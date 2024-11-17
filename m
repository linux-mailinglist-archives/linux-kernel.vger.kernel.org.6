Return-Path: <linux-kernel+bounces-412084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 812789D03BA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 13:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D87AB262C6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 12:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB133199E89;
	Sun, 17 Nov 2024 12:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="de3N7xye"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F16186E58;
	Sun, 17 Nov 2024 12:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731846330; cv=none; b=edI/EPiFrVrOwAtoqabqOQ5HCOctbNWmp+J1ijcLl0+nVq+TvP9M8WM53ait0fZ6iyo332SNnCj7Xk440x5rp/qUUCUMz9tHBwvneHjPcPVSjpCIur8NsWsIhEc7TAu8y0ogJAkOuW+4JEasH+9YHF8LlOnEWp4okHvZKtyJlqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731846330; c=relaxed/simple;
	bh=v0SczrddyMYujY9dYZIJhDs68nkrXtTFyaJ2w+eGWUo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rjUhkXKtGv/g0faY1kTcQ7V4JCKHhIR0DPh9ygJhFgwX0uL1oaXWiJwcbAY1SM7HEXcMhxsnkQVZptfSS9HDZtA0KmOAKFMSCFLRGSKqe1gddxkdfw7DW1lvMk6CyZ/gjxvSltOyYx++CyDMIGNHcO/I0GdM4ieeIN0TjBY0XuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=de3N7xye; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731846323;
	bh=3Q8GF405lgPrVBMNIcWwlkYcIcKlMKmYZQRNZamOSn8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=de3N7xyekklCVojBYAsLV7SwZQaYEA5qDTjTXw8a8r3iLi8xPMcUsFxoI3AWHUK/Q
	 4ziG7DmSyzGQafjZ4A+8hy8pI9Tv9+b5icFGZLsQ8jcHBEF8U5n4ljXk0HOsAVI9Zv
	 qSCn5qk7a9Me7PFPL55Q3+ociPNKooHr8TI4j5X6JYWyWXkILKv/tjKuaqmtUnoaZN
	 k95mU8mj3KruLMC1Z2bvT5AwPt29bo/SsFYXm0J46zYslL4P0QnSPy3EfWpNqHdKce
	 Jjt5YrL49S86/zMeewnM5OzHIX7rd6zH2jqnEGWrNdaFqy6NJ2qhQbk1QG9MAYOnb9
	 P8E6m6UO+fTsw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xrqhy405Kz4xf3;
	Sun, 17 Nov 2024 23:25:22 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Scott Wood <oss@buserror.net>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, linuxppc-dev@lists.ozlabs.org, Lukas Bulwahn <lbulwahn@redhat.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@redhat.com>
In-Reply-To: <20240927095203.392365-1-lukas.bulwahn@redhat.com>
References: <20240927095203.392365-1-lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] powerpc: remove dead config options for MPC85xx platform support
Message-Id: <173184539765.890800.8133214752125480117.b4-ty@ellerman.id.au>
Date: Sun, 17 Nov 2024 23:09:57 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 27 Sep 2024 11:52:03 +0200, Lukas Bulwahn wrote:
> Commit 384e338a9187 ("powerpc: drop MPC8540_ADS and MPC8560_ADS platform
> support") and commit b751ed04bc5e ("powerpc: drop MPC85xx_CDS platform
> support") removes the platform support for MPC8540_ADS, MPC8560_ADS and
> MPC85xx_CDS in the source tree, but misses to remove the config options in
> the Kconfig file. Hence, these three config options are without any effect
> since then.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: remove dead config options for MPC85xx platform support
      https://git.kernel.org/powerpc/c/f20b0a03674cef555a5f48b65f81b82868b17cdd

cheers

