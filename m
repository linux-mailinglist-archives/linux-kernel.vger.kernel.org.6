Return-Path: <linux-kernel+bounces-444468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B179F0758
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49295188C044
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE411ADFFE;
	Fri, 13 Dec 2024 09:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAbwKM7Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961171AD3F6;
	Fri, 13 Dec 2024 09:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081058; cv=none; b=ORSOXCX13p6VU52+PLP562Qcu6SH01K/+IoAZ1H+4W37jbqru+dGV7/mhGimButW6jBlDzUW3FTbV2a03DKYh99IRGozhsjlZaAJsTT8rT3rrY+JdbcN/cvHaljKWuPKKCDUce1HetAw1ytjAkSaRXD9pHunBzdFqXXc091qc9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081058; c=relaxed/simple;
	bh=G+cTnuuCPd8OUrWtJFXbPhKcg/vWEnCq2zPfc22GuSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Du6qkrFl7cMrAVtSnwGdj5LMrChLtn0o4Wt844YNi0UO2tuvvGuTaye7hXS9Epseq/0Qh32GgKGgNA5zxFCobmzSvo9yiwvOMJqBn9gcJ4W88OTU+yVwIdX98GKxOdqT1wvPVnCeYTzDZ/+aQUarKqYp435d3Z1uJ40/bSfCkn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAbwKM7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5358EC4CED6;
	Fri, 13 Dec 2024 09:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734081058;
	bh=G+cTnuuCPd8OUrWtJFXbPhKcg/vWEnCq2zPfc22GuSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GAbwKM7Ql8JlHQtvaxCAEjlrWi6IlQRqnJA8CZ04DwQrSfcb10h5+6cjzhldotnRh
	 L2XSBgnBNZJUfO8crBg8MZlN8CfTvAifyk+GlvHyJiBZTVjivci1Qq01nMnxglh31v
	 zi2eIA2ZMTu2jG9TIvc1Ivn5fZM3DHGSFcpIq8o1+3NB7mQAtUoaY5nAKzecFcPCyO
	 J9jow5Rd3wWUjudv+BGCRohLkufEOp6fwOe3r/hPcHfEjlJ+YXmMmxWIju6dHjvMhR
	 Jw4Xke+387YftU3lGl/YoX2Xk+UUsw0Rkspn2qa5yOkvs2yO2Ogw/NNIThpLB0r9xj
	 +Wc8vdUS31j+A==
Date: Fri, 13 Dec 2024 10:10:54 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kevin Chen <kevin_chen@aspeedtech.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, tglx@linutronix.de, 
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, olof@lixom.net, 
	quic_bjorande@quicinc.com, geert+renesas@glider.be, dmitry.baryshkov@linaro.org, 
	konradybcio@kernel.org, neil.armstrong@linaro.org, johan+linaro@kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, soc@lists.linux.dev
Subject: Re: [PATCH v3 1/6] dt-bindings: interrupt-controller: Refine
 size/interrupt-cell usage.
Message-ID: <k7jftzlih6ss4yaxrv7r4dudhcu43iyu2qvkl2thb5wiaszto7@evzmwfxxzzt6>
References: <20241212155237.848336-1-kevin_chen@aspeedtech.com>
 <20241212155237.848336-3-kevin_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241212155237.848336-3-kevin_chen@aspeedtech.com>

On Thu, Dec 12, 2024 at 11:52:31PM +0800, Kevin Chen wrote:
> 1. Because size-cells is no need to use 2, modify to 1 for use.
> 2. Add minItems to 1 for interrupts for intc1.
> 3. Add 1 interrupt of intc1 example into yaml file.
> 4. Add intc1 sub-module of uart12 as example using the intc0 and intc1.
> ---
>  .../aspeed,ast2700-intc.yaml                  | 60 +++++++++++++++----
>  1 file changed, 47 insertions(+), 13 deletions(-)
> 

As with all your patches, repeating since v1 the same comment, so one
more last time:

Please run scripts/checkpatch.pl and fix reported warnings. Then please
run 'scripts/checkpatch.pl --strict' and (probably) fix more warnings.
Some warnings can be ignored, especially from --strict run, but the code
here looks like it needs a fix. Feel free to get in touch if the warning
is not clear.

Best regards,
Krzysztof


