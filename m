Return-Path: <linux-kernel+bounces-247958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9366292D6A4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49B692876F3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98953195F00;
	Wed, 10 Jul 2024 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XPPuiiuv"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD5F37169
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720629302; cv=none; b=cFkBnLc1IQoYZClOHmhNfP7f2SyC0iaXaEyj+CMLY9apEL9eNYaZFOG8nTYNM/duUAppKrdMc6oVQ+IpAwCdt/hBygQZle/ozJ3HAr4mIxtRzvMS88ZzA4XjYgu2lGAeAIwSHTdNYf5CX4U+v7/9hrhn21i7qIjYcTD17KQj+To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720629302; c=relaxed/simple;
	bh=Bo1iq4RtdnqagKRhpGR0svouD/Lh8LfzKjfI2iX5ut8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hH91KW+JAk2cXla1c+gnAcHH3YAd/CojCbcOOQ9F8fxK6oFy3ijwhyaI7LATaMqaYE/m9zGW57yZ7FGmEXVUtDH8s38tjkv7bVDwQfEQ3bA8zlLFp/dIYcd+e2J/lavAWlltyIMZbc37PsON7aUg9SsK0DRTP6jYfTU3sAyHEnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XPPuiiuv; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e02b79c6f21so7395754276.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720629300; x=1721234100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BF9ive2p9YXUMgbnwW6FuoRy0oF4ePAeLEyGAEOkhY0=;
        b=XPPuiiuv5yy0LLZfelI0p0uV+pjKeDlfIv32MB30JwXWimGbcLwfZKG/BGWvlXIVta
         2p62qzURjcIFKx3B4F2cTdXIIK+9rZKVSVXuX0sgtRQxPi4XxfWFxGM7SkokbsLlSVOt
         faNPFZzcyOuklwhdXjyGUOi2/7e+lwZi+cpW6T3LM5LtrjlZVNJTekXFx5lDb3I1MYr3
         XPX1rouzX9ULy17T2t2MZTQjzml8+R9DBoeqTMKt4AWQKFBxuY45ae+RnbGk9EufO2d9
         DMUyQLyQIRBmxj4Yx1JA6dEwW6eaCxTvIElHFnX0uBiEWm1uNwIA81WY30xWgd7RTHqg
         Nh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720629300; x=1721234100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BF9ive2p9YXUMgbnwW6FuoRy0oF4ePAeLEyGAEOkhY0=;
        b=gPEsju0I8Be+Ji26Ofnn0p5EYaDgAkc6r9+ok7VsBiRhH/2XXpIpB6+wf1+q2X2li/
         KqkCZnLhymeZTAVdtpNIHK7A/w+UVXTA9VBiScvp5aB9g8ktgT7vcNtxtsj2Lfi5iBE4
         elsHJFamteV6uoCTmgEwXoXRqEJo63SzpH/JutpmqhNSEbzvLEf+JLadNPcfGudc+w5p
         XRPrUr9dOzr0Zq4rG9aQUSw43NBs33F4wI6U8qYiURuu6tZlK7Qj3/Ny3HtPTZoRDfbF
         4CFS9RiGr7SFqaqfJoHqO4Pm8C6yJuyNQkTyT490eFSrAxdT9E1iHse4jB1n1/rUuvp3
         eJow==
X-Forwarded-Encrypted: i=1; AJvYcCV3mlCqx9dG73IlF/Qt0EcM5Imao70BZpJrzBaM/TlyEfVQbd52RGwdq510RDX0LzjSCoW3la0z0jZAKMgJAxzXBHde9K9bODbHAF9p
X-Gm-Message-State: AOJu0Yyz1nLBQVghJeOSmyAcTd5UVFad5IsxyIfmbj0Tp+Y73BQ4eDqt
	fyhyklZ4/o0cEhPhIHG9ySJlBUZaUAZ6VZU+LveZzOVlPLLOp96A4z6iW4OsDiB12CRL7HqZnSe
	TybS8V0jt6nmC/R+Yi84ixJTIgzORhUvHffLe
