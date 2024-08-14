Return-Path: <linux-kernel+bounces-286213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 488C3951818
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F385B1F235FC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F406619FA82;
	Wed, 14 Aug 2024 09:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtUf2Fde"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F6719F464;
	Wed, 14 Aug 2024 09:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723629486; cv=none; b=qSD7UwUinJtKyShsVmvvJa7Or7jcaru/FFkzh+Ni3idKci/49fznSL3cCLrIzSY24wzUj4thsRE8n7t00VXTkVz1TB6HXsuLrMolexCpskBwQfuBfbpLyCVJvjn9+ex7wWtewHR+yl3swBcQbxlRLqScFlvIQShfwnpUcZD+8t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723629486; c=relaxed/simple;
	bh=c1DRi6NyZ8YeV/Jy6vvGJBLjP3EAf16yRRK8oKda6ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s890KY/YfFZnUcqGteht78PILt97IPRE0Us2iaimROqBr2h1vBY4A+vU1Vf9tLdHt3bMrzq6J5KtaaQ+jOBXnpeQflCPE3+pWHURkTPh/9ZDt89z7bB/CoHKD8LXNQkmROim3f1EGeoqtgX8yz6SRpGwAkOHr9C3NayDtlo7/r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtUf2Fde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DDCC32786;
	Wed, 14 Aug 2024 09:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723629485;
	bh=c1DRi6NyZ8YeV/Jy6vvGJBLjP3EAf16yRRK8oKda6ws=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MtUf2FdeFRqOGdcCUM5bgD1AXWndhJkKX8W9H8BhmeLL+hueXS8i2+E3mrqHJUU7w
	 ho6ZgYru45RAZ+AtOlDy4Ooli8jN3XXPzoxKhXSPYpBYjD7Qfufhfq/9vgWYVQDotR
	 /WEWnN5r2F3rCZ6NDbRhf+QD9o5r4vjAbXs/YvpLD0WCuTkN2f8nhP2mGd+YmvVLiV
	 qQjIYVNvqDhV4TeRFEcbDuecL+mmyxU8ntq8DXbZ2NxF5ckZIVOl5GzJGQ05FU00D1
	 ldWLI7Np8dRpYYtrXNlN53StzC1X/pHnIULZL8JvVy6Sesc1cHLHxI7k11TCNIDEh4
	 dDcRo1LrmLMwQ==
Message-ID: <99199c2a-1dbf-439c-ad24-68ed8844e096@kernel.org>
Date: Wed, 14 Aug 2024 17:58:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: Use sysfs_emit_at() to simplify code
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <0afb817e75a84859e1a86e1a7ba2041a9b852b6e.1723117820.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <0afb817e75a84859e1a86e1a7ba2041a9b852b6e.1723117820.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/8 19:50, Christophe JAILLET wrote:
> This file already uses sysfs_emit(). So be consistent and also use
> sysfs_emit_at().
> 
> This slightly simplifies the code and makes it more readable.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

