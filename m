Return-Path: <linux-kernel+bounces-413556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A96A59D1AEB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 23:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A8442814ED
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 22:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F09E1E7C3B;
	Mon, 18 Nov 2024 22:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="Gb6Yp+hb"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0641E570E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 22:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731967762; cv=none; b=Mm9TajjJcaKYBMq45CWQdg3gq6GE/XwUewecZbYK4vRzkkO5GByUMR4zphWgmUwRjJgwyphEbkF2NKDwfYX7qh7Tj9YLtyWlC3tNDMUFl2sVJZN7tsjxY3U5zakJejJ3QnVuJ+NqO0uZOVTQk1xEPdfyeyHK4RTrQ536xVcbyEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731967762; c=relaxed/simple;
	bh=I8MIscQQe9cVfzpDABcS2/+GpjCcV2Zx/6rrV6Zgl5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rWh0INQqtOslwnZsCKmhwJgnNv9ughwJ923c9CWj1gO9BcTjtEOUpO4XUeFQG93/Xej9o0X3irSI2EX9/PySY76CdcKiv5KiqjNs35/koUQvpIkv4kyMTY8cEfgssy/SYlozi0oh8HrvXDwTI4wPpCMTjeFw5qXDnKFO1Y76kz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=Gb6Yp+hb; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-460a415633fso27249741cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 14:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1731967759; x=1732572559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8MIscQQe9cVfzpDABcS2/+GpjCcV2Zx/6rrV6Zgl5M=;
        b=Gb6Yp+hb3LS2S3zgzu9xXG4v1kmiTe9wY1PbV3QgOWMQHSmHWOWT1xI8dU7iO68kBV
         4Ojo3PWXytSFdernv3ZGsb9YFfVbwDrZd5mI/0vNDx9a1+Q/WWeCJ3GevOlUWT/SqRy4
         Gy05r3/i+oZu1i3SopG02MLYAPG24QJUhTP/gryTdmzcfiNnp2l3x1v7JdQqq6aM2mR9
         vfETuXNlo83U6lSzYagXrpZbraIsauv0elkttf3q65wCPujazJlhFsgWbv1NLU2UjZjj
         VAIK7E0RbqfZVOV7eBQtKfINmP2xPdFxtDvH6O6VPmZrYP75MyniX6+BzzI7rtGsZoi+
         MBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731967759; x=1732572559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8MIscQQe9cVfzpDABcS2/+GpjCcV2Zx/6rrV6Zgl5M=;
        b=G4G+Ot0i9eJPE5tdwGnbgJhzDI6ks+KxH5XHYSqFycSWg5jx93dq6VEzxMFfw/vxYV
         iA4Mgv6qlSliT7P9D8pqzUsSq9fA7iioW9filwlL3lAe9WXSeob+p3tia3aB53gGQu4n
         5epXoTXSHkivO3khFhFgAJjz9Fcwuq+ky/slSR29yeiwab1qVjrZkVXez0whfbQjI+Ub
         Pp+zOl1qYbv+xxi7uGF7SmcbUYs10KoHzKXh93qCIA7WfcrepJA+BGiOCJbAMSn3STV8
         8XOKHBf75wNBMewb3vmL3fsAdsvJPXnKs4UmW7ARpsbBH6JeSn3ThXomKEYDmcCzfqUY
         JtzQ==
X-Gm-Message-State: AOJu0YyLnJ9HHKhYJec7pQ/7xDrQXojmVPpGV3WdGrojnsj7sLDls+Fk
	i6gLK9DHZM2IrAVBYcuEp7fBiWRRTC9JBuarA63ohIXXg7Zx0N3x23lD3+PUVaJubWplQ+aGnas
	ibwg79ZEnk4cchbIFifC24VaaIvzc3f6d3xVeyQ==
