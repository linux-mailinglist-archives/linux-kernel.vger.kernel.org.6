Return-Path: <linux-kernel+bounces-533531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB30A45BBB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23D8B188F517
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088C52459F9;
	Wed, 26 Feb 2025 10:27:34 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CB02459CB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740565653; cv=none; b=HzLuMlbv4JcNCqQ1IPGWQAq1wsVNEKczfyM4f6lnCTHtqYXIpPIuI78an2TaE6skhuE8IHAqlhaIsMZ61s6kV3emK7tSPvinYWFT15o7PDeMF/e3jiQa1uc8MPA94rFxylPQA00gFQjRo56kolsHegUQr12P+q5xYKzlEFQtJoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740565653; c=relaxed/simple;
	bh=2OqVpQhL3M7afzGEo2RVBoCfV2wxnjYwaEhiWniHeJE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OW05yF6dAWqknUrjMtw2KHeZT08JaOPwGPnWvk+oJ3WxZeI3xvEcdKjilIWkuTl9/kA2jxDC95OrljTodIBcPFxySdO+oo2IOj1PsxoevuwhZdWPvra0q/FXaRZyYWzC+qHElRcfEnn4OX6b8Jbk4LX2Dgf8yHkjEr9ZQosAIU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tnEdM-0004Ga-23; Wed, 26 Feb 2025 11:27:20 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tnEdL-002vsT-2E;
	Wed, 26 Feb 2025 11:27:19 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tnEdL-0003OU-21;
	Wed, 26 Feb 2025 11:27:19 +0100
Message-ID: <b31fa21c7bd352fe77d50da82c4d2c333b8566d8.camel@pengutronix.de>
Subject: Re: [PATCH v2] reset: mchp: sparx5: Fix for lan966x
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen.Hegelund@microchip.com, daniel.machon@microchip.com, 
	UNGLinuxDriver@microchip.com, herve.codina@bootlin.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Wed, 26 Feb 2025 11:27:19 +0100
In-Reply-To: <20250225105329.3037853-1-horatiu.vultur@microchip.com>
References: <20250225105329.3037853-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Di, 2025-02-25 at 11:53 +0100, Horatiu Vultur wrote:
> With the blamed commit it seems that lan966x doesn't seem to boot
> anymore when the internal CPU is used.
> The reason seems to be the usage of the devm_of_iomap, if we replace
> this with of_iomap, this seems to fix the issue as we use the same
> region also for other devices.

So the issue is the devm_request_mem_region() called by
devm_ioremap_resource()?

Wouldn't it be easier to switch to devm_ioremap() instead?

regards
Philipp

