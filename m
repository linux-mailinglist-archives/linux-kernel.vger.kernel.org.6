Return-Path: <linux-kernel+bounces-396380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B26B9BCC5C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291871F2280C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A0F1D47D9;
	Tue,  5 Nov 2024 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNJy8gr/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DC31420A8
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 12:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730808529; cv=none; b=cVh6g5sNuEyI5rJi5BaE4e3wupJPU4IwM+L09q1tYuowUnj1RpUZN1635iiwNV8Sq36AgrvEpVFyzA5p3I2r4UZ5uxBPeYN542dvXUgJ40guSMLuARnyKdS8sqt3ZRwx2ft6f/hyjHDXZ6zGBloxqtZcdMWR5YHt/R/6EkLlMbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730808529; c=relaxed/simple;
	bh=3+foXM8xnS1OpF+Uo1xDiYRy/9Ln0IAUnPhy9K09zho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ih+zI/LZ6Zb4xqE4LW07C1xwACeUg+E18NAabFPYh/MzUX6ATZJNaHpJ+lgzE3Durgu27ZsSqni96K/JMOgPaNnHYaG34Qfb4V4sNqM3rlZUb9/IJq8gx/Gy/92GwZBrR1BbaI7dbqi1pnKVYnFjn8ubzVJDQyLiB+pvOSb9Tzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNJy8gr/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B54EC4CECF;
	Tue,  5 Nov 2024 12:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730808529;
	bh=3+foXM8xnS1OpF+Uo1xDiYRy/9Ln0IAUnPhy9K09zho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oNJy8gr/2r8QgMgKseNovWnEbtZBUhMLlygYbpMPDBcIYq/bwp2X3JIpmTChv0dgp
	 +GMFwAYeB1WVW/z1cwOQ9fzwWd1I663vJizP9uDNLasfY9ZjYQ4WZMurWo+DHacLFa
	 SewT/uKmKWGGZKydeAH2cp/tNr2gs2qxbAaO/+B1MQMbxv+j8tHjIJuCF5QF2NQRIK
	 DaX0oafocXAy8pxLeZSaslnd4rMBidjEZl7R5XCF6fhRthNy7SdKQq+1QPru3xBS4g
	 2YO2gDJPK+INnoyANQ1Wv9D0zMAFvZiyu3/BHmrB9q1OWxU1ERfaS+PKEk7sz4N7Q1
	 WWh67vpQijyQA==
Date: Tue, 5 Nov 2024 13:08:45 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V7 11/21] signal: Replace resched_timer logic
Message-ID: <ZyoKzeOWHmZLmWP4@2a01cb09803abb1ce3ad97aed0fef98f.ipv6.abo.wanadoo.fr>
References: <20241105063544.565410398@linutronix.de>
 <20241105064213.652658158@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241105064213.652658158@linutronix.de>

Le Tue, Nov 05, 2024 at 09:14:43AM +0100, Thomas Gleixner a écrit :
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> In preparation for handling ignored posix timer signals correctly and
> embedding the sigqueue struct into struct k_itimer, hand down a pointer to
> the sigqueue struct into posix_timer_deliver_signal() instead of just
> having a boolean flag.
> 
> No functional change.
> 
> Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

