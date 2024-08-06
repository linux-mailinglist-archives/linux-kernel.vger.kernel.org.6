Return-Path: <linux-kernel+bounces-275790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091A59489CD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99D6283E31
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 07:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B8716630E;
	Tue,  6 Aug 2024 07:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UFXjdAQl"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826F615A4AF
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 07:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722928286; cv=none; b=ZNIYR5WiKW84EJAlnU17wljrUoMg9KpaQ7+wrsvzihAe3kROR+v0dvYrP7f32VS8xaLpUDJTLwymc0dvn7WgPrwRNqa/S0zBRq7qYzi+Vp1JUDPD3iPBd15F5+eoOgXa6HmQggCYF29JmUqtSRtHPkpVhfk66dRA7O/LRAvsRs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722928286; c=relaxed/simple;
	bh=tI4GU1v0QP1BZY9ysqmo/Gml1BncwN7bO6CnKE4Kx0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsqKkiPSFXy5shjJ5Rl5p80pfGjTH/kYQ2NwkluBMrIbtYwTzhuOcLI557b4UBijIMxItHhANSDD5RrG5AphHStvUZJNtBqgLcTQEW2V47SNojALMnMupYmIWwOC518xN18R76ZKHV2MxbBMGAAjJTsApPYxusMMK0OMWwriXUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UFXjdAQl; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7093ba310b0so74764a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 00:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722928283; x=1723533083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+RIwAsXuYk0edOHoe4kpP9MzqspTUeWNsrK1ZVKFbGY=;
        b=UFXjdAQl86GvXoSttkdPmwY9I5/L3706ZsaTb/AOMIvQi7W+cESzs013vkI9duONzl
         JBPJTQKeUzMfctRxK9v36xx9K/JRx+VuVUG7XnoPiU2AVUd6Fef7JQr5ulkOfoJJvM1t
         jjS+FgAdsCBY6tf4pbWBxxCQyj2fN2ZscVL/dnwUk7lwg31vjuMPKDfoBcf/SXc5+nA+
         ghnZ4v+xv1WwgfQfyh3rZnOPrAriCd7OFvXJXwiBLXH7c60Fsjyd3Nms/dCnEq6DaQEP
         YMRP80Syk38MCxKMBpSEctSwTqi0flnAgCLkMuf5EDFBbELImB2GzuTRbz7KY6Pz7d15
         lyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722928283; x=1723533083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RIwAsXuYk0edOHoe4kpP9MzqspTUeWNsrK1ZVKFbGY=;
        b=TpUMGIJQ4WN7aqD4TOPeHVBTwlmocLIOirD16bSfojumZlcReauzjXJ0XvIjccfsNp
         IrakONQHNjzNaV/2c94s1G5MofppADVFofjfvtgQmWnSGwzgLTX41TFMcY2DG7qXR2eo
         j3zU6EEQ2q44PutDhb0UxeYt6I8cAnutsZFFw6PgKjJo97niiuWkRkzA1v3aWTZzx/Qv
         zSLRIT48tAb3ZAng+JsdnRFXm4qaErlLCalzKJTOxIyGz5RHI3GmpPipHWlWJL/L81W3
         CvQjoc1qMB6EMsHLVCwDoVigj3QXycvYQ4JO+e4lrnU5HOP8cPSuQuLm3vQp5vDj0plJ
         5NiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvZxz6IbKJGUJCgY2cBvka/S5w98WsT9UwoYYiFlqCEkvYwg2DQymp0is68AE3c07IxoUlo8Z28a+jWOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/HXzIwybFd17g4ISZr0+oLmeeR6ZaxQsymRR3uPQJEnp3dfAW
	px/vU87+toWfIBuBnVazLTHzcLI+ZlcnhIehOx2FYW8YJfEtqRn4HPfikJ8m4NQ=
X-Google-Smtp-Source: AGHT+IHSQuAwc0wlZNEeglWdrw7pWA5jRN0N68RGv0ULUvD3zjb0b3ayQd1IJeatJgykr4Yyu7MK5Q==
X-Received: by 2002:a05:6830:6e19:b0:704:8660:2672 with SMTP id 46e09a7af769-709b996e591mr24753888a34.25.1722928283617;
        Tue, 06 Aug 2024 00:11:23 -0700 (PDT)
Received: from blmsp ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d6a3ce83sm2098387173.123.2024.08.06.00.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 00:11:23 -0700 (PDT)
Date: Tue, 6 Aug 2024 09:11:19 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Vibhore Vardhan <vibhore@ti.com>, 
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: ti, sci: Add property for
 partial-io-wakeup-sources
Message-ID: <ti4ffymrixcpptlrn3o5bytoyc4w5oovdrzgu442ychai2fjet@wtdhrmwrozee>
References: <20240729080101.3859701-1-msp@baylibre.com>
 <20240729080101.3859701-2-msp@baylibre.com>
 <f0f60af7-8561-433a-a027-811015fc5e16@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f0f60af7-8561-433a-a027-811015fc5e16@kernel.org>

Hi Krzysztof,

On Tue, Aug 06, 2024 at 08:18:01AM GMT, Krzysztof Kozlowski wrote:
> On 29/07/2024 10:00, Markus Schneider-Pargmann wrote:
> > Partial-IO is a very low power mode in which nearly everything is
> > powered off. Only pins of a few hardware units are kept sensitive and
> > are capable to wakeup the SoC. The device nodes are marked as
> > 'wakeup-source' but so are a lot of other device nodes as well that are
> > not able to do a wakeup from Partial-IO. This creates the need to
> > describe the device nodes that are capable of wakeup from Partial-IO.
> > 
> > This patch adds a property with a list of these nodes defining which
> > devices can be used as wakeup sources in Partial-IO.
> > 
> 
> <form letter>
> This is a friendly reminder during the review process.
> 
> It seems my or other reviewer's previous comments were not fully
> addressed. Maybe the feedback got lost between the quotes, maybe you
> just forgot to apply it. Please go back to the previous discussion and
> either implement all requested changes or keep discussing them.
> 
> Thank you.
> </form letter>

I tried to address your comment from last version by explaining more
thoroughly what the binding is for as it seemed that my previous
explanation wasn't really good.

You are suggesting to use 'wakeup-source' exclusively. Unfortunately
wakeup-source is a boolean property which covers two states. I have at
least three states I need to describe:

 - wakeup-source for suspend to memory and other low power modes
 - wakeup-source for Partial-IO
 - no wakeup-source

If something is a wakeup-source for Partial-IO it usually is a
wakeup-source for suspend to memory as well but not the other way
around.

This is the reason why I added a property that lists the devicenodes
that are capable of wakeup from Partial-IO.

Best
Markus

