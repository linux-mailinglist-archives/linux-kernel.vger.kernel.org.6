Return-Path: <linux-kernel+bounces-169424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CB48BC878
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5879E1C2088E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EC3127E3B;
	Mon,  6 May 2024 07:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QEOvWDyO"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A2E1EB36
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 07:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714981168; cv=none; b=NaRzWVF6ovhsK6QuQDHbvUQPzAXZjEH/ZaeoNCQuwkCW9F3rfBXezhZYNTZwOAN/0VPietySd5y29CLtDQk5ku64IK5M2OctY5hEGNtKIxAhmxku+Bb/Zm3LxtCxPq5Vauf6w2B1To/jfMdPQdEOO/qyA5nhWRYLG1BfR5tSnHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714981168; c=relaxed/simple;
	bh=xyxnmqWWSYlgj6H8EbU54BPfhvA1yRIWCx+gjGOZiJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLqxzr8wrtaOtWiVIZtZUHn9DdPWrgTKDISLFd3uQAJ5wXv9aKDiw9y6vuwLvbCS3Gy4ufec+rAffQh8mCcwXebLfklGYv/OIkJlzHi2WuJbFHjleByf04DH6QXEBufe67nlatnPgWIyW7wJztH74yptrWIbAMyZak8dJnvCuqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QEOvWDyO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F1F1340E01A1;
	Mon,  6 May 2024 07:39:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pMqRuncUN6u7; Mon,  6 May 2024 07:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714981158; bh=njZ0/dlsf3FYOxYPVXuxza8YFGw4Nsa8EdWHjWc6X0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QEOvWDyOezcm7lK+A5QpHp1aRlW/0+ad04iJQQPjwjdVEW8HXghemVlQyQ5GcPUis
	 nVbgmQNKBeNHvfYXMjO9RmAweU2EkZ6xAra89ybhJ/lH8+a6dfteH4D1QKp9sJcUkg
	 S/zYEqFJ5a7dRJf4Mp6YF+w2N3H91XLA88uhKD82YvFlNYe6a1o0paYJhZ8xbPvjI+
	 gWbT4PNwyNVWhukjdh9D/jZvLdNnQ//kTahiEAbixT+XjBOp0bCIhCnxdus6i+M4QH
	 rqD4eXh1XZyVPvgwfNl6F1xGEg+R1HaOapZ/nCtS6rLxsNFG8d1/tNhDzEw9ijGJ2r
	 OIK1LUPD56InScrkD/WEYi2rodQVi1d1malMA6ERj15sp80C/KM+pI+hmfbUPi1QmZ
	 Y/y/vClyw35b64a9UGcJSkUAcbhoyDzf/w8bCtuoqwPuqIS3UzrvzkXQJUpMUMkCzb
	 EqrXiZKOeZrBYMIahntZdZVo63OWLMzHqclqqmRlSS1CEw43EfK/N4NzQh+ZClFhN9
	 AqYmYjuG9zAcuo7596ZijyGMbFACArMEZw1QHuYC2064S8h+bmQNfcptYCg0VMkYBr
	 yTviHgI0yKiXCOpNmKP/PlFB9uiHOVHnogu4M/cyFZr1M8r1kJgqz6OHlzXBVtq8RJ
	 rXJ0lwGSlQzkeuc42bvJAqqk=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8449540E0249;
	Mon,  6 May 2024 07:39:10 +0000 (UTC)
Date: Mon, 6 May 2024 09:39:03 +0200
From: Borislav Petkov <bp@alien8.de>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, Srikanth Aithal <sraithal@amd.com>
Subject: Re: [tip:x86/alternatives] [x86/alternatives] ee8962082a:
 WARNING:at_arch/x86/kernel/cpu/cpuid-deps.c:#do_clear_cpu_cap
Message-ID: <20240506073903.GAZjiJF7BQyjYJQLYx@fat_crate.local>
References: <202404302233.f27f91b2-oliver.sang@intel.com>
 <20240430172313.GCZjEpAfUECkEZ9S5L@fat_crate.local>
 <ZjE7DkTBSbPlBN8k@google.com>
 <20240430193211.GEZjFHO0ayDXtgvbE7@fat_crate.local>
 <ZjFLpkgI3Zl4dsXs@google.com>
 <20240430223305.GFZjFxoSha7S5BYbIu@fat_crate.local>
 <20240504124822.GAZjYulrGPPX_4w4zK@fat_crate.local>
 <ZjiCJz4myN2DLnZ5@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZjiCJz4myN2DLnZ5@xsang-OptiPlex-9020>

On Mon, May 06, 2024 at 03:09:27PM +0800, Oliver Sang wrote:
> we confirmed after applying them upon ee8962082a, the WARNING which was reported
> in our original report cannot be reproduced any longer.
> 
> Tested-by: kernel test robot <oliver.sang@intel.com>

Thanks a lot for testing - much appreciated.

Lemme queue them.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

