Return-Path: <linux-kernel+bounces-515135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 874ADA360AF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9DB188CA75
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2891F26658B;
	Fri, 14 Feb 2025 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C+no3KEA"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521CD266572
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739544153; cv=none; b=osdw5N3SVLzCEP2cMAXCSJQZrVTFX0y8OC9xyau5NYcILLIFCgB9jAXCeSbr+DWEjcSiFjtsuzAAyvvqDYs32dHK7b9ZicWA8aSQPUTWeS3BHr/TB4l19qfk2lbEdDDPikkHkARCmwkyZ0EU6YoQeO0nXCEjbrNVFyY51g5wjPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739544153; c=relaxed/simple;
	bh=/hFRqo78Ekm9g5FTrhvJLClp80bSRuKsAEF9GDz0Hts=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cfQGsQ7gf/GLR5ovFWu2V9XZrI7JxmZdZmQj6KsR/Ff+2cpPQjOqI/L7ZvVlfLSLMF02OUzzSnviv14i6HhmaU6ILIrTZxMYWHFwECJT0DNly0rLcuBm+STqP8dC2o4qgh5Zlb6RS1Z10dQ52VSTHtw5K7WQYO8VP11dhtKqyvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C+no3KEA; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5de594e2555so3386688a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739544149; x=1740148949; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5A8Gla8Q///5jr1e+UVgogTbKkTus0cG6K56L7NjpIo=;
        b=C+no3KEA9bPYfxOreQf5ybJ3uJ7f9PclOAuEFQs2abfFOIB2Wu4QkAZ6HGij1jmK84
         6uUK17vIhYQ1D0whxaXV8OUK+522eXLJqymOsQW10WDGlb4NP7jEgguAISKHFJorRVz6
         /umvGA3vIYagf/4Bqo23pIOGOJTumQSDIlvVE26fBnTttRKYfhnewS2WRtshsiALCXsA
         kC1Z7NnJrsM15LVzGPP8K8iLXtbDbVsAgatWmFJe6BD8h5lBw5W65m3FxFfA6OS+XVUI
         3vmajwb/0VU4F4mAsaqiQ2XYnm97tJtH1nD3MCydp9Kw7iDaSid9ZGEURoslqIhjPNMk
         h7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739544149; x=1740148949;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5A8Gla8Q///5jr1e+UVgogTbKkTus0cG6K56L7NjpIo=;
        b=o32fafwOuf6X+RhLTjicfpOFDCiwzIuAYtxhaAJR0oHxABO+mmM3BRdr6myHcZ9SKV
         CwdgUkpNRI20d6bAsH2mApzfn6M3KFiNq0HqNh+dTvUge0MYcEfV5zMNjzPYa72Kbrl6
         Dp600GwpLKvNHh+3giWKqcO8zVECHWdyy8iRxMbe6GjxVbcjhuPxmpPGZGNFU2xNgkG1
         DSX6PBKewkM3Eqyu6bAVl0H+zfTnuKUrXxO9PjNyQc4dfvEXoR0uQvZGPfqZgm92vJUf
         z4HCILESAUrLxnDXHCjjVmk2adU98HzgZQ8UIb5KL9tbzy38h6MHy6nu0XMLs0ZDgIGD
         0/lw==
X-Forwarded-Encrypted: i=1; AJvYcCWGmmNNxsNAYIrW4kto1em0nXO7fex+Y+0muKRixgBOEokUTFtFYV9f4c3Lakck8RmFF4jN6icrqPVGZE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YykKVFq5d9eS/fsj/lLWJdFO4HzvJ8yEtG9K2rkrT6Mv7UXHW8i
	MGD1MTY4XCqzpPMQGioDlTcgkwcAn5JZvDZ+CPo21XZz4ax/dnrmvQfPpK6SJAI=
X-Gm-Gg: ASbGncvSx8u7wpSV0EzDtF1HC5v32TsjlDlpYwv9JGT2dNb/JVg5kIs7RSfi4JOIbFx
	yhbA47wmZNNq9IEmbGLbsGU/8U6ppGXO1mxp/pRobrNMOMt8Ad1wrIc7jtywSxD9KehTraaRZY2
	lzQQ4MltyN3kYU6XGXMnP4uftgI155UKp40b6s84ln6R6+HJm3npLa6bKFkkxoXC4VHZPFp5rOi
	mWuqfoD/p6J8UP+rtnej3VM1LGDT7lfQtDgnQuEi0iBy0VlAcPhhlduJdhw6NiWe2eAEkmBqdqD
	uXZZ90qVD25Co9EcuRoG
X-Google-Smtp-Source: AGHT+IHTsnNF3Z8oPb7KOJ0Szwe2eAivT4doFj5mcvOerXR4qOqV2S8aY3wuae3qVBS6+tsVgOsgtg==
X-Received: by 2002:a17:906:7807:b0:ab7:6369:83fc with SMTP id a640c23a62f3a-ab7f34af3d5mr1042895666b.38.1739544149543;
        Fri, 14 Feb 2025 06:42:29 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-aba533bdd39sm349560366b.167.2025.02.14.06.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 06:42:29 -0800 (PST)
