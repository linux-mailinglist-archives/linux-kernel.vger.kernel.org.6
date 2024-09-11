Return-Path: <linux-kernel+bounces-324116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD628974812
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 04:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AC35B246EE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 02:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285B52E64A;
	Wed, 11 Sep 2024 02:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S10nq36g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895B12CCAA
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726020701; cv=none; b=D6h0fG5Jfj4hc1Oy5u3NayWNQF+Ks+dqtIZGSKSF1wsf2XWUDX7PvsFko1B85rMVNHeI7HoaAMPB7CCbW6ZkG6K59sIPU+EMKNVf3ksGgfFvx+THKdgEpQ2wngcxkX/aL2ujv8TISylXEeJ2NiuKJw4aeI83Lq9nha9SVGGBlrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726020701; c=relaxed/simple;
	bh=1mJdaCMQ/y+9vZRgUVNXZFTQ16s9zRPE93MsE9D4JL8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=igYEdXhzeg1APjPKXVmxnxeAfdoOy9lCYLQ/dvtwXAFFMy9GDhTS0sD3fIAkoFz9x47+JRFNyMP/RIzTa+UGbizDOUTFGi8fU8A9vTE4d+AF4kQ4ohMKZeKnPSEHhvun7MbMLgkM4ExBZ6nvSXhKqoj7NIw9Be6l8NNqFRsbUaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S10nq36g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E37C4CEC3;
	Wed, 11 Sep 2024 02:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726020701;
	bh=1mJdaCMQ/y+9vZRgUVNXZFTQ16s9zRPE93MsE9D4JL8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=S10nq36gUFpRFz3NpLdrRMYVvlcP/anrrOBUYn3SJTrfQDFMdjUQax/lY+8fTF7NE
	 wpk0hItcbiw+qZv7WuNqwxdxK6nNARI+R4QkAimP5bEJGGLjLaSg/cCCT+bWm+B/N7
	 fBLzre7IeZyPBxBXsNqWgEwi5/loELUswEw12RQl2fy0E1ciF3nlrLaN0LWiMLp/oY
	 Pn6Cq56b0NDM3JxNb3wxVSg8z4G79fRyf5UNbo+W2cz7ucFbQDpwHlIjkaplFiIPHx
	 TyEAYOLpwxWC69D9QVQ674aF8H2EhmcQDvRogVRhgqFyxAAabhMZ8XYKosvXBrFvJF
	 4LWJpuYDdVA5g==
Message-ID: <31db09a9-cd34-431b-8e16-31b06785430a@kernel.org>
Date: Wed, 11 Sep 2024 10:11:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v2 2/7] f2fs: introduce
 migration_window_granularity
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20240909221946.2004046-1-daeho43@gmail.com>
 <20240909221946.2004046-2-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240909221946.2004046-2-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/10 6:19, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We can control the scanning window granularity for GC migration. For
> more frequent scanning and GC on zoned devices, we need a fine grained
> control knob for it.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

