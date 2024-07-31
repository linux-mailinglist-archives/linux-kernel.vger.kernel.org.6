Return-Path: <linux-kernel+bounces-269363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 401CC943209
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52C5E1C21E9C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BF51BB6AC;
	Wed, 31 Jul 2024 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="EZ/Rlhwy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="h2PTl+GR"
Received: from smtpout145.security-mail.net (smtpout145.security-mail.net [85.31.212.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C118826AE4
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.145
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722436314; cv=fail; b=XfeMWtHYEAiJjJR/lQjvD7OVV3hD8rEbGNK9Aj7YeDtliDRyOgLOvssfM3tjO/iLgQe8XZRcpa74Nyli7xKQnoiGUOYu1tERgjYFy0ypd9BCNM1WbbUnTkqeSXV+kWkg6HZ+rPxHb8tYtVLJuQbT/Il70Mmd5uE06aaIw0f4kxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722436314; c=relaxed/simple;
	bh=KCOB4bAyoglZAUBsKGZPxyrEWsrckFOjlHpT2xvHqTo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gt3UEPNCNLwFTMlVuKVmp2bwwr16M+a8hPB9RLVYLN7tcUqN1oWO9otLSxtkwmSPNgbd6gC9JdliAwGuH9dkDCEk6vAgu31HzRg8DVXO6sx3oY6cyOFfdCM8FZmWcEFJ2Wlr4iwSQlUGXs61EBlczX6ytvyWfh/CGbalP605L7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=EZ/Rlhwy; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=h2PTl+GR reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx405.security-mail.net [127.0.0.1])
	by fx405.security-mail.net (Postfix) with ESMTP id 82E80336230
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:31:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1722436300;
	bh=KCOB4bAyoglZAUBsKGZPxyrEWsrckFOjlHpT2xvHqTo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EZ/RlhwyIn1VJfrdXnexP3TQZrfllp6py06PPL+u4+BuoqZ2holUuVk4c+ew5OUk2
	 fjFTfSykacWGJU26je4+XzBz8d8mmudLtLDqA9yhQ7N0FObo0jx90yRarrN0wizGWD
	 jpfNFEFHjza1U/Tzl9dMB8mcQh867ot2jjJ9L7Dg=
Received: from fx405 (fx405.security-mail.net [127.0.0.1]) by
 fx405.security-mail.net (Postfix) with ESMTP id 28C7A336227; Wed, 31 Jul
 2024 16:31:40 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011024.outbound.protection.outlook.com
 [40.93.76.24]) by fx405.security-mail.net (Postfix) with ESMTPS id
 61702336225; Wed, 31 Jul 2024 16:31:39 +0200 (CEST)
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:14b::6)
 by PASP264MB5490.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:43b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 14:31:37 +0000
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7a6f:1976:3bf3:aa39]) by PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7a6f:1976:3bf3:aa39%4]) with mapi id 15.20.7828.016; Wed, 31 Jul
 2024 14:31:37 +0000
