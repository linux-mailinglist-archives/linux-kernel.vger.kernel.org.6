Return-Path: <linux-kernel+bounces-311000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7979683C6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27CA51C22795
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76473187332;
	Mon,  2 Sep 2024 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wrxvzcc7"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF46C77102
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725270869; cv=none; b=By1nr/r5WPbtrwq2zt/nNZVvxg09QKZAm06xGNgZ35tIkeZB0uCIKdNzT4+Sw9oL2s/Yi8lkABIZvLDyPWqB+Ndwl1LWOe+ZoLGs+2HMqwoAn4iW/bVn8M68VUOPz2ktyVORmbMQtzKHDy9iIvyp57CWR27W+fgxrAN3hQySyNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725270869; c=relaxed/simple;
	bh=aXAsDlzsqzmmGaE2lHS4tTDcgT0vwJVDwmJr/55lfvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oHrMfAO+Phg+dqMYvmfaMPKNWP7gAWeTr84H1ZqKH4xatvWwDXjOUB2CmPkRxvxxlTvNCWSueb7L/brX52guk4zgiR0cBo5ydidBKyAZJ6f+WbeiqYNN1SnXq/asuc2jOmupnBX6sLvNCQcDHsELh9qEtdTIHdQdQGaa99RRq4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wrxvzcc7; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725270864; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jiZDkhirvnlhDcFjuWk5Xh33CaRuy8xC7OmjieMbApw=;
	b=wrxvzcc7KkMh3CDKu3ObgnfRNaNrhqwOOxNqNhJuFCsDspOy81M9CKpFPWUdSuNr7M03QfG+oMF0iS6oJLTGKHZscKdvXeXdcZnybDW1lFWRFzFjl9mXkxKrmtHsXCuBv8v6MP38MOcspE/vrc5IQX4PXEiiCoM9RLtcpdbsyuk=
Received: from 30.221.132.251(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WE7.M8A_1725270863)
          by smtp.aliyun-inc.com;
          Mon, 02 Sep 2024 17:54:24 +0800
Message-ID: <94737216-af40-44b0-ab3e-e5bfdbffab5f@linux.alibaba.com>
Date: Mon, 2 Sep 2024 17:54:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] erofs: refactor read_inode calling convention
To: Yiyang Wu <toolmanp@tlmp.cc>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>
References: <ca8dea24-1ef2-46a8-bfca-72aeffa1f6e6@linux.alibaba.com>
 <20240902093412.509083-1-toolmanp@tlmp.cc>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240902093412.509083-1-toolmanp@tlmp.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/9/2 17:34, Yiyang Wu wrote:
> Refactor out the iop binding behavior out of the erofs_fill_symlink
> and move erofs_buf into the erofs_read_inode, so that erofs_fill_inode
> can only deal with inode operation bindings and can be decoupled from
> metabuf operations. This results in better calling conventions.
> 
> Note that after this patch, we do not need erofs_buf and ofs as
> parameters any more when calling erofs_read_inode as
> all the data operations are now included in itself.
> 
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV/
> Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

