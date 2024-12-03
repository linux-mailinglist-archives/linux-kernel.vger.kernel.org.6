Return-Path: <linux-kernel+bounces-429243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE2A9E1978
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F01282288
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975801E25E4;
	Tue,  3 Dec 2024 10:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OiQ4EYKB"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADA21E0493
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222256; cv=none; b=Ux3G6IB9qyDISoMFoGyiW+WLfr3ZoHUTExSBYbsUah5FeRdabtk+fIqm2iUg+ACF/30JLKKdzdyYOeoMZu/jqqhUfX5Zc3+qENyE2RQZaMyrirsJgm9lRdF8Zdf7/DZ82XNCCsHdZfOhr4t7b3t79NP1rm5YRM9bkBf1LNDOsVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222256; c=relaxed/simple;
	bh=+R7vJwnPN7TZBrcDtH1Pjz7Gzm8FFyIULIy2HXvkRK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNa6vk6P56ZVmRJqyyPiicw4lk+LJ7uIWqgQ6qTCObVNqfoOK/6kbZsJSvufCpHs9f0XGeDyMd5f9dJ11vmxHxh70DQhJzBgQWBY9MCaSK7rbFpVOXMKBNbyYKWTmeuq0/6XBjr31dH9l5zKLMnN1PfLnQZV9dPkHdR0MwQC+VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OiQ4EYKB; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e38df4166c7so4423581276.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 02:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733222254; x=1733827054; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sPnwihfdsbfkm/uP14UR3jKNdvWL6NNpvOvZqmBYmGo=;
        b=OiQ4EYKBO06/1lE8xEkyaSRHsU5flCyEJToxmD7p2iClLZPHLvQjuARFuFEs+Q1KMz
         +NOSrnN9my4RbXhDsiiScwm2ynQ4uptLHz59T+5TF4g9NaUCgfFDaOVLamULxXEOjZ2t
         XhqrFqpF/fi8It823oV8jrg4iHmVE5PJnEnrKc+CuJ/IkfSx+CbL6iM+g8DFm5wJXA+x
         Y1EunYXL9ZCcdMSuXLnh2Rj+JhaEfz1zDZOtjlclIwseVI1qIrCuT4YoWNIUfJzfDhjp
         bAjRh42xpQBdO23QoagJrBO2FtcD680ojhX0qeanPTnbY8xwBezO57OPaIGPfnce7K9s
         JR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733222254; x=1733827054;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPnwihfdsbfkm/uP14UR3jKNdvWL6NNpvOvZqmBYmGo=;
        b=AvDdt2+5DPJWwQim57JAE4oJtVN6QHTa5ZjZhxJ5ZF1thsrDbwsLbqqx0GVpT4kDXd
         08hW7IBsoKo3WxO3YPDG4NrQ7i/9ZnO3uxfuyxiHk+6w8Vct6cLRVmZ8AY46mxArzKyH
         EQn96FGOM388Ml/j38lZMQ2eoE4cBFlEkCIHP0dg6V+m7u9vn7IquZw6OnC+6lhcfOFU
         OIPc4GeC2c1stBd0skfTrZHA8pBP2Waj6HTfDzUDWVUZMuGXhy34kzGlDBEcnVs+yYim
         ChD3RpH+6xh79kpkWbT4YCwYDTRr+MYqm4NLFAH7nr9IBx7poMjhP55QwVUq6s2RJ5Hd
         IKuw==
X-Forwarded-Encrypted: i=1; AJvYcCUUJRuvIWdJJZggMo/wAvzwpgkIjJG+8vjYYWmP0dI2Wo2E4IXO3VbZRc8M10z8EloncCm9xGaMg4HzSMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRGfU/ClRP7B+gCevjoXhLgu8CYliyLhkj0APAs9yw+zmGoGeQ
	y9WV7mhyFM8eXm8RCNrGjr4Lq7QT44OmVDscOS9cNP3G6hIXuxg0EOjEhDgrZLrZEa7g6JNmrut
	4aGx00HYyiLpauomd0M/ZU5SDDaNEAJN5VJw19A==
X-Gm-Gg: ASbGnctq46WvPCFs6AqFAxoGo5JM4szRfEc+UmSTPXONXHzqJc0dWqkwZ/nT+jcKunU
	di6nzSCg4I8/ID2hmDodKoaRHbyXvtWNw
