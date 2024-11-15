Return-Path: <linux-kernel+bounces-411264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9BC9CF558
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B558FB35382
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AD41E2606;
	Fri, 15 Nov 2024 19:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YsJ4IZMa"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10DB1E1C11
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731700483; cv=none; b=PXpF7duc91GomsbeD8Y7ucMLN5aURN5oS9w6Bi1mdB+cRLiS4w3c85tPYQypJydkwZZXut9LjQlosvJascqnc0LngwTEq0Mtal+jSE+5GVcL7di0eeDSQ8YDWFXhbmqyydsT7O8XWL2vmS0PLPOn+sAJ4XU5exSCruseY96EhSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731700483; c=relaxed/simple;
	bh=tj+HHqKLYPrccjAC29PM8AVMsHyVZb9kCqt7O7EJCGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lzoua6w9YrAPKGFGbFSFQ70/e/botCCr/1xU0YoTjb90o3oLUN9mqDVUUwgv+EhSTKUnF9Ye176DcjK002PVrWYivKCNpCKS+eRiywtfLzlh5qW87gTGntx5FGb3+vBtPrLKiRAwfIIWg+ztjsmbOhTjerBp9dZguuhmKyLnyQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YsJ4IZMa; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5E94DFF803;
	Fri, 15 Nov 2024 19:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731700480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tj+HHqKLYPrccjAC29PM8AVMsHyVZb9kCqt7O7EJCGA=;
	b=YsJ4IZMaY8j9PHD0ZDjqx8IX/lCH3AkLuqdZy3SfO3QcuJ6zVNLMnWn6B7JPoTwgQW+kE/
	poLXgUbFDD66Oaqvl4WPEpEWMpMQCOwpt0/uQ912/hgpziHoXzlklsy0Ymtunf4fAn4gY2
	tC6InRRI3UaDxLvn3QEOYsc1WbOCRnsGURd8gbcd5NM7QBf9gKr2JPsdYVZOtbTpdR0w+o
	WuGTLXvx5RQ5SCK5999M5ODe/0PG1x0He0ujxGFyOPKHA+X4pkTDStzgCNBSjQu2YIcLs5
	X0wrggo7HuRqFAsHEOcegA7Wppg2fDMLtDX+6IO0cxxc3RyAj6xCeGn0WCYjdg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>,  Krzysztof Kozlowski
 <krzk@kernel.org>,  Richard Weinberger <richard@nod.at>,  Vignesh
 Raghavendra <vigneshr@ti.com>,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Herve Codina <herve.codina@bootlin.com>,
  Christopher Cordahi <christophercordahi@nanometrics.ca>
Subject: Re: [PATCH v4 01/10] memory: ti-aemif: Store timings parameter in
 number of cycles - 1
In-Reply-To: <20241115132631.264609-2-bastien.curutchet@bootlin.com> (Bastien
	Curutchet's message of "Fri, 15 Nov 2024 14:26:22 +0100")
References: <20241115132631.264609-1-bastien.curutchet@bootlin.com>
	<20241115132631.264609-2-bastien.curutchet@bootlin.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Fri, 15 Nov 2024 20:54:37 +0100
Message-ID: <87sersmfwi.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: miquel.raynal@bootlin.com

On 15/11/2024 at 14:26:22 +01, Bastien Curutchet <bastien.curutchet@bootlin.com> wrote:

> The CS configuration register expects timings to be expressed in
> 'number of cycles - 1' but they are stored in ns in the struct
> aemif_cs_data. So at init, the timings currently set are converted to ns
> by aemif_get_hw_params(), updated with values from the device-tree
> properties, and then converted back to 'number of cycles - 1' before
> being applied.
>
> Store the timings directly in 'number of cycles - 1' instead of
> nanoseconds.
> Perform the conversion from nanosecond during the device-tree parsing.
> Remove aemif_cycles_to_nsec() as it isn't used anymore.
>
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

