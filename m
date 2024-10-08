Return-Path: <linux-kernel+bounces-354828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE77994314
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA81C1C24C1D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00F21D935C;
	Tue,  8 Oct 2024 08:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJcsVGUr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F1C77102
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 08:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728377470; cv=none; b=atISTSFVB3XmRRVHQvRzOVWY7XXfdRA15spHD+fdoKHqQfzWYr9lGUEWCNHWk7ko8Ro9a+Pru9LXP32PvbsVhAQBw8c6dIqDO6AOhltjVlYkzsKf82HnXR7F8fMvbCXSyHJ1kvD8yxf2dzA1WAJZCFNQ3TE9+U3dJuUy69XpOvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728377470; c=relaxed/simple;
	bh=he3le1eo9eH858qD8mSCjlDMejkMAFfzM9LFSwbMvQM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=r6/sMm8iIyDsRC47z9IEd1SrDQ3u/HyiOaszly8syQRxqJ2rPfyjFv8jFME3tyhiIm714wwj6ll7pP4kaMPQ/QfDZMxy820+UDH/vCvOavUYGnVyIY7mOmAmGUtmmkfAK4fR6wmMmS7GkJ4lorVUG5VUAMVsu3sqsUAvfxhDsjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJcsVGUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7366C4CECC;
	Tue,  8 Oct 2024 08:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728377469;
	bh=he3le1eo9eH858qD8mSCjlDMejkMAFfzM9LFSwbMvQM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=gJcsVGUraCGcbgnLbpApeIpTZN2SoMyoJFCKEgI8OqameUT+7swXIv3CAKiP14eq0
	 /vzLuyHz0kHrCGONYGJkBzToLugYBQfmjBUeX3r29JR3n5SZwwjda1kKcZCeu8ZYMt
	 zSrrk1Wasrp06ZLatCO2k3O49ARbsuAB7GdFvfxjr+GUC/1ScO5pAPkEl2KvBrHGzn
	 GI/oMhp2CmiaT7+VBLYnPK43dCrDWr+zrGNVHXdnqv2IjxSTykk4Z1PydW4qQbxDPN
	 39YYbA+3lUvBXt5NxA2HbZ7x5alT+hSfspGww2nBEYngF7dNKgzLqEJj5nwe1TgQlE
	 JxUY0cXyTDgLg==
Message-ID: <2fee27e0-e681-4f4c-829a-d6e49472e457@kernel.org>
Date: Tue, 8 Oct 2024 16:51:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] f2fs: Use struct_size() to improve
 f2fs_acl_clone()
To: Thorsten Blum <thorsten.blum@linux.dev>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20241007114638.1337-1-thorsten.blum@linux.dev>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241007114638.1337-1-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/7 19:46, Thorsten Blum wrote:
> Use struct_size() to calculate the number of bytes to allocate for a
> cloned acl.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

