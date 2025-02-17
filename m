Return-Path: <linux-kernel+bounces-517902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C55AA3872F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ADD2188549A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FA4148FE6;
	Mon, 17 Feb 2025 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gHilSf7E"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F66020328
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739804617; cv=none; b=LaCJJJhCzNmGAB0eB2I1xL13ds/lpYA0EW9cZjtBTrxBqcQn0W9ooKAPz9A2NTdOjm1zJuCT4MyZ6J993j4oeHAsv69nk9IPO4GQWKtImwvapsNZthqkLlitA6Z++CW0ILPXnfvq1ADKJOgHDgClWKE2oA/HIOKvjwB7kLEGamM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739804617; c=relaxed/simple;
	bh=2Bnqjdrs4NrL2XwBqyj7ZH51u494tNn1vFc5fmPIAAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QvXDc2VNcXff2ipy6Ac+ulcCgo9SkZ9KLd2gBci+iDU4UEvEyRwcYFyX+zG3TTzsrH7vYwKnqP/sCCZAxhIWlHIzw3luqSDH6ej2DJGMSb8Dij3EL+5GLFWOx0fOn9WaHXT/XINMB4aXGf1opAsBLQuuz7+klTxQAU+tMxpI8rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gHilSf7E; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54622829175so923253e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 07:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739804613; x=1740409413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=//GayiTjk2VgwOuQxZT0tXCo12hznJ8fyvNG07N/o2g=;
        b=gHilSf7EgOvEMq6RRwtk1A/ZIXFfHIqpwAOOkvvOGcxdTAzUD4iBy4tNEvQ6Ys0Z6t
         sUKkki0Cdi8T64dXfQQd9lziA12uSpStY0YZye/il68omRudrcr5iLcmvPMTPSY9/JaZ
         Szyd3xp1fUePA6uotrOYiVSSiCfv5kzZ+Zl0Dx+aYd2hXpceqogjN+68e8JtaQ44Z7/g
         ewoKJfBgzbuivVMsSua0OOL3dLdWafdXr0VwxAM8zvSwgJhIE6txpZuylZGAW5aoW5i2
         nY4myRsr6m5wFm/j93EPCBJkL+Xl9rYXsd68QA7wxB0CEbsaL1q/aF3dlkKlU1YQHJku
         d4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739804613; x=1740409413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=//GayiTjk2VgwOuQxZT0tXCo12hznJ8fyvNG07N/o2g=;
        b=FRTSQy8/zGjRIViP7ktmaMD89PQ1byeCKoGOgR6PxVU0W6nGACOc0oCdS15my44Vga
         qy6UmdxI70oAYlrf423UtW+4HjXuMoyGZJt2tazmfqjNmFYnF0PhvOT75PdpPxe5l8re
         6Fpa16nWL152zx3WJluDenHGHkf5Fm2gci8eQGiTWyk+IeXnMhl1zEqzSI97nRruEGQ0
         O3Rm3sG4Rox3jBp/bDc8rJsPWOaJGCrUkOc+eDQAJPzFr8FrdFCB5AvRzoRNVx69YcNU
         Lm3kW0B12mNW58WH+B1l0G5UJNBkCNRDm+/m7jw4cf4j1nv/nwjZv2tdSNfvAJl9KsJh
         r65w==
X-Forwarded-Encrypted: i=1; AJvYcCU3Gh6cLMzIKWvz/hhRmKS/PmtBcpyQYNRStip7rYMRgEj+bKTacF3FzfwxFC0qo30LNB538cLO3s7G/Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXsvdakVZLgTvy8WCxevmdWGUcjQxg3B60BmBw3VZaQsaVN6VG
	ICHL/kdu3+sG5hKwW4608tQi+CqlbsWRfz4NJzIl9VoeDsPcfCyIFSdb801QAunwg1dqH7RNa/t
	4QEU=