X-Google-Smtp-Source: AGHT+IHZ5TRrLFlHZ0PUpr8ak7tkgpez+qbokWJEToBW1Plq4/Xn+bXBEL4Smbx2jz+0wQ10oMADhbvO2AMcGSXJNgc=
X-Received: by 2002:a25:26c8:0:b0:e03:5d07:e17a with SMTP id
 3f1490d57ef6-e041b17195bmr7050542276.56.1720629299714; Wed, 10 Jul 2024
 09:34:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710135757.25786-1-liulei.rjpt@vivo.com> <5e5ee5d3-8a57-478a-9ce7-b40cab60b67d@amd.com>
 <d70cf558-cf34-4909-a33e-58e3a10bbc0c@vivo.com> <0393cf47-3fa2-4e32-8b3d-d5d5bdece298@amd.com>
 <e8bfe5ed-130a-4f32-a95a-01477cdd98ca@vivo.com>
In-Reply-To: <e8bfe5ed-130a-4f32-a95a-01477cdd98ca@vivo.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 10 Jul 2024 09:34:47 -0700
Message-ID: <CABdmKX26f+6m9Gh34Lb+rb2yQB--wSKP3GXRRri6Nxp3Hwxavg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Support direct I/O read and write for memory
 allocated by dmabuf
To: Lei Liu <liulei.rjpt@vivo.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Andrei Vagin <avagin@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Daniel Vetter <daniel@ffwll.ch>, "Vetter, Daniel" <daniel.vetter@intel.com>, opensource.kernel@vivo.com, 
	quic_sukadev@quicinc.com, quic_cgoldswo@quicinc.com, 
	Akilesh Kailash <akailash@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 8:08=E2=80=AFAM Lei Liu <liulei.rjpt@vivo.com> wrot=
e:
>
>
> on 2024/7/10 22:48, Christian K=C3=B6nig wrote:
> > Am 10.07.24 um 16:35 schrieb Lei Liu:
> >>
> >> on 2024/7/10 22:14, Christian K=C3=B6nig wrote:
> >>> Am 10.07.24 um 15:57 schrieb Lei Liu:
> >>>> Use vm_insert_page to establish a mapping for the memory allocated
> >>>> by dmabuf, thus supporting direct I/O read and write; and fix the
> >>>> issue of incorrect memory statistics after mapping dmabuf memory.
> >>>
> >>> Well big NAK to that! Direct I/O is intentionally disabled on DMA-buf=
s.
> >>
> >> Hello! Could you explain why direct_io is disabled on DMABUF? Is
> >> there any historical reason for this?
> >
> > It's basically one of the most fundamental design decision of DMA-Buf.
> > The attachment/map/fence model DMA-buf uses is not really compatible
> > with direct I/O on the underlying pages.
>
> Thank you! Is there any related documentation on this? I would like to
> understand and learn more about the fundamental reasons for the lack of
> support.

Hi Lei and Christian,

This is now the third request I've seen from three different companies
who are interested in this, but the others are not for reasons of read
performance that you mention in the commit message on your first
patch. Someone else at Google ran a comparison between a normal read()
and a direct I/O read() into a preallocated user buffer and found that
with large readahead (16 MB) the throughput can actually be slightly
higher than direct I/O. If you have concerns about read performance,
have you tried increasing the readahead size?

The other motivation is to load a gajillion byte file from disk into a
dmabuf without evicting the entire contents of pagecache while doing
so. Something like this (which does not currently work because read()
tries to GUP on the dmabuf memory as you mention):

static int dmabuf_heap_alloc(int heap_fd, size_t len)
{
    struct dma_heap_allocation_data data =3D {
        .len =3D len,
        .fd =3D 0,
        .fd_flags =3D O_RDWR | O_CLOEXEC,
        .heap_flags =3D 0,
    };
    int ret =3D ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &data);
    if (ret < 0)
        return ret;
    return data.fd;
}

