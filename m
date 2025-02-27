Return-Path: <linux-kernel+bounces-536692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD92A48310
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45FBD3B5838
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866A926B947;
	Thu, 27 Feb 2025 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmUnHW2M"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EA625F790;
	Thu, 27 Feb 2025 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670479; cv=none; b=GBkRG5tcftJLjOIVx1qURLlSAL9Vn3fDPPAOVMmJzVqbGSsAPY+jwlfiXnGXMeaX4q89uWKljy4/vZVGYmgR0Yj3uu9CigTt5YCFi09iPgeA4a+J7+dEHPFC/E4u4m52iymSDCEKv7xYqdpoDSWhwTlCIdYjdccafKGyAngkUTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670479; c=relaxed/simple;
	bh=DQnmkPIeP+h+BKqiIj4ecZCJn0/Q8dv3DMXJ+8RRyTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGkZYiDYEw6XZzJUjO1WSEghh+SxNR32b1oS49YLjAJH/NAPVYg2N09zO0IDXKI6FfeCy0kbWboYU7nUGbn1jimVOBrlI2AksO6kC8XyLciXSm24gCqBzO5V+/KBtzDuINMoDZNyvIm70LB1k72/WzZQjXWczKTZON7pbBIb214=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmUnHW2M; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e05717755bso1493462a12.0;
        Thu, 27 Feb 2025 07:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740670476; x=1741275276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ewW7lGzv9EKdBq0S1qPivXW2ykucSSmJzJOK5QaGs54=;
        b=XmUnHW2M0SVadVvfdCgsiXCOSkhlGm76BJ/VO8nbZVlGv1u0zrg+gUCKdXhdlOtth0
         iWs4ynGV8vu7u1ugB6nL+YQOBJxUv/UPBGk8XGgH5DaN/yLTrAcaYTpXdqhFA0kdIqsG
         2Nd1l8+7Oou19iYZsxzJS0xaZSAXtt1UaFZmbWGlTQJRc5HApr29ldi9FGotoWiMgtMA
         miLwEQLSvbokZpskr/e1ACbeBwn69UoxaXFV2t5RFzHI08je9JNF7mm4TZVdzgT9lPqP
         iRapOx8cTDCuI8XS+TMEfdpMvxsAji27cbHeZltq/1Y2YB7K6CjeR8NDtMlINbKXfOsO
         itaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740670476; x=1741275276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewW7lGzv9EKdBq0S1qPivXW2ykucSSmJzJOK5QaGs54=;
        b=JGRCDP/mKSYlNrXwyyGbSa/IqbAHDwxmI+bkc5PyJyP5hf7Moz2ffSpCF1x1CVZ6va
         zmYaKBiPKLsKTQjYopyYJGJaqTZrJ9OKbGTerm4KWhv7m7Xs/vokjNLyrWrgldALTr4U
         mBwC+SS5HSQU9cuCTIQGYfB0Re/quhcXd8KrAfxYP9YxmhV0iVCHDszcoLaa4Al/zA4h
         CE+FOF5lHeeN4Xqm/KJ1isS/xIIGL7BoN3OE1guIaGBoZUT6RrZ55q5DyiFyutiTWTiz
         8yvwY1J6XMaFp9oQBAWOPFHqogZiyw4UONPP590pHjkEO+so3p/puwzVPKHmkSJ40sD5
         5anw==
X-Forwarded-Encrypted: i=1; AJvYcCVnBsE9/1eMmQePu+3MXf+Fluuxh67t1VSvFl8kQJTAS/sWm7Tpq0wQ9qpXcQ00czFZDkDZ4rNBksQD@vger.kernel.org, AJvYcCXPaIarWsPTjsbd4TULP9/eie2lclRi/X5KA6AR4jpSFyRKo70Ju7Po045RySHOD7HfC060z75y/H0bV3Q=@vger.kernel.org, AJvYcCXydoK30g7JzDbIfgvoyA7Iwc7cQfmQ61ZxucA07n/4+v6Te7Rk5/8s19Xbenlcftye5TTNp6xAZHGz32gb@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1W7kYPtjvI9R3h0YUmGq5JYAS0XQwWh0LXCKOuknJWct7W4jf
	K9+7MlnMPMHUtJBHySunc+8HR0QFWn31h9+qJ58T760te0EYi8kI
X-Gm-Gg: ASbGncu5iKhrsyhq8ORi7uTN7zjl105gFxcK0lZXNDBSA180jcKkzUOaW8LqxPh2zT9
	/ZfzUmQq/M0uOLtR6mDM3e2WbkCUvmCnjFYJ3UwoDdriu7HRl0vX1VvW8wQrN++quef5ywTfMek
	roMy3vJwYyMssW1SBUR62Edc0qFPxQCWuAuj7vFwQYVbWlCQcQbihtdyt9HrF3aNMvHb+oyRX1b
	yKltGxvbU89gJxMbiFB/Ed+jQm03hpOZpsE9v3az23QrOf9XnKrFreEUYnQhZnon+2qwBhbbb+2
	LU9mZsx+6JDjz/BDLywC2vMfr/sKztSEXCnBPk3z2+Ue1byvymHYZ1mabFGEaYhBnTQ=
X-Google-Smtp-Source: AGHT+IGmrWhI9xTnk7myNMS3P04pOgJ/Z6LmnusFuC663a0RitJlSrAiSvhowBBSOpwB/vXXwAkdtA==
X-Received: by 2002:a17:907:3d8f:b0:abb:db78:a24e with SMTP id a640c23a62f3a-abed0d3b4camr1447316766b.23.1740670476128;
        Thu, 27 Feb 2025 07:34:36 -0800 (PST)
