Return-Path: <linux-kernel+bounces-326329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D61CF9766A2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC6F1F244F0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8B819F131;
	Thu, 12 Sep 2024 10:23:26 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D31E19E963
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 10:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726136606; cv=none; b=JqCZrHW8VHTJ5IzFB/o96UPEIgwmyQqM+Kp3HJ7yYyt8631lgdB8AovLWbxA7iAK2VGKS/oUhGHX0yTb1TFfnaOSV6Y2QQf/wNgi73R3Vk/b48O/ekJAyZs9MUza3btv5LNEWzxxZbptYUsPThXuwyChy+2n5uJYlzeLfn22dZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726136606; c=relaxed/simple;
	bh=Ga3pf3XzC614K6AYLW9e1/j77SFrVH7FfpePjfTxj8I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=q/cqKrSMSHaKnHJvQyuR+8vyAqlw0n6z0bEZtTp/fXIElK9sGSXl6r2gDRiaxt3oAtZxR+pmcEJnkwWDFOMFeNs/47Q2r25J3MF09UPQKrCko0wB/2h1dPNlKuoWQuENx3o6VibPoM9gUlOhrmggf7NSxJ+pjm9AAPcMSRFEhk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39f53125f4eso10893415ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 03:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726136604; x=1726741404;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ga3pf3XzC614K6AYLW9e1/j77SFrVH7FfpePjfTxj8I=;
        b=tMvYotn9Do8lY4RiiOkd2PaOuk4x3r28HxF0ew/c1y1kuYLh/wgy4L3cI699jbBxgx
         bUdF5vQ0Cc643fzWjW1N0I35QzL0+V5abfJu8/avVBNh1FBSV7yxVJhFXqt9qapOK3RN
         Ajo+f0aaadzGa5jVPWY/E265MVnd4KX6OyaF5H+ZDIyNWH5srjbQzThizuZCl2uIw9sd
         AD1VgR8Ik1ohyNZdOFqarZ8Gt6PxDZLiwlLB5YmRRd4h+65dkEJjThPv6bzUZRNDzEeL
         QYFYCZycCSOIiJYNuO9CnW8/Fqx68Wa2Tb/agpqN3UkL9pcxD5RaZGhkGX8zSgdjzmCu
         2Xkg==
X-Forwarded-Encrypted: i=1; AJvYcCXkZ8rst0vTtr6A0EtfMNPtaspmwcEC5Dt4r3tBfobNrAnrM/tOipbkJlqGcw1eNfMBTaAxsWdv/aP1wq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOlwGKl2gX4Rl45UrJq/Vm+qosAP8T2ViehDnXcj/Rdi8O7Cm1
	NaDGNDISsPqmoKfpBuSLiwi3zGUMygtyOeRWLal2MEzHI/jm3ZSBUE2ivIKlzJq5tZp5BTXv/g8
	NfKOkRQyf3ADZflx+0uFcLh4aLmNwhMTcDs0A54pGJYzYPlq11vigyCQ=
X-Google-Smtp-Source: AGHT+IHB3lPdkY66x4wBQHUqac7/lulY7UbRd1JBp3TRRp3k8GFo6IQOp4iZHYdf4wkVp+5wAXAW2dNMKGOGSCvO/8pcGm67ed61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216a:b0:39f:7318:c1c6 with SMTP id
 e9e14a558f8ab-3a0848fc717mr21352375ab.15.1726136604242; Thu, 12 Sep 2024
 03:23:24 -0700 (PDT)
Date: Thu, 12 Sep 2024 03:23:24 -0700
In-Reply-To: <CACb6ct19G+OKzjHTaMM3N-uO_5DC_UZWiHPv5V90XoWLoRzeHQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000214aa60621e97fc6@google.com>
Subject: Re: KMSAN: uninit-value in mii_nway_restart
From: syzbot <syzbot+1f53a30781af65d2c955@syzkaller.appspotmail.com>
To: ksjoe30@gmail.com
Cc: ksjoe30@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz redo

unknown command "redo"


