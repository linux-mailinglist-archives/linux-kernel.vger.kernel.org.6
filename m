Return-Path: <linux-kernel+bounces-389475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A36F39B6D85
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69275282AEC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5BF213EF6;
	Wed, 30 Oct 2024 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTaUTCqq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71AF1D12ED;
	Wed, 30 Oct 2024 20:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319638; cv=none; b=BSLvnHgTycaGbiDIb4rYnuEflgHrnNmEtGDckgYrE45MUpOmalYCECEpTsdSJw6WWVR4unRcd29t3VeLxUw36AiQguBDsWLPVnD6Uc5NlWGBTf05t5ysVvTIMMovK/QG8r9qyWaLSDFsFUtSiGeMEdw3sIws6KnQGoN36SlQBOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319638; c=relaxed/simple;
	bh=CuBZ7a5jZNesEjvm4P0cJ7WsRpENx9Ukmf3FByacUNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c79f6HkIVLFG8tMECfC7JYqAIzThBviixxXlmaPjCgMkvRAyMkZVwOxpc3iW01oNpul0COcICYESdUrY7yo2QHMhoMQ8YEIaNw8GS68pwzXI8aAUMiBUTaa5EIhrEwDjwtAL5400nVTJk6/YMFRjSLEMuFPW884knLUoWXjwduY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTaUTCqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36248C4CECE;
	Wed, 30 Oct 2024 20:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730319637;
	bh=CuBZ7a5jZNesEjvm4P0cJ7WsRpENx9Ukmf3FByacUNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oTaUTCqq5kay8J3AvHvGGwA0iYKKKXWuV/NPR5DZmv+HzTwjY+75jJ1cc9eqYtaZH
	 SeLlz7UhdNipKLn1yX0FLRRBDsOK27e5N4r59q0o8YyrN5R6/G81UamYilbLdCBgmq
	 2KGIsw8fzc3YgiHejETp8lZO2/KNd2zm+9YBUvUNhy2frcwb/jdCWPaYEeVbiRkxvr
	 r3FdT/Oi4RtagtYJWYsxtR9Ebnl0s1OqnYWck8faS5fs4xzJs/kkC0IK7i7uYDMF/I
	 HtuwfCeg8tV+EAi+qq8Rb8tYfSJr/iEEAs2ONuPOnQUiPjTx1/hIaBSKW0SaX9DZ51
	 jx6x3hI9h6bKA==
Received: by pali.im (Postfix)
	id 151DD9D2; Wed, 30 Oct 2024 21:20:30 +0100 (CET)
Date: Wed, 30 Oct 2024 21:20:29 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Dell.Client.Kernel@dell.com, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, w_armin@gmx.de
Subject: Re: [PATCH 2/2] dell-wmi-base: Handle Win-key Lock/Unlock events
Message-ID: <20241030202029.3ugz75wiautw6ewt@pali>
References: <20241030181244.3272-2-kuurtb@gmail.com>
 <20241030181532.3594-2-kuurtb@gmail.com>
 <20241030183436.3w5po6kcg6jmqigb@pali>
 <hj6jurton7ll4i475cwcqvk6dzjjire2briawxmuemnliofpyo@kpjdxpwflekm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <hj6jurton7ll4i475cwcqvk6dzjjire2briawxmuemnliofpyo@kpjdxpwflekm>
User-Agent: NeoMutt/20180716

On Wednesday 30 October 2024 17:11:40 Kurt Borja wrote:
> On Wed, Oct 30, 2024 at 07:34:36PM +0100, Pali Rohár wrote:
> > On Wednesday 30 October 2024 15:15:33 Kurt Borja wrote:
> > > Some Alienware devices have a key that locks/unlocks the Win-key. This
> > 
> > Please specify (in comment / commit message) which devices. It would
> > help other developers in future to track for which device is this event
> > needed.
> 
> I will!
> 
> > 
> > > key triggers a WMI event that should be ignored, as it's handled
> > > internally by the firmware.
> > 
> > Can be this handling in FW ignored? So OS can use this key for any other
> > functionality?
> 
> Probably not. FW locks the Win-key regardless of how the event is
> handled.
> 
> > 
> > Anyway, what is that Win-key and its lock?
> 
> Win-key is the LEFTMETA key and the lock key is the RIGHTMETA key.

Ok, thanks for info.

So if the firmware handles and process RIGHTMETA key, it means that the
RIGHTMETA key is not usable for generic purposes on this machine?

> > 
> > > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > > ---
> > >  drivers/platform/x86/dell/dell-wmi-base.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/platform/x86/dell/dell-wmi-base.c b/drivers/platform/x86/dell/dell-wmi-base.c
> > > index 502783a7a..37fc0371a 100644
> > > --- a/drivers/platform/x86/dell/dell-wmi-base.c
> > > +++ b/drivers/platform/x86/dell/dell-wmi-base.c
> > > @@ -80,6 +80,12 @@ static const struct dmi_system_id dell_wmi_smbios_list[] __initconst = {
> > >  static const struct key_entry dell_wmi_keymap_type_0000[] = {
> > >  	{ KE_IGNORE, 0x003a, { KEY_CAPSLOCK } },
> > >  
> > > +	/* Win-key Lock */
> > > +	{ KE_IGNORE, 0xe000, {KEY_RESERVED} },
> > 
> > nit: code style: spaces around KEY_RESERVED.
> 
> I will fix it.
> 
> > 
> > Is not there some better constant for this KEY_*?
> 
> We could assign it KEY_RIGHTMETA.

Just to note that if the key is marked with KE_IGNORE, its value is not
used. But for documentation purposes it is a good idea to have written
there something other than KEY_RESERVED -- if it is possible.

For example it can be useful if somebody in future figure out how to
turn off processing of this key in firmware...

> > 
> > > +
> > > +	/* Win-key Unlock */
> > > +	{ KE_IGNORE, 0xe001, {KEY_RESERVED} },
> > > +
> > >  	/* Key code is followed by brightness level */
> > >  	{ KE_KEY,    0xe005, { KEY_BRIGHTNESSDOWN } },
> > >  	{ KE_KEY,    0xe006, { KEY_BRIGHTNESSUP } },
> > > -- 
> > > 2.47.0
> > > 

