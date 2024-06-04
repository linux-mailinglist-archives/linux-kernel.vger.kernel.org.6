Return-Path: <linux-kernel+bounces-201008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9518FB80A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E29F281CE3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C9813A25B;
	Tue,  4 Jun 2024 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="K6eT2fbb"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C38A148FE1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516332; cv=none; b=sVlW/o5B8O2yR5jMdsIvt3oSCJQVyc2z5GE5xFww79RckCVMm7dPu4ZgCdLAg9SmWX4JKcZjx6MB4JmZS21ISob+rtoZYJFgRzhYTlAnVmxgwm2oFya2GRvfF8WXzuXsGXWc0B59BEmfrT8V1Wlak0eqo3mPEzRzn8r/jBoxSNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516332; c=relaxed/simple;
	bh=aU39Zju7G/ZcjOCuvNg6T7bf9rw418NWUZA0995XVcE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=T57ckb/L9BoXJ6rwASnp5qCztfQiYJs2OATsKnX5hn8ES8HAq9v8C8Zue6L6d/8Y5pI0ps6SoyCbPQfBoWFcpWtJKQ1gzkuzqiywQYcDDnodzg369hZCnoRo3E0bhgKATkH2Fvu9PFXQmlovbIUgx1cNU/rwlNmMXF91ibib4AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=K6eT2fbb; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717516322;
	bh=aU39Zju7G/ZcjOCuvNg6T7bf9rw418NWUZA0995XVcE=;
	h=Date:From:To:Cc:Subject:From;
	b=K6eT2fbbobWaa+xr2vZ6eT0DcOXgNXHgliFL7RjgZzxyr4FN9mQv4GXM2UnnVRi92
	 ZYoS22KtO4ee/+56Q6wtpd4FCD8h9HaBmCskIZs7UIEXUEKswUnKYGlacx91G1s+yM
	 o92NcaGkhDjo5IYD9r01wDI2ezorrJ0yh2Vh+dgGCD+uI27QgYINZIWc/P/UHVtgnM
	 6bP+qFvweKSAkAUMETp3m/eBV2GguEfRjbbmHv8dSUsDYj7py59KENTAUbdzpzyDDy
	 Y+hmfzYcNC1+ju7emtFv1x2vnXKlMr1SuMR9LHs6X8b8IZRkClLWoFXGz7pCqsTMJ7
	 /zNK6mHMk4cGA==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AEA243782196;
	Tue,  4 Jun 2024 15:52:00 +0000 (UTC)
Date: Tue, 4 Jun 2024 11:51:58 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: linux-mediatek@lists.infradead.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Probe failures on mt8183-kukui-jacuzzi-juniper-sku16
Message-ID: <e5912054-0fc9-47ff-8f38-9b9a3e9d2156@notapiano>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

We're monitoring the status of device probe on the
mt8183-kukui-jacuzzi-juniper-sku16 platform in KernelCI, and I thought it'd be
helpful to share the results.

These are the current failures:

* /soc/i2c@11009000/trackpad@15
* /soc/svs@1100bc00
* /thermal-sensor1
* /thermal-sensor2

In more details:

* /soc/i2c@11009000/trackpad@15: I believe this is a second source trackpad and
  is thus waiting for the "platform/chrome: Introduce DT hardware prober" series
  [1] to be merged before it can be handled. Although looks like there haven't
  been updates to the series in a while.

