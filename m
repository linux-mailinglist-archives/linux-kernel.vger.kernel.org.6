Return-Path: <linux-kernel+bounces-284809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 224BA950563
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9501C24584
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9A319A2AE;
	Tue, 13 Aug 2024 12:43:53 +0000 (UTC)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A09919CCF3
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553033; cv=none; b=Kq12ya/lkCYt7agmUZ8xvF5xNJaoDpW2mWF3FdmYWG7U2EqA56S0zjbWjZ/egMYM+kZGrRsPQqRCYQLKeckFE/pkGtmxfbHDMQYuAC+cC+HRvdjPCSrFztqEzjyJt+kd6yXVAeDpiHHR1uYvzIxviJYR5k2VhhXpVsStS0noQ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553033; c=relaxed/simple;
	bh=iywICTYyQ4TYXkBo6AMZnGczjmmFtx3nsRjzm927WyI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rUdhbUcrECKGCrqbEPoV4suljhfqM5sWWxbMsfirHgIMaSZ4OhPtAN5u3Vv/Ot5g6hUTFQjgSqU6raDrXh4koqNVSjPwnzNsl2xjrXHUHsFgsMP3UO4ScjoyKEBIcTQgbLz4dUdq95adxjDrtKSfQgPoIUBNcyUzlibVwonzPz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WjrfX2PGGz4wd0;
	Tue, 13 Aug 2024 22:43:48 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Thomas Gleixner <tglx@linutronix.de>, "Nysal Jan K.A." <nysal@linux.ibm.com>
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>, Michal Suchanek <msuchanek@suse.de>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Peter Zijlstra <peterz@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Sourabh Jain <sourabhjain@linux.ibm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ard Biesheuvel <ardb@kernel.org>, Eric DeVolder <eric.devolder@oracle.com>, Laurent Dufour <ldufour@linux.ibm.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Naveen N Rao <naveen@kernel.org>
In-Reply-To: <20240731030126.956210-1-nysal@linux.ibm.com>
References: <20240731030126.956210-1-nysal@linux.ibm.com>
Subject: Re: [PATCH v2 0/2] Skip offline cores when enabling SMT on PowerPC
Message-Id: <172355300460.69780.8475775851092917266.b4-ty@ellerman.id.au>
Date: Tue, 13 Aug 2024 22:43:24 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 08:31:11 +0530, Nysal Jan K.A. wrote:
> After the addition of HOTPLUG_SMT support for PowerPC [1] there was a
> regression reported [2] when enabling SMT. On a system with at least
> one offline core, when enabling SMT, the expectation is that no CPUs
> of offline cores are made online.
> 
> On a POWER9 system with 4 cores in SMT4 mode:
> $ ppc64_cpu --info
> Core   0:    0*    1*    2*    3*
> Core   1:    4*    5*    6*    7*
> Core   2:    8*    9*   10*   11*
> Core   3:   12*   13*   14*   15*
> 
> [...]

Applied to powerpc/fixes.

[1/2] cpu/SMT: Enable SMT only if a core is online
      https://git.kernel.org/powerpc/c/6c17ea1f3eaa330d445ac14a9428402ce4e3055e
[2/2] powerpc/topology: Check if a core is online
      https://git.kernel.org/powerpc/c/227bbaabe64b6f9cd98aa051454c1d4a194a8c6a

cheers

