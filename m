Return-Path: <linux-kernel+bounces-556505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B28A5CACE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2B2217851D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9FE260394;
	Tue, 11 Mar 2025 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GcMdrCp9"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFD4260370
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741710451; cv=none; b=p3IczETgE1tTZMxPQmwne+4e//Wu5/KDXnXBJAn4bqJAhwN9nE7RYMptgoAPUGr9bleQ3u8IhezxeWDW/uV2jgU2uaDNTbKrztpOZsQJBYBrWrX02eGnmLX/tEs5sejhE9QuopHwsSHIYXGBU4UmQv3cwkBGRBkFySRqoeuJBeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741710451; c=relaxed/simple;
	bh=0mCyXyj/1a5L4Ssc/7ltee11X6K/OBjhBSlN18FgDDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLC5U5U5sVvY6gcNglowbLzDHnkPexiJvu57goc2qa9Dg/JEuxXSLS+JVDMrM0iqG80AjRFYdMOJV8r2TM4H1Mo/eyTyTYjp6DELanOxrirgwgoWmcplha3ost1cNjHPZPhP1GKto+DyhfSGek55TJGwswb9JusBj/nMHYfrMqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GcMdrCp9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-223594b3c6dso103466625ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741710449; x=1742315249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dl1JWfYJOg72EaaV3ldWA/0rrmYP/fUTPGuYqr0ndJY=;
        b=GcMdrCp9TOCZMk/iaQjgcTGttfOksDTKdiuDinD+DYKp4LkZHWwS3GBGbmx4AysjFo
         0mN7JuTDvAWljbN3vGzfQyrnotlhHlgtNDrs6mNvrteTc1iuitDbTs/KcI704InIiTVW
         KTvAsp5WNEX3c58zUbgncpwAYD6qy/blUp95KtGGQJe37qHpUgqaV/GQ2kRfgx7ww1/U
         mLnuKn4SlJumtk8EaZqAO4pvd4TYCIfCZDGAB9wFKWLe87eMsKIHDLWXS+RwqiACLedn
         LDgj7Yb0I5/5IfsuHJzpsK7Aa1FaksOBsWWsrJnMKbipAUQuvge20VvZQH/HsX+wPcvY
         U/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741710449; x=1742315249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dl1JWfYJOg72EaaV3ldWA/0rrmYP/fUTPGuYqr0ndJY=;
        b=Bk5oqthvOljplVMlvELocG+3013ZKIQCEIsdpu8sY3aExQcLVwqI3fSZTEbvNiMcJV
         7LRATxbjnaL02affrxIAEtEoSjnopb2l+jtBC/VDrYMSDrI19iwciGnbGUrpEmUxO4B2
         6Y2QUb52lVFZnn4jaJdakkBC128kR80otDuoVKShMssczk4oQrIC6UQziGMSFsJzMzzZ
         fx4JNHQncMujMfJzCk0I80QiSujVuTzSbnXQACqQIq+5wqjRU3x7o8XGF9akUSSc2mtr
         k2ZsCiX6hli+X9V2vP6m44DFRwTJOZ007/Y+asThCX5nWDr/62r1KpAcb79mfDJRU3ou
         BDxA==
X-Forwarded-Encrypted: i=1; AJvYcCXOEDvmN5Ett0HyHf6LOKK651HYiD9pY4FwGWoqKHB2JpUxV5/RqrH0AxqgVQrfuJ9OCLcgl4nDOCdF0AE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwWGVPaxdT047yoJbrRwxH52MyEfJICy2NWodGIWBfUBCoGkN4
	3gehaAHGFl9q4JhWPJ+AQe4xgQ98Mnh2EuGMfHl14BaZNExD6neaDxdmN1vVI2s=
X-Gm-Gg: ASbGncv/qID0jx4pPdNDnKWa4+weBOlKV05ySkT6l1lOz1dxJp2wTXM7Owq0QfxRHEZ
	st+qGh4jeV/ngSyXK/5GzR4RhwAEtn+ngGmGzfdI9QX4dbgzVu0/cE66FpAbuy7iEkBSGHdqFQJ
	KQcYg7PzjHewRapw+O7I5JTcmuEIzgbcnBYaVBAgEjgKfClLjgwVng/3Pv5v3x/f60T6eALqAuj
	oYdUwWfD9VOFiIH+TrU31tFCrommttjyl67msRZSy+gvFX5+0EtOcq0jLyJpBDNmNEZrA3w8SW0
	ULDQ/tLz9GnRrtI5k0O+sn//CHEwVMVa5jO+hhCqz2WAWheb
X-Google-Smtp-Source: AGHT+IF2UG2Kdovm4QQZtJqBjJbgL9SWkVL1VlYQjoRQyWIygr7zZtU2BIqigowT+nJo0KVbHMcrnA==
X-Received: by 2002:a17:903:32c2:b0:224:1074:6393 with SMTP id d9443c01a7336-22428bffe92mr243601665ad.43.1741710449034;
        Tue, 11 Mar 2025 09:27:29 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:ff32:9486:a333:ba9e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e948asm100400365ad.75.2025.03.11.09.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 09:27:28 -0700 (PDT)
