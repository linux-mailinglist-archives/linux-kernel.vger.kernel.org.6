Return-Path: <linux-kernel+bounces-565219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF34A66388
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43CE189D35B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 00:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDDD18AE2;
	Tue, 18 Mar 2025 00:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0sRRK4J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5E017BA3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 00:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742257047; cv=none; b=jF9ETw4l9rnONTwnEGnho+HavLoEm0Flp8slvrvjv7aOwhArIk3NRXaGs9JRyDhP+RjPuHCUFzDLeN4bYvGh6k1u21xyJ5DNNcQgwAPJnbCuUodtmR/48exfhL+XB+GN5MS8WZ5moIWARqgWTmUSmEkGgYYZuDP/YUkbCsMvzS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742257047; c=relaxed/simple;
	bh=ilTqUgoJ9BEMCciAl8Q1ZAI+r6rC2qfPQ3ckpNm9Nb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7F3d+pBk81YFoD8Rorjc1Geimo9u2BGy4WxvN+KlXrREa6yrmnp9G5dW2ZfOvBZIwiqHSa3vjTrX3taUpApxzT6ArUql1odbz5aQG/2OAQEet6HdibOQnoe2ClXxIpVX+gBeHa1qCUhr7u/vgDv+aSGqzYLbDYV3xxz4W5plFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0sRRK4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C63C4CEE3;
	Tue, 18 Mar 2025 00:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742257047;
	bh=ilTqUgoJ9BEMCciAl8Q1ZAI+r6rC2qfPQ3ckpNm9Nb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f0sRRK4JcoDNftM5pE/Wu12IXxKsmc+62rtuit13aMh4UlbbVi7zO9RCqXFtzEL3S
	 JPOFGVdgcS8NydfE4SvXhwTvnePoTmYfP0g84d51pLNMlKxwwza07A5iPtmW9MC54k
	 5P8PKkLpdAZ65xsYmX1BLsR39Gu67yi4XES1mTkTYtTuFF6j+LfCNDFf8rDPwDbcqw
	 tK3wIvaMuaWKECnVkFRLumaJPULv+zeUQhJnrtd+uL/GXFGEdDyi0sI9x5TtfhRPWM
	 voQs6+LVLC1gMgwAJJer4jD2+1ZVtm6K3hzNb7dz6J/hq6RwL3qaGhCag6LjgdTFs2
	 nqR+HiBQUchNA==
Date: Mon, 17 Mar 2025 17:17:24 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Nikolay Borisov <nik.borisov@suse.com>, linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Dave Young <dyoung@redhat.com>, Peter Zijlstra <peterz@infradead.org>, bsz@amazon.de
Subject: Re: [PATCH v7 8/8] [DO NOT MERGE] x86/kexec: Add CFI type
 information to relocate_kernel()
Message-ID: <wzc2owczflbhfho6xcgnl3mnrutdvmqz46xgo54g2ahorhpo5l@rykdsdkjw4fd>
References: <20250312144257.2348250-1-dwmw2@infradead.org>
 <20250312144257.2348250-9-dwmw2@infradead.org>
 <ra6zlx2iz7eks3y4ymoi6mn7o6rvnjc3lnjoaadf3szaocbkae@yg2lyjzlnqdn>
 <c2471b0a81ebd183d32e76f995a70b7912c1d4a1.camel@infradead.org>
 <7tq4tti5pv7fjboiapuglkcsodl4nsk53rj36skg4xb2bkysei@ncoz2ztiddm7>
 <970a4932cb95bc8934dc2ad15e8e84a2a51d2232.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <970a4932cb95bc8934dc2ad15e8e84a2a51d2232.camel@infradead.org>

On Mon, Mar 17, 2025 at 12:40:14PM +0000, David Woodhouse wrote:
> On Fri, 2025-03-14 at 10:52 -0700, Josh Poimboeuf wrote:
> > 
> > IIRC, the reasons were the patched alternative, and also you wanted to
> > disassemble (but note that's still possible with gdb).
> 
> It's meaningful output from 'objdump -S' that I miss. But OK.

FYI, this works:

  objdump -Srw -j .data..relocate_kernel vmlinux.o

-- 
Josh

