Return-Path: <linux-kernel+bounces-381152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC169AFB2E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15CF1F23BA3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C531B2185;
	Fri, 25 Oct 2024 07:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yK7JXwZV"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D64F18B498
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729841756; cv=none; b=snaYb3NVpc/LRw/aPhXMkejlnH1mDtx0P+a54/ltnV62lHsfAMieGvTo6AjjQ5p5sF0xkgGWFi1pZZhG4xBtql79BZNc+2NhYCK8CHyN8HY0xWaLcgCNso7sjuA1WDocD73hZPIdPCHJNOarcSr2SN+ohgTgyAw3pmRJgtdjAPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729841756; c=relaxed/simple;
	bh=3vHEWOAoO3sunonStkvYOWjQXz7fiPqp+eVdjriQS4o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FURUWRb7+QzxNA0c9iaFgsLu+IKG6hwmc1LJqD0aLQtqtfEaZR/qvjC/euc8gLe2RxyR3dw6w8MOIydydtlDB+SJpOvQnVEebTSZ0BUQ9wb/Ufh3Iyv8vO53koqz7n/cBfxPmzrexdI/WPvWmIkht5K5XyLLNhAR06iN0SOd/kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yK7JXwZV; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315839a7c9so17882275e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 00:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729841751; x=1730446551; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iuRgl2F/xjk94GYb4B6pSkppT/5/2/+/g3oc7q99vZg=;
        b=yK7JXwZV8+FPzjilZwt8A9/h3z7TvPJMvcjSogn9KHYGHArsoC1DBO8jN1ama7OcZY
         dSjcr3Z1ijqZKVqlQ+G3U9aHNFkVkwgKYkWsQoxFJ5pcT/aE+xKHOHSFkO5uJikPa8FR
         Ls+DHM6mz7w3G1niO7fmV6GwNyJHvCAi04IGyoaN3EfkfeW/hTUZCAMxo6itGxAd6Qwv
         02GrR1Go6TXhNUokL8eglQlFkJ75XO57KX3T56qlN9WyRhwGGWDYgt9wwTQL5tdburk0
         TNi0SFZpWQczdWgacdBpERSkT1lST/vn5moWmpU0uW5bAcQNNOEgAcIw2jO8qo0bBisC
         hOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729841751; x=1730446551;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iuRgl2F/xjk94GYb4B6pSkppT/5/2/+/g3oc7q99vZg=;
        b=xEa3iEXidcnb2D+iYFmfqpwPgpjixUX2a9+uUedYC54DgiY/RJWj+dJuCYMSOH08Fx
         /MBp5b9zw3mzxL23B7UyqsZcEXurjiVbA51bGBZ4mZFqjhNcMtu9bPTi6v4rxZJ3n6Tf
         pm+cM5YqBzVgR5p82LLTZW77njxAHLljrJo7PxDau0VsnXiqXwz+IEPvMJuKV2t6C7ti
         K/V/VfdlTOB406GJyYoAy/2vjz0tQfqjHzGxc5EWEZmWZ377wtduxpgy8e0mKV+OC9rE
         cv+0w7ZdfSZ7jZoEdyHGXWpkRN9fa9YarxiO6XTB8jMRjhCvrm4aylcNdhpJzlXC0s+B
         ufBg==
X-Forwarded-Encrypted: i=1; AJvYcCVKxn3ECppc3Jr8r+VbsGWx5cY7gm+ngL3KJAW71I1BXxOGJ4Hrj8gdFO2Z47Fhc6cyyEAtII+bK472SPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl5vKaowuO3jdTTaG5WDlIyXCZ6ZY7rYe8wL0dwMkYzRNHn805
	rKTkQeZpSoyXSHd9+sllhAIKBDRUh2A95DCO/gqmFr8s4BXgRN5W6F0SIp5aZmo=
X-Google-Smtp-Source: AGHT+IFA0MpYO6p8LtVohkgtXalPje3I4kcSbExFnIgWpEgGOG/y0/xxVoo/UXawUg5OUEBPa1KxKw==
X-Received: by 2002:a05:600c:45c6:b0:42c:bb10:7292 with SMTP id 5b1f17b1804b1-4318c6dd96cmr40125075e9.1.1729841751532;
        Fri, 25 Oct 2024 00:35:51 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b92f11sm809687f8f.101.2024.10.25.00.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 00:35:51 -0700 (PDT)
