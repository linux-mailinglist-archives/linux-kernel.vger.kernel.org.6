Return-Path: <linux-kernel+bounces-394373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8CA9BAE1B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 09:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E0042814B1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 08:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BCD18B498;
	Mon,  4 Nov 2024 08:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IWKBxuYT"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0181618F2F7
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 08:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730709083; cv=none; b=eKnGUQVBhMdrfe5A5v7ZWtZ8rBle7I6cEtUFZ6v8mhlCpM47B73kNyFy8wXz9L9y8cuVFxptgXc6Vvd0yjeGTyQNAm/7lcEmOV0BNYAjA1KKBwW9glKH/hS/StfyHK3sfKbUJ6oyhiQUwPAs5hJBWpIX9dlMZkauToZy2OpbioI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730709083; c=relaxed/simple;
	bh=RMFwDMojD3zrSAgOcjuKC+xriirvgs/o1aANeynXSuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QxwVWZAfpX8E+WVrcC44fIeB+Ng3ehpUfvSQEM4Rwc83ePz0Zn06rgXzMiERIABHg12tTuUzDL8fQwJevBa0u+FE1KLdYgwGeGX8wItcwm2MUNi6Gte7inV/XqqvhuWhR/1XqVy4OeDYR3FUoUa/fhF06ReikG0fJc8tbWSJnwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IWKBxuYT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4314c452180so28650495e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 00:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730709078; x=1731313878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T5vDLGsbEr0SVIowN1t5ye+7OUL4pjjT2D7werAFSjM=;
        b=IWKBxuYTkq6vrWktIU4NQb+ppiLmusdhAA+wKIM7dsIqwjibfjojLeWeUzYwEXwvCL
         dZS2u2L9YQQHdglBiFuBnLy1AHlVZOYDgoiK/TAJ4fq9bX5tkb+1ce4T2kTAfX3QF6+8
         C6z7zn+Jp7RpdnIsnk0qO0t4hlA4Awz7z9WQj27+q89wybZw75T1rnNpuK2HKwsLz4VF
         3LGCsJyJZuIVs5eZ+qJM2Gvy5e1EdPhLeUcNgtInjTDsJ8rlMzh0N9LCiqimUcwk8+Rq
         lxB4gGS3Xf6LOnvHG2Ct/OtuiHTDyc6mK7ZXyVtIzSp8YID/a3pnDdhg8+g8qTx6BVPS
         rBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730709078; x=1731313878;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T5vDLGsbEr0SVIowN1t5ye+7OUL4pjjT2D7werAFSjM=;
        b=r2800j0LQJAUdnUla/wNRfSlqlWugbHFCxpOM7Y613o7QG6N10+KU7SaRnI7SpwmE+
         XcVX3Om2JTQjyUFY3GBr+x9pxybZVCgRfTIaL9wcUVkrvjV948xRkS0gsEUCgxjfNyyQ
         9t98JivuMcE7lX9qu6rj7rT0Yw+P/slM0C6MhuT70Iara6R2BFMOmwVLJPbTSCVRtQ6d
         FoGnYpBJBDIU9BI4jlVcQoGR9k8+Pu2MF1iVw9ztsd/6nHfj8oomLZ5/L1KPemTxnVAM
         sEwJdYmo2SD6yKeAXpS5097esrIDwVKgczlf4GhjFgXZEE6ZB+dbU7DAEhqgrBWQj1Y3
         x0nA==
X-Forwarded-Encrypted: i=1; AJvYcCVniuslctJ77ZVDgqYtkL1YJHJjsPgvZQnK2ZWXNSSQCMM1KDZHd+LPv5wvu4vQTqnjfFAHneWUruHSRCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHp5Fokx6iIUV7eoXCwyF2mqBm+uIqQnvPUvvAYNxJRrjZ+/Ai
	6w2FLSUbYPCpjIqlIUHqxTFry6MkHh4POysRh9c2mOcclhqbJSgnQgSLWAhQ1js=
X-Google-Smtp-Source: AGHT+IFFiT8xMGT+o7kM5vRaU6KjK8tqr+AcRQcVqXIZYuM1L7HGi9LZqQfv+QQLXIRdVtTWEYW6xA==
X-Received: by 2002:a5d:64a7:0:b0:374:c7cd:8818 with SMTP id ffacd0b85a97d-381c79e366dmr9155476f8f.22.1730709078297;
        Mon, 04 Nov 2024 00:31:18 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d439esm12549514f8f.44.2024.11.04.00.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 00:31:17 -0800 (PST)
Date: Mon, 4 Nov 2024 11:31:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	hannes@cmpxchg.org, yosryahmed@google.com, nphamcs@gmail.com,
	chengming.zhou@linux.dev, usamaarif642@gmail.com,
	ryan.roberts@arm.com, ying.huang@intel.com, 21cnbao@gmail.com,
	akpm@linux-foundation.org, linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	clabbe@baylibre.com, ardb@kernel.org, ebiggers@google.com,
	surenb@google.com, kristen.c.accardi@intel.com, zanussi@kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com, kanchana.p.sridhar@intel.com
