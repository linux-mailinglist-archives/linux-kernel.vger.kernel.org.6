Return-Path: <linux-kernel+bounces-549533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35C6A553A3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E30C1785AE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E981A269D01;
	Thu,  6 Mar 2025 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgmITw3i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BBC25CC96;
	Thu,  6 Mar 2025 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283697; cv=none; b=d7jLUJ+fO7lWTsPIPyDg7aUxRuK14xyl7i1SJUFhcHJqJqooyeL4sN/YZR0puc0tR6KG7/YQrospWn02hT4HVbkO+UYpTS9fy2WEXro0Jjg0UrfJFh+SX4M+69ywrc0pRPtg5iG9XZjL61sgmw1IUEudy8/p7q99kb7L7Q69Ew0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283697; c=relaxed/simple;
	bh=U3xdOAHZKeSPz+aKFdQVzR86S0fcAtL0VWeNwF394GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=om1gIx5WXA/CNw+GXQp9nRPNnyUy+DaLOHHS5RQwVXVTnx1D7VTgAxXlR+CJau5MGIdh4AyZJTnqHmwq7STqtVym9IiZfuIXkssroHXRs7lL8SJ16d7qUwXJCS69+kZuOMl5StBig9wNqgYbuaT8d6O0a6PVB7FUN9Lu3fGLLec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgmITw3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F90DC4CEE0;
	Thu,  6 Mar 2025 17:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741283696;
	bh=U3xdOAHZKeSPz+aKFdQVzR86S0fcAtL0VWeNwF394GU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qgmITw3itpG7rB5G4E2ytRfHOf/CZyLWYSRSCbnm+w+AwTfWijs5gy/RdBsSJMK4b
	 3QzzZ0KTatu2G+qOh5xBDH6GImXzOfG4vVdLGB9tiL1h/3RCBu9FWivFK0FRmVxTU/
	 RQRBziC0h9xr+87NHjTCvONt//OdhWp+FWnOjIAligvHHuQWxMj6MV+WNuegWpWUou
	 rwAz+QYFeqA0Wz2+EpZzjsaFAlFblkhd1JIm9kIDiqE+xtrZEgxrsOAhuvMK7zFXyJ
	 wkJLv+8bdL8G8i8UPoaofgbfY4ZfcNgkP7FOL4aunsdNt3yMlhCzOOwvvjXRoBAspa
	 Rgbye1eT1DP1w==
Date: Thu, 6 Mar 2025 11:54:55 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Simona Vetter <simona@ffwll.ch>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: display: mitsubishi,aa104xd12: Adjust
 allowed and required properties
Message-ID: <174128369455.567749.6557990524216998006.robh@kernel.org>
References: <20250225210316.3043357-1-robh@kernel.org>
 <20250225210316.3043357-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225210316.3043357-2-robh@kernel.org>


On Tue, 25 Feb 2025 15:03:15 -0600, Rob Herring (Arm) wrote:
> The Mitsubishi aa104xd12 panel requires an external backlight driver
> circuit, so allow the "backlight" property.
> 
> There are users of this panel without a vcc-supply, so it shouldn't be
> required.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/display/panel/mitsubishi,aa104xd12.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!


