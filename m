Return-Path: <linux-kernel+bounces-269402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BD2943271
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58BC2B22CA0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB851BBBD2;
	Wed, 31 Jul 2024 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="CyJDi8/8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="YLsKQWtF"
Received: from smtpout43.security-mail.net (smtpout43.security-mail.net [85.31.212.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6DB1BBBC7
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722437405; cv=fail; b=IPjCnlrY5ZZNCmND9R3RLyB6ir9dUjrGfbxYvJpX3Cg7O8l1VG9F7NUUywu+6LzU4ej3O0+8ivqRwszLvRykv7imkhbjv7q/n1m9sbiv9Bpo5Ch7M9mX5ZAQ7Llkn5ZJzzGdOuNKA/idtUAGYzC1AVEt2wBI7VNlV9dulLUzd/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722437405; c=relaxed/simple;
	bh=molwV3Km+9Hx1/wTeN6ej83qCm38F36J6vIalNsJwsQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GKtYpRBz/MRegKK7VXVR+IRP+aSuqqT4Lxa0DsVyWGJ2kGyPgi7z36zRH1gC8J2dLDi2EQ7J8wovD9RkKMoTrXzeSBq9pjgwmZWl8E1PqfL3HruXrJnpvVObdJzBqHrtFQ3nfwlhF8K0kAoLcT3vHki8vwfutjouGBJXLW8vp4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=CyJDi8/8; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=YLsKQWtF reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx303.security-mail.net [127.0.0.1])
	by fx303.security-mail.net (Postfix) with ESMTP id BCDCC30EFF7
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:47:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1722437231;
	bh=molwV3Km+9Hx1/wTeN6ej83qCm38F36J6vIalNsJwsQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CyJDi8/8AS1LLjmFBMKvh+x6aBQ7ux1isLHTZMRRqIujVRl9OMZP4VyiUltFhqjAv
	 dZ1GCNOreQ9moxqtqdkg6TIvQ0be2SRIdj98X1KdIRX1RETLPicl/CLFopYD+rqiKV
	 61EFtAr1QxOJ7tPnwglPWwvS6M2MUKuOLFYMJcj4=
Received: from fx303 (fx303.security-mail.net [127.0.0.1]) by
 fx303.security-mail.net (Postfix) with ESMTP id 6E6D630ED87; Wed, 31 Jul
 2024 16:47:11 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp17010001.outbound.protection.outlook.com [40.93.69.1])
 by fx303.security-mail.net (Postfix) with ESMTPS id ABC1B30EC13; Wed, 31 Jul
 2024 16:47:10 +0200 (CEST)
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:14b::6)
 by MRZP264MB2617.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 14:47:09 +0000
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7a6f:1976:3bf3:aa39]) by PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7a6f:1976:3bf3:aa39%4]) with mapi id 15.20.7828.016; Wed, 31 Jul
 2024 14:47:09 +0000
X-Secumail-id: <10cb0.66aa4e6e.a8f38.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7Zqin+un+a7Bo00yOOer1aeLcczIFV+3p67L8t4Bhzg8pI9PYv6LABk4H+k/2nNH943Qa65Zgz8JEosK35cw2vG7Xm2yzQzqkDwcqcTumWmsMf3SxaG9yMrwf/F1ds7tNCofg3uoNqbjJpSEXhBYTzhbC7tJjW3jTOjonZzbxt4k+DHrxtNVM2JfPx58+xMiHvR20Asr9ZHJlYferaTN4qyaB2xc+BUd1IiLx91xsEHiz1grdySzFLNCJaIWkVanBYTYYwHR/7d3klappYBdrcqddLEca0ahFwOb0b9TspyX3cXusmxbZD8Rsf/Z45eKr7UER1ikStsIza0wIZ+0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRbXJBrR5uhwiFy5AcY655QSp8y5EZGfwJtpA3i+A1w=;
 b=nwfe8+u32zIIDTab3pS463jNlqWiK+LNOLJN4IO/r+OAZnTl/v/EjBK/gWYmrbLPOSx1kZ6qW4x3MQZFyColfamgUy6J0UbNFrN0ganG4tQHXM/KIJhyg9FlozknmN/b6IxXyIHR3UKUQ3gRNFkbntoT6+tzbvMzifcxzyNlFINXQtSaTL8M9rttbejiAdF75Ljz9ythLaMFeaKk+mYc9iuRZLeL9x0qCS9y7hZQFbEJSZKdWb6YYhGEkbK3ZCoRT9irdhqUfoJ8eyJg+h9hNHto/wOafJ52EXmZKitKrCB6D2Oorltdz6dgD0SyhKQP9u644s5MLHAh0URN4X2wjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRbXJBrR5uhwiFy5AcY655QSp8y5EZGfwJtpA3i+A1w=;
 b=YLsKQWtFyH8jpNOxqNhu4oX6HxpasJGYJfUVKV/z4qqANATXUksZyyaEIffjSfIDbzxRqyjhCzK00O7SE7aYmLikJ1nyZ13I0m58Xc2DpfopnQ17IcE333G1N+6kwKZz7ZMEZ3bOsx7xBy/J6j+1GVjmJgI6KsR8B/uYVljbNqFSXSYBw80JSAHtrce10aSgGj302RH/IuPTn3R0dSLwypvVdpYtlsNFb1X0YYMCOpVl7vdqPGgE1H+TeaTi4nIjJgsMA4a7WScnLh52wx9RsSLyPn2LEmLGfBbVY8Dnu1S3LLeQrGKM5Q9K4EFBnJe5zL9dwNBZzQAhB5AbZrgR/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <8f604cbd-3afe-4409-b6f5-a3d0795dea4e@kalrayinc.com>
