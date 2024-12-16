Return-Path: <linux-kernel+bounces-447620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CBB9F3504
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2511885D3F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D705614A095;
	Mon, 16 Dec 2024 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eLPC5Mtx"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC061369AE;
	Mon, 16 Dec 2024 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734364441; cv=none; b=q4HI/Wo7NnpM8HH06wLc0Ue4WCP9FwUBrOaYppCNxQ35C5jC075cUnlh64V1+NBYDyklwAHg8o0oR6ChoM+bfNRvWZQ2HoDKyxb2qkZeDU2npwrBKeg5cgos5Q4zNi6zMFP0U6dDporIse42N4buwULN0yfZpicCkbpuPnzSv0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734364441; c=relaxed/simple;
	bh=hAOgQmXw4nKeyqM8THp4aXFG6ACRF2AS3Wv29Y1DPGc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i45ZUQX2WdCMDRkkdZVu+/KKSnwzuW5J7G8m95R1rx5ZLc1XIppdI0kY1bkyXtFHyhJqsns4keYchJYyHBr4m4t0NwHR583AYxfomwCJFkpkQajyjK0UOFkPZ+Z1K6sJPLUninhT7WWLryjjH+b+knsx6qCWz9AhC3DxFOVGbVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eLPC5Mtx; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3A2F21BF209;
	Mon, 16 Dec 2024 15:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734364430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZuTRv0vuTZ0VwJUnE4hrLu3RN+h0ws0emLL1w4UELQ4=;
	b=eLPC5MtxucGs6C9aYXHpAlqhEfz1wsdFGZ1JzX1vaiuvk5pRwSaVQKU2lLOSsLFQE18gua
	1/IgTr+KSPcfUB03mc4kZN7+8pFjHPsVy/p+t1nRLQw/TlERLXH9Q4HODNSALgNm+mOb7O
	PUKU50LLlnq+TkncnOyu5S71QT6AMTQOf7WJmsmmMioQj45JfYakM2mVozxJh9cxInsimI
	SDffBlHhzAWlW0230I1MQckdmvQ6ZP5PknhgeeJiBmXXVRqILfya4v26NZtCi7zb55VGV7
	j1mhcTzzNGUfXkf9yDV3LK2muAZAN8sjEr5QQ2llMe6l64WJ3jOXYhCp59++3Q==
Date: Mon, 16 Dec 2024 16:53:46 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang
 <quic_jesszhan@quicinc.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Thierry
 Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: simple: Add Tianma
 TM070JDHG34-00 panel
Message-ID: <20241216165346.4b522b25@booty>
In-Reply-To: <egqtfrmretlglzhizdgq32bioxqtydcz7ftv7j6ftj2or6vhch@tre2xmuz3pry>
References: <20241210-tianma_tm070jdhg34-v1-0-9fb7fe6b6cf0@bootlin.com>
	<20241210-tianma_tm070jdhg34-v1-1-9fb7fe6b6cf0@bootlin.com>
	<egqtfrmretlglzhizdgq32bioxqtydcz7ftv7j6ftj2or6vhch@tre2xmuz3pry>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Krzysztof,

On Mon, 16 Dec 2024 11:09:37 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Tue, Dec 10, 2024 at 06:28:03PM +0100, Luca Ceresoli wrote:
> > Add the Tianma Micro-electronics TM070JDHG34-00 7.0" LVDS LCD TFT panel.
> > 
> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > ---
> >  Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> > index 18b63f356bb4bbf6d2c8e58b13ebb14c5f4004ad..30f655e82666bb1aa227edd26bd8d3621a39e74f 100644
> > --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> > +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> > @@ -281,6 +281,8 @@ properties:
> >          # Tianma Micro-electronics TM070JDHG30 7.0" WXGA TFT LCD panel
> >        - tianma,tm070jdhg30
> >          # Tianma Micro-electronics TM070JVHG33 7.0" WXGA TFT LCD panel
> > +      - tianma,tm070jdhg34-00  
> 
> So tm070jdhg34 or tm070jvhg33? Comment says one, implementation different.

My bad, I swapped the two lines. Apologies, v2 on its way.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

