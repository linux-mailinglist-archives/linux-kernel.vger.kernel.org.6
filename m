Return-Path: <linux-kernel+bounces-296926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6535F95B0AF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBF94B23A04
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C5816EB76;
	Thu, 22 Aug 2024 08:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hL7eLS9d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B482C1C6B5
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 08:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315943; cv=none; b=DTcZU8FVuRea9NC1+ONTeCu/N5UfZThAnp6wSlJ0RV+BW5/7KsD6oN5NEYaCvpaAVvMWHCLtTA7o5tluK7+/SCHMUan4pPw8ppu+oqAELZIVDP7elnAV3bQ+nAfubyocUdQTf8Q5T77wIxDcb0vTahpRNwtW3o6fWjThCOFK1E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315943; c=relaxed/simple;
	bh=fT+LjnGshFLC6OilIQ2o41qvjgIH/HkFb4wDZbRnQc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BiLVhR/Ni6pbuvbukR5LUCx/xXS0c46R5kdB463WSVdaLgXIWoW2hzFXiWSIpY9NpAcVyelOUdw63SamEANdtOcf9YBYTzp1AZ4NvCU73HGdSZVuUsLgdVCeJSdLQeKVoRPwhInLcGSZVjoZqA3KLWnv1f0juVB2T9uxkuROOfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hL7eLS9d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724315940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X0Vz3poE28odMJXeH7OFFxcqgCyFXuVG32HcyaGKNT8=;
	b=hL7eLS9dKPPLDwbNjZBPukaWBVxljyTt1hHob5mla63vIZDVaGPLGr80794JC3G30U/lB0
	CBLJh5zs3QjWbGr1k3cw6Q+BNjmaA5XuxXBQPoz7SwOwBI+mv1yEI4pYUZ01YGX/G14a1/
	lbhnTkN/g+PdqEHivFcHfo0NYMdaKII=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-WMhlBAwINuStXpHSLIZ41Q-1; Thu, 22 Aug 2024 04:38:58 -0400
X-MC-Unique: WMhlBAwINuStXpHSLIZ41Q-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d3efe18d05so642194a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 01:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724315937; x=1724920737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0Vz3poE28odMJXeH7OFFxcqgCyFXuVG32HcyaGKNT8=;
        b=G1R2IvMeB1AijegO0CpGEC6QNkq4/f4z8UPY0R6ChS041r41CJdJnBD5YI+EJVMTM4
         BWkhS23rYkNo3tPvNE8v2+oX2dZ+MbJnbnH9GE47BdX45+QaEvNjCi5iphFEPslDZ8Hn
         c8/VD3U59AGyEM6C+pLM9LvZzP5B7zp1YoQZWaIZoDFMmGoIo0iDDneTtrAocGCGkvq4
         gX9DVp7FqvP0/KoOsCEmnTfOa/ZqzD/RvroXxO+OYsTgrJHUNocdo1QpYn84FcWgX55W
         nTtO/cqDOQE56fjrCvkq5XPfC6cP0+OfeigFdTLiQ1shVwEGIYmkV1MHpUj26aUi/gZI
         qChg==
X-Forwarded-Encrypted: i=1; AJvYcCXzlgc+FYGh5eZsNo+P8tmkUORSQDiTRh+VSA03ady0c3bN8PDzKTjJgrZjr0i7jr8xC2JWQWFflf5XX30=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzJmaCCsNRdXnKl5pmy5Q/WkuCoArg0J9KmyZfyg6/oAJYbB1T
	2ZQZrBEzuH+7NLNWVgjxJvH947b6TUt7UouO6qO3qtmNuHzGKaKp1/HqSItcY2QZvi1FXlr3VMt
	A6LiROaFhly/1PVjGnSlvj/z4iOKmYKBmdyBgdxKjk1lYifNdmpcOk9XEZX3BC0NieLdS8lkLvi
	yQ1sr6KFWgor/JtD/Eoa+WFyMdHv/b+X/NYWqOg5omXcio3VuZFQ==
X-Received: by 2002:a17:90b:4b06:b0:2c9:cf1d:1bcc with SMTP id 98e67ed59e1d1-2d5e9ed072bmr4886746a91.36.1724315937151;
        Thu, 22 Aug 2024 01:38:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE84AxuhDeVWOp48vYsEoskV6JDDEduFK9EcAwn/4EexUiY/p9jPGKilPMbrZ7lPmbXAhd2QaIzXTCWqJq1R1U=
X-Received: by 2002:a17:90b:4b06:b0:2c9:cf1d:1bcc with SMTP id
 98e67ed59e1d1-2d5e9ed072bmr4886728a91.36.1724315936607; Thu, 22 Aug 2024
 01:38:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822024718.2158259-1-yukuai1@huaweicloud.com>
