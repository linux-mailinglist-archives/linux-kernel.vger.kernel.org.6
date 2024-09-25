Return-Path: <linux-kernel+bounces-339208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88BA986276
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5124EB34116
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1091D5AD0;
	Wed, 25 Sep 2024 14:11:22 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA7D1D5AC0
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727273481; cv=none; b=pZrccG5MxRfEFTjMDBJGlwEyM0ugMI7qz8Z0QKmnY73A+hTinsQ44MVoMkete70Gq366U2nQNWnc+8IgNyZYk39ERXTzWu/WVbPPt1S5jrlCJwAyVWiyPURDdjLDnWVyXIQ8p8zczUGYd6P9uHNnUU36sSlJVwXNT97eIodBSCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727273481; c=relaxed/simple;
	bh=ocWCJ2tqfUMUUzOOQRKrLW93IJSHfv598z3D3S08CE0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K57rqIhJiQtuFAw9NWADv5CrSxU8AI+GTqZve4oU/JkPIwnJQdIDCANZS3fSjkKD+7ULBhOdYUKJ/MGnIpF1BE5iEs2zGBRJhjY5rH+JdBzmsGw3PibBP7RmP08rxe6MlAfZmNbFxztIVFWhINX0bMGuDsZkOk2+NJh0YS2W450=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XDJSJ4m5Xz6HJbb;
	Wed, 25 Sep 2024 22:06:40 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C5C49140498;
	Wed, 25 Sep 2024 22:11:17 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 25 Sep
 2024 16:11:17 +0200
Date: Wed, 25 Sep 2024 15:11:15 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>, Peter Maydell
	<peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
	<linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
	<qemu-devel@nongnu.org>
Subject: Re: [PATCH 03/15] acpi/ghes: simplify the per-arch caller to build
 HEST table
Message-ID: <20240925151115.00005b15@Huawei.com>
In-Reply-To: <6305bca3d0c4fc02853fe2794eeb39f46823c733.1727236561.git.mchehab+huawei@kernel.org>
References: <cover.1727236561.git.mchehab+huawei@kernel.org>
	<6305bca3d0c4fc02853fe2794eeb39f46823c733.1727236561.git.mchehab+huawei@kernel.org>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 25 Sep 2024 06:04:08 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The GHES driver requires not only a HEST table, but also a
> separate firmware file to store Error Structure records.
> It can't do one without the other.
> 
> Simplify the caller logic for it to require one function.
> 
> This prepares for further changes where the HEST table
> generation will become more generic.
> 
> No functional changes.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> ---
> 
> Changes from v10:
> - Removed the logic which associates notification and source
>   ID. This will be placed on a separate patch.
> 
> Changes from v8:
> - Non-rename/cleanup changes merged altogether;
> - source ID is now more generic, defined per guest target.
>   That should make easier to add support for 86.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Odd sign off here ;)
Otherwise seems reasonable to me.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


