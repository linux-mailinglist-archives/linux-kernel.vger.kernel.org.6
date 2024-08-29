Return-Path: <linux-kernel+bounces-306626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D61A964177
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A79CB209E4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A991A18FDC0;
	Thu, 29 Aug 2024 10:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d8Irqwkv"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE35818FDD7
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926679; cv=none; b=Y3g+Ob3z0Z41/8GpsmxJUVQC0H1w8r9XCVPIxMXg74+xpVxd6wd2/dg8bP6okrZIbpdO0Q6lhj5a0bNKLeHdUfREDIpBfhtw3rch7ekXTxPWh+G3UgQdGmGUpen3AV56ToGCTHzgJO3XGS/w0pSNXupYlUhIjKQrhv9BkHlrvAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926679; c=relaxed/simple;
	bh=jx64PfnZ0P8Maw2epRmW4FNEZO3KTHmGCd5DnUz0FZE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lOQBaHyBeMil2LPfuNM63lcVo1Nin+tHchUnjkDUYrnNEPkV+ndL4RdFzOnFmsZQBvaJVVX+hnllTDEAVFUjfF/2s/MmVzg35JLLjbdsEUTlrOIbDo30mhEpN5/ZHIKGMQ8A6Az0AxQ/DRBFo+/i3BGrsBjHxjcCzr1fOhvIZKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d8Irqwkv; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-428178fc07eso3982405e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724926676; x=1725531476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cpJAK3u0wNHTYAsOsJ3G+ulHexNJQQgw5rassGX01aE=;
        b=d8Irqwkv/k29762uM5U05JtKZWXC4vooT55qu1pQTHzqLUUOWrUm+QUTV8iK6bwX3H
         pFgGhEbFeuFoCXLju9QaBDowQbnZrwR/xY7iGSZsGGjdLZLRKwdU+FUe5/D5fFg6bXO3
         1CW6SmF0CezHUlgEVvi2rjjQMSpHO5MtNNfH4iR57/6TOlrK+QjsJEyK0iJGwzXW7AAd
         YbnfXzfHQwma4EevC00o2JUzFbA6RGNjjOmgMHBCzn/qCP9C982QjB5k99JYITmME750
         lnXiaVPdFK7k1hjzuwYa9twi3mxO5KezN0A1uT2YPvtqbvy1moOmWzDsVGFW5ps4b5gp
         cCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926676; x=1725531476;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpJAK3u0wNHTYAsOsJ3G+ulHexNJQQgw5rassGX01aE=;
        b=LmfF+FOW8ODIBB6YvYqjj0FuAEoYEf9bJFuGUaeNW9KpUZqhf4RMtf8RhoJPB7JvQ7
         EQrQQCZRBx8x65lsh5U7y8a9YXAFd03sXrpeQEjMbhFGREDVjEzWb1ckNgWXojDXUalO
         bQcCtoIeb4M94GW5+Bzi5rnKQYe/LOc8i7H5iBizW4guz9Qsh4vm9+2RU2WJ5pQ12Tnk
         GNp9n7p7AlAcUPtUHnHgEY8Qk++zN48mzAwVd3ACp9/1ci8B4bN4mdwnnpebNvq5B0KN
         IYOO7wDWIWKJyfubBYSJod4o0MPXvSnvAnJRl7pYHUW1U1Bofsz/+dg9h3kdFR5CKxUb
         eeOA==
X-Forwarded-Encrypted: i=1; AJvYcCVHJrDGo5bdyn7amHQQNJEPQcrdVZv5G5+dpEhGnPRKBdicEe2FY0Jyv62HylTSGhF9oOKvyhfslZIeh8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YywjTxzVQJs961sUiNnSGS82FBzT78wnHyw328rYCpdfxrvjfBY
	Q45udUEay7rdU+hJyumADbEXPP5WHSKCQN0rkIYrslysautiUzZOWzJHPLskYEU=
X-Google-Smtp-Source: AGHT+IHKHTDFnByEuQrhxWvf5SouAIMF+9fOY83uMUNMpx5WQn1PycSxrrZARYgdc1+Bu9avy5zAFw==
X-Received: by 2002:a05:600c:4707:b0:426:5b21:97fa with SMTP id 5b1f17b1804b1-42bb27a102cmr18206875e9.29.1724926675727;
        Thu, 29 Aug 2024 03:17:55 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba6396700sm47212215e9.10.2024.08.29.03.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:17:55 -0700 (PDT)
