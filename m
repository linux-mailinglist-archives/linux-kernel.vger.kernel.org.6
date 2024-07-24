Return-Path: <linux-kernel+bounces-261561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD6893B90E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 00:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E254281C1C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B90613C9C7;
	Wed, 24 Jul 2024 22:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HpDskiL6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0FC13AD09
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 22:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721859228; cv=none; b=o+n5XLTmWRVN9bDSWopyz8UxK7ccHXPhyOKEqmLxLI5+UoYTgndnPZWKUAcKCPuxv4u1jhzBi+4PDutzPVmEG9i9/bYYjVyTTb9H0VzwbY2RptkV79neCwF5SpC0puhhWZmcQjhdMOhO0fk/8sGIvn3yoPAUXFtl3Pg526AcErU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721859228; c=relaxed/simple;
	bh=vkAFNqSKVtspiIRHbQN+ZkiEShAr8Nf/frkNHKbW+e8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=quFRZGrT0fwVuq1Eq1wStYYPUr4UHj6iHLoTbM+LXTQKsK6Q24Y/mpydl0r8vwKE4kqCDLqst7xwt7hTJ3oOi1ib2l68+9wkQGxt6OANV55oNvkGkfh4rDCID/VpSx67syP9l5f9texDhS8U7LRX80pquxW/8NjEiIqZxd5uCHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HpDskiL6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721859226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sw0iKaz8jS4fOk9hmPzbaMCL/H5mNOf+IQSC96CENPU=;
	b=HpDskiL6RuWpfEVddjCdyWcncVhD1Kd7p1msTkjjdoFKx3WwqJtl/nawQ6Ck6GaVTkUBnQ
	eI9dIwx1rkizyv551R+lTX9QXNJBsx6KrPJw2piWE0ppFwaHMw6RAFE7/cy1h/N09VkWnb
	8iyiPRSSCco03cmLfL7MGpIMZ51BM+Q=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-a5JlGiIGPdOwy0WNPaoURA-1; Wed, 24 Jul 2024 18:13:44 -0400
X-MC-Unique: a5JlGiIGPdOwy0WNPaoURA-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-81f77770290so62430241.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 15:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721859224; x=1722464024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sw0iKaz8jS4fOk9hmPzbaMCL/H5mNOf+IQSC96CENPU=;
        b=J3STxOvrXNgrrt4nPTCWAxfgjqp8fxXXozWYF0PA3d63S8whzZ+fMPI/X9YYGxq5Jt
         RvzoIRCGg1Su/dIieIzJNQL2kCM8QYdH/Zz75l7I8PmZ7Fn/1Sgo+QACo7wvHqwIS7QC
         3G3lQJEzCNHbB4mEOpibS0TChH06WLrQNtI12kJKYigIATkBLae906/GgfNchxv7HSX9
         zqAkvBAEKv6cLVhD3Z0d93/rG6b8/uSUmOxT9BrEw0fhxbsqtCOL+Yb7FTqIlBbG2YeN
         G+/ah/UkxRJxvBZYLRuV/GlRfPgT5apltxaPtgQrtsBu1U0ZZya41a0NdJvhsy+SLUS4
         DunA==
X-Forwarded-Encrypted: i=1; AJvYcCXFmDPv0wusX2GRHh04z7wYLxYmLBCSQITpMqIjJGJuhCQULD+2yXNTNOzmFZN8m4XVHmgyli8E3sWckihfAKGUdDFJ+aJL304g3G1L
X-Gm-Message-State: AOJu0YxG9G3E4gzJ9tT8jdGJbEuiFRnHsITmb6xpJlgceGArmYjkEebg
	VsCpLl4RHrud0HX2GnSxTtG6D9VrG9e+ZHq39LANDNxnGxYbN7s9UHyyWGDxSWsAkUNq3MlVnVQ
	J9He8LXQbEgQWlDLC/oGyza+54HlASa0s6iDRytXPaLC1GLUWp/RvfESU5LhE6g==
X-Received: by 2002:a05:6102:4a98:b0:493:c348:4d9f with SMTP id ada2fe7eead31-493d6500ae6mr1344846137.19.1721859224335;
        Wed, 24 Jul 2024 15:13:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsQ+cIsHRVZ68O/7a6DwUI1enp6pkDl9AmUC4S8XL9tjjdHqZ+lltGBlLy6WAluX50lBmZPQ==
X-Received: by 2002:a05:6102:4a98:b0:493:c348:4d9f with SMTP id ada2fe7eead31-493d6500ae6mr1344835137.19.1721859224052;
        Wed, 24 Jul 2024 15:13:44 -0700 (PDT)
Received: from hatbackup.redhat.com ([71.217.44.209])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d7435227sm7542685a.82.2024.07.24.15.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 15:13:43 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: linux-pm@vger.kernel.org,
	"Thomas Renninger" <trenn@suse.com>,
	"Shuah Khan" <shuah@kernel.org>,
	"Shuah Khan" <skhan@linuxfoundation.org>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-kernel@vger.kernel.org,
	"John Kacur" <jkacur@redhat.com>,
	"Tomas Glozar" <tglozar@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH 0/2][RFC] Add SWIG Bindings to libcpupower
Date: Wed, 24 Jul 2024 18:11:18 -0400
Message-ID: <20240724221122.54601-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SWIG is a tool packaged in Fedora and other distros that can generate
bindings from C and C++ code for several languages including Python,
Perl, and Go. We at Red Hat are interested in adding binding support to
libcpupower so Python tools like rteval or tuned can make easy use of it.

This RFC provides a limited subset of bindings as a demonstration. The second
commit provides a Python test script to verify the bindings. I wanted to get
feedback on this before implementing (and possibly testing) the entire library.

The name raw_pylibcpupower is used because this is a demonstration example that
only provides direct bindings for a few functions. A wrapper `pylibcpupower`
may be needed to make the bindings more 'pythonic'. The bindings folder is used
because Go bindings may be useful for Kubernetes or OpenShift in the future.

How should the bindings be built? The current example requires the makefile
in cpupower directory be run first to generate the .o files needed before
running the makefile in the python directory in a seperate step. Would the
maintainers prefer the two makefiles integrated?

Another question is do you want more test files like the .py example? Would
this be used as part of a greater test suite?

Note that while SWIG itself is GPL v3+ licensed; the resulting output, the
bindings code, is permissively licensed. Please see
https://swig.org/legal.html for more details.

John B. Wyatt IV (2):
  Add SWIG bindings files for libcpupower
  Include test_raw_pylibcpupower.py

 .../power/cpupower/bindings/python/.gitignore |  8 ++++
 tools/power/cpupower/bindings/python/Makefile | 31 +++++++++++++
 tools/power/cpupower/bindings/python/README   | 33 ++++++++++++++
 .../bindings/python/raw_pylibcpupower.i       | 45 +++++++++++++++++++
 .../bindings/python/test_raw_pylibcpupower.py | 42 +++++++++++++++++
 5 files changed, 159 insertions(+)
 create mode 100644 tools/power/cpupower/bindings/python/.gitignore
 create mode 100644 tools/power/cpupower/bindings/python/Makefile
 create mode 100644 tools/power/cpupower/bindings/python/README
 create mode 100644 tools/power/cpupower/bindings/python/raw_pylibcpupower.i
 create mode 100755 tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py

-- 
2.45.2


