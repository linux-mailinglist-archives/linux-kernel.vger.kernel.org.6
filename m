Return-Path: <linux-kernel+bounces-418256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0A69D5F6B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC802821AF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F891DE4D1;
	Fri, 22 Nov 2024 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C13fXD0L"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0812555C29
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732280359; cv=none; b=TbK03B7zZhpEKpg12DdSqix8b3xSZOvaepV5Df5ZP+3Rtfs38g1z4k5wP7GDoFSbElEfQLykJz2rWQzeVA3QAn0DLGRGKKG9YPfe81fgVfivgqoJPnN43TiOaTPYDDVOUCn2yK6qQGBJqtVklSux+7JdwuQ+XqJvIqSqAnTo33o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732280359; c=relaxed/simple;
	bh=5LF0sWIal2U0+dbFhFwEhNmDs0IUJECe6wXw1MNkzQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q4xW5RxNLYS1RxTfUSQJUXd0y+pxFOJOd8rpyS+kG18zQFSIPYSuXBkFBBp4MKiqsZwsu9bFIfHQKKFerOqDk/bEjXZQWj3n3pwhHqUxzb8uUqHYR14DM3USlPhzmCUVdObTe38tIzV3Sdbq1odL6JZty27Ka3F1RY66BvdSV/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C13fXD0L; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so18234345e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 04:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732280355; x=1732885155; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hxzSzzFQ3VEMlKbDZ1hYeOGML4eziB5ALghzzU7maks=;
        b=C13fXD0LbHajnpR2AdcU3s9a9PV1hSCe4JqpgHEqESg6aBf6YdJpGD1lSgwBUqLXqj
         I6FsyF5/pseuIww7H8CLRcvCLZXjHbO7LUP6iCVvOOZ2tDDZUwYOkoQgFVBi4p0kpMxP
         423MRHu2GykmO+YdSJi6xqossuX9KMnQOgKqFJCaY4ew/X9Mpp974b9PeX62D6rEWj+F
         5t5jtyk6tShweqbNasvi6mVuYdFuoKbuuEbHkQv7M02AyGUXqyWfTCuXexhgMirjyeCs
         N3IQBtBrYKIg98jgwryaQkYDraPptPu1eldN2aka+T1lPzHjr9LyoBIK+o14iJAYk41G
         n+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732280355; x=1732885155;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hxzSzzFQ3VEMlKbDZ1hYeOGML4eziB5ALghzzU7maks=;
        b=G1DgVMu0vt6n0kyfWPLwdlH8fMwTlDHL7CN8GzxG+QD1RdgSNwf/ZUGluEp8iUg37U
         CKwwjbWNiM38XyY0ePn1cTjJh3e7K9U+no6ig4sttCe0XY2QIP36rbfQJT9QbDqe0wpK
         gZr3TiwELjqpjwo/66RcVQgO0h44GFsUOXTd0zrzXLm9ATGn6w1ZZ/UVWGTPuH2IKAsE
         U6+6SCjPidZoTBgkQIosUEXBY7lbczpjJlEWrZFSeF5wc6+gXRK+No9wWu4BMT2+V3oy
         rez7CBoKeKi98rAmOcGXbkVvYmgthIM5PMP86HcSogaRvY5MVAVi3GjIK/mUTA+G7kEA
         SoTA==
X-Forwarded-Encrypted: i=1; AJvYcCUnm9wYlVB2e2xCGHIYjmfMptKVDVZ1/qBZ7z6IErpracMqmAOBAgyeWG2QovtwEnXd4/Gc8cCpF8QT6NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoGmHPvv0b3TgLd7PP+gWy9cRdfvdbgO5dak9/rW/zRDZbz+pd
	tYPxAYbLuIc3Tnak7l7F1cn42qTyHgQfJYF+RPce1kB2qtkegL+vqKHvymItXvI=
X-Gm-Gg: ASbGncsYzMPxU9GUNQdBFaO8zT+1Gi0ksqtbc6G7gtuNDAEftDjqNcszz4j7vrBKjWr
	Ue0YMIwjs8MRCyI66uJocukFKKbAzC39Wfy0vkhJEGZLnvuEKuD2EWEgyORhwJZ7vtwXSjsJ/Ee
	ifszpGPxIqe12xejFsErtJPyHWQAU4x47Zz7NYSCUEHPe2qZnMXpzclYoBvqDRfGUAiR22Rb6NC
	1WIN8wQCyYMRSpyJTyL1zfga6b7OTjGiTnY5f1V/cN3yJ20BBb8Gzs=
