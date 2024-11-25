Return-Path: <linux-kernel+bounces-420995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B479D855F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3745016240C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11379191499;
	Mon, 25 Nov 2024 12:22:34 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2D017BEC5
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732537353; cv=none; b=mkNmdf14S1HZ6xlFgdwvAibtmbjjJH8zpi1YtHXra0sPUQFBDquhJmvRS3oY0DwnsJpD8sMOH6r0miFBwR06Quxv2KC6cfOi110XbvoyR+0tJWbdT/Aw5O7VC8nVk3T9d3IX19gy5bZSWrH9cbIJ7Cir8rut37QiDcdUiG64L5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732537353; c=relaxed/simple;
	bh=gX6RRUkhrXyt1eQce3tICLmtEBTomtuu1MbxPVMLSgA=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=YR+cQivdJXmhfUZLyoNnRDMaX+WvJy7yaWT3Xbp7qIFVRW6lRTpjVgAW2P6LRb0S5jCKuGx/aaViaJH53KDmk+59CGxZcbSsS2kPnFGZwDWY95NIY+/BebuLWGOu90GJYO0tPQc2R6wtxooSHtoAW7EnZX4Nbyc5jb5/jkc3blI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XxlCR4Ctgz10WWS;
	Mon, 25 Nov 2024 20:20:19 +0800 (CST)
Received: from kwepemh100007.china.huawei.com (unknown [7.202.181.92])
	by mail.maildlp.com (Postfix) with ESMTPS id E18401401F0;
	Mon, 25 Nov 2024 20:22:26 +0800 (CST)
Received: from [10.67.111.53] (10.67.111.53) by kwepemh100007.china.huawei.com
 (7.202.181.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 25 Nov
 2024 20:22:26 +0800
Message-ID: <a8ccbb56-d72c-4752-8ff7-d9166fccb0d0@huawei.com>
Date: Mon, 25 Nov 2024 20:22:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <zhangkunbo@huawei.com>
CC: <airlied@gmail.com>, <chris.zjh@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <liaochang1@huawei.com>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <neil.armstrong@linaro.org>, <simona@ffwll.ch>,
	<tzimmermann@suse.de>
References: <20241106024548.1915611-1-zhangkunbo@huawei.com>
Subject: Re: [PATCH] drm/meson: Avoid use-after-free issues with crtc
From: zhangkunbo <zhangkunbo@huawei.com>
In-Reply-To: <20241106024548.1915611-1-zhangkunbo@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh100007.china.huawei.com (7.202.181.92)

gently ping.


