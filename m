Return-Path: <linux-kernel+bounces-298912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2071A95CD23
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E3E2828AD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B200E18628F;
	Fri, 23 Aug 2024 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="mRIyi30j";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="gLBp1J5E"
Received: from smtpout145.security-mail.net (smtpout145.security-mail.net [85.31.212.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE69D29CEB
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 13:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.145
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724418307; cv=fail; b=T68K2vb9w69B6Dgmd5ThCEhOZ41RlRAHF0ZUOQBvGVsr9t5tGLHn0lN0opO0oHDoacmSfX3xXSzG36r8yJGli9C6qBYckr5RGRWprZheWd3OigRU5cMMhLxM+aiknu+CQ8ctua3nK/dZ3/6Uae9K0pRxZi11geK7fU22FNE2mT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724418307; c=relaxed/simple;
	bh=x5wKGEiunDe4eqq3CuyOQJHLCu4ylX/y1neDAeTrl24=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gsxRiiMrgt1PBqYvqWRdY10OhVcd6dPCF4BHjFfu4i6CwzQ1N/82JGv/v0i/btsc7Am9q0RPmU0dJARRJiMbXdmMOHGLDeg0vAEbdgE8HvGu9GRpP0c2N6VZfPrJh2cyrub0Eu18xnII8/LkBVfrGnqha1p0sUt82SZx3isFMEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=mRIyi30j; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=gLBp1J5E reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx405.security-mail.net [127.0.0.1])
	by fx405.security-mail.net (Postfix) with ESMTP id 3053D335F8E
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:00:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1724418017;
	bh=x5wKGEiunDe4eqq3CuyOQJHLCu4ylX/y1neDAeTrl24=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mRIyi30j9ADm294TC9jmqMHD9wkff8KVEEgISjh2A6C2ID8HFLPzYqMd76aYedN6o
	 iLTYs3CRSIGHBhQSSvEgiGhKxU7CbEkhXeUnsZtHxmHMoZkm8cTWUVd4srYogsV0II
	 VPvuMhqERm0ZUnR6G5ef6Z5qPX2CEypQvqHKeWpI=
Received: from fx405 (fx405.security-mail.net [127.0.0.1]) by
 fx405.security-mail.net (Postfix) with ESMTP id A16DE335F43; Fri, 23 Aug
 2024 15:00:16 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012050.outbound.protection.outlook.com
 [40.93.76.50]) by fx405.security-mail.net (Postfix) with ESMTPS id
 4B413335F8E; Fri, 23 Aug 2024 15:00:15 +0200 (CEST)
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:14b::6)
 by PR0P264MB2887.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 13:00:12 +0000
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7a6f:1976:3bf3:aa39]) by PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7a6f:1976:3bf3:aa39%4]) with mapi id 15.20.7897.014; Fri, 23 Aug
 2024 13:00:12 +0000
X-Secumail-id: <fb3f.66c887df.43ed4.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8ZjhXDpyKcK7rlOEgwMRVHW0Vj+kom9CfH1upXKauEpbF2l+/Y6hcESlGDNz0dhobJnb1AWSrKhhQLc41o76zLXsVK98VJVc1hFdEsPjW0Pnk/oBE3cz6yOOoK9796XrZFmGcLb/eoON2+LYAM5n8QiraQwewox2K700KlR1ZkYo60WEm+H1x5bEjefB03UkPWvpnSWS9WTc3bSXfwZs9ueLmlCqWVGEwbdrJTg5kJIbjjZscc9m0fXLu4etvqAAmIG3/fOFgsv6HJjm6PoBiFtLDxnwu/s83TK9Ha7oreg9G7NV85YYTGv6Ubu1gmWJcP5jX58h50t8GncOl6nhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xq4XQUW+AFPcPEWDjgM07ytyWBaDEBDhXr3DM3Nl5Cs=;
 b=enaD7SmEHtZwhTxGgmqxXPAnPy69DLJCy6Gs3mNGLz0CyOkZZ26unpZAUFTMc3MJ8XXda0VUtqgJyjMiCtjo1i+BNMETgXkiqL64gb9wItdgxmaDAbpk1mXhPporIbdFYk49RfRjOMA0st+4HRDzX9W5h1O5lCcDKSm+qh9eF+MonK2dIPWTn8AjUXf8hM/W9VNTUU3PHMEq4oTh1sDS6dMuH4yDanBtxpMEXWB4Gv4TgvNpphVlWi2Ayo5b+kugfE3CxBz4fJ81GwVOCdoPive+JeAxq4c2cL9puvnjknzmKPXYWRZgEubnv/Rbgbjpq+ZFMssHnelkT43K+TE6Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xq4XQUW+AFPcPEWDjgM07ytyWBaDEBDhXr3DM3Nl5Cs=;
 b=gLBp1J5E/qGoJosJ2OuQcJNUSVEhO6II+r8+fQMAYDtzZ45om2lsjm4Rb0TtaGF/W+r1+0feWykwpjHsFLPKUFW9rrPwO68UMRuOZ/RdhTKmfbHENNVTdEMX+IJpR3jZmdOQdU4/3j9lk1QQBWuDbOHu+sQarg71FnLsFIcCNCXKWodQuDqiu7Vw+YTqq0B/29LjqLatZvcEEtqJpGdGS3uL1KXb9hi5I93duh5WwN8fpiCvVgPtwQQ2zSRNBiiSk+guXsbBnWwxkM/0do7CwG+5uA3wQwrCcxSfYTcZLmXLxTF3QdOCWpD0YZFnLvE72Qjthsdu6FU8o22tmQZG6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <888f5510-5404-4daf-8683-5f43d810f4ee@kalrayinc.com>
