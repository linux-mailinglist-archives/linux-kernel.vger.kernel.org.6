Return-Path: <linux-kernel+bounces-513509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3A3A34AED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5585E171EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADA4145348;
	Thu, 13 Feb 2025 16:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oeca/9Hi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5496728A2BF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465287; cv=none; b=LvTS9E5az+K+H5LIVsDr9GqbC6majxq4Cp0G2g6ovuTEZUJpMkpt/dszIduvwCemmhEC/2BooMvfbMrRI3VzDpCODWxTDvXd34WZXwoOkUqNsVazwAtUN9WuLDvLLCqI1RnMSE9SQip81O/3OPSgz0a6ivznq7X/q1ieFfMmV5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465287; c=relaxed/simple;
	bh=pnn8BHmnPhguSHhF9SP8/h5BuMjqKk4bkkp4E50/w+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApEkWRiReiTbZ2zSkiVUL2ZDOlzKuxHexnVIgDh+8L+LO2YB8xwURbzQRQgd7jXYLAOC+m6cS6Ug4PY+BPvTKcp5QGaYkEFkWVL9uMY9+P0dZzYiQOKZkCgXmfWbcsQsfFHfUL/Ozg8s0wLxrRvmPGPJBPJ0sdfRfpPYCyLf3QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oeca/9Hi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C58C4CED1;
	Thu, 13 Feb 2025 16:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739465286;
	bh=pnn8BHmnPhguSHhF9SP8/h5BuMjqKk4bkkp4E50/w+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oeca/9HiiWk4G5pgQFM9wiSTpGFnGjqiBKl/68YzSZrOhdEO5An007RW4eK8qL4Rh
	 j2IaEXrqo1dGnP/VeY7kj7E8src1iVIkzXzbVVPmvZ3UwGN31BDifCE0DVjp360V3T
	 wQXuCMNc7MkhlUXk2wv/XMr5fS48qmnGb7D1XTkHwp6qJFsNwXAIbl1M0/9P79JsM4
	 5F0OOeDjrYmTvE/zIG+6l3DULNKvxO2KaWThm+SlzItxjX+1DJbDfqGFonCL6hSjbZ
	 p+hDgrsxQZrM7tPMxOyzuBPYAXIjYK40tkPGTw35WT+SUKXKG4qOnSc7x2cqY/fltw
	 EV20blxUqF65w==
Date: Thu, 13 Feb 2025 06:48:05 -1000
From: Tejun Heo <tj@kernel.org>
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix the incorrect bpf_list kfunc API in
 common.bpf.h.
Message-ID: <Z64iRW-yJeTm49u3@slm.duckdns.org>
References: <20250212071936.1406029-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212071936.1406029-1-zhouchuyi@bytedance.com>

On Wed, Feb 12, 2025 at 03:19:36PM +0800, Chuyi Zhou wrote:
> Now BPF only supports bpf_list_push_{front,back}_impl kfunc, not bpf_list_
> push_{front,back}.
> 
> This patch fix this issue. Without this patch, if we use bpf_list kfunc
> in scx, the BPF verifier would complain:
> 
> libbpf: extern (func ksym) 'bpf_list_push_back': not found in kernel or
> module BTFs
> libbpf: failed to load object 'scx_foo'
> libbpf: failed to load BPF skeleton 'scx_foo': -EINVAL
> 
> With this patch, the bpf list kfunc will work as expected.
> 
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>

Applied to sched_ext/for-6.14-fixes.

Thanks.

-- 
tejun

