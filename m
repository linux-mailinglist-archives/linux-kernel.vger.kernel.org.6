Return-Path: <linux-kernel+bounces-225488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F2E913127
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 02:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5C2E285403
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 00:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C932115CB;
	Sat, 22 Jun 2024 00:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t2U2uxeM"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3136385
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 00:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719015892; cv=none; b=YMiCg5NOIJBAiNi9uJpO9tcQkkxHK0gjZ6qgUc3exE5mArhUAbnOWNwV+EOctTvWuhUBKJ8hFin8/bk55sxhj2kYb6esGcNkyO/BFQ3VEsCM1prui5v1dbnrpzkGk6fiY1JzGhA2u8BTBcMiUPyBUS4vx3yeV9FCsZ6LGqG9CNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719015892; c=relaxed/simple;
	bh=TlLWHvDv3H6dKa4ojFZrl6gpWDWeREn7LE1RzC4Nymk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/6fS2I5I1wzKEXEgNf5JeqIlxU3Q91D0/xG7y5zO4FTjgRyHoah5hAq95tX+/OId+EhLoz7HTEWlFftHBlafU2FJC+3uwSyERgQMqmm7d1yAws8MnbZLUxKMURIPXDNWe96ICdt15oySAJGtzmxYQwf++KLTn781XxPwn5c1J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t2U2uxeM; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f70ec6ff8bso231955ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 17:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719015887; x=1719620687; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PRP3VQE1AP3bnFtc/gjNPrEWREESeBel3PS2LQJhyUA=;
        b=t2U2uxeMkVAmTqTeKBCeMmQM3qHFsiEE8vrmrzzZGQPAgoy7JYnNSliaYCa0bqpOh+
         t8ui7D3RfVQw6JCn5Zrv+sm+7EJ3ettnvRNliH5gwGkgfB9GShz1UoO5W9v5HO1rTbhP
         c7bDtn/2dybE814/GY7dVhMXGtMDIfFp9q0W2yzY5Vs32nXD9OOZjHF9Jl5VqKO8W90c
         rGGQYflcwlW3+6BvKdNAjN0thGVrjfOoPRblXmO1Wz04gLcvUCImEh7tURvHqqtIlXvx
         FwwZjIe2Op7fqKnNpJm+zdGuZ3wEav7Q/Jljt8DhjsrXSygspATEm09kTPbzTnHafXF+
         MPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719015887; x=1719620687;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PRP3VQE1AP3bnFtc/gjNPrEWREESeBel3PS2LQJhyUA=;
        b=MOBD3ijTIXnT2BqdQwc43dS9MfI4dZsqA3HlGFr7PMa2SH4wD+ACMtRdj3GTppFPtp
         PCRLC6IWJeIqQ3HI2J6+LWudhKLFDFyEdfbupGlbWQ/n2vZFFDRD8RuWkqqOZNM51ppA
         jKt49DdAPSKC6Q8QF88SOrJ8kqXusZj65O7D91Oijido/vZIteuN1TZZhoPpQNV3ukKO
         JniwqddJUv63QWzPZbxLODIsghyH6uk3wThZNbEF5CUcYVEBqE/NSaFKQaZAeMX0FLLi
         1+82DWWbAiQJ7jGEUvjvdOW4vy5MluUhlCijAaEFPup1LkRIdyNv9dXOmpDIpD2v/U+p
         W5DQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrfXy+CBJmhdskq36N8vGGTbRjHbr5DMVDq2wT8XCUkCREir+rqVXgiAUcLsQKNPNG2pRdPoQM1XsyuOHk93aa1bg740KL7Wdx3myk
X-Gm-Message-State: AOJu0YzezqOpiYlsGCfAGz0osByhq/L6gKmImTcniOUtdepzFhcY/a0w
	sjjSOLQX4VkiP5s9Qq3465aE6dljuUmECqhnEoBgIclmKL5Ik8Tzt0oNJZewiA==
X-Google-Smtp-Source: AGHT+IFMfnpYUYjQkDCI2TK2G2mhr4HnvdZTpVXgoabwYY/WwRqlge71giClqijFHgaHOR3qCIehLw==
X-Received: by 2002:a17:902:8bc1:b0:1f9:ab5b:1716 with SMTP id d9443c01a7336-1fa09ff289dmr872725ad.6.1719015886719;
        Fri, 21 Jun 2024 17:24:46 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbb27acsm19903955ad.247.2024.06.21.17.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 17:24:46 -0700 (PDT)
Date: Fri, 21 Jun 2024 17:24:42 -0700
From: William McVicker <willmcvicker@google.com>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Roy Luo <royluo@google.com>, kernel-team@android.com,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v3 0/6] USB31DRD phy support for Google Tensor gs101 (HS
 & SS)
Message-ID: <ZnYZyoUytCfParSb@google.com>
References: <20240617-usb-phy-gs101-v3-0-b66de9ae7424@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240617-usb-phy-gs101-v3-0-b66de9ae7424@linaro.org>

