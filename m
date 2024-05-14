Return-Path: <linux-kernel+bounces-178560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B368C500F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1681F21130
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC101386B5;
	Tue, 14 May 2024 10:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TA28sTl8"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D62320F;
	Tue, 14 May 2024 10:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715682891; cv=none; b=Hn6lWKgDJocCeF4u5/b/y3ll/bbfNXnI0PORFtz4pQu1JGdFlMlsOW71eylwRaTXTNmftezgKgKNL7ywxL6LHUz+Zs+gPcsy8SuOS3ho/lA6QTOUGXF9G68pArbUi0Fc1kA5q+QmX2p3H/lxPE/2Eqa9Q0vB4f0kbTmoMkeQQdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715682891; c=relaxed/simple;
	bh=TWwiNmIgzodg4vjdt4GkKt1IUIQV7RRqeSjjxHf7908=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LBnBrLk6EcunEnyvyYySHVj+nDlPk04FDd2JeVNPgDSM6b9VOehL6NOzXSE+vDNtJQeMU+G2xDohi1fFnzWO7jrCo4OyryGKtPAjvG+mtD0auewNUfs/kpHiUtGbPDcKfv/qu+6kFGPj2OXBbI5pRwH8fadZPU+vnHAMTGhaLsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TA28sTl8; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59e4136010so1395306566b.3;
        Tue, 14 May 2024 03:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715682888; x=1716287688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7trD0rDL4U7JA4p6IKLVIIlna4fm1L1zpyVjzxwMlo=;
        b=TA28sTl8F1V/h+L2Zg6gakOXLVbi2P7H/XW+Qgytke1xiovSnSm/LNsjT94QFe3N92
         zCgWEsjxXPKSZbBIWafAPtC08l0B2m4dDzDC469SMhaZ/WsqBderR1Il9v6reUK2Vxfo
         686OP1gqA65sS2iCS5ZgA6FF+OIH/oCndwykbti8Z8PaOmFluEIvWhXedsTpPeintn91
         nm4ks9xbaroMu1ugOc3FdCxSqDLqVsr1LvcqpSgHNilTzU8NuxT/i+HLqcIMkLkZI6je
         iBhAbqSjXekbYlwG5aNLRV8IdGcwGgypG2kYZ4vsyRIehUtbYq6OCKLSq1YuE55+UPpR
         jqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715682888; x=1716287688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7trD0rDL4U7JA4p6IKLVIIlna4fm1L1zpyVjzxwMlo=;
        b=MIA75hC8LodTakVwwL99uYX4Dls0gJghI8wavuuJNEKebzvMejrWvEnM+f+mFAbJ+7
         vjF6Jz70cS2fSo7lzbgSqYLB2lgm9av6FN1/QhcTOyBOofIiPT0xlSNunCDerBGz4pcy
         mnRdZTHxMAcTvMpsPUOLTUi5XhWvokumcXmjH4xdx+NwhAltl5JB7OreLCW2YCdLMKjr
         GGD3WGbnfzvNS9K+Wb1iC7xOqMQOk75QcaCMr+QU8N73uUjQvOHx8yP5rM6sCoYzAUe/
         qABmZa65dBz0o2IhoYrJsbK2SIdOKsIxRKSo/VGqd4ONNDjGz2qBOR7gLjtY0iBgJbZQ
         QKgA==
X-Forwarded-Encrypted: i=1; AJvYcCU9iidAlrzmO8wOzGRLxVeOhzNCpGVKbSqmQEyLsZ/gbff011RvpbNIEsV0/VFWy9yOHpQO5Rie6jUTcB2f07nVDkusITEB9pSMQuurfYLVfY7CKU16OxihN9OkCKZtuA9+kh96mFB2j8ahlHdkIjFKEcKSp355gsPNgxpIK2FNVHIvlv4f
X-Gm-Message-State: AOJu0Ywt3mA15TrHBDi66C9MccwhqDNfbg4//1UElnarxwCpJo0AKlbL
	WH6BMxGAVD93hQqRofTMlqAGF1ch4XZjCbfSNTl7MLsfsob1dyD65tWUsYf3
X-Google-Smtp-Source: AGHT+IF2/0DyNnYwDYAigKCEdRXmn4XP3gsRHlGPpr2+mdv/bs9kDusp8Vw8UqBhX/D9pnrRYpYSqQ==
X-Received: by 2002:a17:907:bb83:b0:a59:b68d:4604 with SMTP id a640c23a62f3a-a5a2d65f36amr744967066b.59.1715682888350;
        Tue, 14 May 2024 03:34:48 -0700 (PDT)
Received: from njaxe.localnet (host-79-55-54-147.retail.telecomitalia.it. [79.55.54.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a178a9d9csm704053766b.74.2024.05.14.03.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 03:34:48 -0700 (PDT)
From: matteomartelli3@gmail.com
To: matteomartelli3@gmail.com, Rob Herring <robh@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: es8311: dt-bindings: add everest es8311 codec
Date: Tue, 14 May 2024 12:34:47 +0200
Message-ID: <4196680.zEN4bpRDmC@njaxe>
In-Reply-To: <20240513184404.GA2805391-robh@kernel.org>
References:
 <20240510131238.1319333-1-matteomartelli3@gmail.com>
 <4072123.0gxhY3eTYf@njaxe> <20240513184404.GA2805391-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Monday, 13 May 2024 20.44.04 CEST Rob Herring wrote:
> On Mon, May 13, 2024 at 05:38:16PM +0200, matteomartelli3@gmail.com wrote:
> > On Monday, 13 May 2024 10.53.57 CEST Krzysztof Kozlowski wrote:
> > > On 10/05/2024 15:00, Matteo Martelli wrote:
> > > > Add DT bindings documentation for the Everest-semi ES8311 codec.
> > > > 
> > > > Everest-semi ES8311 codec is a low-power mono audio codec with I2S audio
> > > > interface and I2C control.
> > > > 
> > > > Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> > > > ---
> > > >  .../bindings/sound/everest,es8311.yaml        | 52 +++++++++++++++++++
> > > >  1 file changed, 52 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/sound/everest,es8311.yaml
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/sound/everest,es8311.yaml b/Documentation/devicetree/bindings/sound/everest,es8311.yaml
> > > > new file mode 100644
> > > > index 000000000000..54fb58b9ab58
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/sound/everest,es8311.yaml
> > > > @@ -0,0 +1,52 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/sound/everest,es8311.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Everest ES8311 audio CODEC
> > > 
> > > This looks exactly like es8316, except of later added port. Are you sure
> > > you are not planning to add port later, which would make both schemas
> > > identical?
> > 
> > I did not pay enough attention to audio-graph-port property which is in
> > fact supported and could be added as well. Thus the es8311.yaml would be
> > identical to es8316.yaml. My guess is that I should just add the
> > "everest,es8311" compatible string to the existing es8316.yaml even if the
> > two drivers are separate (like for instance mediatek,mt8186-clock.yaml). Is
> > this correct?
> 
> Yes.
> 
> > If that's the case:
> > * should the evereset,es8316.yaml file be renamed to evereset,es831x.yaml?
> 
> No.
> 
> > * should I also add myself to the maintainers list of that schema?
> 
> That's up to you. Do you want to be CCed on future changes to it?

Yes.

> Rob
> 

Thanks for your feedbacks, I will fix it in patch version 2 as discussed.

Matteo Martelli




