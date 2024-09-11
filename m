Return-Path: <linux-kernel+bounces-324120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2687597481B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 04:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589F31C245EC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 02:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72C42C182;
	Wed, 11 Sep 2024 02:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHviIXG6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2314729CEB
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726020759; cv=none; b=e/UssPYIhdkMoEXQVEZ9SZMZH5UUujJubnifqdG0wPOM4infB8aCWCtPDV1Q1Hqkup51PUKvVivNxfM7GNpcyZU2jp4RQsTMdoXv5o+Sh/iR9iKV1iGlme9hpE+VnRXfLT1VvrLIQc6oMpnngr8j7MptGHegUozPtOtzk6talcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726020759; c=relaxed/simple;
	bh=CtBBddZQklo7l2lh8QWTDib+aAxIxnkJFfbW73WItUU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tcUE2lYDWCQcMxJK5uEOT0GNldj9G/XiRX9Tj00RwPg82preYkx3n/+yxm4sMOIGdvncan4p/xpHshpS4gf8X7RroTqdl0pfWikOr5WjhVEEbNPBYxttdwNvbfx4DdBeINZ7ZA+jhypOZBCfKjViiH74jtoTwOftoFOGqpEQeck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHviIXG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F689C4CEC3;
	Wed, 11 Sep 2024 02:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726020758;
	bh=CtBBddZQklo7l2lh8QWTDib+aAxIxnkJFfbW73WItUU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=FHviIXG6px3qm9J1gZchBLo5XP5DZ1s3Br8XTvg/9fIDG0kVc4OgSjG72dd4dBkn/
	 5CJzTOz9LIBAxEAtofAwEprHwWlM15ff2oFZlGRDZfdVl0F6Rj7XNCTgoWsrupH2gE
	 8UqJaJM+EhNWCjvQL8199DVL1u3LCHG2Kgegrg02Q2TvT6XChp3Iqf7UBrAhc468+z
	 RTal+IkS6T9hnDu3kMuOR/nIboywfdo9Xb2CTrwGHU5U3akT35i5lj4bFOpPeJTDvf
	 XMkMayyneLXemvfI+Pf0Zz3qrjLxoRwfmBRzoXfqVgzLptjH18mRGf67tDYtDM8LAw
	 zdnufUP6VTYGQ==
Message-ID: <92a5282f-aa06-4c4d-aa34-fe43bdd93d5b@kernel.org>
Date: Wed, 11 Sep 2024 10:12:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v2 5/7] f2fs: do FG_GC when GC boosting is
 required for zoned devices
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20240909221946.2004046-1-daeho43@gmail.com>
 <20240909221946.2004046-5-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240909221946.2004046-5-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/10 6:19, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Under low free section count, we need to use FG_GC instead of BG_GC to
> recover free sections.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

