Return-Path: <linux-kernel+bounces-316456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F6496CFD3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 846D3B21B3F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 06:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDBA1925A4;
	Thu,  5 Sep 2024 06:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVZUVrgr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D129A146596
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 06:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725519368; cv=none; b=ILpIuslz1bYXpNnCZHaNpEjOq4qTCP+WjqP8NgNM3MsWMLu4upvIWO9W0SYdD6CH4Uk3FNoKrfxW/hBCn9JWuiuSlVRkWzaMpKuPyqykNnUXIOUV3WZkxyuWQI1waUCmror6gU1U/VZtPr3myzSgP4qiveMGXcEVi/4o6p8sZhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725519368; c=relaxed/simple;
	bh=ce025tkK3ZwkXlnplm7T9pIM5YkyJ3Sa1dTw5Wj9Ogs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qLWatNbP/uX9AwHD4CVDkAZzjFkfkGzR2oLbJq8XQyGNrEidmCx+Uj67JO0VzzAxUiG+a6PcQEi4B/NuFzQdFvwMtyATUbUY4ZtPZBf7zYWFZY5BsaVwlul7MCWVNuCx9MHCln7A28j0GTKh/CNRPKGtoWqwferTaBqkK5RdzBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVZUVrgr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7CFC4CEC4;
	Thu,  5 Sep 2024 06:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725519368;
	bh=ce025tkK3ZwkXlnplm7T9pIM5YkyJ3Sa1dTw5Wj9Ogs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FVZUVrgrWkfbhCvUFwxsxgwYyyEPKW+w6RFmXTvNS/mdZwZun6MJkom95aAVpcpfs
	 omX1MIz+t84xMs1CTR/FmP9zAIFUyUpzRgug1qLp8JkrTvHuNVZy5CnWvX+3dcteSS
	 KozR5zxzL8mFXvhcjowt9U/C2KqaL+8/TtzQqx0TZyBonp+7ej1Z8za+3YdkN/PzS5
	 rWDkruMOlkFbMo4qvG17lKgD1zHnlg1CC6nMMcEY7yeVurtyLaIGDKIW8nTTRVrEqZ
	 uF2MB/eN8zACNyFRD2MgzBbOwSAg5I+DZtcvHuw57xi9y51Xh41o3DaIjgQCwmOCXk
	 hx5HfwJe6Z0Ew==
Message-ID: <cbd52bf3-ef9b-4b1c-9342-c1a01481ff41@kernel.org>
Date: Thu, 5 Sep 2024 14:56:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: clean up erofs_register_sysfs()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240828095232.571946-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240828095232.571946-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/28 17:52, Gao Xiang wrote:
> After commit 684b290abc77 ("erofs: add support for
> FS_IOC_GETFSSYSFSPATH"), `sb->s_sysfs_name` is now valid.
> 
> Just use it to get rid of duplicated logic.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

