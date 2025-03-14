Return-Path: <linux-kernel+bounces-561757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 366F5A615D3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27663BFB86
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B0D203719;
	Fri, 14 Mar 2025 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyDl8W3e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171BA1FFC51
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968482; cv=none; b=UHegkNiTquh7aKAatZ4xaIrwqVpN8kYQ7wJXXmE5gYWCyabWUvph1asmwMNsDVLGgYSLeKED0vfMfMYiwzU4iI8z9kaBVYArol/9vnCmCSrF6Ey0WxjCj33Z1/5zUykX3FbcuiwiHqHmuts82/vyUB5/13HZfvD3QlPlthFOHGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968482; c=relaxed/simple;
	bh=UJQfc8Sd9y6RluPNY5HI8byThwwXEJliQ6skToVHEQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhaeJNYjzJ4qUnFMqkX6W2J7sEbxy8mPdHi7hmc/xzf7wKfrDSKDfGmtVdRthjS1mA//fKHERetPtpXyqf1zZ0XzhQXqfM9cjOwJqEjX4/nW19NXYUuHSU+UvwbTmpiK9Ms2R6g6LH5UWZ2Zjst1YhLl8f9r78v086/+jpGuCP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyDl8W3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64AD9C4CEEB;
	Fri, 14 Mar 2025 16:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741968481;
	bh=UJQfc8Sd9y6RluPNY5HI8byThwwXEJliQ6skToVHEQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uyDl8W3ejOR1+FfyMJEb0SXtm/sgaDZ25kdhv/gwuvWyq15x1/OnjUoI4viQC7eae
	 GKwEP0b9beV5Rtp5WqBCgWcKTr3qwg0fJrLdEDAKBGNpQfkW5nCWVCP1xBe9sJePpH
	 O8tYYyTMcKOx/n1vWK2mCPdHnpKJuyicNYodw+cPDxj20k+I73iksJ98bdXDmyiqcJ
	 SRUPjsRsda8A29NSG5iqSzLy3e7zsK/F49h0WwoSqZ0FOyUlb4ke4yESMg9vabx1RN
	 M14EUPBZbuppRdoJclxct+Qb91PW67j2qLkfxt9BJayPJUG33sGFfH7xT6Xn5DMTB8
	 gIg4azQ4sRhLw==
Date: Fri, 14 Mar 2025 09:07:58 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, 
	Kai Huang <kai.huang@intel.com>, Nikolay Borisov <nik.borisov@suse.com>, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, Dave Young <dyoung@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, bsz@amazon.de
Subject: Re: [PATCH v7 8/8] [DO NOT MERGE] x86/kexec: Add CFI type
 information to relocate_kernel()
Message-ID: <ra6zlx2iz7eks3y4ymoi6mn7o6rvnjc3lnjoaadf3szaocbkae@yg2lyjzlnqdn>
References: <20250312144257.2348250-1-dwmw2@infradead.org>
 <20250312144257.2348250-9-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250312144257.2348250-9-dwmw2@infradead.org>

On Wed, Mar 12, 2025 at 02:34:20PM +0000, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> A previous commit added __nocfi to machine_kexec() because it makes an
> indirect call to relocate_kernel() which lacked CFI type information,
> and caused the system to crash.
> 
> Use SYM_TYPED_FUNC_START() to ensure that the type information is
> present, and remove the __nocfi tag.
> 
> I still can't make objtool happy with this in both GCC and Clang builds
> at the same time, so not yet for merging; only included in this series
> to nerd-snipe the objtool maintainers.

Again, I'd recommend just compiling the code in .data..relocate_kernel.
Then objtool doesn't need to care.

Otherwise it would help to know what warnings you're getting with this
patch, and the corresponding .config.

-- 
Josh

