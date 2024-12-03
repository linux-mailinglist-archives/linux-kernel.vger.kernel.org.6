Return-Path: <linux-kernel+bounces-429347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 946AD9E1CD9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF54CB25B66
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EC51E3799;
	Tue,  3 Dec 2024 11:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ju48PFzp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A40A2E3EE
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 11:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733225138; cv=none; b=fkrQrxrfoz+cXcKMqhXixN8x8gNtiGYgh50QwEm4sfceEVlkfC3lCY683Do35CuFQ4gwBxNbbWbxmNVPLMQ/pGpIj7dIshOK9ensGV6cmzkcutL2Lnvxqm5/QtTAer4ieYARlw0934ptQIILEo3RAtPCNHyNydbvBstIF+ubxIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733225138; c=relaxed/simple;
	bh=2Jrgv3mWyD9qBHNIHYWgGa2ngT9anFHYmDBdik+Nk58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B2KStSg2fCHRPbBaQqH8DXSPpLgpWbaxPEfKrM4nmk7y1EjneqZmxyrhagxy4DHcya9xW4TQImwa4S0FTVRRXdAvOO6+QktoMHPepbn6ER/cyfHnmmEjeNT0hfYV6zK29gz1xCE89V9lu2s/prlGPEwVcmTG8N6q2YZ1biagd+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ju48PFzp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0222DC4CECF;
	Tue,  3 Dec 2024 11:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733225138;
	bh=2Jrgv3mWyD9qBHNIHYWgGa2ngT9anFHYmDBdik+Nk58=;
	h=From:To:Cc:Subject:Date:From;
	b=ju48PFzpSAkdW+CSkw36U8FLvVo4P0s181OqHtSG/oIqXnDsso+aMPLeIvGY0Cx+F
	 mx0LNsXXcztUJLHDVdPqHF8shuOVTs3qMR+lbiPQpXpR7PZLTt9+Ty2iH8+0vXHoux
	 JdP74AfdAcf5qL8OmbS702dNeDyqMqZCUX8MdERCGuQaA//YZ7GZs9H1+d4wnykFk4
	 7e1qahm4ahkGCL8Ey4t9lO4WO08pDFc44XbOeiWdIhy4bNNe9qcxOZbT+0QQKR8lfl
	 w/YuC6x/7NdZMgLvnF09MJiMxedwqcpvJILcHJQ8LaOcGloMKosytbt6h94PZrt2Y5
	 7TFqTMbxI0Mdg==
From: Mike Rapoport <rppt@kernel.org>
To: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	Ning Sun <ning.sun@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	tboot-devel@lists.sourceforge.net
Subject: [PATCH 0/4] x86/boot: a few cleanups
Date: Tue,  3 Dec 2024 13:25:21 +0200
Message-ID: <20241203112525.591496-1-rppt@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Hi,

These patches cleanup x86::setup_arch() e820.c.
No functional changes intended.

Mike Rapoport (Microsoft) (4):
  x86/boot: move setting of memblock parameters to e820__memblock_setup()
  x86/boot: split kernel resources setup into a helper function
  x86/boot: split parsing of boot_params into a helper function
  x86/e820: drop E820_TYPE_RESERVED_KERN and related code

 arch/x86/include/asm/e820/api.h   |   1 -
 arch/x86/include/asm/e820/types.h |   9 --
 arch/x86/kernel/e820.c            |  95 ++++++++-------------
 arch/x86/kernel/setup.c           | 134 ++++++++++++++----------------
 arch/x86/kernel/tboot.c           |   3 +-
 arch/x86/mm/init_64.c             |   8 --
 6 files changed, 97 insertions(+), 153 deletions(-)


base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
-- 
2.45.2


