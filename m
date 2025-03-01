Return-Path: <linux-kernel+bounces-539779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43954A4A873
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 05:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0B818997C2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 04:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420A91AF4E9;
	Sat,  1 Mar 2025 04:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dqxEFTN4"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87BB1519BE
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 04:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740802575; cv=none; b=EHB5H82C9gHXfUmI/fi0Lghz/49sW3Dv8PpNyE9JvOngKh8MAxLQjNydosyDYLCOEYsoZMA9otcUB+Ej2SOy50Ig+vsTLTTUSPRey873/DXmS7XfrZMn7nWzqTYaYxrnJAwG+qVUipTwUUDno3X4t05udpu9FS7c0Pp8R4MrLpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740802575; c=relaxed/simple;
	bh=nRJXVNbZUpNIBtt8TFs13UDH3fN+Tw1tbm1ZW4YHs/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUqVxM491GwLRhwGx0SYyUmUr8cilM8zFEKc6XUcT9tUSxCztOGMrC99yxS04RUmp60X7A7Ou5W2gsuHSCd4nmECbB56V20pLwDGe3X/huNqfuF2W+CdkEm//Rv17BgucW3U0GBe4DVTRI6mVEL/cEFJr8KgWcvyr/mw64IUO9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dqxEFTN4; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54298ec925bso4138423e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 20:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740802572; x=1741407372; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nRJXVNbZUpNIBtt8TFs13UDH3fN+Tw1tbm1ZW4YHs/4=;
        b=dqxEFTN4T+LXT8b/WGkWy3B6mb3egi21CVMTXjvbd8GUrkJEp4RsQLMXzwFjABlnys
         EyWGxaN8RxwDJgmT4Ho4J9wQdn5NhnLVV/r6vvH21ehUIR1OdbpsdWZYh9g6Zi+9qQp+
         LYUBFiMTHCdALkboNfGsDFdVXQRS5dZg7VaS4v8L7prSDQbwV6Mg58oFUfDhv0PUyNLl
         8R3nmWcgPsJWIDG/19gPv0zOU5YJwwMDVbJRXQi0GChfB8BxkFjNiDnZzaR48PIQN5zG
         OFhGRLmJiA5uyelk2i5G8lfVUjLjyARxh65oE9aanbQjYy0WMzwgMYwcrkSGtSeedAGo
         KwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740802572; x=1741407372;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nRJXVNbZUpNIBtt8TFs13UDH3fN+Tw1tbm1ZW4YHs/4=;
        b=nHADhTFrbSQgJBhVkjQhUQXDRHnuFkgEIQVK62gTQA0EtNavadJ4fE3B9HLkyrlA2o
         Fdz6wLcc5jy9OapKIjECrPnetftQlwdn5lI1nSjCTvnQtAU35jTkiB3f4+ysR0Th4hdK
         qgpBQ2QB34TMiX6+Hf/Z7OGNfYktMp2+KNMXsvOoFxR2hovnvupgkAJW2yQuh/CgImxK
         4lyxCFQBoB6HRf8hshbAcI16K8rK43ztJfOXEZkRaEoyh7muuC3Jra2Yu3l8vpzU8oQZ
         gEk3dpALRt0CXmcyLoe/FuJdonl64ghBB1zyUNhN35WhQFPVfuRAWtfPC9O5nLIa3TI6
         pu1A==
X-Forwarded-Encrypted: i=1; AJvYcCX7uwwaCMAwniN1B8AGgSP6p09m2+45YxvJPsBnD7IOCaJog1auSl+Q0gF+m34gjcbCPagcosbwmYov5KM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZhfNxK4usD1uGfB3yAXDGS3wdlywGS8CK8S9pOxRcIrfl71WH
	SRDcjz+w0h86xUFAceEopsfPh228Lua9dv0hs+SC+PII9JbLfEvQxcxiavReAVh7oZfQgtJPKf9
	6dElv85sH9DZOYsmjmJ+IOLDqVk6zKGrR0xYTrUAgElUkb37R+//xj9Nt
X-Gm-Gg: ASbGnct4plmNx0HKvs1P2tgT/sd964zUyqmv/mWy5xtHGwA8mLWULUhtVMlwkFhzCkX
	70xs4/fSfpi5WHf6R1qxgOtMuRTnh3tMjw27vcYT+vPCSqdBw/kqLt9UpaTuOIyZgv5tffkF2d7
	OYnOpV81yvGlmJYRNpD/QOuMDkl/xXixE=
X-Google-Smtp-Source: AGHT+IFP5aCHULz6zpIiPlJszPYhhIKQa4bjgAfv6H6nwuK5koq1iQ2nHbNDaxSV+n8l900FUXdJNFmIzAGeKlhCAx4=
X-Received: by 2002:a05:6512:693:b0:545:b28:2fa9 with SMTP id
 2adb3069b0e04-5494c122af7mr2774025e87.16.1740802571668; Fri, 28 Feb 2025
 20:16:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740504232.git.nicolinc@nvidia.com>
In-Reply-To: <cover.1740504232.git.nicolinc@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Sat, 1 Mar 2025 12:16:00 +0800
X-Gm-Features: AQ5f1Jq1aPPNEUtuYw2bvAu1XDeZv-PKWUyrHeAmpxtPMb0nHo1DtYawDISk28E
Message-ID: <CABQgh9FYqzoUxjR246QBPGW9jqngK1JpgfACvBTLTHq-mBBCJg@mail.gmail.com>
Subject: Re: [PATCH v8 00/14] iommufd: Add vIOMMU infrastructure (Part-3: vEVENTQ)
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org, 
	joro@8bytes.org, suravee.suthikulpanit@amd.com, robin.murphy@arm.com, 
	dwmw2@infradead.org, baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org, 
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com, smostafa@google.com, 
	ddutile@redhat.com, yi.l.liu@intel.com, praan@google.com, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Feb 2025 at 01:33, Nicolin Chen <nicolinc@nvidia.com> wrote:
>
> As the vIOMMU infrastructure series part-3, this introduces a new vEVENTQ
> object. The existing FAULT object provides a nice notification pathway to
> the user space with a queue already, so let vEVENTQ reuse that.
>
> Mimicing the HWPT structure, add a common EVENTQ structure to support its
> derivatives: IOMMUFD_OBJ_FAULT (existing) and IOMMUFD_OBJ_VEVENTQ (new).
>
> An IOMMUFD_CMD_VEVENTQ_ALLOC is introduced to allocate vEVENTQ object for
> vIOMMUs. One vIOMMU can have multiple vEVENTQs in different types but can
> not support multiple vEVENTQs in the same type.
>
> The forwarding part is fairly simple but might need to replace a physical
> device ID with a virtual device ID in a driver-level event data structure.
> So, this also adds some helpers for drivers to use.
>
> As usual, this series comes with the selftest coverage for this new ioctl
> and with a real world use case in the ARM SMMUv3 driver.
>
> This is on Github:
> https://github.com/nicolinc/iommufd/commits/iommufd_veventq-v8
> Paring QEMU branch for testing:
> https://github.com/nicolinc/qemu/commits/wip/for_iommufd_veventq-v8

Thanks Nico

Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>

After rebase on your branch
https://github.com/Linaro/linux-kernel-warpdrive/tree/iommufd_veventq-v8
https://github.com/Linaro/qemu/tree/for_iommufd_veventq-v8

Tested with multi-device in guests, with io page faults happen.

Thanks

