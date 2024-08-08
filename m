Return-Path: <linux-kernel+bounces-279917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 288FE94C35C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D31731F22645
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807B11917CB;
	Thu,  8 Aug 2024 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fqp/ny5y"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AF4190067
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 17:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723136936; cv=none; b=Syz+dil/OPyvGEkv/4676/MWJZtefByiEt71yFMUkDK54DysH8iDQ5y1q3AJO8SCVMz8ObRsjhHAE5Iste3AEmaGH28XyI/Ejz7A1aZJ5uRa8FtyMhhOL2oF3fOJuEdsal3TEcjmwwWiwcebhTAHjwryuMiHjmTB2NuVLXH6qCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723136936; c=relaxed/simple;
	bh=o0ouofDivzDbVdCcNXL0wzjNSLS++RMw3fLPLc5jUAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRndHJRShr86ZpbP3yDIHo2W/W3g8w0nWcodX0tuRoXwGjbkXmFfztAlZjsuEAXpgzFdEXIZBlJNz8aUf0fWmYpmqYV88MTivI/aIls45zLk4qcNm3OJWVxelwfc8D/pMwggDcUmqKYvNn9T8NLEz9hgn/bIiik1pbUiUbHx+xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fqp/ny5y; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723136933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=679sHMsabQp1CD97OrRjCvkbuEAESk7cJl/f+me4pGY=;
	b=fqp/ny5yotKGef+lDwkniatECMpL5V1HO51qnVHw1IOlkhI8j9MPnDy4v/e6fscj0wd6MM
	qAMExeEQ0gV0CmX4aRfZxORSBK7GGuV9LeW2JQ6EBSlgXQ2r/LNMaOUIUDyTDuPFppxBFQ
	1rSibq3s456e34UwcxlszZEp1kS2c1A=
From: Oliver Upton <oliver.upton@linux.dev>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	James Morse <james.morse@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: arm64: Correct feature test for S1PIE in get-reg-list
Date: Thu,  8 Aug 2024 17:08:40 +0000
Message-ID: <172313677522.561165.3929802952412744723.b4-ty@linux.dev>
In-Reply-To: <20240731-kvm-arm64-fix-s1pie-test-v1-1-a9253f3b7db4@kernel.org>
References: <20240731-kvm-arm64-fix-s1pie-test-v1-1-a9253f3b7db4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Wed, 31 Jul 2024 17:21:13 +0100, Mark Brown wrote:
> The ID register for S1PIE is ID_AA64MMFR3_EL1.S1PIE which is bits 11:8 but
> get-reg-list uses a shift of 4, checking SCTLRX instead. Use a shift of 8
> instead.
> 
> 

Applied to kvmarm/fixes, thanks!

[1/1] KVM: selftests: arm64: Correct feature test for S1PIE in get-reg-list
      https://git.kernel.org/kvmarm/kvmarm/c/ad518452fd26

--
Best,
Oliver

