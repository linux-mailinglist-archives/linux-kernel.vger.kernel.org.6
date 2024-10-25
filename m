Return-Path: <linux-kernel+bounces-381569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC259B00F8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43BB21C210D4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C4B2003DE;
	Fri, 25 Oct 2024 11:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xmjDy0SZ"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E04200B9E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 11:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729854977; cv=none; b=bx7nlk35T93KpdNiIkNvWWJ1mx0/iGXHnodis0Kvo+X4YOhzNI34DL9PcbbvLIaJ/gni/+DtF3qCXif4P2gHZgz2NIpTG3KJSiH2EVn7rY/6TsKemBXuCpGYBuKy1PP6bKG/94lIx6Pr2g6qSd7yOjaY7FbbIAvRCP/XbjcQxxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729854977; c=relaxed/simple;
	bh=bfvx6eq3T1d0YuMzY+CinUVIdj3XUhJjSMux6a3jqHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7tEXiKMSK+J/S0Y+DW5YcPEGxpoUXtKj6YZRW9G6iUlAlmkqVzVitubZxCP+sWqeIZBobZTJHbvxcFc/SwNgZd9mj7nZHss+3aN0RMqp4FUv+H4sOskrVufi1CU3VTvsNoVvYFrxHbYMNQx0CI4hjsrCwyd4+TyF6gEWHMbRdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xmjDy0SZ; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso18714161fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 04:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729854973; x=1730459773; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+wbGm/ydtg8JuxWS7dTqYrfqPwq75gu/aTyOSRNBW3w=;
        b=xmjDy0SZZKL+IBz6//6GsgbKAmu2U51Syewui689YVrod3prgJ+I1ovDFpRdVAbRYr
         UKRK3z4yOUZYnBof3EFTQKKtUZLOklQXb/XYdgvfKyfvIjubm1qCXKu6QGtr+9o9eLDF
         2Egl08kLaZATazFV9WWJRHZdvOYa3K8QDPPF73P/ahyYN1/hn8Q+uk3v8P6nsdvnu2EQ
         cPf8QOGonYltnLI9BENg5Uzea/5evsb5yfrsRcBf9HSfskituzf8lyECDqe6X9OiZK68
         VKPjEB77UZjyqzyXUA+YIGwjBEybjwhdMTICh6qo3vLVRC329b0ENTAxlEIIaK9jjmEm
         99eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729854973; x=1730459773;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+wbGm/ydtg8JuxWS7dTqYrfqPwq75gu/aTyOSRNBW3w=;
        b=aAtGJTshHPzFn2nqYVMfhRfpsvALdKKsoFZQ9XpkaOAbw6hEtu416J/qmeJlM1/XvY
         l9/c/kZHNBvRAmBcwOx+a32MZXj1VpAZ/w152QLOjcU/wUL8Beh2HNyaB/wDo84PDI89
         eKPYMKNA6NoUSY3XMX1fkphPWH/91h1lEOFOZqmjTa9F0z01xo1ca80+8BAHHSo0DEvn
         c2b8r8Zj7yQYsCaOmdzOeO4Ew5t98zhgbndN9g4iGp2hmWrmb4xW13rPewzEfRUE2P+F
         0Ka8Bb4XC6Nyvs9EQMrmt/zyYRcgBW7jnkd5L+oEbGZpLmmr5xDfg8Z1L/RIbgF52bct
         swEw==
X-Forwarded-Encrypted: i=1; AJvYcCXiMEaiv2JkeJFzC6/4tieTqpNo/ck7YFG+cx3CjnZ9DkjG8knxq501zDDd8EBR3o/RsrvdqgX9KLdyXeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTimyfLVC902avh/ShZJ2de9+RADxX1q/BtL1UCoqvh/oqRRpo
	bh7jZhrwKVi/zKWRgV7tkWSHNvmr2A69aYNxE7bqZovMfKq38FdkQi8ciTw+i1g=
X-Google-Smtp-Source: AGHT+IFMgBJCOqchmUqQwXq9KDNd3bL+ZFG+8q+6l2yTv7jxzeqI7dwo+daV6UeEF123w4oewKmKng==
X-Received: by 2002:a2e:be8a:0:b0:2fa:d604:e525 with SMTP id 38308e7fff4ca-2fc9d3852d3mr54176781fa.28.1729854973189;
        Fri, 25 Oct 2024 04:16:13 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb4519aecsm1506481fa.42.2024.10.25.04.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 04:16:11 -0700 (PDT)
Date: Fri, 25 Oct 2024 14:16:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Lijuan Gao <quic_lijuang@quicinc.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Tingguo Cheng <quic_tingguoc@quicinc.com>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	Will Deacon <will@kernel.org>, kernel@quicinc.com, linux-arm-kernel@lists.infradead.org, 
	Bjorn Andersson <andersson@kernel.org>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Swetha Chintavatla <quic_chintava@quicinc.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v4 0/7] Add initial support for QCS615 SoC and QCS615
 RIDE board
