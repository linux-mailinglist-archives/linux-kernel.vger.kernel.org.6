Return-Path: <linux-kernel+bounces-222170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4C090FDD2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE961C216A5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9920F4C62B;
	Thu, 20 Jun 2024 07:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwUWPywQ"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5265B2582;
	Thu, 20 Jun 2024 07:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718868759; cv=none; b=siPhPTTjLsFZ9gVI+Uoe4hRx6xkdpjd0gmAHKJ6wao0dloS4pVq9PnJuHfrHW65iHsISSCT5LDcmjiAxmRXKeTFc/V6Qqy0z3rFV1JG+zpZKipykMhP+/gvMFIuCrx3NxhBZQ5u0CusXbMLmUJpFlUQ0/602R9Yoo3fgNrpGduc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718868759; c=relaxed/simple;
	bh=wHBVd9fc2iWfUZuweb4LS9YbAAd/18fD/OhLw/DQ1QU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sgBQKDElaiBa5THypnJhe2lEd3Vm7YsfMtruG0sRKzSlC6ykCPiOtTa2hUSWUxdrVdRjpYAEEiAqQkcJ/rYF9ky4e7QSjT5nl3oxj75FvP4nBj/ZA+Uud2QpK+tNuIjqFABwyY6e2vY6vrWVCghTJNxuvKBcv87sd/kKgXaG4XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwUWPywQ; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-62cddff7f20so5002917b3.3;
        Thu, 20 Jun 2024 00:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718868757; x=1719473557; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qnAIkWGQryIAQtTLmUZTYaNhdbVrLJLMPyGuu/muHE4=;
        b=XwUWPywQ0J+uow7/3WM3VxDHf2yfN/gmz8ONSejpWXnXXkWkkcE6WD3hNXztgjiZVo
         XZ/zSclx0OJXpYAt0hGVqpAKB5difb1mpYRCH5OztsfEtLSQVWJJxQf5pL+Ax06f5/iA
         YT+2o8YyMkinjPqJBepe7jKwDwX/teTqWzztgBF0AgwHBEQj18K6jalWPXDQ7mVG+3rM
         lRpqajQUKesOT1MtPKiLGeYMhl84qtQd7AsoAWQ3veguEion4+RPkDrzazug3283o4DQ
         XhnQ+rsbr6UhJgkolyueURKUq9pOthe+pN6W38xpX4RdhrJ6ewiKSuYwQbH6BsDEDA//
         Es4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718868757; x=1719473557;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qnAIkWGQryIAQtTLmUZTYaNhdbVrLJLMPyGuu/muHE4=;
        b=KA5CCCihMW//oD6Yi55M2BfcadVmm7lW8d9ZIwq+o6o94Mtmo0tuYNWjxxKMDYgXlv
         PMHBm8SJTGgI2vruVFh2TV21J/yR7qDzZVuCPIDAwErzppl+BnHy0IsSOU3PqvPyKhE4
         u5VvznZIa/LgKx0kSLtoNivesaN4cJsQWXCDzkHt7diIWJWgDqdFHkgDT7sYTry4VEpw
         /1PHEIrSrT0xcXin7n9Pytw+LyJIfVTaknU9htgVEmZ5Sv3FhhXANnUDeXznhOP8Ud2a
         bMFlQohwI6iQVia8c3WvwVka0sG0s9POS69Hsmn3FHjEotKyEAJB1xnd9tlIBZA5y8i3
         h65A==
X-Forwarded-Encrypted: i=1; AJvYcCWv8ZDAIh0SxfIUHIt2W0GfAtq7Cg3Mo7e3M4EEeyw55Xt2PuEH9PKozocC3jjglvmltyFRMmr56JvIG7uZh8+mCLA2ZRViK9pwJFEg1tMEDUFFbvFByivFIZuMYdW1XuIa1dTUXE1lECx5eNBkHw5/+FiLlD/yF3ctIQUPLvTbw1Duxw==
X-Gm-Message-State: AOJu0YxZrMoQyKbBGmykjiLU9NaI1hd8zo3cXXdEgLdZSvqOompsMIT6
	kQ6eg6wqWRslT5Sw2fQPwl1Pd3WDwnJVlX5W7UJ0kbrp6s/ZT+lZBLH6qoew6LPwzWlsv733B42
	QPlrHXKyH9BzouBOVGiLH2jdwmmM=
