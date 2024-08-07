Return-Path: <linux-kernel+bounces-277165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C849C949D66
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71DDB1F24326
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B899615B98F;
	Wed,  7 Aug 2024 01:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="k504e3Tt"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CD2846D
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 01:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722994680; cv=none; b=dz7C2maO95pojsMFba0pwIi2NXsyVGFRHtxwpYJLI0IjSYogUk8hM8Q4HPP7noU+TzbJviaU/V/BHamQmaj0XHuvWeRKjSEnidFj+azpB/EpLYqooSJ/9eIXCNL+6DHNCi0AEQ2EaTLwDesTTJ5t8V643F5Dkq7fMXyTNMW4HGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722994680; c=relaxed/simple;
	bh=f+wbAlcsz+fgbGXYQH6NBjS6cOiYBxo+yVEZKffMzKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V9XYAFG9JRjk0yTYT5migYvAvS0L/sOSDl11YY1CZhyiUNmHciiuLhbRUZh1tz4Q0dwG/wu9fNVvuktSj3BTjbhHl2eHHPv/MoNzcKx98P/Vjy7Lo4kjjD3CAJgL2tSAIelfYc0PRFc4U374JakS9hWXOmEF38CMYk40IpsK/qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=k504e3Tt; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722994669; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DVTKbBlGO3zKZupQ2GT0OmYufQRMq9hAP1eYVSXKziE=;
	b=k504e3TtNJu5E/voOZbTGeSBKhv6VBpZy0dPacSgACSpba3O+JT74F5dhqn5DCPKw0Yyg2h36xU3IGh96sqQ00MdxLKcKkakSL/1heKLZOp/0ofhVg4S6Whz/OIsMWum/B9gEwGZOwo86Nmodl9r+yKvIPnR4vaHyZh2kF3upBw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0WCGv2oB_1722994667;
Received: from 30.221.130.220(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WCGv2oB_1722994667)
          by smtp.aliyun-inc.com;
          Wed, 07 Aug 2024 09:37:49 +0800
Message-ID: <fdc0bba1-f225-4d94-b428-e1ca228b0158@linux.alibaba.com>
Date: Wed, 7 Aug 2024 09:37:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: get rid of check_layout_compatibility()
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
References: <20240806112208.150323-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240806112208.150323-1-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/6 19:22, Hongzhen Luo wrote:
> Simple enough to just open-code it.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

