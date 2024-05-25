Return-Path: <linux-kernel+bounces-189542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A84128CF16E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 23:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8B3A1C20956
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 21:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC0F127E2A;
	Sat, 25 May 2024 21:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Pz9CHT6S"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E39126F1B
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 21:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716672650; cv=none; b=Oa6Vb9A3hgAJINnHO8kGBU4aUNWGamWT8ZZMUqmlB0iHtq/7FGqRxEYPWfF/XQ9imlHKbPA28xR1ZS2ESvY+g1pucB/v2sdjPpiy0NHlU8iQufkc+fnHWEfnYzvlpAaa1lcPRivwYReZ1sFV6nkSwz69Kt/dOYFXIxakFQ7FHGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716672650; c=relaxed/simple;
	bh=oGp4b2YKvrIObOfrt0wyE/RGTuaTttOQbmZzFfZ0A7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UxYXh6Iw1x/NKCcg16mOTsfJB3JnpuM06nSCepTfiL2Gky0JgrukXOvukSjFK1sapgFJ6Q0B/df9yyuI3ksS3xr/uEqqxSwO0fr8iQROpC3ku23+rVSz9gdZXGn8f6XsdW81nI36FUNjnjoZ1zLEsxcy8FH8fltROeBrPqvfj9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Pz9CHT6S; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e95a1d5ee2so39552291fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 14:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716672646; x=1717277446; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OLtOdLNidBwuWqfxjuWjK5k/t5nK1x+CSG11FeqLEJ4=;
        b=Pz9CHT6SQkP7aAeX6ea47rq+D3KIfhVnaSfLgBH3B2UjOg1THyqQ57iihcr+9pGdtX
         43MvRBmoxlVJ+QoTB7Di6TcmBrqPj2GW7gSFVG4LjoRMlu27unTdrm/rRLdbvniQla6B
         upGr4ke/+lZjlMPbAlyt05Gup+uGZ9HcBuJJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716672646; x=1717277446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OLtOdLNidBwuWqfxjuWjK5k/t5nK1x+CSG11FeqLEJ4=;
        b=XLq/XwDXDmrh/+PzWLiBbxp5ZUfegfKXijxC+rZ5O7iFSF1AqcGGH41rSh503P2kH4
         KuTR2UTljBCTogtRnnUym6OYdCXNI1zZyx/dLTnurkUEFcPBa45TYx8PTECj22HV/p7C
         O57AxR0kNF/oqUs9dovDGFtR7maUvDYtJxzm6tgPWQ8kHjqCIpUtq0WjVnSrMDpL4wGt
         ILJKsNfYLOCllInS6Ab7aMm3yNvv0e75fx3BkXHtaoyHa+ul+x991qWYvBh2/F8/9X4P
         Hd9OeEnYNSETbSw+hFsPSm7cYQRIpfHICPnslxqJSQB2DTj+OSPjaKHLDXY38xqS8hNO
         jdqA==
X-Gm-Message-State: AOJu0YxCicyXyINOubGm5nt2DyF+BYDnHd7/lqWz1gHx08t67lJe8BuP
	GUgi19kxUZ1pzD+2zSO136pA3JLOsBLn/SSv0Z2BpaUXuiGyecxsoYSRVXs7zV0owQPhs0j9ALd
	/c7lfew==
X-Google-Smtp-Source: AGHT+IFk79/BeEKETkxsray7ydgMsf4d0yjCFgekPSpAE+JB4beFTSyS1ZUz7cSjTnJsCoLuQ59XQw==
X-Received: by 2002:a2e:b2c7:0:b0:2e8:5d2:5e9b with SMTP id 38308e7fff4ca-2e95b096b9cmr47516651fa.13.1716672646431;
        Sat, 25 May 2024 14:30:46 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcc45bcsm9331131fa.27.2024.05.25.14.30.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 May 2024 14:30:45 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e95a74d51fso32727661fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 14:30:45 -0700 (PDT)
X-Received: by 2002:a2e:8502:0:b0:2df:b2d5:5935 with SMTP id
 38308e7fff4ca-2e95b0c23f4mr41303781fa.28.1716672645341; Sat, 25 May 2024
 14:30:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZkJhmhatRHeKuIfE@mail.minyard.net> <ZlH4JYGpbVd1CW8P@mail.minyard.net>
In-Reply-To: <ZlH4JYGpbVd1CW8P@mail.minyard.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 25 May 2024 14:30:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1HfrYa5w20CZiSgcAkp6nARpovQtUjyOoBo9xAzDW3w@mail.gmail.com>
Message-ID: <CAHk-=wj1HfrYa5w20CZiSgcAkp6nARpovQtUjyOoBo9xAzDW3w@mail.gmail.com>
Subject: Re: [GIT PULL] IPMI bug fixes for 6.10
To: minyard@acm.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>, openipmi-developer@lists.sourceforge.net, 
	Jani Rantanen <jrantanen@mvista.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 May 2024 at 07:39, Corey Minyard <minyard@acm.org> wrote:
>
> These haven't hit the kernel yet, were the missed?

Hmm. That email does not exist in my mailbox at all.

When I search for it on lore, I see it there, so it must have been
marked as spam and I missed it when doing my daily quick scan for it.

Or I fat-fingered things some other way.

Thanks for re-sending, that was definitely the right thing, and it's
next in my pull-queue now.

             Linus

