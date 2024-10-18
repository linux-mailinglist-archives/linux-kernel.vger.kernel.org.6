Return-Path: <linux-kernel+bounces-371858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4F69A4165
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1BB8287E54
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1D81FF5F9;
	Fri, 18 Oct 2024 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LXIDplC5"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964261D9686
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 14:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262472; cv=none; b=ARSVY8GffNRuKXw6zkJnnmQkcDAOODCSNNJhjLUDLQIMMnneSKE5JSnAypedWY+/dtT9pL0faHTJNwKoFpYJmTO8+fV8x3Leune88GqNY/uM70Hnwbi0junivRcgooW1k9AYd+946S9962z4tRJ58/LKBcDRS8DMw9cXJcNiZE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262472; c=relaxed/simple;
	bh=KXy0QW3rltGxBb2PIdA/nJfKobq/hvGhRvEM2i4kdSE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qtv2iwRTX9MCgIDk45y/0hHroLe0z7oNjhS3OPmkrC+CDC4rUblgDQupTjgWu+zGPdoAGkt7uIXH4TCwSVE71tJ7Z4PfkgbI4f9PCow06TYfvTpOnP8JzZs3Mjlam1NSqFvFPF+cHXE3Zpf47Ve8udvJROmMtGGfuODygFJYaT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LXIDplC5; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d6716e200so263914f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 07:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729262468; x=1729867268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/asqtaNIs/LQ8Ex93/kvLh/pnGYCRBo6rP+voj53b58=;
        b=LXIDplC5kTnB/NjMWut5YZJBFI7FjfM5jDcr/ilZ6jwpeGkOaTS5ce+SEfbnhh92CV
         +rWgYvJOZUj/4U6WcCRZlZUKsFkjsSbp5NgQisz+3+4TIxHSK0UInoASxjP1iOWV8uLY
         O4WVplIrIbTmsW7s09XzqpV2oZqRNCj2Avqasy1hEbCXb2XYkStGh53h+49QlwjaRfKB
         /bhVNeosPGss9Lt1mjaz7myVDTfK554IRoFoWvcZ+X2vy1pV6L1l9Cb0qn14Zcw357m/
         RQ9KoIJ1xsxxyiwwgx2Em+rH0tZaSpTrQQuytdRVBjT54odXwC0GNeHj40/kh3Hp6zL+
         0rbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729262468; x=1729867268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/asqtaNIs/LQ8Ex93/kvLh/pnGYCRBo6rP+voj53b58=;
        b=E3cI2l72xYxtdoThYvwJvvjfDPsmaPfZxcFr57JPZaKOlSLRAMBA3i9MKFkYlJyydQ
         RgdOp9PtCcQzJ+h4BndHU2yX+FPgFWwQGewz+HTPSTPBNsN9xpVjDEj9pbumaJ+qPN4J
         sccz21+M2F1V508O8L4WeankAiciN2YOh8CRvo+c7Fmq7qHA4sRV0kvCY9lx5aQuMXSS
         J6iO09xR8lPCBqqQh9rifnJqfDC7p8wu3jLqaxtVoMrU19uDE4lLr5eu/uXZun1bAD9X
         uc+hZCIrBJ3jIgyYkWAS7MnZCTOdQNmhJnjnkrB50kjTZS/OamOdjCtKfJcsdXMtt5hw
         ZgYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBoBzC+Qik2h5s/XAfYQVKjVcymgCGWV0bWyDa4/tLtdEl5aL/jxCqu/C4WRHhVopkRe8gVhmB50mU35Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyB3x9fo7lSFkmiBE2HX7jQgNM2djs7Trpa4ukGw2ibEXMTlfj
	r+RN75vuBROK7kXo5Dan9kNp647PeJ7Rpb1UhWr7p4zL5LKY9V3FDzD9fiacMP8=
X-Google-Smtp-Source: AGHT+IH1qh5S7J6zFo4ncGg6+V60kyTvlAXKQJ+CLNOpfD5sSenXkDz6pcY/WbUhTw8Yl2xQ5APNLg==
X-Received: by 2002:a5d:5f41:0:b0:37c:df55:c1a5 with SMTP id ffacd0b85a97d-37ea21c778dmr1041803f8f.6.1729262467626;
        Fri, 18 Oct 2024 07:41:07 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ca0b08ad15sm832282a12.40.2024.10.18.07.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 07:41:07 -0700 (PDT)
Date: Fri, 18 Oct 2024 16:41:05 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Ryan Roberts <ryan.roberts@arm.com>, Michael Kelley
 <mhklinux@outlook.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Anshuman Khandual
 <anshuman.khandual@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, David Hildenbrand <david@redhat.com>,
 Greg Marsden <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 00/57] Boot-time page size selection for arm64
Message-ID: <20241018164105.0e5cc7a9@mordecai.tesarici.cz>
In-Reply-To: <20241018145600.0473b1bd@mordecai.tesarici.cz>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
	<20241017142752.17f2c816@mordecai.tesarici.cz>
	<aa9a7118-3067-448e-aa34-bbc148c921a2@arm.com>
	<20241018145600.0473b1bd@mordecai.tesarici.cz>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Oct 2024 14:56:00 +0200
Petr Tesarik <ptesarik@suse.com> wrote:

> On Thu, 17 Oct 2024 13:32:43 +0100
> Ryan Roberts <ryan.roberts@arm.com> wrote:
>=20
> > On 17/10/2024 13:27, Petr Tesarik wrote: =20
> > > On Mon, 14 Oct 2024 11:55:11 +0100
> > > Ryan Roberts <ryan.roberts@arm.com> wrote:
> > >    =20
> > >> [...]
> > >> The series is arranged as follows:
> > >>
> > >>   - patch 1:	   Add macros required for converting non-arch code to =
support
> > >>   		   boot-time page size selection
> > >>   - patches 2-36:  Remove PAGE_SIZE compile-time constant assumption=
 from all
