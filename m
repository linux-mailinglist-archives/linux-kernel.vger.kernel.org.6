Return-Path: <linux-kernel+bounces-238383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E4F9249A7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0161286476
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 20:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C7420125A;
	Tue,  2 Jul 2024 20:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7pEACpe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262D2201253
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 20:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719953946; cv=none; b=cGoBABcfh50hrWdrPpe+O9S9/ECOmigaRGsFKkyZyHS97OyTTm4VxDDO3luuoaaHxOKskzA7Q3wvZkDW0lsMoxtlrbpupsT7zye2xFJLCQb3pXZ+KSgEHCAmVlqRr4NamTzjd7DkLRyu4H4VmOFPweSMFxxfpnuiDJRtJjfyVsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719953946; c=relaxed/simple;
	bh=M5dTMNNKFSZPNRLeXlD7QixMEqci7PRpRdcKKTHwXT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czEYxog5x/kpzTVAwXnhcg3qmZquzYs6METSABLLVSiDd7xVd1i45Zd+AIn8NesFD+uCaiBgrK1Q7eOPTBEubN8MPHd0r57/RGy+d5jx4rhbVN0YoKPnnO3KDjp+7ayuNbDAYC4pq+ZDUCPtid+6ixQPwpSsLRU7fCOdnRdmwIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7pEACpe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24E9C116B1;
	Tue,  2 Jul 2024 20:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719953945;
	bh=M5dTMNNKFSZPNRLeXlD7QixMEqci7PRpRdcKKTHwXT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e7pEACpep47fM5EzPqXSGjiuTLxe7K5mNh9DdqI5hx0vTSI1SZ/cGPgnfIxMbfOVZ
	 CD+P+li0lCXZeMWlM/V6yLPoD0AKn9ZchhmERR8zjSkciPX9O5Of++hxCIPkPGq+4E
	 17NMFeNi3ankZnfSFjiPdDeXGtQCux1FlEIeseNFfXImBEk5i4fbxDDg5h7kRBnLdm
	 Ldyh3mz1LPgXJS7a4xH0iBySYDO8AqTnE20Q/6QWd4dc68EhTG+VudSTH1dMiuTQwR
	 OcUff5j4/kzbhrKGJsuk2mH/kJLYebuC8kn2pv/a8q5YUx38EnDd40KeCjxfGSe8Fj
	 fNZoKd7lGTpEQ==
Date: Tue, 2 Jul 2024 13:59:05 -0700
From: Kees Cook <kees@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com,
	tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
	wad@chromium.org, rostedt@goodmis.org, arnd@arndb.de,
	ardb@kernel.org, broonie@kernel.org, mark.rutland@arm.com,
	rick.p.edgecombe@intel.com, leobras@redhat.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/3] arm64: entry: Convert to generic entry
Message-ID: <202407021358.D259DF0BCA@keescook>
References: <20240629085601.470241-1-ruanjinjie@huawei.com>
 <202407010839.125126F@keescook>
 <ab934094-ec54-b580-512e-199017ca99fc@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab934094-ec54-b580-512e-199017ca99fc@huawei.com>

On Tue, Jul 02, 2024 at 09:01:42AM +0800, Jinjie Ruan wrote:
> 
> 
> On 2024/7/1 23:40, Kees Cook wrote:
> > On Sat, Jun 29, 2024 at 04:55:58PM +0800, Jinjie Ruan wrote:
> >> Changes in v3:
> >> - Test the MTE test cases.
> >> - Handle forget_syscall() in arch_post_report_syscall_entry()
> >> - Make the arch funcs not use __weak as Thomas suggested, so move
> >>   the arch funcs to entry-common.h, and make arch_forget_syscall() folded
> >>   in arch_post_report_syscall_entry() as suggested.
> >> - Move report_single_step() to thread_info.h for arm64
> >> - Change __always_inline() to inline, add inline for the other arch funcs.
> >> - Remove unused signal.h for entry-common.h.
> >> - Add Suggested-by.
> >> - Update the commit message.
> > 
> > I didn't see the mentioned feedback from tglx in any of the threads. Is
> > lore busted or is there discussion on this series happening somewhere
> > else?
> 
> It Seems Thomas only sent it to me without a public email.

Ah ha! Okay, thanks. I thought I was missing some discussion somewhere. :)

-- 
Kees Cook

