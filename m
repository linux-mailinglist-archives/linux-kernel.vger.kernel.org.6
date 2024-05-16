Return-Path: <linux-kernel+bounces-180864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2988C7417
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4BC1C224E4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 09:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB9D182AF;
	Thu, 16 May 2024 09:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hn8zQ/kz"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6528E14293;
	Thu, 16 May 2024 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715852855; cv=none; b=lnEsVQP4/CjZQMDXFpPYvmcP4e4LQBxOPIVAktBzRSYU7TPqAKq/k02SE7aGVWGD/Rw0BOarwKJd6gLE3l+mzZX2mrJttbHyflUaYJ6aAJHf5/SToo01WxJtr2sgg9x1HMVv2wI90wfTPO8LsaIblBnfX3KSsDCDTGIgn9Uz4rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715852855; c=relaxed/simple;
	bh=cYaqKfnomG8lUr8IPdJmxle18BNsI60Y3vjjQzeloX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UsYRLgUWhiTEwpduF5mDPaCnCnQJLOucNxqtQXI8athiTkbD2S6DBRYfEfg1xzSzae/Mp+CTqttlctjda7bkdrnLBRQX/9TmcITOvmGcF6M/Homu+eEtdcW3n/S8kFZd+rICNzrFgrqPIMiUQ8HFc5nhkgOtOHmr9EmsHzAp5ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hn8zQ/kz; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc236729a2bso7711499276.0;
        Thu, 16 May 2024 02:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715852853; x=1716457653; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gUyknDd5G3O/kbXEyZ7lZAY8kzOAKHNxYeobg/F/UyY=;
        b=hn8zQ/kzqDlZ2qbaR/Z4KGexzz2x1N9IxnKfGXtxU3lJ5Fxfjog6R/zWIBkXLBSras
         NlBN5Wc/OzEUfo3KUNTf+PvUo/3oVEz9Oh27ZMFHzyl5bEA0f5Q8B3gM/JmlK8hxq/0I
         ucMng0aA9bkDeTfg0bwhYQi0j8+N8e/ucI0t9gt34xRSehfMEdZVjpX3RUokq6ABLBic
         K3ps+aYOfOkNngKRY01IoXp57l0AdCepOxGYOcXqP/iDmD0ycM4/UlQPihHSwojWzkfr
         ne8XFuT7+vvRhVu1z8c/Iet2yshUnx3+/TESqQE5s5c3ogdwQviQ5dLSg8RGw3u2m/rh
         6fGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715852853; x=1716457653;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gUyknDd5G3O/kbXEyZ7lZAY8kzOAKHNxYeobg/F/UyY=;
        b=wwXxy7DHHpk/sP+DO5AC0e5WyjpOXPW/M4LarsfuCzEb4iReiPi1AikM8LxW3C188v
         tYT2TlRVc6yYworXLZv781GcQl/13XN4MpPchuxGjsTFz8MOzT3424mmd5bOy+4/yTu4
         ecT64EM76yuw3ZNth2eyv58ieZRZ0n5bsYxLCmW+SjTdDilXj6VjeQTJK5G5y8W6TNZt
         9eWx06UODeJh2KvpZG/wuGiA4Alg22flkPAGTgPo/wcbX8meVBrQFy3NlnHY5y6ScdiT
         2WLgyjIKeUlqMVCS4eL0L464MjdSyTs0W8Rvf9RE8sBdAc697qt7TDfDrhGSpX8salhi
         bUDw==
X-Forwarded-Encrypted: i=1; AJvYcCVtOaKFb+SfEpxE+9T4s73+mwn+jquG8SFGZFvsfJ4Aydvymm7YLhZwnudGlZpC+kbGx0tRjR9L9dZ4zKeBGdUlvCulcXNJQolrlJAAF5+Ufu24syiK3Pkj2XKgZfVNSy/53ayXVdbpzA/xigdLYgHF5TFyUaVqlcqtSj1Pu2DVcVQYpw==
X-Gm-Message-State: AOJu0YxtfWj5vq5K3aXGBO8lDMCxs/V9o4ZUIcKrjLuuNX8P/4Y8Juzo
	0Tozg7ld1JwwBZfQ0b61XtPSArdX1n7VVyNiKuc2yvyUB+AQ+ODkakKXTmgI4Cao20oZNerqIfH
	hnj9I1o++peG08opSbg/D6DyT8vQ=
X-Google-Smtp-Source: AGHT+IEzJt0Z027kWGnPBHHjYcG3IHb+RCewZlXNuCwSPNs6kP35vwq1z5FEuoImbDDdfYqXu+c8znUsBxe1Ou0UEvU=
X-Received: by 2002:a25:b853:0:b0:df3:6f11:923a with SMTP id
 3f1490d57ef6-df36f11964emr3073402276.53.1715852853288; Thu, 16 May 2024
 02:47:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509192411.2432066-1-tmaimon77@gmail.com> <20240509192411.2432066-2-tmaimon77@gmail.com>
 <20240513155154.GA2595523-robh@kernel.org>
In-Reply-To: <20240513155154.GA2595523-robh@kernel.org>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Thu, 16 May 2024 12:47:22 +0300
Message-ID: <CAP6Zq1h4gMRcEsVL96OeggF9c2Eh-ZsXSQ5cTswEe_0ExeNTMQ@mail.gmail.com>
Subject: Re: [PATCH v24 1/4] dt-bindings: reset: npcm: add clock properties
To: Rob Herring <robh@kernel.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de, 
	krzysztof.kozlowski+dt@linaro.org, tali.perry1@gmail.com, joel@jms.id.au, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Rob,

Thanks for your comments

On Mon, 13 May 2024 at 18:51, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, May 09, 2024 at 10:24:08PM +0300, Tomer Maimon wrote:
> > Adding 25MHz reference clock and clock-cell properties to NPCM reset
> > document due to the registration of the npcm8xx clock auxiliary bus device
> > in the NPCM reset driver
> >
> > The NPCM8xx clock auxiliary bus device has been registered in the NPCM
> > reset driver because the reset and the clock share the same register
> > region.
>
> auxiliary bus is a Linux concept. The reasoning for this should be the
> reset block also provides clocks.
>
>
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  .../bindings/reset/nuvoton,npcm750-reset.yaml  | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/reset/nuvoton,npcm750-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,npcm750-reset.yaml
> > index d82e65e37cc0..18db4de13098 100644
> > --- a/Documentation/devicetree/bindings/reset/nuvoton,npcm750-reset.yaml
> > +++ b/Documentation/devicetree/bindings/reset/nuvoton,npcm750-reset.yaml
> > @@ -21,6 +21,13 @@ properties:
> >    '#reset-cells':
> >      const: 2
> >
> > +  '#clock-cells':
> > +    const: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: specify external 25MHz referance clock.
>
> s/referance/reference/
>
> > +
> >    nuvoton,sysgcr:
> >      $ref: /schemas/types.yaml#/definitions/phandle
> >      description: a phandle to access GCR registers.
> > @@ -39,6 +46,17 @@ required:
> >    - '#reset-cells'
> >    - nuvoton,sysgcr
> >
> > +if:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
> > +          - nuvoton,npcm845-reset
> > +then:
> > +  required:
> > +    - '#clock-cells'
> > +    - clocks
>
> New required properties are an ABI break. Please justify why that's okay
> for this platform in the commit message (assuming that it is).
will be done in next version
>
> Rob

Thanks,

Tomer

