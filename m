Return-Path: <linux-kernel+bounces-528147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4268EA4142B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 04:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D61D3A4874
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 03:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02161A9B28;
	Mon, 24 Feb 2025 03:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QG3Q4vOR"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457431A5BAF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 03:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740368587; cv=none; b=i4dJklpP46j9gLI94pM45lT0kl0hh48pwG/2ULleHevCnbfhy9YpfklheLDWxxQla5M3K5pE09WhqkTcT306J9YjwiORzGvTkEXz1BCE2wJQKkdXAEJmnERKv9XKKLNzF7/kgpn8ZWUvdL3QHyWszNX1KHVCmfrh5uHk/YheHvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740368587; c=relaxed/simple;
	bh=2brXvbSRhDKTumjWNgVlgfbHMSBx/NsSwwhkUiBUAi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DsK78xHxZv93C+CmN+4UCPLKwV5MM9ktrXmJbknnY7vIi/b1w0p6OTx9xMZN24Qlh4IqG3UCdUulXR8DIEktj8Nez5xwstyxWhazEQvwxBSDDBtz4uARQjd91+PXdASvAl/B+jrNCzkKSL7SEPMVrQREaq1EQnDioXMG1hnqDlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QG3Q4vOR; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2a8690dcb35so928295fac.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 19:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740368583; x=1740973383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWmyrx22D4RyR4VCDSIk++RqfnUE4ZQz7ryWsBjsG1U=;
        b=QG3Q4vORUS7dpe5ZAdbJjcYmcXpP4EgNcm1ycatcaQM7bMC69jNebVVMCRfkJcUlAF
         d7n2LEQQfj+ZgS/QGMHMoKnexOsGcjiHOqIVFnRMdFrrMW5MY4FZl00HS98l5X1ZAfEJ
         77hZ8SB0Q1D3yz5mdAuDtAFhYrtZrxVw49OsCM5MIS97BgOVC1ieWG5aLrY5xMgiS3MI
         xiWxUWxFyFwdz0pyJp4+QJaaYeTTMkBhspFGiVZ50qiKM0vZlwIkjLiWh1jtTf1tXqMr
         Lo2kppAcQAsXCyxqF5aHxgxFHk+awGAZVRUUYWbEa69zX8POuFOTYVqpV2mZaJTkWtt/
         PT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740368583; x=1740973383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWmyrx22D4RyR4VCDSIk++RqfnUE4ZQz7ryWsBjsG1U=;
        b=LgCpbxcWFRh5ro0oLjXeeiyUrMZpJesaZI+4U2UMR3hVn7LHe+e2BQTg0f4RWU/zM7
         6jH9Av5Ed0cX1s7JunksimhYJlNtELLVUA55xWnRQhTZoCYO2z6z2HDU7g0zPHsOApQD
         qwnbSx6jXMT4cBO9dfRL6NNrOgS6sc+mjSnCokweDn+K7ZG9uQsOh9SEnh5e1sTFljtw
         qT+YbMx+pAbEvSTsADwOsQWiKJXDnbU1IwjzdegE8xjcg8mqzT0upP1UJvyY2k4EXVJI
         aPKsoDFnfIKGrLS2cMMCb1VBIfEvxdDXOPSQLQTXDEpmR+oGA2I1u4RLl8U9gyVPdOzK
         pQwA==
X-Forwarded-Encrypted: i=1; AJvYcCVZlBDZB5nZQ/JBBu6NG+J64vdNNMFLZiP7uR2MvxuQdthaZ0gLEVSGBYU2SiK5bCe+V4a85vC+D3wqUfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoAx4USYkMJzsqmH3aSlnH57wkpZM2xnQpQxQbnYe1+5QgmKVy
	nBypVzDk6nfbRBkQj+kLkyc0UzJque7XejiwNO4vEgUabR36skq+57pd/jUnlwTN5MPYpoHf+k9
	Vqn8vxFconA9CVkPjd27yx2AoM72dtPwATmiTkoVeBXAZbrpaJf+ukg==
