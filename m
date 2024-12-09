Return-Path: <linux-kernel+bounces-436832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D879C9E8B71
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9EF1885A0F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 06:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2E72144D5;
	Mon,  9 Dec 2024 06:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r++wOaHA"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCD117C219
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 06:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733725256; cv=none; b=JSD8DSvcOZ8S3HYDVlCRShn1YKnt8TssATSVp3/r/tnp5KIudsGX7bz2JnoLaL4jseHFeSlKFhPZB14LKQCLNh2xRvjyiM0A4p5edLA4zAi/s6FvTCINv0eHyGCLU8zRWOcyCXw+4h5mKn/njR04Sp+ttEoYI8ghjTUa4hRwams=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733725256; c=relaxed/simple;
	bh=GpYynn+iuoP7VK0sSmVZgMS2aLLGAqJHZ9w4DCaAhoc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XD0aWKRn141/4sHYEy8/W8jvtezmXlygoryc3M0w6Rg9w8IkZNT9Q8vq94BSKxeiVLK2VFVliwRLvwFPJZg/i/VfgZdwItpWwYQ3BxLCA9R+jqU/CsSeAcnGao7OfH9IfwArYotuZ87RO/G7DY3uoDI3GtWpl+DKpAUe2dinknA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r++wOaHA; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434f80457a4so2956925e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 22:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733725251; x=1734330051; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7jJkWSBwztPHLc8SnWGYUODZCuX3iLbpG5bezmk5dRU=;
        b=r++wOaHANj7sm/hOCjaBlqKZhiT6KNYHKAgPbyQ2CQ7gGbAaNFKLUpxvzTAqqQM9Yd
         wVJr7PMyDbQ/1HK9ztAm/IIYsmvrZe/SjyaO6gYVhuYJIi/4e/UH8HEWUPwClc1FMvF0
         uvdKFU+7K46v+IYQ4JkXhTxGOiO9lFNJva6rqkxd4RSwZaB2ASiwpxQ8vvKznpf3I5oh
         XuWTSQX32reIYtJX+Eigfqvua8sRbTHZfCJcE0ZffNd70OpA40mvbuKMArC/oR9esxHP
         SujdkBf08n+GGGaPgYSdROtlCxXSeKq9qx07d45MXUdF/NFpDgyX5BLDByjlHJW6Z2eT
         zNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733725251; x=1734330051;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7jJkWSBwztPHLc8SnWGYUODZCuX3iLbpG5bezmk5dRU=;
        b=J07U1oUq+5ZY2JmusrW1fheMqDw/zPqGfm+pbg8lHqz6eCReGdeNb/F5J2jIZwmLGj
         nt2AB+YMGsNWd5JPHkXOYtVVzMFw2OE43ghpVL/xHikMTJ6iXlCsXA+4GlXyE/oymv1y
         JFH6w9aWuifD1z7OgioD+25mJzsw9DuMnen2Z9QPaRUiwStfaSPZTLr7rc8XR7OBQKas
         8oooS7GFtwaEbRDtabRqHyTBj+G7z3s/Pcqd/KSpzqKJJGJU/ElDhRq5AuM2pH+MZeq6
         F4gjVNojJ1q+EDJD2ru4PSL0pN/2MJ1zXfnSO0f332XwjG6jE3XIPkILIvPTUkURf6L+
         hjpA==
X-Forwarded-Encrypted: i=1; AJvYcCWuHGQQTNFLsJ4J0qiw9XREqY+Oj3gLmlflAcK+Q2Jyk1HwRhZRECbTKtGxexvHCXZ8hzevUW2czx/3gjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBmwzjswSl7V1dky2RrxSye+srWAXYrJmpgD/cAtm/tAu717Pk
	huljHDCfp1+Trp3axxe1of6u7s5Sgr1tvsu2YYEnik+pwBaglRl/X9xo5wORrlbNAs50U8Zq61r
	Z
X-Gm-Gg: ASbGncsQzMY4JnXsYJgk3o+l6kSmxFXitkVnRNmfgxqVNLsyw29f9qbyPjh3VtliyMg
	Es9B04UQZxFMOytuoetyiJCL3poe+iAcnm4K8zwBjqVUIzesfWfq1Bco1aa6c2wA5uUEZbji+LQ
	ubT610x3gLpKpML4KikRQ+1p2tE8hCRCoFUeGRQ7EVo2tk3vheIAsfj6n/hQPOQ0aNvxnLncUQC
	omZJ2D5550KxZq4uEQyoMaHFLTVecPQQsGvefnAxjfnR5r+AZkFye8=
X-Google-Smtp-Source: AGHT+IG7w4/4RKpd6Mi9/6A3a434elfjyRGJzlFv7WKBL0P6cJmpxGL1+tFZA6BscihXHw4JGki09A==
X-Received: by 2002:a05:6000:2ac:b0:385:f7e5:de88 with SMTP id ffacd0b85a97d-3862a7722d0mr7780821f8f.3.1733725251254;
        Sun, 08 Dec 2024 22:20:51 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862190989fsm12360852f8f.73.2024.12.08.22.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 22:20:50 -0800 (PST)
Date: Mon, 9 Dec 2024 09:20:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Cosmin Ratiu <cratiu@nvidia.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c:173
 mlx5_fc_stats_query_all_counters() error: uninitialized symbol
 'bulk_query_time'.
