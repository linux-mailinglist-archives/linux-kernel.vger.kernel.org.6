Return-Path: <linux-kernel+bounces-282591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E181C94E636
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A4B2B20923
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 05:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E5614EC7C;
	Mon, 12 Aug 2024 05:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W/co81+b"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F4814E2C5
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 05:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723441321; cv=none; b=Vigyb74h6oDRlycpenTNFIrxZwxX1JL7/DL1r2SZARljEYNXrzOtmhQQFT6QcOlWcdK/nn7gijTsKE1l3mTnc3ZXA5IG9W5KckmkLccpdF4NYenZX7qXgwZPPcH4cKf3zO/LWgWLI4bfa8h8jQEcJ9h8oUEbbI6Ay9z/Y4O97Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723441321; c=relaxed/simple;
	bh=nCpR0LOaSAh42EDGtLfTNpur5n6x2leD3RYJrB/i3gg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ew4ne7AKJZS5C4h4IK5pyqjl2TjM6XB5oC9FPZvlj03KsHVqVySQnlZTTQ3VSYuK0T4rFqHGvyh4ZH/uSlnPs9da/BMSN9TVEoMHCyu5O5klqZDdnsVBmseBPFUYj1mK5gjtOagw225Q3Zy1iCxKL0RRCA21Ja7N/oMt9o7zN08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W/co81+b; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7aabb71bb2so404363366b.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 22:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723441315; x=1724046115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6CTGoNaTe2XWjeAV+ihoGUgx18k2VPP6Soz43dQHSQ=;
        b=W/co81+brH2w4M/mrkGm9oC4UUNu1FRkTWnvyn978I8qXYRlgvfWj+YXJeXNIiB1di
         ySAIbcdT4l7NW9t7xkBKa6K/EUwkYrzOyWQv66wqnKs6HUEHqlHaK68FsGuiV2lRGfr0
         caRdE8krIYbG3pawABa1j96kRr1WaOGkZKMsVTmM1zB+/e3mvYgEsIXOQ+LZCz+EjfRL
         c8o49nOExzukYnculcz4o30hcOiFmj9mHTY3B2dwsxXhTce8/9sQO9jEy5Eis2EuSOqZ
         wCDqh1g89ZNhELicSCNqhkcbXVnyaUpiMO8mdjVyp4pyTqc1x+BZmA/AJpjc4fSiW5Hw
         ycFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723441315; x=1724046115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6CTGoNaTe2XWjeAV+ihoGUgx18k2VPP6Soz43dQHSQ=;
        b=MqDyH8cb2LzliYgck4tLWhC43UzW768xoZlkAVChdhKjvAT6VJClHBDIhga0FHC00J
         gTdifdI/SJSn0kBVoBlAPZ9BRWmIhceWcUizOkQa0i/vbG447yLbVuv930QiPQXRVSzn
         I8wcYUNp8NC78a5WYsmbudg25+vkxe26qIuKwxDicNjuSKqC2fue505GDieu/UYoMkpu
         L+Zf1l4rZ7DKB7IuRLP0pvl9Fjevls+G9/fGzyxuFrJZ3rQwlEojZUnQ9pmR43lIIdGY
         yi5Nox7HrF3JufupNxUifP+fyipSnK3+BCevqhliDWpjCujxt5FzuAA1dxUnfszyjRqB
         PQ9w==
X-Forwarded-Encrypted: i=1; AJvYcCU6kAufWpRNNLLG9laNaDQFnrzqwxvfr6+THuhSirJ7xkcM9y9pQe20ZLZU7YgH99m3gXKIJ9+wIdtYb+vFVtBG85UQgzONl3WJ9uaN
X-Gm-Message-State: AOJu0YxkoyFsN3Vqcp0u/IS9Yq074q3yR/Zp7PuGRHG7fCRvQfdN7Re/
	WDYGXjWr3DtWTh9Z3kII+NejxZ3lS0gezN5WTVDeUtdXEiMjZ7H0vzzm/rc3x68=
