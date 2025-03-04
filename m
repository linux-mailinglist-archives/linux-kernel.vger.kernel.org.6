Return-Path: <linux-kernel+bounces-543686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 991C2A4D893
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E77416E491
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027FD1FF1C6;
	Tue,  4 Mar 2025 09:27:02 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6F21FF1AF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 09:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080421; cv=none; b=gHeL5LvvQzRLefJC2++zYW7ARobiAxCYGSEuDr+Zr/JUvBUOOSQdk9DD4wOt+hzRO6KSaJwe3TnmPPvcHaC58HICaOUTtZFEik/Y50aUsLp0Wb+Jue2zT9SBD8NeUOcMeo4sqNOpQ2DC3kvdxWkmajosY7c7ICeKzKoUkU/BABo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080421; c=relaxed/simple;
	bh=MAgZCXFeQQaoFQ/XfxnVvHnahq/vKkc7CZc0ef8JInA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hswZD6BfDEWodZm1rDramJc0+Bv315Tocdbm1QM+epdeCv3o/XWTyIe9xX4fU7T1WfqwZRHgDuT7FnklKemFm8mHufUVK7/tmQG+VgupujvrS5oJzMwFY00MD77d7N6do/wDl1/5CcQPCSKj2bRs/Lrv7iTGbPxXgJl2xebtzTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z6Vb23t4cz6L5Hk;
	Tue,  4 Mar 2025 17:22:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id F17961402C7;
	Tue,  4 Mar 2025 17:26:56 +0800 (CST)
Received: from localhost (10.96.237.92) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Mar
 2025 10:26:54 +0100
Date: Tue, 4 Mar 2025 17:26:49 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yicong Yang <yangyicong@huawei.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
	<yangyicong@hisilicon.com>, <wangyushan12@huawei.com>
Subject: Re: [PATCH 2/9] drivers/perf: hisi: Simplify the probe process for
 each DDRC version
Message-ID: <20250304172649.0000189c@huawei.com>
In-Reply-To: <20250218092000.41641-3-yangyicong@huawei.com>
References: <20250218092000.41641-1-yangyicong@huawei.com>
	<20250218092000.41641-3-yangyicong@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 18 Feb 2025 17:19:53 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Junhao He <hejunhao3@huawei.com>
> 
> Version 1 and 2 of DDRC PMU also use different HID. Make use of
> struct acpi_device_id::driver_data for version specific information
> rather than judge the version register. This will help to
> simplify the probe process and also a bit easier for extension.
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Looks good to me. Looking at this I can see the check_reg naming
is an existing thing so maybe leave that alone for now and consider
renaming as a future improvement in readability.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

