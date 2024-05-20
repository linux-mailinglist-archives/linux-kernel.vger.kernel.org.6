Return-Path: <linux-kernel+bounces-184087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D3B8CA254
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 20:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE3F7B213DE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 18:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB6C1384A8;
	Mon, 20 May 2024 18:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="NzX9byB9"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D3628E7
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 18:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716231117; cv=none; b=Eqhx+3mXXGf1utq02ieQbg0fSUGXpC3MewryuER3/Xe/N3dEUTWC3e53zUWFJl+hAyHr9n8BFVXAPtdILQqeZj3XDlBdOakbZA/DUbzhO++pAJfwiR0Psx25tHXuugqUaL8NrEsuugVnH+R9SxfegS8AsQFvujPtv/9ra321ju8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716231117; c=relaxed/simple;
	bh=6tLFbmidl9HnmzZm8HcHCOLMdxh/LS/KgnKuTyXyQvk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GAqkw3rTcXC7ugPgqlcfYsOIkMFwS6YKZ6atRGiQLKpqzSjg4aglqIsmFBbCQty7XbaTdllMg0T2J1bqcem40gbBWHz7dxgR9M691YG33gdR9G/ZKaWRVijuMWIlWBUN4yvWS9ExrQ8833rr3BE1Su1HWSPjyl/vZrXU2YKsEHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=NzX9byB9; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44KFWVTX015440;
	Mon, 20 May 2024 18:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pps0720;
 bh=XVyGGxu8eKIsYmasMQuhPuegyxURmUzy8LZ8dneLhyg=;
 b=NzX9byB94Vkcw1Nwy4xBEQGijsKiaDGiysViF7xBY6/xNVp5vlBHFh9glVR+Jbpw2FXs
 UjUM7KME3mTYiy2FMDlfvyA1ogctBfOg60ZgBQnk1Us99kJpSVId6oxKmHKi0HM2PL94
 EPogbINypITxe9IComGyejjMm9wVeD7NZjgI5dFTFockxSt8Pqd6Opguh8CrY91bwNSV
 eP1r8I6fKIBUydFet/se27sBEsnZdbintWj3bWwmfISlroMMYxkobQcF1W/jEl1mEB0q
 gk70d+KZEJyvA4BvQXEtacxow3noT6dUBFsnWFqPVV9v1nGUEFqBaRrXJBalQYp7TFzf JA== 
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3y7qxj0w25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 18:36:41 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 87A59130EA;
	Mon, 20 May 2024 18:36:39 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.39])
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 6AE5F80E37C;
	Mon, 20 May 2024 18:36:37 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
	id A692730000956; Mon, 20 May 2024 13:36:33 -0500 (CDT)
From: Steve Wahl <steve.wahl@hpe.com>
To: Steve Wahl <steve.wahl@hpe.com>, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Pavin Joseph <me@pavinjoseph.com>, Eric Hagberg <ehagberg@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, Eric Biederman <ebiederm@xmission.com>,
        Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>,
        Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
        Hou Wenlong <houwenlong.hwl@antgroup.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
        Yuntao Wang <ytcoode@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>, Michael Roth <michael.roth@amd.com>
Subject: [PATCH 0/3] Resolve problems with kexec identity mapping
Date: Mon, 20 May 2024 13:36:30 -0500
Message-Id: <20240520183633.1457687-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
X-Proofpoint-GUID: OObMmZjbRG2JVAcKJBDKHm5UjFSP6in-
X-Proofpoint-ORIG-GUID: OObMmZjbRG2JVAcKJBDKHm5UjFSP6in-
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_09,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 clxscore=1011 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2405200149

Although there was a previous fix to avoid early kernel access to the
EFI config table on Intel systems, the problem can still exist on AMD
systems that support SEV (Secure Encrypted Virtualization).  The
command line option "nogbpages" brings this bug to the surface.  And
this is what caused the regression with my earlier patch that
attempted to reduce the use of gbpages.  This patch series fixes that
problem and restores my earlier patch.

The following 2 commits caused the EFI config table, and the CC_BLOB
entry in that table, to be accessed when enabling SEV at kernel
startup.

    commit ec1c66af3a30 ("x86/compressed/64: Detect/setup SEV/SME features
                          earlier during boot")
    commit c01fce9cef84 ("x86/compressed: Add SEV-SNP feature
                          detection/setup")

These accesses happen before the new kernel establishes its own
identity map, and before establishing a routine to handle page faults.
But the areas referenced are not explicitly added to the kexec
identity map.

This goes unnoticed when these areas happen to be placed close enough
to others areas that are explicitly added to the identity map, but
that is not always the case.

Under certain conditions, for example Intel Atom processors that don't
support 1GB pages, it was found that these areas don't end up mapped,
and the SEV initialization code causes an unrecoverable page fault,
and the kexec fails.

Tau Liu had offered a patch to put the config table into the kexec
identity map to avoid this problem:

https://lore.kernel.org/all/20230601072043.24439-1-ltao@redhat.com/

But the community chose instead to avoid referencing this memory on
non-AMD systems where the problem was reported.

    commit bee6cf1a80b5 ("x86/sev: Do not try to parse for the CC blob
                          on non-AMD hardware")

I later wanted to make a different change to kexec identity map
creation, and had this patch accepted:

    commit d794734c9bbf ("x86/mm/ident_map: Use gbpages only where full GB page should be mapped.")

but it quickly needed to be reverted because of problems on AMD systems.

The reported regression problems on AMD systems were due to the above
mentioned references to the EFI config table.  In fact, on the same
systems, the "nogbpages" command line option breaks kexec as well.

So I resubmit Tau Liu's original patch that maps the EFI config
table, add an additional patch by me that ensures that the CC blob is
also mapped (if present), and also resubmit my earlier patch to use
gpbages only when a full GB of space is requested to be mapped.

I do not advocate for removing the earlier, non-AMD fix.  With kexec,
two different kernel versions can be in play, and the earlier fix
still covers non-AMD systems when the kexec'd-from kernel doesn't have
these patches applied.

All three of the people who reported regression with my earlier patch
have retested with this patch series and found it to work where my
single patch previously did not.  With current kernels, all fail to
kexec when "nogbpages" is on the command line, but all succeed with
"nogbpages" after the series is applied.

Tao Liu (1):
  x86/kexec: Add EFI config table identity mapping for kexec kernel

Steve Wahl (2):
  x86/kexec: Add EFI Confidential Computing blob to kexec identity
    mapping.
  x86/mm/ident_map: Use gbpages only where full GB page should be
    mapped.

 arch/x86/kernel/machine_kexec_64.c | 82 ++++++++++++++++++++++++++++--
 arch/x86/mm/ident_map.c            | 23 +++++++--
 2 files changed, 95 insertions(+), 10 deletions(-)

-- 
2.26.2


