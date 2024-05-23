Return-Path: <linux-kernel+bounces-186874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F12B48CCA3A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 03:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D02F1C212F2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 01:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A16B1C3E;
	Thu, 23 May 2024 01:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3quUulc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A811860
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 01:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716426261; cv=none; b=Nv2NefxRQrahS67J9wy907kJNRbz59IKk/Jtybmpovf944ShEnGZ787PHNM7UuSzBF+qoB0tigw0xaVvkXaJ1qELHgobQ/XL6bm8D9vUCrvV4WTezG7wTDNc0oqdVPnU5kGVwHAd5QG4/ELc06aZ0iexQv2/lib/yyIdpExg994=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716426261; c=relaxed/simple;
	bh=PPEphpiHUb+mxbfxkpXQ2Qlmv+jiT6+TrpdG4yvSjbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPz2bwgTxkq2rqIqphsbZoSguVY2zYw4erqVFaIxnUDTb396vaofSxi8NgK3sK/exi83UYL4FfYDIffPs9Mu6Uw22ebMDyjUu13LWlpZCqCgPy/bYBEZCdMHHoT3/pea5OKtLEbuVADeky0Y1YSqWGCNv9dYkCInzuImPVGwF2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3quUulc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB46C2BBFC;
	Thu, 23 May 2024 01:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716426261;
	bh=PPEphpiHUb+mxbfxkpXQ2Qlmv+jiT6+TrpdG4yvSjbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l3quUulcT6OeHqaWvIVQggt8dc447MJ34BYn6OG3wK4ii5LmJPScBLSxxvIK4Ceh5
	 DEC4T5KuCaHvIHig0hhMFAuakJRoWJaVyPme/bkRKy4knHkgeXAM9nnhQ/rNPifoAR
	 Lfjv8b0LVCq2QqgUrkn9QnCBDEuFJxwUhxSWvI7q0KSgI3m37O/0xyoBjM6rhNwZD5
	 8l2AMuQWZCdPSlYs+c+wJ+Xo7emQl5Ea1mVczjVWT7/FHdRjX8LVhoasbGELJmEhpn
	 XpWrd/Sy0d2EYBEENMC/1oP3txMhX0yUgGnSFiwt7tRlD7/P4A3etLgyanA3m/osKr
	 ZVVQt/aWL8FbA==
Date: Wed, 22 May 2024 18:04:18 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Maksim Davydov <davydov-max@yandex-team.ru>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v5 3/3] x86/bugs: Add 'spectre_bhi=vmexit' cmdline option
Message-ID: <20240523010418.gi3mrtzlguxg2znd@treble>
References: <cover.1715059256.git.jpoimboe@kernel.org>
 <66327dcf87284a09ed17ac24227695ea3ba1f287.1715059256.git.jpoimboe@kernel.org>
 <17ab995a-cdc0-43ce-884c-48a263f219c3@yandex-team.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17ab995a-cdc0-43ce-884c-48a263f219c3@yandex-team.ru>

On Mon, May 20, 2024 at 04:12:58PM +0300, Maksim Davydov wrote:
> Hi!
> What is the current status of the series?

Looks like it didn't make the merge window.  I can post a new version of
the series next week (with the minor documentation fix in patch 2).

-- 
Josh

