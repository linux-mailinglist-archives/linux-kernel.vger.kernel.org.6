Return-Path: <linux-kernel+bounces-262029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9662D93BFB6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8BCC1C2174B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80781198E82;
	Thu, 25 Jul 2024 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="FNoGln4P";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="d1saSVC1"
Received: from smtpout145.security-mail.net (smtpout145.security-mail.net [85.31.212.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320BC339A0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.145
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721902074; cv=fail; b=GZGSQFlHMMng3tXalnSROb9sa+tOgyYwGPLS1RJikRxuVGuufnfYaMhmwCN0XoTZID8flupJ3+pUwOEtUhyjZv+ojnYBL+yOidDTUHYcOij9eiSYFIAldrFC9pTg1bA8m45IWnXIf9JoPAZF5OoCpVJSOLS1OGhqvE4jDZF4sb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721902074; c=relaxed/simple;
	bh=LwHddtm018Xx+BLj0mIIRPL38oGhuwyfybonnbALL7Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fkeq+b1DHsRApwK17WwWwyJ1I85AFRxFcnw/oYvSmdpTOl68jIanzbh89VOvNcsiW0rmoYtIMDGh+NWLU4dxgzb+uohn4t1AG1z/RJbdZoXYvb57QCNEju/iydd6rUWFO7mmH0tqm+Gob4U2hVpVTj8x+KaVEPAPIbJqXBhxEpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=FNoGln4P; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=d1saSVC1 reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx405.security-mail.net [127.0.0.1])
	by fx405.security-mail.net (Postfix) with ESMTP id 14474335EFF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 12:07:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1721902063;
	bh=LwHddtm018Xx+BLj0mIIRPL38oGhuwyfybonnbALL7Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FNoGln4PC8cwo156ymesB+2roiLeL4d7vh2LhsrxMxxOXEkTWM0EkyH93ZUqCBS/3
	 Gj81YlzfiiKQRiEG+Y9370o9IoDAb6oAvrruWF6lSFnncorXh+Yi6Tb8SEOo04HgAp
	 qqbJkiR9ZZNVasHsJWYgwAmaKV5ieqRX061jGYrs=
Received: from fx405 (fx405.security-mail.net [127.0.0.1]) by
 fx405.security-mail.net (Postfix) with ESMTP id A7D3B335E35; Thu, 25 Jul
 2024 12:07:42 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012050.outbound.protection.outlook.com
 [40.93.76.50]) by fx405.security-mail.net (Postfix) with ESMTPS id
 8A98E335B00; Thu, 25 Jul 2024 12:07:41 +0200 (CEST)
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:14b::6)
 by PAZP264MB2736.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Thu, 25 Jul
 2024 10:07:40 +0000
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7a6f:1976:3bf3:aa39]) by PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7a6f:1976:3bf3:aa39%4]) with mapi id 15.20.7784.020; Thu, 25 Jul
 2024 10:07:40 +0000
