Return-Path: <linux-kernel+bounces-245573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF3992B480
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F42281C91
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC03B15575E;
	Tue,  9 Jul 2024 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXFMrbQM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C50826AC9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 09:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720518933; cv=none; b=qVloc8TFwdWZXfFLWqjunBlqYZTblSwN8sCMZdH3+lNDx2HJ8u/lF9oMd8KwocvESHDH4g4v3LAv3SBtJsS1/GmYs/FSWt36I7hx3FTBmzOof1QwjQv2KcZXAaNPJo5Ma6Do9Lspb1LLTAY9dBW515itkiZrCcgsDThP/dBemWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720518933; c=relaxed/simple;
	bh=6zFI12ZFHNI1k59l/Qxr6MAqcx8KpDTNzZoQ3DvA3L8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jUcWsQ+IO1XMKLhQ8dG2nLMF83VqAOFe5mLDu6HybzA7HqOMfFbDGqWgnxC3PwrtOIgfJy9/Xt3c5R97xD5r+a/zMLcJLNpH19zgcnyne9GVgPeKc7m2pdgvNaGLBfIetXN2Fk/OV2z/XDMB6wLeCaI8Rxt/4tpEwF6dXTR5J3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXFMrbQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374A5C3277B;
	Tue,  9 Jul 2024 09:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720518932;
	bh=6zFI12ZFHNI1k59l/Qxr6MAqcx8KpDTNzZoQ3DvA3L8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HXFMrbQMvn2pTvzhMP7+ADsx8/Fzk2aQeI51nHWF47ZVqQ86Qsd1aodMuIrx6ipI8
	 JZJjgE4V5JNM5C1b34TxnzKT9MviAMYZcosINDU5R57OX2cAx/eCxKpbjTeNeXvIbO
	 36L01RG1jZ8bvqjvwoMy4/e+D0LnaTX3P1QKVS96X86uJWJXaFTN7gva/3NoiJOiLp
	 4x8uBa8ThtxtZpsuWFrFiwf1id025GQe3tGAqgNv27k4Ha+qpbsXemqxNR/UWCCRpl
	 pR0lK5Ty4u9jeAZLvwR5z2UEqG5Wj7fhjk9m4U0Zk7vJvGRGGwOkNsN5iOBdgZjEi+
	 QZNJcClechumQ==
Message-ID: <37db0df5-c39c-4ddf-a0e2-207ad95857a5@kernel.org>
Date: Tue, 9 Jul 2024 17:55:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: reduce expensive checkpoint trigger
 frequency
To: wangzijie <wangzijie1@honor.com>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, zhiguo.niu@unisoc.com, bintian.wang@honor.com
References: <20240626014727.4095350-1-chao@kernel.org>
 <20240709084026.3098260-1-wangzijie1@honor.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240709084026.3098260-1-wangzijie1@honor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/9 16:40, wangzijie wrote:
> Hi Chao,
> I think that we should call f2fs_remove_ino_entry in f2fs_evict_inode to delete
> ino_entry in CP_XATTR_DIR list.

wangzijie,

For the case:
- update parent's xattr
- flush parent's metadata to disk
- evict parent's inode
- fsync child  --- we should trigger checkpoint to persist parent's
xattr in checkpoint?


