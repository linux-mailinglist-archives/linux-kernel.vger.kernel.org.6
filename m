Return-Path: <linux-kernel+bounces-333628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BB697CB98
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 539EBB2352C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBCA19DF8B;
	Thu, 19 Sep 2024 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="H05zowoE"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2105.outbound.protection.outlook.com [40.92.42.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4537D19994B
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 15:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726759551; cv=fail; b=Er9gjs/rO0txkdC+InLXpnxowXVAfKGp0dbXVuJqwRyTbRsEylKKgRttRaS32pEuokIUca138CWHmghIM0DEgCMSr7dO9pORMZB7vpYn2EqAMj5ySFfHOitUkaa9a6tGFDG9vpOnCExnzPpjsiHbDlnuFV9PNBrEnrjfDaoM9B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726759551; c=relaxed/simple;
	bh=iRVRg1UJabkzkvG8CxIOE9qYzgfL0blXkFNZ0SJM8HI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J1yU1a2BQNVfRm3w03f+kWTc8JVafxS/IsiZKf1Yrwq+JvaqQhkV4u8b7cGqd5IXZ/uGFYrLaId1c/OBpK1E4n4QnTzIMlSWgL4i2qW7Ha0hlz7UyUSQDinzt4F13HZ22EL81kPXj+NUsTe9gr9ajvp+NHCVeaFTmIWHJ/ncDxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=H05zowoE; arc=fail smtp.client-ip=40.92.42.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Os9AZaZrrLx5+6GD0PxWFZCL8NYeJ5Rc3PBwvbebYjWKJuFlnZ/Bq5sewtdUPfutOgk2rkMlgYMDKJTT467PHRLGz/RTAiRbQkZC6k2lCOevMvxSBolhs3vJQw0iCT5joyMBVD2uDrsiOlWtX91X+7FplRW+PkQGyRiuRoUxJLWaklTUHQxPdNEFV+PY2ifCkpR2mODMveEUFmE8HBSy45jdcdXz+jrTNyTkxfCpCArKa3A+JIjbHEffNI+ocHoJMvU+5et/UxgGzCuD8segTQzQBk972db6auk9+8oGOZ4qifkEmW6qKt6GWjRCxpW7RfYvQ/aobp89+ogiQyvZDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOP3TYPZgmz3gNKvOsg3thCE56vI4l2Dzkgf6ouP+Ys=;
 b=viGGdPcS5DzgtszAqH7ti44d13Pzj3h0uTpQjTw9E7ldo1n0D7vd8xnxDtXPr8pwqwlB0YPxCaiNGvn9bSMaY1Qer0f46ZOEiYBb+W1i3q2OIzrOj1PmdNATyo35CDYqqd9RdtQx9L7sDIEG/dci6WjpBWyvF85R9TYzeNJf3vZHYjfp3BwKmpI62RQVgQ2BaWmEygVUFw+dp635bGFqVAmlED44GLvmisRtL12/C/G3j9H0SRW/F9ZF27i5997UceLBZqdTtfdIe93j9zQherBR6OY8IY+9vMFgmbkpoRaSiSTVZ0kyvy7T7YcmPKYNV5sbfkRK3cPWohP9kcE4fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOP3TYPZgmz3gNKvOsg3thCE56vI4l2Dzkgf6ouP+Ys=;
 b=H05zowoE6GwgXrsmvl5WRYcJV+CaLpyQ7APL/sd+j+f8B6Q6JO9Q0Mgpdv0iJSepbFjYiTLvL57qZNrBGaN3RNVQIRmeKjNaR3GoGxO5uFHZDLfO7sJsjKE5YsVJNbBKbLThoLdRHDUnPB7B+GXVDusKJpK/1DlOcuuJhFasvyzbHRQKJfLEIXjEVuuA91TJfdq86qlGNFjRlB86js9RNn2xTOvRvOw8E5cRBYuS8z2LWMZV+2xbdodIWLPpHQ1uVvqUjrJB6ONmtM2OPanuTKiuorlh9M6w5E30pUrLkQbfjzV/DOCT7VdMw70ANqDq88MFJRZW95F+YXgHT20xTQ==
Received: from SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:a03:570::8)
 by CH3P223MB1035.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1b9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Thu, 19 Sep
 2024 15:25:47 +0000
