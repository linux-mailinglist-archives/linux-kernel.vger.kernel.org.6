Return-Path: <linux-kernel+bounces-310880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA797968267
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786331F214A7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02808185B62;
	Mon,  2 Sep 2024 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ICN8gfa2"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96651E48A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725267158; cv=none; b=C5BANI9A+K+G6bs+TTGEiOYV6VrZN8x6KrRub14B87k0CBfSCp5Aq77aAPnhTHrh7atO+PLzkuApvQutA7MAl2pY2P9c94C/O5O79OL1EN7tV/UPY0XPRhiCTavJtJUTshSz30lBi8Y7Q/0RE1TRrAleNoazIbzhg92/QdErUhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725267158; c=relaxed/simple;
	bh=jCIN0G9gY0H8FXbfgPTV9x3+iBBAaVGoYhEY8iQHYiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UOa7plWW0LkES3qE2jXIpRdL1T9C9ijpkQ3d2yO1rI/IqC7X4A+iS4A+KU248e4rtqj5UiDLPNICF4QSXV4xai/rwssIO6rxb8BgvjfuapBRc/FxhZwlUSorLAkkCLb+kLb0rXx6kpnXCTGi8IhpWEpOuzr11PCRnxcWmiy3yTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ICN8gfa2; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725267152; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=FCVpVC6gi7WatC9sJUp9nRqX9Z7VL4I3Hg9WX2Ak+JM=;
	b=ICN8gfa2R0g5WOHOj5Ht+p5Aq3spGWNkQJzpdGMi8ViEj9oIRSrb+yCv4SMpxoCGSH+fXP4Fh3NJZFvOSa4WGx5l21ezobZMQmSIQr8XBsydKn/Yv1rJEuNUY7w3vVSZzKGPPWjITRUnqlHYOshleNxTQVDGdR/WcYCdmJRefOY=
Received: from 30.221.132.251(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WE6HxRv_1725267151)
          by smtp.aliyun-inc.com;
          Mon, 02 Sep 2024 16:52:32 +0800
Message-ID: <5783ccbd-34cb-4f1b-8376-d795df2db4e3@linux.alibaba.com>
Date: Mon, 2 Sep 2024 16:52:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/2] erofs: use kmemdup_nul in erofs_fill_symlink
To: Yiyang Wu <toolmanp@tlmp.cc>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>
References: <20240902083147.450558-1-toolmanp@tlmp.cc>
 <20240902083147.450558-2-toolmanp@tlmp.cc>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240902083147.450558-2-toolmanp@tlmp.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/9/2 16:31, Yiyang Wu wrote:
> Remove open coding in erofs_fill_symlink.
> 
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV
> Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>

If a patch is unchanged, you have two ways to handle:
  - resend the patch with new received "Reviewed-by";
  - just send the updated [PATCH 2/2] with new version
    and `--in-reply-to=<old message id>`.

I will apply this patch first.

Thanks,
Gao Xiang

