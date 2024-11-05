Return-Path: <linux-kernel+bounces-396456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F379BCD65
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C239C1F22533
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB3D1D5CC1;
	Tue,  5 Nov 2024 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0oRKS6V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E011AA785
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 13:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730812106; cv=none; b=RW/XK7uTjpVW0rm6TxSAZ+9Nz4iEnMyLEoc9XEAa2hYrNkfBOPbRZXtK+qixAr+mNh+Zs7wCZ1z8EPC3ospD9OkM1K6vCtQmrwvmluRSfILFfiov1393iqoO1Nxpe4IR0dIJkJZ4tZ/psUIpU0PVZw8EYjOKV/kbtszhhnjICFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730812106; c=relaxed/simple;
	bh=6DQNL9Igneci2ccudveuJvUdMY4QZ/wM2qNZstQSdmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpn7Cu/Im/CVkJFfafP0kvV5m0oFpmQ/wHrHlYZ8emi9bNiwWkMaPMiJWA+QwGawfwLA9VRS2hpAZhPTpk6CaE9VXxgh86YkTRZXDKtKD2G0s0HdowaD46j32v4NfQJcWf2kx4wcahtzYfLKzJ6HRo5ewyMls1Cwum1ZNiZpixY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0oRKS6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E591BC4CED5;
	Tue,  5 Nov 2024 13:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730812106;
	bh=6DQNL9Igneci2ccudveuJvUdMY4QZ/wM2qNZstQSdmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k0oRKS6VBaF2ZoKNfIaTxEwZxhDRY9/bT4JMCxqyycoOo2jt8lrJJhj2J+tAEI3Sa
	 RZ8dkOjBu6vOhR6+s2KwGcgojDK7J/izM5yPVlK/+5KbQXAM0dYRGBduiQw4lAhRo3
	 4gpobj1dtWyWT/+MI8e9QQ9mvkJjtLw85EOKcXDJTfQZHK5AM7WeD/dCXIPcnx8dt8
	 SXdMkIvVRVbUDOte0Y/qiY+rrX/zGd2JBomtJoDJW1u6BUlCP6RDSQ83iK5fEAFIcV
	 WTwYZuKpYVAtoP1f4zIyk34Y4pDpqr9wANn+/dtxjQdPKbkiCuAx33GTCJ5CeF4vYQ
	 e5ujq/2cxTeng==
Date: Tue, 5 Nov 2024 14:08:22 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V7 16/21] posix-timers: Handle ignored list on delete and
 exit
Message-ID: <ZyoYxvDAi14Z7VJJ@2a01cb09803abb1ce3ad97aed0fef98f.ipv6.abo.wanadoo.fr>
References: <20241105063544.565410398@linutronix.de>
 <20241105064213.987530588@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241105064213.987530588@linutronix.de>

Le Tue, Nov 05, 2024 at 09:14:51AM +0100, Thomas Gleixner a écrit :
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> To handle posix timer signals on sigaction(SIG_IGN) properly, the timers
> will be queued on a separate ignored list.
> 
> Add the necessary cleanup code for timer_delete() and exit_itimers().
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

