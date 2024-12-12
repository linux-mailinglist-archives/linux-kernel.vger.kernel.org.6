Return-Path: <linux-kernel+bounces-443821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D729EFC29
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DD882827CD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1E718A95E;
	Thu, 12 Dec 2024 19:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAJ0HZGg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A578748D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 19:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734030947; cv=none; b=SSPMbEn1afPr3NG9Z4aYDsQiUZT2LG9ceQtrF5j96zscRy+9ZLDIKvKdRB7sH2k2MTtDqTvpTy0PuxlFxWhpp9fb+Wag0rTTLhAu1eN/rLPpGeSgKVeolEbQYCIB7lO7vA3Kiu1uFKNnPSjIXE7U6LO36bCZ2J/qk91yqFpoQTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734030947; c=relaxed/simple;
	bh=WPmEWI88/cuChYjUpjNY9yOu0h1CAYhytdOy/sHtUd0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X+6AGywgb93KsQc12he8wF2Gkg377XIe+uLHX/hN51HLfViefq+CcnQlAqjwzM9mr1kzdegpkm+w3mL6jQ9ViuUmTETKfTVjiUYpd6awpqBBmaGPE2IsdRK7920W5vDAgJUJk/9bDk7AYBPbTXv8C1QuBpkkwVl/IdcXohI9lS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAJ0HZGg; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734030947; x=1765566947;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=WPmEWI88/cuChYjUpjNY9yOu0h1CAYhytdOy/sHtUd0=;
  b=NAJ0HZGgKDKo0VAtS1ByWhZfwzLVK6NriNEXY26j06rtmBZY+RdCAZ5H
   QI96Fru2d4mrpnTEe9fd1MYpUbgNkskWlc4nKm8PBLwrE1/SL6lW9/yNi
   dFEl6L22NZuR8sxfCFfn22iUDIeBPF/5H2A3og8k/55KfjuwE/MsKPkmm
   9gRSxhAWu7uwLuL4y4gU7N54JQy4MsRW0yC/fcokT3rAlTs94DxvZfbIo
   58ca8BWQWKynFi+AV0LIErb7tZFUXzGuNvdKWOcL3t7ivKzaOukZIfOpV
   RavYcZQKZTD124UBcYECJQYP9UF9xINfu3Jtsp8J/gjCFfEz2mnoWaeQq
   w==;
X-CSE-ConnectionGUID: u13zJnA7QKaw8u9eOPlCeA==
X-CSE-MsgGUID: gXOmBBD1SV2Di35cw7jpHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="56941413"
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="56941413"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 11:15:46 -0800
X-CSE-ConnectionGUID: 2iUwSh3vQMucky2PtRHAXg==
X-CSE-MsgGUID: VZMLMkWYTpeHDi0MdCwIPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="96067492"
Received: from mesiment-mobl2.amr.corp.intel.com (HELO [10.125.110.139]) ([10.125.110.139])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 11:15:44 -0800
Message-ID: <527d53cded892aea8f36b498ccd42f1bed0a347b.camel@linux.intel.com>
Subject: Re: [PATCH 3/8] x86/itmt: Move the "sched_itmt_enabled" sysctl to
 debugfs
From: Tim Chen <tim.c.chen@linux.intel.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>,  Ricardo Neri
 <ricardo.neri-calderon@linux.intel.com>, Mario Limonciello
 <mario.limonciello@amd.com>,  Meng Li <li.meng@amd.com>, Huang Rui
 <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Date: Thu, 12 Dec 2024 11:15:43 -0800
In-Reply-To: <20241211185552.4553-4-kprateek.nayak@amd.com>
References: <20241211185552.4553-1-kprateek.nayak@amd.com>
	 <20241211185552.4553-4-kprateek.nayak@amd.com>
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-12-11 at 18:55 +0000, K Prateek Nayak wrote:
> "sched_itmt_enabled" was only introduced as a debug toggle for any funky
> ITMT behavior. Move the sysctl controlled from
> "/proc/sys/kernel/sched_itmt_enabled" to debugfs at
> "/sys/kernel/debug/x86/sched_itmt_enabled" with a notable change that a
> cat on the file will return "Y" or "N" instead of "1" or "0" to
> indicate that feature is enabled or disabled respectively.
>=20

Valid values of setting "sched_itmt_enabled" likewise change from "1" or "0=
"
to "Y" or "N".=20

> Since ITMT is x86 specific (and PowerPC uses SD_ASYM_PACKING too), the
> toggle was moved to "/sys/kernel/debug/x86/" as opposed to
> "/sys/kernel/debug/sched/"
>=20
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>

Tim

