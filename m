Return-Path: <linux-kernel+bounces-539100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F43A4A0D5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4843716E423
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54A41BD9CB;
	Fri, 28 Feb 2025 17:50:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1261F4CB1;
	Fri, 28 Feb 2025 17:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765051; cv=none; b=sRnZzCW0FNxNCikXh66Wd0PQ4854mLl2lRm/p+zZXGCuOZ102XMNVrOMOPFVEKEi6ZZLFIlvw0e1C/kDdPQqh/nj7HpSAU5BuOobV0elzFBavCzExgxY9/xPNHvOX9rWI/FjmTE6BZUn6KbwDlcDYzMqQSunb5w0E5O0a9oTXTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765051; c=relaxed/simple;
	bh=gvgDQfQOoR9DJ8Xxv+7hfNCvtch+faulE4Wc/MB7u1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition; b=Z14Ga3GbzKR3VM4pojmFte3VkkwPG1bmtGzy6IRTyToeL9y6K5rhRGkyz64fBYrh7vqAPhMAyISpp27Fqf7JrbY7NzHQDgR/fJEiQ10SZEaAZ9jPofu4EoNGH58h8m8ErtbujOCHJ2aG4++JiZ5MAzOdNmFDBzUV4Kf+kOL/ppk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51EC5150C;
	Fri, 28 Feb 2025 09:51:04 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3B6F3F6A8;
	Fri, 28 Feb 2025 09:50:44 -0800 (PST)
Date: Fri, 28 Feb 2025 17:50:36 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Chatre, Reinette" <reinette.chatre@intel.com>,
	"Moger, Babu" <babu.moger@amd.com>,
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
Subject: Re: [PATCH v11 22/23] x86/resctrl: Introduce interface to list
 assignment states of all the groups
Message-ID: <Z8H3bKmTKQr7N2wG@e133380.arm.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <52c66bf98480c0ab6bb0f0762497e328fcbdeaac.1737577229.git.babu.moger@amd.com>
 <Z7XiQ+u3Pc+uvJCK@e133380.arm.com>
 <45a0a88a-b31e-447e-9d62-bc0cdedf06f7@amd.com>
 <Z7dN2KpsQjVUb3KR@e133380.arm.com>
 <7802f9e9-9a63-463d-a51e-e9ad0e60f77f@amd.com>
 <Z7ijCphcSM58AqA6@e133380.arm.com>
 <09f2f512-0428-4649-b8ef-33e5a03d5dcb@intel.com>
 <Z7ydx6vfuw8OdJzL@e133380.arm.com>
 <SJ1PR11MB608377BD540169FF3B0FF82DFCC02@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Feb 25, 2025 at 12:39:04PM +0000, Dave Martin wrote:
> Hi Tony,
> 
> On Mon, Feb 24, 2025 at 05:23:06PM +0000, Luck, Tony wrote:
> > > It has just occurred to be that ftrace has large, multi-line text files
> > > in sysfs, so I'll try to find out how they handle that there.  Maybe
> > > there is some infrastructure we can re-use.
> > 
> > Resctrl was built on top of "kernfs" because that was a simple base
> > that met needs at the time.
> > 
> > Do we need to look at either extending capabilities of kernfs? Or
> > move to sysfs?
> > 
> > -Tony
> 
> I took a look at what ftrace does: it basically rolls its own buffering
> implementation, sufficient for its needs.
> 
> The ftrace code is internal and not trivial to pick up and plonk into
> resctrl.  We also have another possible requirement that ftrace doesn't
> have (whole-file atomicity).  But ftrace's example at least confirms
> that there is probably no off-the-shelf implementation for this in the
> kernel.

[...]

After having spent a bit of time looking into this, I think we are probably
OK, at least for reading these files.

seq_file will loop over the file's show() callback, growing the seq_file
buffer until show() can run without overrunning the buffer.

This means that the show() callback receives a buffer that is magically big
enough, but there may be some "speculative" calls whose output never goes
to userspace.  Once seq_file has the data, it deals with the userspace-
facing I/O buffering internally, so we shouldn't have to worry about that.

I'll try to hack up a test next week to confirm that this works.

The seq_file approach appears sound, but may be inefficient if the initial
guess at the buffer size (= PAGE_SIZE) is frequently too small.  (There is
single_open_size() though, which allows the buffer to be preallocated with
a specified size and may be useful.)


seq_file doesn't help with the write side at all, but I think we agreed
that handling large file writes properly is less urgent.

Cheers
---Dave

