Return-Path: <linux-kernel+bounces-324119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 528DC97481A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 04:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8303A1C2540C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 02:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8E029CE6;
	Wed, 11 Sep 2024 02:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bb6Zsm5O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C29425745
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726020741; cv=none; b=gv7hHCwNU5LUzYOUd13iS44q7l3Q54BotwCG/8sl9JHtbanfIjiZNrcFIVxHsLsyv4AqBp9nQTj7RZ0eqHO6tQQIqd2uxfmKHDoO/VXYW4jpENnXB+Zpag9ys5UKXeCbljBZfJMrQTbz0/3HpBx7eAaS2P/rP4s1/X/MmTH11tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726020741; c=relaxed/simple;
	bh=LWsEjwaiPxkwFQ8eWGD/xC9gv87fzsLoBKo3pGlhlW0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Traqah3yYpPNRrA9OTVKKCVVRXx3+3tv36n4Gj+aVXr55sRr1cPmIcQIT0VYZYFfvRR9MV9qpyWQjIasgiIQ9fNBOjSHKmJD5QiSDGiX+0K8hUMKEZoAUyJRCWL19sUjdeIBTGINnmyDQsIL2Voxrmt/vJYyoEw/Zz1R7Qr1t18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bb6Zsm5O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D334C4CEC3;
	Wed, 11 Sep 2024 02:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726020740;
	bh=LWsEjwaiPxkwFQ8eWGD/xC9gv87fzsLoBKo3pGlhlW0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=bb6Zsm5OiQY9UHDz+tVXaxD/TWPeAQdJk2UuaQ11anAaRngLckFJOn1OW2NaXKY42
	 qH4sSDiT1GK4toPHFA5lqYl+cSIt8YXDE5MSegJMOE3YQd+Y9wkCW91Xl7xLEVDkio
	 H2U44WWgD4Z9BGXB3oaNL0ygW8qK2MguCzZSMHDX1dOEgLEEHMa/k43iJePGbyljWP
	 kzI5kJy55nBGp0iUJqqO5mCDbn5A/eE2WyJqQSuG80wYxgXig/gYXu1zW5gBB1e/83
	 c/k3soc0qyRn9QMzR1LWGQPAyvRBOHvBMxPikHOuruLTh1FltaF7YJJ0tBZvlHBv34
	 i7wJKVB9dejJQ==
Message-ID: <14cfeb5f-3fa4-44b1-85f7-2eca124a882c@kernel.org>
Date: Wed, 11 Sep 2024 10:12:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v2 4/7] f2fs: increase BG GC migration window
 granularity when boosted for zoned devices
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20240909221946.2004046-1-daeho43@gmail.com>
 <20240909221946.2004046-4-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240909221946.2004046-4-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/10 6:19, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Need bigger BG GC migration window granularity when free section is
> running low.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

