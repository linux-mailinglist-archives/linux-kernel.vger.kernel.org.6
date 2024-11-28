Return-Path: <linux-kernel+bounces-424265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B9C9DB24E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 05:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D52F2822FD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 04:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F358713B792;
	Thu, 28 Nov 2024 04:58:59 +0000 (UTC)
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21581386BF
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 04:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732769939; cv=none; b=e2OBY0HaYnTVu/GxiauWH/QZlmvlxMgQqMIlD8E2K8SGMjt3svMswhY17Wyurk9kOmq1JzuXNjS4ng+PcOZ4u6U4yQsu6GwahPjomlJyULTjoRhr0xOVRs/QkSRTI8PCISZx6x3SYR407BBR2r2VKMIN6iSfnAn/tZkG60pL6PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732769939; c=relaxed/simple;
	bh=Ryv4w/6G7uoxku/s5JSSG7XQcBb9trOUiZQ+gLpW6sA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dhAkZF+xRMseRJl5lE9lTR6N53sjly0jIxrF/zU9rnjEIZUYAzqp2DqrjT/YsbaJxdfis8Teo4ZvkG0Ga/v2OrVUR5llbqS7U2W0U8EsCPoqCEEkZdb+0FagUA5ZfX3SPixu2/0drUKGeNVfN8iOjf3lEyWB3sy89aC5CMWI6MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 9B9122055FA0;
	Thu, 28 Nov 2024 13:52:26 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-6) with ESMTPS id 4AS4qPVY207012
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 13:52:26 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-6) with ESMTPS id 4AS4qPjJ1192305
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 13:52:25 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 4AS4qO5t1192304;
	Thu, 28 Nov 2024 13:52:24 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Wang Jianjian <wangjianjian3@huawei.com>, <linux-kernel@vger.kernel.org>,
        <wangjianjian0@foxmail.com>
Subject: Re: [PATCH] fat: use nls_tolower simplify code
In-Reply-To: <20241128031234.3668274-1-wangjianjian3@huawei.com> (Wang
	Jianjian's message of "Thu, 28 Nov 2024 11:12:34 +0800")
References: <20241128031234.3668274-1-wangjianjian3@huawei.com>
Date: Thu, 28 Nov 2024 13:52:24 +0900
Message-ID: <87plmg9czb.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Wang Jianjian <wangjianjian3@huawei.com> writes:

> Signed-off-by: Wang Jianjian <wangjianjian3@huawei.com>

Looks good. Thanks.

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

> ---
>  fs/fat/dir.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/fs/fat/dir.c b/fs/fat/dir.c
> index acbec5bdd521..88bf16204aab 100644
> --- a/fs/fat/dir.c
> +++ b/fs/fat/dir.c
> @@ -214,10 +214,7 @@ fat_short2lower_uni(struct nls_table *t, unsigned char *c,
>  		*uni = 0x003f;	/* a question mark */
>  		charlen = 1;
>  	} else if (charlen <= 1) {
> -		unsigned char nc = t->charset2lower[*c];
> -
> -		if (!nc)
> -			nc = *c;
> +		unsigned char nc = nls_tolower(t, *c);
>  
>  		charlen = t->char2uni(&nc, 1, uni);
>  		if (charlen < 0) {

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

