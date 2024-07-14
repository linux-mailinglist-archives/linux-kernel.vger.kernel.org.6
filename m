Return-Path: <linux-kernel+bounces-251777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1A093099D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 13:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074BF1F21623
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 11:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF6153389;
	Sun, 14 Jul 2024 11:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOTGbPPY"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66872B9AA;
	Sun, 14 Jul 2024 11:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720955417; cv=none; b=b+VDq4pRS00G1pcksR6NO63Lv5vqN6s0w2MbTnrDcDgSnyEx1t9vHc7Iwwvu07NqdhESkvBfF1pmzYgElBdRLo8hGglOBlnB9SosoLx8IkniCpBI0ifKbaKSbQjjbKTloEmSl5jMD99q0UJYr1oQKZx3Z93R+xcDsRTamY68yzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720955417; c=relaxed/simple;
	bh=dw3P4PCiNo28KxqUHYbTlLtWFLteQxiFmy7SCpHxLmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdgM/dSuQDoJbQcbTFGwwjRKiXnGUlYNXFSDd8T/40qV9zYW/zsfgghTD0IZczHFiy/uPFcPgZppkKZ0qqNzBDJvFPJK/evwd4KDWL/6jLMtPlFkCJDC/cLHsspJPXFS7kxHGEcMWWUBJoI8Y5BomwdTJM7RTDsCYQ7gidBcyk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOTGbPPY; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so45584661fa.2;
        Sun, 14 Jul 2024 04:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720955414; x=1721560214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FeRfW8ykei9dTQMP7xkuDaTaPMGVNep3B5L1FGSBjOM=;
        b=aOTGbPPY9vV3asrIfEf1toKUAQZgZ03wSKATxPV7zNbKlG61EG84xiZqflwAgbnyNN
         70t0xMjvVVJJGZxJMLDRSlk7xAFFEeDkwJ47TXaNKrNlUoUu6Pc9EyK0Yam5OBFiHgFM
         ECW44EAz40LAjXem1x/stowaNWXJ9fp/WREErzdD99j+F0y8tojtjdMmjVmFrD2wGdb0
         x5G9mQp3ZRHJgsDCi/adBIE2Ai8NFrg0zlnCLw/J2VFCO0x+P9RSFQzd6EKmIjzD4Uvy
         nYmiyNfj4ZtaIpxNVS/IdVXrKQFyfR6EDCq0bbiAR9ehdT68WOivQopsQY6jUKUr4+EU
         uMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720955414; x=1721560214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FeRfW8ykei9dTQMP7xkuDaTaPMGVNep3B5L1FGSBjOM=;
        b=PpQJ3b+7pjsCYEGeCfWYhsy1OJoinQN3qsip/bgLxtyI4A3K9IVuiB6omLNPDR/Eih
         FXKuvYXrvqxNYdQGJG/DgVAzez1sMNMPXXY76AFS+CBMKuvQrpADih7cxQqnA9XZ6+yg
         qMQhHWD4P6khOq3Q97sQfIfcqiWC8dh5SPOHWXPakl75bENnnJKD/JJlRFzM23Aqvfiy
         efLwxFwQ3fKLhSmXm2OtwJ6gY7cOm6vJCTDkBhAelUaMCQR5pQ2/s+c0JbC5izFRNWgU
         t3P4yTZp13W3ZVBW7m/rWwty/igm+5Pb/N4G8sbNkTsDrle4rat2i4mTQ4LWaEHSaXkB
         rDPw==
X-Forwarded-Encrypted: i=1; AJvYcCXfgQc3NelKfk/2Gy1CxxnS58IFl2YusfqavJWqoaYgsJxIqMhKTZxvdqViEa3nV2mtK8vW0O0R19YS5GjkppUdR7geEzO2ZgjcUrR8UxBoCml2ZEIbJgJhLeGO+R+ZZEfoyr0WP2aZkQ==
X-Gm-Message-State: AOJu0Yzco9Nqn/TiEVPuAvNeWXOMhkWJOITHP1JfMOVfpPUSEbm0Ohkz
	whhC9RZQ4ywesKBqF947l+YSOaiCSyTKA5Tk6YnexEIw3i4Qv4W1
X-Google-Smtp-Source: AGHT+IFMohqqqj35LclUgNBfikoxNANOB5LaueXhnM/9SpNv72iEZ06nYpsvp+wYCFvQ+9gpCoxgDA==
X-Received: by 2002:a05:6512:1256:b0:52e:97e5:a9dc with SMTP id 2adb3069b0e04-52eb99d3de1mr11253933e87.65.1720955411617;
        Sun, 14 Jul 2024 04:10:11 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5edb525sm48117015e9.34.2024.07.14.04.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 04:10:11 -0700 (PDT)
Date: Sun, 14 Jul 2024 13:10:09 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolin Wang <baolin.wang7@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: nvmem: sprd-efuse: convert to YAML
Message-ID: <ZpOyEWwj/HwQv7n3@standask-GA-A55M-S2HP>
References: <ZpJvRePtbaiG94Te@standask-GA-A55M-S2HP>
 <7a419156-d2eb-4810-9281-dc3414320ad1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a419156-d2eb-4810-9281-dc3414320ad1@kernel.org>

On Sat, Jul 13, 2024 at 08:31:31PM +0200, Krzysztof Kozlowski wrote:
> On 13/07/2024 14:12, Stanislav Jakubek wrote:

[snip]

> > +allOf:
> > +  - $ref: nvmem.yaml#
> > +  - $ref: nvmem-deprecated-cells.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: sprd,ums312-efuse
> > +    then:
> > +      required:
> > +        - clocks
> > +        - clock-names
> > +    else:
> > +      properties:
> > +        clocks: false
> > +        clock-names: false
> 
> Half of the binding is this "if:", so I would say they are not that
> similar. I think it would be easier to read them if these were split
> into two bindings.
> 
> Best regards,
> Krzysztof
> 

Hi Krzysztof,

pretty much this exact if-then-else is described in the "Writing Devicetree
Bindings in json-schema" documentation as a "typical case" for its usage, so
I went with that. I think that it's simple enough that it only minimally
hampers readability.

I admit that there might be some confusion, since I forgot to include an
example for the sprd,ums312-efuse (i.e. with clocks and clock-names).
Could I just add this example in V2 and keep it as-is otherwise?

Regards,
Stanislav

