Return-Path: <linux-kernel+bounces-349101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E91198F0E4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5F4281D41
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616E519CC3C;
	Thu,  3 Oct 2024 13:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IZ5XEAIw"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2723B1547DC
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727963928; cv=none; b=rQqp8xy8WcVBp1wbdtCMRGTWJspFxCBXmyTd8dOxtnm/uQUQ3TFz8CwhA/xNDRiNqsiQUzM3r+2OLBxnCufO8mAmJg3ywr5E44yiKgrqk0ts7EGQ60LWL5PoGBvsTAScUG+unXmNAfVLBgC1MjEUcCuBcCvrYpfUSOubdESbAc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727963928; c=relaxed/simple;
	bh=hH98li1flmtmsrcyn5hXWF3rH2qxp5zxvrFxRxvO21U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HDUmYrXarTIV2OBx8J/1nfYP1t3rW7VLWUYx45uT/e5WdzalfQxM2p6BPnfcgIz2udpAUWL1kvNrXfnc69LaK3VDNx9ltxwO1N/WS6xOMLSFJTYksj6/2qvT+/qZvGx7VXbgTCrbk1EpztmZ/3aClr+VZfEsrRlRZLVeZ6Lttw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IZ5XEAIw; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fad8337aa4so13005971fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 06:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727963925; x=1728568725; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=urLJW6NECL1ucqye5UhOxKoHxkMcZO/OrugWN1Z1yvE=;
        b=IZ5XEAIwbZKyEf8Vze24G5tZ8hxrBnSnBWjp7ngi2g7QQTB7duYnEK2OEAS3uqpcJY
         zqWfp7ODWtlfkvIlAOsmUKJpApHMy5AB0MNVyXWyei3CTqeBFROW/yy6M2Ee2JNokMzy
         /C7J+ROJQ6J+gxkwF0IuKHe+tunPPDx9fbr9B5jYOJvFcLFpVyQbsBmLKMNySMvDpTSO
         1NXf37SWWGk7jtmx9NzF86FSOwWMgBSjEz1GLP5noXfATv+bpPH4nYKANtExhYvLTnkK
         dFFYyGTrh6Uff0q4dMc7VPw6pyr8P7unqxgr4BQ7WAtyfkP/bEYZRnJh1nqIZVHxdLEe
         RMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727963925; x=1728568725;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=urLJW6NECL1ucqye5UhOxKoHxkMcZO/OrugWN1Z1yvE=;
        b=DiZtkMQeIrCEFGMuyT15vA4lgAJmD8+BQvdWbdbYJgni69x1+YOoiUBk/DUwhaK4Oq
         TqwgnloAkTDU8CWj2H886XmrwsFOrHkRG+vfUuhGBPyrM+Rzt+eLhdztD7uJ4GePGlvY
         c/396IAnmvXIbAiTeh8DEFQKcn6/bm3lK0mciIV2ZQAZ/FJp62qGJGkWgeb6+xnK9Pjw
         1JKNBWpDMxpb9XTglknvwfhPwCvEsCEEO3bvqJrL03EMXPXI0jlfRp1LaDjQFjm8p6+P
         6r6pNQygRyB6bEABNCr9S3vJfSCl0Z5axydfK4m1Tt5BVMS5p005L421O85ZuGEGSb+3
         WZKw==
X-Forwarded-Encrypted: i=1; AJvYcCV9tO+Nrdq5xQD2s1JJs/BETsymsPnB1X5RF+ueiqq+qGbQGizhIKlGhzAyGgM+wSIZR5waaQddc1ohi0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz20sNfMG5yyxLXhumaeBaye5zxWdK3+BhVttaDdckZZC7zxQ1Y
	lkgAz/Z0TCqonRuHyhknsLEOW6IzW7jq5NyjTDMBHH0gW4f2NPRFEIZoR3eQ+bG5TX9u7byHib5
	C9GLaYyHhpPplRorCZevNMjJ01jWphnRRipgMUA==
X-Google-Smtp-Source: AGHT+IGblBPy6kBOpO3xGMhQweMvM2XpmVtiWZNUxokmfJKJqKLFp3SSOen5N/4deNadbfpJumzlOeeP0tfYdvrs/WM=
X-Received: by 2002:a2e:9215:0:b0:2f3:f358:8657 with SMTP id
 38308e7fff4ca-2fae10a6b58mr37979671fa.44.1727963925258; Thu, 03 Oct 2024
 06:58:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812072811.9737-1-baolu.lu@linux.intel.com>
 <ZvrUfoTM6s/jv9Nv@p14s> <20241001133510.GD1365916@nvidia.com>
In-Reply-To: <20241001133510.GD1365916@nvidia.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Thu, 3 Oct 2024 07:58:33 -0600
Message-ID: <CANLsYkyUMrLmPMaKH8sGHrB1zXCjXbyCje0zrsqFs68JT+NGKg@mail.gmail.com>
Subject: Re: [PATCH 1/1] remoteproc: Use iommu_paging_domain_alloc()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Bjorn Andersson <andersson@kernel.org>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, linux-remoteproc@vger.kernel.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Oct 2024 at 07:35, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Mon, Sep 30, 2024 at 10:40:30AM -0600, Mathieu Poirier wrote:
> > On Mon, Aug 12, 2024 at 03:28:11PM +0800, Lu Baolu wrote:
> > > An iommu domain is allocated in rproc_enable_iommu() and is attached to
> > > rproc->dev.parent in the same function.
> > >
> > > Use iommu_paging_domain_alloc() to make it explicit.
> > >
> > > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > > Link: https://lore.kernel.org/r/20240610085555.88197-13-baolu.lu@linux.intel.com
> > > ---
> > >  drivers/remoteproc/remoteproc_core.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> >
> > I have applied this patch.
>
> It is a bit late now. Can we run the stragglers through the iommu
> tree? We want to put dependent patches on top of this.
>

Sure, we can do that:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Please send me a pull request so that I can also carry the patch in my tree.

