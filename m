Return-Path: <linux-kernel+bounces-577646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82820A71FDE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 21:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4129D1899F18
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C99253B6A;
	Wed, 26 Mar 2025 20:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ns8FWBDc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CF21CD1F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 20:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743019714; cv=none; b=X+Gqk1fgOYRYv3HNzts3YwiPTYmfcC0GD8AGlq0xnFhXDLsEzCaYDtWZNk5A2gYoZoT8IJejED8RxM7jsIEjWP+lixHuzZYN36UO4w3qfDCP1s7qNgmGERNVHzOkj7FJrdnm6vLAeYtkCWsRkN3iL8WhP2l8nrpnVZAdHrD/Zos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743019714; c=relaxed/simple;
	bh=GOZ95M/rtic8uwPknse+pGIHEThrgderm17yg53D1aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5FgT2d0U6k69Z+2wkbTsfg3CgcjatIeiY4AA+KbfsUo6dvvqlMRuqgRBBbnIKGmL7codiBFdGsAExerO1HbdRK7H6wyzwueftx0XOmJG+ktVDwX0kISo2DwIHMfKHKTolYZAogyx+0pRlEG5CmRR3+qBT1aw8f2xvoGcZBlLsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ns8FWBDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D40C4CEE2;
	Wed, 26 Mar 2025 20:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743019714;
	bh=GOZ95M/rtic8uwPknse+pGIHEThrgderm17yg53D1aM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ns8FWBDcuCzqYMeyOd1ueadQlO4xoe2/zw4gP85fE/wmZxyHIlYLfKXWEKgetwchm
	 4zXsgqWbnH/gSW1jAk39Owoqn8/zVKiearuO4yaGvuCJ2LQ4epzOWtkQ6+0CPp1ZB3
	 sdfHdzicqBdLgTvnf5fVhaaF+3cC3LQc3P31iU7NG7SIVHwsa2pKpfQNDmb9Po0RIx
	 WLG/UoNf7vuy5c4mjUV30VxDQVwrl95wgbQZKCTf6w4gHacPfrrE8dBIB9OM2lB8v0
	 5C0JcKBqS3BMZz9wtTRBhLZGecz1YoBPftT/o/AvNANnvh7QEm8vx33O8qETOzmxDi
	 v2zxXvSzH7MoQ==
Date: Wed, 26 Mar 2025 10:08:32 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: idle: Fix return code of scx_select_cpu_dfl()
Message-ID: <Z-RewKQ9icwdw6iQ@slm.duckdns.org>
References: <20250326191849.195303-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326191849.195303-1-arighi@nvidia.com>

On Wed, Mar 26, 2025 at 08:18:49PM +0100, Andrea Righi wrote:
> Return -EBUSY when using %SCX_PICK_IDLE_CORE with scx_select_cpu_dfl()
> if a fully idle SMT core cannot be found, instead of falling back to
> @prev_cpu, which is not a fully idle SMT core in this case.
> 
> Fixes: c414c2171cd9e ("sched_ext: idle: Honor idle flags in the built-in idle selection policy")
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Applied to sched_ext/for-6.15-fixes.

Thanks.

-- 
tejun