X-Google-Smtp-Source: AGHT+IFMs27chWrPqAVjs1vjzs16P9LfbkLcD+9tzrx+qaAHwjt2BmEAahSMklBZ+1btLgaZ6nW+L/dXD2/WIeBy5t8=
X-Received: by 2002:a0d:e605:0:b0:618:8d31:a557 with SMTP id
 00721157ae682-63a8e1d915cmr46504547b3.14.1718868757233; Thu, 20 Jun 2024
 00:32:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618185819.2155595-2-tmaimon77@gmail.com> <202406191439.3NcnExKM-lkp@intel.com>
In-Reply-To: <202406191439.3NcnExKM-lkp@intel.com>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Thu, 20 Jun 2024 10:32:26 +0300
Message-ID: <CAP6Zq1h2Sk6H2V-i+PAk_fCy9xdywcYw=w9wT_xcJ2WrqyWbAg@mail.gmail.com>
Subject: Re: [PATCH v25 1/3] dt-bindings: reset: npcm: add clock properties
To: kernel test robot <lkp@intel.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, tali.perry1@gmail.com, 
	joel@jms.id.au, venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	oe-kbuild-all@lists.linux.dev, openbmc@lists.ozlabs.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Rob and Krzysztof,

Could you please review this patch?

Thanks,

Tomer

On Wed, 19 Jun 2024 at 09:20, kernel test robot <lkp@intel.com> wrote:
>
> Hi Tomer,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on clk/clk-next]
> [also build test WARNING on linus/master pza/reset/next v6.10-rc4 next-20240618]
> [cannot apply to pza/imx-drm/next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Tomer-Maimon/dt-bindings-reset-npcm-add-clock-properties/20240619-093532
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
> patch link:    https://lore.kernel.org/r/20240618185819.2155595-2-tmaimon77%40gmail.com
> patch subject: [PATCH v25 1/3] dt-bindings: reset: npcm: add clock properties
> config: arm64-randconfig-051-20240619 (https://download.01.org/0day-ci/archive/20240619/202406191439.3NcnExKM-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 13.2.0
> dtschema version: 2024.6.dev1+g833054f
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240619/202406191439.3NcnExKM-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406191439.3NcnExKM-lkp@intel.com/
>
> dtcheck warnings: (new ones prefixed by >>)
>    arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi:63.7-177.5: Warning (simple_bus_reg): /ahb/apb: simple-bus unit address format error, expected "f0000000"
>    arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi:50.35-55.5: Warning (unique_unit_address_if_enabled): /ahb/reset-controller@f0801000: duplicate unit-address (also used in node /ahb/clock-controller@f0801000)
>    arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /: memory@0: 'device_type' is a required property
>         from schema $id: http://devicetree.org/schemas/memory.yaml#
>    arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: system-controller@f0800000: compatible: ['nuvoton,npcm845-gcr', 'syscon'] is too short
>         from schema $id: http://devicetree.org/schemas/soc/nuvoton/nuvoton,npcm-gcr.yaml#
>    arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: interrupt-controller@dfff9000: 'ppi-partitions' does not match any of the regexes: '^v2m@[0-9a-f]+$', 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/interrupt-controller/arm,gic.yaml#
>    arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: ahb: apb:ranges: [[0, 0, 4026531840, 3145728], [4293918720, 0, 4293918720, 90112]] is not of type 'boolean'
>         from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
> >> arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: reset-controller@f0801000: '#clock-cells' is a required property
>         from schema $id: http://devicetree.org/schemas/reset/nuvoton,npcm750-reset.yaml#
> >> arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: reset-controller@f0801000: 'clocks' is a required property
>         from schema $id: http://devicetree.org/schemas/reset/nuvoton,npcm750-reset.yaml#
>    arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: timer@8000: 'clock-names' does not match any of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/timer/nuvoton,npcm7xx-timer.yaml#
>    arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/apb/watchdog@801c: failed to match any schema with compatible: ['nuvoton,npcm845-wdt', 'nuvoton,npcm750-wdt']
>    arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/apb/watchdog@801c: failed to match any schema with compatible: ['nuvoton,npcm845-wdt', 'nuvoton,npcm750-wdt']
>    arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/apb/watchdog@901c: failed to match any schema with compatible: ['nuvoton,npcm845-wdt', 'nuvoton,npcm750-wdt']
>    arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/apb/watchdog@901c: failed to match any schema with compatible: ['nuvoton,npcm845-wdt', 'nuvoton,npcm750-wdt']
>    arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/apb/watchdog@a01c: failed to match any schema with compatible: ['nuvoton,npcm845-wdt', 'nuvoton,npcm750-wdt']
>    arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/apb/watchdog@a01c: failed to match any schema with compatible: ['nuvoton,npcm845-wdt', 'nuvoton,npcm750-wdt']
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

