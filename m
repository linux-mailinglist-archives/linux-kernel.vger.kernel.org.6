Return-Path: <linux-kernel+bounces-355406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D009951C4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ABEE281DAE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C6D1DFDB5;
	Tue,  8 Oct 2024 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+MnrN8L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2912A1DE3AE;
	Tue,  8 Oct 2024 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397953; cv=none; b=t+H4uTLOg4i5KVWpoSZszeQCi4kSVlYVi3aRQIVq4XnmagAJDQ44o9w/0FcZVNV4KtNxhl05VuLKt4D5nz3UcLv4XfykunfPtmkSupcQO7tAdKS+XFSy2rAOOtm0HeTkRL6k8ecuTsNXGPkGG2wH3ZisJEcGGfJYkNuzVYdlbO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397953; c=relaxed/simple;
	bh=t9DSeeXfOlcRotreqKbSLlHeaWLMsRoQIASSMIB2hwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Brj3HuWQ7EZvJaBVgPnvRi/u2ThZMPlBHOrribvVwM+cq96GRskCAku5tybhG1PfHaAFD8jvk/MkqYDuqZlYwZ7ckI3EFPjryRA7ycYYIkLA133vgg16BsjVZH90cHMEe6A9tqAg+DMuKRmQR/wBu9qYsv7WiXgMsbTYDikQ81A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+MnrN8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5887C4CEC7;
	Tue,  8 Oct 2024 14:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728397952;
	bh=t9DSeeXfOlcRotreqKbSLlHeaWLMsRoQIASSMIB2hwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F+MnrN8LCmWYxWqnxbR/QkkXoB/84sd2a4yRgwzGvjfEp31aAwR/+q6fr8sOjf6eP
	 mjmyVgiOU3A7pgB6Vu06FndHVTm322OhTvffGOZ0+XQj2OVxc/MHl2Pcnu62ZSj8un
	 dCWe4d3dY6rGiLZrWz376i+xyJ+F4Yn6CHXcjcs0LhCRs2qALHS0pg6+ulcispOwbf
	 UMs6KGdsmKRuj8sPM8NCK0yO8J/U0DQHwpz//VSDDmuzKgiE9Xg5N+QZsBPChGwChv
	 uVstgtL+TNtLyzGlL+xvqGcJwdHaV5H3fp9tieoZN2MP+4/168EI+XuF/cirjHhZnM
	 6oGcL6LXXbb8w==
Date: Tue, 8 Oct 2024 16:32:25 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, akpm@linux-foundation.org
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com, lina@asahilina.net,
	mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com,
	lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v9 25/29] rust: alloc: implement `Cmalloc` in module
 allocator_test
Message-ID: <ZwVCeQK4qu3HPBGQ@cassiopeiae>
References: <20241004154149.93856-1-dakr@kernel.org>
 <20241004154149.93856-26-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004154149.93856-26-dakr@kernel.org>

On Fri, Oct 04, 2024 at 05:41:29PM +0200, Danilo Krummrich wrote:
> So far the kernel's `Box` and `Vec` types can't be used by userspace
> test cases, since all users of those types (e.g. `CString`) use kernel
> allocators for instantiation.
> 
> In order to allow userspace test cases to make use of such types as
> well, implement the `Cmalloc` allocator within the allocator_test module
> and type alias all kernel allocators to `Cmalloc`. The `Cmalloc`
> allocator uses libc's realloc() function as allocator backend.
> 
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc/allocator_test.rs | 88 ++++++++++++++++++++++++++---
>  1 file changed, 81 insertions(+), 7 deletions(-)
> 

Here we can remove it again:

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 912b6ba2abaa..8acaa24a8f1f 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -215,7 +215,6 @@ unsafe fn free(ptr: NonNull<u8>, layout: Layout) {
     }
 }

-#[allow(dead_code)]
 /// Returns a properly aligned dangling pointer from the given `layout`.
 pub(crate) fn dangling_from_layout(layout: Layout) -> NonNull<u8> {
     let ptr = layout.align() as *mut u8;

@Miguel: I pushed [1], which is already rebased to rust-next (-rc2) and contains
the fixups.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/mm

