Return-Path: <linux-kernel+bounces-434869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E19D9E6C36
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96AA71637D3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5681FCF58;
	Fri,  6 Dec 2024 10:21:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E181FCD0C;
	Fri,  6 Dec 2024 10:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480512; cv=none; b=Ri/QSHeXyUJ0xT5ldGMMAIbhUJmHipmScic/p7twPXgdOfNhCS2n3Q5gT36UCUb36xOQPr6DA6b1lG4PzubgxrNuf3hMSzTSm+XuSidT9yVefMF3DLwN08ijvwLwXQNQQw+vgxsZ3rNwekPXaLnKq5djMviqr8KVJCjDE/EBA7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480512; c=relaxed/simple;
	bh=/tvoac1uzl+98G3NksI81iFC7WAEOniAKip37C5bSfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bV7Z3/IJs64IS+VTjJEvm1OzQMWY90VqGUJnaA14aZOGT5XXNBjo7MJzVLzlfF7ukX/rONFsocxpPybByyMYLqtS9Mgl7pw28NXJlHB0HX9oYZhn/sPgG263n2HkKqMTrJHf2vp5hsHEpiZeHcNMLaYU8zyRt8wK8XaSixa2GzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EF5912FC;
	Fri,  6 Dec 2024 02:22:18 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FF733F71E;
	Fri,  6 Dec 2024 02:21:48 -0800 (PST)
Date: Fri, 6 Dec 2024 10:21:46 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 1/3] dt-bindings: arm,psci: Allow S2RAM power_state
 parameter description
Message-ID: <Z1LQOmEfFy640PjG@bogus>
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

If so, can you elaborate why s2idle doesn't work as an alternative to what
you are hacking up here.

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

Yet another NACK as this corresponds to PSCI SYSTEM_SUSPEND and as per
specification it takes no such parameter. This is just misleading.

-- 
Regards,
Sudeep

