Return-Path: <linux-kernel+bounces-517285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24427A37ED6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B028416D7DF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580432153EE;
	Mon, 17 Feb 2025 09:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="brq9/EQ4"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BDB1B0421
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 09:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739785214; cv=none; b=LwebXIWVogHeypKCXrsQO2rpbRjbPRwUVGLMC5hQsjQB22ATI26p4cHB42gmP2n9ZrqXFv6vs5g9GXg0b/ZgrAIl4KUqQJv7F5zuAqmVUbMkUVb/Ef7ynPEG0mdbp4ryU25iDuGT47yXt4kTBs3Ml+0vojyAWjyp47Nxi91AD0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739785214; c=relaxed/simple;
	bh=Itovs/IMHjTcRSZLaUZrqEiSC0uWKFKb36T2PqOPgC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A9XiAtd4hwNk95Zv88JGWY7YKuy8quaIyFtNcvIvUKN+qeE7h8TNKJ0XvvSlN4ya7eJDfNpJ6aisWi/72yPZNVc8JqnEBhgaH+lOEkJQsUXa8ca5OkxWSYVI4nkPlFbbB+kKGtJVgquBXBKnPKOiQnJZKopAV/X6Tmq2FBkUI7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=brq9/EQ4; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739785208; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=87ftoKEGoH60vQ0eFrijNwZZZFS9ia8YwyKFg83RPJE=;
	b=brq9/EQ49PNLZTWicJXH9COAZqxwHFTurDvfFo58cT6qZPcbnieyPRzpKhUMmZl9qXuS+szcbnvb0V7RygH+ZjMtJKSorxhBxXpkY/bDnVrQgUwRJKKcDWyg8P25yZPVM+KbLIWvCxyuJADCRKVXpjigNsXElO+vLzvC6JW0udU=
Received: from 30.74.130.36(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WPdVKol_1739785207 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Feb 2025 17:40:08 +0800
Message-ID: <b43f712b-8f22-4454-ac86-1347016e9f52@linux.alibaba.com>
Date: Mon, 17 Feb 2025 17:40:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] erofs: get rid of erofs_kmap_type
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250217093141.2659-1-liubo03@inspur.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250217093141.2659-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/2/17 17:31, Bo Liu wrote:
> Since EROFS_KMAP_ATOMIC is no longer valid, get rid of erofs_kmap_type too.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>

The subject should be `[PATCH v2]`, but no need to resend one.

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