Date: Thu, 29 Aug 2024 13:17:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Huan Yang <link@vivo.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Gerd Hoffmann <kraxel@redhat.com>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	opensource.kernel@vivo.com, Huan Yang <link@vivo.com>
Subject: Re: [PATCH v4 4/5] udmabuf: udmabuf_create codestyle cleanup
Message-ID: <b9946356-3375-4817-92dd-baaf85802462@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822084342.1574914-5-link@vivo.com>

Hi Huan,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Huan-Yang/udmabuf-direct-map-pfn-when-first-page-fault/20240826-105359
base:   6a7917c89f219f09b1d88d09f376000914a52763
patch link:    https://lore.kernel.org/r/20240822084342.1574914-5-link%40vivo.com
patch subject: [PATCH v4 4/5] udmabuf: udmabuf_create codestyle cleanup
config: x86_64-randconfig-161-20240829 (https://download.01.org/0day-ci/archive/20240829/202408291101.WAf552sW-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202408291101.WAf552sW-lkp@intel.com/

smatch warnings:
drivers/dma-buf/udmabuf.c:467 udmabuf_create() error: double free of 'folios'

vim +/folios +467 drivers/dma-buf/udmabuf.c

c1bbed66899726 Gurchetan Singh 2019-12-02  396  static long udmabuf_create(struct miscdevice *device,
c1bbed66899726 Gurchetan Singh 2019-12-02  397  			   struct udmabuf_create_list *head,
c1bbed66899726 Gurchetan Singh 2019-12-02  398  			   struct udmabuf_create_item *list)
fbb0de79507819 Gerd Hoffmann   2018-08-27  399  {
fb2c508270085b Huan Yang       2024-08-22  400  	pgoff_t pgcnt = 0, pglimit, max_ipgcnt = 0;
fb2c508270085b Huan Yang       2024-08-22  401  	long ret = -EINVAL;
fbb0de79507819 Gerd Hoffmann   2018-08-27  402  	struct udmabuf *ubuf;
fb2c508270085b Huan Yang       2024-08-22  403  	struct folio **folios = NULL;
fb2c508270085b Huan Yang       2024-08-22  404  	u32 i, flags;
fbb0de79507819 Gerd Hoffmann   2018-08-27  405  
33f35429fc49c0 Gerd Hoffmann   2018-09-11  406  	ubuf = kzalloc(sizeof(*ubuf), GFP_KERNEL);
fbb0de79507819 Gerd Hoffmann   2018-08-27  407  	if (!ubuf)
fbb0de79507819 Gerd Hoffmann   2018-08-27  408  		return -ENOMEM;
fbb0de79507819 Gerd Hoffmann   2018-08-27  409  
c6a3194c05e7e6 Vivek Kasireddy 2024-06-23  410  	INIT_LIST_HEAD(&ubuf->unpin_list);
dc4716d75154b3 Gerd Hoffmann   2018-09-11  411  	pglimit = (size_limit_mb * 1024 * 1024) >> PAGE_SHIFT;
fbb0de79507819 Gerd Hoffmann   2018-08-27  412  	for (i = 0; i < head->count; i++) {
fb2c508270085b Huan Yang       2024-08-22  413  		pgoff_t itempgcnt;
fb2c508270085b Huan Yang       2024-08-22  414  
fb2c508270085b Huan Yang       2024-08-22  415  		if (!PAGE_ALIGNED(list[i].offset))
0d17455ca85ecb Gerd Hoffmann   2018-09-11  416  			goto err;
fb2c508270085b Huan Yang       2024-08-22  417  		if (!PAGE_ALIGNED(list[i].size))
0d17455ca85ecb Gerd Hoffmann   2018-09-11  418  			goto err;
fb2c508270085b Huan Yang       2024-08-22  419  
fb2c508270085b Huan Yang       2024-08-22  420  		itempgcnt = list[i].size >> PAGE_SHIFT;
fb2c508270085b Huan Yang       2024-08-22  421  		pgcnt += itempgcnt;
fb2c508270085b Huan Yang       2024-08-22  422  
fb2c508270085b Huan Yang       2024-08-22  423  		if (pgcnt > pglimit)
0d17455ca85ecb Gerd Hoffmann   2018-09-11  424  			goto err;
fb2c508270085b Huan Yang       2024-08-22  425  
fb2c508270085b Huan Yang       2024-08-22  426  		max_ipgcnt = max_t(unsigned long, itempgcnt, max_ipgcnt);
fbb0de79507819 Gerd Hoffmann   2018-08-27  427  	}
2b6dd600dd7257 Pavel Skripkin  2021-12-30  428  
fb2c508270085b Huan Yang       2024-08-22  429  	if (!pgcnt)
2b6dd600dd7257 Pavel Skripkin  2021-12-30  430  		goto err;
2b6dd600dd7257 Pavel Skripkin  2021-12-30  431  
fb2c508270085b Huan Yang       2024-08-22  432  	ubuf->folios = kvmalloc_array(pgcnt, sizeof(*ubuf->folios),
fbb0de79507819 Gerd Hoffmann   2018-08-27  433  				      GFP_KERNEL);
5e72b2b41a21e5 Vivek Kasireddy 2024-06-23  434  	if (!ubuf->folios) {
fbb0de79507819 Gerd Hoffmann   2018-08-27  435  		ret = -ENOMEM;
0d17455ca85ecb Gerd Hoffmann   2018-09-11  436  		goto err;
fbb0de79507819 Gerd Hoffmann   2018-08-27  437  	}
fb2c508270085b Huan Yang       2024-08-22  438  
fb2c508270085b Huan Yang       2024-08-22  439  	ubuf->offsets = kvcalloc(pgcnt, sizeof(*ubuf->offsets), GFP_KERNEL);
0c8b91ef5100ea Vivek Kasireddy 2024-06-23  440  	if (!ubuf->offsets) {
0c8b91ef5100ea Vivek Kasireddy 2024-06-23  441  		ret = -ENOMEM;
0c8b91ef5100ea Vivek Kasireddy 2024-06-23  442  		goto err;
0c8b91ef5100ea Vivek Kasireddy 2024-06-23  443  	}
fbb0de79507819 Gerd Hoffmann   2018-08-27  444  
fb2c508270085b Huan Yang       2024-08-22  445  	folios = kvmalloc_array(max_ipgcnt, sizeof(*folios), GFP_KERNEL);
c6a3194c05e7e6 Vivek Kasireddy 2024-06-23  446  	if (!folios) {
c6a3194c05e7e6 Vivek Kasireddy 2024-06-23  447  		ret = -ENOMEM;
c6a3194c05e7e6 Vivek Kasireddy 2024-06-23  448  		goto err;
c6a3194c05e7e6 Vivek Kasireddy 2024-06-23  449  	}
c6a3194c05e7e6 Vivek Kasireddy 2024-06-23  450  
fb2c508270085b Huan Yang       2024-08-22  451  	for (i = 0; i < head->count; i++) {
fb2c508270085b Huan Yang       2024-08-22  452  		ret = __udmabuf_pin_list_folios(&list[i], ubuf, folios);

There is a kfree(folios) hidden inside this function.  It doesn't belong there.

fb2c508270085b Huan Yang       2024-08-22  453  		if (ret)
0d17455ca85ecb Gerd Hoffmann   2018-09-11  454  			goto err;
c6a3194c05e7e6 Vivek Kasireddy 2024-06-23  455  	}
452dc1b0221804 Huan Yang       2024-08-22  456  	kvfree(folios);
                                                        ^^^^^^^^^^^^^^
A second free

fbb0de79507819 Gerd Hoffmann   2018-08-27  457  
5e72b2b41a21e5 Vivek Kasireddy 2024-06-23  458  	flags = head->flags & UDMABUF_FLAGS_CLOEXEC ? O_CLOEXEC : 0;
5e72b2b41a21e5 Vivek Kasireddy 2024-06-23  459  	ret = export_udmabuf(ubuf, device, flags);
5e72b2b41a21e5 Vivek Kasireddy 2024-06-23  460  	if (ret < 0)
0d17455ca85ecb Gerd Hoffmann   2018-09-11  461  		goto err;
                                                                ^^^^^^^^

fbb0de79507819 Gerd Hoffmann   2018-08-27  462  
5e72b2b41a21e5 Vivek Kasireddy 2024-06-23  463  	return ret;
fbb0de79507819 Gerd Hoffmann   2018-08-27  464  
0d17455ca85ecb Gerd Hoffmann   2018-09-11  465  err:
c6a3194c05e7e6 Vivek Kasireddy 2024-06-23  466  	unpin_all_folios(&ubuf->unpin_list);
fb2c508270085b Huan Yang       2024-08-22 @467  	kvfree(folios);
                                                        ^^^^^^^^^^^^^
Double free

452dc1b0221804 Huan Yang       2024-08-22  468  	kvfree(ubuf->offsets);
452dc1b0221804 Huan Yang       2024-08-22  469  	kvfree(ubuf->folios);
fbb0de79507819 Gerd Hoffmann   2018-08-27  470  	kfree(ubuf);
fbb0de79507819 Gerd Hoffmann   2018-08-27  471  	return ret;
fbb0de79507819 Gerd Hoffmann   2018-08-27  472  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


