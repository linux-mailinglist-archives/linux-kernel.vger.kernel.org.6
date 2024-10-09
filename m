Return-Path: <linux-kernel+bounces-356327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B0A995F9E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51498B22046
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 06:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF23156653;
	Wed,  9 Oct 2024 06:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J9pHK/mW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SqKQiF0s"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AE114E2DF
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 06:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728454825; cv=none; b=iQy32ATpojqMMHzm5VcQApkgb+G1XOJAKHid5A81SasWhraCEo6vRZOy0kpTpDkcCuBWCK/hbIblgxoHNWsxja3Fvr61pBdECg7Hia5a1FW+tIxteKm9GJ/6p1USpuR0LBsEQLOmeHh4e5u8fZjFDzMAMcW7vXlsHgU8Pt1zXYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728454825; c=relaxed/simple;
	bh=2XH0J7jOoBMeAciPFMqF/1JbqTrR7NkEoJKOZ3NJ8U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNsJQPF42dIxUuRbCcIst0x+M6lBjCltE++HdPLzavUJ+3jm8wZeizzN5ayZko5GUYJTno2FHKGhefruTjesKY//QcxaYwXKQ0R1n+n476U3b9Qczb6KXahCNeaoVfzpEUvoS44X4LuMe2Vyv0jUn5KGRR5DPBwVIi2vZrOk14Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J9pHK/mW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SqKQiF0s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 9 Oct 2024 08:20:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728454821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+i5K9jxY6WjZBaL6cWTwZPS9mYTve1OT3gIMy6B5q4=;
	b=J9pHK/mWGdQC33lMC0XLBRL0WOI0aydM1EDESC34poze07un4oGy+Mt+lO4uVM7iPv//K7
	tYSSAxl2qqY/sLcMDnCmT8Pao/8xqjineOhMh/7VpRcjyMxTiTK06o0BbHOdTLt618M8BC
	b/DGeCbsDepm6dsxbvnW6pwnUM3e/U18xc75yC+tYbOeRBYaMMB6kT/YX8sAzzFimZtOgw
	kvArZAAj5Xr+/uMVsYDgeY4bzA2EDprl6etlYz7WEpmFMpUKpzMMz9qRfp7oaYpUTo9ANR
	Y1rXL/W0wdt/gS34dTe+X78YLayzFfDvZgy9azglDw1p5g2F5BSX6AVCTQ2H8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728454821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+i5K9jxY6WjZBaL6cWTwZPS9mYTve1OT3gIMy6B5q4=;
	b=SqKQiF0sl6thuaPM2EfPBNneeGHK5NQazb+2XluBVMbk3m/cqDPw3pLbLjQpdkGErtZk/7
	xmfA4oWiY34uz1Cw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
	mingo@kernel.org, linux-kernel@vger.kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, efault@gmx.de
Subject: Re: [PATCH 0/5] sched: Lazy preemption muck
Message-ID: <20241009062019.1FJYnQL1@linutronix.de>
References: <20241007074609.447006177@infradead.org>
 <20241008153232.YwZfzF0r@linutronix.de>
 <87wmihdh3u.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87wmihdh3u.fsf@oracle.com>

On 2024-10-08 21:40:05 [-0700], Ankur Arora wrote:
> > While comparing this vs what I have:
> > - need_resched()
> >   It checked both (tif_need_resched_lazy() || tif_need_resched()) while
> >   now it only looks at tif_need_resched().
> >   Also ensured that raw_irqentry_exit_cond_resched() does not trigger on
> >   lazy.
> >   I guess you can argue both ways what makes sense, just noting=E2=80=A6
>=20
> I think we want need_resched() to be only tif_need_resched(). That way
> preemption in lazy mode *only* happens at the user mode boundary.

There are places such as __clear_extent_bit() or select_collect() where
need_resched() is checked and if 0 they loop again. For these kind of
users it would probably make sense to allow them to preempt themself.
We could also add a new function which checks both and audit all users
and check what would make sense base on $criteria.

Sebastian

