Return-Path: <linux-kernel+bounces-525886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EFCA3F6D8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 171AE17A8A1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249D420E330;
	Fri, 21 Feb 2025 14:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ocWp/JfW"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE33E1BCA07
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740146955; cv=none; b=MaDN9ZM47leRpfCfq5HN5YMYZwnYt9JqRJHeXuJD0ieSBF9R1BBSETi1lWzFcrPdBa8S7ynFxSTv2nadD0j6aorwzA9jyuOCjEOtuRQaVMlJyg5LgICgStzSShRZnBpmRWHrDgh1YbrzWDwQrg94CpHptkNNhtomYzxK4GO79Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740146955; c=relaxed/simple;
	bh=35Z1H1MxhW5IbndFquA1CYbsZgLoVdLkqwioV4p/xsM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OpZWXaiOaEs5Ui/+KjIRcQ2xravST+DdlZcjH+gcGOTch7x2saOz7yaUUBQbKQfsQRVfMqNB/lSUIutPUt9tnjOR3Gv8U/+SL5kjVmyC9JuYPuBRZ6A8JoLp3XwwBbAGtVUeHTs0ujdLm9AJBFPsYETeSeyJKJDXv1e9S5NY/oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ocWp/JfW; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e050b1491eso5680043a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 06:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740146952; x=1740751752; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tZAgktSZZMLiPp9SM2R7Kz9OEAafAnD4jJNlBBN52gA=;
        b=ocWp/JfWQQn9PphliLFDdm139NQPpinayyZxY0XkVOYaDpukuo3HhN4mNQgfi8cK1F
         GV6X/GJcKfKto97xIy8zwJv4xGnwtT6alzlaVE28DqonsiWsk9VRM/d4j4HKiDiKe+EC
         0RFSo+/JEuZWe+MLX/zHeM6MXNx7kYe8G4rFkymblBnjwwPGtaf76nZdsiqPVnSYs9nk
         HBJxT979Z+rTTEeaxgg6YIxVtZcZ+haG+IK9H8THIdidNikSThQoyT/pW6RGs5Dxbpsx
         0sVBqt+ZiGGd8XmpPwVFZzApsITrqXku7yOL8xEn4HkqS+TU106b9xPeNKkoa4MSqf6B
         ML5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740146952; x=1740751752;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tZAgktSZZMLiPp9SM2R7Kz9OEAafAnD4jJNlBBN52gA=;
        b=SJlnQ+kBNjDpRMuCVNMQF+OV2JkBIs+XdiQKSZ6Xtq93cTMjFUGhuhhd6ixUeZLAJD
         2LjNnZW2WBZiozvyjworIHGa5CQnNFLgsKUIZ1gjHp+RDnOG5nbKeoLUvrH+nSbw3nUQ
         HMDn/P+Y99eRemGfW6lkCcQHCUfGeBf8dnLzbf5NOECbnqcgdmVTTv/9sqMQLIEQDIGD
         OpPwun3iUh5O+dZ8wdNIxU2jQ0m3pJ5qg/9upwY6n9VBEDVGIJLuMmFplTKNIfoEDooV
         IpEOKQkteCq3uVwPitubkOR+2tTTWw9Kz337We329nWs6AyLC79LwV5CdvDawum/OlPb
         PS8A==
X-Forwarded-Encrypted: i=1; AJvYcCX4CSqE/KRc+flU55eUxz1ggOQo4scmzNd54RZ8oh0uqxBpQhwGTXZytdv4jDitWqvW5wLpDP4VHzxCWpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIq0uQGkUE3FRfLILmiQbFsQV2P9x7UboMd+lOzImovFxmV7EH
	GKbd3PHUKMHg+D2an7y80EDzfS91w56r/hv8WeYLA3xI3+Xya4uM9z8sxaP/3hH46ePSYo6UwAH
	6
X-Gm-Gg: ASbGncuLltJeBuyjSdf6Hxg6IBFmMY7w/Zq1mYO4XVbuCPvSxvVgRvA/JFoU75QONhE
	fXaD/tTE9y8d/NzsOHzc7vETBw+F+Kqu1Stuem/QtDkGiRhB0Oy7IshQTb2rI17X1h9CTnqBCRu
	Jnx5ZVwPf9sIQNX0TBtoN2dy1bsv79NzZeUgmCxCpRfvthvGjCcHGH3fM39nJIa7QHdfbAR680t
	jX9PjjIVlhH+dc3g36dMqP3nPziO1MX+uB9G9s+kSFYJQWL7suKMxeiTcUCoGhT0NMaX3AbCN9I
	uKkhaO518JN1cV6Acfx69GmFXzeb4SQ=
X-Google-Smtp-Source: AGHT+IFu4aNr9Q8vqGT14g6lIi6T5RIzEuhOS18uu9cyvoWpY3r5Cm7kMhRzVURCA/Yj1ZFehwN9pA==
X-Received: by 2002:a05:6402:13c9:b0:5e0:7df0:6623 with SMTP id 4fb4d7f45d1cf-5e0a1240ec9mr6649040a12.6.1740146951950;
        Fri, 21 Feb 2025 06:09:11 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5dece1d3472sm13672546a12.34.2025.02.21.06.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 06:09:11 -0800 (PST)
Date: Fri, 21 Feb 2025 17:09:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Frederic Weisbecker <frederic@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: kernel/sched/ext.c:5356 scx_create_rt_helper() warn: 'helper' is an
 error pointer or valid
Message-ID: <a4f5658c-9ab3-4547-a6a0-7832f539aa64@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   334426094588f8179fe175a09ecc887ff0c75758
commit: 41f70d8e16349c65abdc0dd88a7d0ab94e5ce639 kthread: Unify kthread_create_on_cpu() and kthread_create_worker_on_cpu() automatic format
config: powerpc-randconfig-r073-20250221 (https://download.01.org/0day-ci/archive/20250221/202502211941.Z5Lgg2UR-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202502211941.Z5Lgg2UR-lkp@intel.com/

smatch warnings:
kernel/sched/ext.c:5356 scx_create_rt_helper() warn: 'helper' is an error pointer or valid
kernel/sched/ext.c:5357 scx_create_rt_helper() error: 'helper' dereferencing possible ERR_PTR()

vim +/helper +5356 kernel/sched/ext.c

f0e1a0643a59bf Tejun Heo 2024-06-18  5351  static struct kthread_worker *scx_create_rt_helper(const char *name)
f0e1a0643a59bf Tejun Heo 2024-06-18  5352  {
f0e1a0643a59bf Tejun Heo 2024-06-18  5353  	struct kthread_worker *helper;
f0e1a0643a59bf Tejun Heo 2024-06-18  5354  
f0e1a0643a59bf Tejun Heo 2024-06-18  5355  	helper = kthread_create_worker(0, name);
f0e1a0643a59bf Tejun Heo 2024-06-18 @5356  	if (helper)

if (!IS_ERR(helper))

f0e1a0643a59bf Tejun Heo 2024-06-18 @5357  		sched_set_fifo(helper->task);
f0e1a0643a59bf Tejun Heo 2024-06-18  5358  	return helper;
f0e1a0643a59bf Tejun Heo 2024-06-18  5359  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


