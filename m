Return-Path: <linux-kernel+bounces-513619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BCEA34C8A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5417416B9C0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDAE23A9BC;
	Thu, 13 Feb 2025 17:56:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9753B2063E1;
	Thu, 13 Feb 2025 17:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469389; cv=none; b=J2FfI7ABvxZIuPqN4qEyvMVdnbn6i0RljwSxK/ijJ8hGgKHITWwTSVbOU7bFOFQ0PdHVk3c8ozR1w/o7ZM3U84PeqfEK16SWcr/8rIqVvzwp6AhT8PpdT8nRm717I+szeY2S6hIYJ5IoSZnplKlSK9NA7oubZVYX0cQ2qXTSiOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469389; c=relaxed/simple;
	bh=VJ9/7u5dm3yhevUGmYiN3uNdAeAmMy1lBqGWU8RiYq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZffHj+lJBgb12qZP82t6+z1FONUmXVAetXrOW0093G63mQ01aJUvIFbgSwyshxDYHSfZl11gm+p4dJns8qOBUo+nxber710u0Qg+/2NnO7HW9xlNT/gd6U+wT9E7x9FPnQr882lrpTFZnft5hp14nbS1Gx9WFQPzkixs+rekCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8239B113E;
	Thu, 13 Feb 2025 09:56:47 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 202C73F5A1;
	Thu, 13 Feb 2025 09:56:23 -0800 (PST)
Date: Thu, 13 Feb 2025 17:56:20 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Chatre, Reinette" <reinette.chatre@intel.com>,
	Babu Moger <babu.moger@amd.com>,
	"peternewman@google.com" <peternewman@google.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"thuth@redhat.com" <thuth@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"xiongwei.song@windriver.com" <xiongwei.song@windriver.com>,
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
	"daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"perry.yuan@amd.com" <perry.yuan@amd.com>,
	"sandipan.das@amd.com" <sandipan.das@amd.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"seanjc@google.com" <seanjc@google.com>,
	"Li, Xin3" <xin3.li@intel.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"ebiggers@google.com" <ebiggers@google.com>,
	"mario.limonciello@amd.com" <mario.limonciello@amd.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
	"Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Message-ID: <Z64yRKyaG+yUhc2N@e133380.arm.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <Z6zeXby8ajh0ax6i@e133380.arm.com>
 <9e849476-7c4b-478b-bd2a-185024def3a3@intel.com>
 <SJ1PR11MB6083A2CD66FAE5DBEDCB96C0FCFF2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083A2CD66FAE5DBEDCB96C0FCFF2@SJ1PR11MB6083.namprd11.prod.outlook.com>

Hi Tony,

On Thu, Feb 13, 2025 at 12:11:13AM +0000, Luck, Tony wrote:
> > I do not think that resctrl's current support of the mbm_total_bytes and
> > mbm_local_bytes should be considered as the "only" two available "slots"
> > into which all possible events should be forced into. "mon_features" exists
> > to guide user space to which events are supported and as I see it new events
> > can be listed here to inform user space of their availability, with their
> > associated event files available in the resource groups.
> 
> 100%  I have a number of "events" in the pipeline that do not fit these
> names. I'm planning on new files with descriptive[1] names for the events
> they report.
> 
> -Tony
> 
> [1] When these are ready to post we can discuss the names I chose and
> change them if there are better names that work across architectures.

Do any of the approaches discussed in [2] look viable for this?

(Ideally, reply over there.)

Cheers
---Dave

[2] https://lore.kernel.org/lkml/Z64tw2NbJXbKpLrH@e133380.arm.com/

