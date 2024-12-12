Return-Path: <linux-kernel+bounces-443148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B6E9EE7F6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3404281687
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5073A215F70;
	Thu, 12 Dec 2024 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3mdeb.com header.i=@3mdeb.com header.b="X1ncM7BS"
Received: from 4.mo550.mail-out.ovh.net (4.mo550.mail-out.ovh.net [46.105.76.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7948B2144DE
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.76.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734010889; cv=none; b=PPwU7Qhc4NeBim0MMz563PlRw6x26D6piRfPMUonCtxuK4xB2mcXd5H9HLskfa1QhtfQ6ssNumAhKDwjrplvOy646zaWddzNYFHdw3hHs6nSqv6UD9N/ItK1MIzjSIQFYvt21xXcD7xQLujVwI4e5TU6Dk8E0aTrH/+aehWDnwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734010889; c=relaxed/simple;
	bh=7WU3zS7u584n7ZodT6b13xzCrUPZ6k46ayt6DkLECss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AxvFQnFby5kRjZhcIbiJU1VyMSXtfYD0gQaH7D1sSs6P+6xEmEfO87GF6KyXtIDeFwpHmWLpXpwyQzgYqebh6RU5s1xSVqfSRs++3KXEJ5Zyq05vPk+z5KeaHk0zyswHajMoIHr8xlE8/cRf33coMKyYP02bNIwwsTbjMmOGEoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=3mdeb.com; spf=pass smtp.mailfrom=3mdeb.com; dkim=pass (2048-bit key) header.d=3mdeb.com header.i=@3mdeb.com header.b=X1ncM7BS; arc=none smtp.client-ip=46.105.76.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=3mdeb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3mdeb.com
Received: from director1.ghost.mail-out.ovh.net (unknown [10.109.139.43])
	by mo550.mail-out.ovh.net (Postfix) with ESMTP id 4Y8D3y5WPkz1cDn
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:35:10 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-nx8p4 (unknown [10.110.188.168])
	by director1.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 0694A1FED4;
	Thu, 12 Dec 2024 13:35:09 +0000 (UTC)
Received: from 3mdeb.com ([37.59.142.106])
	by ghost-submission-5b5ff79f4f-nx8p4 with ESMTPSA
	id 29drI43mWmf1pgAADPs4rg
	(envelope-from <sergii.dmytruk@3mdeb.com>); Thu, 12 Dec 2024 13:35:09 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-106R0061429b23c-3ab9-4b07-9ab3-f15f52f32296,
                    B639BF7A6EC39DD0505FDBB1524E94DB3A46F08D) smtp.auth=sergii.dmytruk@3mdeb.com
X-OVh-ClientIp:176.111.183.174
From: Sergii Dmytruk <sergii.dmytruk@3mdeb.com>
To: linux-kernel@vger.kernel.org
Cc: trenchboot-devel@googlegroups.com
Subject: [RFC PATCH 0/9] x86: Trenchboot Secure Launch DRTM for AMD SKINIT (Linux)
Date: Thu, 12 Dec 2024 15:34:58 +0200
Message-ID: <cover.1734008878.git.sergii.dmytruk@3mdeb.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16613216077303100572
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrkeehgdehfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefuvghrghhiihcuffhmhihtrhhukhcuoehsvghrghhiihdrughmhihtrhhukhesfehmuggvsgdrtghomheqnecuggftrfgrthhtvghrnhepjedtgeffjeegteefvdekhefhueehjeetueekheeiffevueetvedvgedvffehjeeknecuffhomhgrihhnpehlkhhmlhdrohhrghenucfkphepuddvjedrtddrtddruddpudejiedrudduuddrudekfedrudejgedpfeejrdehledrudegvddruddtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepshgvrhhgihhirdgumhihthhruhhkseefmhguvggsrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehhedtmgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=YvfIui1rcd7eB+W/4IiHFjdVWdiS1xj9Alknt6NEeCk=;
 c=relaxed/relaxed; d=3mdeb.com; h=From; s=ovhmo3617313-selector1;
 t=1734010510; v=1;
 b=X1ncM7BSrEdVgloTOvbarzQ1KD5/v2wLNqXW3ttjPgElq6ALHGjWelwr2bhiDY4C0VdUvIIO
 tAENa3ic6Z6GCCEbcyMnWQRIk14mlx/YNtDT+6HwoMMQfna8S+t1D73oCX6dAZ9HGI7RQX0uO2K
 AbluqIqL+H760xGAgsQUPyyTTs2bbBbA9hg7kzR/zDl65s4y/Yp/c2gZrCpG6BIjosE0ZysCCbY
 Jsi/ZXP3Y5x3AO6W1Kw/ZqAFcTrCoiS6o0PALFyFfhKNVM0CmhQM12jqxzt7MqWuS6OkT0tV2TM
 Hzrhf8gQSas+Z7QC0zT3c3suF0w3vrQ+iFG5gC6B5Evfw==

NOTE: this patch set follows up on Intel TXT DRTM patches that are
currently under review in their 11th version [0]; therefore, it is not
standalone!

The publication of the patches at this point pursues several goals:
 - Make anyone tracking upstream aware of the maturity of the support
   for AMD SKINIT.
 - Collect early feedback on the SKINIT implementation.
 - Finally, demonstrate the extensibility of Secure Launch for
   incorporating additional platforms.

As the RFC suggest, this series is temporal and will be updated based on
changes made to the initial Secure Launch series. Review comments are
greatly welcomed and will be worked/addressed, but we would caution that
changes to the Secure Launch series will take precedence over review
comments. Once the Secure Launch series is merged, this series will
transition from RFC to a formally submitted series.

-----

The patches extend Secure Launch for legacy and UEFI boots with support
for AMD CPUs and their DRTM in two flavours: SKINIT on its own and SKINIT
with DRTM service running in PSP/ASP.

The code is adjusted to detect CPU type and handle AMD differently.
DRTM-specific differences include:
 - lack of registers to pass data from bootloader to DLME, resulting in passing
   some information via boot parameters
 - a different SLRT entry
 - re-enabling GIF
 - not sending #INIT to APs
 - special handling for TPM event logs to make them "compatible" with TXT logs

-----

[0]: https://lkml.org/lkml/2024/9/13/1396

-----

Jagannathan Raman (1):
  psp: Perform kernel portion of DRTM procedures

Michał Żygowski (1):
  x86: Implement AMD support for Secure Launch

Ross Philipson (6):
  x86: AMD changes for Secure Launch Resource Table header file
  x86: Secure Launch main header file AMD support
  x86: Split up Secure Launch setup and finalize functions
  x86: Prepare CPUs for post SKINIT launch
  x86/slmodule: Support AMD SKINIT
  x86: AMD changes for EFI stub DRTM launch support

Sergii Dmytruk (1):
  Documentation/x86: update Secure Launch for AMD SKINIT

 .../secure_launch_details.rst                 |  83 ++++-
 .../secure_launch_overview.rst                |  64 ++--
 arch/x86/Kconfig                              |   9 +-
 arch/x86/boot/compressed/sl_main.c            | 285 ++++++++++++++----
 arch/x86/boot/compressed/sl_stub.S            |  41 ++-
 arch/x86/include/asm/svm.h                    |   2 +
 arch/x86/include/uapi/asm/setup_data.h        |   3 +-
 arch/x86/kernel/Makefile                      |   1 +
 arch/x86/kernel/setup.c                       |   2 +-
 arch/x86/kernel/sl-psp.c                      | 239 +++++++++++++++
 arch/x86/kernel/slaunch.c                     | 193 ++++++++++--
 arch/x86/kernel/slmodule.c                    | 158 ++++++++--
 arch/x86/kernel/smpboot.c                     |  15 +-
 arch/x86/kernel/traps.c                       |   4 +
 drivers/firmware/efi/libstub/x86-stub.c       |  23 +-
 drivers/iommu/amd/init.c                      |  12 +
 include/linux/slaunch.h                       |  83 ++++-
 include/linux/slr_table.h                     |  15 +
 18 files changed, 1064 insertions(+), 168 deletions(-)
 create mode 100644 arch/x86/kernel/sl-psp.c


base-commit: a74134ba0f244cb8d5d5605699aeca7712631e89
prerequisite-patch-id: d68300fcecfeaf27332858195e334a1802dcf591
-- 
2.47.1


