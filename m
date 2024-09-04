Return-Path: <linux-kernel+bounces-315428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1932296C2A2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985E9281E31
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC0A1E0084;
	Wed,  4 Sep 2024 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="SgoXAf1r";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="b7NeybWw"
Received: from smtpout145.security-mail.net (smtpout145.security-mail.net [85.31.212.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FE91DEFE5
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.145
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464271; cv=fail; b=QY5cwEKY0SEeaThbtRVBtqPQDnB4RjyqWY+BlVnVxELPNLwaJERen9lHSxiyRoPqn3oPBzmaukWH/6Rh+PYvt80Ga/ql5pMN2YJkJs/MM/9tckgKtVBtA+DOSF8+P81MlHP6M0wtoaH6rppCIJuicp1l0qTqFye0bCkyNjfkw8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464271; c=relaxed/simple;
	bh=eYvZk/s6lLR0ltOnI0Vp/6Z1WMuzDGgYq56QlhPi8Hk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q5b0nEiuy7XQnsKgN87nCoTU3h4tbgwuTz27TsIYuV1AnFUTGwrjxRfE1DMb6jK0YOMsl9+QxMsBJeWJZHfm31u7pmSRh9xTLNTGuc+eRkFYVNHwRoK6E/v659lul17Pf/LVK4erRiuPiuc40pEmbgANd7wwc4bVNU00YihoypM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=SgoXAf1r; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=b7NeybWw reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx405.security-mail.net [127.0.0.1])
	by fx405.security-mail.net (Postfix) with ESMTP id 1EA403360FD
	for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 17:37:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1725464257;
	bh=eYvZk/s6lLR0ltOnI0Vp/6Z1WMuzDGgYq56QlhPi8Hk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SgoXAf1rB1OfMajQlxmXvDvFAt4WKFduxe552QtrnZVK5NfFfF0+IUGWXjKdDlzLc
	 FtbYuttOUTvFwS6E5oKw1PPbyppAF+MrtmtR/Xek5H2z1emVIxI3ZAbzqTf00yhl6d
	 6Zc9C+JF1W21HzoUB1tjQvKDAsa98Cd5xoRIr8UI=
Received: from fx405 (fx405.security-mail.net [127.0.0.1]) by
 fx405.security-mail.net (Postfix) with ESMTP id A1477335FF1; Wed, 04 Sep
 2024 17:37:36 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012049.outbound.protection.outlook.com
 [40.93.76.49]) by fx405.security-mail.net (Postfix) with ESMTPS id
 826DE335C0D; Wed, 04 Sep 2024 17:37:35 +0200 (CEST)
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:14b::6)
 by PR0P264MB2584.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 15:37:33 +0000
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7a6f:1976:3bf3:aa39]) by PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7a6f:1976:3bf3:aa39%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 15:37:32 +0000
X-Secumail-id: <15890.66d87ebf.38753.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXpASgbzfFZAGEHKGkn1oAcje9vnIX3OhnJp1O9vQeg37DsnkkcJc8Om5UZ49kvqK1zzmnzv+FkaDbeKzmvciscNDq5/AdS8kx9+63AfGR64D1xZHW6JOdG4DU6nyUCvNPCtmnwCG3fMtUACJHT4b4dpx/PDNQxe7ZS4YJTwwH0ejqsOMksZxwMoK6+Cs0c4ewnWW+wzHBBVkz2v1DNiNP2x1du4M5T+HNhMRbvAUT13fpoo1NrLTkEHWNxvHEGBs5ekcTgK4dCC3fDo7AOpkLmidC2FBI9f+gVliPWlbJGXKqwZ0HI00FqHPo+etuqOSFlO0hixssXxrZXZqoPrBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeCNVY7PHTBNBcJaa4b6aE/xSZ9o/JozPMZwBHWdlW4=;
 b=POMpMamm5r6fnihntrLLjyU48LX6tr9nZ3Ua4TKNrrWIRQn0ailkxxwmFYUDoDALYZq6WmbjY859KZbnh9R6+WPTL4SCC7MWFJhebgb+P7Rqb1vff77t2OKLS0t5vJjtHMJNnSRorjfKkKuDXlrQE45TC8Sjn8OO5oZZ78XQWdKmVFOgML6ITY7IJkAlYbBYtVtMahdaEynbZuVWzF4Wg479kdoFc/7nFOp32AyVprk4urrdN5uBNrl1VdRiE0RBUGmKJndw5CNWmt/3LCQQFKpYFha9bm1k1qWcCnOwmXR/5EoVjLndK8iA7eL5qhKTdQzOrYndRTd1bK42hQvFfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeCNVY7PHTBNBcJaa4b6aE/xSZ9o/JozPMZwBHWdlW4=;
 b=b7NeybWwWUx8ike4MI67sh54SuJ2FOP0MWNF4ULVf0e+zjr85NVAk9B1oXmw3n3BailfeJyU9aSGV0WWMJWoOSEW3ERKhPrBsMA82yN6D0DkuEW0gbllaKkBoCy8amhsTYJL0TLdMLuJhjHrVDo0zW9SoRgIXpEm8WktNQgm5cqHmzxhiM7hSZUBZnsrKMRIJjIJDNWH7iy8dfWNVAvQUQq7e3Rbt0u2YF4Y567L7sXhuUK9eUHAtdk5WUXKyGrSOXmFfMJCrN66S8aVKCOfQiWoK54vJs3/5Z3qaMCfv+cSFpzoXfRgVo9k8K7OlZfhn5yacl7XrXeFRMVmGOFPVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <870f33ca-2704-4e21-92f7-1e8f3150bc8a@kalrayinc.com>
