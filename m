Return-Path: <linux-kernel+bounces-521762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4D4A3C205
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92EE3A97B4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCD71EFFAD;
	Wed, 19 Feb 2025 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzVFdQA1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403B31E5B65;
	Wed, 19 Feb 2025 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739974962; cv=none; b=IRhZJNrrnvk/YyRqZKqzTpoJ+jm79gYzQXdg50j327rPzLtjNqDzUHNxWKClwoPU193MT5i6C6Oag1Y+Wu/OFPOLi9/+/l6kUm211VbuI49xzUa8VvGPqYYTK9+v3H4oo3ZgDnq0qa7wpsUIUf6z5ZPzKSqW6xblCbFYHiPUrNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739974962; c=relaxed/simple;
	bh=L9cXmlOzsS72RtfjvOGSFezFI8Z+PKWtlvupHDV8mXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lb3a5ihd+fMubYOMpZUa5cUTuZn53cyUx4IBxS/iqypzcNrGiChPw39GVMugZFaNPbKTEYzTP6hJuQJm/tUE8qFwAyDwEDUVaIqhEDJQC+hpNbpnrJjqsuqU9gqwPq4RVsWRkvZz1wA4q14U7vghyhRkrXc6oYe/8xpimIwgwrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzVFdQA1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8078AC4CEE0;
	Wed, 19 Feb 2025 14:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739974961;
	bh=L9cXmlOzsS72RtfjvOGSFezFI8Z+PKWtlvupHDV8mXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uzVFdQA1Km9wft+L5wvygubV3B/Fz2QcpdIz+JXKjuuFKnitm6lsvXeidMhpBV0LQ
	 JK7WsHfxN8G2YeOy5B+9gUafcBqnx9y+tYC8QTMCkx3oDabU8J2PwGuLciLpoTljGi
	 gJ2Q5aCQBqTYAs6WoDUu08uUDQgR/mbz9D7iLK4Gu0fEoFGiZAqW1Lx+RYPlqEvgJI
	 y/xh4EDCHkbz5JvAxxpBrpg6l4iuwb1aVlZU2jLWIfQxcryta/MKtPr3q6ZMKGzGLz
	 8dL1VqT+19PvE3dY40ZyWWFPkALgUxwWrBUdbR75savI5R5YgGRmUeyjJ9krfrBvnQ
	 FB6wgG5Bc48ow==
Date: Wed, 19 Feb 2025 08:22:40 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Aradhya Bhatia <aradhya.bhatia@linux.dev>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Jayesh Choudhary <j-choudhary@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Nishanth Menon <nm@ti.com>, Thomas Zimmermann <tzimmermann@suse.de>,
	Praneeth Bajjuri <praneeth@ti.com>,
	Maxime Ripard <mripard@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Devicetree List <devicetree@vger.kernel.org>,
	Devarsh Thakkar <devarsht@ti.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Airlie <airlied@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>,
	DRI Development List <dri-devel@lists.freedesktop.org>,
	Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v5 2/3] dt-bindings: display: ti: Add schema for AM625
 OLDI Transmitter
Message-ID: <173997495988.2526899.9124442481347234668.robh@kernel.org>
References: <20250209160925.380348-1-aradhya.bhatia@linux.dev>
 <20250209160925.380348-3-aradhya.bhatia@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209160925.380348-3-aradhya.bhatia@linux.dev>


On Sun, 09 Feb 2025 21:39:24 +0530, Aradhya Bhatia wrote:
> From: Aradhya Bhatia <a-bhatia1@ti.com>
> 
> The OLDI transmitters (TXes) do not have registers of their own, and are
> dependent on the source video-ports (VPs) from the DSS to provide
> configuration data. This hardware doesn't directly sit on the internal
> bus of the SoC, but does so via the DSS. Hence, the OLDI TXes are
> supposed to be child nodes under the DSS, and not independent devices.
> 
> Two of the OLDI TXes can function in tandem to output dual-link OLDI
> output, or cloned single-link outputs. In these cases, one OLDI will be
> the primary OLDI, and the other one, a companion. The following diagram
> represents such a configuration.
> 
> +-----+-----+         +-------+
> |     |     |         |       |
> |     | VP1 +----+--->+ OLDI0 |  (Primary - may need companion)
> |     |     |    |    |       |
> | DSS +-----+    |    +-------+
> |     |     |    |
> |     | VP2 |    |    +-------+
> |     |     |    |    |       |
> +-----+-----+    +--->+ OLDI1 |  (Companion OLDI)
>                       |       |
>                       +-------+
> 
> The DSS in AM625 SoC has a configuration like the one above. The AM625
> DSS VP1 (port@0) can connect and control 2 OLDI TXes, to use them in
> dual-link or cloned single-link OLDI modes. It is only the VP1 that can
> connect to either OLDI TXes for the AM625 DSS, and not the VP2.
> 
> Alternatively, on some future TI SoCs, along with the above
> configuration, the OLDI TX can _also_ connect to separate video sources,
> making them work entirely independent of each other. In this case,
> neither of the OLDIs are "companion" or "secondary" OLDIs, and nor do
> they require one. They both are independent and primary OLDIs. The
> following diagram represents such a configuration.
> 
> +-----+-----+               +-------+
> |     |     |               |       |
> |     | VP1 +--+----------->+ OLDI0 |  (Primary - may need companion)
> |     |     |  |            |       |
> |     +-----+  |            +-------+
> |     |     |  |
> |     | VP2 |  |
> |     |     |  |
> | DSS +-----+  |   +---+    +-------+
> |     |     |  +-->+ M |    |       |
> |     | VP3 +----->+ U +--->+ OLDI1 |  (Companion or Primary)
> |     |     |      | X |    |       |
> |     +-----+      +---+    +-------+
> |     |     |
> |     | VP4 |
> |     |     |
> +-----+-----+
> 
> Note that depending on the mux configuration, the OLDIs can either be
> working together in tandem - sourced by VP1, OR, they could be working
> independently sourced by VP1 and VP3 respectively.
> The idea is to support all the configurations with this OLDI TX schema.
> 
> The OLDI functionality is further supported by a system-control module,
> which contains a few registers to control OLDI IO power and other
> electrical characteristics of the IO lanes.
> 
> Add devicetree binding schema for the OLDI TXes to support various
> configurations, and extend their support to the AM625 DSS.
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> Signed-off-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
> ---
>  .../bindings/display/ti/ti,am625-oldi.yaml    |  88 ++++++++++
>  .../bindings/display/ti/ti,am65x-dss.yaml     | 154 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  3 files changed, 243 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/ti/ti,am625-oldi.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


