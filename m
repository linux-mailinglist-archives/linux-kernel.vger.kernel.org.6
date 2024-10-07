Return-Path: <linux-kernel+bounces-353135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 410C9992942
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD43EB228E7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934261C9B99;
	Mon,  7 Oct 2024 10:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="WmIZ72pb"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BACE18B473
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728297133; cv=none; b=qTYDQTvbWB4ydg5LadjwWvRK7Js4gX/WNa5I/ggFpfy5GyOqeMZ+XlPq/8VTjieFFlLFT2gHlN+e4jcw+UhX0FrGn5c0eMsNutRE/D1Gav6qow3d1WHxQZJA8ULjr6/jlrnfOa6WziggybFJ82i+bZfLNTDQVyyBrI7UvoL3Weg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728297133; c=relaxed/simple;
	bh=4BUOU3QnSe9dGH5JoK9BkTSTcts/bc1GoFyAUFX9VM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bf3h61rVOH6NPH7XQvZPeiOTeSQO/WTkHtY6oifIxw5gXILMvdysK8Hd3886cXV+pqXm5vGH3kJH6Bfe4523vVcqos7sDidjjhVUmIFG1VYPRvgJA7HUo6MyIHk6gTRnSdi0Fz8nVWgt8x9yjgzU/6kpkcwi3UW/xiDKxUjne/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=WmIZ72pb; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e0a950e2f2so3526271a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 03:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1728297131; x=1728901931; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7LvHP5fo67hgb9VcVRv0wFxCNn8LjWM9uhRHbO3WbUo=;
        b=WmIZ72pbhfWNdlE4a/K1vfh+oveHEgCbK8UgSEVFwx6kuNRZ/chfj0MD4M5kvsMHi0
         yVp7mjtkoGhafm45UIgMS/PFX8QIL1GhbZBFtGYPduA4ONLs/raOSO9K1/qVJcSEhlDO
         DRvP8NuzVFrd7gL3kFnpo3ihNS8C35heerDLYV7j+1zQaLK10hHqHPl/QZ31plliWFng
         c9D8QPHsqdDZSaSAYk0P/qnb2qrxFw7tsLWKpVJ6RnAPiWQ0H7o4m8DssDREObiFDHuC
         /2QVp0DbYCfPHWHXeGaK2annlgh3yL6/mJuCfd7X5QMioN+fB7LH60BGSqT7osuUc9fn
         xZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728297131; x=1728901931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7LvHP5fo67hgb9VcVRv0wFxCNn8LjWM9uhRHbO3WbUo=;
        b=O47Ct1RB7lXwxL3JaZ1O0IFO9gZI4Uy8PsNqo5xTdaojJxmCHY6/bxGyHUSl/AkTJV
         PTcNTpZe5ihwlmyUHIApi82IKdSiyG9nVjfrJg5J+Iw9px/7pix69GOif39/q7kK58Yt
         u2LhC5xiZz6hfA4PqxLowdufZtJljKA0xf+W3mKGki8oufK56MziiVVlkUpS+wvNQrFV
         3vXAh+Q+tPh/T6QIPXgfTXIPrKpiBO6bhumGKRSU9S0Y2loj1qGZa2vqKXKG7qmpuBY1
         Rq+/EpFq+7d6vzpUuv46ONO9mOGja+PqMFQpWKlIrHThTmXsOXlUa2HGmV3Iw6P1vJLA
         AnwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLnYumZ80f+aG66XBi0mlYJZIErFJwmI4pZortG89FVxyep/SKQpUm88x81Nv9+dujpELzHNdZqAnIxZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4cNNlY4PhgSLmqVCyqJRjRzlwwxMV633Xz8KxMeSJAno5kOZe
	6qImA+0bNfb5GdryrAUPnqHDBhMSnZyQU/LL+tnVVWhjRgb1DWc5Y1jzvm1b6uhHfOmvWEu+2n/
	N3np7UHVqnQ41z4vM7feeN1cUsPRuYAhK9wrZ9A==
X-Google-Smtp-Source: AGHT+IFTY63/DLU3Wj2tdaOKPpjw15exbuhnusAMK03pLzADjpWiknDc5KMRIELZ+sDZO65UzW0pNLJlWGwyqrOMhuc=
X-Received: by 2002:a17:90a:8a91:b0:2e0:80e8:a319 with SMTP id
 98e67ed59e1d1-2e1e63bf55dmr12819746a91.34.1728297130812; Mon, 07 Oct 2024
 03:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002084023.467383-1-naresh.solanki@9elements.com> <xuczpa6nrxjwo7hjn62ehblnzc5twupghbg4uuwp5vfczw3gmg@x23yhbxjccpy>
In-Reply-To: <xuczpa6nrxjwo7hjn62ehblnzc5twupghbg4uuwp5vfczw3gmg@x23yhbxjccpy>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Mon, 7 Oct 2024 16:02:00 +0530
Message-ID: <CABqG17gbXGRBDHzt8-rt6_n+37oMhjmJGxCLEqqM48GjMrKNrw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: aspeed: add IBM SBP1 board
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof

On Thu, 3 Oct 2024 at 13:47, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Wed, Oct 02, 2024 at 02:10:17PM +0530, Naresh Solanki wrote:
> > Document the new compatibles used on IBM SBP1.
> >
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > ---
> >  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > index 95113df178cc..8c04d6eaec08 100644
> > --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > @@ -89,6 +89,7 @@ properties:
> >                - ibm,everest-bmc
> >                - ibm,rainier-bmc
> >                - ibm,system1-bmc
> > +              - ibm,sbp1-bmc
>
> Keep alphabetical order.
Sure. Will update in next patchset. Will also include Ack-by for the patch.

Thanks.
Naresh
>
> Best regards,
> Krzysztof
>

