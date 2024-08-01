Return-Path: <linux-kernel+bounces-270815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67929445AC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 055B91C2230A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 07:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1FE16DC03;
	Thu,  1 Aug 2024 07:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="OjaPZIeT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="oyG1Nkd7"
Received: from smtpout149.security-mail.net (smtpout149.security-mail.net [85.31.212.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810091607B2
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 07:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.149
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722498005; cv=fail; b=AnyAkX5U1p76gywszZvFJRYR5u7bE3ZoIJKxbiYyg8mb1Mg8tHQWj44ncZdLNCPo6DUl7v5k0E4QW2RSis03Glh1+vd3Umr5mrAOEta7vEgRnWbTZZfg5n3ImfG2lZTRT5BOKUj6m5E2/H+QVlLNluPXq5JSI1KlQ1oF+FoJXv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722498005; c=relaxed/simple;
	bh=X1+5Mk1hWsisoaHofY6Lu8WqzGnvnRhMsKDCNUnA/Wo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oDfj+Ueao3+SuObj7CbWMC9+mzzDTkRu7WgCGCm0bakN1nvO/zmIUK1YAKYTT/CWI+CMr9tz9qtjXIYzS9F78ajXRV+1WuWvH12NkYIebymmsGEZzSxysT5+/htkWoFNu7uMw7i33g0bfkDCHcv+MF56oLLnMcBKCwZShQeK8hE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=OjaPZIeT; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=oyG1Nkd7 reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx409.security-mail.net [127.0.0.1])
	by fx409.security-mail.net (Postfix) with ESMTP id 507BB349967
	for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 09:35:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1722497707;
	bh=X1+5Mk1hWsisoaHofY6Lu8WqzGnvnRhMsKDCNUnA/Wo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OjaPZIeTUOHt0m1b5qD1qne/RTXls0q22v2IeBBQn67yjhy12yZJQGdpklgu1cOSM
	 gEiVk1oe9rBugo/h3vyncQ8sF+YyV67Jv0Id1wK/uSyHPOFdZ+laKAlr80AREuO57n
	 0kKhz2+7N9yBh+cS6CRXpNj06FH2dHwWiqkQbKbw=
Received: from fx409 (fx409.security-mail.net [127.0.0.1]) by
 fx409.security-mail.net (Postfix) with ESMTP id 0FC353498D0; Thu, 01 Aug
 2024 09:35:07 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012048.outbound.protection.outlook.com
 [40.93.76.48]) by fx409.security-mail.net (Postfix) with ESMTPS id
 52EE13498AB; Thu, 01 Aug 2024 09:35:06 +0200 (CEST)
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:14b::6)
 by PATP264MB5112.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3fc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 07:35:05 +0000
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7a6f:1976:3bf3:aa39]) by PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7a6f:1976:3bf3:aa39%4]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 07:35:05 +0000
X-Secumail-id: <663b.66ab3aaa.4fd85.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pz5bDWSNuIUQsQGBAES5ieJxGOsS2SQq8f/KOeDyG7/BjGH0JkLTti68PtGL0yE3aGQpPWg16s3AzfSX/aXl8D8DFg2F6GTAsIhTPK6SxeRr5st5iCMgIU856HiNgAoAM4B+BmQEKv7YkksLOZp7jPdZOA6ocUbHR2Z2Tj7A2tsCJmDq1AAcUsNf7dEiaCEsBz0ugQo5dHdIHckLefYBldWwPmkq0kBKYeJ4m5JtpPXMWu2ibNTEUfVoO1gxKMAJjxV2p+MROv5G2wK3ZIWpWSnyd6yNOofJt0Es+uv/UowcAYxzFPa42NcwUSS3KQgJTDX3JnltyEq7BvKnIabXeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61vWYPHkvpWIvaU+uZWDFHJUhoSo8YpvnqtPWN1YfjE=;
 b=oW0u+SaNMVbW+2u/K5RyqU8Ku8wEjWQSvlZks/bQRjvYwMx7LPpT983IdELfNq9K9B+MqCj9GB81i694v1Avcp1gbDn+rZAsojrjzx/KWHKg4P76tqenqBRwE05BuXmwNJfFCqxBOfe80PIKe7ukkNWU343ml1OfRcr63drHxGDoQp9PQcNBq9gOq46NhQbYiijvVB/zGPh1okD6r8zZKZBg8M5jnsDn+KWmUM1RSF1ld/wPBxzK6Lo001UYCAS2jpbbQIaQpkv/zftMMZxymc83zR8zFuODb8y1OBqziB/Y2/HbT7lNjx7y/p0OzrsmcnmYCwTQOthjSJZ1Bs4nsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61vWYPHkvpWIvaU+uZWDFHJUhoSo8YpvnqtPWN1YfjE=;
 b=oyG1Nkd7boNCl9YJ8bbhfGaAEY2f4rv5T94JRRTMJPj+X8Ys6lhBm5s93bog8GR0wCEEQoJNUbKeN4o5LQa69x9WMSqaiKr6dTN7FB6VyjQa7834Et9G2MxyQPiS5GGP0dThedJwIbaraMhHj2GJRb2UMzf7ccsRE7hi6IDJ7IknVbYrnniiZWZ8NxRF32QuwKc9dwwy2C4TEBk/IsH1X+As5N9d8DmqI5ihGC5KVfNvzMba0EiHQ2XXzIIzEaTQAJFQQ47krxnEH/lvfry7qKrcwNeCHuYHj3lIvJgrFGKe4w0pUZsQaU3x+2PDOs3qVKjnAc4jKIyKlMygLFhY8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <c13bc751-5668-4d02-b9de-a8a2996c37cf@kalrayinc.com>
