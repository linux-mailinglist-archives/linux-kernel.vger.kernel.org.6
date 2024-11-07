Return-Path: <linux-kernel+bounces-400338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 536E09C0C0C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14F22282EA1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2495216211;
	Thu,  7 Nov 2024 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CEFRhjWM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAB01DF273
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730998642; cv=none; b=Q7ORK72bcU8BWneUSf0ZHwCd45SjCQWQj8lYqx1RMgRXPe5hxKQ6uNwYS/O8jz4uTPJk9i/Bw+l5Z24lBNJ6YRdpsdpHDfFvPiR3MDfYG7V9hMMsjwj4rIK1IGSaKLMmgsa8UjuHc2juyGjEqm/mOhwVoeKhNC+7NSDp2xNwRgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730998642; c=relaxed/simple;
	bh=kz6H1iWURN4eTl4Z5xgP1rh2O+9ql2lyNjRORB5TwyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZZRRmPXG3Jv/xRm8o2TNk9T68LSKM00qDA7CZMJI96dJUm6UyRlHxJAGT4cz3n1Zrko0t4VXdtpxmsfcwIZeI+HcnCL531iMHzUr4TGUVjDBGPHazw17zf75X4JAGrapdgv41udGN70ly9UtUfnQQ6kU9Y3j3WKpsHTMk/fHEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CEFRhjWM; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730998641; x=1762534641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kz6H1iWURN4eTl4Z5xgP1rh2O+9ql2lyNjRORB5TwyI=;
  b=CEFRhjWM59iyE5qTAsynmoDw4v4qhVvSMY0qZRF8Fuchg+TMhSry0fWN
   TQ7RRu2S/dhPl28ABpScBIO8Yb4wyD3el81VcGYdDaQo58LOWt4oIKbdQ
   Az/Cq77IOjPydh6ANuvUCpF6VM5ul+YRiFdYmevxi9zd3E9FBfBBUYQ9f
   AknlSfPKk2NrPPx5f2kaRaWiWEPRm3yFGSXTG1SaNo137WdEnp59YYfxK
   2R5QnE79pB731qQpdRarJw1QuKHDEkOSuKU33qMh9f9oy1+LaCedmp5Ra
   p/wq7rVUWHW5tJLGFr8Q7zqqXnvSEUin5tlSmOfJSg7JqFwQKXGjBtJiX
   Q==;
X-CSE-ConnectionGUID: GPNZzHnkT2WYZkO1z8He8Q==
X-CSE-MsgGUID: 8fgscip0Qt2ZJZwFa5UP9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="34634434"
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="34634434"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 08:57:20 -0800
X-CSE-ConnectionGUID: ha2dtRZiSmiO7rMyVdfpIg==
X-CSE-MsgGUID: Ox5ptFnnTnSD8EMAMmGyDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="90284323"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 08:57:19 -0800
Date: Thu, 7 Nov 2024 08:57:18 -0800
From: Tony Luck <tony.luck@intel.com>
To: Peter Newman <peternewman@google.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
	babu.moger@amd.com, bp@alien8.de, dave.hansen@linux.intel.com,
	eranian@google.com, hpa@zytor.com, james.morse@arm.com,
	linux-kernel@vger.kernel.org, mingo@redhat.com, nert.pinx@gmail.com,
	tan.shaopeng@fujitsu.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH v2 2/2] x86/resctrl: Don't workqueue local event counter
 reads
Message-ID: <ZyzxbhHQptbktfGH@agluck-desk3>
References: <20241106154306.2721688-1-peternewman@google.com>
 <20241106154306.2721688-2-peternewman@google.com>
 <f6b7dd9c-5ace-4816-842f-ac1265c0f9ee@intel.com>
 <CALPaoCioRrjwZPYDdkAApHAecqZVA_Z4rLctjmcpEaV04eq9Ag@mail.gmail.com>
 <CALPaoCgwCwUJHF7fCQrf98kFVdCjPyUTUiCOfYOi3XHJzvqiMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALPaoCgwCwUJHF7fCQrf98kFVdCjPyUTUiCOfYOi3XHJzvqiMw@mail.gmail.com>

On Thu, Nov 07, 2024 at 03:26:11PM +0100, Peter Newman wrote:
> On Thu, Nov 7, 2024 at 12:01 PM Peter Newman <peternewman@google.com> wrote:
> >
> > Hi Reinette,
> >
> > On Thu, Nov 7, 2024 at 2:10 AM Reinette Chatre <reinette.chatre@intel.com> wrote:
> 
> > > This sounds as though user space is essentially duplicating what the
> > > MBM overflow handler currently does, which is to run a worker in each domain
> > > to collect MBM data every second from every RMID for both MBM events.
> > >
> > > * What are the requirements of this use case?
> >
> > Accurate, per-RMID MBps data, ideally at 1-second resolution if the
> > overhead can be tolerable.
> 
> Sorry, forgot about the assignable counters issue...
> 
> On AMD we'll have to cycle the available event counters through the
> groups in order to get valid bandwidth counts.

See below.

> > > For example,
> > >         # cat /sys/fs/resctrl/info/L3_MON/mbm_snapshot/mbm_total_bytes_00
> > >           <rdtgroup nameA> <MBM total count>
> > >           <rdtgroup nameB> <MBM total count>
> > >           ...
> > >
> > >         # cat /sys/fs/resctrl/info/L3_MON/mbm_snapshot/mbm_total_bytes_01
> > >           <rdtgroup nameA> <MBM total count>
> > >           <rdtgroup nameB> <MBM total count>
> > >           ...

How about:

# cat /sys/fs/resctrl/info/L3_MON/mbm_snapshot/mbm_total_bytes_00
<rdtgroup nameA> <MBM total count> <timestamp> <generation>
<rdtgroup nameB> <MBM total count> <timestamp> <generation>
...
> > >
# cat /sys/fs/resctrl/info/L3_MON/mbm_snapshot/mbm_total_bytes_01
<rdtgroup nameA> <MBM total count> <timestamp> <generation>
<rdtgroup nameB> <MBM total count> <timestamp> <generation>
...

Where <timestamp> tracks when this sample was captured. And
<generation> is an integer that is incremented when data
for this event is lost (e.g. due to ABMC counter re-assignment).

Then a monitor application can compute bandwidth for each
group by periodic sampling and for each group:

	if (thisgeneration == lastgeneration) {
		bw = (thiscount - lastcount) / (thistimestanp - lasttimestamp);

-Tony

