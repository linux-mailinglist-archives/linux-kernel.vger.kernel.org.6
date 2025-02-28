Return-Path: <linux-kernel+bounces-538176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A86A49557
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D52517268F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6614F25B688;
	Fri, 28 Feb 2025 09:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOUkbG5F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE7025A2B7
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735411; cv=none; b=kDs05DA/KXia6uZkzvBVzcKyYecvVejnDVwQan1t5dumWGCIX4LvjnymZhCvM2twh41L58GDZ4aqxmHFtKHQPotHKg+XKesdKCGmv675UXH6lSIBi8oU9yUG1Q//yfxNc0ahMfcI43tHdkC7gbD/gpNojMCNFvIjqT9/OYkaqWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735411; c=relaxed/simple;
	bh=6zsIwp+G3KnFeXe9QblTVPYl3pLcTHWS5uhWBROL3+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ccx+JA4vRvw9HjIBKdFZrAHbUGi6Oa2J1fEVwOSDiNUGZ7QJKm2c4FpEZ+s+PzvED0T4f31aVlmZPGf70fZZ7M3aEMLUYNtAqX0ekuTNn/Q58dmL7VoZvyUIFwKX80s8qKG5NtMtWj3qjRh7yxsCYPWZ7cvK+8xUKQ7mnafA6gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOUkbG5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0A2C4CED6;
	Fri, 28 Feb 2025 09:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740735411;
	bh=6zsIwp+G3KnFeXe9QblTVPYl3pLcTHWS5uhWBROL3+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OOUkbG5FMohwetnfSBmCK1760PoqKIqHQIb9rKZZWxrPMTRnld5b+zsNQtP7zv/1c
	 1ZW0nB2hwniJRPpXfdPOrMcyww1hbulc60OSeaTH5V+07XCQ8ImuhSNkpp4YsYJghD
	 Bf+AunLNTT80SaHK6mAHAtEwhe9kc9YhEpgf0uYOlpB+Pr9jIfx9LWY3OFv69nnGw3
	 Q5osoSzAIGGT3RcSu1QpwaNiOMYlKvzF1fCBC8Edpu6rs7h4ZUaiVD7YzTy2GQzUim
	 XNjnv0WFKgdxI6zcHBuNgUmIB0DKqI4PcwLXHiOZopTI63Er9+CVuzP+X8qoVD+8a7
	 +EdwCyQG1HV/g==
Date: Fri, 28 Feb 2025 10:36:43 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/speculation: Simplify and make CALL_NOSPEC
 consistent
Message-ID: <Z8GDqxTNN0rLBbrX@gmail.com>
References: <20250227-call-nospec-v2-1-895a30dceaac@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227-call-nospec-v2-1-895a30dceaac@linux.intel.com>


* Pawan Gupta <pawan.kumar.gupta@linux.intel.com> wrote:

> CALL_NOSPEC macro is used to generate Spectre-v2 mitigation friendly
> indirect branches. At compile time the macro defaults to indirect branch,
> and at runtime those can be patched to thunk based mitigations.
>
> This approach is opposite of what is done for the rest of the kernel, where
> the compile time default is to replace indirect calls with retpoline thunk
> calls.
> 
> Make CALL_NOSPEC consistent with the rest of the kernel, default to
> retpoline thunk at compile time when CONFIG_MITIGATION_RETPOLINE is
> enabled.
> 
> Also add the missing __CS_PREFIX to the CALL_NOSPEC macro to make it
> compatible with -mindirect-branch-cs-prefix.

The __CS_PREFIX change should probably be a separate patch.

Thanks,

	Ingo

