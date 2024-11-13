Return-Path: <linux-kernel+bounces-407420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 053599C6D31
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37E3BB216E3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7581FE0EE;
	Wed, 13 Nov 2024 10:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NwiLAHAk"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EFE320F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 10:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731495325; cv=none; b=t1whdMIN0396dl1lN0F75Rg9qkmmjMe8n5zlG5G4/uvTlZabpcb1w9i+gxL6nFUDrHJutMkp/8XjkqRO1k0UtX21zxDsDbSvspuui9C/WmywjbvhFBXGhstXfwf3oOEE2Tbf3bH5P/4TQS62RKaS91g4VDGA2rIHWHX1sRgC8Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731495325; c=relaxed/simple;
	bh=/pBLww4YxC/M6fY3ALfaV/Z1B7bVr4NbB9uCxlvcMow=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hsqRqjKSjkIi+ZnJY5WCLDP6j7s0RsqxpANaGtgxFyZbbMUYzA1UPLugIqvBq7fchbBdPcLm9mbFrmGk+mFL2pEzxdZrbaJ89vb8hQXQlUF3X3PrkhUmEakrcBfxeTHrY+jYgWJRtJxOL0pYEm79RzSc0GMZyBBWXXc52viKfM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NwiLAHAk; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B8F0F20003;
	Wed, 13 Nov 2024 10:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731495322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/pBLww4YxC/M6fY3ALfaV/Z1B7bVr4NbB9uCxlvcMow=;
	b=NwiLAHAk619Wvb/I387f3vNgmblZX/1Jpd9do/GD1ob9WShm8mYheYNSG2hqXY6ANsn3yG
	Q8zkypC5fFQ5YPQUVI8OBuZ76k/ld8bjgzXyl+n46YRtvb+S5vk6YV2AFtYy76V17yrbks
	D5bv6ULxy1fWxYe0jWv1dJzr+5Vv4TwXiiF2LjDqsAfD1tu1tT9K8v6DsCIAS0Xeh+Jhdm
	vMjQeh8h5V29x+ehi0Ti1qL0Mv+DwQbOuCEcaGiWzqnNWpg6FGfiUBB/wq5w8y58KqVsgJ
	M0r0slN/3PxWrlyQtBor5YoNwp0++qcPogRBJwbliq54K5f2fcqiI4OqAYBj9w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>,  Krzysztof Kozlowski
 <krzk@kernel.org>,  Richard Weinberger <richard@nod.at>,  Vignesh
 Raghavendra <vigneshr@ti.com>,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Herve Codina <herve.codina@bootlin.com>,
  Christopher Cordahi <christophercordahi@nanometrics.ca>
Subject: Re: [PATCH v3 3/7] memory: ti-aemif: Export aemif_*_cs_timings()
In-Reply-To: <20241113094938.44817-4-bastien.curutchet@bootlin.com> (Bastien
	Curutchet's message of "Wed, 13 Nov 2024 10:49:34 +0100")
References: <20241113094938.44817-1-bastien.curutchet@bootlin.com>
	<20241113094938.44817-4-bastien.curutchet@bootlin.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Wed, 13 Nov 2024 11:55:21 +0100
Message-ID: <874j4bqu7a.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: miquel.raynal@bootlin.com

On 13/11/2024 at 10:49:34 +01, Bastien Curutchet <bastien.curutchet@bootlin.com> wrote:

> Export the aemif_set_cs_timing() and aemif_check_cs_timing() symbols so
> they can be used by other drivers
>
> Add a mutex to protect the CS configuration register from concurrent
> accesses between the AEMIF and its 'children'.

I'll let Krzysztof judge whether it is okay to use EXPORT_SYMBOL instead
of EXPORT_SYMBOL_GPL here, but otherwise looks ok to me.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

