Return-Path: <linux-kernel+bounces-228112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E44915B0F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 02:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0789D1F227CA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F5BCA64;
	Tue, 25 Jun 2024 00:39:40 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBB9746E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 00:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719275980; cv=none; b=ML/6PyGimTZB2J0iUoPwmFiET2tUiNWCpDYj4fu5xK8xw3WmANE+xbUO91yZ+uYROHlFELl2XyJpJd7ZUizSUKeYimdHUY77Di3oNDfwt4ll5+uqeHgRjgAlk+9a5NJS3uG07KLy8Aqd458844ujrG5aR26fxLTkgWEt/QGOSjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719275980; c=relaxed/simple;
	bh=Vn8kTjaiavDdyc8/wlZpxrXePEbx3gjEURKJpd8Gq8k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=KH4YPXWaXzu0plTpptEBjiBZxhIqJy8subNYQFewnqEphpUmeF1orpiby27xhmInW8WKPf9Q83oOUhnvYR/N7TT96w+k0JBEhjVISEFtykqZNvWY9/1Fovh9N6zVXcEdp6emvJ0Hf/Y/qJrzB/XbaiLw6eBEFsu/yK5lT3BBcPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f3b0bc9cf6so285656839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:39:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719275978; x=1719880778;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vn8kTjaiavDdyc8/wlZpxrXePEbx3gjEURKJpd8Gq8k=;
        b=KzvZd0SdKzZ2FzKH86r0Td9OgJHGLz8h0kkFqQdW1OVDJUVRoVn8uYTJN0OMaQGVd/
         oC4xXZqGnIfUJWLVSflHguCh01WNIcH+ZcJGS5Wh0o9ANz7l5A6zlVU11M6pnRr2ZguI
         ZZNZAR8GZyS8Bhr2q1KWUlboK4kizJyT/scpGboBlLN3NTaFWtL6dGlmQhtc5HM9Clik
         CpQ2+3jOPO8sQp6M9fREnTTGhjPiLzUc6YCgM7XTvT9sRk/WVnzrxnbaf9UmZOFuPgbj
         WoD0gOEUAYavn5ZTyusgpt3vji26eXVWXzcGhhZdNCu/Bcd9cm/LWth9Ww9Yi9Y85Ylg
         TLjA==
X-Forwarded-Encrypted: i=1; AJvYcCXFZQEHeBlpzRc0X8WQYqLUruW1nUzYfSBapj2F9Jqy+lzilFDeAVVLBGHahlk067qP706XJajIO65/cs3MuuauNZLfmytQK/FlwcW1
X-Gm-Message-State: AOJu0Yzsff/QxKLBnLUArQcmhXO50jypig/iJRuxIz4+MahzzT3ygNv8
	5t4ask8hJRU5MkPIORvhYDRlUa94m7clrs2uL+Upyx4RIoO9alpAOFi7XRfkD+5a0G19ocmIDSt
	Vo39CpE2xgPNmvp47wZXUy8d/6pQvA2QNJvRRDzb4IWkzn2WEqtkgM7g=
X-Google-Smtp-Source: AGHT+IHcGMjzHL2GyZkW6mCzWpb+X9SQH4MtHgNGsY6941zLDvGVuF2wbiAwAKoMrD24+Bx65a9Z52IMxELZ+sv2quVIo91z4Rrp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:871c:b0:4b7:ba5b:96af with SMTP id
 8926c6da1cb9f-4b9efb317a1mr213182173.1.1719275978124; Mon, 24 Jun 2024
 17:39:38 -0700 (PDT)
Date: Mon, 24 Jun 2024 17:39:38 -0700
In-Reply-To: <CAMc0M--t+gM4GVQdpHtbYN1HnVo53Z8-xLd4V65_yofzcKnEqQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f280ea061bac21e3@google.com>
Subject: Re: WARNING in __ext4_ioctl
From: syzbot <syzbot+2cab87506a0e7885f4b9@syzkaller.appspotmail.com>
To: peili.dev@gmail.com
Cc: peili.dev@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test

This crash does not have a reproducer. I cannot test it.


