Return-Path: <linux-kernel+bounces-176851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860CF8C35F4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 12:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775E41C208F7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 10:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01551CAAF;
	Sun, 12 May 2024 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnqZhibz"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871D01C683
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715509592; cv=none; b=oowQq1Yf1N1tPoFKZdcFqFUct06qx15x3z8VN/7vACpylyddyenej9+R85wmSyewz+t5+gP5ZuHKsNQwwshAQyfYvqmgIx3p/T+lJ6ajFg8JLpmHtSApglTtgDF5Ii24M29Ds8/IZZcLVYqZg3yJZ3/qubcOY6OyEyyk6M6qduI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715509592; c=relaxed/simple;
	bh=+9pJXpQgPt2lHwMONUOemo2q9+iF6WTtWDicG6lMru4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHvMUXB4k4Ocl5vsjRah5t63uf9jqbtiVADvEspfIDFoiEcsyLQqWWgLuzOe3rOnUSDl1Ywo70FSKYoNbUcmL6M1iWlWZ75mbW/s9GLz/JkA6FEGbEWtR7cERBTnv0YMmXJb471lfH/DfnO/u9K/XuDoLeUjY8CXaqZXgndqxsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnqZhibz; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso2851813a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 03:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715509591; x=1716114391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lr1WXbRSQZLTTHa7cFPRGYFpMRh1Ph2AIduJlL752P8=;
        b=AnqZhibzX73/H3C57Ki52pkkY7Jd/4UlPm5fe5XGYfAOCDUxzWlt8AFEHpm65ZFZPU
         rzGHDH+c+TRcC4GkJFbtIVTfOiIC20cBl69z/IwB/rP34lMVf8trlmpa4Au4ruCj9ih2
         cM12xUsntOQa8kVMuhUJoeu2EMGWZKfdfOKYNK0akylANloSnRT+uZsQ0lia26BkHH0q
         GPOSfJk/RTNkDSm7L5UKE59CGvbZBKkbT6upaRN7/hUoso/MKqXjjlUGYzykfQ+SuTpY
         sSVwWZMgFxa9hKq0vAEoxfQh8fseRX46HsEG/nB/aaSevkRzAJ2CV6We7dUUvJsdVkKV
         zxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715509591; x=1716114391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lr1WXbRSQZLTTHa7cFPRGYFpMRh1Ph2AIduJlL752P8=;
        b=DgQisWvemGK8wxFzA1k99Bn6w5RjpnXCXbdK4z1jescCmuSjvwZqyCRH0jZOXoQ5+k
         PnSkzJyzpL7azoH5BHVc5HtQBGy/Ne8mwmYioGkHq8v6CaubIeo+o71haWD1Iof8zBPN
         8HzT8tWd1yh/0LAhO0Xeqp1hPoDIzcZqX3ILjnYhoGqJlaYugjP/Uzj3xg506hyBMvbf
         NW2WW/I1/zm/tdT5Q+XyqPT00DoZzG0wxFOV4iL293Lqm0hPSb1gWlJTN5i8Crb4G4Gl
         VBKBupfMa/vkUZbeWfEyvCuvcLdXdr4XD2b5H8xos/o1dVBWHlWiuNjKLxw+DZbFUOfC
         0Rnw==
X-Forwarded-Encrypted: i=1; AJvYcCWh32tZm12V331fOHMikcyyz7ytAmzSxj9u0DZE+0awGLG7Yzb4112LKI6+TQzLninT47HbkDB2iRVUU3T0ysXQtrx0UisviiPLP94i
X-Gm-Message-State: AOJu0Yyr/pO2sA6qr1tZPzKi+d0arTjGX5FxhUH4rNvfw0a+K55gn2Tj
	bGB9LpYZkP/RIw1SAwHupApc5QI+iTMWeGuPUNpiEjxJYPpTet6H
X-Google-Smtp-Source: AGHT+IEFgljEemnXmHYaYEZNRwlIHszI6LnaACziDBUoVD9+Ku7bb0vKsVX72jtPhwQgQBbzm6bgrQ==
X-Received: by 2002:a17:902:b949:b0:1e4:48e7:3dab with SMTP id d9443c01a7336-1ef43e269ddmr91828255ad.38.1715509590471;
        Sun, 12 May 2024 03:26:30 -0700 (PDT)
