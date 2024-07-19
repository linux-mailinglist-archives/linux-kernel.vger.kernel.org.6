Return-Path: <linux-kernel+bounces-257629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D93937CD6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 21:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0D11C217D3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 19:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B10148315;
	Fri, 19 Jul 2024 19:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WjKCmP3O"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAD51482F0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 19:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721415907; cv=none; b=rDyhGQ5Mzo/y7N9jLpTxfXMBvt16NZOHFDO8fZswgPqTNB8e7CcWqP5qCF20jYiRpkQNrhvtPaDvxgqkHe3hyv8IOcyC+Ia4WEWVEdZ+fjsVJZiy5EHgJOWNj2ZjhuCVH4AfPh6bgZ69TBg8eOzyXyyd67CjlE7sSjEAjTe0iPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721415907; c=relaxed/simple;
	bh=J0iZWzPv9tuzSn96jNkzFCrECkH9O3OQra/Km6dfIS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9KlD7+1Y+kiPiGZIR5ELUj0SvqetZDWglOhsbQZVn3U50mFIMe5VZTTHtPma2gyIQazkjgnZ8Q5LD50fpq1vPBUUepnOfVBXqPxMwnUyfb/y+WLux2ikZ/VEnwZuf4osC4N0mMDLTkAazIV5P61KxvwU4SuDrzGvgcrRCMGdiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WjKCmP3O; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70afe18837cso886864b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 12:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721415905; x=1722020705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RKleR+lXMztIafiPT9HsuWNtnPTeHMXhs4SK2dagfFE=;
        b=WjKCmP3OGTf05ADpfhDOcYl3iU3lN30CHEHYozL76G8moh2DXP9hPnPkWNl/DHjitl
         A82wJIdKMvZ3K2B/3IBF9JstHtxob2uQ3l8AsSoUzFFXtO1MfLekm0RojOtpfO0+0+gC
         seMhew3f1s1ZhuiYSG3HiQc+mzu5JMz3YZxqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721415905; x=1722020705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKleR+lXMztIafiPT9HsuWNtnPTeHMXhs4SK2dagfFE=;
        b=lGuEOxGaX72712Mb5acJ4puJsRGidh6N6gdv1oZcoFDZxJSf9CrPhcAj09DESfsfIy
         iLOiBNzZNM370PpAlwzNhPlVUCuhv2AakXeGkmUTUInO/gxzJcwXDIoGD5bSVQlwcJxv
         ghG2hFbncy4OqiKLCIVJsEZilOg/0jlSPQxoHNKlkZXTCR2i8/KfFbe6MtZw7xjj+E8C
         jKO2DaJ1NNXYOR9uP0EXBORyGs/lZu7WqJRdELmiMqRIoFtwaP4x9AU69BG8jFoOsTva
         jZjBqt3hiPhcyk83Q89z5ZxxLJnHYWIHLu3qqfCsW+SrWIOMxzLGzIeCCwszgNMyJ1SV
         M80w==
X-Forwarded-Encrypted: i=1; AJvYcCVJJQ9MNthLupBu38amWuzIwjGYHg0pIR6L+z9wf+7IbgrIuROD4oQBTwEvtRGJ76ne6KJ1tJ+zesBI07EVonLdmQtyO8ZfOca/stWZ
X-Gm-Message-State: AOJu0YxPlGeqIT/8lxmloXeKDs1xE1M2NEcEtqEv03c2Ln5COZbkhZtn
	T9OmMMFejCvFFaKzUJ10MePr0ERfx6XXsYAquhI7F3ME/7kQYzLs6wwmgDr0Tg==
X-Google-Smtp-Source: AGHT+IEbkQzzNCnmyDj+uI6xoOE+O1v8XWzQ5R3YOoTXExBP8AHsDBfBXCO/euBcJOYg+9/xxZwilw==
X-Received: by 2002:a05:6a00:b49:b0:70b:1811:3efa with SMTP id d2e1a72fcca58-70ce507e02dmr11257102b3a.22.1721415904520;
        Fri, 19 Jul 2024 12:05:04 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:bc77:954b:4e8f:b43d])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-70cff59e2d7sm1552552b3a.170.2024.07.19.12.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 12:05:03 -0700 (PDT)
Date: Fri, 19 Jul 2024 12:05:01 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	David Lin <yu-hao.lin@nxp.com>
Subject: Re: [PATCH v2 2/2] wifi: mwifiex: add support for WPA-PSK-SHA256
Message-ID: <Zpq43ZxnICn5vEIu@google.com>
References: <20240717-mwifiex-wpa-psk-sha256-v2-0-eb53d5082b62@pengutronix.de>
 <20240717-mwifiex-wpa-psk-sha256-v2-2-eb53d5082b62@pengutronix.de>
 <ZpmdVq2CkxRcLxvO@google.com>
 <ZpoCC042qMcOQ83N@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpoCC042qMcOQ83N@pengutronix.de>

