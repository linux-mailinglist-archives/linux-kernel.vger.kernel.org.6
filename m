Return-Path: <linux-kernel+bounces-201773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA018FC300
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1080B265FB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 05:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B406613AD28;
	Wed,  5 Jun 2024 05:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GwZS77FN"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52FF8830
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 05:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717565076; cv=none; b=UbxJpPm96egZWxEQqez+XeDGEMhf2OhM0oLpYJwp6gS9q1aXKc2QF9Q79gCFRazahGBuD+d1xORZFfS3qR6yiL7MR375lPlowG0C7kqQcQgF2NhHsxglyql0SaTcofMKN5vYsxaPVFvNG2wQFvjgRxZHgtDRJ1R/qZhT+tk2UsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717565076; c=relaxed/simple;
	bh=poqzOnjxKvuZhOVVP2vCDTAj8Ttrx5WnbLuYUT/fyCk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Vezu3vwhcsiKHJCsHGcJiudr5sE4ezURpfMz0i5Bf0WLaQ+a/nWNXTQEaIDXN3CGysszDzqS1Ch/kbvS0UXh5Nu0LdXdBtJyRF62X0qFnkDF82W29rgUDGhV0JKuZIkoFTWfYdPaGxeSGUO6cJm6trZJO6Mb9b/qzUz8RiTVGdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GwZS77FN; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57a30b3a6cbso2237713a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 22:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717565073; x=1718169873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ieXpxhBBWSSEFA3ad/RzGLUGCP/3ui0qmyCSm+SXO/M=;
        b=GwZS77FNZKlEmv4lwaGnoOL2vt6tO+Yx72ZL7a2dG9Xvb6qJ3jCiRtCpe7A5eAdbyS
         f8PEMyw1RdLIyjdsholI0BFGd9arQSD+HrcrJKFR6+EUuEtRAyyhNmonLrB/WIkREIj9
         PwPx6Yjxk5uR1GuxjO0rFOW/t4wZVeUd2vqBOf8ZPbuz3iA73rtyW+u+b1rGToGgjoL7
         FTKgPLnmPPL9I3Y/WjtSo8j4OOx2+ZXKbzAMOtxNQWlT1YM9cmdDTh/nSejpfJxjoU6C
         Yc5nWgrqATGyWKxE0yJ1EGzAdZumlaE3zMOCtxx0A6ciA61TquxF0bo0WqUEKgbu/jwK
         +PMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717565073; x=1718169873;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ieXpxhBBWSSEFA3ad/RzGLUGCP/3ui0qmyCSm+SXO/M=;
        b=wJ3sP5qYw7FRiiwuf8hmCxQDvapRNOTj6djBs/2CZ/NaQWulXQOGSDQfgMEakQahtW
         74IcrcrkSja+sUubsbh5m34zEXW6YXGjNZHdwK6EcSLpPmB40SZgcYFu9MaaByckeUAg
         434etpj49hEEE8A5ZDJ16olC1vm2ZejHEUxiKlAtqHBZvJFjszrUQ5IsLqNJdSkIA7AG
         Hi/yMqSDVdLFDJ/bmPmGyoLANX3t7Gw4FkcslZjazu39bdsNWM8Vt0Kxx2CrkjkQAukC
         ZenzOEfSlzIW6j6QInITB/PNYHTBATcgvtiEUpndlBCJnqQDrrebz3Z57YKxwsZBUary
         hhIg==
X-Forwarded-Encrypted: i=1; AJvYcCWwFhjzzEg6mrFXLg3od3ou7Ej3SDkjKciHwkLtOnxD4cE0NCcHPV7/RiFcpU/CbtSVQM8ukevHgW4ckGg+wpvD4zzQEwRyIXvR1R1Y
X-Gm-Message-State: AOJu0YzmjbY2qC/gRWPJn1aIlKJmDJQwtSqHgcDu73m3ndaSonEuWRhe
	/BmcekvUq3BGYwPjA8R/MRATVfRy+GSd8n3j8MgaCp/W1+lOQSPeDFB6a+mSTWffMiHZDzH5iwh
	w
X-Google-Smtp-Source: AGHT+IGblo21HwWBJITrF2Lq0wtl7QLdAO0pjSkQJ1yY4jTCAGyNBZoCeBT+Grw2RfWlVYwmCDGV8A==
X-Received: by 2002:a50:d6dd:0:b0:572:6846:b899 with SMTP id 4fb4d7f45d1cf-57a8bccb341mr692996a12.41.1717565072709;
        Tue, 04 Jun 2024 22:24:32 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31c6d301sm8526348a12.76.2024.06.04.22.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 22:24:32 -0700 (PDT)
