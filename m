Return-Path: <linux-kernel+bounces-521080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5983AA3B3B3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66C0C1889FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9E01C5F18;
	Wed, 19 Feb 2025 08:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mceIH92e"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0B51C5F01
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953717; cv=none; b=b3xoOpKGxHZgv9BQPMXGnYMBMuwUNjtcWNCZnrCYilVx1ZG0Brf1Z/FcPxq7taEc1lBCfdodUrguWoKaHY7eAQHAk1ywKI1j9RMkiY+A4xIegoekX6EC4EMZmvgXTk8v4Ajd3lYo856seslDsd47qBtw/VmzRHgJlhohnppHPFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953717; c=relaxed/simple;
	bh=bqo6QBKCHD3/k3h68MCGx9RspNaK4poW7gvXBTZv5Vg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VGZ1Mmy/39IgOwoXdvZSTRllwIwfHTEJ+XhOjBNDR915gGMzBHOsMVoEAQkqqonq1ciQZC7bY5tA+ucqJk5B+bDWGGAlPfrYRa2E83d2FD6bDU+HHff28fBzKxpJqnRqKPPc/m5LE2WrD2E9/hxW/xpwnQFy0oRG2NNukxr+/3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mceIH92e; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0C6A044393;
	Wed, 19 Feb 2025 08:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739953710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=exKoqztBJoJJiNjFsPWiUWzpl1Jwkr5h8NxnGYc9qcg=;
	b=mceIH92eWx935FtkZYGngBr3Sd9Kn6rluybk3eZjvC55G6HLhZNH9QR6uc4wXf+Piy63CZ
	S3lUchkYCk2CEBNwFpp9eQK8BrUe/xQ1/41KfQJ/rJ2INySRQVdjBBYkz2GQHLezCJqMuW
	b/rv3kkaFCabaNUwyx1T+kEi0nChQTzn77gDQpBjQw25qbG7bFlU3Qvj3PyV2DNLcG3tu0
	qNXlgfkc2nG2+Fym8nmG/5A1e1w7G+4W8R3nbSn3b96HbiMRD6LSXSMjfydYUFijsbjMcO
	xhJjALsbrfj5Tqz/5mVXqrQkjwK2uxtojYzA+g3j8kmSIU/21cxnZvbXXuj8YQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: frank.li@nxp.com,  alexandre.belloni@bootlin.com,
  linux-i3c@lists.infradead.org,  linux-kernel@vger.kernel.org,
  tomer.maimon@nuvoton.com,  kwliu@nuvoton.com,  yschu@nuvoton.com
Subject: Re: [PATCH v1 2/3] i3c: master: svc: fix npcm845 FIFO empty issue
In-Reply-To: <20250219011019.1600058-3-yschu@nuvoton.com> (Stanley Chu's
	message of "Wed, 19 Feb 2025 09:10:18 +0800")
References: <20250219011019.1600058-1-yschu@nuvoton.com>
	<20250219011019.1600058-3-yschu@nuvoton.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 19 Feb 2025 09:28:28 +0100
Message-ID: <87wmdmqqxf.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeifeejiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeekpdhrtghpthhtohepshhtrghnlhgvhidrtghhuhihshesghhmrghilhdrtghomhdprhgtphhtthhopehfrhgrnhhkrdhlihesnhigphdrtghomhdprhgtphhtthhopegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhugidqiheftgeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtt
 hhopehtohhmvghrrdhmrghimhhonhesnhhuvhhothhonhdrtghomhdprhgtphhtthhopehkfihlihhusehnuhhvohhtohhnrdgtohhmpdhrtghpthhtohephihstghhuhesnhhuvhhothhonhdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Stanley,

On 19/02/2025 at 09:10:18 +08, Stanley Chu <stanley.chuys@gmail.com> wrote:

> npcm845 HW issue:
> I3C HW stalls the write transfer if the transmit FIFO becomes empty,
> when new data is written to FIFO, I3C HW resumes the transfer but
> the first transmitted data bit may have the wrong value.
> Workaround:
> Fill the FIFO in advance to prevent FIFO from becoming empty.
>
> Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> ---

...

> @@ -891,6 +903,7 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3=
c_master *master,
>  	unsigned int dev_nb =3D 0, last_addr =3D 0;
>  	u32 reg;
>  	int ret, i;
> +	u32 dyn_addr;
>=20=20
>  	while (true) {
>  		/* clean SVC_I3C_MINT_IBIWON w1c bits */
> @@ -931,6 +944,15 @@ static int svc_i3c_master_do_daa_locked(struct svc_i=
3c_master *master,
>  		if (SVC_I3C_MSTATUS_RXPEND(reg)) {
>  			u8 data[6];
>=20=20
> +			/*
> +			 * SVC_I3C_QUIRK_FIFO_EMPTY fix:
> +			 * The TX FIFO should be ready before the TX transmission is starting.
> +			 */
> +			dyn_addr =3D i3c_master_get_free_addr(&master->base, last_addr + 1);
> +			if (dyn_addr < 0)
> +				return dyn_addr;
> +			writel(dyn_addr, master->regs + SVC_I3C_MWDATAB);

Maybe Frank can test, but it feels like there are chances it will break
the other controller.

Perhaps the other quirk applies to the other controller though.


Regarding your series, patch 1 does not make much sense alone, and you
should anyway write a binding patch for your new compatible (first in
the series).

Thanks,
Miqu=C3=A8l

