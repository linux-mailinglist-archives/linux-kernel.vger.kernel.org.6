Return-Path: <linux-kernel+bounces-388040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F609B59A6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 02:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70999B22A84
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9508513B29F;
	Wed, 30 Oct 2024 01:51:53 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D3D13C69E
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 01:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730253113; cv=none; b=m5shRrRw9i1LJcbpUgCXaGQbAXAFSMu2X5RvbwiCd4gS8LrjXSoU5DBlBqFMArlzI3txu+NkSE3YKNpZ55b4xBQ5L3k/pcjG6wRzz2B+Li2+45BVN42tunirM+9lvodMbv+u9+ZsF5MdieEomwsvaSCDF3SKnek6TTPRQORi7u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730253113; c=relaxed/simple;
	bh=L9xR2Qk8/rGKYIwQ3/ai5YrdBem7nONHaKez3ubJN1A=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TTbqv5mktdBfDzpSYAJVXMTwUzmyWEidl+3P6skq8vwFyrt1pn6RfG3fbU+4YjT5nk0erX0aYncuJisd/jhNrxzGg55GrUrtcamEvS4CTeppijNNNOqb50OEdWVfdQmWgvYETkWnOSTueC9/9S+KTxtSXH5ktCYHUykxDMobkLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XdVRh2786z1T8fp;
	Wed, 30 Oct 2024 09:49:36 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D0D718009B;
	Wed, 30 Oct 2024 09:51:46 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 30 Oct 2024 09:51:45 +0800
Subject: Re: [PATCH] mm/memory-failure: Replace sprintf() with sysfs_emit()
To: zhangguopeng <zhangguopeng@kylinos.cn>, <linux-mm@kvack.org>
CC: <nao.horiguchi@gmail.com>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>
References: <20241029101853.37890-1-zhangguopeng@kylinos.cn>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <0df802f5-43b0-7b09-4d3c-e1520218d8d2@huawei.com>
Date: Wed, 30 Oct 2024 09:51:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241029101853.37890-1-zhangguopeng@kylinos.cn>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2024/10/29 18:18, zhangguopeng wrote:
> As Documentation/filesystems/sysfs.rst suggested, show() should only
> use sysfs_emit() or sysfs_emit_at() when formatting the value to be
> returned to user space.
> 
> Signed-off-by: zhangguopeng <zhangguopeng@kylinos.cn>

Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Thanks.
.

