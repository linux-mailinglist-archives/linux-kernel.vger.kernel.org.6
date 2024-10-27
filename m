Return-Path: <linux-kernel+bounces-383601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C409B1DD4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B97281B14
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 13:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AC42FE33;
	Sun, 27 Oct 2024 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=zillerbaer@gmx.de header.b="PHOqhN0U"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C523F370
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 13:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730035983; cv=none; b=LV6dNvftEilvOD0edlf6tjadAAindZ8sX/W3EH7LRzQGf5ZBbhcRayApd2+tSNXwb3hwGFEe+A++sFSfrkD272029ZK+FtK4rFly0D8xyXU/pzp/1FD3VHMa02PlHE3pa9Hyn8NfZTLG/GNntHqeeaQCdw/9TFoiLVrvWYvU+Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730035983; c=relaxed/simple;
	bh=Z4vq4XiAVJ+SVe00yOMPKY7LGZbqb+bkTXyrRPPv3+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n5mx7aNXIvweFiuyhWc4LSHr6oJsOtJ3vLjvRimPkC6lvplPdjOG1c5nflVKh2ersk5yf9V5U1zxo/9inCJv7g/ImkTQR0wu7F1X+58hEvWwru01/Rx95NskaBZDb+jA22y1+7RYTcLh1onDyAgbBmA0vbBpBHRdlXPQrvqJqaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=zillerbaer@gmx.de header.b=PHOqhN0U; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730035953; x=1730640753; i=zillerbaer@gmx.de;
	bh=CRby7dmwgTF0ikgqeJhgwhCuPsnBA2ft/jZDlJBhkmE=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PHOqhN0USMrb0agtbMuwVxj/nCIfycdeCg3UFfunRgtkmOGOM1LG/ky/oSi28uZY
	 bBgzrUKLrfDQjIkp3MF2rf4w3hNS1tp94wyGHmYnQr+izNeUKhMK+QNBekEPAr7oK
	 /nDx4OhBpDyr/9oW4a4HZGPJcWaDS/Tju0T3bTGwh1/AVWO+0OyAXHV+SHQdVQHIg
	 9MepWMSofkqc4UlgJVe4b/VZglwAeW89wiuYoOxYUWVSO/2bpzusG7Aek7JLKwu4l
	 8MyKsoI5WQqeF7LqE8wXLE1kV3SjVZG7tGF7UK5v6SaUtSlDrWbde7Jlt7gyvA6+P
	 u4uvyuj0q+Kia6HBjA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from schleppi.lan ([91.14.228.167]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtfNl-1tsMLm0o4F-00yCgE; Sun, 27
 Oct 2024 14:32:33 +0100
Date: Sun, 27 Oct 2024 14:32:19 +0100
From: Jens Ziller <zillerbaer@gmx.de>
To: Shuijing Li <shuijing.li@mediatek.com>
Cc: <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
 <airlied@gmail.com>, <daniel@ffwll.ch>, <matthias.bgg@gmail.com>,
 <angelogioacchino.delregno@collabora.com>, <jitao.shi@mediatek.com>,
 <dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v2] mediatek: dsi: Correct calculation formula of PHY
 Timing
Message-ID: <20241027143219.56e7b4d0@schleppi.lan>
In-Reply-To: <20240412031208.30688-1-shuijing.li@mediatek.com>
References: <20240412031208.30688-1-shuijing.li@mediatek.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xcy5zVxWCRLQ6wQYRLlEEyAXQMtxxOLf8Uy67bys0mFVHke0mm0
 eW87nZYvbJeWK0bXYf0/H2gbewq0VQXgKnv7sV25mS3FSJoS/3L40FAhSo86M1A9MwHRz1i
 Vp5ykzLWplMIjtpFDWW/9XLXRNBYuBQMb80FDvCL1LWxuHl8vlm87FaF1Ldn5eZiNEhsJMn
 65wOXCM/ak4MdnSCS82zA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QaEgIXRvn+4=;kRhF5hx+fLQztGb6SOdlfogKUX3
 cZ4yacDvl+YE/uQSp3Mgv5FtcwN6NycUvL6odgmEJnGsZUXJqi+UPg+hT6moPiF/O1rNpNSQl
 XHO9KOxWATLLgRL4dhmaT1QLiBoG6iiGvEoqNHvW3jAF4DlgI646eqOSS/EUqfDWtUogabTd2
 KVAYYC3DiXWjrlu2cXSOKZ42DDLVOUgb8gsjMWz1547LIi0b8BN262McVxLlahjniUOXz/1wE
 yUwh1Xqqk5hKZ4fFEAakfQLIzjGT882ElK/Tchy67UEz/0y7d1DrZtIS4BgVVKwJQ9JouH1S0
 x/eiAVMzhQ60GKRinQi0BF/hJX1GDbQl4P+uIYeintg8urbEpVdoy8OVl0YPz6nDkDb0+W5c4
 LxypArRX6RBi3FLov0I4u3ZhHtFtLZXeL/MdL+/MDXJZlfL2YwmxhBMZwKPgyzoh+EAXRzuwQ
 KKZ5DeRR52kufNs71Oviy9TrEx6+Gb/iP3vyNmUUhJzv3evHwdNqgWDneziFB1KV8/S+kZjsR
 6IZrRJMhSyePbRhaaWuabNoY3DC1ZMQMjK9Z5bcxF8q36COPivBAh7PNCdY56mqStlNZm48Xv
 tOPXcVgJRIE1+gpwfLVUbbLWY3RsKVEq63Zll26E2Aja9rJ+vck3+uQ6SttH1FjuzLu+3K34t
 JnW5/A6tD75atEHBJJ9UsUYuQNW2t7wA59dQ4fC4eKQrX404EJ17MvzuGUA/OqFs7h0buzGi5
 hL3R1J8DSXTSYu3cMyL8lS2njdslfQs0ks66XAQB/c1qJuE0n84M1J/jDNkmIwTicRjgJmxAg
 LXpHj0ATkquo83uh4K2vjRWA==


