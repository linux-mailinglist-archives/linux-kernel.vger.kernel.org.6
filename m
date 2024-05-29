Return-Path: <linux-kernel+bounces-193545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D742F8D2D96
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D8A31F24F59
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 06:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52A51607AA;
	Wed, 29 May 2024 06:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2kMBwfF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B68273DC
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 06:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716965303; cv=none; b=fVRm6wlex97fSE5Y4TzozHV6Mk9qY8Kqq3M3BO7f80WTKl1oiEAnw3co12GEZ1HSoTUUXi+AhMbXtNEfFPZDJTRzL1XhVT0IoYwg61dPgSmcrQX+GtTLMe3K3lO8mSrotKlGD1xOU02VFJruAUbsoq5BUzFTY7M6e9BZ7OTq8YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716965303; c=relaxed/simple;
	bh=LT37b7htbeGcJpL05GnAj6ZWtS5APGOieNQzOw+t71M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ETQPWf/ZqA/JvMuAMirMICeDrEpu28ODXeqo28N042s6RzozS4pzSy2wbRlfL3ARtnvnRU/sGY/ZVHFPtd7gzSv8tj9SMXRJSR9Z4GcQkZGSkvWoCJNjwG1A5osaYUS/2z2aXmIK509xNZMiZEPdr7UhjdyzRcEouCfcJ63W3dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2kMBwfF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056E3C32781;
	Wed, 29 May 2024 06:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716965302;
	bh=LT37b7htbeGcJpL05GnAj6ZWtS5APGOieNQzOw+t71M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q2kMBwfFJwD8J04rF88WnQYTzdU815ETS8wfQQpL8tE7cP0tl0dI764MLu+TJn3jh
	 9zxOOpKl5Zvf5Xl42HuezUGHLGKaMkjShEpMz6ePYTN3kuEOGZ9JoK74MwKJMLDHrB
	 yzHJJbw4LxHOWh4c8JjUrRh+uO1ZztY8qOcKsOWE4LemaMtzZxQmC8FqMCaViJ1fcI
	 zz7w3bJs5x0a47ZsTERFpHEfBWgbdnXDTOQmS/iX+LaicDtNoxWGVhHIARuOCwPxJC
	 m7zWAARV8o4EK2wIqyESTY+d+p/e3C7Ze4mJv+ji5/QVfFqdKv7XHoOH+g1NhDfPRP
	 +SDXrQLqUs4TQ==
Message-ID: <4ffa785f-3fb6-4289-8a7f-1b7c586aba0e@kernel.org>
Date: Wed, 29 May 2024 14:48:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: fix to remove redundant SBI_NEED_FSCK flag set
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com
References: <1716808357-7161-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1716808357-7161-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/27 19:12, Zhiguo Niu wrote:
> Subsequent f2fs_stop_checkpoint will set cp_err, so this
> SBI_NEED_FSCK flag set action is invalid.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

