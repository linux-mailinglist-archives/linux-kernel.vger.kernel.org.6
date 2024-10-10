Return-Path: <linux-kernel+bounces-358962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5095B9985CC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367561C22FB8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654251C4609;
	Thu, 10 Oct 2024 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hfl1BcPo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NC4Dc6ar"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B981BDAA5
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728562877; cv=none; b=hENNZerBkQgKSKIkykpA71je0aMPOBGMspv0TW1taVoo5G3yQWdocliu1XYxPv2VVzrUK00CaUozG3kjzSOTqnL6QtmmU3oHp7GVkGq1qSLzQD6qpBT4Rn4LEP4WTEQ5QaCqOz6ViHOzBGleRHAJv1AXdqRbucPz80cMTF+E2bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728562877; c=relaxed/simple;
	bh=UevjZbBWy216zD25MmMfuHA3cSJpNj/nKZVEjV3KD0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=br0eDe1C6I9ogr4tb1Z5AFfUxDT9w8DU28a4hyAscw2lASdP66Pcxr/kgXgVqc66azc6ZLQjKDCi3mU9D3zbT0ixEYwMgf/W7ic1KSVz9TnkZe6eTpP77dNrLPsi3TtiwGM8Z5K27zvQnDzMPsPyzYU1wiXGSX33lYcYZRseKT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hfl1BcPo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NC4Dc6ar; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Oct 2024 14:21:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728562873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3kZuBpACaIGf6sO1p3qo3UuoGLZQPpP9DFEKWVKFprY=;
	b=hfl1BcPolanyamFJPfmUedMfaXGy/TqA2beboaqyBseEtudxma+nu1+qeKcnXcDKpJH2fY
	Z0CUwGdh/J41idsFvJsNTwZc+pHsKxqdN2I+32rBdyD/ObPbRPnHPBdQeST0nLQ5XFmwkl
	t7oouocZqzAMizi+sF5fzDnUzcAshwKSZNvNhC/IkNiMmtRHCcTudi6oKy8ndo+7g/vzmY
	LIqa053QkFfZ+Dd1i+jzXmCkP+96emkbHjlDSrz2a3pfXB2x1nzhICtYTmaPnNXI29Dt8j
	lhgJvyxMLLCaefphiSWPAQixpg+v8kqAGI/Va7fRXHy4gdT8zaq9Jxx9lap+bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728562873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3kZuBpACaIGf6sO1p3qo3UuoGLZQPpP9DFEKWVKFprY=;
	b=NC4Dc6arP8x72ULzTxCnxc0QBApm3EMZxBsEKzG+RG7zCUeO7vgmxam3df2imfdLSBP1jX
	LoyG9j3vP/zorzCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: namcao@linutronix.de, tglx@linutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, x86@kernel.org, hpa@zytor.com,
	aou@eecs.berkeley.edu, bp@alien8.de,
	Catalin Marinas <catalin.marinas@arm.com>, williams@redhat.com,
	dave.hansen@linux.intel.com, mingo@redhat.com,
	john.ogness@linutronix.de, Paul Walmsley <paul.walmsley@sifive.com>,
	pmladek@suse.com, senozhatsky@chromium.org, rostedt@goodmis.org,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 3/3] riscv: Allow to enable PREEMPT_RT.
Message-ID: <20241010122111.BKz_RSCv@linutronix.de>
References: <mhng-64eec780-df98-4e8d-bf6c-0aa07a8d85da@palmer-ri-x1c9>
 <mhng-f0f516a0-6774-4c87-b8da-313601bad133@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <mhng-f0f516a0-6774-4c87-b8da-313601bad133@palmer-ri-x1c9>

On 2024-10-09 09:44:59 [-0700], Palmer Dabbelt wrote:
> 
> and it breaks my boot test script.  Looks like it's actually working mostly
> fine, I'm just not getting the "reboot: System halted" message that I'm
> checking for to make sure the system actually went down cleanly.
> 
> I'm not sure if this is expected behavior in RT land, or if we've got some
> sort of bug.  It sort of smells like we're losing the last printk() line...

Is it just defconfig + kvm_guest.config + PREEMPT_RT on "-cpu rv64
-machine virt" or is there more to it?

Sebastian

