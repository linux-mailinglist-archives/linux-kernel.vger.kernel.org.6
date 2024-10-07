Return-Path: <linux-kernel+bounces-354199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41C099396F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 23:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BBA4282E78
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 21:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BEA18C34C;
	Mon,  7 Oct 2024 21:39:26 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F50528EA
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 21:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728337166; cv=none; b=Hbxy25u+9EEYK95OITI+29DBGCGmzvnFFvWhFimJTGIhK/LviYgbAMBT0mQOJPb1w6wuZ+g0ZQvrsb+dfVF8bt6oZjAuXLjl+Of2a9ZbUsVB2rXZZmelQ5MoEVHYIHlR9vplH/AuCsCkCeRm5FVnOCCk+yLpIy/slTZrYyl0dAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728337166; c=relaxed/simple;
	bh=Isw2oUGYLwPgUQU2ZFndlTgOPQmfS0aCWCz6rnTje7Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RNp8IyY9JlU8hH754N65aadULv0DIODkzFvIem3cP9Q7NXRUG4IaBxDmGPx4rTHxiwjDN928Q+TJmw51OzkHJHVTZl558oPiR9LXqCifzyHQ1kb/ipkT3MXgwKEGnM1eA/diSmpymq7MImYsx7iwpJHtEpwEgF17jjXfzoWGQ8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82cf261659bso781593739f.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 14:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728337164; x=1728941964;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Isw2oUGYLwPgUQU2ZFndlTgOPQmfS0aCWCz6rnTje7Q=;
        b=aHlO5IHeKVAOrwHXVs7V4qKGSpogoGSy8W/wtDg3BVN0FDRzwepsDvfke94uNPh+uB
         qDnMLcJpvXSIAw9IemR2fsdalkKFmWo4iPJLM84wzYmKkVhZBnfNz6642NtBxYKEaoYN
         Kk05g1Vf6wM4bHqNxDSLgPDuj/KDfIklYwFol1623flD0afBEnoUAgOTFdfkRu450baW
         1auPEE0TtfYIrI6/Tlaxg/tXerpPOKcVhDdNKn+BETts1l4Z8nUbN/+aRPDh9JwpmfwV
         GCefur/Re7szY8EeQFCGfHm9h3EqFEme+ltZnDd9ozjxiSlPV0KkOwmcrr51/X1Tlx1n
         X1Eg==
X-Gm-Message-State: AOJu0YwtI3ALUPek/Pf1NoycFhXG5kkp6vwNke+HxTaggreKbvomNnKm
	MXBJSxzsenI9Npn+te8Vvhbm0qEQUUlhsZ8jZWixF9tzWsgb/cdFbkL9gNklRBBxZAtC2/cO309
	H6dM7+ieCYrFdE5sJjWKv/8T+aamLH9GHYYgm3LCJonw7uWiKuJo7i0k=
X-Google-Smtp-Source: AGHT+IGoJPuxnwEGjiWZdFP8mcwF9/exOq0A1iUeHvBxVS200JLdP42ZGNbgIcN9qqT/B5T+eYG2CAi9nIxMfU3PT3XLMnf9qU7R
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3fd5:b0:82d:1cf:5e0c with SMTP id
 ca18e2360f4ac-834f7c76aa6mr1209607639f.4.1728337164184; Mon, 07 Oct 2024
 14:39:24 -0700 (PDT)
Date: Mon, 07 Oct 2024 14:39:24 -0700
In-Reply-To: <66fed783.050a0220.9ec68.0051.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6704550c.050a0220.1e4d62.007e.GAE@google.com>
Subject: Re: [syzbot] possible deadlock in bch2_replicas_entry_validate
From: syzbot <syzbot+4d24267b490e2b68a5fa@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: possible deadlock in bch2_replicas_entry_validate
Author: pz010001011111@proton.me

#syz test: https://github.com/koverstreet/bcachefs.git master