Received: from SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 ([fe80::b5cd:c37a:bd3e:e3fd]) by SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 ([fe80::b5cd:c37a:bd3e:e3fd%5]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 15:25:47 +0000
From: Steven Davis <goldside000@outlook.com>
To: tglx@linutronix.de
Cc: akpm@linux-foundation.org,
	ankur.a.arora@oracle.com,
	frederic@kernel.org,
	goldside000@outlook.com,
	linux-kernel@vger.kernel.org,
	peterz@infradead.org
Subject: Re: [PATCH] irq_work: Improve CPU Responsiveness in irq_work_sync with cond_resched()
Date: Thu, 19 Sep 2024 11:25:23 -0400
Message-ID:
 <SJ2P223MB1026771CE6171D840DF29768F7632@SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <87frpv21gy.ffs@tglx>
References: <87frpv21gy.ffs@tglx>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR14CA0054.namprd14.prod.outlook.com
 (2603:10b6:610:56::34) To SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:a03:570::8)
X-Microsoft-Original-Message-ID:
 <20240919152523.3722-1-goldside000@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2P223MB1026:EE_|CH3P223MB1035:EE_
X-MS-Office365-Filtering-Correlation-Id: 9446bca8-bb8f-45e3-1be9-08dcd8bf55ef
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|461199028|5072599009|8060799006|15080799006|7042599003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	4cb0uoyvLV04Atr6ZyheuISDYZRifDJ1ilwKW03XWDHFXekhj6sHL/hVZahrdiQrDQrNhLxle1M41WJudZgPgOj6PVBg0GbbU9TfWqtqeQhQ5bGRtYw0eJz0QgiryhZ1CNR1c3MLnkz/oaVwsjWjH7HdS/Qs4bEHXbEzZfrnjyzjT0uxgICJtJWr6zCtz4B5zriEdOx2TFzSq/DSA6W2qIsR35jwRDo+OMyEFdN7JJ15/8dKnAbS+dWthH8G0jKJ1sfURKNtvNsTHX0BjdUjujYpCq3nvgpOPdNn8ztmeKuON7bouTJTDLRxOX5NN1LWQI3etkh5lZPCFyQjIng+X3/NwBXKAJoDAPqxKtvoU8EZ5+aIWnnztIuMQDyRi9Vpuh7d7agXViaTid0TwV3HHqoK+FjUtkYINiCQGQd7Imsag2HRkITuJqeIZA4YR3BtjBYFv/6z7DIxHbe6IBwB0PU02Y3RHzn1Xj4xfROGPn2RPoIAREqdlLUSST7OAcJyeqrD50b4vlrdNDkUsOFjeCowWNAVLlu+PQeCyXQBYeWaIIKQ749d9w38INSjE/BRedVtLC9hbwNPUe3+j1bNe8gLS+LkSiLg0hOUPYHACDioF5u/iZGH8rCeb9DJE8dwV2wsdfHPuEPcuJRrkhlI+sOyrof2+E4ByyBA132fGiaqweKznHM75UyJkCo+Bh4LzK5esCDROm+c/QbmP08BeJcqN9d+KwII6sc3frNSNTzESrpAfZXkfg9tJ1p/xs14GccrVG6ur9hN8zrRs+t0aA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QIgep/cOwiFOoP8VKVLocsmNYfNzHOgFEUcZtssqWjpkrA18q9fDD2WzCBbn?=
 =?us-ascii?Q?p7Zik3QzDP66VLCZ/HNMlpOjAm86ZPCRYqqm7uiQf1LcfakUNzwOwz6ITIcW?=
 =?us-ascii?Q?Rcsiux3QIoYUOetQ9F5HkgviOX61FUVQa6St6rFNRZ0XG1arctlw+1xs5GHo?=
 =?us-ascii?Q?aKpm3EgX+3Rdzu6KoRVlH2F62mpKURBLUcf9tmK+kwmF0Tk85Awl8J04UQSM?=
 =?us-ascii?Q?Am9ORnQufjj4JGN2WpAvGshMvvF3Z3a9ZJrrlmVNjsj96F35/CRkAio3odZY?=
 =?us-ascii?Q?0PYP7RavLkYOF8Y6d0ca6eQA21vr0/5BtPx6vCPboj6PDdTg2BFZ5+XWessi?=
 =?us-ascii?Q?A6KTy4FZ8eqaWHLgBF9wQsEIrKsj41PCNcnj6qPbSglnY4FDm8r8iCRy0MGX?=
 =?us-ascii?Q?oeNNsRp8z1Oa8GTOyylrhClV3WsYY5y0vj2W72CkfFRS0lRXoRUz/NYUE5/N?=
 =?us-ascii?Q?a1qDTLO4NeWf37QjpVSTdgp4o1Fd6Q1IYJCRDAlPCIMcknaIZUTFDdtb6ZKT?=
 =?us-ascii?Q?VZZlOiPiwcDz/lyjJojmCE5Qm0NA2fQUrRQZaXj4QRhknLVQbHdvsb48pMq9?=
 =?us-ascii?Q?cDn7QMiz+AMPu/83ZLVgMVT1LybRmRdeer+v9bqIAecxTRMOmQc/hcUS8B4v?=
 =?us-ascii?Q?WhcV3pNw4M6CQuWFn7+U8nnwr4lKu3UATADMnObJp/gJwzWH+fzZTd1MKom6?=
 =?us-ascii?Q?HHf3byVdeVZepMSnqkGXbZltltMUU1ZuzS0NcvOzq8bwsPueN2Z4ajo1kXBp?=
 =?us-ascii?Q?UZ3YBhKvfu6eDJ31xrgJ2koMPIdzea+KGAQCE8z3PjPj03Jpt3ock1l7ZAH6?=
 =?us-ascii?Q?6eEolQMLpTex2VBBaBthOpAIYY7QLR3tbfj5SgMZN1vAjrBeE03xfLm6qkcC?=
 =?us-ascii?Q?vHYNmcIY+j3g+UJyCRcut5SB1kI1BiGvgwDW4dWHwiaZgo4ctOZi/WZMWlu/?=
 =?us-ascii?Q?NtPcgvBnxjIrwvkXXm4SbttrLHDVHty4fDffvSpKHQjK6VIQRBv1JGnMUHi4?=
 =?us-ascii?Q?SzImASunLUTW4/oGzDC/TOKyQJR2oXiG2cRpLxJfq9h3FFsYalq5zKf7Q33N?=
 =?us-ascii?Q?vLczNii7wnsWtg/HYdR0vcaHEZQFF2J8THeHoTvZafXCzZXX+FuadFA8BHDb?=
 =?us-ascii?Q?uKX3JwTu+p6dlgGOi4G/ARFhCe5srRRv+TdfEseaMzy67xDytpqquga2W+W6?=
 =?us-ascii?Q?oe2fqtHGMbqhicnP1HtrDLnF7pI1fkv8NII5eKzwjJ3rdOKihFjtDF/LrDqm?=
 =?us-ascii?Q?bsQjmvCZ+gr5QtLJGspX?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9446bca8-bb8f-45e3-1be9-08dcd8bf55ef