X-Google-Smtp-Source: AGHT+IGoauMHKJ2VwPdWETVSbpWk0FENKo/8XPyLz6nP7e203aXrsJPM4FhHzcZITRY1Du0txiAk8g==
X-Received: by 2002:a17:906:d247:b0:a72:6375:5fc4 with SMTP id a640c23a62f3a-a80aa55409amr560097366b.11.1723441315427;
        Sun, 11 Aug 2024 22:41:55 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb0e1334sm198172066b.79.2024.08.11.22.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 22:41:55 -0700 (PDT)
Date: Mon, 12 Aug 2024 07:41:52 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: bhe@redhat.com, Hari Bathini <hbathini@linux.ibm.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org, Petr =?UTF-8?B?VGVzYcWZ?=
 =?UTF-8?B?w61r?= <petr@tesarici.cz>
Subject: Re: [PATCH v2] Document/kexec: Generalize crash hotplug description
Message-ID: <20240812074152.321febe5@mordecai.tesarici.cz>
In-Reply-To: <20240812041651.703156-1-sourabhjain@linux.ibm.com>
References: <20240812041651.703156-1-sourabhjain@linux.ibm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Aug 2024 09:46:51 +0530
Sourabh Jain <sourabhjain@linux.ibm.com> wrote:

> Commit 79365026f869 ("crash: add a new kexec flag for hotplug support")
> generalizes the crash hotplug support to allow architectures to update
> multiple kexec segments on CPU/Memory hotplug and not just elfcorehdr.
> Therefore, update the relevant kernel documentation to reflect the same.
> 
> No functional change.
> 
> Cc: Petr Tesarik <petr@tesarici.cz>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: kexec@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: x86@kernel.org
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>

It's perfect now.

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

Petr T

