Return-Path: <linux-kernel+bounces-395856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C079BC3FC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 04:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CC161F21DE7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 03:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4456188006;
	Tue,  5 Nov 2024 03:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gkjQJoSb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F4F24B29;
	Tue,  5 Nov 2024 03:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730778164; cv=none; b=s9NR3y+L8UTYx4FgZMG4Tl7BKx2He/tUurN8lr/+MOCkb/YYuFal726E7GdtDJXQyJcpcId8yarqEu1La7lz0VzYx8cVHyGR+i6Cp7caCXT9g+uBopj+PzlSn+LiovQOnFbCZJfxr+urH8jcMCGGUQt32SxWJsM2WDSAhqQVFmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730778164; c=relaxed/simple;
	bh=SYhBjeL3QQHxvmxgitzHmUvIUuClQD3gXZcevAI8S0Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ejFeNeg+9yWmeOR+Zpta6pOUUgWSDsId+wUUXwZbN4YC2IMJvyyg6QvIv8JZazuBS1XBnFN+C9N/FiXddTRci6l3uneU0fQ2hOKzfERa8VQlp1WyjwFdMWHqJjmeevEzRiiEF3WmlkL3peV3nGu/6p9ZdibynVCCo+YS69ztx08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gkjQJoSb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8800EC4CECF;
	Tue,  5 Nov 2024 03:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730778163;
	bh=SYhBjeL3QQHxvmxgitzHmUvIUuClQD3gXZcevAI8S0Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gkjQJoSb91JArGv5LdZEmRqdilkMx31DpAXHP2CeVq2yWiZ03q1+AK2AMthYjqNKE
	 j2LsjW7jzDOSKYZrCv5Xl706gkHWloeYbNVd11ZLhmvn3Wx7gth1N55ITTsO6IQUoq
	 ugAABEH/478N83VcBUelpaXBqGDOAOKE8DNM5M+Y=
Date: Mon, 4 Nov 2024 19:42:42 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Asahi Lina <lina@asahilina.net>
Cc: Sergio Lopez Pascual <slp@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev, Jia He
 <justin.he@arm.com>, Yibo Cai <Yibo.Cai@arm.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Catalin Marinas
 <catalin.marinas@arm.com>
Subject: Re: [PATCH] mm: Fix __wp_page_copy_user fallback path for remote mm
Message-Id: <20241104194242.2456fbd25cd027b338c07855@linux-foundation.org>
In-Reply-To: <251d19c0-f788-4291-a4b3-d6f8a9b3b4f1@asahilina.net>
References: <20241101-mm-remote-pfn-v1-1-080b609270b7@asahilina.net>
	<20241101120717.11db30a5abc6378da7910719@linux-foundation.org>
	<251d19c0-f788-4291-a4b3-d6f8a9b3b4f1@asahilina.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 2 Nov 2024 06:18:54 +0900 Asahi Lina <lina@asahilina.net> wrote:

> 
> 
> On 11/2/24 4:07 AM, Andrew Morton wrote:
> > On Fri, 01 Nov 2024 21:08:02 +0900 Asahi Lina <lina@asahilina.net> wrote:
> > 
> >> If the source page is a PFN mapping, we copy back from userspace.
> >> However, if this fault is a remote access, we cannot use
> >> __copy_from_user_inatomic. Instead, use access_remote_vm() in this case.
> >>
> >> Fixes WARN and incorrect zero-filling when writing to CoW mappings in
> >> a remote process, such as when using gdb on a binary present on a DAX
> >> filesystem.
> >>
> >> [  143.683782] ------------[ cut here ]------------
> >> [  143.683784] WARNING: CPU: 1 PID: 350 at mm/memory.c:2904 __wp_page_copy_user+0x120/0x2bc
> >>
> >> ...
> >>
> > 
> > Thanks.  I assume we should backport this into earlier kernels?
> > 
> > If so, a Fixes: target is desired, to tell people how far back in time
> > it should be ported.
> 
> I think so? I'm not sure how back the bug goes though, possibly a long
> time...
> 
> > I think it's
> > 
> > 83d116c53058 ("mm: fix double page fault on arm64 if PTE_AF is cleared").
> 
> That doesn't sound right. The old code prior to the patch still had the
> __copy_from_user_inatomic() fallback path so it should still have the
> same problem. That fallback goes back to:
> 
>   6aab341e0a28 ("mm: re-architect the VM_UNPAGED logic")
> 
> But the ptrace code back then doesn't seem to be using that codepath at
> all, so that's meaningless. I think this is the proper tag:
> 
>   3565fce3a659 ("mm, x86: get_user_pages() for dax mappings")
> 
> That's when GUP started working for DAX mappings at all, and if my
> reading of the code is correct, at that point do_wp_page() was only
> grabbing the struct page for normal pages to pass to wp_page_copy()
> (triggering the fallback path for DAX mappings). The code has moved
> around a lot today but has the same logic, so I think it's been broken
> since then.

Cool, thanks.

> Should I resend it with the Fixes tag?

That's OK, I edited the mm.git changelog.