> ---
>  arch/x86/kernel/itmt.c | 56 ++++++++++++++++++++----------------------
>  1 file changed, 27 insertions(+), 29 deletions(-)
>=20
> diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
> index ee43d1bd41d0..9cea1fc36c18 100644
> --- a/arch/x86/kernel/itmt.c
> +++ b/arch/x86/kernel/itmt.c
> @@ -19,6 +19,7 @@
>  #include <linux/sched.h>
>  #include <linux/cpumask.h>
>  #include <linux/cpuset.h>
> +#include <linux/debugfs.h>
>  #include <linux/mutex.h>
>  #include <linux/sysctl.h>
>  #include <linux/nodemask.h>
> @@ -34,45 +35,38 @@ static bool __read_mostly sched_itmt_capable;
>   * of higher turbo frequency for cpus supporting Intel Turbo Boost Max
>   * Technology 3.0.
>   *
> - * It can be set via /proc/sys/kernel/sched_itmt_enabled
> + * It can be set via /sys/kernel/debug/x86/sched_itmt_enabled
>   */
>  bool __read_mostly sysctl_sched_itmt_enabled;
> =20
> -static int sched_itmt_update_handler(const struct ctl_table *table, int =
write,
> -				     void *buffer, size_t *lenp, loff_t *ppos)
> +static ssize_t sched_itmt_enabled_write(struct file *filp,
> +					const char __user *ubuf,
> +					size_t cnt, loff_t *ppos)
>  {
> -	unsigned int old_sysctl;
> -	int ret;
> +	ssize_t result;
> +	bool orig;
> =20
>  	guard(mutex)(&itmt_update_mutex);
> =20
> -	if (!sched_itmt_capable)
> -		return -EINVAL;
> -
> -	old_sysctl =3D sysctl_sched_itmt_enabled;
> -	ret =3D proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> +	orig =3D sysctl_sched_itmt_enabled;
> +	result =3D debugfs_write_file_bool(filp, ubuf, cnt, ppos);
> =20
> -	if (!ret && write && old_sysctl !=3D sysctl_sched_itmt_enabled) {
> +	if (sysctl_sched_itmt_enabled !=3D orig) {
>  		x86_topology_update =3D true;
>  		rebuild_sched_domains();
>  	}
> =20
> -	return ret;
> +	return result;
>  }
> =20
> -static struct ctl_table itmt_kern_table[] =3D {
> -	{
> -		.procname	=3D "sched_itmt_enabled",
> -		.data		=3D &sysctl_sched_itmt_enabled,
> -		.maxlen		=3D sizeof(unsigned int),
> -		.mode		=3D 0644,
> -		.proc_handler	=3D sched_itmt_update_handler,
> -		.extra1		=3D SYSCTL_ZERO,
> -		.extra2		=3D SYSCTL_ONE,
> -	},
> +static const struct file_operations dfs_sched_itmt_fops =3D {
> +	.read =3D         debugfs_read_file_bool,
> +	.write =3D        sched_itmt_enabled_write,
> +	.open =3D         simple_open,
> +	.llseek =3D       default_llseek,
>  };
> =20
> -static struct ctl_table_header *itmt_sysctl_header;
> +static struct dentry *dfs_sched_itmt;
> =20
>  /**
>   * sched_set_itmt_support() - Indicate platform supports ITMT
> @@ -98,9 +92,15 @@ int sched_set_itmt_support(void)
>  	if (sched_itmt_capable)
>  		return 0;
> =20
> -	itmt_sysctl_header =3D register_sysctl("kernel", itmt_kern_table);
> -	if (!itmt_sysctl_header)
> +	dfs_sched_itmt =3D debugfs_create_file_unsafe("sched_itmt_enabled",
> +						    0644,
> +						    arch_debugfs_dir,
> +						    &sysctl_sched_itmt_enabled,
> +						    &dfs_sched_itmt_fops);
> +	if (IS_ERR_OR_NULL(dfs_sched_itmt)) {
> +		dfs_sched_itmt =3D NULL;
>  		return -ENOMEM;
> +	}
> =20
>  	sched_itmt_capable =3D true;
> =20
> @@ -131,10 +131,8 @@ void sched_clear_itmt_support(void)
> =20
>  	sched_itmt_capable =3D false;
> =20
> -	if (itmt_sysctl_header) {
> -		unregister_sysctl_table(itmt_sysctl_header);
> -		itmt_sysctl_header =3D NULL;
> -	}
> +	debugfs_remove(dfs_sched_itmt);
> +	dfs_sched_itmt =3D NULL;
> =20
>  	if (sysctl_sched_itmt_enabled) {
>  		/* disable sched_itmt if we are no longer ITMT capable */