Date: Wed, 4 Sep 2024 17:37:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 07/37] dt-bindings: Add binding for
 kalray,coolidge-ipi-ctrl
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Jules Maselbas <jmaselbas@zdiv.net>,
 devicetree@vger.kernel.org
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-8-ysionneau@kalrayinc.com>
 <20240722205030.GA68733-robh@kernel.org>
Content-Language: en-us, fr
From: Yann Sionneau <ysionneau@kalrayinc.com>
In-Reply-To: <20240722205030.GA68733-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0182.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:236::15) To PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:14b::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB3481:EE_|PR0P264MB2584:EE_
X-MS-Office365-Filtering-Correlation-Id: c06c5d42-732f-4cc7-cb9a-08dcccf77dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: FujbxbkAgMa44SB2vnenU1qNgnmJW3FJ3cDrWuxRZmF3VscddOvfgjZ03MOBmccGAbOqOR9ToS1N4hJzFBVs0dHapr7uFrEBFG5G4FdFaMdwfBCEtUB3Nf3YCOYbejXT91tM+GzTnx1mXEOq0esHQwalJeg6f+DWF/8nTKynQKqrzVUadcBHRtX+jmEA3kEUENqrbSb8642fd38byxStq97MkwVgM6Ff00Y1WoGfdCi70aBjoRHUhcsUkILBgKWjF4JBhRc5xCHWE3Pg48p605wqyj7rVqIYDk2u/JN23VjB2o92cKfdCvaaTxvb5rPGBgGlbjHaG2CDE6PtMUJDRNrPcCd5nWyZPAcQBCaIJY/ca5uh3o/Vm73tt0OIqKv66q4mRmBOAUdqD9GsKha+CyiMN1OnxTXJ2eGTRIFPBMvnDNudddoJcKRZiI7tdILSbYT2UF2F9p24ESPyA+F7qackzUnYsQcPS4ZwnoTJcOc/1CzU0Z5l/UHN1ccEUIJgS1NkjSeYOVdjM5UBa7pdbc8W2o1wJNE8gRbxCNvFgd0MpCRt1B1aUMaTbGarpwEKkMxxkXNWLjxvhUsFqUzlUJZ1JGU4IJHQpjhVpSL7iP8cWxnB0uOynj3WcKpoeHI3Xotu/l6lrR+eFj4Kdw0e6rB2eXA2EqX7gGwjyJmSvMuN/5TruFFAlHKEtnI2ff4k9qdBwI4FNa5Sf8t5KFVj9ZAgqWScGZo6PTp0ZZ9dcSEW/ZtHJ1KgrMUVcHMf3ctA3SEPF6IP7JSFlea68mchJw0UmMB2xJ8LZHVy07ouIthaefrn7/ENSjsC7jxcVm9CpUKNxBQA36dM2kETdT+28UIW81zYF5rvxwBdvlLiLQ/AGeJkKzI5hNe4lVjaHNHeRgxVwPLU95B8xpC3W8wO4cWQ98f67FA+XhTiKDYi7xKGTAnVgz5FzPymxMTH7W4DfY9
 EWh6QO/Sdw9nScycA0Noq67nk7kfM1gfc55JLCnNGmjqpg+D98ulH6FmtEhqFXNEALeOT0XffmdISIrpEEEYMuL3pxWwFQdTAVZn6hOlVTAxfu7YOBLK2nPYC31opDcB5e7Jz5rnQWu+MBqyCTtS/egKq2Zl73t5QmFziMvEIJawBb7GUF+jjGvrM0F8FLclQNC/DM3z+C2rxUn5TxaQdWyhii1WMeAK8G4K1WpzP6LqKI+FmerZD6a+haynuprdyDPCxZBds3F32st+CY9Vv0qOnl2EoS2fk1u6Crd3dgoRgTae0ESXFdOYkO5mpMuD2sstB6NSnS8ySgKDKqaqAdn1IHdFoIWw1qQ6DReNsyiDGzPHp/1SO7hvtWoSGrUyss4Jj6OJlVo3vAYxN0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VaetK/2rOmgIRwwsjHmtsEn0MIroW1AYBCOTKgrWlj+Xr+ehacZWgqDwRL8SUU04PXI1/9ZmbU+Moj5pzl3h60T089rkre2oVh5BqovqHPnocyEKHIt/ngaQzLKaj3LFqZvYOMknNd6SHi5UxjX1eJlHNFaFvLHtsqsd/7NKnE0+xkZOO6MPGamucuRR7VCiFurcChZXFdTL1da/7TbAXzMxCf2I4hAOQIjANy2pwySU3kV3HPvVZh6d5PTTeLAtb687hc4iDwg/w1nmqcWQRDVa7ZLhVYbCYoQAqpKqhcAeexn4HSuUXLFEBfitY8nHmZYRV4fH5SqwBc0uKkI4PXFKd5Xlc7a3sn8ZS2SEqFEgGq72MUIiBJCA5BonTmmqW6Mgh04Fwnr+YgU1ojSZtJ/3ec08ImAUPr0NC/6Sj1XnWIz1dF6e28dDAlMNbch1Bnh2XgTS+WNCuIBjnm0/d8Bsww24S/Ct7Ixem7OIucnAzzzeGghtQk0XmP7SqpdT5CB8gQd13W6K8a0GJqjG3I5uqA5IntpiWZ59jsUqRWFU/QyV0QjkXFy3rOxQ0eooH9Q9/Vg/L088eW0vdEANCnA75ackYvAHnVsgy3D1vTdxtDW4y/MJy3vCcPKPEz+3w2ezLosfkMMgfNdgyQGba0Gix4U6aM3gceWvjQAPQZTas762kTU2c2gve9DyBM7XEU+yfvRtjsIPuvS9iWDdbOZS6ThpZyOwZOH4FGtpNVCe/oShqdDPm0Lgn9THaYa36zIlWx6M8KjLQB//+wn0W80MawoawE9ToVd5pm/Kg91AXndOElDNZqKzvyJFkuMB6cnozsH0oOK8DiAFqeWdxPlq7K8Y0EbMXnpfEK5sL31jTZvKmlEtQsMXSFHQ42NmcBzX4PE0ERJszUw/t56Nl9Wrbl3ICf2Qoxydb4vcW2vwFIRu9mv2hUg2yEiaFV4/
 lKdAHGj5Kcs6grAzUekz7dfpkI1LAWrkGkRoVaUFMeS4K0YG9vNgO7NjUPEDkJqZA5TkrFWyo3hnyZbOQMOObGf6mM6L157emq8TCpwMzXC6s0b3rC5FxUwdQY29c0KlZ5x/SIz/uEdnG06z18J/peZG2B7cAC2KxC6SzJFTD4Y+6bGsu/rlPZivNJh/ecvMgfHbnmKY903gEOA2xdIOdvkW1Phq5qzbEsBP3TcHd9ZRheLMSb7AVW3O5AoAQjKaPZVMZ8QgpMMiJqM4geBO4T5Nlu1iWTPkK7ukCYGwX6Q+9LkY6a7ZRzSa0zl6tbAXblXmnXowIG0TQ3C3AW0fJoSNTLW+ljTTPUCrZ1fT0iwLp0MbTyc7OPL9PBJF1EjRJYefs9/GBBqAsSa3zJHjDhoq8fXnf+i4XqcWYj0JBa3LDF5Go/caQWexWS682U4De1FVeiCxoOqMdTMfB/hWSCXLCRim/piijNmchs+EsOTcCIBYaWAGw48cQJzTfhem6lpvpE4XzFYHw8kTwLV8dSF1AXrTrdTeBKe/0CQoxrBRtsKma11X+0LSVj78FSlz81PhjactTZnLV6ekwGtnJ/B0+QfKwdu0PgmWxiiuqjIHUsdvueMihhK4LvPMBtxAEUuj3rHiFHPHVCyMTtgZnThP442RzwxafEtq0geUBvJVYbs4y1UFO6l5fD2+gn5CU4hc3KqoEBDceYSZkWxbtg==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c06c5d42-732f-4cc7-cb9a-08dcccf77dcf
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 15:37:32.0394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/jauKSvO/h1zYuWQncH9t1bZcZuHd2KLXYblrFYhsKmftr2pfqzgjCmtPGPjUbImHnC3s3PrRD//ANzjSGWDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2584
X-ALTERMIMEV2_out: done

