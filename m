Return-Path: <linux-kernel+bounces-417880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA259D5A2D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32C3281BE3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 07:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC970176AA1;
	Fri, 22 Nov 2024 07:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MH8QkPQo"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DA11632D0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 07:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732261561; cv=none; b=ezram/jNn8Q7A2Bfy0Ei64SXb933RQ1fBHbCsH2vY87a0z3IH9Tdxlczwd6mB04fOi4EqalTmCTaNIWTqXxmCh0J9w3VDYplUIJ4RdtP70ifq+5OEjrDggOQaf5fGHlzUrtT2OL+87+6SUIazlE7nQnFvf7oWs2iUjFm8ZrAKe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732261561; c=relaxed/simple;
	bh=5HXtMqhw3tXV3gZZK7lbXDy0S3J+fgiHJzU7zjwgBZI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WREWUdpMLwog+jvLkTfMEVMEv9j9WoZvg4cbOrXVgDii2dG33hm892lU4VtjUTg8vNOA67eoxkc1SFth7Elz1KQW6cQyDBfAwRNYCukSbubZGWaYMcLocT2eEG2cmHW9bAh+qhVc9abnHk2m5DgJx9fdkrbthv5IC3mL1EKFS1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MH8QkPQo; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-432d9bb168cso16439115e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 23:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732261557; x=1732866357; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kp3Es+EYJzhWtzxIqPztkeb+fLawoz/8tmOGiwlpXsU=;
        b=MH8QkPQozo9FTnE5yFmsBovPF0jJhICB3VV5MOh2XCcjG9I4bwfUP59D17xXgGz236
         E5akstVULk8z+2FwCAA1yDkSd38hGPNbbhZp0SNiFp7kFqlAEfyC3PjvSeqgj+HrroeS
         KX0CoalOD9aND8Y59+IQzQk90olRdMuQoOi5giWFRp7ou6ozRv+9YAn4BAL4C2frvII+
         CD0zu2F0i+khgByDepwRtKTDOWlxFRim8gHsavfRA0GeGpzNxZZMUXahhS875GOMsGR5
         mzwXk8WK9S9cNKmoCTQHCpOnLTghmXPNxQloNsHK3KElohzumWpVDnk3vuw2G/xuFFg5
         ou1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732261557; x=1732866357;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kp3Es+EYJzhWtzxIqPztkeb+fLawoz/8tmOGiwlpXsU=;
        b=LjD5HaNdLv/bPVGxaJnlixYIMFO87GMSolOzLTW4Vy1ltKExKNQ/9wUohn5cs/seKu
         m0np57picIUxu+mc+U2jA0qAH+gsui+wVYDRl+TD9apr0B/q6cSlP9aBI3gnyqvCUwLk
         xRzWjY0KD95aF68xy7FoxvX+DLE3KkrdUhqWQbok/lQkrntUTBVQEaaD0AhiS8SSpvF1
         6nTO0zkbgxMDXFFyT/w3f0og5/rbSeMaHEY3E7lZUj1nCB63c0jgAw4ZtoQ90rq2YX2/
         xrKzcs4EAw7fYgu9EzxyK2dOWWgGk90cXaNeFN1k0BA0cP8Dy+iWILeZjF7g1EdtBpXe
         cD3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXB06dJkEgpMP3ashcC1divrrauqylGKBp7TA0OdzDIASVh5Sd3XA4fVo8KXzNnbfDwDbVESOMb8mRAco8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn1xKkI67cM7JyxMw8Yqi4A8M0k9hh3j3MyTePXAkqAOBI2xuE
	snEzhijlc/NU8oDlEllLTlHCihpoWH2tvQ+sdPkQyLaIdaR/mqhaVhRL6oGBP4I=
X-Gm-Gg: ASbGncsU8ClrxQwBqQJDbnJJK5GCvhgNwk9ZstyR1u0LGxcnRL//M5pz9sn6qb7QdTO
	rsp9XRfBIlJjdjNN0R+8fZ4c3EhphSHVe9NEZjQDNC34FnBzp+W79g0PSzJEvqoRqJo/+gXDo3T
	3q38QehA+nOen+q8MfHHvBgvGpkYUe7OdkGAIwKR69zf0PzU/d1AYZq3lDQmykwwkeGfXRZcdX8
	04HNn+lWiEwTqLu2ilqRcKK9/4UATJ2788dfe/sNLsamT0k8M67of8=