int main(int, char **argv)
{
        const char *file_path =3D argv[1];
        printf("File: %s\n", file_path);
        int file_fd =3D open(file_path, O_RDONLY | O_DIRECT);

        struct stat st;
        stat(file_path, &st);
        ssize_t file_size =3D st.st_size;
        ssize_t aligned_size =3D (file_size + 4095) & ~4095;

        printf("File size: %zd Aligned size: %zd\n", file_size, aligned_siz=
e);
        int heap_fd =3D open("/dev/dma_heap/system", O_RDONLY);
        int dmabuf_fd =3D dmabuf_heap_alloc(heap_fd, aligned_size);

        void *vm =3D mmap(nullptr, aligned_size, PROT_READ | PROT_WRITE,
MAP_SHARED, dmabuf_fd, 0);
        printf("VM at 0x%lx\n", (unsigned long)vm);

        dma_buf_sync sync_flags { DMA_BUF_SYNC_START |
DMA_BUF_SYNC_READ | DMA_BUF_SYNC_WRITE };
        ioctl(dmabuf_fd, DMA_BUF_IOCTL_SYNC, &sync_flags);

        ssize_t rc =3D read(file_fd, vm, file_size);
        printf("Read: %zd %s\n", rc, rc < 0 ? strerror(errno) : "");

        sync_flags.flags =3D DMA_BUF_SYNC_END | DMA_BUF_SYNC_READ |
DMA_BUF_SYNC_WRITE;
        ioctl(dmabuf_fd, DMA_BUF_IOCTL_SYNC, &sync_flags);
}

Or replace the mmap() + read() with sendfile().

So I would also like to see the above code (or something else similar)
be able to work and I understand some of the reasons why it currently
does not, but I don't understand why we should actively prevent this
type of behavior entirely.

Best,
T.J.








> >
> >>>
> >>> We already discussed enforcing that in the DMA-buf framework and
> >>> this patch probably means that we should really do that.
> >>>
> >>> Regards,
> >>> Christian.
> >>
> >> Thank you for your response. With the application of AI large model
> >> edgeification, we urgently need support for direct_io on DMABUF to
> >> read some very large files. Do you have any new solutions or plans
> >> for this?
> >
> > We have seen similar projects over the years and all of those turned
> > out to be complete shipwrecks.
> >
> > There is currently a patch set under discussion to give the network
> > subsystem DMA-buf support. If you are interest in network direct I/O
> > that could help.
>
> Is there a related introduction link for this patch?
>
> >
> > Additional to that a lot of GPU drivers support userptr usages, e.g.
> > to import malloced memory into the GPU driver. You can then also do
> > direct I/O on that malloced memory and the kernel will enforce correct
> > handling with the GPU driver through MMU notifiers.
> >
> > But as far as I know a general DMA-buf based solution isn't possible.
>
> 1.The reason we need to use DMABUF memory here is that we need to share
> memory between the CPU and APU. Currently, only DMABUF memory is
> suitable for this purpose. Additionally, we need to read very large files=
.
>
> 2. Are there any other solutions for this? Also, do you have any plans
> to support direct_io for DMABUF memory in the future?
>
> >
> > Regards,
> > Christian.
> >
> >>
> >> Regards,
> >> Lei Liu.
> >>
> >>>
> >>>>
> >>>> Lei Liu (2):
> >>>>    mm: dmabuf_direct_io: Support direct_io for memory allocated by
> >>>> dmabuf
> >>>>    mm: dmabuf_direct_io: Fix memory statistics error for dmabuf
> >>>> allocated
> >>>>      memory with direct_io support
> >>>>
> >>>>   drivers/dma-buf/heaps/system_heap.c |  5 +++--
> >>>>   fs/proc/task_mmu.c                  |  8 +++++++-
> >>>>   include/linux/mm.h                  |  1 +
> >>>>   mm/memory.c                         | 15 ++++++++++-----
> >>>>   mm/rmap.c                           |  9 +++++----
> >>>>   5 files changed, 26 insertions(+), 12 deletions(-)
> >>>>
> >>>
> >

