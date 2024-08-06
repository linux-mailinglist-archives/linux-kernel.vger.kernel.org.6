Return-Path: <linux-kernel+bounces-276994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BA8949AD5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ECEC1F21570
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7493817A5A0;
	Tue,  6 Aug 2024 22:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHAf2l1F"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DA217A591;
	Tue,  6 Aug 2024 22:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981763; cv=none; b=Ls1ULLDD62u6yDUxnofEgijghIGaRUxIFoh6+Av2xifymBWX220qEjC+7lWSQVgx05yUd3AAyqA/RUmqMM23yNwi7fPCqdmzEcZGLdNoTDE6hjCSOWof1QOYYdhY07zB80bEWBCakMl+fQb0MxBfrTHJmPpBEX1xIX2kCSuaY08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981763; c=relaxed/simple;
	bh=aR1W/c9RP1fIj6vHqwGqd/uGjv/1lmu03CBJ0wO/Hw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2pGL+CsGH/hIuFyq5bRX9vYOXi3tDzzLCs0S3gZwu0TU4Vebl/B1I+egxI7gmr3ZQsN1vYl+jvKcowVvr3HywN5NJwTbqLZhe/+xEdnlszanLgVZLBrWBWgkiBEMhrnC+uVN5Z6Xl/dJkZweIIDzz2MNMUcqq2nWxw23qW42ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHAf2l1F; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428243f928cso7728005e9.3;
        Tue, 06 Aug 2024 15:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722981760; x=1723586560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mp0WpaiC2XvuDjPrqJ1y4U3Oi9te7Bps6SXi4DFmtEs=;
        b=QHAf2l1FBhgPDkyoCdWFZG1UzZfy1bEWApONygeVO6l5c1C1WjnS6CvmmiSa8jN0V0
         3O+UWbWRVIr02Owwe4HC+GN9nasbYkPXoMMcuHvEvllRRQ/jN9Wq2Gsv1i1vcdrfeppD
         kk9Yj1s4+lx0PCUCz5Jy+Hd7opxHGW8Tso4qWB2Q/Rdjgy4M9gBbXr85Umz5Iru8t9FC
         +tasr8I9E8HHSlj2VYRvsGGOPmETEwmgXTavf995GOczlNQnRnC2Ya+gXsS04ayQVLRt
         1czwQUD5Q9Rh4QzvUQIq3vPwhoAVMt9XPHPgEhZm0vhz1UGxN6T9abbmIhiWmf2Femno
         TTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722981760; x=1723586560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mp0WpaiC2XvuDjPrqJ1y4U3Oi9te7Bps6SXi4DFmtEs=;
        b=VQW4V5NWthCN6QZTWYf3S7uLeBh9frrZMGrmbCzqgSVzp0fMLecI+udqRqLRnaRj86
         8pWw91Jxn8H79fPtLMeqN7Wfo1ENcH0PMHshDoDry6IyPvJgHvOszLD+bb6UK5k5M+yD
         b+2f2fwNlRLBYubzkIa+jAB9RH6xJMu9I/6G5Ds0yWLP7RHGUHl2yic7FQKnY4ubf8Ri
         CNPEgAPwPzaJMm84L6W4+CAOMDqD05JJG57WBPRyo577vLt5oCm/oU7K/ueLk787vyR3
         fkD/O+RmEcJ40rosFyLGJjLftbakZdD6ISSiK1RVaCoT8K5dPVhI0urYd+pnpJUwLInL
         BQaA==
X-Forwarded-Encrypted: i=1; AJvYcCVxmZmQy/yfcTGI9Opnkc02hD58DKWJfekEFKZ48SxT8ssZcnIhW+QH42hE9K2StJCwlY25Y3DQAyQuPYOH6BfYNWDs5nV8NnLHFxwOlvT3XAM0MF/LS9b3W2VuBqiTiWFsjCyBtxYr
X-Gm-Message-State: AOJu0YzqJOhymDcSKB553p8bc+MJNBdVmQviiWC2iRuTKjCIsr8Up9Kf
	SeQVWAJtlkPtP+XRg1/y7pdVcrLsBEmckk27l91wI/MXw08c69Zy
