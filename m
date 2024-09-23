Return-Path: <linux-kernel+bounces-335752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA2497EA1F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ECD91C20CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73F3196C7B;
	Mon, 23 Sep 2024 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSuua116"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B18E19599C
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727088503; cv=none; b=Xi71rrlTAPMQfJd9m4Bb+Am1/yCKktT5xWqMULDLYh0Fm+fQcZkvwJDJ+6s0kwSpPLoTEC3A7EqpPyjiFCcneY4EWPYRx2fLQw0VKfC0OHr3WJJdIWCqo1LYW/9eSNmUP+2vfjSJnjDUlWD1ZQRV7LqZyefQMBXzARFPCfbq/ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727088503; c=relaxed/simple;
	bh=+C8EsgJ9UqbOmjJWH8ixs+CIsVhcksfl7qxcHC4vU8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JolHTuSxyEWcGewvGnUrBwn+7QZ1U8jsTob5raGb/RNWBzB87f7rEYRaS/cYt6ZzvpG3e1kGt0TlWN6GyC0kR+VCwjRaTyjG/Q1NjJEWiMngzMrHr/LNRynvIkov8wicU8Ukw9I92ztclAVZI1g1a9XXk7O2b2gfkYAsI1bYLAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MSuua116; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727088499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IiotXPQlbFM/2toFuC512KnVpUNQrr7cx9DuHkk5r8A=;
	b=MSuua116b2LHIrZDnYL7DpMmLFRbEFuCNorLT/Y8ra7CgCa1CRWOP4RnlZqOHoQ0wpTROf
	EbAu1+EzKhEreLP0DBMcGoWtSwcRanVj0jzKcYZQ2ArD/2AH7LA4FDtdMS/HdrYjDymF5S
	NEJIXkUDU5WpUESGzZ00J69nt1gL9Xc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-z3dl42qXMamoP4fGmw2kXA-1; Mon,
 23 Sep 2024 06:48:16 -0400
X-MC-Unique: z3dl42qXMamoP4fGmw2kXA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CC3618E6A69;
	Mon, 23 Sep 2024 10:48:15 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.32.86])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9C4F1956094;
	Mon, 23 Sep 2024 10:48:13 +0000 (UTC)
Date: Mon, 23 Sep 2024 12:48:11 +0200
From: Phil Auld <pauld@redhat.com>
To: andrea.righi@linux.dev
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Giovanni Gherdovich <giovanni.gherdovich@suse.com>,
	Kleber Sacilotto de Souza <kleber.souza@canonical.com>,
	Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Provide a sysfs enable_seq counter
Message-ID: <20240923104811.GB308802@pauld.westford.csb>
References: <20240921193921.75594-1-andrea.righi@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240921193921.75594-1-andrea.righi@linux.dev>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi Andrea,

