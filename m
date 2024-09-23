Return-Path: <linux-kernel+bounces-335689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4758697E924
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E706B1F21FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FE6194AFE;
	Mon, 23 Sep 2024 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O8/UmZGP"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C098479
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727085312; cv=none; b=qWTAYQr5h+kAmUwfyp3iF/A0QvC2VZ9Hib93mUrPDA9AZbPZRYy8HSsi+8U6YOuvqPR3hexQwpLMfo95up/fAiU/ARcIZbtvEf5RRKgyAiCN6uirOMYC7SlzpzcAF24JkrwW/HkPqmCsIqkEd9fFz+OIKLjExmuSuje6rFCQi9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727085312; c=relaxed/simple;
	bh=J4o8JzDp2yz1GGIFrCJ+rMTUUnD+FAkBCVr8fE1H78w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9fmq6JI+EHIFmAgDLv/xfZGCSOOXrU683TjIlKSqxvUP7XWbHpJgrG1aseBEkelJSOcZ8DrJXt7KF6Y1ho3IyBz+tQ5+5xWQ90nWF6uzZ7cNZaHHmESpMGwwIsqLCYOEHBTOhVFgcpqH3nQNnBWwq6X+uPrdXn4DbCXjHQ/RO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O8/UmZGP; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 209D2E0017;
	Mon, 23 Sep 2024 09:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727085301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GtciH+6fYB+wPGJcsZy95HneQ85Qj6dnHAz8ksQYExw=;
	b=O8/UmZGPTcjprGbxxASUWJKHYLiT3S1+ld1M1aV/HU4ca4gwhlpvxE0p0frIyALyRNNNDU
	34iIuvN/kB44vFZ7pK6oXgzLpckAKWVWD00PXU+zes3BkQ+tZJijaTNIPAYa5d1mRRXuvu
	9GzhJXS2qWMD8tpec/NlhOf/z/Cy5r4b6SjxGz1jE6P/iGUNMb0kIyjNVH4sQg8fEXP3mF
	kByYvzEWIfXOM4f92H62Ka59OjgRjuOwRY8HSYMX0hQUH/3XFLbjG4jsuEHfxSGDif9w2U
	7F5rCwHudpY0+3K52KCOPyMIDeIvw7jknQONG0z8tF+J5I7be7NnSuX02/hHbA==
Date: Mon, 23 Sep 2024 11:54:57 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	jani.nikula@linux.intel.com, thomas.petazzoni@bootlin.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: writeback: Introduce drm managed helpers
Message-ID: <ZvE68e95dwLqjVuW@2a02-8440-b157-69df-aafc-5046-a3b3-4ce9.rev.sfr.net>
Mail-Followup-To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	jani.nikula@linux.intel.com, thomas.petazzoni@bootlin.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240906-writeback-drmm-v1-1-01ede328182c@bootlin.com>
 <rz3xk3kwwsfstjrqffp4vfkm7mvn5sdviwjzb5dodmsnb5v2fz@vuamquxmvt4r>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rz3xk3kwwsfstjrqffp4vfkm7mvn5sdviwjzb5dodmsnb5v2fz@vuamquxmvt4r>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 22/09/24 - 18:31, Dmitry Baryshkov a écrit :
> On Fri, Sep 06, 2024 at 07:28:17PM GMT, Louis Chauvet wrote:
> > Currently drm_writeback_connector are created by
> > drm_writeback_connector_init or drm_writeback_connector_init_with_encoder.
> > Both of the function uses drm_connector_init and drm_encoder_init, but
> > there is no way to properly clean those structure from outside. By using
> > drm managed variants, we can ensure that the writeback connector is
> > properly cleaned.
> > 
> > This patch introduce drmm_writeback_connector_init, an helper to initialize
> > a writeback connector using drm managed helpers. This function allows the
> > caller to use its own encoder.
> 
> Also it introduces drm_writeback_connector_cleanup(). Ideally that
> should be a separate commit with a proper description.

Will do for the v2.

> You should also
> document that existing users should call that function (and maybe add a
> WARN_ON that can check if the function wasn't called).

It was my initial implementation [2] (usage in [3]), but Maxime suggested 
switching to drmm. If I make it non-static, this will be a new API with no 
user.

I don't know how to add a warning if this function is not called. Do you 
have an example somewhere where a warning is emitted after everything has 
been cleaned up?

> Last, but not least, please don't add API without a user. Please switch
> at least one driver into using this API.

The user will be VKMS, see [1].

[1]:https://lore.kernel.org/all/20240912-google-vkms-managed-v3-4-7708d6ad262d@bootlin.com/
[2]:https://lore.kernel.org/all/20240814-google-remove-crtc-index-from-parameter-v1-11-6e179abf9fd4@bootlin.com/
[3]:https://lore.kernel.org/all/20240814-google-remove-crtc-index-from-parameter-v1-12-6e179abf9fd4@bootlin.com/

Thanks,
Louis Chauvet

> > 
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > ---
> > Hi Maxime, Jani,
> > 
> > I tried with this commit to implement the drm-managed version of writeback 
> > connector initialization. I tested with the current vkms driver, and it 
> > seems to works (at least no crash/warns).
> > 
> > As suggested by Jani, I only created one function, which takes a 
> > NULL-able pointer for encoder/encoder functions/possible_crtc. What do you 
> > think about it?
> > 
> > Regarding the documentation, I think I repeated too much, can I simply add 
> > comments like "see documentation of @... for the details / requirements"?
> > 
> > Good weekend,
> > Louis Chauvet
> > ---
> >  drivers/gpu/drm/drm_writeback.c | 224 ++++++++++++++++++++++++++++++++++------
> >  include/drm/drm_writeback.h     |   7 ++
> >  2 files changed, 201 insertions(+), 30 deletions(-)
> > 
> 
> -- 
> With best wishes
> Dmitry

