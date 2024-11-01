Return-Path: <linux-kernel+bounces-391528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 597609B8844
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 02:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD3F28257A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 01:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA13C52F88;
	Fri,  1 Nov 2024 01:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T30OEJa4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4997220328;
	Fri,  1 Nov 2024 01:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730424045; cv=none; b=D7EXjqYP2MYdDVu01c6A/MgaIZaNeLsNk8eL1DZiiQs4QeYdMkqYR5y6Hi42cbKxWpnoajzv1IM1G6VM84LgwIWqevQx4pyoFL/vQv108PPvVJ1+BWbgbqT6Xl22SMQQUmSiNJ862ObYsue4xd6WENaMRvEaJ1jXMzL8Ylkz7M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730424045; c=relaxed/simple;
	bh=vuUWriRyJgNDUqoRutkuBPsZgLVx2wLFsmuENH79BFQ=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=UJnriN3vgHxIklz/qjl+ZZx+oB6B+4WTZk+ci5HI3aEnGq7Re/10/MJmRAYQb4x8nCbiC0EBOvzimVIVmKjXV/tQFLkze2DmfsQ0qpQXIZF6nT/g8d312qpF7Fsij1QlcSzs4SbiHnCBkoSqbSF5RRRjv2Hp08sGN3nXhftrlNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T30OEJa4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9847CC4CEC3;
	Fri,  1 Nov 2024 01:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730424044;
	bh=vuUWriRyJgNDUqoRutkuBPsZgLVx2wLFsmuENH79BFQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=T30OEJa45d3iql7Qu2R+dYAf41tbQbX0kqADVxG+zRsyE6NRa16qnwSuskCldUVzH
	 DPGfBLPh6cFKluLGnYRXehPaptwmzDTW0lCSddoRm663c82dE7ox6XWQzntg35s1Wk
	 +AcnOyiRLn/1yij7pXb8taVkQjj9FONvA2VRKmvLWk0VQI38Noub+TCHhL2nlDYR0J
	 n52NekukHWAvqFPI2dPe0DKfqIY9vYXMi64gMPuZOVLff8XJ+F3sWGnFpafa9n9SiO
	 R4xZZ5HXrZx7J8RMEO8qxBVFIMLHoMHpD+zDhITqzETu0vGy009Xve3wpZ+G6lGnlh
	 JhA85E1xTQWxw==
Date: Thu, 31 Oct 2024 20:20:43 -0500
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
Cc: linux@roeck-us.net, gregkh@linuxfoundation.org, 
 linux-kernel@vger.kernel.org, kyletso@google.com, 
 heikki.krogerus@linux.intel.com, krzk+dt@kernel.org, 
 dmitry.baryshkov@linaro.org, conor+dt@kernel.org, badhri@google.com, 
 xu.yang_2@nxp.com, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 rdbabiera@google.com
In-Reply-To: <20241031235957.1261244-3-amitsd@google.com>
References: <20241031235957.1261244-1-amitsd@google.com>
 <20241031235957.1261244-3-amitsd@google.com>
Message-Id: <173042404301.889048.6986869139957882077.robh@kernel.org>
Subject: Re: [PATCH v1 2/3] dt-bindings: usb: maxim,max33359.yaml: add
 usage of sink bc12 time property


On Thu, 31 Oct 2024 16:59:53 -0700, Amit Sunil Dhamne wrote:
> Add usage of "sink-bc12-completion-time-ms"  connector property to
> max33359 controller for delaying PD negotiation till BC1.2 detection
> completes. This overcomes the occasional delays observed while
> receiving PD messages where BC1.2 detection runs in parallel.
> 
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241031235957.1261244-3-amitsd@google.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


