Return-Path: <linux-kernel+bounces-201920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 016DB8FC54C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CFF51F2809E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25F418C32A;
	Wed,  5 Jun 2024 08:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M/KdOAc3"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6403137929
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717574482; cv=none; b=URXYBR5KWg6xoiYCpM0N67/EfzLfQQNTFo0wBQVfcxGCcxBJBVoMottuHzYwv74k/FfQjxQaDDxBqa7ozWy74GIFcUgDAOh6JYzT2A1doFngBvgOryzXisiZThmE+unGozsk4BLlX/xJ2nHvBzpu+Sk/3wqBSVBjSCRt2E//dXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717574482; c=relaxed/simple;
	bh=2SrJCHZCOM9IGtk+Zr6Yf/RUkrrgRuWEqMIJnnVHES0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t4++FPnb5ttLzBi25AjW01C4epXgzlawyJi/3GQrLqLJ1ba74xHwCByMO8IGItT/DrQ63UmP+AY3Xp9hacBkEdeQLTL+rKbZGM+DMPX5HGjRPU1wywnhXIhxaJIZ7AuDH2F1vdqs0UEQACHpQnPHiO3SH4iHpSbwmtkJVelCfaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M/KdOAc3; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52b78ef397bso604910e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 01:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717574478; x=1718179278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYi7r2TnCxaibretuO7IusVqeOqvcY8+ogUviW8Ksn4=;
        b=M/KdOAc3JnJq3/W5ToY8xHmKUPaH9yk3JilKXoDhEtTFcVm2OIsFOBSc+zyz8Hk+uC
         GggyG7KmZlCfnJmHSIMe4AK9X7RrAHzUKm19DAWDOvgFe6w/6ad96CtWEnKoKVoVj14S
         XpmBIZ3ybZwG27HIDTAxHnRxMDaa7VleVnwik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717574478; x=1718179278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYi7r2TnCxaibretuO7IusVqeOqvcY8+ogUviW8Ksn4=;
        b=ZODtvdg4db9C2nqbJFtlPm3YpqbYIYqX3X7tImlf8vGNyBxsKSb5l9IDarB4idztgd
         DEC7Z95HHiqiqLmcf5yYxrizeFJI3H9GCSMyxAKpe83AtYfFfrspJTsnHsORZk6kRQ5a
         kch9SA2VxeV62XjvH3R63KzpUuHnJb5e4ooTXiEbsGGVG+8XZ74PHAIiaZuxgb4Lhaz/
         /7w3i9PfLiSWV+G5QiENwLiUwr0LDxhV0ggXlRBQ2FnO+ybU6U784BBW4SBVm5gtRq0r
         CsUonqxXmkGZoaEaGJ8N4QoDd6+pM0iEo+8IiGiYRiT50Aui7yNd+R1GJJxzWG68EZYm
         qqRw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ1Iv64UkmPBC8vO3o+vlT4Wrsy2gGZksORPBpmdDY8umkV8ZvqHppJ34CDGrc4dk6YhDaxCePdpAug2svb97FjJYe1kqp4Z2gzGyq
X-Gm-Message-State: AOJu0YyovIeIBUGZZ1llwLT9W6EXCTYC43GF+47tgMCPnGRVh/UEY/uU
	xJ1HLdEUlY5SNIi/nFU7NW02nNOOtMyfkk5VXrNqJbjkXCV66vFuszPiUuSyAIUWiB08jTbXZe5
	Nyi+nj0AU28yr/EAjqH8TJwLq/BqLCC3+GoIQ
X-Google-Smtp-Source: AGHT+IFClBERnCz/V4H8WjtGceS02ooFyfidArVM3QcN2FmBGBb44gqcYD9TWK6di5XCSG/W/X5AWubXBeAQk5tXlLQ=
X-Received: by 2002:a05:6512:108b:b0:52b:963d:277c with SMTP id
 2adb3069b0e04-52ba22a0b4cmr1638728e87.33.1717574478217; Wed, 05 Jun 2024
 01:01:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e5912054-0fc9-47ff-8f38-9b9a3e9d2156@notapiano>
In-Reply-To: <e5912054-0fc9-47ff-8f38-9b9a3e9d2156@notapiano>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 5 Jun 2024 16:01:06 +0800
Message-ID: <CAGXv+5HJKur9vWq4j_x7-fuL5H0SY_oQNYFWTxFCC1EBxF9yQw@mail.gmail.com>
Subject: Re: Probe failures on mt8183-kukui-jacuzzi-juniper-sku16
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: linux-mediatek@lists.infradead.org, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 4, 2024 at 11:52=E2=80=AFPM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> Hi,
>
> We're monitoring the status of device probe on the
> mt8183-kukui-jacuzzi-juniper-sku16 platform in KernelCI, and I thought it=
'd be
> helpful to share the results.
>
> These are the current failures:
>
> * /soc/i2c@11009000/trackpad@15
> * /soc/svs@1100bc00
> * /thermal-sensor1
> * /thermal-sensor2
>
> In more details:
>
> * /soc/i2c@11009000/trackpad@15: I believe this is a second source trackp=
ad and
>   is thus waiting for the "platform/chrome: Introduce DT hardware prober"=
 series