X-Secumail-id: <3adf.66aa4acb.5c94f.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfDiOCm31wwRcLHXu3qXE3ami3FnO58di9rQA2SWEyYBmCpILUyC1cRD3rHcecKR8swQHqkgjF3QA/Bhe6m0L17NPN7HZ1BBkRaN8ESPrwIeCc26JGVq75USFeY5TzY5UVJPk1H0F3h2N/zJ1qUHgijoMsLdMxM/+BZD/VdSstim7HYOMqMR+o+ujLI28Y8E+PRr/jW2DyogrvcMA5qH/fn1lmqDZaJ5+WX0Lf0I67T6y3e2ZNu2jB2PXrM1YZ3vXgd1X3fsEfC1//GY5qoKAM+2ARBV2f2uc4CNtMBkAJt+Zq+ALbjAYboDTw1gTaEM9tyvXHV2Cxyo217Xv+yE6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9wKLku2+dBb913TVRzIOs8cC+jAvoc6RMB1XyyCeWE=;
 b=UgRLSe+juPhTL7jVrMG3cAkr8l/GM30k5r4GLp0Gct9fw3aBwQzWSM/UdE1YL4aokvy+ZywzdgjJNrIGvNciorPiM0ml4GIZJPzJ83jjzfOLyNmQLN/FRekTf4hljBRQqS+NKTOO5HYgO8tbaR+481pfJAgMjZ2i+WXQs3ozIPRK4iCM7LgfjfhZxHsefcaVwKwGgvh4jMH1xo9XpLpJuyJAj+C+GtQii7j8kKGVESQCsTjyQIEKc3omc7TqzwogGom4ooi4F3T4M0eZ71rJrybXyoP958bkxKtqWCPt5zMqa7fzsM17kQERIRCcOzM0F2jf44iywb8oce8zwfiI0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9wKLku2+dBb913TVRzIOs8cC+jAvoc6RMB1XyyCeWE=;
 b=h2PTl+GRxEtLaOUEPkNoaTuze10hcNKzBO/qzzx+oKyGp5BKFlePAAMiS8Lxs0xkFPdnx8qiTec5GiDNikwQzHyqRudm5trQR9kR6ONB6TdMVq7fPfOd4P/jY+1erYH0mZ9Bo5XB15qLDSa23mKOwu86tUVCbOTsg6OHd3aDRYbr/ygm4vVddUElIhZBWRGeUQuVA3GA/lQ72k1AWPudLHwTM5glKP/v3fzBZk+IJvjcQE/VxBc0Ugd8NLVJtD8LahMzSOrSB1yvrIGuwaRPESfeIaVl0J8N3U5jpDv7sm75Vi/IC/P06jRKveP07sLKvy2juv3GHUW3jdA6f8bFZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <37f5b278-921a-4ccb-8f70-e8bbcbad6576@kalrayinc.com>
Date: Wed, 31 Jul 2024 16:31:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 02/37] dt-bindings: soc: kvx: Add binding for
 kalray,coolidge-pwr-ctrl
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jonathan Borne <jborne@kalrayinc.com>, Julian
 Vetter <jvetter@kalrayinc.com>
Cc: devicetree@vger.kernel.org
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-3-ysionneau@kalrayinc.com>
 <2f95cda2-c061-4b0e-9f7a-3dc48421281c@kernel.org>