> > >>   		   non-arch code   =20
> > >=20
> > > I have just tried to recompile the openSUSE kernel with these patches
> > > applied, and I'm running into this:
> > >=20
> > >   CC      arch/arm64/hyperv/hv_core.o
> > > In file included from ../arch/arm64/hyperv/hv_core.c:14:0:
> > > ../include/linux/hyperv.h:158:5: error: variably modified =E2=80=98re=
served2=E2=80=99 at file scope
> > >   u8 reserved2[PAGE_SIZE - 68];
> > >      ^~~~~~~~~
> > >=20
> > > It looks like one more place which needs a patch, right?   =20
> >=20
> > As mentioned in the cover letter, so far I've only converted enough to =
get the
> > defconfig *image* building (i.e. no modules). If you are compiling a di=
fferent
> > config or compiling the modules for defconfig, you will likely run into=
 these
> > types of issues.
> >=20
> > That said, I do have some patches to fix Hyper-V, which Michael Kelley =
was kind
> > enough to send me.
> >=20
> > I understand that Suse might be able to help with wider performance tes=
ting - if
> > that's the reason you are trying to compile, you could send me your con=
fig and
> > I'll start working on fixing up other drivers? =20
>=20
> You're right, performance testing is my goal.
>=20
> Heh, the openSUSE master config is cranked up to max. ;-) That would be
> a lot of work, and we don't need all those options for running our test
> suite. Let me disable the conflicting options instead.
>[...]
> I'll see if I can do something about btrfs. Then I can try to boot the
> kernel...

FWIW the kernel builds and _boots_ after applying this patch:

 fs/btrfs/compression.h  |    2 +-
 fs/btrfs/defrag.c       |    2 +-
 fs/btrfs/extent_io.h    |    2 +-
 fs/btrfs/scrub.c        |    2 +-
 include/linux/raid/pq.h |    4 ++--
 lib/raid6/algos.c       |    2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -33,7 +33,7 @@ struct btrfs_bio;
 /* Maximum length of compressed data stored on disk */
 #define BTRFS_MAX_COMPRESSED		(SZ_128K)
 #define BTRFS_MAX_COMPRESSED_PAGES	(BTRFS_MAX_COMPRESSED / PAGE_SIZE)
-static_assert((BTRFS_MAX_COMPRESSED % PAGE_SIZE) =3D=3D 0);
+static_assert((BTRFS_MAX_COMPRESSED % PAGE_SIZE_MAX) =3D=3D 0);
=20
 /* Maximum size of data before compression */
 #define BTRFS_MAX_UNCOMPRESSED		(SZ_128K)
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -1144,7 +1144,7 @@ next:
 }
=20
 #define CLUSTER_SIZE	(SZ_256K)
-static_assert(PAGE_ALIGNED(CLUSTER_SIZE));
+static_assert(IS_ALIGNED(CLUSTER_SIZE, PAGE_SIZE_MAX));
=20
 /*
  * Defrag one contiguous target range.
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -89,7 +89,7 @@ enum {
 int __init extent_buffer_init_cachep(void);
 void __cold extent_buffer_free_cachep(void);
=20
-#define INLINE_EXTENT_BUFFER_PAGES     (BTRFS_MAX_METADATA_BLOCKSIZE / PAG=
E_SIZE)
+#define INLINE_EXTENT_BUFFER_PAGES     (BTRFS_MAX_METADATA_BLOCKSIZE / PAG=
E_SIZE_MIN)
 struct extent_buffer {
 	u64 start;
 	u32 len;
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -100,7 +100,7 @@ enum scrub_stripe_flags {
 	SCRUB_STRIPE_FLAG_NO_REPORT,
 };
=20
-#define SCRUB_STRIPE_PAGES		(BTRFS_STRIPE_LEN / PAGE_SIZE)
+#define SCRUB_STRIPE_PAGES		(BTRFS_STRIPE_LEN / PAGE_SIZE_MIN)
=20
 /*
  * Represent one contiguous range with a length of BTRFS_STRIPE_LEN.
--- a/include/linux/raid/pq.h
+++ b/include/linux/raid/pq.h
@@ -12,7 +12,7 @@
=20
 #include <linux/blkdev.h>
=20
-extern const char raid6_empty_zero_page[PAGE_SIZE];
+extern const char raid6_empty_zero_page[PAGE_SIZE_MAX];
=20
 #else /* ! __KERNEL__ */
 /* Used for testing in user space */
@@ -39,7 +39,7 @@ typedef uint64_t u64;
 #ifndef PAGE_SHIFT
 # define PAGE_SHIFT 12
 #endif
-extern const char raid6_empty_zero_page[PAGE_SIZE];
+extern const char raid6_empty_zero_page[PAGE_SIZE_MAX];
=20
 #define __init
 #define __exit
--- a/lib/raid6/algos.c
+++ b/lib/raid6/algos.c
@@ -19,7 +19,7 @@
 #include <linux/module.h>
 #include <linux/gfp.h>
 /* In .bss so it's zeroed */
-const char raid6_empty_zero_page[PAGE_SIZE] __attribute__((aligned(256)));
+const char raid6_empty_zero_page[PAGE_SIZE_MAX] __attribute__((aligned(256=
)));
 EXPORT_SYMBOL(raid6_empty_zero_page);
 #endif
=20

Petr T

