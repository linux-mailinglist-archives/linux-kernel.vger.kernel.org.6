Return-Path: <linux-kernel+bounces-520823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 611F6A3AFB0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 03:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 212BF16EBD3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C039118FDC5;
	Wed, 19 Feb 2025 02:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="afv7hQDu"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ACC157A55
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 02:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739932664; cv=none; b=mBGpSu+gir0tRzxb8zn1qr7nh6kMEpQGv46sWVeGNHazelC4AXfaTwZRC9cLmyc6DHuOkMgv6IhETSwQgpHAaj1uEnADffJepabrjDwoT2i+a1nL/3ZCRp7OIlukYsm9C4rrcRD+Sm0LZVX3bccN/tF9Kc0BVgOdd5NgPWfA/nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739932664; c=relaxed/simple;
	bh=0HSYr8AtBOLoWK5iWmiAHyWKunqueCUl6Dc7EF0/I7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mYttWwx0BeZWjjJwIgH27j2zDB5sOCCrdD8xKNlGymgAfdb6yfAYT2pAvHlbm3xWa21ZvprF7iOLSxnf0+z09bdWNvYXJoFRbdkf8dnTKf5R7b58Orosam6NHKYxuYhPapH7sEPfutRuYJflfB2q2l3vR7Bf8awTAl37I14sYDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=afv7hQDu; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5A5193F1DD
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 02:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739932660;
	bh=xpF/uqVgz1DIPu42/nvkTgDWLM87bKVH+JDh7HeEf0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=afv7hQDue6C3v+a69bc1QvYEMPi0cZ6jJaZ+zm+kHOAWtWqtWU3PlXOxf2fv31MPh
	 ddnBMZsm7hRH+SRydGUMk27JjeDNIzDL0FB/FFsnlu3nLQw2XnV8vFCooO+23AMCqE
	 UxnpJq+JV/rehv4v0BrWXBMKL3nW7fR4Yw4YsaMzTiJLJ/SNCmJMteHW30tBf89tae
	 VozA96dobaQITTvbVjSjCA6kaKnfdtSLqX/odzT7QMcPemq/43nuD8Zt3lU5QGoIBk
	 DiD4xjspP2MAt0gucnib01e+irD/z/63161NZHOH1qPLWRE3B5sf9jeEqHNV483hVp
	 SgWvA9BJ167YQ==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-abb7e837a7aso362588666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:37:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739932660; x=1740537460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpF/uqVgz1DIPu42/nvkTgDWLM87bKVH+JDh7HeEf0M=;
        b=D5XFsSu93dZbJQYIFSw+kadH8CswzT14cpx8dB7UqHJLdSsnbFu7Q0eKLFrsaM2goG
         8Pb9E2CEEn1jUhXxYHkCUWmVIo1PxiBMex44uJ2tBGHuDu1lecxz1kv7aKFwPMX1vh/U
         TjWydukYSPbVYDwHuB6BuzNgiqEjhjy4x9QLdFl9K5F8s+0l1kiT7IfaVYNH2DpQFvWy
         nVymOpOAjasM4bjYuMj0WI9LodMz6OWvM9qBorABvfwY+eFsu20Oh/nFqVLAAwFbj9iS
         xbyZMBIJ7fWUbiWoWUA6OipFB/yJr7PpzFu/0oI9CeX3CtgeLlC3WPxSMY7ao5I2QRcI
         187A==
X-Forwarded-Encrypted: i=1; AJvYcCViyGK4oqwBI3tFvb9FslJcvaJwekawt/L6cvK9JMYXgJmQ66/iA5WKKvzGFqocdkd2Vpo53lkONN5ie2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkx6P/2BAnC7jOeUzlxoTMPHXnxiUouulF5Iz4Q+Nls/+fkenj
	y7AHs8Ynv9a/FOf+FXHo5R3+keL710LDsYOFCeoJB+kFx4wDc7mA0kbKV5QSbzAyCRdBdR45HbG
	1lSop3Vt8flTisQxtjlE2eTprYz8cFAKvcHVzPRMmqStM9qLcIPTGQM0VtVDvdjeBxsUbX+TuyX
	gpXhllUyMYCHtnSa2lTm5MvdHTZU9xNtkDZlrYjiEaiFBd+P33cg4W
X-Gm-Gg: ASbGncu/ec/8Mx+5lE8BoBr+FahWIHENcLrfGvcyszCvA/7Wr2Na+IWpeNRQbRIRFyZ
	1vXTOEUwRBarRyvSjtCNSBh9q9CYy5hGz5dwNm9F8vjqYpJWfRAp1NPO23J/Y
