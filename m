Return-Path: <linux-kernel+bounces-315373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E60496C1CD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2606C282B5E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949301DC75F;
	Wed,  4 Sep 2024 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="XM7egI0r";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="G3IvoCYd"
Received: from smtpout42.security-mail.net (smtpout42.security-mail.net [85.31.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7705F441D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462605; cv=fail; b=kuhz+sOusIxm0OsRJ8BZ6PtiY1Q7qHzmONIHPMbuixgMHeKxO9vYSRl67khiarAZZzirHYDc4bvx30jJjsfHlGDlqwACkuq8N+cTVqD+Bvj86P4lgZx2TlZ9kU8t+DDSKtRPPh0fo3hBP9KLVzyp3WhmL1LNhF/yz9Z2OeftlRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462605; c=relaxed/simple;
	bh=CQxiSpa3VlhZxAsNM9PPjjaLFmtcKvnoPbK4PYsbyuA=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P72JrF7/z5bNQSX/XhVwxVb8qgfP/A2/RBZyx9uOImDoPM3ZyE43obimbxdbPSgR7A/WI7gcmSbgNWOc3RWnA7aeObPvXhcjqXd0MUPCGiwMENxS2lIxXl2oZhop5rf7l2vIeiI1uQbJZLedbSNiNTVEazeOw9WN5FjJPersGE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=XM7egI0r; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=G3IvoCYd reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx302.security-mail.net (Postfix) with ESMTP id 45D80620B20
	for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 17:07:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1725462436;
	bh=CQxiSpa3VlhZxAsNM9PPjjaLFmtcKvnoPbK4PYsbyuA=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=XM7egI0rDYq+TJYYRXlZLswUaHCOBNYWs65yrCstl9+dW+jvxYDWGBqEucb+rOHFc
	 6egAtZ2Yh3Z/kT351Y2/sxpg9RCLxTpSBhwKqd3JL1H3SB4kxDSQhwFmNWNAUvH4Fm
	 JS6RleSufi5sLm0D9wudqd+Sy1NG/06xirrO/8KM=
Received: from fx302 (localhost [127.0.0.1]) by fx302.security-mail.net
 (Postfix) with ESMTP id 1D39C62036C; Wed, 04 Sep 2024 17:07:16 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011025.outbound.protection.outlook.com
 [40.93.76.25]) by fx302.security-mail.net (Postfix) with ESMTPS id
 84F146209A8; Wed, 04 Sep 2024 17:07:15 +0200 (CEST)
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:14b::6)
 by MR1P264MB2706.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:37::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Wed, 4 Sep
 2024 15:07:13 +0000
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7a6f:1976:3bf3:aa39]) by PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7a6f:1976:3bf3:aa39%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 15:07:13 +0000
X-Secumail-id: <4723.66d877a3.83e23.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XoaK9MhrKjRsKqGpbAG3VkucTqEe6kNKuD9Szz3iHh8NTDE+a/bCS+j201rXROz8TX0Q7TbXe5pP7zCG6VCSh6pnouWSdDh+0+pVW+99d0RLiK4dVH0YW0nb1pZTql7h/aErv0z/Imok3fV54KU/Sk1L53v/yELLlGsmUCz0IvLztfY4evkCWCyvmMP1J22DY0DcQKJqlGGooHTL3Owx2BZ+SuAIAybYmtbikcGeM8LQpXn8lRwTUgcoop6OHqhZz3YY0qH3hMSItc0Lpg68tTDQRjAVcHAzEpVQE0lHADKdRLkalmOYTwim+ry+fBlg5f5yQ5qTyxz3opgo5ygTRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqqpPaWK3JXATFvKZVIblpsrwAGC2wfU5v9mJOfYFgA=;
 b=OJVnk40t/0b05WJcwQv4Wa3Jc0Z1ZDMUmRgpziW5O0c2SeccKYkgdVgnmCxHspXBIGcUTw7P8GU+hGO8FiSSIg95dc/YsCk9vw+osHGGDy4Xw8IQAGihNxHsNlg3we/V8Trk1A/9LGz1wBItA/eoeoze4ezs6TtJCE+sapiZ+OaFnHR6oiUH741EDjD88Y6nCzFCy2Y2sh5MpoIGQskFYUshwUzgG/GByraNjXsWO5qaax620Qx173jkW+p7FCg2rjDIdSXrP6cwiw03v/5TGyn3UfyrsrXZod9t44PkoWxSxpKSj1H/lzi5JUx0x+X2pGxsuFCcx+CSxjenJnRRow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqqpPaWK3JXATFvKZVIblpsrwAGC2wfU5v9mJOfYFgA=;
 b=G3IvoCYdwiGhpIfTtthP//gbfJV+ysIWN3i1jhEMjzwMIq3cSZhWANQ9GI8ory6cr+BubSdjCvM93qKmFBCnSh7bDzTE8SEAJWncebkkaGZMHzKkdiB0+QjA8zDVUIINqQfxcRWDJYD0QLQGV2r/BL0qs4PNxxvRbIqQk3emmnj1YX9Y19E+oZdHZRoUGS9RHQuNhDHpTOIfEgr5JlTUR1U23JA4wk2enq6us272rs33/jH7kq/zgvLP4lYD9L97JTiSN4IEoMJWmdgAufPh1itfELi+9KTG71/pKiWoR9Yr++i7DwXcW2WHVNcLtepggYrI8+6pbKk55TU2AkPD8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <05e23438-9842-4bd7-8ec7-a6a1a04d6353@kalrayinc.com>
