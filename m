Return-Path: <linux-kernel+bounces-252003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A66930CE3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 04:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8875B20D06
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 02:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C43BE71;
	Mon, 15 Jul 2024 02:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="r4S4I+cy"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2072.outbound.protection.outlook.com [40.92.42.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C71C53A9;
	Mon, 15 Jul 2024 02:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721012211; cv=fail; b=k18Tg0+ZUotj6heaujcNEey2n8TVAPpp7K/BAc9IyH+4itSa3/viBaejG1n0YVKb1RY8nB+64ZWO0gUpl9N2hgm9aKyDhrc/KEQ+WTdkUNwSCwu/0D6IOQ3P5Qas0ODhk2KkJ5HTej4tuPRrz2WTbNhxGUz2xtas4StPfj6CJMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721012211; c=relaxed/simple;
	bh=B99Nj25RU144ET4AFww48SDDrUNqsGGzKpWRhREabk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P2XiXtFC9HhyXsJ5Pe/IR7L8u+DfrWB1jUEIXUzYj6SN7QTy+wOXkr1A5Il3OETvyTAeOOOhZ27CtXU1BDwmu0h4ZmA/gtQLqzD/FNYYGJtSQ4puCwE4mIGb05vQlUGOHCm7t/7bE7i8UWT68YWJUXio7RyyGmF2hfnX1szLQnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=r4S4I+cy; arc=fail smtp.client-ip=40.92.42.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rC/wiQXPHmhfxc39oU7loszJYt1xyTYcAr20bxJOq09HEL7rKeR4/xSOi0q2Iopa0+5N+KBtg7YRazdjVBQyyB5ak5hr5jVHABtz7WQDN/UkymB1iEWjGfVSe5y6QfXnQng37UjGud2a1H6Bt31DOLU+SADDnHjPrV4EjeKJMQc25+2VrjaJbkI6PzupcNqgkdaKbk67PoysrGN4+oRWj2Xr4wBymrEQAJrO5uWpCbzgMekzRjhtyUY7GE0vrSWseizcmkxvb14kJTkkzY6ntrr7vY2oeqw7LfJA79GwDfBx7rhf/b2w2ICZv3VsYEtyZPuSWkDd9jzj9MHBjJEsjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChyAhydfD512nbPT6/rsfJnsmNf8KQLpbs2ybBYf0bs=;
 b=zRbvsEW3aITVBoHj042V71oS6F1OCGfkb3WyWb+Xu1Fad22LJ/Niofqoz3ZGyFZDGN5C7qJcPq49zghZEhmDxUqbByPuUvNd35UCoJBt0YqtRdIBBcpQja+lR/8ltGSWJeTrrg/KUaR2QwLDafzkvXLv0e5dtIP+Lyy6V1iIZ+PqTeNRqfQXnWZr3rXzlAa3JVroZAP3m3y23tlyuusYWycBd2HwmtLpMe3+GliuAV3+fnV6JbpbWPzm4uLbPGuAMciKP48JW0vLoB2J+B4UKoDf+jwSyQL8M/Ik2RynxhMUR4r1Af47dNLLreIi7W/4Jr/CCEM51NVn222sKlZuNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChyAhydfD512nbPT6/rsfJnsmNf8KQLpbs2ybBYf0bs=;
 b=r4S4I+cyJWa2rsZoCFu+q7WEi/m2EFdkrMv0AA4AdysJ6MZnF4JLKLzKgW69TVEG+W1GLtDQM+O/KqcWk0bxDPli4qH2NAtmYSw9VHydpfsanJQ5omtzCp4XOM3iUo+BF2zBXWnfVphuArMInbhwsmofn6FQgbSLdjtKGppenQJg8d/D/OvvINTUhohW3YJKs+k6i4hWv9TH8Lrl0iCg9oArLaR+L8558m+AB3MlgqMFikqLiUCrA8tQUt+3DjALjGeZHmhViRKvPis0J6a0wrr2Ti2eev7lhG80Ap8m/Z7S4jyx6b5JXsJcdiUcLkMwAmmfoEu62e/3x8wmKAA/wQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by BY1PR20MB7331.namprd20.prod.outlook.com (2603:10b6:a03:4aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Mon, 15 Jul
 2024 02:56:47 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%6]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 02:56:47 +0000
Date: Mon, 15 Jul 2024 10:56:38 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Yuntao Dai <d1581209858@live.com>, jassisinghbrar@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	unicorn_wang@outlook.com, inochiama@outlook.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: mailbox: add Sophgo cv18x SoCs
 mailbox
Message-ID:
 <IA1PR20MB49537F9F04E601413EA1C86FBBA12@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <SYBP282MB223825D5903777B937A8A377C4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
 <SYBP282MB22382E1C032FDE2D36E6B58DC4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYBP282MB22382E1C032FDE2D36E6B58DC4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
X-TMN: [9Z39/C8q2BYapcGFyhM6H4EVnT3BsTYv1EisiBfGBlo=]
X-ClientProxiedBy: TYCP286CA0136.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::20) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <ndrxkx2seolvggibwtr36lcdmc4xvwhj6p2lld6ksjvvjwoyuh@lnjyyjsy4ad5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|BY1PR20MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d8abbdd-ef8b-4616-e48f-08dca479c42e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|19110799003|3412199025|4302099013|440099028|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	zQa/OKjVr3jgflzV5yzlq6Y48zZWx1kTRtgravt5n3brrM+EWNA6LBerIzwi7PqjuHXSEP1iSn0JQ7ZZeSZbysE6O2n7TYiW08KamEuFT1e6ou7bVfwhZ5d3rUx1CzBczK7dtUl204TPBQ+GT2B76Kj71Fkyyo6cIPlYwHKgmT4YtvdYLnqPFiUZNGgCJfD9kpLgZPYYTV7g1xVxBkf/VOdj3koLr++HMhHzTDnEx7l1qT0UqD9KcZ+2ylIjYXp9x1IC3Zo++6ynzMiednVMSHI67+tX26ZzuHdKdKJpMyNKnO8dv0E9TVvLXvSN8cpTg64Wzr05QRBFBWjbv1dDDajWQGaQYS8P0N3S8ZoqOsFyOFnFCCwW5CsglhNGaY0/S2a+C7Rop/y34/e+NXc6S0Ac72LBh8lSsLWftSSduBBp+sLUuZiRDEepR+GcXCRa6zXnkz0u60xcWBD33ZITh2RNeCe6KCKy+u9blPmsLQBNjPXv4vO4Z14iwQzY6VEnLRoThe2Rl/gOHDj8EyJ5cAbHqsH4HH39qKn5ugxUkQo9xEtwvykX+WxF7vqzblAL+dXZQqauxR84nJaUo0LBCyxMr6lOrYnaL91fkzc0t9S6hkJIeIGkpt+pDvtmpqyotdoll1t/WJJ/k77J9TYD5oXWCzH7exGTOVhabhxTYlVb5CH09ZbtZqJeP4vT6fBWNLLlRqaEbT3u/WdLxXloFdOJNKc4BtnnnCpjRHojUmGn6b/g6aKQ5dQekA+Qx+/bcGVaVF9PW1IUnIk4Jy9p29d1C31jQiUHTw3hKbxtqJY=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PYG31+lWzlEJSyO2KcA60GBXPTTBxQC79Ree9E5K4u6Rd4/jTOXsQgzjbGVD?=
 =?us-ascii?Q?6vnOKcLHnmbdcKNQ3L6vI//PoFtyy9/cQBOOMkfk5f++clGz136LLz13QU7t?=
 =?us-ascii?Q?tnZNgmP3pTOlQsHhbF2B+mIQXlU/+b4Y6Daqs6DhcghnmCrGMx+89KXUq/au?=
 =?us-ascii?Q?BOAhbBQGPxZUIOx9tC6Wc17tScbKTtyYbHpWL8DCVnFzAihB1P123ABiUnkm?=
 =?us-ascii?Q?31NXA3Wp7OWHGn+ofCaO3MudmZxoMAW9spodzfdhT44dNm8+hwRv3IhjSu8/?=
 =?us-ascii?Q?wfiCN2brZQHmOZZPaT51UMXKcnnAweGoQ1U1+5Sjg2Vok1JsOVmKmfz5pXGt?=
 =?us-ascii?Q?YxV+rx/kAYUxp42UizhdiJmnpQOo+KFNNTs7mly+nQTav+CLpk7ilcIcvo3i?=
 =?us-ascii?Q?bNTqGsLynE4PV/yT4/63fTRSyPYdPnBde6LooZKPmAGzCzERlAwiqpO1pxOp?=
 =?us-ascii?Q?X0JVpYKBqQ4/T0IUIWA2Uc7hLqSWKYX6QBmDZtsEYjp8G8w6MkSDn0AvxphH?=
 =?us-ascii?Q?VD1mwcnvX8EZXEwyCRC7EsxrGL94DU+DQ+AZJ6SaCNXRzk9qqbs4/EFbamLw?=
 =?us-ascii?Q?jz6ULOzL2Q7rY0+t1zEfCrQOar3TnS95rDtRoA0tgJXABbMY9GIkqxvXqH6N?=
 =?us-ascii?Q?Iwwlu7ibbl8O1y0Nd9xJUQK+0U2wr9TTkZ3Vg3wuTcaisSFh+5hCI5/o+/cG?=
 =?us-ascii?Q?25QF6KAsBmcbrxaZalu2sSAmHgBmfjkl9xUqnOpw1c2ycltRVu0TZTOI3cQs?=
 =?us-ascii?Q?W6q0xfPSvM1d+2xlff5BY9gvij8XCTt7UHpR86wQgwDRnI6QlQ16h9K0ZtjH?=
 =?us-ascii?Q?3XKGqXYjaps4HU3iP6hE6nd/mV8Ql4Xzo+biS4iBuMl9FWq7P6GJEJDEQ8YX?=
 =?us-ascii?Q?BQKdYOO1yTf/ua1gXiWQHVckoKLGHVMrxtoTaCTRkU9+g4pdwDI2HiB4SGHn?=
 =?us-ascii?Q?c3i9FJZCvUWJvun5ueLGMtID209eO1Rwbbgm5XQC/RnTASa0s3uAFT6ChFZf?=
 =?us-ascii?Q?/46lt8t0FQ1j4PX+1q7W7etFbFoBK7WvSK59VvbKbw2hXM49zQNIfH2iHsCM?=
 =?us-ascii?Q?vTPaxRHrnW4Gtp9gidihhNXhzbxgwF9LartW4VSjY/fEwjwOuIpjeZD/kUG2?=
 =?us-ascii?Q?lKH59x9I1gzh8OH+ANzWiCKukMWs+OADFVrOA1P61lis3b8PS/Iy2W4KMbgQ?=
 =?us-ascii?Q?qdpUPBsbi8KayU8xwGIh/1bwUMFra4L11KVHX8ZJ+9EcwzH6ShN3MSuFmkDz?=
 =?us-ascii?Q?z0QJFHs9nzk1xeHjOEbv?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8abbdd-ef8b-4616-e48f-08dca479c42e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 02:56:47.0407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR20MB7331