Date: Wed, 31 Jul 2024 16:47:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 03/37] dt-bindings: Add binding for
 kalray,kv3-1-intc
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>
Cc: Jules Maselbas <jmaselbas@zdiv.net>, devicetree@vger.kernel.org
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-4-ysionneau@kalrayinc.com>
 <bcf385af-3c2c-4e1d-87eb-0810046f5a4d@kernel.org>
Content-Language: en-us, fr
From: Yann Sionneau <ysionneau@kalrayinc.com>
In-Reply-To: <bcf385af-3c2c-4e1d-87eb-0810046f5a4d@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR2PR09CA0016.eurprd09.prod.outlook.com
 (2603:10a6:101:16::28) To PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:14b::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB3481:EE_|MRZP264MB2617:EE_
X-MS-Office365-Filtering-Correlation-Id: 54dba498-e2d8-42f6-6a7e-08dcb16fa790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: QXIvocsokmSN5qfaf44qGd0sjMA7Js0k7WC7sPd/60N5eTgXnnMh/iecuCOwwu2qsnzy9waXI/x8TcMzQNMNbxjU4X8zJP40+lbv8T/ZnMwz6bBNEYmev/wU+bhCAjgKFYU0e3QGQZcAVrv+CBf900rdrPDk0D4KCrCd81LLGch4AA0iJxs/K7c01BxcAZ8W1mc3DX4vgQKSw3wrlvVLcVE+BABBT4t8oLsxsAFBeEhF4IX5Es2F/e5qq9kDbKOtY8W1t5rtVWjFP2hBsdL8hvsC1Eli49eRFZ9MARItt33RSp5ttxeoDCTgh//nkaBcoOSI2RWGVY4upq6sKL3092cQIUDLf8NdoL2fokAeTgICfGtP8cenh3MeqI+ViEiUTNv0CL8uQ/bLUXrIYdNXFZU7mM79hOTOYXw43mfldiWL6kFobeOeFcklZXmnis6kzDtePhFV2yIyQ2ElODquWK3dmaJM7+kd6DWq5lFnTfoppO1vNqrYuw/ANM5aVoRlmCe72pAPySdUU4hf1A58PqeoaY5m1UmoEoMZo3PXHCNlitBzB+TV7XocQvSaD/HQvg4SAbiU/WYPaEUBLzVg3ksngYZ3vonikPWqDm5zag+GtwoxyPJUtIptO2MvRR67EJo5Yl7L5yLQdW3h+gZPGDp2wGC1r2x9IOgYWIklUM/G2ac++V8+NPANymEvdf4+aFsSk3rQYudRKP1DIaF/V75MiO6OjH3xKusdmXYlrIU3twNx0s5GunIGuRCypdKMqLSbWXxUwBYWpfBTrnPfJp/slOuz43gb4f0f8l5crIWQMEp6/n3dZO2QRYXJSxZy384r+aDVIkQd4X3sLs/qqHq4M0NG3FPQF7dyu0mLqq3rlQXUCfL9ZFOgY1qM9rIIwoEXOAaoxT6JVM0SZ+2SaASzpx6UDHdAcn7eb4cDXCt7zlLzkNzXL/1AF1rscphK0Sq
 p/0MoEtikNRK+AxUhimJ0zzToKyJMewlm0j+qyO4nGTtXTaPhmyH+ntRVKYf8MSYUdjukv94O1Jfxgo8LA/EikYEb3zWbJdBQbhh0gKpOBKBjp0BjMMy5jptYQOK+zSPNXzTzHUZgDcfQ+wW6DHQv04W7MKDNUv+FuCtdbwNMAo3GDiLXhZNyptLJQLijX6aN9u4ncwZmPe6MsGYanh7pBETmGahzZHKhpVOXJEpKY5PRrb2c9vcc4+UhMbk1NpFZvfjMhpSGRgZ1cMJPG7/Qnue+DF90eoENnYl/JAIGfhiHUNSnkm4xba6Y08rQ3BPwjPaYCgGeAjM5hGVSg6EPdQU7k28/u6eK3QIEH7Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CYhx3tjY2Sk2m0TMMXciwa1infOhnMRNMmBxsu7Vg8WGM4RPZqdWJGpCZcqXCYoR5kdxqUHKXtroXtEi5r9PijqUBMXbxN02UXCScNVKLBoi7XG/I8r3ZAGMV/buKUAfHseRrneNkoedk2hkbULGVtQ6pX3PPNeJFIa9HDQmKUpnBSGYVxQRjkBsp0Tm3fCWIoorfPRlWqJdVGnS3pTv2aT73Uez3LsKThMpLw86rDhCRweRHkTi7d8AGWr/58q49ztPjzVX1WHRfS08bcBdfDj51FGTNYqVVe4tFg230nASxfKKsR2iyH1YOzOExgDnbkpJVOTEDDkYaAi4qpbAmd1miyS74xmF7okO9XUaszQwtoR5+fr9LvOsaPDt00+wzWVQD1zcrLDa2krO3DLcLJWg6Vv0FG6INRHAGUEe0Ywhe55K0hfxQVjK+BT5SB4lH+mp8s76Cu2fdBCmEe/GsuyNOAXUdODswsEN8vUUZfXVCsjoujo9/RkH6dIZS4rIvOPJF3WNpLzlQH7jWBYedygZheZZVDk1vcgodf7oOPaPMguUlOkQ8dGN3caovlELx8uJQLARFP5VyW9rNnVb8C/7Px+Vpm1j1vjGfE7LWF8B9wroHbz8Bfe34zBh+UHrlgzolEtMnagjoezFYxEBZSyQe6iO+4v+vmkuu2BMt4Texh8m74L4zT/7KWzrsHax//y+vFTAecmZPgN2iXiGIYp+1ldCU7tt6WLqYDY5Ovr4B7oPrEt9pqEqgD7cR5tsWTLJThEYiDRNnoyGouoqeZD36CBoadja8xUBAH6keCfM90W+3JV6gi0uKaxjKZg+XgiRzNjUbmM4ePmLujjgFzEtHX1qvhdgzZUH/W3tp0MbqkE56BkXKPjb5ZDnVZ+cLylguwbmtiWNW6un+4t+0HcTaj0NrSwiYHfTTbKFhVM8S1U3YqhnOJkQN8MemO+y
 03vnKp7Ae9PXCDwDUCVFsUVhTVg71U4pUQfe9qzExxUCGPBbesv2MR1+SL1c2vkAqwc/E96K2aLrTwDx7zCDDIy7bTIBtK36BEFY5MtqRSrlgRcOVcjF6Ce3kD29l1qXDmc405qPeMboj+tcKp3myef4YJ7MBFlzAKhAPju/5jj5TPMs/77a9BX/A+3fKciGWx+8hnoFwAJDeGYRQAyx6XfF0rSA1jGpHRH5TzPazaGqUKa4CzAfJqsNSUjJvAdaSvo9HnhCLRiQEWgdg1HCKDrDn0TVGt/3vkL/VyRLb0shr+UtUPNgt+HxH9kNFW8l+81Ttjv5FrHRJmdQ8obZ/gzZKrsrp0BWpsskJZpev39V/ekFwzldmwQ/qjtU4l9DlB7TpA8yeEciUCokhC4lmjoQiCV8m1jqLxhy6jk77+h2XBN1Qf8Ot5ELB6f0o5ofUoA7E+jNTseNexjJT9AqQZn+VToSXZuhzrskip3oTXHNmoUETm4g2/3Wit4wfSxodQQ75jKwZNzJ3/m2/4ZpoKkULTVvjNVxHJA2VUwST+BqAZlHjDPB9sXTM7ShA3Vl8o21DzZ9PWQMwK4X8HRV7B7Nv5XKsS10/Rmumn4YrWGY7d5zw5FdAdbjlN62V6HHSlMXj4GXuRf9xGefS0t9k9GVclPrZB9Y1+Ivkhp+diezdLqxzEb6dvJ94IQmqqILenNybay/aYYRN79ZabSMew==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54dba498-e2d8-42f6-6a7e-08dcb16fa790
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 14:47:09.1585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NU2cIXHe72pw9U6MnAwfZhKsSz7sDxttcszwgDF4Cbt4o6Yn1//hAUmZl2OzWNaZ/YMro4m9oDapQcMRPJYNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2617
X-ALTERMIMEV2_out: done

