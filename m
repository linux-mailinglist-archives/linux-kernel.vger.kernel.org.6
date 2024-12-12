Return-Path: <linux-kernel+bounces-443431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD939EF0E2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A38A1750AD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA01238E18;
	Thu, 12 Dec 2024 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kx3uPknH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6427226194
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019882; cv=none; b=M/t5BI8VqB7gCWf9NgyuH9sx/WVDNvqEWyEyL/rbpZ0FAzavlyb1nKgwKMD9/AazEwHOGdKDh3jJnSNEUI0A7l546fwd5ULe4qyWVRWOAIcmIwuVrIauK3sIsnSR6l9TQJIoCQwyO88fZ+ZnjAdEUGqUEAHrNMWlA+XC0uSQ6CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019882; c=relaxed/simple;
	bh=dZ4VZAM7FcWZqocKTmrpQrhxyIrk8tVMApXVzVdvLhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cU8mHNOCYrVA1d/c2YR0nWM4JyIPyR/isp8Jm2lrHSUbqeA54NTVQnRpGZS3GgIyfeYWRvt6Xp3c/WH5M4i8VLkALJ5Ji6IOXbnLzi00/LgSMAGPkbWvwlbV0O5kerEUqaPzV0UM/LgpeNJ7NEx8W/oIkpp94CawhWpWcN5JYlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kx3uPknH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E30BC4CEDF;
	Thu, 12 Dec 2024 16:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734019882;
	bh=dZ4VZAM7FcWZqocKTmrpQrhxyIrk8tVMApXVzVdvLhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kx3uPknHgsY5YLmOlqZ+PYIfqD4j8GA0jZpQxNfBxH+7fhXIHv+aaqrvTMYP1V+/2
	 FtOt1kkjWv6xZOuJYtL1ovJfo2dpPpgJP/zfDvvq2UuTSt/V+G8ZJ3pSNQ8LAaADlG
	 KDB/nh/gI+5eyUb9NHCOsmzuc1wEv6PQq9ZW+CRZ0XlarK3720M8FBN1B+817yvgCY
	 a7JxrLkwLBSUWmq3W4QjavY9iYvFCc5EUXs8bZL6R7wMOUlIKNKVFJq4uQ6MvF4SG+
	 FKz1iP+tBJR7obyvb5XZlm6/dZicQRFHEZ1hs5C3OCbiRc8dS/PqYwpJZsn5ijPOgy
	 Dn+D5ozW0ArHw==
Date: Thu, 12 Dec 2024 16:11:20 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Yeongjin Gil <youngjin.gil@samsung.com>, chao@kernel.org,
	daehojeong@google.com, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>,
	Sunmin Jeong <s_min.jeong@samsung.com>,
	Jaewook Kim <jw5454.kim@samsung.com>
Subject: Re: [PATCH v2] f2fs: compress: don't redirty sparse cluster during
 {,de}compress
Message-ID: <Z1sLKDtRa3wX2Z9g@google.com>
References: <CGME20240819083433epcas1p3861b773a5b21eea6f0332036a71bb5d7@epcas1p3.samsung.com>
 <20240819083430.31852-1-youngjin.gil@samsung.com>
 <644671fc-b35d-4c53-ae25-356963466339@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <644671fc-b35d-4c53-ae25-356963466339@stanley.mountain>

On 12/12, Dan Carpenter wrote:
> On Mon, Aug 19, 2024 at 05:34:30PM +0900, Yeongjin Gil wrote:
> > In f2fs_do_write_data_page, when the data block is NULL_ADDR, it skips
> > writepage considering that it has been already truncated.
> > This results in an infinite loop as the PAGECACHE_TAG_TOWRITE tag is not
> > cleared during the writeback process for a compressed file including
> > NULL_ADDR in compress_mode=user.
> > 
> > This is the reproduction process:
> > 
> > 1. dd if=/dev/zero bs=4096 count=1024 seek=1024 of=testfile
> > 2. f2fs_io compress testfile
> > 3. dd if=/dev/zero bs=4096 count=1 conv=notrunc of=testfile
> > 4. f2fs_io decompress testfile
> > 
> > To prevent the problem, let's check whether the cluster is fully
> > allocated before redirty its pages.
> > 
> 
> We were discussing how to detect these sorts of things in the future.
> Presumably a user found this by chance?  Xfstests has two tests which deal
> with compression tests/f2fs/002 and tests/f2fs/007.  But it feels like
> xfstests is not really the right place for this sort of thing, it would
> be better as part of some sort of fuzz testing.
> 
> What do you think?

Yeah, agreed that we must have tests to catch this. One way may be creating
some basic disk images having some possible valid layout to see f2fs can
work as intended. I feel we can put it in xfstests as wel?

Chao, thoughts?

> 
> regards,
> dan carpenter

