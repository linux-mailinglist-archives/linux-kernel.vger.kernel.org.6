Return-Path: <linux-kernel+bounces-376392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5F19AB0CA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE271C225FE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ED01A08C6;
	Tue, 22 Oct 2024 14:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUTbZFTh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F88983CC7
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729607150; cv=none; b=R/FN4vIaTSDG5haPsrOK5WM6x2r65FlB9weEpaFRRMSQdOpRc+FOnX+Y3cRAtQHL3GOSOMc0nYsnwcYhtHvJMKc38BHUEjWX8dpsbzqaKFDuAk+w1faXLgQ72QeXFNpMq6TCv/zX9CGYxuKsvAn+R5oo7psLtpYTVRr4dWlEYTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729607150; c=relaxed/simple;
	bh=mmHvQnejgtDBEYiUiLY07NR+//R3gfm+20XK//h3C3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e11PjphKEYdSaT3V1ZjWGYabc2UcjLVp5xEZ7OimBgCp3f9rQBxaafzOx7xEcYqZaKVXdeNJpq9u2ZAipj7obagjNO3O53RLC1ofl/v1i6GVYqRKL1J91zlSNIqjEq3G6JWCFvjtd8HYvRIaqjaEfAo/7eyQEu0U2KdzSNMSGJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUTbZFTh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8004BC4CEC3;
	Tue, 22 Oct 2024 14:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729607150;
	bh=mmHvQnejgtDBEYiUiLY07NR+//R3gfm+20XK//h3C3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FUTbZFTh9ZCU3qlApuVuOfD65CUmXOs8MqePghBuSqc965b3faXqgKbHlrkyraX1K
	 sK1Nlyoh3iBWEONFfErAZBxuHGZmAdOgFzw8JRHSdVU+rRt5h2Z0NPZqGA/6LtLVQe
	 xXI03hhFQW7jR13xmkQNgvYZ6vhdICvDMItov2rDIAH2Mer8nNJfE6jvgHyu/xmh8C
	 i24t3S/PgUqXycw6cotj4vupN/QZYV0uM/LLix7geX9yJ2aTssPGGGxEbCU+f+L4M/
	 aV8LoqsXbqjSZ+KaCPXAvYCfAcuY1QwKQL6TuBAnObPO0DUKpTXSiPAhjeXQtD6efY
	 yTU3DnGSYd9rA==
Date: Tue, 22 Oct 2024 16:25:47 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 10/26] posix-cpu-timers: Use dedicated flag for CPU
 timer nanosleep
Message-ID: <Zxe161PswCpcuiJd@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083835.850997918@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001083835.850997918@linutronix.de>

Le Tue, Oct 01, 2024 at 10:42:13AM +0200, Thomas Gleixner a écrit :
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> POSIX CPU timer nanosleep creates a k_itimer on stack and uses the sigq
> pointer to detect the nanosleep case in the expiry function.
> 
> Prepare for embedding sigqueue into struct k_itimer by using a dedicated
> flag for nanosleep.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

