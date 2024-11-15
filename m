Return-Path: <linux-kernel+bounces-411265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9CC9CF56A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 21:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9D1AB2F34A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B493C1E1A34;
	Fri, 15 Nov 2024 19:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XDbWp8i8"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0069B1DD0C7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 19:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731700593; cv=none; b=nQZ0y+1V9gq6kyTyH0tGq3/FSC4Qhdpaf6Vp35J9/fJPa6ZUJFT6xni/J69uF+LU6zf3iFejPhA60W62ngCwYA6KG5WfLMqYIwpWB+S7Im6pTD/DjVjWDA9kJhY4Eei1UJxs52MCEu+hl8ZkjRE5XNcANDlKvIA6CmJYy4NY7mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731700593; c=relaxed/simple;
	bh=hZ6Co4N3thBmRpA4ccL2c7pOVG/mJ2c9Ht9oLnIkdzU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iZeQu2p7nyclJADxuVj5zkRVFMmMkgZnnFjbprLfefUQjTyeop9Z1FlQFM5/uXXwAgrLcySNA4INelbCszDBlhyHxhrsnj8kcFYe1dktLv4928XyZUDMStLxmQYN3FjAt8j1J7dZWVdYj6rX0TSufEPcWjxx6g0RGLewR/QXHRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XDbWp8i8; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 01596240005;
	Fri, 15 Nov 2024 19:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731700589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7mNYmj6ni23Jqko1xtDRAMtam5EhBsgqdEbqnjiENf0=;
	b=XDbWp8i8JF47NcJG/C7twNY8eXASi6ybsjpo1jkIg6zozBQyheFJ+4vmRR5rGbrnNqbtDt
	cq6NoEdhqw0Ty1N6aSuPSwbb59OqxoFhQUNZNF1HsCKcaHMIC3B3SV0ijuXYxeIjExHJBy
	mSQP+RyJz9AIxLKqOMLeUYfT5qNVx414L3hSCBaA0zj6MV5dfpSKz8z52mCjWhdgT9iB+v
	0Xi1Uafy925rS23lfO/vn+mPAKKu6Qq03Lwc1/EIsMSstyeTtNtBkhQwnFV8PC6k0KIMeW
	pU208kbhVfSJT50YH+FUfwQT/FVsmwD1WF60YM+oC1l9a/z96LGoFVw5RlLOWA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>,  Krzysztof Kozlowski
 <krzk@kernel.org>,  Richard Weinberger <richard@nod.at>,  Vignesh
 Raghavendra <vigneshr@ti.com>,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Herve Codina <herve.codina@bootlin.com>,
  Christopher Cordahi <christophercordahi@nanometrics.ca>
Subject: Re: [PATCH v4 03/10] memory: ti-aemif: Wrap CS timings into a struct
In-Reply-To: <20241115132631.264609-4-bastien.curutchet@bootlin.com> (Bastien
	Curutchet's message of "Fri, 15 Nov 2024 14:26:24 +0100")
References: <20241115132631.264609-1-bastien.curutchet@bootlin.com>
	<20241115132631.264609-4-bastien.curutchet@bootlin.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Fri, 15 Nov 2024 20:56:27 +0100
Message-ID: <87jzd4mftg.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: miquel.raynal@bootlin.com

On 15/11/2024 at 14:26:24 +01, Bastien Curutchet <bastien.curutchet@bootlin.com> wrote:

> CS timings are store in the struct aemif_cs_data along with other CS
> parameters. It isn't convenient for exposing CS timings to other drivers
> without also exposing the other parameters.
>
> Wrap the CS timings in a new the struct aemif_cs_timings to simplify

s/the//                        ^^^

> their export in upcoming patches.
>
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>

But otherwise this feels very sensible.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

