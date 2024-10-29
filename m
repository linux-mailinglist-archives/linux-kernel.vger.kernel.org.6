Return-Path: <linux-kernel+bounces-386391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D479B42D9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC963B21E3D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C142022ED;
	Tue, 29 Oct 2024 07:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ei3l9Zb3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599F88821;
	Tue, 29 Oct 2024 07:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730185827; cv=none; b=SiDpBNjgALgiyRuVXNKsuFlJRumCIlpIKyHKlA0TR3L+c+KGWkIlE4sV6G4gUiklK82CS1DlLEcwLgrmfKPhBClnVafeRYzH8dXmCNcb8VOmPyYfbx98Tqj9jFcJ7mqOuSn3+3DLWTNXMc3QeAK+EHlE4zN0p5Hlrlu1j/gw+38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730185827; c=relaxed/simple;
	bh=EO032NXE9PkRJOzWtE2Jyo8yYUI2qKerjCpFA489KL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyP7zaAQi3C2Np3mFrk0FF3MiZ1WgkDdqge5PknoxBOxbWnUv6N7mG3yE7tFOXowyahXLrVhY3FjN/hIiOjxyEBnKFhunGgJXtEbdiwztpI4oPaUtUgCNOOLT0ei05B9iYU4nWWWMZ4Hcjjs0v8laLBh5q5BMHD4MZer610hZpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ei3l9Zb3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A272C4CEE3;
	Tue, 29 Oct 2024 07:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730185826;
	bh=EO032NXE9PkRJOzWtE2Jyo8yYUI2qKerjCpFA489KL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ei3l9Zb3PXeU5l+wtwuGRq5uL9QbHjfUVHOG/D25ZEkIUEsrociR55GLAtNOYc7Ol
	 op87vgFPkRTAwjveEuYPuYzjMyNzdf4F26NtcQ9NnvA0fefu70+fHR4pHV23eaAGGT
	 ZoLVW2WdwRMHeM2NJmAAMx+f6FLiciGM3g0TJLCnJeZoIkvZ5utoK6OoauMRwCbdrp
	 vIWNilUX2uToPemZKFMLy4XSCvCpSDfqaY3C3jWLseJBDbXx8TVwVBH1ZvBYaNWS8Z
	 A4UAXt8MG8S7SoQ+IdKnkJruitCnLB/h/osDPVXVUaUz8et7Y6jvirEy6Jbg/31UoV
	 RSiG0B8fbfXOg==
Date: Tue, 29 Oct 2024 08:10:23 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Karan Sanghavi <karansanghvi98@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Alexander Aring <alex.aring@gmail.com>, 
	Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v4] dt-bindings: power: Convert raspberrypi,bcm2835-power
 to Dt schema
Message-ID: <bdze3425qwrtlvlairw2b4xiycpkmhirzhqn2jt6jngc3bu4ta@uo4nc2lnj4sf>
References: <20241028-raspberrypi-bcm2835-power-v4-1-acf44abd45ff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241028-raspberrypi-bcm2835-power-v4-1-acf44abd45ff@gmail.com>

On Mon, Oct 28, 2024 at 04:44:12PM +0000, Karan Sanghavi wrote:
> Convert the raspberrypi,bcm2835-power binding to Dt schema
> 
> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> ---
> Changes in v4:
> - Corrected misindentations and random differences.
> - Link to v3: https://lore.kernel.org/r/20241026-raspberrypi-bcm2835-power-v3-1-6621e075d33f@gmail.com

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

<form letter>
This is an automated instruction, just in case, because many review tags
are being ignored. If you know the process, you can skip it (please do
not feel offended by me posting it here - no bad intentions intended).
If you do not know the process, here is a short explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tag is "received", when
provided in a message replied to you on the mailing list. Tools like b4
can help here. However, there's no need to repost patches *only* to add
the tags. The upstream maintainer will do that for tags received on the
version they apply.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
</form letter>

Best regards,
Krzysztof


