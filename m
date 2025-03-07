Return-Path: <linux-kernel+bounces-551233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA65FA569E7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFB791753BD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EFB21ADA4;
	Fri,  7 Mar 2025 14:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAMFpOYg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910A121884B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741356317; cv=none; b=O3oQhwi6wP+S/tdGbfQCP9s733AOQp6FUe4nYwVgaEAVFv4bfz7oHEqvuOyHNgropKccUA7JtTSRbUy+qLKYtUWFnNS4NsXnfi7e0Ey7xTEv+nrQrurGrn876pmCqJu26jak+dFsZz4u6ichIc0VUgBi8808CE0a+1RyEv8RrxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741356317; c=relaxed/simple;
	bh=q3zRE+Xlyi2JCteoHShCaneTvsauDp3jLQRhkAEfLdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPZ7ad+27lZpP/kXUmocwBU8YbcCHSiAQ7kP8zSF+REwx2NJYvf8v3VFkQb4SAB5B3KB51x/VfZsZhyDl+5YaW11pXEdQxNAaVdI5jChaa1BW4LYVYOfICEi5KqHuRX/ETHzqke8taCO9U/cB/NQWLWBrECyBKBPwd3DG/nU8y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAMFpOYg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C09DC4CEE5;
	Fri,  7 Mar 2025 14:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741356316;
	bh=q3zRE+Xlyi2JCteoHShCaneTvsauDp3jLQRhkAEfLdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hAMFpOYgnFpdmfIxr80xqqdtyv+Ls7QLfylGHsCjAm6gJG9vAN1KEq6VTppVDWW7o
	 ChQ5jiDqYHmGnqoSiXH4Cy06y1yaUEGgM5pjpVGjjcWIRcwUeJ8++pfRVVZgt1igQ6
	 RXN9ZSrCh4ULjV8NKOf5IlyftSgs51VFCrpDb/LAHvSqhxGIg0NOc6/Wwvj9Vj72FX
	 HoFIv9gWcaMIjkT8BCR0sRCfZpPCnzvkCheQ2AgnFeuhpY6CT+97ou+bKoQ5qAd1qH
	 sCpLkOKrBR+evmD4SrdEfybVxWwAuMrJJnPbpuJi1ug6YE2JrUIQSFLxkrWkt/YBAb
	 e17B7p4oSBRgA==
Date: Fri, 7 Mar 2025 15:05:12 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Benjamin Segall <bsegall@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrey Vagin <avagin@openvz.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 05/17] posix-timers: Remove SLAB_PANIC from kmem cache
Message-ID: <Z8r9GADYR3yt8Mn4@localhost.localdomain>
References: <20250302185753.311903554@linutronix.de>
 <20250302193627.229366917@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250302193627.229366917@linutronix.de>

Le Sun, Mar 02, 2025 at 08:36:51PM +0100, Thomas Gleixner a écrit :
> There is no need to panic when the posix-timer kmem_cache can't be
> created. timer_create() will fail with -ENOMEM and that's it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

