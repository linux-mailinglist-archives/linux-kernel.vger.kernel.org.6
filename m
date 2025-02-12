Return-Path: <linux-kernel+bounces-511086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE422A325AA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380923A2C39
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7493320B7F7;
	Wed, 12 Feb 2025 12:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcIw9ksd"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365FF271822
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739362045; cv=none; b=XxgLcd0TxndjWqXROnIFJm6vE9KjodLoCzLoDefYPNOWDwaswWUo4btHxF7LqsOgyGH+D189c5Ag1XTFO9BYRZShXXwSDdkizy9W6Z5aii9rBo+MrOI1v+i9/L2wlI/LPdmVhhl32YhkIxa0cbNIzPS/fDMCzFLYTq+qdlO6c/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739362045; c=relaxed/simple;
	bh=m+7AIzaS6qw6D7rm+xj+rIUgbPFe9Yd5MZAp2+/RNKg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rp/zbqpuYKI+Q+zRtAAXDbh8HGU0qsXD/mL+xTB//VKGNzhR6+KRIKPDsAmhDbTl5YZCRKTYnHVFEbt69iuRGxF1A28+6gTTbG2f0lTQkz3338TcVv6A50sKoM7ahZXcxmxeKcmCfYCFpRfyT+0IafMd0ac6ysh2SerlAH+yf7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcIw9ksd; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab7e1286126so335060066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 04:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739362041; x=1739966841; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CrVye6MPzWCLDkatFMo1WLbDCtOoMAqYZUqUGOJz98=;
        b=gcIw9ksdfLOIkCxJ0vJl6CelCN14T04mHVvycv631cAQSxewl4eUJNwDFMGKKbQIJA
         4ZB6mKG0a6Umx/q0xQ3q8XEa+oteO3Y0/7HtPDatNHwB7X0V8LS1yBNsf5gReCygLDK1
         oTbGqlhRBszqYhUiMoTx6vX5H4sVJOf8tud93r/U0ehV7GT7BV5mnCsHsah8aYkwWZ/i
         2lZ3nvIU7ECnt8F+Y1LzQpwiJDiCVt9KsOgz1NU+96UcIs6E6GO8QxePPaRHkxByTJiz
         uKt9/a2MRtoHDVlCAPZU/Kc2mQOgkSSykH+pOQAKfkATFfClQk7xR96xJ0k/I0TCcNY2
         K7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739362041; x=1739966841;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CrVye6MPzWCLDkatFMo1WLbDCtOoMAqYZUqUGOJz98=;
        b=MR9OQFGP9FVXlfLZV17eaZUxhoOXsyXwJJwKWv4NZMqqICEzw2DswoIUV73rj1u0D2
         uHu1X/s77AnCRD4Tc+orjHc/MQ19JZN7IOhOt5Wl2yHWbbYLIqR6+smylVYQG1NIo3wh
         oIa6bNMU0V/1I6lx44wNaIxqujq9Ijf3qB4oP7H/auNQjBJfWFrXxaH4RC8MyCMmg3kP
         CHy1arK+9yvUHEKc3CGnw8V6Yo7DELq3ZM4A2/PbHwrL80y9rcNxCeF+7SW59Mw9seIC
         1lZk/h2MfJohUku9PmkmHvoCxom2qzxlklL3xxWHPJYxTldeLR0jC9QlZPsQl7YUDluy
         GCAA==
X-Forwarded-Encrypted: i=1; AJvYcCXzFLHtZvEJx04qaDWqcYtEWtBbOvrX4GRiqrJ+tXzzu6gCY/4AUTI2AygZ7Ig3ftJCQ2hqrbjEpjAP9NA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ0GMbc7j5D2nqa1znsLg2Zie+FvlULzdBHQgFws+PFViFqRL7
	wUQ9+VUwdsqAJbFoSXNKTtiFlJ2Aib7szI8CgC1Hzx3/JpL3aJAq
X-Gm-Gg: ASbGncv+DCesJsge35sQTnxry5rgPznmaIhOTON/nogcjzk9hqrgmFRqZKwNWzFnbor
	Zcebf9YLngA6MLg3iCAa+o9eLO+Je7c3TGf08Emi5Owziq7Bd0ng99V3FVT+l+DlxaaOJqfZH5n
	wVizNi0oVbjw1XZC4XjirFs3hnGENDtzG7np345ijvh5V4R/s2t3vELMFUBLxnZ7/rVLyIzaV3C
	NX/JiIf66XJrXw2eH1/aQGyDSYN/4Uz5sSyCo/SyuNaSLK66EELApOiUvhRpp1zKuJVh8nyqetL
	LRdyI9drmsgVQ71hYtsHLEUGG6g5lh8=
X-Google-Smtp-Source: AGHT+IFc1v0JcVlWA924bMLzSxaUPYChpvrd2w78UTf+MsA4sSygFAE0xQZWb8eWB8RA+HbFzu+bYA==
X-Received: by 2002:a17:907:3f0f:b0:aaf:ada2:181e with SMTP id a640c23a62f3a-ab7f33c63b9mr221665566b.26.1739362041265;
        Wed, 12 Feb 2025 04:07:21 -0800 (PST)
Received: from smtpclient.apple ([132.68.46.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7d101ed7dsm455259866b.106.2025.02.12.04.07.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Feb 2025 04:07:20 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH v10 09/12] x86/mm: enable broadcast TLB invalidation for
 multi-threaded processes
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20250211210823.242681-10-riel@surriel.com>
Date: Wed, 12 Feb 2025 14:07:08 +0200
Cc: the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Borislav Petkov <bp@alien8.de>,
 peterz@infradead.org,
 Dave Hansen <dave.hansen@linux.intel.com>,
 zhengqi.arch@bytedance.com,
 thomas.lendacky@amd.com,
 kernel-team@meta.com,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 jackmanb@google.com,
 jannh@google.com,
 mhklinux@outlook.com,
 andrew.cooper3@citrix.com,
 Manali Shukla <Manali.Shukla@amd.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <940E9420-0CD3-4C9A-AFCC-23433AF8EFA4@gmail.com>
References: <20250211210823.242681-1-riel@surriel.com>
 <20250211210823.242681-10-riel@surriel.com>
To: Rik van Riel <riel@surriel.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)

It all looks pretty sane to me.

One small note:

> On 11 Feb 2025, at 23:08, Rik van Riel <riel@surriel.com> wrote:
>=20
> +/*
> + * Check whether a process is currently active on more than =
"threshold" CPUs.
> + * This is a cheap estimation on whether or not it may make sense to =
assign
> + * a global ASID to this process, and use broadcast TLB invalidation.
> + */
> +static bool mm_active_cpus_exceeds(struct mm_struct *mm, int =
threshold)
> +{
> +	int count =3D 0;
> +	int cpu;
> +
> +	/* This quick check should eliminate most single threaded =
programs. */
> +	if (cpumask_weight(mm_cpumask(mm)) <=3D threshold)
> +		return false;
> +

Does it make sense to first check mm.mm_users against the threshold? It =
might
be less cache-contended.

Anyhow, for what=E2=80=99s it worth:

Reviewed-by: Nadav Amit <nadav.amit@gmail.com =
<mailto:nadav.amit@gmail.com>>