X-Google-Smtp-Source: AGHT+IG4Dx1g+NkaBIciA+wHIQJHu1E+LL7rr9z6w9T0IuFUILRLHEvNl+aoTVLSgg2g8CbSu9m0iQ==
X-Received: by 2002:a05:600c:1f90:b0:427:9dad:e6ac with SMTP id 5b1f17b1804b1-428e6b96b2fmr114221385e9.34.1722981759894;
        Tue, 06 Aug 2024 15:02:39 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:7600:c5:51ce:2b5:970b? ([2a02:6b6f:e750:7600:c5:51ce:2b5:970b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429057e8fe9sm255675e9.1.2024.08.06.15.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 15:02:39 -0700 (PDT)
Message-ID: <4ed9feaa-b7dc-4a02-a58d-ee845e872bd2@gmail.com>
Date: Tue, 6 Aug 2024 23:02:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] mm: add selftests to split_huge_page() to verify
 unmap/zap of zero pages
To: kernel test robot <lkp@intel.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev, hannes@cmpxchg.org,
 shakeel.butt@linux.dev, roman.gushchin@linux.dev, yuzhao@google.com,
 david@redhat.com, baohua@kernel.org, ryan.roberts@arm.com, rppt@kernel.org,
 willy@infradead.org, cerasuolodomenico@gmail.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com, Alexander Zhu <alexlzhu@fb.com>, riel@surriel.com
References: <ZqsS/1ts8leyUeEQ@rli9-mobl>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <ZqsS/1ts8leyUeEQ@rli9-mobl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 01/08/2024 05:45, kernel test robot wrote:
> Hi Usama,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Usama-Arif/Revert-memcg-remove-mem_cgroup_uncharge_list/20240730-223949
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20240730125346.1580150-6-usamaarif642%40gmail.com
> patch subject: [PATCH 5/6] mm: add selftests to split_huge_page() to verify unmap/zap of zero pages
> :::::: branch date: 32 hours ago
> :::::: commit date: 32 hours ago
> compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240801/202408010618.lgnamdZd-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/r/202408010618.lgnamdZd-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    vm_util.c: In function 'rss_anon':
>>> vm_util.c:188:41: warning: format '%ld' expects argument of type 'long int *', but argument 3 has type 'uint64_t *' {aka 'long long unsigned int *'} [-Wformat=]
>      188 |         if (sscanf(buffer, "RssAnon:%10ld kB", &rss_anon) != 1)
>          |                                     ~~~~^      ~~~~~~~~~
>          |                                         |      |
>          |                                         |      uint64_t * {aka long long unsigned int *}
>          |                                         long int *
>          |                                     %10lld
> 
> 

Interesting affect of different compilers!

If I compile with the above suggestion on my machine, i.e. convert ld to lld, I get a warning on my machine that uint64_t is long unsigned int (and not long long unsigned int as above):

vm_util.c: In function ‘rss_anon’:
vm_util.c:188:42: warning: format ‘%lld’ expects argument of type ‘long long int *’, but argument 3 has type ‘uint64_t *’ {aka ‘long unsigned int *’} [-Wformat=]
  188 |         if (sscanf(buffer, "RssAnon:%10lld kB", &rss_anon) != 1)
      |                                     ~~~~~^      ~~~~~~~~~
      |                                          |      |
      |                                          |      uint64_t * {aka long unsigned int *}
      |                                          long long int *
      |                                     %10ld


I will just do below which should work hopefully with all compilers: 
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 7b7e763ba8e3..bd147bdb1bb2 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -172,9 +172,9 @@ uint64_t read_pmd_pagesize(void)
        return strtoul(buf, NULL, 10);
 }
 
-uint64_t rss_anon(void)
+long unsigned rss_anon(void)
 {
-       uint64_t rss_anon = 0;
+       long unsigned rss_anon = 0;
        FILE *fp;
        char buffer[MAX_LINE_LENGTH];
 
@@ -185,7 +185,7 @@ uint64_t rss_anon(void)
        if (!check_for_pattern(fp, "RssAnon:", buffer, sizeof(buffer)))
                goto err_out;
 
-       if (sscanf(buffer, "RssAnon:%10ld kB", &rss_anon) != 1)
+       if (sscanf(buffer, "RssAnon:%10lu kB", &rss_anon) != 1)
                ksft_exit_fail_msg("Reading status error\n");
 
 err_out:

