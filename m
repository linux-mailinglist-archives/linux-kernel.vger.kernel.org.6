Return-Path: <linux-kernel+bounces-430440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D039E30E2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5E01672DB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 01:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD494F9F8;
	Wed,  4 Dec 2024 01:43:50 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D96917C60;
	Wed,  4 Dec 2024 01:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733276630; cv=none; b=cKXATF3n9KFuy/O9LEvRk4f5jP2yw1/DAO0hpPuIrILeCqJEO8mmI7KfMcP7YrslOFO4poC3aOE9c5Za+SJXPRBk1ubKLyrN0XzLQfAz78IixV6v+HroqkJls7Bv8JEKBqbXslX1fWTeZnzDXq0bSYCKcAVpfTcJpm9ctLeIeFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733276630; c=relaxed/simple;
	bh=LuuVXAlVpMzdyj2GZRhwna+hzeJ+5qkzHw7X632tjd0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cd8ejXnLDPDeawSWPcCu5lbaYZ2CyNXjh7ObE4fnO9mATVFtqCYY5nyMU0R9bF1Ab+TOYQEtb9J9JhzE0h0IrC2nFPgXqHc1QkBldkFcojcZIkh4C8eB04+S/MlJa3QYK/smgd/0105WE8dR8go+As/FC5b7Imd0EmcxFaebquM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tIeQO-000000005b9-1hBw;
	Tue, 03 Dec 2024 20:43:32 -0500
Message-ID: <05946af9f1c223bf20a43b9ced346e39e2f54cad.camel@surriel.com>
Subject: Re: [PATCH v2] x86,mm: only trim the mm_cpumask once a second
From: Rik van Riel <riel@surriel.com>
To: Dave Hansen <dave.hansen@intel.com>, Mathieu Desnoyers
	 <mathieu.desnoyers@efficios.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org, Ingo Molnar
	 <mingo@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Peter
 Zijlstra <peterz@infradead.org>, Mel Gorman <mgorman@suse.de>
Date: Tue, 03 Dec 2024 20:43:32 -0500
In-Reply-To: <4360210d-0656-4328-ab67-240465ab2f9c@intel.com>
References: <202411282207.6bd28eae-lkp@intel.com>
	 <20241202202213.26a79ed6@fangorn>
	 <5dcb4050-f0f3-43d6-b4b1-42fa305a0fba@efficios.com>
	 <20241203144845.7093ea1a@fangorn>
	 <5544716d-31be-40c6-a289-030220e518de@intel.com>
	 <cc6d6e0be9b4fb61228f42ad82a057f60a1c1e12.camel@surriel.com>
	 <4360210d-0656-4328-ab67-240465ab2f9c@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Tue, 2024-12-03 at 16:46 -0800, Dave Hansen wrote:
> On 12/3/24 12:07, Rik van Riel wrote:
> > The tlb_flush2 threaded test does not only madvise in a
> > loop, but also mmap and munmap from inside every thread.
> >=20
> > This should create massive contention on the mmap_lock,
> > resulting in threads going to sleep while waiting in
> > mmap and munmap.
> >=20
> > https://github.com/antonblanchard/will-it-scale/blob/master/tests/tlb_f=
lush2.c
>=20
> Oh, wow, it only madvise()'s a 1MB allocation before doing the
> munmap()/mmap(). I somehow remembered it being a lot larger. And,
> yeah,
> I see a ton of idle time which would be 100% explained by mmap_lock
> contention.
>=20
> Did the original workload that you care about have idle time?
>=20
The workloads that I care about are things like memcache,
web servers, web proxies, and other workloads that typically
handle very short requests before going idle again.

These programs have a LOT of context switches to and from
the idle task.

> I'm wondering if trimming mm_cpumask() on the way to idle but leaving
> it
> alone on a context switch to another thread is a good idea.
>=20
The problem with that is that you then have to set the bit
again when switching back to the program, which creates
contention when a number of CPUs are transitioning to and
from idle at the same time.

Atomic operations on a contended cache line from the
context switch code end up being quite visible when
profiling some workloads :)

--=20
All Rights Reversed.

