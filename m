Return-Path: <linux-kernel+bounces-518902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B988A395FF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FC2D177278
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DF522DF9F;
	Tue, 18 Feb 2025 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADXSoU2h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3E422CBD8;
	Tue, 18 Feb 2025 08:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739868040; cv=none; b=bq1V+CJSsKvXgLI5F0+U8Hc8FJlHpA7bYhIm3YGz+2hiZoJETHtzbCbUJTXDSoOdAgRAkTIXAtPLpbM+QZzN42+TQFBXSnySIZhivCXshw6xEPgL2/+KbOguSpt8uQkfCR7C/nqL7sMoOcrCu/Qh03haAuvSNuP0Ooa4JyutpBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739868040; c=relaxed/simple;
	bh=n2akpTGWIUPiDpg5UDCEvSWvsCe8G6rT5xtsrG+8fOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGiaDn3ommTmoiA0+mDmRWS+E6VA+lzGkAWaIBmGXOhNoSco4zFlVM4Jo5XfwbhFGKq3Q+PSuutIKqcTfJSCNzy4mturuME3rpBqGA9Ok05dz+KA/q0U8ZamteMpIBK3aAXjSe59RHyV/y5GzoW2J1iZs65Ziiqja8q2P4VZUEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADXSoU2h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F393BC4CEE2;
	Tue, 18 Feb 2025 08:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739868039;
	bh=n2akpTGWIUPiDpg5UDCEvSWvsCe8G6rT5xtsrG+8fOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ADXSoU2h5CxSVEcQuDafN/DBP9NJEUTDWhG7UCNpYSZT4Q99xnCwTIanHO7ltSvrd
	 VBebDKTTsq9YlskH27b4M5acTRUkpP8drTlj4l5Mb4L5KU5CPpNObQly0vK7j19VYc
	 bUqnscRb97jlJ8GUCRuzrw3faT5fKO11IBoeExKEOy5BLpkGcAvViCKKTAZZ8TeZ16
	 FnIkAqHbF/61fpt6gw6uP9Njp/0rXS3JzrdKPfX8wuj2RztPvyNmPqfa21Os7+UqsM
	 sgRnU3j3ARQXwf1/MfUZx3E398TzqXUQhBnK1qJQlgBNhwcNe8QLX07dhK451TMQ52
	 tOmhztHsscY4w==
Date: Tue, 18 Feb 2025 09:40:36 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: display: bridge: Document Solomon
 SSD2825
Message-ID: <20250218-wandering-angelfish-of-endurance-b35c2c@krzk-bin>
References: <20250217140910.108175-1-clamor95@gmail.com>
 <20250217140910.108175-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250217140910.108175-2-clamor95@gmail.com>

On Mon, Feb 17, 2025 at 04:09:09PM +0200, Svyatoslav Ryhel wrote:
> Add bindings for Solomon SSD2825 MIPI master bridge chip that connects an
> application processor with traditional parallel LCD interface and an LCD
> driver with MIPI slave interface. The SSD2825 supports both parallel RGB
> interface and serial SPI interface.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../display/bridge/solomon,ssd2825.yaml       | 141 ++++++++++++++++++
>  1 file changed, 141 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/solomon,ssd2825.yaml
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


