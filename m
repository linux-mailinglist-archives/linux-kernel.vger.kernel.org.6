Return-Path: <linux-kernel+bounces-326229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FCA976535
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D9752855F5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6603A193099;
	Thu, 12 Sep 2024 09:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxKbzOYe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C751E192B97
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 09:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726132140; cv=none; b=g/6AAV5Zh3qboyLF18YcIAcrI4kNNxHNSuGonf4U5lqGIBbjKXYCKYc9DIDI7xwCc6pzGjjUviXPOpP48qi8dXGDm7WxkH+kQwaZnEEr53/tGfP8YyauO7YApnK94n5FLzPYm2wglxP9ikksohUsV6evc/p6sxDkX177kdTsfEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726132140; c=relaxed/simple;
	bh=d4ks9mtR7upiaSaXYwa6WztAU/vsuQg//2VO7mzJKYA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=abQEnSy8tgDdNIK0QJsb14ksDq9Z5AYU5Ez/qqJPJxmt4C6pZ2J/wx/Sa6zcATQYIuL13PEULm1t+ZJilT7yj6UTjuTycJlaapIOE/rdZvo4HnVo92Bx9ofD+UvyBpVzLR1J/v7uDSWOVQ9KqQNlKA2lwt0Bpoh78CNfubZzTkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxKbzOYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F023C4CEC3;
	Thu, 12 Sep 2024 09:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726132140;
	bh=d4ks9mtR7upiaSaXYwa6WztAU/vsuQg//2VO7mzJKYA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=cxKbzOYemlPhxUsxRgFLiv7Zs6Xh5VAc8RTXYK1tTSP3I8UsSRXs6jEKKIMdAYtTa
	 +Lq95LF18D5hJMoc/NSkJCniAF2KFFuacM7s8zE4XtkSUV8mPeJ97K4+fQScH3mQGJ
	 XGebjkAWUaazVCIRAXZatCp63A4TPSUU6oJmUL2r7VDBcyEkmsj8+EsazUoTwn+9ox
	 kipAL3V4ny1OiDirGtM3sQXfVsmmZ4dTGOO2NGWyv80QJZgHO9Ey3UTm7CIlqQqPz3
	 CBfiaRHjwb1lCFixP2bLhtrLGqrIec7WMayAPxXa7byIoHVFf0RIp5mOE+lcox7r4z
	 nAVwuZCAk0Fdw==
Message-ID: <0600636f-ff01-4175-9de7-4a4fcf7e5669@kernel.org>
Date: Thu, 12 Sep 2024 17:08:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] erofs: reject inodes with negative i_size
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240912083538.3011860-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240912083538.3011860-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/12 16:35, Gao Xiang wrote:
> Negative i_size is never supported, although crafted images with inodes
> having negative i_size will not lead to security issues in our current
> codebase:
> 
> The following image can verify this (gzip+base64 encoded):
> 
> H4sICCmk4mYAA3Rlc3QuaW1nAGNgGAWjYBSMVPDo4dcH3jP2aTED2TwMKgxMUHHNJY/SQDQX
> LxcDIw3tZwXit44MDNpQ/n8gQJZ/vxjijosPuSyZ0DUDgQqcZoKzVYFsDShbHeh6PT29ktTi
> Eqz2g/y2pBFiLxDMh4lhs5+W4TAKRsEoGAWjYBSMglEwCkYBPQAAS2DbowAQAAA=
> 
> Mark as bad inodes for such corrupted inodes explicitly.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