Received: from ernest.hoecke-nb (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c75ff0asm138782866b.159.2025.02.27.07.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 07:34:35 -0800 (PST)
Date: Thu, 27 Feb 2025 16:34:34 +0100
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	patches@opensource.cirrus.com, Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2 3/5] ASoC: dt-bindings: wm8904: Add DMIC, GPIO, MIC
 and EQ support
Message-ID: <er4bcixggriqp6idl6xmr7bjetf5kkhadyeplkbyxvrffuiknc@ews752x4ugh7>
References: <20250224155500.52462-1-francesco@dolcini.it>
 <20250224155500.52462-4-francesco@dolcini.it>
 <20250225-delicate-tortoise-of-management-e43fa2@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-delicate-tortoise-of-management-e43fa2@krzk-bin>

On Tue, Feb 25, 2025 at 09:41:17AM +0100, Krzysztof Kozlowski wrote:
> On Mon, Feb 24, 2025 at 04:54:58PM +0100, Francesco Dolcini wrote:
> > +  wlf,drc-cfg-regs:
> > +    $ref: /schemas/types.yaml#/definitions/uint16-array
> > +    description:
> > +      Default register values for R40/41/42/43 (DRC).
> > +      The list must be 4 times the length of wlf,drc-cfg-names.
> > +      If absent, DRC is disabled.
> > +
> > +  wlf,retune-mobile-cfg-names:
> > +    $ref: /schemas/types.yaml#/definitions/string-array
> > +    description:
> > +      List of strings for the available retune modes.
> > +      If absent, retune is disabled.
> 
> How is this retune supposed to be used? If by user-space I can easily
> imagine that static DTS configuration won't be enough, because you need
> to factor for example temperature or some other minor differences
> between same boards.

This is intended for integrators to be able to specify some EQ options,
mirroring the previous behaviour that was possible via platform data.

I expect most users to use the first five Retune Mobile registers and
not care about the rest, which require a proprietary tool and are not
well documented. The example in the binding shows how some simple
static EQ can be configured. Anyone interested in the extended config
can also use it (statically).

If someone requires dynamic behaviour at runtime that could be a
separate patch that should not be hindered by this static config.

> > +
> > +  wlf,retune-mobile-cfg-rates:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> 
> Drop
> 
> > +    description:
> > +      List of rates for the available retune modes.
> 
> Use standard property suffixes - hz or whatever is matching here.

I will send a v3 later integrating your feedback, I have renamed this
property to wlf,retune-mobile-cfg-hz there, and dropped the "ref".

> > +
> > +            wlf,retune-mobile-cfg-names = "bassboost", "bassboost", "treble";
> > +            wlf,retune-mobile-cfg-rates = <48000 44100 48000>;
> > +            wlf,retune-mobile-cfg-regs =
> > +                /* bassboost: EQ_ENA = 1, +6 dB @ 100 Hz, +3 dB @ 300 Hz, 0 dB @ 875, 2400, 6900 Hz */
> > +                /bits/ 16 <0x1 0x12 0xf 0xc 0xc 0xc>,
> > +                /* default values for ReTune Mobile registers 140-157 */
> > +                /bits/ 16 <0x0fca 0x0400 0x00d8 0x1eb5 0xf145 0x0bd5 0x0075 0x1c58 0xf3d3 0x0a54 0x0568 0x168e 0xf829 0x07ad 0x1103 0x0564 0x0559 0x4000>,
> 
> See DTS coding style.
> 
> Best regards,
> Krzysztof
> 

Would the following snippet be a good way to handle wrapping this?
To me the first six registers form an "item" since they are the most
important, followed by the next 18 which belong together, but I was
not sure about the common convention to handle wrapping such a long
item.

/*
 * Config registers per name, respectively:
 * EQ_ENA,  100 Hz,  300 Hz,  875 Hz, 2400 Hz, 6900 Hz
 *      1,   +6 dB,   +3 dB,    0 dB,    0 dB,    0 dB
 *      1,   +6 dB,   +3 dB,    0 dB,    0 dB,    0 dB
 *      1,   -2 dB,   -2 dB,    0 dB,    0 dB,   +3 dB
 * Each one uses the defaults for ReTune Mobile registers 140-157
 */
wlf,retune-mobile-cfg-regs = /bits/ 16 <0x1 0x12 0xf 0xc 0xc 0xc>,
                             /bits/ 16 <0x0fca 0x0400 0x00d8 0x1eb5
                                        0xf145 0x0bd5 0x0075 0x1c58
                                        0xf3d3 0x0a54 0x0568 0x168e
                                        0xf829 0x07ad 0x1103 0x0564
                                        0x0559 0x4000>,

                             /bits/ 16 <0x1 0x12 0xf 0xc 0xc 0xc>,
                             /bits/ 16 <0x0fca 0x0400 0x00d8 0x1eb5
                                        0xf145 0x0bd5 0x0075 0x1c58
                                        0xf3d3 0x0a54 0x0568 0x168e
                                        0xf829 0x07ad 0x1103 0x0564
                                        0x0559 0x4000>,

                             /bits/ 16 <0x1 0xa 0xa 0xc 0xc 0xf>,
                             /bits/ 16 <0x0fca 0x0400 0x00d8 0x1eb5
                                        0xf145 0x0bd5 0x0075 0x1c58
                                        0xf3d3 0x0a54 0x0568 0x168e
                                        0xf829 0x07ad 0x1103 0x0564
                                        0x0559 0x4000>;

Apologies for sending the broken binding. I have integrated the rest of
your feedback into v3 which will be sent later. Thanks for taking the
time to review.

Kind regards,
Ernest

