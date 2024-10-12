Return-Path: <linux-kernel+bounces-362053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFD899B05F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 05:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1384628502E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 03:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FD684E0D;
	Sat, 12 Oct 2024 03:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J47lQwCx"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706DF83A09
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 03:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728702744; cv=none; b=LNMgJY7+IPiKU9aqb44+7g2BxFflbd9R7aCNkE3IM2eGpPqU7i0+PXQRvXXw8R1qJMlfxMs3eoW7Y3ByCecsx0ui6NBAgTJ2QY3FtXgPCI+Up3e6tkCfWF79Fz2UKdgMQD5BIW3b5ZPee2kNrzlp+Ndgs7m7APkw3vdVCNNXnMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728702744; c=relaxed/simple;
	bh=ZPl0vRIjZy6Q1TLJkMAfmvzvlUnFAH8cE6wBRsWA6AY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlylSqG+BhR4LGrDzuuyBZOAy35kLCv8LU64TPNHC9gYnHAo/hWoUywfrjxLDyrXraezeZEEHoND4FAiaL7sZo+b7/PiSVytDTLVsLPBU4p91X9MT9LMaYnmMYScR8var4f6XBAjswLvIfzNFOgEYz/uJEE/xSbB36+mPtVboXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J47lQwCx; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5399041167cso4079385e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 20:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728702740; x=1729307540; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=skhRjSsjRWRBkBJSR7ncRA8S1Q1nCZnYe3M18zuYqQk=;
        b=J47lQwCx+4XUsSAE/vwmhj5DOBoH5ZYp5nTV34E3yYMJX3BTIL5SrCSfLwZkReBd5r
         ItMKZCcE6GAuECUdcas9MBaWnbZNn3uKm1JSF4BQq3ddpk3gIb7zY0pZGmu7ndeO1Hrv
         xC8auQvL1DKq546o0+YjrCrRIcguPMSsoWorZ/va3YflSqtDmkZK96BVhy/z7KhOBZA+
         X09rlMgXCnzZgy3BZ3D3//cy5gAro5r64O0nb9qXUuJvC3kqV1G4FQEaebgOKxWcdEa5
         OIE76IE0vTUeaqRsDnWWPz+DddA/2kQPIIG4f8x3TdC22EY7MuX+a8w7U8zKhuNV6W+g
         L2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728702740; x=1729307540;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=skhRjSsjRWRBkBJSR7ncRA8S1Q1nCZnYe3M18zuYqQk=;
        b=C8NVGoKdViRD35ZbWCI4LG9E0u0VfoUV0GRJThffPGywxJbG+J7qN4rHa7R1zLPVwn
         v2ts4WREULSTBsoM8XWKtzp6zmfVjy9yahwKAnCSzn5qs4VDLa/XoxcjBARCUha2rnp+
         E0UN547MpcP3w6W2l2naxk8rv3R8fMdD8NEJbX1xutV9tdfI0JVGa3y69kXN5m83vB9+
         tIFBHY7EFz1pYICSVpxzX7/72GWDfqs32yeNRHjnVO4ALrrPmiRhuMtQrzK7cp0yIPsD
         ffpppWFoEAPjuwWVROWfVOT81Vqqg33+4sM/T1o6PHHnuRE89htKM14PqeGEDEinyIEw
         gloA==
X-Forwarded-Encrypted: i=1; AJvYcCU6PLWoyKgvslCPNizyuys8sic1d6aBO2MwPGdeJvRFW9tAc9BAXos38GIfOvxwKnngCt8gi3TYyGznljQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyOkb4L/7kwngGOptqxRqx/XCzGGq74K+Ulm3ZcEY6kolDCdSs
	JSbb0JcU2tlCRNwlENGCy4iKOdqOuZ4Dy7lvrA6g/STR1I0cad9CshEUiOWVvAQ4elS+WuVGUsZ
	lU5ZXDieXGwVDm640oyJW465E2uM048cfCNVlBA==
