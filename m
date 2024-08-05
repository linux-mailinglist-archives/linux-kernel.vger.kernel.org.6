Return-Path: <linux-kernel+bounces-274259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527109475C4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADB69B20983
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F86149009;
	Mon,  5 Aug 2024 07:10:07 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8808E146A8A
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 07:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722841806; cv=none; b=lXA8Ehv4xC6KUA65GDVGszWBGWD3Tok9eEu+1HE2/EZYo+qf2PPmbsn1D8qMsouRzfwfzpWZrr6VpEQbCur9TIWq2genDthNb3d+2k0mwuTXP95zgy3GsFNK3rLIskqNWmgr1HTvBYgDihcRC48fIQgOKsIgP6nZp6EsHnwmVmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722841806; c=relaxed/simple;
	bh=DC6uOOquHjtobA6jnJgILWXDyqvljJjDGI1+7UgadBI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZMBivwfItjtJxgMSzhbTZ1kCplmBcB9RpRpXmG+srYmyUSeHPu3jyt7J0i4s1qWIGDEqqkawGyIbynDPuEsHTsXNLjd2gz3fo+jv1dqxIZtX4u/HZYuItglpaeJng4RXS2tkZAiCwNw1NgaB8YxMB3AVy2X2qKzu4pjO2sYzEsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wcnbm3qRyzndgd;
	Mon,  5 Aug 2024 15:08:52 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D4F418009F;
	Mon,  5 Aug 2024 15:09:59 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 5 Aug 2024 15:09:58 +0800
Subject: Re: [PATCH] mm/z3fold: Add __percpu annotation to *unbuddied pointer
 in struct z3fold_pool
To: Uros Bizjak <ubizjak@gmail.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
CC: Vitaly Wool <vitaly.wool@konsulko.com>, Andrew Morton
	<akpm@linux-foundation.org>
References: <20240730123445.5875-1-ubizjak@gmail.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <607b6854-081d-7d07-b2a8-fbfb004d5723@huawei.com>
Date: Mon, 5 Aug 2024 15:09:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240730123445.5875-1-ubizjak@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2024/7/30 20:34, Uros Bizjak wrote:
> Compiling z3fold.c results in several sparse warnings:
> 
> z3fold.c:797:21: warning: incorrect type in initializer (different address spaces)
> z3fold.c:797:21:    expected void const [noderef] __percpu *__vpp_verify
> z3fold.c:797:21:    got struct list_head *
> z3fold.c:852:37: warning: incorrect type in initializer (different address spaces)
> z3fold.c:852:37:    expected void const [noderef] __percpu *__vpp_verify
> z3fold.c:852:37:    got struct list_head *
> z3fold.c:924:25: warning: incorrect type in assignment (different address spaces)
> z3fold.c:924:25:    expected struct list_head *unbuddied
> z3fold.c:924:25:    got void [noderef] __percpu *_res
> z3fold.c:930:33: warning: incorrect type in initializer (different address spaces)
> z3fold.c:930:33:    expected void const [noderef] __percpu *__vpp_verify
> z3fold.c:930:33:    got struct list_head *
> z3fold.c:949:25: warning: incorrect type in argument 1 (different address spaces)
> z3fold.c:949:25:    expected void [noderef] __percpu *__pdata
> z3fold.c:949:25:    got struct list_head *unbuddied
> z3fold.c:979:25: warning: incorrect type in argument 1 (different address spaces)
> z3fold.c:979:25:    expected void [noderef] __percpu *__pdata
> z3fold.c:979:25:    got struct list_head *unbuddied
> 
> Add __percpu annotation to *unbuddied pointer to fix these warnings.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Vitaly Wool <vitaly.wool@konsulko.com>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Thanks.
.