Am Fri, 12 Apr 2024 11:11:39 +0800
schrieb Shuijing Li <shuijing.li@mediatek.com>:

> This patch correct calculation formula of PHY timing.
> The spec define HS-PREPARE should be from 40ns+4*UI(44ns) to
> 85ns+6*UI(91ns). But current duration is 88ns and is near the
> boundary. So this patch make the duration to 64ns so it is near the
> safe range.

Hi Shuijing,

with this patch the panel in the Tentacruel ASUS Chromebook CM14
(CM1402F) flickers. There are 1 or 2 times per second a black panel.
Stable Kernel 6.11.5 and mainline 6.12-rc4 works only when I reverse
this patch. There's a bug inside. Can you please check that?

Best regards
Jens

>
> Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>
> ---
> Changes in v2:
> Add a commit to describe the improvements to this patch in detail,
> per suggestion frome previous thread:
> https://patchwork.kernel.org/project/linux-mediatek/patch/20240315072945=
.19502-1-shuijing.li@mediatek.com/
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 33
> +++++++++++++++--------------- 1 file changed, 17 insertions(+), 16
> deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c
> b/drivers/gpu/drm/mediatek/mtk_dsi.c index a2fdfc8ddb15..d1bd7d671880
> 100644 --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -235,22 +235,23 @@ static void mtk_dsi_phy_timconfig(struct
> mtk_dsi *dsi) u32 data_rate_mhz =3D DIV_ROUND_UP(dsi->data_rate,
> 1000000); struct mtk_phy_timing *timing =3D &dsi->phy_timing;
>
> -	timing->lpx =3D (60 * data_rate_mhz / (8 * 1000)) + 1;
> -	timing->da_hs_prepare =3D (80 * data_rate_mhz + 4 * 1000) /
> 8000;
> -	timing->da_hs_zero =3D (170 * data_rate_mhz + 10 * 1000) /
> 8000 + 1 -
> -			     timing->da_hs_prepare;
> -	timing->da_hs_trail =3D timing->da_hs_prepare + 1;
> -
> -	timing->ta_go =3D 4 * timing->lpx - 2;
> -	timing->ta_sure =3D timing->lpx + 2;
> -	timing->ta_get =3D 4 * timing->lpx;
> -	timing->da_hs_exit =3D 2 * timing->lpx + 1;
> -
> -	timing->clk_hs_prepare =3D 70 * data_rate_mhz / (8 * 1000);
> -	timing->clk_hs_post =3D timing->clk_hs_prepare + 8;
> -	timing->clk_hs_trail =3D timing->clk_hs_prepare;
> -	timing->clk_hs_zero =3D timing->clk_hs_trail * 4;
> -	timing->clk_hs_exit =3D 2 * timing->clk_hs_trail;
> +	timing->lpx =3D (80 * data_rate_mhz / (8 * 1000)) + 1;
> +	timing->da_hs_prepare =3D (59 * data_rate_mhz + 4 * 1000) /
> 8000 + 1;
> +	timing->da_hs_zero =3D (163 * data_rate_mhz + 11 * 1000) /
> 8000 + 1 -
> +		timing->da_hs_prepare;
> +	timing->da_hs_trail =3D (78 * data_rate_mhz + 7 * 1000) / 8000
> + 1; +
> +	timing->ta_go =3D 4 * timing->lpx;
> +	timing->ta_sure =3D 3 * timing->lpx / 2;
> +	timing->ta_get =3D 5 * timing->lpx;
> +	timing->da_hs_exit =3D (118 * data_rate_mhz / (8 * 1000)) + 1;
> +
> +	timing->clk_hs_prepare =3D (57 * data_rate_mhz / (8 * 1000)) +
> 1;
> +	timing->clk_hs_post =3D (65 * data_rate_mhz + 53 * 1000) /
> 8000 + 1;
> +	timing->clk_hs_trail =3D (78 * data_rate_mhz + 7 * 1000) /
> 8000 + 1;
> +	timing->clk_hs_zero =3D (330 * data_rate_mhz / (8 * 1000)) + 1
> -
> +		timing->clk_hs_prepare;
> +	timing->clk_hs_exit =3D (118 * data_rate_mhz / (8 * 1000)) + 1;
>
>  	timcon0 =3D timing->lpx | timing->da_hs_prepare << 8 |
>  		  timing->da_hs_zero << 16 | timing->da_hs_trail <<
> 24;


