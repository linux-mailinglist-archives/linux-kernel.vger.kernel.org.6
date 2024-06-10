Return-Path: <linux-kernel+bounces-208176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DF19021E5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F9928351F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887E580BF7;
	Mon, 10 Jun 2024 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="i0ShZLRm"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD2F80045
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718023688; cv=none; b=moptNn465pTrOcGvOSBWzAjzAXBAW6DZU7jLAUXbQmZCMxQN+UFdauFW7srnt5MWYX1Vf5R5lKOvg3Q8htjqaTmbus3vw3Y1UOLdMnA6aiThkPj16AVql0J1ey/yHKgsYXu9ub3vsYNThTkuHEOOVRYNFyv9e5BdJ0PZb1ZXAhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718023688; c=relaxed/simple;
	bh=+ecHLff7v1OpVQFUWVfCE9rGpM2sM5huV/0sdhzdtVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETAmx7ieawo+8Ir+EtRP3IN0ApHVnpZWEvaIv9iOWwn4a0aH65hV3qlZ3czyFTPZeDZdt5XH8ek6LFjLnqoPRbixkmFnD8Nx4IZ9FH5KdvM/gt5mwsmg419hQr7It2Ca0aybaTYjEGLQ8KPA1i1/sjHfE5df+s1F29XqZ0BKNPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=i0ShZLRm; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1718023677; bh=+ecHLff7v1OpVQFUWVfCE9rGpM2sM5huV/0sdhzdtVw=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=i0ShZLRmqI9v9z2T54xJpJpCVR+0XfKrrmbHrBWPfwLyQxzaIrE/THGBNslgtTeVn
	 fdNvdGMyM+gc8hFllcAVpaeu2i6jeLH9ZbnJMvoyIVF+iwCcuT9n5o83hGo6Rb0U4y
	 M9V0DFz/BmnF+wVU9CuUE/WWSuwG1QzV2kvUCCjc=
Date: Mon, 10 Jun 2024 14:47:57 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Maxime Ripard <mripard@kernel.org>
Cc: linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 0/3] Move blender setup from individual planes to crtc
 commit in sun4i-drm
Message-ID: <55gzdgev6oq5mqc5rdybncn4yc3jahqrfqbldkfftyn2s25o3k@kysjowztftde>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240224150604.3855534-1-megi@xff.cz>
 <171801637114.423417.15912541590264684056.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <171801637114.423417.15912541590264684056.b4-ty@kernel.org>

On Mon, Jun 10, 2024 at 12:46:11PM GMT, Maxime Ripard wrote:
> On Sat, 24 Feb 2024 16:05:57 +0100, Ondřej Jirman wrote:
> > From: Ondrej Jirman <megi@xff.cz>
> > 
> > This series refactors blender setup from individual planes to a common
> > place where it can be performed at once and is easier to reason about.
> > 
> > In the process this fixes a few bugs that allowed blender pipes to be
> > disabled while corresponding DRM planes were requested to be enabled.
> > 
> > [...]
> 
> Applied to misc/kernel.git (drm-misc-next).

Thank you. :)

Kind regards,
	o.

> Thanks!
> Maxime
> 

