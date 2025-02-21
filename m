Return-Path: <linux-kernel+bounces-526599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C1FA400D6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3896D19E1FED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76866253B59;
	Fri, 21 Feb 2025 20:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="GmNFvO/m"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A3925333A;
	Fri, 21 Feb 2025 20:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169577; cv=none; b=LoE329Mekiz4VaJSgCJgJl7GldRN3hB1T/1t6OQ9KeQ7yIiZMI5P1DW1omjDi9FMsxOzO1nL2d2FTrGlNenXBBdDn0Yw7MQ4eTTVQtsKwdk7dlgTTpBJRg4v3w+ZKADh5DI8Lom/hPVxAQoHUN/uq93XEa5sabIIDFrPTzfdiUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169577; c=relaxed/simple;
	bh=SNRbu/jnJKXoj48AelySCEhbG3R/e4BFfPm2mdmbW/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aGSDZfP4si2WnoAhcxYvvep3j6Lda9rq6xUkFyebh8n3h3Ak15Uoe6w5zTpA/TeP7/3M15Pr96TOqR9SJ6HxRsVO2a0k8Y7VyHOGWGliOVcqV2NDAksUYCX+npxwZ+tZ3Furtbsjb42Rp80n9m/7d/hEioR98gp2O8oZnfj59NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=GmNFvO/m; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9C857404E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1740169575; bh=frRcChxiUOHYxrTxtkNQKCSJdRbDaRzKsG89zMOYTcg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GmNFvO/mXRqZnXuhHjsf8d+u1iVJdDN1//BRqQhTLQmE8HA3vK80SowGvivt6kIxy
	 APxBOUbCROQzXz8AuAQJD25AUpm1vNuuigNQQGO5eM/F1IiCNfyJ2YGhWiwaPkvOwY
	 H9T8G4wC1HDUXyX2UqHnUsbte8qbWg8jkxW/KcQfv9duFX/NDv6rdJhmQ0QFziu5/3
	 cGW6Vw3+Fxoy6jO6+Ytntjc1UQv4SKDbfNl3SKQK6j7SX2vTv8eSp3PW9rb92RDDR2
	 STEUp87suhw178wfNh0SV8/9zypHGtMqzTzCIHzWMFtDQt92N7m9O0K51p2dvK8uqS
	 e1UbCkruNTtCQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2d7f::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9C857404E4;
	Fri, 21 Feb 2025 20:26:15 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Brian Ochoa <brianeochoa@gmail.com>, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, x86@kernel.org
Cc: Brian Ochoa <brianeochoa@gmail.com>,
 linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: arch/x86/sva: Fix two grammar errors under
 Background and FAQ
In-Reply-To: <20250219150920.445802-1-brianeochoa@gmail.com>
References: <20250219150920.445802-1-brianeochoa@gmail.com>
Date: Fri, 21 Feb 2025 13:26:14 -0700
Message-ID: <87ikp3gi3d.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Brian Ochoa <brianeochoa@gmail.com> writes:

> - Correct "in order" to "in order to"
> - Append missing quantifier
>
> Signed-off-by: Brian Ochoa <brianeochoa@gmail.com>
> ---
> Changes since v1:
> Reworded commit message
>
>  Documentation/arch/x86/sva.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

jon

