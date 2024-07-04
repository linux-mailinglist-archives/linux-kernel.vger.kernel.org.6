Return-Path: <linux-kernel+bounces-240883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3508A927429
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3EBEB21C6B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C8A1ABC47;
	Thu,  4 Jul 2024 10:36:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA3C12D76E;
	Thu,  4 Jul 2024 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720089403; cv=none; b=ljwo0GzH4XkDnGWb/Ps8T/ZeCRRfGuMXdGrOnm9NIuTqSH8Rs1bZgzjrRmuSzXfvSI+MExe1fKOog/RPuciuq1y6FYS8cUcBMayw09APV939O4rXfUJskvixJaaiOhHfKEks3vPHqgXER70nsSDLiIOHYnUuvQU4/Dzrdyv++a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720089403; c=relaxed/simple;
	bh=tc+zXpW5EumM4Y5w1BQmomPKVoA3wzt9NxV5ihkiHlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TAKlEE5JT2U5vpMSoDrqz+rD5dyx7SH1ueYbPqyLK6i+CsMXvxx794lwufd0CGFVTq86dEX1DfM2rtvD4qhkNv99Uh0u4jf11l7MDCocI66rnwPEZli2XRzORdLI03N8DGE7zbd5+f4+mRTABviIJFsBPbM6E7VrnP5ZdtXNn8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DACF367;
	Thu,  4 Jul 2024 03:37:06 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4933B3F762;
	Thu,  4 Jul 2024 03:36:39 -0700 (PDT)
Date: Thu, 4 Jul 2024 11:36:36 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: cristian.marussi@arm.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, devicetree@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 1/2] dt-bindings: firmware: arm,scmi: introduce
 property mbox-rx-timeout-ms
Message-ID: <ZoZ7NCSaG0YRK-60@bogus>
References: <20240703031715.379815-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703031715.379815-1-peng.fan@oss.nxp.com>

On Wed, Jul 03, 2024 at 11:17:14AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> System Controller Management Interface(SCMI) firmwares might have
> different designs by SCMI firmware developers. So the maximum receive
> channel timeout value might also varies in the various designs.
> 
> So introduce property mbox-rx-timeout-ms to let each platform could
> set its own timeout value in device tree.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
>  Drop defaults, update description.
> 
>  Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index ebf384e76df1..dcac0b36c76f 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -121,6 +121,12 @@ properties:
>        atomic mode of operation, even if requested.
>      default: 0
>  
> +  max-rx-timeout-ms:
> +    description:
> +      An optional time value, expressed in milliseconds, representing the
> +      mailbox maximum timeout value for receive channel. The value should
> +      be a non-zero value if set.
> +

IIRC, you had the min and max constraint in the earlier response. You
need to have rushed and posted another version before I could respond
with my preference.

So there is no rush, these are v6.12 material. Take time for respining
and give some time for the review.

-- 
Regards,
Sudeep

