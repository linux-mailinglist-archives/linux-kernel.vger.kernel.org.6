Return-Path: <linux-kernel+bounces-174960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D238C1805
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 23:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FC051C21575
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 21:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8755684A5F;
	Thu,  9 May 2024 21:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X4OWjvzO"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72327811E0
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 21:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715288620; cv=none; b=HyQDrewt5L0w8yS3KZvuE/QXkH8DJdZ2pebBD05YRTT2WC+bzP6s4cTifFosmDgZ9o9V7oZpT7MIiN/Ve8T/hoO1YxpjzGp0MdpmGPZgg9WUC+OphNYUl0OdgQFMfarlzTQrQd0yTpY0K0mVFC23aP5DSDu+2dv8+PWOx41Lv4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715288620; c=relaxed/simple;
	bh=WWeJkG+WaCF+VDsCkDaSF2gZlW5ED8FtpZTAWDGzQXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gw3wKskKG6bKducS4lnlEsq7Yfb8463RtCw4esfHgehwwICHZ/+tZ0uQ2Hx823irwh5ryNObWaJf3dZCUBo7ZQh3Qu7x8w9RZdHuVmedP9wwB5/c6+5TcjAvEwrFeTD40Pe/rWJut4Zh8SFyyCI6WSqulYg/AM3c7rmU5cAcmJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X4OWjvzO; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso1422590276.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 14:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715288618; x=1715893418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IfAWkFXhjwD2b7MDcPpPbsLosZhZSildjQMHcbXjWw=;
        b=X4OWjvzOD5TuDBjEWXbhsHIXQEli10/2uPFniLDv/pHR9F6HJrhUfWrTP4yw/fA9VR
         TlEv12op/xb9KlPqtbsrgn/Y9sD+Kx/g5Ro95wUmdPpGCEiF2Vb7ojjG0rcSqr851oNi
         Bl9skZma5hYn7iGvtgn2177YsL00VJqge2i7PRW5F1HBQxURljwTkjktETp9JOzaFOWB
         DrfehpnNlqe6sLBXXdjjLxBUbeNrjeJaYUleVtGx7K86Uloo6DMJVxvXagQnNE4yjpxh
         JMgP18dmH2son6KiOR8jcttGwL8AV8147waQ3tAxYe84qutjHjk9cbrtv78+1SVBrmHy
         6TyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715288618; x=1715893418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+IfAWkFXhjwD2b7MDcPpPbsLosZhZSildjQMHcbXjWw=;
        b=QSSkBkZlwb2mN3ijlxLWvjb20HVN7AGPF/PTMMXOAnuOkRxATJFwNdtKMmjwc14vSA
         /WYMfg8UhDM+hC9nGP0DNYDszTOwpyFxvF5XbgO9Rljozj1Em2ZVBvRxlHz0M9JFmKb2
         77mnG0jqNnRZc6IezWhUIAXQi+ljemm85+VlJywW5sFII268t1ok6IUkE6fBOKw3NR2S
         j8Z9YGr4wnfIf76nNu43Lu2T2iiYAmcv03l346ciR0I1t6JiFT2KjxW7/OMG/v3bwKbq
         G537ReD67649S3fHygTi2HRLwqp/nkwhOpOw8LTCyLVBNz+7fWIDoRpTvKn5Cf7ESP5W
         2tcA==
X-Forwarded-Encrypted: i=1; AJvYcCWNVr71EN9VGJ6M/3zq1sAft79NPYTKQJD2maIqVo/bEo2gqZUBfcuZSarryZWhGx4POCVyqCL0tqOioeQZ4Ktb8pHGEB5l2Vmmqm0b
X-Gm-Message-State: AOJu0YyFk9fg/Mtns3gh+gLKK3n5ovHlFhPtGgR9akgMeh94dogsyITS
	1xsPPnDJQnriRXVlpSyXmaPxnQZ5tsvH262qPZUkjIs/JSmaovzL6wkgFMJDx5c4r6w4DUtlXac
	7Exue4pTDIF6ilPkETR0UZB/oXVbAYAG9/D1H
X-Google-Smtp-Source: AGHT+IHi4meLqolcqBUgsfW8E+aCr6OvcC0n5md5fXsCW9cwP0FNY/tME/MzPUie8mstiTIWEnHBYgpv6DCUutU9+jM=
X-Received: by 2002:a5b:688:0:b0:de4:5cfe:855a with SMTP id
 3f1490d57ef6-dee4f1bc28emr739029276.33.1715288618153; Thu, 09 May 2024
 14:03:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507013502.3095744-1-tjmercier@google.com> <2125dda3-829c-4113-988c-3c5861127f97@intel.com>
In-Reply-To: <2125dda3-829c-4113-988c-3c5861127f97@intel.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 9 May 2024 14:03:26 -0700
Message-ID: <CABdmKX3OpiFup4AtEJ+qfBnO6_5KjT=d5yQJtkMptvXPJRKX0A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] doc: swiotlb: iommu/dma: Clarify swiotlb=force
 option applies only to dma-direct
To: Dave Hansen <dave.hansen@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, petr@tesarici.cz, mhklinux@outlook.com, 
	robin.murphy@arm.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 1:18=E2=80=AFPM Dave Hansen <dave.hansen@intel.com> =
wrote:
>
> So, I know get_maintainer.pl doesn't work great for files that are used
> by a lot of subsystems, but it doesn't seem _super_ hard to find
> relevant maintainers for this stuff.
>
> There are many IOMMU and swiotlb folks in MAINTAINERS who aren't cc'd
> here.  I'd be great to get an ack from those folks.
> iommu@lists.linux.dev seems to pop up pretty frequently.
>
> I'd also have zero objections to a patch to:
>
>         Documentation/arch/x86/x86_64/boot-options.rst
>
> that goes through another tree.

Sorry about that. I did manually CC iommu@lists.linux.dev on the
original version of this patch after a thread [1] on this topic on the
iommu list, but I neglected to manually add it for this v2. There will
be a v3 for the second patch, so I'll make sure to include the iommu
list then.

[1] https://lore.kernel.org/all/CABdmKX1HdXccWp9chz-Y_-Hh5TPry-4WRcVf4fUXKV=
=3DOg3dVTg@mail.gmail.com/

