Return-Path: <linux-kernel+bounces-269405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A5294327F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE622811C9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8961BBBD1;
	Wed, 31 Jul 2024 14:55:27 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DC31B29A4
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722437727; cv=none; b=Wo/ENjyWpIfBlRsj5ukjJKx2iqexFSySUnvo5JU9L6q97EWn4POwZbLmrSegWTAyIDE1R1jFCxLMh1qQPlpxP+WZxGTPinEy8PlNOhd3/ml7KfyNQyE2GVwruYJ8/fcX4J6PVFzBTMWA1eTVxaXSgVL0OEk8AmHHMrg6QZ6uSgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722437727; c=relaxed/simple;
	bh=ikD7Gt0yoY/EoXt8Vl5M8L7z4xNpnkl29F9Nbh46Glw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KzSJF/lMp/ovztDJGxkSq/3aFNvwPILGeukr3q2Z49QmEKeZTrc/waEwvlROzYI0IZ+kNAetTQM7kMYfkKXQ6REZUYoMRpoUxYEo0ZPWBrqOG4YiAMC+ax87Ss2iNamhNRpj04E5VIaYCcHhKwZrN1Bnef1LmW1JPbp1TnkKO7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39915b8e08dso114541715ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722437725; x=1723042525;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ikD7Gt0yoY/EoXt8Vl5M8L7z4xNpnkl29F9Nbh46Glw=;
        b=g5qdPWD3AUtawS47SuZR1hVEiZ1+Xzqpe0fIwdNHDvcsG+GBmax+3RykUMWHB4Lqes
         +uM3i7Vd4awGQjJBqE81DUdsLnL/yMJTfvSdHUh1Q8oO0I0VNuActzyzV/Cg9vncbHVz
         ypHaSF6wArOSa3W1X2jjqa6vGodFmORULfPHbnZDQ7TStGwzDmpZHxcu4AAcSakBIUKO
         7plzDZb4CXmp5xLdC0uQ8Ew8CNoQTD7bl9AeW16Cy4kYPcgqZ9zpUst1tBx2MXVPr7ye
         UwjtmYl8OC6lXGxVafIiscS4sggJU6p+15UKat4tNfnd8BlBXaBR6cAbdthiidOxYCAV
         2zRg==
X-Gm-Message-State: AOJu0YzTp7d6b4I7l0ljdRR4XAvXRvwzXqkySDn5PAg6c8+BinDDy7Ff
	5SLTqI18WIt9Ai3sC+V/Ee9hmPSRmSRpmHsPgCRYqKNTbeQRUrseTqHJia+3WMOU34nqEuEsnkF
	JU+0A0HlqVN1VJB2wdJdopl4uZXd6QyV7/yj1GPmmZdcifrkRXRoHwO4=
X-Google-Smtp-Source: AGHT+IHniGWS7CxTtLJ1jg+u4OXTpS+PWtoZ4Nqx6Aq6JnoSeI0JSQKT3rkzkR1PB2k9UchvjILBLzjqHqJ5CTSK3ecuJbkeNvO9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1495:b0:4c2:8a0c:3815 with SMTP id
 8926c6da1cb9f-4c63eb2e5a4mr762689173.2.1722437725130; Wed, 31 Jul 2024
 07:55:25 -0700 (PDT)
Date: Wed, 31 Jul 2024 07:55:25 -0700
In-Reply-To: <0000000000002b27c60592b00f38@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c120a5061e8c48b3@google.com>
Subject: Re: [syzbot] WARNING in implement
From: syzbot <syzbot+38e7237add3712479d65@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: WARNING in implement
Author: andreyknvl@gmail.com

#syz fix: HID: core: remove unnecessary WARN_ON() in implement()

