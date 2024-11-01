Return-Path: <linux-kernel+bounces-392290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F869B91F9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E47C1C22181
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051FF19D089;
	Fri,  1 Nov 2024 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVVmwHg0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654709479
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467552; cv=none; b=BDuJtC0fBgY8NnzMeKfrT9uo1FxOVqiHMIFtynQkbajXA+ca7k5X0f+LE3MQobUEdCkRjGyaLq9RbSQWW3+8dWR8mnlNJhw50hgxSwmgl4TgpW+3GFt6oFh/iidiMr0hltX5eptHn6vLUmLLwwP3ip5BZP+Wf2nmFyldMbwBHIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467552; c=relaxed/simple;
	bh=I77E32RzdlVmUcQ2s4apwKXW4xb3kuZ1pr/dOKJ8Fe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTACtXKYJ06r3At75h5H2+sZVd9kUqo0of4QAPe53EohYPjijA6XOxnqZSqPv42mA6/h5L3fVoC9SpXg7X55qJHDa4askhZpjjA5p4z3ymYZIy1Gf4SuA9JcvrO4Uim6cnDag95eBkAnk7kMKMw1U5EAkL1O3DSiK3JpRqeGKE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVVmwHg0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E41CC4CECD;
	Fri,  1 Nov 2024 13:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730467551;
	bh=I77E32RzdlVmUcQ2s4apwKXW4xb3kuZ1pr/dOKJ8Fe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sVVmwHg0Squ41PW54Wm11c59LqJlEaUftXWKYatBitQhZvJqDe0soJkIBsPtgSggD
	 feZ4tnJqXnydNK7iTgSZGhhBSmIZGBaJ8rhwGS+jSsy3+zJqNm82xOmBOwAcQC7oVP
	 apo0TNx1VA9nbw4SFnwDeNK8uxbGqKSFg8MI3yk30jEA6FlPokmvZDJRJ2k8LM267/
	 CX5Zchl3lQubqHRv4Fdk1I+5nfq0/sgYB9rM1acZqMCd/Vc4+l1h2sdgR0ktHp/hjK
	 U4J1DUnig1G+GllcvsR2iROa2IWoZCPWrMkdLeU4+IvinfNZRKRfZrGQ707rnsVbvl
	 +eFm3Pxglu/Gg==
Date: Fri, 1 Nov 2024 14:25:48 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch v6 10/20] signal: Replace resched_timer logic
Message-ID: <ZyTW3B_zlbFskIzi@localhost.localdomain>
References: <20241031151625.361697424@linutronix.de>
 <20241031154425.182629074@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241031154425.182629074@linutronix.de>

Le Thu, Oct 31, 2024 at 04:46:35PM +0100, Thomas Gleixner a écrit :
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

