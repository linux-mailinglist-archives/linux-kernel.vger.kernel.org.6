Return-Path: <linux-kernel+bounces-228373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE069915EF8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 457B7B2135D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 06:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF2A145FFD;
	Tue, 25 Jun 2024 06:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PfaObVn7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a/pFdLNH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536A41CFB6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 06:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719297375; cv=none; b=gOZg3FLjAOFeQRVvJGuUDUGz0RAywW7sgDGLj2SZucw3aREggVnJuwNSTsLxedYGAw6MNnTneW6bmAh3SbJY1uTEtRs3B7hj0tusoOB3IBi0IX1iDqYZWg0y/AEC73OIw1hds24RDGYIsYsuCVqs53hi0lhL3w9BoE7sWHSR518=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719297375; c=relaxed/simple;
	bh=tK6NIb+hw+S/x16P5BrkWYts6gJEwvfxLSXDLL3RyWc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MBNglwhGAeNs2lb0NS+QeFMuVOFyg8Kr+d13imaBD1cuJ0BATZc7C7F9p5vNu+kmQqfCAmpgJSZpcEHUmidGd3Q82n6Aqk6zygsPnIon5NEMXJEfgCkq92NaE6L0gqN1dZL9lpANSLhPzBfzN7gErYssVgVQVeWsg+/zxhHJxNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PfaObVn7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a/pFdLNH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719297372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AY5U7uXGBfl0lHtaU3sKWVQ9KHyEs2m+fizS2s+IKiw=;
	b=PfaObVn7GlxH2+XGs7UutUEWPy44QY/6SEXg9EpElBSw1MgbgTJ2ypmEYmZbeJ+Nvm06Dd
	uV/evAZw7b1+5MOSlWlop41Ho0MFqjCo2uoQAFK7gemqS/go3jH+dRoMX2yQt8YbVLYOTo
	F+M1R2biSynzUqupGrlIktJQKDqV3YrQgM8XC91TYhTHTikJPin2xahkjpCuoBGcOlj78U
	4nFESZ+39lD9LZyVtVrtfP0F0X8Tt3Ox7m/+uVxj6dBs6SCKJbinfRct/LxqORl/+hpaG9
	JQulpYO80oYpiU4vmnMDman4A/9REG7G5y9I3paKnMa0MQQVphJEfwsejdVFUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719297372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AY5U7uXGBfl0lHtaU3sKWVQ9KHyEs2m+fizS2s+IKiw=;
	b=a/pFdLNHS9eWpAAkXqACk9e5RK+GJ4U+VgJat2qLLAO4bcisxgtQUKnjVK0jbXWE2hRQvo
	8qIemL7b6tvMpCBQ==
To: Thorsten Blum <thorsten.blum@toblux.com>, jstultz@google.com,
 sboyd@kernel.org, linux-kernel@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@toblux.com>
Subject: Re: [PATCH] timekeeping: Use min() to fix Coccinelle warning
In-Reply-To: <20240624062411.321995-2-thorsten.blum@toblux.com>
References: <20240624062411.321995-2-thorsten.blum@toblux.com>
Date: Tue, 25 Jun 2024 08:36:11 +0200
Message-ID: <87jzid7cmc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten!

On Mon, Jun 24 2024 at 08:24, Thorsten Blum wrote:

> Fixes the following Coccinelle/coccicheck warning reported by
> minmax.cocci:
>
> 	WARNING opportunity for min()

I'm fine with the change, but not so much with the change log.

You cannot fix a coccinelle warning. You can only fix the code which
triggers the warning, right?

'Opportunity to use min()' is nothing else than an opportunity, but
what's the benefit of replacing correct code with it? What does this
fix?

It fixes nothing. So calling it a fix is confusing at best.

What you want to say is something like this:

  Subject: timekeeping: Replace open coded min()

  Replace open coded min() because $GOOD_REASON

  Discovered by minmax.cocci

$GOOD_REASON is not 'coccinelle emitted a warning'.

Thanks,

        tglx

