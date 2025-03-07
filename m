Return-Path: <linux-kernel+bounces-551477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD54A56CDF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0019188AD2D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B878D221F31;
	Fri,  7 Mar 2025 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VF+sU4Rs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2208B221F21
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363129; cv=none; b=Z6JCEQ16jACviw4GawlJN9X32LVv0YM84AQfKPfpUbWRUwOfC7xnRXBi+pLD4h7NHbmKFzKGwNBILGlSIGW8dwVllCN9VehDfaSDVY0YzBlHUXO6QpSSZvI7LedWvQA9PPDi0dcZ1JmDajxoUNdK/RWirzYDKXHFoE3le3Z/UOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363129; c=relaxed/simple;
	bh=fH/5vaAn2+rupV0lSUMQO+zbP+VjO2bOTmV9omTmFak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjsiF7MD/P4DycFo/x38dgQq05h987HpVx0XFOFo5A0G5mdSdZZ0ryLqHRcgJKcq1SmncJ8NDF1lhhOVHLU63m7F22Ab1mSEqp+Ih2d+sIhv3IzNPK98NM0OYJ6tV5k2wKUD1k5YlH6dNDFvZrs07cvRoOfbAOj5P9rU8cutQgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VF+sU4Rs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773BEC4CEE7;
	Fri,  7 Mar 2025 15:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741363128;
	bh=fH/5vaAn2+rupV0lSUMQO+zbP+VjO2bOTmV9omTmFak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VF+sU4RsKeo4es9ZCUyEy8Z3VxN/hV+NqpiMdVD9DwhVPdYvsVZTSBrociDmtpgCf
	 1F+4exBazlf9Ox7D40fzJ2sKjlXni83K1oK+/5gp+N6Hxohq7Ro6dSK420UXNRv//g
	 OMQNiuQSjqjCEJshATztaRZdoigll1EwxBLmxssssIQkHPNSunHvYCXf2yRgm0QBMo
	 iJZ0QL0Ge1ni0abQUevf0lyzxNcSlNcyCJ1dmZ2Ax0ZrMto3S2xHlWl7+Fdy12X2AN
	 JxrGKeMYvozP2JBGx3vYJZ01u7GmYJR7w7bG0Hr5agHhaw2vQ+XVGCLObdDb9BBKdv
	 y4vQXYC2NABGg==
Date: Fri, 7 Mar 2025 05:58:47 -1000
From: Tejun Heo <tj@kernel.org>
To: lirongqing <lirongqing@baidu.com>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Simplify cpumask computation in balance_scx
Message-ID: <Z8sXt5eRyga_ukql@slm.duckdns.org>
References: <20250307064533.2663-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307064533.2663-1-lirongqing@baidu.com>

On Fri, Mar 07, 2025 at 02:45:33PM +0800, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> Compare SMT CPU against RQ CPU and skip balance it, to avoid calling
> for_each_cpu_andnot() and cpumask_of(), they are relatively expensive

How is cpumask_of() expensive? I have a hard time seeing how this would
actually improve anything. Do you have any measurements?

Thanks.

-- 
tejun