On Sat, Sep 21, 2024 at 09:39:21PM +0200 andrea.righi@linux.dev wrote:
> From: Andrea Righi <andrea.righi@linux.dev>
> 
> As discussed during the distro-centric session within the sched_ext
> Microconference at LPC 2024, introduce a sequence counter that is
> incremented every time a BPF scheduler is loaded.
> 
> This feature can help distributions in diagnosing potential performance
> regressions by identifying systems where users are running (or have ran)
> custom BPF schedulers.
> 
> Example:
> 
>  arighi@virtme-ng~> cat /sys/kernel/sched_ext/enable_seq
>  0
>  arighi@virtme-ng~> sudo scx_simple
>  local=1 global=0
>  ^CEXIT: unregistered from user space
>  arighi@virtme-ng~> cat /sys/kernel/sched_ext/enable_seq
>  1
> 
> In this way user-space tools (such as Ubuntu's apport and similar) are
> able to gather and include this information in bug reports.
> 
> Cc: Giovanni Gherdovich <giovanni.gherdovich@suse.com>
> Cc: Kleber Sacilotto de Souza <kleber.souza@canonical.com>
> Cc: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
> Cc: Phil Auld <pauld@redhat.com>
> Signed-off-by: Andrea Righi <andrea.righi@linux.dev>

Thanks for pulling this together. I am hopeful we can get it in
a 6.12-rc.

Reviewed-by: Phil Auld <pauld@redhat.com>

Cheers,
Phil

> ---
>  Documentation/scheduler/sched-ext.rst | 10 ++++++++++
>  kernel/sched/ext.c                    | 17 +++++++++++++++++
>  tools/sched_ext/scx_show_state.py     |  1 +
>  3 files changed, 28 insertions(+)
> 
> diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
> index a707d2181a77..6c0d70e2e27d 100644
> --- a/Documentation/scheduler/sched-ext.rst
> +++ b/Documentation/scheduler/sched-ext.rst
> @@ -83,6 +83,15 @@ The current status of the BPF scheduler can be determined as follows:
>      # cat /sys/kernel/sched_ext/root/ops
>      simple
>  
> +You can check if any BPF scheduler has ever been loaded since boot by examining
> +this monotonically incrementing counter (a value of zero indicates that no BPF
> +scheduler has been loaded):
> +
> +.. code-block:: none
> +
> +    # cat /sys/kernel/sched_ext/enable_seq
> +    1
> +
>  ``tools/sched_ext/scx_show_state.py`` is a drgn script which shows more
>  detailed information:
>  
> @@ -96,6 +105,7 @@ detailed information:
>      enable_state  : enabled (2)
>      bypass_depth  : 0
>      nr_rejected   : 0
> +    enable_seq    : 1
>  
>  If ``CONFIG_SCHED_DEBUG`` is set, whether a given task is on sched_ext can
>  be determined as follows:
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 9ee5a9a261cc..8057ab4c76da 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -874,6 +874,13 @@ static struct scx_exit_info *scx_exit_info;
>  static atomic_long_t scx_nr_rejected = ATOMIC_LONG_INIT(0);
>  static atomic_long_t scx_hotplug_seq = ATOMIC_LONG_INIT(0);
>  
> +/*
> + * A monotically increasing sequence number that is incremented every time a
> + * scheduler is enabled. This can be used by to check if any custom sched_ext
> + * scheduler has ever been used in the system.
> + */
> +static atomic_long_t scx_enable_seq = ATOMIC_LONG_INIT(0);
> +
>  /*
>   * The maximum amount of time in jiffies that a task may be runnable without
>   * being scheduled on a CPU. If this timeout is exceeded, it will trigger
> @@ -4154,11 +4161,19 @@ static ssize_t scx_attr_hotplug_seq_show(struct kobject *kobj,
>  }
>  SCX_ATTR(hotplug_seq);
>  
> +static ssize_t scx_attr_enable_seq_show(struct kobject *kobj,
> +					struct kobj_attribute *ka, char *buf)
> +{
> +	return sysfs_emit(buf, "%ld\n", atomic_long_read(&scx_enable_seq));
> +}
> +SCX_ATTR(enable_seq);
> +
>  static struct attribute *scx_global_attrs[] = {
>  	&scx_attr_state.attr,
>  	&scx_attr_switch_all.attr,
>  	&scx_attr_nr_rejected.attr,
>  	&scx_attr_hotplug_seq.attr,
> +	&scx_attr_enable_seq.attr,
>  	NULL,
>  };
>  
> @@ -5176,6 +5191,8 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  	kobject_uevent(scx_root_kobj, KOBJ_ADD);
>  	mutex_unlock(&scx_ops_enable_mutex);
>  
> +	atomic_long_inc(&scx_enable_seq);
> +
>  	return 0;
>  
>  err_del:
> diff --git a/tools/sched_ext/scx_show_state.py b/tools/sched_ext/scx_show_state.py
> index d457d2a74e1e..8bc626ede1c4 100644
> --- a/tools/sched_ext/scx_show_state.py
> +++ b/tools/sched_ext/scx_show_state.py
> @@ -37,3 +37,4 @@ print(f'switched_all  : {read_static_key("__scx_switched_all")}')
>  print(f'enable_state  : {ops_state_str(enable_state)} ({enable_state})')
>  print(f'bypass_depth  : {read_atomic("scx_ops_bypass_depth")}')
>  print(f'nr_rejected   : {read_atomic("scx_nr_rejected")}')
> +print(f'enable_seq    : {read_atomic("scx_enable_seq")}')
> -- 
> 2.46.0
> 
> 

-- 