* /soc/svs@1100bc00: On the logs the following is reported:

    SVSB_GPU: cannot get "gpu-thermal" thermal zone

  MT8183 uses the auxadc_thermal driver, which apparently only registers one
  thermal zone (tz 0, for the CPU):

    devm_thermal_of_zone_register(&pdev->dev, 0, mt,
                              &mtk_thermal_ops);

  As a quick hack I changed the 0 to 2, so the GPU thermal zone got registered,
  and that did allow SVS to go further in its probe, but still resulted in an
  error:
  
    [    9.330993] mtk-svs 1100bc00.svs: M_HW_RES0: 0x00320090
    [    9.336700] mtk-svs 1100bc00.svs: M_HW_RES1: 0xa3ffff5f
    [    9.342628] mtk-svs 1100bc00.svs: M_HW_RES2: 0x47cf47cf
    [    9.347898] mtk-svs 1100bc00.svs: M_HW_RES3: 0xa3ffff5f
    [    9.353164] mtk-svs 1100bc00.svs: M_HW_RES4: 0xa3fff1aa
    [    9.358400] mtk-svs 1100bc00.svs: M_HW_RES5: 0x47ec4b82
    [    9.358411] mtk-svs 1100bc00.svs: M_HW_RES6: 0xa3ff9aac
    [    9.358416] mtk-svs 1100bc00.svs: M_HW_RES7: 0xa3ff1c13
    [    9.358420] mtk-svs 1100bc00.svs: M_HW_RES8: 0x4bec4beb
    [    9.358424] mtk-svs 1100bc00.svs: M_HW_RES9: 0xa3ff7b02
    [    9.358429] mtk-svs 1100bc00.svs: M_HW_RES14: 0x06ce7583
    [    9.370719] mtk-svs 1100bc00.svs: M_HW_RES15: 0x00220010
    [    9.381134] mtk-svs 1100bc00.svs: M_HW_RES16: 0xa3ffdf46
    [    9.381141] mtk-svs 1100bc00.svs: M_HW_RES17: 0x47ec47eb
    [    9.391612] mtk-svs 1100bc00.svs: M_HW_RES18: 0xa3ffd443
    [    9.477419]  SVSB_CPU_LITTLE: svs_init01_isr_handler: VDN74~30:0x16202931~0x363b4147, DC:0x02bb0013
    [    9.495313] cpu cpu4: cpu4: failed to find OPP for 1781000000
    [    9.495549]  SVSB_CPU_BIG: svs_init01_isr_handler: VDN74~30:0x16212a33~0x393e444b, DC:0x02d000d0
    [    9.495847]  SVSB_CCI: svs_init01_isr_handler: VDN74~30:0x141b252e~0x33394147, DC:0x02c10049
    [    9.495897]  SVSB_GPU: buck voltage: 700000uV, expected vboot: 800000uV
    [    9.496184] mtk-svs 1100bc00.svs: error -EPERM: svs start fail
    [    9.496204] mtk-svs 1100bc00.svs: probe with driver mtk-svs failed with error -1
  
  so it seems that more changes will be required in addition to updating
  auxadc_thermal to register multiple thermal zones.

* /thermal-sensor1, /thermal-sensor2: The following is reported:

    [    2.813605] thermal_sys: Failed to find 'trips' node
    [    2.813611] thermal_sys: Failed to find trip points for thermal-sensor1 id=0
    [    2.813619] generic-adc-thermal thermal-sensor1: Thermal zone sensor register failed: -22
    [    2.813624] generic-adc-thermal thermal-sensor1: probe with driver generic-adc-thermal failed with error -22

  And the same for thermal-sensor2. So both are missing the required 'trips'
  subnode.

If you have any additional information on these issues please let me know.

Full test results are included below if you're curious.

Note: these results are from today's next: next-20240604

Thanks,
Nícolas


[1] [RFC PATCH v3 0/5] platform/chrome: Introduce DT hardware prober
https://lore.kernel.org/all/20231128084236.157152-1-wenst@chromium.org/
  