X-Gm-Gg: ASbGncvSOud4lcFaHL9QkDW6LtfPQ/WOzShQiksRDDNE6g5Jbh/EkdRIYBAflME1UfF
	bNtk8uOzX/UuOS7xHuqtDReLpcTpB3OViAmQv22HzQGU3DwKKpgTqdYAw6WpyuFDdUV8JAJMoId
	UIE7T+BHQzOQ==
X-Google-Smtp-Source: AGHT+IGv99EkJ7MMHfoGHA1P2RRAdF3geIY8k8jLdJmdUqKUmwxzj8cPjmtTfekpYtzSV93z/z3S2U1jmWSLvf+eA2Q=
X-Received: by 2002:a05:6871:d104:b0:29e:5c94:5b10 with SMTP id
 586e51a60fabf-2bd50fa5b9cmr9369042fac.34.1740368583214; Sun, 23 Feb 2025
 19:43:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220101511.37602-1-cuiyunhui@bytedance.com> <622aa790-6560-4be9-bfb4-736809a249bc@linux.intel.com>
In-Reply-To: <622aa790-6560-4be9-bfb4-736809a249bc@linux.intel.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 24 Feb 2025 11:42:52 +0800
X-Gm-Features: AWEUYZnZAgZWgpT1jq430siBo66BfD-b8aN1SXFV2Q6cuPz2z7re5pNq-FV4LMY
Message-ID: <CAEEQ3wm019hEGK=2i+2KF7LVcWr8y9N2uGzF65pfQLurroa+YA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] iommu/vt-d: fix system hang on reboot -f
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: dwmw2@infradead.org, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Baolu,

On Mon, Feb 24, 2025 at 9:06=E2=80=AFAM Baolu Lu <baolu.lu@linux.intel.com>=
 wrote:
>
> On 2/20/25 18:15, Yunhui Cui wrote:
> > When entering intel_iommu_shutdown, system interrupts are disabled,
> > and the reboot process might be scheduled out by down_write(). If the
> > scheduled process does not yield (e.g., while(1)), the system will hang=
.
> >
> > Signed-off-by: Yunhui Cui<cuiyunhui@bytedance.com>
> > ---
> >   drivers/iommu/intel/iommu.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index cc46098f875b..76a1d83b46bf 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -2871,7 +2871,8 @@ void intel_iommu_shutdown(void)
> >       if (no_iommu || dmar_disabled)
> >               return;
> >
> > -     down_write(&dmar_global_lock);
> > +     if (!down_write_trylock(&dmar_global_lock))
> > +             return;
>
> If system interrupts are disabled here, locking is unnecessary. Hotplug
> operations depend on interrupt events, so it's better to remove the
> lock. The shutdown helper then appears like this:

Currently, intel_iommu_shutdown() is only called by
native_machine_shutdown(). The down_write/up operations can be
removed. Even if there's a hardware access error, IOMMU_WAIT_OP() will
trigger a panic().

>
> void intel_iommu_shutdown(void)
> {
>          struct dmar_drhd_unit *drhd;
>          struct intel_iommu *iommu =3D NULL;
>
>          if (no_iommu || dmar_disabled)
>                  return;
>
>          /*
>           * System interrupts are disabled when it reaches here. Locking
>           * is unnecessary when iterating the IOMMU list.
>           */
>          list_for_each_entry(drhd, &dmar_drhd_units, list) {
>                  if (drhd->ignored)
>                          continue;
>
>                  iommu =3D drhd->iommu;
>                  /* Disable PMRs explicitly here. */
>                  iommu_disable_protect_mem_regions(iommu);
>                  iommu_disable_translation(iommu);
>          }
> }
>
> Does it work for you?
Yes.

>
> Thanks,
> baolu

Thanks,
Yunhui