On 06/17/2024, André Draszik wrote:
> This patch series adds support for the Exynos USB 3.1 DRD combo phy, as
> found in Exynos 9 SoCs like Google GS101. It supports USB SS, HS and
> DisplayPort, but DisplayPort is out of scope for this series.
> 
> In terms of UTMI+, this is very similar to the existing Exynos850
> support in this driver. The difference is that it supports both UTMI+
> (HS) and PIPE3 (SS). Firstly, there are some preparatory patches to convert
> this driver to using the clk_bulk and regulator_bulk APIs to simplify
> addition, while the bulk of the changes is around the SS part.
> 
> Dependencies on other patches:
> While there is no compile or link time dependency, for USB to actually work
> this series also requires Peter's syscon changes from
> https://lore.kernel.org/all/20240614140421.3172674-1-peter.griffin@linaro.org/
> 
> To: Vinod Koul <vkoul@kernel.org>
> To: Kishon Vijay Abraham I <kishon@kernel.org>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Peter Griffin <peter.griffin@linaro.org>
> To: Marek Szyprowski <m.szyprowski@samsung.com>
> To: Sylwester Nawrocki <s.nawrocki@samsung.com>
> To: Alim Akhtar <alim.akhtar@samsung.com>
> To: Sam Protsenko <semen.protsenko@linaro.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
> Cc: Will McVicker <willmcvicker@google.com>
> Cc: Roy Luo <royluo@google.com>
> Cc: kernel-team@android.com
> Cc: linux-phy@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> 
> Changes in v3:
> - drop patch 'phy: exynos5-usbdrd: use exynos_get_pmu_regmap_by_phandle()
>   for PMU regs'. This is not needed anymore with Peter's syscon series
>   mentioned above (Krzysztof).
> - drop those patches that have already been merged via
>   https://lore.kernel.org/all/20240507-samsung-usb-phy-fixes-v1-0-4ccba5afa7cc@linaro.org/
> - update device tree binding 'reg-names' (Krzysztof)
> - use clk_bulk and regulator_bulk APIs throughout to simplify addition of
>   gs101 support as preparatory patches
> - patch 1: add required but missing regulators
> - patch 4:
>     * make the register access clock name(s) platform specific and avoid
>       use of devm_clk_bulk_get_optional() as we want to be sure to have
>       retrieved all required clocks
>     * fix a whitespace issue
>     * slightly rephrase commit message
> - patch 6:
>     * set unused callback pointers to NULL in gs101_tunes[]
>     * implement missing regulator support and enable power to phy before any
>       register access
>     * add more phy tunes
>     * move PTS_UTMI_POSTINIT utmi phy tuning to before completion of POR
>       sequence, as per datasheet
>     * group gs101 related symbols closer to each other 
> - Link to v2: https://lore.kernel.org/r/20240501-usb-phy-gs101-v2-0-ed9f14a1bd6d@linaro.org
> 
> Changes in v2:
> - avoid having nested else/if in the DT binding (Rob)
> - add missing bitfield.h include
> - Link to v1: https://lore.kernel.org/r/20240423-usb-phy-gs101-v1-0-ebdcb3ac174d@linaro.org
> 
> ---
> André Draszik (6):
>       dt-bindings: phy: samsung,usb3-drd-phy: add gs101 compatible
>       phy: exynos5-usbdrd: support isolating HS and SS ports independently
>       phy: exynos5-usbdrd: convert core clocks to clk_bulk
>       phy: exynos5-usbdrd: convert (phy) register access clock to clk_bulk
>       phy: exynos5-usbdrd: convert Vbus supplies to regulator_bulk
>       phy: exynos5-usbdrd: support Exynos USBDRD 3.1 combo phy (HS & SS)
> 
>  .../bindings/phy/samsung,usb3-drd-phy.yaml         |  77 +-
>  drivers/phy/samsung/phy-exynos5-usbdrd.c           | 958 +++++++++++++++++----
>  include/linux/soc/samsung/exynos-regs-pmu.h        |   4 +
>  3 files changed, 893 insertions(+), 146 deletions(-)
> ---
> base-commit: 6906a84c482f098d31486df8dc98cead21cce2d0
> change-id: 20240423-usb-phy-gs101-abf3e172d1c4
> 
> Best regards,
> -- 
> André Draszik <andre.draszik@linaro.org>
> 

Thanks Andre! I tested this out on my Pixel 6 Pro. I verified the USB modules
load and probe as expected. I also verified my device is detected via adb on my
host machine. However, occasionally when I boot from RAM the device doesn't
come up via adb compared to when I flash and run `fastboot reboot`. So there
must be something happening differently when booting from fastboot mode versus
a reboot. Specifically, when I flash the kernel and run `fastboot reboot`, adb
has always come up, but booting the kernel from RAM results in about 30% adb
detection fail rate. I'll keep an eye on this.

$ adb shell lsmod
Module                  Size  Used by
at24                   24576  0
dwc3_exynos            12288  0
i2c_exynos5            28672  0
ufs_exynos             32768  0
phy_exynos_ufs         20480  1
phy_exynos5_usbdrd     36864  2
s3c2410_wdt            24576  0
arm_dsu_pmu            24576  0

Thanks,
Will

