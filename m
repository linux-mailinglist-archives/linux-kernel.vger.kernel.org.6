Return-Path: <linux-kernel+bounces-576934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C73A71636
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E43837A5220
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EACD1DED5F;
	Wed, 26 Mar 2025 12:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4AjXU5U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A514C2A1B2;
	Wed, 26 Mar 2025 12:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742990845; cv=none; b=obmDv4pc6av+jQnIv374SmTX0gH/v7FqR4SyI84l8jSQwcNO6K7LCA/FGnERPJVejzksSWJiuIA72L5F12kwvvv0Gp1x/1BKrxwE7RROb8MerN7GMoEaR10nEw2uuFGpTih4okaBMIgQhi9s3AKAL45Cn7fR5SIt2nUDnDiw5Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742990845; c=relaxed/simple;
	bh=MfJ0FXYJCv8THmu44KFWCJKW5Y6BQslOAVgSU6DpjPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSxyLxSQRN00rBTte326TCM/+uop0uzjzQ2A90CUzvO4P1gokGe7MU2MEbcGccbnnD1wfdZOKcimE/AM/IhZ6m/MJZsdch8HhhkHBOwPg+C6GlSzfs/oRU0TwMOtLudL+O0uzTrSiJUaGNe368raPUgwo0M1XvlfV2T/E/d5Bw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4AjXU5U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95BC6C4CEED;
	Wed, 26 Mar 2025 12:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742990845;
	bh=MfJ0FXYJCv8THmu44KFWCJKW5Y6BQslOAVgSU6DpjPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q4AjXU5UbkAQx5aYar7PCRjCmarMZeYXZZkrMlCatQoWK5Vt4UvNZUDT6N/8RNsTZ
	 7o5Uxs8c15urYeBLkON6Vo+a/MWPcWMcSWDzJDC7U/kxmVCl4X3jmNI9XSk2Lypjuj
	 Q5b9Qy1JR/Y+stStQg60BmTHSgU4Ma1/0fWEyqpudzP/0aUueElJ4ot+DcUUMTbuYr
	 9C09LODiWWoP6DYgnYWcFcVBxLrb2hOz3xJiCc9Ffrxdf7OQs5rJ0TAY0gOfwc295v
	 P9J6rYku7UtdVF/dK6zoP0E9eWJm0EkggPLgNL1NqZ/b3BX8aJ/V4x18OQn4+KJYqA
	 KXKzGSk4uhW/w==
Date: Wed, 26 Mar 2025 08:07:19 -0400
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org,
	graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org,
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com,
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, dwmw2@infradead.org,
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com,
	corbet@lwn.net, krzk@kernel.org, mark.rutland@arm.com,
	pbonzini@redhat.com, pasha.tatashin@soleen.com, hpa@zytor.com,
	peterz@infradead.org, ptyadav@amazon.de, robh+dt@kernel.org,
	robh@kernel.org, saravanak@google.com,
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org,
	tglx@linutronix.de, thomas.lendacky@amd.com,
	usama.arif@bytedance.com, will@kernel.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v5 09/16] kexec: enable KHO support for memory
 preservation
Message-ID: <Z-Pt9yLP0cMR23cJ@kernel.org>
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-10-changyuanl@google.com>
 <20250321134629.GA252045@nvidia.com>
 <Z98Lmo50h5RboFXq@kernel.org>
 <Z+BZOKSpyPA1Pyu+@nvidia.com>
 <Z-Gh-t9xB21UNGU2@kernel.org>
 <Z+G7iHUdRZGv1Ose@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+G7iHUdRZGv1Ose@nvidia.com>

On Mon, Mar 24, 2025 at 05:07:36PM -0300, Jason Gunthorpe wrote:
> On Mon, Mar 24, 2025 at 02:18:34PM -0400, Mike Rapoport wrote:
> > On Sun, Mar 23, 2025 at 03:55:52PM -0300, Jason Gunthorpe wrote:
> > > On Sat, Mar 22, 2025 at 03:12:26PM -0400, Mike Rapoport wrote:
> > >  
> > > > > > +		page->private = order;
> > > > > 
> > > > > Can't just set the page order directly? Why use private?
> > > > 
> > > > Setting the order means recreating the folio the way prep_compound_page()
> > > > does. I think it's better to postpone it until the folio is requested. This
> > > > way it might run after SMP is enabled. 
> > > 
> > > I see, that makes sense, but also it could stil use page->order..
> > 
> > But there's no page->order :)
> 
> I mean this:
> 
> static inline unsigned int folio_order(const struct folio *folio)
> {
>         if (!folio_test_large(folio))
>                 return 0;
>         return folio->_flags_1 & 0xff;
> }

I don't think it's better than page->private, KHO will need to
prep_compound_page() anyway so these will be overwritten there.
And I don't remember, but having those set before prep_compound_page()
might trigger VM_BUG_ON_PGFLAGS().
  
> Jason

-- 
Sincerely yours,
Mike.

