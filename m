Return-Path: <linux-kernel+bounces-335656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AAE97E89F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881D9280F38
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFDA194AF3;
	Mon, 23 Sep 2024 09:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=studenti.polito.it header.i=@studenti.polito.it header.b="RhMyMo3X"
Received: from compass.polito.it (compass.polito.it [130.192.55.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFA93D556
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.192.55.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727083674; cv=none; b=WSQUMMr49BaDyU8XZHaTbXG03OpLAV3Lv4vexcWwrS+1L8cliKsufpk4Lqb/TdTtCmBgG+8m/7F8ugvvSpwlsEkZLMqQgHYVOQxcNMvZEbm8EWb8nUuy88RAl2avhtHGxTQqFsiro51lJq29DWHVLPAsB1BvjN0rjakVg2HW9Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727083674; c=relaxed/simple;
	bh=ysBwwg4v0AoOMOBgReKqS70SJOfel8B59Qui7SyeszM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/IewiQ+6EZ0Q5S/5zR0El7jvUhHyD+bQaXlAa1EH1WB2MmwvnEQDSMtz2CAUWg91cpvUlRoNV4lVkUw+IXafHSAD/zt6r5Q6Z2YZGknGE6bobNZO9ZAdJLQVxf/Iq/wDoJbPtb87UMFg1V/45G/AlRRLhn9+TC+kO9ZfKhy1Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=studenti.polito.it; spf=pass smtp.mailfrom=studenti.polito.it; dkim=pass (1024-bit key) header.d=studenti.polito.it header.i=@studenti.polito.it header.b=RhMyMo3X; arc=none smtp.client-ip=130.192.55.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=studenti.polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=studenti.polito.it
Received: from compass-fwd (localhost [127.0.0.1])
	by compass.polito.it (Postfix) with ESMTP id 786D26001181;
	Mon, 23 Sep 2024 11:23:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by compass.polito.it (Postfix) with ESMTP id 769F86001180;
	Mon, 23 Sep 2024 11:23:56 +0200 (CEST)
Authentication-Results: compass.polito.it (amavisd-new);
	dkim=pass (1024-bit key) reason="pass (just generated, assumed good)"
	header.d=studenti.polito.it
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	studenti.polito.it; h=content-transfer-encoding:content-type
	:content-type:in-reply-to:from:from:content-language:references
	:cc:to:subject:subject:user-agent:mime-version:date:date
	:message-id:received:received; s=y2k10; t=1727083435; bh=ysBwwg4
	v0AoOMOBgReKqS70SJOfel8B59Qui7SyeszM=; b=RhMyMo3XvFFxm6Z4XsL8rYh
	sJ3L8/ItLDAg+5HlIS0cZXnl3p74t+kZUyiD5TT0EsT6SCI4lqbodsbbzspJ91Hk
	mXneqYc0XIpuKYy5xrzg0mGg6kD8ZxgcGPA65FKZ/IlL67Qq09nTdcPY8ZXQSEeE
	MNNbUOTEGENPHaDxcrMI=
X-Virus-Scanned: amavisd-new at studenti.polito.it
X-Spam-Flag: NO
X-Spam-Score: -6.499
X-Spam-Level:
Received: from compass.polito.it ([127.0.0.1])
	by localhost (compass.polito.it [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2mtuOcE0hf4E; Mon, 23 Sep 2024 11:23:55 +0200 (CEST)
X-AccountStatus: yes
Received: from [172.21.70.41] (unknown [172.21.70.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: s273493@studenti.polito.it)
	by compass.polito.it (Postfix) with ESMTPSA id DAAE8600118A;
	Mon, 23 Sep 2024 11:23:49 +0200 (CEST)
Message-ID: <8084185d-b4cf-4c30-a67e-28b9b590306d@studenti.polito.it>
Date: Mon, 23 Sep 2024 11:23:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] udf: fix uninit-value use in udf_get_fileshortad
To: kernel test robot <lkp@intel.com>, oe-kbuild@lists.linux.dev
Cc: Dan Carpenter <error27@gmail.com>, jack@suse.com,
 linux-kernel@vger.kernel.org,
 syzbot+8901c4560b7ab5c2f9df@syzkaller.appspotmail.com
References: <202409230809.5ozgjLm9-lkp@intel.com>
Content-Language: en-US, it
From: Gianfranco Trad <s323713@studenti.polito.it>
In-Reply-To: <202409230809.5ozgjLm9-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
On 23/09/24 02:26, kernel test robot wrote:
> BCC: lkp@intel.com
> CC: oe-kbuild-all@lists.linux.dev
> In-Reply-To: <20240919195227.412583-1-gianf.trad@gmail.com>
> References: <20240919195227.412583-1-gianf.trad@gmail.com>
> TO: Gianfranco Trad <gianf.trad@gmail.com>
> TO: jack@suse.com
> CC: linux-kernel@vger.kernel.org
> CC: skhan@linuxfoundation.org
> CC: Gianfranco Trad <gianf.trad@gmail.com>
> CC: syzbot+8901c4560b7ab5c2f9df@syzkaller.appspotmail.com
>
> Hi Gianfranco,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on brauner-vfs/vfs.all]
> [also build test WARNING on linus/master v6.11 next-20240920]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Gianfranco-Trad/udf-fix-uninit-value-use-in-udf_get_fileshortad/20240920-035519
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
> patch link:    https://lore.kernel.org/r/20240919195227.412583-1-gianf.trad%40gmail.com
> patch subject: [PATCH] udf: fix uninit-value use in udf_get_fileshortad
> :::::: branch date: 3 days ago
> :::::: commit date: 3 days ago
> config: mips-randconfig-r073-20240922 (https://download.01.org/0day-ci/archive/20240923/202409230809.5ozgjLm9-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 8663a75fa2f31299ab8d1d90288d9df92aadee88)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> | Closes: https://lore.kernel.org/r/202409230809.5ozgjLm9-lkp@intel.com/
>
> smatch warnings:
> fs/udf/inode.c:2223 udf_current_aext() error: we previously assumed 'epos->bh' could be null (see line 2204)
Given this error my initial guess is to update the patch to check the 
assumption of epos->bh not null.
> vim +2223 fs/udf/inode.c
>
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  2193
> ff116fc8d1d439 Jan Kara        2007-05-08  2194  int8_t udf_current_aext(struct inode *inode, struct extent_position *epos,
> 5ca4e4be841e38 Pekka Enberg    2008-10-15  2195  			struct kernel_lb_addr *eloc, uint32_t *elen, int inc)
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  2196  {
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  2197  	int alen;
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  2198  	int8_t etype;
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  2199  	uint8_t *ptr;
> 5ca4e4be841e38 Pekka Enberg    2008-10-15  2200  	struct short_ad *sad;
> 5ca4e4be841e38 Pekka Enberg    2008-10-15  2201  	struct long_ad *lad;
> 48d6d8ff7dca80 Marcin Slusarz  2008-02-08  2202  	struct udf_inode_info *iinfo = UDF_I(inode);
> 28de7948a89676 Cyrill Gorcunov 2007-07-21  2203
> cb00ea3528eb3c Cyrill Gorcunov 2007-07-19 @2204  	if (!epos->bh) {
> ff116fc8d1d439 Jan Kara        2007-05-08  2205  		if (!epos->offset)
> ff116fc8d1d439 Jan Kara        2007-05-08  2206  			epos->offset = udf_file_entry_alloc_offset(inode);
> 382a2287bf9cd2 Jan Kara        2020-09-25  2207  		ptr = iinfo->i_data + epos->offset -
> 4b11111aba6c80 Marcin Slusarz  2008-02-08  2208  			udf_file_entry_alloc_offset(inode) +
> 48d6d8ff7dca80 Marcin Slusarz  2008-02-08  2209  			iinfo->i_lenEAttr;
> 4b11111aba6c80 Marcin Slusarz  2008-02-08  2210  		alen = udf_file_entry_alloc_offset(inode) +
> 48d6d8ff7dca80 Marcin Slusarz  2008-02-08  2211  							iinfo->i_lenAlloc;
> cb00ea3528eb3c Cyrill Gorcunov 2007-07-19  2212  	} else {
> ff116fc8d1d439 Jan Kara        2007-05-08  2213  		if (!epos->offset)
> ff116fc8d1d439 Jan Kara        2007-05-08  2214  			epos->offset = sizeof(struct allocExtDesc);
> ff116fc8d1d439 Jan Kara        2007-05-08  2215  		ptr = epos->bh->b_data + epos->offset;
> 28de7948a89676 Cyrill Gorcunov 2007-07-21  2216  		alen = sizeof(struct allocExtDesc) +
> 4b11111aba6c80 Marcin Slusarz  2008-02-08  2217  			le32_to_cpu(((struct allocExtDesc *)epos->bh->b_data)->
> 4b11111aba6c80 Marcin Slusarz  2008-02-08  2218  							lengthAllocDescs);
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  2219  	}
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  2220
> 48d6d8ff7dca80 Marcin Slusarz  2008-02-08  2221  	switch (iinfo->i_alloc_type) {
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  2222  	case ICBTAG_FLAG_AD_SHORT:
> 2aa242080b8dda Gianfranco Trad 2024-09-19 @2223  		if (unlikely(alen < 0 && epos->offset == epos->bh->b_size))
> 2aa242080b8dda Gianfranco Trad 2024-09-19  2224  			return -1;
The check would be inserted up here in the if clause. But if the patch 
doesn't look good, I can redesign it in a better way. If so, I'm more 
than glad to follow your advice.
> 4b11111aba6c80 Marcin Slusarz  2008-02-08  2225  		sad = udf_get_fileshortad(ptr, alen, &epos->offset, inc);
> 4b11111aba6c80 Marcin Slusarz  2008-02-08  2226  		if (!sad)
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  2227  			return -1;
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  2228  		etype = le32_to_cpu(sad->extLength) >> 30;
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  2229  		eloc->logicalBlockNum = le32_to_cpu(sad->extPosition);
> 4b11111aba6c80 Marcin Slusarz  2008-02-08  2230  		eloc->partitionReferenceNum =
> 48d6d8ff7dca80 Marcin Slusarz  2008-02-08  2231  				iinfo->i_location.partitionReferenceNum;
> 28de7948a89676 Cyrill Gorcunov 2007-07-21  2232  		*elen = le32_to_cpu(sad->extLength) & UDF_EXTENT_LENGTH_MASK;
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  2233  		break;
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  2234  	case ICBTAG_FLAG_AD_LONG:
> 4b11111aba6c80 Marcin Slusarz  2008-02-08  2235  		lad = udf_get_filelongad(ptr, alen, &epos->offset, inc);
> 4b11111aba6c80 Marcin Slusarz  2008-02-08  2236  		if (!lad)
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  2237  			return -1;
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  2238  		etype = le32_to_cpu(lad->extLength) >> 30;
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  2239  		*eloc = lelb_to_cpu(lad->extLocation);
> 28de7948a89676 Cyrill Gorcunov 2007-07-21  2240  		*elen = le32_to_cpu(lad->extLength) & UDF_EXTENT_LENGTH_MASK;
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  2241  		break;
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  2242  	default:
> fcbf7637e6647e Steve Magnani   2017-10-12  2243  		udf_debug("alloc_type = %u unsupported\n", iinfo->i_alloc_type);
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  2244  		return -1;
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  2245  	}
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  2246
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  2247  	return etype;
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  2248  }
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  2249
>
Thanks for your time,

--Gian


