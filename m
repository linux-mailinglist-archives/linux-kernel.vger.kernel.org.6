Return-Path: <linux-kernel+bounces-354756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5493699423A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0891F26205
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC191F1310;
	Tue,  8 Oct 2024 08:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fFO5P2bK"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9834718FDB7;
	Tue,  8 Oct 2024 08:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728375020; cv=none; b=n9fO5wPjqTfn5IZJ5UlCKmQFaeGxobTSaAZXgxUnTbzPDWHD0trJbYzjWPg01aYFpYr3dGv5ZxKoyAjJ+M1/4okBdi4o6lSscEcmVLvy+21ZXHs64kcyZ75L6DGcGOV1rVe4+7qTTk/MSJ3OZRhl6ICInJi3QfV85rO5+VVfirU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728375020; c=relaxed/simple;
	bh=GZ85QRx9iGUXXRrMC3iHfNP9kJrXIacbmMz+7wwj4Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iILEn+CIPyD3ikhJrr09lzoco5BhU2+pu9/eQRlibU8tjp9NfVXX9oXeB8GfyV21FZ10MFKUFzNEPYcDpoTZMnKuyhvph7sLw5MU3j6/a48aq60CX5+b7kZqXd2f/TiZheldKL/izU9l7Wt5QXdDCfgBtKULdKKid+51VoFQV20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fFO5P2bK; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 541EC20003;
	Tue,  8 Oct 2024 08:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728375017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GZ85QRx9iGUXXRrMC3iHfNP9kJrXIacbmMz+7wwj4Dw=;
	b=fFO5P2bKRSZf5vJrA1j6XjV3ctThPJ4FXtWjXHz2lLBEn+UGyhxQFDN4MmYram/EbuTEaM
	jodp6V+jvTa0pjmTEkDFG6JW4f8FAK1dAZiNP42FIxQyAJyQsFWKPwGWDjilMlRvCLJ1xV
	As7iyL53/Oz9EJgt43TKe3fc65kBtwWqEJCNCt6M/InBsMSyL5zuRnUFvYAcZariQVPzQe
	wdqOK3OvUK1m6Z5jMPag1ykC5s48w7WB3Ynaw6ZWflWl2dRMN1C+OHRunOpvoa/U+at2R1
	szXtLkC87VVBWtsp1+SQnpRdsUunsrx6pPy8mtnj1H166/ZGWHi+suj/drtFKg==
Date: Tue, 8 Oct 2024 10:10:15 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/2] dt-bindings: mtd: davinci: convert to yaml
Message-ID: <20241008101015.0b136acd@xps-13>
In-Reply-To: <20241008-ondie-v5-2-041ca4ccc5ee@gmail.com>
References: <20241008-ondie-v5-0-041ca4ccc5ee@gmail.com>
	<20241008-ondie-v5-2-041ca4ccc5ee@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Marcus,

marcus.folkesson@gmail.com wrote on Tue, 08 Oct 2024 09:02:45 +0200:

> Convert the bindings to yaml format.

Impressive how legacy these descriptions are. Anyway, the conversion
lgtm, so let's see what the binding maintainers think of it.

Thanks,
Miqu=C3=A8l