>   [1] to be merged before it can be handled. Although looks like there ha=
ven't
>   been updates to the series in a while.

I've been working on other stuff and haven't had time to respin this series=
.

Just to confirm, is the failure due to pinctrl conflicts when the trackpad
variants probe asynchronously?

> * /soc/svs@1100bc00: On the logs the following is reported:
>
>     SVSB_GPU: cannot get "gpu-thermal" thermal zone
>
>   MT8183 uses the auxadc_thermal driver, which apparently only registers =
one
>   thermal zone (tz 0, for the CPU):
>
>     devm_thermal_of_zone_register(&pdev->dev, 0, mt,
>                               &mtk_thermal_ops);
>
>   As a quick hack I changed the 0 to 2, so the GPU thermal zone got regis=
tered,
>   and that did allow SVS to go further in its probe, but still resulted i=
n an
>   error:
>
>     [    9.330993] mtk-svs 1100bc00.svs: M_HW_RES0: 0x00320090
>     [    9.336700] mtk-svs 1100bc00.svs: M_HW_RES1: 0xa3ffff5f
>     [    9.342628] mtk-svs 1100bc00.svs: M_HW_RES2: 0x47cf47cf
>     [    9.347898] mtk-svs 1100bc00.svs: M_HW_RES3: 0xa3ffff5f
>     [    9.353164] mtk-svs 1100bc00.svs: M_HW_RES4: 0xa3fff1aa
>     [    9.358400] mtk-svs 1100bc00.svs: M_HW_RES5: 0x47ec4b82
>     [    9.358411] mtk-svs 1100bc00.svs: M_HW_RES6: 0xa3ff9aac
>     [    9.358416] mtk-svs 1100bc00.svs: M_HW_RES7: 0xa3ff1c13
>     [    9.358420] mtk-svs 1100bc00.svs: M_HW_RES8: 0x4bec4beb
>     [    9.358424] mtk-svs 1100bc00.svs: M_HW_RES9: 0xa3ff7b02
>     [    9.358429] mtk-svs 1100bc00.svs: M_HW_RES14: 0x06ce7583
>     [    9.370719] mtk-svs 1100bc00.svs: M_HW_RES15: 0x00220010
>     [    9.381134] mtk-svs 1100bc00.svs: M_HW_RES16: 0xa3ffdf46
>     [    9.381141] mtk-svs 1100bc00.svs: M_HW_RES17: 0x47ec47eb
>     [    9.391612] mtk-svs 1100bc00.svs: M_HW_RES18: 0xa3ffd443
>     [    9.477419]  SVSB_CPU_LITTLE: svs_init01_isr_handler: VDN74~30:0x1=
6202931~0x363b4147, DC:0x02bb0013
>     [    9.495313] cpu cpu4: cpu4: failed to find OPP for 1781000000
>     [    9.495549]  SVSB_CPU_BIG: svs_init01_isr_handler: VDN74~30:0x1621=
2a33~0x393e444b, DC:0x02d000d0
>     [    9.495847]  SVSB_CCI: svs_init01_isr_handler: VDN74~30:0x141b252e=
~0x33394147, DC:0x02c10049
>     [    9.495897]  SVSB_GPU: buck voltage: 700000uV, expected vboot: 800=
000uV
>     [    9.496184] mtk-svs 1100bc00.svs: error -EPERM: svs start fail
>     [    9.496204] mtk-svs 1100bc00.svs: probe with driver mtk-svs failed=
 with error -1
>
>   so it seems that more changes will be required in addition to updating
>   auxadc_thermal to register multiple thermal zones.
>
> * /thermal-sensor1, /thermal-sensor2: The following is reported:
>
>     [    2.813605] thermal_sys: Failed to find 'trips' node
>     [    2.813611] thermal_sys: Failed to find trip points for thermal-se=
nsor1 id=3D0
>     [    2.813619] generic-adc-thermal thermal-sensor1: Thermal zone sens=
or register failed: -22
>     [    2.813624] generic-adc-thermal thermal-sensor1: probe with driver=
 generic-adc-thermal failed with error -22
>
>   And the same for thermal-sensor2. So both are missing the required 'tri=
ps'
>   subnode.

IIRC either the driver or the DT had comments saying "these zones don't
need trip points". In that case maybe the driver should use
thermal_tripless_zone_device_register() for them?


ChenYu

