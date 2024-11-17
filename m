Return-Path: <linux-kernel+bounces-412083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D6B9D03B6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 13:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66AEF1F23320
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 12:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F991993BD;
	Sun, 17 Nov 2024 12:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="cYKSUioy"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F94197A67;
	Sun, 17 Nov 2024 12:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731846330; cv=none; b=EmSfa9HDxdcNvSKj/mcp2x6o5NCoJKFNbhRuIzYvIiZ3ccO8KlOpSwnAPMZIdPIuaOiLzO/2ZoOuI5ZvZCbGZ+3S2yafvk/vjRrEhFYepbSsyzjohjmCA//FvzYi6SPijwLBjtEPRlAGj/y0CXlmNYHhdtuhI2TJBAaaAxBujCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731846330; c=relaxed/simple;
	bh=UhQp5M75ttMDLLl4pXH8a9kqYD+N8w+1DJ5C3+ucOuY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m2WyOJO1J/PkQJFQxtRLxc67FmnfULs8Ido8Jr69CPSlIg0gvP8x/RloalqgcFVoWwTNUyDQPxI0vZtWGdEPgnBzYxCw0Rok2pSE8gnvu85vDr2XGlfyeKWDBdkItB3moS7Qh1xnAs/8nQwNdxRMvszgTg6z3A1h75Uo6Os3bXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=cYKSUioy; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731846324;
	bh=qEN0Kwz7qB+tHJIFoBnHGZnsWkjyVi0fv3pOXXkbJ4A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cYKSUioycv3kazqMia0kRCu1mC2T3aI4KdTicIV/2W1oKwKPEVW+okcxOW4xrj91D
	 COm+slZWPPTET2a7yJV2R9Q0Xp8uvlV1CqQ9Q+bnuWbCC8nc/rJmHc1eO4O4RAzlaH
	 UxDigqpCaKP4lWGFussuMuM6hHw53Bxb0kJJVdccjs80M3vLEghPdbkwLcdLYx0eG4
	 wPlcbrD9AYZxYVzgsxbDprDwga89bXqip+Qv8yc9rqcAkFROxhsogS02vMUVZ+7gK3
	 +07l7ro2WA/WTBNKIFcvDTOZNQsXRbdhH/BRBTegDBS5My9SzAJgdGMjLSWDq3jWAm
	 XyrTs+eMBL1Rg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xrqhz3M4hz4xdg;
	Sun, 17 Nov 2024 23:25:23 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, Johannes Berg <johannes@sipsolutions.net>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>, Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
In-Reply-To: <189b93e2-4e81-438d-9c77-cbe4d9d7a0d9@web.de>
References: <189b93e2-4e81-438d-9c77-cbe4d9d7a0d9@web.de>
Subject: Re: [PATCH] macintosh: Use common error handling code in via_pmu_led_init()
Message-Id: <173184539767.890800.12330441666540799793.b4-ty@ellerman.id.au>
Date: Sun, 17 Nov 2024 23:09:57 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, 03 Oct 2024 21:15:45 +0200, Markus Elfring wrote:
> Add a jump target so that a bit of exception handling can be better reused
> at the end of this function implementation.
> 
> This issue was detected by using the Coccinelle software.
> 
> 

Applied to powerpc/next.

[1/1] macintosh: Use common error handling code in via_pmu_led_init()
      https://git.kernel.org/powerpc/c/352268dc6da7b422022541c2cf846663110f775c

cheers

