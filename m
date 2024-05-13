Return-Path: <linux-kernel+bounces-177616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DED98C41A4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C865B23C93
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC2B152194;
	Mon, 13 May 2024 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVOQ6J6q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE5B1514CB;
	Mon, 13 May 2024 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715606234; cv=none; b=aNXwZgXKPewn+I73PUwGw91uKy5ObUmgff3k0eBTs28llFoQiQuhxD8IAzYtFcWA/h1JY9c49CMuQn9Kq7slyEFhw4V0Qm62wFI9N0CwxxZajKXKWwDiOG84PoNyddjofLrvKiIq6WIngp99k0mU3vYtAhAcO3wc8I/yhOmFtQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715606234; c=relaxed/simple;
	bh=sCQQdb5fu1AI/GGQpLevWmpW1G8ldkeo47pUNmNMP28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLfABpuy3HzoqDs2nERVx54QSuK8/rNWww1bpT5Zdhf+tCd1aXLlgGL5COeh//7f6rAZbhzAk7eu52aMkF6GAiRx8ovuY8TeKcO7KBJWXjVk/Rz3ii6II2bbCpacNS5yu1wseL7cdNNLb7cdpgk6uX5GKylSjdZmF7zY2tAzs8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVOQ6J6q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C88C32782;
	Mon, 13 May 2024 13:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715606234;
	bh=sCQQdb5fu1AI/GGQpLevWmpW1G8ldkeo47pUNmNMP28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GVOQ6J6qh9mPjnMq3qWXWlho7YHflOLaSR7O8ow4CyTYYKWE8VLxAuwgeNWUvnhbB
	 lJHTadSnAkBn5dX3iQDDPYfwl8qEa253rLwbY80rMa6ltM8/CL90fDFQxsyO9WEIpV
	 yIFYmDclZKObVEIt5Gc5FEtij2cLgxyKYBClMwdserwKoCcjhUapvYgMRGAbUWy/3I
	 +V4XjklX7tXHR9liySEK4MtRskLrFbK5tDgx/bUnkD7AB0avM2xNxDR8vHg80WMof1
	 YgwS3ipWEE7NYv9RmhOpWWmmnzg8S3tfOuQ3eJjWVhhxk36eiilob23X8S5/0yLHWw
	 RxzmKIwNUU3Sw==
Date: Mon, 13 May 2024 08:17:11 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Konrad Dybcio <konradybcio@gmail.com>,
	Del Regno <angelogioacchino.delregno@somainline.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Luca Weiss <luca.weiss@fairphone.com>,
	Dmitry Baryskov <dmitry.baryshkov@linaro.org>,
	Shawn Guo <shawn.guo@linaro.org>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] dt-bindings: display: panel: constrain 'reg'
Message-ID: <20240513131711.GA2419451-robh@kernel.org>
References: <20240509-dt-bindings-dsi-panel-reg-v1-0-8b2443705be0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509-dt-bindings-dsi-panel-reg-v1-0-8b2443705be0@linaro.org>

On Thu, May 09, 2024 at 11:42:50AM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> Cleanups for display panel bindings.
> 
> Rob, maybe you could take entire set if it applies? I based it on
> linux-next, so letl me know if I need to rebase on your for-next.

Applied. These 2 don't exist in my tree:

Documentation/devicetree/bindings/display/panel/lg,sw43408.yaml
Documentation/devicetree/bindings/display/panel/raydium,rm69380.yaml

Rob

