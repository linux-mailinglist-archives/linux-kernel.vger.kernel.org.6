Return-Path: <linux-kernel+bounces-446905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 355179F2ACA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC4E51888C5A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 07:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199FA1B6CE0;
	Mon, 16 Dec 2024 07:19:13 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5E31487F6
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 07:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734333552; cv=none; b=GoYSggDWOf4dsNpryKHUtHSavpACTFbzhFLfayFAqS1l9STjlUa8vyNYIEEc9VEjXp6EhEKEH/YNRFK1NIPlwZMCnn66iKEnQC6LgbXwL1W3vgAZR0vx0JxqCLrSr9IErHVDTR5R9A8YndWrvpwT53LbmYWYGUlbnoOyP966EgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734333552; c=relaxed/simple;
	bh=qfyH8LTOFNjp+RUtIEHV0KupLnMm+SlXo+VPwDHoO5I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nnIkivA7IX9EW0XW4bkNYnclpbwyaohkqZ6BmY4bICAtxzUsAb/GZdB4XME68RjcDEACyf7av5SA81/iGi+Fkt2et5WAWPcF/ZGk5R2fR74dQeyZD+LxgOK98RRrsPJ9VWxHyMnjBAw6VMXVq/kMmXNNEiKD7ZZObLi5cF7vJnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a7d85ab308so35648565ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 23:19:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734333550; x=1734938350;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PpMJI4OabJ+Wct5olSgWEL5BMeKs4ncR2B170z4kaEM=;
        b=u3PtnKpBgN7/4dBoqJjaOCesXY1LHfta+KhUTWflRJ//Yml3VngOsM+LNRrwrR+jIG
         IuyTT3aRRLBMiW2mpCTQEiWHao9Wt6o5MWbIudEPeC0LWsRSUappnvI4Y8B950pVj/KC
         ToYvugdCAvFo6vga8mniMEjMzmWU5slq90QRPH4ZIR7nUQtfVzRNfOtIiUc09oe5NSVl
         UdyZz1LEhcpvf1Yiw52PlXBvbNDbXYr7VM2jIu7WQqR19Z7oKzANnjLOFD0ysaWJ6HRh
         M6bXVvlGw8XatppQ3IpbHf1mmzlLLuatLnPpBpFyL9Ual/2rXsUiG+lv76lby+AqUGhl
         HTnA==
X-Gm-Message-State: AOJu0Yx1AVfdaSiT4oTABSy/3qtAI3beec6JM4AGmlBLOIjOzqbIWP5e
	F27h1QGiAKBGWscXRdQE/l0DTiZUMlF3lnpZmgFv5+QM8JNuqb4DVqKeXPGGiW49R9mfzRtNZdN
	vJxZjssyH9A1kMCAbq/ftMnjud7igXNjP8kAbJm1X0Hh/bYE4Ka6uQoc=
X-Google-Smtp-Source: AGHT+IGL9AQbeXD1jyy0rBfGNMzJwqV22WldJrmpR8mD9IG5Uwb/ZM5G2AFUsl8KVzzdFdm1dRjMf/R0st9YNieWyLKQYWt5qbnL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152e:b0:3a7:6c5c:9aa4 with SMTP id
 e9e14a558f8ab-3aff039a391mr127913435ab.12.1734333550455; Sun, 15 Dec 2024
 23:19:10 -0800 (PST)
Date: Sun, 15 Dec 2024 23:19:10 -0800
In-Reply-To: <675f4ea7.050a0220.37aaf.0105.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675fd46e.050a0220.37aaf.0117.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [tomoyo?] WARNING in tomoyo_write_control
From: syzbot <syzbot+7536f77535e5210a5c76@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [tomoyo?] WARNING in tomoyo_write_control
Author: lizhi.xu@windriver.com

User input a too large avail length 0xfffffdeful.

#syz test

diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index 5c7b059a332a..d25752eb8790 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -2656,6 +2656,9 @@ ssize_t tomoyo_write_control(struct tomoyo_io_buffer *head,
 		return -EINVAL;
 	if (mutex_lock_interruptible(&head->io_sem))
 		return -EINTR;
+	if (avail_len << PAGE_SHIFT > MAX_PAGE_ORDER)
+		return -EINVAL;
+
 	cp0 = head->write_buf;
 	head->read_user_buf_avail = 0;
 	idx = tomoyo_read_lock();

