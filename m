Return-Path: <linux-kernel+bounces-323853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C197A97443D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 22:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0622891E8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE851A7AF1;
	Tue, 10 Sep 2024 20:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+maVeZJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B84F176252
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 20:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726001072; cv=none; b=RgY6Sc3k09GtGJeryNTnyCLdNJMy4mZIpMX8GlWMzPsC6qh7cJSml672cqcwls+uT2S1J9lnUtWntopMzJu7xgYlWI5M8/LIGm88ryIetJrXfebSJ4dP2xEWHK7f6FI7tx6mIwWy/X+SSR7F+l6TeEXjFeAzMRDbmGE1T5ZLJuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726001072; c=relaxed/simple;
	bh=9nafgbmiAaXCaMpS2H9g+FM8xMU9jMdbQEiA16D9NQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDoOOoN7TMyoP91nOWG3wywUUNVu4EM0vT41+3lha6mPmkewwXVHa1sLb9JLfQ3pEcIt1v22qlgPAjLdAy1mEPcYLbbq/5C18Z0kEl8yhaqUEKOgAYsO3kGHlrjRs6le8pzE/NHLajUBc8IsWhrXQl057QlXe8yW/UbtJpLRgIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+maVeZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3B1C4CEC3;
	Tue, 10 Sep 2024 20:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726001071;
	bh=9nafgbmiAaXCaMpS2H9g+FM8xMU9jMdbQEiA16D9NQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r+maVeZJHlnInfE5cTDrVL/QwEQZLzaptYTU68tCi0XCX6LhrzA0KKx2QHNdAOCxH
	 NxbKmnB1fntznG07Cob3W1dX27lu7Hv+Vw11C3cOATcso/O9Rkwm0GI1SxF3WGUGqF
	 mMfIj3x0r8G+/9NfTBBaYrivp4vMFUFiMMnhrDaeI/m3IsknDiVtSMBlMoJGuVpZHR
	 lDUnBXYoDwzNxY/M4XeHRewb5sQBpCtDZR1hezehHM2JIij8zt3c9amA3LLVNpsVLf
	 AJs4Nb/hcptwIAbK8k9Ze+BfZFVIJ/POkc4K4yYTm4lypq2HrW1DXx+Q5egNtDIkhQ
	 jgtft1ivunfqA==
Date: Tue, 10 Sep 2024 10:44:30 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	hodges.daniel.scott@gmail.com, multics69@gmail.com,
	andrea.righi@linux.dev, schatzberg.dan@gmail.com
Subject: Re: [PATCH sched_ext/for-6.12] sched_ext: Don't trigger
 ops.quiescent/runnable() on migrations
Message-ID: <ZuCvrsK9vf51Acy8@slm.duckdns.org>
References: <Zt-HfBC0Q-DcUjHm@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt-HfBC0Q-DcUjHm@slm.duckdns.org>

On Mon, Sep 09, 2024 at 01:40:44PM -1000, Tejun Heo wrote:
> A task moving across CPUs should not trigger quiescent/runnable task state
> events as the task is staying runnable the whole time and just stopping and
> then starting on different CPUs. Suppress quiescent/runnable task state
> events if task_on_rq_migrating().
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Suggested-by: David Vernet <void@manifault.com>
> Cc: Daniel Hodges <hodges.daniel.scott@gmail.com>
> Cc: Changwoo Min <multics69@gmail.com>
> Cc: Andrea Righi <andrea.righi@linux.dev>
> Cc: Dan Schatzberg <schatzberg.dan@gmail.com>

Applied to sched_ext/for-6.12.

Thanks.

-- 
tejun

