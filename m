Return-Path: <linux-kernel+bounces-432841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D66509E50EA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 910D028C768
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8451B1DB95D;
	Thu,  5 Dec 2024 09:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QH3tFh7l"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ECB1D54FE;
	Thu,  5 Dec 2024 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733389882; cv=none; b=ReN9CfLNWHwpQwY83xbH5JBr0pJIU2la6gQJF2UKeHvJQnCWJkcmM4fD0RLxl9iBbu9ktl4O68zMY7o3S/DHSHNnSyUQ0o0EdVtSNMy7GKLy4byxOzQyJUAq9Crvft1tzWWWVsMkoj7dlntmgC9tj4/CgdlpHrkuVc6sFNYB8Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733389882; c=relaxed/simple;
	bh=gbRvMBWecchVXZQINpiNcELmH4AXFji5mB9ZcmAb+ck=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gIH3ipX1fjda/MgM1Me+whLmk6Toc9Ugp8z+jLr8dZmDi0eXdDNB5cFzkaHygK38ilHHk1L7L6KhgMf/ek6MeNRGIr8Y2kVnjxgPX7wFYPBTjBIXcJwD3ymDX2JMQ4d9+Du76jqagMkNGzNSXuF6MmpBa9zv0AIqwgIrV0XfIgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QH3tFh7l; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ffa8df8850so6275501fa.3;
        Thu, 05 Dec 2024 01:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733389879; x=1733994679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g70770pHl/BwAdcq7mSKVqhSUdxEsRQhDHwPhr+/2R0=;
        b=QH3tFh7ldvanhIEUWz/nccMcwYxYZMG7K7cC7rncbcO2mblyaqipTz4TKFwqz9Xczl
         2KsoCgIV0BIiWC3AjfbM9/2bK1GKQpcYCQo6IR4ah9T103LKnhvpOEkM8mdsMH1ib8Ee
         FRFa22qecYF+sSQKik3+ZbFwHqkitqq2EwkDJFrT7sGYWoTHGMwQ6G29CZQtmHvEnrzE
         h79ydj49UL51yjZuXESNIaOLYZIMlaAFGevPQ+Jw3Rh56XovYOZsR/MZ8nn1QWc6NsDP
         CKsvnH3/DvsELyYXQLNduZ7ZW9sYwAo3g/JcdKYMu0vNam0MkNzFcoGye8Le/730Fubg
         L0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733389879; x=1733994679;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g70770pHl/BwAdcq7mSKVqhSUdxEsRQhDHwPhr+/2R0=;
        b=vV9SaLdau/DTKsMMjpRRLRBuWvoF3rwDJh0g2AClhx/i3ohleQ4b038MYkez6oSObY
         YxVM6j/87OEI2CkLH4abr3UnVabkW6eIaEY41/hHFavh9mP5tMLFKbtjdc9yf9W0TAM1
         kXal45/Tm74yfSJfaqod49p4JrUJdH9i4LGESdCRtKKh60StXBOP85syEAzc1OgkeSgy
         4qGSpUTBag2cpy55XC4cfmmfTs/30vt/uZYY1kRlvoDW/XKnp3Ypa58Df31YKHYzu3H4
         YKCxo7PWrj3wtr4uLa7PiFT+8UNZUs2fuF8i0g2266+PIoxZjFhj36tzlPDvV2h+2B2+
         yarQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbv/amBAVbhPtjYnHJ/4MR/UfoysmdizpGc3SBtan2CBEAEqD4H41jeEfi5h+NZRccBHoC6se+R8SU@vger.kernel.org, AJvYcCXjJ7DbZ4jTGxDXWHLO33SYLat3nHhXqt2vh2mCpKPH7YyCBgOWGG4zebKrwFSY19FHMXcvsuSlEXv4GcfR@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjk3KvMf+Ix6L/m0nlsD9AMx5H6GTmyzFH6cNufijY2r49SIN1
	BT5zNmJ/vWbXrcijIoiNN2fHK8SBTctK/xEDVhoU+QoWiK5U0QVy
X-Gm-Gg: ASbGnctjkZRY0FO1zwjRPOimr4Fil29JNXtEVpvTlM4WK7bhjSJY3bCTPp4rk5VeZBJ
	BnZZ7wcKcr+4Lr/km7rsXHtdDN7rbQmsvmHixbgXvxWxaaUl/bWSc4zE1zld334BQQxR33LX0+L
	0LhlIm1h9L1Jwrk9AZ+ikSbgekCAkjRkPHAwvuv2cd2eSHX6xbr/wxcuoyaa4J7vTdRX4feS6wk
	cncahtI3VnzOPhCN8iflIm5azUxoz4t2C/a/v7ZOVixU7rJJmDmOg==
X-Google-Smtp-Source: AGHT+IFZ6+YRR3jm0gV75fejVmMXL5MRbl//2N9aoRFrmHGjZdJU9MYPNc36DsVVHcoZY+7LCJrMXw==
X-Received: by 2002:a2e:8e84:0:b0:300:18fc:8e55 with SMTP id 38308e7fff4ca-30018fc906cmr21853361fa.2.1733389879024;
        Thu, 05 Dec 2024 01:11:19 -0800 (PST)
Received: from [192.168.0.107] ([91.90.219.38])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020da1182sm1586511fa.35.2024.12.05.01.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 01:11:18 -0800 (PST)
Message-ID: <6c8e60a1-820b-4818-ad68-9b042533f4f9@gmail.com>
Date: Thu, 5 Dec 2024 14:06:27 +0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Dmitry Yashin <dmt.yashin@gmail.com>
Subject: Re: [PATCH v3 0/3] drm/rockchip: Add driver for the new DSI2
 controller
To: Heiko Stuebner <heiko@sntech.de>
Cc: andy.yan@rock-chips.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 quentin.schulz@cherry.de, Dmitry Yashin <dmt.yashin@gmail.com>
References: <20241203165450.1501219-1-heiko@sntech.de>
Content-Language: en-US
In-Reply-To: <20241203165450.1501219-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Heiko,

On 03.12.24 21:54, Heiko Stuebner wrote:
> This series adds a bridge and glue driver for the DSI2 controller found
> in the rk3588 soc from Rockchip, that is based on a Synopsis IP block.
>
> As the manual states:
> The Display Serial Interface 2 (DSI-2) is part of a group of communication
> protocols defined by the MIPI Alliance. The MIPI DSI-2 Host Controller is
> a digital core that implements all protocol functions defined in the
> MIPI DSI-2 Specification.
>
>
> While the driver structure is very similar to the previous DSI controller,
> the programming model of the core is quite different, with a completely
> new register set.
>
> Another notable difference is that the phy interface is variable now too
> in its width and some other settings.

Thanks for the series. I was able to get output on my Radxa's Rock 5B
(dsi1) + Radxa's 10FHD Display setup. Works smoothly with multiple DE's,
rotation and display on/off.

Tested-by: Dmitry Yashin <dmt.yashin@gmail.com>

-- 
Thanks,
Dmitry


