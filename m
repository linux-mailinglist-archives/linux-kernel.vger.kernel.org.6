Return-Path: <linux-kernel+bounces-515055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B915CA35F34
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24EC18896B6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5940B264A86;
	Fri, 14 Feb 2025 13:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eFA2LcJH"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC14E264A78
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 13:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539759; cv=none; b=A7fJumlj6efDydoafjfgiBRVMdmRefSI15CE7XWOQnlMAiD3iEdq9nWjFn4URzexGkzyeB43uWrKYYa0/ItDzhB6NJ3oW2vh2PowrpaHSpbx6PLEoYPFv5BSsp07fcl2h8WSV5jjabUdzUNitH5oPYNLNF+t9Z7kPulW6pUQI80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539759; c=relaxed/simple;
	bh=7kpQeUICXaXCdMZIy1NV1EzlOwfA/TJScayT6niK0wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZ/ZsbvoId8MQVRsch095mDM0qYmbNHE/Y1G4IL37UuItwps/LhXxBfxVGYm1WQHJA7IXsODqAwi3Zrw0Ovs87WktgFGedct6DMqymnDZNyWQOJJYDw8HOkNjukvHU+dz9oh5e//mjjowIJxQRSKFkvwKlGDNGCJI5TfwmALwcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eFA2LcJH; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30920855d5bso6270351fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 05:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739539756; x=1740144556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GckW9SgjVb4uOUm4nzkhOEDjrIncX3PrBzD3QPYjQIA=;
        b=eFA2LcJH0mdfBFwYA6kIK4rJruS1SzRTTC285vBQCSCD0OaDRMo3YklaKilm58ZI1N
         8g4FhvRHZywqh34+nSEmkQ5kzoxwWuQf7MSY52Gov0I9hmgK3sWxoZTDTNuiYmJHeKQ/
         49ToJtB8vnZuCyoQsGUIJJJilN0nWBbDEi6BtryE3BSUuhO8mwFRdWxEcGBOxvLkYnsX
         Zx0N96avwOaCxyCrJtZZncxkcEe+OX3SUpvX33yfyuX6kKGHy4m14Kej8tnMFFWLnp4y
         F/RbvPl0wH7neYwEhvWGEpAVr8iEYqZbrlugYYA5Gxef76SrI/tKZmcks1K1wcGVzDjQ
         fsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739539756; x=1740144556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GckW9SgjVb4uOUm4nzkhOEDjrIncX3PrBzD3QPYjQIA=;
        b=B/yDQUHCH43TLTCRZ4dRP+11r/zEx0vih4M/08e95X8UEmfJ83ekA8HqYej0XGF8l9
         dOXPIBtZzHKJ2lc6oWSBwtbXMbM4kCdzkM5HMGMifIoH6UddRpJQv290rokdlu+hoNsy
         h2zelQlt8lG/BttWAuVZNq2ta3/2Nur/Ndq71vpg/okDpdkBwVPfzBuNEPWGgRqsHReJ
         JBpIRzatZuctrNrHjkmaOkUQ4bsaCjOJg2q/6nv5BO+/MxqRBqzFJ9PzCVkNzEA3RAAM
         1okkCEoP7lcNL32Wcv9dvhRhZtTGMTZ0SYZWZMRY5WYEthPy93oa5pBc6l4Y0EgSNs4i
         ppwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdR6QgfTddrcG/xfLWyNbmlG/Rg+HbqYP17JdwwHmTfwjUGR12jEoczyfQcFHZrlppebbq8SZ4nUBhMnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVtzxHSx9JQp8zJlceBNyuatabQGot9gmY8ZEviaARyTDbgWh+
	jdA/aFrNNC7C+xfCCynTvdAWnX85sHBPatcz0v15h+0XhF8CKktH3vA5cPCBI3g=
X-Gm-Gg: ASbGncvzNOIeKe50blOWOGkRIbgRKzUreBRqmR/hPnW0gnEn2v/PGrN/fLgu6GyPI7r
	ZfvG6Mqjk/sswW3SCDiefAfb9OkWfUk0s0MJtZDEG5M7tMxVNNL/AQiXEIeFqn0WzaUO6i70f1u
	ehCsOhjy4YcRjJx3z3ZYpLYDtX3lrqXp++/N1+X5p8YGRxO/2zQOfr0MTzWwIfnDS11+NhJiNvy
	oMRy0IcjtR9BRo50o2Vk6rMh86oyL1Vj1bViu3pCrocuVyobkw9jRVS85CidQgE2lEZPGgWJhq0
	/sYV4C/ld2/9tSFKUji/oB/CO2F3mRMDg4HEjtIsOlMehY15BKn2UnUhnWUMpu81ieOBHTo=
X-Google-Smtp-Source: AGHT+IFKrTe1qOLXvbGIJXg+EWgQKwS3o7giu2lqYZTaorNRk1NGxn7QVCdOwKf+9Z3tm3rgrJjXzw==
X-Received: by 2002:a2e:91d2:0:b0:308:e9d4:7ccf with SMTP id 38308e7fff4ca-3090f11c8cfmr22400311fa.4.1739539755893;
        Fri, 14 Feb 2025 05:29:15 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309221d7074sm1604541fa.102.2025.02.14.05.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 05:29:14 -0800 (PST)
Date: Fri, 14 Feb 2025 15:29:12 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 32/37] drm/bridge: Make encoder pointer deprecated
Message-ID: <yy37e4kne7i2hl7coix6v7vajb5bm4zohod4fdzayvxr52l57u@cxturs2uxgcm>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
 <20250213-bridge-connector-v3-32-e71598f49c8f@kernel.org>
 <nfb4fb6lzjw4j5brsh242htgw3au2moklqjalfa3zzxjsi2qn5@l3censelmgbz>
 <20250214-arrogant-strong-hoatzin-efdcd8@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-arrogant-strong-hoatzin-efdcd8@houat>

On Fri, Feb 14, 2025 at 02:07:18PM +0100, Maxime Ripard wrote:
> On Thu, Feb 13, 2025 at 06:35:15PM +0200, Dmitry Baryshkov wrote:
> > On Thu, Feb 13, 2025 at 03:43:51PM +0100, Maxime Ripard wrote:
> > > Other entities (drm_connector.crtc, drm_encoder.crtc, etc.) have
> > > pointer to other currently bound entities. They are all considered
> > > relevant only for non-atomic drivers, and generally perceived as
> > > deprecated in favour of the equivalent pointers in the atomic states.
> > 
> > I think there is a significant difference between mentioned fields and
> > drm_bridge.encoder: the former fields are variable and can change. The
> > latter one is static and set at the bridge attachment time. Nevertheless
> > I think it is a good idea to deprecate it.
> 
> I'm sorry, it's not clear to me here what you want here either. Do you
> want me to change anything to that patch?

Well... I was thinking if we should expand the commit message. Most
likely it's fine though. In the end, I've r-b'ed the patch.

-- 
With best wishes
Dmitry

