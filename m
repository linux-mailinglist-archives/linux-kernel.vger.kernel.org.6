Return-Path: <linux-kernel+bounces-559664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F49A5F75F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EC763B2802
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E498D267F4E;
	Thu, 13 Mar 2025 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MvDU8a+0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1210266EFF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875138; cv=none; b=chAbMzrcd8MENGq7KlA3gRIcCrxNPNsQjKrIfg1kAgOmbAtntC8casd9/hHNxBgjU+E8TWmz4BNomlAkOZ1uQGodS740j9yLWpUilC81LAqUuwXBuS/Ovbfw8ixSB9PaFGB4r9GvnN02fqbqOQnH/a43VK0XQ4L7eMhpABifMi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875138; c=relaxed/simple;
	bh=EQb0SSqK+nGH9Bh8+yrxOQuY4w2JsbtSQJQgNEbhL5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJRSaQuF/IXIoi6KlKaDGtPHBxEwvRwjPLsuXyfK9jwgPRkO53iLVOQhySb1RliES7V8nPFSpMEBu7javNUynPDxSmmRy4yXEoAQ/N8nw+6l/um9K9/ttzPWx/4gt6odfypi8RjdUd39WShs701LDyUHbk7L7WL3yGo4gkXNtDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MvDU8a+0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741875135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xTSCTViFsCC8M3AWW7+HEFBBSa3sEutKnMAaO+/MsLQ=;
	b=MvDU8a+0jLgMjbq4ump1yzYjjpxsx3LPnTHgmG5ho/QKHQInVLKmnbts+pB+fllFdGMVgm
	o6JZi63lNnP7lrV+3c2CN1AqTo8Y9WuQQYUMbBhL+YBSIgB5OtzJ+lfiTmp67evL1/rlrg
	MZpkBfqFEwt7T/XNdlYLS+ou7EtGVPc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-ehQpkj3fORasmbbTeny4-Q-1; Thu, 13 Mar 2025 10:12:13 -0400
X-MC-Unique: ehQpkj3fORasmbbTeny4-Q-1
X-Mimecast-MFC-AGG-ID: ehQpkj3fORasmbbTeny4-Q_1741875133
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e90b13f5c3so22919186d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741875133; x=1742479933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTSCTViFsCC8M3AWW7+HEFBBSa3sEutKnMAaO+/MsLQ=;
        b=BglB+sI9ltUTyIID7M7eLSySuUIlbDrHpxPxv328d8FGmLcus5K0Jc3l1sPaVZwBe3
         qioilx7YX1G+vIK3UGaTR13/9sAOWkKxXENFNxwYRUeSKFEplb6iOvWGoNxKOyjNfXs4
         2JWgOlkYzUBiTQfHhlN5TwSY3uq5m/9vp1AcQ60XDuFOJgPJfPAmdSoLsOUBhnOtHglj
         3qXDi+OFyTnCUpRRyZ5wZKGWfdEac4aT11/+417lF73dVFxASOvN+AwuOqfbGH/IvFlD
         ayRUjojvAb2Mv3sH1piNSSQ/FTvYc04v05XmEoUMmRWpwQ1gMoWzyRsnkei8ybQl0nhR
         d4cw==
X-Forwarded-Encrypted: i=1; AJvYcCWdccAZ665ml37fQSNumG9Oxt+Ow2MTyxuhm9LAQGFkuindzy3dyLlKdkfz2i3FBJThUayGhY1u+9r2BP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy16ck/EPgPPf27dfserckDLCAgXzIwFfp0XtZwN9PpIC/RvdGX
	PHyF6hB2y+bGrJVOSd6rfB0Ep/pUHfBb06eCQhoHD6qGJRU61HOuoPN20Z6dVGjEplA0NXF7hau
	OUQg9oiJmeCz9o+hiIz9adW4dnzToeKi/eAtLHciZWn+eDAVveISq437A7T8b8g==
X-Gm-Gg: ASbGncuyJYpRBdU6w4NxH0vhO6QVD5a3yAHRPANqWY6nUlyA3BgVB4NgqOvGuITw3v0
	PdxjKR/FvfsXKJDlQzbXHwVXfFi5N3sKt/Qf1/o22KuEUTWQKtNJ/qs7iP+c7W3T5OeNQdUqJzX
	IiJXnVDuOr0wFtWR6T7c3VGTbcRUAhK/H4RqriYKo9IYYbDm+FLx46XEMsQjAQtZfpFS+j9ZWhk
	5yLNL/4vArBT5FJRLwHLmJ+ZxL0yh5/q2NwsqlNZx86fw6mfmzetpDdq+IXa5VOvgrzc+LXAqyo
	U0VHISWiosI=
