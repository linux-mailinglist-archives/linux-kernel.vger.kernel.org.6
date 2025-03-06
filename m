Return-Path: <linux-kernel+bounces-548283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CA0A542D5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C3318934FA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 06:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D02419882F;
	Thu,  6 Mar 2025 06:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NkXkKx12"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734C7199FC9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 06:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741242935; cv=none; b=HKDrOG+7ps8+KhrE722Sy8zqMHCLdD/WtAapPA0QoxZsHcFdA+DsOAFIwDnSlaoxdWg/sFQplJwSCkbNo8ytefxC8TInIYow+MEOl6kIVcGsHNuaxMBgLV5IZCCb6nyG5dg58a1uDjuid5qXB93hlu+KS8C3MZHNSKRW4B6wYfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741242935; c=relaxed/simple;
	bh=OgVi8LZ/avO7r/TihguE885iMoKtcusZUL+VQwbS8dk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ifuCxjxnLrYwkCSfbg64wSCiFJnmLJYwfV+oefmup6q6ipj6LkU6NBa8vhPnBlSJydm9S9r1edpvTY3ecGPnoBkE3u3hoF3Q2oAkMVkIDEv69u+sJhqsrUkc59s2oBlmoCsbyoJ94uikLHo2zNchmTgAOj0tTWU08AL2P0lyClY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NkXkKx12; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43bc4b16135so1243655e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 22:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741242931; x=1741847731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mx4eXhc4yqpVhI7TdTQuRC9iguxZspH9NuwtaHcC+Lc=;
        b=NkXkKx121iIVwRfnvL2NV5bLufVR3G63SPc2p4TvkVzVlrqSAO8fwb7sdoMK0GT32C
         ilASo1O5JK5ny5ODedT2PQkBlTEz9WDqL3Uw3WLQIupKoBZxhobysE7kPRTQY1s9kqa0
         rk9rvPMv44zRlZlAtGDG7EGQo/5pLiwA8PvxRhYa/g0txZI2zYLfYnN7xk2WsQQZvLOT
         Vy0eQ+j+Ktk57PekxQCGydsr068OdVmEtWspEdI+gb60MMdV+jfL1SZEn8lDPMasLGpH
         keu9Rve6CedfwPt/S7sg02dFwD7XQyy23x+MZIoajVllLg+CMTeADiVW/3vHx85yVG83
         LgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741242931; x=1741847731;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mx4eXhc4yqpVhI7TdTQuRC9iguxZspH9NuwtaHcC+Lc=;
        b=ZbYp6jUSDBUgZfzVmU+uNBjOO8TdYexDtyynPWZZuviXEMYcYsWZHAcOgcrpAzbTbD
         7m8ruNHgiNVkijUFCjRAp49f2o6gpMJkiMgwvlJodJXxKi7XDi0SPr8+08YrmzSfZyoc
         qWqA0CNqmpfpJX9Jh4aPTB6PlCQf4RntoFdGNz8hzgPIOVQWG3X8PLl1sGGgrL2sqokR
         qt35nIzu8XHOc4d8lsllgbMcfY/LI9dnKcbuXOThcFSkOcXOV57or2owyJubV9t8eXB2
         +QntDKzrGfB99/WEU2/aC3qi29c7lZCY5nD+6XNoB14xTPUk6Xbbza1BV27l49o4o451
         RS0w==
X-Forwarded-Encrypted: i=1; AJvYcCWcdxo7wuiGL8tYlnLm9rvoIyjiWU+TPTzSVZo5tgkr9lX0dBVoMqiFvEefOqcdBMHAqpofG7eNvpLjSR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyve26t4ppLDLSnQ63xsxbf/CoZ9zcrS/zRZo7jotdW/kcDlR6o
	JOxHLoLxLqy0oIxN+4oJamwEjGMfegX6GGEWOJwi5N1QKcJ/vlCYIHmGn69SZ/Q=
X-Gm-Gg: ASbGnctvmyCXtptYq6AkN/B3l2Z6FOnN/5f1zKj9twxNaWnN/jd2aU0ocuYM9J03PU6
	aUWUQ6K/s/XgKnVhjL1T6l+bKEz2o/9s5fOpahh9L2PPkLZlg53xkMnM3fJaZvG9XusUYBN4dqH
	yvweskqyyABi4sPiwycIBSFX5oIZOBoBBLQV3IfNjxqDpKGqUDQot1IGLXIc6cHE++sucyfPBjl
	dAMpkAK6Xbh9LH3OA/slvp0f/aBFYTlwSKD+NW14VZvV9SxH/HBz9OplnjRpPB+2qjxpkt5CB2g
	ZhCc06eHzmxHXvWdOMYSRtegP7Y9HAkR+WeIcz59sjOqyJh2iQ==
X-Google-Smtp-Source: AGHT+IEldEFBJ6GcJ/9AsmwidDi0MW22pFoTiX1DY3pYgmQW8PLpDd7QMPBO5UsdG2P8Z7W4b9nJlQ==
X-Received: by 2002:a05:600c:1551:b0:43b:cb0c:3556 with SMTP id 5b1f17b1804b1-43bd2af49cemr38379685e9.28.1741242930569;
        Wed, 05 Mar 2025 22:35:30 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bdd8c314asm9415525e9.10.2025.03.05.22.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 22:35:30 -0800 (PST)
Date: Thu, 6 Mar 2025 09:35:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, steven chen <chenste@linux.microsoft.com>,
	zohar@linux.ibm.com, stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
	eric.snowberg@oracle.com, ebiederm@xmission.com,
	paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
	James.Bottomley@hansenpartnership.com, bhe@redhat.com,
	vgoyal@redhat.com, dyoung@redhat.com