Content-Language: en-us, fr
From: Yann Sionneau <ysionneau@kalrayinc.com>
In-Reply-To: <2f95cda2-c061-4b0e-9f7a-3dc48421281c@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0012.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19e::17) To PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:14b::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB3481:EE_|PASP264MB5490:EE_
X-MS-Office365-Filtering-Correlation-Id: 69a2dcf1-97e6-4173-82c0-08dcb16d7c42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: XzjPgWc6QrUaWcNQcMc1EWWkYDpVJOjAyordQOgg0wvKY4mxgwG4IMzyROlxcNOGuXeIbADbYQsWa0nLoJD4+EXUP7NInFxX9OxFbvyBbXYx8WwF9sC4ROBug1U6285H+PVoKSI38XrWQWOt3xVOHVUpbgzkIMXYYsPvOs9RoxnyUQPgfA9BhwViv1EjmSTNwZwrP5BkMCt6zN8HNr5bDrgPTwf5/7O1YN6jDR+K9ngJ3urLSClTDfOm/W3q6fXPQtu6cpGaR4BjdGFMmDlCSsBbm8F48u6BHLaWDEFwJ1X8xOieyB4ppM/ZgbQDd6toAb6hoxtUhDSTV+0XrrcD1eyTlp0dGcFQmnuBYOxrjzpCvZGQPcu/wf7ew/X1ZgjQpYKlmGEYGaDe9SONbyKKI8m7uLgT82xW2FmHO5glN6sBQU7DS0zKUCdOP7/apnmllzo1hm57M6tFQeZIZTGd9DNN8nHXuoRvkKNS/+R88kPQf8AeA2xXhGD3VodhBdaZDucSvKuizpql/jJM1n77IycIUw9XKaEGE0I9dgbGon3WQ1+oxqUR4sTV6nRPOj7CGI+oKwl7j7GrB6YBWKjA13Mu+2DmbM1YXOVA+VqJOoa+P7PurBuuH7P7UgwvXxMCDU1HFsmBa3qQ6paaKxSR6tJ2QU3Wnh4/b3I5ad7fVPrMJ8KRRtfuNAuJ2vkHYeqy2LeG0VTRu3NfsttCv9BdNyUK7R0c2LAA7w3DUbhPK9A5G7v7C2DS0m3W0oACn1K/oAFRNXJGe+TQQiemazSE+s8pV5IuHOvnEiTbm9pui4BdkZ2N7g/TcMT/aUx5v7XzfQezHLnr/k6X5Dl1KmUyZk6SqpcsIkvSMKpth4KM8i0RlQ0ua8Nh9+9MJh9G0/VKeYMPwBIAXKVluYxgTSjd9z5GcUuUVM/FxxM0MYcO4Yl1MTG6oE9nEmGIPFseP3ODx6P
 h0Ap6eNcVzMHsoPvI2/7xKEY+13j0Zp6hoDdMw/0iI36MvP/sPiNqg48/iVVGNd5+olCxhC/wFOiyI1ERPl/e1wJSyAiM6Bj8Fju3a8Im2//103yFIjd9FN5icjYJGP2RADCrEPxJ6dDyvDYkyRWs5hOkGtOD80V2xwta2BiHpSHYwhmn+e9Ev0SeijriSRQPVhv+tAiax9fECMHQKGT7z/sDelBz0jlOJoD8TeBZnUWIgAfR14OpQEpAwzyPbMXzxriGaQ2eRNmkb6sBzxvUTju67WuHl90LXAdbrms7QKtZxRUCJXg1WbM6xP9nisnhX3klTSkHw5RSj9WGaz5VLGbOrldiDRy2tg6+pYc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Fnp9UMgQDBT1yWrzF6UnZn1wQWc1GKOBq5QDHYHEPDNcdacqxrfdg2vPkGUlied1uEwOYSWgd22qMTFj0fYFME7KQTiGi8hql3Wcj/Y1yZfDno1PI+EskqRfGDWOySuyOsSCWTmeAmGos1B45UIFe4MXyJuYLfbXtZrCuy1z8iViPzjO+Z4108W3Re2EyaWGpFKJhuNnpgLm0QC4wtwFkj3ITjHOfuQ9ICFqx0dFvr8R+vLCi21LYymV4TgKxgWbrpm/ObyeVQjHC7eOFrI/LdukWiDH0BRTgigcBU0x8Urn9sTJTkzynncHa/5sUVy57Q6Gl8RUw1C0Xie3+AavB/g/ZACX5k0mUWYb0rskkQe/CKdGyieCOLi1csjaT36iJPiJ4OPXQqpM06ZN8GcdNAwplrQ54C76QLzeYGAfMge3QGnV/8m1Nx5it8HdMzyHi2F2RWeyCmzUjs2Y2uie6lU0RjNYGsU2I1X6jIQ0BLpBlGGJRltu6e9ETwKz+xw6OR9eSPXtNv9BHrzPvUykMFdAFl2kkcD2P3EXsBro5zbPeVJQUCC+iRruvKelFoxvel+MSLFjRNE0NaojxreuzqtkKvhHvgCKZvtpR5KibXLuTdezdB9c3PTfFCaKPJPwSXRykQwW7n8DxONMmBTD8xsXbJQurEQ/qSjuQS+OVjd0HuF6VVyOOMIzO7stMfeTibFsJthC5CvVngAsaGq6xJhcTHCYfIqT2AkeSg5P8AB6YcPifEFDQhEbGYnNpHS3FMLlYeGev8in3AwNjohfAxYAS/JyOhda9B8cbprpXhyygtB6JNfj0LIsktifG/pebfFRF4wh8u++ojbc4puqHFdX/eMn9TpyUkUPUqmuu5l0x248rP2XNNwywu+Z0yvazeJqxGIdIOaDUzDMX7nD7p/Ijdc5rIPbGqILvZmpswNIHkNZZVVl86RNV4hf2xyf
 e4Z8vhJuJbh3qCQ9EgeY7fAemmgIafGoSYP7Kk5J/v6XqoJ+hi4qCCwJloBjkcBtATNCY7thFo9oyIpx04tP77s3VY5ktRQGTTvWSFoZ1yonEERSN42cGn9khq3cS1yHRKw9918xSL7DkxezY1Z7D02lLVLk7lm59DVSapPedVRSXdJiAzseAsaxKQKz7hizxP8vDEDg65iIEJ7bl11vtxADGpvhIDXZjHp+elUaUecNHmWtiRl8p0BAjAT3NZMDTj5R03gldFR88h6EEzeH+Dy7ZjWo1t7L876+yw/hFMO490GkWmFUjsexqETZPzUgk9710W3RtUYEasv46h6ZswTg2lJUBivce6y8T9T54uOsyzTfCuU7uMmcmxRZa3OklIZL/HKyulJ4rItUxNeEPpmvJ8i57q5Ph/lpZdZWEvmMF4edSWmD/jQ7ou6k6oq4an06sTupfrCJ+4PaUDb8TrLdZHj3lbNw165LT7pw2j/IdCui0XWiNDVcqHRnT8QF5t4WkVpgXfiSN59g10C4oLx5dHkv36koQb+XFC32I3HnMqCopFgfCpURMZVjzPrHEUiik79PhL52q0hA3EejRezZvtWwCHb260PvmCvE++xHTby/tCG5MG/vN/Ryzi/GOx3smjz9siTLIlLH8YwB5agNZDocyqw57xy7qj452rncf7Uk+4q695kW0N59U91SAFqL0L+UIJNFzgK3DZw09Q==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a2dcf1-97e6-4173-82c0-08dcb16d7c42
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 14:31:37.5914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYeXPO0m+GSC9By6Nln53RejW4XRDutdN+tbxTh6ijXXMifRkemiSmrS1cvv2fOqgOO/YNpiLRMWVmddbtYI4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB5490
X-ALTERMIMEV2_out: done

