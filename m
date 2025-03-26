Return-Path: <linux-kernel+bounces-576739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B5AA713D6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A31A97A5A72
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58FA1A8412;
	Wed, 26 Mar 2025 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c5gD+Uvg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9381624DF
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742981779; cv=none; b=V0R6sLw5Z7xmI5Ag5sdKVCD57NZ6jL7IXjPKTEgQbqcSyOP7PDBoi1+RhNtZOkyWnVp/Itmf6yUSReFAYuMN+KdvSnYoo1NpXWGMkHTyJphraz3rcTqiTnJ7fzTEnjqrBz6065kWyamdl1YbzIqDKa+9stno2yIaettIrCUB/TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742981779; c=relaxed/simple;
	bh=aPS1tJ4jno8OgHfjqqCfT1rUCV0Rlu9rTyQpCyd/T3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grc7vAMNtHYHWoQR6XntclQk1LkDKEhzoIsoxOq146xxwm+zczWwLJKmNHqFrQcggDvh1Jb0lWCgHopxnjvGlwb0FVBVrNnTrR5UOx24A+LgGhtOmdqvdMtxFXUlkrkfgyD1CT4jcQQemR/oXq6wVqlg/UKQToZiJsQDBtb3qeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c5gD+Uvg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742981776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7s6kGrJksefYUT5ouwvuh5z8KUx3QyiVOgbgLYNxiYY=;
	b=c5gD+UvgXhRBCGdCuLW/vJA1FtYuc0TpmCdlgBRqHoafZZt2kXQeKW0QwOrb3+PI0JNfjm
	Vanjt6GQkMBH84Yhf/hkOMgUdhAWHeWwNY1gAS01eb9IXdTTWfKlmbhgqvvgjva3GvaahR
	pmhLQEFk+YnIxLiycblcfXRX+L+Dl5A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-Ntfzn1olMPiWbWipkhq9bA-1; Wed,
 26 Mar 2025 05:36:12 -0400
X-MC-Unique: Ntfzn1olMPiWbWipkhq9bA-1
X-Mimecast-MFC-AGG-ID: Ntfzn1olMPiWbWipkhq9bA_1742981771
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 050D61809CA5;
	Wed, 26 Mar 2025 09:36:11 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.42])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3517919541A5;
	Wed, 26 Mar 2025 09:36:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 26 Mar 2025 10:35:38 +0100 (CET)
Date: Wed, 26 Mar 2025 10:35:33 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: kernel test robot <lkp@intel.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Phil Auld <pauld@redhat.com>
Subject: Re: kernel/sched/isolation.c:50: undefined reference to
 `sched_numa_find_closest'
Message-ID: <20250326093532.GA30181@redhat.com>
References: <202503260646.lrUqD3j5-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202503260646.lrUqD3j5-lkp@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 03/26, kernel test robot wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   2d09a9449ecd9a2b9fdac62408c12ee20b6307d2
> commit: 5097cbcb38e6e0d2627c9dde1985e91d2c9f880e sched/isolation: Prevent boot crash when the boot CPU is nohz_full
> date:   11 months ago
> config: sh-randconfig-r132-20250326 (https://download.01.org/0day-ci/archive/20250326/202503260646.lrUqD3j5-lkp@intel.com/config)
...
> >> kernel/sched/isolation.c:50: undefined reference to `sched_numa_find_closest'

kernel/sched/isolation.c makes no sense without CONFIG_SMP, but

	config CPU_ISOLATION
		bool "CPU isolation"
		depends on SMP || COMPILE_TEST

and .config above has CONFIG_COMPILE_TEST but not CONFIG_SMP.

It also has CONFIG_NUMA, it doesn't depend on CONFIG_SMP in
arch/sh/mm/Kconfig, so isolation.c can't use the dummy version
of sched_numa_find_closest() in kernel/sched/sched.h, and
kernel/sched/build_utility.c doesn't include topology.c without
CONFIG_SMP.

Perhaps we can should simply remove this "|| COMPILE_TEST" ?

Oleg.

--- x/init/Kconfig
+++ x/init/Kconfig
@@ -709,7 +709,7 @@ endmenu # "CPU/Task time and stats accou
 
 config CPU_ISOLATION
 	bool "CPU isolation"
-	depends on SMP || COMPILE_TEST
+	depends on SMP
 	default y
 	help
 	  Make sure that CPUs running critical tasks are not disturbed by



