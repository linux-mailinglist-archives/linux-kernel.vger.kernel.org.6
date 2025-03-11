Return-Path: <linux-kernel+bounces-555546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0708A5B95E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE873ACAD7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 06:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B2C1EBA0C;
	Tue, 11 Mar 2025 06:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ayMr+Zcc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0656360
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 06:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741675532; cv=none; b=PdFDteEhUhcWAiKeq4LmZJ4ZdafKe/Eu1wcjk34L5tdMyE9RUbsBiuHZqx48BSDFfVXNugJt/6tKWLtgnYWlBq7zzFC6SmE0LO6YlfeklcfaBpB/KT7R05xXkXAZ+IBaP41LY2o8zUNn3PixG6/ezvFOXNA29oult7uLIPJJJpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741675532; c=relaxed/simple;
	bh=wUx86Xs4QmwfkauzxHUVzTI+dcKFK5TmOSvB8z7y32c=;
	h=From:To:Cc:Subject:Message-ID:Date:MIME-Version:Content-Type; b=W1qBK1/z8EH2OEBboPuM5M9o+3CPA34d6S2WD+SZ2qjVWD4EqKoAsM4t7C8UTsQGfap7fHOcxwZIWqfOfU+ah1/ED8qcbCnWYVTcoA9uvLXOdrAnXA78qcy5lFypr9PasDTvJgtVx+V+VlGiWkXY1Fk1AfFp62Gr6Kx1DAD7JXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ayMr+Zcc; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741675531; x=1773211531;
  h=from:to:cc:subject:message-id:date:mime-version:
   content-transfer-encoding;
  bh=wUx86Xs4QmwfkauzxHUVzTI+dcKFK5TmOSvB8z7y32c=;
  b=ayMr+Zcc0fuCBk9p8nH9PFKsMN06/Kqu+66XAPMoGNk2b4/jqHiA8QTX
   XIFLs/+RPGJ5ToNqWE1rtEIaEdXgcCptC5fdlpeUrgDszL6YsjQqj4pG0
   ECwPF/ex6D0kLIRdq/kc88TDbxmNDtOip3YZHiNz1Uh/d9TDNAoq97z/Y
   anmsSBe+CniWyQUHiMnpR47LaCSYvh1uqxA6CuCOixrBgxAspQRB8ZhuF
   Nj3bJ1jkW6TqK5IqkP+UNOCmV8GQGsnSFMkkKz/rQCmdCAnSPKT5if7Ob
   d5cMptL7k3szWvxEuXfpwxL3R/Es9xMDesb3iccMjbAMwe7HpBfErA9R0
   A==;