Hello Krzysztof,

On 22/07/2024 11:51, Krzysztof Kozlowski wrote:
> On 22/07/2024 11:41, ysionneau@kalrayinc.com wrote:
>> From: Yann Sionneau <ysionneau@kalrayinc.com>
>>
>> Add binding for Kalray kv3-1 core interrupt controller.
>>
>> Co-developed-by: Jules Maselbas <jmaselbas@zdiv.net>
>> Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
>> Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
>> ---
>>
>> Notes:
>>
>> V2 -> V3: Fixed bindings to adhere to dt schema
>> ---
>>  .../kalray,kv3-1-intc.yaml                    | 54 +++++++++++++++++++
>>  1 file changed, 54 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-intc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-intc.yaml
>> new file mode 100644
>> index 0000000000000..9c8bb2c8c49dd
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-intc.yaml
>> @@ -0,0 +1,54 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/interrupt-controller/kalray,kv3-1-intc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Kalray kv3-1 Core Interrupt Controller
>> +
>> +maintainers:
>> +  - Jonathan Borne <jborne@kalrayinc.com>
>> +  - Julian Vetter <jvetter@kalrayinc.com>
>> +  - Yann Sionneau <ysionneau@kalrayinc.com>
>> +
>> +description: |
>> +  The Kalray Core Interrupt Controller is tightly integrated in each kv3 core
>> +  present in the Coolidge SoC.
>> +
>> +  It provides the following features:
>> +  - 32 independent interrupt sources
>> +  - 2-bit configurable priority level
>> +  - 2-bit configurable ownership level
>> +
>> +properties:
>> +  compatible:
>> +    const: kalray,kv3-1-intc
> What is the SoC name/model? You use "Kalray Core" and "Coolidge" and
> "kv3-1".

