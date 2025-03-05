Return-Path: <linux-kernel+bounces-547439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14286A50878
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9CD33A35E9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2215B1A840E;
	Wed,  5 Mar 2025 18:07:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E77017B505;
	Wed,  5 Mar 2025 18:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198034; cv=none; b=RSEU3Y/OVeiMjUJ33xef/NCeyHF5PUNjSNtzuxA+NoZc184i+Q4ChdTN3VYni2UHkixXX0Qz2nYINMoZGDSzvmpsUpeVtqki/jWAsucGxUcZaNgRYtzeldWt13FNMCJAo89Tn/LpRdobaShShXKM2l9L8rN8oJHtML5XN19ZXRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198034; c=relaxed/simple;
	bh=Dgyu/TYmFa2Ai76zST8/MhLUutsM7nY/dhPZG8raPOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tL1/mGmRCn0xF/cL4yt4YsvqggU8dNZWXxj884Bw+phwyX9++6T56vs2AOxkdWsngvuezCIUbdVMnSsebqDS/dCehpvv0M4/HYKzN09y1EPyJcbazQlozzRP7Bm/3kbw/xmErxv6zlrXFYBtIEcS4DFXM7alSgxklS4Y2YfkL+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4331FEC;
	Wed,  5 Mar 2025 10:07:24 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 123993F66E;
	Wed,  5 Mar 2025 10:07:06 -0800 (PST)
Date: Wed, 5 Mar 2025 18:06:55 +0000
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
Message-ID: <Z8iSrcTKSnxLx9n4@e133380.arm.com>
References: <Z7XiQ+u3Pc+uvJCK@e133380.arm.com>
 <45a0a88a-b31e-447e-9d62-bc0cdedf06f7@amd.com>
 <Z7dN2KpsQjVUb3KR@e133380.arm.com>
 <7802f9e9-9a63-463d-a51e-e9ad0e60f77f@amd.com>
 <Z7ijCphcSM58AqA6@e133380.arm.com>
 <09f2f512-0428-4649-b8ef-33e5a03d5dcb@intel.com>
 <Z7ydx6vfuw8OdJzL@e133380.arm.com>
 <SJ1PR11MB608377BD540169FF3B0FF82DFCC02@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Z8H3bKmTKQr7N2wG@e133380.arm.com>
 <SJ1PR11MB6083186EB2D63441E2D4BC04FCC92@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083186EB2D63441E2D4BC04FCC92@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Mon, Mar 03, 2025 at 07:30:48PM +0000, Luck, Tony wrote:
> > After having spent a bit of time looking into this, I think we are probably
> > OK, at least for reading these files.
> >
> > seq_file will loop over the file's show() callback, growing the seq_file
> > buffer until show() can run without overrunning the buffer.
> >
> > This means that the show() callback receives a buffer that is magically big
> > enough, but there may be some "speculative" calls whose output never goes
> > to userspace.  Once seq_file has the data, it deals with the userspace-
> > facing I/O buffering internally, so we shouldn't have to worry about that.
> 
> Doesn't this depend on the size of the user read(2) syscall request?

Yes and no.

If I've understood correctly:

To service a given read() call, seq_file calls down into the backend to
generate some whole record, then copies it out to userspace, then
repeats this process so long as there is any space left in the user
buffer.

For resctrl files, we don't implement a seq_file iterator: there is no
.next(), no .llseek(), and we don't implement any notion of file
position.  So our _show() functions generate a single big record that
contains the whole dump -- frequently multiple lines of text.

(This might or might not be desirable, but it is at least simple.)

If a _show() function in resctrl holds rdtgroup_mutex throughout, then
whatever it dumps will be dumped atomically with respect to other
resctrl operations that take this mutex.


So, to flesh out your scenario:

> 
> If the total size of the resctrl file is very large, we have a potential issue:

Let's say it's 5KB.

> 1) User asks for 4KB, owns the resctrl mutex.

(Note, rdtgroup_mutex is only held temporarily inside the resctrlfs
backend to these operations; at the start of the process, it is not
held.)

> 2) resctrl uses seq_file and fills with more than 4KB

(It's actually seq_file that uses resctrl here via callbacks: seq_file
sits in between the VFS layer and resctrl.)

When a .show() callback is called, resctrl doesn't know how much data
to generate; it just writes stuff out with seq_printf() etc.

If there's too much to fit in the default seq_file buffer, the data
gets truncated and the seq_file will get internally marked as having
overflowed.  resctrl could check for this condition in order to avoid
formatting text that will get thrown away due to truncation, but this
is not required.  When the .show() callback returns, the seq_file
implementation will respond to the overflow by growing the buffer and
retrying the whole thing until this doesn't occur (see the loop
preceding the "Fill" label in seq_file.c:seq_read_iter().)

This terminates with a seq_file buffer that contains all the output
(untruncated), or with an -ENOMEM failure (which would be punted to
userspace).

So, assuming nothing went wrong, the seq_file buffer now has the 5KB of
data.  rdtgroup_mutex is not held (it was only held in the _show()
callback).

> 3) User gets the first 4KB, releases the resctrl mutex

Userspace gets the first 4KB, and seq_file's notion of the file
position is advanced by this amount, and the generated text is
kept in the seq_file's buffer.

> 4) Some other pending resctrl operation now gets the mutex and makes changes that affect the contents of this file

The un-read data remains buffered in seq_file.  Other resctrl
operations can happen, so the buffered data may become stale, but it is
still an atomic snapshot.

> 5) User asks for next 4K (when it reaquires resctrl mutex)

If an iterator is implemented, seq_file might try to generate another
record to fill the requested space.  But we don't have an iterator, so
the generated data remains as-is.

> 6) resctrl uses seq_file() to construct new image of file incorporating changes because of step 4

I think this happens only if the file is reopened or lseek()'d, and
only if .llseek() is wired up in struct file_operations.  Resctrl
doesn't seem to do this (whether by accident or by design).

So userspace just sees a non-seekable file.

> 7) User gets the second 4KB from the seq_file buffer (which doesn't fit cleanly next to data it got in step 3).

Userspace gets the final 1K of the data that was generated in response
to the original read() call.

If userspace tries to read again, it will get EOF (again, because we
don't have an iterator -- meaning that no additional records can be
generated).


I haven't traced in detail through the code, but that's my
understanding.

Cheers
---Dave

