Return-Path: <linux-kernel+bounces-298877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DED8F95CC85
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F47B1F23114
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725A6185B5C;
	Fri, 23 Aug 2024 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="PfwD4qq/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="oBIBEpf5"
Received: from smtpout144.security-mail.net (smtpout144.security-mail.net [85.31.212.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A43185B52
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 12:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724416807; cv=fail; b=TPe+S5YwILvnMY+uf0QyrscYAYq3iiCrcE5fLDIFnB9RPqgDA0D5zIoUkObq4a8AuDFuVVqU/HRUjV1l3ZemaqnodwJHN+KhkmuwT2QJqZByuZoI/rsNkurv58loeF+y0o/hisklsFf5uqL8aOPScj+bLNnaOpHmqiKoRlVaqEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724416807; c=relaxed/simple;
	bh=EWM0XLRyljNpnvOegmGJJDjJgSoxQNrgJJQayXeXG78=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KxkQw0IpZ1L9Y4x/hyJcTieuCKHyhwPehPd/oAgOZGxPPeaWZ+EH4mVwuo+dl9jF4ZcWq6S1Cy6chtQy12ugh40F7P6YzgCg0bqpN/vyFvrFtDiX7FvQtk/HcwQMeLeEPqay83Wapw983kFIlAxCIoRvudQUSZSpUBf/H16O9Kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=PfwD4qq/; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=oBIBEpf5 reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx403.security-mail.net (Postfix) with ESMTP id 18F5B18DAF9
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 14:37:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1724416672;
	bh=EWM0XLRyljNpnvOegmGJJDjJgSoxQNrgJJQayXeXG78=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=PfwD4qq/G4kAdWTh5U7mTTXUoqEO2VmFKqvtGWtjwLZ0vUzeySI2u8nGRBzO9I8+y
	 JOZZV+qNTnvSlkowc6nz73CIfgXm6tNzKxgNOTBnvH7EcD38NyJBKoblqgRzelDika
	 QY8AeKjN+FT5LQ07HJUN5pm6IU0TLA3LoJKU/UIE=
Received: from fx403 (localhost [127.0.0.1]) by fx403.security-mail.net
 (Postfix) with ESMTP id DBCB818E272; Fri, 23 Aug 2024 14:37:51 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp17010003.outbound.protection.outlook.com [40.93.69.3])
 by fx403.security-mail.net (Postfix) with ESMTPS id 0BC3218E88F; Fri, 23 Aug
 2024 14:37:51 +0200 (CEST)
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:14b::6)
 by PR0P264MB2904.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 12:37:49 +0000
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7a6f:1976:3bf3:aa39]) by PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7a6f:1976:3bf3:aa39%4]) with mapi id 15.20.7897.014; Fri, 23 Aug
 2024 12:37:49 +0000
