Return-Path: <linux-kernel+bounces-571543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEF4A6BEA0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 246D7171B73
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508E71C1ADB;
	Fri, 21 Mar 2025 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KuVwBnf2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735091D86C3
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742572093; cv=none; b=ReOGAYCoioPWHXRHPj86clU3CRqSAT1lSuQjlp0FnLpESnr3/pGS1hoU3cJfjvhsWPc8J4i7JrC4XzNaqW1Wuf2vqGWijtx34H9br7HyQwZtdwNo/YMkWIh0qHD2bowxcrPoNxR4i6VfkvKruorLuI2dICbhd8A+8NPrAqTpiAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742572093; c=relaxed/simple;
	bh=kvTFsr7ktgYszQ3wTsviG7c/3AR4BniICQsdxnGuuss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vCpsXIPwqXEbc7joFTm9f0DkxkRe6/CLnx95cIVggdl8qU31FRD33d0TuS850omTxLJRPWhOPBbGm5rUX9xbD1eYpO/xMnQS0h3cLgwSMtfDiRyMLGGISbJqjdZkZNnuG7AcC87oINRokUGvlPQA3rCGciEJkZ1vtJ8jngdu09c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KuVwBnf2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LATCvM011479
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ew2lMrVu7l0SPLG0kCLHLamFRIyU0cvwAG4t3O7Yn4g=; b=KuVwBnf2nE5dgPjG
	iu0Dt5aTEYsF242ofGUjG/G1tZoUkf5iok4yeVizpJeM03fVEnrkD1BgMm4Qtb6d
	S3jwK6BuxlDQCxas1P4zGZzLcw8YJpXmqIWPXMSjcyHe0W05XCYVL7lR5TsZna+Y
	78BcbGqdkT0LTtdDWr0cpuZ9Ubk8oUIutzZVxWdEIPQf+MEb2ZJtOrytLQV4k966
	8rnadosj7oXO4uKQa4r5Rjxd2qC6lctIPZ5Pl4M/psr9+JNXC1aYxiC6LHCzZq7w
	PTzSvvfVO4+6CE4LojnPskHDOxVZvStMDqcB76N5HJOcXFD9zeFrs7uA/qN9fMvD
	FgKxnQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45g15y6xef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:48:10 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-22647ff3cf5so28720125ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742572089; x=1743176889;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ew2lMrVu7l0SPLG0kCLHLamFRIyU0cvwAG4t3O7Yn4g=;
        b=BY7QjiXK9sLN5y+nSD+3GSbVM9VxE1LsFuMblfvS6lm5s63MkP5PVPJNsPcxlWeLTf
         4slQxvz166AUMJ0UAELvJNMvKPuI65zBC95wB57n5XR382boMoK43xqiQnflD3oJxbCz
         jYMKIS7NoMBRqpNPVFckVgUmlg+GHNfFg3uAC7X2Uh2cY3ejG37knguhgModcLaTotmZ
         o6zqZsFJuSJqR41BVz5nSZ8FmZ5RLMsS2fbNhGR7/TWKEpSSw/C0Z6h86VTLB9v39TS8
         QSk/iL2fX2TVIt8R5o9qZHUEfNqw7PeyEi+CPnLOQFgCOa/c21yOBB3PYpnwR52H8CYy
         RTVw==
X-Forwarded-Encrypted: i=1; AJvYcCUbEVi3KtJIVYzfIzdY8Fl4V4mV9uRzShlT31vIWkEp4MMOhq0bbj0XkPfp4VY6+UaVrO3fo525SvNmbVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUH74v7r9BUAjZ1JrTtUx3xQVtoXyuyYQZVI1d4Pvu6IQLDB23
	V6leb8fpDkoTHeuVz4zfeOk3oB1460SThwX3tXe0X1lMkKNq8NfXKP7fN4Oe6W9ylO+6IyXJPcO
	pE4NzE7yEyr0bPyAmWAXXPTh3XhyjXp7CWgdGhqfk+7gSZ5Lr/7bY+7ec+PCHyEs=
