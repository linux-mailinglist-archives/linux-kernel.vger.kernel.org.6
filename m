Return-Path: <linux-kernel+bounces-218833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE12290C6D5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A271F2273F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED3E144D02;
	Tue, 18 Jun 2024 08:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zsog6wNK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A2218E1D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718698147; cv=none; b=fhUpxB6cu7lMKMXhuXChecQVKjx7uc3Rw2yYYp4PdLHpNAseMyst3MlIO8OZB6sWrVkUZyVPkt0k/Vn/PdrPrFnnbz645ortzis0IAjLkGhujAjQE1dUOrgl+iKssQSjduoawzydrC4nKRzOme48UNlrBWylJsl1jwfirWSyeCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718698147; c=relaxed/simple;
	bh=Me7HXSrT1mn4Xb+2uvfuq5JsAE1wR88izfxdR2nfLAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STfSUndol8iRYONxmcvD1Gs+1D2bNjwc93t2sr0yk/FMDLyJ09QrTztoC4ka1wH5dW0CvQL/GCOf/qjlJCW6if5Pwss2IH8z48aWJn07FplbhkRW5TOlCMleldpSZ1AU7brDbsfOpzB5tUL2O9Xrv43viXuY+/9Tph4s2+La/DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zsog6wNK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02A7C3277B;
	Tue, 18 Jun 2024 08:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718698147;
	bh=Me7HXSrT1mn4Xb+2uvfuq5JsAE1wR88izfxdR2nfLAU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zsog6wNK++pvGuCZs5pQcEaKfoZrI5hH9igp1UKcQJQ59eLAzkjNc190BJ0FkrZCa
	 eH2YmVUXVBYNYkdS6qc4kxTY+d0oqp51+fSerEF1nUVZGNj+q0z9+nLAXOel09dZ+1
	 yDD1AZznRCvC4zvHh71GZJZXxhGC2jrwjloyUvEIdpTP+DaRnz+rE3+KvP5h4EGlGe
	 I+U2qIEhahwS8Z+QL9HtIC+RxGAwnl6PO2XMB57sWRnm+G/NGW1osK0+NI5S4Jp4FU
	 0N4rfQEGRb+ExiZ4ULOE4Yx8LdilLozCEaYdNhpJWqlBfe84Vj8FPt672BKS6OvwBO
	 9rryqEngWtOwQ==
Message-ID: <a657cf9c-e8f6-4eae-874e-e6f2f734e390@kernel.org>
Date: Tue, 18 Jun 2024 16:09:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs-tools: fix do_set_verity ioctl fail issue
To: Xiuhong Wang <xiuhong.wang@unisoc.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: niuzhiguo84@gmail.com, ke.wang@unisoc.com, xiuhong.wang.cn@gmail.com,
 hao_hao.wang@unisoc.com
References: <20240617071114.150721-1-xiuhong.wang@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240617071114.150721-1-xiuhong.wang@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/17 15:11, Xiuhong Wang wrote:
> When using the f2fs_io tool to set_verity, it will fail as follows:
> unisc:/data # ./f2fs_io set_verity file
> FS_IOC_ENABLE_VERITY: Inappropriate ioctl for device
> this is because commit: 95ae251fe828 ("f2fs: add fs-verity support"),
> the passed parameters do not match the latest kernel version.
> 
> After patch:
> unisoc:/data # ./f2fs_io set_verity file
> Set fsverity bit to file
> unisoc:/data # ./f2fs_io getflags file
> get a flag on file ret=0, flags=verity
> 
> Fixes: 95ae251fe828 ("f2fs: add fs-verity support")
> Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

