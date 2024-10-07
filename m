Return-Path: <linux-kernel+bounces-353295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EFF992BB8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8421283104
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12851D278C;
	Mon,  7 Oct 2024 12:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjBxqF+9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFD81D1F63
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 12:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728304039; cv=none; b=V3gVFRcKXx10l7OOaRZxm5oxpK8YQzQW99zwqiZ98/zwYCaf4Y/MAvB2l1UEgYa7Bh1yPvugosN+kengUth42myFvMImxj93BMUzUvsiOeoqQ2XWLoHBMW/wcKO2ye+xu4xpTT8bnQFK0Kz68HO4CHEwAKX3ceVIewQJvixhpzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728304039; c=relaxed/simple;
	bh=x1bhCSRMZrbkDZYDGKmJJVG+bTAzG8QmDW8aqIplGxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOIJsmBmquSNDPvq0EcVcXonsHItu1aknR9IXVDaxrAMeDi9wkqnmPmVRIaxPEjVILvPl0fhld0IJYESVUL18vf47MF5CyZts/4bepSfX+sSh1ZkamNatQxlRR48SR/clRQHD4iq+/d05dELQzURyMtZSw2kOUFALHISUWvLmRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjBxqF+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C824C4CEC6;
	Mon,  7 Oct 2024 12:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728304037;
	bh=x1bhCSRMZrbkDZYDGKmJJVG+bTAzG8QmDW8aqIplGxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EjBxqF+9z42OuSOaxkPVw/SMtdOWgWE1stmjW/bUTBae4oHOssF2ZZv1q1PzO+H9d
	 qAJVXdzP/AIbQh8CPrF9cQb6TYNVdz4k+lf1iP2jhKIWoI46P9nJVrCZ5TTSde9CWb
	 hStPSTB1HZcm3ChchE4q5EDplvC2UYt41cchEou9gfseXgTlnltynxaHHv8asJnpzZ
	 HY3qOVH1LCJ2KS7+pqTD60xB3IwRtTBp9rlsVU7QZPlaOLDuCNMLGTNY9MqXUhYBZB
	 cpuAOWAjflLRouABNjg5Ny2OVOq8eTy38Rp5pKGJAGI7n8rFi9j/77ELuv4femXcsx
	 MHFVLEAPTGnwA==
Date: Mon, 7 Oct 2024 14:27:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: luca.boccassi@gmail.com
Cc: linux-kernel@vger.kernel.org, christian@brauner.io, oleg@redhat.com
Subject: Re: [PATCH v7] pidfd: add ioctl to retrieve pid info
Message-ID: <20241007-lustig-mietfrei-b507b1fb7f03@brauner>
References: <20241007094438.398806-1-luca.boccassi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241007094438.398806-1-luca.boccassi@gmail.com>

On Mon, Oct 07, 2024 at 10:43:28AM GMT, luca.boccassi@gmail.com wrote:
> From: Luca Boccassi <luca.boccassi@gmail.com>
> 
> A common pattern when using pid fds is having to get information
> about the process, which currently requires /proc being mounted,
> resolving the fd to a pid, and then do manual string parsing of
> /proc/N/status and friends. This needs to be reimplemented over
> and over in all userspace projects (e.g.: I have reimplemented
> resolving in systemd, dbus, dbus-daemon, polkit so far), and
> requires additional care in checking that the fd is still valid
> after having parsed the data, to avoid races.
> 
> Having a programmatic API that can be used directly removes all
> these requirements, including having /proc mounted.
> 
> As discussed at LPC24, add an ioctl with an extensible struct
> so that more parameters can be added later if needed. Start with
> returning pid/tgid/ppid and creds unconditionally, and cgroupid
> optionally.
> 
> Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> ---
> v7: fix RCU issue and style issue introduced by v6 found by reviewer

We went from v1 to v7 over the weekend? What happened? :D
Mostly looks good to me.

