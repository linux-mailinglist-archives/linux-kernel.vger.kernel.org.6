Return-Path: <linux-kernel+bounces-560056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12987A5FD14
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505E91712DC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38407269AE6;
	Thu, 13 Mar 2025 17:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="at5SdzpL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A00268FDB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885707; cv=none; b=GKqfJtN1kO+jVyvasE30edWUZhMJkYt5xr5GDn2x1KvjTRP0biIanHhKCg+HZ60HmKtw3coZsjZui1bjMtkDlMkxdnHFQwag5KV7ARVTnTL5dmXYMOIQhNqpGWB3EAX6Rxd/XrgNj8BaOPVTr/qp34nkC96sLYvokiI37+szuVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885707; c=relaxed/simple;
	bh=QAUHNbSDOYstTbGDXDcCiRiWP+fJLKO7uJTAdJrfDC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6BSt00fg2dE3kel+pbwGfxHFVzNaTuUPG+WbXliB+RYpb/eo1Y0fCXEJStvfJ1SO1jWz8vupAFeUxV88QuddvgjaGwyRYFk9KtHMLHKiojQuyO1Zjpu2ntUcDMi2f7OKL0fMyXhp0ApP505LAnm+BqUqCUuPWcG5J90LEJVZ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=at5SdzpL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48F6C4CEDD;
	Thu, 13 Mar 2025 17:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741885707;
	bh=QAUHNbSDOYstTbGDXDcCiRiWP+fJLKO7uJTAdJrfDC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=at5SdzpLLgv7fg5PK22Q17mPwZ1XLhLrRS/iW7iWtWkKKdFnf5Ak69l++27WkxVLb
	 pVF7CMx7yUFoUAooq/j+j/q10u6nSXWm6iecIMiyCAQrEUXoXfSvWiD7dsWppk1hlo
	 RmaRsTZbx9R9bE5VHZeUZY9oe/nbpqPQuCCtXZZs5nxtLKpmIfw5zr+XA3T6rXYhiM
	 /Zmtm/eMu6jT9A/p5gCToYAtARYDTtroSSApXbvzLvss4/fKjNT1HXByxmL9YplUr/
	 S6bMu9+9G1O+8jyORCCkppTeqfXRwN1MLZIZi9/6Vlq/9UdIQOn5AFFq2M5kw+TkuC
	 iNlMDSYXy3/Tw==
Date: Thu, 13 Mar 2025 07:08:25 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Skip per-CPU tasks in
 scx_bpf_reenqueue_local()
Message-ID: <Z9MRCY0DwYrZOpkD@slm.duckdns.org>
References: <20250313170321.99510-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313170321.99510-1-arighi@nvidia.com>

On Thu, Mar 13, 2025 at 06:03:21PM +0100, Andrea Righi wrote:
> scx_bpf_reenqueue_local() can be invoked from ops.cpu_release() to give
> tasks that are queued to the local DSQ a chance to migrate to other
> CPUs, when a CPU is taken by a higher scheduling class.
> 
> However, there is no point re-enqueuing tasks that can only run on that
> particular CPU, as they would simply be re-added to the same local DSQ
> without any benefit.
> 
> Therefore, skip per-CPU tasks in scx_bpf_reenqueue_local().
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Applied to sched_ext/for-6.15.

Thanks.

-- 
tejun