Message-ID: <1ce44712-7b81-4ace-aae8-7284974b11f1@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b5f217084ab3ddd4bdd03cd437f8e3b7e2d1f5b6
commit: 918af0219a4d6a89cf02839005ede24e91f13bf6 net/mlx5: hw counters: Replace IDR+lists with xarray
config: openrisc-randconfig-r072-20241206 (https://download.01.org/0day-ci/archive/20241207/202412071312.oNFnyT9f-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202412071312.oNFnyT9f-lkp@intel.com/

smatch warnings:
drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c:173 mlx5_fc_stats_query_all_counters() error: uninitialized symbol 'bulk_query_time'.
drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c:174 mlx5_fc_stats_query_all_counters() error: uninitialized symbol 'bulk_base_id'.

vim +/bulk_query_time +173 drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c

918af0219a4d6a8 Cosmin Ratiu 2024-10-01  138  static void mlx5_fc_stats_query_all_counters(struct mlx5_core_dev *dev)
a351a1b03bf169f Amir Vadai   2016-07-14  139  {
5acd957a986c167 Cosmin Ratiu 2024-10-01  140  	struct mlx5_fc_stats *fc_stats = dev->priv.fc_stats;
918af0219a4d6a8 Cosmin Ratiu 2024-10-01  141  	u32 bulk_len = fc_stats->bulk_query_len;
918af0219a4d6a8 Cosmin Ratiu 2024-10-01  142  	XA_STATE(xas, &fc_stats->counters, 0);
6f06e04b67baa1c Gavi Teitz   2019-07-29  143  	u32 *data = fc_stats->bulk_query_out;
918af0219a4d6a8 Cosmin Ratiu 2024-10-01  144  	struct mlx5_fc *counter;
918af0219a4d6a8 Cosmin Ratiu 2024-10-01  145  	u32 last_bulk_id = 0;
918af0219a4d6a8 Cosmin Ratiu 2024-10-01  146  	u64 bulk_query_time;
6f06e04b67baa1c Gavi Teitz   2019-07-29  147  	u32 bulk_base_id;
a351a1b03bf169f Amir Vadai   2016-07-14  148  	int err;
a8ffcc741acb3c7 Rabie Loulou 2017-07-09  149  
918af0219a4d6a8 Cosmin Ratiu 2024-10-01  150  	xas_lock(&xas);
918af0219a4d6a8 Cosmin Ratiu 2024-10-01  151  	xas_for_each(&xas, counter, U32_MAX) {
918af0219a4d6a8 Cosmin Ratiu 2024-10-01  152  		if (xas_retry(&xas, counter))
918af0219a4d6a8 Cosmin Ratiu 2024-10-01  153  			continue;
918af0219a4d6a8 Cosmin Ratiu 2024-10-01  154  		if (unlikely(counter->id >= last_bulk_id)) {
918af0219a4d6a8 Cosmin Ratiu 2024-10-01  155  			/* Start new bulk query. */
918af0219a4d6a8 Cosmin Ratiu 2024-10-01  156  			/* First id must be aligned to 4 when using bulk query. */
6f06e04b67baa1c Gavi Teitz   2019-07-29  157  			bulk_base_id = counter->id & ~0x3;
                                                                ^^^^^^^^^^^^

918af0219a4d6a8 Cosmin Ratiu 2024-10-01  158  			last_bulk_id = bulk_base_id + bulk_len;
918af0219a4d6a8 Cosmin Ratiu 2024-10-01  159  			/* The lock is released while querying the hw and reacquired after. */
918af0219a4d6a8 Cosmin Ratiu 2024-10-01  160  			xas_unlock(&xas);
918af0219a4d6a8 Cosmin Ratiu 2024-10-01  161  			/* The same id needs to be processed again in the next loop iteration. */
918af0219a4d6a8 Cosmin Ratiu 2024-10-01  162  			xas_reset(&xas);
918af0219a4d6a8 Cosmin Ratiu 2024-10-01  163  			bulk_query_time = jiffies;

bulk_query_time is only initialized on this path which is marked as unlikely()
and not initialized on the else statement.

918af0219a4d6a8 Cosmin Ratiu 2024-10-01  164  			err = mlx5_cmd_fc_bulk_query(dev, bulk_base_id, bulk_len, data);
a351a1b03bf169f Amir Vadai   2016-07-14  165  			if (err) {
a351a1b03bf169f Amir Vadai   2016-07-14  166  				mlx5_core_err(dev, "Error doing bulk query: %d\n", err);
6f06e04b67baa1c Gavi Teitz   2019-07-29  167  				return;
a351a1b03bf169f Amir Vadai   2016-07-14  168  			}
918af0219a4d6a8 Cosmin Ratiu 2024-10-01  169  			xas_lock(&xas);
918af0219a4d6a8 Cosmin Ratiu 2024-10-01  170  			continue;
6f06e04b67baa1c Gavi Teitz   2019-07-29  171  		}
918af0219a4d6a8 Cosmin Ratiu 2024-10-01  172  		/* Do not update counters added after bulk query was started. */
918af0219a4d6a8 Cosmin Ratiu 2024-10-01 @173  		if (time_after64(bulk_query_time, counter->cache.lastuse))
                                                                         ^^^^^^^^^^^^^^^

918af0219a4d6a8 Cosmin Ratiu 2024-10-01 @174  			update_counter_cache(counter->id - bulk_base_id, data,
                                                                                                   ^^^^^^^^^^^^

918af0219a4d6a8 Cosmin Ratiu 2024-10-01  175  					     &counter->cache);
a351a1b03bf169f Amir Vadai   2016-07-14  176  	}
918af0219a4d6a8 Cosmin Ratiu 2024-10-01  177  	xas_unlock(&xas);
a351a1b03bf169f Amir Vadai   2016-07-14  178  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


