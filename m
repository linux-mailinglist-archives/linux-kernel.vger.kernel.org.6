Return-Path: <linux-kernel+bounces-232871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6868891AF50
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2D61C22A29
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67953A1DD;
	Thu, 27 Jun 2024 18:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4YqFdCL"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635762139D6
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 18:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719514206; cv=none; b=BcgqyTd/TbOkfkzMUTGNKxL6Rg5MvVHohv42cEENHhGvbTn5KrKIZYNvjCdt5b5v0MEmAIc2iB5hIGnKpnO/kZCGvCdSZv+Lazqz8jkIGkjEkA60ShPbZDTdlFNdEapEG2eCBz9vjB4T/jItIbYSRQz6q/e4/vmc5mtDAoSZzcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719514206; c=relaxed/simple;
	bh=GRu5M8rp//ayqaCz2ar3NwTTXa4YboEGx6o4Bc33hEA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=NdL8MqoQErFpqky4eydpXLCDctwYKQFwoG+Y7+osBaG+LxZC+5kTTE3FFvtqSE/ZNtdQWIBnyLtRDUdahZ53mtK2K+39fTBpux3G0XR/SKvPkkUa0ByONglqigayKMPAoDCyuQcQ/apMQKfYk3mrtxisILxQ60ZaqAtOckBR0r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4YqFdCL; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a72604c8c5bso571629566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 11:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719514202; x=1720119002; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKnIJ4iyD5W8ajGZ6svI0H9mupI9Vpd8vKt8PPwTVAM=;
        b=V4YqFdCL/5LcfihxBOy8SZFXioG5wLV7ziGcsPKExe1t51MTI7d8WKiTJKRJlg64JZ
         aRy6CxQxuMH+t+Jj19zsQA1+7J3OvRiGg29pfgwTuaM6qwOBdKr9XyZyWTESbpRehE/i
         1vBOP/FGhdTAqUlyYZl9s0dBSrIVqWMNJ2u8vOaPyPfHweMWUKcYW9IMW+gXAba3pr6Q
         N/rMRtMj9mLgXqqcDekqVyGYoGA8dmgkzw0+fAe2LJzbQJmPTr/7awux1szuDOCk06Io
         9icFuTBa/frdPg9OJeBbGOCNdrpUKNzo8XdpRC4oYejPL+J5IgIoQA25pmxsl1cOez/y
         f1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719514202; x=1720119002;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tKnIJ4iyD5W8ajGZ6svI0H9mupI9Vpd8vKt8PPwTVAM=;
        b=tcuLbq4IMaB6vI/3NvRqx8S/rGcTERhEIzewmaPB1fiVSo3eMTEntx/fQXUa38fI/c
         byAqVUEGvpZEuW/Y04MiG96apgKp++qXOJf2pMilM675FHKt4CazCGLUaWBRuXBG4Axs
         5AqXzZ3t70OBvk8GRxZ7LjuT1BzzuE4zgyCQoH3s2f1QKQqu6ztB0AZCK1akSbRWkrqS
         A/m9iLit6SMJ2/3O/eCcH5BSXazK/OiHvhwTsNzponNs18txjZMchB7ZqYFZyeGObnnV
         0jkpozLAOoZMEQlWJ6Jk2Om5z2cOjS4I5lJx9tzN5kEgi8PqCh+ciZjnP5W62CNxXvR2
         gk1A==
X-Gm-Message-State: AOJu0YxelKxoKMrXh/jL4iPfkjuxYrIgTP/5VskLjvsI/1osZYiiSt4W
	5QPahn3FwrDeD0MqGDjVVRumGywXylf/j5ZtP/eWJgE1FgRK/6nmE6XQzA==
X-Google-Smtp-Source: AGHT+IH+YtWaIe9j0Uys8o5uEUeSpdjGYqhGAPquiuELoKtsS9HhB4e/ujgdMqergocspgjF+jsEYg==
X-Received: by 2002:a17:906:1d42:b0:a6f:b6c3:fb48 with SMTP id a640c23a62f3a-a7245b56e16mr948905266b.29.1719514202036;
        Thu, 27 Jun 2024 11:50:02 -0700 (PDT)