X-Google-Smtp-Source: AGHT+IHgErHJJknZMEh23hRcjVwJIhKX7vQIjlso3cuza9wI0qkpqYqjlJKkMCE8wQ9ApjBOoThzTQ==
X-Received: by 2002:a5d:64ce:0:b0:382:4f77:5bff with SMTP id ffacd0b85a97d-38260b83598mr2161069f8f.30.1732280355229;
        Fri, 22 Nov 2024 04:59:15 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433cde98988sm26440415e9.42.2024.11.22.04.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 04:59:14 -0800 (PST)
Date: Fri, 22 Nov 2024 15:59:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, "Darrick J. Wong" <djwong@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: fs/xfs/scrub/rtsummary.c:288 xchk_rtsum_compare() warn: missing
 error code? 'error'
Message-ID: <c9a86317-aef1-407e-809b-466fef57d123@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   28eb75e178d389d325f1666e422bc13bbbb9804c
commit: 04f0c3269b41f28c041980a30514850453ded251 xfs: check rt summary file geometry more thoroughly
config: x86_64-randconfig-r071-20241122 (https://download.01.org/0day-ci/archive/20241122/202411222034.c3kvpXzY-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202411222034.c3kvpXzY-lkp@intel.com/

smatch warnings:
fs/xfs/scrub/rtsummary.c:288 xchk_rtsum_compare() warn: missing error code? 'error'

vim +/error +288 fs/xfs/scrub/rtsummary.c

526aab5f5790e2 Darrick J. Wong 2023-08-10  221  STATIC int
526aab5f5790e2 Darrick J. Wong 2023-08-10  222  xchk_rtsum_compare(
526aab5f5790e2 Darrick J. Wong 2023-08-10  223  	struct xfs_scrub	*sc)
526aab5f5790e2 Darrick J. Wong 2023-08-10  224  {
526aab5f5790e2 Darrick J. Wong 2023-08-10  225  	struct xfs_bmbt_irec	map;
04f0c3269b41f2 Darrick J. Wong 2023-12-15  226  	struct xfs_iext_cursor	icur;
526aab5f5790e2 Darrick J. Wong 2023-08-10  227  
04f0c3269b41f2 Darrick J. Wong 2023-12-15  228  	struct xfs_mount	*mp = sc->mp;
04f0c3269b41f2 Darrick J. Wong 2023-12-15  229  	struct xfs_inode	*ip = sc->ip;
04f0c3269b41f2 Darrick J. Wong 2023-12-15  230  	struct xchk_rtsummary	*rts = sc->buf;
04f0c3269b41f2 Darrick J. Wong 2023-12-15  231  	xfs_fileoff_t		off = 0;
04f0c3269b41f2 Darrick J. Wong 2023-12-15  232  	xfs_fileoff_t		endoff;
04f0c3269b41f2 Darrick J. Wong 2023-12-15  233  	xfs_rtsumoff_t		sumoff = 0;
526aab5f5790e2 Darrick J. Wong 2023-08-10  234  	int			error = 0;
526aab5f5790e2 Darrick J. Wong 2023-08-10  235  
04f0c3269b41f2 Darrick J. Wong 2023-12-15  236  	rts->args.mp = sc->mp;
04f0c3269b41f2 Darrick J. Wong 2023-12-15  237  	rts->args.tp = sc->tp;
04f0c3269b41f2 Darrick J. Wong 2023-12-15  238  
04f0c3269b41f2 Darrick J. Wong 2023-12-15  239  	/* Mappings may not cross or lie beyond EOF. */
04f0c3269b41f2 Darrick J. Wong 2023-12-15  240  	endoff = XFS_B_TO_FSB(mp, ip->i_disk_size);
04f0c3269b41f2 Darrick J. Wong 2023-12-15  241  	if (xfs_iext_lookup_extent(ip, &ip->i_df, endoff, &icur, &map)) {
04f0c3269b41f2 Darrick J. Wong 2023-12-15  242  		xchk_fblock_set_corrupt(sc, XFS_DATA_FORK, endoff);
04f0c3269b41f2 Darrick J. Wong 2023-12-15  243  		return 0;
04f0c3269b41f2 Darrick J. Wong 2023-12-15  244  	}
04f0c3269b41f2 Darrick J. Wong 2023-12-15  245  
04f0c3269b41f2 Darrick J. Wong 2023-12-15  246  	while (off < endoff) {
04f0c3269b41f2 Darrick J. Wong 2023-12-15  247  		int		nmap = 1;
04f0c3269b41f2 Darrick J. Wong 2023-12-15  248  
526aab5f5790e2 Darrick J. Wong 2023-08-10  249  		if (xchk_should_terminate(sc, &error))
526aab5f5790e2 Darrick J. Wong 2023-08-10  250  			return error;
526aab5f5790e2 Darrick J. Wong 2023-08-10  251  		if (sc->sm->sm_flags & XFS_SCRUB_OFLAG_CORRUPT)
526aab5f5790e2 Darrick J. Wong 2023-08-10  252  			return 0;
526aab5f5790e2 Darrick J. Wong 2023-08-10  253  
526aab5f5790e2 Darrick J. Wong 2023-08-10  254  		/* Make sure we have a written extent. */
04f0c3269b41f2 Darrick J. Wong 2023-12-15  255  		error = xfs_bmapi_read(ip, off, endoff - off, &map, &nmap,
526aab5f5790e2 Darrick J. Wong 2023-08-10  256  				XFS_DATA_FORK);
526aab5f5790e2 Darrick J. Wong 2023-08-10  257  		if (!xchk_fblock_process_error(sc, XFS_DATA_FORK, off, &error))
526aab5f5790e2 Darrick J. Wong 2023-08-10  258  			return error;
526aab5f5790e2 Darrick J. Wong 2023-08-10  259  
526aab5f5790e2 Darrick J. Wong 2023-08-10  260  		if (nmap != 1 || !xfs_bmap_is_written_extent(&map)) {
526aab5f5790e2 Darrick J. Wong 2023-08-10  261  			xchk_fblock_set_corrupt(sc, XFS_DATA_FORK, off);
526aab5f5790e2 Darrick J. Wong 2023-08-10  262  			return 0;
526aab5f5790e2 Darrick J. Wong 2023-08-10  263  		}
526aab5f5790e2 Darrick J. Wong 2023-08-10  264  
04f0c3269b41f2 Darrick J. Wong 2023-12-15  265  		off += map.br_blockcount;
04f0c3269b41f2 Darrick J. Wong 2023-12-15  266  	}
04f0c3269b41f2 Darrick J. Wong 2023-12-15  267  
04f0c3269b41f2 Darrick J. Wong 2023-12-15  268  	for (off = 0; off < endoff; off++) {
04f0c3269b41f2 Darrick J. Wong 2023-12-15  269  		union xfs_suminfo_raw	*ondisk_info;
04f0c3269b41f2 Darrick J. Wong 2023-12-15  270  
526aab5f5790e2 Darrick J. Wong 2023-08-10  271  		/* Read a block's worth of ondisk rtsummary file. */
04f0c3269b41f2 Darrick J. Wong 2023-12-15  272  		error = xfs_rtsummary_read_buf(&rts->args, off);
526aab5f5790e2 Darrick J. Wong 2023-08-10  273  		if (!xchk_fblock_process_error(sc, XFS_DATA_FORK, off, &error))
526aab5f5790e2 Darrick J. Wong 2023-08-10  274  			return error;
526aab5f5790e2 Darrick J. Wong 2023-08-10  275  
526aab5f5790e2 Darrick J. Wong 2023-08-10  276  		/* Read a block's worth of computed rtsummary file. */
04f0c3269b41f2 Darrick J. Wong 2023-12-15  277  		error = xfsum_copyout(sc, sumoff, rts->words, mp->m_blockwsize);
526aab5f5790e2 Darrick J. Wong 2023-08-10  278  		if (error) {
04f0c3269b41f2 Darrick J. Wong 2023-12-15  279  			xfs_rtbuf_cache_relse(&rts->args);
526aab5f5790e2 Darrick J. Wong 2023-08-10  280  			return error;
526aab5f5790e2 Darrick J. Wong 2023-08-10  281  		}
526aab5f5790e2 Darrick J. Wong 2023-08-10  282  
04f0c3269b41f2 Darrick J. Wong 2023-12-15  283  		ondisk_info = xfs_rsumblock_infoptr(&rts->args, 0);
04f0c3269b41f2 Darrick J. Wong 2023-12-15  284  		if (memcmp(ondisk_info, rts->words,
04f0c3269b41f2 Darrick J. Wong 2023-12-15  285  					mp->m_blockwsize << XFS_WORDLOG) != 0) {
526aab5f5790e2 Darrick J. Wong 2023-08-10  286  			xchk_fblock_set_corrupt(sc, XFS_DATA_FORK, off);
04f0c3269b41f2 Darrick J. Wong 2023-12-15  287  			xfs_rtbuf_cache_relse(&rts->args);
04f0c3269b41f2 Darrick J. Wong 2023-12-15 @288  			return error;

error is zero here.

04f0c3269b41f2 Darrick J. Wong 2023-12-15  289  		}
526aab5f5790e2 Darrick J. Wong 2023-08-10  290  
04f0c3269b41f2 Darrick J. Wong 2023-12-15  291  		xfs_rtbuf_cache_relse(&rts->args);
526aab5f5790e2 Darrick J. Wong 2023-08-10  292  		sumoff += mp->m_blockwsize;
526aab5f5790e2 Darrick J. Wong 2023-08-10  293  	}
526aab5f5790e2 Darrick J. Wong 2023-08-10  294  
526aab5f5790e2 Darrick J. Wong 2023-08-10  295  	return 0;
526aab5f5790e2 Darrick J. Wong 2023-08-10  296  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


