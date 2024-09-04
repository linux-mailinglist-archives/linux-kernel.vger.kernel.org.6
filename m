Return-Path: <linux-kernel+bounces-315902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673AA96C85A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9635F1C2291D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28758148304;
	Wed,  4 Sep 2024 20:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akgS+hOc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA4612C54B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 20:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481641; cv=none; b=NgdwOHbpWNRI0Yf7X36z47qsIpUdb1Tdq/EEqwIww8iR/1l47TRzKwxashtSGnagBAFba5cKoIfxiwDWY+MQcf3Fk8rstngqbkkzZKffLok9pBJhTdj3yETcRh/XEaEy5tYwQ2LvMdgGbQ0YoRruC+QNH5DroN0KMJFCKTn0GGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481641; c=relaxed/simple;
	bh=Tu6xZXP9z9EHz1Y3zLb69vyH04xM96AwgolmnF7AcHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9vYZin12Utmab7Q0/My6UOsMLqbakUDsCkya4MdJ9vlEkvq5EhcofvvEw6Rx92d9U/PCV9lsMOc7UQJZHWZ+9zfclxGSjQFI/Li3dyYoOLGQLS9wODN4DYLq4O28fE8vw1zWXP7t49AiJYzWkpGQCPwsQae0kskcZ+cF6TaPMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akgS+hOc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22A6C4CEC2;
	Wed,  4 Sep 2024 20:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725481641;
	bh=Tu6xZXP9z9EHz1Y3zLb69vyH04xM96AwgolmnF7AcHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=akgS+hOcdtfBBawAXnMnvG8ouT8cjBLEOKWKGsFDXVnu/wSoOcguWixFDNMI2jya+
	 07HRIMzd94wTfixmXq94aa5z374l1PuRSdaDvGVSP1WfR3mddLY+fsDW12IAOsGRe5
	 D7/BOHTLba3bBFBfyf8QLcmudjE+J+PWJmycDdgpL5NgrQwtjby4ACXnE3/YyrbnDS
	 wqJm/8t5EdJw4AYbpJ5+colpvBxH2J+ND7yqTYfgFO1QFXf76DHyq7AOlXOxYri+cI
	 WVr01duIBp91EbtDaKM06gwRkLuTMBV898z8JnfgSjQFVz3V8Jezt/L1WsPpNre6uw
	 3i+Nci17cgGJg==
Date: Wed, 4 Sep 2024 10:27:20 -1000
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v2 sched_ext/for-6.12] sched_ext: Implement
 scx_bpf_dispatch[_vtime]_from_dsq()
Message-ID: <ZtjCqM0-dZJOIOcB@slm.duckdns.org>
References: <20240901164417.779239-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901164417.779239-1-tj@kernel.org>

On Sun, Sep 01, 2024 at 06:43:37AM -1000, Tejun Heo wrote:
>  0001-sched_ext-Rename-scx_kfunc_set_sleepable-to-unlocked.patch
>  0002-sched_ext-Refactor-consume_remote_task.patch
>  0003-sched_ext-Make-find_dsq_for_dispatch-handle-SCX_DSQ_.patch
>  0004-sched_ext-Fix-processs_ddsp_deferred_locals-by-unify.patch
>  0005-sched_ext-Restructure-dispatch_to_local_dsq.patch
>  0006-sched_ext-Reorder-args-for-consume_local-remote_task.patch
>  0007-sched_ext-Move-sanity-check-and-dsq_mod_nr-into-task.patch
>  0008-sched_ext-Move-consume_local_task-upward.patch
>  0009-sched_ext-Replace-consume_local_task-with-move_local.patch
>  0010-sched_ext-Compact-struct-bpf_iter_scx_dsq_kern.patch
>  0011-sched_ext-Implement-scx_bpf_dispatch-_vtime-_from_ds.patch
>  0012-scx_qmap-Implement-highpri-boosting.patch

Applied to sched_ext/for-6.12.

Thanks.

-- 
tejun