Hello Rob,

On 22/07/2024 22:50, Rob Herring wrote:
> On Mon, Jul 22, 2024 at 11:41:18AM +0200, ysionneau@kalrayinc.com wrote:
>> From: Yann Sionneau <ysionneau@kalrayinc.com>
>>
>> Add binding for Kalray Coolidge IPI controller.
>>
>> Co-developed-by: Jules Maselbas <jmaselbas@zdiv.net>
>> Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
>> Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
>> ---
>>
>> Notes:
>>
>> V2 -> V3:
>> - fixed bindings to adhere to dt-schema
>> - moved to interrupt-controller directory, like the related driver
>> ---
>>  .../kalray,coolidge-ipi-ctrl.yaml             | 79 +++++++++++++++++++
>>  1 file changed, 79 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-ipi-ctrl.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-ipi-ctrl.yaml b/Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-ipi-ctrl.yaml
>> new file mode 100644
>> index 0000000000000..91e3afe4f1ca5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-ipi-ctrl.yaml
>> [...]
>> +
>> +description: |
>> +  The Inter-Processor Interrupt Controller (IPI) provides a fast synchronization
>> +  mechanism to the software. It exposes eight independent set of registers that
>> +  can be use to notify each processor in the cluster.
>> +  A set of registers contains two 32-bit registers:
>> +    - 17-bit interrupt control, one bit per core, raise an interrupt on write
>> +    - 17-bit mask, one per core, to enable interrupts
>> +
>> +  Bit at offsets 0 to 15 selects cores in the cluster, respectively PE0 to PE15,
>> +  while bit at offset 16 is for the cluster Resource Manager (RM) core.
>> +
>> +  The eight output interrupts are connected to each processor core interrupt
>> +  controller (intc).
> It says there are 16 interrupt outputs below...

