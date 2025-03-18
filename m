Return-Path: <linux-kernel+bounces-565422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49444A667D7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75DE53AE443
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFB51991C9;
	Tue, 18 Mar 2025 03:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="O4+vRyFg"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D0918FC86
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742270006; cv=none; b=r8l30bAjLwCpXHdUTJc3zIikjp9UHWRdPyQYAlzZnssqzixfkzDbdOB56yk4JSWtla3V+WNHvs6iGmI8Gf/JqXVJh5Vy800be3Lz6quWRNQhw1ks7mMZb4+wgg0H0Mr8ji+5GnZoxWSrKQl2JPF81XmPX0tF+6hNsR9xiwoZZdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742270006; c=relaxed/simple;
	bh=SPJQhG2Fjivhst5PBtXnylwjViPNNM2kv+8gULeU7SU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipeh76MfTxQ0IxzqWg3ZsYerTDEIdFYuYAgw7/n9G0p4U4+qJVrzQlfgnNj6FWSCkSluwaPRGUgrQFn5JXxc4Sb9jk2GiAEwauYiSuBeg8f4aDDcCNPexbb53zzJ1IK7kWJlcYcRcHNZe0FlXO/d6IyPWg3d5+1nOPR5eTtFBn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=O4+vRyFg; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-225b5448519so95420565ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 20:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1742270004; x=1742874804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=titXZ1u8sqgmcv29C5GX0zJ9XE5maVA48khuDzjVSvs=;
        b=O4+vRyFgkcmRDgcsrsYmpDk2xH9BHFlsc+1DEXo66r2x0ezsWwHwFemXeMAwBb+/ac
         7+PHujDPr92n95U4c4BBDPDEuRZY4NuFEHtBQXJJxh0cSfkejV1u+j6uqgwMy6dQHmMf
         QW/5y1guh2bno5LC7k0eDMqlrYky//XHqZGepoRCWH7ELxgSetQmd+QGDg8rtELfkjyI
         aeYRR/zmEYapBho/KcJb237kTjMmfCwIaXm2RnDHypWiCJZwTASPGsM9FpVrG1yyPpnU
         BPTZu/YUEFaEQWweyM0oGv/lrhF8HWfIYOhsqku3AGdbC+ekFtJNqpbtWtRdYdSm2gL/
         b5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742270004; x=1742874804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=titXZ1u8sqgmcv29C5GX0zJ9XE5maVA48khuDzjVSvs=;
        b=eUsIs2NY7zw8KYTvHbTpePvmT74AoYtNmlQpEa/U0mn12CU5mAM0VVzJ6En/tA5lRS
         3joO2KswZerXUzB/eDCY1YqF95+hPQYub4kdw3h4YGsbcLG+912dKvZPBU9k3sOv28h6
         4lK8YVI0oqsXay8BSVv31o573Vai6WIlh7xzWx/hzw7/vc5D6gO5xgV24dSQIH/n9xpC
         w1Sg1d4SedP06lOfGii1BiG9SzfZ7+UyV4hhB4VTeO/yYiUoQI8axa3EsuSctSPKYQRE
         uk1kXy+kRuDFe5nDHSCm3h2OcYphdqihFCT904I7CPhwcKIvQbIss42qcXT3xKS/hWTN
         3eMg==
X-Forwarded-Encrypted: i=1; AJvYcCVnb5HPYddrhhEWs9R/TQEac4kE3ndFKi3FoXgwsG10ny06h7YzsqhoMq8rkWS8k6jzFVqgIUCbwT+y6cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLzATA8vIOrEvFG2rzRra0E2dC1J8mJBx5J+ngJNpAEMpgGSrx
	sdutMMv5pwtH0Ez9xa+lxRaQnSgKjYgMTOEubDTKSruNdqT64MUYUDLLqaKDLW5rVpumL0b1mMw
	q07BJ40r0dTxqUPHCI9dlGAvvT9i9L0RQu0Pxuw==
X-Gm-Gg: ASbGncskbaV7Iw1yYXAElz75co87vUyNkEpdn70EoQ9mhGlZJs798F+YP5Yroz1S+eW
	CPqrQQlAnrkiJZSkU2stmkFoC2rh/3oM6bU6fIpS+ZKzIbmqsCor4RFvNPb77iQyHCnSaHXc4Iw
	0yZHOr/J98eKoXTgtp33tMeXcnemSv/I47UG7NwPA=
X-Google-Smtp-Source: AGHT+IG326VMe4vn7e9NQdmf2Gzb6Z5/6rNqL13aLduhiRSSWgBSBYvNvoDGVOzk0pLh/BjjILq/QbGgoCbsljXCb84=
X-Received: by 2002:a17:903:41cc:b0:21f:85d0:828 with SMTP id
 d9443c01a7336-225e0afb823mr208706225ad.41.1742270003946; Mon, 17 Mar 2025
 20:53:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311122510.72934-1-luxu.kernel@bytedance.com> <b7969702-5e88-4891-bd0e-8728562ff5f5@ghiti.fr>
In-Reply-To: <b7969702-5e88-4891-bd0e-8728562ff5f5@ghiti.fr>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Tue, 18 Mar 2025 11:53:13 +0800
X-Gm-Features: AQ5f1JofhabKG_lWUnMk5-B6NxJsL7pxsKmBBMbcb9NW6YGeRX47Tog6Ry8a4Is
Message-ID: <CAPYmKFstx5_huJu05Dv4jEO7CiOJuQb1QVds218tfcFC1G1f7w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 0/4] riscv: iommu: Support Svnapot
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: akpm@linux-foundation.org, jhubbard@nvidia.com, 
	kirill.shutemov@linux.intel.com, tjeznach@rivosinc.com, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com, lihangjing@bytedance.com, 
	xieyongji@bytedance.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

Thanks for the reminder. I will resend the patch and cc linux-mm.

Regards,

Xu Lu

On Tue, Mar 18, 2025 at 12:47=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> wr=
ote:
>
> Hi Xu,
>
> You did not +cc linux-mm on your series, it would be nice to have
> feedback from them. I'd say it would be easier to resend the whole
> patchset with them in +cc.
>
> Thanks,
>
> Alex
>
> On 11/03/2025 13:25, Xu Lu wrote:
> > According to the RISC-V IOMMU hardware spec, the IOMMU implementation
> > has the same translation process as MMU and supports Svnapot standard
> > extension as well. These patches add support for Svnapot in the IOMMU
> > driver to make 64K also an available page size during DMA mapping.
> >
> > Changes in V2:
> > 1. Supply more details about huge pte issue in follow_page_pte().
> > 2. Fix some style problems.
> >
> > Xu Lu (4):
> >    mm/gup: Add huge pte handling logic in follow_page_pte()
> >    iommu/riscv: Use pte_t to represent page table entry
> >    iommu/riscv: Introduce IOMMU page table lock
> >    iommu/riscv: Add support for Svnapot
> >
> >   arch/riscv/include/asm/pgtable.h |   6 +
> >   drivers/iommu/riscv/iommu.c      | 258 +++++++++++++++++++++++++-----=
-
> >   include/linux/pgtable.h          |   8 +
> >   mm/gup.c                         |  17 +-
> >   4 files changed, 233 insertions(+), 56 deletions(-)
> >
>

