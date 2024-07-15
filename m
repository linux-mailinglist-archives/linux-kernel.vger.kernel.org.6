Return-Path: <linux-kernel+bounces-252044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FE5930D78
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 07:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F33A1F21488
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 05:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFDC139D05;
	Mon, 15 Jul 2024 05:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNnDWT+l"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195EC23A9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 05:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721020656; cv=none; b=bCNyQrFQsszDAisV2ZSPlZJhKGT/JR1O1ayqtiltzfmUoRdGlaJIvKbLF8cY6a6bjyBekvhn6p1PBsBids2/3KY2t2RUfwYaNcDXRFcSjsGJ+zRaBiEBxTBt7yPCXRt2D6v3EFAbWx8oonMS48k/J60L1I+ywIydn3jKxz3HQxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721020656; c=relaxed/simple;
	bh=2dB+4NW25Vy1y/w/I42IjtsTHq8JEtqyfEauHOUmZRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHC8tW0Nwzoawg45cWRMEMIcj5fSiL1BdWuCYj1Tbzsd1ZuQwL62cpB6g4JWOHZOd3j7ib23HYNOaHydQ9nuoFcNOqNTcVXevqNxAU48iiQG0LQxaREVogZWSX/npPI7seK2ou/JyGHwrwsiD5VAnhl14kUhmE9fD9UHUHHh3qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNnDWT+l; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-767506e1136so2786066a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 22:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721020654; x=1721625454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIzZZfZmFSjXeRKbRDsdNKXHqqNFJBx4cF3Fw5vmNVw=;
        b=MNnDWT+ldES46VhlYljnqhafplXJgYDlMhDae9B1AMa393XKqmPspfnvWDrZUxnoZ9
         GzMP+obq6JhNVcWNa6cx6MEOm+pisYIKOKi/BkV7qDp4BPASNqgur77LMV4gKHD7hnYb
         Rocap/YKRbnbJZNJd/xVz34TPPRsDFxea5CrTWIEYl2BbqgMjR/T4stGD/1/pZz8AfTz
         dvvsOVOOEsDiuCqeTnbTlFu8CQexhujRncVuyMAUj9ys6SWEG/JReaoHZMhsb//B7gQv
         4FsnPk6UMJ1FlY1VbHrnVYeLNCG7wUkSYF3emmFqCRPphdrFw35zHoTIuGa3eSrdsNQm
         n+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721020654; x=1721625454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIzZZfZmFSjXeRKbRDsdNKXHqqNFJBx4cF3Fw5vmNVw=;
        b=ecJGLI2P7jBFPGSfbpxgWNW1oa0cBeCjsGhsyY+VdSw0ebgbCgLE3dg+FbLACD9vGM
         1mD0cLihHn74bYEH32UkcPZU25xTlEnePiqXlOk/h6oUk2z6HJgrtf/WxJSFZlOJ0PEt
         BKduXSckEs2ClSxutKlMQL/y0o4Rvhlp1yD6z9hKwvsSX9F2shG+zfL3D44W1B01HJw/
         Zr5RFCsxgO6Cg8WzjE5arMpIi8M9NB9RKC9igCqvbWgVEZO0p4jaeSwQStOYTKbBU8N+
         FHwuK4xtxGWyZepMjxN9aaxDtgmDorZV5f21dW1RQdu66pvl4lCwPzLnNXMwNFQ/D1IJ
         f6OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzUEY4qoMCx5v7ODZJ2fBpIZr+9aRU2uLgoBKhiwkHqRm9oI2ySsqlMB2glv/hO2IdrKV5QO1pIaHdhSdRbTmDcURTT7TyuSHPGAcQ
X-Gm-Message-State: AOJu0YygyMCxKRCuWXkleljqFJhbxgVaGYxkqVPEfOqABX4yIhCCxQ/s
	HFA+8SU+WrFNH8ZbbpCYxbcklKqIPdARRT1SxXLHUeq0cIV80rTXbXKZBQ==
X-Google-Smtp-Source: AGHT+IE/8C1bvFpCsDnyqVOyBh2nFA/vOavRs3HFFApq/5Gmn34XAVdGY+aS47t3xA6p6eCpZgc4iw==
X-Received: by 2002:a17:90a:bf08:b0:2c9:6d45:8187 with SMTP id 98e67ed59e1d1-2cac51b7e97mr13632825a91.21.1721020654311;
        Sun, 14 Jul 2024 22:17:34 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cacd2ccbdcsm5387415a91.11.2024.07.14.22.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 22:17:34 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 14 Jul 2024 19:17:32 -1000
From: Tejun Heo <tj@kernel.org>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: sched_ext/for-6.11: cpu validity check in ops_cpu_valid
Message-ID: <ZpSw7PvW1Teh6tNV@slm.duckdns.org>
References: <ZpLSEHskvXXv4EoR@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpLSEHskvXXv4EoR@linux.ibm.com>

Hello, Vishal.

On Sun, Jul 14, 2024 at 12:44:24AM +0530, Vishal Chourasia wrote:
> Currently, the BPF scheduler can return a CPU that is marked as possible
> in the system configurations, but this doesn't guarantee that the CPU is
> actually present or online at the time. This behavior can lead to
> scenarios where the scheduler attempts to assign tasks to CPUs that are
> not available, causing the fallback mechanism to activate and
> potentially leading to an uneven load distribution across the system.

ops.select_cpu() is allowed to return any CPU and then the scheduler will
pick a fallback CPU. This is mostly because that's how
sched_class->select_task_rq() behaves. Here, SCX is just inheriting the
behavior.

Dispatching to foreign local DSQ using SCX_DSQ_LOCAL_ON also does
auto-fallback. This is because it's difficult for the BPF scheduler to
strongly synchronize its dispatch operation against CPU hotplug operations.

> By defalut, When a "not possible" CPU is returned, sched_ext gracefully
> exits the bpf scheduler.
> 
> static bool ops_cpu_valid(s32 cpu, const char *where)
> {
> 	if (likely(cpu >= 0 && cpu < nr_cpu_ids && cpu_possible(cpu))) {
> 		return true;
> 	} else {
> 		scx_ops_error("invalid CPU %d%s%s", cpu,
> 			      where ? " " : "", where ?: "");
> 		return false;
> 	}
> }
>
> On POWER, a system can have differences in cpu_present and cpu_possible
> mask. Not present, but possible CPUs can be added later but once added
> will also be marked set in the cpu present mask. 
> 
> Looks like cpu_present() is a better check.

We can consider tightening each path separately but I'm not sure making
ops_cpu_valid() more strict is a good idea. For example, there's no reason
to abort because a scheduler is calling scx_bpf_dsq_nr_queued() on an
offline CPU especially given that the kfunc is allowed from any context
without any synchronization. It can create aborting bugs which are really
difficult to reproduce.

Thanks.

-- 
tejun

