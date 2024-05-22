Return-Path: <linux-kernel+bounces-185958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E2C8CBD63
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECC891C20D2A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 08:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A98080BEC;
	Wed, 22 May 2024 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LwjrOOpI"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75DD7F486
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 08:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716368298; cv=none; b=O0LxSxLlP2Zl9AZbnpgaHd7RH9r7y8oSTMDC9W31ITI/PLAmFWnu7Wdeh9xLRYEEo72e5FlWGa2Dm/k+ZbXzgwZuq3UTOYP1WmRdGg1Jgf1NG3K3MrWdv1itVuYmIYxubsa3xL8oxipbUqkr7cbsAdpM/MkxEnh2aWliX5vQII4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716368298; c=relaxed/simple;
	bh=5drciXMGAdYELysmjzz3Rf4LK6AJOqcEGCFERe2XB+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ID+hiUif451lE+GS6CyshB0cacwDSZxp6iYeMkMal2akGrKh6fqLvjqJG41wqDa9EZP4MzWWO1000cY5KtWawLhAxIVNsnFb8VqbGCqivTYH6a3VRnqYd9InNbPyl1PajWXwbjm58mOWDZunLkF5gFwSTCSQzzrrNM7n/hf/azA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=LwjrOOpI; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a5a5c930cf6so971273066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1716368293; x=1716973093; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LjTE4WfHhoeXUwUqEwrecuarcFt+4f9tVsycy9v4ZlE=;
        b=LwjrOOpIS/usGDwNKQHzZp/tdFO4on8C5ttwUFgWhkhf2WArpAyDZ+ySx9oUZrKaVr
         IOK4R3OkLXjV9f8cqsJOAb71/NaDCnFAs4teLXQNmEvbEAKFLTA6HD7HCguEI5K89aKe
         tKUY3GCsPBSXLDpqEHXztADX+whM8oTbx9kjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716368293; x=1716973093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LjTE4WfHhoeXUwUqEwrecuarcFt+4f9tVsycy9v4ZlE=;
        b=pG+gFAYKTClASWTfzhE1Um/UqE6xq+N947Ar3cgaWP24L/aO9ba1kutBxaG2GpbO43
         FXxumF5OFuZRucRbmDq94QwJwi95GcCEHDz0I81zXxwp1OD9P5UeWsDsSmshKg2BkpFl
         5JKNe46VoRvM/tHHvFb6/X8n28A2HxfQzr/5AR7VBdOS2r6V/rhdkOileRayx6w3KxA6
         5w6DmSdljS93FWid8thKBhyAtYj/Eh/Oi3/LWx7UmENmRC1CSSWbJ+q2ktew/o5eO7uf
         t3lH4jTG4OVv2H8G39M7/zaPwxqdF026NlWGl85s9WJzun1vRbyAGTHKUK/xppJLq6fc
         1abA==
X-Forwarded-Encrypted: i=1; AJvYcCVmpC9Po5EdhaCCSUsnScNodJB3r+lCJMytvM8TmhjmS2CZMG84aFUREl2Ue6iIq/M33l03t0ReHlPHqGp5ZsnI9PpoP7Uokc3ALGl6
X-Gm-Message-State: AOJu0YyqxrlmyOGkROPewirZXSON46J5EU3VcBcD7eYzCWvRvxZfVKh8
	27TBi9MJWZj8xDD7vn57abRlyggGbeAtKIcE4s4AjL2rgP7TnrZBLOcMcCAXz7y7In+YDayoJ6Y
	zTXrTF4TrhJq+YyQdtbkKD/Ga7LFRzX00bV6VuA==
X-Google-Smtp-Source: AGHT+IGgLmVa8nGFRuH2lLvEoDTQ6Rj2QgnH8O/MrBxes++zUajUrC9MH9ZOGLxZV91yfG+FjV6yMUJtua3Xpybi24I=
X-Received: by 2002:a17:906:4086:b0:a5a:6367:7186 with SMTP id
 a640c23a62f3a-a62281910e7mr77367066b.70.1716368293170; Wed, 22 May 2024
 01:58:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708709155.git.john@groves.net> <CAOQ4uxiPc5ciD_zm3jp5sVQaP4ndb40mApw5hx2DL+8BZNd==A@mail.gmail.com>
 <CAJfpegv8XzFvty_x00UehUQxw9ai8BytvGNXE8SL03zfsTN6ag@mail.gmail.com>
 <CAOQ4uxg9WyQ_Ayh7Za_PJ2u_h-ncVUafm5NZqT_dt4oHBMkFQg@mail.gmail.com> <kejfka5wyedm76eofoziluzl7pq3prys2utvespsiqzs3uxgom@66z2vs4pe22v>
