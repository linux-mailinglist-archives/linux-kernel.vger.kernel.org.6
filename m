Return-Path: <linux-kernel+bounces-330765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FDA97A3ED
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54A5E1C274F2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1AB14D439;
	Mon, 16 Sep 2024 14:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqY2Aif0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16260175AD
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 14:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726496064; cv=none; b=eTxP01Lre6m5Vd+KcYnq62yjGglUM3cruaFCmKNODfnaUqKOhnml+0XujdMrlScAR/ghMiqJ/jzlV21TqVKsSES2jpO1b5xx+0D55GOWk0kmWcwnOLZrgnwi3fzSIoD/tBFtxwkO21w1oIJ4yg4kYu7dH349po8rL6RaSDX+LSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726496064; c=relaxed/simple;
	bh=p8Qw/Z3EWptB753IvVwwQTS7CehLpJ7ecSD0INIPXEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DS2sucHnUx1UiKNfLF0mASvIThOuXobyvb0q+ADpUBqSGz2APO9u55N9X1UZnlILosd835u0pjoWIa1uyCC3hmLr4V7GqPUYxt/FAT6vYlposCQtCjZaHFVkFKqcD8QeCRe2w69LzSR2ImqYSuf9/ahqla+HBWEXAvjgpZt0uOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JqY2Aif0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726496061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AcF8APrk91tCbcYltqs1GD/SqMXA9dDCBkUimLG4iT0=;
	b=JqY2Aif012GWq4HUeJc77KmCsutesJpEsjq7FyDOjhyJe2trZkx5glkN4eoA/pAFRs3KPZ
	D8Xtc0ZctaxcDa41od7qIyIFPvUTzCw6m6hC/bOwXXnlaUy8kNPKo5a2vuynXJgS1vCVDB
	ZJv+uCzP1LY6W1NYbx3xtaSne2BADwY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-gvMfnx9dOkudKSBoBIo-Aw-1; Mon, 16 Sep 2024 10:14:20 -0400
X-MC-Unique: gvMfnx9dOkudKSBoBIo-Aw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6c366f8b1ebso102835076d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 07:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726496060; x=1727100860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcF8APrk91tCbcYltqs1GD/SqMXA9dDCBkUimLG4iT0=;
        b=a3SBZhXR7Omjp92GlN0xPYnkxnD1DFfeJwWyplbjUekDWY+JUJ8xXZdW/wpoEhimi4
         mOytDVVpo7ux6a/CRBuwVyF1EnB9A4E6QRT0n445K1CruzQ0OUbX5KOwmctkgodenCW8
         fkmoxllGGAi1oRDlP1aizrkc+2JgYq9nj+gON43bk3p7+01m+xDnQnxmR0ikDBpfT6zc
         kUpCEr4sBS8PykmtGwJKF5lBYjBq75k15eL/w+YLQkBKuDtRvXMVZ7tdvHCoH6yOszPF
         9kB66An1Lp6eM2vYyVsgamgnR5QovmTotJ/kRcTHS2TGp8Ad3uh4IxcnpdC4gmZ7fsq1
         vusQ==
X-Forwarded-Encrypted: i=1; AJvYcCU90IIitOvSzqSSrHx6QAXt46nC4H9+Ll/M/Nw4Y7VYA/YGkKrbLVcwK/qvZNlWi/+V7xJ41qZ4d0e8TQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEX1avXH+s8FUQV+64ePGhkr1eG4j/Ps6cnJ+n+taysHiXP5Ah
	rntddLZFnreq7eGRnDiYfL+MIurTxH2NQMU9CZWepSfAD6U3esVT991zzz5KTGlCvDmnAv5fwbL
	5uWC/72lw0q8HElRW6L2Ni0VO9GL1fnLshldlJp7PimSpfq96kiZum3JAiGcvQw==
X-Received: by 2002:a05:6214:1ccb:b0:6b5:1d2f:1d3 with SMTP id 6a1803df08f44-6c554b1cdddmr398070486d6.0.1726496059816;
        Mon, 16 Sep 2024 07:14:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqL/oYOimlYmlJ6CYNue/wCoB+Q5zjZ6hGSjMzwDsJkqgqG7vOoSeuPSCijo4hPmZayqJz8Q==
