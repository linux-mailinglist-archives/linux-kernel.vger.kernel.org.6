Return-Path: <linux-kernel+bounces-568336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06844A693EF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF0A21653CD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37AF1B0F1E;
	Wed, 19 Mar 2025 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObyD9DX6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3199914D70E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 15:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742399267; cv=none; b=e6qehaPgoYHO+S2j0723vxEcltoLbIHdxeEbBkXu2X0p+q4lXaqJQ4vqsbTxuc4BOapSeU9JTxyAM1IWwDxUCO/zLha9rsS0N8r8c9+nqz8KdhE5YAEV+YEm4jfgyjGgfpV9DjVwZJTzQHrGf96ELwB+WjhVP8LDf1ubdO1Blv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742399267; c=relaxed/simple;
	bh=lAjVQdTPRzzpOcaWKxBbmeTz8ix+m8SuzeHqkBCr0UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJPmaFAfztATvwipjyz0I6hyB6HM3AhTDvBs8E3Mq8N2ueS7Hri1dsBO12UZbaSDcJWv53+sMoXYwV9S5Bd8nHxWRVivgzXH9dtwonIYKjvTkv8ymmD1qcnFO8kfb32VktAozzLj91JM4W2PgLYn0D+vJt8wD8QHY9TdWyUURbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObyD9DX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D80C4CEE4;
	Wed, 19 Mar 2025 15:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742399266;
	bh=lAjVQdTPRzzpOcaWKxBbmeTz8ix+m8SuzeHqkBCr0UM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ObyD9DX6BZweAsb6Fmkp+8baqxl74XIy5lSYdJuHrL6zjHExJhT8TWx/1mU6gin1h
	 mttNl50AnFAuCtRsry0jJeuofZoxU1Ahha4Y0X0HQ8mxf8XBRSOc6EhIjmr3pmXxpF
	 cm8EM/Vi+J503HW2fgER+/t2F0uOvIiiCbf8zWfBJ+YnC//F5ii1naFBVTWbgU6fgQ
	 m/2qYccXiVO+KDDFevX8hvy8G99+4BjzGWHKxIiAdgjgQmmVX7Z+sLrRM/p2FbRICf
	 L8GkKftAbynDpQe3E8vPn+KzUFKOfVA13PtYFLuSbUl14ZbPBflUN3NOPMA5GalNyJ
	 4Tp+xc0OjhGVQ==
Date: Wed, 19 Mar 2025 08:47:43 -0700
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
Message-ID: <7jpwi6r564hdpw2n7b75o6oqvtjdx3wpmq43e5khhwa2lh3yij@cis5aamxquol>
References: <c2471b0a81ebd183d32e76f995a70b7912c1d4a1.camel@infradead.org>
 <7tq4tti5pv7fjboiapuglkcsodl4nsk53rj36skg4xb2bkysei@ncoz2ztiddm7>
 <970a4932cb95bc8934dc2ad15e8e84a2a51d2232.camel@infradead.org>
 <wzc2owczflbhfho6xcgnl3mnrutdvmqz46xgo54g2ahorhpo5l@rykdsdkjw4fd>
 <6swzz4732x5kfeg3qsif2r5s5ado3nbweznm6alsxvniy4xq6a@z6foorhlhelj>
 <9c41ab61efc573e3ab5a75b6e4031f81db84a846.camel@infradead.org>
 <awucsfjn475mvwg7xhihexln2hfbtvrie2uv333u7awtkz4mrf@t57pi7jibytc>
 <e48391c54a4ba27795919099f8ea25c29d868000.camel@infradead.org>
 <orpk67p2yolcb4gi462wqwphaaio6ivny2gcfcw4jna3uyaak5@oty7arlxxykl>
 <8BD39200-583E-4835-BA0B-90409E0E55C4@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8BD39200-583E-4835-BA0B-90409E0E55C4@infradead.org>

On Wed, Mar 19, 2025 at 01:04:20PM +0000, David Woodhouse wrote:
> On 18 March 2025 22:41:43 GMT, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >On Tue, Mar 18, 2025 at 09:06:58PM +0000, David Woodhouse wrote:
> >> On Tue, 2025-03-18 at 10:14 -0700, Josh Poimboeuf wrote:
> >> > On Tue, Mar 18, 2025 at 03:56:36PM +0000, David Woodhouse wrote:
> >> > > For the relocate_kernel() case I don't think we care much about the
> >> > > first. Without a CFI prologue, no *other* code can be tricked into
> >> > > calling relocate_kernel()
> >> > 
> >> > But for FineIBT the hash is checked on the callee side.  So it loses
> >> > FineIBT protection.
> >> 
> >> Right now the relocate_kernel() code doesn't even have an endbr, does
> >> it? So it isn't a useful gadget?
> >
> >In that case wouldn't IBT explode when you indirect call it?  Or is IBT
> >getting disabled beforehand?
> 
> Not sure of the details. The machine_kexec() function which is the
> *caller* is currently marked with the __nocfi tag which stops any
> software checks. I guess any hardware feature which requires an endbr
> to be the target of an indirect branch has to already disabled on the
> way down? What specifically am I looking for, to check that? Or the
> hardware support has just never worked with kexec, perhaps?

Looking at machine_kexec(), it calls cet_disable() before the indirect
call.  So yeah, it seems fine for relocate_kernel() to not have a CFI
prologue or ENDBR.

-- 
Josh

