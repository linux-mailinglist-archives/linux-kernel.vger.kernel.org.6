Return-Path: <linux-kernel+bounces-424456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818AE9DB4A6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A31282294
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB18154445;
	Thu, 28 Nov 2024 09:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cvooM6Q2"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00212154BFE
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 09:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732785278; cv=none; b=pwK6A5OUzys3d57TzXAMNI5ERM8MDXz4HlRkV1Vdzh/K4mGyGR7FU+O6szVWjFbfvzn+3xL8UP3GD6NLFLfP9JcTcWud1lQ58nuq7kCwkpiAd+do6By4jHURTflBqcfzaQNY1CN24RbvQVjIs5EgbMwRlVId7725pSLVUnJhGQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732785278; c=relaxed/simple;
	bh=+RwrGvFnR/1yuMp6y+4dSC7bCdIbBw1r8nPWRcX5aNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/BpWxgr+fNSiurv/cYeAZhKISypce0wmGnvmaIFhJNm7CpcVFrzt+1td+76asNODe+XOzAQN/3ystivw+fdcn8bt+8qXakhvG9AIdNNn4LFDN7YwgCFoHNqq12wBQ97UkwaI0JaVGdOAkjM5P5Wzyyn5BiXgElgSp7f6+zr14c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cvooM6Q2; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-724ffe64923so681668b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732785276; x=1733390076; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+RwrGvFnR/1yuMp6y+4dSC7bCdIbBw1r8nPWRcX5aNU=;
        b=cvooM6Q2K23LxF/OPQeFAe8QsWDc/Y59n6SFqVD2xcTxW6zEcBeSsOBAnBnlIEGWzl
         n+oWXIWOaAqgXpKoQga/+62AEw/8BfmJqZLqiWYI2Ryn+Fb334aKDVs5MFrpXtnYZ2GQ
         TpXH5Sen154HVZmhUNFGoRrWAMUkfAnsflchOcothA7j5jTy6F6uLnyPMuAI2C2VhMDf
         mxJ+66XbLqe+x5m8hbGGiw0kwctuutAxX6tjqojT3twrBizfw5Meqc4+foNqsD+KOFJ9
         WzYhHCNOaDLLG6QOLDQRXX1P2XlKDOnkO2uKC2MmhnRqXhzyTisSbW3WJYlAjA5hH18k
         MYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732785276; x=1733390076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+RwrGvFnR/1yuMp6y+4dSC7bCdIbBw1r8nPWRcX5aNU=;
        b=lIiHFXpoTh3eoTiQuB+3UkTdD7mZi7vbSnokCyD/4z2FUtXjdgifFoEQOg6EHyP4au
         E9aAhPz4A/21b7qS9RBI8k6IbfzPABbX9wVsV3eXrrQ7VQf0r/I5c5OFi6KjH8O33Mbw
         M9dH7tg48hMs7e69UWoz+5u9NRgZkxwT60tMnyfa9I/jizWKqIydRdnIEkZ21ekgJb+5
         NlE27ifpY73pDq9opUSq+ZjmCMIZ4QNmEtKHhKY67D2vDHzxBF11TeOmrbBAKafrbXJE
         Xcdt62uE2gbDSUsQVaJOucgAX59ymLv/mGaG8Asf0UZPo/sYmxFChRNjEggkcIMeJRCQ
         SGUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCDxgvPD22GELXrfIqywbND6JBdsaARMhdTUuHffSvpUCaQ9lJdal8lbs64osiV6oDV73S9qQ4VB9vP4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEfWEUHS/07g/kWKqJBbQFmfyvBaK7nZPEttJ4+N1cEXL014A9
	sZMXEBFKV1F5JiFQlQQtB2VLvGIWPsuj2Olrr5Z+kognXGv2M8LE+O+ECP1lmfA3sFbPgWVU6Xd
	kF99rtjPFLDqsh8YE/0uPySSJ8RMCcS5rFt7o
X-Gm-Gg: ASbGnctiOqm9St+zWnwvyi1aiCchhkcld/NbPk7/j21eYO3GeUbo9KKZH7HX7BIgdRj
	W16UCAfYezAwFdh8SzFqTPptq16wePRdoTnkB/Z4RM1r72qqag1rg3AmJzsM2CTE=
X-Google-Smtp-Source: AGHT+IHe1mD7jKSeVuSzIwRC/v13V+ZoCLx043OO1JxUpZG1K4+7c49fjkdBwGUgxF1AOZNEDXMkSu5bIJvNqD5Ukug=
X-Received: by 2002:a05:6a00:92a2:b0:71e:6c65:e7c4 with SMTP id
 d2e1a72fcca58-72530185399mr8749308b3a.26.1732785275833; Thu, 28 Nov 2024
 01:14:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122154051.3914732-1-elver@google.com> <20241127172523.b12b82d150aad5069e024645@linux-foundation.org>
In-Reply-To: <20241127172523.b12b82d150aad5069e024645@linux-foundation.org>
From: Marco Elver <elver@google.com>
Date: Thu, 28 Nov 2024 10:13:59 +0100
Message-ID: <CANpmjNPDVORFLCqnm3n1RHnJBKdim_x=kurbOJ0QYxaztT4q=g@mail.gmail.com>
Subject: Re: [PATCH] stackdepot: fix stack_depot_save_flags() in NMI context
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, kasan-dev@googlegroups.com, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 02:25, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 22 Nov 2024 16:39:47 +0100 Marco Elver <elver@google.com> wrote:
>
> > Per documentation, stack_depot_save_flags() was meant to be usable from
> > NMI context if STACK_DEPOT_FLAG_CAN_ALLOC is unset. However, it still
> > would try to take the pool_lock in an attempt to save a stack trace in
> > the current pool (if space is available).
> >
> > This could result in deadlock if an NMI is handled while pool_lock is
> > already held. To avoid deadlock, only try to take the lock in NMI
> > context and give up if unsuccessful.
>
> Is it possible to trigger this deadlock in current kernels, or is this
> a might-happen-in-the-future thing?

I can't find evidence this happens right now (at least with the quick
test I just ran), so it's more of a might happen if use of this API
broadens.

Thanks,
-- Marco

