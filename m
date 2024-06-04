Return-Path: <linux-kernel+bounces-200384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF588FAF31
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05E81F20F08
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B9B143759;
	Tue,  4 Jun 2024 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tJ1im1G5"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E431448C0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717494414; cv=none; b=HdA0wKo3H2SiBUOvfGuwfOA5SRHeran0vVTn/1dgb3JSV0Ycr0xcvQw/9U4sg2GBQX4hf+iw3iLZmh/SmwnLGE2JWen5+dGHCgmHzem8OMo7GsfdfxwBBzIgFkj3pSUiWz5ycpgBlNhHHtNoXdKuQUDOGr6RJu2FFJgXKOB2dcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717494414; c=relaxed/simple;
	bh=1wnMqtQJtRj3+gTWj1ugftP7U3xAwgM0JU7zBk7OL6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cftn8uXYO5kH1cGrhK7lkgVnxECi+Gov0/Tc+p9xwf+FuA2z5kDz/TGyxE/Iu5bMn5qJZlezMiH7uOEFlH481OGJhtaSWxYi8iS/otqtmZ/mG0sfsqFvN0qSo6ZxVvU2rlujvnAb09fqCpwWhkYEC/dwP2kbzQWX7DYOffPCvSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tJ1im1G5; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717494410; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=w9CWqFqz/02HJiTpzlXIXRw1jdnSg1U4CIk3OywuaOY=;
	b=tJ1im1G5iYKNxneVXZRPCZYzw6J+0TMSK4M1I4hbU+FD9o55WU25jA444QMQSQSoW3iAtNC93phjfBdEiBUrtnytKIwTAUy5Od3QqHbYqK+RQEdJqtjAjJMRFwaXIz+kg1fcmv8HCqRSxg17ONvKnbQPMIwAwaddgZFQ2eGnO5o=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W7qjMxu_1717494322;
Received: from 30.97.56.67(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7qjMxu_1717494322)
          by smtp.aliyun-inc.com;
          Tue, 04 Jun 2024 17:46:49 +0800
Message-ID: <ae09631d-65e1-42a7-a574-468a1c7c3ea6@linux.alibaba.com>
Date: Tue, 4 Jun 2024 17:46:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] mm: shmem: add mTHP support for anonymous shmem
To: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
 akpm@linux-foundation.org, hughd@google.com
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, willy@infradead.org,
 david@redhat.com, wangkefeng.wang@huawei.com, ying.huang@intel.com,
 21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com,
 ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com,
 p.raghav@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <ad47dc93-0cdb-45fb-83b3-170f2c09b93a@moroto.mountain>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ad47dc93-0cdb-45fb-83b3-170f2c09b93a@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/4 17:23, Dan Carpenter wrote:
> Hi Baolin,
> 
> kernel test robot noticed the following build warnings:
> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baolin-Wang/mm-memory-extend-finish_fault-to-support-large-folio/20240530-100805
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/ec35a23026dd016705d211e85163cabe07681516.1717033868.git.baolin.wang%40linux.alibaba.com
> patch subject: [PATCH v3 4/6] mm: shmem: add mTHP support for anonymous shmem
> config: powerpc64-randconfig-r071-20240531 (https://download.01.org/0day-ci/archive/20240602/202406020203.14sT311e-lkp@intel.com/config)
> compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project bafda89a0944d947fc4b3b5663185e07a397ac30)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202406020203.14sT311e-lkp@intel.com/
> 
> smatch warnings:
> mm/shmem.c:1766 shmem_alloc_and_add_folio() error: uninitialized symbol 'suitable_orders'.

Thanks Dan. LKP also reported this warning [1]. Will fix it.

[1] https://lore.kernel.org/all/202405301430.0NRLTOWU-lkp@intel.com/

