Return-Path: <linux-kernel+bounces-316766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4761896D3F6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06ED4289843
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C2A199223;
	Thu,  5 Sep 2024 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQ8MjYSN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFE71991D9
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529608; cv=none; b=lxor4IRtUVhrGfp0NqyWN805U6csI7pN0HLdVHfoheVHxUzfsr/v0oUyn8zB/40uosS5pVZqKoJUUdQc33aFiVDRbZ13+2BTqk8FxXLUj/HnL9170Lf/r0Nh3wH1ooaMnohdQmkimHpTA6/jCDvYb4XwbkSo5q58nxmvER0iXdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529608; c=relaxed/simple;
	bh=YEneNQaX0gxRmH24YN6kZK5p+5+wcuX0UjfdhlRhrPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QDy6zWoLRC6jnedvYzsmZa0OkPg+LTFVv97yNhJT3zq7+ONMRMahPszXLJ5Of0UxCcYdQp0RZK77aiUcHVFE3gTJdZlXQwCt//1Sdy+ttgy082KWpEk1rZ2eF5vUwIUmPw8rNeD8a1ugxsu6eoDlLpU5JANg143AdY4/3Acgbk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQ8MjYSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0826C4CECB;
	Thu,  5 Sep 2024 09:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725529607;
	bh=YEneNQaX0gxRmH24YN6kZK5p+5+wcuX0UjfdhlRhrPI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VQ8MjYSN23iF0GjoNHIf2lG7dxiaT/6deL90C9964Gz0ggxZKeymMpPHPfvhHgplp
	 Vr69oPsuYg9KrnOCkgm+qoD13wR3MQKcoddgA2CK4p/fK+HPJc9CC5ulkzwREayOvz
	 AhxudPRD4tNGOf/EEvyVpAqwEngP1PUh2lzrC5ev/8LVFkCa8ogzujwu5j+PbhZweZ
	 WJyRu6d2fQfSb/uKl6Yn3QZvd9fmQ9kz5xWEKXHfBzK5RAYbnPN/rZFNDcJIf7cWxE
	 H3+jY/xKvmyvOEwUAWTX6xiB8w6hvshZvCUiP8L1OrgWR1STggKTrqD5WMvP1bhMyM
	 7ucZD4bEzypBg==
Message-ID: <eed65184-aeb3-44e9-841a-3d5415e82a63@kernel.org>
Date: Thu, 5 Sep 2024 17:46:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] erofs: support compressed inodes for fileio
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
 <20240830032840.3783206-3-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240830032840.3783206-3-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/30 11:28, Gao Xiang wrote:
> Use pseudo bios just like the previous fscache approach since
> merged bio_vecs can be filled properly with unique interfaces.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

