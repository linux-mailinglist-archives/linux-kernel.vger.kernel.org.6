Return-Path: <linux-kernel+bounces-380202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 947219AEA20
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08DADB23E9C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13CC1B5EA4;
	Thu, 24 Oct 2024 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metux.net header.i=lkml@metux.net header.b="OUZ2sExm"
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41E6157A6B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782915; cv=none; b=GNsO+WH1Kk3GKups588YNwn6/wH9x5f6sH44ABbcacC8XEPekNzTV5SJuFj+7WdhptlNHQwDZel0LOFZffUoblyBPDGLZy/62HaTcH+a7Mq0pl1UAoeYEQLcpDfQzQF6O1cIX4EyLAfupli3c8Z0hd6opC5B5PBmkveuITPQhzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782915; c=relaxed/simple;
	bh=6uVl2Hg6NkjchTGh8ifDJU+C4FlajTWQ0oLX1gbhVgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G7OXwADAAHHUYf7IThEzfdUYA9udXSbx4/x06rQQ6z5H12rmNJ4bDdatg5MQOKHT2LJDdkusGVKlurXfVd9v9OWGBU5V2JUvylg7Npx1vI/WruW1zP6RSLtzDGmc0PWx69Yuz0iArBy4y8gxnr2n4nVMspNlxwsu5VGua5EIJ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net; spf=pass smtp.mailfrom=metux.net; dkim=pass (2048-bit key) header.d=metux.net header.i=lkml@metux.net header.b=OUZ2sExm; arc=none smtp.client-ip=217.72.192.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metux.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=metux.net;
	s=s1-ionos; t=1729782907; x=1730387707; i=lkml@metux.net;
	bh=X0k//SWeqeCFGhnx/YbyvixXShoOxir2erT9ndTg9OQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OUZ2sExmB4aNEGix9jhtLu2+9Zf1lGt6E+3UaCd7f9EfF25vzWqcWT+vYQrbZ+YP
	 8/Yk5hBKP51rqhVMt+bSe+lHeRmV0fv9kFtDcHF6LB7L4j42W31jnEdEibO6soFJm
	 wWbVz0KEPMl1rNiNRb4dKrQusBLBju+NFjP0GMbHQk+oV1WcNBVVzvub12hiG2IKm
	 vfgXbsXa+47TjYJaEpzkeUm7xMpUS+MTD4qiP5lqS50YFVDQHNKLx8mV8Ul/lNXwn
	 6PxmBBmXZC/aY6Cru3qtlUjRvd+6/bejL6G3V23l+lA9yBm5Hqz9Q1zEe2Insk4AG
	 nsgt8zrA1tX9eZxURg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.1.178] ([77.2.18.78]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MybCV-1tpegZ3Xh7-00tv5U; Thu, 24 Oct 2024 17:15:06 +0200
Message-ID: <36b3ea99-73f7-46e7-a430-dae85be1b150@metux.net>
Date: Thu, 24 Oct 2024 17:15:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Remove certain entries due to their
 involvement in the PRISM (US-984XN) program.
To: edjsn0wden <edjsn0wden@proton.me>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <qUEsjMZ5C95BqPoeHUg8_1SGNjeIrFgKUWInutz3xDjYqsqR6otCKUgCRM1sHfKr7ms5fGBbmVX8vfrRBz06t2jjBegVgKr34uzOi2V1MsQ=@proton.me>
Content-Language: tl
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
In-Reply-To: <qUEsjMZ5C95BqPoeHUg8_1SGNjeIrFgKUWInutz3xDjYqsqR6otCKUgCRM1sHfKr7ms5fGBbmVX8vfrRBz06t2jjBegVgKr34uzOi2V1MsQ=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WFzZhElIrws3+uCnIv6g3vk0IyyOoIv9g/sKGh3FJLK6aXI0wBz
 q/me5jRGRq5D2w+Gh5Si3KGVZ0SnrBJKfv/ptHpzfhXLyuzayILmMIvLY8TcbIbONRQJ1C+
 zhXMFw1PFp8o5fl63cpz9h5HaMAyF2T0kRjTFw48XKrcNsC8RMqZaLe5H7TtTdKaXXvYuw+
 +4liAQJHr3XhUIz3h9SLQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kbr0bciAh1k=;wO4/JAqwiGBIXnZG7JnYvwIzEY6
 +EgH4BAP0iLsfC8P0GSKw/IN2xElU9cY1L//HBvzNr/aGZozocWt8ENTRcGlRl1/Lx4AoCFjU
 H+FoCCv1HqiOUwVrey3979I+OyDhE5NuYv3xcHIzEEosrXAl384t2zxfB9ReNuva9jyHVdoGf
 19vceXgPaZSYFhQcrDvhV8c/SmTv9RwoTEZa0KI0nlVDpY4iN+0a7xp65bSD9F1kbE5kHpAyb
 9re/g/D9f3RgAp5RqHUWZrxRx+cdMbIeUhfUrOc0LG8V98ZpB20O2zRxtTEaJ8eomwhV4tVGl
 78oYY24Y6pzcdbY7dzq78jB2FcOABP0OoijQg1Uh7Hzf7YO2SV9GwBGoqpc0RwBGPYXLaxRVk
 tOJHuvV0sZmqCDwCRc64o0HHWjeaMbh/1QM4KvFjL/VMbDIYTe8Tsw9R3c3k2rpWfHXfpiAGx
 lE7GfnSWhn2ipPz4Y9ASQa1ayInfFwHl2T2t1zwpMmMouDtlwnbHopClKMjWlhYrs16aojXdV
 ziVEyGQqhYLK29/d8tkC2+L9/OH2VQuCYiie+rZWN1Ahd4wg2lFqcTNUbBA2/AM2eXOF4BgW2
 shNKECJrSVBOX+EFNOyykZup2fpnz/Jriforsf5jE0/hkiHqreBTZO9yYSI4Je7CpUF7RuRO8
 oB3c3De3z1Hh2nzrlAv18Zp0C16NCIfq5XQ5TiFPSyfFKWQlNwWDLBNzV4yueg6OhPCok4p7H
 jYy8af8DCSNAFnVEndLroUMSBoXL9WZUw==

Acknowledged-By: Enrico Weiglet <info@metux.net>


On 24.10.24 11:10, edjsn0wden wrote:
>  From 60399896ac24e29de97cd82542ad99728963cde1 Mon Sep 17 00:00:00 2001
> From: "Ed. J. Sn0wden" <edjsn0wden@proton.me>
> Date: Thu, 24 Oct 2024 09:01:22 +0000
> Subject: [PATCH] Remove certain entries due to their involvement in the =
PRISM
>   (US-984XN) program.
>
> Companies with a history of unethical practices should be excluded from =
the maintainers'
> list of open-source freedom software to ensure the integrity and trustwo=
rthiness of the community.
> ---
>   MAINTAINERS | 73 -----------------------------------------------------
>   1 file changed, 73 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e9659a5a7fb3..b71ed3019f1f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1566,8 +1566,6 @@ M:	Todd Kjos <tkjos@android.com>
>   M:	Martijn Coenen <maco@android.com>
>   M:	Joel Fernandes <joel@joelfernandes.org>
>   M:	Christian Brauner <christian@brauner.io>
> -M:	Carlos Llamas <cmllamas@google.com>
> -M:	Suren Baghdasaryan <surenb@google.com>
>   L:	linux-kernel@vger.kernel.org
>   S:	Supported
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.gi=
t
> @@ -2194,7 +2192,6 @@ F:	drivers/mmc/host/usdhi6rol0.c
>   F:	drivers/pinctrl/pinctrl-artpec*
>
>   ARM/ASPEED I2C DRIVER
> -M:	Brendan Higgins <brendanhiggins@google.com>
>   R:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
>   R:	Joel Stanley <joel@jms.id.au>
>   L:	linux-i2c@vger.kernel.org
> @@ -2739,9 +2736,6 @@ ARM/NUVOTON NPCM ARCHITECTURE
>   M:	Avi Fishman <avifishman70@gmail.com>
>   M:	Tomer Maimon <tmaimon77@gmail.com>
>   M:	Tali Perry <tali.perry1@gmail.com>
> -R:	Patrick Venture <venture@google.com>
> -R:	Nancy Yuen <yuenn@google.com>
> -R:	Benjamin Fair <benjaminfair@google.com>
>   L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
>   S:	Supported
>   F:	Documentation/devicetree/bindings/*/*/*npcm*
> @@ -4168,7 +4162,6 @@ R:	Yonghong Song <yonghong.song@linux.dev>
>   R:	John Fastabend <john.fastabend@gmail.com>
>   R:	KP Singh <kpsingh@kernel.org>
>   R:	Stanislav Fomichev <sdf@fomichev.me>
> -R:	Hao Luo <haoluo@google.com>
>   R:	Jiri Olsa <jolsa@kernel.org>
>   L:	bpf@vger.kernel.org
>   S:	Supported
> @@ -4271,7 +4264,6 @@ F:	kernel/bpf/ringbuf.c
>
>   BPF [SECURITY & LSM] (Security Audit and Enforcement using BPF)
>   M:	KP Singh <kpsingh@kernel.org>
> -M:	Matt Bobrowski <mattbobrowski@google.com>
>   L:	bpf@vger.kernel.org
>   S:	Maintained
>   F:	Documentation/bpf/prog_lsm.rst
> @@ -5388,7 +5380,6 @@ S:	Maintained
>   F:	drivers/watchdog/cros_ec_wdt.c
>
>   CHRONTEL CH7322 CEC DRIVER
> -M:	Joe Tessler <jrt@google.com>
>   L:	linux-media@vger.kernel.org
>   S:	Maintained
>   T:	git git://linuxtv.org/media_tree.git
> @@ -5515,7 +5506,6 @@ S:	Supported
>   F:	drivers/infiniband/hw/usnic/
>
>   CLANG CONTROL FLOW INTEGRITY SUPPORT
> -M:	Sami Tolvanen <samitolvanen@google.com>
>   M:	Kees Cook <kees@kernel.org>
>   R:	Nathan Chancellor <nathan@kernel.org>
>   L:	llvm@lists.linux.dev
> @@ -5532,9 +5522,6 @@ F:	.clang-format
>
>   CLANG/LLVM BUILD SUPPORT
>   M:	Nathan Chancellor <nathan@kernel.org>
> -R:	Nick Desaulniers <ndesaulniers@google.com>
> -R:	Bill Wendling <morbo@google.com>
> -R:	Justin Stitt <justinstitt@google.com>
>   L:	llvm@lists.linux.dev
>   S:	Supported
>   W:	https://clangbuiltlinux.github.io/
> @@ -5619,7 +5606,6 @@ F:	Documentation/process/code-of-conduct-interpret=
ation.rst
>   F:	Documentation/process/code-of-conduct.rst
>
>   CODE TAGGING
> -M:	Suren Baghdasaryan <surenb@google.com>
>   M:	Kent Overstreet <kent.overstreet@linux.dev>
>   S:	Maintained
>   F:	include/asm-generic/codetag.lds.h
> @@ -5653,9 +5639,7 @@ COMMON INTERNET FILE SYSTEM CLIENT (CIFS and SMB3)
>   M:	Steve French <sfrench@samba.org>
>   R:	Paulo Alcantara <pc@manguebit.com> (DFS, global name space)
>   R:	Ronnie Sahlberg <ronniesahlberg@gmail.com> (directory leases, spars=
e files)
> -R:	Shyam Prasad N <sprasad@microsoft.com> (multichannel)
>   R:	Tom Talpey <tom@talpey.com> (RDMA, smbdirect)
> -R:	Bharath SM <bharathsm@microsoft.com> (deferred close, directory leas=
es)
>   L:	linux-cifs@vger.kernel.org
>   L:	samba-technical@lists.samba.org (moderated for non-subscribers)
>   S:	Supported
> @@ -6494,7 +6478,6 @@ F:	drivers/base/devcoredump.c
>   F:	include/linux/devcoredump.h
>
>   DEVICE DEPENDENCY HELPER SCRIPT
> -M:	Saravana Kannan <saravanak@google.com>
>   L:	linux-kernel@vger.kernel.org
>   S:	Maintained
>   F:	scripts/dev-needs.sh
> @@ -6753,8 +6736,6 @@ DMA-BUF HEAPS FRAMEWORK
>   M:	Sumit Semwal <sumit.semwal@linaro.org>
>   R:	Benjamin Gaignard <benjamin.gaignard@collabora.com>
>   R:	Brian Starkey <Brian.Starkey@arm.com>
> -R:	John Stultz <jstultz@google.com>
> -R:	T.J. Mercier <tjmercier@google.com>
>   L:	linux-media@vger.kernel.org
>   L:	dri-devel@lists.freedesktop.org
>   L:	linaro-mm-sig@lists.linaro.org (moderated for non-subscribers)
> @@ -7618,7 +7599,6 @@ M:	Tian Tao  <tiantao6@hisilicon.com>
>   R:	Xinwei Kong <kong.kongxinwei@hisilicon.com>
>   R:	Sumit Semwal <sumit.semwal@linaro.org>
>   R:	Yongqin Liu <yongqin.liu@linaro.org>
> -R:	John Stultz <jstultz@google.com>
>   L:	dri-devel@lists.freedesktop.org
>   S:	Maintained
>   T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
> @@ -8085,7 +8065,6 @@ F:	drivers/edac/
>   F:	include/linux/edac.h
>
>   EDAC-DMC520
> -M:	Lei Wang <lewan@microsoft.com>
>   L:	linux-edac@vger.kernel.org
>   S:	Supported
>   F:	drivers/edac/dmc520_edac.c
> @@ -8370,7 +8349,6 @@ M:	Gao Xiang <xiang@kernel.org>
>   M:	Chao Yu <chao@kernel.org>
>   R:	Yue Hu <huyue2@coolpad.com>
>   R:	Jeffle Xu <jefflexu@linux.alibaba.com>
> -R:	Sandeep Dhavale <dhavale@google.com>
>   L:	linux-erofs@lists.ozlabs.org
>   S:	Maintained
>   W:	https://erofs.docs.kernel.org
> @@ -8630,7 +8608,6 @@ F:	net/core/failover.c
>   FANOTIFY
>   M:	Jan Kara <jack@suse.cz>
>   R:	Amir Goldstein <amir73il@gmail.com>
> -R:	Matthew Bobrowski <repnop@google.com>
>   L:	linux-fsdevel@vger.kernel.org
>   S:	Maintained
>   F:	fs/notify/fanotify/
> @@ -9635,9 +9612,6 @@ S:	Maintained
>   F:	drivers/input/touchscreen/goodix*
>
>   GOOGLE ETHERNET DRIVERS
> -M:	Jeroen de Borst <jeroendb@google.com>
> -M:	Praveen Kaligineedi <pkaligineedi@google.com>
> -R:	Shailend Chand <shailend@google.com>
>   L:	netdev@vger.kernel.org
>   S:	Supported
>   F:	Documentation/networking/device_drivers/ethernet/google/gve.rst
> @@ -10157,7 +10131,6 @@ F:	Documentation/scsi/hptiop.rst
>   F:	drivers/scsi/hptiop.c
>
>   HIKEY960 ONBOARD USB GPIO HUB DRIVER
> -M:	John Stultz <jstultz@google.com>
>   L:	linux-kernel@vger.kernel.org
>   S:	Maintained
>   F:	drivers/misc/hisi_hikey_usb.c
> @@ -10544,10 +10517,7 @@ S:	Maintained
>   F:	drivers/media/i2c/hi847.c
>
>   Hyper-V/Azure CORE AND DRIVERS
> -M:	"K. Y. Srinivasan" <kys@microsoft.com>
> -M:	Haiyang Zhang <haiyangz@microsoft.com>
>   M:	Wei Liu <wei.liu@kernel.org>
> -M:	Dexuan Cui <decui@microsoft.com>
>   L:	linux-hyperv@vger.kernel.org
>   S:	Supported
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
> @@ -11022,7 +10992,6 @@ F:	Documentation/devicetree/bindings/iio/multipl=
exer/io-channel-mux.yaml
>   F:	drivers/iio/multiplexer/iio-mux.c
>
>   IIO SCMI BASED DRIVER
> -M:	Jyoti Bhayana <jbhayana@google.com>
>   L:	linux-iio@vger.kernel.org
>   S:	Maintained
>   F:	drivers/iio/common/scmi_sensors/scmi_iio.c
> @@ -12216,9 +12185,7 @@ F:	drivers/hwmon/k8temp.c
>
>   KASAN
>   M:	Andrey Ryabinin <ryabinin.a.a@gmail.com>
> -R:	Alexander Potapenko <glider@google.com>
>   R:	Andrey Konovalov <andreyknvl@gmail.com>
> -R:	Dmitry Vyukov <dvyukov@google.com>
>   R:	Vincenzo Frascino <vincenzo.frascino@arm.com>
>   L:	kasan-dev@googlegroups.com
>   S:	Maintained
> @@ -12242,7 +12209,6 @@ F:	scripts/Kconfig.include
>   F:	scripts/kconfig/
>
>   KCOV
> -R:	Dmitry Vyukov <dvyukov@google.com>
>   R:	Andrey Konovalov <andreyknvl@gmail.com>
>   L:	kasan-dev@googlegroups.com
>   S:	Maintained
> @@ -12254,8 +12220,6 @@ F:	kernel/kcov.c
>   F:	scripts/Makefile.kcov
>
>   KCSAN
> -M:	Marco Elver <elver@google.com>
> -R:	Dmitry Vyukov <dvyukov@google.com>
>   L:	kasan-dev@googlegroups.com
>   S:	Maintained
>   F:	Documentation/dev-tools/kcsan.rst
> @@ -12402,9 +12366,6 @@ F:	fs/smb/common/
>   F:	fs/smb/server/
>
>   KERNEL UNIT TESTING FRAMEWORK (KUnit)
> -M:	Brendan Higgins <brendanhiggins@google.com>
> -M:	David Gow <davidgow@google.com>
> -R:	Rae Moar <rmoar@google.com>
>   L:	linux-kselftest@vger.kernel.org
>   L:	kunit-dev@googlegroups.com
>   S:	Maintained
> @@ -12534,7 +12495,6 @@ F:	tools/testing/selftests/kvm/*/s390x/
>   F:	tools/testing/selftests/kvm/s390x/
>
>   KERNEL VIRTUAL MACHINE FOR X86 (KVM/x86)
> -M:	Sean Christopherson <seanjc@google.com>
>   M:	Paolo Bonzini <pbonzini@redhat.com>
>   L:	kvm@vger.kernel.org
>   S:	Supported
> @@ -12638,9 +12598,6 @@ W:	https://kernsec.org/wiki/index.php/Linux_Kern=
el_Integrity
>   F:	security/integrity/platform_certs
>
>   KFENCE
> -M:	Alexander Potapenko <glider@google.com>
> -M:	Marco Elver <elver@google.com>
> -R:	Dmitry Vyukov <dvyukov@google.com>
>   L:	kasan-dev@googlegroups.com
>   S:	Maintained
>   F:	Documentation/dev-tools/kfence.rst
> @@ -12696,9 +12653,6 @@ F:	mm/kmemleak.c
>   F:	samples/kmemleak/kmemleak-test.c
>
>   KMSAN
> -M:	Alexander Potapenko <glider@google.com>
> -R:	Marco Elver <elver@google.com>
> -R:	Dmitry Vyukov <dvyukov@google.com>
>   L:	kasan-dev@googlegroups.com
>   S:	Maintained
>   F:	Documentation/dev-tools/kmsan.rst
> @@ -12776,7 +12730,6 @@ F:	include/uapi/linux/kvm_para.h
>
>   KVM X86 HYPER-V (KVM/hyper-v)
>   M:	Vitaly Kuznetsov <vkuznets@redhat.com>
> -M:	Sean Christopherson <seanjc@google.com>
>   M:	Paolo Bonzini <pbonzini@redhat.com>
>   L:	kvm@vger.kernel.org
>   S:	Supported
> @@ -12790,7 +12743,6 @@ F:	arch/x86/kvm/vmx/hyperv.*
>   KVM X86 Xen (KVM/Xen)
>   M:	David Woodhouse <dwmw2@infradead.org>
>   M:	Paul Durrant <paul@xen.org>
> -M:	Sean Christopherson <seanjc@google.com>
>   M:	Paolo Bonzini <pbonzini@redhat.com>
>   L:	kvm@vger.kernel.org
>   S:	Supported
> @@ -12806,7 +12758,6 @@ F:	net/l3mdev
>
>   LANDLOCK SECURITY MODULE
>   M:	Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> -R:	G=C3=BCnther Noack <gnoack@google.com>
>   L:	linux-security-module@vger.kernel.org
>   S:	Supported
>   W:	https://landlock.io
> @@ -13177,7 +13128,6 @@ F:	drivers/misc/lis3lv02d/
>   F:	drivers/platform/x86/hp/hp_accel.c
>
>   LIST KUNIT TEST
> -M:	David Gow <davidgow@google.com>
>   L:	linux-kselftest@vger.kernel.org
>   L:	kunit-dev@googlegroups.com
>   S:	Maintained
> @@ -14746,7 +14696,6 @@ F:	mm/mm_init.c
>   F:	tools/testing/memblock/
>
>   MEMORY ALLOCATION PROFILING
> -M:	Suren Baghdasaryan <surenb@google.com>
>   M:	Kent Overstreet <kent.overstreet@linux.dev>
>   L:	linux-mm@kvack.org
>   S:	Maintained
> @@ -14819,7 +14768,6 @@ M:	Andrew Morton <akpm@linux-foundation.org>
>   M:	Liam R. Howlett <Liam.Howlett@oracle.com>
>   M:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>   R:	Vlastimil Babka <vbabka@suse.cz>
> -R:	Jann Horn <jannh@google.com>
>   L:	linux-mm@kvack.org
>   S:	Maintained
>   W:	http://www.linux-mm.org
> @@ -14909,7 +14857,6 @@ F:	drivers/staging/media/meson/vdec/
>   META ETHERNET DRIVERS
>   M:	Alexander Duyck <alexanderduyck@fb.com>
>   M:	Jakub Kicinski <kuba@kernel.org>
> -R:	kernel-team@meta.com
>   S:	Supported
>   F:	Documentation/networking/device_drivers/ethernet/meta/
>   F:	drivers/net/ethernet/meta/
> @@ -15282,8 +15229,6 @@ F:	include/linux/cciss*.h
>   F:	include/uapi/linux/cciss*.h
>
>   MICROSOFT MANA RDMA DRIVER
> -M:	Long Li <longli@microsoft.com>
> -M:	Ajay Sharma <sharmaajay@microsoft.com>
>   L:	linux-rdma@vger.kernel.org
>   S:	Supported
>   F:	drivers/infiniband/hw/mana/
> @@ -15567,7 +15512,6 @@ F:	include/dt-bindings/clock/mobileye,eyeq5-clk.=
h
>   MODULE SUPPORT
>   M:	Luis Chamberlain <mcgrof@kernel.org>
>   R:	Petr Pavlu <petr.pavlu@suse.com>
> -R:	Sami Tolvanen <samitolvanen@google.com>
>   R:	Daniel Gomez <da.gomez@samsung.com>
>   L:	linux-modules@vger.kernel.org
>   L:	linux-kernel@vger.kernel.org
> @@ -15978,7 +15922,6 @@ F:	net/core/drop_monitor.c
>   NETWORKING DRIVERS
>   M:	Andrew Lunn <andrew+netdev@lunn.ch>
>   M:	"David S. Miller" <davem@davemloft.net>
> -M:	Eric Dumazet <edumazet@google.com>
>   M:	Jakub Kicinski <kuba@kernel.org>
>   M:	Paolo Abeni <pabeni@redhat.com>
>   L:	netdev@vger.kernel.org
> @@ -16039,7 +15982,6 @@ F:	tools/testing/selftests/drivers/net/dsa/
>
>   NETWORKING [GENERAL]
>   M:	"David S. Miller" <davem@davemloft.net>
> -M:	Eric Dumazet <edumazet@google.com>
>   M:	Jakub Kicinski <kuba@kernel.org>
>   M:	Paolo Abeni <pabeni@redhat.com>
>   L:	netdev@vger.kernel.org
> @@ -16188,7 +16130,6 @@ F:	tools/testing/selftests/bpf/*/*mptcp*.c
>   F:	tools/testing/selftests/net/mptcp/
>
>   NETWORKING [TCP]
> -M:	Eric Dumazet <edumazet@google.com>
>   L:	netdev@vger.kernel.org
>   S:	Maintained
>   F:	Documentation/networking/net_cachelines/tcp_sock.rst
> @@ -16381,7 +16322,6 @@ S:	Maintained
>   F:	drivers/input/touchscreen/novatek-nvt-ts.c
>
>   NSDEPS
> -M:	Matthias Maennich <maennich@google.com>
>   S:	Maintained
>   F:	Documentation/core-api/symbol-namespaces.rst
>   F:	scripts/nsdeps
> @@ -17218,7 +17158,6 @@ F:	include/linux/oa_tc6.h
>
>   OPEN FIRMWARE AND FLATTENED DEVICE TREE
>   M:	Rob Herring <robh@kernel.org>
> -M:	Saravana Kannan <saravanak@google.com>
>   L:	devicetree@vger.kernel.org
>   S:	Maintained
>   W:	http://www.devicetree.org/
> @@ -17787,7 +17726,6 @@ F:	drivers/pci/pci-bridge-emul.c
>   F:	drivers/pci/pci-bridge-emul.h
>
>   PCI PEER-TO-PEER DMA (P2PDMA)
> -M:	Bjorn Helgaas <bhelgaas@google.com>
>   M:	Logan Gunthorpe <logang@deltatee.com>
>   L:	linux-pci@vger.kernel.org
>   S:	Supported
> @@ -17808,7 +17746,6 @@ F:	drivers/pci/pwrctl/*
>   F:	include/linux/pci-pwrctl.h
>
>   PCI SUBSYSTEM
> -M:	Bjorn Helgaas <bhelgaas@google.com>
>   L:	linux-pci@vger.kernel.org
>   S:	Supported
>   Q:	https://patchwork.kernel.org/project/linux-pci/list/
> @@ -18030,7 +17967,6 @@ M:	Namhyung Kim <namhyung@kernel.org>
>   R:	Mark Rutland <mark.rutland@arm.com>
>   R:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
>   R:	Jiri Olsa <jolsa@kernel.org>
> -R:	Ian Rogers <irogers@google.com>
>   R:	Adrian Hunter <adrian.hunter@intel.com>
>   R:	"Liang, Kan" <kan.liang@linux.intel.com>
>   L:	linux-perf-users@vger.kernel.org
> @@ -18430,7 +18366,6 @@ F:	include/uapi/linux/pps.h
>
>   PRESSURE STALL INFORMATION (PSI)
>   M:	Johannes Weiner <hannes@cmpxchg.org>
> -M:	Suren Baghdasaryan <surenb@google.com>
>   R:	Peter Ziljstra <peterz@infradead.org>
>   S:	Maintained
>   F:	include/linux/psi*
> @@ -20077,7 +20012,6 @@ R:	Gary Guo <gary@garyguo.net>
>   R:	Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
>   R:	Benno Lossin <benno.lossin@proton.me>
>   R:	Andreas Hindborg <a.hindborg@kernel.org>
> -R:	Alice Ryhl <aliceryhl@google.com>
>   R:	Trevor Gross <tmgross@umich.edu>
>   L:	rust-for-linux@vger.kernel.org
>   S:	Supported
> @@ -20462,7 +20396,6 @@ M:	Juri Lelli <juri.lelli@redhat.com> (SCHED_DEA=
DLINE)
>   M:	Vincent Guittot <vincent.guittot@linaro.org> (SCHED_NORMAL)
>   R:	Dietmar Eggemann <dietmar.eggemann@arm.com> (SCHED_NORMAL)
>   R:	Steven Rostedt <rostedt@goodmis.org> (SCHED_FIFO/SCHED_RR)
> -R:	Ben Segall <bsegall@google.com> (CONFIG_CFS_BANDWIDTH)
>   R:	Mel Gorman <mgorman@suse.de> (CONFIG_NUMA_BALANCING)
>   R:	Valentin Schneider <vschneid@redhat.com> (TOPOLOGY)
>   L:	linux-kernel@vger.kernel.org
> @@ -21121,7 +21054,6 @@ F:	drivers/nvmem/layouts/sl28vpd.c
>   SLAB ALLOCATOR
>   M:	Christoph Lameter <cl@linux.com>
>   M:	Pekka Enberg <penberg@kernel.org>
> -M:	David Rientjes <rientjes@google.com>
>   M:	Joonsoo Kim <iamjoonsoo.kim@lge.com>
>   M:	Andrew Morton <akpm@linux-foundation.org>
>   M:	Vlastimil Babka <vbabka@suse.cz>
> @@ -23202,7 +23134,6 @@ W:	https://wireless.wiki.kernel.org/en/users/Dri=
vers/wl1251
>   F:	drivers/net/wireless/ti/
>
>   TIMEKEEPING, CLOCKSOURCE CORE, NTP, ALARMTIMER
> -M:	John Stultz <jstultz@google.com>
>   M:	Thomas Gleixner <tglx@linutronix.de>
>   R:	Stephen Boyd <sboyd@kernel.org>
>   L:	linux-kernel@vger.kernel.org
> @@ -23261,7 +23192,6 @@ F:	Documentation/hwmon/tmp513.rst
>   F:	drivers/hwmon/tmp513.c
>
>   TMPFS (SHMEM FILESYSTEM)
> -M:	Hugh Dickins <hughd@google.com>
>   L:	linux-mm@kvack.org
>   S:	Maintained
>   F:	include/linux/shmem_fs.h
> @@ -23570,7 +23500,6 @@ F:	include/uapi/linux/ublk_cmd.h
>
>   UBSAN
>   M:	Kees Cook <kees@kernel.org>
> -R:	Marco Elver <elver@google.com>
>   R:	Andrey Konovalov <andreyknvl@gmail.com>
>   R:	Andrey Ryabinin <ryabinin.a.a@gmail.com>
>   L:	kasan-dev@googlegroups.com
> @@ -24586,7 +24515,6 @@ M:	Andrew Morton <akpm@linux-foundation.org>
>   M:	Liam R. Howlett <Liam.Howlett@oracle.com>
>   M:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>   R:	Vlastimil Babka <vbabka@suse.cz>
> -R:	Jann Horn <jannh@google.com>
>   L:	linux-mm@kvack.org
>   S:	Maintained
>   W:	https://www.linux-mm.org
> @@ -25584,7 +25512,6 @@ K:	zstd
>
>   ZSWAP COMPRESSED SWAP CACHING
>   M:	Johannes Weiner <hannes@cmpxchg.org>
> -M:	Yosry Ahmed <yosryahmed@google.com>
>   M:	Nhat Pham <nphamcs@gmail.com>
>   R:	Chengming Zhou <chengming.zhou@linux.dev>
>   L:	linux-mm@kvack.org

=2D-
=2D--
Hinweis: unverschl=C3=BCsselte E-Mails k=C3=B6nnen leicht abgeh=C3=B6rt un=
d manipuliert
werden ! F=C3=BCr eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schl=C3=BCssel zu.
=2D--
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287

