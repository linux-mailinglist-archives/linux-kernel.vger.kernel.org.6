Return-Path: <linux-kernel+bounces-341452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1979988048
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2091C20DFB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEE717BECB;
	Fri, 27 Sep 2024 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="hXdbxO04";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="L0n4eNj6"
Received: from smtpout147.security-mail.net (smtpout147.security-mail.net [85.31.212.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC5E17E44F
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.147
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727425507; cv=fail; b=ghZj+1X6aREbpqYEtT+i/wBbuCS+6cwWbpGskqUUgl21WR+61L6xTwJlqjioBrCgrylerWb6r3ETWTzmRFXW7unaTo2E/hxR2/SV8otVsgLWgEBqfjGvW4qi9TvzleRLFXCQ2Ksplr68Mxy9dkUz49lma7aptFDh+r9iv/TCOh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727425507; c=relaxed/simple;
	bh=JfUfzdCcv3RO8SvMeEQ+/D1bPtYt59mq89aOVg5vxo4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g6/Pl+jNp5AN9RSdqA/nuMu8MKtzr97M3YGK2Qw4i5oV/dNjCYyDp75mvC0kZhpMvFYSgnbg1NpalfvCPJOIVMGRpqiWhZdYYj6eBfwcIZRoXLZYjfOnagKvhdI4ZrwykF9qOazv1IHBzL0TKkEDFdGkItr/xkPKJfXZL4/r++M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=hXdbxO04; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=L0n4eNj6 reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx409.security-mail.net [127.0.0.1])
	by fx409.security-mail.net (Postfix) with ESMTP id CA97D349C89
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 10:19:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1727425175;
	bh=JfUfzdCcv3RO8SvMeEQ+/D1bPtYt59mq89aOVg5vxo4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hXdbxO04vdcGVieDt2WZ2EJSkW8mgbYxWKcel3GbLFW5sMyyUdfryv9FwY4IcI5Ph
	 kv4/mrcBUdCuh8eqw+pWQbTqTu2plfyA/ECqbqOa3zZTnJRkP469kZkk81I54n+W38
	 Wf08P8AX1kH/Un6MG1kJKMor53tO29KAwe7d2EhE=
Received: from fx409 (fx409.security-mail.net [127.0.0.1]) by
 fx409.security-mail.net (Postfix) with ESMTP id 8C743349BCF; Fri, 27 Sep
 2024 10:19:35 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17010004.outbound.protection.outlook.com
 [40.93.76.4]) by fx409.security-mail.net (Postfix) with ESMTPS id
 654D7349C2E; Fri, 27 Sep 2024 10:19:34 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PAZP264MB3608.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:141::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 08:19:32 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8005.020; Fri, 27 Sep
 2024 08:19:32 +0000
X-Secumail-id: <164f7.66f66a96.64623.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pIjM6ANKn/PcgQoCGf2MEAwH9+AkgmCbLvxHP1LDK5YCkgSWFV9GMc9urNDQHnBti7mlP0UbA/m4nqU1U4rSrci6PnUjCiJyz3bgFDEPpPeyZ/hgAYjaXouttfClMDi5EnAt3CKvXWVmDfx9EoCD69ZHROGkVLLsJod187h7ItCrvblFH8zSzzL7nTh+6CVmUv69SJgxsPdhUwId/AanB9rwBSI5BQ6/7CVvGQsz0JW38Oay1kaebF/XWeahwlF73Y4Zu3yunMRh0ehtcxkFb4P6HDo0KLC6dYFHZl85EQqw5GDMyhzZ+5fnXkUdfadesyNUQD9cGKkUYIkK67ewsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=af2NV92BK69A2g6DXL0TL0Tt3ZZMMoqVpubgjbLWTJE=;
 b=zTUfRc/AssL8Qm+fFwStsSXlnp8R+VBbd8vuSw87wjTWOXg2DBePmXfrEoM5VgTg2FvCOASMZ1yrT3l8VncNA3grwMC5mOjf2RDnCXxfWsPb6A2/xf57FJ12bK9tp2OAIf95IsvrET9R7Vw9uWzbF15A29SWGI6ioBLtWZQ0/S7s6Q8rCArq5GIAFUQHblyG2O8qtPsmk4bqWeTCw1U75iNyicJKfpOuzQJ/UVwV3IbAaDiaqV1T7k3qBsy7Ot8QbYvE+KbsAWFz0DVVPMBujbohFmEudfv3CqF8JsEybNe1Qis0Rpg7mSS316skMp4oCrrsIqFRVj69e8VA302MkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=af2NV92BK69A2g6DXL0TL0Tt3ZZMMoqVpubgjbLWTJE=;
 b=L0n4eNj6uPiWh8WtG4bFX/cqEv4g8xxjVU/r61QIcyhX83/6dxp6XwI+81Q/FIS9ZsFWaGmtf47jH4HwYXQaPjwVPOqIZfmzk5zo5HwtngXOGAuCllWnREDw5XwSWhdE/bvN/LOML8THPxde2hCUgng978lgpQPGS2fgvD9WrXZr9qT8xT1f6VaHQlCkeFfLy7CMZ1+H3tQqbUF3r/p5EdUaoCiShXF7LwwBe5mJobsdl0e3383jBDKhbDOPmfpgPTceTHjwx1NvNJZSw5ar9qgydyLR7YCT5YnzcYU2jlfqVicBEqUMqSR9QWmFpncADlJIyXgLKuEC14AUVwzLuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <b9f3f692-d4fa-473b-9bdf-4ea73b22ccde@kalrayinc.com>
