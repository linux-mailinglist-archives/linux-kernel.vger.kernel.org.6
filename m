Return-Path: <linux-kernel+bounces-290842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA15F955967
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 21:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 344EF1F21F09
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 19:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7103015534D;
	Sat, 17 Aug 2024 19:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="FJG0oTJ6"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753B04A2D
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723922903; cv=none; b=chFeYcOrt2xcLVM2b/B5ofDJrIom5Dv1qhf113GOYv1pxkq/sUwd7r6yEULi9dcmv6iNNa51WdnyOftRbQWEDrVt4MH9wXUnweEZ28pLfwd2KHEJ+x02oVdKcDsuwQ0w5Wfc9f/7JA8Q+LycT1ILw5bHWT0J96aIZ4+6ZiW6X3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723922903; c=relaxed/simple;
	bh=buq2gqRLEnCsTc8U9OTezdiCTUKjtZxGXRrn7CtZc+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqjLegKKnD88JkoYFmnXfBzHEIvbgaEK7zTpqfCcIYdQSf2nFZbZg1YcNbTuIMxb9WU4uaXdAcFDtZmJsAdRLJSEydN3cFs+ezgsXkUTfsukYOc6nnY9/PSPA872BSzM4thBsOB3sFqhYf/yGgXjnezdpqo1z01KP0UDy7VPW3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=FJG0oTJ6; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723922891;
	bh=buq2gqRLEnCsTc8U9OTezdiCTUKjtZxGXRrn7CtZc+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FJG0oTJ6zK4a3YcVioXPzEFseqTOEH38EnrBMI/PA9/myTDjcUFHPfSyn8lBH25uK
	 L/mUlx5Edbf3WZowu8l26LErMEgKJB7Rja4DOm8YhHNFQF5t+QtOcLjbqV8cHkZblZ
	 bMhIbAVS6IttxsIjvFoaLgZinim80z/l0+xQctl0=
Date: Sat, 17 Aug 2024 21:28:10 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Dustin Howett <dustin@howett.net>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Alex Deucher <alexander.deucher@amd.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Matt Hartley <matt.hartley@gmail.com>, Kieran Levin <ktl@framework.net>, 
	Hans de Goede <hdegoede@redhat.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, Jonathan Corbet <corbet@lwn.net>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: panel-backlight-quirks: Add Framework 13 glossy and
 2.8k panels
Message-ID: <02b27fe8-d20f-429f-9a62-e8ef7a9e0206@t-8ch.de>
References: <20240817-drm-add-additional-framework-laptop-displays-to-panel-backlight-quirks-v1-1-cfdd5dbbffc8@howett.net>
 <CA+BfgNK9PEspi8=M2YDC4Kc43+JcEo2iej4Q2K7O2r9X1=X=OA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+BfgNK9PEspi8=M2YDC4Kc43+JcEo2iej4Q2K7O2r9X1=X=OA@mail.gmail.com>

Hi Dustin,

On 2024-08-17 14:23:42+0000, Dustin Howett wrote:
> On Sat, Aug 17, 2024 at 1:59 PM Dustin L. Howett <dustin@howett.net> wrote:
> >
> > This patch depends on
> > 20240812-amdgpu-min-backlight-quirk-v4-0-56a63ff897b7@weissschuh.net
> >
> > I have tested these panels on the Framework Laptop 13 AMD with firmware
> > revision 3.05 (latest at time of submission).

Thanks for the tests and patch!

> I apologize for the noise. I built this against Thomas' earlier patch
> version and obviously did inadequate testing when he submitted v4.
> 
> I will follow up with a new revision after a little while.
> 
> >
> > +               .quirk.pwm_min_brightness = 0,
>                    ^^^^^^
> This is clearly incorrect for the updated quirks infrastructure.

If you want, I can incorporate your patch directly into my series.
This would make the value of the quirk infrastructure in the introducing
series clearer and it should be easier for everybody to keep track of
the different parts.
If you agree, please let me know and either send me your updated patch
privately or I can adapt the patch you posted on my own.

My plan is to send a new revision tomorrow.


Thomas

