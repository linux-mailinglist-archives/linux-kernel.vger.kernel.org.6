Return-Path: <linux-kernel+bounces-423336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2909DA5F5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6711116452F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1745019884B;
	Wed, 27 Nov 2024 10:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="islEAvqI";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="Dp4UrgW7"
Received: from bayard.4d2.org (bayard.4d2.org [5.78.89.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E2C155389;
	Wed, 27 Nov 2024 10:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.78.89.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732703860; cv=none; b=fJnQSiL1b9/pEGAWLe0auFSargW/i347nfQI9gvyx5yK0h2uhPpdW5ZIxzpcostoSvRRR+lK9in6XNI7CdxCyw2FeDrJPzrk3VoUdYyF0m0Pk0eH9sjyeQ2QUVMWgNtgJteM+Lc3+QsXBhF+AADC5f58wQSrVo8pZ1utRpr2Us4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732703860; c=relaxed/simple;
	bh=EwkTX+MIFpLy9bn5raEc+I7FYh+YTAy5cL29F6FwZ48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIsm2RIIdxQpTi5akGYyn0Ae2pVeLsuhmViy98Jth9yTu7f+oq3d0+PBbVamp5A1VHtcXKjDjEAYuaCqPk04WDPctplGvZi++8rfZbsXCbrdVA/3/lMELkQ4/9OKrrbnPkrmew/O957bzCoInpKOXmgqF40AmhmqczLeXxSPro0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=islEAvqI; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=Dp4UrgW7; arc=none smtp.client-ip=5.78.89.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from bayard.4d2.org (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id 1581E122FE1E;
	Wed, 27 Nov 2024 02:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1732703855; bh=EwkTX+MIFpLy9bn5raEc+I7FYh+YTAy5cL29F6FwZ48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=islEAvqIu14umc0Nh0BNtaP0O54EhJiE/KsA+8hCjHouDnLAMzIa0hA/1GJIQK2Ma
	 8u9eFi0mi7Z6PHzaRGyiTZBBFjQZAjeEu7D45U4AHmoxpcYTpQs4r7nSyOSiKO77Eb
	 kIZ6/J02wk+ftsCE+1enjvEiZ/tjre4O71Zgrrm26h9Mi1Zhjt5jKfvKntsyVE6LIN
	 aQ0uiqTK2eL8dSnZrCEmZ9ozq/I99rssBjDLGqxqjJXwvGvG4MUURW7BzSUB95ZH5V
	 q0VZDrAo9VVt0LYZjg9xI4qsFwAvBhSo9HnKKEBxRXoKiKMa3Ic4qH70L5IKcYxRkh
	 Vi4kgWYfOu//Q==
X-Virus-Scanned: amavisd-new at 4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by bayard.4d2.org (bayard.4d2.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gT4AeVqNt7z5; Wed, 27 Nov 2024 02:37:33 -0800 (PST)
Received: from ketchup (unknown [119.39.112.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id 0E94A122FE1A;
	Wed, 27 Nov 2024 02:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1732703853; bh=EwkTX+MIFpLy9bn5raEc+I7FYh+YTAy5cL29F6FwZ48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dp4UrgW77o9Ymd6bTjpRfztdQI5YoI8Jx6G+IprE8QppyWLBTchlw/HqDcCAFrY3c
	 ZULd2sM/4mo0pFNtm3Fw5vaHW8akqi0gF2hIUGXAmoL5g0LdqHP2vS0NH0oypcswZa
	 eLMteRDH7RCZA/1zTjKf4MHS9hi5kjjXZ4qZndXUvFRCkTyHxZvByw4ji8yACxopJo
	 fQJYSiUZJtdrRogf6ch9w7eyyJFOoqd0Bo3nWn5BtxhB75MqagIKYFMmSvBLPQclI/
	 UWNGvwbQXo+lXFGlwjVhdnfBLF1zRWmrq510Y8qelZp7Ofn/H+h8dB8SxRUeWrnd0J
	 dFqueXyjg70eg==
Date: Wed, 27 Nov 2024 10:37:20 +0000
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
Subject: Re: [PATCH v3 1/3] dt-bindings: clock: spacemit: Add clock
 controllers of Spacemit K1 SoC
Message-ID: <Z0b2YOdIWfuJINDW@ketchup>
References: <20241126143125.9980-2-heylenay@4d2.org>
 <20241126143125.9980-3-heylenay@4d2.org>
 <64bf96a3-e28c-4c47-b7b3-e227bbaa7aee@kernel.org>
 <hgtrinu32q2jtxb4z5nvjskjlkwwzxhymtf3alvaxlbqxrbzd3@2rw3uy2tqgnf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hgtrinu32q2jtxb4z5nvjskjlkwwzxhymtf3alvaxlbqxrbzd3@2rw3uy2tqgnf>

On Wed, Nov 27, 2024 at 09:03:11AM +0100, Krzysztof Kozlowski wrote:
> On Tue, Nov 26, 2024 at 03:48:33PM +0100, Krzysztof Kozlowski wrote:
> > On 26/11/2024 15:31, Haylen Chu wrote:
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - spacemit,k1-ccu-apbs
> > > +      - spacemit,k1-ccu-mpmu
> > > +      - spacemit,k1-ccu-apbc
> > > +      - spacemit,k1-ccu-apmu
> > > +
> > > +  clocks:
> > > +    maxItems: 4
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: osc_32k
> > 
> > osc
> > 
> > > +      - const: vctcxo_1m
> > > +      - const: vctcxo_3m
> > > +      - const: vctcxo_24m
> > > +
> > > +  spacemit,mpmu:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > +    description:
> > > +      Phandle to the syscon managing "Main PMU (MPMU)" registers. It is used to
> > > +      check PLL lock status.
> > 
> > Why your example does not have it? Example code is supposed to be complete.
> 
> I think I understand why - this is for only one variant?

Yes, currently all implemented PLLs are located at APBS region, thus
this property is only meaningful in spacemit,k1-ccu-apbs.

> But then this
> should be disallowed in your binding for others. Currently your binding
> says that it is required for one and allowed for others.

Thanks for the correction. I'm considering moving the definition of
spacemit,mpmu to the if block as well. Is it the correct way to disallow
its usage in other variants?

> 
> Best regards,
> Krzysztof

Thanks,
Haylen Chu

