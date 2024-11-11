Return-Path: <linux-kernel+bounces-404656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 985459C4645
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2801F22AE2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D271B654C;
	Mon, 11 Nov 2024 20:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Uz4rrv9s"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D7C1AD9EE
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 20:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731355212; cv=none; b=KZgl1LPog+MN9+Xwe8f56BtXkCrD6WZCnK+Vc3QiJ4JAX/nhLDcdvrgr+WJn6FYkGOrhEgzy9056iZusAOSCNiWP2X2hUaMs0j/6buju7XUYw0t0dhrVTrESPcho5sbKiyDU+m3FX4Mva9oKkIatJzEtCdeysfIXGBdQKbqb/AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731355212; c=relaxed/simple;
	bh=/sZlCQTAFlSV3ML2XYkoLh9xs5MKTCcnmOpJ7AVIaFs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=syGNtO6h4UuUXPLwfhHHjfnZ0Ksi6gNm/mA2imIRvApnLhL8qERCh+gwMMIiLUaW/3/+N2SuggGy9Vgae2uFDv3ELyxalOm7kh67EP8w30uMC19WDxcnOMslutBN1f8+qijoeGWHvNYcj3a1BdfWuhI/Wcm3GBB0IggG56aa+gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Uz4rrv9s; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 64570FF805;
	Mon, 11 Nov 2024 19:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731355201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/sZlCQTAFlSV3ML2XYkoLh9xs5MKTCcnmOpJ7AVIaFs=;
	b=Uz4rrv9sAP6S1v8QJIJFrVsvty0w6LV7bj8szBZ3c6JUpFfJZMqY1PY7ggwgRie8xN6OtY
	DPSXnkYejOFnRKak5R1szxwUDKqIDtzg1hzIZX6bAeA9PwYmGxGqRlxGuCTu5wVuojLLR0
	5/EKKzrKJYipEREX7mfpycg3/XKqDBkB/U47/hFOlwAN6G0lefplYzZh1RT/ghKfeaAx+G
	FebU7XtxgGauhPdMs6Ho0PNyl6Z38OWv7zh4/ioRknH7nxLvC43fd21YlFFfudVvHh10RL
	D0pckZO+obQ4tj7cdnK9tdsytdbUQHJcMJl0P2UrnR6OJjsvuwyPrW7M2ncK7A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Lucas De Marchi <lucas.demarchi@intel.com>,  Thomas
 =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,  Rodrigo
 Vivi
 <rodrigo.vivi@intel.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
  Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie
 <airlied@gmail.com>,  Simona Vetter <simona@ffwll.ch>,  Jani Nikula
 <jani.nikula@linux.intel.com>,  Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>,  Tvrtko Ursulin <tursulin@ursulin.net>,
  Oren Weil <oren.jer.weil@intel.com>,  linux-mtd@lists.infradead.org,
  dri-devel@lists.freedesktop.org,  intel-gfx@lists.freedesktop.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] mtd: add driver for Intel discrete graphics
In-Reply-To: <20241107131356.2796969-1-alexander.usyskin@intel.com> (Alexander
	Usyskin's message of "Thu, 7 Nov 2024 15:13:46 +0200")
References: <20241107131356.2796969-1-alexander.usyskin@intel.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Mon, 11 Nov 2024 20:59:58 +0100
Message-ID: <87y11po81t.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Alexander,

On 07/11/2024 at 15:13:46 +02, Alexander Usyskin <alexander.usyskin@intel.c=
om> wrote:

> Add driver for access to Intel discrete graphics card
> internal NVM device.
> Expose device on auxiliary bus by i915 and Xe drivers and
> provide mtd driver to register this device with MTD framework.
>
> This is a rewrite of "drm/i915/spi: spi access for discrete graphics"
> and "spi: add driver for Intel discrete graphics"
> series with connection to the Xe driver and splitting
> the spi driver part to separate module in mtd subsystem.
>
> This series intended to be pushed through drm-xe-next.

Overall the mtd bits look fine, I don't want to block this series
further so you can add on the mtd patches my

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

