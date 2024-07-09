Return-Path: <linux-kernel+bounces-246598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E11D092C423
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956331F234C7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3501D182A7B;
	Tue,  9 Jul 2024 19:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b="rUnY0UFI"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E681B86ED;
	Tue,  9 Jul 2024 19:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720554794; cv=none; b=F3njYr5x6jZI7GSmgd7lB8FLJvf1/9rFXFHtwBh8ZWgFQFp/h1thh0NAQpJTYeszcH0dOGO6VQ6lIrsrXiMTuzJCx280RDe+reeIMVow0UtEqHg/LE5gcvoLZGTXB4i22vXS8genDehYTL36Me2Nh5MP0dS4nezw6cAx+XJh+jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720554794; c=relaxed/simple;
	bh=4VS6Gzx42in4s/cuAXwyjapmmPAl1UBawf23jVaBWnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNUKFsKm//BMlsj+Vo0jWFhWaziZOy+nSz0mTV1b67Wf6YexZiuSxNtLeQnXqmQIgEqEqlZ8T3aom7bEh2teqi9WAKU/4djfIdCuH7rfX8ice/3af1zl31UmTxizb7RYR6FXzoBglwPrAQnQau+K/xPArKibdULgVx3Mr6jLwdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b=rUnY0UFI; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1720554773; x=1721159573; i=j.neuschaefer@gmx.net;
	bh=4VS6Gzx42in4s/cuAXwyjapmmPAl1UBawf23jVaBWnE=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rUnY0UFIabfP2Tbh1ZPdf39SARlrVoyRanRLWcmkfM3ikQ7REFFIXdaWC2QZNf0k
	 d6n7kS7EMJSpzaXW2VpG3kT5N8irmm118zpNLIF+jecHyKSuoTrO59y6IbrazvjZy
	 NsvP8aPWqhCBkHaxuaofVEdOZooL/GhvsWH9sjKx8HzdP8gq4BsXkHJmORb9C2+QM
	 QB6uWLTk+PgmLirYCigv+RMve1YkzroKk0kBgU/bZnPv/NSvEHc9KlXda71qFLPca
	 6+eoKzv01fWkgktNfGzPudQtY7lgN1jLP3AtpLE2/uarIjFL8vkA1C+fDQXaUDwp0
	 otL2ObFUzHgZy1VCEA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([5.145.135.151]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDQic-1sZYMl0kpK-006lrd; Tue, 09
 Jul 2024 21:52:53 +0200
Date: Tue, 9 Jul 2024 21:52:49 +0200
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: bcm2835: Specify
 /system/linux,revision property
Message-ID: <Zo2VEZ3kHmYtU1_T@probook>
References: <20240708-raspi-revision-v1-0-66e7e403e0b5@gmx.net>
 <20240708-raspi-revision-v1-1-66e7e403e0b5@gmx.net>
 <a3400961-ae76-4e11-ba8d-1f659f7324d0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a3400961-ae76-4e11-ba8d-1f659f7324d0@kernel.org>
X-Provags-ID: V03:K1:g0FDFvr9YWbx7Xcr+ARx7Y+T9ipJ+T99zpRg2SekCAz/fQV9uvp
 kIiSiJm3rbcTNEAsrW1V9DRdorYz8DTKLf3R2Htzjzv0gN7VCsCyEzWpyQPO2vrsaCePNlW
 4l8rssdbSDjQKSLHcR/Ud31wWA6nGXNbF5cj14R8MjM3HSCAqiaPJ7JF3AExOBHthbDuXrj
 mfBQpUqzguui1YA68pUsg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IaDw7jJPIVc=;tL7hhhJJSKOgU1n+kVDY7cTif4g
 KxteMqy3s8Gw+w2CGqG7TsoBVEDeITP6oFNXpVjW4AAoC43XVvpxOjBq0crytkDyATPAbWJxD
 CgRwrkl55DqS3NvscbgWKd/BGAgBD1SGhtk6nwQnsP6DiDutO2GakAEbNRQNcV3cKv+GtGOBV
 8YaCgCU/EYSDAFp7CW+Q27wZCsfVkaejV2XYZFe1/6HXiqWtynaQ6iQ5QNJ4o2LuxOes3KZpP
 Dwgi/QnNF2k1F2QbIZJ1E3vVfxa4lIvothzd9o8EodT9hS/5BQ0UaRb7TbIes0kke8lRm/0Tq
 F7+8mjkeqXfomRxzaFETlhmcoQwjs3hh8pLsEtomrLvEmEd2rQuF8ZxzwTUh4sYPzyuHfIIdo
 llGJdILYwM0VyrEvNN36dsZcorDevmrc+vUiZctMt9YaKLeNkms8y1gVmAf+YaA5AValVf+L/
 vRqiWSdm+9QZPFSND/WNpcZbziMIHCi0ptzzSuMDPxtH5ISGw7bSXAgCNoT3h96CkruTTvCeE
 gdZSYgGIzNHVMaajk8splH9jEZjgUJrEwwpzBv5iRpZGxCZT9Hat4adYSNrVpuIWDnvB6QVal
 oa+A1t8JVAx6NNFPnsurdOwK28rn8M1FYJoFggezPmmbVl5ggfIJQnWvDC0QcVQ2lWneACvWY
 cSBdYcoCGA0iYfZPSBU1uPwyw3f5qh8F/BANmHipdAXv9+Qa++jZpVjewX79Jff7/FzXBMIHL
 pjHywquwSXUHivcGXe80jJDLI64gTwfQ++mbZBQn+ZYM+KY/j5tiOVH7qhtau9464cwahAFaq
 Lyc3Yo4V5YsSlegk2nNxghqMGziihgF9VLQa9R6sY649E=

On Mon, Jul 08, 2024 at 04:13:10PM +0200, Krzysztof Kozlowski wrote:
> On 08/07/2024 01:08, Jonathan Neusch=C3=A4fer wrote:
> > The Raspberry Pi bootloader provides a revision code[0] in the
> > devicetree, at /system/linux,revision. This patch adds
> > /system/linux,revision to the schema to allow it to be used in
> > mainline Linux.
>
> Sorry, no, we do not document stuff for various out of tree things.
> Otherwise we would have to accept hundreds of ridiculous, vendor propert=
ies.

Fair enough.

> Fix your bootloader or make it upstream.

There is no open source upstream for this bootloader. It is (sadly)
Broadcom's own proprietary code.

Not sure what fixing it would entail.


Jonathan

