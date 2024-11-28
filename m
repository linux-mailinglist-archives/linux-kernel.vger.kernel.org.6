Return-Path: <linux-kernel+bounces-425132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E3A9DBDBB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 23:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E359D28193D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 22:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717401C4A1A;
	Thu, 28 Nov 2024 22:59:46 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B3A1B0F2C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 22:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732834786; cv=none; b=uwk1q9F5BWvEJVBTfTJ8DisOYqUBZaeKz14pauzcOF3ZpXzx9ZOyQS9BE3BAVPeOgNoEEyJ6hG+Q0oclEDXLSNjNpF/aU3o5KPsveHmXLdx+n39qBzA8gfDGyhy4cvoXun9TXj948sJpvhW4+MfS+FbGFhnsY/GQYudRfbIOSzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732834786; c=relaxed/simple;
	bh=1yolC6VIqmkcDOGiD6fDzCcOTiT6FkJc3itHhdVxbP0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LMqfh+Fqmx8tplaPg4+7EUkstGXlp/o4Tn6fhRlhCf6ullAG+YXdPoPzLu4hcoPkcYn51W4azEta9jH7P4+MPrrDoySKUn1ZNojyZecdBrcueX/0dSzy0Ot4ucH+WjGK6gEyFxQFwRqd6c/D3XJS4AJaz+9EM4tOd76sxJzGtIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-843e5314c99so120856439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 14:59:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732834784; x=1733439584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c0UhEKsnejQUFj77mqcd6aSQfDC/L5D7vE3OCFmLJww=;
        b=DH0ggwLeG3//sJwftEyY1Mytjt+d7uAyQBHEV3W1VeZqOCT/ApascTrXIfE9WLv1FA
         YI75cqCeJLz9vysX3b3Z4kgViWFavAD9+dyuU5dQbBJsl9Tg4bPZMT93oN75sxTZOXm0
         g5aaBN9h/UQRYKmGkK5VJPke4Myc4v2BRRwH/TmcEfyYoyPgSg56D2fXncBH3ofBEjgT
         NihFUl+c/f48GLVYrMunwQYXq9DGOpZALZobneOekerPjg1IFLpMnpMAWnT6iAaPhU3l
         ZnoWlqV6jclQYe2jXGgjprkuIHQQPhPtT15dB8P/M9vd8M5FYvio+tr/sU+//uJQnxcA
         CAVA==
X-Gm-Message-State: AOJu0YzqsoR9pDazmsiYAiCicCur7ltq7Hfsii2ySFEK30cFeEXcmArP
	xoxcUsfhN/V5n9DjjbJT/WsjuhKHaocfAf6wT21RT2bSqrvc+OIMQ342JeP+5LfXO2wau1ascWy
	cFgzXWjccMqPGf33/Uc0aC2oS4KoCVD73xq1EPLgYyLHesVlYLOn/FoQ=
X-Google-Smtp-Source: AGHT+IE8HHwrX7VS0x+XpDXlrsZDPDVRJMMOykfUJUuP1tRRdvnetxiBM1ai6wHa6mc7mlW87kWOxn2wGRsfAXdiJDxbaggSa6Sl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a6:b0:3a7:9347:544c with SMTP id
 e9e14a558f8ab-3a7c552580emr98940595ab.5.1732834783958; Thu, 28 Nov 2024
 14:59:43 -0800 (PST)
Date: Thu, 28 Nov 2024 14:59:43 -0800
In-Reply-To: <000000000000e4d9eb061d719657@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6748f5df.050a0220.253251.0095.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+dd3d9835055dacb66f35@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: cryptographic MACs on superblock are not (yet?) supported

