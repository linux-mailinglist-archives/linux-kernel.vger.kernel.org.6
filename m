Return-Path: <linux-kernel+bounces-385455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 343E39B375D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 657A91C20B58
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8941DF266;
	Mon, 28 Oct 2024 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLeItSA3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74271D5CC6;
	Mon, 28 Oct 2024 17:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730135380; cv=none; b=A89QkRs7VsD7nrvLJLGk3UgDwNTvjfa3qFXV6NW8Lvi7x/ysmNnKOnobDmWYMHAoZBijbg6zu1ZzKaSqCVGnqmLUXCLXQwTEnrT22QDBUP7Gh937iAvryNQ1tTEFwX3OpMWgun1XfapkEhpiKzXemN6GFsEwSWtGEAfUOVulIBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730135380; c=relaxed/simple;
	bh=WJDZhRtwghKuue3Ou1x958utvll99lUFzlZQbjrclpk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=OhT0hHxr/2nKx9XjCGHg4u0hjaqL9NCdqwR2BEpefrAvvjnPbnIaNkTJfPfzoXpW0zzO9S7u1dQdFjstUWLH4Pkr6XG1NO1kO44yWHb4RhqMCM4j4AQjgw36Hd7lNxpsfzahKNbKLoQCf+Qm40hvakNkSzKOVOPiNJSJyPJQs5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLeItSA3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BAEC4CEC3;
	Mon, 28 Oct 2024 17:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730135378;
	bh=WJDZhRtwghKuue3Ou1x958utvll99lUFzlZQbjrclpk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=gLeItSA3fn2FDDa5nKD3HQn3kGWUx7nLbl492Fr0hM8uBGwuaa9HIRUnUsCTgLlSj
	 gPOlTSXQNRRXdcuNjXI2pd0Pn4xIIArp164mNdhgkDTHa1ei2flF3eRE4iVNrdVz3a
	 lBrfqDgYMI7h+hS+w2ECYH4VRGfinwWeliufn/mPq97hE5o+coSwPGemjeeoD9oojo
	 mjBE1CCych3FIRr7FvQW1o7uRjhTCMkY1/+vAZ9XVj/AV9NYygA5kgyzRbtNc3wAXC
	 K1RB3d1wJicYj7GHvBom3zQfyMELpqvdxIzJoWuMsiyqqDIHmhW9Mg9FRS/YUyDSZb
	 6iFDOhOT+ecQA==
Date: Mon, 28 Oct 2024 12:09:35 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org
In-Reply-To: <20241028-topic-cpu_suspend_s2ram-v1-1-9fdd9a04b75c@oss.qualcomm.com>
References: <20241028-topic-cpu_suspend_s2ram-v1-0-9fdd9a04b75c@oss.qualcomm.com>
 <20241028-topic-cpu_suspend_s2ram-v1-1-9fdd9a04b75c@oss.qualcomm.com>
Message-Id: <173013537587.887084.8594386084996855802.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: arm,psci: Allow S2RAM power_state
 parameter description


On Mon, 28 Oct 2024 15:22:57 +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Certain firmware implementations (such as the ones found on Qualcomm
> SoCs between roughly 2015 and 2023) expose an S3-like S2RAM state
> through the CPU_SUSPEND call, as opposed to exposing PSCIv1.0's
> optional PSCI_SYSTEM_SUSPEND.
> 
> This really doesn't work well with the model where we associate all
> calls to CPU_SUSPEND with cpuidle. Allow specifying a single special
> CPU_SUSPEND suspend parameter value that is to be treated just like
> SYSTEM_SUSPEND from the OS's point of view.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/arm/psci.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/psci.yaml: properties:arm,psci-s2ram-param:maxItems: False schema does not allow 1
	hint: Scalar properties should not have array keywords
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241028-topic-cpu_suspend_s2ram-v1-1-9fdd9a04b75c@oss.qualcomm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