Date: Fri, 14 Feb 2025 17:42:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Karan Tilak Kumar <kartilak@cisco.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	Gian Carlo Boffa <gcboffa@cisco.com>,
	Arulprabhu Ponnusamy <arulponn@cisco.com>,
	Arun Easi <aeasi@cisco.com>
Subject: drivers/scsi/fnic/fdls_disc.c:263
 fdls_schedule_oxid_free_retry_work() warn: inconsistent indenting
Message-ID: <f1c717cf-63eb-402a-82cc-91c445055b97@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   128c8f96eb8638c060cd3532dc394d046ce64fe1
commit: a63e78eb2b0f654b138abfc323f6bd7573e26145 scsi: fnic: Add support for fabric based solicited requests and responses
config: i386-randconfig-141-20250214 (https://download.01.org/0day-ci/archive/20250214/202502141403.1PcpwyJp-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202502141403.1PcpwyJp-lkp@intel.com/

smatch warnings:
drivers/scsi/fnic/fdls_disc.c:263 fdls_schedule_oxid_free_retry_work() warn: inconsistent indenting
drivers/scsi/fnic/fdls_disc.c:989 fdls_send_fabric_logo() warn: inconsistent indenting
drivers/scsi/fnic/fdls_disc.c:1953 fnic_fdls_validate_and_get_frame_type() warn: inconsistent indenting

vim +/cur_jiffies +166 drivers/scsi/fnic/fdls_disc.c

a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  244  void fdls_schedule_oxid_free_retry_work(struct work_struct *work)
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  245  {
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  246  	struct fnic_oxid_pool_s *oxid_pool = container_of(work,
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  247  		struct fnic_oxid_pool_s, schedule_oxid_free_retry.work);
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  248  	struct fnic_iport_s *iport = container_of(oxid_pool,
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  249  		struct fnic_iport_s, oxid_pool);
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  250  	struct fnic *fnic = iport->fnic;
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  251  	struct reclaim_entry_s *reclaim_entry;
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  252  	unsigned long delay_j = msecs_to_jiffies(OXID_RECLAIM_TOV(iport));
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  253  	int idx;
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  254  
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  255  	spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);

Passing fnic->lock_flags is wrong.  spin_lock_irqsave() is not nestable
in the sense that the "flags" variable can't hold two values at once:

	orig_irq = save_original irq states and disable()
	orig_irq = save_original irq states and disable()
	restore(orig_irq)
	restore(orig_irq)

The second restore(orig_irq) is not going to restore the original states
it's going to leave them as disabled.

If fnic->lock_flags is holding anything useful when this is called, then it
is a bug or if anything uses it before we exit that will break us.  Just
declare "unsigned long flags;" locally.

a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  256  
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  257  	for_each_set_bit(idx, oxid_pool->pending_schedule_free, FNIC_OXID_POOL_SZ) {
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  258  
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  259  		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  260  			"Schedule oxid free. oxid idx: %d\n", idx);
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  261  
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  262  		spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11 @263  	reclaim_entry = (struct reclaim_entry_s *)
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  264  	kzalloc(sizeof(struct reclaim_entry_s), GFP_KERNEL);


The indenting is off.  The normal way to write this is:

		reclaim_entry = kzalloc(sizeof(*reclaim_entry), GFP_KERNEL);

Remove the cast and change the sizeof().

a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  265  		spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  266  
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  267  		if (!reclaim_entry) {
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  268  			FNIC_FCS_DBG(KERN_WARNING, fnic->lport->host, fnic->fnic_num,
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  269  				"Failed to allocate memory for reclaim struct for oxid idx: 0x%x\n",
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  270  				idx);

Remove this DBG.  The truth is that for as long as anyone can remember
the kmalloc() allocator won't fail for tiny allocations.  We're more
likely to formalize this rule than we are to change it at this point.
Still, we check for errors until that day arrives.

But allocations are not supposed to print an error message on error.
It's just messy and it doesn't add any information that isn't already
in the stack traces that kmalloc() prints.

I guess we can't call schedule_delayed_work() without holding the
spin_lock?  It's a strange thing.

a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  271  
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  272  			schedule_delayed_work(&oxid_pool->schedule_oxid_free_retry,
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  273  				msecs_to_jiffies(SCHEDULE_OXID_FREE_RETRY_TIME));
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  274  			spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  275  			return;
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  276  		}
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  277  
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  278  		if (test_and_clear_bit(idx, oxid_pool->pending_schedule_free)) {
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  279  			reclaim_entry->oxid_idx = idx;
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  280  			reclaim_entry->expires = round_jiffies(jiffies + delay_j);
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  281  			list_add_tail(&reclaim_entry->links, &oxid_pool->oxid_reclaim_list);
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  282  			schedule_delayed_work(&oxid_pool->oxid_reclaim_work, delay_j);
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  283  		} else {
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  284  			/* unlikely scenario, free the allocated memory and continue */
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  285  			kfree(reclaim_entry);
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  286  		}
a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  287  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