X-Secumail-id: <a303.66c8829f.97ca.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5hRZ1m4QJYWed2pTzuhtw7iaOrdIk4zx9BM3HFfKi1Lk91RcEQXejS/pUasBRMxwlFl6Jfoj+x8QpqAKQJxC6WJq6P64oWY39zYynfBe96zpIhIT0xQ3DrMuw9LeJHK0d0+r4QqJUDYAIIOAUEYd0iScwUGds/qO/E26Co+yvbcTtRJ2jpmemVZ9zbVjCq6Y2L8KSxS5CpPRa4pIOrtzG3UW65YK2bixD8Pbsgbg0dlXZk0M0CwL5zMCeiEvNTX9qMPuuEuD+Uwy6V8Q2tuej5D4eI3723i+iEHYLFe3+/ckQLing3iO+fbv1iNkO9WSO3xeb1maC+KtOTaen0Tdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ow5Sfq3jhtoYtpZt6Kp+AQG1y91+pNfoaaxH6etQa/Q=;
 b=BVU4tzBP6DELtOKBdFWyUhKXagB1DvH/Z/gXQA3TPh4CgdgqUQXOIDCr7aNimmu2FAaA/QKy9IWOvBpx6UkTGw9kU7GdhQKSgk2rtNaRdP4xAwjJSaBwzpT2Mjls0skXmsgQb39zLCJRIqxBuUhNU0jA6RlKRKruo2Ahy9B5wgnWxbXFx931FvT5rxzve9v3oEHnpEFBUojXCX0WHwXkOKNzHNOYbIAzpao8+KUtgo/qk/ByRoWn9X3qzxwNt2aiXiNKYWmJEc89UdOMMVIO+ZYGDlyZhIuPaf5Zu+MC7/wIx6NWjdionBt/cBTXJkX6ByRLu87NkpdB6aQo+i8USw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ow5Sfq3jhtoYtpZt6Kp+AQG1y91+pNfoaaxH6etQa/Q=;
 b=oBIBEpf5uJXNFX5SwevOYu1UH0VFqqjITpYUpabIpoPcsNFOpUjMjxVe5u1oKaU+AnbbwY1do93NlVer7M0NT4Ys7LKzWQPo2bMvWGLUaTWXXGwVJanmk8PBffur9QDQoC7+3w/z5HFF0dej3dDQEks5FXOtQneNaph9giuFiefQspZV+Z8ZcCs9S4kNggMp+PFMsP6FW3eV51djXnWI1UnFZwFNZ1K8ASG/CRnV5v9zwsZMCydGy59+6l5tbl7BM5O4nJv/ZK1j9K9Oho0F6TRsAgGFmvbnxdddUJMyioFjyF917GakLhRHmhA4bbCC+C3WvLdnPBpyQZpMNo96yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <1a3c4327-68f1-4dd6-ba84-2be77625475c@kalrayinc.com>
Date: Fri, 23 Aug 2024 14:37:47 +0200
User-Agent: Mozilla Thunderbird
From: Yann Sionneau <ysionneau@kalrayinc.com>
Subject: Re: [RFC PATCH v3 19/37] irqchip: Add irq-kvx-apic-gic driver
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Clement Leger <clement@clement-leger.fr>, Vincent
 Chardon <vincent.chardon@elsys-design.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-20-ysionneau@kalrayinc.com>
 <19587631-3da7-4378-910a-9c3075b96995@kernel.org>