X-Secumail-id: <13877.66a223ed.87f9b.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOnvixkwWI7Tgvx7YZN1vIB4D1a3y26KkaiaBr2TV3urMLZ8K3giCOLtgAqtoqvzr0g6oGbI9uFTKPFpjlHmfrHm/yWsONx8sVo/OGsP9z1u1kxV9Ie4JfTbJgZvr2rk7OJfK5G4fkDXgpn1u9khoFUQu1d9WQSsN2bBc8cowGLrQqg3I6XCUOW4ehnBk5NkI/lhp7v3MuU+1E5YVZTfwUTa2U1fjCAR3uDoNbosWWRnmZcq3thIkPzKbf7o7wcsGD1uBbkfiaGRcAvYz1PDkjc3+PDlZicaO/BH2kYeqhejVtTAUF4CZR8+/3F+AkPA8Y+RjEmCVRdgXQsCJAZ+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMDmu0kaLo6F/wBXWRP3PmPrcGUFlfC9eOiJ7ukx5rU=;
 b=cT97yssNK9463l7QByFevMCtAxSGM6V1XgR5BvW/PErKdKhyvLKOm2yn+OHiIZY8k//8KTQTb3pyWXOPGDu87IPsao0VDD3SJXlQWDCTg3nHLLxM2is8lBdgpb0MmzUqUWFGMeJagU/JdIcAQC1kC4GgpF4zvlJqB52c/jplfLKS3GeMXU1A01c8u4SfPkdwZy3RZ54heUf/Q+mAlU54QkKOhpgbonEnGb7/xOUFAcBrXLVX06D1MyiHhh4GPGbXKbZD6890tMLCEbf0Tbd5lRarY1WDRGgmXn3u8xZAJQU464FZvNbcPnib3SA6v34ugj/j1TFmcXyhsCjFnA/7Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMDmu0kaLo6F/wBXWRP3PmPrcGUFlfC9eOiJ7ukx5rU=;
 b=d1saSVC1QYtvU9UA0zqZxidzRkNoOd1Mkeg28cJl/PvsPYHpEtDZN1aoHamkQT7yVLSeHUNr1ydQTGwDmiA6pTHnli//oRBGt9CNGVjq5wHBtN7vD+VU078GvMwN+SElQT7/6R3PpKCZto1RcoMcGdiHsD6Fq6sqpTcx/6oLnQ0qcTbe1YC5UkMcX04PNSuD30H7dG+BaNvj1FHTsjp3QZk4q1aESHBIPOMN6JgqXhdYUODyZ+rs0Ea3rMlILjp3ctikxtyyDms14pUB0NvKL+YM3pvox/4xyyx20DmBlg36kuFrUTQD7BjgLdGCIVxNHqxEvLh5oevwNYH983laZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <8648033e-6eb5-42f7-a65d-3153992e9135@kalrayinc.com>
Date: Thu, 25 Jul 2024 12:07:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/37] Upstream kvx Linux port
To: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Paul Iannetta <piannetta@kalray.eu>, Xavier Raynaud
 <xraynaud@kalray.eu>, Patrice GERIN <pgerin@kalray.eu>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <de10b443-b6b8-4829-94bd-e5648d9955d7@app.fastmail.com>