Date: Thu, 1 Aug 2024 09:35:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 37/37] Add Kalray Inc. to the list of
 vendor-prefixes.yaml
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, devicetree@vger.kernel.org
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-38-ysionneau@kalrayinc.com>
 <e4f7caeb-6118-4c85-867f-064308c082ca@kernel.org>
Content-Language: en-us, fr
From: Yann Sionneau <ysionneau@kalrayinc.com>
In-Reply-To: <e4f7caeb-6118-4c85-867f-064308c082ca@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3P191CA0014.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:54::19) To PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:14b::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB3481:EE_|PATP264MB5112:EE_
X-MS-Office365-Filtering-Correlation-Id: ebba9a14-ff2b-41b5-829c-08dcb1fc75f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: KbCERZzlEN/wUx8luz14t+FIVY6BRoRRoDoMz/NHz484nWrT/Wo3f1PBtiJhCZhFMlCDhFDA6QGyq5u6lZ9+tFz0NMqFWonxxOgrEgXizkRNxK+gWG0aysiCi0QypTgWHaaDDoLUubS6UnHgQXrKxqNvK0zmrE24MvnxVz84pu1s6c+PHyOf1XkpK5uBWsMID1M5KV0jgwl21ybmSoNEZyEtiiYbHZOvLX5dxrV28EqYxNFJjWY+kRaecTf8j8muqEzgOIswi2GVZpVSgOyl8F/vqgkfHdNK9JW0rX531qw9pISQag8j0/T+zf933Em45GulW5xlD7jXpBY61FlZIyztRAJT3SYuyYz8U2N17dxzmwkFc3o4AEqmm/Y+Zi9QeZvAcL+gqx6/YYdmiIVzlTiiuv2oK+1A7aFV+R7wT/20Z4UpNK3M431nPCi5AA77WO8eiHUIULloPgYvu/JcSVeQrJd71+bA8ze/yBH5xmcSmudH5vt84l252STqKrhHjqG8hDxMbL6qveFfn0vtaVvzzs8PC70XP8fpyEm3Oe1KZuL0IOMmHseZkILI5e17CXq2l1bW82qpMFVhZSnXKhzkH2p3w0COpdvX4yMqKAp6tQi36ZCSr426Ob3JX5ldsPZTScascWnuJ4fOItfUWSMaZ4kBxVzAWLVlhf/lMXkRLpLZpgwxlaO82olZZuFDrE91mlnjFjo3h5BSHvfBhb1NZmAc1piCeD0Dxe9iO6EJ4euLsTgM09R4bRvbmApCoIM5LfxbozJQXWvpddMOlohw+1xSii2kLNdrPa2pFeW+2aNOupzM8XGkjcRlgW1HAMXPr6txi7Ec9bz5EKxEsjJAB0o/vGTFrr25TPrXWenhctYlgOjn63qlZ7/7V4MtB3hGF3XvDV1oBL46/ePRUJF6/JrZtrolV1c3Lrn6if94WOwxg1Vyuxfh1YqIPGmkioK
 zlGWgwwU/EotvJW+t0WfJBQFXFLPA6qg8ZloqnxYV6Kr0zmNjpVdG6kI3yzrL48zg+eFhNrBNkL4T1EJwXMjZ7MyqRBD05nx5nJ35lI+YnMUS1xbbEzVc2kAjqf5eRXS5bMysbGQz59CPcV7SFEbsd2Rju1WIsdwHs8BzCrNFemmcym1TK5H4T3DUmXdqtuqH6ShTHI17sOe8/FjAmXO0qyrZxIM/I6hhsQImbcfxkYO47njWZs+lJuEIAmLtHGR2dDaxRj4XbmTNELl2hktOQ0J8uC/K3QTHa1ihgea/rfQhOhF9cMfeMiT3IZopiR5mhqGQ1x6AgDHwqxUrmqv4Xa0OUEu59KiBDn0rnxO1nxxTh3/Bmib7SDwYlIUYZoQ27H7w5kyBsCaylnIPMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 75YXoz+oj1ggMOGfn979ydYyRLZuJqjiwT0LePpYEg2kvLCNx3T9imhHN5DG/3mo0jUxXAbmRdgQwyCovaRma9avufEloQw+/vN4Kzoi03XaXmL5I1C4hI86rgZubKfyzRP9SI0IoVScJy1KkG0TyrHQenyFlnsuC8mK+oOj6kF0Zrttj7O+M461vgRh2jsJqM8wHhvYmnZNyBSMhKswj9bf8KNXFJKYCMhn1Dc1fM1COw9YlpGME42Q/YPyMDJNX7DCTIIdKK+ciPQG5D9UibLrmnhFKNTRSLCdm4YWkB1TPB+LI8/JjrLfGuUpI1vAYbn7RjEM6d0VIicXyE9gvlFsMwuSWsgwtc2eJDS4NIEPJc90SqoxYnCac3S+IHeaMGqHVSRyEygHFgluvJSE17y5jXnxMfkqS5ODpZ5R0AlbrcAb4REfJC0jbxQRRwdQ/NtmFWMPmTtynfJ109qIJ/PRS2yaJcppl85E/1HbdmgkfH3a1DrwvEiudANyAeD8kLGLogD1aJBhkx7Gdi+1a0h/F+Fy0HRvmbnjlgoTUphpxhObQpzrfdnAXnXRJEBonjdvTlxpxDH4LXUAEa6V62Cvhdds5tkXl47oaU5qHkGlPSko9/yv33DtWQWbeMckvoMHQHECEN8rxkdI/SlvT3m1uvFd+7pifpom1bOZ2OUZJ3zVYNbh6n+uKIwdyBusBTGh/zPU7xl/4tDQoMrslC9oLt5J980jK8T9ybCTlDm0J8o1CeoZZdT7IByVBia99J2PHJ5riJMIqL0Sfazg4Upzk2Cm+GqtV/obBW3u0rBBoKkLwTun4kpzDKAOw5DgU3vuJRaX+0F1tGpFAJvVG6NoHg2FRmw5hmRCkq8HTAXnZ/7LDv8KjrfNZt6yk4uG1lwNCIxJC5p+q2oErCwMsU3/lWOxcliyyXSNXIeEFHAiRYptkfd7MJonF7vfOMs/
 iWwyFydwECsctImTkciJnG/JaLfO+UEjxE+m6v9brUxeUDmQCmz0TTrsRN0b95SIfs2SGltdKVQlAavIMUjFfr3aW+E3q4EDXxf/pakjUntyW3izPLQ2J7XF/DSxnMyIP/HD1Il7D4ydfqmbBCl9pAjyaAadWPjZfx3HQvtPzPl/Ha9ikEkmDgvOimKmZ6rF+X3+g57/8RemcCwgxyLNKoEEpwWmzHVydCoH9KoRO9uIf9Sb2tYkK/E1MIweMxAuWY5meG6UGIdwQjOveD9ARZuivkJh5NxarWco25xnEWIwCzDYElVuAU9CTitD7FQcT2k0VOMl31IISGu1if3Uzxc3VNtnUtc3Rxkk7egbv0+PPIowhZYl/QxqywUJkBQeRcv7oi/Agx9mH59uOjYMo8Zn+CrlhXWk7n/5CJY5Lc5j89ad+crQv2ywRYJDyIySOU4w2UqbXC7c3e2e/t1Ln3N9eAQAaqCIZka507CXu1kEESx7tGdjoKL2pkVuMRHG5mXjLnIsLSM94n6jEsn2YnJ4ZqNXgedD482kLA3s9C70Uyf8OqszBpwNsBBn8emJEnRxJwgzBpgZ5+fTMnbyBAP8slotJ8D9OypxAJh2Czm9LYqWFTuy+EAyMhFxub+/b5ZXwcY7S3+4JN0JgxwAiZbKBG8THzhJsSGxXCd0o/gJjdF2lVt8X4mn0XmIgAzfDHR/53s++Dzu+h/tcCvu1w==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebba9a14-ff2b-41b5-829c-08dcb1fc75f5
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 07:35:05.0412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxkfUx2o84NkKt9Wz3edFpM/ouJo9mnv5F6epdhoIk7T1+2JbwymqNYmGqVWYdtTzpUJp30F3NviOlLtkWy6NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB5112
X-ALTERMIMEV2_out: done

Hello Krzysztof,

On 22/07/2024 11:56, Krzysztof Kozlowski wrote:
> On 22/07/2024 11:41, ysionneau@kalrayinc.com wrote:
>> From: Julian Vetter <jvetter@kalrayinc.com>
>>
>>
> Missing commit msg.
Ack, will fix.
>
>> Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
>> Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
>> ---
>>
>> Notes:
>>
>> V2 -> V3: New patch
> Bindings come before users.

Oops, ok.

Regards,

-- 

Yann







