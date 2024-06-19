Return-Path: <linux-kernel+bounces-221327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1FF90F1F0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67DB1C20B13
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE8B25569;
	Wed, 19 Jun 2024 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/D+cdA2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751031F95A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718810228; cv=none; b=DsH2K8b0YUfep61o7bhdio3Y3o4wcxo6nrKV8GTBlvzhg8jKY8HOySvxXyogJJ9o5QHFz2HqhiGOJILM8YnmMlBDURKSIb71ayM4NCG+ZsIC1lKDwhLeq52cuevDJcFz1b/93poGHWNx8ay+XFcO5Xd2GmLBVaYl2aiGX26q6wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718810228; c=relaxed/simple;
	bh=hgEb586LrO9KPIUgZrYV++LUVTqkU6h8UN3b41kMY14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dF4RvaTaj3AfQPa/WORN+8QHgIuqqfiIICdD9VPa82z2FqK6+fA3FiGLyDZa20QFatUv4ZANvGht6oAxGd0NVJCmlA4FVKn3xJwBhhDyHtqWUrDFNgcYESeGE1BMCO6g2tCjhHtcclXKpIlheXMaNsDwxXQb16ngIT1OiUM0Nrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D/D+cdA2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718810225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gC7WNA1QA+YwkrX8gjXlglJDeCpaBidYafu3xduhGfM=;
	b=D/D+cdA2q0U0crtdBDg7dVvHJwlHuT6598jnYzUSWx1c5L5rxkdCi39cRBggUY1/eNsZuq
	W/fcHL3HSBeYneqVevxkg8Gjtxgv8r6LpQPM5oWUGXQfUBNo6E05PvmU2SHDO9xbAWkgwt
	1Tqukc//btv2FYVrPBLG9OdBDtekF2g=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-xiTvddoYPcSYiaLGHLgSeQ-1; Wed,
 19 Jun 2024 11:17:04 -0400
X-MC-Unique: xiTvddoYPcSYiaLGHLgSeQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09CA41955E82;
	Wed, 19 Jun 2024 15:17:02 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.168])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5D1551956087;
	Wed, 19 Jun 2024 15:16:56 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 19 Jun 2024 17:15:30 +0200 (CEST)
Date: Wed, 19 Jun 2024 17:15:24 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: hw_breakpoint: Save privilege of access control
 via ptrace
Message-ID: <20240619151524.GB24240@redhat.com>
References: <20240618071010.11214-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618071010.11214-1-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

I don't understand what this patch does, but...

On 06/18, Tiezhu Yang wrote:
>
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -467,6 +467,7 @@ struct perf_event_attr {
>  		__u32		wakeup_watermark; /* bytes before wakeup   */
>  	};
>  
> +	__u8			bp_priv;
>  	__u32			bp_type;

Is it safe to add the new member in the middle of uapi struct?
This will break userspace...

Oleg.