X-Gm-Gg: ASbGncuhHdPhFdkSQb/1pSFEBK+ejghHz2RDXJFOWU0kZJ7wCWvt4gI21lBq+QfUtxW
	ZXDwVWBPxRaD6sSyEQ9mJCTnxytXek46WgHqSWvhGmkTQpnvnv8SNAXS5bOuUdj/VMETq8Kfs8D
	hhkY2/q95P5Qb1yiiWdbGEKNAvsK0tgky8doog4ZwCVZ2WG2Q1kGvbXIy9s/t3qvSm352DzddLK
	zbH5fAFpniwYuAeI1TfUCxJBsvdpsS1VUsrbtXOmdpCkpStt5ew4csyK5RelaHPk3C7SCNMFrQz
	rKm2n+g1mGpMtXim5BtBWwZcQdSzUjTcseQgC/d7rYoWibUvqo6vZil4BjMgtEI=
X-Google-Smtp-Source: AGHT+IF9JYqSQ6ntE3558qRENvEigRRMYqxdMfCUuklz4yeVdCf7BoSLXDiwqfmV2TzwBrbwiuonQQ==
X-Received: by 2002:a05:6000:1f87:b0:38f:23f4:2d7a with SMTP id ffacd0b85a97d-38f33f43751mr9709394f8f.40.1739804602180;
        Mon, 17 Feb 2025 07:03:22 -0800 (PST)
