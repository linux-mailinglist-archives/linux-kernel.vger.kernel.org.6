Return-Path: <linux-kernel+bounces-286437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3EF951AF0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9A5FB213E1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B9D19FA80;
	Wed, 14 Aug 2024 12:36:00 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183481A00F3
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723638960; cv=none; b=pBAIUbxSbkbDnugTFOmk27g1Z3jt+t6xdl1o01VX/3YvmhaKc22nxPqusdA7PqoikU8McNYhonWMfawqKM+RPoA5h2DTgVP6MQ9frdo59z1sq12rNjzuBuKqNMmDgs1gDbGXrlg0YdxsWxr4UOfDFbQaTyyXfpzYpCFXAucnzxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723638960; c=relaxed/simple;
	bh=9A1dC+U34Fj6mcTl77qfGMMR3YANBJ5yWXuXiFk4Tfw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s42EdjfAdmVmwygI3egNEQVcBFDZsW+X7B9OSi5pbqMFDVq9gbhnfAHkg3om5UP/HZk5psK7M0FtkhClARd3hmm+EAZh9S8XIPBYO+O2laWcM859VVX5qAv0LZgg1Th23TzF4dV+xEuPaNKoNFv3j9Hm9i1CdYVi6K/2dmgnpIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WkSMC2sfzz6K6Wy;
	Wed, 14 Aug 2024 20:32:39 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C65B140DAF;
	Wed, 14 Aug 2024 20:35:55 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 14 Aug
 2024 13:35:48 +0100
Date: Wed, 14 Aug 2024 13:35:47 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Shiju Jose <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Igor
 Mammedov <imammedo@redhat.com>, "Peter Maydell" <peter.maydell@linaro.org>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, <linux-kernel@vger.kernel.org>,
	<qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v7 02/10] arm/virt: Wire up a GED error device for ACPI
 / GHES
Message-ID: <20240814133547.00002385@Huawei.com>
In-Reply-To: <41d72570cc4e1fa3239ebf61d91240ebbaba838f.1723591201.git.mchehab+huawei@kernel.org>
References: <cover.1723591201.git.mchehab+huawei@kernel.org>
	<41d72570cc4e1fa3239ebf61d91240ebbaba838f.1723591201.git.mchehab+huawei@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 14 Aug 2024 01:23:24 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Adds support to ARM virtualization to allow handling
> generic error ACPI Event via GED & error source device.
> 
> It is aligned with Linux Kernel patch:
> https://lore.kernel.org/lkml/1272350481-27951-8-git-send-email-ying.huang@intel.com/
> 
> Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
Not sure I said, but this is much neater than what I had so
I like this a lot.

Jonathan

