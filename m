Return-Path: <linux-kernel+bounces-300671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 927BE95E709
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 04:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A27D282826
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 02:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999814086A;
	Mon, 26 Aug 2024 02:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="YzzU0gap"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE0B5256
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 02:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724640582; cv=none; b=UrndSvhRSmBsNjm5d5cmyhnFUrKCO2TyRr9i99krQcmaO6RJuogPtFHsmlNR3VEOffW81j4QcjvPW/jhNAFQXxNfKupG5DflnBSqh2wNvRap+ZY/VXFF9swGpoe/JJ8N8ZDgDJT3wCTX5y5QxNpNyLJStOnKOfJasBwOtl6Ip4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724640582; c=relaxed/simple;
	bh=yTFQj2pXRXmQeA8wusp6/oJHF4Qtq+313HkbnmcPsuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tf3T9d3yhPZMK21CwTgOdlBBQHqlLWCNuQ5LVgRVAaD0FlphWDMYrtzqxu8Ea0Q34nnoGsuWyNsJ5KdjHCGJYhyzoSR2An+cTzSerAPkvLLtgNaULOGf98+nCdgoOoXk8nkWtKRCYJgtws70HmyLPMlil6tO+7GE+1ll7v+1BpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=YzzU0gap; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d3b36f5366so2582011a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 19:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1724640580; x=1725245380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=onpXfQ2VgikqzMxbBsqGH31KEWEFeqmAa750GJskFp8=;
        b=YzzU0gapz67e7e32NNWjUn2eEl9uYSMJCZ8NJ5MYKzT4Ym4AtzXnhpZ6fBX+LBXLTh
         18yF98vcSAsg3scwbLhvdp29eD1PIpWi1iPG9dKh9YrcxI1fmYxxEfaMqHmVr/B5kRBV
         uP53lO7Vef/syuK5F8fWdLBhu7nFDcmOvFt1mXfTOVfgsxlG7GMI2ERAwtY08ZZ/Jhrs
         JkZMmtcbKr+WP7tqbirl7IDIDmu8wLT6DslAe4TNFe7j9NdY9nIksd5Y4FUIe6DC2j9V
         kayDF/pDo+EvsTSFDZ99lLSKpXdiWuzSUczZRPW1IMt7CDqOa9BO0q8UeDgsP3Mafq1i
         X3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724640580; x=1725245380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onpXfQ2VgikqzMxbBsqGH31KEWEFeqmAa750GJskFp8=;
        b=PT38YIH0ib4uMP9GZm8GBRRFvXaTzIm4NzmLinqJBr1fZs4DF/UhVL5p9hqp4z976P
         8CYqwlVLAj8tnO8lGG1seUo0b/rANIn9YxKNmWEBGRKMnW3R68vmvO7bjSljPWqVOsM4
         ++OaUoUWmx2yh/6DPugysNymCv/OLvwfHovDZ5pl8ewfwKCA1lYZODoUlXNlMN0Hg4kJ
         vsaFmouN8UR61MYj81B7R5uBzgunz0doJ6qdnideFiMWzxf4Ndj4d+9uIiA07ARf8SaU
         Wp/MBlqll7CjycqMl9SV3lquWGofrV9lUXMXMGFpCivIKwDtOOHqMQYNkGqpoe3F7ITB
         GVww==
X-Forwarded-Encrypted: i=1; AJvYcCXB7blaal1yCayquwjweNaxsPB1el7iMWh7KYN/kbJNicEUJ35ofOeJ8rnAMqJkJy11vRbIGUOk991Xv2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2t2T46qwXuLe4paZ7kdyakJrUfA53SuRX7O003cpTfQfzFrzo
	aT/ROLoceNscFtXNwRi/EeO0omjZxcExvA/VD091WgOh51JQ12dA3HiwKpYosXLbvLi4EQKiwMK
	0LII=
