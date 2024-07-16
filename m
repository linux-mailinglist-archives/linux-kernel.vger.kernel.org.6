Return-Path: <linux-kernel+bounces-253403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CF19320C9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 08:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDD67B219EA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 06:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8627C1CFBE;
	Tue, 16 Jul 2024 06:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bLWEJ6In"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03A61CD39
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721112918; cv=none; b=e0TB6xDtzcSVBR66V1UdVRZlrqBBKSk0U2oIufU5rFYh6/rfGGnh1E/B4HC7DQcuH5jT/v9Mj4mkKlr2SYPBQBNoN749geqIQz+AZwSRHYEq3j1A+H8BAnYJ0uLKdcvqOjhNFyY7KUce1gZwWA6ZhGGDB6RXwEWFsaCagLsp+Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721112918; c=relaxed/simple;
	bh=DfqVHEM/JHNEmI3EXhl5J5LalUoDyiv4zLiIsKFYdKo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A3yEzQZw70Gxl3RTXUOmKzXluCqd8qdjr0zKehE+oZLclfysxmaLNPODNBBpWLldml5j9Z32DZzKFlYPqUpF0brDvUmWqC/ykguj8wgGYbWyLCSNJLuQiYB76XKMCLmUYIJgyZPZgv+GptIQejznUMTukNcsuViXYhCVvVfmVg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bLWEJ6In; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A4EFD40E0223;
	Tue, 16 Jul 2024 06:55:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lLySKcLE_cIi; Tue, 16 Jul 2024 06:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1721112908; bh=ygzrCeNipETpAP+iPDncrOl/Mb7ATe7ELb5oVJ00kts=;
	h=Date:From:To:Cc:Subject:From;
	b=bLWEJ6In/yqGtVzSj+WE/bRqyi3nVLNWduGV/dfemuHQf9SojL4C3U5Cjh1ly2kPj
	 f3pwM8P/YJ5Qz+nE5BdhOwrl67hUL/4BVXZCL9Xrf5bSH7VUubHUo8RUPRdrbVOWnG
	 UMGiAqU62HUWtyUqlMgNAqzIv3y6NX34y89mkuSbNXi/lHMDsWzJWvf/AOC0Tee2dy
	 T1dsG+IeFmQJ4sK7fiNJEHive/20di3dnTamJ4BoByj35BjjMldhCeY4lrJ7SboI7G
	 kAgy0HWnrdeh4f4JZNvLZ5uuINtOGp7ohkDYts4pg/VdDdhsuduvl78JWoL4c6OxBA
	 l3ljGoCE02+knxMpu3ToloSS72go6q+2fU3TQxdfoQUubb/dj66KilOtkYCxjJjCWg
	 Cl5WJ9j8HttGZANUMWAvE0jv41rBCixQMZttId8nnUfnKl2SB+QowANKiBBFCcd5sm
	 LypiRnOtonNhLzNr2O5S+o2IqKXR3Wek04smkLOVsukiaGMS51q3cjCaPGTaNHv7yb
	 weoCKDAP1zK+wj459DaoNnYwjOZrpHbMMPvgkZB1tp+ggAcAZXTeQ3VFVozsPDMLjL
	 1YLxnRQuruMmCCPCUEFOpfRRD+lTgKIE2f5NbjqKIlM3uiTCWQ5ncjWbzgVXzcdHDa
	 dEAEzwDy9VIVaHSdfNrV950Q=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5269640E0221;
	Tue, 16 Jul 2024 06:55:05 +0000 (UTC)
Date: Tue, 16 Jul 2024 08:54:58 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cache for v6.11-rc1
Message-ID: <20240716065458.GAZpYZQhh0PBItpD1k@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/cache lineup for v6.11-rc1.

Thx.

---

The following changes since commit f385f024639431bec3e70c33cdbc9563894b3ee5:

  x86/resctrl: Replace open coded cacheinfo searches (2024-06-10 08:50:12 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_cache_for_v6.11_rc1

for you to fetch changes up to ea34999f41873c96ac89e861e5fdfc7d0403f9e3:

  x86/resctrl: Update documentation with Sub-NUMA cluster changes (2024-07-02 20:03:19 +0200)

----------------------------------------------------------------
 - Enable Sub-NUMA clustering to work with resource control on Intel by
   teaching resctrl to handle scopes due to the clustering which
   partitions the L3 cache into sets. Modify and extend the subsystem to
   handle such scopes properly

----------------------------------------------------------------
Tony Luck (19):
      x86/resctrl: Prepare for new domain scope
      x86/resctrl: Prepare to split rdt_domain structure
      x86/resctrl: Prepare for different scope for control/monitor operations
      x86/resctrl: Split the rdt_domain and rdt_hw_domain structures
      x86/resctrl: Add node-scope to the options for feature scope
      x86/resctrl: Introduce snc_nodes_per_l3_cache
      x86/resctrl: Block use of mba_MBps mount option on Sub-NUMA Cluster (SNC) systems
      x86/resctrl: Prepare for new Sub-NUMA Cluster (SNC) monitor files
      x86/resctrl: Add a new field to struct rmid_read for summation of domains
      x86/resctrl: Initialize on-stack struct rmid_read instances
      x86/resctrl: Refactor mkdir_mondata_subdir() with a helper function
      x86/resctrl: Allocate a new field in union mon_data_bits
      x86/resctrl: Create Sub-NUMA Cluster (SNC) monitor files
      x86/resctrl: Handle removing directories in Sub-NUMA Cluster (SNC) mode
      x86/resctrl: Fill out rmid_read structure for smp_call*() to read a counter
      x86/resctrl: Make __mon_event_count() handle sum domains
      x86/resctrl: Enable shared RMID mode on Sub-NUMA Cluster (SNC) systems
      x86/resctrl: Detect Sub-NUMA Cluster (SNC) mode
      x86/resctrl: Update documentation with Sub-NUMA cluster changes

 Documentation/arch/x86/resctrl.rst        |  27 +++
 arch/x86/include/asm/msr-index.h          |   1 +
 arch/x86/kernel/cpu/resctrl/core.c        | 312 ++++++++++++++++++++++--------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  89 ++++++---
 arch/x86/kernel/cpu/resctrl/internal.h    | 108 ++++++++---
 arch/x86/kernel/cpu/resctrl/monitor.c     | 250 +++++++++++++++++++-----
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  27 +--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 276 ++++++++++++++++----------
 include/linux/resctrl.h                   |  88 ++++++---
 9 files changed, 855 insertions(+), 323 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

