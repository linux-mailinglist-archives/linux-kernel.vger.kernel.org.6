Return-Path: <linux-kernel+bounces-352003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6569918FB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 19:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04525B216B3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 17:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635C7158DA7;
	Sat,  5 Oct 2024 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHfLjNLC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAED1F61C;
	Sat,  5 Oct 2024 17:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728150242; cv=none; b=I4Gpt4vTwSgDlc7rGo5PP42dRj/kjDAffZ934yi/B94knegB65P4hmVqZ/dqN7CITTyFH8q89tchugB9HXFmZOWjxckLLClWlJS547CBH3YmC0oe1O5H2OpXl7+r8/PbQzMQhRfZJCXq4K0qQGLtVj4d3cdwMtEDtfqrs1WWhnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728150242; c=relaxed/simple;
	bh=djk9MX/9q9abJv7cF3LUfPXfJX9TOYq3vBr1RWrzieM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToEUltSKkJYsJJCwE8XgUN1/ThDgCD9lNCKRTxFCRKnTu/XMKKuQSPIUUwi6hQZiplH2MnAIZ0TBXFQVeyce2wz71L+ysPZEUG3V5gYgfaPe9boj7W51Wipij4tq682j6m/25mO9o4QpDM5P3phZE/Fz00hHJxa3oPZWI+0/Xhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHfLjNLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2207CC4CEC2;
	Sat,  5 Oct 2024 17:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728150242;
	bh=djk9MX/9q9abJv7cF3LUfPXfJX9TOYq3vBr1RWrzieM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RHfLjNLCRptfy6ZcsFJ37LpVph/5PRErKNbnaWD/OQHHRV75W1s2mKnS9V7pe5Oph
	 z2UtCjqDF/Q8ngjubuDlJrmph7kxxuBt0Z+S+vwuK0t33RuDUOoDjEomPGUN1IS70O
	 fit2wOwkQg5RYg5L8Ig6S1v8NXz3y+EYzQrX6Cqm+tXxRnEiNmZMj+Oy2BPtxaq0Vb
	 gu6N0gdFX7vPsago9jgvKP29iKlpc7+sfzJ/s3qwTKlFPicqW/r87leOAMZfDEqbON
	 Winx8lUaLU+Pyok0JSSZbyJV3i3DIIvpaXG/pls09hAZkzeOqhoq7mRgMWoN5oguL8
	 qrNukWMvDRmKQ==
Date: Sat, 5 Oct 2024 12:44:01 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Maxime Ripard <mripard@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	David Airlie <airlied@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
	Andrzej Hajda <andrzej.hajda@intel.com>, devicetree@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH 1/2] dt-bindings: display: bridge: tc358768: switch to
 bus-width
Message-ID: <172815024006.438324.4885049988134352168.robh@kernel.org>
References: <20241003133904.69244-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003133904.69244-1-krzysztof.kozlowski@linaro.org>


On Thu, 03 Oct 2024 15:39:03 +0200, Krzysztof Kozlowski wrote:
> "data-lines" property is way too similar to "data-lanes".  It is also
> duplicating "bus-width" from video-interfaces.yaml schema.  Deprecate
> "data-lines" and use the common property.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/display/bridge/toshiba,tc358768.yaml  | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


