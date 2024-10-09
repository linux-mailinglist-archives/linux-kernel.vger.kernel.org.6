Return-Path: <linux-kernel+bounces-356141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6A3995CF4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 03:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E1E51F241E5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 01:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AA62A1CF;
	Wed,  9 Oct 2024 01:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="W5cD4KTS"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4252E18C31
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 01:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728437411; cv=none; b=IRmCV9h3aOryZmj1g6+82sKF1lQ3zrWfe4GMyuD+8wct1bd26zJ0DWsfyQfnTzzkYH+yLH6G4jiMh1FX1+M0E1X5uRwwjnmIgi/igpW6iHIHLrLdE6OhceAbZIgFOC7kxFr8NkP5NitK5jsr8TUOdm93eYvSEYhQCjBGbY9ZY88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728437411; c=relaxed/simple;
	bh=LQvCC2Aw8Y1AyJ+AzFZ3JkaGYFqsWv4imGdBy7295to=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BZC3zSMMD7shoaGUnT0v3SNlEuZR0yWgV/F9+B5mmkEK6ovh8aVQWi+c+OK8EP8v7UWsiWWKABcSR+zGQRjXLTSS4Bqj0AlA/llvpteWNCW4bYQNAXDEBDWG805lXux+5JYfn7VFIXX2d9AoBjcehl9TMTw+fgz5jetX4rtrOJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=W5cD4KTS; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728437405; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zFLu3EkdVwFP8iOvfcDIDQG9CGsaqaGodoR5z9tQwvw=;
	b=W5cD4KTSAH9TxutlK4jvrAJKsem0/u3vX6i1gmj8o/Vhu4AoUFHrtAHufbHfAw+2hoTBJfnWiM2rx0+q1Nx/SWJtEaX17Iznqe/i1mH+XsU4V0pADGPpqv0wX1zquzK4af4trDweb0NwaAiIX62U/Fsb//shBRB89HThMMGqan4=
Received: from 30.246.161.56(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WGgrcPb_1728437404)
          by smtp.aliyun-inc.com;
          Wed, 09 Oct 2024 09:30:05 +0800
Message-ID: <09cf9871-6d6d-416d-99dc-de4bdeed9a67@linux.alibaba.com>
Date: Wed, 9 Oct 2024 09:30:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] perf/dwc_pcie: Add support for Ampere SoCs
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 Jing Zhang <renyu.zj@linux.alibaba.com>, Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241008231824.5102-1-ilkka@os.amperecomputing.com>
 <20241008231824.5102-2-ilkka@os.amperecomputing.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20241008231824.5102-2-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/10/9 07:18, Ilkka Koskinen 写道:
> Add support for Ampere SoCs by adding Ampere's vendor ID to the
> vendor list.
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>   drivers/perf/dwc_pcie_pmu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> index 4ca50f9b6dfe..3581d916d851 100644
> --- a/drivers/perf/dwc_pcie_pmu.c
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -107,6 +107,7 @@ struct dwc_pcie_vendor_id {
>   
>   static const struct dwc_pcie_vendor_id dwc_pcie_vendor_ids[] = {
>   	{.vendor_id = PCI_VENDOR_ID_ALIBABA },
> +	{.vendor_id = PCI_VENDOR_ID_AMPERE },
>   	{.vendor_id = PCI_VENDOR_ID_QCOM },
>   	{} /* terminator */
>   };

Look good to me.

Thanks.

-
Best Regard,
Shuai