[ +CC David, in case he has thoughts ]

On Fri, Jul 19, 2024 at 08:04:59AM +0200, Sascha Hauer wrote:
> On Thu, Jul 18, 2024 at 03:55:18PM -0700, Brian Norris wrote:
> > On Wed, Jul 17, 2024 at 10:30:08AM +0200, Sascha Hauer wrote:
> > > This adds support for the WPA-PSK AKM suite with SHA256 as hashing
> > > method (WPA-PSK-SHA256). Tested with a wpa_supplicant provided AP
> > > using key_mgmt=WPA-PSK-SHA256.
> > > 
> > > Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > ---
> > >  drivers/net/wireless/marvell/mwifiex/fw.h      | 1 +
> > >  drivers/net/wireless/marvell/mwifiex/uap_cmd.c | 3 +++
> > >  2 files changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
> > > index 3adc447b715f6..1c76754b616ff 100644
> > > --- a/drivers/net/wireless/marvell/mwifiex/fw.h
> > > +++ b/drivers/net/wireless/marvell/mwifiex/fw.h
> > > @@ -415,6 +415,7 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
> > >  #define KEY_MGMT_NONE               0x04
> > >  #define KEY_MGMT_PSK                0x02
> > >  #define KEY_MGMT_EAP                0x01
> > > +#define KEY_MGMT_PSK_SHA256         0x100
> > >  #define CIPHER_TKIP                 0x04
> > >  #define CIPHER_AES_CCMP             0x08
> > >  #define VALID_CIPHER_BITMAP         0x0c
> > > diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > > index 7f822660fd955..c055fdc7114ba 100644
> > > --- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > > +++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > > @@ -60,6 +60,9 @@ int mwifiex_set_secure_params(struct mwifiex_private *priv,
> > >  		case WLAN_AKM_SUITE_PSK:
> > >  			bss_config->key_mgmt = KEY_MGMT_PSK;
> > >  			break;
> > > +		case WLAN_AKM_SUITE_PSK_SHA256:
> > > +			bss_config->key_mgmt = KEY_MGMT_PSK_SHA256;
> > > +			break;
> > 
> > I feel like this relates to previous questions you've had [1], and while
> > I think the answer at the time made sense to me (basically, EAP and PSK
> > are mutually exclusive), it makes less sense to me here that PSK-SHA256
> > is mutually exclusive with PSK. And in particular, IIUC, this means that
> > the ordering in a wpa_supplicant.conf line like
> > 
> >   key_mgmt=WPA-PSK WPA-PSK-SHA256
> > 
> > matters -- only the latter will actually be in use.
> > 
> > Is that intended? Is this really a single-value field, and not a
> > multiple-option bitfield?
> 
> It seems that when only the KEY_MGMT_PSK_SHA256 is set, then
> KEY_MGMT_PSK also works. Likewise, when only KEY_MGMT_SAE is set, then
> also KEY_MGMT_PSK_SHA256 and KEY_MGMT_PSK work.
> I gave it a test and also was surprised to see that we only have to set
> the "most advanced" bit which then includes the "less advanced" features
> automatically.

Huh, that's interesting. So these KEY_MGMT* flags don't really mean what
they say. It might be nice to have some additional commentary in the
driver in that case.

> I could change setting the key_mgmt bits to |= as it feels more natural
> and raises less eyebrows, but in my testing it didn't make a difference.

That would make sense to me, but I think that's in conflict with what
David Lin said here:

https://lore.kernel.org/all/PA4PR04MB9638B7F0F4E49F79057C15FBD1CD2@PA4PR04MB9638.eurprd04.prod.outlook.com/

"Firmware can only support one of WLAN_AKM_SUITE_8021X,
WLAN_AKM_SUITE_PSK, or WLAN_AKM_SUITE_SAE."

If that's true, then it seems like we need some kind of priority
conditions here (e.g., if PSK is provided, but then we see PSK_SHA256,
let PSK_SHA256 override -- but not vice versa). That might be pretty
ugly though.

> BTW wpa_supplicant parses the key_mgmt options into a bitfield which is
> then evaluated elsewhere, so the order the AKM suites are passed to the
> kernel is always the same, regardless of the order they appear in the
> config.

I hear you, but that's not really how we define kernel APIs -- by the
particular implementation of a single commonly-used user space.

Brian

