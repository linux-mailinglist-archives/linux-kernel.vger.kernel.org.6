Return-Path: <linux-kernel+bounces-307842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB3B9653B0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 01:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 821C2283F7B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9079718EFEC;
	Thu, 29 Aug 2024 23:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jq26jEqb"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5006B18EFCC
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 23:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724975762; cv=none; b=YN1Arc+2YGqXQRJjhiFb9ZI8dg/UdYWFNK2lXHKrM0fAbyUatYSL6NxvAdqVS9Bl5nafyDhJh26kUkgP8SaibI5Nk/5LTqAK5ljHMzZO6lSJLDd8EXaLx2L4imudBjZvVfBf7X/mz009NnQHjgYiRhPdLvyLSt707vvnib+WouY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724975762; c=relaxed/simple;
	bh=Z56eTYTogGxam/jBW68b68Ds5TR3vKyRCb7j3RLBa5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZlwQncSvP6k0q7av2svPs8wJ+2/Ux7Re2L65H17Rf1tY3OiSxnAuHr9LoG36/Cj0n5zmUHUHRpxbZ/4vsckCuRucXvYWFdD+KjROXRFtNWBbQG0bqcmMgGEgzUlXMvpoqArewc56vF42NmDMVtfhX/yl4OMTrvKZFIOuw/xAyqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jq26jEqb; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c22b1f470dso873236a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724975760; x=1725580560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z56eTYTogGxam/jBW68b68Ds5TR3vKyRCb7j3RLBa5w=;
        b=Jq26jEqb6sB9y+dQGtzfafoyppSqgTTJdWqFaBfQdTXqXtREVZLZfxHWxFYVF44+7m
         +EYs2tdjFrrd50v7OtMb/N4TgIwnY9LHJa6602iG5kI/gIig+AXI2OWmWm4OyU3VrrMU
         3590WNQBze46zIbOGogYp6jWG96v8GL3uT+nvKJq5I5gYda4TLHeNFH8NHQQdl446b2L
         5+5LHPf+LcHWE6z53ooinVbvO6O9KaMXtwWppQXeXqAJE26kOkp7hAlhbclv5OS0yKCZ
         mRQVxVBsaCMgNbZNfxWUMCnEqdfKHtnKtYLYwTNhiur9JGEjyafGje1bX8FD4JJoJS2O
         rRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724975760; x=1725580560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z56eTYTogGxam/jBW68b68Ds5TR3vKyRCb7j3RLBa5w=;
        b=J4/dy5A/8w+Twihm33cJ/v3u00CgaZERA80Km0ies2dDO4Y6GL093s3o5nWauFOGMs
         hREYtukzazBmyTQmJJodp7DEdtgInuSZKLGClon1+iRxqjtTfEmIYfg6xhGbd1OIguEM
         9wNf9fyjglY5gibwSJHcRlexZCn1gRWx0+Ik4VEy8Pr6Ii0mJTGJx40Eocsf3i3WP7K3
         SgxDeK8U+ZG+TZtyWWFmyHvW7V+CxpGeawOjEt1RwFpWcAcwl3oXNPuBiYMYcJswF9GI
         IokWYFc4ptNyOfqK2lTfeJceDSvttn+u67gMH9TTBS0v7mEKp/qxmEWTGBOVCb5/RnaX
         JvpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeKXzmu3yOS9fNnbRWgHlnoS//u/ds0xROIAwuyimQ6OqEPyIg8J3e0OZ4Osxzji707AE0vyerSMZZXY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjgkmNE8YxVC+GIp0vpY58eDxgrV6146LtJ/U7oNPKFv4k5llE
	awmIiJIFXPIbWBCiJNV9luC3gE2RafBxpBnr94SNqF11sezQ0HShwudplCNZf4XWH6JM2OKmaRk
	zh8J+jmiOo2EB4Kg7gMEopD52sSjPzPIls25Z
X-Google-Smtp-Source: AGHT+IEO+rZOae8h+9buJpbqj7PYzlZzY330N8iMyF0vrJhhmkh5Yne4HgabKQyv3/a3J36Qr0DINbuzfB+lyC8TSUg=
X-Received: by 2002:a17:906:f589:b0:a86:9d14:dbb8 with SMTP id
 a640c23a62f3a-a897f77fd62mr399237966b.6.1724975758976; Thu, 29 Aug 2024
 16:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828093516.30228-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkZv3YnhxFo-rvHNB2_mro1+UuKOP69yXV8KmaeEz5F1mA@mail.gmail.com>
 <CAKEwX=O8CfyBHZD6Xm_0DW5EuTY7g7FhKHiKj4xzZ4ozxdgQFA@mail.gmail.com>
 <CAJD7tkZnT2_JD90xAt09Uk6Lsc6C8t0V5dpUOKLLknw75yUqkA@mail.gmail.com> <CAKEwX=Nak1J30bDmavQZH3SrcmP9hj2X7wYg-eX=k-jb_p+T=g@mail.gmail.com>
In-Reply-To: <CAKEwX=Nak1J30bDmavQZH3SrcmP9hj2X7wYg-eX=k-jb_p+T=g@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 29 Aug 2024 16:55:22 -0700
Message-ID: <CAJD7tkZY-VNGbekQsB8UdMhyN60zdg0DnjomzwSi77+Jv+N1Zw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] mm: ZSWAP swap-out of mTHP folios
To: Nhat Pham <nphamcs@gmail.com>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, hannes@cmpxchg.org, ryan.roberts@arm.com, 
	ying.huang@intel.com, 21cnbao@gmail.com, akpm@linux-foundation.org, 
	nanhai.zou@intel.com, wajdi.k.feghali@intel.com, vinodh.gopal@intel.com, 
	Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 4:48=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Thu, Aug 29, 2024 at 4:39=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > Interesting. If CONFIG_THP_SWAP is enabled this basically means your
> > zswap utilization keeps going down as your THP utilization goes up. So
> > the swapin cost would go higher. How do you deal with that?
>
> Johannes definitely knows more than me about this, so please fact
> check me. But my understanding is we don't get enough THP for this to
> become a problem just yet :)
>
> But yes, we're working hard to make THP become more readily available.
> Which will lead to the problem you're describing, hence my enthusiasm
> in this work :)

Adding Shakeel here as well as I am sure he's familiar with the
problem I was talking about.

