Return-Path: <linux-kernel+bounces-408318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E34859C7D56
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 22:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49EBE1F238E4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 21:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0A72071EA;
	Wed, 13 Nov 2024 21:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+AoRXnt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32E41CAAC;
	Wed, 13 Nov 2024 21:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731532281; cv=none; b=K14CihqL5yKzatynojCKIjx0SYWRjQgCCFPjFf+VX03nOpuCYeiYznSAmTSwF+DX5IUUbEk73n1uKaIzAlQQxnX7jKXLUDFdWvJ9myUFTpnRFY8R2l39egTDklxzcBZUQ27zWIOJ1GfYqH/HsAc1qBdSsWaurJ0y1zE5xOD2VSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731532281; c=relaxed/simple;
	bh=4kQGbjjznEDkNkq4OGvG06vwaYxqZLBJJmMFbCdHpWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDndrqB9DdItTwSM8X+86h9hIrkZBXYAeWCVnSAvuECIVV1cMeGIoyx+GmuZrWM0zFqVCpvSvH3pt9cBzT35wCLthX81860BrxVTSamFdpGXhNHCaQ0ek7C/OsNpvU4F4x9no02NfjFqKv1+G9yNZuxxvEq4J67OUJXWwPM+kV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+AoRXnt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF46BC4CECF;
	Wed, 13 Nov 2024 21:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731532281;
	bh=4kQGbjjznEDkNkq4OGvG06vwaYxqZLBJJmMFbCdHpWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J+AoRXnt+OKNdB/8nMZO9jnokNwGZMgSlSKT3Yx2kx3+Q1MVR+j9Z1Mm39PkE7SES
	 pqfqnHer65cjdeXHc0xpXsZ7cVm+9WdUNM4WOq6hbiyGDa/nTK6kSVHD54l8Phnrh5
	 rWZW9lpU74s6WwevH6Xsj5+ZS4nFZWfIgA76csfObZQx7ol5S/v313jjU32nxVJ0yo
	 EsXAv76y37rPU+QpKH+HaLV/HUqv54oGDWf9FBrYaaw0lXzBybyD+xr4pSCbM5W8Tj
	 fnPZzRa91X49KC28oheCql4L3XvpdSnsBHHHEFJmERTV2jq9rSvDDU/36nq2eI47Qp
	 XfSYwVsbS4NcQ==
Date: Wed, 13 Nov 2024 13:11:19 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Xi Ruoyao <xry111@xry111.site>, Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Jan Beulich <jbeulich@suse.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Subject: annotating jump tables (Re: [PATCH v2 5/5] LoongArch: Enable jump
 table with GCC for objtool)
Message-ID: <20241113211119.lfwlxv2bjyqfqeh2@jpoimboe>
References: <20241105123906.26072-1-yangtiezhu@loongson.cn>
 <20241105123906.26072-6-yangtiezhu@loongson.cn>
 <20241105141530.GE10375@noisy.programming.kicks-ass.net>
 <62df4c24-68ed-fbfc-ed98-2df796697d89@loongson.cn>
 <9589c5b673f45f02e2b0fa9d9a96eff0f0df0920.camel@xry111.site>
 <7e8adb0b-e681-72ae-40d8-740dc3f9480b@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e8adb0b-e681-72ae-40d8-740dc3f9480b@loongson.cn>

On Tue, Nov 12, 2024 at 08:26:56PM +0800, Tiezhu Yang wrote:
> On 11/12/2024 11:15 AM, Xi Ruoyao wrote:
> > On Wed, 2024-11-06 at 13:03 +0800, Tiezhu Yang wrote:
> > > On 11/05/2024 10:15 PM, Peter Zijlstra wrote:
> > > > On Tue, Nov 05, 2024 at 08:39:06PM +0800, Tiezhu Yang wrote:
> > > > > For now, it is time to remove the compiler option -fno-jump-tables
> > > > > to enable jump table for objtool if the compiler is GCC and it has
> > > > > the compiler option -mannotate-tablejump, otherwise still keep the
> > > > > compiler option -fno-jump-tables to maintain compatibility with the
> > > > > older compilers.
> 
> ...
> 
> > > ifdef CONFIG_CC_HAS_ANNOTATE_TABLEJUMP
> > > KBUILD_CFLAGS                   += $(call cc-option,-mannotate-tablejump)
> > > else
> > > KBUILD_CFLAGS                   += -fno-jump-tables
> > > endif
> > 
> > Has -mannotate-tablejump been added to Clang?
> 
> Yes.
> 
> > IMO it's better to add it
> > to Clang first, and add Clang & GCC support at once into objtool.
> 
> Looks reasonable, the fact is that there are some corner issues
> compiled with Clang due to different compiler behaviors, most of
> the issues have been addressed and I need to do more test, I will
> send v3 with about 10 patches after the coming merge window.

Hm, I didn't know -mannotate-tablejump existed.  We really need
something which supports all arches, not just loongarch.

Others were looking at adding something similar (adding them to Cc).

-- 
Josh