Subject: Re: [PATCH v9 2/7] kexec: define functions to map and unmap segments
Message-ID: <7bde870f-07eb-48a6-8b8d-edac57640775@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304190351.96975-3-chenste@linux.microsoft.com>

Hi steven,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/steven-chen/ima-copy-only-complete-measurement-records-across-kexec/20250305-031719
base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
patch link:    https://lore.kernel.org/r/20250304190351.96975-3-chenste%40linux.microsoft.com
patch subject: [PATCH v9 2/7] kexec: define functions to map and unmap segments
config: x86_64-randconfig-161-20250306 (https://download.01.org/0day-ci/archive/20250306/202503061449.gbVGafZc-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202503061449.gbVGafZc-lkp@intel.com/

smatch warnings:
kernel/kexec_core.c:896 kimage_map_segment() error: uninitialized symbol 'dest_page_addr'.

vim +/dest_page_addr +896 kernel/kexec_core.c

bf06eab7ae0f04 steven chen 2025-03-04  870  void *kimage_map_segment(struct kimage *image,
bf06eab7ae0f04 steven chen 2025-03-04  871  			 unsigned long addr, unsigned long size)
bf06eab7ae0f04 steven chen 2025-03-04  872  {
bf06eab7ae0f04 steven chen 2025-03-04  873  	unsigned long eaddr = addr + size;
bf06eab7ae0f04 steven chen 2025-03-04  874  	unsigned long src_page_addr, dest_page_addr;
bf06eab7ae0f04 steven chen 2025-03-04  875  	unsigned int npages;
bf06eab7ae0f04 steven chen 2025-03-04  876  	struct page **src_pages;
bf06eab7ae0f04 steven chen 2025-03-04  877  	int i;
bf06eab7ae0f04 steven chen 2025-03-04  878  	kimage_entry_t *ptr, entry;
bf06eab7ae0f04 steven chen 2025-03-04  879  	void *vaddr = NULL;
bf06eab7ae0f04 steven chen 2025-03-04  880  
bf06eab7ae0f04 steven chen 2025-03-04  881  	/*
bf06eab7ae0f04 steven chen 2025-03-04  882  	 * Collect the source pages and map them in a contiguous VA range.
bf06eab7ae0f04 steven chen 2025-03-04  883  	 */
bf06eab7ae0f04 steven chen 2025-03-04  884  	npages = PFN_UP(eaddr) - PFN_DOWN(addr);
bf06eab7ae0f04 steven chen 2025-03-04  885  	src_pages = kmalloc_array(npages, sizeof(*src_pages), GFP_KERNEL);
bf06eab7ae0f04 steven chen 2025-03-04  886  	if (!src_pages) {
bf06eab7ae0f04 steven chen 2025-03-04  887  		pr_err("Could not allocate ima pages array.\n");
bf06eab7ae0f04 steven chen 2025-03-04  888  		return NULL;
bf06eab7ae0f04 steven chen 2025-03-04  889  	}
bf06eab7ae0f04 steven chen 2025-03-04  890  
bf06eab7ae0f04 steven chen 2025-03-04  891  	i = 0;
bf06eab7ae0f04 steven chen 2025-03-04  892  	for_each_kimage_entry(image, ptr, entry) {
bf06eab7ae0f04 steven chen 2025-03-04  893  		if (entry & IND_DESTINATION) {
bf06eab7ae0f04 steven chen 2025-03-04  894  			dest_page_addr = entry & PAGE_MASK;

Is the first entry always IND_DESTINATION?

bf06eab7ae0f04 steven chen 2025-03-04  895  		} else if (entry & IND_SOURCE) {
bf06eab7ae0f04 steven chen 2025-03-04 @896  			if (dest_page_addr >= addr && dest_page_addr < eaddr) {
                                                                    ^^^^^^^^^^^^^^
otherwise this is uninitialized

bf06eab7ae0f04 steven chen 2025-03-04  897  				src_page_addr = entry & PAGE_MASK;
bf06eab7ae0f04 steven chen 2025-03-04  898  				src_pages[i++] =
bf06eab7ae0f04 steven chen 2025-03-04  899  					virt_to_page(__va(src_page_addr));
bf06eab7ae0f04 steven chen 2025-03-04  900  				if (i == npages)
bf06eab7ae0f04 steven chen 2025-03-04  901  					break;
bf06eab7ae0f04 steven chen 2025-03-04  902  				dest_page_addr += PAGE_SIZE;
bf06eab7ae0f04 steven chen 2025-03-04  903  			}
bf06eab7ae0f04 steven chen 2025-03-04  904  		}
bf06eab7ae0f04 steven chen 2025-03-04  905  	}
bf06eab7ae0f04 steven chen 2025-03-04  906  
bf06eab7ae0f04 steven chen 2025-03-04  907  	/* Sanity check. */
bf06eab7ae0f04 steven chen 2025-03-04  908  	WARN_ON(i < npages);
bf06eab7ae0f04 steven chen 2025-03-04  909  
bf06eab7ae0f04 steven chen 2025-03-04  910  	vaddr = vmap(src_pages, npages, VM_MAP, PAGE_KERNEL);
bf06eab7ae0f04 steven chen 2025-03-04  911  	kfree(src_pages);
bf06eab7ae0f04 steven chen 2025-03-04  912  
bf06eab7ae0f04 steven chen 2025-03-04  913  	if (!vaddr)
bf06eab7ae0f04 steven chen 2025-03-04  914  		pr_err("Could not map ima buffer.\n");
bf06eab7ae0f04 steven chen 2025-03-04  915  
bf06eab7ae0f04 steven chen 2025-03-04  916  	return vaddr;
bf06eab7ae0f04 steven chen 2025-03-04  917  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


