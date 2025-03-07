Return-Path: <linux-kernel+bounces-550621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BC0A5621E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6010716FB9F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8761A8F97;
	Fri,  7 Mar 2025 08:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cGUTpD/p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X/42zBxj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1F228E8;
	Fri,  7 Mar 2025 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741334505; cv=none; b=f8VElK/ChSkydx2WVvuTBKdT6O9uCzZl3s3fFY80WdW0j/fc9GGJ4pXvTEQ/dy7It6B2lxBb7udmnK2OpQSU5fIvsE2r5K/OEADbE0sofZRvBjyFiUzWk4+XUyqsE+4iehKIgnSjjDONhxTw8d5oquoaZv3Qtxpwx+/LLJVmw+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741334505; c=relaxed/simple;
	bh=7FwadEiQoLyNtMeiuJrDoqH2BzOXedSd+yAyT04YNDg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BtNOKbMydELwrBzGSoJVo3yTU+375/tbra8SuqSi0b569awG/3/gXsH8z3k8RoXIGogtZz+8Yk/TslMGK+mJdKFDbtUEQ8iH+pY1XShikiG20B0VRBZ5rMX6irEAfVpugDmZ1Tv+P1SIOQ0u1t3eiC+6FJvP/6Fs9CMeZTQrIi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cGUTpD/p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X/42zBxj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741334502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VrTQhqGlLV5cWQ6Nh+cod8+JI+BnnsiYR1gmH7cf4OM=;
	b=cGUTpD/pe3+W5tQmc1UM6R77BLDtZLZPh4MzBkWfM8xdOdIstwwUc72y/EM8DW5lICWEtO
	QDmtT7tYePDwwGwkUCsSEFKl6oHKnmJYGulQtm7IP/OZuM+B0a0LulmxnQ24WxVSOhIYHc
	Ilayib+gPL/+blLqWb51BoD388E2Kdm4OYFXFqM/rH3olhYhLmc1/iKAMZ+o0EbzY12bDl
	/o8gJBKYfy7GsGxjGn5gN19tGPN6jOeZzt8FZWAwJopqI9MSJ+CUJ51evyKYseUlCMzzz/
	8ME1P1KZANA7uwYovrS1UZ3ZNEw696ySyr5djYKum6oNMBGYmJs0yRN9nNIwwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741334502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VrTQhqGlLV5cWQ6Nh+cod8+JI+BnnsiYR1gmH7cf4OM=;
	b=X/42zBxjbdatW11BeZBnTTaD80z26A5ii1/XPwd/MSjYv0wfuJQfp1V0qduef7uS1MOlJU
	UowQ9qoOHXEF1bBg==
To: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: Re: [PATCH v3 2/4] irqchip: Add support for Amlogic A4 and A5 SoCs
In-Reply-To: <20250305-irqchip-gpio-a4-a5-v3-2-1eec70352fea@amlogic.com>
References: <20250305-irqchip-gpio-a4-a5-v3-0-1eec70352fea@amlogic.com>
 <20250305-irqchip-gpio-a4-a5-v3-2-1eec70352fea@amlogic.com>
Date: Fri, 07 Mar 2025 09:01:41 +0100
Message-ID: <87h64546ca.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Mar 05 2025 at 18:02, Xianwei Zhao via wrote:
> @@ -358,16 +385,19 @@ static int meson_s4_gpio_irq_set_type(struct meson_gpio_irq_controller *ctl,
>  {
>  	u32 val = 0;
>  	unsigned int idx;
> +	const struct meson_gpio_irq_params *params;
> +
> +	params = ctl->params;

Please fix up the variable declaration according to

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations

and initialize params right in the declaration. 

Thanks,

        tglx

