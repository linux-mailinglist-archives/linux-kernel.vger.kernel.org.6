Return-Path: <linux-kernel+bounces-250661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A78292FABC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B34C283033
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7857171098;
	Fri, 12 Jul 2024 12:53:57 +0000 (UTC)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8E316F856
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720788837; cv=none; b=XTipcVFY9Xo/GIhTorS9/QaVOGyrtqp0V/gfwMn65MfI0KgwjrHrtu6yCkEN22LuC5N7E1ckcVmnnIj9s2rV1rmjsFaKkyNMQ1KiBmNdnmAiHaekh+oiKjmMKLO2itViLqPPcHiFpAEyg2KsRXGwblulYHFD5c/8pot+52ZbgnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720788837; c=relaxed/simple;
	bh=/4cY90ODw2YhhtNukeJTzWx99qRyTdoKxmZbXQb+myo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=i3eyNNFwoxaSC5ctdTxQaFTZJZbx2UQKdPcNrC4ARY4JsGrOMsq2aOEbpGk8E7jlO5iiUKWTCAF9Vd93lHX+fR1m2O/o+u05l65otpvyPuctlZeXlpMVabF5g+F6jT1jAF9wNPu/6EPgyL7oo/6Q9zx1cwjEXpYNLVHtu+UNGB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WLBNx5qhvz4x1V;
	Fri, 12 Jul 2024 22:53:53 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Nick Bowler <nbowler@draconx.ca>
Cc: Pawel Moll <pawel.moll@arm.com>
In-Reply-To: <20240711035428.16696-1-nbowler@draconx.ca>
References: <20240711035428.16696-1-nbowler@draconx.ca>
Subject: Re: [PATCH] macintosh/therm_windtunnel: fix module unload.
Message-Id: <172078879460.310795.17178596698046388308.b4-ty@ellerman.id.au>
Date: Fri, 12 Jul 2024 22:53:14 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, 10 Jul 2024 23:54:17 -0400, Nick Bowler wrote:
> The of_device_unregister call in therm_windtunnel's module_exit procedure
> does not fully reverse the effects of of_platform_device_create in the
> module_init prodedure.  Once you unload this module, it is impossible
> to load it ever again since only the first of_platform_device_create
> call on the fan node succeeds.
> 
> This driver predates first git commit, and it turns out back then
> of_platform_device_create worked differently than it does today.
> So this is actually an old regression.
> 
> [...]

Applied to powerpc/next.

[1/1] macintosh/therm_windtunnel: fix module unload.
      https://git.kernel.org/powerpc/c/fd748e177194ebcbbaf98df75152a30e08230cc6

cheers