> v6: use rcu_read_lock() when fetching cgroupid, use task_ppid_nr_ns() to
>     get the ppid, return ESCHR if any of pid/tgid/ppid are 0 at the end
>     of the call to avoid providing incomplete data, document what the
>     callers should expect
> v5: check again that the task hasn't exited immediately before copying
>     the result out to userspace, to ensure we are not returning stale data
>     add an ifdef around the cgroup structs usage to fix build errors when
>     the feature is disabled
> v4: fix arg check in pidfd_ioctl() by moving it after the new call
> v3: switch from pid_vnr() to task_pid_vnr()
> v2: Apply comments from Christian, apart from the one about pid namespaces
>     as I need additional hints on how to implement it.
>     Drop the security_context string as it is not the appropriate
>     metadata to give userspace these days.
> 
>  fs/pidfs.c                                    | 90 ++++++++++++++++++-
>  include/uapi/linux/pidfd.h                    | 31 +++++++
>  .../testing/selftests/pidfd/pidfd_open_test.c | 81 ++++++++++++++++-
>  3 files changed, 198 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 80675b6bf884..729dc6091a76 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -2,6 +2,7 @@
>  #include <linux/anon_inodes.h>
>  #include <linux/file.h>
>  #include <linux/fs.h>
> +#include <linux/cgroup.h>
>  #include <linux/magic.h>
>  #include <linux/mount.h>
>  #include <linux/pid.h>
> @@ -114,6 +115,85 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
>  	return poll_flags;
>  }
>  
> +static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long arg)
> +{
> +	struct pidfd_info __user *uinfo = (struct pidfd_info __user *)arg;
> +	size_t usize = _IOC_SIZE(cmd);

A general comment: The _IOC_SIZE() and similar macros are uapi and thus
available to userspace. So userspace can figure out how large the struct
is that the ioctl cmd uses. This doesn't necessarily reflect what the
kernel knows if e.g., the ioctl cmd is provided by glibc. That's a
general thing though and we do provide seamless forward- and backward
compatibility.

> +	struct pidfd_info kinfo = {};
> +	struct user_namespace *user_ns;
> +	const struct cred *c;
> +	__u64 request_mask;
> +
> +	if (!uinfo)
> +		return -EINVAL;
> +	if (usize < sizeof(struct pidfd_info))
> +		return -EINVAL; /* First version, no smaller struct possible */
> +
> +	if (copy_from_user(&request_mask, &uinfo->request_mask, sizeof(request_mask)))
> +		return -EFAULT;

Use copy_struct_from_user() here it's not strictly needed as we
technically don't care whether userspace passes unitialized stuff as
this is an output-only struct right now but imho it's just good hygiene.

> +
> +	c = get_task_cred(task);
> +	if (!c)
> +		return -ESRCH;
> +
> +	/* Unconditionally return identifiers and credentials, the rest only on request */
> +
> +	user_ns = current_user_ns();
> +	kinfo.ruid = from_kuid_munged(user_ns, c->uid);
> +	kinfo.rgid = from_kgid_munged(user_ns, c->gid);
> +	kinfo.euid = from_kuid_munged(user_ns, c->euid);
> +	kinfo.egid = from_kgid_munged(user_ns, c->egid);
> +	kinfo.suid = from_kuid_munged(user_ns, c->suid);
> +	kinfo.sgid = from_kgid_munged(user_ns, c->sgid);
> +	kinfo.fsuid = from_kuid_munged(user_ns, c->fsuid);
> +	kinfo.fsgid = from_kgid_munged(user_ns, c->fsgid);

Needs a put_cred() here to avoid leaking memory.

> +
> +#ifdef CONFIG_CGROUPS
> +	if (request_mask & PIDFD_INFO_CGROUPID) {
> +		struct cgroup *cgrp;
> +
> +		rcu_read_lock();
> +		cgrp = task_cgroup(task, pids_cgrp_id);
> +		if (!cgrp) {
> +			rcu_read_unlock();
> +			return -ENODEV;
> +		}
> +		kinfo.cgroupid = cgroup_id(cgrp);
> +		rcu_read_unlock();

You're already in a separate scope due to PIDFD_INFO_CGROUPID anyway so
you can just use a cleanup guard (same thing as systemd's scope-based
cleanup):

		guard(rcu)();
		cgrp = task_cgroup(task, pids_cgrp_id);
		if (!cgrp)
			return -ENODEV;
		kinfo.cgroupid = cgroup_id(cgrp);

> +
> +		kinfo.result_mask |= PIDFD_INFO_CGROUPID;
> +	}
> +#endif
> +
> +	/*
> +	 * Copy pid/tgid last, to reduce the chances the information might be
> +	 * stale. Note that it is not possible to ensure it will be valid as the
> +	 * task might return as soon as the copy_to_user finishes, but that's ok
> +	 * and userspace expects that might happen and can act accordingly, so
> +	 * this is just best-effort. What we can do however is checking that all
> +	 * the fields are set correctly, or return ESRCH to avoid providing
> +	 * incomplete information. */
> +
> +	kinfo.ppid = task_ppid_nr_ns(task, NULL);
> +	kinfo.tgid = task_tgid_vnr(task);
> +	kinfo.pid = task_pid_vnr(task);
> +
> +	if (kinfo.pid == 0 || kinfo.tgid == 0 || (kinfo.ppid == 0 && kinfo.pid != 1))
> +		return -ESRCH;
> +
> +	/*
> +	 * If userspace and the kernel have the same struct size it can just
> +	 * be copied. If userspace provides an older struct, only the bits that
> +	 * userspace knows about will be copied. If userspace provides a new
> +	 * struct, only the bits that the kernel knows about will be copied and
> +	 * the size value will be set to the size the kernel knows about.
> +	 */
> +	if (copy_to_user(uinfo, &kinfo, min(usize, sizeof(kinfo))))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
>  static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  {
>  	struct task_struct *task __free(put_task) = NULL;
> @@ -122,13 +202,17 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  	struct ns_common *ns_common = NULL;
>  	struct pid_namespace *pid_ns;
>  
> -	if (arg)
> -		return -EINVAL;
> -
>  	task = get_pid_task(pid, PIDTYPE_PID);
>  	if (!task)
>  		return -ESRCH;
>  
> +	/* Extensible IOCTL that does not open namespace FDs, take a shortcut */
> +	if (_IOC_NR(cmd) == _IOC_NR(PIDFD_GET_INFO))
> +		return pidfd_info(task, cmd, arg);
> +
> +	if (arg)
> +		return -EINVAL;
> +
>  	scoped_guard(task_lock, task) {
>  		nsp = task->nsproxy;
>  		if (nsp)
> diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
> index 565fc0629fff..24b25cd52ab3 100644
> --- a/include/uapi/linux/pidfd.h
> +++ b/include/uapi/linux/pidfd.h
> @@ -16,6 +16,36 @@
>  #define PIDFD_SIGNAL_THREAD_GROUP	(1UL << 1)
>  #define PIDFD_SIGNAL_PROCESS_GROUP	(1UL << 2)
>  
> +/* Flags for pidfd_info. */
> +#define PIDFD_INFO_CGROUPID		(1UL << 0)
> +
> +struct pidfd_info {
> +	/* Let userspace request expensive stuff explictly. */
> +	__u64 request_mask;
> +	/* And let the kernel indicate whether it knows about it. */
> +	__u64 result_mask;
> +	/*
> +	 * The information contained in the following fields might be stale at the
> +	 * time it is received, as the target process might have exited as soon as
> +	 * the IOCTL was processed, and there is no way to avoid that. However, it
> +	 * is guaranteed that if the call was successful, then the information was
> +	 * correct and referred to the intended process at the time the work was
> +	 * performed. */
> +	__u64 cgroupid;
> +	__u32 pid;
> +	__u32 tgid;
> +	__u32 ppid;
> +	__u32 ruid;
> +	__u32 rgid;
> +	__u32 euid;
> +	__u32 egid;
> +	__u32 suid;
> +	__u32 sgid;
> +	__u32 fsuid;
> +	__u32 fsgid;
> +	__u32 spare0[1];
> +};
> +
>  #define PIDFS_IOCTL_MAGIC 0xFF
>  
>  #define PIDFD_GET_CGROUP_NAMESPACE            _IO(PIDFS_IOCTL_MAGIC, 1)
> @@ -28,5 +58,6 @@
>  #define PIDFD_GET_TIME_FOR_CHILDREN_NAMESPACE _IO(PIDFS_IOCTL_MAGIC, 8)
>  #define PIDFD_GET_USER_NAMESPACE              _IO(PIDFS_IOCTL_MAGIC, 9)
>  #define PIDFD_GET_UTS_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 10)
> +#define PIDFD_GET_INFO                        _IOWR(PIDFS_IOCTL_MAGIC, 11, struct pidfd_info)
>  
>  #endif /* _UAPI_LINUX_PIDFD_H */
> diff --git a/tools/testing/selftests/pidfd/pidfd_open_test.c b/tools/testing/selftests/pidfd/pidfd_open_test.c
> index c62564c264b1..30c50a8ae10b 100644
> --- a/tools/testing/selftests/pidfd/pidfd_open_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_open_test.c
> @@ -13,6 +13,7 @@
>  #include <stdlib.h>
>  #include <string.h>
>  #include <syscall.h>
> +#include <sys/ioctl.h>
>  #include <sys/mount.h>
>  #include <sys/prctl.h>
>  #include <sys/wait.h>
> @@ -21,6 +22,35 @@
>  #include "pidfd.h"
>  #include "../kselftest.h"
>  
> +#ifndef PIDFS_IOCTL_MAGIC
> +#define PIDFS_IOCTL_MAGIC 0xFF
> +#endif
> +
> +#ifndef PIDFD_GET_INFO
> +#define PIDFD_GET_INFO _IOWR(PIDFS_IOCTL_MAGIC, 11, struct pidfd_info)
> +#define PIDFD_INFO_CGROUPID		(1UL << 0)
> +
> +struct pidfd_info {
> +	/* Let userspace request expensive stuff explictly. */
> +	__u64 request_mask;
> +	/* And let the kernel indicate whether it knows about it. */
> +	__u64 result_mask;
> +	__u64 cgroupid;
> +	__u32 pid;
> +	__u32 tgid;
> +	__u32 ppid;
> +	__u32 ruid;
> +	__u32 rgid;
> +	__u32 euid;
> +	__u32 egid;
> +	__u32 suid;
> +	__u32 sgid;
> +	__u32 fsuid;
> +	__u32 fsgid;
> +	__u32 spare0[1];
> +};
> +#endif
> +
>  static int safe_int(const char *numstr, int *converted)
>  {
>  	char *err = NULL;
> @@ -120,10 +150,13 @@ static pid_t get_pid_from_fdinfo_file(int pidfd, const char *key, size_t keylen)
>  
>  int main(int argc, char **argv)
>  {
> +	struct pidfd_info info = {
> +		.request_mask = PIDFD_INFO_CGROUPID,
> +	};
>  	int pidfd = -1, ret = 1;
>  	pid_t pid;
>  
> -	ksft_set_plan(3);
> +	ksft_set_plan(4);
>  
>  	pidfd = sys_pidfd_open(-1, 0);
>  	if (pidfd >= 0) {
> @@ -153,6 +186,52 @@ int main(int argc, char **argv)
>  	pid = get_pid_from_fdinfo_file(pidfd, "Pid:", sizeof("Pid:") - 1);
>  	ksft_print_msg("pidfd %d refers to process with pid %d\n", pidfd, pid);
>  
> +	if (ioctl(pidfd, PIDFD_GET_INFO, &info) < 0) {
> +		ksft_print_msg("%s - failed to get info from pidfd\n", strerror(errno));
> +		goto on_error;
> +	}
> +	if (info.pid != pid) {
> +		ksft_print_msg("pid from fdinfo file %d does not match pid from ioctl %d\n",
> +			       pid, info.pid);
> +		goto on_error;
> +	}
> +	if (info.ppid != getppid()) {
> +		ksft_print_msg("ppid %d does not match ppid from ioctl %d\n",
> +			       pid, info.pid);
> +		goto on_error;
> +	}
> +	if (info.ruid != getuid()) {
> +		ksft_print_msg("uid %d does not match uid from ioctl %d\n",
> +			       getuid(), info.ruid);
> +		goto on_error;
> +	}
> +	if (info.rgid != getgid()) {
> +		ksft_print_msg("gid %d does not match gid from ioctl %d\n",
> +			       getgid(), info.rgid);
> +		goto on_error;
> +	}
> +	if (info.euid != geteuid()) {
> +		ksft_print_msg("euid %d does not match euid from ioctl %d\n",
> +			       geteuid(), info.euid);
> +		goto on_error;
> +	}
> +	if (info.egid != getegid()) {
> +		ksft_print_msg("egid %d does not match egid from ioctl %d\n",
> +			       getegid(), info.egid);
> +		goto on_error;
> +	}
> +	if (info.suid != geteuid()) {
> +		ksft_print_msg("suid %d does not match suid from ioctl %d\n",
> +			       geteuid(), info.suid);
> +		goto on_error;
> +	}
> +	if (info.sgid != getegid()) {
> +		ksft_print_msg("sgid %d does not match sgid from ioctl %d\n",
> +			       getegid(), info.sgid);
> +		goto on_error;
> +	}
> +	ksft_test_result_pass("get info from pidfd test: passed\n");
> +
>  	ret = 0;
>  
>  on_error:
> 
> base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
> -- 
> 2.45.2
> 

