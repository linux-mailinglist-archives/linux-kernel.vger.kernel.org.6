Return-Path: <linux-kernel+bounces-307850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CD39653F2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 02:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 043952838A3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 00:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB64E2595;
	Fri, 30 Aug 2024 00:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqZTslOs"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2A923B1
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 00:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724977211; cv=none; b=IzTihbXFM9zdG7hNIauT1Fvp0NktOJlXqtgmLCG0/Z3BLFythMIFdoTpz8ZWKG5l8FzlelN9zacbCEMchT+5s2FnlvW84WsaO2TX89dAEQGNCV5pc+Ah+rfqiGlvjYPlhgGXBvIrYTxyZ1tu5qKYF0760dH0hBxqkD/dk2gGXWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724977211; c=relaxed/simple;
	bh=pq8/ye+EVtbfQjtYRTx1RwF1/V0qM9Qn4mgDSQStvqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nB2pxyJTjB+4afBQAQxKbRA4sRexVrQmduNwHEFH3V60EFcrGLy8ntX+WOUE0WbIcAXmBBLVn/df5cktopCqwYjpTfpGLvt26s8dRXS/ePgn7OPzryWyyMxNIiwvnASJwcudckJvJj1z03nSnd17xQFKng1qP/LEWR6t6ThZyKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqZTslOs; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e179c28f990so1221053276.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 17:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724977209; x=1725582009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pq8/ye+EVtbfQjtYRTx1RwF1/V0qM9Qn4mgDSQStvqo=;
        b=kqZTslOsaR+ikz2a7Dfl2NZbACbPUxO+STUWTDJ0cjYl9hloizjv05yRN1MOROEMH5
         JyDmtZ3DYD9Lknz1rAqGwZ5HcDtC7GYjYHSwPk4B8+vCn9B8K28n6Sij7EkmsxBe8W90
         WBHwYIEBP8Wk5131DDeTIztyiuU3pj43IQUjtzp5oD1DGQjZ2iaRE2ht2HM7gDtAc84a
         JUV05e2UB3cenarot5koguSrjyYxa+qOhlYTbbDnh7rrTnlUaINaVeq99nf4e4BZUGE3
         Mvsx4WT0f9aY8emZksPMLIy3UH1jRYkqeCMeGYP8MvU1D6xEglx2C8+NDg0OwSWlkPZE
         eFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724977209; x=1725582009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pq8/ye+EVtbfQjtYRTx1RwF1/V0qM9Qn4mgDSQStvqo=;
        b=jJvwVBqsDrArBFaFykAxCevpOXKBWFODgXPTAXmGhpvuMwXFKDZ/E5hqxolC5s1Eqi
         F2cK3Ipan16ipTU1y0sNR76YQOcS2la7Xa84Tm1vFxYx8lPut2XNEj4W3AvBLjLcZk5d
         O2JU+Hw5nIe4bpz4HJq5sd/+alyI4DwWkCGKB6bcmTmiB1WB3mWiE7/eYUYRc2IVa9lv
         qIb85tv2MCVbinGnq5KQlh3jKKRefwC0p/tnj/u9urFOyl0tysHDmWxVocs16CZzYNI/
         N3pl288x2UeZLdfrFLvKU868428fdCHFwc4U1A7zC2LNSXo4uZxylS05q5/RyE4Z9UFI
         Aszw==
X-Gm-Message-State: AOJu0Yzbtp0fZGcbfGV4G+A+6uxli/UqqHVg2bUvlRvY2l2u+1ZDqLpi
	QZdwwGfD7qKEaE0qULuq5KC9V8NPPYGBIV4xOBQ4+ztHby68aY6ljE8GFHDDknC4b5/aNJwMINP
	85PdCniUo9eFVViDEns8M0q94od8=
X-Google-Smtp-Source: AGHT+IGA10iYP4xYvqI1e9nwDNM0jyyLJ+Ig3o5b/Pou75d09h3KxZhzSJwpiqom+3YaAd0ZWegw6SnCgSuYCvz+Fyk=
X-Received: by 2002:a05:6902:218d:b0:e11:baf6:a323 with SMTP id
 3f1490d57ef6-e1a7a1ae4b8mr501324276.39.1724977208685; Thu, 29 Aug 2024
 17:20:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829212705.6714-1-kanchana.p.sridhar@intel.com> <20240829212705.6714-4-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240829212705.6714-4-kanchana.p.sridhar@intel.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 29 Aug 2024 17:19:58 -0700
Message-ID: <CAKEwX=Na1AySK6UMm41h5NkFo59c_ZBGvD-FUZb9vbQ90e-ejw@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] mm: swap: Count successful mTHP ZSWAP stores in
 sysfs mTHP zswpout stats.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
	ryan.roberts@arm.com, ying.huang@intel.com, 21cnbao@gmail.com, 
	akpm@linux-foundation.org, nanhai.zou@intel.com, wajdi.k.feghali@intel.com, 
	vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 2:27=E2=80=AFPM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> Add a new MTHP_STAT_ZSWPOUT entry to the sysfs mTHP stats so that
> per-order mTHP folio ZSWAP stores can be accounted.

Can you update Documentation/admin-guide/mm/transhuge.rst?

1. New entry for zswpout.

2. Probably should clarify the semantics of swpout too - this does not
include zswap right?

