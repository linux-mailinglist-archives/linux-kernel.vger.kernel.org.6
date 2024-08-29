Return-Path: <linux-kernel+bounces-306668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC119641DF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0111F25385
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DB9190684;
	Thu, 29 Aug 2024 10:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2JCCafX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B39E190666;
	Thu, 29 Aug 2024 10:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724927053; cv=none; b=NjlS4O6ngvBzUOnyqehaDtOfYyqre4lsQiEZ0Jj6dcoI35T/0sPvgH5poKt7o2+AMNTcUfe4yXDDcSKJlYc4A42EFP7uLFT6fZXAMzY7eY0J/3AnOuplkcC5u8vI1NrFfUTq0nRPvHStuB8Dc7VJbLETIKxp3kDar7peG+pQR+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724927053; c=relaxed/simple;
	bh=729zgq4sALOytFJ4dQMLRwIoHBrGCvNxhQojI7f4avU=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=rYGwoi6aHYcBfaMT93XehD4riw2r4ViKp3vQMj6d3IkacQ2PDUPV8MKHjUqLly0KKTDp2AmS/D/+rfXohRI8MJ+Zu+GT9+XSYRhfrWx3aAF6eKs72lMXX9wTDbHVZFZ1COPy0lWP19jIx25TmYno7owng6POVSN3E2a3TPShCDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2JCCafX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE19C4CEC1;
	Thu, 29 Aug 2024 10:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724927053;
	bh=729zgq4sALOytFJ4dQMLRwIoHBrGCvNxhQojI7f4avU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Q2JCCafXw788OY6j2AOZjvHheXbbiNC9O1CFDQhgvgI6rJcH+dHiWuUs/EQBrOgSo
	 LcXr1s8MUs+PsSQHD/vMrhgsGB7BbPOICTL0JudPON7D6JQy2Qhp15E5pri0Mg/wlp
	 Wf7VVg3mJ+/KtButfbM73uQfkx2/4z+30Oei66e0eRIMP5HgembtR4djxX7dFeY1YE
	 GNdnnlEizbJ6HJe8Tw6NPr2fc4Z0GkrX86atbR8+uq2/8Gof1YoyvPMWl4KxRMZ5Op
	 YVqn9rBX7gIIuLI/nr2RxyprLz9eharhQMG4h0Nr8wcw9WXkewH2kd1JNwWHawCL1r
	 rlkg2CWYdQjJA==
Date: Thu, 29 Aug 2024 05:24:11 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 Sven Peter <sven@svenpeter.dev>, Thomas Gleixner <tglx@linutronix.de>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, Hector Martin <marcan@marcan.st>, 
 linux-kernel@vger.kernel.org, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 asahi@lists.linux.dev
In-Reply-To: <20240829092610.89731-2-towinchenmi@gmail.com>
References: <20240829092610.89731-1-towinchenmi@gmail.com>
 <20240829092610.89731-2-towinchenmi@gmail.com>
Message-Id: <172492705116.3333643.6993934329983052782.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: apple,aic: Document A7-A11
 compatibles


On Thu, 29 Aug 2024 17:03:11 +0800, Nick Chan wrote:
> Document the compatibles for Apple A7-A11 SoCs.
> 
> There are three feature levels:
> - A7-A10: No fast IPI
> - A11: fast IPI, global only
> - M1: fast IPI with local and global support
> 
> Each feature level is an extension of the previous. For example, M1 will
> also work with the A7 feature level.
> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  .../bindings/interrupt-controller/apple,aic.yaml  | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/apple,aic.example.dtb: interrupt-controller@23b100000: compatible: 'oneOf' conditional failed, one must be fixed:
	['apple,t8103-aic', 'apple,aic'] is too long
	['apple,t8103-aic', 'apple,aic'] is too short
	'apple,s5l8960x-aic' was expected
	'apple,t8103-aic' is not one of ['apple,s8000-aic', 'apple,t7000-aic', 'apple,t8010-aic']
	'apple,t8015-aic' was expected
	from schema $id: http://devicetree.org/schemas/interrupt-controller/apple,aic.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240829092610.89731-2-towinchenmi@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