Date: Wed, 4 Sep 2024 17:07:12 +0200
User-Agent: Mozilla Thunderbird
From: Yann Sionneau <ysionneau@kalrayinc.com>
Subject: Re: [RFC PATCH v3 05/37] dt-bindings: Add binding for
 kalray,coolidge-apic-mailbox
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Jules Maselbas <jmaselbas@zdiv.net>,
 devicetree@vger.kernel.org
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-6-ysionneau@kalrayinc.com>
 <20240722204723.GA61731-robh@kernel.org>
Content-Language: fr
In-Reply-To: <20240722204723.GA61731-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0159.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f9::23) To PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:14b::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB3481:EE_|MR1P264MB2706:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c2e0d9a-a47d-4136-b4bd-08dcccf341dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 6cfa970dWK8e0nDJltfCcBb5vlXfCbHYcMAQw1XohR9mbokkK121fxRRIxAviYlekodvItPi04tyiOw6yukv1+5WuA9SotGI448W5vTqY2FgkweY0ftWB6CFjX2iLHE8znY9uHSDpBlW9ntFD6H7vzAY6smCdzNY3vLHCZNTfWEdq0k9Km9HUCdVmRx4G3iJV0j6AgDOiDNyuX5+q96mySCWpKHTEoC3Sw3Yox2kKzW2KaoZXmrrWPmhdszn3C6A5+1NpBSaVOjdX9Z6SWFNiiUiSsaiFL7I+rKvqXddZj5S0YP8AXZxnv5jit8KA9eXZju/LrPH3YnbBBIJs7RzUqHg2EFNwAQckJa+10Jv8lf5bbsv3fnu3yr6EMJMyKUvza1avKBHjnT/uhu48LJYLgt9pUIwOl7NmXHmgrBhq2IfozU3Jv8dirfMUAcCxTAvo3Y529UDCOYj6RU+kUC1l2L18w+45854bc2lTc9A2I9RaTMqCec8Htale9dI4TKjxuecoNkeOs5Crulkn673BFwCtNzYUfxJbHVrm9TL9iSACwhud1LSizAHcOhZWGtHXMrIjny1LrZqBB0O9lKttFdcx8sC5oHDCLjKKP/ISKUgQLagnkKGRN31XxsT/UfUx2O7qIQX9YV1xzgQd0fKhYp1wcYpu6KTph1IGI/lpqN1WdKBOfQ+I0HWPWhgD4VV3eFW68tlDmvWsvT5HNA3n4SeYMbBKNmgl3rGyGypDacifilPdYoo1PSVlC499D9dZyyDP7wiXXygyGhC9gkq1B8TMmg1Gssx+nUIiyj13CIJ+GzeURFSOyR2i9iK5TRckW5x60axda0LojTu25Mnn6/V1Hv6vOQD8cUZ76j5nxPNF8yTuj5W2bhhzrGEwCwFTrofUwIaazbwcees1w3iIGF+HjHGKZ7SYzcL8I8PSlMqb/+S0+xB+5futPTdb3lKXVK
 h40MkVzF/yu/9FHccfGTsxH1mTxIvpG+xnshAP2c+TnvXSAq5gJO8dHAikCVohHcu2LkafVRrv6Li/MSRnhHNloHz2rERIOxecrLRmQlfW/9EShzrl6wqzzLHePovAh0zbpdwXRYG8g1brTa1kmPjWGiQ0YNo5kLyxu0x5IxQM9pV/KEzT9UMgN2ov9mgenpXXOZNFif/Djdryyx8kPicyy4JEVZGdopfsxLqgCKQN729ZoJ4MGVOBdp12fj2OMYZS2M3f2g+pxCo+5rlWHaWn8w/H4pu0m9fA4LCCc0TMaYBpDTKczJ1AAM1owFlT5w4laKWq6KvlCxdU8LXcG+V2WhKMWN1KjaX9fGn6yWzrBne2aPA5sDSp0hcBrBgWzee/AISRXsmF08IbkKKXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: C1/5eNmKJhkxbfz8DzJIHCPnqEkl8hy2kvhk2TCo5HNbt7NIfKp0dfAKNvST45K4lQxo2J+c6/Q6Cv7L5gjFSJNwOkwNVvyaW3fanfrCm/yUIVQwsCCkyjBy0XY8KCEyhQ9k4I4qBy/S5/YiSIKO6msJDuapj/hROl+CTurYE8qR6SgzwymySYO6si2AHU3z+GbW+2/30TF4QPW+R+wAGQMT0LIniaDaZIERUbQwgNGj6OGiiEUTjwz8T1gGqkDCBKNHGupeMv09SW037NLgkPnIZtUER1l3UE0yb0ayYNMahe3hF5VP2DaFfBQT+kKvAVh1SGKZCNoWxnFxlBsLhnwPavN03ji1jrEKhMDLa5wNaBbx89VdrX/AUx8qjWrPyj55FqHkbS1fGTnwcDsYhPuOFDLwhiRdBUCp9jZZHc2VryJvueUghXBB8hqgLB/sUtfWM74WcsjCgW01bvbGIME7MSlrxdz812XnjT4sI5M1EAdpzfVmqoBRDJtq3oE+U7u+RYfNr+FqAWahQhCGO4G8YrGKJYB0wz4md1Mu0qixMGTQCPBHGN1nUZdbkt4zOV7DHOTL/k6sMNQXm61zBNLVRO1XVi/8NkJF/Zl1ePvvoPz3d+iYNRBNe3Z0JJMelYF97oP5WxdvLDrI9eSrLNI1CoiUMocS36FlTcvCujkgUrNRJeIS2wwAfDz5fL0T+Kqfh//5nGuS/gHqSzJFJTrfqaCaLdeUwWJNFMKkEUbVoYOBihz0AkPYOQno6ysywkVARAzDU+QghntIHhxPkHLP2arzIaiERUSdh3xHQQAdXooBK0hf9n+q7uEUiceYbnp6+7dcStvrZ9l1YVmg/zQszmnLlTtk+N79Mb05VhYtApSWWbD52gvOgEa1hMMzeMswR6d7sVw5lXkYwTF1wioSL6Lq84caODYHzbfFen3T5vUGKGB5/ezpzIvMDsE9
 iy5V1XauZn4RDEdHhk77i+/pYAk2GJxi7WzNmVyYD7dAwh58bs16bRuZihUjPNq3vweJd03zIWi2cbnOa9AapBlKhnLSHQ4VUDvLs/jO/VS21ZlFTSbSIi9C+gIvljSuW7a1oiItpUsKCWLxWlJdK7tc0lErHI25pFs5mjZPbbq3mXI1FS9lYIj9sZWnofC/MaUn2P9zQFqgeDtlfHl6Z9mqGovNOJVQjbrBguOdlgPC3f4dS9TyXjwgoaOtYNMwB4UvJ8h1EX86TyUO0CzPXA0lOSlpd6D8eTETHGb1Wxevtk8c2BwBCj+odo/kJjw0ecUf+igAy6f1AXjGkAImVv7Qhs5tw4w+QrdbcFJtGQtnmIXQEDLzYHQxNZYekjbZX/Fe1F/ZI3JRjiz8GogjHzQC5b/4g/NiY3PBEdXDWfed/B8UsER2cy6l9LbU3x9gZUiHwJBfM+WvQueV2CuaoWJYjAgKFx5Ph7200jBhLE6eSkJNjkMlPqkw11m9MmZbq+skuTKhjQpsePlp2AoqbQ1Nl14Fy8Sz6aAjQWEbh6rd1XuoKUPYSrwRwSllIO9j1RHlb9pKzl4DSXE2omszxSgotGbDl2NciXYLu6RyEW/yPLhtScF+M9fQggw1JcykAygqPbaBShr1KF+08QG4hAkMFPPvCOEXCbT5dVuZxcxIj1VItrzOfUgUXPsqdFyyFZiVXfXohHJX+NTqmcONJA==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2e0d9a-a47d-4136-b4bd-08dcccf341dd
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 15:07:13.5011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QGpgEQpEzSgYArgv8Q21B4dcvmnMHH+DUiP461E4+gsAZXvDIQ84pccZdSNfv3rWM+LAFTINhUUCjhENbCLKog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2706
X-ALTERMIMEV2_out: done