On Mon, Jul 15, 2024 at 12:36:45AM GMT, Yuntao Dai wrote:
> Add devicetree bindings documentation for Sophgo cv18x SoCs mailbox
> 
> Signed-off-by: Yuntao Dai <d1581209858@live.com>
> ---
>  .../mailbox/sophgo,cv1800-mailbox.yaml        | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/sophgo,cv1800-mailbox.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/sophgo,cv1800-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/sophgo,cv1800-mailbox.yaml
> new file mode 100644
> index 000000000..05099d819
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/sophgo,cv1800-mailbox.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/sophgo,cv1800-mailbox.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo cv1800 mailbox controller
> +
> +maintainers:
> +  - Yuntao Dai <d1581209858@live.com>
> +
> +description:
> +  The Sophgo cv18x SoCs mailbox has 8 channels and 8 bytes per channel for
> +  different processors. Any processer can write data in a channel, and
> +  set co-responding register to raise interrupt to notice another processor,
> +  and it is allowed to send data to itself.
> +  Sophgo cv18x SoCs has 3 processors and numbered as
> +  <1> C906L
> +  <2> C906B
> +  <3> 8051
> +

Unify the "cv18x" (at least it should be cv18xx) and cv1800 in your binding.

> +properties:
> +  compatible:
> +    enum:
> +      - sophgo,cv1800-mailbox
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    const: mailbox

I think this is not necessary, there is only one interrupt.

> +
> +  "#mbox-cells":
> +    const: 2
> +    description:
> +      The first cell indicates which channel is used, the second cell indicates
> +      sending to which processor
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#mbox-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    mailbox: mailbox@1900000 {
> +        compatible = "sophgo,cv1800-mailbox";
> +        reg = <0x01900000 0x1000>;
> +        interrupts = <101 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names = "mailbox";
> +        interrupt-parent = <&plic>;

Remove "interrupt-parent".

> +        #mbox-cells = <2>;
> +    };
> -- 
> 2.17.1
> 

