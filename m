Return-Path: <linux-kernel+bounces-411268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8479CF559
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352A81F21665
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0EA1E1A34;
	Fri, 15 Nov 2024 19:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oN/OXCB2"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF03816D4E6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731700710; cv=none; b=P8k9mY7KMXYkRpcL2GCyPYJDmSjQQvCk8cDbzdGuGu4ouKVbQMYuGBsvAzqA8iawmSVrBSKGPnV1VmvtNwxNZMb8Bx5vILLUQNt9FWK12Zd8c/n/1xnvvBxUaSDYLdrzvZrLGFh0GlQZcglbR5XzWeayzaEXrOIetkz3gNPWBMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731700710; c=relaxed/simple;
	bh=LCcNL9j+JHpEUWwQ1+V/y6fhBw9ANCI49Cstw5j3pro=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KIPelCbt7fpm71EvUaMB2YDqGlUgX3DbgYE+1G2R/87kWOn1dQsgZoAtcfFHGWhyLzppOep+BDFna0n7F2sh+KeGYDCfiXD9orVjnSlrRHQUi1YSc8Fi2TheQuvuS22508DPHW1624VL14ULKMObeYiA535+9tzE0HBMIf/jXFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oN/OXCB2; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DCEA9E0002;
	Fri, 15 Nov 2024 19:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731700700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T6fzcxagWyMTwXuJJwuCweyoeq3e4Jn/aH3kJkkVikk=;
	b=oN/OXCB2lWBwrp2SmLeOnPni2S2XVS25+JTSJaJbjqKOu+EJrX9l0CaafNc2yfLPzpIHNL
	vA/521AiTIvtmGYkozCUK32I+qDBbsiyuU6ptcNT6dqJgxBVdgg2/V/s4kIQA9yE1wHjWN
	a0RE9gBWXw/T6KKFdva7DTWlJ2BS9rwirLg38FPDQhHppOJ2PLZECv2+zT1t2uTqCnkQB5
	7T9mvYqsSHgAWx5QVPZ9i1MF4ELLERQ6aqRA6vkEGdo8zvUHg0bmXo/BAI8suEpefWiFn2
	pF+D/0/40ccM44Qjgti0Tdo/6gCaPS/bvcXKP02bglbf58JqYlDv3b4O3idBKw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>,  Krzysztof Kozlowski
 <krzk@kernel.org>,  Richard Weinberger <richard@nod.at>,  Vignesh
 Raghavendra <vigneshr@ti.com>,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Herve Codina <herve.codina@bootlin.com>,
  Christopher Cordahi <christophercordahi@nanometrics.ca>
Subject: Re: [PATCH v4 04/10] memory: ti-aemif: Create aemif_check_cs_timings()
In-Reply-To: <20241115132631.264609-5-bastien.curutchet@bootlin.com> (Bastien
	Curutchet's message of "Fri, 15 Nov 2024 14:26:25 +0100")
References: <20241115132631.264609-1-bastien.curutchet@bootlin.com>
	<20241115132631.264609-5-bastien.curutchet@bootlin.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Fri, 15 Nov 2024 20:58:17 +0100
Message-ID: <8734jsmfqe.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: miquel.raynal@bootlin.com

On 15/11/2024 at 14:26:25 +01, Bastien Curutchet <bastien.curutchet@bootlin.com> wrote:

> aemif_calc_rate() check the validity of a new computed timing against a

                    checks

> 'max' value given as input. This isn't convenient if we want to check
> the CS timing configuration somewhere else in the code.
>
> Wrap the verification of all the chip select's timing configuration into a
> single function to ease its exportation in upcoming patches.
> Remove the 'max' input from aemif_calc_rate() as it's no longer used.
>
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

