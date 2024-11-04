Return-Path: <linux-kernel+bounces-394178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD079BAB80
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 04:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBEC12829C7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320DE17DFEF;
	Mon,  4 Nov 2024 03:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="YgLkiNoX"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F55CB665
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 03:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730691134; cv=none; b=Q3xffB1LIte/rx5as/wtJkhfCYlteQIX3O+a9893pQgoA0diUk5H+3HU471thSdxxrZFAmzFzI0KNZ+5TTCVAB6th1RQUa+dhjHgDgXUYLTtk/c8nMl9kfaFUeITe/xPv60ycN8My719GPUlSyHGifKA32qjw7Tnl6TkSRIo0nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730691134; c=relaxed/simple;
	bh=88CEasn5+LMNyLKjBTf7QNNd350MAsE7hWWXr67xEAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQamXj8h3WibhRVsDPuRMbWrnqh2uVDDyyoXjtqDbl9uy03uczwTHl0z09hfRVnPCWVa/CMSVBfBYonPBwAGti7FgH8zJIbNbm7rvSfXjok4rBRzJLDVEDdFyUkkFa9VOno9jbr1SuVJTf9TBYY65mDAGye5K4bjuXEL5As3/Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=YgLkiNoX; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e4e481692so3605147b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 19:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1730691132; x=1731295932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ze30dbasUMsyhSVV1c/zg/A1qIjoc9vvnCHhmEzapi4=;
        b=YgLkiNoXH47XQiLsrdcQ4BGYPh34bryN99vHykKUIH6/kmQw1tEienwWSggB7iyjbk
         7belBibPelB615NceziflMG5cdGbG/wr1ABJ97dA1vobMm9t7Ad81lKZDrVLLE2C6xe1
         s2EvuCbu7v5YkcrLSqTXXTJGksQwbt0YcPOR8xOgBC0aL85m8OwXaNJBtkTrKLJQ+diN
         BhrV/AloizM61ieOOSJXAVTIke9Gmk0J5sHDtQlLNLPvZxl+FMT37ohg7goE47GFDLIz
         Sr22YtTy5i8BIRsjmBrgx+CPiVtpyTtYQjXw3ZLVeb3kYHMzUkZnKgVNTs1c1KyOdZEi
         0QUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730691132; x=1731295932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ze30dbasUMsyhSVV1c/zg/A1qIjoc9vvnCHhmEzapi4=;
        b=gw2uhEfkbnwxFxqPD5OtxdruQUAikIUjTgEw/IQCh03CNJqSC/sbOa+e760kwsuUHg
         WC2t8ja+onzwmeX0Kpp492sWdtA7buJqE71oUTf12Xfi5ao05CKeaACRu6/1vqiId734
         xCOyroL0LM1vacVO0U6+o7w0LKj7oc+D5olIgh0nd/UVdmGkOXVhBQvNAspgQdfo+z6X
         3z0MacScrFiNm0H1RwWC1CvUbbJiAB5Nxf/UqbpzQdtoCqXCd+UKY3QGjGr2cZgOkDKu
         /9iGYysDVXWo7fNY+u8/g3FTw80U1iShjNwDxUIbQd88dcnhzuk/FK3JGs2vnHytEB+e
         TCEA==
X-Forwarded-Encrypted: i=1; AJvYcCXL91Z7qNsEHW3rDsdunFbewfVx49/nxwDBIo/jFvlyI+tP1qyd3/YfdB5fo1hxrPQCB/7qCr4ZkUYtsaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzocmpJNgW7iUgL1q1iob6EhU8OCPNnGyBVF8rU2q4hgzDSg6mq
	wklBitgEstO56MpZgjEjyVXqPP+Glc3rs/LGWTjuBozkzRgrdTC83w+BdI1WyHE=
X-Google-Smtp-Source: AGHT+IEdgJLFZ+5AwPGplcCEayS3QGz+5KYf12lMpd7R3Pc8PU/KtFSxeNrNRPygzmWVrOq+BF/jfA==
X-Received: by 2002:a05:6a21:3514:b0:1d7:7ea:2f2d with SMTP id adf61e73a8af0-1dba5218fe5mr17384161637.6.1730691131732;
        Sun, 03 Nov 2024 19:32:11 -0800 (PST)
