Return-Path: <linux-kernel+bounces-316284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8904896CD7A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7391F2713B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03D5143C7E;
	Thu,  5 Sep 2024 03:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kDxGwEGF"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A1410E9
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 03:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725508082; cv=none; b=fOj9SpDjOR8kxJjpnpS1JmyPxQAxmQNb00pbpDijBNQbcjkdy39kH1Nv9gO+RsIk82ZjIpq8GeBO1J6oZvz1iaRQ63eKUNn2AJmJ+tcp5eu+Z1cyRLhB1HB7QhH5P3rLRyoU+EYgb381ze3wgeOAQ7w5IyRogzTVMGEOqTpVDso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725508082; c=relaxed/simple;
	bh=JyEEhSzwsXOS4ZpiCbWor7RSL9eSgGolNaYxseMXh3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9F9UoNUzOG0IcOxKwSy8Nw6v5m3ZB2PWZfVTlmgaIfgE29Y9ZBVrOUi9Z+EOYQ4JThy4Caxkok1rccvLintyuWhhgYttLILD9gDILavhc+ZwYwvTCYBO5HeyB8oPu1sNDMwaeboMKeN4Tm5blFeIlhLcYkyJVaOOC+SQS5Zpy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kDxGwEGF; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725508076; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=pFI+pahaRnG+81eE2WtVl2HkbJm0IUUxQro0GhJkgTU=;
	b=kDxGwEGFgKT1hiTFlQntB46wOdFN3pcKYUY6dmuwh5lVHGfSwnOu5blS6Xo7p3d00wMQkvjYM/SNQgLJ/uMbUN+7/n3P9Cp2/TIduym0ZQqBKoNLmjOzApqX8bJKYEUTArf6B9EHqoeTk+4VxL30TItIB117FbSvqfmvyN2JKl8=
Received: from 30.221.129.218(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEJsxlR_1725508075)
          by smtp.aliyun-inc.com;
          Thu, 05 Sep 2024 11:47:56 +0800
Message-ID: <6023d984-335b-4940-83d5-339db0b89c5b@linux.alibaba.com>
Date: Thu, 5 Sep 2024 11:47:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: simplify erofs_map_blocks_flatmode()
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
References: <20240905030339.1474396-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240905030339.1474396-1-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/9/5 11:03, Hongzhen Luo wrote:
> Get rid of redundant variables (nblocks, offset) and a dead branch
> (!tailendpacking).
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

