Return-Path: <linux-kernel+bounces-318823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A9196F3C2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49EE01F25DEB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA87C1CDA20;
	Fri,  6 Sep 2024 11:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="U5p5gFX7"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A641CC179
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 11:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623735; cv=none; b=XHGjwRo2t12IPHDJXktYuy5wUJoK4JyeIf8gR+JcqtPwIynlVc4a0FAF7EduXfOJ00sfAqb90IHbNQQVRTS5fKOandR8BIzFLdlIClHZ/gIRFKBv6dC9wHnK5OgLn/iIYoF/6j9XCpRnw7Tkd3mveuwnCL6CfMvAwGzMd2RNruE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623735; c=relaxed/simple;
	bh=wXZaFjdvYvos1chhDx3sbfIN2qjDFppXe4hB1KfFomg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZCrZnbuRaNHiUDSyE5eNF8e6lJrj/oI5ckTG1k033+WD8odk4TPlqqTSkhShmIwyJjLL686hXiZ3SVZHP3P2gNB8kQi6f+ThHRGDIVi/M5oH7XA04UYP2fLKJrzOOZpjHAqRBV0+yNjVMjWBb7YiQs3A1ddYzl7r1HoR6mcR+DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=U5p5gFX7; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1725623731;
	bh=DbMztvvaFPoOtSRqVj+TzOFz2xGU/sv7nl4ktpugczI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=U5p5gFX7B72T6vilbey+jJoTLmSbQx7c23SCrWmgP1za3RogGR3OF6ZFseL8Qb7YS
	 C6F0U76hceuSe3AGIhulZAE3SqOt4Zy4YHJI7HAAvJbGdveco2Xrn4/4K/gwstul8J
	 4ZFgebXNa7idllP29yQT3+f6N9cAenz1tz/r5kOSeu8I/vFZyw78hvjXu6j1sA4ICT
	 skozskyEwyJM3r8jqaxZMv7ON5tkeo5bOtf0yfeDhTLqw/TpBBjuJUypfGKV1eTqEj
	 MxYY5+uICD8qySjCIvgyuOpQx6rrJotKcs6vSd803i4K4xciAoxOmnbFu0eXR/LBM9
	 u0u0HK6VlacEw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X0ZRk6qSlz4x8c;
	Fri,  6 Sep 2024 21:55:30 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <2439d50b019f758db4a6d7b238b06441ab109799.1724156805.git.christophe.leroy@csgroup.eu>
References: <2439d50b019f758db4a6d7b238b06441ab109799.1724156805.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc/32: Implement validation of emergency stack
Message-Id: <172562357202.467568.4678514155829068407.b4-ty@ellerman.id.au>
Date: Fri, 06 Sep 2024 21:52:52 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 14:26:54 +0200, Christophe Leroy wrote:
> VMAP stack added an emergency stack on powerpc/32 for when there is
> a stack overflow, but failed to add stack validation for that
> emergency stack. That validation is required for show stack.
> 
> Implement it.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/32: Implement validation of emergency stack
      https://git.kernel.org/powerpc/c/dca5b1d69aea36ab559d9ca13729370007c60df1

cheers

