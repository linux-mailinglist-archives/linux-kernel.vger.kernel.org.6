Return-Path: <linux-kernel+bounces-532338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D785AA44BCF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CEA53B5981
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69791206F18;
	Tue, 25 Feb 2025 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJCvw13g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1503D984
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740513026; cv=none; b=pXRlysvcHjPaidchExhn0OyfJahY10/jEto40NLAjj9kyAojgeYc0cfBZThYhbYculUURiLrLDMdf8R7gK5eRxMRSIX5onfxEFIe6oWoDJvJkXG9Q5M+7gJvufyzGjXEVzsnyfthCy+nBo5MPwVMKyk+aaSIIlZExUUQ7XYAkgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740513026; c=relaxed/simple;
	bh=yfAk0Bn+rwLzhnHTwJ1abBgwmVGuLjkYX9Pi98Wzfmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rs1InUqM/Q0zcCHEyU69uYz6wsm70IX13Lu/X2TzXI1JD3Ntp8zTnXOyidz0P45DnbdHXJu0CTwQvA0wOHfUi3x7GrQ/tVQsZcLaum5IeLdaPBaEWJIP8bOMEtRQqNnBpa6my6zHqsWLwpGqn7JzPXHVc2tVPuH11yAL4PFXLR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJCvw13g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51957C4CEDD;
	Tue, 25 Feb 2025 19:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740513026;
	bh=yfAk0Bn+rwLzhnHTwJ1abBgwmVGuLjkYX9Pi98Wzfmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OJCvw13gGb7chgCXEwVZnAv1/IRTAHW3KQUZnAfpiwKmp+1h4n7j6teQK9XcKqkV3
	 8ObmjEbfrq6hOcit2EAhEhzClUG9LXIAAxsVNwI5I4hElttIL26qk2jk99vmQaDF2Y
	 QWaFPIiAKu+BAz6vSmw3KBs2WrCNgeSL4VNkY1Ac7ZD6yL5jJeFjktUpgEy3W2MRkc
	 uzxncxGSOD6R/8QjnaS/ewrf1FNkUoSD8BJHaGAb+IzW0khrjiABo9vWLZt4dRWqxh
	 EHdoWJO59n7bvVPJuYJ5dGoqVyapX7NipwsROUeMNxsM5xp8Ue/akampHDP6LJEHzg
	 Mh5QyKv/V8qZQ==
Date: Tue, 25 Feb 2025 20:50:17 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mtrr: Remove unnecessary strlen() in mtrr_write()
Message-ID: <Z74e-ZHCu6cV4dfi@gmail.com>
References: <20250225131621.329699-2-thorsten.blum@linux.dev>
 <Z73HDk9p2P_Zigu2@gmail.com>
 <35EF1145-7214-4B51-8168-4D54028BE0E5@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35EF1145-7214-4B51-8168-4D54028BE0E5@linux.dev>


* Thorsten Blum <thorsten.blum@linux.dev> wrote:

> On 25. Feb 2025, at 14:35, Ingo Molnar wrote:
> > * Thorsten Blum <thorsten.blum@linux.dev> wrote:
> > 
> >> The local variable length already holds the string length after calling
> >> strncpy_from_user(). Using another local variable linlen and calling
> >> strlen() is therefore unnecessary and can be removed. Remove linlen
> >> and strlen() and use length instead.
> >> 
> >> Compile-tested only.
> >> 
> >> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> >> ---
> > 
> > I see no corner-case analysis in the changelog about what may happen if 
> > the copy fails partially.
> 
> Hi Ingo,
> 
> I'm not sure what you mean. Why would I describe something I didn't
> change? This patch only removes an unnecessary string (line) length
> calculation and shouldn't affect the logic in any way.
> 
> If strncpy_from_user() fails, we immediately return length from
> mtrr_write(), but my patch doesn't change this - unless I'm missing
> something?

My bad: I was fixated on this 'some data may have been copied' language 
in the strncpy_from_user() documentation:

 * If access to userspace fails, returns -EFAULT (some data may have been
 * copied).

which would make the strlen() result ambiguous. But this doesn't matter 
here - if there was a fault then we get an unconditional -EFAULT from 
strncpy_from_user(), so your patch should be equivalent to the previous 
logic.

Thanks,

	Ingo

