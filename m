Return-Path: <linux-kernel+bounces-178075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D2B8C4849
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 22:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8572819C8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 20:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84D780045;
	Mon, 13 May 2024 20:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Gfg+0xdX"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E8A7F499
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 20:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715632579; cv=none; b=us6kiFeHCJm6bbUGeavQB9jrhpZ7dFEaMOiKLamvTtF9tshfwnw5VidWktTCj9mPHtGV0exNUpanDi6Gcc2+pq7NKg3iNxcgJqdhhuRoizWRkCx/Sk8neMlsmLXwo6ReJViVriDYtNLpz7aNLfexaXdc0+vnyiOE0J3BIg8EaII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715632579; c=relaxed/simple;
	bh=Vm5ffhlsGkE2Y3R2YiSsCMLraUbkncQ+RgFFPCJX4rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWW0l23roRF8+211ic79KfC71yOwQygYB8I851GA1/oFS3PbsshoU+usXqI5kO0+Wxq9xT7NQIK72XBdur3gGShXNwp9PtOzur4Ok5aFCAIU7y9R74+J3/6eameFPhs3VMLS7++GXYLknpAEdtKfxF3i3zVXIogyNH1JABTafxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Gfg+0xdX; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 077763FB6E
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 20:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715632568;
	bh=iHGP+H/HM9flCIvET231fhltqpSgxNj3NFbnCTXeM88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=Gfg+0xdXR1HN7Q/j/WtqLQjBWj/ugy68Va3XzGKhuplG+Abwkz6MdaUdOd37gcJH3
	 pSrpcZ/Z6oEXyVs8lP8edyEIo+7IVa6zkd1Ga32Iie0gb+9XnAQMOxasdRRiGk/ET5
	 xQu4nj76KdAky3JDrAAmIZotHOUtF7mAHt6s6yolF7svzykn62oRqsEvweg/kAa75I
	 x9YlXmk0D7HEDtcOT6S1zy7SWnbbkWtK6Nw1uWi148PO7HwOwIb8fnb9JohNwXjI49
	 Pos8QGDDipo90IT9Qx5d/IVkYr6YKhAHDYbDwmdQksyblxmGYGbKyfjNKc9agzJ+F8
	 s5tru/T/LYQZg==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a5a5fdd6185so190864866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 13:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715632565; x=1716237365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHGP+H/HM9flCIvET231fhltqpSgxNj3NFbnCTXeM88=;
        b=YF9PANjJeyA4RV1VOvq4fW8JycKr+adNpBlFdZxPnmJHjmRrB87l7P1pML6uHW1nCi
         frkyJnHOvyTL5My1nsYG1evju8grP5VHCcwh5ytakPTVXiNqIvnDdOowjMSlXA82yrwE
         WpnDhKRGtc/TLgYEAqtR44IxepEwUZkipM06ZpvzyyCecqcRzUuFxknrsg2RJNKtAGgy
         9J+TEWaWG+VV/7K29ts1JRpuThcHb1CdjgQ/Ag9V2fkV6kATzm8Fan1Rbrrshhbx20ZL
         p02oyroxBcbSJupzxDNYfdNfezn17kcU/mxDyGvFaZAr6ArZwmTSfwWM/wHP3l6m7uXq
         BjUA==
X-Forwarded-Encrypted: i=1; AJvYcCXB3s5hyFUfFMurvv8g6VaWjTJhYfTeih6jJrj1HxCKysJBt+Er0+6ab8LyA8sIyX8CV5FDFcgFxuUEN7A1O9Q2lRCo8BedN0Oce3LC
X-Gm-Message-State: AOJu0YzXhnx2++t4UpBhFAWDfgmXUlkbzSwmZQCZ6IfksFiyMkSGOQGV
	z1KpYJ5uyoxvb/xsAza28DShMtUVGsS5wC4AARhTBUwL2KGoP2qQaJlYipLYyRE8Qsn9GQqPEme
	32UF6eG1JsHGRnjwnYkSPmf3TMsNFMjduerO4PNEkZxVJ1e25rlg0jHG6lsEpdjkyqARIgofa59
	g19A==
X-Received: by 2002:a17:906:bc50:b0:a59:cb28:a8ae with SMTP id a640c23a62f3a-a5a1123b477mr1149344466b.0.1715632564576;
        Mon, 13 May 2024 13:36:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg1kQyCjjCLZOhI8xB5fNDStLR4XHod0qoVMqxPP86DQNq5z5g3CRr53iNeRzv+ZRIvZoBqQ==
X-Received: by 2002:a17:906:bc50:b0:a59:cb28:a8ae with SMTP id a640c23a62f3a-a5a1123b477mr1149339166b.0.1715632564003;
        Mon, 13 May 2024 13:36:04 -0700 (PDT)
Received: from localhost ([149.11.192.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17d02sm638065566b.218.2024.05.13.13.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 13:36:03 -0700 (PDT)
Date: Mon, 13 May 2024 22:36:02 +0200
From: Andrea Righi <andrea.righi@canonical.com>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, joshdon@google.com, brho@google.com,
	pjt@google.com, derkling@google.com, haoluo@google.com,
	dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
	riel@surriel.com, changwoo@igalia.com, himadrics@inria.fr,
	memxor@gmail.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
Message-ID: <ZkJ5spNSP2Hzj-Xq@gpd>
References: <20240501151312.635565-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501151312.635565-1-tj@kernel.org>

On Wed, May 01, 2024 at 05:09:35AM -1000, Tejun Heo wrote:
..
> - Ubuntu is considering to include sched_ext in the upcoming 24.10 release.
>   Andrea Righi of Canonical has been actively working on a userspace
>   scheduling framework since the end of the last year.
> 
>     https://github.com/sched-ext/scx/tree/main/scheds/rust/scx_rustland
>     https://discourse.ubuntu.com/t/introducing-kernel-6-8-for-the-24-04-noble-numbat-release/41958

Regarding this topic, I can confirm that Ubuntu intends to provide
official support for a sched_ext kernel in the 24.10 release.

We still have to finalize all the specific details of the plan, but
essentially, there will be a separate "derivative" kernel featuring
sched_ext, alongside a user-space scx package(s) for the schedulers and
tools (which, ideally, we would also like to upstream into Debian).

-Andrea