Received: from ?IPV6:2a01:e0a:5ee:79d0:9c3e:a06c:91d9:c06b? ([2a01:e0a:5ee:79d0:9c3e:a06c:91d9:c06b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b412esm12273223f8f.1.2025.02.17.07.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 07:03:21 -0800 (PST)
Message-ID: <79477810-00a9-47f1-8282-f8077ea082bb@baylibre.com>
Date: Mon, 17 Feb 2025 16:03:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/6] drm/mediatek: dsi: Improves the DSI lane setup
 robustness
To: =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
Cc: "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
 "simona.vetter@ffwll.ch" <simona.vetter@ffwll.ch>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "will@kernel.org" <will@kernel.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "simona@ffwll.ch" <simona@ffwll.ch>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 =?UTF-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
 "robh@kernel.org" <robh@kernel.org>
References: <20231023-display-support-v7-0-6703f3e26831@baylibre.com>
 <20231023-display-support-v7-2-6703f3e26831@baylibre.com>
 <ab3bd050c873bb6cecc00b615b938eabc157cb49.camel@mediatek.com>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <ab3bd050c873bb6cecc00b615b938eabc157cb49.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi CK.

On 17/02/2025 08:56, CK Hu (胡俊光) wrote:
> On Fri, 2025-01-10 at 14:31 +0100, Alexandre Mergnat wrote:
>> External email : Please do not click links or open attachments until you have verified the sender or the content.
>> 
>> 
>> Currently, mtk_dsi_lane_ready (which setup the DSI lane) is triggered
>> before mtk_dsi_poweron. lanes_ready flag toggle to true during
>> mtk_dsi_lane_ready function, and the DSI module is set up during
>> mtk_dsi_poweron.
>> 
>> Later, during panel driver init, mtk_dsi_lane_ready is triggered but does
>> nothing because lanes are considered ready. Unfortunately, when the panel
>> driver try to communicate, the DSI returns a timeout.
>> 
>> The solution found here is to put lanes_ready flag to false after the DSI
>> module setup into mtk_dsi_poweron to init the DSI lanes after the power /
>> setup of the DSI module.
> 
> I'm not clear about what happen.
> I think this DSI flow has worked for a long time.
> So only some panel has problem?

I don't know if it's related to a specific panel or not.

> 
> And another question.
> Do you mean mtk_dsi_lane_ready() do some setting to hardware, but lane is not actually ready?

The workflow should be:
... | dsi->lanes_ready = false | Power-on | setup dsi lanes | dsi->lanes_ready = true (to avoid 
re-do dsi lanes setup) | ...

I observe (print function name called + dsi->lanes_ready value):

[    9.086030] mtk_dsi_probe 0
[    9.662319] mtk_dsi_host_attach 0
[    9.662941] mtk_dsi_encoder_init
[    9.984685] mtk_dsi_poweron 0
[   10.043755] mtk_dsi_host_transfer 0
[   10.043769] mtk_dsi_lane_ready 0
[   10.055837] mtk_dsi_host_transfer 1
[   10.055853] mtk_dsi_lane_ready 1
[   10.179788] mtk_dsi_host_transfer 1
[   10.179803] mtk_dsi_lane_ready 1
[   10.179880] mtk_dsi_host_transfer 1
[   10.179885] mtk_dsi_lane_ready 1
[   10.179920] mtk_dsi_host_transfer 1
[   10.179923] mtk_dsi_lane_ready 1
[   10.179986] mtk_dsi_host_transfer 1
[   10.179993] mtk_dsi_lane_ready 1
[   10.180134] mtk_dsi_host_transfer 1
[   10.180143] mtk_dsi_lane_ready 1
[   10.180175] mtk_dsi_host_transfer 1
[   10.180178] mtk_dsi_lane_ready 1
[   10.180223] mtk_dsi_host_transfer 1
[   10.180226] mtk_dsi_lane_ready 1
[   10.180245] mtk_dsi_host_transfer 1
[   10.180248] mtk_dsi_lane_ready 1
[   10.180278] mtk_dsi_host_transfer 1
[   10.180280] mtk_dsi_lane_ready 1
[   10.180312] mtk_dsi_host_transfer 1
[   10.180314] mtk_dsi_lane_ready 1
[   10.203774] mtk_dsi_bridge_atomic_pre_enable
[   10.203787] mtk_dsi_poweron 1
[   10.203793] mtk_output_dsi_enable
[   10.203795] mtk_dsi_lane_ready 1
[   10.471517] mtk_dsi_host_transfer 1
[   10.486962] mtk_dsi_lane_ready 1
[   10.487244] mtk_dsi_host_transfer 1
[   10.503733] mtk_dsi_lane_ready 1

Here the mtk_dsi_lane_ready function:

	static void mtk_dsi_lane_ready(struct mtk_dsi *dsi)
	{
		if (!dsi->lanes_ready) {
			dsi->lanes_ready = true;
			mtk_dsi_rxtx_control(dsi);
			usleep_range(30, 100);
			mtk_dsi_reset_dphy(dsi);
			mtk_dsi_clk_ulp_mode_leave(dsi);
			mtk_dsi_lane0_ulp_mode_leave(dsi);
			mtk_dsi_clk_hs_mode(dsi, 0);
			usleep_range(1000, 3000);
			/* The reaction time after pulling up the mipi signal for dsi_rx */
		}
	}


As you can see, something call "mtk_dsi_bridge_atomic_pre_enable" then mtk_dsi_poweron is called a 
second time. This issue is probably due to the probe order (race condition).
After all, IMHO, after a poweron, the registers status should be consider as unknown (or at least HW 
default value), so, lanes setup has to be done. This solution improve the driver's robustness.


> Or mtk_dsi_lane_ready() configure the hardware and lane is is actually ready,
> but something make it not ready again, what's the thing which break lane ready?
> 
> If this is a bug fix, add Fixes tag.
> 
> Regards,
> CK
> 
>> 
>> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
>> ---
>>  drivers/gpu/drm/mediatek/mtk_dsi.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
>> index e61b9bc68e9a..dcf0d93881b5 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
>> @@ -724,6 +724,8 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
>>         mtk_dsi_config_vdo_timing(dsi);
>>         mtk_dsi_set_interrupt_enable(dsi);
>> 
>> +       dsi->lanes_ready = false;
>> +
>>         return 0;
>>  err_disable_engine_clk:
>>         clk_disable_unprepare(dsi->engine_clk);
>> 
>> --
>> 2.25.1
>> 
> 
> 
> ************* MEDIATEK Confidentiality Notice
>   ********************
> The information contained in this e-mail message (including any
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be
> conveyed only to the designated recipient(s). Any use, dissemination,
> distribution, printing, retaining or copying of this e-mail (including its
> attachments) by unintended recipient(s) is strictly prohibited and may
> be unlawful. If you are not an intended recipient of this e-mail, or believe
>   
> that you have received this e-mail in error, please notify the sender
> immediately (by replying to this e-mail), delete any and all copies of
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!
> 

-- 
Regards,
Alexandre

