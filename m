Return-Path: <linux-kernel+bounces-394300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A40179BAD10
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 08:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087061F21D10
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 07:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2138B192B91;
	Mon,  4 Nov 2024 07:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lVYQnxCi"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C4D23AB
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 07:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730705020; cv=none; b=iXLNRFy8mCv//q972cOEFkMXf51tNABMM3QEKOLeJXiPTCG8dN2jxS6LeYFAYhB7yrlLw5g5fqcKqb2UqzzgjAAW/JHicMEH80895VX5rFWRS7arshxXHrYAMx/bYoD9s0FfmKPuzC0H2FSJ+IW69L2mxdREEFNd1zui/uk6UA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730705020; c=relaxed/simple;
	bh=BzZ86BxrPlQC9+39mi52+0OlxseZ8YqyYhJ2yPkZFts=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MVdxFqz1Rw5DAwRYlY6dBK3X9E20OVWxuvhrqVKTcm5KA5py7Kw7JpijS7RtYRZGBHjg+7k5X3ak5qAXa19wBzniK35ujoh1AD3SbEyapHbAUHfJ2maQITGkAbntmxigpHMW1TBv9dBGXzz4KNwz5g+w7QhznBUF/zrI9q3wom4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lVYQnxCi; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so32911625e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 23:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730705017; x=1731309817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jiS8XdRJ5mjLBZvVPPJ1C4Js2HB6fwq261ppgxWkFZU=;
        b=lVYQnxCiaCiIE+702FWK5E6ZVbgOSWHTppLfk82gvR84bq4EO+oFz6XaQ0MuYQTLNw
         StYzoRmW3iKix715z88zhO4QMc6t+fI1Vypvq9wqE950cECqtxLVpbYRMo2TkSUWSYqO
         85RkrP82NcT4bDwJ/TRhJ+dxUviDySkyh2pWb5MtC1uRLzQKAPTdr39E5yr814eU8Eq4
         rnBE92O+4NBQTbUZ1njSg380x76NcAHW0/TbXNgnDr1IYU5w7kOwS/hC8ToAuLKiEgoB
         q0AuOl8V7XHQwcjnjXa2xLc6WKM4JnncMkbRuV31B7cErxkniQcLGCbLMt3G963F6Rw0
         qQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730705017; x=1731309817;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jiS8XdRJ5mjLBZvVPPJ1C4Js2HB6fwq261ppgxWkFZU=;
        b=n7HFPUsJoljUARRJTpXxIIMRcYyKOuWCxKR+5YJYLlmPPvPuzXLLMFhjUh8tpaF0Ks
         +XvGBF3UGncGlmwsCCLVV6x/ndNR8s6CdusxM5oQzF+hH2fI2UJ2LaFhrmVIolNEJpEo
         MUYkMhftq6K8wQltDLvwtpUso98SsN7o0dzg0qCXwNqobPWDhDe8KE4NPlWLxUx9YE/1
         /FG8C480nuyMJ3koGpF6wueQSgqwrSnsPNSF/nP4bjywiiJD5TyoIo3OqLJkwmpRQyeU
         jPUA0H6E1G/5GAMtkBGm/jtiUcjApcqqFUxxUS9VJE7UMjxbik5fAHeKqcXv+ndBDRRg
         pXtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEsAlN3nBbIoFO2qo6AAjbwfJ9+PN6r/z4XV6MKnyS5+RGUTfWUPGSDdk9sJVSHdWNtZhlvFzc5l+bna4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF8Ii5hmpZ2R1fdsDdflu+vSgIY33uxxdJRm/xKcTGaoIaAyz0
	PsEovlNW0WgEo/t9/t12QfPdKt458SwdcQ0MUHTJCzr5NWKmzn54V9hFm+O93mM=
X-Google-Smtp-Source: AGHT+IH40kTx91Wk2I+uwvpntqh9B6wAV6h1+3zOozojDZ54UMaVhhfVF5oyrYpKHhmXEoEXhdGeTQ==
X-Received: by 2002:a05:600c:3507:b0:431:4e3f:9dee with SMTP id 5b1f17b1804b1-4327b6f46d3mr123743255e9.4.1730705017060;
        Sun, 03 Nov 2024 23:23:37 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5abfefsm144395155e9.4.2024.11.03.23.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 23:23:36 -0800 (PST)
Date: Mon, 4 Nov 2024 10:23:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, mrpre <mrpre@163.com>,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	martin.lau@kernel.org, edumazet@google.com, jakub@cloudflare.com,
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, mrpre <mrpre@163.com>
Subject: Re: [PATCH v2 1/2] bpf: Introduce cpu affinity for sockmap
Message-ID: <53444aeb-aa22-4076-95dd-f079861567c9@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101161624.568527-2-mrpre@163.com>

