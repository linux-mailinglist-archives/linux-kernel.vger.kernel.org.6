Return-Path: <linux-kernel+bounces-298887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DECD895CCBA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FEB81F2136D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217341865EC;
	Fri, 23 Aug 2024 12:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="UoF1t/uh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="On/WPrSk"
Received: from smtpout148.security-mail.net (smtpout148.security-mail.net [85.31.212.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E77185B66
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 12:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.148
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724417107; cv=fail; b=CRNL1EqjPM05bK4JNn+u97dwSELAkllLpyjg+lAfHTobxDudP7xVUDWyMZmyRpms4fn841UaSCbATuPjqLe1HabzRWnhrVtnhXCMfFqUs7r8bhqmM4I2knlShHk+TR6gppEMVssFx5CPjOQT+5+yYhOSR7tuYJW22bvFaAIrFNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724417107; c=relaxed/simple;
	bh=vWId3pBChHUNERso1PhWkiq7j9cT3j+5duH7xNgYIsU=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oqmCUImG8Hy2Q8Jbotu2v+D/rmUkhfK9HT1j/J4ZUYtcDoufzD94XoB7uBYQe2SFBhPTnTzz3hj6wMD5mkYQN1s0tPtuZWuRBp4Y/ji4t/m1LOodRl6jKEL4rTe+a7ONhxaXRlguikWD+HosL0w3Lq/FUv8NMkMzKgcoIzePWyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=UoF1t/uh; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=On/WPrSk reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx408.security-mail.net [127.0.0.1])
	by fx408.security-mail.net (Postfix) with ESMTP id 7EC9032285D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 14:42:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1724416926;
	bh=vWId3pBChHUNERso1PhWkiq7j9cT3j+5duH7xNgYIsU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=UoF1t/uh3kXVpXYk7o377hSBv2+nAaXKmKE0ByRQHzRs9SZ1ZaxR6rQYYVBrVNhDV
	 lf7QX9OW8Pt3ktfVOIJe13AqbClfrR8XbYd91YofzlajmH44la9l4iGNBOG+ZGCO/f
	 IZ1eEov8r/GwYrq9bz4byRg09Ib5KOz6VnAZCnPQ=
Received: from fx408 (fx408.security-mail.net [127.0.0.1]) by
 fx408.security-mail.net (Postfix) with ESMTP id 5882532282B; Fri, 23 Aug
 2024 14:42:06 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp17010005.outbound.protection.outlook.com [40.93.69.5])
 by fx408.security-mail.net (Postfix) with ESMTPS id CBB023227E5; Fri, 23 Aug
 2024 14:42:05 +0200 (CEST)
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:14b::6)
 by PASP264MB5350.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:43c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 12:42:04 +0000
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7a6f:1976:3bf3:aa39]) by PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7a6f:1976:3bf3:aa39%4]) with mapi id 15.20.7897.014; Fri, 23 Aug
 2024 12:42:04 +0000
X-Secumail-id: <135e8.66c8839d.caaf3.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHdmWpPPs5hi5eWqFrG/30/ryYiVdrLei7ZD68va43Q2h9TKgIuMPWUyci+FuRjI3l0egfzLf3Qnirs1/e2aaALnh1b9tBpUhhGjyq2IrDPwmROPGkDaWwZR94Lh+V0JDniODSszbz5ZAeJtpoXENYMtkBt24jpN5w4c47IbaHLk5MA0uVHHVZMq15LC9h6H1wSkpmLIGVuSxVtFmB2/MN/7k+w5ODBIVkkpIwT9mLYDe2e5SwgVXDUUDcI0k/E8BP6H9akgMlz8U7HX5guc6gEN0aupoBe1qX7TwQol8+gjqSaDhc0smybBwJLmiXHgA0Jtw2/m0KUz+1WkHWgkLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMlX7n/D7MGTd1fUq7qwUbRULVSyuvQu3SZrWlm+lYk=;
 b=J32c52OF9q9++zgP6fXkY9jvmDYt7+fid0QHwpom7cUzIBY4jRBqgYZETglsTEvR+FSrmJFnLWIl0owwCBQLfPX5t9TfIqu9GtypwnvPRZ5VGuIIz4Ehls5HiA/JBViWrXd2i7TLn8wIa6SQ87eRJAQAqMoJHPWwhzdsfOZs6leKrYt/zP1ItlvnIbDfqAOBlJ7M642bQ6VCBF2blPxi45QQkT8NRDCei5VUYx53rG2/ONKskMRvKJNrkcn+Qa++C6VgLFYPfTW+tewGnW1PwLqqqkFa1Z1CdQjnlR5yWhwsJA5iHM5bdU/iWLsrNyVhnB8kU0XJFqqLn+9OAMNstQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMlX7n/D7MGTd1fUq7qwUbRULVSyuvQu3SZrWlm+lYk=;
 b=On/WPrSkoSJlDlZpqQJATmp8bnpoMjQgN9jBxOmM3pdsKEsi0Kkz0zvvx5lTbUEunHTRtydvBosjtJGnU5o2je2FIZg2hYay64XvULaPcyRB9JX+xYboSZdyv01L5OJY1F5x0ISJdMpkCo9b8Ghyji2LXafV3ryp5LmvBAxQMjdq5Jo8P5PRKiuWIFNTv7sRE6gnxLkdpMlMarJvW0OZXc3X9oXH+Dx6SXC04/QYNZMlB6/OJ21lAt5gIX8wNdO+RGiNRSqg5xJgE1y79Bc7ftKS2VXv4kK9dk1LSuMY+CJ1QXJ2HkFAOmUqYh7U/snWp6W2nxRqsBH6SZm2mZx8ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <5adb0cf2-e0f1-492f-90d6-2ef3b92e87fe@kalrayinc.com>
