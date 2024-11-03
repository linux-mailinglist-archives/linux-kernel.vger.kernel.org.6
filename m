Return-Path: <linux-kernel+bounces-393688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9519B9BA410
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 06:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC421C212A2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 05:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF4E142659;
	Sun,  3 Nov 2024 05:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmeOx9Ak"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE640800;
	Sun,  3 Nov 2024 05:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730611373; cv=none; b=OJPmA29rcnt1S2G8T+0WLpbEOIP2phtAnu9twjIivzJgrMlEr7Qqru8zijQ+uG6WzXvuJF8Q9XnrVWVagWKGCxVRfl++IarVLcrTeublNsmQRCwoC5mIsaR1yl8+QowRDgMSAYPUbXApOu7xMzOK/yLiCo4N0sX6+AtAimAODNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730611373; c=relaxed/simple;
	bh=h84tEPWQA32B7KuowAYEIaMRiPB0pEi18T4lhbSjVkk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=KcIk8D9/N/8ZBFKTsNf3YlQeHDC03gfaHVjHuOZZtRf1KDQsSh8CoTUCR66uPqnf0349rDjkARGXwI5NnHsq5l+pUjsJEP7TE05viwX/w7oN2WKdLPuG5JlWS9iqm6v8QhRkmals55P3JGOE/r+wVzYNZIYE5O4F+sAQWNZhGdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmeOx9Ak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D04C4CECD;
	Sun,  3 Nov 2024 05:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730611372;
	bh=h84tEPWQA32B7KuowAYEIaMRiPB0pEi18T4lhbSjVkk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=tmeOx9AkLPcwpNZFiBDenF18qJ5nS2iitVT2z5dbjVtGOXmoo7MJVkuFcU06tvG8L
	 M1mc7bDFllofhF0Pt2ENTyRHlvIZ1dDHqHt6lvtLDO4HwmiQj/6zxM3H+5jRht2Skv
	 UXPLrh0XJTxXFVeuQJ8ixbhNj/2S6FycNownfmHjLDnvV2b1W7ncuHh37OldgloTbU
	 MDe1j1lRtwu2cEJ6cdEgMr9qEMZXDNwIBFia/Ik7SKpzm9cfJV2rvs1hfjvTt8y6CP
	 6OtzpJlNDf8p2n8emR6gGWHomtIy3Py6SA/xMnrPfHChxZVp+ERBlIoiXWfE6/NG1k
	 MJtmWI+88jFWQ==
Date: Sun, 03 Nov 2024 00:22:50 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: rdbabiera@google.com, linux-usb@vger.kernel.org, krzk+dt@kernel.org, 
 dmitry.baryshkov@linaro.org, conor+dt@kernel.org, 
 gregkh@linuxfoundation.org, badhri@google.com, linux@roeck-us.net, 
 xu.yang_2@nxp.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 heikki.krogerus@linux.intel.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, kyletso@google.com
In-Reply-To: <20241103034402.2460252-3-amitsd@google.com>
References: <20241103034402.2460252-1-amitsd@google.com>
 <20241103034402.2460252-3-amitsd@google.com>
Message-Id: <173061137043.3549002.17300495931303369678.robh@kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: usb: maxim,max33359: add usage of
 sink bc12 time property


On Sat, 02 Nov 2024 20:43:29 -0700, Amit Sunil Dhamne wrote:
> Add usage of "sink-bc12-completion-time-ms"  connector property to
> max33359 controller for delaying PD negotiation till BC1.2 detection
> completes. This overcomes the occasional delays observed while
> receiving PD messages where BC1.2 detection runs in parallel.
> 
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/maxim,max33359.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/maxim,max33359.example.dtb: maxtcpc@25: connector: Unevaluated properties are not allowed ('sink-bc12-completion-time-ms' was unexpected)
	from schema $id: http://devicetree.org/schemas/usb/maxim,max33359.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/maxim,max33359.example.dtb: connector: Unevaluated properties are not allowed ('sink-bc12-completion-time-ms' was unexpected)
	from schema $id: http://devicetree.org/schemas/connector/usb-connector.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241103034402.2460252-3-amitsd@google.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


