Return-Path: <linux-kernel+bounces-543765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1DCA4D9B2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2913F16B36C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82D21FDE2B;
	Tue,  4 Mar 2025 10:02:46 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69341EE7AD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741082566; cv=none; b=qqtfCARvSPmXKC0vtP4g6vJSQfFjINkpo8k+uUpi3AGg0KXP7eytgAYe3v4NLqCNaArBFfO5xVcbYn+dgKzPYLehectkpcBE99fUNHZZ08OTsE+kX1VSMmLPWFqDSCNquRIix84qZ304z9bmKhwn06SxEbrfjmm8PuCClIUnhvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741082566; c=relaxed/simple;
	bh=a8iZW3dESf47nN3davu8paH2RASSbL3s6A912OEy2ZE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dr8TdCfydDvlXTTwX2L/DU96mWRtLSHoq0vE0Y12o0XpHTg1uLakKKzKdP/1Q0pFK8OFgy6Vy2Hq/6AlmRE4D2a0rKCQr1wpj4BQ/kDmyKkyARDGEJrqxMK3s+/fJydUNzues6hanznOQVhTon+xRzzMHhEZRlmbZwFG2eg9e/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z6WQQ4HF2z6D8yv;
	Tue,  4 Mar 2025 18:00:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A5DB6140A08;
	Tue,  4 Mar 2025 18:02:42 +0800 (CST)
Received: from localhost (10.96.237.92) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Mar
 2025 11:02:39 +0100
Date: Tue, 4 Mar 2025 18:02:35 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yicong Yang <yangyicong@huawei.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
	<yangyicong@hisilicon.com>, <wangyushan12@huawei.com>
Subject: Re: [PATCH 5/9] drivers/perf: hisi: Add support for HiSilicon SLLC
 v3 PMU driver
Message-ID: <20250304180235.00005eb3@huawei.com>
In-Reply-To: <20250218092000.41641-6-yangyicong@huawei.com>
References: <20250218092000.41641-1-yangyicong@huawei.com>
	<20250218092000.41641-6-yangyicong@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 18 Feb 2025 17:19:56 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Junhao He <hejunhao3@huawei.com>
> 
> SLLC v3 PMU has the following changes compared to previous version:
> a) update the register layout
> b) update the definition of SRCID_CTRL and TGTID_CTRL registers.
>    To be compatible with v2, we use maximum width (11 bits)
>    and mask the extra length for themselves.
> c) remove latency events (driver does not need to be adapted).
> 
> SLLC v3 PMU is identified with HID HISI0264.
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