Date: Fri, 25 Oct 2024 10:35:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Heiko Carstens <hca@linux.ibm.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>
Subject: arch/s390/mm/fault.c:566 do_secure_storage_access() warn:
 inconsistent returns '&mm->mmap_lock'.
Message-ID: <5e4a2c40-9fc4-439a-8166-3a694e705d8e@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c2ee9f594da826bea183ed14f2cc029c719bf4da
commit: 7c194d84a9ce662426b2ecb59da54bb80c6b1d91 s390/mm,fault: remove VM_FAULT_BADMAP and VM_FAULT_BADACCESS
config: s390-randconfig-r072-20241024 (https://download.01.org/0day-ci/archive/20241025/202410250552.XsMLl1sx-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202410250552.XsMLl1sx-lkp@intel.com/

smatch warnings:
arch/s390/mm/fault.c:566 do_secure_storage_access() warn: inconsistent returns '&mm->mmap_lock'.

vim +566 arch/s390/mm/fault.c

084ea4d611a3d0 Vasily Gorbik     2020-01-21  498  void do_secure_storage_access(struct pt_regs *regs)
084ea4d611a3d0 Vasily Gorbik     2020-01-21  499  {
5be05c35e72f74 Heiko Carstens    2023-10-12  500  	union teid teid = { .val = regs->int_parm_long };
9641613f48bbf8 Heiko Carstens    2023-10-12  501  	unsigned long addr = get_fault_address(regs);
084ea4d611a3d0 Vasily Gorbik     2020-01-21  502  	struct vm_area_struct *vma;
084ea4d611a3d0 Vasily Gorbik     2020-01-21  503  	struct mm_struct *mm;
084ea4d611a3d0 Vasily Gorbik     2020-01-21  504  	struct page *page;
b108f7f0a29b24 Claudio Imbrenda  2022-06-28  505  	struct gmap *gmap;
084ea4d611a3d0 Vasily Gorbik     2020-01-21  506  	int rc;
084ea4d611a3d0 Vasily Gorbik     2020-01-21  507  
85b18d7b5e7ffe Janosch Frank     2021-01-12  508  	/*
3aad8c04429779 Heiko Carstens    2023-10-12  509  	 * Bit 61 indicates if the address is valid, if it is not the
3aad8c04429779 Heiko Carstens    2023-10-12  510  	 * kernel should be stopped or SIGSEGV should be sent to the
3aad8c04429779 Heiko Carstens    2023-10-12  511  	 * process. Bit 61 is not reliable without the misc UV feature,
3aad8c04429779 Heiko Carstens    2023-10-12  512  	 * therefore this needs to be checked too.
85b18d7b5e7ffe Janosch Frank     2021-01-12  513  	 */
5be05c35e72f74 Heiko Carstens    2023-10-12  514  	if (uv_has_feature(BIT_UV_FEAT_MISC) && !teid.b61) {
85b18d7b5e7ffe Janosch Frank     2021-01-12  515  		/*
85b18d7b5e7ffe Janosch Frank     2021-01-12  516  		 * When this happens, userspace did something that it
85b18d7b5e7ffe Janosch Frank     2021-01-12  517  		 * was not supposed to do, e.g. branching into secure
85b18d7b5e7ffe Janosch Frank     2021-01-12  518  		 * memory. Trigger a segmentation fault.
85b18d7b5e7ffe Janosch Frank     2021-01-12  519  		 */
85b18d7b5e7ffe Janosch Frank     2021-01-12  520  		if (user_mode(regs)) {
85b18d7b5e7ffe Janosch Frank     2021-01-12  521  			send_sig(SIGSEGV, current, 0);
85b18d7b5e7ffe Janosch Frank     2021-01-12  522  			return;
85b18d7b5e7ffe Janosch Frank     2021-01-12  523  		}
85b18d7b5e7ffe Janosch Frank     2021-01-12  524  		/*
3aad8c04429779 Heiko Carstens    2023-10-12  525  		 * The kernel should never run into this case and
3aad8c04429779 Heiko Carstens    2023-10-12  526  		 * there is no way out of this situation.
85b18d7b5e7ffe Janosch Frank     2021-01-12  527  		 */
85b18d7b5e7ffe Janosch Frank     2021-01-12  528  		panic("Unexpected PGM 0x3d with TEID bit 61=0");
85b18d7b5e7ffe Janosch Frank     2021-01-12  529  	}
084ea4d611a3d0 Vasily Gorbik     2020-01-21  530  	switch (get_fault_type(regs)) {
b108f7f0a29b24 Claudio Imbrenda  2022-06-28  531  	case GMAP_FAULT:
b108f7f0a29b24 Claudio Imbrenda  2022-06-28  532  		mm = current->mm;
b108f7f0a29b24 Claudio Imbrenda  2022-06-28  533  		gmap = (struct gmap *)S390_lowcore.gmap;
b108f7f0a29b24 Claudio Imbrenda  2022-06-28  534  		mmap_read_lock(mm);
b108f7f0a29b24 Claudio Imbrenda  2022-06-28  535  		addr = __gmap_translate(gmap, addr);
b108f7f0a29b24 Claudio Imbrenda  2022-06-28  536  		mmap_read_unlock(mm);
7c194d84a9ce66 Heiko Carstens    2023-10-12  537  		if (IS_ERR_VALUE(addr))
7c194d84a9ce66 Heiko Carstens    2023-10-12  538  			return handle_fault_error_nolock(regs, SEGV_MAPERR);
b108f7f0a29b24 Claudio Imbrenda  2022-06-28  539  		fallthrough;
084ea4d611a3d0 Vasily Gorbik     2020-01-21  540  	case USER_FAULT:
084ea4d611a3d0 Vasily Gorbik     2020-01-21  541  		mm = current->mm;
d8ed45c5dcd455 Michel Lespinasse 2020-06-08  542  		mmap_read_lock(mm);
084ea4d611a3d0 Vasily Gorbik     2020-01-21  543  		vma = find_vma(mm, addr);
7c194d84a9ce66 Heiko Carstens    2023-10-12  544  		if (!vma)
7c194d84a9ce66 Heiko Carstens    2023-10-12  545  			return handle_fault_error(regs, SEGV_MAPERR);

mmap_read_unlock() before returning?

084ea4d611a3d0 Vasily Gorbik     2020-01-21  546  		page = follow_page(vma, addr, FOLL_WRITE | FOLL_GET);
084ea4d611a3d0 Vasily Gorbik     2020-01-21  547  		if (IS_ERR_OR_NULL(page)) {
d8ed45c5dcd455 Michel Lespinasse 2020-06-08  548  			mmap_read_unlock(mm);
084ea4d611a3d0 Vasily Gorbik     2020-01-21  549  			break;
084ea4d611a3d0 Vasily Gorbik     2020-01-21  550  		}
084ea4d611a3d0 Vasily Gorbik     2020-01-21  551  		if (arch_make_page_accessible(page))
084ea4d611a3d0 Vasily Gorbik     2020-01-21  552  			send_sig(SIGSEGV, current, 0);
084ea4d611a3d0 Vasily Gorbik     2020-01-21  553  		put_page(page);
d8ed45c5dcd455 Michel Lespinasse 2020-06-08  554  		mmap_read_unlock(mm);
084ea4d611a3d0 Vasily Gorbik     2020-01-21  555  		break;
084ea4d611a3d0 Vasily Gorbik     2020-01-21  556  	case KERNEL_FAULT:
084ea4d611a3d0 Vasily Gorbik     2020-01-21  557  		page = phys_to_page(addr);
cd1adf1b63a112 Linus Torvalds    2021-09-07  558  		if (unlikely(!try_get_page(page)))
084ea4d611a3d0 Vasily Gorbik     2020-01-21  559  			break;
084ea4d611a3d0 Vasily Gorbik     2020-01-21  560  		rc = arch_make_page_accessible(page);
084ea4d611a3d0 Vasily Gorbik     2020-01-21  561  		put_page(page);
084ea4d611a3d0 Vasily Gorbik     2020-01-21  562  		if (rc)
084ea4d611a3d0 Vasily Gorbik     2020-01-21  563  			BUG();
084ea4d611a3d0 Vasily Gorbik     2020-01-21  564  		break;
084ea4d611a3d0 Vasily Gorbik     2020-01-21  565  	default:
ae626f686351d2 Heiko Carstens    2023-10-12 @566  		unreachable();
084ea4d611a3d0 Vasily Gorbik     2020-01-21  567  	}
084ea4d611a3d0 Vasily Gorbik     2020-01-21  568  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


