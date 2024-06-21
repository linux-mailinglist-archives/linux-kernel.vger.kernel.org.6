Return-Path: <linux-kernel+bounces-225454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41476913096
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 00:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEA021F22FCE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 22:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9D116F0D0;
	Fri, 21 Jun 2024 22:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M7wl2ioZ"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F193E15D1
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 22:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719010247; cv=none; b=fsMFibDRl0SdyF28KI1B73FFA1/3qg728rvlkOlTvnIo0ORsbzjIFIWm8iDkL9hrAWNMx4XZ2FyynuwQQJIuzq8oW8qt/+zd4tLKFwTmKgOqG5vpcKQvD9ftFtec4VJV7AEWr7Yu7Jn5P17/+5GWPZ47rMW5w0YqGGDC3UkNHwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719010247; c=relaxed/simple;
	bh=qdXb7h2xSSWEhzC4Qt2mxzTAvZLwyXuoc2FCs8MmEQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArNSMDf0785XbSUI8q4hhSKjHfKIS1BoOAjRIRyRUf7C4WXqYOiP2qm2HyEhpH1QUQCjBU3JgdFYGY1Dh/bIVl931wK9WeC5GHmqp2RmbiVFfBmeF5MfS+Y2wWr/rx8wJnjsFTBJC61OF4uTeRESjgekXuaLroYUngYD28lj1NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M7wl2ioZ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-706264e1692so2040184b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719010244; x=1719615044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IdAX7YqB8PuY9bzTn2bAULXcR/7WVxmcKxOrcis8Hbw=;
        b=M7wl2ioZu9k4qBOb/pQKdlWjY6SrVVVKMam+ns81v0v+oyuuqo5l1z14CxW7/mfAMo
         hZM4i9WpQ91tdDW0hxy8BSycGiCfExUAZ3nCFO88wRp+vlMOOzxy+HC+qBberjCyFsnn
         zoARTQ6c4dAzVtlxkRZtrnJD+3h9XZCl9og08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719010244; x=1719615044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdAX7YqB8PuY9bzTn2bAULXcR/7WVxmcKxOrcis8Hbw=;
        b=qr+BR/BxXkl6B/m/kHv+LVl5uUMG5e/+8zXhHGr+3LKCRXhGX6SB1HPTCVlWId/fm+
         Vwqk1gsFEOz4R0rUt4iohcoZoLm1ZMCmTmvyim3vb+PBlDsUUwmUttwXGbDKICgpu1fR
         snOjBd6NhoArhq6UGPp8Rp9BXV99CXbfKPdwBcgBHEeqV+um3K+W5BbABS8r41lL0egZ
         yO3zlnfw8VhttQF3kopBAxAz/u49BTwJNuwcdpGcX9HRA8fSBnYD20hPWbAfo+4fOtID
         q3X1eMIVzFem12YphZDGE6kdpREcNNWqoZVjmS1KONtqxt9mHUvjKz/fzxsXUdHQf6ck
         eI+w==
X-Forwarded-Encrypted: i=1; AJvYcCV0VlNsWrO05D62ZPGUiZlwqXflL3GrMBdjXGy/D18H5X3frAk9SN1AEBbNujgnLF40m+6IucOO3ZmtJ8ehQObNLDMdTqy7BE7s393I
X-Gm-Message-State: AOJu0YwfV2a0Wf/a12fiCcwuYiTsV0lfe/smlxjgVtjnkjFV+bWONv6O
	MVx+pb3ezjejcYvjs/0J162eqmc9AsmjD6rQWtPX4gd3tAuMQv18/s1J5I3btg==
X-Google-Smtp-Source: AGHT+IEuv038RQes/j90RQdadBEcwu5TtIIxJ+qn0yvSgF9gdxWbw0Z/sDsDE0s4taUdJZXL2g5LOA==
X-Received: by 2002:a05:6a20:b802:b0:1a7:60d8:a6dd with SMTP id adf61e73a8af0-1bcbb60d03fmr9158258637.53.1719010244154;
        Fri, 21 Jun 2024 15:50:44 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:40ba:89b1:5f45:68d8])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-706512e000asm1997743b3a.179.2024.06.21.15.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 15:50:43 -0700 (PDT)
Date: Fri, 21 Jun 2024 15:50:42 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Lin <yu-hao.lin@nxp.com>,
	Francesco Dolcini <francesco@dolcini.it>