Content-Language: en-us, fr
In-Reply-To: <19587631-3da7-4378-910a-9c3075b96995@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0173.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36f::9) To PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:14b::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB3481:EE_|PR0P264MB2904:EE_
X-MS-Office365-Filtering-Correlation-Id: d88a2b60-1069-4114-28b6-08dcc37065d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: h/iFSEyJgMQlYY1z8mAG4FGm+Hbyd+RVmTqUXE9X0mW03K0pxzYlQP5fWxOH+Xjvsj0TlD/CNw3gXXa5MNSbnYMNWOI1irzoXmk1icB9Un5SgrdllKDI5tA8qKM8XJ0uNKtb+/VggcH7RCpn6eJoRWoxYIQ44SFuLSPFSBW/r1iDdBnmzDEYgUv6sX0mRy8VAtR9dGaA7JB7bK+xzlSac6kOBgNFljavKLxdvCim3/fkc8+Ibr+Ecsz3D4MuBnO4VxeRUVVb08UE95RtLkywu3vCpxBWIafeY4lnCAfrza9C4429i8NLFe4CeFGS2oxUkx9e1kPq73r/d2ttslLr8v0EMtSabNg+n23xZucAzYgME5qZC+c8Ur36aniEjDTxGEWZn1Ypahhy4ow88NWnOtBGBzroWdG3txA6tHi3GkacaR++z1LtyQYYGV13muf1gUGjg6Y0Nr3OrNHVgZ5HWHeN8+dxg/Grfaaenwvf8nFeObeIDwTOoDJ3yMMy/d1/8qWBlKmKStwSSnCsWQBD4Ui2+Xr88WUIGl0JBFdRXNEKHrNBeJJAP+l2tSczVGAvfGs0LLdm16uEzrSKULQYd5CrSRJ6Vtv/t18maFSG4gB0VQW9lpAVW7GZnMuHaz/6pck+1s5zwP3tWzurwu6YIYre8nzrYJ9TxsDlus6WvBjOPIbJ4mTOuK5UPu5r3KjzPTRyYfydqd+u5Lj6ELhrw8nNYSLffG4lna0A6zIPh31uVN7YEaPL9X+bVLqVUlU94Q2DV/TOL1nGuDH6iDzLo0cPpu0SlQU0NiPox9ozs/qDHzHyzSVBXO6yJDxcCKZEUL87eEMiI5BFl/Yp+7sg/yAnx59fx9IqOKOcqRLc62WFbHAO/8vFEwuGqTtrM8uJ4pRDROnim9tvteY+qGRlmkefiZHZk4mRo1nClUBa87Pia8123fJW5mfjojvdv0HzZmt
 iVK9gsUh8bGVzO+3692ytrp4/u4ZjKIjArJf2I5yn3MpXjQv77Rdl4kdqJfO1R9IZe7hI+y8nzXEBdSnRxwPlsOuNnMuiUcl24cAMhTY97BZ3+YeApxIjVaTUuz37ISMbC5DQ6nMc7B8PxzGxWb3uJWyxZlvQIERKy5x4dN4LSvDi6jXLtQ3JZyChCv5IsDA458oEPq5cZ4QRG+V29JD1egGfNnBxxhHUGAc22BVrqm3KZYrYUXlmMi6n+gTgSJhMSYjhwVse6S+dzSdHMrEmSBRtznkMB1v6TUE+d+SwfcWFulrCcXpTyDKowFYpt7czm77sew/V9stSZ7b1BDknV06k7SpI6/UGEGMPUzuasNbZstqapEvBbUmw956v5IbmEjdcI4vbVDd9mi4umw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B8/hhB+tOMUn+0rfE/ic6ELxdcbQV1y6xxdjZYeR+KhUwaD/GUeUFY5ixocc/Gkwg7EOzEaVG9pnTwZHaSaFBwXv44NzhCSmblEIRBgL0PrbBUZkpnoGHfr2KJlVRsnpFlQhTSQxFZQFkk//DltR6x3boR4qVFw4NxiUCoiE3QQtWnZg6ugXpeir31uV7G1MRzjyugXyXQ/BftkzkuChp43UN+mtMGMjmLopiNGgImdvdjb2YWD5qDr6X73xY4vjK5dbEAX21eZWyeeiC+0jCr4SLBu/vsoPfAHS9XlJmbry967NvzPcmtCspNvW0AfTseiaK4FKt6zDneQn5WA1QY8o/+BEjm5KKzvH5iUZLrRYwAxLIb2d3nmF1gmyzuLYllvwxCDpmvNOFH+HWWp5IGrIYYzGZZUcrTg0x8CMPM01rkxTQvAJkR67e0vD/QrGzbneJhYdp17DghTlzAVSWzxKon8kMK92ptmMWDdRXUpAFKylE5EQMCUhW1mCrSbuweUZWGN+HxHH6en4/phaOPsc/Ws+xrG7VyoobvMcwo0n4lbotIvf6NV6vafCqM/8GlS9tnm9f/Kh1Q213I24yPXLDZdTn2rnAky2Xbk0UBwaOE9GSyZ/dgIqucB0Uqs3JH2Gt0dmWGcE6bdzH+20MHriARVVSZzz27wHDe9ASPnFFa729TulSPTVbuJHRiOyjomMLXJgsJ3g1Z36BBAhafnkZ2J2lUJhNC4oWrRs+qZgqbggujYQmiPeTpEtMF2cIIZAm72F4XXm9lIB0rJAq2oPjJroj38i1+NMkq3TH9LepR42OoNINVI2HiWxpbFHg/hyw+TX9C9SDQ4H9iSOuAXUkyP5j2AKqhVc0P0kK8HmSvnh/TlPKbsyY1eqHWvyCb2eC4Wo1QCYif1AsQZpVV368RxjvtZk4JgWIBiw9HKvMrIFroayC7+pZjvc7tD4
 9quZy6ZmR9dabqgOi6hxiakoOKmEXol0Txqm0GFOsr0axx0zlo3ZWKIb+uYWK5rNqOroNt/JhB63zBpuvsBAOwZfYWN4gB9uP4oMDXcIhhmef9FEo+Sks2q+qE8lJWkp110qT59PmU0/Yj6e455C/9QuqdqRzuUiZYD+/YmgiFTgLIrVnDeLUD8rb1o4nFEpUat1FgVrzBgy4HCmmtJLGm8Tij9RBAPVqLCAJvZzTkfW+58XERTK0kzBu7oHRkgtfwHr/piA8kwl2wrniEcpgORay0rtEEcGR1F6UHsAGVVm699K2CuYUbaxyehuuh6N1TuowGdQKNdQu45ij00+9E2z0Vdoo1+60owvvLz6UG4nfWGyQjPz4WqbJ0blfDqlYsWEKXhpqn/6BuN6wKXbvyqxQPZaSmCbF4qV7RdmNXpY/Hr4Dk0oqisRIRMOpUEgpZ9rp9MLyI8Z55bDW4iSkyasGih0jYQAvkbW8kGSHs5g03CJS6hh0TstIib3i8mCCDBklbVv8msMv1GN2B38IQUdxS2MWyYNQMVKJ+9oGfIqnfAsg+p9xxzRh1vs1JJPPt6y9VOfOBU8SnkD6uzJbJ65Bp3jKeDTgieheLhp7xnKgK/J3GtH1xfshx3MDOadJsyGNMI/O81MG+oGt8+XhBWZ8d0qkd/4Ua2uVLsiegUo8oBUBEfxHCxuDbpelJJhkujMay+SFzB3lOyy8aAGkQ==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d88a2b60-1069-4114-28b6-08dcc37065d1
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 12:37:49.3160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X56914htWDrbwNfVQ2lf7VhVcFV9dqECNb9uJKk6RWEencMqeTDzya/aQBlyGs5gTOFPIMzdm8ZI215/CkwyAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2904
X-ALTERMIMEV2_out: done

