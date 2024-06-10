Return-Path: <linux-kernel+bounces-208533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35631902656
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 957C3284BFF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182EF143742;
	Mon, 10 Jun 2024 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzxCXNJt"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BA21422D5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718035907; cv=none; b=X7lImxAUqAtxj/hkb+IAO5HBWfk5vup5RW0HRfJrdCrRV+PqQaYl4HUs8kwsrwuKuc0TU85g9z/7Cavu8VkC5zPWhjgoNoA2CrTV28iFXUxHLxi3FBvH9hchg5a1CkgHW225msSzB/JSZPu2+A2LTocjel7nQxilInl3+clWOC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718035907; c=relaxed/simple;
	bh=8PyZOvtdFs4jstvaTU5WWR+FuhXbfdIgX/IVFoSXpqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYMXXzo7Ts+jX4dWrMwiy9YDahZDrzfPbdoCvjEyUiI7GWMQJLX7rkEWP+JrAROH805MCqKx03sQlT8PckJaKrK3RcoQ1fRFCEeD4atFBGPXi4w/kwPi+u4Mz29D+ip0Ad4V7nlt0+lTK24wEPoZ4s3chMQ/Z4aaKnAWxc/ViEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzxCXNJt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f44b441b08so137305ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 09:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718035905; x=1718640705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6ZXxsgtfP1Sq+vCpMXkoGmxyb9Yzoerz6YROXEE4cg=;
        b=hzxCXNJtB23wMCU3ujywUgU8qBEP9PwoNuN/au+DpFHgyswhEJBXTEWHRleAAlgMxx
         X8PL0fj6716ycFfMfZg0bFJa3yiRNFjRLjnXL2lXq6G3gaLTcwBxe8xBfRdh/VIwr/zD
         0ReWqrXsNLuxFxE0HbKEFsuMeK1oeD+4htokejtg/bTn+EM94QspPh0JiB/kOitsK1Sh
         fWVjdB++J7S6ksUQ3QpgGx++nE9iWV3kp3U1j055jecptMnWJGPYM3fcfzem2BDv5XS8
         HP8OIXS75I3TKlnnYXHUrJetuLrQ/jv2bgAfY8cef7a4IhYUwBM4EIkePwiVwTXVLGre
         Qc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718035905; x=1718640705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6ZXxsgtfP1Sq+vCpMXkoGmxyb9Yzoerz6YROXEE4cg=;
        b=V95kEdkz40I/LYenn1Adg41IooWm3gPab9mW89MOlagVBgZ9f9TwGRq/74sG0JyeVw
         pJnLTmty0LU1FzUGA38TW28yw6JdiFJowDGlnQkZ2T/xJgg2wQO/Zt+60zvF4FTe95LG
         XGSBIxlAuiHmvI8mJmYgoQEudwrZUkF5iG1SCYoz0hQsXTzIdULkIRFP26ds/PQOW81q
         K02cjQ2JgCju+DSV7/IC2Kwvb4mPBkWxX+eMiW7DFpl9NQVxKSn3l8cYVqN/jXHwc/ku
         apEapzri0+OI5WICwcesTk3hl/eUQTTk9bKxkDhk4W1PWZGsoq0X2W9pqGzXSKn1A8zo
         1BgA==
X-Gm-Message-State: AOJu0YwxgH87xzkNXDEzFsrxn8X8BMa9Ao1/zcbSI6f8CvBGe32wytrJ
	L6f3xCGIKvfAQFexLnC1xUq6qMGIxvih4Ci0Uy5dh69Duzwd0Y6Z
X-Google-Smtp-Source: AGHT+IHzZgOQ0E0Cg3QHUoHYs9KezSYIt9yVbZqXgeFOEWkxEm/ryw1/tVmaaXncFaW0eCD4ulj4YQ==
X-Received: by 2002:a17:902:ecc1:b0:1f6:ff48:1cd9 with SMTP id d9443c01a7336-1f6ff481ebemr55384685ad.69.1718035905067;
        Mon, 10 Jun 2024 09:11:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6fad0cc37sm38870595ad.187.2024.06.10.09.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 09:11:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 10 Jun 2024 09:11:43 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.10-rc3
Message-ID: <643a620e-3c91-4e60-9310-d49ce4eef1ef@roeck-us.net>
References: <CAHk-=wiK75SY+r3W5hx+Tt_bjhcSKPLdji-Zf_8HjikRPbn9wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiK75SY+r3W5hx+Tt_bjhcSKPLdji-Zf_8HjikRPbn9wg@mail.gmail.com>

On Sun, Jun 09, 2024 at 02:27:01PM -0700, Linus Torvalds wrote:
> Hmm. Absolutely nothing stands out here.
> 
> We've got driver fixes (networking, gpu, HID and x86 platform drivers
> account for the bulk of it), architecture fixes (mostly kvm-related),
> and some core kernel updates (filesystems, mm, core networking). And
> just the regular random fixes.
> 
> IOW, nothing looks particularly odd, and size-wise this is also pretty
> much right where you'd expect for an rc3.
> 
> So things look good, the water is warm, please jump right in and keep testing,
> 

From my testbed:

Build results:
	total: 158 pass: 158 fail: 0
Qemu test results:
	total: 470 pass: 469 fail: 1
Failed tests:
	m68k:mcf5208evb:m5208:m5208evb_defconfig:initrd
Unit test results:
	pass: 228426 fail: 0

The m68k test failure is really a build failure.

Building m68k:mcf5208evb:m5208:m5208evb_defconfig:initrd ... failed
init/initramfs.c:578:31: error: 'sysfs_bin_attr_simple_read' undeclared here (not in a function)
  578 | static BIN_ATTR(initrd, 0440, sysfs_bin_attr_simple_read, NULL, 0);

seen with m5208evb_defconfig+CONFIG_BLK_DEV_INITRD=y. It was introduced
with commit 66bc1a173328 ("treewide: Use sysfs_bin_attr_simple_read()
helper"). The fix is available in linux-next as commit 44a45be57f85
("sysfs: Unbreak the build around sysfs_bin_attr_simple_read()").

Guenter

