Return-Path: <linux-kernel+bounces-295235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FD29598E7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FA971C20441
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E928B1AD5D5;
	Wed, 21 Aug 2024 09:34:19 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01781AD5CA;
	Wed, 21 Aug 2024 09:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724232859; cv=none; b=XMk1Ff46h4cOu1tzm/oPWUXKQuXVioD+64/4S3yPF8pb04SZQIBeAQLphCRS5NxhEctawjqcyTO8fezu3caSROpCuBX1Knty2oCssKH39gTFqxefYKfv1GanbJsmC2mSxU071U7IOlvqBviAZgNENDv/6Llf/3CXZSbboBPpmoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724232859; c=relaxed/simple;
	bh=5E5DayvS4WYqmd+qmX8J1jgtMR/TdIQApbh9bNfz6TA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Mg0DuFtxMQGRbStd5zWCYbVu7wQH+7cYIv54WdLyffY6YfTbjmYFU1/NNSzE8f12QKHDnpgk/eEGHzWAY3Kh2Wvk4X2O2fzmXRBz0YmWYNRdURyNLGlF0cwuoxiVjGhMM7OjbzpAWtbClr9ecMo2xqoVwTDK2jKWRJ3Nmt2Mo3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wph3Z1gmdzcdG7;
	Wed, 21 Aug 2024 17:33:46 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id C8BB2140EA9;
	Wed, 21 Aug 2024 17:34:08 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 Aug
 2024 17:34:08 +0800
Message-ID: <8e279112-9b2b-1066-50f8-ba0b318b8e25@huawei.com>
Date: Wed, 21 Aug 2024 17:34:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 14/14] thermal: core: Clean up trip bind/unbind
 functions
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui
	<rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>
References: <2205737.irdbgypaU6@rjwysocki.net>
 <1831773.TLkxdtWsSY@rjwysocki.net>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <1831773.TLkxdtWsSY@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600004.china.huawei.com (7.193.23.242)


在 2024/8/20 0:33, Rafael J. Wysocki 写道:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Make thermal_bind_cdev_to_trip() take a struct cooling_spec pointer
> to reduce the number of its arguments, change the return type of
> thermal_unbind_cdev_from_trip() to void and rearrange the code in
> thermal_zone_cdev_binding() to reduce the indentation level.
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Huisong Li <lihuisong@huawei.com>

>
>
>
> .

