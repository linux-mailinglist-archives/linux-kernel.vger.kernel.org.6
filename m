Return-Path: <linux-kernel+bounces-306285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 312B6963CA3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77BE1F2547F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B347116D306;
	Thu, 29 Aug 2024 07:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D0c5SZwI"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44775210EE
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724916132; cv=none; b=ID7fsPKON8GXDio3jKxoSJsKTdObN+V1WlpPdFkSTcC8LvkxvtGmZ1dw7b6fMmyRXM9HVGcBfBkUTEF/k341QfnW9kLiJfRCLtLCpVnH6ueyzgV8+UIrqCT4QLn+j5NJUZBQq29z/Ad+aXRHAn704qArW1IKfAKzN52Xk1gI0kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724916132; c=relaxed/simple;
	bh=1zBRMlPjDgBVivgHAreopNXvVKzKab2jeoxF7VBexfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g4nfJfHd2W1AOCjqPs5tQFgjFVZL/dMHIZDJbRfBxpgmjBbSr2sgm5it5NCnzc8rR/n8pjfJmG1eXp1wygetDiQngS2RlxNkZB9OLVO/IZ70HTo/bRN1HkXceEeWNSXWvJ54oUDVKg66hm4Q6ysqDN+UBIrThf4viTlZhbf1EZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D0c5SZwI; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <732c3fd3-3d04-456b-8fd7-a9fa438d21aa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724916123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1zBRMlPjDgBVivgHAreopNXvVKzKab2jeoxF7VBexfY=;
	b=D0c5SZwIWdQNc7+YnMxsvzEUvr2k836FFmLmSHquTRnDq/LhuvvyZc2N3eHo18KznHIrk6
	Y/WrUpEdegapBasxAgsf8Oxt7mtbkrLdJy14FOhkfZQboK1oCQ0SnOHrvjt44okjcpK+Qv
	eiuEie5njUjVKm0tZOOO6qnmEuBt+pU=
Date: Thu, 29 Aug 2024 15:21:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 03/14] powerpc: assert_pte_locked() use
 pte_offset_map_ro_nolock()
To: Qi Zheng <zhengqi.arch@bytedance.com>, david@redhat.com,
 hughd@google.com, willy@infradead.org, vbabka@kernel.org,
 akpm@linux-foundation.org, rppt@kernel.org, vishal.moola@gmail.com,
 peterx@redhat.com, ryan.roberts@arm.com, christophe.leroy2@cs-soprasteria.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1724310149.git.zhengqi.arch@bytedance.com>
 <89ae94f722996b4ee7ef20d44cd7f5e2f0495c47.1724310149.git.zhengqi.arch@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <89ae94f722996b4ee7ef20d44cd7f5e2f0495c47.1724310149.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/8/22 15:13, Qi Zheng wrote:
> In assert_pte_locked(), we just get the ptl and assert if it was already
> held, so convert it to using pte_offset_map_ro_nolock().
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

