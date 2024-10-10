Return-Path: <linux-kernel+bounces-360112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA48999490
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 23:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05AA1F2439D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD531E260B;
	Thu, 10 Oct 2024 21:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/0wANbx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2138F6A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 21:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728596612; cv=none; b=fegRQZepAgFPpaz2hOnFbh9+xSb7URavkGyMUy4YbwEQTADWDOoCKK4wLRyvgypOeZrIlul2XbahHNAF1yukRIdYOZ7yq1l6/jVnPDPcH6RoZMF+bLRhfl9bT487zQl+THPmYKGWMT5PO5no+xF4T1eCCauqvi3gT/1gRgv3sik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728596612; c=relaxed/simple;
	bh=eIvxptA0DIlaTCQeU9SFdJiu2gS7TBHZFd1jgjEpvQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kd+GTzJaf5rIPMcKjuO72rIYjF/EHKaNLNRI7Os+mwdW6L5PCctkJRNI8tZumHhBsK855qvFCEAJVaFLqrRA5JxfQASwcUXH9RMfeLHOR8r5XLq+9fOZPxmT0rGuT0PWZtrnvmyTDdD6AmRJXQX6YrK+uOFkieLdq2ulCPD/m5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/0wANbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B1DC4CEC5;
	Thu, 10 Oct 2024 21:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728596611;
	bh=eIvxptA0DIlaTCQeU9SFdJiu2gS7TBHZFd1jgjEpvQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E/0wANbxgD2E/SIrOvj4FAnEPLzsrgM2ffMGmJCY1sCJIC7gPwwxXWbsiKDwAcX43
	 QKnWLuzRExuEmaT/B40qqGyXcH5hhem66yO324ivVK1qFNpverpDIV6j7pRHfSiElE
	 awL4l1v44LQVBre5FRYX0KcKgaGEH5VHzx2m2nKE/gMRSpWpHZeHGK8OPL0qfG48Fw
	 Ejllp+Rscxakxa1OnnUTCqCsLZa7+BnLTZI3xVsZF/JoLYjIyXVBHWiR2+KT4Bk2LE
	 v7EVYyQrMO/1g6pFAJVQnzHmYFA2LITMoT8V2FTW6W5QhhZZjHeZaBxnofsuV1o1qj
	 RY3RftFv2VN0A==
Date: Thu, 10 Oct 2024 11:43:30 -1000
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org, sched-ext@meta.com
Subject: Re: [PATCHSET sched_ext/for-6.12-fixes] sched_ext: Fix RCU and other
 stalls while iterating tasks during enable/disable
Message-ID: <ZwhKggvg4dFY0mlF@slm.duckdns.org>
References: <20241009214411.681233-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009214411.681233-1-tj@kernel.org>

On Wed, Oct 09, 2024 at 11:40:56AM -1000, Tejun Heo wrote:
> The enable/disable paths walk all tasks a couple times in bypass mode. There
> are a couple problems:
> 
> - Bypass mode incorrectly depends on ops.select_cpu() which must not be
>   trusted in bypass mode.
> 
> - scx_tasks_lock is held while walking all tasks. This can lead to RCU and
>   other stalls on a large heavily contended system with many tasks.
> 
> Fix the former by always using the default select_cpu() in bypass mode and
> the latter by periodically dropping scx_tasks_lock while iterating tasks.
> 
> This patchset contains the following patches:
> 
>  0001-Revert-sched_ext-Use-shorter-slice-while-bypassing.patch
>  0002-sched_ext-Start-schedulers-with-consistent-p-scx.sli.patch
>  0003-sched_ext-Move-scx_buildin_idle_enabled-check-to-scx.patch
>  0004-sched_ext-bypass-mode-shouldn-t-depend-on-ops.select.patch
>  0005-sched_ext-Move-scx_tasks_lock-handling-into-scx_task.patch
>  0006-sched_ext-Don-t-hold-scx_tasks_lock-for-too-long.patch

Applied to sched_ext/for-6.12-fixes.

Thanks.

-- 
tejun

