Return-Path: <linux-kernel+bounces-316759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E957296D3C0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86C1FB24C06
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD7C198E7A;
	Thu,  5 Sep 2024 09:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geJ9RRlf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF7A198A3D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 09:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529501; cv=none; b=U6lFjmJznW8GE5htPCEE4QIuLkO1KpBb0kWUT0s2HTC/5z5a4cEFis1UvUT0mu4e7cP/YbgNMiL0ZRYx6+YQmQQH2BgUNQmZVMJurh3nHcw3ZgFAYzD4facuJg2KbjEFjWUYD1gsh2j9b9Dce7SQG+M2TwIhvKMGAZigsNJe7Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529501; c=relaxed/simple;
	bh=S5ymXpa1KOgwMsuMGp7XboDwi0bCDu7KxdYDFH+QZ7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FXtSSjTe48s50UFKvtX/SHj+cKHSi7vsExzdN8boYFTIgqdtWrRSur+4L/3gTv5wHb1F81ffptzrdpi5Wly7+d/HS0Cjzp8x2sD4b2a/SXO7lY469mKFuN8WzP4NmzvVLzo6Nd5e7vmQix++MKa3Ygueg5oLWE+4FsPtbDvvHLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geJ9RRlf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97210C4CEC3;
	Thu,  5 Sep 2024 09:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725529501;
	bh=S5ymXpa1KOgwMsuMGp7XboDwi0bCDu7KxdYDFH+QZ7Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=geJ9RRlfKCgixR4Jx6yPhanHIgA8bBlWNti3bWbEV9jbRWoD8wQfGVR0XK5uCvvTR
	 /hvzATYq43k26bTCdtGlQUGMtlEi8PScftA901sVVMlsviSCLl/dGrf+8gTUNzzBxh
	 35jkuRdt8ypBG/X1t2DqXBtxM2+gxgBA//37VrE65ESreDk9lrUx0FD8pMy7A0kQKB
	 dktdT+AvZFO6QlIWnwaEYrf/w/ViI8ghxx7b32ntzrp/JIcalnByFppUYzl2AA6gke
	 H+bJ+fAjlF8ImHRqrIh+pf2sVdFKu6zBeuZ73/ZpsvsNEOYgO7sbMoJhIH3WmgrNZf
	 H8aB9vy2+DmKg==
Message-ID: <c73e424a-851b-4bb0-86ba-46acdd7cbe25@kernel.org>
Date: Thu, 5 Sep 2024 17:44:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] erofs: support unencoded inodes for fileio
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
 <20240905093031.2745929-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240905093031.2745929-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/5 17:30, Gao Xiang wrote:
> Since EROFS only needs to handle read requests in simple contexts,
> Just directly use vfs_iocb_iter_read() for data I/Os.
> 
> Reviewed-by: Sandeep Dhavale <dhavale@google.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

