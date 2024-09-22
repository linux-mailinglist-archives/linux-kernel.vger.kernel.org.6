Return-Path: <linux-kernel+bounces-335141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A39397E1C0
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 14:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB131F213A8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 12:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB68139D;
	Sun, 22 Sep 2024 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YuA5kkhG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770877E1
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 12:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727009728; cv=none; b=P5RQ2ZJKO/MdO7Qe9Q444EhsnsGtcAeYyv70DCmm78SdG4GjweHtzjnvD1S0P4FJaA+XMhYo/YJYh4IE++1N4IBqvbQLv7OQmnH9VQcCeY9tyUKmsfLbdV3tEYEsI/4lARPgR4/rLQIOiUZ/w3afJl2k1YtEMUt+ppabNBojCNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727009728; c=relaxed/simple;
	bh=3tWYqI7ESR2PkD5yF7Ujend92FQEIquO3TcqsrQJ2v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaohKECES9cm9r7XejElQwhwFNVkehquXPgNm5A3ir1HW+p/P37N5atmD7HVeE7lVJ7ORXqRI2UyBVvSzuO4qKM542KK2P/3peun44XGFQrB1TVIc4A7caipduKdm9XRDWPgOE5j+3nR/YNEhI/AL2cEWKtoT/PhUBpsmbgsxcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YuA5kkhG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727009725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HJu5OA2N3X4rk8YmNnrd6Eec6y1gkJFQlhfmBaY80jU=;
	b=YuA5kkhG2PBWcdOKOYBrbOKrIIR9eDlcDMhs/h1nmvJKKmpgIe+sUB6DEALsmVtlCEwGBF
	k1VvyvQHErzVvuBzibYa7OZshSwSlZxHoz3FSt5nLQ+0MjNesVo1i2rYILGGGjdRPzIdbY
	ceJPA77quskxIt03nN2JRdX4b6Q3uLs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-oI5VGB6EPci41-_kRMOg6w-1; Sun,
 22 Sep 2024 08:55:18 -0400
X-MC-Unique: oI5VGB6EPci41-_kRMOg6w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6D051979062;
	Sun, 22 Sep 2024 12:55:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.42])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 087ED19560A3;
	Sun, 22 Sep 2024 12:55:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 22 Sep 2024 14:55:04 +0200 (CEST)
Date: Sun, 22 Sep 2024 14:54:59 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "qiwu.chen" <qiwuchen55@gmail.com>
Cc: corbet@lwn.net, mhocko@suse.com, jani.nikula@intel.com,
	akpm@linux-foundation.org, brauner@kernel.org, paulmck@kernel.org,
	linux-doc@vger.kernel.org, "qiwu.chen" <qiwu.chen@transsion.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] exit: dump current pt_regs info on global init
 exit
Message-ID: <20240922125458.GA9426@redhat.com>
References: <20240922095504.7182-1-qiwu.chen@transsion.com>
 <20240922095504.7182-2-qiwu.chen@transsion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922095504.7182-2-qiwu.chen@transsion.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add lkml.

On 09/22, qiwu.chen wrote:
>
> @@ -847,10 +848,12 @@ void __noreturn do_exit(long code)
>  		 * If the last thread of global init has exited, panic
>  		 * immediately to get a useable coredump.
>  		 */
> -		if (unlikely(is_global_init(tsk)))
> +		if (unlikely(is_global_init(tsk))) {
> +			/* dump the pt_regs of current thread for debugging. */
> +			show_regs(task_pt_regs(tsk));
>  			panic("Attempted to kill init! exitcode=0x%08x\n",
>  				tsk->signal->group_exit_code ?: (int)code);

Well, this means that show_regs() will be called twice if CONFIG_DEBUG_BUGVERBOSE
at least on x86, see dump_stack() in panic(). See also show_regs_if_on_stack()
in show_trace_log_lvl().

Not good...

Oleg.


