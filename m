Return-Path: <linux-kernel+bounces-258380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1184093873F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 03:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 514E3B20AD6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 01:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5B7846F;
	Mon, 22 Jul 2024 01:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkOOIsmv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF94D610C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 01:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721611866; cv=none; b=oVMixx1qjj2vdhgD9qulZizwjFy/fnXdHeM7hCbNJ1fFaVVJ45a9y095UEeukOvWYxH1r0oCba6qXYKEuxZPrQ5f/mhMoRBn67TgGFn3G1puaYueeU/KM5lmPo1BQ1FhMO+/5/QasQN0Ud5PA6V0uIg30Tf66vXUba6AmkdKOWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721611866; c=relaxed/simple;
	bh=Pgdfoi+plDo5Sv3bTklJaLHXbBK8ZHhX9xR+sbaiMhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lE7yluMSuc4TueUm1osv0IIeY5o54++usZX22lc2p7h9T5h0BvvomWMl4ngme/s2O9ifxwnC65mPTkkccg8VmmkLU0dj4UCj9QBkGO7BAoJStyYPfUIOfVxiRrGNzZWrfqs69JaxImtBgwhUevllTOl2dnDy5EhJCWHWnQGghtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkOOIsmv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E7AC116B1;
	Mon, 22 Jul 2024 01:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721611865;
	bh=Pgdfoi+plDo5Sv3bTklJaLHXbBK8ZHhX9xR+sbaiMhQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hkOOIsmvpuHAylM3fafNyX9Gn3LhzrBn8erzTFGQ9ZBy02HJXjLFkpkI1EUkGuBV2
	 aYBm2YapcZDduVx8+HlYNUy6jF/cZ+vpG5qveZroDz55Gidx+7llkY3ubUhYMWL2zH
	 pV7TFFM0fUNGKXmcoCJjx15/ClYikEIEVm0sHs/KaFxI28g7KHjHjbUmmtBQyewuyQ
	 3JwMMua7ECXOkI4s6LMJcsOrx2lOMFnnpyso6FnNc76/Y/YJM/zEQIgti7vHk51/dG
	 j2Kun6/jsqdtrs7heEi1nCDgdO90dKMEdOcvBt1LICZPonsz1Rb7fRvtUo0MtCXtHc
	 m74JMPb3appVw==
Message-ID: <e406930d-def7-4e10-91f6-7ff084eac7a2@kernel.org>
Date: Mon, 22 Jul 2024 09:31:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] f2fs:Add write priority option based on zone UFS
To: Liao Yuanhong <liaoyuanhong@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: bo.wu@vivo.com, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
References: <20240702062952.28859-1-liaoyuanhong@vivo.com>
 <20240715123451.7918-1-liaoyuanhong@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240715123451.7918-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/15 20:34, Liao Yuanhong wrote:
> Currently, we are using a mix of traditional UFS and zone UFS to support
> some functionalities that cannot be achieved on zone UFS alone. However,
> there are some issues with this approach. There exists a significant
> performance difference between traditional UFS and zone UFS. Under normal
> usage, we prioritize writes to zone UFS. However, in critical conditions
> (such as when the entire UFS is almost full), we cannot determine whether
> data will be written to traditional UFS or zone UFS. This can lead to
> significant performance fluctuations, which is not conducive to
> development and testing. To address this, we have added an option
> zlu_io_enable under sys with the following three modes:
> 1) zlu_io_enable == 0:Normal mode, prioritize writing to zone UFS;
> 2) zlu_io_enable == 1:Zone UFS only mode, only allow writing to zone UFS;
> 3) zlu_io_enable == 2:Traditional UFS priority mode, prioritize writing to
> traditional UFS.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> Signed-off-by: Wu Bo <bo.wu@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

