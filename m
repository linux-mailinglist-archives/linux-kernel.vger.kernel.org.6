Return-Path: <linux-kernel+bounces-449085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD3E9F4990
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADE6218813B2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F44F1E573F;
	Tue, 17 Dec 2024 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hg18FeHl"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9865713CFB6
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 11:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734433630; cv=none; b=tQ4umjqg6vxy6wvW0sWdfdW+0XVVeEgfOrmeCyXAWXSTuumT+oFDWTIfkF/fAot79u9NKb+YCC4aFMbmZFYttcYPKcGxecysa46ShTFKIH0FSZ+Jwb+6pC8mddmICGh7+Cux2XZZUdsLNAwJ3GEXaEJNTqgkiaL8Yq4AbSPwnPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734433630; c=relaxed/simple;
	bh=DssytWRsJzFgDQC1CkHvnXulBSToKLyeKpd2UiymnY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGi/N7idNr7A2QQnj0K8iqTnUcREJksrmBEzk9MbWzqe0Bije/bpjYPq+alzQifDaH5BkRY9kPbiG8g5eo8sCpoiWfpxLujWLhvSnOcM2Lf6tNEzqQ/cIfzP1ivv4ewhDX3DrI2oFEE6Rjy8CLcO81W5UiyzkvDX1wP4Uj/ZVfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hg18FeHl; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53e3a227b82so4922555e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 03:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734433627; x=1735038427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AfuoU4NCeZC6i1F3LvimU1oXmmt7Zka/LPketmVAjnQ=;
        b=hg18FeHlgKYaZGPHZpZs/LQQ0wJOEtwbKnGINxWzTyfjwe3BWQAaUIXuJ0/pWnGxH0
         4NlVzA6hQe3XeTQztKuyOJkORaUCdgCDi+Sj6JShPb/kSIIFBYE3W0i3Yy+syjmXzryJ
         cLu0B5on/Oyb/Xw7y9Vpl0wy36xBg0Hy11K3QcTn8yNJvu7hP3Z9ot577WmddNEyoXru
         6G/DVXrYhDM1Vrg+ALeFXTIjv+LNUZfdjnpw4FGikN2G6fDa4YgMRNFGM6ZSoqGPsOe3
         oOq2mhTk2Qbr4xVL1bWaWg440lPYl0vuCCDskCw+9vRn9h1Qf/nvci8sEHJU/HIVcDtr
         s6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734433627; x=1735038427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfuoU4NCeZC6i1F3LvimU1oXmmt7Zka/LPketmVAjnQ=;
        b=Tg9HGP5gM52RTIdrLMrXb3i+mNDCt4Yg+Aow8GEiWHQzCiHHRIUJLfcqMN+315frUW
         +AhlYYn45ynPliIZrz4TLKD0EqkwuBfptW9Y0xGj+Aagz1ZGlcQKopMiYi6y2BZ7tdCD
         Iwsh9JfaVHuqUZ1ztuyRR+cVIVbYON9ziFPxsP1Uo4JNfm3yhXxpnIqTbjByUEu4Nign
         YgqNDQZA6AZSlJ08KGvTOo9Ueog4Hb9XgaPk+YDA6Avl7Z8mgwwopORxi417QswzTEYv
         sQE35zBe0oKhk9eICRKD1utINnq5z3cjeZtkqyw1OaQEf5O7gEDpvvYGJ6FKk5XpdSGl
         B8Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXVzVX8RaUo7eHMc417XoRjCgLj+bEtRj1SdnxlaOEZ3Ao3bLn6oVfy6H/FLhdQVFelU5WUj9lNZYH3l5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzHYRP7o5+6BiYYyJr8P2Mi7oqGku0t8WX/6RLFvWHkSkYuKlL
	uma6A2bJMkmpgjWzPkTLV2BEdWvDXUuwfhi9kGk1JHss3Y6CqzupCkKWpbN9GWo=
