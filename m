Return-Path: <linux-kernel+bounces-420397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D850F9D79F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 03:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A91DB219DA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 02:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B283D28684;
	Mon, 25 Nov 2024 02:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYCyg9Na"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1582317C60;
	Mon, 25 Nov 2024 02:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732500413; cv=none; b=tt0ibwoTTcxm+R/5gevmUH2m13S4r7k3YYYDUOIeSELoLsyciHi/QPdfac/K9z2mxBlJuwZ9rw2sczxIFb2lmgdpQ1x7NjE4zo3wn+T9+5/Jpy73J2+3E2CvWCa+x2ZZrfVEndYUOjsm2lAQv2gB0bLwyPTrvojuK2wCMMsrGDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732500413; c=relaxed/simple;
	bh=Gu5Wu6oqy5RrPJGF75jiB8mV6u7GUvi00veqq4oAV6I=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=YouYvHkcsUwAr7lnYucoUGb3+BDYIMhnz19TM0OdCpaZTvMya7zS3GSYy1otCzS4xiigKUwpF3UEh+oIQd/R6sbcOOYVXFw6f5LAaOMBJvwa3+qCUfVq6md69ADuSR5rVm1/PwMYZH7mZ5XtiJeYvflmHBpvgBwTMzF+DQuXSLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYCyg9Na; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31A7C4CED9;
	Mon, 25 Nov 2024 02:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732500412;
	bh=Gu5Wu6oqy5RrPJGF75jiB8mV6u7GUvi00veqq4oAV6I=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=MYCyg9Na2ZSPDLA10+VfV7vvGR536PZbxkdwlN9SVGiZXCNzmI4JkyDU4ml3fYcz8
	 HOYLlKb2i8HldOFxv15S6gVnl2YWa8yYMfxL9gqs9YYgLXWpcE/DVzlDug1xD9AIUs
	 xgoTY0HkEL1a5n/pQBK1zMeJRptg9wNThp07WVrBCiIL5cFOpefCPGp8BjBHUqKHRN
	 Kbj7ZpslOPuKDpu1i7WKRP9xiMw7t1d3k3MO99sMOmwKaAaBDL0ISNZb4MUcli10bc
	 r/JBxZUf/mUqJvtjdoBd7DjhpSa0A2R2aT6B04oJ2vAL0JntI9gx2hsAYXZvxVmRzC
	 wk+GWhxiBC0VA==
Date: Sun, 24 Nov 2024 20:06:51 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, asahi@lists.linux.dev, 
 David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 linux-arm-kernel@lists.infradead.org, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Simona Vetter <simona@ffwll.ch>, 
 Sven Peter <sven@svenpeter.dev>
To: Sasha Finkelstein <fnkl.kernel@gmail.com>
In-Reply-To: <20241124-adpdrm-v1-1-3191d8e6e49a@gmail.com>
References: <20241124-adpdrm-v1-0-3191d8e6e49a@gmail.com>
 <20241124-adpdrm-v1-1-3191d8e6e49a@gmail.com>
Message-Id: <173250040970.6667.2839660338071681474.robh@kernel.org>
Subject: Re: [PATCH 1/5] dt-bindgins: display: Add Apple pre-DCP display
 controller bindings


On Sun, 24 Nov 2024 23:29:24 +0100, Sasha Finkelstein wrote:
> Add bindings for a secondary display controller present on certain
> Apple laptops.
> 
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
>  .../bindings/display/apple,display-pipe.yaml       | 59 ++++++++++++++++++++++
>  .../bindings/display/panel/apple,summit.yaml       | 24 +++++++++
>  2 files changed, 83 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/display/apple,display-pipe.yaml:21:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241124-adpdrm-v1-1-3191d8e6e49a@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


