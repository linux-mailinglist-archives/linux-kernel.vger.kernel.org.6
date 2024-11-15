Return-Path: <linux-kernel+bounces-411266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB96B9CF555
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80177281CE6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857291E105A;
	Fri, 15 Nov 2024 19:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="j4ea1HT2"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38961D5173
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 19:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731700625; cv=none; b=HtC2egdt6J6Wo+pWRAVB0/H4srYd8k9p018WjRAyl/V1ZWPvOytYhFi1cGhDCogDKPUngNgiICff1ewxrqu/2bO9VhsxPFXhfRHDHLFulanPC9aAF4f9yc0QzpXZCuXDm8dUd7C/gG7RnKOQ6deaN0T7N8UxkT4Vzy5KzihweGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731700625; c=relaxed/simple;
	bh=RMPOtaSPR2u/J6W/otLqp/bAJKMCLqxDB3D+lpqWdvU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GkvJhDOxLKWnvv4ZSZUkwD/SRb85/fYh51nh6OtbsySbZz6wrvqT6jpFuBItTIu49FYn03ow/QTgTK295olfh9iImFbo/Sl0XcJSy3mQJmZeBnDZLomyXI44h6IYwVssd5q+VzxsH0hyegxCjeBeYMEJeoJtAAB4YD5qz4KIW58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=j4ea1HT2; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D5F1E1BF205;
	Fri, 15 Nov 2024 19:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731700615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RMPOtaSPR2u/J6W/otLqp/bAJKMCLqxDB3D+lpqWdvU=;
	b=j4ea1HT2ncPsYema0YJq7ESOcgNcHXZCn87eWbrnKmENKzLgtSsoZsmNNYAz8ZQWBKpQwf
	CTDvnuvHLFN8veGdWKfEPOb8pEArEMFtX2i13ygjxFxcU/NXGcGXyuA09qrR64Mg2fhMx6
	sF3oUiqPlCCJtAg9GXnWpNryodDHqRuVj7D6T2JnsHEMiKFuEJVesufVUxPDH9UI365y/y
	oq4GlUEHaWT4H5sQaHDdCg31ObgM7BZ9xmRgvhnFggQSj10h24iilT5KTAKeLsnRwixS3U
	qDYDdW7QwPG7eBjI7GkOM0DxzDSw9s7MetykRin2r8rpDlQMPjJ6tzilWLMNSQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>,  Krzysztof Kozlowski
 <krzk@kernel.org>,  Richard Weinberger <richard@nod.at>,  Vignesh
 Raghavendra <vigneshr@ti.com>,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Herve Codina <herve.codina@bootlin.com>,
  Christopher Cordahi <christophercordahi@nanometrics.ca>
Subject: Re: [PATCH v4 02/10] memory: ti-aemif: Remove unnecessary local
 variables
In-Reply-To: <20241115132631.264609-3-bastien.curutchet@bootlin.com> (Bastien
	Curutchet's message of "Fri, 15 Nov 2024 14:26:23 +0100")
References: <20241115132631.264609-1-bastien.curutchet@bootlin.com>
	<20241115132631.264609-3-bastien.curutchet@bootlin.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Fri, 15 Nov 2024 20:56:53 +0100
Message-ID: <87bjygmfsq.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: miquel.raynal@bootlin.com

On 15/11/2024 at 14:26:23 +01, Bastien Curutchet <bastien.curutchet@bootlin.com> wrote:

> CS timings are copied to local variables that are then used as is,
> without any modifications.
>
> Remove these unneeded local variables and deal directly with the timings
> stored in the struct aemif_cs_data.
>
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
> ---

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