> If you have any additional information on these issues please let me know=
.
>
> Full test results are included below if you're curious.
>
> Note: these results are from today's next: next-20240604
>
> Thanks,
> N=C3=ADcolas
>
>
> [1] [RFC PATCH v3 0/5] platform/chrome: Introduce DT hardware prober
> https://lore.kernel.org/all/20231128084236.157152-1-wenst@chromium.org/
>
>
> TAP version 13
> 1..1
> # timeout set to 45
> # selftests: dt: test_unprobed_devices.sh
> # TAP version 13
> # 1..166
> # ok 1 / # SKIP
> # ok 2 /backlight_lcd0
> # ok 3 /bt-sco
> # ok 4 /cci
> # ok 5 /cpus/cpu@0 # SKIP
> # ok 6 /cpus/cpu@1 # SKIP
> # ok 7 /cpus/cpu@100 # SKIP
> # ok 8 /cpus/cpu@101 # SKIP
> # ok 9 /cpus/cpu@102 # SKIP
> # ok 10 /cpus/cpu@103 # SKIP
> # ok 11 /cpus/cpu@2 # SKIP
> # ok 12 /cpus/cpu@3 # SKIP
> # ok 13 /cpus/idle-states/cluster-sleep-0 # SKIP
> # ok 14 /cpus/idle-states/cluster-sleep-1 # SKIP
> # ok 15 /cpus/idle-states/cpu-sleep # SKIP
> # ok 16 /cpus/l2-cache0 # SKIP
> # ok 17 /cpus/l2-cache1 # SKIP
> # ok 18 /firmware/chromeos # SKIP
> # ok 19 /firmware/coreboot
> # ok 20 /fixed-factor-clock-13m # SKIP
> # ok 21 /max98357a
> # ok 22 /mt8183-sound
> # ok 23 /opp-table-0 # SKIP
> # ok 24 /opp-table-cci # SKIP
> # ok 25 /opp-table-cluster0 # SKIP
> # ok 26 /opp-table-cluster1 # SKIP
> # ok 27 /oscillator # SKIP
> # ok 28 /oscillator1 # SKIP
> # ok 29 /pmu-a53
> # ok 30 /pmu-a73
> # ok 31 /pp1200-mipibrdg
> # ok 32 /pp1800-mipibrdg
> # ok 33 /pp3300-panel
> # ok 34 /psci
> # ok 35 /regulator-vsys
> # ok 36 /regulator0
> # ok 37 /regulator1
> # ok 38 /regulator2
> # ok 39 /regulator3
> # ok 40 /regulator4
> # ok 41 /regulator5
> # ok 42 /regulator6
> # ok 43 /reserved-memory/memory@50000000 # SKIP
> # ok 44 /reserved-memory/ramoops
> # ok 45 /soc
> # ok 46 /soc/aal@14010000
> # ok 47 /soc/audio-controller@11220000
> # ok 48 /soc/audio-controller@11220000/mt8183-afe-pcm
> # ok 49 /soc/auxadc@11001000
> # ok 50 /soc/ccorr@1400f000
> # ok 51 /soc/color@1400e000
> # ok 52 /soc/cpu-debug@d410000
> # ok 53 /soc/cpu-debug@d510000
> # ok 54 /soc/cpu-debug@d610000
> # ok 55 /soc/cpu-debug@d710000
> # ok 56 /soc/cpu-debug@d810000
> # ok 57 /soc/cpu-debug@d910000
> # ok 58 /soc/cpu-debug@da10000
> # ok 59 /soc/cpu-debug@db10000
> # ok 60 /soc/dither@14012000 # SKIP
> # ok 61 /soc/dma-controller0@14001000
> # ok 62 /soc/dma-controller@14005000 # SKIP
> # ok 63 /soc/dsi-phy@11e50000
> # ok 64 /soc/dsi@14014000
> # ok 65 /soc/efuse@11f10000
> # ok 66 /soc/efuse@8000000
> # ok 67 /soc/gamma@14011000
> # ok 68 /soc/gpu@13040000
> # ok 69 /soc/i2c@11005000
> # ok 70 /soc/i2c@11007000
> # ok 71 /soc/i2c@11007000/touchscreen@10
> # ok 72 /soc/i2c@11008000
> # ok 73 /soc/i2c@11008000/anx7625@58
> # ok 74 /soc/i2c@11008000/anx7625@58/aux-bus/panel
> # ok 75 /soc/i2c@11009000
> # not ok 76 /soc/i2c@11009000/trackpad@15
> # ok 77 /soc/i2c@11009000/trackpad@2c
> # ok 78 /soc/i2c@1100f000
> # ok 79 /soc/i2c@11011000
> # ok 80 /soc/i2c@11016000
> # ok 81 /soc/i2c@11016000/ts3a227e@3b
> # ok 82 /soc/interrupt-controller@c000000 # SKIP
> # ok 83 /soc/interrupt-controller@c530a80 # SKIP
> # ok 84 /soc/iommu@10205000
> # ok 85 /soc/jpeg-encoder@17030000
> # ok 86 /soc/larb@14017000
> # ok 87 /soc/larb@15021000
> # ok 88 /soc/larb@1502f000
> # ok 89 /soc/larb@16010000
> # ok 90 /soc/larb@17010000
> # ok 91 /soc/larb@1a001000
> # ok 92 /soc/larb@1a002000
> # ok 93 /soc/mailbox@10238000
> # ok 94 /soc/mdp3-ccorr@1401c000 # SKIP
> # ok 95 /soc/mdp3-rsz0@14003000 # SKIP
> # ok 96 /soc/mdp3-rsz1@14004000 # SKIP
> # ok 97 /soc/mdp3-wdma@14006000 # SKIP
> # ok 98 /soc/mmc@11230000
> # ok 99 /soc/mmc@11240000
> # ok 100 /soc/mmc@11240000/qca-wifi@1
> # ok 101 /soc/mutex@14016000
> # ok 102 /soc/ovl@14008000
> # ok 103 /soc/ovl@14009000
> # ok 104 /soc/ovl@1400a000
> # ok 105 /soc/pinctrl@10005000
> # ok 106 /soc/pwm@11006000
> # ok 107 /soc/pwm@1100e000
> # ok 108 /soc/pwrap@1000d000
> # ok 109 /soc/pwrap@1000d000/pmic
> # ok 110 /soc/pwrap@1000d000/pmic/keys
> # ok 111 /soc/pwrap@1000d000/pmic/mt6358codec
> # ok 112 /soc/pwrap@1000d000/pmic/mt6358regulator
> # ok 113 /soc/pwrap@1000d000/pmic/rtc
> # ok 114 /soc/rdma@1400b000
> # ok 115 /soc/rdma@1400c000
> # ok 116 /soc/scp@10500000
> # ok 117 /soc/scp@10500000/cros-ec-rpmsg
> # ok 118 /soc/serial@11002000
> # ok 119 /soc/serial@11003000
> # ok 120 /soc/serial@11003000/bluetooth
> # ok 121 /soc/smi@14019000
> # ok 122 /soc/spi@1100a000
> # ok 123 /soc/spi@1100a000/tpm@0
> # ok 124 /soc/spi@11010000
> # ok 125 /soc/spi@11010000/flash@0
> # ok 126 /soc/spi@11012000
> # ok 127 /soc/spi@11012000/cros-ec@0
> # ok 128 /soc/spi@11012000/cros-ec@0/extcon0
> # ok 129 /soc/spi@11012000/cros-ec@0/i2c-tunnel
> # ok 130 /soc/spi@11012000/cros-ec@0/i2c-tunnel/sbs-battery@b
> # ok 131 /soc/spi@11012000/cros-ec@0/keyboard-controller
> # ok 132 /soc/spi@11012000/cros-ec@0/typec
> # ok 133 /soc/spi@11012000/cros-ec@0/typec/connector@0 # SKIP
> # not ok 134 /soc/svs@1100bc00
> # ok 135 /soc/syscon@10000000
> # ok 136 /soc/syscon@10001000
> # ok 137 /soc/syscon@10003000
> # ok 138 /soc/syscon@10006000 # SKIP
> # ok 139 /soc/syscon@10006000/power-controller
> # ok 140 /soc/syscon@1000c000
> # ok 141 /soc/syscon@13000000
> # ok 142 /soc/syscon@14000000
> # ok 143 /soc/syscon@15020000
> # ok 144 /soc/syscon@16000000
> # ok 145 /soc/syscon@17000000
> # ok 146 /soc/syscon@19000000
> # ok 147 /soc/syscon@19010000
> # ok 148 /soc/syscon@19180000
> # ok 149 /soc/syscon@19280000
> # ok 150 /soc/syscon@1a000000
> # ok 151 /soc/syscon@c530000
> # ok 152 /soc/t-phy@11f40000
> # ok 153 /soc/thermal-sensor@1100b000
> # ok 154 /soc/timer@10017000 # SKIP
> # ok 155 /soc/usb@11201000
> # ok 156 /soc/usb@11201000/usb@11200000
> # ok 157 /soc/usb@11201000/usb@11200000/hub@1
> # ok 158 /soc/video-codec@16020000
> # ok 159 /soc/watchdog@10007000
> # not ok 160 /thermal-sensor1
> # not ok 161 /thermal-sensor2
> # ok 162 /timer # SKIP
> # ok 163 /vddio-mipibrdg
> # ok 164 /volume-buttons
> # ok 165 /wifi-pwrseq
> # ok 166 /wifi-wakeup
> # # Totals: pass:127 fail:4 xfail:0 xpass:0 skip:35 error:0