Date: Fri, 23 Aug 2024 14:42:01 +0200
User-Agent: Mozilla Thunderbird
From: Yann Sionneau <ysionneau@kalrayinc.com>
Subject: Re: [RFC PATCH v3 20/37] irqchip: Add irq-kvx-itgen driver
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Clement Leger <clement@clement-leger.fr>, Vincent
 Chardon <vincent.chardon@elsys-design.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-21-ysionneau@kalrayinc.com>
 <214fef44-f4d0-47e9-bcab-9c8b38e68d20@kernel.org>
Content-Language: en-us, fr
In-Reply-To: <214fef44-f4d0-47e9-bcab-9c8b38e68d20@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0134.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36e::16) To PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:14b::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB3481:EE_|PASP264MB5350:EE_
X-MS-Office365-Filtering-Correlation-Id: 7929107a-70cf-4ef0-77fc-08dcc370fce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: VIBVEyqRuL/L/xI8ZzW1+bifAMsVA26Mmozc5BEieAiJ/kuzL9nvIIBm8JHlsnzmyZ/Psgo+uaoHSWS0Sh9g6MWi5UGODm5FF2cysfg3h76oROjAs4aGrxe+7hkhk/LlrOJdlmy6GbM/OuS4AuOPxJ2EzTusXxMLxa0R+MOC++fOghXHDPFyvdg541s8xMVyeKoSxgBLifBMHQ9wNqtbay4U9JWRi8MW0wwbOM5rBzYiK+Qb5XpKl/Z9iUR1Lmt9PGUjvFHhiM2WGANYrnbZ70MovpIgmzxcLjAO7Ov+axCJl5RfYqPeS8d35BuJ+0jtvReF4a4LArGPxhrOqLrO1lXvPGaGHP6IyNCTpWAEoVwjZHaWtZwwEqCrJL7qmFEtmKu7hS7gd/PWbz8nX67DpI80SIn7IugIGcchz0gudOMno7Ce93D1mDJ1of+fdp9rMGssZc/ytuR8VMFpbHe+JmYa7Z7zkPskRfn0iZtBjzbH8PXUcHpkyJW38OB+rdvFG7OiagYs87IE4TYZJzOzebP4u8j15qrGdndMljUBhvQwX8JGvP4M6H4b52j5NFXj/hpcpyZbT4zDEwdgGNvAKnTIAu9fsyAV7AkI/UPpvqbMZx/c6OEjueYou7hHRyCjR8sCZxHiK3yCNvdMqS5FBj+NKkYKzUZi8tkZF5tZzgtanNzXD45WTjLAg2yVJdWuM5cu/PdDU3I6Ob4yXF/3Tn1s2bSicaY+N+txe1se3p2RvcVg+KswJ2rnM3oghnqZZqEXygya+JFb/GPHnmLMLapEgST7rVFWmNyz8zglF0PMBWvRX7zc2//VpxTTjtc5OloX12XXn7d5HLbZnVgXJFgNeT5FiakWWYyoxz51VPVV8/5t3A05ONUV0OSE6Ykixo4a9Kpco9uq8X/wHknNKp1OUGSPjifmxC8cRYX4ZoRpaO80O9bbG+MhFL3eVcAohcP
 FwOTv/I83Z1rtYoY1DZROVAECQV4ZimotUMvnIYF3PmslhyDckPMe/jNF7hJYFSClfojOrnXDaqzEr/s+XP2WYSlsXw/7h+qdFubB8hh3BV/ORzjSQUtuqTAiQIUJ2VbJRNsg5UhI57IDtfRxLeP9iHEKoOXiL6otXi8/flNlBvqdzzYcfFhUNKskrgr0yKjRRHi8LFqhJgNJskem+TBK8ACixFfHaFu1eHxK66wBrSw7isSC92q+AEjzS3eyIa0TILy0cK6osDJMyBelUylvnyTKeiAwk6qiLwNHBpxQnrjwjHEnJtu2SMsUU7udIdCeRtQCFkTVR6bM7vJFhZtjjO/0bhNq1FUcpaA8ttM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: G9mAFNlOVyjNffEyI85EXh3Idxf6A3vNj4avHw0wlBR3TAt/gGPhMGqQSiun9Q8oOInoPIGZd9xOxWEAIiCpC3/3Ozp5okUzB/AHOLBWw1bnzL6kf5YjJ+wIpS6d2IcnjAof0CIWNwGGIl5hqEgNLre6vIVIoCOQ9rFVflYv5RuPc2mqyJFd8p2vusr7PnL9jdcLeu6kHC14eXTFfEOJDYpsITwQnOOVcdk7nVP4kRlXq1a3QBq5T8qoLKdgLtYWRTDYgY7ol7ik1dkn7Vdr04FIBubRhM0rkaJGqMw5znfPLS4xchtg6R7atQczy6XrUJhflnSqewODYxpDEJbv2UeJjQ3uZQFQp6GR3h5lDpIvh64h7D17tcuiol+VGfkx7Ky4tit86bXOAbx0sHvIhUdxbJcOLJAQeqIF5hopdLdUgYX6yN2wZ/dDSCHNC/gch3FgocuSGdvyEFb7Z/qVWHqVk1Amm6xstl/gQ+QLrpXuLymCjHInw5z1FpwSiZ7Bivbk+OJ+72ggSYvMUa4gKcgdaAlVPpTqUtWIiMMUj4ckvvQqt/xsS2lhW0dk9YrMfvWXU5eVFVwCJX0l4uwM5g8TtDmVy/ggjI5tbf4klIy2iF2hdHAZQnl+I4kFoFjdSwnGeYQcDUh52dsEjwF7/5HF2rrdpsfSAbR+dFg85ZSoiRvj+MIdIVApyNxpuS9aZR1TbtvlTBcmmkDanIsl++VSFCw2VIcatcd6zZw/SP3H5sOZE6hPN55QqFK5pQhWe2eBqZ6SwO9fzyQShFeNwdH4cDZTsKvg0uf+YUotatrHX/Fys7uFzcSpqzxn7/V6wuK8tu2Rh0PhoO48OEqB0jHVCc4YIMD1HzB1BluzJIYHUVMNddSymIxBSH38MEHV1/955MOi3s3R5/MBcRCAj2vimOcqWwxQ9JokL2OG92Tc0k3tKcKxn5MOlaXD54Ff
 Q/W1ihT+o+xGYmDisqsxIE7NlGTzwein1CaW+Sr4MbJebjaGsMEeCU9aklE7p1asmwwfGmCoYA5XyCWw8YjIo61/tJasSyeDZA9QXFGj3WosT65gf/PsvTB5d2P6QoS6AaAgVhrz5Eqq6333aZ0UcEPb7NMt2raZXd/CukPWMTKNNCK7uxcUKNoy4Wsto4Qwls/BHMJanFlEYc5dRap91BeP0c1/Doz9PpNU9CYbkNnBEfbCoffxoeUxeXISpAQHAqC4XXDWbtpjM1uHyShtIbuZg8oZVJvXe0vSFvXwcVUNNMUsLRMMtw2YKhIpH4UrwrWl3CnZnzCJ/HpFRj/5LAFyiN9qxFpvm9YtWsLcdX6VAzHHUAmt33xlSNYA8LA9O3cJ0MaEGf2Buf7JRbbECT98eMdLL9dw0vDQ5YQMrclZMxVSnIEJTwOUnRnPgNRT/wasENPJQQTxyhJ7v7A/aJR+6Wc+YqN6EHqglfLtiZUkvpK/tZhNa0aO/WuxvTx/r0gOBLQt7SY9kUC4FldwyW+Tbnh2JeDflWeu2rX7/aU1+cCTCCPP/mFwbJJboNvbp+ZlC8Wi4aoIcra82MZSNoUO3Mdb9X4kRsLZ2/1ty19DrgPoeTcEsEgduVN+eFZY/G0WE8allQt4QfZRFvXcLUFnEf0dH2hhmLxVlirEKPLeXMB74EjSJ5JcgBklindjXWJLijyeY8IoySyMwO+Wmw==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7929107a-70cf-4ef0-77fc-08dcc370fce4
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 12:42:04.2668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5YzBNsBwa/OH9Wy93+nD8EB/svzobLXP9ZzTlACucvRgFG7IZWQOzAFJ7dYRZws06VXYchYb8RTsiRbG/YLeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB5350
X-ALTERMIMEV2_out: done

