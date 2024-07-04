Return-Path: <linux-kernel+bounces-241738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362AE927EF4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 00:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A46FB21CBF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 22:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41203143C7E;
	Thu,  4 Jul 2024 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="UwrLnUIL"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1017F14375C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 22:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720131215; cv=none; b=Q1HEiEYxTrHctOcTjH/0ICZhKSSuLuylmDEiwoKEfU382lb2FtOltEcvIbVEHJ+VAVg8VHj82CXHiTMIR7rkL7AaAlZqP3CjEgJKl0H1s0c2pO15TQaMOlWTqKRdQxs1gJ7SeqLFFwHKh+V3OlSW6GUNbLFU5IsHfqJvUS03Aac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720131215; c=relaxed/simple;
	bh=kDaqPnBFIvUQeR2+H9HpTQwmPMC9L+ing0oAJYJfI4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skMsA3kV/jznUf0WvgHLqaXLTlF/ZTaCB7fDcr63KyDrRuJAKJOj4C9JlJ+WjLQj4QEUpVooQ7HURY5fpvbFY5aXpAtU0jfH08RFEfAQG3Y9bxvuqzeFhlLDaoaP6zflztr5coQZ6VyI+D/W5lKF21DkdpzgORVlgpPpdzv2t14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=UwrLnUIL; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c96170d23eso744838a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 15:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1720131213; x=1720736013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nt1pnpCk1KfQaN+YgEj1HaWaKfx+85yAEH2SJic0Se0=;
        b=UwrLnUILWTManJmFRIKAt5HaKxruH9Zo4trDinb5SwCuo6LoprkghwqeMhb/n7wKxz
         IyoPBeM2i3+oF74fSeItorHYKxpXgLNRrGH3u0UwJQfXKWB7gd1LSQ41qcOZQsm1ARng
         bdu0dxgQK2NMvmDXvyV+rQEhFvc4WQktO/Yqlr8xpG8FeCdT12DJS4mJaiqkMC+XElR4
         xizdzXf3zFisMQwRKFsqDzaekcCopvbHXjav1+UU9fNWEeznqHenMgUjsNj4nxwkH0tW
         FdUmNTAoIQakMBGVTjryI++Xw/P5J3wsCTduwA30tWom+D44bMWyN5oEmTiaw0pdWIee
         5PQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720131213; x=1720736013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nt1pnpCk1KfQaN+YgEj1HaWaKfx+85yAEH2SJic0Se0=;
        b=Y9Znosar82xPqwPfrUkGjD1aNYB1LLnUu6hevu6OuPIKg2io5TdyWwKCa7L7pIsJbL
         RhhqEd0v+7EkDcqpvdk1EsGbfl6PY4S+zYenMiVODa7b/Fq5A7hrpF3PJBCvUFSQl37J
         8ypigHop5ff6BFNBHvfUOzuKDJ3mUMpkjdaXgmYVEc0Er/wd9wKNdau5lvmcdW3UrEAd
         hV3F7VwkVg+QcQGafOIm3OCju+pDT2jGMLAk0WN0ZmiVoLAALBp6m0BH1j5rY/i71VT6
         qKkTGhoRr9EmWWJOeGFeLHtopiE5ezamBwRLmHOU155rqpOkCjyYcZOWfRNI44XXjCo9
         Cpig==
X-Forwarded-Encrypted: i=1; AJvYcCWT/a5w14Jna/pGSG59dUUDCKXvisx/jgpaiTvkpfNeIhdSo8yvS0ZiKyr2R7IzUer/+o+/qKADufoPQP3sxEEl8ZK/DWoF4jG2oYaB
X-Gm-Message-State: AOJu0YyEvFxqv/1cmb3OgdUK6ZrPunvXsX7FLga8hBc0dXhY8CBixW5d
	aCDxqfQDkFkhhsTV8/U6za/wdihZyXUvX3GvKE6f1sdqJTA/0IA9QH0NeKjfPSM=
