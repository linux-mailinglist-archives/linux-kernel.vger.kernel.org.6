Return-Path: <linux-kernel+bounces-376060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AF89A9F67
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2190C1F23D0B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057D11991CC;
	Tue, 22 Oct 2024 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cf0qjZCA"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD2A199236
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729591072; cv=none; b=tYN2Z2ABOOzPlkLrL13knVmTbw7uTlkonu4Uw8VUdp5cB+ibKXpkXTQ8hdmi8GKQNA4efY7OYepE4tU9+hALF0hzWnFxg1N5DgL2rOtspU//aZaDPJzAJ4t6Bo5FbCqeXitAe5pbQJbAdAx62j6matA0fDVkb3EBpIqBeaPUr/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729591072; c=relaxed/simple;
	bh=Z6dKNwVETYKa4690g17q5VlS/mmQvHhfpIjCFuk8s2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryMXQDM0Cp9imP9PijL53MEJraHnaO3mQ/fZzDCPBEPiEjs3Mps1fn++J9ldzwOFD1cOAzI+OTjG9GNV4zahKvfSVrnFYIUxsBjvZu04LphuwiLpMnOZcqwe273ZSxLKNxe41pDUHpP3jICCtkgcxDnz6R4QyRjX7fDwmlIupnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cf0qjZCA; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so7202044e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 02:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729591068; x=1730195868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HvTNyLNGAHIQ6cpxYTM3zWA6pjUJiTbrO2qEq3VuoYw=;
        b=cf0qjZCA0KSByW+TG9sIpgT8hhcKYEcg58y34rv7GLwquMdsHLBJIzm+2nYqY4aGRg
         PvtGF6QrGspqES7yQY5N+gIxZMK1KcfMwr4clar2OPCOIPB7X4hxVUfFsabQEiUe/Nkh
         1BMf4IRyvGTLbeN8ufihN+d/+sUem9KVZ2zH8jOUIy5TjacS7Y5c7Yg9lzum+1hwPvI2
         RhAdubp8vXEsZ+21Seukv0eai1g/PB5Lj/nyNinwqQLEB6rjn8mN3YS0RNUuW+n5Zw9e
         d+PLTVR6MZZxcZ2vrdHuG6L3UF2e1IEP8JaL6768JTj1+ZPWMBoiWl1UQ1hRZjkzn+Pp
         sf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729591068; x=1730195868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvTNyLNGAHIQ6cpxYTM3zWA6pjUJiTbrO2qEq3VuoYw=;
        b=TUIWhzKzl8ZcX9hRwggg40JCpPgQ+DS+iP1FJnhJpkXnX4WWkN5jw/ruTNiAHANB13
         LhHWPLMPv/VCL+vLJ2WYKxM1pzZTfCKaivdQuyxyGLrNG6LUr8P5LhcEp8ZVNbjpFy6k
         GnMANfFNNlWZTDk5lQvMK5tkXrOiaQTTi9tTDnjHCejHcpLPV14RCFwYDlZ6A9MhkTMP
         M83aXUENTuYGz1Z7K490vGQazA7UWS6ZbMj31F0dNfXWv7VkP2A4q5TADxDmWKeC5KBo
         GY7RLgnT9MMPA4nTdty3NIC/PZQmysawmopHVbMsCjhE6yIr/a5HSEzg2B/HStvDMgbs
         SFqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnfjPNaMLKdjjrFS2dDojNf8cQwoCCrNHshJAMxxq9i/MpqixgUlkxUJRMQbit02wD3DrBviy39o2tmNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfRiXOlONf0qDeBbOq2pkxmDMlndLmVzihSw/uHdk2GN55HGec
	wsiecYxx32z9vRPW+eT3JM7Ra+QFWARR8sTrYb+hdJ8B/0k4gyTqRhV3FR+KlSuVpzhbFaYDpF0
	9
X-Google-Smtp-Source: AGHT+IHVu91T26e5E//xB6XfjAMTT+PWPADj71F+BMcbekDOXThdc77eC6SbwTZMrGx5Pm1w5zcDNg==
X-Received: by 2002:a05:6512:220a:b0:539:da76:c77e with SMTP id 2adb3069b0e04-53a1520bd15mr6361012e87.5.1729591067825;
        Tue, 22 Oct 2024 02:57:47 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223efbcesm728504e87.72.2024.10.22.02.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 02:57:47 -0700 (PDT)
Date: Tue, 22 Oct 2024 12:57:45 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: kvalo@kernel.org, quic_jjohnson@quicinc.com, 
	ath11k@lists.infradead.org, linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] wifi: ath11k: add firmware-name device tree property
Message-ID: <smgbishqbin4kcpshqvue3ivvfko2l6rj2w4ikwydosbkq6kde@pdbzhklj7znm>
References: <20241001033053.2084360-1-quic_miaoqing@quicinc.com>
 <20241001033053.2084360-3-quic_miaoqing@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001033053.2084360-3-quic_miaoqing@quicinc.com>

On Tue, Oct 01, 2024 at 11:30:52AM +0800, Miaoqing Pan wrote:
> QCA6698AQ uses different firmware/bdf/regdb with existing WCN6855
> firmware, which is customized for IoE platforms. And the 'pci-device-id +
> soc-hw-version + soc-hw-sub-version' may not be enough to identify the
> correct firmware directory path.

Why is it so? What makes it so different from the existing platforms
that you can not use WCN6855 firmware?

> 
> The device tree allows "firmware-name" to define the firmware path,
>     wifi@c000000 {

You are describing platform node, while the commit message talks about
the PCIe devices. Could you please clarify, whether it is a PCIe device
or an AHB device?

>         firmware-name = "QCA6698AQ";

Could we please follow the approach that has been defined in the commit
5abf259772df ("wifi: ath10k: support board-specific firmware
overrides")? In other words, instead of creating another directory under
ath11k, create a subdir under the WCN6855/hwN.M/ which contains your
device-specific data.

>         status = "okay";
>     };
> 
> Tested-on: QCA6698AQ hw2.1 PCI WLAN.HSP.1.1-04402-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
> 
> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>

P.S. please CC linux-arm-msm for future respins of this series or for
all other submissions that concern board-specific DT data on MSM
platforms.

> ---
>  drivers/net/wireless/ath/ath11k/core.c | 12 ++++++++++++
>  drivers/net/wireless/ath/ath11k/core.h | 11 +++--------
>  2 files changed, 15 insertions(+), 8 deletions(-)
> 

-- 
With best wishes
Dmitry