In-Reply-To: <kejfka5wyedm76eofoziluzl7pq3prys2utvespsiqzs3uxgom@66z2vs4pe22v>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 22 May 2024 10:58:01 +0200
Message-ID: <CAJfpegvQefgKOKMWC8qGTDAY=qRmxPvWkg2QKzNUiag1+q5L+Q@mail.gmail.com>
Subject: Re: [RFC PATCH 00/20] Introduce the famfs shared-memory file system
To: John Groves <John@groves.net>
Cc: Amir Goldstein <amir73il@gmail.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, john@jagalactic.com, 
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, dave.hansen@linux.intel.com, 
	gregory.price@memverge.com, Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 May 2024 at 04:05, John Groves <John@groves.net> wrote:
> I'm happy to help with that if you care - ping me if so; getting a VM running
> in EFI mode is not necessary if you reserve the dax memory via memmap=, or
> via libvirt xml.

Could you please give an example?

I use a raw qemu command line with a -kernel option and a root fs
image (not a disk image with a bootloader).


> More generally, a famfs file extent is [daxdev, offset, len]; there may
> be multiple extents per file, and in the future this definitely needs to
> generalize to multiple daxdev's.
>
> Disclaimer: I'm still coming up to speed on fuse (slowly and ignorantly,
> I think)...
>
> A single backing device (daxdev) will contain extents of many famfs
> files (plus metadata - currently a superblock and a log). I'm not sure
> it's realistic to have a backing daxdev "open" per famfs file.

That's exactly what I was saying.

The passthrough interface was deliberately done in a way to separate
the mapping into two steps:

 1) registering the backing file (which could be a device)

 2) mapping from a fuse file to a registered backing file

Step 1 can happen at any time, while step 2 currently happens at open,
but for various other purposes like metadata passthrough it makes
sense to allow the mapping to happen at lookup time and be cached for
the lifetime of the inode.

> In addition there is:
>
> - struct dax_holder_operations - to allow a notify_failure() upcall
>   from dax. This provides the critical capability to shut down famfs
>   if there are memory errors. This is filesystem- (or technically daxdev-
>   wide)

This can be hooked into fuse_is_bad().

> - The pmem or devdax iomap_ops - to allow the fsdax file system (famfs,
>   and [soon] famfs_fuse) to call dax_iomap_rw() and dax_iomap_fault().
>   I strongly suspect that famfs_fuse can't be correct unless it uses
>   this path rather than just the idea of a single backing file.

Agreed.

> - the dev_dax_iomap portion of the famfs patchsets adds iomap_ops to
>   character devdax.

You'll need to channel those patches through the respective
maintainers, preferably before the fuse parts are merged.

> - Note that dax devices, unlike files, don't support read/write - only
>   mmap(). I suspect (though I'm still pretty ignorant) that this means
>   we can't just treat the dax device as an extent-based backing file.

Doesn't matter, it'll use the iomap infrastructure instead of the
passthrough infrastructure.

But the interfaces for regular passthrough and fsdax could be shared.
Conceptually they are very similar:  there's a backing store indexable
with byte offsets.

What's currently missing from the API is an extent list in
fuse_open_out.   The format could be:

  [ {backing_id, offset, length}, ... ]

allowing each extent to map to a different backing device.

> A dax device to famfs is a lot more like a backing device for a "filesystem"
> than a backing file for another file. And, as previously mentioned, there
> is the iomap_ops interface and the holder_ops interface that deal with
> multiple file tenants on a dax device (plus error notification,
> respectively)
>
> Probably doable, but important distinctions...

Yeah, that's why I suggested to create a new source file for this
within fs/fuse.  Alternatively we could try splitting up fuse into
modules (core, virtiofs, cuse, fsdax) but I think that can be left as
a cleanup step.

> First question: can you suggest an example fuse file pass-through
> file system that I might use as a jumping-off point? Something that
> gets the basic pass-through capability from which to start hacking
> in famfs/dax capabilities?

An example is in Amir's libfuse repo at

   https://github.com/libfuse/libfuse

> I'm confused by the last item. I would think there would be a fuse
> inode per famfs file, and that multiple of those would map to separate
> extent lists of one or more backing dax devices.

Yeah.

> Or maybe I misunderstand the meaning of "fuse inode". Feel free to
> assign reading...

I think Amir meant that each open file could in theory have a
different mapping.  This is allowed by the fuse interface, but is
disallowed in practice.

I'm in favor of caching the extent map so it only has to be given on
the first open (or lookup).

Thanks,
Miklos

