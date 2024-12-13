Return-Path: <linux-kernel+bounces-445218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 868C39F12EF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A64164261
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B441E47DA;
	Fri, 13 Dec 2024 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SknRvrUU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2E21E491B
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108717; cv=none; b=JFQFunCTY39BTYjTmBOYEHbuhG/k8Yc1xeWNHQsQmC+7mn8Awg1Ah9BmZsbBwQO7b6Fc6l8MmtqpqIx0wI2E1SqfHwCEtgpvysdsQBDGJM24dz6HUsEjOgpJZach6DV4r+OBpUEgEdtE+ZbPr0HchVwejYtYCCiZPM0XJTyk1z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108717; c=relaxed/simple;
	bh=sZMakeCTaiaGziM4mr2CuUt7fXxdZvBiSCa18MAJOfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrINGjmk65cbq24E4mCyeGMiDBjaFqrUMbao/ys9EracL1/Ljye0gvQ8P1by5Hkpck8yL8VhdeJYq/05KcCkpI1sx0v2korsQInS6PqPIcg8LcFg4K0CsHi1UgsTEXDoPmxoDsyvXz2zO64zvYKFZE5DZOscSvd3hvb1kWlIobM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SknRvrUU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF1CC4CED0;
	Fri, 13 Dec 2024 16:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734108717;
	bh=sZMakeCTaiaGziM4mr2CuUt7fXxdZvBiSCa18MAJOfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SknRvrUU7OIhlxgHKYOEVToNKF5+9lFlD6g1wLto4G/z/pK+77PsT4DBRCCMvZ01b
	 cnVDi9VprKEkMHVlnFErWQmcp8X5SIRRHHvPEPc9EGnINrrj0wSjWzW2mT0sYTP0Qd
	 gBTl1rqzO3DaBoNXaJwYiL/s7/DkYrZ7lnND2f2TeiEs1hJxwSDbUeZwlY/EbL7Pgt
	 +VH6ACTk+Uj1NAGOowSJcjfMcrtywCXjLMkqhis+3Mb14g63p9z/7y8KCM3xvAkmU8
	 S1wDO85MU0mnc85qIWi4nv19UrHsFpWCxsTQeC/Pn4ZTzeJwXaM5d5ByyaZD1WMYtO
	 /1rQ5Qq60maVw==
Date: Fri, 13 Dec 2024 06:51:56 -1000
From: Tejun Heo <tj@kernel.org>
To: Liang Jie <buaajxlj@163.com>
Cc: void@manifault.com, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	fanggeng@lixiang.com, yangchen11@lixiang.com,
	Liang Jie <liangjie@lixiang.com>
Subject: Re: [PATCH] sched_ext: Use sizeof_field for key_len in
 dsq_hash_params
Message-ID: <Z1xmLMuaP8BcIEtJ@slm.duckdns.org>
References: <20241213095254.1577635-1-buaajxlj@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213095254.1577635-1-buaajxlj@163.com>

On Fri, Dec 13, 2024 at 05:52:54PM +0800, Liang Jie wrote:
> From: Liang Jie <liangjie@lixiang.com>
> 
> Update the `dsq_hash_params` initialization to use `sizeof_field`
> for the `key_len` field instead of a hardcoded value.
> 
> This improves code readability and ensures the key length dynamically
> matches the size of the `id` field in the `scx_dispatch_q` structure.
> 
> Signed-off-by: Liang Jie <liangjie@lixiang.com>

Applied to sched_ext/for-6.14.

Thanks.

-- 
tejun

