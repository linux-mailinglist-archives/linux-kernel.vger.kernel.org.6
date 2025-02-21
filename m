Return-Path: <linux-kernel+bounces-525873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 417EAA3F69F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9F0A188DA2A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF4F20E035;
	Fri, 21 Feb 2025 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="J+B8ftd8"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD64520A5DB
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740146395; cv=none; b=fSCwR1qJDd3k6CTpy3enjJIwLcC7f00M33e3Cnp5tAPNvfvnHyH11R4rP3BQXnvyr6pirGu0gUa1Xe5xwBwXHpeo5UDpabjfcR0NdJdSNDvNKn29/8hFN1SRypL2LOm+o6eoRCEGoYDmkfsMkNepbXHz344NNKXDOip+8+YvGxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740146395; c=relaxed/simple;
	bh=jPzBuw9UsBe99nwjSVKxaFyXXJIsLlYuHr4g0n0BOKE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pV4SVa+lWiFXumR6UwFSWTzux/vSRPUigvKbYDxF5L9dEV8ssCSr+p9dWTHkL3Mzln06hVui45zD8pjopsx/amUY+vPMZWddBBBtcuNuOQUFn92vzXd3SbQ2vOgCgMoW37yr0Ag6yFjd4W6Ui2bspe9UgACjdHtHcwNgFJl7v6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=J+B8ftd8; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C2BAA44275;
	Fri, 21 Feb 2025 13:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740146390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jPzBuw9UsBe99nwjSVKxaFyXXJIsLlYuHr4g0n0BOKE=;
	b=J+B8ftd8W/uUKRzfNpEGZm82vjg0m+a7zbdrRQIrI4q7z/IKhcDSBhL9AEAyNvx3dVt6KF
	AncIKgxMQOzO7iz8vsWqlnp2DrescSnIRGgfumgU33fO7MTGaJUKJDtG8vAns90AAATKE+
	uXJLU/rGzv8tVMQWK5UpwRrVqhVq0heHpeWaHqemC5kegbOCmvByaDBF9Kl3h6b7q9yKx3
	EM0kxekr+X83CrbE+uRMZDSm05Ufl+dRDzNdzN00TIzfbN7eqVjrPQqUDPwX4vPb9lqqQx
	Hey9efkSdK+2h8ou28EyjmZ8wYqAoXpPNmP2dkA3Ld0orMADdqRgFGaBDFJO8w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: vigneshr@ti.com,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  richard@nod.at,  alvinzhou@mxic.com.tw,
  leoyu@mxic.com.tw,  Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH v4 0/2] Add support for read retry
In-Reply-To: <20250221093300.430994-1-linchengming884@gmail.com> (Cheng Ming
	Lin's message of "Fri, 21 Feb 2025 17:32:58 +0800")
References: <20250221093300.430994-1-linchengming884@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 21 Feb 2025 14:59:49 +0100
Message-ID: <87r03rfley.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejtddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffeghfejtdefieeguddukedujeektdeihfelleeuieeuveehkedvleduheeivdefnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepkedprhgtphhtthhopehlihhntghhvghnghhmihhnghekkeegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehlihhnuhigqdhmthgusehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtp
 dhrtghpthhtoheprghlvhhinhiihhhouhesmhigihgtrdgtohhmrdhtfidprhgtphhtthhopehlvghohihusehmgihitgdrtghomhdrthifpdhrtghpthhtoheptghhvghnghhmihhnghhlihhnsehmgihitgdrtghomhdrthif
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

On 21/02/2025 at 17:32:58 +08, Cheng Ming Lin <linchengming884@gmail.com> w=
rote:

> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
>
> When the host ECC fails to correct the data error of NAND device,
> there's a special read for data recovery method which can be setup
> by the host for the next read. There are several retry levels that
> can be attempted until the lost data is recovered or definitely
> assumed lost.

I am sorry but you need to rebase on latest -rc1 or maybe even nand/next
because it does not apply.

Thanks,
Miqu=C3=A8l