X-Google-Smtp-Source: AGHT+IHQ6Q8PkXwW8MkRPKtNaN6kWeT10jc398KmflG1NM1AyxwVW9WnqP3ne+6xWm3R1T1sFiFHdA==
X-Received: by 2002:a17:90a:1285:b0:2d3:c892:9607 with SMTP id 98e67ed59e1d1-2d646bad18fmr7565881a91.12.1724640579992;
        Sun, 25 Aug 2024 19:49:39 -0700 (PDT)
Received: from mozart.vkv.me (192-184-160-110.fiber.dynamic.sonic.net. [192.184.160.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5ebbb00d3sm10865521a91.39.2024.08.25.19.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 19:49:39 -0700 (PDT)
Date: Sun, 25 Aug 2024 19:49:36 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: David Lin <yu-hao.lin@nxp.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"briannorris@chromium.org" <briannorris@chromium.org>,
	"francesco@dolcini.it" <francesco@dolcini.it>,
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [EXT] Re: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to
 support iw61x
Message-ID: <ZsvtQCXxNJHh_DWS@mozart.vkv.me>
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
 <Zsc1efkBHDXdZtfJ@pengutronix.de>
 <ZsuWExGZyY8Tvu6s@mozart.vkv.me>
 <PA4PR04MB96384BCB4093D621C43B047ED18B2@PA4PR04MB9638.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PA4PR04MB96384BCB4093D621C43B047ED18B2@PA4PR04MB9638.eurprd04.prod.outlook.com>

On Monday 08/26 at 02:33 +0000, David Lin wrote:
> > From: Calvin Owens <calvin@wbinvd.org>
> > Sent: Monday, August 26, 2024 4:38 AM
> > To: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: David Lin <yu-hao.lin@nxp.com>; linux-wireless@vger.kernel.org;
> > linux-kernel@vger.kernel.org; kvalo@kernel.org; johannes@sipsolutions.net;
> > briannorris@chromium.org; francesco@dolcini.it; Pete Hsieh
> > <tsung-hsien.hsieh@nxp.com>; kernel@pengutronix.de; calvin@wbinvd.org
> > Subject: [EXT] Re: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to support
> > iw61x
> >
> > Caution: This is an external email. Please take care when clicking links or
> > opening attachments. When in doubt, report the message using the 'Report
> > this email' button
> >
> >
> > On Thursday 08/22 at 14:56 +0200, Sascha Hauer wrote:
> > > On Fri, Aug 09, 2024 at 05:44:50PM +0800, David Lin wrote:
> > > > This series adds support for IW61x which is a new family of 2.4/5
> > > > GHz dual-band 1x1 Wi-Fi 6, Bluetooth/Bluetooth Low Energy 5.2 and
> > > > 15.4 tri-radio single chip by NXP. These devices support 20/40/80MHz
> > > > single spatial stream in both STA and AP mode. Communication to the
> > > > IW61x is done via SDIO interface
> > > >
> > > > This driver is a derivative of existing Mwifiex [1] and based on
> > > > similar full-MAC architecture [2]. It has been tested with i.MX8M
> > > > Mini evaluation kits in both AP and STA mode.
> > > >
> > > > All code passes sparse and checkpatch
> > > >
> > > > Data sheet (require registration):
> > > > https://ww/
> > > > w.nxp.com%2Fproducts%2Fwireless-connectivity%2Fwi-fi-plus-bluetooth-
> > > >
> > &data=05%7C02%7Cyu-hao.lin%40nxp.com%7Cff25728795724a618a5208dcc5
> > 45c
> > > >
> > 5fd%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63860215067862
> > 3224%
> > > >
> > 7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB
> > TiI6
> > > >
> > Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=U0Cej8ysBD%2Fg1Sa4Ia
> > Ph63Ot
> > > > iTcemadiCfMINYM%2BRL4%3D&reserved=0
> > > > plus-802-15-4/2-4-5-ghz-dual-band-1x1-wi-fi-6-802-11ax-plus-bluetoot
> > > > h-5-
> > > > 4-plus-802-15-4-tri-radio-solution:IW612
> > > >
> > > > Known gaps to be addressed in the following patches,
> > > >   - Enable 11ax capabilities. This initial patch support up to 11ac.
> > > >   - Support DFS channel. This initial patch doesn't support DFS channel in
> > > >     both AP/STA mode.
> > > >
> > > > This patch is presented as a request for comment with the intention
> > > > of being made into a patch after initial feedbacks are addressed
> > > >
> > > > [1] We had considered adding IW61x to mwifiex driver, however due to
> > > >     FW architecture, host command interface and supported features are
> > > >     significantly different, we have to create the new nxpwifi driver.
> > > >     Subsequent NXP chipsets will be added and sustained in this new
> > driver.
> > >
> > > I added IW61x support to the mwifiex driver and besides the VDLL
> > > handling which must be added I didn't notice any differences. There
> > > might be other differences, but I doubt that these can't be integrated
> > > into the mwifiex driver.
> >
> > Hi Sascha,
> >
> > I'd also love to see this patchset, if you're able to share it. I can test on an
> > IW612 if that's helpful at all.
> >
> > > Honestly I don't think adding a new driver is a good ideai, given how
> > > big wifi drivers are and how limited the review bandwidth is.
> > >
> > > What we'll end up with is that we'll receive the same patches for both
> > > drivers, or worse, only for one driver while the other stays unpatched.
> >
> > I have some concrete experience with "in-tree driver forks" like this:
> > a pair of SCSI drivers named mpt2sas and mpt3sas.
> >
> > The latter was created as a near copy of the former:
> >
> >
> > https://git.kernel/
> > .org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcom
> > mit%2F%3Fid%3Df92363d12359&data=05%7C02%7Cyu-hao.lin%40nxp.com%7
> > Cff25728795724a618a5208dcc545c5fd%7C686ea1d3bc2b4c6fa92cd99c5c3016
> > 35%7C0%7C0%7C638602150678637352%7CUnknown%7CTWFpbGZsb3d8eyJW
> > IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0
> > %7C%7C%7C&sdata=mzrLLqJNee7vIdV47j8xVSU%2FByjh%2FnNKnRsx1nw3yNo
> > %3D&reserved=0
> >
> > The result was *exactly* what you forsee happening here: both drivers were
> > constantly missing fixes from the other, and they were just subtly different
> > enough that it wasn't simple to "port" patches from one to the other. It was a
> > frustrating experience for everybody involved. I think their git histories prove
> > your point, I'd encourage everyone with a horse in this race to take a look at
> > them.
> >
> > It took three years to finally unify them:
> >
> >
> > https://git.kernel/
> > .org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcom
> > mit%2F%3Fid%3Dc84b06a48c4d&data=05%7C02%7Cyu-hao.lin%40nxp.com%7
> > Cff25728795724a618a5208dcc545c5fd%7C686ea1d3bc2b4c6fa92cd99c5c3016
> > 35%7C0%7C0%7C638602150678649431%7CUnknown%7CTWFpbGZsb3d8eyJW
> > IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0
> > %7C%7C%7C&sdata=UGjDfngO1POWuydIfmOL%2BR%2BqJ1BoDQW6NboQUV
> > q2Xh8%3D&reserved=0
> >
> > I doubt anyone would disagree that wifi drivers are much more complex than
> > SCSI drivers. It would be strictly *worse* here, and the path to unifying them
> > strictly longer.
> >
> > Thanks,
> > Calvin
> >
> 
> I think Nxpwifi will support NXP new WiFi chips and Mwifiex will support existed NXP WiFi chips.

Hi David,

I understand that. I don't think that really changes anything: there
will still be many future patches which need to be applied to both,
because the bug being fixed existed before the fork. As the forked
driver diverges, that will only become more difficult and error prone.

Thanks,
Calvin

> David