Message-ID: <3x2wwun2fqzyrqtzzy42t272e3vr6tj4lvislfsasmm4hoib7b@spxucor47qvh>
References: <20241022-add_initial_support_for_qcs615-v4-0-0a551c6dd342@quicinc.com>
 <172978739698.623494.13901719999982782781.robh@kernel.org>
 <de0f9f1c-9d5e-492d-b7fa-cb7e9d05ae10@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de0f9f1c-9d5e-492d-b7fa-cb7e9d05ae10@quicinc.com>

On Fri, Oct 25, 2024 at 04:10:46PM +0800, Lijuan Gao wrote:
> 
> 
> 在 10/25/2024 12:33 AM, Rob Herring (Arm) 写道:
> > 
> > On Tue, 22 Oct 2024 16:54:28 +0800, Lijuan Gao wrote:
> > > Introduces the Device Tree for the QCS615 platform.
> > > 
> > > Features added and enabled:
> > > - CPUs with PSCI idle states
> > > - Interrupt-controller with PDC wakeup support
> > > - Timers, TCSR Clock Controllers
> > > - Reserved Shared memory
> > > - QFPROM
> > > - TLMM
> > > - Watchdog
> > > - RPMH controller
> > > - Sleep stats driver
> > > - Rpmhpd power controller
> > > - Interconnect
> > > - GCC and Rpmhcc
> > > - QUP with Uart serial support
> > > 
> > > Bindings and base Device Tree for the QCS615 SoC are splited
> > > in four parts:
> > > - 1-3: Binding files for QCS615 SoC and PDC (Reviewed)
> > > - 4  : Soc table entry (Reviewed)
> > > - 5-6: Initial DTSI and RIDE board device tree
> > > - 7  : Enable uart related configs
> > > 
> > > Bindings Dependencies:
> > > - watchdog: https://lore.kernel.org/all/20240920-add_watchdog_compatible_for_qcs615-v2-1-427944f1151e@quicinc.com/ - Reviewed
> > > - qfprom: https://lore.kernel.org/all/20240912-add_qfprom_compatible_for_qcs615-v1-1-9ef2e26c14ee@quicinc.com/ - Reviewed
> > > - tcsr: https://lore.kernel.org/all/20240920-add_tcsr_compatible_for_qcs615-v2-1-8ce2dbc7f72c@quicinc.com/ - Applied
> > > - tlmm: https://lore.kernel.org/all/20240920-add_qcs615_pinctrl_driver-v2-1-e03c42a9d055@quicinc.com/ - Applied
> > > - interconnect: https://lore.kernel.org/all/20240924143958.25-2-quic_rlaggysh@quicinc.com/ - Reviewed
> > > - rpmhcc: https://lore.kernel.org/all/20241016-qcs615-clock-driver-v3-1-bb5d4135db45@quicinc.com/ - Reviewed
> > > - gcc: https://lore.kernel.org/all/20241016-qcs615-clock-driver-v3-3-bb5d4135db45@quicinc.com/ - Reviewed
> > > - rpmhpd: https://lore.kernel.org/all/20240927-add_qcs615_qcs8300_powerdomains_driver_support-v2-3-18c030ad7b68@quicinc.com/ - Applied
> > > 
> > > Build Dependencies:
> > > - tlmm: https://lore.kernel.org/all/20240920-add_qcs615_pinctrl_driver-v2-2-e03c42a9d055@quicinc.com/ - Applied
> > > - rpmhcc: https://lore.kernel.org/all/20241016-qcs615-clock-driver-v3-2-bb5d4135db45@quicinc.com/ - Reviewed
> > > - gcc: https://lore.kernel.org/all/20241016-qcs615-clock-driver-v3-4-bb5d4135db45@quicinc.com/
> > > 
> > > Patch made the following verifications:
> > > - Successfully passed dt_binding_check with DT_CHECKER_FLAGS=-m for earch binding file
> > > - Successfully passed dtbs_check with W=1 for dts
> > > - Verified CPU Hotplug, idle and online CPUs on QCS615 ride board
> > > - Checked pinctrl-maps path
> > > - Verified watchdog functionality with "echo 1 > /dev/watchdog", can trigger
> > >    a watchdog bark and later bite
> > > - Verified functionality with UART console on QCS615 ride board
> > > - RPMH controller driver probed successfully
> > > - Sleep stats driver probed successfully and checked qcom_stats
> > >    node on QCS615 ride board
> > > 
> > > Signed-off-by: Lijuan Gao <quic_lijuang@quicinc.com>
> > > ---
> > > Changes in v4:
> > > - Configure vreg_l17a to High Power Mode (HPM) as it supplies power to UFS
> > >    and eMMC, which can be utilized as boot devices.
> > > - Link to v3: https://lore.kernel.org/r/20240926-add_initial_support_for_qcs615-v3-0-e37617e91c62@quicinc.com
> > > 
> > > Changes in v3:
> > > - Added interconnect, GCC, RPMHCC, QPU, and RPMHPD related nodes for UART console
> > > - Enabled UART condole on ride board device
> > > - Link to v2: https://lore.kernel.org/r/20240913-add_initial_support_for_qcs615-v2-0-9236223e7dab@quicinc.com
> > > 
> > > Changes in v2:
> > > - Collected reviewed-bys
> > > - Removed extra blank line
> > > - Removed redundant function
> > > - Renamed xo-board to xo-board-clk and move it and sleep-clk to board dts
> > > - Renamed system-sleep to cluster_sleep_2
> > > - Removed cluster1
> > > - Added entry-method for idle-states
> > > - Added DTS chassis type
> > > - Added TCSR Clock Controllers
> > > - Added Reserved Shared memory
> > > - Added QFPROM
> > > - Added TLMM
> > > - Added Watchdog
> > > - Added RPMH controller
> > > - Added Sleep stats driver
> > > - Link to v1: https://lore.kernel.org/r/20240828-add_initial_support_for_qcs615-v1-0-5599869ea10f@quicinc.com
> > > ---
> > > 
> > > ---
> > > Lijuan Gao (7):
> > >        dt-bindings: arm: qcom: document QCS615 and the reference board
> > >        dt-bindings: arm: qcom,ids: add SoC ID for QCS615
> > >        dt-bindings: qcom,pdc: document QCS615 Power Domain Controller
> > >        soc: qcom: socinfo: Add QCS615 SoC ID table entry
> > >        arm64: dts: qcom: add initial support for QCS615 DTSI
> > >        arm64: dts: qcom: add base QCS615 RIDE dts
> > >        arm64: defconfig: enable clock controller, interconnect and pinctrl for QCS615
> > > 
> > >   Documentation/devicetree/bindings/arm/qcom.yaml    |   6 +
> > >   .../bindings/interrupt-controller/qcom,pdc.yaml    |   1 +
> > >   arch/arm64/boot/dts/qcom/Makefile                  |   1 +
> > >   arch/arm64/boot/dts/qcom/qcs615-ride.dts           | 219 +++++++
> > >   arch/arm64/boot/dts/qcom/qcs615.dtsi               | 688 +++++++++++++++++++++
> > >   arch/arm64/configs/defconfig                       |   3 +
> > >   drivers/soc/qcom/socinfo.c                         |   1 +
> > >   include/dt-bindings/arm/qcom,ids.h                 |   1 +
> > >   8 files changed, 920 insertions(+)
> > > ---
> > > base-commit: de938618db2bafbe1a70c8fc43f06ccdd60364b2
> > > change-id: 20241022-add_initial_support_for_qcs615-2256f64a9c24
> > > prerequisite-change-id: 20240919-qcs615-clock-driver-d74abed69854:v3
> > > prerequisite-patch-id: cd9fc0a399ab430e293764d0911a38109664ca91
> > > prerequisite-patch-id: 07f2c7378c7bbd560f26b61785b6814270647f1b
> > > prerequisite-patch-id: a57054b890d767b45cca87e71b4a0f6bf6914c2f
> > > prerequisite-patch-id: d0c5edf9c06568ae2b3ffacba47e57ebb43acb15
> > > prerequisite-change-id: 20240920-add_watchdog_compatible_for_qcs615-eec8a8c2c924:v2
> > > prerequisite-patch-id: 3a76212d3a3e930d771312ff9349f87aee5c55d5
> > > prerequisite-change-id: 20240911-add_qfprom_compatible_for_qcs615-e3b02f6fa71e:v1
> > > prerequisite-patch-id: 8a2454d5e07e56a6dd03f762f498051065635d85
> > > 
> > > Best regards,
> > > --
> > > Lijuan Gao <quic_lijuang@quicinc.com>
> > > 
> > > 
> > > 
> > 
> > 
> > My bot found new DTB warnings on the .dts files added or changed in this
> > series.
> > 
> > Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> > are fixed by another series. Ultimately, it is up to the platform
> > maintainer whether these warnings are acceptable or not. No need to reply
> > unless the platform maintainer has comments.
> > 
> > If you already ran DT checks and didn't see these error(s), then
> > make sure dt-schema is up to date:
> > 
> >    pip3 install dtschema --upgrade
> > 
> > 
> > New warnings running 'make CHECK_DTBS=y qcom/qcs615-ride.dtb' for 20241022-add_initial_support_for_qcs615-v4-0-0a551c6dd342@quicinc.com:
> > 
> > arch/arm64/boot/dts/qcom/qcs615-ride.dtb: clock-controller@100000: 'clock-names' is a required property
> > 	from schema $id: http://devicetree.org/schemas/clock/qcom,qcs615-gcc.yaml#
> > 
> Got it, it will be updated in the next version, thanks!

Instead drop it from the bindings, please.

-- 
With best wishes
Dmitry

