Return-Path: <linux-kernel+bounces-380902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4659AF794
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 04:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA1528157A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 02:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A6A18A6DF;
	Fri, 25 Oct 2024 02:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyEkNrzU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0BF22B64E;
	Fri, 25 Oct 2024 02:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729824148; cv=none; b=TfRFxSIhlIsy2KICg5KuzHaVDa8+bbrxDeRdLxl4+g3vKYfkMnMbCSScoKAILQpB4tWqi09pJfzO1trUqulnzeBePGhUsuhgzY3SjDFF032yn/rwHEIXCZgcNYi+4b11C3zZ21Ms6GqEF8gEcT/cRnluyXukYOOf8bkwMoXKCW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729824148; c=relaxed/simple;
	bh=/uO3XLumgeX4Ph/V2YT6ZoQW03XGQDlCzb6y7cZGGt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UI8MyrWJBqeNmzHgBVjPyybKEHOqj4kNC7jOagPOWa1Q+inJiuym20ajblb3KftnYBtEbVHk973Lw+xS21ls6o2yfJIFGcxyuSDXTe7cP+LWBMknIxzMEMNZvsDdarCOAkPJNEjSKyM6RB5dRvQ3ig/xoxYsocBMPYDSf0lQhYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyEkNrzU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89CF7C4CEC7;
	Fri, 25 Oct 2024 02:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729824146;
	bh=/uO3XLumgeX4Ph/V2YT6ZoQW03XGQDlCzb6y7cZGGt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PyEkNrzUQxaBDp+HDDi3qDUQb60QZMJBaIlGj0VfuwvKuC2hy0PPYVdFsjeMVnpe4
	 +ro3QKw3FwAhSqfOb9gmwkyaEUTvjlLsxFnncZp/f04WIoCdZD3s5PmFLTs70wr8XG
	 T+mpnMFEc7cEIdNDU+tyS/h2LTabpcfMXVMFyeXoU9hr+6bGeY0DIPy/enwe4WuG/b
	 6Q34o7vEJcNZLlaCE7uMu+9zEADY/8YeW11/Nd5Fb3GX2c6opLs6CrkS7fGkM52ZDG
	 5HXtmBJh3HtGMpjTbILLu5uz+VfKF1XUqMqMbMG+J/IFQme4Htuot+yUtItgwJqDJ3
	 NMb1wNwZAA1rw==
Date: Thu, 24 Oct 2024 19:42:24 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 5/5] dt-bindings: riscv: document vector crypto
 requirements
Message-ID: <20241025024224.GC1781@sol.localdomain>
References: <20241024-fanning-enrage-bcc39f8ed47d@spud>
 <20241024-pungent-lasso-42dd3512a3c8@spud>
 <20241025022411.GB1781@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025022411.GB1781@sol.localdomain>

On Thu, Oct 24, 2024 at 07:24:11PM -0700, Eric Biggers wrote:
> On Thu, Oct 24, 2024 at 01:34:33PM +0100, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> > 
> > Section 35.2. Extensions Overview of [1] says:
> > | The Zvknhb and Zvbc Vector Crypto Extensions --and accordingly the composite extensions Zvkn and
> > | Zvks-- (sic) require a Zve64x base, or application ("V") base Vector Extension.
> > | All of the other Vector Crypto Extensions can be built on any embedded (Zve*) or application ("V") base
> > | Vector Extension
> > 
> > Apply these rules in the binding, so that invalid combinations can be
> > avoided.
> 
> It looks like that part of the spec is wrong, though.  The Zvknhb and Zvbc are
> correct, but the list of the composite extensions that at least one of them is
> included in is: Zvkn, Zvknc, Zvkng, Zvksc.
> 

I am attempting to fix this in
https://github.com/riscv/riscv-isa-manual/pull/1697

- Eric

