Return-Path: <linux-kernel+bounces-523969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4266BA3DD80
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64DF93B5555
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9EC1D5CDB;
	Thu, 20 Feb 2025 14:57:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FC31D5ADC;
	Thu, 20 Feb 2025 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063446; cv=none; b=RYPi1Q4oe/aRWs8ULauI4QRUfNNz1JweHJIoHjCMKzrzxEke/e30+3Ejt8KaLBap/q3lFv7nKFmKCcor/ZoZXIVvkpBdGwmxuNndTGbzloySFdrSauAsWEFCUNU+BK280kSa1rYPD3x+AvfuFzir6ziLrSpaCLNS9IvJbJ8aNqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063446; c=relaxed/simple;
	bh=4swTJhJme/kUIwO4pXe7KXlwM5vi2EDJ4oDb11ckgdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdd92+LJBeNYZSeYykoEdX0OHx4EEn6PjMhU9z2C0TG/qR7F0HBSFU0zPTaJBo2dSV70TUCHJpbvo0DRPFMAbffXphuBzj5WniHv0768CWo1Ups3zBGY6rVjCbVf4RhWJJYa0etQb4as/jxXX82xrWnR4/6kNvHbIOJQX6+znL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 354D816F3;
	Thu, 20 Feb 2025 06:57:41 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB30C3F59E;
	Thu, 20 Feb 2025 06:57:18 -0800 (PST)
Date: Thu, 20 Feb 2025 14:57:16 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Babu Moger <babu.moger@amd.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"Chatre, Reinette" <reinette.chatre@intel.com>,
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
Subject: Re: [PATCH v11 23/23] x86/resctrl: Introduce interface to modify
 assignment states of the groups
Message-ID: <Z7dCzCbM5puaoFzG@e133380.arm.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <fe1c0c4cebd353ccb3e588d7ea2fe9ef3dff0ef2.1737577229.git.babu.moger@amd.com>
 <Z7YBxNIWb7dqOnfi@e133380.arm.com>
 <SJ1PR11MB6083C0A20067D84AFE16F2F5FCC52@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083C0A20067D84AFE16F2F5FCC52@SJ1PR11MB6083.namprd11.prod.outlook.com>

[Dropped Cc: fenghua.yu@intel.com <fenghua.yu@intel.com> (bounces)]

On Wed, Feb 19, 2025 at 05:43:43PM +0000, Luck, Tony wrote:
> > I hacked up something a bit like this so that schemata could be written
> > interactively from the shell, so I can try to port that onto this series
> > as an illustration, if it helps.
> 
> Note that schemata will accept writes that just change the bits you want to change.
> 
> So from the shell:
> 
> # cat schemata
> MB:0=100;1=100
> L3:0=fff;1=fff
> 
> # echo "MB:1=90" > schemata
> 
> # cat schemata
> MB:0=100;1= 90
> L3:0=fff;1=fff
> 
> -Tony
> 

Yes, but not:

# {
	p=:
	echo -n MB
	for ((d = 0; d < 2; d++)); do
		echo -n "$p$d=100"
		p=';'
	done
	echo
  } >schemata

(Or at least, it depends on the shell.  Each simple command that
generates output can result in a separate write() call -- certainly
there is no guarantee that it won't.)

Doing the same thing from C will "work", because by default I/O on the
schemata file will be fully buffered in userspace... unless the whole
output exceeds the default buffer size.

The difference from sysfs here is that it would be insane to write a
small, single formatted value in pieces when it is natural to generate
it from a single format specifier -- whereas the syntax of some of
resctrl's files has a multilevel internal structure that has to be
built up in a piecemeal fashion (whether or not it is written to the
file in one go).


I'm not saying that this is an issue for realistic uses though, and
anyway, the schemata file is nothing to do with this series.

Cheers
---Dave