X-Google-Smtp-Source: AGHT+IFwRn6hrEcHQ9I6nQ268X1gXrm8sfvunsDK3GyTofhPaRS1QQnV5dbgZWbsMLcZFqf7T3+lYQ==
X-Received: by 2002:a05:6000:1545:b0:382:3efc:c6de with SMTP id ffacd0b85a97d-382601132d7mr1279165f8f.3.1732261557506;
        Thu, 21 Nov 2024 23:45:57 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbc44f7sm1692299f8f.82.2024.11.21.23.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 23:45:57 -0800 (PST)
Date: Fri, 22 Nov 2024 10:45:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: drivers/media/pci/intel/ipu-bridge.c:752 ipu_bridge_ivsc_is_ready()
 warn: iterator 'i' not incremented
Message-ID: <54307d9c-a9bf-4bc1-b15d-60c5ba53d0ea@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   28eb75e178d389d325f1666e422bc13bbbb9804c
commit: 93da10eee90b2ffa4b496dd4a6ea276c57461fb6 media: intel/ipu6: Fix direct dependency Kconfig error
config: alpha-randconfig-r072-20241122 (https://download.01.org/0day-ci/archive/20241122/202411221147.N6w23gDo-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/

smatch warnings:
drivers/media/pci/intel/ipu-bridge.c:752 ipu_bridge_ivsc_is_ready() warn: iterator 'i' not incremented

vim +/i +752 drivers/media/pci/intel/ipu-bridge.c

c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  745  static int ipu_bridge_ivsc_is_ready(void)
c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  746  {
c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  747  	struct acpi_device *sensor_adev, *adev;
c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  748  	struct device *csi_dev;
c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  749  	bool ready = true;
c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  750  	unsigned int i;
c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  751  
c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03 @752  	for (i = 0; i < ARRAY_SIZE(ipu_supported_sensors); i++) {
8810e055b57543 drivers/media/pci/intel/ipu-bridge.c       Ricardo Ribalda 2024-05-01  753  #if IS_ENABLED(CONFIG_ACPI)
c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  754  		const struct ipu_sensor_config *cfg =
c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  755  			&ipu_supported_sensors[i];
c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  756  
c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  757  		for_each_acpi_dev_match(sensor_adev, cfg->hid, NULL, -1) {
8810e055b57543 drivers/media/pci/intel/ipu-bridge.c       Ricardo Ribalda 2024-05-01  758  #else
8810e055b57543 drivers/media/pci/intel/ipu-bridge.c       Ricardo Ribalda 2024-05-01  759  		while (true) {
                                                                                                        ^^^^^^^^^^^^^^

8810e055b57543 drivers/media/pci/intel/ipu-bridge.c       Ricardo Ribalda 2024-05-01  760  			sensor_adev = NULL;
8810e055b57543 drivers/media/pci/intel/ipu-bridge.c       Ricardo Ribalda 2024-05-01  761  #endif
8810e055b57543 drivers/media/pci/intel/ipu-bridge.c       Ricardo Ribalda 2024-05-01  762  			if (!ACPI_PTR(sensor_adev->status.enabled))
c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  763  				continue;


These continues make sense in for_each_acpi_dev_match() but not in a while (true) {
loop.  We're stuck forever.

c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  764  
c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  765  			adev = ipu_bridge_get_ivsc_acpi_dev(sensor_adev);
c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  766  			if (!adev)
c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  767  				continue;
                                                                                                                        ^^^^^^^^


c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  768  
c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  769  			csi_dev = ipu_bridge_get_ivsc_csi_dev(adev);
c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  770  			if (!csi_dev)
c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  771  				ready = false;
c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  772  
c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  773  			put_device(csi_dev);
c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  774  			acpi_dev_put(adev);
c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  775  		}
c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  776  	}
c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  777  
c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  778  	return ready;
c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  779  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


