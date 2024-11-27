Return-Path: <linux-kernel+bounces-423211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62229DA464
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB94128217D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AAF1917C2;
	Wed, 27 Nov 2024 09:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="ewjAQr6U"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23697190063;
	Wed, 27 Nov 2024 09:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732698178; cv=none; b=b94Tx2vDgAKVnD55m5qdYr1EYmOIpJOG+Gc92D7TLziH7+NjaMuarJbC5nXLXI2qTzQVFuUYeJAz14T+ACkEO3TvLtsI//UY4BHMT9jVs7P97eTvAvhJu8gEAjp4i2rIZcOVQcU3VXxst2RmmGiK8B0Wa6tCBDmkxu0OzZiIb2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732698178; c=relaxed/simple;
	bh=xmm7RsqS3T6XMGrZAEdjQZ/IDfHlUDvR/7Er1sgv5QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AekS5TVhkqNWRa08/Z+u5FyKhj+7Jke9zm13pVjWVJojJAPAERgBZxI5RWWnud7J20XMTjnqKqybUhDPYAvPJgv/+CylYd9phOm881PZH2EtAOrwyGsp2R86kTZljvGwAkmOF6KZI9kvt7uhoR7WiA8aRJpPhCuqyypz99wfzig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ewjAQr6U; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5xYFbeCB+e6OAmBPgxWC1aBOZF+pwN3ehhO4OEzGRVY=; b=ewjAQr6UFywEDO7kuHOtJAXJTt
	Un7LL0hV4c1nn5RZMNaYxHVlfYH/LxT3YT0sQyOWXirqP0w1jEXIvcg92jxatSJi63+64knMALY6g
	o2QKO8YUL2JmZRdqIawTGYEjr/26SfJxCmax2fL0JijP/sOBm3xGHX1F9xU0qMx6fV9OXv35DuP3E
	8aORms2QZEMV9dc/U3TZgO3NegubmyiyoPcmKa6uEop9Llx3NeldkIvfi6uYj5NHf4WyENHeI/Xo4
	rb3Rqni2lHGw1SarKUr4ttOM9MLAwLtrkw7bhTyey7kv1F4HeFZGLmvwxv7uuItq4bhq6ye0/tw1x
	8MDzd7LQ==;
Received: from i5e86190f.versanet.de ([94.134.25.15] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tGDwd-0006eh-Pp; Wed, 27 Nov 2024 10:02:47 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 rfoss@kernel.org, vkoul@kernel.org, sebastian.reichel@collabora.com,
 cristian.ciocaltea@collabora.com, l.stach@pengutronix.de,
 andy.yan@rock-chips.com, hjc@rock-chips.com, algea.cao@rock-chips.com,
 kever.yang@rock-chips.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, Damon Ding <damon.ding@rock-chips.com>
Subject:
 Re: [PATCH v1 10/10] arch64: dts: rockchip: Enable eDP0 display on RK3588S
 EVB1 board
Date: Wed, 27 Nov 2024 10:02:46 +0100
Message-ID: <2485598.jE0xQCEvom@diego>
In-Reply-To: <20241127075157.856029-11-damon.ding@rock-chips.com>
References:
 <20241127075157.856029-1-damon.ding@rock-chips.com>
 <20241127075157.856029-11-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Damon,

Am Mittwoch, 27. November 2024, 08:51:57 CET schrieb Damon Ding:
> Add the necessary DT changes to enable eDP0 on RK3588S EVB1 board.
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> ---
>  .../boot/dts/rockchip/rk3588s-evb1-v10.dts    | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts
> index bc4077575beb..67c2e6d1bece 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/soc/rockchip,vop2.h>
>  #include <dt-bindings/usb/pd.h>
>  #include "rk3588s.dtsi"
>  
> @@ -116,10 +117,56 @@ masterdai: simple-audio-card,codec {
>  
>  	backlight: backlight {
>  		compatible = "pwm-backlight";
> +		brightness-levels = <
> +			  0   1   2   3   4   5   6   7
> +			  8   9  10  11  12  13  14  15
> +			 16  17  18  19  20  21  22  23
> +			 24  25  26  27  28  29  30  31
> +			 32  33  34  35  36  37  38  39
> +			 40  41  42  43  44  45  46  47
> +			 48  49  50  51  52  53  54  55
> +			 56  57  58  59  60  61  62  63
> +			 64  65  66  67  68  69  70  71
> +			 72  73  74  75  76  77  78  79
> +			 80  81  82  83  84  85  86  87
> +			 88  89  90  91  92  93  94  95
> +			 96  97  98  99 100 101 102 103
> +			104 105 106 107 108 109 110 111
> +			112 113 114 115 116 117 118 119
> +			120 121 122 123 124 125 126 127
> +			128 129 130 131 132 133 134 135
> +			136 137 138 139 140 141 142 143
> +			144 145 146 147 148 149 150 151
> +			152 153 154 155 156 157 158 159
> +			160 161 162 163 164 165 166 167
> +			168 169 170 171 172 173 174 175
> +			176 177 178 179 180 181 182 183
> +			184 185 186 187 188 189 190 191
> +			192 193 194 195 196 197 198 199
> +			200 201 202 203 204 205 206 207
> +			208 209 210 211 212 213 214 215
> +			216 217 218 219 220 221 222 223
> +			224 225 226 227 228 229 230 231
> +			232 233 234 235 236 237 238 239
> +			240 241 242 243 244 245 246 247
> +			248 249 250 251 252 253 254 255>;

manual brightness-levels shouldn't be needed anymore and the backlight
can create those automatically.

So both the brightness-levels and default-brightness-level should be able
to go away?

> +		default-brightness-level = <200>;
>  		power-supply = <&vcc3v3_lcd_edp>;
>  		pwms = <&pwm12 0 25000 0>;
>  	};
>  


Heiko