Date: Fri, 27 Sep 2024 10:19:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/5] Consolidate __memcpy_{to,from}io and __memset_io
 into iomap_copy.c
To: Arnd Bergmann <arnd@arndb.de>, Julian Vetter <jvetter@kalrayinc.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 guoren <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev, Yann Sionneau
 <ysionneau@kalrayinc.com>
References: <20240925132420.821473-1-jvetter@kalrayinc.com>
 <20240925132420.821473-2-jvetter@kalrayinc.com>
 <f47e66f9-ec20-4e75-b88f-d412339e797d@app.fastmail.com>
Content-Language: en-us
From: Julian Vetter <jvetter@kalrayinc.com>
In-Reply-To: <f47e66f9-ec20-4e75-b88f-d412339e797d@app.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MR1P264CA0146.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::7) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|PAZP264MB3608:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c4df8ab-1203-401c-0636-08dcdecd1d30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info: 21XWDCN+LcHwBqlaWNs0S3aW6zDGB5kbf8w6TdpwJzgot2DssiaoKWYnRveusyC8aFUcJP30wnNkxVbHJOWGEWj8r2sQ8bOTLYPnN7TIUVB144lD0l/SqzOlaTAecMNRtrVQOth2V60IuJQN+oJMqpvrcDfYwjq9dYQmOF3OVyvmqM6aDlABK4SUTQuBCyV+lDoexb6YT7PS8jHC0cFvJxjx4njK+DnPWHQhW6U/IpCDseajSqoVaJebRAugJJ4xohyFJsc57gfbJerwYGvvEuxt9D+PHclXTO29OfwNEo4r5CH2NJBH8U4pK2pApmswdLzdMGqA9ce1wTQqSU62WJAJ56GgZyPj5gsHQStdIP88WI3kXoAW5UeaaRO6hGVuC01cXmy3nb/NQ06BX6h/qB4sTwkZZk3WB7Ph6jLLIu7ZaCXbjIyOJAuEt/PC3Yx4yeASvLNjIl5vIbkyaeDuQNcvLN1akv2pSDSOqKKJHGhcSOAHN9Q+xATOS5IuDxErLu2lw2VCOi0Hn+9mrccETLGjChVlBJ37A1s5OTI19Gzs4DYFtbvn7x6xFDKlPWMMlZHXhKDA9xjY214A5EgFwk/+zAhjA0/fAkXp05APWLvjjwei1AHz0MshaVWQVBoJEivHanaX5P4BdD1uESmhGI15TNWXqpWc3H+tPCL8RmXAuHA7wKvEfroj02vvQeuFpjHgKaoIoq+s7+WptB4aFlhL0y+/4Lv7Z/X7SRWGM903CPhmoDfgpxzEcTPSSVr33qtNLlAqaAxynavAwC576/GomAlyvKPDN7nc/206ES5P4NzfyBX8EFBNM+N5qzMbwZkP0XN7Zuom90YSiAnhyh0KFcCHYrLXBUSDkDK3brtQXDKOD80pCMI0nQmfkalyNo4dWJWnqMwY7mi/g4mSXFysghpTfFhAK4moSURhevFW34GbC5Md7RT5uJzBVUIJEyd
 nZz1iGp4bV5wq6vsIDjInG9BEz36R3XDUctoREbkprsydSiDFR1BXIAqYfiUlVjjeURibAkaGjmMf6b3h7Kyd3XLRHEF/Blf1v723EM2eReldSDVRikeuISI3IQMsZ4g2tSNTseYUYypRWnGGjZaU+jWLQoP2B0tFbm3unpC3qlUxxTJcptOsM1j17pxfsnTnbBqkmkjzxqf8TPzIhI1PEkyyT+impHk/SkdtWCeOicmw19nJvZsdH29KqMmwy4qqtsokoh+BEuSQ5sBoNvakznlbyJA1Wk8eqJDtrcWTlWOktsSL2E/7vvD+fpxXhVqupFxJdwTh9xl6QhpluSCRlP4Nce81VMP7fakbRV7kBz8MJ88Lb2GD7XFQFjn4W1RbkfHa9SeI0aAu3RKyQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OiJkmhW1rOH5hwzPFZgWF/p5Sbvx4EVyCrWvg59GTwR7nL5lkv1YhsilEJa2XV4tsGWt1Y5HH0UYJj6Fhu0asDqO76wtUvsGS7VNCkFEoEc60oCNyBjwkXxv27fFKFBqK7hfZqzlipRs1y978PUkdxIyJR4/pmWYTlTZm6IYDWQoF+eCcUI1r3IZ4hP6o6PWncIL9A/pW+HsgjdhoapzqphVmVasMRUW7E797kDGpYGD7SqQyM6PkOpmscuOOukMR+xnrXuEeZcW3c/FqCH96s7KL/GgdxXqWRS4vaYBDBET/VwpQVKm3CuU2+lbKaKFoeODOf7E1FsF6ouPoM1It0z3xBlDmzA2iPyCN5MjwMu5pUBKzGCqSuwwhRxNfY4R7dZyOnbtIfeplvKLMfwaiIU8Y3Dt0waSk91FYgDNnNBQfZqBll3L/p2mJMxgWoFBYM19aTE9iN7abf571If/7Qmm/m/OLZZVWiCHy4m3jsHLVwkuZkMdHvON/h/LYcCZ70JQhvexyhgKsLWWIl4A2gEtWCguVnCnvrrqZVPUcoUEfaCGYs+o4ZaUV9K0BJKYbAjkn38ybrLwiGDj9JzWdZW49SyoO/ksnyWNg6SJBtiU+aNO9EtnlQ83VZ1R+X8eZOGJ9mRtOQzdAKklXoGo3+x0OrSfgPz48tCZjbDxbjr5IWJ2kmQJYGSIEzkWuMSPKGvkEMuVc0fcZOZ4LorD1k1q4YajzYXBq3NcBfbEJ+4HpA+Gluaem2uFMN+fpGJ1aRntPS+Q22Egqc8bSZKo3bR05MVt++Qpd+iGI41etfK51NKCSt92rt2tV+Xafr3p2W4rvubD/4X5tRi9oGUjeCreTQszhI0lqDrWAMZQtrgRl6BNQA6hSWFQlksv1jwbKJjwZkh+Xh60Sjq39P1iZeuL+bqpVghCmShGF2Z85O3fGfao/ekXzmnQCrwBOv9D
 gsT0PE5u64feWZj9+t9Gw3jOxeo2gCa5LJbyY5evhj4C/FOKUXNxm2fAlmIHbdXHokWuRprprP6eQZtVvvz0PQMx345TXAetsIdtDdDPgdC5cu/uRXpPH2+KR0Iq4WJsyrGNrdflB5+d+NEkqPXn5lUUXMBVZg6DCYPWQ28Hex7YixmVQLRVgWHnfD/w/VLEf/FsWgjuHrQ0IxMRZafhclXB4yBZwsxG1URsnaxo0ZVP+kDHq00I7XL66ilZ02j1uk2GqZadcKWwm8DVkR0ve3hCd2fC2erPBQcm1MrGTNKm11ZdgWCr7q5ck2hECNrlpbVEMPBn/nTskNW9YiA0ERQ9Z+QPx7CL6BY2JVn7AlMl65OswQtEoSsfzHKWxUMOApUsV74CQNyStFZOAyqds4h3KtWHO7dT+zmq3cUfytYNEZIwk3UnLW84aEOxo9jsQsGS8N5drrmMH42znXcDQZc2CF5f18EJF3QeBVc+NZXvnPT+KeoMk/KIvAuq/dyyfxBGLW1/h1aw9kxZjI5LfRL/peHqVxTTDDAR2JBCax4bL0yhriSwR+3AxKzWWBU2MhkevhZIBaINDGAeoPn3tWKf3cQ/VqGrIY988T9I75PAWaa6JToSsgj5du4/Rd7Koyuv/SIf+SQZFrui/XqSIPlyfKUpsx/y/P7Npvb3EK+XgF+ri9Y9cPusN96XX3Y4
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4df8ab-1203-401c-0636-08dcdecd1d30
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 08:19:31.9852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /41/oV7VEAIRXv5t7NGowjkK2RUxqUR0obez6VcYN+HRPuQkwXftyXxa2RwkSfsHRCxQ/M9FGWThqEugxbcbHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB3608
X-ALTERMIMEV2_out: done

