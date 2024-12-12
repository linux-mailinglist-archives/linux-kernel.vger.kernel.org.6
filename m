Return-Path: <linux-kernel+bounces-443161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412EF9EE81F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E86A165478
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80D12144C0;
	Thu, 12 Dec 2024 13:56:59 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CBC748D;
	Thu, 12 Dec 2024 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734011819; cv=none; b=dcm/YOVoNmklPg3HF9DnJGdBR0rUOahlbYRgAIYVYc9t37RuGZDGmV/YFTkK1UnrF+qSMAuUUcp/RUWDanewEBHQPeusIqutVr8DtA3DzrbY1wOKPFQXoqG/eA+A8nPUZgddZGbk8WaGHMEqaJagyq8asBCAOUE6xY06MBuALx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734011819; c=relaxed/simple;
	bh=7MAB+48kX57f5J+PZmhsnPf+/QzojGAb3/SlWK+EdNA=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ycq6HuH7/Ilhw12SRohR4Tw2PERX6SLVI41KS3Qa47u75SYUi9s+XQx6X2AHPRrEQFAizRqMvdqE/mfcx/iwkNdCKWDpz0IllH0Snj8jN6/Z+MoyYQMBOxv4rj9+d0eqoC6fa94okTeqL+lNWnjEMjrB0pwdvD2ZiDFI1KTE6gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Y8DYF249Dz20lcJ;
	Thu, 12 Dec 2024 21:57:05 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 1660D180042;
	Thu, 12 Dec 2024 21:56:48 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 12 Dec 2024 21:56:47 +0800
Message-ID: <7b385f78-b77b-4d52-b7a1-30c304721482@huawei.com>
Date: Thu, 12 Dec 2024 21:56:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<gregkh@linuxfoundation.org>, <shenjian15@huawei.com>,
	<wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, <shiyongbang@huawei.com>,
	<libaihan@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<hkelam@marvell.com>
Subject: Re: [PATCH V6 net-next 3/7] net: hibmcge: Add unicast frame filter
 supported in this module
To: Jakub Kicinski <kuba@kernel.org>
References: <20241210134855.2864577-1-shaojijie@huawei.com>
 <20241210134855.2864577-4-shaojijie@huawei.com>
 <20241211195440.4b861d51@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20241211195440.4b861d51@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2024/12/12 11:54, Jakub Kicinski wrote:
> On Tue, 10 Dec 2024 21:48:51 +0800 Jijie Shao wrote:
>> +static void hbg_del_mac_from_filter(struct hbg_priv *priv, const u8 *addr)
>> +{
>> +	u32 index;
>> +
>> +	/* not exists */
>> +	if (hbg_get_index_from_mac_table(priv, addr, &index))
>> +		return;
>> +
>> +	hbg_set_mac_to_mac_table(priv, index, NULL);
>> +
>> +	if (priv->filter.table_overflow) {
> why are you tracking the overflow (see below)
>
>> +		priv->filter.table_overflow = false;
>> +		hbg_update_promisc_mode(priv->netdev);
>> +		dev_info(&priv->pdev->dev, "mac table is not full\n");
>> +	}
>> +}
>> +
>> +static int hbg_uc_sync(struct net_device *netdev, const unsigned char *addr)
>> +{
>> +	struct hbg_priv *priv = netdev_priv(netdev);
>> +
>> +	return hbg_add_mac_to_filter(priv, addr);
>> +}
>> +
>> +static int hbg_uc_unsync(struct net_device *netdev, const unsigned char *addr)
>> +{
>> +	struct hbg_priv *priv = netdev_priv(netdev);
>> +
>> +	if (ether_addr_equal(netdev->dev_addr, (u8 *)addr))
>> +		return 0;
>> +
>> +	hbg_del_mac_from_filter(priv, addr);
>> +	return 0;
>> +}
>> +
>> +static void hbg_net_set_rx_mode(struct net_device *netdev)
>> +{
>> +	hbg_update_promisc_mode(netdev);
>> +	__dev_uc_sync(netdev, hbg_uc_sync, hbg_uc_unsync);
> __dev_uc_sync() will only fail if it failed to add an entry
> you can pass the status it returned (cast to bool) to
> hbg_update_promisc_mode(), no need to save the "table_overflow" bool

Ok, I'll fix it in v7

Thanks，
Jijie Shao