> ---
> 
> Changelog:
> 
> Since v1: https://lore.kernel.org/all/20240805050829.297171-1-sourabhjain@linux.ibm.com/
>   - Update crash_hotplug sysfs document as suggested by Petr T
>   - Update an error message in crash_handle_hotplug_event and
>     crash_check_hotplug_support function.
> 
> ---
>  .../ABI/testing/sysfs-devices-memory          |  6 ++--
>  .../ABI/testing/sysfs-devices-system-cpu      |  6 ++--
>  .../admin-guide/mm/memory-hotplug.rst         |  5 +--
>  Documentation/core-api/cpu_hotplug.rst        | 10 +++---
>  kernel/crash_core.c                           | 33 +++++++++++--------
>  5 files changed, 35 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-memory b/Documentation/ABI/testing/sysfs-devices-memory
> index a95e0f17c35a..cec65827e602 100644
> --- a/Documentation/ABI/testing/sysfs-devices-memory
> +++ b/Documentation/ABI/testing/sysfs-devices-memory
> @@ -115,6 +115,6 @@ What:		/sys/devices/system/memory/crash_hotplug
>  Date:		Aug 2023
>  Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
>  Description:
> -		(RO) indicates whether or not the kernel directly supports
> -		modifying the crash elfcorehdr for memory hot un/plug and/or
> -		on/offline changes.
> +		(RO) indicates whether or not the kernel updates relevant kexec
> +		segments on memory hot un/plug and/or on/offline events, avoiding the
> +		need to reload kdump kernel.
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 325873385b71..1a31b7c71676 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -703,9 +703,9 @@ What:		/sys/devices/system/cpu/crash_hotplug
>  Date:		Aug 2023
>  Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
>  Description:
> -		(RO) indicates whether or not the kernel directly supports
> -		modifying the crash elfcorehdr for CPU hot un/plug and/or
> -		on/offline changes.
> +		(RO) indicates whether or not the kernel updates relevant kexec
> +		segments on memory hot un/plug and/or on/offline events, avoiding the
> +		need to reload kdump kernel.
>  
>  What:		/sys/devices/system/cpu/enabled
>  Date:		Nov 2022
> diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
> index 098f14d83e99..cb2c080f400c 100644
> --- a/Documentation/admin-guide/mm/memory-hotplug.rst
> +++ b/Documentation/admin-guide/mm/memory-hotplug.rst
> @@ -294,8 +294,9 @@ The following files are currently defined:
>  ``crash_hotplug``      read-only: when changes to the system memory map
>  		       occur due to hot un/plug of memory, this file contains
>  		       '1' if the kernel updates the kdump capture kernel memory
> -		       map itself (via elfcorehdr), or '0' if userspace must update
> -		       the kdump capture kernel memory map.
> +		       map itself (via elfcorehdr and other relevant kexec
> +		       segments), or '0' if userspace must update the kdump
> +		       capture kernel memory map.
>  
>  		       Availability depends on the CONFIG_MEMORY_HOTPLUG kernel
>  		       configuration option.
> diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
> index dcb0e379e5e8..a21dbf261be7 100644
> --- a/Documentation/core-api/cpu_hotplug.rst
> +++ b/Documentation/core-api/cpu_hotplug.rst
> @@ -737,8 +737,9 @@ can process the event further.
>  
>  When changes to the CPUs in the system occur, the sysfs file
>  /sys/devices/system/cpu/crash_hotplug contains '1' if the kernel
> -updates the kdump capture kernel list of CPUs itself (via elfcorehdr),
> -or '0' if userspace must update the kdump capture kernel list of CPUs.
> +updates the kdump capture kernel list of CPUs itself (via elfcorehdr and
> +other relevant kexec segment), or '0' if userspace must update the kdump
> +capture kernel list of CPUs.
>  
>  The availability depends on the CONFIG_HOTPLUG_CPU kernel configuration
>  option.
> @@ -750,8 +751,9 @@ file can be used in a udev rule as follows:
>   SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>  
>  For a CPU hot un/plug event, if the architecture supports kernel updates
> -of the elfcorehdr (which contains the list of CPUs), then the rule skips
> -the unload-then-reload of the kdump capture kernel.
> +of the elfcorehdr (which contains the list of CPUs) and other relevant
> +kexec segments, then the rule skips the unload-then-reload of the kdump
> +capture kernel.
>  
>  Kernel Inline Documentations Reference
>  ======================================
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 63cf89393c6e..c1048893f4b6 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -505,7 +505,7 @@ int crash_check_hotplug_support(void)
>  	crash_hotplug_lock();
>  	/* Obtain lock while reading crash information */
>  	if (!kexec_trylock()) {
> -		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> +		pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
>  		crash_hotplug_unlock();
>  		return 0;
>  	}
> @@ -520,18 +520,25 @@ int crash_check_hotplug_support(void)
>  }
>  
>  /*
> - * To accurately reflect hot un/plug changes of cpu and memory resources
> - * (including onling and offlining of those resources), the elfcorehdr
> - * (which is passed to the crash kernel via the elfcorehdr= parameter)
> - * must be updated with the new list of CPUs and memories.
> + * To accurately reflect hot un/plug changes of CPU and Memory resources
> + * (including onling and offlining of those resources), the relevant
> + * kexec segments must be updated with latest CPU and Memory resources.
>   *
> - * In order to make changes to elfcorehdr, two conditions are needed:
> - * First, the segment containing the elfcorehdr must be large enough
> - * to permit a growing number of resources; the elfcorehdr memory size
> - * is based on NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES.
> - * Second, purgatory must explicitly exclude the elfcorehdr from the
> - * list of segments it checks (since the elfcorehdr changes and thus
> - * would require an update to purgatory itself to update the digest).
> + * Architectures must ensure two things for all segments that need
> + * updating during hotplug events:
> + *
> + * 1. Segments must be large enough to accommodate a growing number of
> + *    resources.
> + * 2. Exclude the segments from SHA verification.
> + *
> + * For example, on most architectures, the elfcorehdr (which is passed
> + * to the crash kernel via the elfcorehdr= parameter) must include the
> + * new list of CPUs and memory. To make changes to the elfcorehdr, it
> + * should be large enough to permit a growing number of CPU and Memory
> + * resources. One can estimate the elfcorehdr memory size based on
> + * NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES. The elfcorehdr is
> + * excluded from SHA verification by default if the architecture
> + * supports crash hotplug.
>   */
>  static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu, void *arg)
>  {
> @@ -540,7 +547,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
>  	crash_hotplug_lock();
>  	/* Obtain lock while changing crash information */
>  	if (!kexec_trylock()) {
> -		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> +		pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
>  		crash_hotplug_unlock();
>  		return;
>  	}