X-Google-Smtp-Source: AGHT+IESbkfK9x0RkC/zr+X/5OJJGUEqu4Sl+Zaum+icoDlotDKEsytnJ09AslW1W0e34iL7p8s2SZSLipO7yFwMhZw=
X-Received: by 2002:a05:6512:b85:b0:539:936c:9845 with SMTP id
 2adb3069b0e04-539e571c924mr863040e87.37.1728702740436; Fri, 11 Oct 2024
 20:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728491532.git.nicolinc@nvidia.com> <d714a9d107696194cc63e5f6c2b6bf5877b37f68.1728491532.git.nicolinc@nvidia.com>
In-Reply-To: <d714a9d107696194cc63e5f6c2b6bf5877b37f68.1728491532.git.nicolinc@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Sat, 12 Oct 2024 11:12:09 +0800
Message-ID: <CABQgh9E1rfA8i+x+6VRgyFb41n+n_F6-gqnT-TfqLqVeYaYmew@mail.gmail.com>
Subject: Re: [PATCH v3 14/16] iommu/arm-smmu-v3: Add arm_vsmmu_cache_invalidate
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, will@kernel.org, joro@8bytes.org, 
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com, dwmw2@infradead.org, 
	baolu.lu@linux.intel.com, shuah@kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com, 
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com, 
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com, yi.l.liu@intel.com, 
	aik@amd.com, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Oct 2024 at 00:44, Nicolin Chen <nicolinc@nvidia.com> wrote:
>
> Implement the vIOMMU's cache_invalidate op for user space to invalidate the
> IOTLB entries, Device ATS and CD entries that are still cached by hardware.
>
> Add struct iommu_viommu_arm_smmuv3_invalidate defining invalidation entries
> that are simply in the native format of a 128-bit TLBI command. Scan those
> commands against the permitted command list and fix their VMID/SID fields.
>
> Co-developed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   5 +
>  include/uapi/linux/iommufd.h                  |  24 ++++
>  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 131 +++++++++++++++++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   6 +-
>  4 files changed, 162 insertions(+), 4 deletions(-)
>

> +static int
> +arm_vsmmu_convert_user_cmd(struct arm_vsmmu *vsmmu,
> +                          struct iommu_viommu_arm_smmuv3_invalidate *cmd)
> +{
> +       cmd->cmd[0] = le64_to_cpu(cmd->cmd[0]);
> +       cmd->cmd[1] = le64_to_cpu(cmd->cmd[1]);
> +
> +       switch (cmd->cmd[0] & CMDQ_0_OP) {
> +       case CMDQ_OP_TLBI_NSNH_ALL:
> +               /* Convert to NH_ALL */
> +               cmd->cmd[0] = CMDQ_OP_TLBI_NH_ALL |
> +                             FIELD_PREP(CMDQ_TLBI_0_VMID, vsmmu->vmid);
> +               cmd->cmd[1] = 0;
> +               break;
> +       case CMDQ_OP_TLBI_NH_VA:
> +       case CMDQ_OP_TLBI_NH_VAA:
> +       case CMDQ_OP_TLBI_NH_ALL:
> +       case CMDQ_OP_TLBI_NH_ASID:
> +               cmd->cmd[0] &= ~CMDQ_TLBI_0_VMID;
> +               cmd->cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, vsmmu->vmid);
> +               break;
> +       case CMDQ_OP_ATC_INV:
> +       case CMDQ_OP_CFGI_CD:
> +       case CMDQ_OP_CFGI_CD_ALL:
> +               u32 sid, vsid = FIELD_GET(CMDQ_CFGI_0_SID, cmd->cmd[0]);

Here got build error

drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c:302:3: error: a
label can only be part of a statement and a declaration is not a
statement
  302 |   u32 sid, vsid = FIELD_GET(CMDQ_CFGI_0_SID, cmd->cmd[0]);
      |   ^~~

Need {} to include.
case CMDQ_OP_CFGI_CD_ALL: {
...
}

Thanks

