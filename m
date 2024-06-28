Return-Path: <linux-kernel+bounces-234385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E2E91C5FD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 319E028314E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8121CD5D3;
	Fri, 28 Jun 2024 18:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IalppJ1R"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A80725634
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719600284; cv=none; b=a1JYVkN+4VrfEWrz5W+0npemxRZjxig6yTmsMMeOf21dL1CUoC6GkPVt8WpxAj3V64fZMImz4eGmQ87PEubI2s/cuwR2jJaSOl7aSkDRgYOLvf+F3Oe073MUsAaxPBoVxnDkqCZhh2m6TowTWFyY3kmlajcyKLWK0QzxWFuTH/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719600284; c=relaxed/simple;
	bh=CjeOPx08KHZCMpZar8Zw4g3simp6ijuR/rUR6FpMdU8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Ei71snPxf0BCQmpBy5c46pf8HV4V2V3jDPeYa0klYhT18Kf3/0YOH8W5GMbV/ZNIIJTCziMUlxNPv/uZ3a/3NSEKPsVTb/TAWbu1nc0WR+H+DAMpT8NOQuwjVBLkEe7SqMdXNpWr/3hiDbp9qfQN4pnh9K6E+oTCq1ymEBUUxT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IalppJ1R; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57d457357easo1257135a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719600281; x=1720205081; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DyDuHHLcDpZV6xvkvgsuMWxJVbSxBe6+9nLQ49p2W/Y=;
        b=IalppJ1R/euobZBQzsDeoUsGzhya3ujkUtMHIRwax9Hp0/idDzuLOIbqX4wPhRNRDS
         19Gn/BfszVq9cBr/38WtNQrHlZQS44uOjxywhOh7T6fEFmX1ecU9gz6Xy38wHE1/2IP7
         A7h4NxYj4ojfJbbhmKM4jpGpyBBskZkpcD0penMStUV4c2tZCmWtaS2vlJpdql224RCi
         cD9TXk8F6paE5jTLcFEeefonDtbJVrEFY+PkAlSoKiPAwHR63kF404YfcsUmBHQDLjla
         uBIo9uKfMzUYdMPwtbcamj1bv/QmIPpdKxHDxBxUogDBZr3V28xXkrqQgoQlGd74uH7N
         48Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719600281; x=1720205081;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DyDuHHLcDpZV6xvkvgsuMWxJVbSxBe6+9nLQ49p2W/Y=;
        b=oE5zZz+5/Opw1zt6yBh3kkJ2yI352xsJ9DD3nlbWXFCM6eyF83J+fTvFY7H+4YE7tN
         YoMTQijpQXMlqLqG7o6ZBwcrETfKS9+XzGs7rHUxsMyLXEc5Jom+iLT57wgP3pXC/yjB
         jKStiDHexoH0nKj/q8NTMPqAVzP9f4Xmh5SM7EWkIsGzqSdjQ1Rb2r3veKbiuj2hUcZj
         X8cF3wKWSelLgGRq8V821gTaASpahHLJ/YvSoAaXDALkUVSlz5TfT0FakFSVoyY5qnDz
         Vc0UJq9iX1eVog9AnNMr6oIzjL3NocQdy4zRK1BBdm0UDPAI2jMyxjMKVrjyvJgkn3QI
         xkrg==
X-Forwarded-Encrypted: i=1; AJvYcCXsAh8HFbVFnKKJDjJ9YU2ddgOHOnRLfHciUrW437iDhwsunw/QPdi+A4sjtBBg1QgZkbe6DCLRxp0GPmKKp7BAelVtPc4FbDgSWTUn
X-Gm-Message-State: AOJu0YwbVfIRdKQnFhioPczDOjLbb7RUMKO/vfLXpDu8liq3wdj41khP
	/R2RvLtpFzeUpraJEP3cLGfqWs0pmo5a1fvvMPn1y5P9+JjuEp/d4GCo8lo9/PBXrHV7zlRWuZA
	A95NAY1jf5730/YgxbyGRkcHGEFTMw63P
X-Google-Smtp-Source: AGHT+IGIDNxv7UkwNj6t32nU9mTwm4hZstgH1Gq54BFg3PYElDBMdRUZ0VO6tdEJLBbCCbfpp6FEKsk51eASC35Ku0o=
X-Received: by 2002:a17:907:a80e:b0:a6f:4d6b:c779 with SMTP id
 a640c23a62f3a-a727f8200f3mr737792266b.52.1719600281288; Fri, 28 Jun 2024
 11:44:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Sat, 29 Jun 2024 00:14:28 +0530
Message-ID: <CAOuPNLjpMaa1hC-VOzN_aQCuLt=T6PkgC3NBBDp8BBE5xhHTew@mail.gmail.com>
Subject: device-mapper: verity: 251:0: metadata block 18398 is corrupted
To: dm-devel@redhat.com, open list <linux-kernel@vger.kernel.org>, snitzer@redhat.com, 
	agk@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hi,
In one of our NAND products (arm64) we are having Kernel 5.15 along
with squashfs + ubiblock + dm-verity on rootfs along with ramdisk.

Recently we have enabled "NAND Page Cache" in our nand driver to
improve nand read performance.
But after enabling this feature, the dm-verity detects metadata
corruption during boot-up and the device is crashing.
If we disable dm-verity (from ramdisk) then we don't see this problem
and the device boots fine.

Are there any dm-verity specific changes (in higher Kernel version)
that we are missing here ?

This is the failure log.
What does the below metadata corruption indicate ?
Does this mean, the root_hash is corrupted ?

{{{
[    7.731295][  T136] device-mapper: verity: 251:0: metadata block
18398 is corrupted
[    7.742723][  T136] ------------[ cut here ]------------
[    7.748206][  T136] workqueue: WQ_MEM_RECLAIM kverityd:verity_work
is flushing !WQ_MEM_RECLAIM k_sm_usb:0x0
[    7.754840][  T136] WARNING: CPU: 3 PID: 136 at
kernel/workqueue.c:2660 check_flush_dependency+0x12c/0x134
[...]
[    7.809215][  T136] pc : check_flush_dependency+0x12c/0x134
[    7.814933][  T136] lr : check_flush_dependency+0x12c/0x134
[...]
[    7.905120][  T136] Call trace:
[    7.908345][  T136]  check_flush_dependency+0x12c/0x134
[    7.913710][  T136]  flush_workqueue+0x1cc/0x4dc
[    7.918452][  T136]  dwc3_msm_shutdown+0x48/0x58
[    7.923195][  T136]  platform_shutdown+0x24/0x30
[    7.927937][  T136]  device_shutdown+0x170/0x220
[    7.932680][  T136]  kernel_restart+0x40/0xfc
[    7.937152][  T136]  verity_handle_err+0x11c/0x1b0
[    7.942071][  T136]  verity_hash_for_block+0x260/0x2d8
[    7.947343][  T136]  verity_verify_io+0xe8/0x568
[    7.952085][  T136]  verity_work+0x24/0x74
[    7.956297][  T136]  process_one_work+0x1a8/0x3a0
[    7.961133][  T136]  worker_thread+0x22c/0x490
[    7.965700][  T136]  kthread+0x154/0x218
[    7.969725][  T136]  ret_from_fork+0x10/0x20
[    7.974116][  T136] ---[ end trace 166e4069e91d0a01 ]---
}}}

Thanks,
Pintu