X-Google-Smtp-Source: AGHT+IGsG8YQ1ggZzCdJnuPl8QhAuveUqLW8ajO21T6RKY94XRehmhGe1lb+y5bziuBa+IeNh+8txdT/gnk+MIJW+FM=
X-Received: by 2002:a05:6902:2d45:b0:e39:9749:bb2b with SMTP id
 3f1490d57ef6-e39d3e1c5f4mr1383026276.29.1733222254485; Tue, 03 Dec 2024
 02:37:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202151228.32609-1-ansuelsmth@gmail.com> <CAPDyKFqrY7uLD8ATqH0LghmkHgApQSsGtvGkOTd8UVazGu0_uA@mail.gmail.com>
 <674dd60f.7b0a0220.2ba255.7b7a@mx.google.com> <20241202205738.GA3149730-robh@kernel.org>
 <674e1fc4.050a0220.a615a.6ff9@mx.google.com>
In-Reply-To: <674e1fc4.050a0220.a615a.6ff9@mx.google.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Dec 2024 11:36:58 +0100
Message-ID: <CAPDyKFrb4-oJT2TMgw0SU035S2nO8LZZEOrQOz2mN+pFgZcYDA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: Document support for Airoha
 EN7581 CPUFreq
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Rob Herring <robh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, upstream@airoha.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Dec 2024 at 21:59, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> On Mon, Dec 02, 2024 at 02:57:38PM -0600, Rob Herring wrote:
> > On Mon, Dec 02, 2024 at 04:45:17PM +0100, Christian Marangi wrote:
> > > On Mon, Dec 02, 2024 at 04:42:33PM +0100, Ulf Hansson wrote:
> > > > On Mon, 2 Dec 2024 at 16:20, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > > > >
> > > > > Document required property for Airoha EN7581 CPUFreq .
> > > > >
> > > > > On newer Airoha SoC, CPU Frequency is scaled indirectly with SMCCC commands
> > > > > to ATF and no clocks are exposed to the OS.
> > > > >
> > > > > The SoC have performance state described by ID for each OPP, for this a
> > > > > Power Domain is used that sets the performance state ID according to the
> > > > > required OPPs defined in the CPU OPP tables.
> > > > >
> > > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > > ---
> > > > > Changes v4:
> > > > > - Add this patch
> > > > >
> > > > >  .../cpufreq/airoha,en7581-cpufreq.yaml        | 259 ++++++++++++++++++
> > > > >  1 file changed, 259 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..a5bdea7f34b5
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> > > >
> > > > [...]
> > > >
> > > > > +examples:
> > > > > +  - |
> > > > > +    / {
> > > > > +        #address-cells = <2>;
> > > > > +       #size-cells = <2>;
> > > > > +
> > > > > +        cpus {
> > > > > +            #address-cells = <1>;
> > > > > +            #size-cells = <0>;
> > > > > +
> > > > > +            cpu0: cpu@0 {
> > > > > +                device_type = "cpu";
> > > > > +                compatible = "arm,cortex-a53";
> > > > > +                reg = <0x0>;
> > > > > +                operating-points-v2 = <&cpu_opp_table>;
> > > > > +                enable-method = "psci";
> > > > > +                clocks = <&cpufreq>;
> > > > > +                clock-names = "cpu";
> > > > > +                power-domains = <&cpufreq>;
> > > > > +                power-domain-names = "cpu_pd";
> > > >
> > > > Nitpick: Perhaps clarify the name to be "perf" or "cpu_perf", to
> > > > indicate it's a power-domain with performance scaling support.
> > > >
> > >
> > > Will change to cpu_perf. Thanks a lot for the review!
> >
> > Is that defined in arm/cpus.yaml? No.
> >
> > The current choices are perf or psci though those aren't enforced (yet).
> > Or nothing which is my preference if there is only 1 power domain.
> >
>
> I would also prefer not having to define the names property but I guess
> that is mandatory for the PD APIs? Maybe Ulf can confirm.

No, that's not needed.

dev_pm_domain_attach() attaches a single PM domain, without requiring a name.

But as stated in the other thread, to be future proof, I would suggest
using a name already at this point. Even if it's not required.

Kind regards
Uffe

