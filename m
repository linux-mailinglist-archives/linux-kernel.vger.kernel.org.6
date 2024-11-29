Return-Path: <linux-kernel+bounces-425682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6675F9DE905
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DF00B22519
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 15:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F620145335;
	Fri, 29 Nov 2024 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pqCx954B"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8319713D897
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732892404; cv=none; b=ZA7kj8p/nhY5FlG1HiWxIRgC6D1Xp6Ef0nAzg00q80r6t6sbz1iNfeTQNCT/M/dUoKFKyXhXkCgfbRpzjtcpRp2D0p1xR8aCht8Q61WdC5IVyXIMCx1f6eDHeFlLY7g59KjqI2F35gC4F9lvnq2RCrFBw50rBaYpupec2WOnxFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732892404; c=relaxed/simple;
	bh=7rKnjW4rpFTe59H8KcB97NQe+rDchrrI2JouqK3NvS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqGLQ5EDI4A1v8R+7Q9J8sfL1iMmUVQ0YF5Cs+NNnZp8hwoyHYx68sxYDc2WIQUyj9fHYAYQUcowHJ4fuN4HfVYZf20PFKWdrOVnrcjitlPtc9t9f7RwGjQRo8pCfz6JJ1h/imW/o8MSLfR/jBLhe4jP/LAI0Exo5bZWQGjuN7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pqCx954B; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434a7ee3d60so18202395e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 07:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732892401; x=1733497201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rKnjW4rpFTe59H8KcB97NQe+rDchrrI2JouqK3NvS8=;
        b=pqCx954BagLF2FV0MPzc3ApQpcw9Yz80DovSXfiPn5RIKp0giwZyWfCnzB3R+gHn5p
         gHxpeyDnZaiW/IXTuuqsAdH2DLnoFwMufPebxiJIyC12nPN2ctdvUgwmkhqoniFCISnV
         TaP2sfdFIxN7l71sCwRpMR3TI5lVJpri1cOxZpnSUMzVS3gzlSj6SSDRTimtzhArs2Ow
         YZq8brfgpcif5bpj5aeLt4P5l1hpOY9+jMgwNkkF/xtdQUdh1vmy5vHW1DiJh4p74uDO
         aPSFezE0DSbnJhl2EjJ89thCkkdiZbKjgWde1Qu36DZrcjDacRBagT3vDDJ0B7t4BQiG
         CBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732892401; x=1733497201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rKnjW4rpFTe59H8KcB97NQe+rDchrrI2JouqK3NvS8=;
        b=VMqXadwdoxNMGksNK7IcfPZrpGNCplnlldeZCkW/Dpez8Gdx2j5kVU9qOhJnmof8JN
         dP8aeXswbuCEhO6VjVjFC2coTlsPGwx7vuwiZZwtpJyNcnYHaLxx0sgTjXKCacJOoI+l
         3qexBIeQ2CHnL/7I/Mx6nZjgBC/GqRiPRFKTjTcLTPAeLd5P5ZbqEIlxULFHKvdvQpG3
         qML4QDaleoXlW0w7OhtJOB+YpOUDbYnSMDj/6XNB71VA2BjBkMQcfGFG8c3N7GB0Ealw
         x4WQ6T0Ar+lT95zAI3kJXG+H4XuAyLLPDl6CfXbRmUPJGiq0Nf2vXRKZrLbDgMctSjUP
         a8qA==
X-Forwarded-Encrypted: i=1; AJvYcCWVCBx+NG4xfwxgJq8o4GVfFLtGLL36d/6lQ3xfnbi5ix1lzrXsmGeFYWN95DWJEjp6sgYhfnVERjbf69Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaZyrt+MoW2JgCBzA0ew6pLjBNWwp7WYiwsJBF0OqNzqFP+Taw
	XW4vGTlOVMh5frvHNIg48Uc4GCjkqL8y4Z3D+DWcihldtzQImOhydTgEpJIJCVGAPvmoXB+IJ2i
	D2XkZiC8zgmhJ6KPr2z0/zj+Vz/JpbKJK/QDn
X-Gm-Gg: ASbGncvU7R0P8O3w44eZ2O6sB3G3TR5r3xzj30kqFlfpk7nsPWFcyabbmbn1U7MX2Ca
	2rNvW3p8TooxPtMg3mQOJYts5YqSYasdOWl5PN+B2FC/oCoykzW5eomjVRxdXFw==
X-Google-Smtp-Source: AGHT+IHDi4K4lNAohQfNlceyKH9RUzPZtVMe3BZmZ2vxNmK7aM3ImmmIXciX3tmNHa7ia1ZHmeIkXE0xn4QwvOvwLsc=
X-Received: by 2002:a5d:5c05:0:b0:385:d7f9:f15f with SMTP id
 ffacd0b85a97d-385d7f9f229mr4841298f8f.19.1732892400847; Fri, 29 Nov 2024
 07:00:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128-list_lru_memcg_docs-v1-1-7e4568978f4e@google.com>
 <Z0j3Nfm_EXiGPObq@casper.infradead.org> <CAH5fLgg00x1SaV-nmPtvRw_26sZbQxW3B0UWSr1suAmhybxc_Q@mail.gmail.com>
 <Z0nReJHvBJS1IFAz@casper.infradead.org>
In-Reply-To: <Z0nReJHvBJS1IFAz@casper.infradead.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 29 Nov 2024 15:59:49 +0100
Message-ID: <CAH5fLgjosHfmOX5_8p04jGpOQSdR7UBf+ksugA+dSL9ZNTJ2sA@mail.gmail.com>
Subject: Re: [PATCH] list_lru: expand list_lru_add() docs with info about sublists
To: Matthew Wilcox <willy@infradead.org>
Cc: Dave Chinner <david@fromorbit.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 3:36=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Nov 29, 2024 at 09:58:27AM +0100, Alice Ryhl wrote:
> > Oh I had not noticed the "Return"/"Return value" change. It must be a
> > copy-paste artifact from list_lru_del_obj() which already uses "Return
> > value". Would you like me to change that one to 'Return'?
>
> Yes please!

Done in v2:
https://lore.kernel.org/all/20241129-list_lru_memcg_docs-v2-1-e285ff1c481b@=
google.com/