TAP version 13
1..1
# timeout set to 45
# selftests: dt: test_unprobed_devices.sh
# TAP version 13
# 1..166
# ok 1 / # SKIP
# ok 2 /backlight_lcd0
# ok 3 /bt-sco
# ok 4 /cci
# ok 5 /cpus/cpu@0 # SKIP
# ok 6 /cpus/cpu@1 # SKIP
# ok 7 /cpus/cpu@100 # SKIP
# ok 8 /cpus/cpu@101 # SKIP
# ok 9 /cpus/cpu@102 # SKIP
# ok 10 /cpus/cpu@103 # SKIP
# ok 11 /cpus/cpu@2 # SKIP
# ok 12 /cpus/cpu@3 # SKIP
# ok 13 /cpus/idle-states/cluster-sleep-0 # SKIP
# ok 14 /cpus/idle-states/cluster-sleep-1 # SKIP
# ok 15 /cpus/idle-states/cpu-sleep # SKIP
# ok 16 /cpus/l2-cache0 # SKIP
# ok 17 /cpus/l2-cache1 # SKIP
# ok 18 /firmware/chromeos # SKIP
# ok 19 /firmware/coreboot
# ok 20 /fixed-factor-clock-13m # SKIP
# ok 21 /max98357a
# ok 22 /mt8183-sound
# ok 23 /opp-table-0 # SKIP
# ok 24 /opp-table-cci # SKIP
# ok 25 /opp-table-cluster0 # SKIP
# ok 26 /opp-table-cluster1 # SKIP
# ok 27 /oscillator # SKIP
# ok 28 /oscillator1 # SKIP
# ok 29 /pmu-a53
# ok 30 /pmu-a73
# ok 31 /pp1200-mipibrdg
# ok 32 /pp1800-mipibrdg
# ok 33 /pp3300-panel
# ok 34 /psci
# ok 35 /regulator-vsys
# ok 36 /regulator0
# ok 37 /regulator1
# ok 38 /regulator2
# ok 39 /regulator3
# ok 40 /regulator4
# ok 41 /regulator5
# ok 42 /regulator6
# ok 43 /reserved-memory/memory@50000000 # SKIP
# ok 44 /reserved-memory/ramoops
# ok 45 /soc
# ok 46 /soc/aal@14010000
# ok 47 /soc/audio-controller@11220000
# ok 48 /soc/audio-controller@11220000/mt8183-afe-pcm
# ok 49 /soc/auxadc@11001000
# ok 50 /soc/ccorr@1400f000
# ok 51 /soc/color@1400e000
# ok 52 /soc/cpu-debug@d410000
# ok 53 /soc/cpu-debug@d510000
# ok 54 /soc/cpu-debug@d610000
# ok 55 /soc/cpu-debug@d710000
# ok 56 /soc/cpu-debug@d810000
# ok 57 /soc/cpu-debug@d910000
# ok 58 /soc/cpu-debug@da10000
# ok 59 /soc/cpu-debug@db10000
# ok 60 /soc/dither@14012000 # SKIP
# ok 61 /soc/dma-controller0@14001000
# ok 62 /soc/dma-controller@14005000 # SKIP
# ok 63 /soc/dsi-phy@11e50000
# ok 64 /soc/dsi@14014000
# ok 65 /soc/efuse@11f10000
# ok 66 /soc/efuse@8000000
# ok 67 /soc/gamma@14011000
# ok 68 /soc/gpu@13040000
# ok 69 /soc/i2c@11005000
# ok 70 /soc/i2c@11007000
# ok 71 /soc/i2c@11007000/touchscreen@10
# ok 72 /soc/i2c@11008000
# ok 73 /soc/i2c@11008000/anx7625@58
# ok 74 /soc/i2c@11008000/anx7625@58/aux-bus/panel
# ok 75 /soc/i2c@11009000
# not ok 76 /soc/i2c@11009000/trackpad@15
# ok 77 /soc/i2c@11009000/trackpad@2c
# ok 78 /soc/i2c@1100f000
# ok 79 /soc/i2c@11011000
# ok 80 /soc/i2c@11016000
# ok 81 /soc/i2c@11016000/ts3a227e@3b
# ok 82 /soc/interrupt-controller@c000000 # SKIP
# ok 83 /soc/interrupt-controller@c530a80 # SKIP
# ok 84 /soc/iommu@10205000
# ok 85 /soc/jpeg-encoder@17030000
# ok 86 /soc/larb@14017000
# ok 87 /soc/larb@15021000
# ok 88 /soc/larb@1502f000
# ok 89 /soc/larb@16010000
# ok 90 /soc/larb@17010000
# ok 91 /soc/larb@1a001000
# ok 92 /soc/larb@1a002000
# ok 93 /soc/mailbox@10238000
# ok 94 /soc/mdp3-ccorr@1401c000 # SKIP
# ok 95 /soc/mdp3-rsz0@14003000 # SKIP
# ok 96 /soc/mdp3-rsz1@14004000 # SKIP
# ok 97 /soc/mdp3-wdma@14006000 # SKIP
# ok 98 /soc/mmc@11230000
# ok 99 /soc/mmc@11240000
# ok 100 /soc/mmc@11240000/qca-wifi@1
# ok 101 /soc/mutex@14016000
# ok 102 /soc/ovl@14008000
# ok 103 /soc/ovl@14009000
# ok 104 /soc/ovl@1400a000
# ok 105 /soc/pinctrl@10005000
# ok 106 /soc/pwm@11006000
# ok 107 /soc/pwm@1100e000
# ok 108 /soc/pwrap@1000d000
# ok 109 /soc/pwrap@1000d000/pmic
# ok 110 /soc/pwrap@1000d000/pmic/keys
# ok 111 /soc/pwrap@1000d000/pmic/mt6358codec
# ok 112 /soc/pwrap@1000d000/pmic/mt6358regulator
# ok 113 /soc/pwrap@1000d000/pmic/rtc
# ok 114 /soc/rdma@1400b000
# ok 115 /soc/rdma@1400c000
# ok 116 /soc/scp@10500000
# ok 117 /soc/scp@10500000/cros-ec-rpmsg
# ok 118 /soc/serial@11002000
# ok 119 /soc/serial@11003000
# ok 120 /soc/serial@11003000/bluetooth
# ok 121 /soc/smi@14019000
# ok 122 /soc/spi@1100a000
# ok 123 /soc/spi@1100a000/tpm@0
# ok 124 /soc/spi@11010000
# ok 125 /soc/spi@11010000/flash@0
# ok 126 /soc/spi@11012000
# ok 127 /soc/spi@11012000/cros-ec@0
# ok 128 /soc/spi@11012000/cros-ec@0/extcon0
# ok 129 /soc/spi@11012000/cros-ec@0/i2c-tunnel
# ok 130 /soc/spi@11012000/cros-ec@0/i2c-tunnel/sbs-battery@b
# ok 131 /soc/spi@11012000/cros-ec@0/keyboard-controller
# ok 132 /soc/spi@11012000/cros-ec@0/typec
# ok 133 /soc/spi@11012000/cros-ec@0/typec/connector@0 # SKIP
# not ok 134 /soc/svs@1100bc00
# ok 135 /soc/syscon@10000000
# ok 136 /soc/syscon@10001000
# ok 137 /soc/syscon@10003000
# ok 138 /soc/syscon@10006000 # SKIP
# ok 139 /soc/syscon@10006000/power-controller
# ok 140 /soc/syscon@1000c000
# ok 141 /soc/syscon@13000000
# ok 142 /soc/syscon@14000000
# ok 143 /soc/syscon@15020000
# ok 144 /soc/syscon@16000000
# ok 145 /soc/syscon@17000000
# ok 146 /soc/syscon@19000000
# ok 147 /soc/syscon@19010000
# ok 148 /soc/syscon@19180000
# ok 149 /soc/syscon@19280000
# ok 150 /soc/syscon@1a000000
# ok 151 /soc/syscon@c530000
# ok 152 /soc/t-phy@11f40000
# ok 153 /soc/thermal-sensor@1100b000
# ok 154 /soc/timer@10017000 # SKIP
# ok 155 /soc/usb@11201000
# ok 156 /soc/usb@11201000/usb@11200000
# ok 157 /soc/usb@11201000/usb@11200000/hub@1
# ok 158 /soc/video-codec@16020000
# ok 159 /soc/watchdog@10007000
# not ok 160 /thermal-sensor1
# not ok 161 /thermal-sensor2
# ok 162 /timer # SKIP
# ok 163 /vddio-mipibrdg
# ok 164 /volume-buttons
# ok 165 /wifi-pwrseq
# ok 166 /wifi-wakeup
# # Totals: pass:127 fail:4 xfail:0 xpass:0 skip:35 error:0

