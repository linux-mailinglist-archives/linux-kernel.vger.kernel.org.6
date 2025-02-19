Return-Path: <linux-kernel+bounces-521612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2BAA3BFEA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F284188B781
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BF91E378C;
	Wed, 19 Feb 2025 13:28:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE5F1DF98E;
	Wed, 19 Feb 2025 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971731; cv=none; b=Nej74vyS/Ff2GHTRXP0xBvomeUn4hteaMHK8teYJ6RLXeL/iNpD098i8WVacC/xzswVsldvCOZmKN0S7gQs8mC9W1pWXTmt2WsZqaqFMcbDRriuMBUQrwIUSu8mNPd+e8gF3L0WiKa90KZNlEyqPDuB0AwjqwKP2H+rNGsGqmzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971731; c=relaxed/simple;
	bh=uWS+fW47N6wt39dtEOcS7XkDieAQeJAE7zI6AMNgwrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8fdTVr8YJiMNpkjHpSciz6NgbZSoA5gsrk5yNrXFYJQAkzTIm9EPmUsllPPlsNaKMPUiTxmi8Ru+AtBlaV3ojGOIC1z14TXRJbv/g/Cpn+70N0QSvsHHcaR5N5NKf3GYgcp6g1kYjDRxXgTBzm1wXZv4n+cI35CRANXfyhzjW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5B281682;
	Wed, 19 Feb 2025 05:29:07 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C67A13F59E;
	Wed, 19 Feb 2025 05:28:44 -0800 (PST)
Date: Wed, 19 Feb 2025 13:28:42 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"peternewman@google.com" <peternewman@google.com>,
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
Subject: Re: [PATCH v11 10/23] x86/resctrl: Remove MSR reading of event
 configuration value
Message-ID: <Z7XcinJVBKfr7JN7@e133380.arm.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <b4298186c0be8db76be4eb74e1d948fbe5c1de7d.1737577229.git.babu.moger@amd.com>
 <53e104c0-64ee-4191-bddf-3ddb56dca1d5@intel.com>
 <SJ1PR11MB6083C234656AF934E41A7BA8FCF62@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <2a78f9a1-e03a-4e82-836b-26d3175d3f2b@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a78f9a1-e03a-4e82-836b-26d3175d3f2b@intel.com>

On Wed, Feb 05, 2025 at 05:41:53PM -0800, Reinette Chatre wrote:
> Hi Tony,
> 
> On 2/5/25 4:51 PM, Luck, Tony wrote:
> >> This new arch API has sharp corners because of asymmetry of where resctrl
> >> runs the arch function. I do not think it is required to change this since we
> >> can only speculate about how this may be used in the future but I do think
> >> it will be helpful to add comments that highlight:
> >>
> >> resctrl_arch_mon_event_config_get() ->  May run on CPU that does not belong to domain.
> >> resctrl_arch_mon_event_config_set() ->  Runs on CPU that belongs to domain.
> > 
> > Here's a vague data point about the future to help with speculation.
> > 
> > I have something coming along the pipeline that also can run on any CPU.
> > 
> > I am contemplating a flag in the rdt_resource structure (in appropriate substructure
> > resctrl_cache/resctrl_membw) to indicate "domain" vs. "any" for operations.
> > 
> > Would something like that be useful here?
> 
> hmm ... I cannot envision how this may look. Could you please elaborate?
> 
> You mention "a" (singular) flag in rdt_resource while this scenario involves
> different ops having different scope. This makes me think that this flag may
> have to be per operation that in turn would need additional infrastructure to
> manage and track operations.
> 
> These "arch" functions are evolving as the work to support MPAM is done and
> so far I think it has been quite ad-hoc to just refactor arch specific code
> into "arch" helpers instead of keeping track of which scope they are running in.
> This currently requires any arch implementing an "arch" helper to be well aware 
> of how resctrl will call it.
> 
> Reinette

For MPAM, we must typically do all configuration access from a CPU in a
power domain that depends on the power domain of the relevant MPAM MSC,
including reads of the configuration.

In the MPAM case, the required topology knowledge is not necessarily
identical to the resctrl domain topology, so it doesn't feel right to
have the resctrl core code making the decisions.

So, in the interest of keeping the arch interface simple, should cross-
calling be delegated to the arch code, at least for now?

Cheers
---Dave