In reality, the ipi-ctrl hw can generate 8 interrupts per core, and there are 16 PE (Processing Element) cores and 1 RM (Resource Manager) core.

But, so far, our kernel port only uses 1 interrupt per core (for IPI) and only for the 16 PE (the RM does not run Linux).

Should we describe in the yaml all the hw can do?

Or only what we do use?

>
>> [...]
>> +
>> +  interrupts-extended:
>> +    maxItems: 16
>> +    description: |
>> +      Specifies the interrupt line the IPI controller will raise on the core INTC.
>> +
>> + [...]
>> +
>> +examples:
>> +  - |
>> +    ipi: inter-processor-interrupt@ad0000 {
>> +        compatible = "kalray,coolidge-ipi-ctrl";
>> +        reg = <0x00 0xad0000 0x00 0x1000>;
>> +        #interrupt-cells = <0>;
>> +        interrupt-controller;
>> +        interrupts-extended = <&core_intc0 24>,
>> +                              <&core_intc1 24>,
>> +                              <&core_intc2 24>,
>> +                              <&core_intc3 24>,
>> +                              <&core_intc4 24>,
>> +                              <&core_intc5 24>,
>> +                              <&core_intc6 24>,
>> +                              <&core_intc7 24>,
>> +                              <&core_intc8 24>,
>> +                              <&core_intc9 24>,
>> +                              <&core_intc10 24>,
>> +                              <&core_intc11 24>,
>> +                              <&core_intc12 24>,
>> +                              <&core_intc13 24>,
>> +                              <&core_intc14 24>,
>> +                              <&core_intc15 24>;
>> +    };
>> +
>> +...

Thanks for your review!

Regards,

-- 

Yann