X-Gm-Gg: ASbGncv6L7Xe2/UEybwVnW6tpmBa9uEBj5ghVhRopMGKk17WpYPXj8hTHRc4GhAC33R
	IgOKdWTASi0XDkVsL9SeeSCEqsK/klFup51dOnxsPOwKgllERgTRLrIOzzsMobVZP2xnaWRgHiN
	atswopvuvH1v2JaKpQR1zy8pSZ/idi05pF1QeB9i21kmKpThs2C8qvJ+JBBfMwKxdF+rYPnTqvV
	HnlEdg8arxw2UTQaZMKpUdvoMmRv5jmErMnedFlHvHltge0ub5fZa+rE6grqTikud5jClid77v0
	fPSJ/566PKj8YOl/qBWo+2ZRLDU7YBTVYwOx
X-Google-Smtp-Source: AGHT+IGORYjhudTQdAvMdm8g3LCUxmZy1h6j52DQHamk5YqQ8TrNPXiGHtV+PtxV/2H4doZcZuIeCQ==
X-Received: by 2002:a05:6512:2392:b0:540:20eb:80c5 with SMTP id 2adb3069b0e04-540905a6f84mr5483487e87.37.1734433626614;
        Tue, 17 Dec 2024 03:07:06 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c13d69sm1118592e87.217.2024.12.17.03.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 03:07:05 -0800 (PST)
Date: Tue, 17 Dec 2024 13:07:02 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sandor Yu <Sandor.yu@nxp.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com, 
	daniel@ffwll.ch, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, vkoul@kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, mripard@kernel.org, 
	kernel@pengutronix.de, linux-imx@nxp.com, oliver.brown@nxp.com, 
	alexander.stein@ew.tq-group.com, sam@ravnborg.org
Subject: Re: [PATCH v20 1/9] soc: cadence: Create helper functions for
 Cadence MHDP
Message-ID: <rew4x4qxemig7rq4kossrn7cybihrgsizh43wnllgv2daf75gm@ziqsakm7gm56>
References: <cover.1734340233.git.Sandor.yu@nxp.com>
 <7fd5d54e2594aadd66598888ddf512f3d6d30e5d.1734340233.git.Sandor.yu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fd5d54e2594aadd66598888ddf512f3d6d30e5d.1734340233.git.Sandor.yu@nxp.com>

On Tue, Dec 17, 2024 at 02:51:43PM +0800, Sandor Yu wrote:
> Cadence MHDP IP includes a firmware. Driver and firmware communicate
> through a mailbox. The basic mailbox access functions in this patch
> are derived from the DRM bridge MHDP8546 driver.
> New mailbox access functions have been created based on different mailbox
> return values and security types, making them reusable across different
> MHDP driver versions and SOCs.
> 
> These helper fucntions will be reused in both the DRM bridge driver MDHP8501
> and the i.MX8MQ HDPTX PHY driver.
> 
> Six mailbox access helper functions are introduced.
> Three for non-secure mailbox access:
>  - cdns_mhdp_mailbox_send()
>  - cdns_mhdp_mailbox_send_recv()
>  - cdns_mhdp_mailbox_send_recv_multi()
> The other three for secure mailbox access:
>  - cdns_mhdp_secure_mailbox_send()
>  - cdns_mhdp_secure_mailbox_send_recv()
>  - cdns_mhdp_secure_mailbox_send_recv_multi()
> 
> All MHDP commands that need to be passed through the mailbox
> should be rewritten using these new helper functions.
> 
> The register read/write and DP DPCD read/write command functions
> are also included in this new helper driver.
> 
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> ---
> v19->v20:
> - new patch in v20.
>   The patch split from Patch #1 in v19 and move to a new folder drivers/soc/cadence

It makes it harder to review, but granted that we have already past
that, I think it's fine.

> 
> diff --git a/drivers/soc/cadence/Kconfig b/drivers/soc/cadence/Kconfig
> new file mode 100644
> index 0000000000000..b668790660fa5
> --- /dev/null
> +++ b/drivers/soc/cadence/Kconfig
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +config CDNS_MHDP_HELPER
> +	tristate "Cadence MHDP Helper driver"

This symbol isn't supposed to be selected by the user. Please leave just
tristate without the menu entry text (the help text is fine, please keep
it).

LGTM otherwise.

> +	help
> +	  Enable Cadence MHDP helpers for mailbox, HDMI and DP.
> +	  This driver provides a foundational layer of mailbox communication for
> +	  various Cadence MHDP IP implementations, such as HDMI and DisplayPort.
> +

-- 
With best wishes
Dmitry

