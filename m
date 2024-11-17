Return-Path: <linux-kernel+bounces-412085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA089D03BF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 13:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8481F233D0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 12:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C3E1A9B2F;
	Sun, 17 Nov 2024 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="BfA+hDrB"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D74919ADBF;
	Sun, 17 Nov 2024 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731846333; cv=none; b=hfxEx4OTnfp3LkhtBy7FGaHY4l4MeOzz+NIjVD8rdO9vkgMsAhsgtQvUVcXE2fLZqP7VV8jqdIOcBIpdoDtUSCxjN52cLxRXQVsNQLfAlDpLfSMc2lPBeXfkVtVCn1vQb5zBV+LW2DggSQrf2UhrwXBqXqr5gQJMFdTOf3y52nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731846333; c=relaxed/simple;
	bh=Is8yc5+TSfPF5LwkL6cMbKzwx66c7RFMVwvIrqQbSUk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gb48ccTj/TealCltDNFrZt0I740MO3YtKdm9/HgMVUliDLV7sbKjlQfY5YnLLRoJvZJv/fHFNmYSR10HAXji1QOEdtA2jIbjZE8UM2LzaiZuSnuLOYashQtIKu4NwSqwBBL2OR4PtumRd/PJ+SCibaDQ8WZDFuLvuw+zZKo07/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=BfA+hDrB; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731846327;
	bh=KaVcfOJB5yHFkrI9gBoi6KkKyub0hH9jAka1jgkP7js=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BfA+hDrBx4pasiTqOPTLolLQ/OuZVtnl+jlr0QV+dYbn3p8dExFxdsdsSXOaTOTTW
	 8vGsEDqQhCzQJtY5P7jpcNoKtkQ0Z4dEWZBdH3EVCBp3XuHAJ1R8sebUu+l7byZ6u6
	 NjN5q5GifvWctHaEdF36bgoW4ndeR4r1vP8fZEHrOM+C27scsTMZZhqhOA0ermMKkW
	 IrCUU5MvIlnoTJiNc6TUyLR2FqVMCm9Gq43MmYL/Lw/q0onSb5CliEjn8ts1RlTtFl
	 baKUnobbQNi7+CtMrM7o/+544GmOvKcOy1qizi1wF4BY3RrghWhUfRQw2As3v450K/
	 +Pc/bVc6rx6fA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xrqj04H09z4xdS;
	Sun, 17 Nov 2024 23:25:24 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org, Jani Nikula <jani.nikula@intel.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Naveen N Rao <naveen@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Thomas Zimmermann <tzimmermann@suse.de>, Paul Mackerras <paulus@ozlabs.org>, Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ede25e03-7a14-4787-ae1b-4fc9290add5a@web.de>
References: <b7e69e04-e15c-41ec-b62b-37253debc654@web.de> <d9bdc1b6-ea7e-47aa-80aa-02ae649abf72@csgroup.eu> <ede25e03-7a14-4787-ae1b-4fc9290add5a@web.de>
Subject: Re: [PATCH] powermac: Use of_property_match_string() in pmac_has_backlight_type()
Message-Id: <173184539766.890800.18087603028273437362.b4-ty@ellerman.id.au>
Date: Sun, 17 Nov 2024 23:09:57 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2024 18:18:42 +0200, Markus Elfring wrote:
> Replace an of_get_property() call by of_property_match_string()
> so that this function implementation can be simplified.
> 
> 

Applied to powerpc/next.

[1/1] powermac: Use of_property_match_string() in pmac_has_backlight_type()
      https://git.kernel.org/powerpc/c/2e716f5cdebed2fb98cafffaf626645c2e922dbb

cheers

