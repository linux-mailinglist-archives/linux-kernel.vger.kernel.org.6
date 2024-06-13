Return-Path: <linux-kernel+bounces-214079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C8A907F27
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18A1C1C22837
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 23:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3D914B090;
	Thu, 13 Jun 2024 23:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BU16xhib"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019B3757E0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 23:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718319686; cv=none; b=FQ3iKSR19aSzbjTwbOU7OVQcvAB77ZoLqZLqNCRpAFzVU9Von5SRtxrESon0eEetUhxOusdv5P+ZoL/QbulBdmNKyhyExmHQiEisDuIJyDcFWWFU2IYIbpQL9Dsq+xd/b4T9EAe7bq+TOHoIaRZaUIH4+xyMdTyuTahwWcrqOzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718319686; c=relaxed/simple;
	bh=7qRzL3/rFlFAHnkTccB47kfalUYR0QQRNpd2AEffK4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N06G2mWDkiaHfwTmTDAYKCFbFXJqzpX7Mv9TjbcP+yRQFJpz/u3cKONpB9SOKvyyzKczF2VU9aVYYBMy/AKRCPF/MPeEOuOR5dpjxgmTfW+oZyBGe9c8Rwb8kRr2x6qyOoIKQw+a9rGnTulpCFr6vu29YxRtwjR6vYSEmAhI8kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BU16xhib; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-35f22d3abf1so1470143f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 16:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718319683; x=1718924483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsgR3vbidd/cU/+kmzVj8gsTc1SpNyhRUL8VQVP8ayc=;
        b=BU16xhibzDx0PThP9HNY6Xcv/5Jotlg7avttzxa0Gud9o248hOt8H9nTqSA5oM2i84
         0rOoTz5bHCTdB+E7aXxTjtef4tggZJm727VoX7Kf2BX048mlJZhEyTY34IpOKNkOLqw3
         /CZZUFmy7qP3ml9ycMSOVuHQsndWt5SZ4m6HA1cKGvMZao/fmwc6kbISSkatxrI7KhQk
         1Z6hUPBKNT+7XIEsiSoqijNrN9FrJPOyh8ZjLGiLi9/JUULOn8g3OIpzk+EFvobK3ZpV
         0tj7XiK/kIVmBNXLDDyRw8czeewydr35yY+2Om50CRAP3zS/PA1hAmvbmputLqd2qn2A
         CkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718319683; x=1718924483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UsgR3vbidd/cU/+kmzVj8gsTc1SpNyhRUL8VQVP8ayc=;
        b=EEKM/3iTYeZNKRSG7TiPZ2spX/klpTAWGwUyn7CCLuEC7YE4RwGFyOeff3KNrRh0s0
         bwhbs8MIQhiFlGP7ZySCHSLhr1EoiaXEakDQijJM1Au2CP+nkRfDsQKgdk/DI6k1Dtxf
         7hfFLf+Zwt8EEIQQBIMEb3lYI75UMR02Qc6jpuIFm+W0ltMwgD87Whinomdu+G0YszVn
         B2Sdy9iFzi3+ydi8OZF7ifQ1RnbW4PpB6QsFmot55Y8UlNNFhAhe0nvwkzHS/I3mTAPy
         9DNqQstMq2m3Ws52MXinSpacPaIKYV+PWIu1UfzYtKX8APvedfI4N6G6TLSG6go6yFhk
         74zw==
X-Forwarded-Encrypted: i=1; AJvYcCUmShe5HC/iht3RdDBcIiH+ZvviuJT4l/IGn+G2HbuAIdW/Cq265hcfCbnnN6u8P3B1fOjK985X4ofcswVC2RHWlYukTuytQ1mOP/NS
X-Gm-Message-State: AOJu0Yw/prznlTnsyoSnAYN3oHzo9gRlwZP8xRKiawSBulDapRuz9lQQ
	0Hg9/aUmfcsxn7V3unXmNiwyfIP2Nv7SFk+C8V+ASzYjzwMj9KFrO1ljPOI4rLZXI0XZ9jHrEnR
	6V4anMDg3UK6mvOuBaDhQRbWE1jw=
X-Google-Smtp-Source: AGHT+IErZ5mciFEMUbeoJjX/bfOy8YtG8MNSE8yqTLj4b1zZjgUuCWWM0PivCg0lABSvKxOLjiqJ68dje/TpjTAht/4=
X-Received: by 2002:a05:6000:1a86:b0:35f:3189:ddd2 with SMTP id
 ffacd0b85a97d-3607a7687f8mr1097172f8f.35.1718319683296; Thu, 13 Jun 2024
 16:01:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718092070.git.dvyukov@google.com> <7662127c97e29da1a748ad1c1539dd7b65b737b2.1718092070.git.dvyukov@google.com>
