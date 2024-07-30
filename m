Return-Path: <linux-kernel+bounces-266846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 744C2940872
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA9B71F21830
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D080B18E741;
	Tue, 30 Jul 2024 06:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="s/sVjjmj"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2036.outbound.protection.outlook.com [40.92.15.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9C47FBAC;
	Tue, 30 Jul 2024 06:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.15.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722321323; cv=fail; b=jjNB2vfcZH9gvT1lU1aNE6KaISp5rQIv+kO0EHF7K9PLxiTXJNJVF4pN4krUQMRxVUy64RQ+pZxHURI4LnDpY+Y73OMS1M+fF1+/dVW2IBfl8wz9QDDwSZpx8mgLpNXIz+HUHZY1DbGs23cte3OBifbZ3q/LpIsXMiKqSHEoC5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722321323; c=relaxed/simple;
	bh=OmQLM4+IkSWpOp2fAEMUv+01/CUdU8SbEMFd51dRcSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SE321Rc2OiZU3+vIdDv8m+ChStDCoTUNhzzIFDYzIFypY751xdfhISkOsrxi0+BwuAMXF4WZT1DMjX8vknBIi+/nrSdK0oJgYqoDwp/RoEdJvCeuL+mgOj1CRty7J36lDlX0aO4lQ3N1C5q7Y+eXTfHT9EXyF94eNOHaK+vLhvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=s/sVjjmj; arc=fail smtp.client-ip=40.92.15.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRO+cqrLTEUmKTdodXggnP8gSeVtrOI0kHPB2H7wGaKpxcDMDnebgIos0OLTlMdwbBqs4hpdyskxk9Yox5sMlNwfdORFJkYT2KPn+7cO0mgZ64OFxtj0aFGw/f7Jt5dhQ3jo8eKlD+/4EvNrFbD3W16t59CKbviAKGJg15IOSzDLHe+yiD/OBlmA4aVItnCr5tFVeZfO/rRmEG5bM/7NAL4ZX+6ahCHp8Vu8X2nj/21KIVv9bGo3oTlwaYMvqOeJgYzsGInzuh7SkLTxIxcjr8dUBYHqDGHaVNnKz9PA+fmJB4G/N7oiagWuPEcn6W6uooPSgyjSD651lvCE/dy8zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXHNltkK1RudiLrW/7EsWkyYCYWBOHPoEn7gdmFoHJc=;
 b=bTSYVBQrYbcgN6lBMAqv2YB5fe45E2Ys5rivB6G8PPXEvZ9HvE+OFIEX6n4ULPXsouwgNdEKGjtvyQjeaVE9c0sa2kGG84/2W3bJe5cfEr4wJjIJo6kCptyCAAb0iyxFenO8AqN4mzeJYvddr+tl8vzD4dIEd2fktRhcDAcrbUCjKiPZXoAJ5UivtjxwuqUcwFgnGSaBXC5jSIjvYzIrIvttNCuQFvo7SFnZLQ2AkIBQiaJp1Mhl5u7GVTcCpl4u1DVq5efErN7ae/gyzSsx2LhgT8g+ExqoVbu9wYy1fc/Y6vOqERGlwT/TS5DWE4vrKPePcol4OkcAGrC2zAZObw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXHNltkK1RudiLrW/7EsWkyYCYWBOHPoEn7gdmFoHJc=;
 b=s/sVjjmjuQItoseX+1d49Jfffi7IeLSkisESs43VHVH8AEXOU9QGfWj4a8R+/ZiQE1WGboTskRA161EEXuqd1crLUJDA4Fb9HACnowysZC1425M6gd3D3vB01hMDMzMlBTjffo8bmYmfl/ZjVXc7OaqT3Dei+SZ1CMWsFqZmzjWhvdDt1R0BfUMVO/DaBtjYYBjNpsl6E9LY25V3l7gkPdur430cvD5VOis4b5J4Op0aBQwBKjchDa8XDVkod+syPitH+4/QLMtFu2ZSBA6OqtRWZwU39c6bkTZGru8zDEzp9c1xGK9oUiUFolbYG4byUFmdMW8LcgI2C/ka0asMNw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH0PR20MB6420.namprd20.prod.outlook.com (2603:10b6:610:191::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 06:35:19 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 06:35:19 +0000
Date: Tue, 30 Jul 2024 14:34:51 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
	Chao Wei <chao.wei@sophgo.com>, Conor Dooley <conor@kernel.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: interrupt-controller: Add SOPHGO
 SG2002 plic
Message-ID:
 <IA1PR20MB49536DC2E1F556D292C9B63ABBB02@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240711-sg2002-v4-0-d97ec2367095@bootlin.com>
 <20240711-sg2002-v4-1-d97ec2367095@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711-sg2002-v4-1-d97ec2367095@bootlin.com>
X-TMN: [9VXF7fT4+veg2yywh7bJ7Er4NcwuEEyOb65iciECnSU=]
X-ClientProxiedBy: OS7PR01CA0181.jpnprd01.prod.outlook.com
 (2603:1096:604:250::18) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <au6sab5sgycpkd55eg4pfosg4njfli7mzr6pilypgl2blwcnyh@fhntoyp7gi7u>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH0PR20MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 370e0f22-9284-4994-03e9-08dcb061c7b3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|8060799006|19110799003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	dlNmiTZMEQjs8hplW+Vq4wvFF+FjmToEqvrYEQW01QfA5Ga0bWoSAW++T3veEIFG05Gd9YzMU2zWsz9OHENgOGDJqP9GvS/nXVhq7xXOl2S49V6rKebqxOcpVRbtQjZAEybAfl+HRNpKKI5k4fR1PKk26UduTvn+BhfnS7vnjrdZZSrpDvTFXN14wA4PfdTnGu1n9Pxk7Cs6M/She0aWHp3wCoI78Hm70KSOD5/UhmKgDlKWPi9OLPRl66TKNUrHM2CSnVMcd88zJ34k5mLjbqGdlIKdG4ugL1pOoLNAbJPeJl3esZwd3G2AsuCpltMgdR5DomlDNYdW6FgwmnHRyoJN5Cq/8cLG+yuuX6WWmXLEowAXbKreoL8hcyiPwpYprsK6CTP6f/rMC0E22l4SFottLsTYluZ1YJuTtn/lMTuyzffWF3hpBx0qsQGs0rSD7HFQWPgdlL+O0ST0EmC/jQXH7r7Bi3AXO61Y4FsKcOZFO747/raKBI436EX2ZuOSEqE7L95CUkeEKwTEaw2bk4JWEfvlqoC9Uvx7e8ajTMPkKbPpZCj+Y+rq0DuDJJGiKc3dJxxuBD3J55ME9uG/aizmoJg5SVMDDutA/b8igSVggGWsIxvtRGYXGXbalm+1iHvugDMpJ6PHbt3ElV8vp/m7U3B+YpGgDVYy60/+SH4j8e323dh4BUj9th0idJf7eHcehq1hJm8fym7eQ5cuMQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h78yvSytCoSJ+D703SqCuy4Ch16HIlpAuBiUigq8ZNKxxJguMDOXNwOEtnjL?=
 =?us-ascii?Q?igodUQfhy2yVGf3Tu9JWOSy/CyjZ+6fhq7O8GzIYnHy10ZMW+KVZw6c3trxR?=
 =?us-ascii?Q?lX+IhgO1gLRvzsp01P/yk4aRisJIWFkcbRZT0SVShPff+9eTEGplS95TQZYo?=
 =?us-ascii?Q?/e+3AyZzPz5A6bMMJx0F41un69WdVQ9N4ww810rzudVkRR+Dlh5vGLXDshfr?=
 =?us-ascii?Q?XDu0uY2kON7lcS0so+ZJq3CcYk7A5AVK3xAxD9wXE9cJfm2ahP9qVlW1RrDQ?=
 =?us-ascii?Q?IqHhrxkdyCqCWMYi/EyTCSriFoYEaZ/BaDCCA3318KrYmOqtTS3hyEgXF3F1?=
 =?us-ascii?Q?dmTGlds5qM1h+uYwLjpV+sAf1ZONOvV7vTK4qufRFQFns4WFDeYnPBjaj+3I?=
 =?us-ascii?Q?NMd+wyP9j9TLK3VN09h9rteTNqJdSnmRQ3V779AZCNPgsDYjOp2PrX2rRQ8b?=
 =?us-ascii?Q?E2tHfgXtkf7XLWTjAyfQBPlOYTNyZdDtHIFJyvvz5Lli8it8FnqirQro94DC?=
 =?us-ascii?Q?fWZIH/PCzMLI1ZPYnzNGADDcNs09Dz1c5MLeZjAtp+oa+PaBpI0Sm4cXpm4T?=
 =?us-ascii?Q?Vr5pmW94kxK7DYGyfETlNcJhc6ZJwHzgwy+Bgbb/uWMibyEZnm1QbiXm6ldq?=
 =?us-ascii?Q?/LtbYp8S6SzuUeINSyHZdKZMO3QG5xSpZDRpg93MyqFvYKQaxLoCoEILUc2h?=
 =?us-ascii?Q?KktLsFVIB79weavBI6R/aTmlIhV6OIBJ5gkfRMWDySRFWmCBjwnRQvS8jdKQ?=
 =?us-ascii?Q?RvcYA2WE88k8oKKssW83HfFMdYxlWYPYJ0OLHT8JyvtWOr3uwQ1kiGrba2Ma?=
 =?us-ascii?Q?UVVLY0yh7UQps5Qxmr43SDLmN/zRr4kwPWX9aGbGixGSYxFpw5EhjLLi0ObN?=
 =?us-ascii?Q?r1J2br3lbOcAm7J0vjPJSyhq5oQOETzHezfK2Z0AJI39T9OpLoWXyFUMWIV+?=
 =?us-ascii?Q?lWpVoSFDxxZuMqwyrBengqafmibO4aHCiZsHfvazfdtyvIotH4/fbHovQncp?=
 =?us-ascii?Q?imHLLcHIrAFKFLwOGZC+7HAsSbNtsjmbKjp8WFIiy6VnbA4srGJjwb5Bcyxy?=
 =?us-ascii?Q?+grvQZeliwbJUJ+MTJuNwqHXAV7dlJJw4HSt1g4y2udVH6x4+u5pmW9ShMbw?=
 =?us-ascii?Q?qi07JUCphLiq+g4+MazoOhSaz1sAjCJLMH72qCBYgb2GmRlORfGbiMWFG5rM?=
 =?us-ascii?Q?xHEx7wbR7psu1nwOMPaI8IGHhl/obiX0sw7MqTQ/DFxbgzSP22ednaEmASO+?=
 =?us-ascii?Q?FstiXyBDWqHVMh6DMmyz?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 370e0f22-9284-4994-03e9-08dcb061c7b3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 06:35:19.3352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR20MB6420

On Thu, Jul 11, 2024 at 12:01:28PM GMT, Thomas Bonnefille wrote:
> Add compatible string for SOPHGO SG2002 Platform-Level Interruter
> Controller.
> 
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml      | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> index 709b2211276b..7e1451f9786a 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> @@ -67,6 +67,7 @@ properties:
>                - allwinner,sun20i-d1-plic
>                - sophgo,cv1800b-plic
>                - sophgo,cv1812h-plic
> +              - sophgo,sg2002-plic
>                - sophgo,sg2042-plic
>                - thead,th1520-plic
>            - const: thead,c900-plic
> 
> -- 
> 2.45.2
> 

Hi Thomas,

Could you take this patch?
It will be good to take this series early so we can test new submitted
driver with this platform.

Regard,
Inochi.

