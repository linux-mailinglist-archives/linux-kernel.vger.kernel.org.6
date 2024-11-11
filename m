Return-Path: <linux-kernel+bounces-403811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E239C3B27
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAD9E1F21E90
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB1B1531C5;
	Mon, 11 Nov 2024 09:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gQn4E1FF"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0964B224D6
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731318238; cv=none; b=QAj19Pges7+qz6KpGNSxCi2hDyjawEkr+WGbbDCzQ1q/DnN6OXhqjYnzWesQSA1JyQOXH0zhqVKcaiFk4Y8/kWUU3N51SNzqUkXzor55F+aZjx0QZOkXXdoEorsS1wkRI/xu3HJgpJ/iEcISUs3NO/hCBmbDr+XAeldrmOm7rbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731318238; c=relaxed/simple;
	bh=LG2oRZ80i01qs7NGC4LV+2RagFX7Y68AMcAgdb+Ah4I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HrGhC0S03hm8Qi1EkNSi8bVp0Fji1w57nZQThJKre9eCMYPbRif3etlKJy+LJt1hbMTUkSSKhbaJeRme2nDH9pWSs1fZWvxtkz/WOLiCemgQF5SJWSur4Cm/BWku+CF1AbNYysxbBD50Mg13inEjsBjmRN4J12Ni/rlzg6WTQOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gQn4E1FF; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9acafdb745so857615166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 01:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731318235; x=1731923035; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zN5u/k/hQf/EODB0Rgy/g9MqUY8TUESZQQ3pm+8evkw=;
        b=gQn4E1FFLOJxMgapkZk5PCpUCixn7sriqCzg4y8lj6okxpWf559XLLbKjwTZf6/c/J
         lpjv53JlKO4nr4oIsd3utalgM21f+5x0UGuAyvnF4mAw0IJy/Y8C501ZY1hFsVLuHU+q
         P0DUqhFvcehszDEyXcXLeTVWch/b/Qux/+h/Tm8PhNdnlvLFRPka0hegVVg9T6pDniQg
         0IAFqs6/UQ5dZZPI2oJFtfUnkF8UO6YRotVWFUzSmfVKq86EdhE8coQ95kkVwqYvkZ78
         hW8vseBHi+4O57klL+O64CKv0gqmNAwU9hCbCZIuvQ0tDSnvy0Q/znUmGcLZPBSkJ3Np
         RBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731318235; x=1731923035;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zN5u/k/hQf/EODB0Rgy/g9MqUY8TUESZQQ3pm+8evkw=;
        b=h22vizJzlwyqegRPvdaEwa7Qrw1JjroxaRS0eV2UK4fyFfAAeXzkUwpjuQQo7iK3g7
         3RBqCCHEVop2/eVhjn2K2dGsBvZOEX4sTeXVf56MTGg7NGSWEDaqZEwqbdSAxXznWXVM
         4dx822Pu97DFQhWVBO7arRtadRlkL/p484CiNsc3Yle3Fk2L3M7XWp+OddQIyrOFHb4+
         md2HzfaLTYljlh5O7g8S9n6LjACOmn4XMMcA7faL7a+/VohpshgM2WVL0NZNenTKYw25
         V5gMP+r9bVjqhEXPoQvVkGGw3kSg4N0rwSnM56A+TpD4XUTZbGehENm/Z7KuduJRAg72
         Ov1g==
X-Forwarded-Encrypted: i=1; AJvYcCVfoRvCI7FB3d3gMRWO1bNjoxtbuVnshhbV31WbpJNkFAJN6HIbBFJaTbwaFQ65PvzHn9Vuxt8BzZ9fUu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfzGHGrB5Ao7LYhzlGkE8d9ZznVYJcnqDr8hh7UFDTMXo4EzEU
	FsHqHvnKY1DiHHzzpq1cUAOC9CjbJu4hUXsjuMZ6Kpe2ECLEZl/d5ecnCI1pK+A=