Hello Rob,

Le 7/22/24 à 22:47, Rob Herring a écrit :
> On Mon, Jul 22, 2024 at 11:41:16AM +0200, ysionneau@kalrayinc.com wrote:
>> From: Yann Sionneau <ysionneau@kalrayinc.com>
>>
>> Add binding for Kalray Coolidge APIC Mailbox interrupt-controller.
>>
>> Co-developed-by: Jules Maselbas <jmaselbas@zdiv.net>
>> Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
>> Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
>> ---
>>
>> Notes:
>>
>> V2 -> V3: Fixed bindings to adhere to dt-schema
>> ---
>>  .../kalray,coolidge-apic-mailbox.yaml         | 90 +++++++++++++++++++
>>  1 file changed, 90 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-apic-mailbox.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-apic-mailbox.yaml b/Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-apic-mailbox.yaml
>> new file mode 100644
>> index 0000000000000..334b816b80583
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-apic-mailbox.yaml
>> [...]
>> +
>> +  interrupts:
>> +    maxItems: 128
>> +    minItems: 1
>> +    description: |
>> +     Specifies the interrupt line(s) in the interrupt-parent controller node;
>> +     valid values depend on the type of parent interrupt controller
> Your description applies to all 'interrupts' properties and is therefore 
> redundant. What you should explain is what are the 1-128 possible 
> interrupts. Normally, you have to list each one out unless they are all 
> instances of the same type of interrupt.

Oops I understand what you mean, this description could work on any .yaml indeed.

I propose this instead:

Each of the 128 mailboxes generates an interrupt on the APIC-GIC.

The interrupt is triggered according to the mailbox input mode and

its trigger condition.

>> +
>> +  msi-controller: true
> "#msi-cells" should be specified too.
Ok.
>
>> +
>> +additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - "#interrupt-cells"
>> +  - "#address-cells"
>> +  - interrupt-controller
>> +  - interrupts
>> +  - msi-controller
>> +
>> +examples:
>> +  - |
>> +    apic_mailbox: interrupt-controller@a00000 {
>> +        compatible = "kalray,coolidge-apic-mailbox";
>> +        reg = <0 0xa00000 0 0x0f200>;
>> +        #interrupt-cells = <0>;
>> +        interrupt-controller;
>> +        interrupt-parent = <&apic_gic>;
>> +        interrupts = <0>, <1>, <2>, <3>, <4>, <5>, <6>, <7>, <8>, <9>;
>> +        msi-controller;
>> +    };
>> +
>> +...
>> -- 
>> 2.45.2
>>
>>
>>
>>
>>
>





