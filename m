Return-Path: <linux-kernel+bounces-199562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B7E8D8896
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 20:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184B01F238DD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2D81386B3;
	Mon,  3 Jun 2024 18:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BSMO5vOY"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7A2132804
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717439250; cv=none; b=OLENR2buCrEgrKbEStZDc7yh6HdTGTtasPa3bu+EHtm37db/nw7hNK9Zr9mwWEvyjvQ1OFQmhOAnQ9b5K2vRhSF4Ae/JpfiTGe7gyCp9bv+TX4PXgE8+FzLmncwcwJlRYwkVqmzwpePw9oc9P+OfllEc9C9WILu1RCUFX+20PtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717439250; c=relaxed/simple;
	bh=a2ix+CxhqvYcsQIN8fnCjkHy/IPdu8haOIon0MmL5S8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JwCgP/2UmA9dgfFKUAMeKsF9VjmqsWUdlzdb3D8dADhHipagDJqfSVsE4fo6aDLl4+CDXX1WJGKm2riqN9w0dUAYzzdQjnSlc6sKIvCANJ9NiTdpHwZgSaAkIMV0743Duso1Mx2+9eZlLVoAcuBofGMIIwpH8IKJnrwpAN+CqPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BSMO5vOY; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70264bcb631so1297660b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 11:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717439248; x=1718044048; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQZ7pJhWzrnWrAArcMbWFf+ClUA0PNfqT/R1+wW2GPg=;
        b=BSMO5vOYCYPy5iQBI+Ghb2MyGAZh/JSRZpK5e/mZa0fY9T9j6YkixA+JURrKev7F+s
         /2hrLaampD4vpjnWNCZxTA6PZRSd8GfEK2VDB+fSl6ViN/ymY42iWhz+YRatBVKNZ2gP
         1M5+ynpCLz2dEWj1Zd5uJddIxPosd9CLXG5sZyS5mSQW/zsio1/nKYaePAk6KzBCsXo/
         9RY2TeTKB8/KrqhGy2YL1hZrhzkmE4aY1sp9SA6Qq3Bkp1C1m/+s2zorVLo3WLqLNII7
         9z3C86W1UqHYwJhFn7qAafwN1hNEsoUZCWZqZ0w/3ROm+qVHiUGwH7vftfC/4En/Qrg2
         346g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717439248; x=1718044048;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQZ7pJhWzrnWrAArcMbWFf+ClUA0PNfqT/R1+wW2GPg=;
        b=AuSYg9H8EQzuUvXzS0k4TY4N9O1ipUExstP/D+nnzdE/c9s6ERYT+m8yjbtvJAOT2n
         0x10FgaxS83SeJ+bsNLDQGHNPdwL5ByblIT1f+1QVPNMLzIo7rIfx52VSqqGjCw8RjYw
         bkvDKZ600iLfW3/JY4G2tPo1XdemXW3uTH48VLWfGeNX06d+HYgrj61YYuyzy0yAvItn
         qyVW8GJ3nTP9aTLA8MLU79+QBYAti7KwJSH23wSONZoNsC0g9vNl1kTXkYgAfEWrfpem
         5z2MZ+4lbWoqd7DaZLmGb7Bw5eJB4lrf4cPLuw76X5PAV+ADB52WoOBnbxT7zSH6w7Lb
         Qb5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVcby/I55FxPlVNY5NxYVRq3uoAmFyWwHMiIlFU91iRNlZVTTSAnEuIzFEgC58u5PmydykYeDF1jjwDJsjm1nshzpwrlwX5p4+X6H8n
X-Gm-Message-State: AOJu0YwQ+XholQ29ssjiyiHSymZhHRVHLEIz6gyBCkCDzI7jwrdZOA3Q
	ThbxFIaQ+7nyb5xLGpHHpnxgllcpQlph5njLJX0ATTJq8NSkmFoyuWWzDZ2m+g==
X-Google-Smtp-Source: AGHT+IG9pOSZfsbyN0C6+FoYiF185CBi2wu43FjbL73OSlUP60i5AI74/j2vAb6zJ6bCnI6Vjzs60g==
X-Received: by 2002:a05:6a21:3393:b0:1b2:5e40:bc63 with SMTP id adf61e73a8af0-1b26f18577bmr10388643637.28.1717439247870;
        Mon, 03 Jun 2024 11:27:27 -0700 (PDT)
Received: from google.com (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70259fe3e6asm3682729b3a.52.2024.06.03.11.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 11:27:27 -0700 (PDT)
Date: Mon, 3 Jun 2024 18:27:23 +0000
From: Carlos Llamas <cmllamas@google.com>
To: linux-mm@kvack.org
Cc: Mike Kravetz <mike.kravetz@oracle.com>, Andi Kleen <ak@linux.intel.com>,
	Hugh Dickins <hughd@google.com>, Edward Liaw <edliaw@google.com>,
	kernel-team@android.com, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Header conflicts with shmget() and SHM_HUGE_2MB
Message-ID: <Zl4LC9lTNptB2xTJ@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi, I'm trying to figure out how one would use SHM_HUGE_{2MB/1GB}
defines through shmget() from userspace. After having a look at the
man-pages I thought the #include pattern would be similar to that of
mmap(), e.g.:

  #include <sys/mman.h>
  #include <linux/mman.h>
  [...]
  	mmap(NULL, size, prot, flags | MAP_HUGETLB | MAP_HUGE_2MB,
	     fd, 0);

However, when doing the shmem equivalent with the headers I get several
redefinition conflicts. When attempting to compile something like this:

  #include <sys/shm.h>
  #include <linux/shm.h>
  [...]
  	shmid = shmget(key, size, flags | SHM_HUGETLB | SHM_HUGE_2MB);

I run into the following type of issues:

  /usr/include/linux/shm.h:26:8: error: redefinition of ‘struct shmid_ds’
     26 | struct shmid_ds {
        |        ^~~~~~~~
  In file included from /usr/include/x86_64-linux-gnu/bits/shm.h:45,
                   from /usr/include/x86_64-linux-gnu/sys/shm.h:30:
  /usr/include/x86_64-linux-gnu/bits/types/struct_shmid_ds.h:24:8: note: originally defined here
     24 | struct shmid_ds
        |        ^~~~~~~~

I can see such definitions are tagged as "obsolete" in the uapi headers.
Do we need some ifndef protection with the glibc headers?

What is the advice to follow for userspace? Skip <linux/shm.h> and
openly redefine the SHM_HUGE_* wherever needed?

Thanks,
--
Carlos Llamas

