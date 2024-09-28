Return-Path: <linux-kernel+bounces-342672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3060989179
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 23:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E9E4285DC8
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 21:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD90D16DEB2;
	Sat, 28 Sep 2024 21:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAlBq/V0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE7B136358
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 21:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727557878; cv=none; b=MHlZmGe6Aie7jdsPuZDQBZSWSPliT2BPEyE2HDYvTAiV2r8q05sL9F9FtpbUiNx+VdVEPx5kpYqrct8/W97CwGc7MWryeyN4AiC+qz98RsP5EiUMah37S3ebBLurh/wCq3cSAVDZTJhKRjF2fBHeLzfV51RKHFI++B5pRZxuvhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727557878; c=relaxed/simple;
	bh=xdeG288R8PQh2PECjs5Ydvy8L83lNJIFNPWwgpCp5rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArVsVXwAZ8Dr2Csq3Xhalx7jSIid4ua/LRzNv3L810Xn7lrR4RsXOSryU2DHTVN1ij//KIzIxyNHj73yvDzoX1qqOymn51T66BohcvFxvAx0iDcWbRqA6hlePdwxQgyrDFPw2QkBh6hUqtt6oIwV1FdHaMk7CHyhnSwIYvOYyj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAlBq/V0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4B0C4CEC3;
	Sat, 28 Sep 2024 21:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727557877;
	bh=xdeG288R8PQh2PECjs5Ydvy8L83lNJIFNPWwgpCp5rE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iAlBq/V0Stwg/CcdiA5PfpsJmjMdhsaK4QEO6VlMXmEPCN3zyk5vkFMVFBn8+QhIj
	 MsG8d/DmDHnTVfqon1/wmL0CF9lxPc1J9h06IS7Cv9w/nFCG0K7EhPdpvkI7WZVteG
	 u3NVzKba41smYrsuBFwzIaGS2OURKGTFvgsATBsARuJCJD90LArzsIuGiKDQ1+EfPL
	 3gL2FqJdGtfjKv7iVYwBGnhvUjpTvs24cVZ5AmgK2tTFEXoILCvyDfV7sQeWwet1NM
	 uAtrlafN32GasGHHo3lfWgeTnNaBKQfw0Fp0K8T/VZ3nr8AJCXk3vDHSjBnfnBvdSy
	 Fjgx+sYkkKjGw==
Date: Sat, 28 Sep 2024 14:11:17 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Zhang Boyang <zhangboyang.id@gmail.com>,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/5] rslib: Bug fixes and improvements for Reed-Solomon
 library
Message-ID: <202409281410.FBD093EAB@keescook>
References: <20240924123141.16962-1-zhangboyang.id@gmail.com>
 <6a92d261-8cc4-459a-a44f-365f9d41f289@infradead.org>
 <CAHk-=wgs70xZ_F=3+52cuhXNsK3eDWVp3PJtExbCAQrUdhcRwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgs70xZ_F=3+52cuhXNsK3eDWVp3PJtExbCAQrUdhcRwg@mail.gmail.com>

On Thu, Sep 26, 2024 at 10:12:39AM -0700, Linus Torvalds wrote:
> On Thu, 26 Sept 2024 at 10:03, Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> >
> > If I were making this patch series, I would send it to Andrew Morton,
> > but if Linus takes it, I'm certainly OK with that.
> 
> I don't feel like I have the expertise of something like rslib, and
> would actually suggest it go through one of the (very very few) users.
> 
> It's just pstore and some NAND chip drivers, afaik.

I can review this soon and can take it via pstore; I'll probably go poke
tglx though, since IIRC, he was the original author.

-- 
Kees Cook