X-Received: by 2002:ad4:5beb:0:b0:6e8:ed7f:1a79 with SMTP id 6a1803df08f44-6e9006773e7mr422214946d6.32.1741875133050;
        Thu, 13 Mar 2025 07:12:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSdv1Udz8OiduVCV/r0UNSUpke1W8wSfiJZ1L2LpzbF7s+BBan2QBwjnmyG0rUa71XbBcyYw==
X-Received: by 2002:ad4:5beb:0:b0:6e8:ed7f:1a79 with SMTP id 6a1803df08f44-6e9006773e7mr422214486d6.32.1741875132694;
        Thu, 13 Mar 2025 07:12:12 -0700 (PDT)
Received: from thinkpad2024 ([71.217.65.43])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade330c68sm9983166d6.82.2025.03.13.07.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 07:12:12 -0700 (PDT)
Date: Thu, 13 Mar 2025 10:12:09 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] Introduce a C extension module to allow libperf
 usage from python
Message-ID: <Z9LnuXCvK5P5KCiU@thinkpad2024>
References: <20250313075126.547881-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313075126.547881-1-gautam@linux.ibm.com>

Hello Gautam

On Thu, Mar 13, 2025 at 01:21:21PM +0530, Gautam Menghani wrote:
> In this RFC series, we are introducing a C extension module to allow
> python programs to call the libperf API functions. Currently libperf can
> be used by C programs, but expanding the support to python is beneficial
> for python users.
> 
> The structure of the patch series is as follows:
> 1. Patch 1 : Create wrappers for the perf structs which are used by
> examples/counting.c
> 
> 2. Patch 2: Create the C extension module that maps and exposes the
> libperf functions to python programs

May I ask why you are not using SWIG? With libcpupower the kernel has
already been using SWIG to generate Python bindings for a C user-space API.

This has several advantages including a much smaller footprint (you only
need to copy the header definitions into a .swg file), can generate for
several languages (Perl, Ruby, Java and C#), and SWIG is an active,
tested, and mature piece of software code that has been around for
almost as long as the Linux kernel.

Python bindings including the makefile as an example:
https://elixir.bootlin.com/linux/v6.13.6/source/tools/power/cpupower/bindings/python

How to use the bindings in a script:
https://elixir.bootlin.com/linux/v6.13.6/source/tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py

Original discussion:
https://lore.kernel.org/linux-pm/20240724221122.54601-1-jwyatt@redhat.com/

SWIG has been pretty useful as it helped me find two issues in the
libcpupower API that have been around for over 10 years:
https://lore.kernel.org/linux-pm/20240905021916.15938-1-jwyatt@redhat.com/T/#mf04b4ba93f79fe68c20c1d88d8ed966164a1c7d7
https://lore.kernel.org/linux-pm/20250305210901.24177-1-jwyatt@redhat.com/

> 
> 2. Patch 3: A python variant of counting.c - counting.py to demonstrate
> the usage of libperf from python
> 
> We have not added support for entire libperf, as we want to get
> community feedback on the approach taken in this series.
> 
> Gautam Menghani (3):
>   libperf: Introduce wrappers for perf structs to be exposed to python
>   libperf: Introduce a C extension module for python
>   libperf: Add counting.py example to demonstrate libperf usage from
>     python
> 
>  tools/lib/perf/Build                          |   1 +
>  .../perf/Documentation/examples/counting.py   |  74 +++
>  tools/lib/perf/Makefile                       |  12 +-
>  tools/lib/perf/include/perf/py_perf.h         | 431 ++++++++++++++++++
>  tools/lib/perf/libperf.map                    |   1 +
>  tools/lib/perf/py_perf.c                      | 262 +++++++++++
>  6 files changed, 779 insertions(+), 2 deletions(-)
>  create mode 100755 tools/lib/perf/Documentation/examples/counting.py
>  create mode 100644 tools/lib/perf/include/perf/py_perf.h
>  create mode 100644 tools/lib/perf/py_perf.c
> 
> -- 
> 2.47.0
> 

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


