Return-Path: <linux-kernel+bounces-226447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 454B6913E74
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 23:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6E4D1F21572
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 21:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DB11849E6;
	Sun, 23 Jun 2024 21:19:46 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1425D530
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719177586; cv=none; b=CGwGiu50DSiIgAi2uO/GYjUqJfQryKsjW56w2/HLVB7QEqwjy5GCQ9SGrU6Pp6i/D6t5DjDX6zbRegeGpo1jIMtt23e4ao3kohW/jHcLk126n6gi9JRDiU/HQa5fHKxLZcH4wOXu/gf3UYHn5yHlr9w5KOYjhe0HXaGrLzu1+1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719177586; c=relaxed/simple;
	bh=1zAPJJyZahgUCItkyk66+Z0clkNk8Y/ym3jv742vkNM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ooeX6bMnw6kE6Sq7AAR2ox2xDGJBttYdvlvmWZXG5Elaw4VNI99cMrMi4VckldUgpbU4Z09Dy3D2mn0RBg/mJ1a/0CnMzgB6qw6JO3rbPQqCho+Xh2A6XqVg/hwaDAovcKiY9Iev88lD/Z+RGQfjLZIDa/IUf/tJtSFtn+8zUD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-375c390cedeso49335525ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 14:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719177584; x=1719782384;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c1PKUn/Fl8/W8a1IK0W7BCEJGFKzEZoGpXjSDjwNK9s=;
        b=FOUt96dGfTD9cuQpHTETiz8rIV6Wl/ElEr4GbwZjWOh+GvTQsOiRWA1mOQ3LLj/qvh
         EhXOUsksSeVfI51IMUpyghnO6cAeP7/2Zf/SJqhKPoqP22JJSMZk5TLARSfPYEa44gCM
         iafB/fKEto2yOzMC/EDTN3SemySbFr+dUJZX5IPr0qX6kcjoGQDtT5k+oaux5DQ5jevh
         wUct4wor3sKAdX2smFQUYbYpDIz1XnA49ET2qmAwbNAozkovAqus5aMwBA5f62PxqJP1
         Y13YRjtcdnAj4s6J8fJik+XI+kWXf/6g4iAUwczuUhrXAz8opa24+BmU9wi1kWSS/fWc
         4Y6g==
X-Gm-Message-State: AOJu0Yx6UzV9IcnfK/UyAN6MqeMvbXHlONuKIeurpJAVqFJ62BoFGegx
	ANhM/s4A2+moQe0BZtHUxHenQfBvYkYTkMKROZ7ZAPUIe2a1UrkBUgKMI/wt0QJ3FPoMZ0ITGF+
	q5/Iaw0ec/qnKIgIA+5pULhP2s0m72tpnBivtmesKCRu5aY+JZwfTROY=
X-Google-Smtp-Source: AGHT+IE7EbzFdpxfB+ruF24ALFMBnpfQ33j5y0BwJxMsPVFpJGpruOo+EDcYstHkWwSXTpgcuhlSdB5VtklR9q/kxUP132cK207V
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0e:b0:376:4544:827b with SMTP id
 e9e14a558f8ab-37645448473mr2130995ab.3.1719177583854; Sun, 23 Jun 2024
 14:19:43 -0700 (PDT)
Date: Sun, 23 Jun 2024 14:19:43 -0700
In-Reply-To: <000000000000747dd6061a974686@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000311c7c061b95397b@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in nci_rx_work
From: syzbot <syzbot+3da70a0abd7f5765b6ea@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in nci_rx_work
Author: jain.abhinav177@gmail.com

#syz test

--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1510,6 +1510,8 @@ static void nci_rx_work(struct work_struct *work)
   struct sk_buff *skb;

   for (; (skb = skb_dequeue(&ndev->rx_q)); kcov_remote_stop()) {
+ if (!skb)
+ return;
   kcov_remote_start_common(skb_get_kcov_handle(skb));

   /* Send copy to sniffer */
--


