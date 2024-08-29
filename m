Return-Path: <linux-kernel+bounces-307833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8DE96538B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 01:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0D39B22883
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BE018FC81;
	Thu, 29 Aug 2024 23:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nSECuSnk"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D7A187843
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 23:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724974757; cv=none; b=rcfBW2Lh1anjttaCmWobsJyahS5MCd3nG10GE+WaIgGkcJZ3T6102UPKRdCyZj3Db+YpAQtK3BWueo6jE+Oh2AmGn1cWTN29IOOEo2PwnNhUQFN695f7gZNVVnoDzxEsRNOLnw+XcIcyC9jMQwLoZcYxlLVPpJAVezvfsfF18zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724974757; c=relaxed/simple;
	bh=xPKmii8VGDYcV+TyAEqaS8QPtU+HBD45jztCQktpPHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qa6MCcy6P3uqSuYB+VwrpoIQS8ghn76IAdDZ4qCE+3NYVpAhe9zvLiUmNBRYnKOwzpCYlcw+ImbT6eWL1Z7mfWzBLkUeRvAA6FAnvYCBWeMtewD5k4sYiXiHTX32LxxFV/Vr3Mi4H2adMxWAq85xnh8Rr2V1jTF16Wxtl8yXvlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nSECuSnk; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8682bb5e79so159934366b.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724974754; x=1725579554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPKmii8VGDYcV+TyAEqaS8QPtU+HBD45jztCQktpPHI=;
        b=nSECuSnkzQHyTnzxgXadX9cqvqVM381RJ9jH0v1YDUxyRoJrufsrXMD0P9lmZo3XVS
         2ulvY9rh45H6M1ILR9M+61WDamKIJhbRsF9ZR9+HfYSZIzxgsu6mTFwpvlEcgEprqySQ
         Mbsoxg1618pfcIwjWv811uhJd/2vbPMJN1bsWMHUmxAb638MnzgXPXpNSv0j/i9hrjKI
         3aNEBN0ie+zfL3Osv55LN/FRRZCh2003ZL9MeJpRuR/h5tiTQfrya5Bkx4ceKuq8gmnw
         Ym+o7kmPc91mvxFjl5UN2AlF9dbRHWd4g8c2F/IbIWy1tUBhkfNinqvUsgqNsq2eQkdU
         M0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724974754; x=1725579554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPKmii8VGDYcV+TyAEqaS8QPtU+HBD45jztCQktpPHI=;
        b=GQ0Rtn4LEDw7gU8WYKFR4mqQe9x+4GM/0YIqjw9c3TkO+1hEQXs+ucuUx1GSe5sj/3
         ugY29KORV8bkBwmVLFSwxpxS11lNqQr1dfqOZnQG7Yv2dsCJY8sQQ3LjbR/HzBL8tDXQ
         jGBX16T7FyoCN60WNpwmnIkjAjO0AX1Gwjy1Wjyyn6ihO236EKgSPE+3hvgt43drbEE2
         O5WpEpbu4kdy42i+AerDAO1pPPS0vZpyg7bspNYTm1YCAvYWai94Y3V7OD6Lja7LDeRu
         zjbUEdwN3J5gkUgOmovH/YWvLW4wtBRd11aDFTXP8ntQjz1S6z6qUm+s8Vt4we9SvEjU
         B0SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZj0h2kStIoxYgKduNWiRJ8sCx01scbXy/vNDNx3aCz03dpgEeXbWskVV6m9HUbyiK6gwjCd9RDLzI8Mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJboN/Rt/mEgpKgIF9WobBmOYpTkvCvj958zvqev9Epv6fE04U
	/SgueJ5wtveux/13/SxdSG6BF2kepqriQAOzkQoP4/WaaxRtBzSDdSgj2+yW5s1S0KJ7XpFF+Ry
	rr4RU3igwrRo3HsRM9l2Dd/3LD7hiltH+YQQw
X-Google-Smtp-Source: AGHT+IGzZfUfLb/wr+phXMbsB0+tDWS6drQ4HUFsKOGrUqGacGSCGe1p4nfsL+WVQ9XrDA2jPRt1p5sNpvv/DAfFdKI=
X-Received: by 2002:a17:907:980a:b0:a7a:b070:92cc with SMTP id
 a640c23a62f3a-a897fa638famr365229366b.45.1724974753491; Thu, 29 Aug 2024
 16:39:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828093516.30228-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkZv3YnhxFo-rvHNB2_mro1+UuKOP69yXV8KmaeEz5F1mA@mail.gmail.com> <CAKEwX=O8CfyBHZD6Xm_0DW5EuTY7g7FhKHiKj4xzZ4ozxdgQFA@mail.gmail.com>
In-Reply-To: <CAKEwX=O8CfyBHZD6Xm_0DW5EuTY7g7FhKHiKj4xzZ4ozxdgQFA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 29 Aug 2024 16:38:37 -0700
Message-ID: <CAJD7tkZnT2_JD90xAt09Uk6Lsc6C8t0V5dpUOKLLknw75yUqkA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] mm: ZSWAP swap-out of mTHP folios
To: Nhat Pham <nphamcs@gmail.com>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, hannes@cmpxchg.org, ryan.roberts@arm.com, 
	ying.huang@intel.com, 21cnbao@gmail.com, akpm@linux-foundation.org, 
	nanhai.zou@intel.com, wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 4:33=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Wed, Aug 28, 2024 at 3:38=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Wed, Aug 28, 2024 at 2:35=E2=80=AFAM Kanchana P Sridhar
> > <kanchana.p.sridhar@intel.com> wrote:
> > Are you saying that in the "Before" data we end up skipping zswap
> > completely because of using mTHPs?
> >
> > Does it make more sense to turn CONFIG_THP_SWAP in the "Before" data
> > to force the mTHPs to be split and for the data to be stored in zswap?
> > This would be a more fair Before/After comparison where the memory
> > goes to zswap in both cases, but "Before" has to be split because of
> > zswap's lack of support for mTHP. I assume most setups relying on
> > zswap will be turning CONFIG_THP_SWAP off today anyway, but maybe not.
> > Nhat, is this something you can share?
>
> I think we're enabling it, but we're a zswap heavy shop + THP
> allocation is not suuuper reliable until recently with Johannes'
> latest (and upcoming) work, so I don't have much data to share :)

Interesting. If CONFIG_THP_SWAP is enabled this basically means your
zswap utilization keeps going down as your THP utilization goes up. So
the swapin cost would go higher. How do you deal with that?

