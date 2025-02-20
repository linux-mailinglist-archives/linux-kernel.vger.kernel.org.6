Return-Path: <linux-kernel+bounces-524305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8557BA3E1B4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F65A3BA09B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B08E20DD6E;
	Thu, 20 Feb 2025 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XTMerqX0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eaoodYHM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XTMerqX0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eaoodYHM"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279FD17A2F0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070467; cv=none; b=mzqulfE1sbIVI9/sbHV8vLfPOzOzD3HzDEXJOY1qAlJJzdGQ/ZJ4tAcrE3tPEw2Bs5m8NRoeHnkf3h9Voy0T7NIy7C4ADcF7/oNxMjYkepjqC3KjsCKgqvB7U+Qs4Y6BIKm+epjCs1zvFc53orFawQ5s+UvxCoNvuczp92StL7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070467; c=relaxed/simple;
	bh=ci26Mu8FbxdZmJKduMzpDrDy7ncCG3jMAOBwVjjOSvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=raJGWPn13BYsJXRzMCCvRqWuiaFi4JQHt/fOs2zmI2H/HPwOB93QdBIGp60F7PPBovXyibZrHF3idEfPQML8YSrAa2yTY5SuexkZe4kUoXx1FOYbTvjtoqM3EE73lSSqbHfBQIzTlghI4cIkjRGxz1BxtmXT2TPIUoAagLsy2Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XTMerqX0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eaoodYHM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XTMerqX0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eaoodYHM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from localhost (unknown [10.100.12.32])
	by smtp-out1.suse.de (Postfix) with ESMTP id 7976721186;
	Thu, 20 Feb 2025 16:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740070464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wakkuwf1ugz5t/UIuNizagYe9kFHhtgEfpZOsreDN3A=;
	b=XTMerqX0GICjNsYCmpT3d86Y5d/iCOx3eeIgF+zW9pC0xqJUBLi1xpGj28SIdC6SbeWbMa
	7NpY3W4Q9XcH8kNohCHJQ5QQWWzOPd1txXDLDLIIh5qQmdD73YynIG3U3SSssZMdl78yqh
	Uc7N/GG8qI0ZFM7ZFs7VsucAXvt/wCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740070464;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wakkuwf1ugz5t/UIuNizagYe9kFHhtgEfpZOsreDN3A=;
	b=eaoodYHMSTrDFPSZZoxEeoyhBJcAyVrRgb032l5UFSC5tZ7yzLRtWRtBEwYIhzM6LA/9La
	Q5TByx/Su9H0/ZDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740070464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wakkuwf1ugz5t/UIuNizagYe9kFHhtgEfpZOsreDN3A=;
	b=XTMerqX0GICjNsYCmpT3d86Y5d/iCOx3eeIgF+zW9pC0xqJUBLi1xpGj28SIdC6SbeWbMa
	7NpY3W4Q9XcH8kNohCHJQ5QQWWzOPd1txXDLDLIIh5qQmdD73YynIG3U3SSssZMdl78yqh
	Uc7N/GG8qI0ZFM7ZFs7VsucAXvt/wCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740070464;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wakkuwf1ugz5t/UIuNizagYe9kFHhtgEfpZOsreDN3A=;
	b=eaoodYHMSTrDFPSZZoxEeoyhBJcAyVrRgb032l5UFSC5tZ7yzLRtWRtBEwYIhzM6LA/9La
	Q5TByx/Su9H0/ZDw==
Date: Thu, 20 Feb 2025 17:54:24 +0100
From: Jiri Bohac <jbohac@suse.cz>
To: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc: Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
	linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: [PATCH v2 3/5] kdump, documentation: describe craskernel CMA
 reservation
Message-ID: <Z7deQKy1F8BW1ibi@dwarf.suse.cz>
References: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
X-Spam-Score: -4.26
X-Spamd-Result: default: False [-4.26 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.16)[-0.785];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,localhost:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Describe the new crashkernel ",cma" suffix in Documentation/
---
 Documentation/admin-guide/kdump/kdump.rst     | 19 +++++++++++++++++--
 .../admin-guide/kernel-parameters.txt         | 14 ++++++++++++++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index 5376890adbeb..3f7ff301c604 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -213,8 +213,7 @@ Dump-capture kernel config options (Arch Dependent, i386 and x86_64)
    kernel.
 
    Otherwise it should be the start of memory region reserved for
-   second kernel using boot parameter "crashkernel=Y@X". Here X is
-   start of memory region reserved for dump-capture kernel.
+   second kernel using boot parameter "crashkernel=Y@X". Here X is start of memory region reserved for dump-capture kernel.
    Generally X is 16MB (0x1000000). So you can set
    CONFIG_PHYSICAL_START=0x1000000
 
@@ -315,6 +314,22 @@ crashkernel syntax
 
             crashkernel=0,low
 
+4) crashkernel=size,cma
+
+   Reserves additional memory from CMA. A standard crashkernel reservation, as
+   described above, is still needed, but can be just big enough to hold the
+   kernel and initrd. All the memory the crash kernel needs for its runtime and
+   for running the kdump userspace processes can be provided by this CMA
+   reservation, re-using memory available to the production system's userspace.
+   Because of this, the CMA reservation should not be used if kdump is configured
+   to dump userspace memory - the re-used memory ranges won't be in the vmcore.
+
+   This option increases the risk of a kdump failure: DMA transfers configured
+   by the first kernel may end up corrupting the second kernel's memory. This
+   reservation method is intended for systems that can't afford to sacrifice
+   enough memory for standard crashkernel reservation and where less reliable
+   kdump is preferrable to no kdump at all.
+
 Boot into System Kernel
 -----------------------
 1) Update the boot loader (such as grub, yaboot, or lilo) configuration
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb8752b42ec8..ea4d53435515 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -987,6 +987,20 @@
 			0: to disable low allocation.
 			It will be ignored when crashkernel=X,high is not used
 			or memory reserved is below 4G.
+	crashkernel=size[KMG],cma
+			[KNL, X86] Reserve additional crash kernel memory from CMA.
+			This reservation is usable by the first system's userspace,
+			so this should not be used if dumping of userspace
+			memory is intended. A standard crashkernel reservation,
+			as described above, is still needed to hold the crash
+			kernel and initrd.
+			This option increases the risk of a kdump failure: DMA
+			transfers configured by the first kernel may end up
+			corrupting the second kernel's memory. This reservation
+			method is intended for systems that can't afford to
+			sacrifice enough memory for standard crashkernel
+			reservation and where less reliable kdump is preferrable 
+			to no kdump at all.
 
 	cryptomgr.notests
 			[KNL] Disable crypto self-tests

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