X-Gm-Gg: ASbGncv7vZMal48Z2JRw3rPEUOb7doBcyaX3nowFcj9Z8O4iqD1OOmmpl8SHak4+1GO
	3oPWHtrNO+9P0WHCuM4BKPjO7ibanwVTcBhLw5KV7oeQasFoTF5qdMBW+3oA4FyzaJV0U28sDxQ
	C/Ois8MdP4xsoVu4+HoXsZWmbaC0Ej11q0llxryOQIvSFHYRaIpoaQ9T5D04UInZRqTsxpMrEaY
	3UXy2gMlv1AHX0wvLHkpo8HV9nq4h16x0FwbWq/lJeV+uoI+Yw7zUYrkCHY1tLA4gPNNzH2tsyK
	0r/GtQQrQHIYU1umkPPz+S8xoqxtiaJ/y358w9EDz0rFD+rzyHMoD7vRKyUVleKRMA==
X-Received: by 2002:a17:902:e846:b0:225:abd2:5e39 with SMTP id d9443c01a7336-22780da5fc2mr56334535ad.30.1742572088489;
        Fri, 21 Mar 2025 08:48:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhXXKtU/apQYCTmprByHUMaLSD4Gh5qMihEs8CapzUY4ItUimuE0Rg0Pf+Wmofij6lJ9+HXg==
X-Received: by 2002:a17:902:e846:b0:225:abd2:5e39 with SMTP id d9443c01a7336-22780da5fc2mr56333985ad.30.1742572087896;
        Fri, 21 Mar 2025 08:48:07 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811baee4sm18356385ad.135.2025.03.21.08.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 08:48:07 -0700 (PDT)
Message-ID: <f96b313a-fa0d-45d6-b358-8d2da40a9b95@oss.qualcomm.com>
Date: Fri, 21 Mar 2025 09:48:04 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] accel/rocket: Add a new driver for Rockchip's NPU
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20250225-6-10-rocket-v2-0-d4dbcfafc141@tomeuvizoso.net>
 <20250225-6-10-rocket-v2-4-d4dbcfafc141@tomeuvizoso.net>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20250225-6-10-rocket-v2-4-d4dbcfafc141@tomeuvizoso.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: STatwxE9i2UZUNEnvRjii6EQLNyvYN19
X-Proofpoint-ORIG-GUID: STatwxE9i2UZUNEnvRjii6EQLNyvYN19
X-Authority-Analysis: v=2.4 cv=VaD3PEp9 c=1 sm=1 tr=0 ts=67dd8a3a cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=DISFzqtZAAAA:8 a=4oo6kz2Fa93MN3BI1icA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=aug85vrO5LANNmmtkfAW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210116

On 2/25/2025 12:55 AM, Tomeu Vizoso wrote:
>   
> diff --git a/Documentation/accel/rocket/index.rst b/Documentation/accel/rocket/index.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..ad33194dec0325d0dab362768fd349e8dc286970
> --- /dev/null
> +++ b/Documentation/accel/rocket/index.rst
> @@ -0,0 +1,19 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +=====================================
> + accel/rocket Rockchip NPU driver
> +=====================================
> +
> +The accel/rocket driver supports the Neural Processing Units (NPUs) inside some Rockchip SoCs such as the RK3588. Rockchip calls it RKNN and sometimes RKNPU.
> +
> +This NPU is closely based on the NVDLA IP released by NVIDIA as open hardware in 2018, along with open source kernel and userspace drivers.
> +
> +The frontend unit in Rockchip's NPU though is completely different from that in the open source IP, so this kernel driver is specific to Rockchip's version.
> +
> +The hardware is described in chapter 36 in the RK3588 TRM.
> +
> +This driver just powers the hardware on and off, allocates and maps buffers to the device and submits jobs to the frontend unit. Everything else is done in userspace, as a Gallium driver that is part of the Mesa3D project.

Nit: name the specific Gallium driver here?

> diff --git a/drivers/accel/rocket/Kconfig b/drivers/accel/rocket/Kconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..83a401129ab2dc2847ccc30c6364e8802f43648d
> --- /dev/null
> +++ b/drivers/accel/rocket/Kconfig
> @@ -0,0 +1,25 @@
> +# SPDX-License-Identifier: GPL-2.0

I'm curious, is there a specific reason for "GPL-2.0"?  This tag is 
depreciated and everywhere else in the accel subsystem "GPL-2.0-only" is 
used.

Same comment for the Makefile and everything else in this patch.