X-Google-Smtp-Source: AGHT+IGuHkyDbKbXTopolKHlpXUuh5hPb8odsFN1/bRhiOBmnf88AGPczox19phVHKQRb/h9sm7V4erFguZn2MVlnKk=
X-Received: by 2002:ac8:5946:0:b0:458:2764:37d5 with SMTP id
 d75a77b69052e-46363de80famr188224651cf.6.1731967759219; Mon, 18 Nov 2024
 14:09:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com> <ZzuRSZc8HX9Zu0dE@google.com>
In-Reply-To: <ZzuRSZc8HX9Zu0dE@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 18 Nov 2024 17:08:42 -0500
Message-ID: <CA+CK2bAAigxUv=HGpxoV-PruN_AhisKW675SxuG_yVi+vNmfSQ@mail.gmail.com>
Subject: Re: [RFCv1 0/6] Page Detective
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, derek.kiernan@amd.com, 
	dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, tj@kernel.org, 
	hannes@cmpxchg.org, mhocko@kernel.org, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	vbabka@suse.cz, jannh@google.com, shuah@kernel.org, vegard.nossum@oracle.com, 
	vattunuru@marvell.com, schalla@marvell.com, david@redhat.com, 
	willy@infradead.org, osalvador@suse.de, usama.anjum@collabora.com, 
	andrii@kernel.org, ryan.roberts@arm.com, peterx@redhat.com, oleg@redhat.com, 
	tandersen@netflix.com, rientjes@google.com, gthelen@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 2:11=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> On Sat, Nov 16, 2024 at 05:59:16PM +0000, Pasha Tatashin wrote:
> > Page Detective is a new kernel debugging tool that provides detailed
> > information about the usage and mapping of physical memory pages.
> >
> > It is often known that a particular page is corrupted, but it is hard t=
o
> > extract more information about such a page from live system. Examples
> > are:
> >
> > - Checksum failure during live migration
> > - Filesystem journal failure
> > - dump_page warnings on the console log
> > - Unexcpected segfaults
> >
> > Page Detective helps to extract more information from the kernel, so it
> > can be used by developers to root cause the associated problem.
> >
> > It operates through the Linux debugfs interface, with two files: "virt"
> > and "phys".
> >
> > The "virt" file takes a virtual address and PID and outputs information
> > about the corresponding page.
> >
> > The "phys" file takes a physical address and outputs information about
> > that page.
> >
> > The output is presented via kernel log messages (can be accessed with
> > dmesg), and includes information such as the page's reference count,
> > mapping, flags, and memory cgroup. It also shows whether the page is
> > mapped in the kernel page table, and if so, how many times.
>
> This looks questionable both from the security and convenience points of =
view.
> Given the request-response nature of the interface, the output can be
> provided using a "normal" seq-based pseudo-file.

We opted to use dmesg for output because it's the standard method for
capturing kernel information and is commonly included in bug reports.
Introducing a new file would require modifying existing data
collection scripts used for reporting, so this approach minimizes
disruption to existing workflows.

> But I have a more generic question:
> doesn't it make sense to implement it as a set of drgn scripts instead
> of kernel code? This provides more flexibility, is safer (even if it's bu=
ggy,
> you won't crash the host) and should be at least in theory equally
> powerful.

Regarding your suggestion, our plan is to perform reverse lookups in
all page tables: kernel, user, IOMMU, and KVM. Currently, we only
traverse the kernel and user page tables, but we intend to extend this
functionality to IOMMU and KVM tables in future updates, I am not sure
if drgn can provide this level of details within a reasonable amount
of time.

This approach will be helpful for debugging memory corruption
scenarios. Often, external mechanisms detect corruption but require
kernel-level information for root cause analysis. In our experience,
invalid mappings persist in page tables for a period after corruption,
providing a window to identify other users of the corrupted page via
timely reverse lookup.

Additionally, using crash/drgn is not feasible for us at this time, it
requires keeping external tools on our hosts, also it requires
approval and a security review for each script before deployment in
our fleet.

Thanks,
Pasha

