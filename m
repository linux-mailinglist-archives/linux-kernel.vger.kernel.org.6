Return-Path: <linux-kernel+bounces-311980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7FA969061
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 01:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09121F228EE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 23:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5AF188593;
	Mon,  2 Sep 2024 23:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jrzRY3dI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qI8JG99E"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A043F2032A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 23:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725319380; cv=none; b=p+eYFvUvkh69KQyL+B1mzoiw3D7hsxoC6qeJk2/NxM2APGjXPF+fFZWijJj3DSV0g+5yawv6GeJPU8GrdFYSBCPZJSSnW0POWR3eA2zCWD2J6flVtZb3RsY44U1iFF8WPk5idC4pb8hqxWqQkR3tKKBZUf6luz8ylWaZ09Iw38Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725319380; c=relaxed/simple;
	bh=EeemspWwKDSHMN0/k0un4WZJtVLztEF16Gtosj6Ylt4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oFKCj42vRO+V4QyZx7WnLBXaSq3K13mGN9aJYwJiiBC09EhN5oGu9Zow/aftcV6FIOSLuv4AQmlsB+N8ulrz5Lnlpli5Hi3RMVWTseNFmtzxFM3o+sZVrdaCS8Lm7TX8GJopSnrwa+lO0MFvfPN9PY0vapoHJh5VFmXvmeCoZs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jrzRY3dI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qI8JG99E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725319376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dxk6ISaO+tGCPSS65Piy6q0R6nZ3wT+P4PJcOSd3ODI=;
	b=jrzRY3dIT6U+OhnlXQcEcq9irGAH1Bm1hOPR7ToCuP+A+S8aaFLd6ACOOePu83/i7c2Vbg
	nZ5PLeb0qq0Y8YoQTU2CqjquZv3CkjSCDW7T+cN1sMm6ZjIUEPmmUrosg7XOw2PUlX6qIv
	cvC7zpI9u2je3mLqjEH/N+bEYGBlUTVUOGA0wNLshvMXsw1skWJugFqswH+0ioOXWAWnZ9
	6/X51nWpNI347nxu3s7sryOQHWBLOqbwnhqewxL6/heUaOipJdRErjwjb50adDMk4Ezcjv
	lBgvoRozO/vyigmQ6JwdvyG7wtuTEQn0F687e4yjc2NLTATRcU2EiQayryyI4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725319376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dxk6ISaO+tGCPSS65Piy6q0R6nZ3wT+P4PJcOSd3ODI=;
	b=qI8JG99EmZ3jpU8p0K+aLoigGayK7PLn8bQTSXRrSvQbmmDpKHIHGXr9rMf5DEiX3PhJ8q
	aSkczOalnaa2H/Dw==
To: Xingyu Li <xli399@ucr.edu>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Yu Hao
 <yhao016@ucr.edu>
Subject: Re: BUG: general protection fault in __free_object
In-Reply-To: <CALAgD-6MwUxVzN9Q=U5qBNnhO7tUy43dnT==Vh=TbJ4aCZpsgw@mail.gmail.com>
References: <CALAgD-7TsMdA7rjxfpheXc=MNqikEXY9TZNxJt4z9vm6Yfs5qQ@mail.gmail.com>
 <87frqi76ns.ffs@tglx>
 <CALAgD-6MwUxVzN9Q=U5qBNnhO7tUy43dnT==Vh=TbJ4aCZpsgw@mail.gmail.com>
Date: Tue, 03 Sep 2024 01:22:56 +0200
Message-ID: <871q2163ov.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 02 2024 at 15:55, Xingyu Li wrote:
> This needs the corresponding
> kernel config, the exact kernel version and a description of the
> reproduction environment (compiler, qemu command line ....)
>
> As mentioned, it is on Linux 6.10. And here is the config:
> https://gist.github.com/TomAPU/64f5db0fe976a3e94a6dd2b621887cdd
> It is compiled by clang version 14.0.0
> (https://github.com/llvm/llvm-project.git 329fda39c507e8740978d10458451dcdb21563be).

You still fail to provide the reproduction environment:

    - qemu version
    - qemu invocation

This all matters and I don't have time to figure that out myself.

Thanks,

        tglx