X-Received: by 2002:a05:6214:1ccb:b0:6b5:1d2f:1d3 with SMTP id 6a1803df08f44-6c554b1cdddmr398070036d6.0.1726496059363;
        Mon, 16 Sep 2024 07:14:19 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::43])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c58c625f50sm24683996d6.3.2024.09.16.07.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 07:14:18 -0700 (PDT)
Date: Mon, 16 Sep 2024 09:14:16 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Beleswar Prasad Padhi <b-padhi@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Keerthy <j-keerthy@ti.com>, 
	Neha Malcom Francis <n-francis@ti.com>, Eric Chanudet <echanude@redhat.com>, 
	Enric Balletbo <eballetb@redhat.com>, Udit Kumar <u-kumar1@ti.com>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-j784s4-evm: Mark tps659413
 regulators as bootph-all
Message-ID: <rjc2cbkzg6zjsue66cvy7lk7qc7vn6yjdqcjzrbzcsf7c2jdo5@lcy7dntjvzau>
References: <20240911-j784s4-tps6594-bootph-v2-0-a83526264ab1@redhat.com>
 <20240911-j784s4-tps6594-bootph-v2-1-a83526264ab1@redhat.com>
 <c4ace228-ea32-4760-b6af-f7555b68063a@ti.com>
 <zlgo4e5qwg352tsadvw43oj7vlekefuqe66ckokyo6aba47z6o@2wwbyrfjkstz>
 <9aedf384-207a-4eb7-a371-70bbe76ab5af@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9aedf384-207a-4eb7-a371-70bbe76ab5af@ti.com>

On Mon, Sep 16, 2024 at 04:14:43PM GMT, Beleswar Prasad Padhi wrote:
> 
> On 14/09/24 00:27, Andrew Halaney wrote:
> > On Fri, Sep 13, 2024 at 04:27:47PM GMT, Beleswar Prasad Padhi wrote:
> > > Hi Andrew,
> > > 
> > > On 11/09/24 22:49, Andrew Halaney wrote:
> > > > In order for the MCU domain to access this PMIC, a regulator
> > > > needs to be marked appropriately otherwise it is not seen by SPL and
> > > > therefore not configured.
> > > > 
> > > > This is necessary if the MCU domain is to program the TPS6594 MCU ESM
> > > > state machine, which is required to wire up the watchdog in a manner
> > > > that will reset the board.
> > > > 
> > > > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> > > > ---
> > > >    arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 8 ++++++++
> > > >    1 file changed, 8 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> > > > index 6695ebbcb4d0..6ed628c2884e 100644
> > > > --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> > > > +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> > > > @@ -663,6 +663,7 @@ tps659413: pmic@48 {
> > > >    		regulators {
> > > >    			bucka12: buck12 {
> > > > +				bootph-all;
> > > >    				regulator-name = "vdd_ddr_1v1";
> > > >    				regulator-min-microvolt = <1100000>;
> > > >    				regulator-max-microvolt = <1100000>;
> > > 
> > > In my opinion, bootph-all property should come after other standard
> > > properties like regulator-name etc., as it is least important to Linux. Same
> > > comment for other nodes wherever applicable. What is your opinion?
> > > 
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n130
> > I think that does align better with the dts-coding-style doc!
> > 
> > Looking at the tree though, the standard currently in the TI folder
> > is to put it first. In my opinion if changing the ordering is desired
> > it should be done in one fell swoop (outside this series). I'd do
> 
> 
> There is a series[0] under review which takes care of this bootph- addition
> and order correction. In that series, looks like bootph- is placed at the
> end of the list of all standard properties. So, it is better if we align
> these patches to follow the same.
> 
> [0]: https://lore.kernel.org/all/20240814-b4-upstream-bootph-all-v4-2-f2b462000f25@ti.com/
> 

Ahh, ok. I'll post v3 with things ordered in that fashion!

Thanks,
Andrew


