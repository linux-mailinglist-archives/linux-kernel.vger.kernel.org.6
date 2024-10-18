Return-Path: <linux-kernel+bounces-371596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E079A3D0E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198B71C211CB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35A7202F73;
	Fri, 18 Oct 2024 11:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GmTFyuY8"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507B1202F6F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 11:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729250037; cv=none; b=j9SMHDbkK7gEVhWXmiWgj+zMV3Aw3OMfKm9yw5F8d+X1Y3Y7vEWLllDAZz8lcafaiMKqJHw1Jv2zkpunKzjMRl5XB7V3BPI/YPx6CkbnkxBy4NBHptdIlmymPyd2OVT3aTuZp75v8Rlic7CL7/XTDpM0b7mFthz6t/6v3BSz2PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729250037; c=relaxed/simple;
	bh=LP3haA7d+OoJSxhlWG5Y0d6CbvOQsn5QrGtxSj4Pz9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODVTPL/gRIOKW2J/erMz7cIFPoCXwjNdN4qPN2G9SQR4WnRsu49d49KQLOAySnDL/o+dazbmkVnAa7PISlyiMpAX82MKgH57Yao7YJjoqgyMdl9WlsPLZMuWVCWIAMCE6ymXaPcDRx3h1GeJlUTmJtpoJBjm9wmB/UT9lj4cfi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GmTFyuY8; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R2RqkZkmN0VlXxNgjvRznKQvYVZWzsGPLJdUJbM/oPc=; b=GmTFyuY8EMFURb2jybowygINfT
	zz9mDMpYeoY8+5rNySkuR31dLaAj65WLvVWvPtsU8Yu23lzPmKBCoHiOiklO+W6HWlu9ZXb5p2ZuP
	drrzg2rt3AdR393g+ktgH/PB+wG/oV1TSvyszkyhtAOtHJbDqhIxxK4Rrnk5uZ/Wbl8NztUo+7+PV
	zuttj09CRVDXxjOt+rAbFEafOPsmkKOgJbNBOilECELLdHUgbO/WewmiInEg/hHTZ6CgXVXkKx1Oc
	W4rDtr2cr2F72i271X1Kw6/TBErlzsMmf+3BQzXypAgIKUqus9uvfEZri7kE1hi/oXmukXdltmUch
	Mtw/YlQg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t1kvU-00000007LDj-2doZ;
	Fri, 18 Oct 2024 11:13:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 07BEF3002D3; Fri, 18 Oct 2024 13:13:48 +0200 (CEST)
Date: Fri, 18 Oct 2024 13:13:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: mingo@redhat.com, will@kernel.org, longman@redhat.com,
	linux-kernel@vger.kernel.org, tglx@linutronix.de,
	paulmck@kernel.org, thomas.hellstrom@linux.intel.com
Subject: Re: [GIT PULL] LOCKDEP changes for v6.13
Message-ID: <20241018111347.GX16066@noisy.programming.kicks-ass.net>
References: <ZxHq7-o8vV07M36J@Boquns-Mac-mini.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxHq7-o8vV07M36J@Boquns-Mac-mini.local>

On Thu, Oct 17, 2024 at 09:58:23PM -0700, Boqun Feng wrote:
> Hi Peter & Ingo,
> 
> Please pull the changes of lockdep for v6.13 into tip.
> 
> The following changes since commit 87347f148061b48c3495fb61dcbad384760da9cf:
> 
>   futex: Use atomic64_try_cmpxchg_relaxed() in get_inode_sequence_number() (2024-10-17 22:02:27 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux tags/lockdep-for-tip.20241017

If I managed the git magic right, this should now reside in queue
locking/core, and is on its way to tip.

