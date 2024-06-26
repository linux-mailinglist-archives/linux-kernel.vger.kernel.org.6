Return-Path: <linux-kernel+bounces-230276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D45917ABF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E398E1C23BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E8F1662E9;
	Wed, 26 Jun 2024 08:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="N3WVX5Pm"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B461607BD;
	Wed, 26 Jun 2024 08:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719389920; cv=none; b=WjB+vz3Tk54IB/lO7wk7u4g2VdORaezooDm//UwxdApfZsaqtAj8iIgtUzQbcLyijnxQN/l5cIwkusCxNUlHH+B0hBHdp54YG2ls1mCjvdyoD3wCdMsHb+N5zhZ1+qMwxfjRiqlVrgjJOA33bd7U4YqvHpL5xyraU8MRzkRXwxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719389920; c=relaxed/simple;
	bh=tLqxjdvKncjvyf03Lhs0i9bSG7lfZSHlzhwH58h2wN0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ihb4A9Th0qdGjafePAHgy56VlBMiC/JmrI50Y2Flk8VP/R2+97DGDR3jKYdQO8VpTkwABP/pdYca21AOkcmxYajF2yLVtN5V+ZZJWfzu1oXa6wsR0Zd3Hf706g/4Fme8BRU3PJG2VqECKvFHIWUcPbUHourOjVU6sdVM2M7zDPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=N3WVX5Pm; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 423DC200EE;
	Wed, 26 Jun 2024 16:18:31 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1719389913;
	bh=tLqxjdvKncjvyf03Lhs0i9bSG7lfZSHlzhwH58h2wN0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=N3WVX5PmAnQAqeowtVcZ488EtThGN08BtJWVXcoy22JwMyw501suKxzDx8T7zKjM2
	 tdVm4H7Pn1oMa3vej7VwUHZPgHzwfS9Lk9oWPVMo8IlmlR2FTpTHH6D5zEM2Sv00dj
	 CPGGtYnzPHAHQpkBQ15TjkVeopHfXc6ozGXDY4xqdmxDhQPRH08C9tDsosQ9ASuBei
	 wsWQlDxHPsZo9T23leb7BrD3BSUb4HQ8K3wdJwJbfIpEg0wLCDBDY4koSuJFhIDI7y
	 TqzW0Ekk7zslyVwI7j3EhZ2n8ItW+kkEz0lyxR9peXgGTZDEagg9R+05/nm13gjsKq
	 4/9zy4Y+pwlfQ==
Message-ID: <b4ba5fa7834fdfb1a1e26ff0e01b9bb235de63b5.camel@codeconstruct.com.au>
Subject: Re: [PATCH 1/2] dt-bindings: i3c: dw: Add property to select IBI ops
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Aniket
 <aniketmaurya@google.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>,  Joel Stanley <joel@jms.id.au>, Billy Tsai
 <billy_tsai@aspeedtech.com>, Rob Herring <robh@kernel.org>,  Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Date: Wed, 26 Jun 2024 16:18:31 +0800
In-Reply-To: <c15045b4-2e5f-4fcc-b25c-76a5e4973e93@linaro.org>
References: <20240626052238.1577580-1-aniketmaurya@google.com>
	 <20240626052238.1577580-2-aniketmaurya@google.com>
	 <e28ba03d1df1c0c5aec987411c40e44fc351ce0d.camel@codeconstruct.com.au>
	 <c15045b4-2e5f-4fcc-b25c-76a5e4973e93@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Krysztof,

> > > +=C2=A0 ibi-capable:
> > > +=C2=A0=C2=A0=C2=A0 description: Set to select IBI ops.
>=20
> What are IBI ops? Standard form letter:
>=20
> You described the desired Linux feature or behavior, not the actual
> hardware.

In this case it is the actual hardware; my understanding is that the
gateware IP can be configured to support in-band-interrupts or not,
before being baked-in to hardware.

> > Wouldn't the compatible string select whether the hardware instance
> > supports IBI or not?
> >=20
> > I'd imagine that each specific synthesis of the DW IP would imply
> > corresponding hardware settings, and so would warrant its own
> > compatible
> > value.
> >=20
> > Maybe one for the DT folks: would this work better as individual
> > properties? Is there a policy here?
>=20
> Usually if feature is specific to given hardware, e.g. always capable
> of foobar, then it can be deduced from compatible, so no need for new
> property.

Sounds good.

Aniket: the hardware you're dealing with there may need a new, specific
compatible property, which will dictate whether we enable IBIs in the
driver.

For cases where no other special behaviour is required, we can
represent this just as an entry in the OF match table.

Cheers,


Jeremy

