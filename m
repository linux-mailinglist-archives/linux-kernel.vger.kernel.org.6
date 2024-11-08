Return-Path: <linux-kernel+bounces-402349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CD79C26AA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 21:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9871F2192D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00AA1CF5F6;
	Fri,  8 Nov 2024 20:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnZMrYTc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A3617A5BE
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 20:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731098285; cv=none; b=IwDhyluTbPnoGR8WQZXNLzO1CNpFSShh11hOMbGNZdcWRPnQKtFZm7hx2lr5kRQyaXEqYNHRDFWjLOrpnhQgtt5aTbIgR4cNQh9r8tFulFvPf+Go3KiOLnTCOG+kvrMjZc25yk8mPGGUEyU3fh3VR6G+QWI9DwGU4GaYfnROPLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731098285; c=relaxed/simple;
	bh=mYZu31TFoHeC1EQYi1DFFEWNPmkRwzl46rSAuB7oQ+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzRo/OqwmUzrmFuZ7PcTlSfmwGPU0VNDSla/bHzseydAcYfdy5a0SZPYK2/0og6gSICaHS0SdYyUrItzHIpKorn1jvh14JUgnkLGF0YJmXrS4QGR0mJzcdapMPwbHNYIBynN6dcDs206Hr16N0Hb+qIgllsfolZiGj11Kd+7NsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnZMrYTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C833FC4CECD;
	Fri,  8 Nov 2024 20:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731098284;
	bh=mYZu31TFoHeC1EQYi1DFFEWNPmkRwzl46rSAuB7oQ+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lnZMrYTcgM7ssrWsuK6AVXITepjqFbDs4f7Tziz1JkFkwhZZ6BIhmVb7noIR/vuSO
	 Uk18OphD/OgUavn111RlGa6Pjy+qG1NBLbpjsuTKNXjIzRfn+fYZ90KMLdAIbQr0mQ
	 VdCXUnVx9IHBuhu5eHvizTZzw16gNYDGVCG2yHXZ/eqg6RYeWfrKFwxSlV1ewlAn28
	 7m8GOMZ9la86S0hIXHZKyNCWdhRRYBdl2tfduy7HaKg4H7BooTIe8WXseYe3k81xEb
	 WiVKAxkbjzHNd6xcoBIvggol0dmRsmzmGJ7zd+5OD1+c+V3TrdrtVEqMfGKdA88SJJ
	 8wA7XT7n17Mzw==
Date: Fri, 8 Nov 2024 10:38:03 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, sched-ext@meta.com,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <multics69@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH sched_ext/for-6.13 2/2] sched_ext: Enable the ops
 breather and eject BPF scheduler on softlockup
Message-ID: <Zy52q5U8p55DtdJw@slm.duckdns.org>
References: <ZyqSm4B4NuzuHEbp@slm.duckdns.org>
 <ZyqS0GP9h2hG2lvC@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyqS0GP9h2hG2lvC@slm.duckdns.org>

On Tue, Nov 05, 2024 at 11:49:04AM -1000, Tejun Heo wrote:
> On 2 x Intel Sapphire Rapids machines with 224 logical CPUs, a poorly
> behaving BPF scheduler can live-lock the system by making multiple CPUs bang
> on the same DSQ to the point where soft-lockup detection triggers before
> SCX's own watchdog can take action. It also seems possible that the machine
> can be live-locked enough to prevent scx_ops_helper, which is an RT task,
> from running in a timely manner.
> 
> Implement scx_softlockup() which is called when three quarters of
> soft-lockup threshold has passed. The function immediately enables the ops
> breather and triggers an ops error to initiate ejection of the BPF
> scheduler.
> 
> The previous and this patch combined enable the kernel to reliably recover
> the system from live-lock conditions that can be triggered by a poorly
> behaving BPF scheduler on Intel dual socket systems.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Applying 1-2 to sched_ext/for-6.13.

Thanks.

-- 
tejun

