Return-Path: <linux-kernel+bounces-526094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE46A3F9C6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 044B97AE66D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4867E1F3D31;
	Fri, 21 Feb 2025 15:53:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD951E3DFC;
	Fri, 21 Feb 2025 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153229; cv=none; b=Nb4B/T9Ed1al1k8q1MaHRr59C0VJ3mnikB0k+kFW4P+q0fRMlCkETa/+ehzo3smb0HU45+ubyLmqI4Ls6vHyxUUIg07hfEQORFKVz49ZmXRcNSSumLgD05W+rcx1tNWOuTBa4VKFwujEJSzd3gjZdYhZ2xP5JuQG8k31c7l3ggI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153229; c=relaxed/simple;
	bh=OH75syadtmqJ/zqZ424brvsuAGnOABDXDTeYXWKzwIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJplI2l8xEwqYRZmx5Z1Z1FzcXhlSoDrSHiLiWUii2aZTkF21bOhyfBUl0WJPZl5J7nauEoFIRey9+ZxLKw20fZAtnFsx6uRy8UEXvidBHaUi3HD0MQQsLZ3qZsXEgGTQ0SW7v95OB9X4h0Ep6DueDAZ/NQZNFlcwGYTn/9d98w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41893168F;
	Fri, 21 Feb 2025 07:54:04 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BA713F5A1;
	Fri, 21 Feb 2025 07:53:42 -0800 (PST)
Date: Fri, 21 Feb 2025 15:53:35 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: "Moger, Babu" <babu.moger@amd.com>
Cc: "Moger, Babu" <bmoger@amd.com>, corbet@lwn.net,
	reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, tony.luck@intel.com,
	peternewman@google.com, x86@kernel.org, hpa@zytor.com,
	paulmck@kernel.org, akpm@linux-foundation.org, thuth@redhat.com,
	rostedt@goodmis.org, xiongwei.song@windriver.com,
	pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
	jpoimboe@kernel.org, perry.yuan@amd.com, sandipan.das@amd.com,
	kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
	xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com,
	mario.limonciello@amd.com, james.morse@arm.com,
	tan.shaopeng@fujitsu.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com,
	eranian@google.com
Subject: Re: [PATCH v11 23/23] x86/resctrl: Introduce interface to modify
 assignment states of the groups
Message-ID: <Z7ihOkYhQoymphB1@e133380.arm.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <fe1c0c4cebd353ccb3e588d7ea2fe9ef3dff0ef2.1737577229.git.babu.moger@amd.com>
 <Z7YBxNIWb7dqOnfi@e133380.arm.com>
 <1ccb907b-e8c9-4997-bc45-4a457ee84494@amd.com>
 <Z7dIfWAk+f4Gc54X@e133380.arm.com>
 <fdfe13ae-1fb1-417c-88f5-6b0973338c34@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdfe13ae-1fb1-417c-88f5-6b0973338c34@amd.com>

Hi,

On Thu, Feb 20, 2025 at 02:57:31PM -0600, Moger, Babu wrote:
> Hi Dave,

[...]

> Created the problem using this code using a "test" group.
> 
> include <stdio.h>
> #include <errno.h>
> #include <string.h>
> 
> int main()
> {
>         FILE *file;
>         int n;
> 
>         file = fopen("/sys/fs/resctrl/info/L3_MON/mbm_assign_control", "w");
> 
>         if (file == NULL) {
>                 printf("Error opening file!\n");
>                 return 1;
>         }
> 
>         printf("File opened successfully.\n");
> 
>         for (n = 0; n < 100; n++)
>                 if
> (fputs("test//0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;9=tl;10=tl;11=tl\n", file) == EOF)
>                         fprintf(stderr, "Failed on interation %d error
> %s\n ", n, strerror(errno));
> 
>         if (fclose(file) == 0) {
>                 printf("File closed successfully.\n");
>         } else {
>                 printf("Error closing file!\n");
>         }
> }

Right.

> When the buffer overflow happens the newline will not be there. I have
> added this error via rdt_last_cmd_puts. At least user knows there is an error.
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 484d6009869f..70a96976e3ab 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1250,8 +1252,10 @@ static ssize_t
> resctrl_mbm_assign_control_write(struct kernfs_open_file *of,
>         int ret;
> 
>         /* Valid input requires a trailing newline */
> -       if (nbytes == 0 || buf[nbytes - 1] != '\n')
> +       if (nbytes == 0 || buf[nbytes - 1] != '\n') {
> +               rdt_last_cmd_puts("mbm_cntr_assign: buffer invalid\n");
>                 return -EINVAL;
> +       }
> 
>         buf[nbytes - 1] = '\0';
> 
> 
> 
> I am open to other ideas to handle this case.

Reinette, what do you think about this as a stopgap approach?

The worst that happens is that userspace gets an unexpected failure in
scenarios that seem unlikely in the near future (i.e., where there are
a lot of RMIDs available, and at the same time groups have been given
stupidly long names).

Since this is an implementation issue rather than an interface issue,
we could fix it later on.


Longer term, we may want to define some stuff along the lines of

	struct rdtgroup_file {
		/* persistent data for an rdtgroup open file instance */
	};

	static int rdtgroup_file_open(struct kernfs_open_file *of)
	{
		struct rdtgroup_file *rf;

		rf = kzalloc(sizeof(*rf), GFP_KERNEL);
		if (!rf)
			return -ENOMEM;

		of->priv;
	}

	static void rdtgroup_file_release(struct kernfs_open_file *of)
	{
		/*
		 * Deal with dangling data and do cleanup appropriate
		 * for whatever kind of file this is, then:
		 */
		kfree(of->priv);
	}


Then we'd have somewhere to stash data that needs to be carried over
from one read/write call to the next.

I tried to port my schemata buffering hack over, but the requirements
are not exactly the same as for mbm_assign_control, so it wasn't
trivial.  It feels do-able, but it might be better to stabilise this
series before going down that road.

(I'm happy to spend some time trying to wire this up if it would be
useful, though.)

Cheers
---Dave 

