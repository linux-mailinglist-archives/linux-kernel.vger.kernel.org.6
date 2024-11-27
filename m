Return-Path: <linux-kernel+bounces-423370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E3F9DA668
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0078282E48
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDB81EF080;
	Wed, 27 Nov 2024 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="OHIzLYyP";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="FX47VPYp"
Received: from bayard.4d2.org (bayard.4d2.org [5.78.89.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36771EBFFA;
	Wed, 27 Nov 2024 11:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.78.89.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732705304; cv=none; b=ZyZuRj9WenHtfGtV4hTEIJjvEJyC7qpGHmkP5vacb6d/erUar8T96cv36qELaWKRiiLYbNSIZW/QhiUT9mafdLtKRD2zxHu2+lDOlfgdx2DEyb/68Tbxa2Zl1PwVTAd+uMEECBfElYFBkFmHI651PDuWABsmqYjf/j1XOSnocOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732705304; c=relaxed/simple;
	bh=Mr+PrXarwOscZIn47L1gfNj1f8aJ1BHQ8BTWIOY61ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ellivNVVIlkf5lhJXuhz8LLuY/zHX0XMbd+TFr6PTB+POxuhutukcbvBFswFceqAxJgsUptfU7Rgi38d9b80Xeo3q1CSshl4N8cqo1IYDHrT533MVlRUKKDRabxXRvyfRZGREs1koRJYWT/7B3/NocsJ0kmMhd4lOROJESCQT0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=OHIzLYyP; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=FX47VPYp; arc=none smtp.client-ip=5.78.89.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from bayard.4d2.org (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id 17570122FE1E;
	Wed, 27 Nov 2024 03:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1732705302; bh=Mr+PrXarwOscZIn47L1gfNj1f8aJ1BHQ8BTWIOY61ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OHIzLYyPyFtoNjLCFvS5IPk8qT4yLEkbgh6LsK+BzonUqz/tc/xHELvL50nmjfpeX
	 ntqG1EtvQCH1OdqzxCsHglwDgndwNWX9fZSKUBFYdbaXVib04zQ5GFYnD8E/21LSuK
	 RC1fSm8FHWDcovwPmhs4zdAg9cImVgD6HrkzDW58M/PKfyKmZTOIZt4fBm+S2/tOdt
	 BTTmS+Dfd7NQWqcLWGoUCRLfAvIedMS3ELYGB6MvrL+npvbGcYpgKqRl+bXPPKp+k9
	 2nWnkE4p4nSgQbCFHJlME2de0owJGfn5CGg3kzfrF92dM1JJcaf+8HWTD87GqTzIQ7
	 IzYgU5z+axBOQ==
X-Virus-Scanned: amavisd-new at 4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by bayard.4d2.org (bayard.4d2.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NZ89x4naavqP; Wed, 27 Nov 2024 03:01:40 -0800 (PST)
Received: from ketchup (unknown [119.39.112.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id B6AA7122FE1A;
	Wed, 27 Nov 2024 03:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1732705300; bh=Mr+PrXarwOscZIn47L1gfNj1f8aJ1BHQ8BTWIOY61ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FX47VPYpyNVOMtFWkYzfQso3D9D7SO9qMo41IRHV4Ur1Nmi6bskvj6VpBe8QKnYjR
	 ogJVCTf7igfmo6J4xENGzcxgeSEvCzsO/WicYLW1xXA9SEpYR8RSDFkLu84ykQeIbA
	 gFM1Vfogp8I9eJtNS2oQ2Y/PadA9WnNn9PRESVmTkFIPzBAicqFwgh8EuuEqc8xH75
	 RKZI9WfzNhcZF1wS4lsNUmL5oMWQDm1Z2Z9Jyy0v2Yob4uxM8nn+G5ADJiDBVZRyDH
	 tA4Bl69WLnXJkqwOFZl4eg3Dlenu1/ZRYRAIyprW7LvNTvP7nQLLZfWDWq5xxhHWby
	 /fCLxZtCZAUhg==
Date: Wed, 27 Nov 2024 11:01:28 +0000
From: Haylen Chu <heylenay@4d2.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Haylen Chu <heylenay@outlook.com>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Inochi Amaoto <inochiama@outlook.com>,
	Chen Wang <unicornxdotw@foxmail.com>,
	Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: soc: spacemit: Add spacemit,k1-syscon
Message-ID: <Z0b8CJGrAe_kUeuU@ketchup>
References: <20241126143125.9980-2-heylenay@4d2.org>
 <20241126143125.9980-5-heylenay@4d2.org>
 <711362cf-5f4c-49e3-b771-38dfb441bc4c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <711362cf-5f4c-49e3-b771-38dfb441bc4c@kernel.org>

On Tue, Nov 26, 2024 at 03:50:30PM +0100, Krzysztof Kozlowski wrote:
> On 26/11/2024 15:31, Haylen Chu wrote:
> > +examples:
> > +  - |
> > +    osc_32k: clock-32k {
> > +        compatible = "fixed-clock";
> > +        clock-frequency = <32000>;
> > +        clock-output-names = "osc_32k";
> > +        #clock-cells = <0>;
> > +    };
> > +
> > +    vctcxo_1m: clock-1m {
> > +        compatible = "fixed-clock";
> > +        clock-frequency = <1000000>;
> > +        clock-output-names = "vctcxo_1m";
> > +        #clock-cells = <0>;
> > +    };
> > +
> > +    vctcxo_3m: clock-3m {
> > +        compatible = "fixed-clock";
> > +        clock-frequency = <3000000>;
> > +        clock-output-names = "vctcxo_3m";
> > +        #clock-cells = <0>;
> > +    };
> > +
> > +    vctcxo_24m: clock-24m {
> > +        compatible = "fixed-clock";
> > +        clock-frequency = <24000000>;
> > +        clock-output-names = "vctcxo_24m";
> > +        #clock-cells = <0>;
> > +    };
> 
> Drop all above. Your changelog is poor - does not explain this at all.
> Write changelogs which detail what you did and why.

Thanks, I forgot that missing phandle references are acceptable in
dt-binding examples. This and other required changes in v2 that I forgot
to apply will be adapted in v4.

> 
> Best regards,
> Krzysztof

Thanks,
Haylen Chu

