Return-Path: <linux-kernel+bounces-433007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 415249E52DC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCDB01692FB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C881D5AD4;
	Thu,  5 Dec 2024 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bx/XghAA"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605E31946B3;
	Thu,  5 Dec 2024 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395610; cv=none; b=FOCDjOkIzygpb9DcsQGvUhNltMcK1HpMLn0DmieKu5ljul3QsQ0ixsg9SaHVlYIWQYiErBrFErnr6EvFYtHUhlTFn9nVvtPyV9tf1QLsMszv3qQA5wUfU8ySwOn1y8zz2OzvjPIfufUHDFCzSwe5FjnIw9eTtBjMT/milIJU3Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395610; c=relaxed/simple;
	bh=inXZSiSdow9lnlxEHLSvl7TRY3Mjafcy8CPpOrdlgqE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OvIery5cNgU1ecNOA3r0oDC7A8TYvqI6tTCuE2bQBsIpgLaL30FfsKFHPyNli40YcjTeL50kVxqiLhXeRC/ZczgPEbQLyy9h/9gc1BU7X7V48VKfZ8ml19NrkOi3MQjJUfQ6w79nWKJz4zK7fafyWBqagVzoN9THNUhme7oN43U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bx/XghAA; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EDB68E0004;
	Thu,  5 Dec 2024 10:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733395601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=inXZSiSdow9lnlxEHLSvl7TRY3Mjafcy8CPpOrdlgqE=;
	b=bx/XghAAOu5daQIBI50PbI23icFM90XQCnPU9shwwP3VCxUfv8gLaLJvx2fuLfGE6mNamH
	usAhgCUSTFjrt2u73yTpwmQJGN+zPg+fBGHzJrgV482BTkqwYWUFAYErvu2KWx0BW3Yobt
	jhElUSa7/cBOYezsIaicvPw+76XkIbA2sIVS3Z/7eMwpb05YYvGZ+6Ynd6YZv/WEHPQ7JM
	V4Zoke0EkSxLatqqUxrIexUTqxbv2VMIF7EIj76+y/wM1perMmFPH6RlJsw86AVH7erGZx
	ktxXs4HduY/MNyS29wzbQc8332yaCPeZbdH80Ls+ANVBjRjqX1bEPrxZULyvUw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Heiko Schocher
 <hs@denx.de>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  devicetree@vger.kernel.org,  David Jander
 <david@protonic.nl>,  kernel@pengutronix.de,  Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 0/3] Add support for Fujitsu MB85RS128TY
In-Reply-To: <20241203-mb85rs128ty-v3-0-79107d54d839@pengutronix.de> (Jonas
	Rebmann's message of "Tue, 03 Dec 2024 11:38:34 +0100")
References: <20241203-mb85rs128ty-v3-0-79107d54d839@pengutronix.de>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 05 Dec 2024 11:46:40 +0100
Message-ID: <877c8ev23z.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

On 03/12/2024 at 11:38:34 +01, Jonas Rebmann <jre@pengutronix.de> wrote:

> The Fujitsu MB85RS128TY FRAM chips behave almost identically to the
> Microchip 48L640. This series adds their support to the mchp48l640
> driver.
>
> Signed-off-by: Jonas Rebmann <jre@pengutronix.de>

Series applied to mtd/next.

Thanks,
Miqu=C3=A8l

