Return-Path: <linux-kernel+bounces-262416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E4D93C6CB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8091F24448
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748C419D89C;
	Thu, 25 Jul 2024 15:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="WTvTTMQg"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E1218028
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721922568; cv=none; b=uLhIRzerYGi6CAum/CCOqJO3UUzpFkedzVDeGVNRWFmv4mFhyWhVnH3BrWwabp/5lYJdV6M1KVdVXNiyZC5aSX50Re3QP1KxMC1WJ6UFtrQhEv+lYBsxmNOK5KwedcLImrr18opNru4WjMXfo5Eupc80aI0tMW6C6tHpbsxCsVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721922568; c=relaxed/simple;
	bh=ysaoQgIy1zQ6s25DZ0M7M/41ey3ueCP40qRnOA7NIfE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nHAr6EiCePm3R44rKbPBLniIKgHMWPhAiiGF60oL/AL4O6Tbnr0cW/UTBMTZ/AAGDur6yPEyM2eHuT/QdAqFEecyKVifshBVvCmFdu5udk50UYCxdq8mPeVCnN56zA5IKFGuiMbYpFkB6dcKUHz/AFHdgZpJF0lST7S2bRiNNGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=WTvTTMQg; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a1d6f4714bso73483785a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1721922566; x=1722527366; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EiM0AfqNoljTun5mmx46BsTbCIPS9IOQPLOcGs9Hz6c=;
        b=WTvTTMQg6fEXGuSya5ijLpUoGmrShjxrgNJ1iRvNNMrdFpMDeRYjnxdolycQC0iJ7C
         to6CEKPM8cG8fQxzeinE1joKM0JNqwVvWSNw2nm8OYwGdI+huKx59CREFN73VgLg+fM0
         rG9yTSEzX6fo21YumFeISBoYc5imr+bSYe7EUY9/CkQW9aE92CW84UMs7yW/X0/cAZzZ
         Lx3KtV6QK0BeJyk+AF6ZCyOWKpKK2xclYXrd/cirrmxIVVV07q/Qx7EglnekasW/TCM1
         GFr4jbwl6ihlOS2Kbem0QceS+ZAArTAVYqZG6/7oRya2wdD7VZF8gFPJdFzHdEJ1F1HJ
         q4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721922566; x=1722527366;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EiM0AfqNoljTun5mmx46BsTbCIPS9IOQPLOcGs9Hz6c=;
        b=peFLgp8wmxJoegCOGnWaBE0vPrzqeuI5Mj+Dj3rH19MRw7B0uMaZHAUA0j2QMSWJxw
         9ARx5IuiFEbVLUsCn5sKMRL/cZNT2u8OaQxCNnGKg35EitnQtBvX5JZjoZyk4XU4zFbC
         XvHVAX05l9Rc+uteLcWWDySngkpIfr6729REqAWEBImJJzpVkR1UF9lgiLUtnOSDe0ya
         2ZPO7BhcIweQOUBCaqGDyWAX3bUWHQbIJI/Gi40xX4rn4LaQLXVRLSv86htWfd9sD0PJ
         WVn+qx0PpJdnyZia6VNCPIW+EHnoU8Hkn+O4oPf5z7N5b8hWqHgLf0aKmouHvzRzowUr
         gFRQ==
X-Gm-Message-State: AOJu0YyrE5IoIGYE7ptvvFPrRXOXSEk1/fTL1P8Y1aWjBPbwPfFlkJ3/
	qgwExyCP/5pXw1R/BcpzlxRRVjI/52R0/EbNebMH9aLDFFjDcCfBNn9IgztLReWbZgGE+zrCybX
	eeA==
X-Google-Smtp-Source: AGHT+IFgZ3ufpLznUr7LG1LCx0WI3NJBuDdC+z5cZQIFALz5ESZLkNbSrKc3Gew19LK7hkkxYBVlqw==
X-Received: by 2002:a05:620a:4107:b0:79b:a8df:7829 with SMTP id af79cd13be357-7a1ccd2c6ecmr941885485a.14.1721922565774;
        Thu, 25 Jul 2024 08:49:25 -0700 (PDT)
Received: from rowland.harvard.edu (iolanthe.rowland.org. [192.131.102.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe82013cdsm7167431cf.72.2024.07.25.08.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 08:49:25 -0700 (PDT)
Date: Thu, 25 Jul 2024 11:49:22 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Daniel Scally <djrscally@gmail.com>
Cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Intel SkyLake ACPI INT3472 not working on Dell Latitude 7450
Message-ID: <26eb7093-d777-4071-b539-8e2141117dae@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dan:

The 6.9 kernel fails to activate the webcam on my new laptop.  Comparing 
dmesg logs with the webcam enabled vs. disabled in the BIOS shows 
that the difference lies in the INT3472 driver.  With the camera 
enabled, the following messages appear:

[    5.128560] int3472-discrete INT3472:01: GPIO type 0x12 unknown; the sensor may not work
[    5.128588] int3472-discrete INT3472:01: cannot find GPIO chip INTC10D1:00, deferring
[    5.135938] int3472-discrete INT3472:01: GPIO type 0x12 unknown; the sensor may not work
[    5.135960] int3472-discrete INT3472:01: cannot find GPIO chip INTC10D1:00, deferring
[    5.141230] int3472-discrete INT3472:0c: GPIO type 0x12 unknown; the sensor may not work
[    5.141243] int3472-discrete INT3472:0c: unknown \_SB.GPI0 pin number mismatch _DSM 17 resource 369
[    5.141245] int3472-discrete INT3472:0c: GPIO type 0x02 unknown; the sensor may not work
[    5.148382] int3472-discrete INT3472:01: GPIO type 0x12 unknown; the sensor may not work
[    5.148413] int3472-discrete INT3472:01: cannot find GPIO chip INTC10D1:00, deferring
... many repeats ...
[   17.421707] platform INT3472:01: deferred probe pending: int3472-discrete: Failed to get GPIO

Can you say what's needed to get this working, or suggest a more 
appropriate person to ask?

Thanks,

Alan Stern

