Return-Path: <linux-kernel+bounces-407417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE2F9C6D29
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3521F23E29
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B62A1FCF7C;
	Wed, 13 Nov 2024 10:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iMs3tmyU"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6811230984
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 10:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731495134; cv=none; b=Ffg5NUi9/EBDBdG1hOBuGm+v7eRjRq7MjuxjhFQp5NSk1v8HC+ynftfWOQRptBYMozVb/PNvQS4CC0Oi722cW2VacyoGLoOAwy+X/relqzmb5L0fvTHb+n5bp9j7tfKeAhgTe73+xE9oECczxpxhjQRxJ1D4rMJPGKyK+Zhez1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731495134; c=relaxed/simple;
	bh=DXmkaewXV+jbmtfOFtF+vCWWc8QJDcVY8+FgkFNdz3s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hNQ84Uvw3NfkLQjM1/yvYHvMsqmBejADCKSJSmARYcfVuWrc05K3BluxGobFgdfrqJtOBX3WQ33SHZlh1ToV48CbUC1nehLJcoXF28zdPZDeg//Ru3aAaX+/aUAMH2vbYe3DQPv3NegCkDgplzT4Dm+Dw3LjskA2d8Ev2vw8fB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iMs3tmyU; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EB1632000A;
	Wed, 13 Nov 2024 10:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731495130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DXmkaewXV+jbmtfOFtF+vCWWc8QJDcVY8+FgkFNdz3s=;
	b=iMs3tmyUKGNew47ufeH21OT0z6vZVymsxg845TFTftjh4l9pwPZORX8Xdi+/VlrXkRI2xG
	HfKlhRAMr7T7+abHhE0zh/aJiQkLvIt0v6mxhjat9whvT9qmqN1szesxM4ukFqpfbhxy+W
	p+cnuUwkBlbN3ehRqdMJhJnSoL/uqQKdxdUZDtGm4IW5g/VkqHPoS4nlSkvjNX/2trNWSB
	bFYAmdtHXJF2RFaw3Ahltj6g7obARkvIaNyCH592iApg0+8FgG6wCVDh9RWcq4j/L3066g
	zob9VdNHFwtZ+LawXC8+Dh0HjJqBds2j2g0HO71UPZro53ZpLTdmgZu/HitFuA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>,  Krzysztof Kozlowski
 <krzk@kernel.org>,  Richard Weinberger <richard@nod.at>,  Vignesh
 Raghavendra <vigneshr@ti.com>,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Herve Codina <herve.codina@bootlin.com>,
  Christopher Cordahi <christophercordahi@nanometrics.ca>
Subject: Re: [PATCH v3 2/7] memory: ti-aemif: Create aemif_set_cs_timings()
In-Reply-To: <20241113094938.44817-3-bastien.curutchet@bootlin.com> (Bastien
	Curutchet's message of "Wed, 13 Nov 2024 10:49:33 +0100")
References: <20241113094938.44817-1-bastien.curutchet@bootlin.com>
	<20241113094938.44817-3-bastien.curutchet@bootlin.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Wed, 13 Nov 2024 11:52:07 +0100
Message-ID: <87cyizquco.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: miquel.raynal@bootlin.com

On 13/11/2024 at 10:49:33 +01, Bastien Curutchet <bastien.curutchet@bootlin.com> wrote:

> Create an aemif_set_cs_timings() function to isolate the setting of a
> chip select timing configuration and ease its exportation.
>
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

