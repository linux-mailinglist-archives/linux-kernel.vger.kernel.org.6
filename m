Return-Path: <linux-kernel+bounces-364841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F2599DA17
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63E81C211A5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 23:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550D11D5AA4;
	Mon, 14 Oct 2024 23:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mD4EBwmv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A920017BD3
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 23:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728948298; cv=none; b=nGaG8H/IzvT4IMl9RGC+DkPvlS9xj8A0BT77u9PNXhk2yOD+7sAKYabXghfLg0cn8YNMzjSa7DBWuxPRLDxTA06Q2IzXwdMUtsVqLqPdjBJ9zJp4AnfSJVKMpNDpoUGZYNrgrhYykBxZAPY8z932JTSUEk9Rag2OW9VGNxvbT4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728948298; c=relaxed/simple;
	bh=BvsN34mxfR4labYu/yAuPoZceMwdjE8ADsco8Pd2EpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4ZmSX+K7D5JdWA7ouK9nr5bMfRI8yZJPQmbUmu/hvvLufDERNSt0coqTPZ/nCBj+WwjzOzgQFKavAo0qKssM7Qe9oagPKhUhtKjTlnQ09/emTfwZZBvzTkWR8QSbqTrWp4KoMJV6l3E/AqxsZJlWYoRGY0pBNffCpAhg5ytUTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mD4EBwmv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18891C4CEC3;
	Mon, 14 Oct 2024 23:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728948298;
	bh=BvsN34mxfR4labYu/yAuPoZceMwdjE8ADsco8Pd2EpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mD4EBwmvkToPjZt5c/7DQkvkXRbO9SS/lEN2ev8M9lUafZVDNkk32EZ9jPmJV6eLI
	 1zlAsZ239HilfFa8hZtipDL/bouACKPrwNs5bpsiXfPDnHGxBk6MZbIcmB09Q+YUU9
	 fsVr4A1YCWq5g2o91P6Cs/fEBwHZRegKsnYPCSykQDO9IjLEP0nnQFMIdraIIuVGnX
	 7JwscG4zudMTx8oH0cMOhQz2YW0z66YMtX/WqfQ8e5+Vj/bq0ZNDsd+sa8tOP0/haR
	 XgY5MnMJbu9TQDxuJcOAC0piu/AfHiEAaZkIbb2CBVNTcDmE4OR05AKwftMiYZAB5S
	 tjBCQunYjxy8w==
Date: Mon, 14 Oct 2024 13:24:57 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@meta.com, kernel-team@meta.com,
	Waiman Long <llong@redhat.com>
Subject: Re: [PATCH for-6.12-fixes] sched_ext: Remove unnecessary cpu_relax()
Message-ID: <Zw2oSWEJ8LJG6454@slm.duckdns.org>
References: <20241014175830.5108-1-void@manifault.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014175830.5108-1-void@manifault.com>

On Mon, Oct 14, 2024 at 12:58:30PM -0500, David Vernet wrote:
> As described in commit b07996c7abac ("sched_ext: Don't hold
> scx_tasks_lock for too long"), we're doing a cond_resched() every 32
> calls to scx_task_iter_next() to avoid RCU and other stalls. That commit
> also added a cpu_relax() to the codepath where we drop and reacquire the
> lock, but as Waiman described in [0], cpu_relax() should only be
> necessary in busy loops to avoid pounding on a cacheline (or to allow a
> hypertwin to more fully utilize a core).
> 
> Let's remove the unnecessary cpu_relax().
> 
> [0]: https://lore.kernel.org/all/35b3889b-904a-4d26-981f-c8aa1557a7c7@redhat.com/
> 
> Cc: Waiman Long <llong@redhat.com>
> Signed-off-by: David Vernet <void@manifault.com>

Applied to sched_ext/for-6.12-fixes.

Thanks.

-- 
tejun