Hello Krzysztof,

On 22/07/2024 14:28, Krzysztof Kozlowski wrote:
> On 22/07/2024 11:41, ysionneau@kalrayinc.com wrote:
>> From: Yann Sionneau <ysionneau@kalrayinc.com>
>>
> ...
>
>> +
>> +static int __init kvx_init_apic_gic(struct device_node *node,
>> +				    struct device_node *parent)
>> +{
>> +	struct kvx_apic_gic *gic;
>> +	int ret;
>> +	unsigned int irq;
>> +
>> +	if (!parent) {
>> +		pr_err("kvx apic gic does not have parent\n");
> How is this possible? Aren't you controlling the code being executed?

I think this is called from generic code with values from the DT.

If this node does not have any interrupt-parent I guess parent is NULL.

DT is user controlled, not controlled by the driver code.

Also, I can see such tests in several irqchip drivers: irq-imx-gpcv2, irq-sni-exiu, irq-crossbar, irq-meson-gpio, irq-al-fic, irq-tegra, irq-mmp, etc

Isn't it ok?

>> +		return -EINVAL;
>> +	}
>> +
>> +	gic = kzalloc(sizeof(*gic), GFP_KERNEL);
>> +	if (!gic)
>> +		return -ENOMEM;
>> +
>> +	if (of_property_read_u32(node, "kalray,intc-nr-irqs",
>> +						&gic->input_nr_irqs))
> There is no such property. Also, there shouldn't be anyway...
Ok I'll remove this property from the code and just use KVX_GIC_INPUT_IT_COUNT renamed as KVX_GIC_MAX_INPUT_IT_COUNT everywhere with the maximum possible value.
>
>> +		gic->input_nr_irqs = KVX_GIC_INPUT_IT_COUNT;
>> +
>> +	if (WARN_ON(gic->input_nr_irqs > KVX_GIC_INPUT_IT_COUNT)) {
> Why? Please, drop all these WARN_ON from here and other patches. WARN_ON
> is for cases which cannot happen, as it might panic entire system.
Ok, I'll replace with pr_warn().
> Instead, handle the case properly.
>
>> +		ret = -EINVAL;
>> +		goto err_kfree;
>> +	}
>> +
>> +	gic->base = of_io_request_and_map(node, 0, node->name);
>> +	if (!gic->base) {
>> +		ret = -EINVAL;
>> +		goto err_kfree;
>> +	}
>> +
>> +	raw_spin_lock_init(&gic->lock);
>> +	apic_gic_init(gic);





