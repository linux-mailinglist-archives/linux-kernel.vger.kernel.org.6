Return-Path: <linux-kernel+bounces-392216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 939BE9B911D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B23F1F22BEF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E938319D08F;
	Fri,  1 Nov 2024 12:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLuYQXS1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E7C19AD97
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 12:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730464010; cv=none; b=fwxn1lSkLZJkKreYT0OkSFSP/Q89RtTOFHCz3fg9RhELS+x5FcQ4poEvd2RIT4qQN2ngX+/2ce2qNMt5EI9Yoa7XcLQHtyVxecATu3DPM6RhqP+fQpWcdsoaLvhBBNDWUNXqXtlTtr3aEnj01YvEYyrmawFtKNKTO6eHjgXinoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730464010; c=relaxed/simple;
	bh=yKoZepCE3gsGUKWQJXFe3pcsTqEDFRetaWkvECHl+h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TE7vRbi8F8e0tqY89jsg/zuLkPw1ACeMy7p+7n6DOWQZx6xuP5jMcCeUm/ZJGGbFIxNOV3wFBIUGw/2DD8KTAOXJ2BxNNQ7xyoaAZbiiAWOpZgMjBDnLKFDoo1zKjcKbIhET6H0e/3WlZxp/Lbap1pWirmgGQBs1a/w7vtTTM6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLuYQXS1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A02C4CECD;
	Fri,  1 Nov 2024 12:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730464009;
	bh=yKoZepCE3gsGUKWQJXFe3pcsTqEDFRetaWkvECHl+h8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XLuYQXS11N6qdB7hsk2SFC0BD+DRvdnrZ91auXmnOub8YXcS+X5idrBkmyxPSDYFu
	 VLYDeBq7Pb8QDOYrj7ByRvxAhgs0RdLcKpq2fB9e8T7HRwDNqxXuV7MbN/7eXh8BgD
	 QLrQTCa28pBst5i0WjG5WZIzw0ukLk8uux++TRGJSZYUWMx8/+4wN8XeiysI/l+UGb
	 9mJAj4eDM9pt2Rl6QrqOmMIv3zTo75HixuAmlMlGuoQCKJ8EB0o3u0SjiR18HzOb4u
	 Z5n6ymDzvJZZsTjUuzWckPFLdrf9gP4BMOiwrKPVuQtgDfFNRdUvr2UmC0FrjwwrcM
	 2t7srvETOTuzA==
Date: Fri, 1 Nov 2024 13:26:46 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch v6 01/20] posix-timers: Make signal delivery consistent
Message-ID: <ZyTJBkZG-XT1crWi@localhost.localdomain>
References: <20241031151625.361697424@linutronix.de>
 <20241031154424.613821401@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241031154424.613821401@linutronix.de>

Le Thu, Oct 31, 2024 at 04:46:24PM +0100, Thomas Gleixner a écrit :
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Signals of timers which are reprogammed, disarmed or deleted can deliver
> signals related to the past. The POSIX spec is blury about this:
> 
>  - "The effect of disarming or resetting a timer with pending expiration
>     notifications is unspecified."
> 
>  - "The disposition of pending signals for the deleted timer is
>     unspecified."
> 
> In both cases it is reasonable to expect that pending signals are
> discarded. Especially in the reprogramming case it does not make sense to
> account for previous overruns or to deliver a signal for a timer which has
> been disarmed. This makes the behaviour consistent and understandable.
> 
> Remove the si_sys_private check from the signal delivery code and invoke
> posix_timer_deliver_signal() unconditionally for posix timer related
> signals.
> 
> Change posix_timer_deliver_signal() so it controls the actual signal
> delivery via the return value. It now instructs the signal code to drop the
> signal when:
> 
>   1) The timer does not longer exist in the hash table
> 
>   2) The timer signal_seq value is not the same as the si_sys_private value
>      which was set when the signal was queued.
> 
> This is also a preparatory change to embed the sigqueue into the k_itimer
> structure, which in turn allows to remove the si_sys_private magic.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

