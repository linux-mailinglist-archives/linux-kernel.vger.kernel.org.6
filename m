Return-Path: <linux-kernel+bounces-438390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C31609EA09B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4F651649D4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855B419AA72;
	Mon,  9 Dec 2024 20:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DB93rz6W"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCCD1E515
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 20:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733777616; cv=none; b=lsfh/YX0smF8f5vZM/KUc753SPrbdDYpFhQkD76g/v1TDLXbFl7tOMYdgNNdsyp7Nqklfl2i02dKUevhyV9ZAuwMk0LMV1H5dqoHXDTlLKY9QNN7dlSUQGQ9Eb2SoAqgOEt3kIy4TiPtAcP5Sdb+paePBdwtzwlN9rFLORahDWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733777616; c=relaxed/simple;
	bh=MuEuujiyyJvWTVyWstHQ8QjJFMFxtjOyvwBn0XuKDrQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=akVLPaQdbANsKGr95PQw3ALFpGPjBvV02upXO3rX2pgAgOw5Nxyp7UwOCXS89lU+rCyxUxIIF15BNF47aYbAslyqcQhjwpyZWLRvhQMnbNRDD/NqLshT4JYPADh6Ny2GdJ9O3L75jkHw3zRxmm4KMVs6D9haG6taJIrqoB6uGIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DB93rz6W; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1A3FDE0004;
	Mon,  9 Dec 2024 20:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733777606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MuEuujiyyJvWTVyWstHQ8QjJFMFxtjOyvwBn0XuKDrQ=;
	b=DB93rz6WjPj6/SWHmQsR5IQ9w8dxml0YceInz36BE61vyVuVednaZiU3O4/wWGE4poVevW
	3XI+1dJwj45Z0Ci6VwiQRmgilo765uoh45TMjeZ/DZZH2fS4/ZKQNqOlMObPCrzVJJJURE
	DBDtqES2HbzYZv1OlzJVKj8lS8NlFh9BYaZl2aekvahGaFTCCsLWhYcUZr5c2zNB5Y8qBl
	W2JTqHVQGaJdi0u3uZ8GpCNVSXB+mF1yFlXjZywea/FwVkr/orijLUzZM0fOT3n6fHz0Pq
	aCYXng97NzMRAtBxwshXMR5McFyswCbiwA1mVtyFpgTbfDtJioNOW53XQaxEag==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Santosh Shilimkar <ssantosh@kernel.org>,  Krzysztof Kozlowski
 <krzk@kernel.org>,  Richard Weinberger <richard@nod.at>,  Vignesh
 Raghavendra <vigneshr@ti.com>,  Bastien Curutchet
 <bastien.curutchet@bootlin.com>,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Herve Codina <herve.codina@bootlin.com>,
  Christopher Cordahi <christophercordahi@nanometrics.ca>
Subject: Re: (subset) [PATCH v5 0/9] Implement setup_interface() in the
 DaVinci NAND controller
In-Reply-To: <173377318397.159219.10800117213949308208.b4-ty@linaro.org>
	(Krzysztof Kozlowski's message of "Mon, 9 Dec 2024 20:40:56 +0100")
References: <20241204094319.1050826-1-bastien.curutchet@bootlin.com>
	<173377318397.159219.10800117213949308208.b4-ty@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 09 Dec 2024 21:53:24 +0100
Message-ID: <87ikrsr323.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

> I'll wait till it hit next and got build reports and provide these as sta=
ble
> tag/branch.

Perfect.

Thanks,
Miqu=C3=A8l

