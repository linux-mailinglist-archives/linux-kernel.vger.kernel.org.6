Return-Path: <linux-kernel+bounces-213788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8715907A79
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68258285893
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A46614A602;
	Thu, 13 Jun 2024 17:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAXnB4KK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7D214A4F0;
	Thu, 13 Jun 2024 17:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718301588; cv=none; b=kNuMhQdLk7jCPC9beZUlPwabi+j9vbXSrjZx3QFCgG+j1yZHIY7NKJgcqoJfNro1VaW1bggtDq1E4LfcCUx+FeGyodT3IetJ3wYsioOfLzn+wIT0BpJmZRQiksJHslh21C+x2g8/VXBB8b81A18b3bYJZ9xhUSqMvfGKDuLb050=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718301588; c=relaxed/simple;
	bh=ba5a7SrwKzZox0+DAfJ3tbJfpYcmRULnrBc+3V62Rng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLpI8wVQqQyJEcYi0PorW1SkdMzJRIy3EXjdA0dIXUTiV4+P6j3H8yK+rN1GadGx1gA+IZ0cCAJMpSJHKD3w9zPej0mzkidzcZBA7exhfJqynN5OPzQP+RzGm3HBJB6cmxyCN/cn2CHgRr3Pfkc2Bj6ypDKKLD8VVQDfsRHMqUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAXnB4KK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B553EC2BBFC;
	Thu, 13 Jun 2024 17:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718301587;
	bh=ba5a7SrwKzZox0+DAfJ3tbJfpYcmRULnrBc+3V62Rng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HAXnB4KKEIeKZoxVRiMkvnv0AqZzQvtowJBSJEy5NC54ajGD+adT0vDwmcxkPEXeg
	 TqfjfBtyXYJZ2BJP497pWWS6oCUQ/uzLmZykxewe2ZiuMYHtTU2DfP+u60cjU15XxA
	 bzpwihCtcQAVhogRG/3CP3ZfMa3QDBd20qLzuWibcChfdeOU8Wp/jpO7EaBTeNjyqL
	 lM0GhdN54G1t2i6+BEdkIHr9vNmn3FnDaY5U8MD+OYmbwGYhkjcqv9sYTNIDyHu2aw
	 luKgqZx3PxYSaGoLMZIBQRpb7mffXd91Zl8CoiNaF7qeFvicGJJRKe6i0dKj9BqyCQ
	 AdzgQOcKcKmOA==
Date: Thu, 13 Jun 2024 11:59:46 -0600
From: Rob Herring <robh@kernel.org>
To: Potin Lai <potin.lai.pt@gmail.com>
Cc: Corey Minyard <minyard@acm.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	openipmi-developer@lists.sourceforge.net,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Patrick Williams <patrick@stwcx.xyz>,
	Cosmo Chou <cosmo.chou@quantatw.com>,
	Potin Lai <potin.lai@quantatw.com>
Subject: Re: [PATCH 1/2] bindings: ipmi: Add property for skipping SBMR boot
 progress response
Message-ID: <20240613175946.GA2085029-robh@kernel.org>
References: <20240612043255.1849007-1-potin.lai.pt@gmail.com>
 <20240612043255.1849007-2-potin.lai.pt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240612043255.1849007-2-potin.lai.pt@gmail.com>

On Wed, Jun 12, 2024 at 12:32:54PM +0800, Potin Lai wrote:
> In ARM Server Base Manageability Requirements (SBMR) document, Callers can
> choose to not read back Response Data after sending the command "Send Boot
> Progress Code".

Got a link to that document?

> Define "arm-sbmr,skip-bootprogress-response" property for skipping the
> response of "Send Boot Progress Code" from userspace.

I don't understand why this would be conditional? How can you define in 
the BMC what the host behavior is? Doesn't the host side decide 
that? So don't you always have to support no response?

> 
> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
> ---
>  Documentation/devicetree/bindings/ipmi/ssif-bmc.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ipmi/ssif-bmc.yaml b/Documentation/devicetree/bindings/ipmi/ssif-bmc.yaml
> index 02b662d780bbb..b21e958efc184 100644
> --- a/Documentation/devicetree/bindings/ipmi/ssif-bmc.yaml
> +++ b/Documentation/devicetree/bindings/ipmi/ssif-bmc.yaml
> @@ -19,6 +19,11 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  arm-sbmr,skip-bootprogress-response:

Form is vendor,property-name where vendor is defined in 
vendor-prefixes.yaml. 'arm-sbmr' is not a vendor.

> +    type: boolean
> +    description:
> +      Skipping ARM SBMR “Send Boot Progress Code” response.
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.31.1
> 

