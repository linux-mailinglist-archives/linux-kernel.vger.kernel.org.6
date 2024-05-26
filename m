Return-Path: <linux-kernel+bounces-189569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A81D88CF215
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 01:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E551281BAA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 23:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB4312A146;
	Sat, 25 May 2024 23:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="TYAcnYSZ"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B03129A9A
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 23:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716678573; cv=none; b=Bp3VvrWZWtI9VR1zs4GuPgNm2jiwvwB5oCpTVo+UoHkuf02qmcjGTdSE1feYB/NX2+9cuEHWJo2ksAhjf7AookBxobE0mD+90eqNknf1xlKRtPgD8mHIU+md2R6YI+0jt35k1p3ST4h/uj6hO4S4Z8HP3SzP+Sgwnm6vYV6w/Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716678573; c=relaxed/simple;
	bh=faN9rNSdcMcbjtK47u0oId+ibnqpzDbiA+nKCknSZ+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1xUchBMAAdL8Oy5jOtANAGzcAo8rliQulPk+iGsNZI+IBof+YCnhNSEFzDmxNH4UGhmQa3b7poP6TwbDmiBXcRc5IqGWSnHb1uRvAjpyULRVcS/eb/gQgJ8u9XtYyT/auJ/RT4c99lzGAyy96Ap++xa/7r7pVYAn3DpQTYJ8/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=TYAcnYSZ; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-68197de7400so1731412a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 16:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1716678571; x=1717283371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Crh6RjgT+TcJb1jq4rCjRtTqJLBvMRyCXUhpelsfOKA=;
        b=TYAcnYSZr305sH9XLnMvStIEDlJaWfuAxeIKJ8RHPQ2FdZChlHVw3WOedEm+oJTNqI
         stTuZ4fQcw6UxiGfRHR90Bp74bwzaixt2GDlsFinFqwsc869LKAliJMxIv9qTmLKte90
         sq9F8bi8bpvUJzN0IUjLPRE9fJjkfjv5gfgmowNLTuqBzw1qcIAMQNDSly1A1w3VVbGl
         8+P7OVtW0gK8XJZGCmv5e1rowLpX51EXhR5iPw/zYbDLRoTZIL2nRgW5TTKIhnQ6151n
         cTidOa1KmAj+ZAT11fKYV1i4bpCfpO+pzVNGRkUDuJnBIDt7bLWMHaeIDv9F1c8BEZf0
         OwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716678571; x=1717283371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Crh6RjgT+TcJb1jq4rCjRtTqJLBvMRyCXUhpelsfOKA=;
        b=QQgBTp8W21SsZyRGaE9soaXh6lrb0A+ZZjtiJa5urCQahvsaEsReXh0mPlJu0ULx3g
         MYlW0c8w7HO+y+sGQy0+JiaJ6NlyKQfwfW9bXVMPewC7qeUDk6Aksx6yqOkcrBVNfyCL
         9H1tyUHrNDw/eY4jXvIar4RrR62CDgGt7zqIuXKPLPr0udeWWlAfXps/Rg3DVhlWWaCS
         mTSalBGOx6vnt7M/XGWPqXgchrDM8N3VDOIOUqLYEbMxvwXbt77Fi4pk5bJfEH1UF9EH
         uKg4Q9y2AX6wrX+0Jo4MyokVn04e68enhCdZKU2CXjbQYgykmnz3Q0wpq4Sj0HwYqDTP
         bCug==
X-Forwarded-Encrypted: i=1; AJvYcCUHksD+digREVmv2fj8HMCAu6lp15uRj7AJ/Knil5Q6N3o9XzJnEb01qcd2WtnVLEsKroHmh+3anR3adu/jbgwdqK7hBzVXaVKskrvZ
X-Gm-Message-State: AOJu0Yxqg5vTp3e2Ueb/WVen106pI4xbqHQ2/KLcGw0goEcKsYC8qWgn
	7AZ1gXGa+1D5PHGGviBYgz27DUF+FzPyYVxoe8NfMB/drViR/qS2UytBxG6HpJg=
X-Google-Smtp-Source: AGHT+IGYciyTBhNiI5PZlCjyMDogB+ANQNNWDCUuYjIsBj+L8eTBYhs5xE8S13XEF72yE6eBkoNGvg==
X-Received: by 2002:a17:902:d50b:b0:1f4:768b:445e with SMTP id d9443c01a7336-1f4768b4768mr21943575ad.24.1716678570642;
        Sat, 25 May 2024 16:09:30 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9afba1sm34658165ad.246.2024.05.25.16.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 16:09:30 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sB0Vz-00AUvI-1V;
	Sun, 26 May 2024 09:09:27 +1000
Date: Sun, 26 May 2024 09:09:27 +1000
From: Dave Chinner <david@fromorbit.com>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, bvanassche@acm.org, hare@suse.de,
	damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
	joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 06/12] fs, block: copy_file_range for def_blk_ops for
 direct block device
Message-ID: <ZlJvp47RSFKkbwRJ@dread.disaster.area>
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520102929epcas5p2f4456f6fa0005d90769615eb2c2bf273@epcas5p2.samsung.com>
 <20240520102033.9361-7-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520102033.9361-7-nj.shetty@samsung.com>

On Mon, May 20, 2024 at 03:50:19PM +0530, Nitesh Shetty wrote:
> For direct block device opened with O_DIRECT, use blkdev_copy_offload to
> issue device copy offload, or use splice_copy_file_range in case
> device copy offload capability is absent or the device files are not open
> with O_DIRECT.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>  block/fops.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/block/fops.c b/block/fops.c
> index 376265935714..5a4bba4f43aa 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -17,6 +17,7 @@
>  #include <linux/fs.h>
>  #include <linux/iomap.h>
>  #include <linux/module.h>
> +#include <linux/splice.h>
>  #include "blk.h"
>  
>  static inline struct inode *bdev_file_inode(struct file *file)
> @@ -754,6 +755,30 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	return ret;
>  }
>  
> +static ssize_t blkdev_copy_file_range(struct file *file_in, loff_t pos_in,
> +				      struct file *file_out, loff_t pos_out,
> +				      size_t len, unsigned int flags)
> +{
> +	struct block_device *in_bdev = I_BDEV(bdev_file_inode(file_in));
> +	struct block_device *out_bdev = I_BDEV(bdev_file_inode(file_out));
> +	ssize_t copied = 0;
> +
> +	if ((in_bdev == out_bdev) && bdev_max_copy_sectors(in_bdev) &&
> +	    (file_in->f_iocb_flags & IOCB_DIRECT) &&
> +	    (file_out->f_iocb_flags & IOCB_DIRECT)) {
> +		copied = blkdev_copy_offload(in_bdev, pos_in, pos_out, len,
> +					     NULL, NULL, GFP_KERNEL);
> +		if (copied < 0)
> +			copied = 0;
> +	} else {
> +		copied = splice_copy_file_range(file_in, pos_in + copied,
> +						 file_out, pos_out + copied,
> +						 len - copied);
> +	}

This should not fall back to a page cache copy.

We keep being told by application developers that if the fast
hardware/filesystem offload fails, then an error should be returned
so the application can determine what the fallback operation should
be.

It may well be that the application falls back to "copy through the
page cache", but that is an application policy choice, not a
something the kernel offload driver should be making mandatory.

Userspace has to handle copy offload failure anyway, so they a
fallback path regardless of whether copy_file_range() works on block
devices or not...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