Date: Fri, 23 Aug 2024 15:00:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 33/37] kvx: Add support for cpuinfo
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Clement Leger <clement@clement-leger.fr>, Guillaume
 Thouvenin <thouveng@gmail.com>, Jules Maselbas <jmaselbas@zdiv.net>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-34-ysionneau@kalrayinc.com>
 <1c4a5ec3-cf51-49d6-a62b-53c081aacb1b@kernel.org>
Content-Language: en-us, fr
From: Yann Sionneau <ysionneau@kalrayinc.com>
In-Reply-To: <1c4a5ec3-cf51-49d6-a62b-53c081aacb1b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0141.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2ce::20) To PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:14b::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB3481:EE_|PR0P264MB2887:EE_
X-MS-Office365-Filtering-Correlation-Id: d42bb332-b211-4ecc-dc99-08dcc3738671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: DBb9PVzA2MZlpxHFg871jqE+Ds/re9iNfR/Mt1w7tnNZuFu+T0/qJMuGo73qkOulbW6nfmCXlD6q9vQQn48XfL19ittbnrkcSveDWkVPC31HU8UpgO40K4EAxwy2x/CO+ybT5i529sllBFXtIYm4jZFnjpjrhnUuhZTcvgElrTxGpHyqPSREAkZ1DsdE8zYktsxo13AHADQEc/eTa8M8Tchzqd95+XdXawMgvKNr01IuWjSMBPZReRvyQ3AYINZz4WGX7JhSVjkUiv9Ve5h+VI/7jtTIXS4PkN9tKhX2Rg9P/XeyL+GUgModtGmKZKGQs7QfTFTsfm+ztfdx/GN9MI2MuBN/E9dwXeIshuEavZv+Tcs4cbyfe3gm/Zc7ug+jwsJzLjwuFoWs3h1JpY6+qMIoZmUsGf6ybyY1JnuG+n2oNzFjae0Iw8gVrMAZ/upGYY12QxhQQgwM36fLEEAkrIH1H3bwtZ37rkwCmGqQ9cON5h2twNBpC8k4W5zYBBQMIEVJLQkuxrg8pFuaBwyiQMe5tivTwUuNSdrIR6vb8PZrvR8SQHqxZZ/tKBzUu7ZOxUz/K0gbPFabk1JvQrOATtIort3aOBPyLW/S1CKcS+DaD86jcqvA/YlpEG/q5DAAUSfCspywquBTwUK5r4WRq0XpVg+lREqU601e018YMmIMKyYSzuRWagHdAGLi4rgm5Y6XZycF5ePoV4lWQI9fHHvNaFxwZdlsghB1A7FAnlP2xscUSNsTBNeMOE2S5TC3NvONJ72p6f6sjtOqXhFMlFAFlpdu90ADvOTklIF61nwhKrEuYZrzPyMXIzIxbJlcEcO3jIPq80WAA2sVjn+kQc/faJ2lQzDmzajii4DqoOeulJQryob6ghIB+VZZzVsnfNlqn5jRjB019cLsHLhBqrG8MwAQJQ3JlaKJVo5vpd517azMv0WTpDRH6I8nbc41YuK
 vKjokMW1MTdYEZ9EZZHRR+KFHNy6Hq39M74tIh8Ts7oZMsrLbs2x/kgVitifAYNlBhUCNE81JWuJw8/jQxmcP//ElgDvWlJ4JuO8eJqZDteafY7lQ9MQcYTaIg3N1HxO3HdqZqgJv6gBtsiB5lX6QGba+c4XjkpNmSbz2nwRkHe9ek6ttcYy61X+gmJuiq3tLVnYFXcAogoIAswKZbp2afuAS4+/TBvz6+2I8HvHUJG8SzXUdssSX/3t8TXFwN6XvvmNdd2N1g6C5O6FecnoceBNHskpjmuNc0sq3CHagvLGP2jHA2IBIk+X1B6OxiuId5b3hdny0HveJwr8EUxNdUrX4di2krW/QwCVPpjM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jLhFpYG3ZvDwPOEn3PBRJmSsxV2V3bDqWZ84dLY9WHZSSiaWrp8HngT+hi7T6UT8682GmCkh12GA4oo81boffLFtIdtLA0NVxJUT7NxZE6uR7Uu21SY1JMPCPtkMAm6j6tgXqknM3Yh/ESxAtzBaO2HdSANqc48CB/w9N3sMwOFfmFSQs6+3a1ciqmkxtMkY1ow/hKixBe/n/ti9j/kmfdr9hBbpVm3rO3h1SZiWQdeggXB8t6YPRvK0tKxTIzNXM53v2GW3pdcuLWHcznfxBQvcz93vL5WM7DO/UOwEHM8P64Eld0fXhh215qphkJ34AMJaZtJWVoeFz584Yke24WDjSUFfaforNF/k5v9Hk+N7VZzCfF9Aq2HRGzhTZqxT/eJM6ix00x5hxFi2MCuvk5Lyv9/4qFC/ZdCrWE6YRfXsY/oCiSzKu4dhdWiIuBaK1Y0QNMGznrYKK4YleRYu0kDu3ICMqsonITGV5SoLLtXXsIjrdhMHduOdmJqXO+rwYPt5umXRDfU4r1xWEgeofYs4tB+atV4saS1ddsmf9WGGkV8eT2wI5rdz8a+ZE3LM2N4OjiaJJyBfphvn8LreDO8I7FdqUoO+ZmXRRyv+88AVAbCAekxMyQgX2lcJt0dLatYk/w+geVtlAu3zRU8K24sS7fyxaxp6i9lfBSZTM05A33p8ROtceAN1aBxFpMsNlKMAz2HckN5baqYbjDM/bc/36fQcun+xk2q7j01lJnjb8K/n36NIGDfeBsqqZaLu3BCR9pCDKiyIv0TE7mazALkj4OoRofnToRTwT/M8CigPG6MYDxVy8BQUZ0DGBk6SXTlP4B4t0Mzh1iDWGLElX78vyrm0eluORsCaZVewOq2FMEPvDjotXisx5+Br4ETwnKVvU1ELHraK2RhgxXLpy/ql/fjT1u2npFuz0Igy7rVSeL7Gcw11qua+vi9JRGiD
 RsFdOa1nBTVcpSLFjEeJ3mY8Q4gJynx1uzJjRVsZfPuMP3fFIp1xyAL1kkISWf3EWUZek2s/iybYdrK1wS2uNWrHqqPA6lTSwCdYjgaYjAOo5JXjvqyN+1hO824Ldru+KragBSpRTmSq8VDSQSIB+murw0SGwTIrtN4EJWIL+XJJxwdsLIK/gkhu3kcZgcFoih8qqozTrbShNyDve1oZh/apkjJyXEq6EWzpIF5/uZcY5XyPVPY8PUsP66B9GARoh8zi0k6ce/4R6F9t7Wq7nIIHLpRYu9DC9M1K/jWKYg5K0rGmqfdaTvC0YYtCsBxEcXcScFTxWf1AuhiNOjLsIjAjt6s04aG+yMaCbMNlmZCY680G0gGD26ONsxyDdI8y+S5jPBY5PN8k+Wf25S9UAq7wvjqrPWY/bDpnLvyFafggN+dn2DSIdnXb9dGcricvIY0xuCDXD5HZEZ9ypNIT+kullJzw4a4S37nznFRjC69PbyPu9ASa+mIthYoTEdhu50SMT3mYHQPoh/ltiuEB5xKNUx+ssKMCDwagwKPuMvrxEbQzUHbbLgsvVh1D6TTm1PKtP61Sy6XBEATne21HNZbkUNbKZM8BImc9rvVgC9sQ3RMxCRgegcouAR7YDTbWz+3DUMu89RMO1uiRE4ETUoXDu54+13wZkn7AsjpzuIvSba1XdoUeaqHoNF+wnyJWSTWJOhp351irKgbye/zlJg==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d42bb332-b211-4ecc-dc99-08dcc3738671
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 13:00:12.5801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGNeljb9wzqjJjQxVJkT8W6R25Bvrw6Sfn/+k4MWpWQuE5hqeU98y1zgCi+DdjLK3GFmqvk0X6ZvRGtINQqJIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2887
X-ALTERMIMEV2_out: done

Hello Krzysztof

On 22/07/2024 14:35, Krzysztof Kozlowski wrote:
> On 22/07/2024 11:41, ysionneau@kalrayinc.com wrote:
>> From: Yann Sionneau <ysionneau@kalrayinc.com>
>>
>> Add support for cpuinfo on kvx arch.
[...]
>> +
>> +static void c_stop(struct seq_file *m, void *v)
>> +{
>> +}
>> +
>> +const struct seq_operations cpuinfo_op = {
> Where is this used?

This is used by `fs/proc/cpuinfo.c`: https://elixir.bootlin.com/linux/v6.10.6/source/fs/proc/cpuinfo.c#L12

I think I should add a #ifdef CONFIG_PROC_FS around this code, or even better use obj-$(CONFIG_PROC_FS) in the Makefile

>
>> +	.start = c_start,
>> +	.next = c_next,
>> +	.stop = c_stop,
>> +	.show = show_cpuinfo,
>> +};
>> +

-- 

Yann






