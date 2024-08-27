Return-Path: <linux-kernel+bounces-302657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 999C6960188
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B859B21A58
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3C3143759;
	Tue, 27 Aug 2024 06:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g5JQdUOi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ADABA49
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 06:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724739942; cv=none; b=oIEOJrbElT5sRl9jd7FuF+59OPqJbEtAoTS0IZqLdUVB/eU1Zxk7uiJb810ZtiBRMkSVYP3tE6wVvjbKAh3IVvqWG4oJxbsnx/ymAdpeODDCTW4lI6LrXDsOncPrptJWvvVZwNzq1L4xAUZ5fwWSa7XUi+P2+ADyC8HOQGvyaAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724739942; c=relaxed/simple;
	bh=wLOZRoP2rCUX34UsELGnogltijstDh57sTW3CSCim8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SLLrnI8eV7YgsFXZFJta1rYCo7H/STih4VJKyBhUc4bQCF+S/cKFJ9usG6+o3I7C9ry5gZ94OHoVsX3pOv0TQHFX/WmAs2anMZMmaM+Yy0KtEr0LuxeDC7TdtwP2CiLgh6kPcyDG4aza7ev/SWzHky1mfAgrf3wKDi5lwCq7dag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g5JQdUOi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724739939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XeQMIYTnf+XexoNiwV2cnhT2tLUAhCdUh4JVRVTo888=;
	b=g5JQdUOiHlMB4lPMh6claB5ijJMD91u7Pmf1YoboSv+nWnsbl7pWWTM/oYremsYYihbjN7
	PDEByLItpzJYesXPG+IpEyTRoJdCJfXdgJJ5ZBSIERnkSvEj3vbkj5Y8+tU6TlhqltI82i
	HHsI2wcWk/cVSh8fNYjs9ai+MY+8Vuk=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-wOkgYFW2P_aYcC6SiLn8UQ-1; Tue, 27 Aug 2024 02:25:37 -0400
X-MC-Unique: wOkgYFW2P_aYcC6SiLn8UQ-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-498d9003facso1914948137.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 23:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724739937; x=1725344737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XeQMIYTnf+XexoNiwV2cnhT2tLUAhCdUh4JVRVTo888=;
        b=KcrMFZA8D+CjXB5Q4l9ZCKs48NERTcOc1LazhwH2UCHvCL2suiu0p6m/NIjpcNtFCH
         qCRgF3/HzEzHFLyENN0szVovaQA5NC+tauMwGdWIkJEntavZe7XEv78voRobjOmfpb9i
         kbiaj0VShMsdWyLAgVKr8ykf17aVXk2Lbp3elqaiz7ZxcGHHSiygNXe78hwmeIj7KPpt
         aXC8FWxuEydW5TLyWIpzq5dKE2TxNiKGL2K4g3ZmpEaOjX/XcrHSo6iey3bMkZMb4Zwy
         S0xHpbq3TmKQ0lRq6o2qUb+Lu7VzMaovNoD7lOgCmGDxiZJ0wGqhRKKnK12Y+sremFQ0
         PQAw==
X-Forwarded-Encrypted: i=1; AJvYcCXDSEvuEtDnWoQabKrXgFLSGrYWURfK/rR1uZPIrQeCHRCVR8pmPhdFtWM8E6SBFOkPghUcG4S9I7rUxi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC6NequL8YPYBroTkzqCgP8rdE6qoNVbZ4nMCmkXrLBtYezUH4
	6Q+DOt35cxHkf54uBxlmzCiXRnLHMMo90PFYoH5vDPUFoqPKXiGIl33Tnh2RESGbZJ4KIzSAwpU
	0hbc2eBwH7VKgsvLtOq1M/oUncla/FysARmRwi+W1tvU0iukLs9T5nw3iACEFXQ==
X-Received: by 2002:a05:6102:3a06:b0:492:9394:d1e with SMTP id ada2fe7eead31-498f4640371mr9096218137.14.1724739936650;
        Mon, 26 Aug 2024 23:25:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvhJviliNCP7B1YX1z0Y/cJT0ncQOEY0a3jmJLi7NjKouv2pIFbOuxOJci5vzkeIFAoYzsSQ==
X-Received: by 2002:a05:6102:3a06:b0:492:9394:d1e with SMTP id ada2fe7eead31-498f4640371mr9096205137.14.1724739936184;
        Mon, 26 Aug 2024 23:25:36 -0700 (PDT)
Received: from rhfedora.. ([71.217.43.75])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f1fe176sm521044185a.0.2024.08.26.23.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 23:25:35 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-pm@vger.kernel.org,
	Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Arnaldo Melo <acme@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH v2 0/4] Add SWIG Bindings to libcpupower
Date: Tue, 27 Aug 2024 02:24:32 -0400
Message-ID: <20240827062438.71809-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SWIG is a tool packaged in Fedora and other distros that can generate
bindings from C and C++ code for several languages including Python,
Perl, and Go. Providing bindings for scripting languages is a common feature
to make use of libraries more accessible to more users and programs. My team
specifically wants to expand the features of rteval. rteval is a Python program
used to measure real time performance. We wanted to test the effect of enabling
some levels of idle-stat to see how it affects latency, and didn't want to
reinvent the wheel. Since SWIG requires the .o files created by libcpupower at
compilation it makes sense to include this in the cpupower directory so that
others can make use of them.

The V2 of this patchset includes:
* the full definition of libcpupower headers that is needed for the bindings
* dummy implementation in C of a function listed in the header of libcpupower
(requested by Shuah Khan)
* test_raw_pylibcpupower.py demonstrates an example of using the bindings
* adding myself and John Kacur to the cpupower section of the maintainers file
(requested by Shuah Khan)
* addressed review comments about doc, makefile, and maintainers file
* small style and other fixes

The name raw_pylibcpupower is used because a wrapper `pylibcpupower` may be
needed to make the bindings more 'pythonic' in the future. The bindings folder
is used because Go or Perl bindings may be useful for other users in the
future.

Note that while SWIG itself is GPL v3+ licensed; the resulting output, the
bindings code, has the same license as the .o files used to generate the
bindings (GPL v2 only). Please see
https://swig.org/legal.html
and
https://lore.kernel.org/linux-pm/Zqv9BOjxLAgyNP5B@hatbackup/#t
for more details on the license.

Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat

John B. Wyatt IV (4):
  Add SWIG bindings files for libcpupower
  Implement dummy function for SWIG to accept the full library
    definitions
  Include test_raw_pylibcpupower.py
  MAINTAINERS: Add Maintainers for SWIG Python bindings

 MAINTAINERS                                   |   3 +
 .../power/cpupower/bindings/python/.gitignore |   8 +
 tools/power/cpupower/bindings/python/Makefile |  31 +++
 tools/power/cpupower/bindings/python/README   |  59 +++++
 .../bindings/python/raw_pylibcpupower.i       | 247 ++++++++++++++++++
 .../bindings/python/test_raw_pylibcpupower.py |  42 +++
 tools/power/cpupower/lib/powercap.c           |   8 +
 7 files changed, 398 insertions(+)
 create mode 100644 tools/power/cpupower/bindings/python/.gitignore
 create mode 100644 tools/power/cpupower/bindings/python/Makefile
 create mode 100644 tools/power/cpupower/bindings/python/README
 create mode 100644 tools/power/cpupower/bindings/python/raw_pylibcpupower.i
 create mode 100755 tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py

-- 
2.46.0