Hi mrpre,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/mrpre/bpf-Introduce-cpu-affinity-for-sockmap/20241102-001844
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20241101161624.568527-2-mrpre%40163.com
patch subject: [PATCH v2 1/2] bpf: Introduce cpu affinity for sockmap
config: i386-randconfig-141-20241102 (https://download.01.org/0day-ci/archive/20241103/202411030036.PSKG1pW3-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202411030036.PSKG1pW3-lkp@intel.com/

smatch warnings:
net/core/sock_map.c:511 sock_map_update_common() warn: variable dereferenced before check 'psock' (see line 492)

vim +/psock +511 net/core/sock_map.c

604326b41a6fb9 Daniel Borkmann 2018-10-13  467  static int sock_map_update_common(struct bpf_map *map, u32 idx,
ffed654afa8dc1 mrpre           2024-11-02  468  				  struct sock *sk, u64 flags, s32 target_cpu)
604326b41a6fb9 Daniel Borkmann 2018-10-13  469  {
604326b41a6fb9 Daniel Borkmann 2018-10-13  470  	struct bpf_stab *stab = container_of(map, struct bpf_stab, map);
604326b41a6fb9 Daniel Borkmann 2018-10-13  471  	struct sk_psock_link *link;
604326b41a6fb9 Daniel Borkmann 2018-10-13  472  	struct sk_psock *psock;
604326b41a6fb9 Daniel Borkmann 2018-10-13  473  	struct sock *osk;
604326b41a6fb9 Daniel Borkmann 2018-10-13  474  	int ret;
604326b41a6fb9 Daniel Borkmann 2018-10-13  475  
604326b41a6fb9 Daniel Borkmann 2018-10-13  476  	WARN_ON_ONCE(!rcu_read_lock_held());
604326b41a6fb9 Daniel Borkmann 2018-10-13  477  	if (unlikely(flags > BPF_EXIST))
604326b41a6fb9 Daniel Borkmann 2018-10-13  478  		return -EINVAL;
604326b41a6fb9 Daniel Borkmann 2018-10-13  479  	if (unlikely(idx >= map->max_entries))
604326b41a6fb9 Daniel Borkmann 2018-10-13  480  		return -E2BIG;
604326b41a6fb9 Daniel Borkmann 2018-10-13  481  
604326b41a6fb9 Daniel Borkmann 2018-10-13  482  	link = sk_psock_init_link();
604326b41a6fb9 Daniel Borkmann 2018-10-13  483  	if (!link)
604326b41a6fb9 Daniel Borkmann 2018-10-13  484  		return -ENOMEM;
604326b41a6fb9 Daniel Borkmann 2018-10-13  485  
2004fdbd8a2b56 Cong Wang       2021-03-30  486  	ret = sock_map_link(map, sk);
604326b41a6fb9 Daniel Borkmann 2018-10-13  487  	if (ret < 0)
604326b41a6fb9 Daniel Borkmann 2018-10-13  488  		goto out_free;
604326b41a6fb9 Daniel Borkmann 2018-10-13  489  
604326b41a6fb9 Daniel Borkmann 2018-10-13  490  	psock = sk_psock(sk);
604326b41a6fb9 Daniel Borkmann 2018-10-13  491  	WARN_ON_ONCE(!psock);
ffed654afa8dc1 mrpre           2024-11-02 @492  	psock->target_cpu = target_cpu;
                                                        ^^^^^^^^^^^^^^^^^
The patch adds an unchecked dereference

35d2b7ffffc1d9 John Fastabend  2023-08-29  493  	spin_lock_bh(&stab->lock);
604326b41a6fb9 Daniel Borkmann 2018-10-13  494  	osk = stab->sks[idx];
604326b41a6fb9 Daniel Borkmann 2018-10-13  495  	if (osk && flags == BPF_NOEXIST) {
604326b41a6fb9 Daniel Borkmann 2018-10-13  496  		ret = -EEXIST;
604326b41a6fb9 Daniel Borkmann 2018-10-13  497  		goto out_unlock;
604326b41a6fb9 Daniel Borkmann 2018-10-13  498  	} else if (!osk && flags == BPF_EXIST) {
604326b41a6fb9 Daniel Borkmann 2018-10-13  499  		ret = -ENOENT;
604326b41a6fb9 Daniel Borkmann 2018-10-13  500  		goto out_unlock;
604326b41a6fb9 Daniel Borkmann 2018-10-13  501  	}
604326b41a6fb9 Daniel Borkmann 2018-10-13  502  
604326b41a6fb9 Daniel Borkmann 2018-10-13  503  	sock_map_add_link(psock, link, map, &stab->sks[idx]);

This also dereferences psock btw.

604326b41a6fb9 Daniel Borkmann 2018-10-13  504  	stab->sks[idx] = sk;
604326b41a6fb9 Daniel Borkmann 2018-10-13  505  	if (osk)
604326b41a6fb9 Daniel Borkmann 2018-10-13  506  		sock_map_unref(osk, &stab->sks[idx]);
35d2b7ffffc1d9 John Fastabend  2023-08-29  507  	spin_unlock_bh(&stab->lock);
604326b41a6fb9 Daniel Borkmann 2018-10-13  508  	return 0;
604326b41a6fb9 Daniel Borkmann 2018-10-13  509  out_unlock:
35d2b7ffffc1d9 John Fastabend  2023-08-29  510  	spin_unlock_bh(&stab->lock);
604326b41a6fb9 Daniel Borkmann 2018-10-13 @511  	if (psock)
                                                            ^^^^^
Probably after 6 years of not triggering the WARN_ON_ONCE() on line 490, we can
remove this check?

604326b41a6fb9 Daniel Borkmann 2018-10-13  512  		sk_psock_put(sk, psock);
604326b41a6fb9 Daniel Borkmann 2018-10-13  513  out_free:
604326b41a6fb9 Daniel Borkmann 2018-10-13  514  	sk_psock_free_link(link);
604326b41a6fb9 Daniel Borkmann 2018-10-13  515  	return ret;
604326b41a6fb9 Daniel Borkmann 2018-10-13  516  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


