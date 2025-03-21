Return-Path: <linux-kernel+bounces-571136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D45A2A6B9A6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2655D188DDC0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC40F221DB5;
	Fri, 21 Mar 2025 11:14:26 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E156221578
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742555666; cv=none; b=qHxfCzD2rSxmRtskQaJLtPY4Acsjs+rcZ1CupHv0G3Z0THg1l6hIFXH5ojQw7oKzRP3LmCHskAaK+UTpgMqfKfADBnpONHeH973LP8dpinnJLBFyPqKLdTVlUYegOjRIVIHV8IYSlro400pLPEyXhRJXqULJj6IEaqds1OkShC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742555666; c=relaxed/simple;
	bh=gGVeuBAXsKb4g8YbohrfDvQUVmmozNKYR4xjmnWSsCg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nYupH3gdZdwM1Ozj/P0RDlmZy/XYGr4/oMP3lFPv6n/jE2lWhG4z28p/DUmBKkya2ucSRfsc5HTuo5h2oynszNbySw/EfqKlY3EKk081/nKyBCGNUou1R6SsA5PMdWnkllbZbbq7ab9nt3SRlFfXkwTlsm76Q7PtMbKBczM0iho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZK09w4mnlz6839B;
	Fri, 21 Mar 2025 19:11:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C1E01406AC;
	Fri, 21 Mar 2025 19:14:22 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Mar
 2025 12:14:21 +0100
Date: Fri, 21 Mar 2025 11:14:20 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yicong Yang <yangyicong@huawei.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<hejunhao3@huawei.com>, <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
	<yangyicong@hisilicon.com>, <wangyushan12@huawei.com>
Subject: Re: [PATCH v2 5/8] drivers/perf: hisi: Relax the event number check
 of v2 PMUs
Message-ID: <20250321111420.00003182@huawei.com>
In-Reply-To: <20250321073846.23507-6-yangyicong@huawei.com>
References: <20250321073846.23507-1-yangyicong@huawei.com>
	<20250321073846.23507-6-yangyicong@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 21 Mar 2025 15:38:43 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Junhao He <hejunhao3@huawei.com>
> 
> The supported event number range of each Uncore PMUs is provided by
> each driver in hisi_pmu::check_event and out of range events
> will be rejected. A later version with expanded event number range
> needs to register the PMU with updated hisi_pmu::check_event
> even if it's the only update, which means the expanded events
> cannot be used unless the driver's updated. However the unsupported
> events won't be counted by the hardware so we can relax the event
> number check to allow the use the expanded events.
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

