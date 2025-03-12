Return-Path: <linux-kernel+bounces-558466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1ADA5E64F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EA66165625
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0043C1EEA3B;
	Wed, 12 Mar 2025 21:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGWUJjUQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBA83D81
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814045; cv=none; b=JYP6CP9QMn5cC7SS+jP2qdfHKPIzDcBFp1uuORDzIjOeLj9RgH9OjOZAYJ72awcz9VGH4EAI19ieawF8zGJUNcuSgjCDR+joke639QNNGCWT2PHhhO3GWR92rcwpfTApGsJEMb+K2/NHR2AggZCE2e/kI5qBgRijBzpUSbHNpXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814045; c=relaxed/simple;
	bh=fDJWUvivJfWvxswiKcX+bh4YnAo11JQUFxKNJakCsBw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MzhvbMfw9luhnzmF3WXlJFN6w0NiIK1Fv62J0wIS8K6sgMn3QNMbQTmqVyf/9pb2zekhGCF2iSwGKBVWJvreVadLWh/j83Woy9uv6AHLiJ3q3cHLg0EfS/qyJueVYUDCa4FT1xEdiyF8ZIy5h54DkEa9+lQ8iZP0+bQu0YR87lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGWUJjUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABB1C4CEDD;
	Wed, 12 Mar 2025 21:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741814044;
	bh=fDJWUvivJfWvxswiKcX+bh4YnAo11JQUFxKNJakCsBw=;
	h=Date:From:To:Cc:Subject:From;
	b=cGWUJjUQuP/rp6XAfpAjocTdAiZkuLbwdGk2UqCXKZDP8qKU6qxQ+zBzjEF0uQssr
	 4o3V8uwUAcWATlYZCX2EwdMVMOvcATfxDct9iJXKOIbvr8v3gfDy8Y+HtM/hLdzhi8
	 jRxLNAP2ydsSn8YypxfQGUzkGgfln6Ybf2D3MOCGI3QykYSVb5zHsSkHSKSkrs39zT
	 xMjTwqEM6lRsffNzufwF+Uz1DV6JutTAKmQEtg4ZEwgUKA5DAWR3IIHkKGs99ihAnQ
	 Vr8DYmkuz4TR95xfn3WCx7mp5kVZTJ3avEyA5YTtAcljrI5w77677dQjuwqE8yyH9L
	 CBley+hMTF6Ag==
Date: Wed, 12 Mar 2025 11:14:03 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Subject: [GIT PULL] sched_ext: A fix for v6.14-rc6
Message-ID: <Z9H5G3I7A477CRuP@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8fef0a3b17bb258130a4fcbcb5addf94b25e9ec5:

  sched_ext: Fix pick_task_scx() picking non-queued tasks when it's called without balance() (2025-02-25 08:28:52 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.14-rc6-fixes

for you to fetch changes up to 9360dfe4cbd62ff1eb8217b815964931523b75b3:

  sched_ext: Validate prev_cpu in scx_bpf_select_cpu_dfl() (2025-03-03 07:55:48 -1000)

----------------------------------------------------------------
sched_ext: A fix for v6.14-rc6

BPF schedulers could trigger a crash by passing in an invalid CPU to the
helper scx_bpf_select_cpu_dfl(). Fix it by verifying input validity.

----------------------------------------------------------------
Andrea Righi (1):
      sched_ext: Validate prev_cpu in scx_bpf_select_cpu_dfl()

 kernel/sched/ext.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
tejun