Received: from dread.disaster.area (pa49-186-86-168.pa.vic.optusnet.com.au. [49.186.86.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1ed42fsm6423963b3a.78.2024.11.03.19.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 19:32:11 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1t7np2-009sYv-0b;
	Mon, 04 Nov 2024 14:32:08 +1100
Date: Mon, 4 Nov 2024 14:32:08 +1100
From: Dave Chinner <david@fromorbit.com>
To: zhangshida <starzhangzsd@gmail.com>
Cc: djwong@kernel.org, dchinner@redhat.com, leo.lilong@huawei.com,
	wozizhi@huawei.com, osandov@fb.com, xiang@kernel.org,
	zhangjiachen.jaycee@bytedance.com, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
Subject: Re: [PATCH 0/5] *** Introduce new space allocation algorithm ***
Message-ID: <ZyhAOEkrjZzOQ4kJ@dread.disaster.area>
References: <20241104014439.3786609-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104014439.3786609-1-zhangshida@kylinos.cn>

On Mon, Nov 04, 2024 at 09:44:34AM +0800, zhangshida wrote:
> From: Shida Zhang <zhangshida@kylinos.cn>
> 
> Hi all,
> 
> Recently, we've been encounter xfs problems from our two
> major users continuously.
> They are all manifested as the same phonomenon: a xfs 
> filesystem can't touch new file when there are nearly
> half of the available space even with sparse inode enabled.

What application is causing this, and does using extent size hints
make the problem go away?

Also, xfs_info and xfs_spaceman free space histograms would be
useful information.

> It turns out that the filesystem is too fragmented to have
> enough continuous free space to create a new file.

> Life still has to goes on. 
> But from our users' perspective, worse than the situation
> that xfs is hard to use is that xfs is non-able to use, 
> since even one single file can't be created now. 
> 
> So we try to introduce a new space allocation algorithm to
> solve this.
> 
> To achieve that, we try to propose a new concept:
>    Allocation Fields, where its name is borrowed from the 
> mathmatical concepts(Groups,Rings,Fields), will be 

I have no idea what this means. We don't have rings or fields,
and an allocation group is simply a linear address space range.
Please explain this concept (pointers to definitions and algorithms
appreciated!)


> abbrivated as AF in the rest of the article. 
> 
> what is a AF?
> An one-pic-to-say-it-all version of explaination:
> 
> |<--------+ af 0 +-------->|<--+ af 1 +-->| af 2|
> |------------------------------------------------+
> | ag 0 | ag 1 | ag 2 | ag 3| ag 4 | ag 5 | ag 6 |
> +------------------------------------------------+
> 
> A text-based definition of AF:
> 1.An AF is a incore-only concept comparing with the on-disk
>   AG concept.
> 2.An AF is consisted of a continuous series of AGs. 
> 3.Lower AFs will NEVER go to higher AFs for allocation if 
>   it can complete it in the current AF.
> 
> Rule 3 can serve as a barrier between the AF to slow down
> the over-speed extending of fragmented pieces. 

To a point, yes. But it's not really a reliable solution, because
directories are rotored across all AGs. Hence if the workload is
running across multiple AGs, then all of the AFs can be being
fragmented at the same time.

Given that I don't know how an application controls what AF it's
files are located in, I can't really say much more than that.

> With these patches applied, the code logic will be exactly
> the same as the original code logic, unless you run with the
> extra mount opiton. For example:
>    mount -o af1=1 $dev $mnt
> 
> That will change the default AF layout:
> 
> |<--------+ af 0 +--------->| 
> |----------------------------
> | ag 0 | ag 1 | ag 2 | ag 3 |
> +----------------------------
> 
> to :
> 
> |<-----+ af 0 +----->|<af 1>| 
> |----------------------------
> | ag 0 | ag 1 | ag 2 | ag 3 |
> +----------------------------
> 
> So the 'af1=1' here means the start agno is one ag away from
> the m_sb.agcount.

Yup, so kinda what we did back in 2006 in a proprietary SGI NAS
product with "concat groups" to create aggregations of allocation
groups that all sat on the same physical RAID5 luns in a linear
concat volume. They were fixed size, because the (dozens of) luns
were all the same size. This construct was heavily tailored to
maximising the performance provided by the underlying storage
hardware architecture, so wasn't really a general policy solution.

To make it work, we also had to change how various other allocation
distribution algorithms worked (e.g. directory rotoring) so that
the load was distributed more evenly across the physical hardware
backing the filesystem address space.

I don't see anything like that in this patch set - there's no actual
control mechanism to select what AF an inode lands in.  how does an
applicaiton or user actually use this reliably to prevent all the
AFs being fragmented by the workload that is running?

> We did some tests verify it. You can verify it yourself
> by running the following the command:
> 
> 1. Create an 1g sized img file and formated it as xfs:
>   dd if=/dev/zero of=test.img bs=1M count=1024
>   mkfs.xfs -f test.img
>   sync
> 2. Make a mount directory:
>   mkdir mnt
> 3. Run the auto_frag.sh script, which will call another scripts
>   frag.sh. These scripts will be attached in the mail. 
>   To enable the AF, run:
>     ./auto_frag.sh 1
>   To disable the AF, run:
>     ./auto_frag.sh 0
> 
> Please feel free to communicate with us if you have any thoughts
> about these problems.

We already have inode/metadata preferred allocation groups that
are avoided for data allocation if at all possible. This is how we
keep space free below 1TB for inodes when the inode32 allocator has
been selected. See xfs_perag_prefers_metadata().

Perhaps being able to control this preference from userspace (e.g.
via xfs_spaceman commands through ioctls and/or sysfs knobs) would
acheive the same results with a minimum of code and/or policy
changes. i.e. if AG0 is preferred for metadata rather than data,
we won't allocate data in it until all higher AGs are largely full.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