Subject: Re: [PATCH v2 13/13] mm: zswap: Compress batching with Intel IAA in
 zswap_store() of large folios.
Message-ID: <89728727-0fd2-4539-bc89-17a699d7179a@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241103032111.333282-14-kanchana.p.sridhar@intel.com>

Hi Kanchana,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Kanchana-P-Sridhar/crypto-acomp-Define-two-new-interfaces-for-compress-decompress-batching/20241103-112337
base:   5c4cf96cd70230100b5d396d45a5c9a332539d19
patch link:    https://lore.kernel.org/r/20241103032111.333282-14-kanchana.p.sridhar%40intel.com
patch subject: [PATCH v2 13/13] mm: zswap: Compress batching with Intel IAA in zswap_store() of large folios.
config: x86_64-randconfig-161-20241104 (https://download.01.org/0day-ci/archive/20241104/202411040859.2z0MfFkR-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202411040859.2z0MfFkR-lkp@intel.com/

smatch warnings:
mm/zswap.c:1788 zswap_store_propagate_errors() warn: variable dereferenced before check 'sbp->entry' (see line 1785)

vim +1788 mm/zswap.c

c1252ac91d6a6a Kanchana P Sridhar 2024-11-02  1771  static __always_inline void zswap_store_propagate_errors(
c1252ac91d6a6a Kanchana P Sridhar 2024-11-02  1772  	struct zswap_store_pipeline_state *zst,
c1252ac91d6a6a Kanchana P Sridhar 2024-11-02  1773  	u8 error_batch_idx)
c1252ac91d6a6a Kanchana P Sridhar 2024-11-02  1774  {
c1252ac91d6a6a Kanchana P Sridhar 2024-11-02  1775  	u8 i;
c1252ac91d6a6a Kanchana P Sridhar 2024-11-02  1776  
c1252ac91d6a6a Kanchana P Sridhar 2024-11-02  1777  	if (zst->errors[error_batch_idx])
c1252ac91d6a6a Kanchana P Sridhar 2024-11-02  1778  		return;
c1252ac91d6a6a Kanchana P Sridhar 2024-11-02  1779  
c1252ac91d6a6a Kanchana P Sridhar 2024-11-02  1780  	for (i = 0; i < zst->nr_comp_pages; ++i) {
c1252ac91d6a6a Kanchana P Sridhar 2024-11-02  1781  		struct zswap_store_sub_batch_page *sbp = &zst->sub_batch[i];
c1252ac91d6a6a Kanchana P Sridhar 2024-11-02  1782  
c1252ac91d6a6a Kanchana P Sridhar 2024-11-02  1783  		if (sbp->batch_idx == error_batch_idx) {
c1252ac91d6a6a Kanchana P Sridhar 2024-11-02  1784  			if (!sbp->error) {
c1252ac91d6a6a Kanchana P Sridhar 2024-11-02 @1785  				if (!IS_ERR_VALUE(sbp->entry->handle))
                                                                                                  ^^^^^^^^^^^^^^^^^^
Dereferenced

c1252ac91d6a6a Kanchana P Sridhar 2024-11-02  1786  					zpool_free(zst->pool->zpool, sbp->entry->handle);
c1252ac91d6a6a Kanchana P Sridhar 2024-11-02  1787  
c1252ac91d6a6a Kanchana P Sridhar 2024-11-02 @1788  				if (sbp->entry) {
                                                                                    ^^^^^^^^^^
Checked too late

c1252ac91d6a6a Kanchana P Sridhar 2024-11-02  1789  					zswap_entry_cache_free(sbp->entry);
c1252ac91d6a6a Kanchana P Sridhar 2024-11-02  1790  					sbp->entry = NULL;
c1252ac91d6a6a Kanchana P Sridhar 2024-11-02  1791  				}
c1252ac91d6a6a Kanchana P Sridhar 2024-11-02  1792  				sbp->error = -EINVAL;
c1252ac91d6a6a Kanchana P Sridhar 2024-11-02  1793  			}
c1252ac91d6a6a Kanchana P Sridhar 2024-11-02  1794  		}
c1252ac91d6a6a Kanchana P Sridhar 2024-11-02  1795  	}
c1252ac91d6a6a Kanchana P Sridhar 2024-11-02  1796  
c1252ac91d6a6a Kanchana P Sridhar 2024-11-02  1797  	/*
c1252ac91d6a6a Kanchana P Sridhar 2024-11-02  1798  	 * Set zswap status for the folio to "error"
c1252ac91d6a6a Kanchana P Sridhar 2024-11-02  1799  	 * for use in swap_writepage.
c1252ac91d6a6a Kanchana P Sridhar 2024-11-02  1800  	 */
c1252ac91d6a6a Kanchana P Sridhar 2024-11-02  1801  	zst->errors[error_batch_idx] = -EINVAL;
c1252ac91d6a6a Kanchana P Sridhar 2024-11-02  1802  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


