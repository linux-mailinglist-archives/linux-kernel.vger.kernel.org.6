Return-Path: <linux-kernel+bounces-379836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0019AE46D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88EBA1F22976
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119A61D1739;
	Thu, 24 Oct 2024 12:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgINYSC6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE3D17B51A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 12:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729771849; cv=none; b=n+l9D52jhohfgg8mdowH1k6ZSBSElAIT7WPV8bfENyGasQxwzYCh8EVcq/uWhe/c+6FMAI3boGu8BpeUFLjURYAGD1tZomBPRsjAle6ofLkfssKOTDLi8u5zYvyjvKVnel0KsqasFUEolvZIRoEignMrS3gs31/VrOHFaYhhEaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729771849; c=relaxed/simple;
	bh=nj4eg9XYRhifvPXBCauMUJiF12TmQu17Tr6oSm2RCGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkDztzF4W71B+S3x+NUVqCD6qBWSzw4WRUjvAofsoZXvBSTUOIT61j3DKNpQVIQESukEaU0xdnCOioPJyjqT0d2fGlDT606MbPyFOYjn3BL+YkWbii5B92HQag3CJh/bE7UZlCK9hPJDn+F5xGCsfZFh47dm5eOlA9sI8I/IJbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgINYSC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92348C4CEC7;
	Thu, 24 Oct 2024 12:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729771848;
	bh=nj4eg9XYRhifvPXBCauMUJiF12TmQu17Tr6oSm2RCGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WgINYSC6Xzg0aL2JVPDDTGLHmULVsZ1hmogjU/IuHnwubz5H2/jqqdEU+aLlMtErR
	 lUDFhN1sGlznBPfdNUpzjFTiW81aeK0Jd7L/lo5+qBSQZ8xZqr2/mIOJpcY/K6DpiS
	 Z48WqVKyJeHKM2aWOkEJzNbfi+ALARbzkwiSrzV3hnX5HkyEPg5oaVSPPeyQpcV3JP
	 hfdE6VfraxhZAJ/UE7Dm02zjK8ljVYBeYLGgWnEs5h+MBzqq+fotmxHXaqZyRvEZ4G
	 iaQHlEzFIJgRfnoE46ORVt32KmMdqL3qDUact26MbBwoSqqy+ihPudym1Hq1h8fgZV
	 k6t0WWud2UL2Q==
Date: Thu, 24 Oct 2024 14:10:46 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 07/26] posix-timers: Add proper state tracking
Message-ID: <Zxo5RnxokWPre99y@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083835.670337048@linutronix.de>
 <ZxZU5ViCYadY6eOE@localhost.localdomain>
 <87r0856g9n.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r0856g9n.ffs@tglx>

Le Thu, Oct 24, 2024 at 10:45:24AM +0200, Thomas Gleixner a écrit :
> On Mon, Oct 21 2024 at 15:19, Frederic Weisbecker wrote:
> 
> > Le Tue, Oct 01, 2024 at 10:42:09AM +0200, Thomas Gleixner a écrit :
> >> From: Thomas Gleixner <tglx@linutronix.de>
> >> 
> >> Right now the state tracking is done by two struct members:
> >> 
> >>  - it_active:
> >>      A boolean which tracks armed/disarmed state
> >> 
> >>  - it_signal_seq:
> >>      A sequence counter which is used to invalidate settings
> >>      and prevent rearming
> >> 
> >> Replace it_active with it_status and keep properly track about the states
> >> in one place.
> >> 
> >> This allows to reuse it_signal_seq to track reprogramming, disarm and
> >
> > Did you mean it_status here?
> 
> No. it_signal_seq is used to validate whether a queued, but not yet
> delivered signal, is valid or not. The sequence is stored in the signal
> when the signal is queued and compared to the sequence on delivery.

Yeah I missed the following patches that increment it_signal_seq on delete
and reset. Makes more sense now.

Thanks!

> 
> Thanks,
> 
>         tglx