> +
> +config DRM_ACCEL_ROCKET
> +       tristate "Rocket (support for Rockchip NPUs)"
> +       depends on DRM
> +       depends on ARM64 || COMPILE_TEST
> +       depends on MMU
> +       select DRM_SCHED
> +       select IOMMU_SUPPORT
> +       select IOMMU_IO_PGTABLE_LPAE
> +       select DRM_GEM_SHMEM_HELPER
> +       help
> +	  Choose this option if you have a Rockchip SoC that contains a
> +	  compatible Neural Processing Unit (NPU), such as the RK3588. Called by
> +	  Rockchip either RKNN or RKNPU, it accelerates inference of neural
> +	  networks.
> +
> +	  The interface exposed to userspace is described in
> +	  include/uapi/drm/rocket_accel.h and is used by the userspace driver in
> +	  Mesa3D.

Nit: name the specific Mesa driver here?

> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called rocket.
> diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..09d966c826b5b1090a18cb24b3aa4aba286a12d4
> --- /dev/null
> +++ b/drivers/accel/rocket/rocket_core.c
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright 2024 Tomeu Vizoso <tomeu@tomeuvizoso.net> */
> +
> +#include <linux/clk.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>

This list of includes seems insufficient. You use PTR_ERR but don't have 
the include for it (linux/err.h). Same for dev_err/dev_info. I'm 
guessing this comment applies elsewhere.

> +#include "rocket_core.h"
> +#include "rocket_registers.h"
> +
> +static int rocket_clk_init(struct rocket_core *core)
> +{
> +	struct device *dev = core->dev;
> +	int err;
> +
> +	core->a_clk = devm_clk_get(dev, "aclk");
> +	if (IS_ERR(core->a_clk)) {
> +		err = PTR_ERR(core->a_clk);
> +		dev_err(dev, "devm_clk_get_enabled failed %d for core %d\n", err, core->index);

Do you think it would be useful to mention "aclk" in the message? Seems 
like if this or the hclk get fails, you won't know just from the kernel log.

> +		return err;
> +	}
> +
> +	core->h_clk = devm_clk_get(dev, "hclk");
> +	if (IS_ERR(core->h_clk)) {
> +		err = PTR_ERR(core->h_clk);
> +		dev_err(dev, "devm_clk_get_enabled failed %d for core %d\n", err, core->index);
> +		clk_disable_unprepare(core->a_clk);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +int rocket_core_init(struct rocket_core *core)
> +{
> +	struct device *dev = core->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	uint32_t version;
> +	int err = 0;
> +
> +	err = rocket_clk_init(core);
> +	if (err) {
> +		dev_err(dev, "clk init failed %d\n", err);

This feels redundant since rocket_clk_init() already printed an error 
message with more details.

> +		return err;
> +	}
> +
> +	core->iomem = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(core->iomem))
> +		return PTR_ERR(core->iomem);
> +
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_set_autosuspend_delay(dev, 50); /* ~3 frames */

Frames? That feels like a rendering term, but this driver is not doing 
rendering, right? Is there a better way to describe this?

> +	pm_runtime_enable(dev);
> +
> +	err = pm_runtime_get_sync(dev);
> +
> +	version = rocket_read(core, REG_PC_VERSION);
> +	version += rocket_read(core, REG_PC_VERSION_NUM) & 0xffff;
> +
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	dev_info(dev, "Rockchip NPU core %d version: %d\n", core->index, version);
> +
> +	return 0;
> +}
> +
> diff --git a/drivers/accel/rocket/rocket_device.c b/drivers/accel/rocket/rocket_device.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..ce3b533f15c1011d8a7a23dd8132e907cc334c58
> --- /dev/null
> +++ b/drivers/accel/rocket/rocket_device.c
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright 2024 Tomeu Vizoso <tomeu@tomeuvizoso.net> */
> +
> +#include <linux/clk.h>
> +
> +#include "rocket_device.h"
> +
> +int rocket_device_init(struct rocket_device *rdev)
> +{
> +	struct device *dev = rdev->cores[0].dev;
> +	int err;
> +
> +	rdev->clk_npu = devm_clk_get(dev, "npu");
> +	rdev->pclk = devm_clk_get(dev, "pclk");

Are these optional? It would appear that error handling is missing.

> +
> +	/* Initialize core 0 (top) */
> +	err = rocket_core_init(&rdev->cores[0]);
> +	if (err) {
> +		rocket_device_fini(rdev);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static void rocket_drm_unbind(struct device *dev)
> +{
> +	struct rocket_device *rdev = dev_get_drvdata(dev);
> +	struct drm_device *ddev = &rdev->ddev;
> +
> +	drm_dev_unregister(ddev);

You allocated this with devm, shouldn't that make this unnecessary?

> +
> +	component_unbind_all(dev, rdev);
> +
> +	rocket_device_fini(rdev);
> +}

