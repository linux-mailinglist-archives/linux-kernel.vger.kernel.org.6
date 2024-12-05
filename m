Return-Path: <linux-kernel+bounces-433000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292E09E52C5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE21E284A58
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA93A1DB94F;
	Thu,  5 Dec 2024 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NJnHShKW"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7991D4600;
	Thu,  5 Dec 2024 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395418; cv=none; b=UcKh+TDF7UUE6H2mykR35Od35r6AZbC1qv6TdXc1mFs8WrXXMg91KhvfbRJOHR8Y5AtDQV42oBXzixhU/lVKc7/1MJJpJk/+fRzzoDofK2fVcBQ2fWiTWsq8Fcg3rruDAdBXZCGKxPtuCqOWTpHXBIiRhO86jFxJuUql89086eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395418; c=relaxed/simple;
	bh=0TzKSVsNu5M/UvdOeCNcMXOT8dIKIS/jDUqyfqKg3eY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W5uM0bTeWJsrSXd+XuA5SfCDj7ExsrN5litl6siKuGDVoTP2HALBypAyOFo3AC/JJ3dD6MZ4FWX9YZKi9Ydb89JaO4dXn8rB6UmbOl/u29su4lG3CHDZChkupd1fXJSjW0RcrwU4mHs+JXwzs21VGNLoutTwUdvm3CWQrNAyPPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NJnHShKW; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 92C6EFF80C;
	Thu,  5 Dec 2024 10:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733395414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tVOU/hBtES9NqNMn3b9b53d5oMMBwDCM8MS0sfrPHxw=;
	b=NJnHShKWQUPjsX2QhlM5RDC+Jzxsy8E7DP7gbzzy10uiSf8zLJzRgetftuIys0UKY5J3/z
	dZWX9tr5Ds/Wu8zUUSUTAIIGSpdwLF2mrHkqpInaACBaJCF7/pDxTfR00uHY4a+epFiWKI
	n18wVl8zCnBtflYJW/vJvYMwUOP/OmzQcVnqMAPbvI5iCIXz75fjvBb8GdFzARHOVBj86m
	zpfcoA5iQUn6ElWHAr4IjGQf2rl8GrRvtUbNYBeDcb+1j1dR37ufXae52mw3NwvlW/oOwh
	ma/3ujT1hBMvn7nnVZiscRbdLoXa4pYSkWvzaAvSSBNJFlydFY1B0v9aihF+Ow==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] mtd: rawnand: fix double free in atmel_pmecc_create_user()
Date: Thu,  5 Dec 2024 11:43:25 +0100
Message-ID: <173339519112.766262.17129619892556491178.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <7d809e5f-32e1-4438-9cc6-3167f27dd239@stanley.mountain>
References: <7d809e5f-32e1-4438-9cc6-3167f27dd239@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 23 Oct 2024 11:40:56 +0300, Dan Carpenter wrote:
> The "user" pointer was converted from being allocated with kzalloc() to
> being allocated by devm_kzalloc().  Calling kfree(user) will lead to a
> double free.
> 
> 

Applied to mtd/fixes, thanks!

[1/1] mtd: rawnand: fix double free in atmel_pmecc_create_user()

Patche(s) will be available within hours on:
mtd/linux.git

Kind regards,
Miquèl

