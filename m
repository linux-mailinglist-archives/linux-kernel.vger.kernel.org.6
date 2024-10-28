Return-Path: <linux-kernel+bounces-385211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D629B340D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E97FD1C21B20
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E521DE2B1;
	Mon, 28 Oct 2024 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MOsYWneh"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25C01DD89F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730127233; cv=none; b=rbDA6BMMsIdT3YgIqdyBqBuUXoNqV/rQrCgM8MaoWRvbjxWou/kccL70/Ai+OefzDGQS64Jk9x/zhlPCe0Lc8eLjQEA+gBdiEeR3HiKmQGP+ZKADuMvXRCaKMsNwcdw70TVp97+yv5A4wXjP450k6kw9zIEj7vBq6Q3CVpiSEaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730127233; c=relaxed/simple;
	bh=tYb/zBUosi1Aw03l7Ek5wmBbG3dG3J1OV92E6B3BlZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HT1sPMIHigruzu7Tyx5OUQ3kopUrQfQzaBcQocnjMb10hBKLT2cz5PqMeuO3xuOSJpTwimKTd3i5/fxc871Het6MNkqfupHmow3DyYhkOOnxwbfKfFxad0IfGv9bIXtRISIpgZGHR2vRrWumm9agruKZFdalS0DILbRVdfZVf4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MOsYWneh; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539f1292a9bso5115496e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730127230; x=1730732030; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tYb/zBUosi1Aw03l7Ek5wmBbG3dG3J1OV92E6B3BlZg=;
        b=MOsYWnehb6VWf8PGsIvVUn69xF51tB0HmDEo/UQ2+SwqGQYdZRB1C4iEPBWN0iyiJY
         P2ehIdPgEZJCkfjrJpQJlgwECUAZjuspEFikSZzovExv1gz8ao9SkAIe+oJWcNJi91Uq
         TDWrOyFbwRRV4cZcmdBm0/UWJ7ofQiZaZ/DyWuV5iNolFez6ysj7uaT2CA6K/ruhsb/1
         7mL8sQO6Z9q8G4rs1EJXw1zzZiJ6YAjHQe0nNOxgupCUTVVHWIBfz1dApWYN5IJn+kaG
         2yeolHTZzDT4zRRd2CDXFCJtdxAXoCn6176WODmtLE3CxPeb5BLomdCT90SRscGtNeiK
         Lg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730127230; x=1730732030;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tYb/zBUosi1Aw03l7Ek5wmBbG3dG3J1OV92E6B3BlZg=;
        b=YIlqfLpYgBEdeaX2lUZfyGS0I1Iih+OhsqtK1WwqNc58mtrCbwHPFm42DUEg1omM1N
         avPio9yWYDez0XWezH+syENGc8AvRhB3d1XrcroSf0R+5m0yiaowJ0356d+zlKApX3r/
         7RG+H0zGBPDnyAqkXV/xZMCj7ZAAQ6jG5ZIvf24gwBj+FwapfafbJcWeET8udXlSSHPQ
         sqGrztWA2N5Lzn7vUVyl7ViCyVSZeSGHAg/ReqGCctVbFvZvngZkg/0cjx2uYRTDaPo5
         GyL7LgUgRMB8dVpJfxjhScVmN3jbKaPhTSzl3Q3rlAJLRQQkihb8NAqLt8zm18RbcQ52
         80Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWmLpbNlQNT/qcyEVc06AOYcFvJE0gh7n709f+gZADBhoLXSHMksl4HYMbcCpy8BC21aqR8xaL1dPQmXQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTO1dIGsWQPcfID6lEr8Vw5p0cVhYcr6m8TdEe+6uNIfuwCOWk
	fUG0blAtujYSQerXTS0v01tKbGoduC2PdLV/7UynVx1xfbx5HxZFsEvUWtV1KanzqbCFQWS9z1j
	kxAuDoDAINRI3vcrGeyb4dTcOqnWdXAYcIe5iUz5mZ2PxuUSrPRSmDOn5fjH6UQ==
X-Google-Smtp-Source: AGHT+IGlKQWc3SNm51s3PmWaJ7k8IkmWwj+g1zwTCjME9I3N35fBxQXDjWPZqSRQvbi+ZoURs9MmaNgH4mwrA6FxW5g=
X-Received: by 2002:a05:6512:1590:b0:539:f554:78ac with SMTP id
 2adb3069b0e04-53b348b9125mr3453985e87.9.1730127229738; Mon, 28 Oct 2024
 07:53:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729897352.git.nicolinc@nvidia.com> <4f5ed9d75c23a503ffe672a85cf9010569652794.1729897352.git.nicolinc@nvidia.com>
 <CABQgh9Gkt5tsw+wr_=WeA+m=Kz2xY5Z7aSBNhHCvBG2r=7O3TQ@mail.gmail.com>
In-Reply-To: <CABQgh9Gkt5tsw+wr_=WeA+m=Kz2xY5Z7aSBNhHCvBG2r=7O3TQ@mail.gmail.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Mon, 28 Oct 2024 22:53:38 +0800
Message-ID: <CABQgh9EgXsyHDzZHK2FMuUw-eu9zeczyMGLTUjS3AKYUHKwwDg@mail.gmail.com>
Subject: Re: [PATCH v5 06/13] iommufd: Allow pt_id to carry viommu_id for IOMMU_HWPT_ALLOC
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

On Mon, 28 Oct 2024 at 11:24, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:

> By the way, has qemu changed compared with v3?
> I still got a hardware error in this version, in check

Found iommufd_viommu_p2-v5 misses some patches,
Simply tested ok with iommufd_viommu_p2-v5-with-rmr, (with some hacks)

Thanks