X-Received: by 2002:a17:906:c154:b0:aaf:74dc:5dbc with SMTP id a640c23a62f3a-abb70bbe128mr1861184266b.29.1739932659916;
        Tue, 18 Feb 2025 18:37:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECXTzTfK1hucT5By1Vc8OsQKE7WAN8jPGAEpn8NtOS1yJ+2Zh+7oQ/9jhpxrBKBlUn80fC/zEsdNt+HBs+mbo=
X-Received: by 2002:a17:906:c154:b0:aaf:74dc:5dbc with SMTP id
 a640c23a62f3a-abb70bbe128mr1861181666b.29.1739932659564; Tue, 18 Feb 2025
 18:37:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218222209.1382449-1-alex.williamson@redhat.com>
In-Reply-To: <20250218222209.1382449-1-alex.williamson@redhat.com>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Tue, 18 Feb 2025 20:37:28 -0600
X-Gm-Features: AWEUYZnajB3rq8CyRdBuSpSrOypipt2nxnKQMlTKOQA6kaKkIZVRcB0xmWVuT9o
Message-ID: <CAHTA-uZciMceCK3OF6krjoPx1kaoeQRuYhkpfZ_tZJQ4dmhzJQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] vfio: Improve DMA mapping performance for huge pfnmaps
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, peterx@redhat.com, 
	clg@redhat.com, jgg@nvidia.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	david@redhat.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

No change in behavior observed from v1 on my config (DGX H100). Thanks!

Reviewed-by: "Mitchell Augustin" <mitchell.augustin@canonical.com>
Tested-by: "Mitchell Augustin" <mitchell.augustin@canonical.com>

On Tue, Feb 18, 2025 at 4:22=E2=80=AFPM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> v2:
>  - Rewrapped comment block in 3/6
>  - Added 4/6 to use consistent types (Jason)
>  - Renamed s/pgmask/addr_mask/ (David)
>  - Updated 6/6 with proposed epfn algorithm (Jason)
>  - Applied and retained sign-offs for all but 6/6 where the epfn
>    calculation changed
>
> v1: https://lore.kernel.org/all/20250205231728.2527186-1-alex.williamson@=
redhat.com/
>
> As GPU BAR sizes increase, the overhead of DMA mapping pfnmap ranges has
> become a significant overhead for VMs making use of device assignment.
> Not only does each mapping require upwards of a few seconds, but BARs
> are mapped in and out of the VM address space multiple times during
> guest boot.  Also factor in that multi-GPU configurations are
> increasingly commonplace and BAR sizes are continuing to increase.
> Configurations today can already be delayed minutes during guest boot.
>
> We've taken steps to make Linux a better guest by batching PCI BAR
> sizing operations[1], but it only provides and incremental improvement.
>
> This series attempts to fully address the issue by leveraging the huge
> pfnmap support added in v6.12.  When we insert pfnmaps using pud and pmd
> mappings, we can later take advantage of the knowledge of the mapping
> level page mask to iterate on the relevant mapping stride.  In the
> commonly achieved optimal case, this results in a reduction of pfn
> lookups by a factor of 256k.  For a local test system, an overhead of
> ~1s for DMA mapping a 32GB PCI BAR is reduced to sub-millisecond (8M
> page sized operations reduced to 32 pud sized operations).
>
> Please review, test, and provide feedback.  I hope that mm folks can
> ack the trivial follow_pfnmap_args update to provide the mapping level
> page mask.  Naming is hard, so any preference other than pgmask is
> welcome.  Thanks,
>
> Alex
>
> [1]https://lore.kernel.org/all/20250120182202.1878581-1-alex.williamson@r=
edhat.com/
>
>
> Alex Williamson (6):
>   vfio/type1: Catch zero from pin_user_pages_remote()
>   vfio/type1: Convert all vaddr_get_pfns() callers to use vfio_batch
>   vfio/type1: Use vfio_batch for vaddr_get_pfns()
>   vfio/type1: Use consistent types for page counts
>   mm: Provide address mask in struct follow_pfnmap_args
>   vfio/type1: Use mapping page mask for pfnmaps
>
>  drivers/vfio/vfio_iommu_type1.c | 123 ++++++++++++++++++++------------
>  include/linux/mm.h              |   2 +
>  mm/memory.c                     |   1 +
>  3 files changed, 80 insertions(+), 46 deletions(-)
>
> --
> 2.48.1
>


--=20
Mitchell Augustin
Software Engineer - Ubuntu Partner Engineering
Email:mitchell.augustin@canonical.com
Location:United States of America


canonical.com
ubuntu.com

