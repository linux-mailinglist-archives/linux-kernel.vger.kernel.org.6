Return-Path: <linux-kernel+bounces-510895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD61A3234E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A098D162C9A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6193B20551C;
	Wed, 12 Feb 2025 10:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lxL5udSV"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946931E500C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739355421; cv=none; b=c/UQ+nyNLOxqOO5f40QMgkXnYdHagbsz2U4PPyAD9YZ/S0Ohy+ZTqi0Ggujzj7FckxeRAoOg42vGHrrLDXfFmQcksAT6ReRAfpIeKNs4gm/XXPe6flDAOFMhbWKhgAmP25tokTNrm0n908jX8Z/wLTDHTIqDh1K1E2fRiBES1EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739355421; c=relaxed/simple;
	bh=aDiJ7MzcZuOp59joBAKOXPnxH/9tlAB04GJhUTcCYwI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IczKvCSr3rcG6xQcEGjbpKjqdGjWSNQ/KPirtrbKjL2f/Wa0yFgxC5mPewyR9RbTKr6Quthe4laAC6enjVXn9meyLPtCiyZecNu2EKKzulCL8umxrWfpueOb0fX0u60SlQszL3ngQ/350ZwoyCeXVsVtQf5EQ7kS7JhBFENvbss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lxL5udSV; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43957634473so9717945e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739355418; x=1739960218; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hCOjIl9TK1N5GOFcZIiD312EURItMH5pxsfAsuejYZk=;
        b=lxL5udSVfEGZR8HBBxORDCwrp+3+LeCxI/VSXHchy4edPH4tOvfsH2aGSbFaej17Px
         Yc64UyXXWOD+poV7B0Hryt85HVEQlkk8zrfqYoJd/n5+R8uxQM4a4bqwlXSbcJmybQFK
         CyvlSFwEwB2YHguXZZjaugACKEfWLaYHjdCW5ivTQUTZr6CUIgZbSZ0Bl5UylnGm/RBc
         YPV6DUF/Nsve0EUKs2RNx45NZ+2x8tyUyhu3A1Gt+HNyK7bBXfyXFUBSVQ9VAwkuibbC
         StsmtPbxSbu35aO2Uslk8pGxwyjY7zss9YgFjZOBolOUTZ8zhQK//EuieaILNVUBV7nD
         /jhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739355418; x=1739960218;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCOjIl9TK1N5GOFcZIiD312EURItMH5pxsfAsuejYZk=;
        b=m4D0s2R5os61wj0IMx3S5kmyQ7/mztX+tTOcNuxHW9HyZbHpcmXqLS9hU5jORXdvq0
         3v8mFThqntpfIYvnSuJgmnp4Vbeoc+aA+LBrOuYyoBzpz/1CPmNDm8W/TBZC4AKaLEJ5
         5+S2Q1nx0W1htUEGtRQBabiyH8OKXd2FtS1ZUeV6383dyp6lX6o32Wi3uI17TGVK63e3
         XCnKhbmkU0w4mwhtG9ZjT5OyGbAcjVDQQ+OOMcGSW9z8ZvOZ5yCDtZYF+Uq4EgUcnQxs
         dhlMqakDAXbnSWgIcbNOmQOJviTiUz7PSkhDAZlVUmhmx3KgoHoSfFp5b52EppD+mT05
         d13g==
X-Forwarded-Encrypted: i=1; AJvYcCVmt28+8UvEBKzRx+f0Nte/mP9yRpI1VshXcj/nBpjygbs6FU98GM46qG5/7n/OdfWw8MMjsfGDVMhjD2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu6xjX3XXmUoZwoW6MfaBQFXmyvRHUPQ6HKaxE4oICtXnF+4GP
	9SxXiqdVkTMEmL0A1R54KHHbLrC2wo8j+k4TElfaFWGsW9QnMciqwhShK8OdKBw=
X-Gm-Gg: ASbGncup9AHb2p6lAhKiypie22fQ9eDIxfL56eEGdgKTmkk2aQyuBzgEi755Rg8F/xv
	rixV0CdyhaXpXSf+cf4cvYLSXia/4Aq46lDjifJdERd/+0j+MfRCNm9pMs9kog14JkHUjfJHcr2
	g+zNjeALzIPewrLaJDnAvXlsd3couUjdcVSNW0/LU5avlcjrlChEsP8Ftx007bfE39njUrNEov1
	sg6F9QZrffCuQ0DTsHhwUnUJSYlVBLqTXcl5WBBDX1iKWAdzmYVMthYKAJKUTqJ9bvoBf/tXVm1
	xhYq7cHcUOgl9A==
