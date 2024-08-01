Return-Path: <linux-kernel+bounces-271786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEED945334
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5475F2822F2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB1E1487E9;
	Thu,  1 Aug 2024 19:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvtqVQt4"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62063132139
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 19:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722539823; cv=none; b=oTeYMLyvflcTQtw3F3Bw8r8smiC174icvdGf9cexdiBPIgXDsTVR2vh8MuMSgkoT+Ml6gq/vKp9dFFH/GwfNebr1rCYniDiS9MKxUa5Emdk7LRh0+Vk+OwQJ4dck0ra6pxMS+24+ivhJ8FknCE3ODXr6LUYKw7sQX2tNnGYEPjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722539823; c=relaxed/simple;
	bh=FsTgJv5ULfjtT4uzQD1idPknmyOfBUlp5h5MZu/m0Og=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ccUvQAiF0wE9HkvNxfqIZJCrZMSRj/UhuUSOY0c33t0SlQlnmQoq87bLbtDKHFPwdJYvqB3zK5XZDoQggt+2FnsDPhtqRRMm7w4hibZ80DM9ZarePF6hfPGqE+MBVXvNw8hrkOxBKB06hNGC4J0MZbg6S+VG15PLIWXAsCtflMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvtqVQt4; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7d89bb07e7so458044766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 12:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722539820; x=1723144620; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2lJyLZbucIe5opdiO3kpiQWjoU7HWScAFHcY/FoPqQM=;
        b=HvtqVQt4nWwIKkWx9kZkBjzfcVWwaSmb8Ow8GDmnkzRPMjqoYHrk9YyIL4wJp+VoDh
         o3uP9JOJXgO4qN+b6gu131Y55Wv/9YnCZcO7iRP37Z6q61ND3EzC0pvpxerogC+Bn41H
         hQ2y3v7VDNxm//U0KaHWRv/CFnn30AX/cXhUNzmrkX6GnGkj9bFujSQwHvgoH8XzpMy8
         UTH21VNe8DlEtfnDNXVhgnxJAVoxrY38vgQE7zZfw5oDxwMqhs/dUDEQ+HslMtl0dmZw
         8UdQbOSnxoE/skNk/8Mqn1+bGsPbEvSOgsGemV2yxmqpagk5cYaN2tgto1RuLgOe6gQQ
         /bgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722539820; x=1723144620;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2lJyLZbucIe5opdiO3kpiQWjoU7HWScAFHcY/FoPqQM=;
        b=iSCUcOf4fpNuIZlskSSFNiVVJVOita5Y3MnUoTfa1v0c16NH2+VjcO4LkxIC5+KrVC
         7JV4EgWzmAq8CxwrNIdQY/M2jcMaj9DIiVPdwY1FiH7BwsLw9oc2OC5ABgcXPHC7cHBe
         C90bdMTo1Udk+zGEE1C9XaA4TpZAbiBNB0t7J/uQq083R2AxzFK7JaiQU8tqYaKnIvxt
         smj6DUphcgN2xBGLKflhM91mp5G1N6i7o2SUTjssB2VPHdsQLkDUcSsbvyjatYXkHS7C
         vo0DJYtXK3gKt9d4scsUHLwzW95ZmnD31F8lCEmXbmAFSq8D9Ij8hRWyAm/7EA5G48d+
         PZBg==
X-Forwarded-Encrypted: i=1; AJvYcCXrvdhiaO4JG0z5IU7OkYHMN0ib3Q1ghtoJgCfO5AOVRCq1n3mJmjDZRKi6WV8ML2tkyo0Yysh/XidZvu7Hp95hejGkL89z9llF+h4s
X-Gm-Message-State: AOJu0Yxzq/edyn6rRyU2GxmPUcZCmLB2FmFOoxdmctmcepk1pkRoZuBT
	HLqYvGRbafjsleslQoziF4GvYOkN7X+Rj7zmVFxCAiBrRrosXNo=
X-Google-Smtp-Source: AGHT+IExQa6e27hKb7qI6K5zAXQAkD9NjlnCkP6LIDB8EFr35Vr02bglzhOFdAcC662NfTnh88Mv6g==
X-Received: by 2002:a17:907:7f94:b0:a7a:84f8:eaef with SMTP id a640c23a62f3a-a7dc4e8c3f0mr99005866b.35.1722539819259;
        Thu, 01 Aug 2024 12:16:59 -0700 (PDT)
Received: from p183 ([46.53.253.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ecad25sm12474266b.221.2024.08.01.12.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 12:16:58 -0700 (PDT)
Date: Thu, 1 Aug 2024 22:16:56 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] xen, pvh: fix unbootable VMs (PVH + KASAN)
Message-ID: <a9f505a6-fd31-4cfa-a193-d21638bb14f1@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Uninstrument arch/x86/platform/pvh/enlighten.c: KASAN is not setup
_this_ early in the boot process.

Steps to reproduce:

	make allnoconfig
	make sure CONFIG_AMD_MEM_ENCRYPT is disabled
		AMD_MEM_ENCRYPT independently uninstruments lib/string.o
		so PVH boot code calls into uninstrumented memset() and
		memcmp() which can make the bug disappear depending on
		the compiler.
	enable CONFIG_PVH
	enable CONFIG_KASAN
	enable serial console
		this is fun exercise if you never done it from nothing :^)

	make

	qemu-system-x86_64	\
		-enable-kvm	\
		-cpu host	\
		-smp cpus=1	\
		-m 4096		\
		-serial stdio	\
		-kernel vmlinux \
		-append 'console=ttyS0 ignore_loglevel'

Messages on serial console will easily tell OK kernel from unbootable
kernel. In bad case qemu hangs in an infinite loop stroboscoping
"SeaBIOS" message.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/x86/platform/pvh/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/platform/pvh/Makefile b/arch/x86/platform/pvh/Makefile
index 5dec5067c9fb..c43fb7964dc4 100644
--- a/arch/x86/platform/pvh/Makefile
+++ b/arch/x86/platform/pvh/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 OBJECT_FILES_NON_STANDARD_head.o := y
+KASAN_SANITIZE := n
 
 obj-$(CONFIG_PVH) += enlighten.o
 obj-$(CONFIG_PVH) += head.o