Date: Wed, 5 Jun 2024 08:24:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Xiu Jianfeng <xiujianfeng@huawei.com>,
	akpm@linux-foundation.org, muchun.song@linux.dev
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 2/3] mm/hugetlb_cgroup: prepare cftypes based on
 template
Message-ID: <87bca9ca-0c3e-449a-b121-eee7b84dc2ed@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603120506.1837322-3-xiujianfeng@huawei.com>

Hi Xiu,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Xiu-Jianfeng/mm-hugetlb_cgroup-identify-the-legacy-using-cgroup_subsys_on_dfl/20240603-201513
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240603120506.1837322-3-xiujianfeng%40huawei.com
patch subject: [PATCH -next 2/3] mm/hugetlb_cgroup: prepare cftypes based on template
config: i386-randconfig-r071-20240604 (https://download.01.org/0day-ci/archive/20240605/202406050210.OWthxCFt-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202406050210.OWthxCFt-lkp@intel.com/

smatch warnings:
mm/hugetlb_cgroup.c:828 hugetlb_cgroup_cfttypes_init() warn: this array is probably non-NULL. 'tmpl->name'

vim +828 mm/hugetlb_cgroup.c

66bcc9ace99241 Xiu Jianfeng 2024-06-03  815  static void __init
66bcc9ace99241 Xiu Jianfeng 2024-06-03  816  hugetlb_cgroup_cfttypes_init(struct hstate *h, struct cftype *cft,
66bcc9ace99241 Xiu Jianfeng 2024-06-03  817  			     struct cftype *tmpl, int tmpl_size)
66bcc9ace99241 Xiu Jianfeng 2024-06-03  818  {
66bcc9ace99241 Xiu Jianfeng 2024-06-03  819  	char buf[32];
66bcc9ace99241 Xiu Jianfeng 2024-06-03  820  	int i, idx = hstate_index(h);
66bcc9ace99241 Xiu Jianfeng 2024-06-03  821  
66bcc9ace99241 Xiu Jianfeng 2024-06-03  822  	/* format the size */
66bcc9ace99241 Xiu Jianfeng 2024-06-03  823  	mem_fmt(buf, sizeof(buf), huge_page_size(h));
66bcc9ace99241 Xiu Jianfeng 2024-06-03  824  
66bcc9ace99241 Xiu Jianfeng 2024-06-03  825  	for (i = 0; i < tmpl_size; cft++, tmpl++, i++) {
66bcc9ace99241 Xiu Jianfeng 2024-06-03  826  		*cft = *tmpl;
66bcc9ace99241 Xiu Jianfeng 2024-06-03  827  		/* rebuild the name */
66bcc9ace99241 Xiu Jianfeng 2024-06-03 @828  		if (tmpl->name)
66bcc9ace99241 Xiu Jianfeng 2024-06-03  829  			snprintf(cft->name, MAX_CFTYPE_NAME, "%s.%s", buf, tmpl->name);

tmpl->name is an array so it's non-NULL.  Just do the snprintf().  No
need for the if statement.

66bcc9ace99241 Xiu Jianfeng 2024-06-03  830  		/* rebuild the private */
66bcc9ace99241 Xiu Jianfeng 2024-06-03  831  		if (tmpl->private)
66bcc9ace99241 Xiu Jianfeng 2024-06-03  832  			cft->private = MEMFILE_PRIVATE(idx, tmpl->private);
66bcc9ace99241 Xiu Jianfeng 2024-06-03  833  		/* rebuild the file_offset */
66bcc9ace99241 Xiu Jianfeng 2024-06-03  834  		if (tmpl->file_offset) {
66bcc9ace99241 Xiu Jianfeng 2024-06-03  835  			unsigned int offset = tmpl->file_offset;
66bcc9ace99241 Xiu Jianfeng 2024-06-03  836  
66bcc9ace99241 Xiu Jianfeng 2024-06-03  837  			cft->file_offset = MEMFILE_OFFSET0(offset) +
66bcc9ace99241 Xiu Jianfeng 2024-06-03  838  					   MEMFILE_FIELD_SIZE(offset) * idx;
66bcc9ace99241 Xiu Jianfeng 2024-06-03  839  		}
66bcc9ace99241 Xiu Jianfeng 2024-06-03  840  	}
66bcc9ace99241 Xiu Jianfeng 2024-06-03  841  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