X-Google-Smtp-Source: AGHT+IHbLFUK64oZDaRhyUljmKTni82bcsfQUnjFGMVlOka7cHXg7qh7zuixm+Pnf373SApmvVszgQ==
X-Received: by 2002:a05:600c:35ce:b0:436:ed38:5c7f with SMTP id 5b1f17b1804b1-43958176904mr27619615e9.12.1739355417891;
        Wed, 12 Feb 2025 02:16:57 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:65bb:e6ee:3141:374])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a053fb3sm15318055e9.16.2025.02.12.02.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 02:16:57 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Dave Ertman <david.m.ertman@intel.com>,
  Ira Weiny <ira.weiny@intel.com>,  "Rafael J. Wysocki"
 <rafael@kernel.org>,  Stephen Boyd <sboyd@kernel.org>,  Arnd Bergmann
 <arnd@arndb.de>,  lkp@intel.com,  oe-kbuild-all@lists.linux.dev,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] clk: clk-imx8mp-audiomix: use the auxiliary
 device creation helper
In-Reply-To: <7bb0b7ea-8ca4-4ea1-a7ec-d56646240e59@stanley.mountain> (Dan
	Carpenter's message of "Wed, 12 Feb 2025 10:26:50 +0300")
References: <7bb0b7ea-8ca4-4ea1-a7ec-d56646240e59@stanley.mountain>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 12 Feb 2025 11:16:56 +0100
Message-ID: <1jldub1n8n.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed 12 Feb 2025 at 10:26, Dan Carpenter <dan.carpenter@linaro.org> wrote:

> Hi Jerome,
>
> kernel test robot noticed the following build warnings:
>
> url:
> https://github.com/intel-lab-lkp/linux/commits/Jerome-Brunet/driver-core-auxiliary-bus-add-device-creation-helper/20250207-023433
> base:   2014c95afecee3e76ca4a56956a936e23283f05b
> patch link:    https://lore.kernel.org/r/20250206-aux-device-create-helper-v2-6-fa6a0f326527%40baylibre.com
> patch subject: [PATCH v2 6/7] clk: clk-imx8mp-audiomix: use the auxiliary device creation helper
> config: xtensa-randconfig-r071-20250208
> (https://download.01.org/0day-ci/archive/20250208/202502081655.FlCrxpYN-lkp@intel.com/config)
> compiler: xtensa-linux-gcc (GCC) 14.2.0
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202502081655.FlCrxpYN-lkp@intel.com/
>
> smatch warnings:
> drivers/clk/imx/clk-imx8mp-audiomix.c:241
> clk_imx8mp_audiomix_reset_controller_register() warn: passing zero to
> 'PTR_ERR'
>
> vim +/PTR_ERR +241 drivers/clk/imx/clk-imx8mp-audiomix.c
>
> c350f4c434316c Jerome Brunet 2025-02-06 231 static int
> clk_imx8mp_audiomix_reset_controller_register(struct device *dev)
> 6f0e817175c5b2 Shengjiu Wang 2024-06-14  232  {
> c350f4c434316c Jerome Brunet 2025-02-06  233  	struct auxiliary_device *adev;
> 6f0e817175c5b2 Shengjiu Wang 2024-06-14  234  
> 6f0e817175c5b2 Shengjiu Wang 2024-06-14  235  	if (!of_property_present(dev->of_node, "#reset-cells"))
> 6f0e817175c5b2 Shengjiu Wang 2024-06-14  236  		return 0;
> 6f0e817175c5b2 Shengjiu Wang 2024-06-14  237  
> c350f4c434316c Jerome Brunet 2025-02-06  238  	adev = devm_auxiliary_device_create(dev, KBUILD_MODNAME,
> c350f4c434316c Jerome Brunet 2025-02-06  239  					    "reset", NULL, 0);
> c350f4c434316c Jerome Brunet 2025-02-06  240  	if (IS_ERR_OR_NULL(adev))
> c350f4c434316c Jerome Brunet 2025-02-06 @241  		return PTR_ERR(adev);
>
> If devm_auxiliary_device_create() could return NULL then that would count
> as success.  But devm_auxiliary_device_create() can't return NULL.  It
> only makes sense to return NULL if the auxiliary device is optional.

Hi Dan,

It should have been IS_ERR() there. It is something I've noticed and
fixed in the other changes before submitting the v2 but, somehow, this
one slipped through. Thanks for catching this. This is obviously still
present in the v3 I've sent yesterday but will be fixed on the next
version. I'm waiting for feedback on the core part before making another
one.

Cheers

>
> https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/
>
> 6f0e817175c5b2 Shengjiu Wang 2024-06-14  242  
> 6f0e817175c5b2 Shengjiu Wang 2024-06-14  243  	return 0;
> 6f0e817175c5b2 Shengjiu Wang 2024-06-14  244  }

-- 
Jerome