In-Reply-To: <7662127c97e29da1a748ad1c1539dd7b65b737b2.1718092070.git.dvyukov@google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 14 Jun 2024 01:01:12 +0200
Message-ID: <CA+fCnZfddD4T9xGmePPHiPZaGbiK10PO-NT98n3Q7-2n-Pjccw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] kcov: add interrupt handling self test
To: Dmitry Vyukov <dvyukov@google.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com, elver@google.com, glider@google.com, 
	nogikh@google.com, tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 9:50=E2=80=AFAM 'Dmitry Vyukov' via syzkaller
<syzkaller@googlegroups.com> wrote:
>
> Add a boot self test that can catch sprious coverage from interrupts.
> The coverage callback filters out interrupt code, but only after the
> handler updates preempt count. Some code periodically leaks out
> of that section and leads to spurious coverage.
> Add a best-effort (but simple) test that is likely to catch such bugs.
> If the test is enabled on CI systems that use KCOV, they should catch
> any issues fast.
>
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: syzkaller@googlegroups.com
>
> ---
>
> Changed since v1:
>  - renamed KCOV_TEST to KCOV_SELFTEST
>  - improved the config description
>  - loop for exactly 300ms in the test
>
> In my local testing w/o the previous fix,
> it immidiatly produced the following splat:
>
> kcov: running selftest
> BUG: TASK stack guard page was hit at ffffc90000147ff8
> Oops: stack guard page: 0000 [#1] PREEMPT SMP KASAN PTI
> ...
>  kvm_set_cpu_l1tf_flush_l1d+0x5/0x20
>  sysvec_call_function+0x15/0xb0
>  asm_sysvec_call_function+0x1a/0x20
>  kcov_init+0xe4/0x130
>  do_one_initcall+0xbc/0x470
>  kernel_init_freeable+0x4fc/0x930
>  kernel_init+0x1c/0x2b0
> ---
>  kernel/kcov.c     | 31 +++++++++++++++++++++++++++++++
>  lib/Kconfig.debug |  8 ++++++++
>  2 files changed, 39 insertions(+)
>
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index c3124f6d5536..72a5bf55107f 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -11,6 +11,7 @@
>  #include <linux/fs.h>
>  #include <linux/hashtable.h>
>  #include <linux/init.h>
> +#include <linux/jiffies.h>
>  #include <linux/kmsan-checks.h>
>  #include <linux/mm.h>
>  #include <linux/preempt.h>
> @@ -1057,6 +1058,32 @@ u64 kcov_common_handle(void)
>  }
>  EXPORT_SYMBOL(kcov_common_handle);
>
> +#ifdef CONFIG_KCOV_SELFTEST
> +static void __init selftest(void)
> +{
> +       unsigned long start;
> +
> +       pr_err("running self test\n");
> +       /*
> +        * Test that interrupts don't produce spurious coverage.
> +        * The coverage callback filters out interrupt code, but only
> +        * after the handler updates preempt count. Some code periodicall=
y
> +        * leaks out of that section and leads to spurious coverage.
> +        * It's hard to call the actual interrupt handler directly,
> +        * so we just loop here for a bit waiting for a timer interrupt.
> +        * We set kcov_mode to enable tracing, but don't setup the area,
> +        * so any attempt to trace will crash. Note: we must not call any
> +        * potentially traced functions in this region.
> +        */
> +       start =3D jiffies;
> +       current->kcov_mode =3D KCOV_MODE_TRACE_PC;
> +       while ((jiffies - start) * MSEC_PER_SEC / HZ < 300)
> +               ;
> +       current->kcov_mode =3D 0;
> +       pr_err("done running self test\n");
> +}
> +#endif
> +
>  static int __init kcov_init(void)
>  {
>         int cpu;
> @@ -1076,6 +1103,10 @@ static int __init kcov_init(void)
>          */
>         debugfs_create_file_unsafe("kcov", 0600, NULL, NULL, &kcov_fops);
>
> +#ifdef CONFIG_KCOV_SELFTEST
> +       selftest();
> +#endif
> +
>         return 0;
>  }
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 59b6765d86b8..695a437a52d9 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2171,6 +2171,14 @@ config KCOV_IRQ_AREA_SIZE
>           soft interrupts. This specifies the size of those areas in the
>           number of unsigned long words.
>
> +config KCOV_SELFTEST
> +       bool "Perform short selftests on boot"
> +       depends on KCOV
> +       help
> +         Run short KCOV coverage collection selftests on boot.
> +         On test failure, causes the kernel to panic. Recommended to be

Nit: "causes the kernel to panic" =3D> "causes a kernel panic" or "panic
the kernel"

> +         enabled, ensuring critical functionality works as intended.
> +
>  menuconfig RUNTIME_TESTING_MENU
>         bool "Runtime Testing"
>         default y
> --
> 2.45.2.505.gda0bf45e8d-goog

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

