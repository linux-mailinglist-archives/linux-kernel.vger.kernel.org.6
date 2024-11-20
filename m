Return-Path: <linux-kernel+bounces-415209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD609D32EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 05:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB022841DC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 04:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF1E14831D;
	Wed, 20 Nov 2024 04:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKFt4UD9"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9751876
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 04:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732077610; cv=none; b=lyYu4yzL1lg/fPdqpQRyspxDalmetq8Z48iH96omz0YZkSVLJ+iSvZa05x+CeRk6ozMDdWVFo9IXu9vnGeBUslxVkcqyzHsYXT2MK7F6wSc4SY44Eizr2muE0KqN6Mr0twRl3JbbwGydDM79TIcUeKlxUXX3/Cs+eqS5IXR4GIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732077610; c=relaxed/simple;
	bh=PLdJLKJC82JfVrnPyd+9YeJl4Ye3hTqMS0HK0+TXyj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCm/XaU2DliMdKTdIXcxv3MjEHlsBOw6r72oUHdWXA7HByxCPmW64zCllNxHycWAO+RZHGrdJytshIrPu9Dwc/yKRrj+xBzlygXSeeJGHOElCQthn3eRVLh2JSUhDdM3FbCPEuHGBaeCD29WxbXQsHIZC1q8p8DhsxUCa0+mjkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKFt4UD9; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cf6f804233so6992402a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 20:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732077607; x=1732682407; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lDSsn1BYXXDAXiWD1sg2l3m5HoKoH0Comr7O4JuesqE=;
        b=WKFt4UD93ApKdYEF2L183h7982/BqHNQKISKM+j3NjeoyJFJMab1UlbxKo/8Js81CS
         w4M166ba00jQjFUcNBinqu6ffD7gv6dtWJ4HhYTnJ9yYPJVOFtCz0knbSAaCPo5Lj8rL
         uYZIBpmBoAz/fQDAEVlpPt9g7frj6Q9aPhiG0mE5urcb8XuZlEGHhs+EQCTUeGXk1tyr
         ViGwWgGg76ZSVFPAzdkfgZzgEBhG23hcdo80XhVAQ4cFCefp+MAU3xYf3NtI4Cfph3oI
         v57z9QZ1jRKQECy9zPvl4f8XTPowAcAY/W6j71Y6nJ+EO/qizso2EEc/MDY5NLM0yiaP
         lCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732077607; x=1732682407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lDSsn1BYXXDAXiWD1sg2l3m5HoKoH0Comr7O4JuesqE=;
        b=m1rLwoDttmzlxtoO4KbcBIau/YCy4UEYgKfF0P4OAny6fETYC4vcxRr0c6C4bflETc
         xUZv2sGPTOI49xkGZGQ+VMEsJdaxEEQYCi6UQDITLtnfy2JwnjXbr1cAvUxwbceVVdsc
         jz/ry7mM/JBSLes0APCpuMbgbJEiO/M1Vyh3K7RpnIAbqQpR1QRFYkCm+ILpAZ+5MIdi
         9sjRN0D0kxvJ7T+94HXTB2WRVa/AQNHLxKryBv+4inWoJWJPntRWXGgSE/WWfe1NFm35
         WIzm3o+0sygnUfiQ0dZjWNhNpF4gb8KDnBFPa6OBRvaeWfaYAJuOK6Jz9lCAsMF8/9UT
         rJeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs2css1kdWcniBbRBUHZt3qmC03STj4hAk1s9wjNn3vEzDXNc9V4UgBfJGv8zx4PBJB2VnsmZ0ZNMDZKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YybSKWFW5n0MSP3pmyDUOgAxnIaVMC41ZBYlvC3eCCkCc1O8HF0
	m8vGHNKEWHmNl7HNHPNtm+N2TuGkmTS3qgYs0rrV4oDkRsyXfcTIvuAE0xIBKuw/XOAnyI4YuSc
	thnVSHP7PQ/TBsBLYu4Dnpy/jhFY=
X-Google-Smtp-Source: AGHT+IFXuWwjWwmmYva29ncqigG5pI2rfYzjNf4t5M/eO1r2z13mHBdnDmOcqzsyTIGt5O1MqaFjGsoFY4kMBmOc+cE=
X-Received: by 2002:a05:6402:42c7:b0:5cf:3d13:ddb9 with SMTP id
 4fb4d7f45d1cf-5cff4c7b8d4mr757350a12.15.1732077606957; Tue, 19 Nov 2024
 20:40:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_E213136E4B8D60D984B3095D9C2E2F0FD107@qq.com> <20241119191344.53712-1-sj@kernel.org>
In-Reply-To: <20241119191344.53712-1-sj@kernel.org>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Wed, 20 Nov 2024 10:09:55 +0530
Message-ID: <CAOuPNLi0f-Bo5mzuKn2CPXNy70jtbsOuonV9cdmKZB8jKu9jOA@mail.gmail.com>
Subject: Re: [PATCH] mm: Remove 'return;' at the end of void cma_activate_area()
To: SeongJae Park <sj@kernel.org>
Cc: winterver <295107659@qq.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Pintu Kumar <quic_pintu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Nov 2024 at 00:43, SeongJae Park <sj@kernel.org> wrote:
>
> Hello,
>
> On Tue, 19 Nov 2024 19:59:40 +0800 winterver <295107659@qq.com> wrote:
>
> > From: Jiale Yang <295107659@qq.com>
> >
> > Remove 'return;' at the end of void cma_activate_area(). It's a void
> > function, so an ending return statement is unnecessary.
> >
> > Signed-off-by: Jiale Yang <295107659@qq.com>
> > ---
> >  mm/cma.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/mm/cma.c b/mm/cma.c
> > index 2d9fae939..070399bce 100644
> > --- a/mm/cma.c
> > +++ b/mm/cma.c
> > @@ -135,7 +135,6 @@ static void __init cma_activate_area(struct cma *cma)
> >       totalcma_pages -= cma->count;
> >       cma->count = 0;
> >       pr_err("CMA area %s could not be activated\n", cma->name);
> > -     return;
> >  }
>
> Looks good to me.  But, seems a same change[1] from Pintu Kumar has already
> merged into mm-unstable?
>
> [1] https://lore.kernel.org/20240927181637.19941-1-quic_pintu@quicinc.com
>
Yes, this [1] is already part of linux-next now.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20241118&id=1fa00a568d113db279f683f40636cf72cf73a55d