Hello Krzysztof,

On 22/07/2024 11:47, Krzysztof Kozlowski wrote:
> On 22/07/2024 11:41, ysionneau@kalrayinc.com wrote:
>> From: Yann Sionneau <ysionneau@kalrayinc.com>
>>
>> Add binding for Kalray Coolidge SoC cluster power controller.
>>
>> Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
>> ---
>>
>> Notes:
>>
>> V2 -> V3: New patch
>> ---
>>  .../soc/kvx/kalray,coolidge-pwr-ctrl.yaml     | 37 +++++++++++++++++++
>>  1 file changed, 37 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/soc/kvx/kalray,coolidge-pwr-ctrl.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/soc/kvx/kalray,coolidge-pwr-ctrl.yaml b/Documentation/devicetree/bindings/soc/kvx/kalray,coolidge-pwr-ctrl.yaml
>> new file mode 100644
>> index 0000000000000..e0363a080ac11
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/kvx/kalray,coolidge-pwr-ctrl.yaml
>> @@ -0,0 +1,37 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/kalray/kalray,coolidge-pwr-ctrl.yaml#
> It does not look like you tested the bindings, at least after quick
> look. Please run `make dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).
> Maybe you need to update your dtschema and yamllint.

You are entirely correct, I *did* test the bindings at some point, but then in my last rounds of modifications I only ran make dtbs and make dtbs_check and completely forgot to re-run the `make dt_binding_check`.

Sorry about that.

We'll work on those again.

Regards,

PS: my dtschema and yamllint are up to date though.

-- 

Yann






