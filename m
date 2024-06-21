Return-Path: <linux-kernel+bounces-224278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F98912022
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6701C22880
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3490716D9B1;
	Fri, 21 Jun 2024 09:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqnToB/9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7656A1C02;
	Fri, 21 Jun 2024 09:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718960902; cv=none; b=TeOr4IOwUh/NAG0oMnwntf63F/I3DKQG3VGgJdipuX8t+C8IvX8FHSqjVb0shEiwg0StcFMTNUzqVX00HzHfGIVRYSPJ5PYMnkGi3VHupkLcONabiMlCJN1z68zgzmPBobU5lE9zYaVO/yajtRYsvtp6q1BnjaT9cLzFL5NjnoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718960902; c=relaxed/simple;
	bh=JIeqoaIa7EKTaeKtvAYQWwAw9IeCYkgkrJJWV2KYcqo=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=YJaJZxelmodIUIaiZgFnOEd4lPHMRlo1hTlADskpHIhXql5+SDCJMMjH+E6yi8Sc55WyFLIfu37R84y/FFutZlZNJ32YxfxFdqV2RfQD84AH99uxlub5yCD5+9A0d2Yrc/EpHqyxRCGbNAR2TjZXCgSiThIg5HNOAJxYTAyGlhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqnToB/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7475EC2BBFC;
	Fri, 21 Jun 2024 09:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718960902;
	bh=JIeqoaIa7EKTaeKtvAYQWwAw9IeCYkgkrJJWV2KYcqo=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=IqnToB/9X11ppEn/xXYZbNOhbMPxLenETGWyexBKZU+fzT1WxXbi2gFFDBg05vY53
	 oNEhYAOhKD/KcxT8ezrzqbzO54kcdxO2ZPszBFU4BJougE4i7zvdnrPsavceCNUQVA
	 ln3PzOO0eusBGoJqczNT2sggxvpFMiZ0iJJgC/djlvuO2UyDalykT702p0BEzJXW54
	 zqwnhMXS0whYj21c1eNeToyzDH3B2E5pjcghvWQUSlilxgvxqifRw+r01NNJhwBFOA
	 3BLui8oJabIWm8JjXQW9Ld1HwUW7s3TYHWEtmWI/MC5vgpdUMJy2MRV4FZ3X/YLloj
	 dk8uo8g4D4Xzw==
Message-ID: <a1086246d73bb548d72799324dc96983@kernel.org>
Date: Fri, 21 Jun 2024 09:08:19 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH RFC 1/5] drm/bridge: lt9611: use HDMI Connector helper
 to set InfoFrames
In-Reply-To: <20240615-drm-bridge-hdmi-connector-v1-1-d59fc7865ab2@linaro.org>
References: <20240615-drm-bridge-hdmi-connector-v1-1-d59fc7865ab2@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, "Andrzej
 Hajda" <andrzej.hajda@intel.com>, "Daniel Vetter" <daniel@ffwll.ch>, "David
 Airlie" <airlied@gmail.com>, "Jaroslav Kysela" <perex@perex.cz>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, "Jonas Karlman" <jonas@kwiboo.se>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Liam Girdwood" <lgirdwood@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Mark Brown" <broonie@kernel.org>, "Maxime
 Ripard" <mripard@kernel.org>, "Neil Armstrong" <neil.armstrong@linaro.org>, "Robert
 Foss" <rfoss@kernel.org>, "Takashi Iwai" <tiwai@suse.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Sat, 15 Jun 2024 20:53:30 +0300, Dmitry Baryshkov wrote:
> Use new HDMI Connector helpers in the Lontium LT9611 bridge driver.
> Program InfoFrames using the helper's callbacks. Also use TMDS char rate
> validation callback to filter out modes, instead of hardcoding 4k@30.
> 
> The Audio InfoFrame isn't yet handled by these helpers, it requires
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

