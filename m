Return-Path: <linux-kernel+bounces-226440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A887E913E63
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 23:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10066B211BC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 21:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD7A18508E;
	Sun, 23 Jun 2024 21:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsfStvg5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E434918307B
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 21:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719176650; cv=none; b=CZIai0xWGnHeroiA17WUQrkjla8rVI99xg9TpvyXEbXtVwRvnXbUcPt1PwPRXEUTF/rlxTOJomrg0dR/8rS3skttmypV+Jq3DMgHQZbSE4L0jMVzcLSbSiRTHeHO7+u2XS1KEm6EHymt4y3aOxYlX6ga3bfr9cY3QaO97uaGVfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719176650; c=relaxed/simple;
	bh=yFNf4vns4BOm6RZJ6vJ+2rPtWpv1qS8CSRlZdpmW4Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmmsCOArFrHCe8S+tnzN3Ij+HgJ/OH5QHGN0cR3NGVKfOcT8shiB2GDj4zNZmNy5V3V+gmOSPf7ciZuxXWe6deget7BPX4ISst3ry2294hzAM+vXwbrKMvMKMBokphWCi5ZLbv1AkDHMZbl0AsKoA6tKJKNnOU5hLGBCwI5JE1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsfStvg5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F59C2BD10;
	Sun, 23 Jun 2024 21:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719176649;
	bh=yFNf4vns4BOm6RZJ6vJ+2rPtWpv1qS8CSRlZdpmW4Ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FsfStvg55cfcG5hLKAUxRdMm+b2XNGpBZwaN34x4X+IEM1D5Rgx6N8mDj4itmKIYK
	 51NlnwpiSzobDRlKYTFy3O1bEsa7dKN4KHEHo011kpb4fXGrAgcNr4+fjiL1LcywKa
	 tiZOVQfmfEwVUcccFfr1HefUZCt8CUcAoCH3pnKMTHtN66tl+o50kBTbHZYjzoe5No
	 jQM02Me+/xqfuv1zhZ9MditCiQCd2MoBE6/kSip67xaHlKjPDU8QCnYlSSdUo/EQrd
	 +hRwPBD/7fRSRFeTPwN1d9+hNqxNvmJd0uNNxfh1EEe/ML4kVg0zc7aUQBq4hrE9xL
	 lAPJFw0oTsSOA==
Date: Sun, 23 Jun 2024 23:04:06 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V3 13/51] posix-cpu-timers: Do not arm SIGEV_NONE timers
Message-ID: <ZniNxrr5TNI-HaNs@pavilion.home>
References: <20240610163452.591699700@linutronix.de>
 <20240610164026.299017301@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240610164026.299017301@linutronix.de>

Le Mon, Jun 10, 2024 at 06:42:21PM +0200, Thomas Gleixner a écrit :
> There is no point in arming SIGEV_NONE timers as they never deliver a
> signal. timer_gettime() is handling the expiry time correctly and that's
> all SIGEV_NONE timers care about.
> 
> Prevent arming them and remove the expiry handler code which just disarms
> them.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