Received: from five231003 ([2409:40f0:1038:c113:806e:6d6a:367e:63ce])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf32b4dsm61454005ad.137.2024.05.12.03.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 03:26:30 -0700 (PDT)
Date: Sun, 12 May 2024 15:56:22 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] soc: ti: knav_qmss_queue: do device_node auto cleanup
Message-ID: <ZkCZTv0Gci3xxKtw@five231003>
References: <20240510071432.62913-3-five231003@gmail.com>
 <202405111846.3m9z398l-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202405111846.3m9z398l-lkp@intel.com>

On Sat, May 11, 2024 at 06:12:39PM +0800, kernel test robot wrote:
> Hi Kousik,
> 
> kernel test robot noticed the following build errors:
> 

[...]

> All errors (new ones prefixed by >>):
> 
> >> drivers/soc/ti/knav_qmss_queue.c:1853:3: error: cannot jump from this goto statement to its label
>                    goto err;
>                    ^
>    drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
>            struct device_node *regions __free(device_node) =
>                                ^
>    drivers/soc/ti/knav_qmss_queue.c:1840:3: error: cannot jump from this goto statement to its label
>                    goto err;
>                    ^
>    drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
>            struct device_node *regions __free(device_node) =
>                                ^
>    drivers/soc/ti/knav_qmss_queue.c:1835:3: error: cannot jump from this goto statement to its label
>                    goto err;
>                    ^
>    drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
>            struct device_node *regions __free(device_node) =
>                                ^
>    drivers/soc/ti/knav_qmss_queue.c:1831:3: error: cannot jump from this goto statement to its label
>                    goto err;
>                    ^
>    drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
>            struct device_node *regions __free(device_node) =
>                                ^
>    drivers/soc/ti/knav_qmss_queue.c:1822:4: error: cannot jump from this goto statement to its label
>                            goto err;
>                            ^
>    drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
>            struct device_node *regions __free(device_node) =
>                                ^
>    drivers/soc/ti/knav_qmss_queue.c:1826:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
>            struct device_node *queue_pools __free(device_node) =
>                                ^
>    drivers/soc/ti/knav_qmss_queue.c:1818:4: error: cannot jump from this goto statement to its label
>                            goto err;
>                            ^
>    drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
>            struct device_node *regions __free(device_node) =
>                                ^
>    drivers/soc/ti/knav_qmss_queue.c:1826:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
>            struct device_node *queue_pools __free(device_node) =
>                                ^
>    drivers/soc/ti/knav_qmss_queue.c:1810:3: error: cannot jump from this goto statement to its label
>                    goto err;
>                    ^
>    drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
>            struct device_node *regions __free(device_node) =
>                                ^
>    drivers/soc/ti/knav_qmss_queue.c:1826:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
>            struct device_node *queue_pools __free(device_node) =
>                                ^
>    drivers/soc/ti/knav_qmss_queue.c:1813:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
>            struct device_node *pdsps __free(device_node) =
>                                ^
>    drivers/soc/ti/knav_qmss_queue.c:1806:3: error: cannot jump from this goto statement to its label
>                    goto err;
>                    ^
>    drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
>            struct device_node *regions __free(device_node) =
>                                ^
>    drivers/soc/ti/knav_qmss_queue.c:1826:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
>            struct device_node *queue_pools __free(device_node) =
>                                ^
>    drivers/soc/ti/knav_qmss_queue.c:1813:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
>            struct device_node *pdsps __free(device_node) =
>                                ^
>    drivers/soc/ti/knav_qmss_queue.c:1795:3: error: cannot jump from this goto statement to its label
>                    goto err;
>                    ^
>    drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
>            struct device_node *regions __free(device_node) =
>                                ^
>    drivers/soc/ti/knav_qmss_queue.c:1826:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
>            struct device_node *queue_pools __free(device_node) =
>                                ^
>    drivers/soc/ti/knav_qmss_queue.c:1813:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
>            struct device_node *pdsps __free(device_node) =
>                                ^
>    drivers/soc/ti/knav_qmss_queue.c:1801:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
>            struct device_node *qmgrs __free(device_node) =
>                                ^
>    9 errors generated.

Seems like gcc didn't catch this when I compiled locally.

Normally, this would be fixed if we placed braces around the individual
initialization blocks, that is, say

	{
		struct device_node *qmgrs __free(device_node) =
			of_get_child_by_name(node, "qmgrs");
		...
	}


That would make the code look a lot more dirty though and is purely
unnecessary.  So I'd say I'd drop this patch and do a v2 with the
remaining two patches.  Thoughts?

There's also some stuff with classes but that too is not really worth
doing because the code will end up looking very ugly.

Thanks