In-Reply-To: <20240822024718.2158259-1-yukuai1@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Thu, 22 Aug 2024 16:38:42 +0800
Message-ID: <CALTww28Pj6kPSc_JGX3ya6B5bgUUyoHxVXd6BnCZ1P-ub404bw@mail.gmail.com>
Subject: Re: [PATCH md-6.12 00/41] md/md-bitmap: introduce bitmap_operations
 and make structure internel
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: song@kernel.org, mariusz.tkaczyk@linux.intel.com, l@damenly.org, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, yukuai3@huawei.com, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 10:52=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Changes from RFC v1:
>  - add patch 1-8 to prevent dereference bitmap directly, and the last
>  patch to make bitmap structure internel.
>  - use plain function alls "bitmap_ops->xxx()" directly;
>
> Changes from RFC v2:
>  - some coding style.
>
> The background is that currently bitmap is using a global spin_lock,
> cauing lock contention and huge IO performance degration for all raid
> levels.
>
> However, it's impossible to implement a new lock free bitmap with
> current situation that md-bitmap exposes the internal implementation
> with lots of exported apis. Hence bitmap_operations is invented, to
> describe bitmap core implementation, and a new bitmap can be introduced
> with a new bitmap_operations, we only need to switch to the new one
> during initialization.
>
> And with this we can build bitmap as kernel module, but that's not
> our concern for now.
>
> This version was tested with mdadm tests. There are still few failed
> tests in my VM, howerver, it's the test itself need to be fixed and
> we're working on it.

Hi Kuai

Do you run lvm2 test regression tests? It's better to run lvm2
regression tests for such a big change.

And by the way, does this patch set have a conflict with patch set
"[RFC V7] md/bitmap: Optimize lock contention". I haven't read the
patches, it's an optimization for the bitmap lock too.

Best Regards
Xiao
>
> Yu Kuai (41):
>   md/raid1: use md_bitmap_wait_behind_writes() in raid1_read_request()
>   md/md-bitmap: replace md_bitmap_status() with a new helper
>     md_bitmap_get_stats()
>   md: use new helper md_bitmap_get_stats() in update_array_info()
>   md/md-bitmap: add 'events_cleared' into struct md_bitmap_stats
>   md/md-bitmap: add 'sync_size' into struct md_bitmap_stats
>   md/md-bitmap: add 'file_pages' into struct md_bitmap_stats
>   md/md-bitmap: add 'behind_writes' and 'behind_wait' into struct
>     md_bitmap_stats
>   md/md-cluster: use helper md_bitmap_get_stats() to get pages in
>     resize_bitmaps()
>   md/md-bitmap: add a new helper md_bitmap_set_pages()
>   md/md-bitmap: introduce struct bitmap_operations
>   md/md-bitmap: simplify md_bitmap_create() + md_bitmap_load()
>   md/md-bitmap: merge md_bitmap_create() into bitmap_operations
>   md/md-bitmap: merge md_bitmap_load() into bitmap_operations
>   md/md-bitmap: merge md_bitmap_destroy() into bitmap_operations
>   md/md-bitmap: merge md_bitmap_flush() into bitmap_operations
>   md/md-bitmap: make md_bitmap_print_sb() internal
>   md/md-bitmap: merge md_bitmap_update_sb() into bitmap_operations
>   md/md-bitmap: merge md_bitmap_status() into bitmap_operations
>   md/md-bitmap: remove md_bitmap_setallbits()
>   md/md-bitmap: merge bitmap_write_all() into bitmap_operations
>   md/md-bitmap: merge md_bitmap_dirty_bits() into bitmap_operations
>   md/md-bitmap: merge md_bitmap_startwrite() into bitmap_operations
>   md/md-bitmap: merge md_bitmap_endwrite() into bitmap_operations
>   md/md-bitmap: merge md_bitmap_start_sync() into bitmap_operations
>   md/md-bitmap: remove the parameter 'aborted' for md_bitmap_end_sync()
>   md/md-bitmap: merge md_bitmap_end_sync() into bitmap_operations
>   md/md-bitmap: merge md_bitmap_close_sync() into bitmap_operations
>   md/md-bitmap: mrege md_bitmap_cond_end_sync() into bitmap_operations
>   md/md-bitmap: merge md_bitmap_sync_with_cluster() into
>     bitmap_operations
>   md/md-bitmap: merge md_bitmap_unplug_async() into md_bitmap_unplug()
>   md/md-bitmap: merge bitmap_unplug() into bitmap_operations
>   md/md-bitmap: merge md_bitmap_daemon_work() into bitmap_operations
>   md/md-bitmap: pass in mddev directly for md_bitmap_resize()
>   md/md-bitmap: merge md_bitmap_resize() into bitmap_operations
>   md/md-bitmap: merge get_bitmap_from_slot() into bitmap_operations
>   md/md-bitmap: merge md_bitmap_copy_from_slot() into struct
>     bitmap_operation.
>   md/md-bitmap: merge md_bitmap_set_pages() into struct
>     bitmap_operations
>   md/md-bitmap: merge md_bitmap_free() into bitmap_operations
>   md/md-bitmap: merge md_bitmap_wait_behind_writes() into
>     bitmap_operations
>   md/md-bitmap: merge md_bitmap_enabled() into bitmap_operations
>   md/md-bitmap: make in memory structure internal
>
>  drivers/md/dm-raid.c     |   7 +-
>  drivers/md/md-bitmap.c   | 560 +++++++++++++++++++++++++++++----------
>  drivers/md/md-bitmap.h   | 268 ++++---------------
>  drivers/md/md-cluster.c  |  91 ++++---
>  drivers/md/md.c          | 155 +++++++----
>  drivers/md/md.h          |   3 +-
>  drivers/md/raid1-10.c    |   9 +-
>  drivers/md/raid1.c       |  78 +++---
>  drivers/md/raid10.c      |  73 ++---
>  drivers/md/raid5-cache.c |   8 +-
>  drivers/md/raid5.c       |  62 ++---
>  11 files changed, 752 insertions(+), 562 deletions(-)
>
> --
> 2.39.2
>


