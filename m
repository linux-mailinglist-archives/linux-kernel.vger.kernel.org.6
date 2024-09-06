Return-Path: <linux-kernel+bounces-318097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8AC96E84F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EBC02866B3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 03:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D8638DE9;
	Fri,  6 Sep 2024 03:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gr3CC3qi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BAA1E521
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 03:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725593832; cv=none; b=OEDAOArmo7enAmQjesP5aGQ8ocQtG5Vbps1cG/EkojOH+zsIQRESSgANZ2tee0n/kiIjp3Cl9/f5oTHjeuquBaZnR4MjqyvysYuau46Vx4gYKR/EBsalQlIAEzcPIht7hWPVfCmPydxSppRcUQccpQLI5NrGhL9cwMu/dDpyLco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725593832; c=relaxed/simple;
	bh=YVvENx5aaiAOK9H4ZpnX6vvObtIp41pjxWyGqQWNolw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZVCfUBBU6ydLTU1rt6h8z8GcopQPW5N1BUildbKVUPXOY79SbPwOt9i03tLhZcQ+75+MarmL3zXPenqOE1zEId3TQ0fjksWbFs/7k7vFLYaU3VUj9+M3KHXFAeF4Dg2iv5nW2JNhcfq31lqY06Kvcc3dgKbkgAb/lCk04mLjPkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gr3CC3qi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1E0C4CEC3;
	Fri,  6 Sep 2024 03:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725593832;
	bh=YVvENx5aaiAOK9H4ZpnX6vvObtIp41pjxWyGqQWNolw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gr3CC3qi9+fpPZ74NnEIEnRSAeD6b1LdeIXsDBhTv5zvTks7S1lrz1XFXqwyvRlRJ
	 EbyB5oYlZCpxgiHSenMQ0Y8vQW2lIWVMQlkOyRQhn5XXeK/dglT5LLJPwQ2kMcpc3q
	 KfPkJBH62o26JEWJfU6GNPcUBg36eaaJei9vmNhndxuNjtOvpb0mQkNjHJTaeL4Bba
	 CKtGwwnb9Y1l7L4XokXWRKgdgSItxRd1SDg2YEHwHWSd8vcQT40Ni/kCb30le5UrFC
	 cdKguSOaxxxP71dkFYSy5ijv/d1dJNfZAGuRSurNdNc8qTAIv1WE1AafDMHVsPx1eM
	 8sMoGxoXkiXDA==
Message-ID: <61f40fb5-13e0-4866-809b-d7bfd73a6ee9@kernel.org>
Date: Fri, 6 Sep 2024 11:37:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH 4/7] f2fs: increase BG GC migration granularity
 when boosted for zoned devices
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
References: <20240829215242.3641502-1-daeho43@gmail.com>
 <20240829215242.3641502-4-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240829215242.3641502-4-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/30 5:52, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Need bigger BG GC migration granularity when free section is running
> low.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

