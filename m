Return-Path: <linux-kernel+bounces-244809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE4292A9CD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31FD62827C1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DA314D444;
	Mon,  8 Jul 2024 19:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QqSWUFe4"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1422146D74
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 19:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720466804; cv=none; b=UZ0ySbkAEmpwdWUgIKtK+446XjBs9xKF2qzeHbDot3qpPP6+vkKCX7eE/Y3wPywu23n+jghIvHCJ5cMMh5Fn1HEz6p30023hGE7vRx+WR4BxOFjT1faP2ws3W6Cc6mw2aWdZ8eZEJcSZkTvKQoqjhumtmtmipOX2kWjUEbAsDfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720466804; c=relaxed/simple;
	bh=yoalBGunsAhVZHpt4Zz+z9F5awaPae/yF3kNbJXTA5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVVk0glH04qYw0jsPyrqznvVgRbdQeV4Hiu5QjIHJW7lA2jrtqxIAA9KttRrnqpE7YTUZ3cVElx8PI9Kt9+HSla+loe4Vg/2NToTTDo6B80jYkHUfmgPVLPmB1nJWedA6evZmi5F/9fllcgkr6fAreQ0Czbc01bWHTw5mHlZhGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QqSWUFe4; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7201cb6cae1so2108933a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 12:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720466802; x=1721071602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Emo5pzCrjfNrsol1oVrwdOxe+d/A9gG3XbKfbbvKsdw=;
        b=QqSWUFe4PRBfxtxoYviLzlWh1Lh0/Uj3Xmqc/pFyUuGNF+k1nvRlgPARyr26MuHxYQ
         Pr4NUzyJQJvXgvFsr4usoNIqGXg4VAhJcWLdNOcSfEq7YgeYH/mASysQAEd6uAD9QIr3
         pMK378Ik9O+pB5k35+pRkAiVvH9rQrJ9FQCeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720466802; x=1721071602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Emo5pzCrjfNrsol1oVrwdOxe+d/A9gG3XbKfbbvKsdw=;
        b=nNhFNDcTo9SMwU/IHQ7BPZzH+mNo2b830lhkHhRCIWDApgssN6B03AkHXPROp1uSLC
         5LgaaKRxR7KfLqM2qv5ZnChRRfmt0a8BsYVbEsOtPgsY+vgWypva9toJftiz3qrdM79k
         8PR0PjXjtadZ5CsXC0D26pBcrrRUztJQ09YkqiW8Xmun1BWhYQmb0Zc6WlieAFXNijwP
         2mJU69f2f3D67tMBY42MmtXO4m96dvHXMos0xZJn5e5P2XLlVZQUf+AEG+ZPYKmOCjRw
         2v4LZhwmcFXqC2yCk80JZuWAAncoFx4ZSmPBI+Ag2Jgdy93k1IgOuQQ4pJvvOUMD50Rf
         j2AA==
X-Forwarded-Encrypted: i=1; AJvYcCVDuQDG1sl6djY2RsGrdbzkw9pnYPz9Ruuc07ClCVadyaurR1yz1oiy+NTwHRZ6bHR1rHKeSEOSuHfE1cG3/LLmRiC2y1LtoBU7BOcX
X-Gm-Message-State: AOJu0YxPQDYwf2X/aTY/NBNVKKF1pRH2EC19pJXOC/DClsOQxK3cB9vT
	Pc0ws8uOVYau3JPyRd1Y3Hum+eP++dKO64XLzOhqmiF2ZljVXb0Jasv5uC5Bng==
X-Google-Smtp-Source: AGHT+IFzWLGpJjfdPjA5LoDyCMlL1inahjNqMJV6Pi2zIPLk2kpujT5ZtrJAD9JSab5j7LYKjxGTVQ==
X-Received: by 2002:a05:6a20:1582:b0:1c2:94ad:1c66 with SMTP id adf61e73a8af0-1c2982163d9mr331010637.5.1720466802283;
        Mon, 08 Jul 2024 12:26:42 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:3e22:9cde:6b65:e5e8])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1fbb6a10111sm2283585ad.20.2024.07.08.12.26.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 12:26:41 -0700 (PDT)
Date: Mon, 8 Jul 2024 12:26:40 -0700
From: Brian Norris <briannorris@chromium.org>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v11 2/2] wifi: mwifiex: add host mlme for AP mode
Message-ID: <Zow9cOyMvgiddkKw@google.com>
References: <20240704033001.603419-1-yu-hao.lin@nxp.com>
 <20240704033001.603419-3-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704033001.603419-3-yu-hao.lin@nxp.com>

Hi David,

On Thu, Jul 04, 2024 at 11:30:01AM +0800, David Lin wrote:
> Add host based MLME to enable WPA3 functionalities in AP mode.
> This feature required a firmware with the corresponding V2 Key API
> support. The feature (WPA3) is currently enabled and verified only
> on IW416. Also, verified no regression with change when host MLME
> is disabled.
> 
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Acked-by: Brian Norris <briannorris@chromium.org>
> ---
> 
> v11:
>    - modify 'mwifiex_mgmt_stypes' to allow multi-adapters with different
>      setting of host_mlme_enbaled.
...
> -	wiphy->mgmt_stypes = mwifiex_mgmt_stypes;
> +	if (adapter->host_mlme_enabled) {
> +		memcpy(adapter->mwifiex_mgmt_stypes,
> +		       mwifiex_mgmt_stypes,
> +		       NUM_NL80211_IFTYPES *
> +		       sizeof(struct ieee80211_txrx_stypes));
> +
> +		adapter->mwifiex_mgmt_stypes[NL80211_IFTYPE_AP].tx = 0xffff;
> +		adapter->mwifiex_mgmt_stypes[NL80211_IFTYPE_AP].rx =
> +			BIT(IEEE80211_STYPE_ASSOC_REQ >> 4) |
> +			BIT(IEEE80211_STYPE_REASSOC_REQ >> 4) |
> +			BIT(IEEE80211_STYPE_PROBE_REQ >> 4) |
> +			BIT(IEEE80211_STYPE_DISASSOC >> 4) |
> +			BIT(IEEE80211_STYPE_AUTH >> 4) |
> +			BIT(IEEE80211_STYPE_DEAUTH >> 4) |
> +			BIT(IEEE80211_STYPE_ACTION >> 4);
> +		wiphy->mgmt_stypes = adapter->mwifiex_mgmt_stypes;
> +	} else {
> +		wiphy->mgmt_stypes = mwifiex_mgmt_stypes;
> +	}
>  	wiphy->max_remain_on_channel_duration = 5000;
>  	wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
>  				 BIT(NL80211_IFTYPE_P2P_CLIENT) |
...
> --- a/drivers/net/wireless/marvell/mwifiex/main.h
> +++ b/drivers/net/wireless/marvell/mwifiex/main.h
> @@ -1008,6 +1008,7 @@ struct mwifiex_adapter {
>  
>  	bool ext_scan;
>  	bool host_mlme_enabled;
> +	struct ieee80211_txrx_stypes mwifiex_mgmt_stypes[NUM_NL80211_IFTYPES];

This wasn't exactly what I had in mind by a "second copy" of
mwifiex_mgmt_stypes -- that you add a new array to mwifiex_adapter that
is only sometimes used. I meant something more like a const
'mwifiex_mgmt_stypes_mlme`, with the appropriate constant values. But I
suppose this works too, if a bit awkward, and saves a bit of code/data
duplication.

So, the 'Acked-by' still seems appropriate.

Thanks for the patience on this series.

Brian

