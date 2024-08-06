Return-Path: <linux-kernel+bounces-275836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24747948ACE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B39BAB25140
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D98E1BBBE0;
	Tue,  6 Aug 2024 08:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WRrQzINO"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797AC28F5
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 08:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722931409; cv=none; b=QXWQOPscFDGOE4vxg70B4A40pprEIE3EHSyfm2mRVztPcaGAUCua0bw6pTsKF29NWfYigyKZc4V23C5YvgJilen8YlqujX85cFESZctAIdzExZG6chic7Xns7Gl+FqbQtjcvEAU3EN8XIbtLJgFDq3OeYJM4uIEzLUixAj0sPzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722931409; c=relaxed/simple;
	bh=xUbEDe8Ju4tZyZi6DkwHyzxRu+sNl4qqdn3MR2Ct9bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heeRt0DWD3yOdntmhdtUrySG8nb+wOWB3hBP15CbNl2GbrMuadYDTeodzmhvfGJHKCtVKnDdOE9wyNdIBrBA2YnMUjsQpWNdv1EXpKh2OFyW5QbTFCg1Ilq0vqrRhpmVveGGXKaUMw+o7HRNi7N9AIrmltIzSAetHYkm09cYHWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WRrQzINO; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 6 Aug 2024 10:03:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722931404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ha85jh06ju2ec3M6eRrZItHlhVDmC4EM/7NItagZQ6A=;
	b=WRrQzINO6/pcFc2X+Qn0D1xCm1LCIlAS5BXaDHH2iAtz0z/gvuY+2/qdve+Fbxt/fwK0az
	k1cQHSnhbB6EU/BXNUoulEpY9YvGeSD4GUzwN27LHJ5AqFFKgjU/cRDeWEOS8Eqg9iLBLR
	9mYk9u14+hQJfRS4q7iO9UeeQNj1XCY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Mark Brown <broonie@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Joey Gouly <joey.gouly@arm.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: selftests: arm64: Use generated defines for
 named system registers
Message-ID: <20240806-7d137744fa04e05689efac71@orel>
References: <20240802-kvm-arm64-get-reg-list-v1-0-3a5bf8f80765@kernel.org>
 <20240802-kvm-arm64-get-reg-list-v1-2-3a5bf8f80765@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802-kvm-arm64-get-reg-list-v1-2-3a5bf8f80765@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 02, 2024 at 10:57:54PM GMT, Mark Brown wrote:
> Currently the get-reg-list test uses directly specified numeric values to
> define system registers to validate. Since we already have a macro which
> allows us to use the generated system register definitions from the main
> kernel easily let's update all the registers where we have specified the
> name in a comment to just use that macro. This reduces the number of
> places where we need to validate the name to number mapping.
> 
> This conversion was done with the sed command:
> 
>   sed -i -E 's-ARM64_SYS_REG.*/\* (.*) \*/-KVM_ARM64_SYS_REG(SYS_\1),-' tools/testing/selftests/kvm/aarch64/get-reg-list.c
> 
> We still have a number of numerically specified registers, some of these
> are reserved registers without defined names (eg, unallocated ID registers)
> and others don't have kernel macro definitions yet.

FWIW, the "ARM64_SYS_REG(...encoding...), /* NAME */" format was
intentional. The idea was that when get-reg-list outputs new or missing
registers it discovers, or the user lists registers with --list, the best
it can do is output "ARM64_SYS_REG(...encoding...)". Putting that format
directly into the test enabled copy+paste of the list output into a test
case. However, the lack of names did lead to scripting the generation of
the name comments, which means it wasn't a direct copy+paste anyway. The
other benefit of the format was being able to directly grep the test for
the 'missing' registers. Anyway, maybe always going through asm/sysreg.h
with greps of '...encoding...' is the better approach.

Thanks,
drew

