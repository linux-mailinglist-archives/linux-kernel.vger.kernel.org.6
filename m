Return-Path: <linux-kernel+bounces-544026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B04A4DC8D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E121886D3E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681C61FF5E6;
	Tue,  4 Mar 2025 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuctRa9E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DF21FE45C;
	Tue,  4 Mar 2025 11:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741087656; cv=none; b=BXTnHl8n5B8vVa+IRKGq1XP4PL6Lh5z+PYEGvLNKU4UbQJj0ycIjVYlTQKteVDSQYy7Ei5wayBqf+OqjNOJIQ0OhpCdlGTynNfaqcbuLL4xKrhLhGKePxhDleIN2bkVqf+NhMznTP1qLV3WogZ1NbaLtAjMX3DSf+Li647WFHHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741087656; c=relaxed/simple;
	bh=4KFBBF3Ao5HU3HgirJAXKEK8cCaqMTH0xugNMYsYIco=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=PZwCXvYAJrpTOsJKps+8C2LK9xNe9MDy9oLTDjehq7iAPWBWW7v6KoA8rbMu+0vDVAuZTQuto1MqrWShypXZwYgU0DjLM+tv/Uszua6RrJzqZsXv62WjFcEFhh3wFj/3rqrOQApLULECapbCgpyqzwn3EkfmL9ytirmciNs+/4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuctRa9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0741EC4CEE5;
	Tue,  4 Mar 2025 11:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741087656;
	bh=4KFBBF3Ao5HU3HgirJAXKEK8cCaqMTH0xugNMYsYIco=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=kuctRa9E5v64bZ+7Oc2Xsl/TmkYbNrxpoVbayvVM4YOnYgC52o2+kv/QDT//qQZTg
	 LoBe7Cr+vfJYA9UVmMSzWHTqUePaOk8UDKry3rqjnLELMHi/PZJfNtgXJ2IhXQL3zU
	 qAw76DR1GxOcP4Tq1iP/DK+sGa2rj2L/u0905iz1oXPdQ4K5kkamcdfhE6WvSvqDPA
	 nuwHsra3WoGAKl/wsCvzH+vGoEukfisjBaUMJzsCp1CdXA6fcf+Gr2fogxBU5xAqHU
	 MqITI7QxBtZ50PtdfomUQAJlzNDv18N3VcxUX1WwOgnPuZGMayxoTj1niuQ17ymeSt
	 J9YO6SsmazMpQ==
Date: Tue, 04 Mar 2025 05:27:34 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: airlied@gmail.com, conor+dt@kernel.org, krzk+dt@kernel.org, 
 Laurent.pinchart@ideasonboard.com, andrzej.hajda@intel.com, 
 tzimmermann@suse.de, simona@ffwll.ch, neil.armstrong@linaro.org, 
 jernej.skrabec@gmail.com, linux-kernel@vger.kernel.org, mripard@kernel.org, 
 devicetree@vger.kernel.org, jonas@kwiboo.se, rfoss@kernel.org, 
 maarten.lankhorst@linux.intel.com, dri-devel@lists.freedesktop.org
To: Liu Ying <victor.liu@nxp.com>
In-Reply-To: <20250304101530.969920-4-victor.liu@nxp.com>
References: <20250304101530.969920-1-victor.liu@nxp.com>
 <20250304101530.969920-4-victor.liu@nxp.com>
Message-Id: <174108765439.1932765.4056731627407364924.robh@kernel.org>
Subject: Re: [PATCH 3/5] dt-bindings: display: simple-bridge: Document DPI
 color encoder


On Tue, 04 Mar 2025 18:15:28 +0800, Liu Ying wrote:
> A DPI color encoder, as a simple display bridge, converts input DPI color
> coding to output DPI color coding, like Adafruit Kippah DPI hat[1] which
> converts input 18-bit pixel data to 24-bit pixel data(with 2 low padding
> bits in every color component though). Document the DPI color encoder.
> 
> [1] https://learn.adafruit.com/adafruit-dpi-display-kippah-ttl-tft/downloads
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>  .../display/bridge/simple-bridge.yaml         | 89 ++++++++++++++++++-
>  1 file changed, 87 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/bridge/simple-bridge.example.dtb: /example-1/bridge: failed to match any schema with compatible: ['dpi-color-enoder']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250304101530.969920-4-victor.liu@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


