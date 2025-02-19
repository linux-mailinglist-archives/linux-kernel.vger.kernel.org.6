Return-Path: <linux-kernel+bounces-521977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C03A3C483
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 660E43B8E22
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5E11FE46C;
	Wed, 19 Feb 2025 16:07:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35D21FDE03;
	Wed, 19 Feb 2025 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981262; cv=none; b=FsE18DwfeFVBQSA3ke+/NWZg8D8DktoRXp/LdSYL/Z7seDya8qHzj7X21XtEU1fqqcUz3Y4JMJogr/mb+UhK9iZgo9X0ClI7PnHsaPCskqooejY2AKDvdvxbvvs5WLdN5kVcjUHHfZ8rzocYqYbf/72razpJq7ZHetZ6R4GCsVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981262; c=relaxed/simple;
	bh=g0PBpbCAAAIxLvLEUXjbW119WGVJf9Rzrw66OtCteLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZ7RIEtO2lvYD9UnJf2g7OW+sB6owYH5IoaE6/rwIl/iLuMol5zCO0rgkK7ezqV7m8nniFMUrrtMdYQRwEUsWvX9E1VM0LxSuMeLWoubN0iSdXiVYcj5EtlfMG8uWrcjaxXSNgnXdX4XqFKlrQ7bx9tooz0KjOdbQewW9J60z00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39FCD1682;
	Wed, 19 Feb 2025 08:07:58 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 202723F6A8;
	Wed, 19 Feb 2025 08:07:35 -0800 (PST)
Date: Wed, 19 Feb 2025 16:07:32 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Babu Moger <babu.moger@amd.com>
Cc: corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	tony.luck@intel.com, peternewman@google.com, fenghua.yu@intel.com,
	x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
	akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
	xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
	daniel.sneddon@linux.intel.com, jpoimboe@kernel.org,
	perry.yuan@amd.com, sandipan.das@amd.com, kai.huang@intel.com,
	xiaoyao.li@intel.com, seanjc@google.com, xin3.li@intel.com,
	andrew.cooper3@citrix.com, ebiggers@google.com,
	mario.limonciello@amd.com, james.morse@arm.com,
	tan.shaopeng@fujitsu.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com,
	eranian@google.com
Subject: Re: [PATCH v11 23/23] x86/resctrl: Introduce interface to modify
 assignment states of the groups
Message-ID: <Z7YBxNIWb7dqOnfi@e133380.arm.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <fe1c0c4cebd353ccb3e588d7ea2fe9ef3dff0ef2.1737577229.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe1c0c4cebd353ccb3e588d7ea2fe9ef3dff0ef2.1737577229.git.babu.moger@amd.com>

Hi,

On Wed, Jan 22, 2025 at 02:20:31PM -0600, Babu Moger wrote:
> When mbm_cntr_assign mode is enabled, users can designate which of the MBM
> events in the CTRL_MON or MON groups should have counters assigned.
> 
> Provide an interface for assigning MBM events by writing to the file:
> /sys/fs/resctrl/info/L3_MON/mbm_assign_control. Using this interface,
> events can be assigned or unassigned as needed.
> 
> Format is similar to the list format with addition of opcode for the
> assignment operation.
>  "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"

[...]

> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 6e29827239e0..299839bcf23f 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1050,6 +1050,244 @@ static int resctrl_mbm_assign_control_show(struct kernfs_open_file *of,

[...]

> +static ssize_t resctrl_mbm_assign_control_write(struct kernfs_open_file *of,
> +						char *buf, size_t nbytes, loff_t off)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +	char *token, *cmon_grp, *mon_grp;
> +	enum rdt_group_type rtype;
> +	int ret;
> +
> +	/* Valid input requires a trailing newline */
> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
> +		return -EINVAL;
> +
> +	buf[nbytes - 1] = '\0';
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	rdt_last_cmd_clear();
> +
> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
> +		rdt_last_cmd_puts("mbm_cntr_assign mode is not enabled\n");
> +		mutex_unlock(&rdtgroup_mutex);
> +		cpus_read_unlock();
> +		return -EINVAL;
> +	}
> +
> +	while ((token = strsep(&buf, "\n")) != NULL) {
> +		/*
> +		 * The write command follows the following format:
> +		 * “<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>”
> +		 * Extract the CTRL_MON group.
> +		 */
> +		cmon_grp = strsep(&token, "/");
> +

As when reading this file, I think that the data can grow larger than a
page and get split into multiple write() calls.

I don't currently think the file needs to be redesigned, but there are
some concerns about how userspace will work with it that need to be
sorted out.

Every monitoring group can contribute a line to this file:

	CTRL_GROUP / MON_GROUP / DOMAIN = [t][l] [ ; DOMAIN = [t][l] ]* LF

so, 2 * (NAME_MAX + 1) + NUM_DOMAINS * 5 - 1 + 1

NAME_MAX on Linux is 255, so with, say, up to 16 domains, that's about
600 bytes per monitoring group in the worst case.

We don't need to have many control and monitoring groups for this to
grow potentially over 4K.


We could simply place a limit on how much userspace is allowed to write
to this file in one go, although this restriction feels difficult for
userspace to follow -- but maybe this is workable in the short term, on
current systems (?)

Otherwise, since we expect this interface to be written using scripting
languages, I think we need to be prepared to accept fully-buffered
I/O.  That means that the data may be cut at random places, not
necessarily at newlines.  (For smaller files such as schemata this is
not such an issue, since the whole file is likely to be small enough to
fit into the default stdio buffers -- this is how sysfs gets away with
it IIUC.)

For fully-buffered I/O, we may have to cache an incomplete line in
between write() calls.  If there is a dangling incomplete line when the
file is closed then it is hard to tell userspace, because people often
don't bother to check the return value of close(), fclose() etc.
However, since it's an ABI violation for userspace to end this file
with a partial line, I think it's sufficient to report that via
last_cmd_status.  (Making close() return -EIO still seems a good idea
though, just in case userspace is listening.)

I hacked up something a bit like this so that schemata could be written
interactively from the shell, so I can try to port that onto this series
as an illustration, if it helps.

Cheers
---Dave