Content-Language: en-us
From: Yann Sionneau <ysionneau@kalrayinc.com>
In-Reply-To: <de10b443-b6b8-4829-94bd-e5648d9955d7@app.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0082.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::23) To PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:14b::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB3481:EE_|PAZP264MB2736:EE_
X-MS-Office365-Filtering-Correlation-Id: 12ec00bf-9b42-45d7-d8d7-08dcac919e09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: qXit3/2NEYb5PLp4VbLMlEhsGbOJPI7tHwFNVT6nLun7rjyFlWP8CE/mCKhbG+zaZmtw47lAPLt/BtqAiXFbnqPRAOo2hdJd7FXC5k9hFSEZdvokqb3Uwh30V2uAFyd/xomuajTwOhcy1vPQzv5mz61Xp4xdYpQho7wmnijnO462jXPxsCRaN0FSgywt5ecKfxyXqAVaMoPoR6UnNzMohQ7mYjMOK3N3jbhpnuT36YkbP/OkgoAmC8YR3eQ57u0CVihw2YwnX1K3KmVIu/835g0Nfh7xUSO3SkZqX88RmweC0P+jRqE/WmDEN4DxsvfXNnHrpTk2R9th/AFCgcx3gTh3M5mA3X9m8MVUmAT3XNe1U1jnyySXg/ez7CLaaQVri4F8g+yCBVREgQImWgnlJsiFLJTVkFB/MZCivsxdfeXtQpcxcnbnhxTC4DAm6cHToBqmoGzz4dBJesA2Ylf8YefZGVVa+0U4cEtaIXrTneqboNGUCiVm+lDSqx7Tuf57i4PDDbPjoEy0yteanbLPuZtiMpSN/3NMNGY80BZ5OfBXCz7do2Wyh2IhIt27ykMsG69QmVOci2z5xrRZwcI3edO8NQdQll34xOMkaABIBKCqBN9j9BsQj1XiRmLmahKFCE1VTk3KG3HEMgKZM1Cz7javph2MDzhgjwEiuan3Hy9V2QozDLdVso3WJCFiVQrA4WxW7CqyQVx/QkL+Ay751ZKs3B6S75dwBkTpjhinwHbVdkUhEmw24beYC6grPONS+Sb0oPrd1OoLnFm2g57bDm1zGUa1hHjX5ihyXiKEj+PVff0+Ey0C9d8PYLp/Oqx39xs8VN1Ylz7pYdGGaN8Z5wP6augUQyryMxHbVZjiY7ebJ5LPC1odeG4SM59qGrWizjylnftsegh7l6S7snMlUNX8l1ZkB9fb8LcTyDOghJoI07suSFkK3bFatQYU0nQ1lGe
 4H30U4HFMY85nN75fEH8TVukVsBxNWI3HATgm+CpDyabuJhSsBw7zB7wxqF2pHc4rnV7wh+gULcfHnqtuIDuLr7Zp1IkYER1CG8JbomoIxqgmdfGZAxt/UYNDuf2fXO5RfjKhD5RUgly1qionY29JmfmqzswlDWz27o9saWfz5x6bCzgNIn5OAMFiLiohAmIweVdnHqrKIdS+j63zS968mgLcArI7vYeP8L3yyFImhfvFehKd6kZZ2qXj5uEMLpDf/4wsC49zJk7keUHZzXxOFzFLr8/8Y6J+8rKyKPbROElHeIW94dGVt62iw1Ezao4OkZPxR45TxLJ9Mu064kfCrhZy5OG7Gl11yyCirKE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9WSRswjYOvaYt9HDJaStN127ZjUw4A6fESdx8zApT+Dhi9bJebu2WsB13DqoFyWkraD1k52gQ/zcgMmBpxs4mu7qWX5nryoHsCJDVdnuIXBsCMEPyYJTYyuWMHNRpZkghXRM8opqx21Brdcs1rnWXYRmjYdQMN796XtaRqZOI3g5XgPtkju6dO4zJPVVROY2qokIdFo0DSLQXLfhXStVoEptBgsfjU+5Nfrr7/hUjWK6VUKUeV0+mYHEtdNSusz/8oW8UbhBUGo7cSre0isdvk7r5PKHhn/2/5rK5RppUX0x8ND02uefxMjvpWXaNj/gV8NEXbqAcXtwhKGYPPc22YQJT5cQhEWK360QzwgGXFwTN34xcofEyxYWu921RxCYApNGQ5c5bZu5QeobUhnhsdSbfIyJmf7nv+5Ji3+OlNE3X7JKHj3xe9U86UFvWsoCGCWFWjtG//x3jpN1XEBzzQPIstlOMFNo62Aye/5JHLZqZ2MOtqKOfphA9ijSVmX2r3yTEUbytAVNp5TWdpHo7jWFbeeLyIkcffarjX7i+2OnYkZWE+4VaI6w+7DFJOML4EMgspkb3b5MnAeRWnk5wbNOwfaHHQdK/+kzIV949giI037XyhWI1jV2nCfaQ0YEyRhZPS/wHGYoJfzC4CM12lRXqMdLgAEJWTQMRVykQKHX2v6NYLD6XunHrVlSVEWAlPG2dwCJBEjzbsGc2Us6ysKx049l+co1hDLC7gxZc4ExwhcVMblu99kJ2nX9ox/Ry/vJgQJqIlV2Fl7uWofKxOUyQT+pZ4QbBfKNv+L5FApbEgUTyBm8z15H/OBnZb3P75ROq4CCEClWqIeSxzsQFOFAO2M63UZLOm2JdaRYeMo3fbY6Fjh8HmJRC66a9B6Rnxv8+UhXZpyZFfFsM4sY9W4QYYv/ao8uf/aAyxzkhzNzfcMp5X+YYmozNl4pJazd
 4gLQ1luQoSSX9IYZHCXHiatKjInkXaDvIyZCI8T6SzJskAs4Su2UODK1EmV/0dR7bJYRBb4P4QtLQUaY0jfjvQdLScuH3qf3N4krllHOffKKe1v6xxzv1VSR/O8pz0SVtI3NKXjoqe71Tut+rrUlOq83IzXMhrzR/MaAgR5PKVxSIBoS7ogomqwhIEF4rwq2M7WEMHsS9eskL5EyFHxduON53c1Uo+2ytpgNGOSbY3oJQuK7dQW0poPSV08UVH1g3RU7f6b+0dFqIi0UBSX2YFQi1mrJOlybxEzQdRmdOFhp4izynSL5pPchRud9qd7A08alRG9ogiGAahCht6rjonUnh2Z6nGHm6vZd0Qh+sw/PImTEky9ZeQ77hv1LOaxt4wjsSX6VyXrVG9UcmyNOvDrwNvNp46hn/dIR3rD9Xbu9tKrAUcJ8TY7l6a1vIZD+lva87FP/gP2fCYFXAGK9Y9PQVBXq46C/R3cXDZQ9Hp/nwlMB0ExJb/by53fPW/p+I+MEGL60r63UlrQeGqGlu0vV2kzB+l9DqkDewsc0JgTqZu/tqd/VAtWQn9nHJ/xjKooKIe7tQ7zgbBu3qo4Aev+p7bKrifYEXLohJNOQB/qBYJCfkGD68kUt6XfDtvbTt1q9q24y1eYuLFd/RgyrXw==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ec00bf-9b42-45d7-d8d7-08dcac919e09
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 10:07:40.2581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLblBqaHI1o4VXrMGG48njQyezlnA9nHilIVkSI7GTl7ckm+hUdrRllHBhe3ju439PXNT3s4dzlxXEz8knXtYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2736
X-ALTERMIMEV2_out: done

