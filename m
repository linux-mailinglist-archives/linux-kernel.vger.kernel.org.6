Return-Path: <linux-kernel+bounces-330099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBF09799B4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 02:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0232831A3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 00:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03242F52;
	Mon, 16 Sep 2024 00:46:48 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EA636B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 00:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726447608; cv=none; b=kVVQ7DDd4IDUypnNudy4yMe02RwZ+ocHRHqPTDrEbAPsNhOKkY/i2qK75OMdpfGzwbvdX9GAFXe62h8UtsuSRF/8D/B/lQi/DgRzehQ2a/Dcd94sRtTEUXv12QEPbInUBRR+/fSdre6Sdgb09e9wbc2CpcUrMv73BDfdxoWcHKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726447608; c=relaxed/simple;
	bh=Kj8AFoyZqUe74w0nZtLRjcnDA34VkrhiKAF/VJcvQjQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=knn4+z0ZHT+bgcUdG8rBXHhySkQvlGvKeqgCFp/16RkkEhI/G1B6LsBr5TtDN7n5TbFNUN3HCAgftyZI3R14mA1wPUCDtv8+RJ3XcbeWxfESO0/vJTq2yA+z6iQch6plV8DWmwwnYzUIxSXj+xezvT2iPL+/1oHYSJs1yc1KYqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a0a54fb476so4133015ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 17:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726447606; x=1727052406;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jwyjdXOUVlYdlwbeTWqF+oHpRNDQxsR1BZgZziSd9K8=;
        b=N4DsuHBeqJK/I45nUTZMMahZuvE+CEmnDLw3kiVIJPVMPw7wbTYQHgteE4poVFPwHg
         AqUnmh+CjCWLe3TosGI3TGtp8nhznfi9MkrMJ7LYH2K/G4IKBVl5bnem1ucxE0QTs906
         cEKMweAjhFoNyMM91QcE+p+t9nZ1jOZPCKXivpKZ4DSvXHYIuvVM8BP6TS1iaF+bS7FA
         2Ypx1mPR5HCwPP1aRTtNihMDLNLBvZzpmTID6RWRW4CchzsmSO9doPWi24UjBcGHqGgo
         maDfoKeGQNnYYrXfZnH/H7Xstlkfuw5PDzutgd/g7VlxehMbymadbcS2xK6IcIQ0sHTA
         MZaA==
X-Gm-Message-State: AOJu0YwKZyMZCoJWGFDfoiC1zWD1MnhTviigSnzV7+6vf5c6oTG5eusN
	C5zY+6vIcunhcPDOOkiEAkT5AsCneN6C8q3Dg73UW5+smxanGGrZskTHvK++rLeBri4KZDu7ea2
	q+PfkbgdoBD22Cx96DLwy3479AJWDpdBJQ3nwKZKbnhwo8L8jvKt5ys0=
X-Google-Smtp-Source: AGHT+IHL7vPBsa4v0938A8JtvaAYwCys6S+3YA27RjmSCbJ0sppqAVf5XOQ4cS7OAzrRxC9cCXWfWJYcx6kYz2nN3JYE8lVB8MI9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144e:b0:39b:3894:9298 with SMTP id
 e9e14a558f8ab-3a0847cd5e8mr135920535ab.0.1726447606304; Sun, 15 Sep 2024
 17:46:46 -0700 (PDT)
Date: Sun, 15 Sep 2024 17:46:46 -0700
In-Reply-To: <00000000000002df770621bf81d9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c2375062231e807@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel NULL pointer dereference in fbcon_putcs
From: syzbot <syzbot+3d613ae53c031502687a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: BUG: unable to handle kernel NULL pointer dereference in fbcon_putcs
Author: qianqiang.liu@163.com

#syz test

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 3f7333dca508..96c1262cc981 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1284,7 +1284,7 @@ static void fbcon_putcs(struct vc_data *vc, const u16 *s, unsigned int count,
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	struct fbcon_ops *ops = info->fbcon_par;
 
-	if (!fbcon_is_inactive(vc, info))
+	if (!fbcon_is_inactive(vc, info) && ops->putcs)
 		ops->putcs(vc, info, s, count, real_y(p, ypos), xpos,
 			   get_color(vc, info, scr_readw(s), 1),
 			   get_color(vc, info, scr_readw(s), 0));

-- 
Best,
Qianqiang Liu


