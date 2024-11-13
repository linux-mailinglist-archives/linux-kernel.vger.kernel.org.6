Return-Path: <linux-kernel+bounces-407597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AADF9C6FAC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5289D1F212E0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F19200CAA;
	Wed, 13 Nov 2024 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfhHWOHA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A6F1DF25D;
	Wed, 13 Nov 2024 12:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731501799; cv=none; b=TKexxeIKWi3JZN5oSCvloCPst+d1ddVx9wdfeDGT7FiGOrkguV6T79KrojjqwVBzoahH1uVGzVlucHwM7jg0D32mMWc1DZxP8J6/dDewTJlq537FItiX1GDnvg7XXkoPNLOmVgYE8NB00+MsUDmGTj1D/gkkpLosEWQAnhtzEAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731501799; c=relaxed/simple;
	bh=Q4Q4ybEfBqgLRDPVB7Zw53fPxqgmPSshebKB+JwBp8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSF+jsgXcrzeFveowPK/BlVDCfhnyzABt7ee03asPUP3FgkjkJQhjhqxm39MAB44/A2To7P3ajBeVDY4aN/sg68IC5uHlRnUeT7MdTqxrpvqDqN0JiUjDpEglmXxueEF7toXZSFHlo59yolrbqUrzpaAIQxfEZKJeG94ELsu4Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfhHWOHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759A5C4CECF;
	Wed, 13 Nov 2024 12:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731501799;
	bh=Q4Q4ybEfBqgLRDPVB7Zw53fPxqgmPSshebKB+JwBp8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KfhHWOHAWXbfue7LMZwl9fC6h+g3T/79kEYzpLytgqH4lGn9pUAKy8xKvgLwyVLay
	 a8BmAEX8Lg+DIX61KRWvCDM+LJ33sfY2T2b+bMPcSm4slf8Wn7L5jezibzouJtq/kW
	 ZURyY9WVzEQoMI1fUkLLK72C6OU9VEM82brwQ2BgGpfi6oPUQ2xMJ9eeTiqzFKmtYt
	 xPHonkUjE3eWZl9mJxWELMHSVwp6hN4XE/R72q4V+pDD9fRCUnuBMjD/ZU8anv9zU1
	 7NjRlmzL7hHh52l4gsvtj52tMb3ZmqWPW90KrA+abBvg70mZXPvcgky9ckfT1Ctuid
	 9DunVmtJCqvHQ==
Date: Wed, 13 Nov 2024 13:43:13 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 1/3] dt-bindings: arm,psci: Allow S2RAM power_state
 parameter description
Message-ID: <ZzSe4UAyil8KUm85@lpieralisi>
References: <20241028-topic-cpu_suspend_s2ram-v1-0-9fdd9a04b75c@oss.qualcomm.com>
 <20241028-topic-cpu_suspend_s2ram-v1-1-9fdd9a04b75c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028-topic-cpu_suspend_s2ram-v1-1-9fdd9a04b75c@oss.qualcomm.com>

On Mon, Oct 28, 2024 at 03:22:57PM +0100, Konrad Dybcio wrote:
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

For the records, the info above is not relevant.

These are generic firmware bindings for PSCI specifications - how CPUidle
is implemented in Linux must play no role here.

> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/arm/psci.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
> index cbb012e217ab80c1ca88e611e7acc06c6d56fad0..a6901878697c8e1ec1cbfed62298ae3bc58f2501 100644
> --- a/Documentation/devicetree/bindings/arm/psci.yaml
> +++ b/Documentation/devicetree/bindings/arm/psci.yaml
> @@ -98,6 +98,12 @@ properties:
>        [1] Kernel documentation - ARM idle states bindings
>          Documentation/devicetree/bindings/cpu/idle-states.yaml
>  
> +  arm,psci-s2ram-param:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      power_state parameter denoting the S2RAM/S3-like system suspend state
> +    maxItems: 1

NACK

This is nothing that has ever been specified in the PSCI specifications,
see above.

>  patternProperties:
>    "^power-domain-":
>      $ref: /schemas/power/power-domain.yaml#
> 
> -- 
> 2.47.0
> 

