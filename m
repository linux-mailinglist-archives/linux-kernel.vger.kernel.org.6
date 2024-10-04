Return-Path: <linux-kernel+bounces-351395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C591199105F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70DC91F242B4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5091DBB2E;
	Fri,  4 Oct 2024 20:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sV+eyGXw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB851DBB26
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 20:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728072720; cv=none; b=YpsdDM3ze0gFPoh2Djw5nMsYrHTVVrO4bO+iJ60mF1xy3eroXHZFQgkVv/zIiJgVKCY56c+ulj2OY9xcnHy3f929vY1Kac0rYYv5f1xnbA+pRo4Wv21rAjyWPVBj7w2v3DlLSJz+cKvcw4is8XAQHGL4uv6ws1lYFteJZNqd/Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728072720; c=relaxed/simple;
	bh=7r7hHmFyeP0fOr7m0Qjy49aO6iWo6eIdszxngxKbEr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rh43NmQK1yPw5RtNNFyoJnJ+YHZUY6EQzRl1qGUyIS7YdwRPOfzUB2R5UbdG1QJ1Gq1vIhvQGksGO1vzxSPBIW/TY/nqfZ72j8ghK1DQFEICvT3c+whdEbwzJIoffdIleaHMjJ+R3DYrH95DjcDpr5wMpr6QHjh2xh1h2OuFFb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sV+eyGXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCFBC4CEC6;
	Fri,  4 Oct 2024 20:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728072719;
	bh=7r7hHmFyeP0fOr7m0Qjy49aO6iWo6eIdszxngxKbEr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sV+eyGXwyPXXI/65SBuOA0Rc5ntKGDUqHFngpRC9BUaI0QZ7mGAp1wm+7+2o4HXDp
	 Vvgotb3Loq4Gji+v66por6Ndt49ONSNPkpaH41wFLFFBiJytYVxw4LGfxiwc/uWPj5
	 wsrwJfxNRxqFw1Po4CfjZTObSzkEgVh3k2Z6rlxJfUD5bivFz0kuAkoCC9YXELvbEJ
	 J3JNT+gEwHE/zD0JfJzzcOJLnpTxxc1hTTlCqVY4VHlLQ60I+tdhskXYqoKtReIUj+
	 RdmZZfZICdX1Ivm+q9GnFJ5zOGf8usKTcicAwHW9Z2RHQ4l44ri2OrELXQfBHKrNxr
	 t2E/wbZtSbFEw==
Date: Fri, 4 Oct 2024 10:11:58 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, sched-ext@meta.com,
	Daniel Hodges <hodges.daniel.scott@gmail.com>,
	Changwoo Min <multics69@gmail.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Dan Schatzberg <schatzberg.dan@gmail.com>
Subject: Re: [PATCH sched_ext/for-6.12-fixes] sched_ext: Improve error
 reporting during loading
Message-ID: <ZwBMDpTJMyq1z7-s@slm.duckdns.org>
References: <Zv2uIXK53_Dqtw8T@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv2uIXK53_Dqtw8T@slm.duckdns.org>

On Wed, Oct 02, 2024 at 10:33:37AM -1000, Tejun Heo wrote:
> When the BPF scheduler fails, ops.exit() allows rich error reporting through
> scx_exit_info. Use scx.exit() path consistently for all failures which can
> be caused by the BPF scheduler:
> 
> - scx_ops_error() is called after ops.init() and ops.cgroup_init() failure
>   to record error information.
> 
> - ops.init_task() failure now uses scx_ops_error() instead of pr_err().
> 
> - The err_disable path updated to automatically trigger scx_ops_error() to
>   cover cases that the error message hasn't already been generated and
>   always return 0 indicating init success so that the error is reported
>   through ops.exit().
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: David Vernet <void@manifault.com>
> Cc: Daniel Hodges <hodges.daniel.scott@gmail.com>
> Cc: Changwoo Min <multics69@gmail.com>
> Cc: Andrea Righi <andrea.righi@linux.dev>
> Cc: Dan Schatzberg <schatzberg.dan@gmail.com>

Applied to sched_ext/for-6.12-fixes.

Thanks.

-- 
tejun

