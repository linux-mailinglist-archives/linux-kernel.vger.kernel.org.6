Return-Path: <linux-kernel+bounces-557448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9E4A5D907
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA3DC3A758A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 09:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D94E238D31;
	Wed, 12 Mar 2025 09:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MkKNTYoF"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C883B238D53
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741770863; cv=none; b=iX9Pj8vVnTplKxnz0c2BsbEHwxVuVC1HE4BGaED0CLgKrAXKOlrx6nOghwlj+lWNchJyz7C4FDhpd3WTtSRpV0YLz5X1jToXkef2JEuKxNWDb/gqW/3vaBTalUOGKvLYApy7sW4XTTuXiStQZF7i/fvaqUgMMLirP9AK+ODt4qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741770863; c=relaxed/simple;
	bh=te+At9Lat2lla0qN32QWrOQCD1NQjHRc0Z4y5LAxu80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDceuwbiNBkwSM5xeaGaGVqAMPtMmELvJcK8bwH4ROdfznqye5/4UjqScEXJaV/EM6vYNG60p2wGmHY+UTpYYIhPUAWDanR84d1PJgr5QR4BZUsw88wXGbHwq9Qc4DqVEljk1fhZQ2nUxYs/xG7Eoygr6xHZGdfLS/o/IDa944Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MkKNTYoF; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3598640E0217;
	Wed, 12 Mar 2025 09:14:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id H1Xw5XrbJRib; Wed, 12 Mar 2025 09:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741770849; bh=iuZPpMPi93c9LpNUBLSzVQmBdj/437vgMpjRdqiXcFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MkKNTYoFgSDY7MK1nJbWVhdWSbz8dfZT16gHfepHa1fndep+Rw0Gn06LPqQqY1emS
	 WoVSHdVfe8LTimgc6B+nHpgXFY8vnNtrmeHfJgod4AsKKfzLI/1xN91KQSkOcBOUHQ
	 BBph4kvhzHey4MZnZ/q1CQ8Ar61IM0obCwzyFScqrel7IHYnuPfXkdpUc7SNc1HPfW
	 +NjliiMcf85VeBWcx21H95lhzu3K4HO44QsaBaWwW3JkEvvt1DyGQJSmNuXjek7xfJ
	 3tRaPGg5BizjBroH0A0OYBuUOw+R3gjC4/NvoAszn18AK0ZgmPfWrHuU356b8d66Sg
	 PlT8bmhSyunfY+3zc3rcDhHh/v+zVF3AncVY5DTsRpZGfC6+Mw2Lsaj9WSt/1U3L0y
	 k7NQVdoxzihz02iaFm9Ovj7gCGSozKna1HGI3fW5rI7NM1fAzDFegwNktFYZJU9MsD
	 hPcBYtXZei7OK0+o2Ym0Ttc0kQgsnaIrpM6THSGRx2dVPxF5xeYGDOUI2FB8QkY84k
	 tt8BOvoA6WYNASKW/ljK6G2iJnXavsl3UnyzAYD5ir2Hy/AZqjCRm+ZM7mCarJ1J6j
	 sPHUmV1YiZd6vSy6bAZ4xOehUEABbHvIjSGzuiCFtFhk7sMtvnXSdJT9hfZdn6qokO
	 RAXlQoCmJQYJYN5zjNXaGhHI=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 40B5A40E0219;
	Wed, 12 Mar 2025 09:13:41 +0000 (UTC)
Date: Wed, 12 Mar 2025 10:13:33 +0100
From: Borislav Petkov <bp@alien8.de>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: James Morse <james.morse@arm.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v8:for-boris 22/30] x86/resctrl: Move mbm_cfg_mask to
 struct rdt_resource
Message-ID: <20250312091333.GAZ9FQPWB0xQVlgw4b@fat_crate.local>
References: <20250311183715.16445-1-james.morse@arm.com>
 <20250311183715.16445-23-james.morse@arm.com>
 <dd428220-ac94-4410-a90e-18c69cbea619@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd428220-ac94-4410-a90e-18c69cbea619@intel.com>

On Tue, Mar 11, 2025 at 09:47:38PM -0700, Reinette Chatre wrote:
> Nit: checkpatch.pl warns about the duplicate signature for Fenghua.

My patch massaging script whacked it already.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

