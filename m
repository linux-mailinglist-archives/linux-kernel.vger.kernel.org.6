Return-Path: <linux-kernel+bounces-182024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 841878C853F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 13:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB551F2322A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 11:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B9C3F8FF;
	Fri, 17 May 2024 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ABDLSD+f"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBBA3F8D6
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 11:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715944030; cv=none; b=Lr4Bn2vlYPH2mm8nSHm2viBuOpBK7rE5EudQxDr0YcuaSRi09jgO9nr+dtI4P7B+04dvujBFA0ZG0cp1hWd5DjbHpjmBP/Tr6ZnkR1PjOCHaGPflvIUyR3N1VIIr/RyRdsAw/mC8vzY8basFN6uDZb1IuWXGbHUUbHQ+6Oah67c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715944030; c=relaxed/simple;
	bh=+Id/aTWot8WAN+dv7EyLSqAe8cEABB1YQ4dgdgATGrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NDYCZKLf8fculbrE8Qb7TpmnHshSfiq7c53K8r2e0Mvnhka+no0tah9cOdkfaJahFM/hJq8nD9LsqxZdaZe/AqLN11BTMdhRSv61A3LEjVftT3PB7nxRstsyPi5rouM9MBLo5P6nxwJ8DzAsLSXdZcTGPsIybl9TXCYINu72EHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ABDLSD+f; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715944023; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=h1Fqr7xCikQaAhNzhVJ8gXplRgXTM7enqQ1sdmbBOxo=;
	b=ABDLSD+fhzqDngONNkcDyvbQ0bF86elw5ZBTrdpjaT2fHnwyyYccmaD5Dx73MKwUb5lQfo7/r8k2ovjg6c7tHNZ81ytVvrXCkXIn9+5bZL2CEpy18q6Iozu8Fnt9wkKTPgcOSkd5dja8eZlu1hQvx36wg9jUrPdSs8wAns5XtIg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W6eXG.u_1715944000;
Received: from 30.27.74.17(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W6eXG.u_1715944000)
          by smtp.aliyun-inc.com;
          Fri, 17 May 2024 19:07:02 +0800
Message-ID: <84c23a37-0a7b-4c56-9446-05bb7d6a3808@linux.alibaba.com>
Date: Fri, 17 May 2024 19:06:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: clean up erofs_show_options()
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc: huyue2@coolpad.com, jefflexu@linux.alibaba.com,
 linux-kernel@vger.kernel.org
References: <20240517095652.2282972-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240517095652.2282972-1-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/5/17 17:56, Hongzhen Luo wrote:
> Avoid unnecessary #ifdefs and simplify the code a bit.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