Date: Tue, 11 Mar 2025 10:27:25 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: p.zabel@pengutronix.de, robh@kernel.org, krzk+dt@kernel.org,
	shawnguo@kernel.org, devicetree@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, conor+dt@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, andersson@kernel.org,
	Frank.Li@nxp.com, peng.fan@nxp.com, laurentiu.mihalcea@nxp.com,
	iuliana.prodan@nxp.com, shengjiu.wang@nxp.com
Subject: Re: [PATCH v5 0/8] imx8mp: Add support to Run/Stall DSP via reset API
Message-ID: <Z9BkbVHlx60VFD7q@p14s>
References: <20250311085812.1296243-1-daniel.baluta@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311085812.1296243-1-daniel.baluta@nxp.com>

Thanks for the re-spin.  I will wait for Shawn and Sascha to review their
respective bits before picking up this set.

Mathieu

On Tue, Mar 11, 2025 at 10:58:03AM +0200, Daniel Baluta wrote:
> This patch series adds support to control the Run/Stall DSP bits found on
> i.MX8MP via the reset controller API instead of using the syscon API.
> 
> DSP found on i.MX8MP doesn't have a direct reset line so according to hardware
> design team in order to handle assert/deassert/reset functionality we
> need to use a combination of control bits from two modules.
> 
> Audio block control module:
> 	- for Run/Stall control bits of the DSP
> 
> Debug Access Port (DAP)
> 	- for Software Reset via IMX8M_DAP_PWRCTL register
> 
> The current implementation for IMX DSP Remotproc driver and for Sound Open
> Firmware driver (already upstream) uses the following approach:
> 	- maps the Audio Block Control address via syscon API through
>           the fsl,dsp-ctrl property of the dsp node.
> 	- maps the DAP address space using directly a call to ioremap
>           with IMX8M_DAP_DEBUG macro depicting the DAP base address.
> 
> The both approaches are problematic when comes to describing the address
> spaces via the DT:
> 	- for Audio Block Control, because it uses the syscon interface
> 	- for DAP because it hardcodes de base address instead of using a dt node.
> 
> This patch series aims to fix the Audio Block control usage of the
> syscon interface and replace it with Reset Controller interface.
> 
> Main advantages of using the Reset Controller API is that we stop
> abusing the syscon interface, offer a better probe ordering, PM runtime
> support. Main critique of using the Reset Controller API is that
> Run/Stall bits are not reset bits (but according the hardware design
> team they are part of the reset proccess since there is no real reset
> line).
> 
> Initial discussion is here:
> https://patchwork.kernel.org/project/imx/patch/20250212085222.107102-6-daniel.baluta@nxp.com/
> 
> Note that we can safely remove the fsl,dsp-ctrl property usage from IMX DSP
> remoteproc driver because there is no Device Tree users.
> 
> Changes since v4:
> https://lore.kernel.org/lkml/20250305100037.373782-3-daniel.baluta@nxp.com/T/
> 	- picked-up R-b tags from Frank Li and Peng Fan
> 	- reworded commit message of patch 8/8 as per Mathieu Poirier suggestion
> 
> Changes since v3:
> https://lore.kernel.org/linux-arm-kernel/20250225102005.408773-5-daniel.baluta@nxp.com/T/
> 	- renamed resets ids as per Philipp comments
> 	- add boths resets (named them runstall and softreset) as per Philipp comments
> 
> Changes since v2:
> (https://lore.kernel.org/lkml/Z7ZNngd3wtJ5MZgl@lizhi-Precision-Tower-5810/T/)
>         - picked R-b and A-b tags
>         - use run_stall instead of reset to refer to reset controller
>           instance
>         - remove 'resets' description as it is a common property
>         - add correct include in the yaml dts snippet example
> Changes since v1:
> (https://lore.kernel.org/imx/20250219030809.GD6537@nxa18884-linux/T/)
>         - addresed comments received on v1
>         - picked up R-b and A-b tags
> 
> Daniel Baluta (8):
>   dt-bindings: reset: audiomix: Add reset ids for EARC and DSP
>   dt-bindings: dsp: fsl,dsp: Add resets property
>   arm64: dts: imx8mp: Use resets property
>   reset: imx8mp-audiomix: Add prefix for internal macro
>   reset: imx8mp-audiomix: Prepare the code for more reset bits
>   reset: imx8mp-audiomix: Introduce active_low configuration option
>   reset: imx8mp-audiomix: Add support for DSP run/stall
>   imx_dsp_rproc: Use reset controller API to control the DSP
> 
>  .../devicetree/bindings/dsp/fsl,dsp.yaml      | 24 +++++-
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  3 +
>  drivers/remoteproc/imx_dsp_rproc.c            | 25 ++++--
>  drivers/remoteproc/imx_rproc.h                |  2 +
>  drivers/reset/reset-imx8mp-audiomix.c         | 78 +++++++++++++------
>  .../dt-bindings/reset/imx8mp-reset-audiomix.h | 13 ++++
>  6 files changed, 114 insertions(+), 31 deletions(-)
>  create mode 100644 include/dt-bindings/reset/imx8mp-reset-audiomix.h
> 
> -- 
> 2.43.0
> 

