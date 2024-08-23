Return-Path: <linux-kernel+bounces-299779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D4D95DA04
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 01:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594961C231CA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 23:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F9B1C93CE;
	Fri, 23 Aug 2024 23:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="N6XdgojT"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022132.outbound.protection.outlook.com [40.93.195.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CC81925A9
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 23:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724457496; cv=fail; b=ZA/35obtbnGRTE72tvM/5oIIGLQh47O00MBf8U8e9Wlf3i8kpDyg0Ab+PzFmZzyForGGjS7fkagcPWUb5PfLc/9ZhfZm1bW2HtoBudtPMyNea4LslcpWFqVZWf7iX+pN/msaUR5J7SVypZNv/EbdxvTalxDpb9CP3onYpALPmxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724457496; c=relaxed/simple;
	bh=2WA/jek8YPrTuFovh+uwMKTTXmdRvNzqNrHDoCnG4DA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=Hx0tio5aLzcMLskqfeT2oWaxv6LWo+7DzwCkTESnH1cwBDlENYguuBABVG8I2pPAbV4e35y7DpKCQ3EkAKi26ur6blorzcIZUi8KgieGK6iV88npqZBjemxaqHOyMIUKHNVahfS4F2R5Fd0/j/wE/Ij6UC4gUMzD4GNB4jox5m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=N6XdgojT; arc=fail smtp.client-ip=40.93.195.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qo/TZ451bZfyzzDXcjPfZeZubNXu/7RU4DZGlG/wngmiD/XSoMPTpDcy7DVvHzDhc8YP14PkroWRYDqHmaZzffL6zm4GKFR+qHBkTTYBmSsk/cNTV/OEzH2vZULrk7GfBjXKCwJ3Yxx3ZjxnFo6ZG4tFQQ0bsqAodmgVvl8USxAgORZaflRCrS9A0UYkcxN9MU5qzKTHC33u4lTXM8fVzla8680USp2ryi8+rva1hw385x3SszUMoeeON+sEiH0BgoYronG5XsYRZL/IcTbI7Ir9IF1dM3On5O47eXTBEF8cyC/kvqoZE4qWE9Ka2Rfd0clZZQuJWHIAIvBHKeU7bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5ahJnojQ3daMpQ8/NDzxrK1U4eiKz0VIHIs+1p4Ixg=;
 b=yB9WtV1WQwuLuBC5e8oQ3lhfl1qRQUtUmOv98tHzQKEGasKTXXJE7lAsRX9yjIHjJ93jDDmtix08GykzbWNkX387WWxiGT79G8daF/xdvIjfn96rNUVlySxau/oVgamV8Zw3cOFKTyLH9ikRb4VX3MuTiijJnoxKeq77gAogwRpqSbMixahgXWecwBFvXk5SmNWvLcW7ekgYrez83/qcPiMXc2RUcZ/m//rZ7x5lk9ywmfMQ/XHhniQ1d2NA7oxL3Ez1dDWRTwQgnrItbHgYbL24oebetLLeu4J6JjsvPYqYIwfnw9rbW0hpjUvxacCo9xrStoABxDYSFsOQXr6Suw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5ahJnojQ3daMpQ8/NDzxrK1U4eiKz0VIHIs+1p4Ixg=;
 b=N6XdgojTO3ZbzckM4dUw64EB7l8asvSNHQwTKjryCkTPyNNlHN7WN/u5SOnXytICmP7XmQNBcmlpIaBMyt/fz0hDdDJozbUXeApwUvKnNjtxfUZUh7AzC43PLq1jGa0TiQSQtoZAaXh66dsNx3WoQBn9uvnKzICzYNoP51Nqbok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 SJ2PR01MB8126.prod.exchangelabs.com (2603:10b6:a03:4fb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.19; Fri, 23 Aug 2024 23:58:11 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%5]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 23:58:11 +0000
Date: Fri, 23 Aug 2024 16:58:07 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: Mark Rutland <mark.rutland@arm.com>, will@kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
    ilkka@os.amperecomputing.com
Subject: Re: [PATCH 3/8] perf/arm-cmn: Ensure dtm_idx is big enough
In-Reply-To: <22b69400-af16-4e78-8f72-c10564d7cc6c@arm.com>
Message-ID: <edd08294-df5a-a297-31c8-7b1934c374a0@os.amperecomputing.com>
References: <cover.1723229941.git.robin.murphy@arm.com> <aa9d45b10814dc6b2c59dfb2c1be49f333dae1dc.1723229941.git.robin.murphy@arm.com> <Zr8ma7pt7te0qxNG@J2N7QTR9R3> <22b69400-af16-4e78-8f72-c10564d7cc6c@arm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: DS0PR17CA0017.namprd17.prod.outlook.com
 (2603:10b6:8:191::28) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|SJ2PR01MB8126:EE_
X-MS-Office365-Filtering-Correlation-Id: 9901bde0-1695-4a3c-2acf-08dcc3cf71bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EmWNtM3IefRFRMrTp0WJnpZoXTxCyU48k/1er5OabZKdSbpDHpdhhfkopLxO?=
 =?us-ascii?Q?ihYky0BIKCOLBLOIhF34mZbZu+0ZUT/RUsESmk+9jF0uEuAwy96T/Nj35hkP?=
 =?us-ascii?Q?0gSAh5U7qo8CN929+iktFf+mG0qhedBpIMClnKByU+25MubvjDCUFzbYaPLB?=
 =?us-ascii?Q?4wB3q57uwR0H/A1DQzjK/B9qvgj4AFw7Hsmic2T1ytafaPD5XgrmKDVhV1Z6?=
 =?us-ascii?Q?XLdpookQBg5bsUkgxxdb4umSAUqd0Gti6b7h7X88IPvQrk943VvqwW9k1Qrf?=
 =?us-ascii?Q?WiSXx3nEJGL+61kxLAiYgehkTvxBL2mM8SlgfUgPFhkN8RtCvgjtPtVo6115?=
 =?us-ascii?Q?2KXs+y6GxU5MlGcoeW4wJIJsx5877cMvstg6Jz+kGylqaAR60KGnYP4cfxl6?=
 =?us-ascii?Q?khvskgcQ/nrMfjf5gSyeVeQOItBzpPgCkvoEaz9yKlSSKfmcSU9zS9uDtZam?=
 =?us-ascii?Q?SQ5U6xJG28MmjcNcVz7y/4/sm3PS6Y0TgXKtqnpFMuJqr8p8f9apySpsf6yc?=
 =?us-ascii?Q?SDCA4y+E6eQwOHaGhMnpJU8arvus1qyHs0OiQmfc7nBIT+Cs8sXSGlF0IGVS?=
 =?us-ascii?Q?uPQoT1RVpwb2GnLRf6XQuuhDCCQ+P82epVU8OmlnKnODfqQZeg7uqGc6FXtn?=
 =?us-ascii?Q?lxTVAp8IB7BvHewczfYUo6jke6AIw/NpTzlblyW8TrbprAx58scfmDBhhe7l?=
 =?us-ascii?Q?FoJuYx/5e57NMABZVt+0JXj1KpSu4uljXyXcMbY9KTqXu4X0vPGSxLCJXoUO?=
 =?us-ascii?Q?A+5hMSpk4UFO/QQKhePWsXQ7iP+mHwvxZJ9eXd7DaQ1sG6PF+qCK6qubgdxl?=
 =?us-ascii?Q?Hu5fPeMpN0Z5a2KAOe7Vgi0v4wFyMn3fXbvWKbETmuYdwa0jTRMSAskUNYwK?=
 =?us-ascii?Q?qFQ6TxChcK7JXM8HMNvBzsV8+3o7mmYeP1uHri0WnJIP4PY59NrsRR3uV5AX?=
 =?us-ascii?Q?+U/2ctg6S7uW/LcTaKmLfpb9RzM8knrrW6rn1lm8HlET7Z5oI8hBk8wEJ81/?=
 =?us-ascii?Q?77BYJKBII/2HBZpXaNrtd3kXZai1UHi56w8Q+rgzUEiFlcWCwG9TI+dAQRZ0?=
 =?us-ascii?Q?4hA7/Z1DOoLbAODSIA/zz76eNDkjPFxmhmfLd1wL7d9BuAKjKxa249mNXStC?=
 =?us-ascii?Q?rLG098/T+2sT+EXK7t4/CSnSQyMc9LmW33XrFCN78Mx9pfLPiWLTny9TlCZj?=
 =?us-ascii?Q?/vAKq2oqvcVxhYuaN5CruViHMJzrw6Isn4BnNfFoWGEd6XQQftaTWjI8brlP?=
 =?us-ascii?Q?nfs26GN4lNFVkrhwHH28YMqu3ZK9gmBQEkNLuj4NeiPqK8F54/2pX8K/8+5Q?=
 =?us-ascii?Q?SiVSWLGk0yMgnA+gX6L+ZcbIhHpr6TMkGmtmTv6hkXtTb7PzRietz+dBCkOk?=
 =?us-ascii?Q?7/pPqSos1LsAEi4vV4gLYXdlemYqeeNMsuCGpMu/TW9AuUH/Hg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7QkxKimCpyp2lmTZseHK8ammrZ/Xex+z+fFAbuPvWxnm6GO+FYlhMH4zxRrX?=
 =?us-ascii?Q?Ev4xYZbkd/uTHtkx2jmpSOdtstgg8UywS3rFPjGR6rbAR0vHH/h88pYAxnLK?=
 =?us-ascii?Q?ArQ+2D3gPVKEZtkp1ImRzc8WtXWmiiJP3QfYDk3AZ/sWokdA87BSal3e2yIu?=
 =?us-ascii?Q?2iFf3QvmcXMJek+qjRrXIEYi16K90ij2F4LEno/ItkM3nc7mQ+CDS7kbRIgl?=
 =?us-ascii?Q?2mgOOYZxjRxnFC8w9gLJ6b0LKwELDCMjCaDnkLnX95bMhzEAv51HIP7R1kR6?=
 =?us-ascii?Q?IjSOv9XXOSpHCjjM3FPnxPdmaQo/RZeoJOEsD5fi7y7onJZcsb7Q9YgkDS6Y?=
 =?us-ascii?Q?aTQ5p+3gwO1XLJUKGHhHeW1NcXyZYGrUQ6IhN9QJ3cj8e4Cpg1HEBL6tFgnR?=
 =?us-ascii?Q?0k9cksB6IcSXqwq0e/CRWNguXsQzPH80fulNhf+0htoEs3cT7xD6XOehNF8F?=
 =?us-ascii?Q?BbPeZHul9mL2S6OHRdkoZWAyk/35uvSJqOq9Gck4mNf20OpSqwYm+Lgb1HNb?=
 =?us-ascii?Q?AZ5OtV2D4/a4UCxiCNqwJ2HlDOs21Tl/9KrfKlbMpHQ7LHipxGNl5N/fw23B?=
 =?us-ascii?Q?frGacOGE0iU9QapOTEwVMJB97AAUwPHbpaHZocY0MbiLLCo03B+mpFTkgVG6?=
 =?us-ascii?Q?ZK+zQm4+nyT+95PoL+UJn1SJclU2Egig2uiCmglV35QqE8XTHA3KQetUKTo0?=
 =?us-ascii?Q?nXco/8pIhqTSENigUnYdPnmc5v3gnmkdeJIZqTepIsDJNoDUDTu5nXn9azm2?=
 =?us-ascii?Q?Yu4sHg38O0pVEkP17XYRkWWk43Bc80hwvX8GqIW4J2Slf1Ut9+8TTp9O8nsX?=
 =?us-ascii?Q?vIY0zvkW0TZlvDdAi+tiK40jYq5qKJLZs9UK6Y5a8YRp/4J8bdlejOhnhAAc?=
 =?us-ascii?Q?RcOTdupXiFzJ8uoDjVQK5eEfJ+xAfGjymiEPk0+D1Yo3NJuawcU7SQTfP/Zk?=
 =?us-ascii?Q?klvIATQ4zlRAs9FJQAUt6TtBDpm1ZVGhRzE1YaEmsuVvm08GveBS+DEWqPHg?=
 =?us-ascii?Q?uB4T4IAIz/ctvMBaM3F2KeS8Ysg94PRECV7rDYuzW+w75lKBWvgOqJ5oPJTg?=
 =?us-ascii?Q?E74keF1vE6lpJ6mxFevYzUaurKPhk05jce2nwL7Okk4e/h3M+yL5tXcu5EHT?=
 =?us-ascii?Q?UdX0gKCqi1VYqGz53eRfe/erQuy9skKy1h2VNvavIRnoFDXjTrTSk0B4XZqN?=
 =?us-ascii?Q?23Q3/J4kdli4eOUlNQnMyUyMSXu9g9QFaJjNOvJrZwVF2kV01XAkZUrmROsT?=
 =?us-ascii?Q?oEYzVnaLSbHegAUB1Emyu+MVYf8d450EnXyPYh0aKCujX14HMWSphpgVmG+1?=
 =?us-ascii?Q?5DaXXbIp1Uk6nqCUus/ikmBniU+SJS1513vMbh175iSa+nSGJTu1lwag3HUc?=
 =?us-ascii?Q?GSA3yeynycrVffTciN8D8BV+ZNRn0YfUACvBFBev71CqLy151l41VkI50ZGF?=
 =?us-ascii?Q?o0+NfHBolNP2gcOxRL7kGBVln1PRPtxix9OS7BKJHKVnEmAmhDPgDlrrdJcf?=
 =?us-ascii?Q?yJC1plhVRDHeixJcbqrQXwsl+8O7empKRQBkHC6LQG7iTNLUXMl54gpeQQ7+?=
 =?us-ascii?Q?wxcjVM9AUJGJPirAbXCcxiN8c5+pHLNmdfPwZL2gUDvG/k/HjXtMVciOpZqF?=
 =?us-ascii?Q?KbkfV+PKP5qCLKXBQI3n9Fk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9901bde0-1695-4a3c-2acf-08dcc3cf71bf
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 23:58:11.5063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qklvoo8nmp8Xcm9m0rOF6IRWrw59fSXeNO3fj3o2gAzOiu3afH4N2t5QSlMd3FMAlHIEznA2umBJ8N9u8T08xKWN0c9DPkYiMuiWqMWto5Lo/vjBiuGOxUOQ9IQVBt5R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8126



On Mon, 19 Aug 2024, Robin Murphy wrote:

> On 16/08/2024 11:14 am, Mark Rutland wrote:
>> On Fri, Aug 09, 2024 at 08:15:42PM +0100, Robin Murphy wrote:
>>> While CMN_MAX_DIMENSION was bumped to 12 for CMN-650, that only supports
>>> up to a 10x10 mesh, so bumping dtm_idx to 256 bits at the time worked
>>> out OK in practice. However CMN-700 did finally support up to 144 XPs,
>>> and thus needs a worst-case 288 bits of dtm_idx for an aggregated XP
>>> event on a maxed-out config. Oops.
>>> 
>>> Fixes: 23760a014417 ("perf/arm-cmn: Add CMN-700 support")
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>> ---
>>>   drivers/perf/arm-cmn.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>> 
>>> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
>>> index 0e2e12e2f4fb..c9a2b21a7aec 100644
>>> --- a/drivers/perf/arm-cmn.c
>>> +++ b/drivers/perf/arm-cmn.c
>>> @@ -563,7 +563,7 @@ static void arm_cmn_debugfs_init(struct arm_cmn *cmn, 
>>> int id) {}
>>>     struct arm_cmn_hw_event {
>>>   	struct arm_cmn_node *dn;
>>> -	u64 dtm_idx[4];
>>> +	u64 dtm_idx[5];
>> 
>> Can't we size this based on CMN_MAX_DIMENSION (or CMN_MAX_XPS or
>> CMN_MAX_DTMS), to make that clear?
>
> Fair enough, I did go back and forth a little on that idea, but reached the 
> opposite conclusion that documenting this with the assert to deliberately 
> make it *not* look straightforward was nicer than wrestling with an accurate 
> name for the logical quantity here, which strictly would be something like 
> CMN_MAX_NODES_PER_TYPE_WE_CARE_ABOUT (there can already be up to 256 RN-Fs, 
> but those aren't visible to the PMU).
>
> I'll have another think on that approach - I do concur that the assert isn't 
> *functionally* any better than automatically sizing the array.

I'm ok with the patch but automatic sizing would be nice as there would be 
one less thing to verify when the mesh size is increased again.

Cheers, Ilkka

>
> Thanks,
> Robin.
>
>>  From the desciription in the commit message it sounds like you need 2 *
>> CMN_MAX_XPS bits, i.e.
>>
>> 	#define DTM_IDX_BITS	(2 * CMN_MAX_XPS)
>>
>> 	u64 dtm_idx[DIV_ROUND_UP(DTM_IDX_BITS, 64)];
>> 
>> Mark.
>>
>>>   	s8 dtc_idx[CMN_MAX_DTCS];
>>>   	u8 num_dns;
>>>   	u8 dtm_offset;
>>> -- 
>>> 2.39.2.101.g768bb238c484.dirty
>>> 
>