Hello Krzysztof,

On 22/07/2024 14:30, Krzysztof Kozlowski wrote:
> On 22/07/2024 11:41, ysionneau@kalrayinc.com wrote:
> ...
>
>> +#define ITGEN_UNSUPPORTED_TYPES (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_EDGE_FALLING)
>> +
>> +static int kvx_itgen_domain_alloc(struct irq_domain *domain, unsigned int virq,
>> +				   unsigned int nr_irqs, void *args)
>> +{
>> +	int i, err;
>> +	struct irq_fwspec *fwspec = args;
>> +	int hwirq = fwspec->param[0];
>> +	int type = IRQ_TYPE_NONE;
>> +	struct kvx_itgen *itgen;
>> +
>> +	if (fwspec->param_count >= 2)
>> +		type = fwspec->param[1];
>> +
>> +	WARN_ON(type & ITGEN_UNSUPPORTED_TYPES);
> How is this possible?

If DT contains something like this:

interrupt-parent = <&itgen IRQ_TYPE_LEVEL_LOW>;

Then this is not supported.

But I reckon we can replace WARN_ON() with pr_warn() to avoid crashing machine with "panic on warn" setting.

>> +
>> +static void kvx_itgen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
>> +{
>> +	struct irq_data *d = irq_get_irq_data(desc->irq);
>> +	struct kvx_itgen *itgen = irq_data_get_irq_chip_data(d);
>> +	uint32_t cfg_val = 0;
>> +	uintptr_t dest_addr = ((uint64_t) msg->address_hi << 32) |
>> +							msg->address_lo;
>> +	void __iomem *cfg = get_itgen_cfg_offset(itgen, irqd_to_hwirq(d));
>> +
>> +	/*
>> +	 * The address passed in the msi data is the address of the target
>> +	 * mailbox. The itgen however writes to the mailbox based on the mppa
>> +	 * id, cluster id and mailbox id instead of an address. So, extract
>> +	 * these information from the mailbox address.
>> +	 */
>> +
>> +	cfg_val |= (((kvx_sfr_get(PCR) & KVX_SFR_PCR_CID_MASK) >>
>> +				 KVX_SFR_PCR_CID_SHIFT)
>> +				<< KVX_ITGEN_CFG_TARGET_CLUSTER_SHIFT);
>> +	cfg_val |= ((dest_addr >> MB_ADDR_MAILBOX_SHIFT) &
>> +		     KVX_ITGEN_CFG_TARGET_MAILBOX_MASK)
>> +		    << KVX_ITGEN_CFG_TARGET_MAILBOX_SHIFT;
>> +
>> +	/*
>> +	 * msg->data contains the bit number to be written and is included in
>> +	 * the itgen config
>> +	 */
>> +	cfg_val |= ((msg->data << KVX_ITGEN_CFG_TARGET_SELECT_BIT_SHIFT)
>> +		    & KVX_ITGEN_CFG_TARGET_SELECT_BIT_MASK);
>> +
>> +	dev_dbg(&itgen->pdev->dev,
>> +		"Writing dest_addr %lx, value %x to cfg %p\n",
>> +		dest_addr, cfg_val, cfg);
>> +
>> +	writel(cfg_val, cfg);
>> +}
>> +
>> +static int
> Why is this wrapped? Does not look like exceeding 80.
Ack, I will fix it.
>> +kvx_itgen_device_probe(struct platform_device *pdev)
>> +{
>> +	struct kvx_itgen *itgen;
>> +	u32 it_count;
>> +	struct resource *mem;
>> +
>> +	itgen = devm_kzalloc(&pdev->dev, sizeof(*itgen), GFP_KERNEL);
>> +	if (!itgen)
>> +		return -ENOMEM;
>> +
>> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	itgen->base = devm_ioremap_resource(&pdev->dev, mem);
> Use proper wrapper over these two.

You mean I should call devm_platform_get_and_ioremap_resource <https://elixir.bootlin.com/linux/v6.10.3/C/ident/devm_platform_get_and_ioremap_resource>()?

Ok I will do this.

...

> +
> +static const struct of_device_id itgen_of_match[] = {
> +	{ .compatible = "kalray,coolidge-itgen" },
> +	{ /* END */ }
> Drop comment, that's really obvious.

Ack, I will do this.

Regards,

-- 

Yann Sionneau