On 26.09.24 09:14, Arnd Bergmann wrote:
> On Wed, Sep 25, 2024, at 13:24, Julian Vetter wrote:
>> Various architectures have almost the same implementations for
>> __memcpy_{to,from}io and __memset_io functions. So, consolidate them
>> into the existing lib/iomap_copy.c.
>>
>> Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
>> Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
>> ---
>> Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
> 
> You have a duplicated signoff here.

Yes, thank you. I will remove it in the next patch revision.

> 
> 
>> +#ifndef __memcpy_fromio
>> +void __memcpy_fromio(void *to, const volatile void __iomem *from,
>> size_t count);
>> +#endif
>> +
>> +#ifndef __memcpy_toio
>> +void __memcpy_toio(volatile void __iomem *to, const void *from, size_t
>> count);
>> +#endif
>> +
>> +#ifndef __memset_io
>> +void __memset_io(volatile void __iomem *dst, int c, size_t count);
>> +#endif
> 
> I'm not entirely sure about the purpose of the #ifdef here, since
> nothing ever overrides the double-underscore versions, both before
> and after your patches.
> 
> Unless I'm missing something here, I think a more logical
> sequence would be:
> 
> 1. add the definitions in this file without the underscores,

by: "...in this file..." you mean the 'lib/iomap_copy.c' file, right? 
But what if an architecture does not select 'CONFIG_HAS_IOMEM'. Then 
'iomap_copy.c' is not compiled and we don't have an implementation, 
right? I tried to compile with ARCH=um, with some MTD chip driver, like 
the robot did and it indeed fails, because um has 'NO_IOMEM' set. and 
the driver uses memcpy_fromio. I mean it's a strange combination, 
because apparently we try to use IO memory? Is this an invalid 
combination? But shouldn't the driver then 'depends on HAS_IOMEM'?

>     as memcpy_fromio/memcpy_toio/memset_io, with the #ifdef
>     for that name that is always set at this point
> 
Right. I will remove it in my next patch revision.


> 2. replace the default implementation in asm-generic/io.h
>     with extern prototypes, remove the #define from those
> 
Yes, I have done this now.

> 3. convert the other architectures, removing both the
>     implementations and the prototypes.
> 

I have removed the prototypes and have aligned the function arguments in 
m68k, alpha, parisc, and sh, which all have their own implementation, 
but had slightly different function arguments. Btw, I have not removed 
their implementations because some of them seem to have optimized 
implementations (e.g., alpha and m68k), that I didn't want to touch. But 
you're right others (e.g., sh) just do byte wise accesses and have a 
comment "This needs to be optimized." Maybe I should remove these and 
let them use the new version?!

>       Arnd
> 
> 
> 
> 






