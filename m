Return-Path: <linux-kernel+bounces-274240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BAB947587
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A65AD1C20F76
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 06:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D726F1474D7;
	Mon,  5 Aug 2024 06:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IXLmoly7"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBB64D8B6;
	Mon,  5 Aug 2024 06:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722840229; cv=none; b=nXMc5E8JnJ3YAVmyZVHZvKOPrje0SmhVHayY5mq4e17glWw8Vy0mSkGh28v3dg9apx4PZgqq6+VBM02yxfSNTlprdtJbTqWgNItl0EAVM9yDWyPKRrOBg7enzPzYdbi0e3/EooSLsxSGDJJCzGRYF1j+2/T+orm8tFENogwxh7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722840229; c=relaxed/simple;
	bh=QZQSy8ZoYUWUP29f66OnozoAOdOuxCvkn0ehOIdqK7k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m15nX2stkBlnJah956fbdfVT0QBnF3l06VChyIt77CQjdETn4am7aGebz5YIvrRtr+HP/3R/a9pAYogMlBvznpMMG6pSgh2aUYF5cTEuZ5aP9fcqJuG+ok7nWwD625pccn8liulI4XjCUAMENyulSIkj0DxNif+bLI3ouC5TFF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IXLmoly7; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BFDDC1C0002;
	Mon,  5 Aug 2024 06:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722840218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s6fMI2V+iIFbdGWfpib0kcCfB4Ujnw6ekS2SGu24ZM8=;
	b=IXLmoly7c+mkZ12TUUfRtD0urpAI6pYYj6CpO3u/i0qOFDFoRxuqZ0HC1OjG7eH85J9rTo
	x0d0IAx+cNPoQhJ6Xr60DHpi6DNheT0MYKzydw30FNz1JF1C4ukhseAtn+cnJpIT+pTqwu
	e/tvCO6s8fohLAxRwb4JaCP83KjGXCI5tAGwN/aYP8Ur+1Rcu73wDaX1I2xRI73LOiYlwP
	1snstTXoGK6K9zVE9UmDw8UELLwGpUmAlwh+qx58+ovo6AVfq20bqeRoPWyuwfg0ExluoI
	DD7qWBxzZgHtKOtnvZU3/ASkSEvjgFG1aEhBxaqNgAKRtb4STCjEwkHpS85sKg==
Date: Mon, 5 Aug 2024 08:43:36 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Qiang Zhao
 <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>, Mark Brown
 <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v1 23/36] dt-bindings: soc: fsl: cpm_qe: Add QUICC
 Engine (QE) QMC controller
Message-ID: <20240805084336.4e711102@bootlin.com>
In-Reply-To: <20240730193635.GA2017245-robh@kernel.org>
References: <20240729142107.104574-1-herve.codina@bootlin.com>
	<20240729142107.104574-24-herve.codina@bootlin.com>
	<20240730193635.GA2017245-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Rob,

On Tue, 30 Jul 2024 13:36:35 -0600
Rob Herring <robh@kernel.org> wrote:

...
> > +
> > +patternProperties:
> > +  '^channel@([0-9]|[1-5][0-9]|6[0-3])$':  
> 
> Unit-addresses are typically in hex.

I thought it was more related to the reg value.
In our case, the reg value is just the channel number from 0 to 63.

Should I change to a hex format?

...
> > +
> > +      compatible:  
> 
> compatible goes first in the list.

Yes, I will move it to the first position in the next iteration.

> 
> > +        items:
> > +          - enum:
> > +              - fsl,mpc8321-ucc-qmc-hdlc
> > +          - const: fsl,qe-ucc-qmc-hdlc
> > +          - const: fsl,qmc-hdlc  
> 
> Really need 3 compatibles?
> 

The QMC is handled by the QUICC Engine (QE) companion. The QE can be available
in several SOCs.

The first one is the exact device (SOC MPC8321 + UCC QMC)
The second one references the QUICC Engine family instead of the SOC.
The last one is the fallback one just referencing the QMC. This one matches
all QMCs whatever the SOC and the companion.

On QMC handled by the CPM1 companion, we have these tree compatibles:
 - fsl,mpc885-scc-qmc-hdlc or fsl,mpc866-scc-qmc-hdlc
 - fsl,cpm1-scc-qmc-hdlc
 - fsl,qmc-hdlc

IMHO, I think it makes sense to have the 3 compatibles.

Best regards,
Hervé