Hello Arnd,

Le 7/24/24 à 09:59, Arnd Bergmann a écrit :
> On Mon, Jul 22, 2024, at 11:41, ysionneau@kalrayinc.com wrote:
>> From: Yann Sionneau <ysionneau@kalrayinc.com>
>>
>> This patch series adds support for the kv3-1 CPU architecture of the kvx family
>> found in the Coolidge (aka MPPA3-80) SoC of Kalray.
> Thanks for posting it again. I tried to read through it
> and point out a few things I noticed. It's been a while
> since v2, so I may have forgotten things we already discussed.
>
> I did not see any major issues here, the main things that
> take work to implement (better atomics, vmemmap, also vmap_stack
> which I did not mention) are just there to make your code
> better, but are not required to get it merged.
Thanks a lot for your reviews, as always it's much appreciated.
>> This is an RFC, since kvx support is not yet upstreamed into gcc,
>> therefore this patch series cannot be merged into Linux for now.
> Do you have a timeline for upstream compiler support?  I see that
> your github trees contain both llvm and gcc forks on an older
> baseline (gcc-12.2 and llvm-15, respectively), but I don't know
> how much you have already submitting for inclusion in a newer
> release.
We are still willing to contribute our kvx support into upstream gcc, 
but we cannot commit to a deadline yet because

of some code cleanup that is needed and we don't have a date for it yet.

We also do have public gcc 13.2.0 support 
(https://github.com/kalray/gcc/blob/coolidge/ChangeLog) and llvm 15.0.7

We regularly (every 3 months) push on our github repos updated toolchains.

As said in the cover letter binutils kvx support is now upstream.

Regards,

-- 

Yann






