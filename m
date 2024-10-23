Return-Path: <linux-kernel+bounces-378737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE979AD4A0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDBD5B21E1B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1F81D0E18;
	Wed, 23 Oct 2024 19:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cq7p6ehF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209F71CF5C4
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 19:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729711233; cv=none; b=OXxaWGZHujWlpbMyAtqFM41Qla8ZtuEr7keEvcudOY0yifUFv9GK4TjKldlX6G1kgxUqZg+1TohzeNoQlknoG9WTaHyoavu1Y+7AN9VU6WwUT4EZB3eQ9n9+owlopb+csVTKsYnwuCKKsyvZ6jU/nUAv14xcceJnC9yqWn2Pb5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729711233; c=relaxed/simple;
	bh=PY+OPSnE8upfsVI93jDUXeqT9p7dWGq2UprYSqma0Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRjizJRNNRLwxZSS+iGCme0uJOhbd81KFZLo0ww+SqCN44HD7Oavki6dD5kIBQ10xFlwGVTg+Zo1OiW6iaxXAAWKr3hQ5EzIfRa9cY5M2sLmx1nc7omVahi/Uck0JbkUohdyGoBtJlUEH1GEbTq0PiqpcmZZ65YUuH1j/Rg6efU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cq7p6ehF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7159EC4CEC6;
	Wed, 23 Oct 2024 19:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729711232;
	bh=PY+OPSnE8upfsVI93jDUXeqT9p7dWGq2UprYSqma0Ps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cq7p6ehFAtUikdnvEZ1FsAXzDAUaIirBUQLsYnvAe63uxQvzcDSo6bAb+OyUNZ+mV
	 QGmR+qjdcrPXYqOwnMdHR49ZNwVCSbtL2oWtJ3wzos5XZNsryBCKyFltJ1wiqJ3eym
	 t+d487tMq2WIPjNOemR4QddNWBjtaKCk633o5lvBAnFkhMeI8QR+SHcUw99sj6ngkk
	 /0g9t4Du+dq6v0XcXggGZosz4PBpmgCK1c7EyV8nWQ93aeHshWqpLt/7q0FYNrGT+9
	 n1w3FXXKHVzs3UDD3LOZRLBuz32bJvKteNNnikcx76DE4eToy1fex/2RHwyiWoJpkt
	 Xj6yESqAj1A2A==
Date: Wed, 23 Oct 2024 09:20:31 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Clarify ops.select_cpu() for single-CPU tasks
Message-ID: <ZxlMf94wpHuAsPQm@slm.duckdns.org>
References: <20241023111907.36172-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023111907.36172-1-arighi@nvidia.com>

On Wed, Oct 23, 2024 at 01:19:07PM +0200, Andrea Righi wrote:
> Update ops.select_cpu() documentation to clarify that this method is not
> called for tasks that are restricted to run on a single CPU, as these
> tasks do not have the option to select a different CPU.
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Applied to sched_ext/for-6.13.

Thanks.

-- 
tejun