The SoC name is Coolidge , it contains "Kalray cores". Kalray being the name of the company.

The exact core name is kv3-1. The core is part of the kvx family: next core generation will most likely be called kv4 or kv4-1.

The question whether to use "coolidge" (soc name) or "kv3-1" (cpu core name) for our IPs compatible is indeed a good one, we talked about it internally at Kalray.

We ended up using "kv3-1" at the beginning of the compatible when the hw IP is very closed/tightly integrated into the CPU core.

We ended up using "coolidge" when the hw IP is just some general IP inside the SoC (like the IOMMU, the dma_noc).

The "intc" or "core intc", is very tightly integrated into the cpu core.

The "core intc" is configured directly using core registers named SFR (System Function Registers) using special SFR handling instructions. It is not memory mapped.

So we ended up using "kv3-1" in the compatible. Is this OK?

>
>> +
>> +  "#interrupt-cells":
>> +    const: 1
>> +    description:
>> +      The IRQ number.
>> +
>> +  "#address-cells":
>> +    const: 0
>> +
>> +  interrupt-controller: true
>> +
>> +additionalProperties: false
> Please put it after "required:" block. See example-schema. This applies
> everywhere.
Oops, ok, I will do this.
>
>> +
>> +required:
>> +  - compatible
>> +  - "#interrupt-cells"
>> +  - "#address-cells"
>> +  - interrupt-controller
>> +
>> +examples:
>> +  - |
>> +    intc: interrupt-controller {
> No resources? How does it talk with the hardware?
CPU configures the core intc using special instructions to access SFR (System Function Registers).
>
>> +        compatible = "kalray,kv3-1-intc";
>> +        #interrupt-cells = <1>;
>> +        #address-cells = <0>;
>> +        interrupt-controller;
>> +    };
>> +
>> +...

Regards,

-- 

Yann