X-Google-Smtp-Source: AGHT+IGFaIPnZqqDAJMhMwyxIn6+GOqns9j3XX//DVN0QDrgJeJvrt3tgEqi2wiJm4jBk9jWGeE3Ug==
X-Received: by 2002:a17:907:2da5:b0:a99:fbb6:4972 with SMTP id a640c23a62f3a-a9eeff97fe5mr1165490066b.25.1731318235345;
        Mon, 11 Nov 2024 01:43:55 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0defbdcsm573018066b.159.2024.11.11.01.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 01:43:54 -0800 (PST)
Date: Mon, 11 Nov 2024 12:43:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Hector Martin <marcan@marcan.st>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: drivers/soc/apple/mailbox.c:292 apple_mbox_get() warn: passing zero
 to 'ERR_PTR'
Message-ID: <8291bb96-afb7-4703-8a72-ba764534efc9@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   906bd684e4b1e517dd424a354744c5b0aebef8af
commit: c84292d9d253706267889cf2614400712f15d689 soc: apple: mailbox: Rename config symbol to APPLE_MAILBOX
config: sparc-randconfig-r072-20241107 (https://download.01.org/0day-ci/archive/20241108/202411081103.7IiOcvUp-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202411081103.7IiOcvUp-lkp@intel.com/

smatch warnings:
drivers/soc/apple/mailbox.c:292 apple_mbox_get() warn: passing zero to 'ERR_PTR'

vim +/ERR_PTR +292 drivers/soc/apple/mailbox.c

6e1457fcad3ff6 Hector Martin 2023-03-14  282  struct apple_mbox *apple_mbox_get(struct device *dev, int index)
6e1457fcad3ff6 Hector Martin 2023-03-14  283  {
6e1457fcad3ff6 Hector Martin 2023-03-14  284  	struct of_phandle_args args;
6e1457fcad3ff6 Hector Martin 2023-03-14  285  	struct platform_device *pdev;
6e1457fcad3ff6 Hector Martin 2023-03-14  286  	struct apple_mbox *mbox;
6e1457fcad3ff6 Hector Martin 2023-03-14  287  	int ret;
6e1457fcad3ff6 Hector Martin 2023-03-14  288  
6e1457fcad3ff6 Hector Martin 2023-03-14  289  	ret = of_parse_phandle_with_args(dev->of_node, "mboxes", "#mbox-cells",
6e1457fcad3ff6 Hector Martin 2023-03-14  290  					 index, &args);
6e1457fcad3ff6 Hector Martin 2023-03-14  291  	if (ret || !args.np)
6e1457fcad3ff6 Hector Martin 2023-03-14 @292  		return ERR_PTR(ret);

This should be something like: return ERR_PTR(ret ?: -EINVAL);

6e1457fcad3ff6 Hector Martin 2023-03-14  293  
6e1457fcad3ff6 Hector Martin 2023-03-14  294  	pdev = of_find_device_by_node(args.np);
6e1457fcad3ff6 Hector Martin 2023-03-14  295  	of_node_put(args.np);
6e1457fcad3ff6 Hector Martin 2023-03-14  296  
6e1457fcad3ff6 Hector Martin 2023-03-14  297  	if (!pdev)
6e1457fcad3ff6 Hector Martin 2023-03-14  298  		return ERR_PTR(EPROBE_DEFER);
6e1457fcad3ff6 Hector Martin 2023-03-14  299  
6e1457fcad3ff6 Hector Martin 2023-03-14  300  	mbox = platform_get_drvdata(pdev);
6e1457fcad3ff6 Hector Martin 2023-03-14  301  	if (!mbox)
6e1457fcad3ff6 Hector Martin 2023-03-14  302  		return ERR_PTR(EPROBE_DEFER);
6e1457fcad3ff6 Hector Martin 2023-03-14  303  
6e1457fcad3ff6 Hector Martin 2023-03-14  304  	if (!device_link_add(dev, &pdev->dev, DL_FLAG_AUTOREMOVE_CONSUMER))
6e1457fcad3ff6 Hector Martin 2023-03-14  305  		return ERR_PTR(ENODEV);
6e1457fcad3ff6 Hector Martin 2023-03-14  306  
6e1457fcad3ff6 Hector Martin 2023-03-14  307  	return mbox;
6e1457fcad3ff6 Hector Martin 2023-03-14  308  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