Received: from [192.168.178.20] (dh207-41-166.xnet.hr. [88.207.41.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab065646sm1798466b.111.2024.06.27.11.50.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 11:50:01 -0700 (PDT)
Message-ID: <a40298f8-fedd-46bd-97c9-9c2775bda17a@gmail.com>
Date: Thu, 27 Jun 2024 20:50:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Mirsad Todorovac <mtodorovac69@gmail.com>
Subject: =?UTF-8?Q?=5BPROBLEM_linux-next=5D_make_randconfig=3A_kernel/kallsy?=
 =?UTF-8?B?bXMuYzo0OTI6MTc6IGVycm9yOiDigJhzdHJjcHnigJkgc291cmNlIGFyZ3VtZW50?=
 =?UTF-8?Q?_is_the_same_as_destination_=5B-Werror=3Drestrict=5D?=
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

On vanilla linux-next 20240627 tree, there appears to be something od with this KCONFIG_SEED=0x6C165C4C.

This construct should prevent the kernel/kallsyms.c:492:17: error: ‘strcpy’ source argument is the same as destination
error, so I am perplexed?

491         if (name != buffer)
492                 strcpy(buffer, name);



$ time nice make -j 36 bindeb-pkg |& tee ../err-6.10-rc5-next-20240627-02.log; date
  GEN     debian
dpkg-buildpackage --build=binary --no-pre-clean --unsigned-changes -R'make -f debian/rules' -j1 -a$(cat debian/arch)
dpkg-buildpackage: info: source package linux-upstream
dpkg-buildpackage: info: source version 6.10.0-rc5-3
dpkg-buildpackage: info: source distribution jammy
dpkg-buildpackage: info: source changed by marvin <marvin@defiant>
 dpkg-source --before-build .
dpkg-buildpackage: info: host architecture amd64
 make -f debian/rules binary
#
# No change to .config
#
mkdir -p /home/marvin/linux/kernel/linux-next/tools/objtool && make O=/home/marvin/linux/kernel/linux-next subdir=tools/objtool --no-print-directory -C objtool 
  INSTALL libsubcmd_headers
  CALL    scripts/checksyscalls.sh
  UPD     init/utsversion-tmp.h
  CC      init/version.o
  AR      init/built-in.a
  CC      kernel/kallsyms.o
  CC      kernel/kallsyms_selftest.o
  CC      kernel/vmcore_info.o
  CC      kernel/elfcorehdr.o
  CC      kernel/crash_reserve.o
  CC      kernel/kexec_core.o
  CC      kernel/crash_core.o
  CC      kernel/kexec_file.o
  UPD     kernel/config_data
  CC      kernel/kprobes.o
  CC      kernel/hung_task.o
  CC      kernel/seccomp.o
  CC      kernel/tracepoint.o
  CC      kernel/irq_work.o
  CC      kernel/static_call.o
  CC      kernel/static_call_inline.o
  CC      kernel/context_tracking.o
  CC      kernel/torture.o
  CC      kernel/iomem.o
  CC      kernel/rseq.o
  CC      kernel/watch_queue.o
  GZIP    kernel/config_data.gz
  CC      kernel/configs.o
kernel/kallsyms.c: In function ‘__sprint_symbol.constprop’:
kernel/kallsyms.c:492:17: error: ‘strcpy’ source argument is the same as destination [-Werror=restrict]
  492 |                 strcpy(buffer, name);
      |                 ^~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [scripts/Makefile.build:244: kernel/kallsyms.o] Error 1
make[6]: *** Waiting for unfinished jobs....
make[5]: *** [scripts/Makefile.build:485: kernel] Error 2
make[4]: *** [Makefile:1934: .] Error 2
make[3]: *** [debian/rules:74: build-arch] Error 2
dpkg-buildpackage: error: make -f debian/rules binary subprocess returned exit status 2
make[2]: *** [scripts/Makefile.package:121: bindeb-pkg] Error 2
make[1]: *** [/home/marvin/linux/kernel/linux-next/Makefile:1555: bindeb-pkg] Error 2
make: *** [Makefile:240: __sub-make] Error 2

real	0m2.962s
user	0m12.970s
sys	0m5.293s
Thu Jun 27 20:42:38 CEST 2024
$ 

Hope this helps.

Best regards,
Mirsad Todorovac

