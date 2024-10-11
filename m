Return-Path: <linux-kernel+bounces-360439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C8F999AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 05:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6078B215E7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 03:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA501F472C;
	Fri, 11 Oct 2024 03:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DntyGKQh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AF1EBE
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 03:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728616234; cv=none; b=AQmrn0/iMjXoxN2VXr746vVFMmrZatyGCDdX3MRexROtiVRRQyCT2ZxlqfETk7iudm/vc3pfHXdD7o/SxLeoWjYu93t/AoUUxR4MtdFSCzYL17mVncvuoqMSyUkP8dMDW4p9HDD0AZjNDXyQ543mgNWjO3rzbc6GxL2upblVJDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728616234; c=relaxed/simple;
	bh=6b25pjgk+omSednQLQU3IFag9Hwh3O+MVcY9W5utO34=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f9L7Y706YZ73cfb0//vuU2mJHBHD5jWu5H8jE9Hw3jNmTIkIXV89eHWVVnKHTyFDRSJnv5xsZy8EdLTRWVtmk1EKVR2pC1dlIUxSVdM3M9uj64g8yVbxIQYFJK2do73D/PaHy0+LZqZxYW79cN+osYuDg40yOp6Q+phvMczXzY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DntyGKQh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2100EC4CEC5;
	Fri, 11 Oct 2024 03:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728616233;
	bh=6b25pjgk+omSednQLQU3IFag9Hwh3O+MVcY9W5utO34=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=DntyGKQhWSzq52qJFSsEWzkDb1dXQ3q2VlF73pHDHIfIIiCeDKSNGBIC1uhq013Sy
	 Ncwbqg3eB+jC3lh2bV6Q6FYZMCvQg5AnPgXruk30zIsRB+bHsfE1anDw4uBfw/yQ91
	 vCZrvDSRf+/oENVvdk4vwiMJIcT3gc8TSLWGLh7Dk8L+17UW5VvuVFQ22Z9vSH9fpx
	 vQ7+u/5WMdaLZqDfaSvuvqTPshvA0v8PIrd7E2i+UxufvKglswryvBvYOlHUH6nihK
	 qs37pyjo27UWrvY0qJ0qJina+3qJgwiKORjhsSzecOv9QTGDDV9E2FKVzDmrr3ZH/Z
	 VPTpyG7fRVGtQ==
Message-ID: <27aeda6c-dd0d-4cef-b071-18499b1b3e70@kernel.org>
Date: Fri, 11 Oct 2024 11:10:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>,
 syzbot+001306cd9c92ce0df23f@syzkaller.appspotmail.com,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] erofs: ensure regular inodes for file-backed mounts
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <00000000000011bdde0622498ee3@google.com>
 <20240917130803.32418-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240917130803.32418-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/17 21:08, Gao Xiang wrote:
> Only regular inodes are allowed for file-backed mounts, not directories
> (as seen in the original syzbot case) or special inodes.
> 
> Also ensure that .read_folio() is implemented on the underlying fs
> for the primary device.
> 
> Fixes: fb176750266a ("erofs: add file-backed mount support")
> Reported-by: syzbot+001306cd9c92ce0df23f@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/r/00000000000011bdde0622498ee3@google.com
> Tested-by: syzbot+001306cd9c92ce0df23f@syzkaller.appspotmail.com
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

