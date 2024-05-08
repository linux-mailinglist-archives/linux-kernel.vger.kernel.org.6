Return-Path: <linux-kernel+bounces-172727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1548BF5E2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 08:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B72F4B23002
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 06:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1CF17BCD;
	Wed,  8 May 2024 06:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="M0dC76PS"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0E08F6C
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 06:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715148224; cv=none; b=hKN7d3MA84jeViQL5sDtTIfECPRBIAcyh3Sv81TcAluRDUkWHSfzT5nCm+vSOejk4zyKKP8H9ltGk5yK5cxKsaTZmIgNbhBcvIpGKNXg7CN01ChpUVmhUIpFSGNT1KXgMk1Cezb8OAaafsag8CbcIep9oqu7mAPRvuLlHUNY8cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715148224; c=relaxed/simple;
	bh=vR8MQjZ4OZFhEHYcpFtvdK1XRggMdo6jqFWufXUb6lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u1YgxRnA/1jISul7LcTiBrOsvtTtDN+6j+1DIJ34VmWgHKGCVQhD8lUWDV5SKu7zhwgS8j2QeW8nTvTOD7KFgmQb+rc91L8iExw8i51Y+uRBw4P+medsaOrzxaF/Qg315v7kwTjm5t/2rv+zV1Kkfd2ABkTLlr+yBRAFsMHBxyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=M0dC76PS; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715148217; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=quezWr5QuXsegJOKyc01UZwoa4UGQB+lMfqaDG5ySt4=;
	b=M0dC76PSi5EJU+kfyDhPKEE/dF4SPcbeDfaMMu/z14myLJy/Ks0SylhLhtbTlegEv5b1bXKWS+17yLrU1NZrRbKFMfwIFTHIRLyeBeK/eBAXnqSfc9Rnfums6yk6Y+tTuYHR/4ZToXElUsDFleu8vtcysg+p4ubFUfS55orR1cg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W62W8yi_1715148214;
Received: from 30.97.56.69(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W62W8yi_1715148214)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 14:03:35 +0800
Message-ID: <4a6c6c90-04bd-4a02-9080-0f98e8cf5ebe@linux.alibaba.com>
Date: Wed, 8 May 2024 14:03:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] mm: shmem: add mTHP support for anonymous shmem
To: kernel test robot <lkp@intel.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, willy@infradead.org,
 david@redhat.com, ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 ying.huang@intel.com, 21cnbao@gmail.com, ryan.roberts@arm.com,
 shy828301@gmail.com, ziy@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <adc64bf0f150bdc614c6c06fc313adeef7dbbbff.1714978902.git.baolin.wang@linux.alibaba.com>
 <202405071820.2KY0UnDu-lkp@intel.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <202405071820.2KY0UnDu-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2024/5/7 18:46, kernel test robot wrote:
>>> mm/shmem.c:1780:10: warning: variable 'folio' is used uninitialized whenever 'while' loop exits because its condition is false [-Wsometimes-uninitialized]
>      1780 |                 while (suitable_orders) {
>           |                        ^~~~~~~~~~~~~~~
>     mm/shmem.c:1795:7: note: uninitialized use occurs here
>      1795 |         if (!folio)
>           |              ^~~~~
>     mm/shmem.c:1780:10: note: remove the condition if it is always true
>      1780 |                 while (suitable_orders) {
>           |                        ^~~~~~~~~~~~~~~
>           |                        1
>     mm/shmem.c:1750:21: note: initialize the variable 'folio' to silence this warning
>      1750 |         struct folio *folio;
>           |                            ^
>           |                             = NULL
>     mm/shmem.c:1564:20: warning: unused function 'shmem_show_mpol' [-Wunused-function]
>      1564 | static inline void shmem_show_mpol(struct seq_file *seq, struct mempolicy *mpol)

Thanks for reporting. Will add below change to avoid the warning:
diff --git a/mm/shmem.c b/mm/shmem.c
index d603e36e0f4f..fd2cb2e73a21 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1747,7 +1747,7 @@ static struct folio 
*shmem_alloc_and_add_folio(struct vm_fault *vmf,
         struct shmem_inode_info *info = SHMEM_I(inode);
         struct vm_area_struct *vma = vmf ? vmf->vma : NULL;
         unsigned long suitable_orders;
-       struct folio *folio;
+       struct folio *folio = NULL;
         long pages;
         int error, order;