X-Google-Smtp-Source: AGHT+IGqzAnayF06dHh/ly76CeJIvdvLTHzY9adBh22u0N8/+/Xrrmia4PfBDw7CTW+ANd7wUSoKiw==
X-Received: by 2002:a17:90a:348b:b0:2c8:a8f:c97 with SMTP id 98e67ed59e1d1-2c99c80b2aemr2034402a91.37.1720131213291;
        Thu, 04 Jul 2024 15:13:33 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a95624dsm2040861a91.20.2024.07.04.15.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 15:13:32 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sPUhm-004JHs-1V;
	Fri, 05 Jul 2024 08:13:30 +1000
Date: Fri, 5 Jul 2024 08:13:30 +1000
From: Dave Chinner <david@fromorbit.com>
To: Hannes Reinecke <hare@suse.de>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	willy@infradead.org, chandan.babu@oracle.com, djwong@kernel.org,
	brauner@kernel.org, akpm@linux-foundation.org,
	yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v9 06/10] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <ZoceivBuLIcylaxk@dread.disaster.area>
References: <20240704112320.82104-1-kernel@pankajraghav.com>
 <20240704112320.82104-7-kernel@pankajraghav.com>
 <2c09ebbd-1704-46e3-a453-b4cd07940325@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c09ebbd-1704-46e3-a453-b4cd07940325@suse.de>

On Thu, Jul 04, 2024 at 05:37:32PM +0200, Hannes Reinecke wrote:
> On 7/4/24 13:23, Pankaj Raghav (Samsung) wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > iomap_dio_zero() will pad a fs block with zeroes if the direct IO size
> > < fs block size. iomap_dio_zero() has an implicit assumption that fs block
> > size < page_size. This is true for most filesystems at the moment.
> > 
> > If the block size > page size, this will send the contents of the page
> > next to zero page(as len > PAGE_SIZE) to the underlying block device,
> > causing FS corruption.
> > 
> > iomap is a generic infrastructure and it should not make any assumptions
> > about the fs block size and the page size of the system.
> > 
> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > ---
> >   fs/iomap/buffered-io.c |  4 ++--
> >   fs/iomap/direct-io.c   | 45 ++++++++++++++++++++++++++++++++++++------
> >   2 files changed, 41 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index f420c53d86acc..d745f718bcde8 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -2007,10 +2007,10 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
> >   }
> >   EXPORT_SYMBOL_GPL(iomap_writepages);
> > -static int __init iomap_init(void)
> > +static int __init iomap_buffered_init(void)
> >   {
> >   	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
> >   			   offsetof(struct iomap_ioend, io_bio),
> >   			   BIOSET_NEED_BVECS);
> >   }
> > -fs_initcall(iomap_init);
> > +fs_initcall(iomap_buffered_init);
> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index f3b43d223a46e..c02b266bba525 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -11,6 +11,7 @@
> >   #include <linux/iomap.h>
> >   #include <linux/backing-dev.h>
> >   #include <linux/uio.h>
> > +#include <linux/set_memory.h>
> >   #include <linux/task_io_accounting_ops.h>
> >   #include "trace.h"
> > @@ -27,6 +28,13 @@
> >   #define IOMAP_DIO_WRITE		(1U << 30)
> >   #define IOMAP_DIO_DIRTY		(1U << 31)
> > +/*
> > + * Used for sub block zeroing in iomap_dio_zero()
> > + */
> > +#define IOMAP_ZERO_PAGE_SIZE (SZ_64K)
> > +#define IOMAP_ZERO_PAGE_ORDER (get_order(IOMAP_ZERO_PAGE_SIZE))
> > +static struct page *zero_page;
> > +
> 
> There are other users of ZERO_PAGE, most notably in fs/direct-io.c and
> block/blk-lib.c. Any chance to make this available to them?

Please, no.

We need to stop feature creeping this patchset and bring it to a
close. If changing code entirely unrelated to this patchset is
desired, please do it as a separate independent set of patches.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

