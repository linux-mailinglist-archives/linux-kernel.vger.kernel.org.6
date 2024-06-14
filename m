Return-Path: <linux-kernel+bounces-214424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B6C908437
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD9EA1F22BFB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A5314882B;
	Fri, 14 Jun 2024 07:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="M+xXHm7W"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5871487DA
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718349086; cv=none; b=LKCWybAcXjulcUZwXQnRJ8o3hQT5EeNA7lDB/7P0/nL1n4O5mIGwyn7zWvMmv+D3ZhVpb1TtPrZHKbH9BRCCspC/vwTI7aANGNrIWjLs32GS/iDzo8l2OlmCvefj2mf0VVZwRsuuMnXU5cc4IoIHSE2GoTm3Uq9+J17xOze6acM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718349086; c=relaxed/simple;
	bh=l8eGqwVlSZc035rRa1tMyKGo0mOKJB0fBLhyTI6e4BE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aiT5BYkJdRqgY6Mgv6zyA9AinkMTmI6KyA2y9mFSIbXF0Gd0eAXWf0BLztL0eMq6WoZsygqvhI6nkb1Khvqy+hWaTfoUMn+f6KiZQXRwTTydbeErwPqvsPYwQWaxrsR9aGlcxXMu/ET9e6S6CipW6inGJxto9JRs3VT7K7k6b2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=M+xXHm7W; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6ef46d25efso238023066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 00:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1718349083; x=1718953883; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l8eGqwVlSZc035rRa1tMyKGo0mOKJB0fBLhyTI6e4BE=;
        b=M+xXHm7WJTr3jhQkJNbr72YvYlZvsSAmBb/UiPwFg7lZF5aR4GzJxxixHqNjN3e1rg
         PCfhPxWrPUlRIgIvKVefZrbI/C5oW20SfBqwPRI9poPNBqJaq7XsmlG0W9BKv3yUTbUX
         tyC2G7imBEQdmYPBwJceWwGRHgtHnaZvwcDg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718349083; x=1718953883;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l8eGqwVlSZc035rRa1tMyKGo0mOKJB0fBLhyTI6e4BE=;
        b=LnIHllgS2ZxcqKaUNGb3acG+ZPaBwQF/5UZtej9rtMo13pEBvtR6oEWAfdBnbq4ext
         AIspwVISoyF1LGBQux3WX0HZa/fiwxex738SzF95VDl+y66Gg9i1SvB3bSnu2WFAnVeU
         uH/vcDf/rM5iFig64ml0CrwEDlbxMcz8k6X1Bdgg7QQtq6NEz9hD/uWkZSV21K2kYlJQ
         ev0drnu+9E+2Fa7hzL97klEZSrrbxPj8PlkV0NZo+QCRI8c6bEez+c5NweMK9epu0aTq
         7mA+uDTShony6Fo+2441hROk9/9KbWsM2atbLgy1ZZXwuykK5Bqaaal1SKaDSbaS44aY
         79kQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXw8d8+pL/c6lvft6xDxTn++rYpSxs+0VQ7hlLRmn4JIep0VmaCcxYTFqMvQ8yGxyzhoO0l2FIJlujs1RltgjSLx7gGavn5lXUZhh5
X-Gm-Message-State: AOJu0YxuLx0yNH1b63Ym1YvZhTRxozylIq2FPVHDxGRTtoYHPKWSFCjm
	pJXmOepbfDTsf/B2L6oHepEGgBFKXhw4uxLNsXp9AK7xsdB8nI8ZNIhZSq+APhSwFFE1hk/GFqU
	UDWLe+T9FjGEK9m0ad7l9a/RC23MvaZWyfULD8p2d2ePxF82yFnk=
X-Google-Smtp-Source: AGHT+IFDNKdwAfXSEycKXGnTTBABM6FmRmjjX+FTRFKdGLxumAJ8MD9QB4DFtL1S00LVOzY3IYZuvZA5viN2JMztKFM=
X-Received: by 2002:a17:906:365b:b0:a6f:1231:a8be with SMTP id
 a640c23a62f3a-a6f60dc17a0mr105055766b.53.1718349082972; Fri, 14 Jun 2024
 00:11:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000871190061acd8fed@google.com>
In-Reply-To: <000000000000871190061acd8fed@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 14 Jun 2024 09:11:11 +0200
Message-ID: <CAJfpegvhMX_CoZ80Rkva_GCrWAXY=McAphHh3DyHgiukRV3BBg@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] possible deadlock in ovl_copy_up_one
To: syzbot <syzbot+b778ac10fe2a0cd72517@syzkaller.appspotmail.com>
Cc: amir73il@gmail.com, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

#syz dup: possible deadlock in ovl_copy_up_flags

