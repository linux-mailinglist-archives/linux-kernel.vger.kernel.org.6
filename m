Return-Path: <linux-kernel+bounces-374420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584719A69EB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9181F226BC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7356A1F12FA;
	Mon, 21 Oct 2024 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtCelnAp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FAF1E0B96
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729516776; cv=none; b=JtvL4C2t6K1qkvuemvWqTnt5oCJUAeR2XKYw1JTNtPt+sjdElsVXS2FSAozK+XCZMctaP/0j9ys97j9IxphktkjLQNyItGEHAoH989/ayReUMOoCrRTD1H1L0Mo5tJqyGU6aLWGQDs0jqILdt5zxvUwzAgYRJFSF9qVQaUgqF1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729516776; c=relaxed/simple;
	bh=Y2WFdQQBx8ph1psQf+3vnQucMoMVE5yyTqz/XnQF+84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHbinB6qxS+tmyzxvCuSRe4EEaGAfz1oU4YqxXhXyt1jCdW3KofqNd18yQVjvp0FpJhMNq1MN1j9TCrNABO9Pi+FufaU+T8jX1DxAxSngRdsKpbQUXSLNHFPgyCDzgmf4AluvRChrZ2vJFP6vSXmfW41m0c7ML+9StDxEQqdPv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtCelnAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA00C4CEC3;
	Mon, 21 Oct 2024 13:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729516776;
	bh=Y2WFdQQBx8ph1psQf+3vnQucMoMVE5yyTqz/XnQF+84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JtCelnApt5ikJy15ywer77wAL/Muzewxh3F0BfW/Bz6YKhBxMeqtIpyj+KlDNh8NR
	 AsMBdZWk/utItk/LUqKHyZCQdkgJwjX2QbbxTFvnxsAk/KS4q0g7ei9mvNHHM5p7KH
	 j0cXrBo36i8XLkTgXcndmhbiM+X5rU5wBQpJ88yyteLYoKnNmwoTtHUIHUbzxEXLBb
	 AthTyfuC9pj75Vwlzx0/O2xbia2mzrHJNrINGq6yfg8GtSDHA9u8W9RtmH/PIz4YhY
	 fENl22EEAIG0TlO9NIb/bkVjZ+x+2AffThk2f81F8NEPEk8zv3tq/Sne9SwdsAT23C
	 w+a7/YErPlJxw==
Date: Mon, 21 Oct 2024 15:19:33 +0200
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
Message-ID: <ZxZU5ViCYadY6eOE@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083835.670337048@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001083835.670337048@linutronix.de>

Le Tue, Oct 01, 2024 at 10:42:09AM +0200, Thomas Gleixner a écrit :
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Right now the state tracking is done by two struct members:
> 
>  - it_active:
>      A boolean which tracks armed/disarmed state
> 
>  - it_signal_seq:
>      A sequence counter which is used to invalidate settings
>      and prevent rearming
> 
> Replace it_active with it_status and keep properly track about the states
> in one place.
> 
> This allows to reuse it_signal_seq to track reprogramming, disarm and

Did you mean it_status here?

> delete operations in order to drop signals which are related to the state
> previous of those operations.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Anyway:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

