Return-Path: <linux-kernel+bounces-178013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D63798C476F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 364EBB22C43
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E7653370;
	Mon, 13 May 2024 19:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFLD3zCK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6080E4500D;
	Mon, 13 May 2024 19:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715627986; cv=none; b=XZLQyDrlUAktfkY0Gt2LS8nUyCYs7pDOx5kL9+kIA2R8j/axhTbbEpyLDBl4phqN2voAYp+x8YrMOIvwsKX1e3/AOePqYfDOlnHqcqStSLqFL4R26Zdt+vHSSxVHcsDirxiAKyI6udZGrh5yoY7VgfGUHs2Z+5+MKg8arj44WCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715627986; c=relaxed/simple;
	bh=JVhe7vOVUPnlGpP2MxGacJlnQpO7mBINOPZS5hTa6nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdCc6InLUTgPfy4N7oEEUox/hoGL1O4SoHcG4dNCMrQL8f9LX9FmNF8g39wzhkEGy1K8h+OL0OUwtUV6QR+3lqnslfVup3CLw+YsOWZYyTLs6udeCrboeiWSy5ldv4i3UUJ0iq6WFdwtUu9E10sXRVi4Cpl1YvVbekpYjVR1gQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFLD3zCK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4EADC2BD11;
	Mon, 13 May 2024 19:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715627985;
	bh=JVhe7vOVUPnlGpP2MxGacJlnQpO7mBINOPZS5hTa6nE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OFLD3zCKW+7SyfyyAhT+WlbUmcVf6rHVLffMn9M4W1jL5pPFUks9tsHFJSAL24Be/
	 HQQAbGZECfz5y6c7COeE99YHCfGWczQSHFwH8NSnMKRHgAbTco7AsZnKZP4wAqghyB
	 WGEjMAQZ9BlFH1NtW0SS5H0u6uM7SF6yKce0MOG/xpfffu4nPsATZUdcgtvbxpCz4u
	 Esdy+GA9UMqYIS/8X8IqnYOBrwtvBxoF6Z+Q8ZbtzKJUplo1OJKaCTFVDjpJrAYEGS
	 PGxXT9I/P7f2GZe3PwvrhiYnzJt9WMZV1gD/k1PAdNSjDIo/XAOO83eUmK/CT3gXfo
	 P9IFEacMlG8xg==
Date: Mon, 13 May 2024 14:19:43 -0500
From: Rob Herring <robh@kernel.org>
To: Aradhya Bhatia <a-bhatia1@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Jyri Sarha <jyri.sarha@iki.fi>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	DRI Development List <dri-devel@lists.freedesktop.org>,
	Devicetree List <devicetree@vger.kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Randolph Sapp <rs@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
	Jayesh Choudhary <j-choudhary@ti.com>, Jai Luthra <j-luthra@ti.com>
Subject: Re: [PATCH 1/4] dt-bindings: display: ti,am65x-dss: Minor Cleanup
Message-ID: <20240513191943.GA2982709-robh@kernel.org>
References: <20240511193055.1686149-1-a-bhatia1@ti.com>
 <20240511193055.1686149-2-a-bhatia1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240511193055.1686149-2-a-bhatia1@ti.com>

On Sun, May 12, 2024 at 01:00:52AM +0530, Aradhya Bhatia wrote:
> Reduce tab size from 8 spaces to 4 spaces to make the bindings
> consistent, and easy to expand.

"Re-indent the example" would be more specific than "minor cleanups" in 
the subject.

Otherwise,

Acked-by: Rob Herring (Arm) <robh@kernel.org>

> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>  .../bindings/display/ti/ti,am65x-dss.yaml     | 54 +++++++++----------
>  1 file changed, 27 insertions(+), 27 deletions(-)

