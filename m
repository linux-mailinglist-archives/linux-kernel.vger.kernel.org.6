Return-Path: <linux-kernel+bounces-185083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 521A78CB046
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93851F23CAC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1A812F5B1;
	Tue, 21 May 2024 14:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K315iUjp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C633412F388;
	Tue, 21 May 2024 14:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716301266; cv=none; b=TNWTcj2JkZQ9QgWKC2c/OfznC1lGtC7L3d+4wU0MfRt/jf0WwrVlLbRt4hOF3gJcrWGiqz1zHZlJB++VV+AbfTyzRgt82pg0RQfTcPfyyzorxiwsmmJjzkuGLHgSWut5PmJLGHUA/WteJ17zf5yFa9jOh3BMPJQStybDxKJQIZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716301266; c=relaxed/simple;
	bh=CLn2G4vuf3oqkBDthyQRr2R2coyMKZzEup6hxUQ08uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lk0xrZzVxgBGgHxpldSEnFYJLThZU6VE0QruI4PvQI1hpZCVzdh3bL2fFqpbnJRgsTPGFMpHu7K7oXgvsYqlyCdc83Kt7H9HfHsKkPY5AzPVDr7qMt8iTOIH7MMAq8gl+pNCu2CgI2Q8HT46qGQ6yzMB3QQzBgRNS601ClEXx+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K315iUjp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33621C4AF09;
	Tue, 21 May 2024 14:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716301266;
	bh=CLn2G4vuf3oqkBDthyQRr2R2coyMKZzEup6hxUQ08uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K315iUjpBHdqtqR4SIkjemhcchKB0hAco+F+zmDbiSjfML1DhHMC26xg+aIor62ZL
	 B58A+4O2N5B7z9+j9su5xbnz3rqZKPOHGn/d/+hoYTaVijlZCVYdzvdeGmttb2yYBv
	 O0sMT4IBB1J0ymBAqfxwEIQWda8b+T8uQAr43Xf1sx8oyfcAKrGRK09poTVMEjG+eT
	 HFgHRvX52akpZeLeSLFvkqXMRAPZlucaDURmkbfOZDrfxX84q5Do35I7RVWkJHmHri
	 zud1cpeFU6p1KJGSJVLF0jP1M4kGeG6EFAIbuAvMZnZtqu1VCYs27uNVNEwUbgy0ot
	 K0eNwl8qveSIQ==
Date: Tue, 21 May 2024 09:21:05 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org,
	Thierry Reding <thierry.reding@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	devicetree@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH] dt-bindings: display: Reorganize legacy eDP panel
 bindings
Message-ID: <171630126263.4110905.17984387768866183422.robh@kernel.org>
References: <20240520153813.1.Iefaa5b93ca2faada269af77deecdd139261da7ec@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520153813.1.Iefaa5b93ca2faada269af77deecdd139261da7ec@changeid>


On Mon, 20 May 2024 15:38:17 -0700, Douglas Anderson wrote:
> Back in the day, we used to need to list the exact panel in dts for
> eDP panels. This led to all sorts of problems including a large number
> of cases where people listed a bogus panel in their device tree
> because of the needs of second sourcing (and third sourcing, and
> fourth sourcing, ...). Back when we needed to add eDP panels to dts
> files we used to list them in "panel-simple.yaml".
> 
> These days we have the new way of doing things as documented in
> "panel-edp.yaml". We can just list the compatible "edp-panel", add
> some timing info to the source code, and we're good to go. There's not
> really good reasons not to use this new method.
> 
> To try to make it obvious that we shouldn't add new compatible strings
> for eDP panels, let's move them all out of the old "panel-simple.yaml"
> file to their own file: "panel-edp-legacy.yaml". This new file will
> have a description that makes it obvious that we shouldn't use it for
> new panels.
> 
> While we're doing this:
> - We can remove eDP-specific properties from panel-simple.yaml since
>   there are no more panels there.
> - We don't need to copy non-eDP properties to the
>   "panel-edp-legacy.yaml".
> - We'll fork off a separate yaml file for "samsung,atna33xc20.yaml".
>   This is an eDP panel which isn't _quite_ handled by the generic
>   "edp-panel" compatible since it's not allowed to have an external
>   backlight (it has one builtin) and it absolutely requires an
>   "enable" GPIO.
> - We'll un-fork the "sharp,ld-d5116z01b.yaml" and put it in
>   "panel-edp-legacy.yaml" since there doesn't appear to be any reason
>   for it to be separate.
> 
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  .../display/panel/panel-edp-legacy.yaml       | 127 ++++++++++++++++++
>  .../bindings/display/panel/panel-simple.yaml  |  58 --------
>  .../display/panel/samsung,atna33xc20.yaml     |  95 +++++++++++++
>  .../display/panel/sharp,ld-d5116z01b.yaml     |  30 -----
>  4 files changed, 222 insertions(+), 88 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/panel-edp-legacy.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/sharp,ld-d5116z01b.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