X-MS-Exchange-CrossTenant-AuthSource: SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 15:25:47.6461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3P223MB1035

On Thu, 19 Sep 2024 at 15:54:21 +0200, Thomas Gleixner wrote:
> On Wed, Sep 18 2024 at 11:23, Steven Davis wrote:
>> Add cond_resched() to the busy-wait loop in irq_work_sync to improve
>> CPU responsiveness and prevent starvation of other tasks.
>>
>> Previously, the busy-wait loop used cpu_relax() alone, which, while
>> reducing power consumption, could still lead to excessive CPU
>> monopolization in scenarios where IRQ work remains busy for extended
>> periods. By incorporating cond_resched(), the CPU is periodically yielded
>> to the scheduler, allowing other tasks to execute and enhancing overall
>> system responsiveness.
>> 
>> -	while (irq_work_is_busy(work))
>> +	int retry_count = 0;
>> +
>> +	while (irq_work_is_busy(work)) {
>>  		cpu_relax();
>> +
>> +	if (retry_count++ > 1000) {
>> +		cond_resched();
>> +		retry_count = 0;
>> +	}
>
> Did you verify that all callers are actually calling from preemptible
> context?

Yes, I reviewed the 11 calls to irq_work_sync, and they all seem to 
occur in preemptible contexts.

> If so, then we should just get rid of the loop waiting completely and
> use the rcu_wait mechanism which RT uses.

Will do that soon. Thanks for the suggestion.

	Steven

