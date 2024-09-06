Return-Path: <linux-kernel+bounces-318069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB42E96E7F5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606311F248FE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 03:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6BF28379;
	Fri,  6 Sep 2024 03:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsYFFAlT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC1B18E0E
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 03:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725591878; cv=none; b=JOfgHokAAR4UCQIZl+eraT83qAIF9W0v+oSMmhUas7XFuqzxIFQ3fRVlSd9N6AGiTBrvPPjnp7TAVJLoGlbrn30ECujF0aenQhw1GhMtaZI5WJktjHISoLtG8tLZjx9xucy5bvBSbGYYN1gtkYXHOzM3yBGNOLaVOoW9HhJr274=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725591878; c=relaxed/simple;
	bh=vYXBEgfRmNPrT003e74yVQxsDxUlL7X0ruY8/n2rJo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JfNnfptr7rBoRJceiTVPwwLm/R8wOnfjxJ/uY5lZrhyPMi8Dv+8zMPlKlyc8ORf9iFliS5dBrf3dFEcv1T41Z1MSCynybw5+9oxrRS/vTTThIjETzcQ4Dc67NeoKKLG9+iSUB19AC3H+YnJrOH6DqMHMQ9+kBsaeZbZZmq3Fp3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsYFFAlT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93944C4CEC3;
	Fri,  6 Sep 2024 03:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725591877;
	bh=vYXBEgfRmNPrT003e74yVQxsDxUlL7X0ruY8/n2rJo0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qsYFFAlToGoW/5OgOkJuDM1UC46+GgiTTS9d4zE0C17QfRgClTh2gVEeoJ20mnK04
	 WEkpzUVOEniuWnbWn815UgIuA7r2ZwM/ekEboC5HOQattbQ21+7no3XzsHXiKo2kBm
	 xFOzCFe1Wy+9yFT9uH6VRtznE0uLKlmi0qlgorO4K9BwXh5gn5nx/saJQTzRqtfsAl
	 +oKB+Z0Hn3UylFTt37tTLoAuepqNfhvXWOFcsf1jKHXNx/gl6x2auQnlON6x6RWlis
	 Ht49joGVGWQJNhxwmXYSq1k2oTKv7wkqV0z94WWEipOdbrGvSlLQCYPoTJFkFz53SS
	 adHN6J8OAa2hg==
Message-ID: <321f7e25-6ff6-4480-adf5-432c3115b85d@kernel.org>
Date: Fri, 6 Sep 2024 11:04:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH 3/7] f2fs: add reserved_segments sysfs node
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
References: <20240829215242.3641502-1-daeho43@gmail.com>
 <20240829215242.3641502-3-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240829215242.3641502-3-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/30 5:52, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> For the fine tuning of GC behavior, add reserved_segments sysfs node.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

