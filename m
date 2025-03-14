Return-Path: <linux-kernel+bounces-561362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE641A61079
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8EF919C1CFE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719031FDE27;
	Fri, 14 Mar 2025 11:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bctgYOS0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4471FCFFC;
	Fri, 14 Mar 2025 11:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741953448; cv=none; b=eC8e7CWwhhfqaXTUaq9VHUSHiVcCS4rnuFYNFgE4w7Qup2ykVg6ASb3dCGWiDavQCCTlgG4soU7K4uiRexgwFXTfj3/Lbz3zMWFDWl+wSuOP4LzAXZpHE7x6ZiyK+k2hep4pKLpAQfYxZCbvQ5bQjxTGWGDM+oEx/Yrh0OywMtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741953448; c=relaxed/simple;
	bh=Xdms5+QQhoz6Zd6XPHIzvq+uHuf+7xFlemSQMYg/9Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oys5nk8m53PWUkYPXPFrTrtXkSpbjr8vmkU3upHYpoX2tQobUaFt0sEof71ts+1uBEQecoxxBajU7Y23Rit0jDw3d5PIR3a7Sdbh4vNfyeV12tg9FFmsp4xbfo+5f7RhbJGxNa2LDgHt2t+LzH4aK6IVV2df7gyIm/92t43EYwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bctgYOS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852A8C4CEE3;
	Fri, 14 Mar 2025 11:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741953448;
	bh=Xdms5+QQhoz6Zd6XPHIzvq+uHuf+7xFlemSQMYg/9Dg=;
	h=From:To:Cc:Subject:Date:From;
	b=bctgYOS0cSs+68qiGz3z82KzOpPH6pTkCZkYl9D8mIyfiFFmsqcqbgL/dlc4zf47f
	 oMX8pD4UawacOp+GOnVBz/tz2kscPoEeNsbW7Ii58MhohKMLNuR7E1v5ShE2dA/f+m
	 BzU5oWzwdHXwVGuCkrk01U5LO2zL9iLeUYWO7UGo5rofsAHQALb55+NiDcAUK8YbC8
	 zEiPhPxnWnvGAwC4UeXYV0EZRPnJlJEsQaxtcQ/lSE1ixW40ohCrsv4sq66ZHK0StN
	 hebWyVcAdICzIAsT0b8Hl9Es7S3OIJD4DNlZK3zTDkLxYfgkvDlLidyAalpg9/r8NW
	 oOL7+lEOfWyWg==
From: Alexey Gladkov <legion@kernel.org>
To: x86@kernel.org
Cc: "Alexey Gladkov (Intel)" <legion@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	Alexey Gladkov <alexey.gladkov@intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Joerg Roedel <jroedel@suse.de>,
	Juergen Gross <jgross@suse.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Larry.Dewey@amd.com,
	Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: [RFC PATCH v1 0/3] Export TDX module information via SYSFS
Date: Fri, 14 Mar 2025 12:56:25 +0100
Message-ID: <cover.1741952958.git.legion@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alexey Gladkov (Intel)" <legion@kernel.org>

TD-Preserving updates depend on a userspace tool to select the appropriate
module to load. To facilitate this decision-making process, expose the
necessary information to userspace.

Also TDX module information (version, supported features, etc) is crucial for
bug reporting. For this purpose, it makes sense to have a consistent structure
for host and guest information in sysfs.

As already discussed [1] in the mailing list for tdx used the directory
/sys/hypervisor/tdx.

[1] https://lore.kernel.org/lkml/20250311110748.GCZ9AZhPYYAz-MXErv@fat_crate.local/


Alexey Gladkov (Intel) (3):
  x86/tdx: Make TDX metadata available via SYSFS
  x86/tdx: Make TDX metadata available on guest via SYSFS
  docs: ABI: testing: Add documentation about TDX

 .../ABI/testing/sysfs-hypervisor-tdx          | 50 ++++++++++
 arch/x86/Kconfig                              |  2 +
 arch/x86/coco/tdx/tdx.c                       | 92 +++++++++++++++++++
 arch/x86/include/asm/shared/tdx.h             |  2 +
 arch/x86/include/asm/tdx.h                    | 12 +++
 arch/x86/virt/vmx/tdx/tdx.c                   | 74 +++++++++++++++
 6 files changed, 232 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-hypervisor-tdx

-- 
2.48.1