X-CSE-ConnectionGUID: n7tbBfezQaaIjlM2FEnr5Q==
X-CSE-MsgGUID: KYM4Dq6JTo+QpdQLnqKWDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42883440"
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="42883440"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 23:45:30 -0700
X-CSE-ConnectionGUID: zDAqQkwdRFaMnP+zKR7U9g==
X-CSE-MsgGUID: HQwrlAh4QxmEEYn7FigIcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="125424464"
Received: from ipu5-build.bj.intel.com (HELO [10.238.232.136]) ([10.238.232.136])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 23:45:29 -0700
From: Bingbu Cao <bingbu.cao@linux.intel.com>
To: link@vivo.com, vivek.kasireddy@intel.com
Cc: linux-kernel@vger.kernel.org, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org
Subject: udmabuf vmap failed (Revert "udmabuf: fix vmap_udmabuf error page
 set" can help)
Message-ID: <9172a601-c360-0d5b-ba1b-33deba430455@linux.intel.com>
Date: Tue, 11 Mar 2025 14:40:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit


Huan Yang and Vivek,

I am trying to use udmabuf for my test, and I cannot vmap the udmabuf
buffers now. vmap_pfn_apply() will report a warning to complain that
the pfns are invalid.
I dump the pfn numbers as below:
[ 3365.399641] pg[0] pfn 1148695
[ 3365.399642] pg[1] pfn 1145057
[ 3365.399642] pg[2] pfn 1134070
[ 3365.399643] pg[3] pfn 1148700
[ 3365.399643] pg[4] pfn 1144871
[ 3365.399643] pg[5] pfn 1408686
[ 3365.399643] pg[6] pfn 1408683
...
[ 3365.399660] WARNING: CPU: 3 PID: 2772 at mm/vmalloc.c:3489 vmap_pfn_apply+0xb7/0xd0
[ 3365.399667] Modules linked in:...
[ 3365.399750] CPU: 3 UID: 0 PID: 2772 Comm: drm-test Not tainted 6.13.0-rc2-rvp #845
[ 3365.399752] Hardware name: Intel Corporation Client Platform/xxxx, BIOS xxxFWI1.R00.3221.D83.2408120121 08/12/2024
[ 3365.399753] RIP: 0010:vmap_pfn_apply+0xb7/0xd0
[ 3365.399755] Code: 5b 41 5c 41 5d 5d c3 cc cc cc cc 48 21 c3 eb d1 48 21 c3 48 23 3d 31 c0 26 02 eb c5 48 c7 c7 c4 3c 20 a8 e8 5b c0 d8 ff eb 8a <0f> 0b b8 ea ff ff ff 5b 41 5c 41 5d 5d c3 cc cc cc cc 0f 1f 80 00
[ 3365.399756] RSP: 0018:ffffb9b50c32fad0 EFLAGS: 00010202
[ 3365.399757] RAX: 0000000000000001 RBX: 0000000000118717 RCX: 0000000000000000
[ 3365.399758] RDX: 0000000080000000 RSI: ffffb9b50c358000 RDI: 00000000ffffffff
[ 3365.399758] RBP: ffffb9b50c32fae8 R08: ffffb9b50c32fbd0 R09: 0000000000000001
[ 3365.399759] R10: ffff941602479288 R11: 0000000000000000 R12: ffffb9b50c32fbd0
[ 3365.399759] R13: ffff941618665ac0 R14: ffffb9b50c358000 R15: ffff941618665ac8
[ 3365.399760] FS:  00007ff9e9ddd740(0000) GS:ffff94196f780000(0000) knlGS:0000000000000000
[ 3365.399760] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3365.399761] CR2: 000055fda5dc69d9 CR3: 00000001544de003 CR4: 0000000000f72ef0
[ 3365.399762] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 3365.399762] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[ 3365.399763] PKRU: 55555554
[ 3365.399763] Call Trace:
[ 3365.399765]  <TASK>
[ 3365.399769]  ? show_regs+0x6d/0x80
[ 3365.399773]  ? __warn+0x97/0x160
[ 3365.399777]  ? vmap_pfn_apply+0xb7/0xd0
[ 3365.399777]  ? report_bug+0x1ec/0x240
[ 3365.399782]  ? handle_bug+0x63/0xa0
[ 3365.399784]  ? exc_invalid_op+0x1d/0x80
[ 3365.399785]  ? asm_exc_invalid_op+0x1f/0x30
[ 3365.399790]  ? vmap_pfn_apply+0xb7/0xd0
[ 3365.399791]  __apply_to_page_range+0x522/0x8a0
[ 3365.399794]  ? __pfx_vmap_pfn_apply+0x10/0x10
[ 3365.399795]  apply_to_page_range+0x18/0x20
[ 3365.399796]  vmap_pfn+0x77/0xd0
[ 3365.399797]  vmap_udmabuf+0xc5/0x110
[ 3365.399802]  dma_buf_vmap+0x96/0x130

I did an experiment to revert 18d7de823b7150344d242c3677e65d68c5271b04,
then I can vmap the pages. Could you help what's wrong with that? 


-- 
Best regards,
Bingbu Cao