Subject: Re: [PATCH] [RFC] mwifiex: Fix NULL pointer deref
Message-ID: <ZnYDwjS293Cb8O1f@google.com>
References: <20240619070824.537856-1-s.hauer@pengutronix.de>
 <87wmmll5mf.fsf@kernel.org>
 <ZnSHcZttq79cJS3l@google.com>
 <ZnVCzx3-pvbcYQLm@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnVCzx3-pvbcYQLm@pengutronix.de>

On Fri, Jun 21, 2024 at 11:07:27AM +0200, Sascha Hauer wrote:
> I am running plain wpa_supplicant -i mlan0 with this config:
> 
> network={
>         ssid="somessid"
>         mode=2
>         frequency=2412
>         key_mgmt=WPA-PSK WPA-PSK-SHA256
>         proto=RSN
>         group=CCMP
>         pairwise=CCMP
>         psk="12345678"
> }
> 
> wait for the AP to be established, <ctrl-c> wpa_supplicant and start it
> again.

Thanks. I still can't reproduce, but that's OK. From your fuller
description now, it seems it depends on the particulars of the bss
indices in use, and maybe my device/firmware is behaving differently.
Anyway, your current description and patch below make a lot more sense.

> It doesn't seem to be a locking problem, see the patch below which fixes
> my problem.

Sure. It's probably harder to trigger real issues out of some of these
kinds of race conditions, and the logical problem below sounds a lot
more likely.

> At some point during incoming events the correct adapter->priv[]
> is selected based on bss_num and bss_type. when adapter->priv[0] is used
> for AP mode then an incoming event with type MWIFIEX_BSS_TYPE_STA leads
> to adapter->priv[1] being picked which is unused and doesn't have a
> wiphy attached to it.

Ack, that makes a lot of sense -- although I think it also implies
either you're getting some kind of corrupt event buffer from your device
too, or there's something else logically weird with your firmware when
you're receiving MWIFIEX_BSS_TYPE_STA events for a *_AP interface. (Or
maybe that's also racy, as you're changing the virtual interface from
STA to AP? Not sure.)

It also highlights that I find this fallback code from
mwifiex_process_event() weird:

        /* Get BSS number and corresponding priv */
        priv = mwifiex_get_priv_by_id(adapter, EVENT_GET_BSS_NUM(eventcause),
                                      EVENT_GET_BSS_TYPE(eventcause));
        if (!priv)
                priv = mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
                       ^^ // if we didn't match the right BSS/event
			  // metadata, we'll deliver the event to an
			  // arbitrary interface?

But I don't think that's your problem. And at least so far, I don't
think the AP and STA event IDs collide in any way, so I don't think
we're likely to end up misbehaving even if something is misdelievered.

> 
> -------------------------8<----------------------------
> 
> From 3357963821294ff7de26259a154a1cb5bab760cb Mon Sep 17 00:00:00 2001
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Date: Tue, 18 Jun 2024 12:20:20 +0200
> Subject: [PATCH] mwifiex: Do not return unused priv in
>  mwifiex_get_priv_by_id()
> 
> mwifiex_get_priv_by_id() returns the priv pointer corresponding to the
> bss_num and bss_type, but without checking if the priv is actually
> currently in use.
> Unused priv pointers do not have a wiphy attached to them which can lead
> to NULL pointer dereferences further down the callstack.
> Fix this by returning only used priv pointers which have priv->bss_mode
> set to something else than NL80211_IFTYPE_UNSPECIFIED.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/net/wireless/marvell/mwifiex/main.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
> index 175882485a195..c5164ae41b547 100644
> --- a/drivers/net/wireless/marvell/mwifiex/main.h
> +++ b/drivers/net/wireless/marvell/mwifiex/main.h
> @@ -1287,6 +1287,9 @@ mwifiex_get_priv_by_id(struct mwifiex_adapter *adapter,
>  
>  	for (i = 0; i < adapter->priv_num; i++) {
>  		if (adapter->priv[i]) {
> +			if (adapter->priv[i]->bss_mode == NL80211_IFTYPE_UNSPECIFIED)
> +				continue;
> +
>  			if ((adapter->priv[i]->bss_num == bss_num) &&
>  			    (adapter->priv[i]->bss_type == bss_type))
>  				break;

Acked-by: Brian Norris <briannorris@chromium.org>

Something about this formatting didn't get properly picked up by
patchwork though, so you'll need to resubmit. Feel free to carry the
above tag with it.

Brian

