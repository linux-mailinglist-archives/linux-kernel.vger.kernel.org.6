Return-Path: <linux-kernel+bounces-226485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8920913F01
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 00:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8445A1F21510
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 22:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45960184126;
	Sun, 23 Jun 2024 22:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2aXlrhZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8966765C
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 22:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719182470; cv=none; b=MZTa6ksp4djJrvFEiV83WbrLqrlG4bA3fiLmj9LqetqeRMeAGiZv2RI4MhwBEvQB8STyFGnPfAaUmlgnEK/YlQ1c1DIGiaKL9tXY+wxYplEY5eVFYYrgMAfN3ui0rrtoTnh7YBH8hARj7ROV+6ZiRrzVVR+xVoEPPEMeWEMp13s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719182470; c=relaxed/simple;
	bh=T8W4qtQfYosHHgUeJlreDGpeDtios4GOT7uKsJGV8aY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNhskYsKVzUkHVd0e8ndEQM2fUvxcLfooK6h2Os4Ma/r9YrCialFMfYLiA5RaNXmqdQ6++6ubt4G5A3JWo8alMPVWWDubaGgvX0FgfPbV7JPnvKDadq4BCKAT+T6cFotr+6SiUcpapdZQXILcTqZyGY/AQb78W+XGQhKFCe5Cm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2aXlrhZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBA9C32782;
	Sun, 23 Jun 2024 22:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719182470;
	bh=T8W4qtQfYosHHgUeJlreDGpeDtios4GOT7uKsJGV8aY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f2aXlrhZMA5DSiIAWJWF9qwR3qEm1kuHA4ZNdK637YPL/22Wa3HN2JS5K0agwv8bx
	 kX7pcKkzxeoBvcclJA+89CRwsPuc5QB1q5UICRqGx1J/X+HrPSAWj42KuWrPN3Z6p9
	 3gA1HuTIvTAddDw3HysgA+IAFhTZ9uLJUCUpRhtRyyGbbS+595TJjt53yRsl2bhuNT
	 WYHdP4kARBuIMpylxld5/7QK/+8bMmSo89gQNqgo68kfXRaXqPBm0wXWRcafs0SBqD
	 zhfjK4nskBhMoJU+f9cn+wD4PaCGgttaeCNRRzw72Dn9Ha4Mipo/xuxXq9nmdMDCHx
	 jNL2Co4s77vAA==
Date: Mon, 24 Jun 2024 00:41:07 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V3 16/51] posix-cpu-timers: Simplify posix_cpu_timer_set()
Message-ID: <Znikg9RypWnjBxRn@pavilion.home>
References: <20240610163452.591699700@linutronix.de>
 <20240610164026.489279861@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240610164026.489279861@linutronix.de>

Le Mon, Jun 10, 2024 at 06:42:25PM +0200, Thomas Gleixner a écrit :
> Avoid the late sighand lock/unlock dance when a timer is not armed to
> enforce reevaluation of the timer base so that the process wide CPU timer
> sampling can be disabled.
> 
> Do it right at the point where the arming decision is made which already
> has sighand locked.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

