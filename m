Return-Path: <linux-kernel+bounces-294796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A47F3959297
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 04:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8FB81C2251A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 02:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7C63EA98;
	Wed, 21 Aug 2024 02:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="eR5VYJAp"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2066.outbound.protection.outlook.com [40.107.215.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65A474040
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 02:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724205742; cv=fail; b=tvrPJO9ohEMjvp4LrF9cO+DDjR5wb561pvTg18lpx6fFMNdTAzGJprG3LLaj1d1DQsg8Xqka7eX8U005LmM5bONA4V5Sc8dYBLT6Jf2BQdCAktgNutH9bvhuCmYZaqcta2RKup+x55kPugid7t83pdB4KMvGnVZLHxjYjQYT7q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724205742; c=relaxed/simple;
	bh=7iNXFBvDTokVv+WAOgT2oGXAcdv3Z+elskACbhfp5c8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UT0wFKYTXpRCgb3dLOTVa+kX1+CVdXyhhveDrIJVl0/HbDRBDfIa2wROa4XHB8bnpW2CVX6VWFtHMbItZMvAlSH6qjvfU/0IOyd6LtSC1har5anpbNxpxcsj9FlsOqt3NhLyiUJHt+ZfLzDAmcNHrnbivpl4U20l0sCBxFCOmn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=eR5VYJAp; arc=fail smtp.client-ip=40.107.215.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnNxK+bUBzFBqdZKobJb1ED1tG5METQDaJjePX5fL4CN/9CVBJyyk7UdRXfbtza03dAm7sTcq09ejvMxz1f0/x3owbZY+CLrsx3H05Hb4LeWiD25vjHS2a6RpmbAwVXbFniEBI2PSd1Z9ptR/9LfNSnx6niZza8m7dXAEyWVkm771tUbyElccVuDmAP+/0C+koAd5+aqwreatl5XzbDGx3e1oJL+s3UITf+7QppeFf3NS/NQ7NzIw9Ha0h6c2w2+9EWDKXuf9ioyM7IYtQ67VdowSeasjlSGg83EdRqYpO0zpI6c6xFBJQVUu1gi+P68SoR1E9GHvZWML2XNXRPcTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iNXFBvDTokVv+WAOgT2oGXAcdv3Z+elskACbhfp5c8=;
 b=pSwyLCpHf4CsPRtFKzT1oe+VKIU9RXBeWCJAoZIWiW6HGFzyXh9RFr9uH9OX4HO1NCwxudeC3OSQ8LmQNzTnQEGoyhFhDa2qpX8JlpFpxsfde1HpP61ahG2V9h/YtihQPANqDNbHufpUcTmDP42jx8Ui4q2cpvjdmHm3jQvB+HP58Nd3thH1dI7JeH6wmmT6eijc/2ktp/6VjM3rKAzRuOVXj09vVjny8NVx0tbwsXOzdnI6KaqJX2Cd1V6If2521d6LmUeP+svSQPznZgoPdj/sgAAYlepIokz5drDp4samdZWaCXw4rE/0ejLaveQE5/Gnm8w0gVbAm6/oRea1Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iNXFBvDTokVv+WAOgT2oGXAcdv3Z+elskACbhfp5c8=;
 b=eR5VYJApRhUpos62pzThjx0GnlclamyUcws6gi6fyC9v2N9P/+4zHBiq8B8ga0Ut8lWiv1ohmDwyTXU4eO86QjhGavr/MSLVzFgEC9gaR03e0XqZzXjUZfMFjp9DVyuwFcs5fYVQMhnOf+JnjG3iFr1Elz7zhRFbFnrd4+ssY7Gwe0URMiJCoRAgK9Iou7H6k/Lq4xIq3IRqYM2LVAePx0FtEpBw2fC4S5Ig8xIN6YHFVskr5F7LG1so7z50+3OsbVmCoF9ekVA/3H64S735/54fow2lyM+3I5LAmx2v5Z9aevFdrfsYkz9cuBwRu7FUXDVRfFmVq2KT5x6NWhN0sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TY0PR06MB5472.apcprd06.prod.outlook.com (2603:1096:400:266::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.18; Wed, 21 Aug 2024 02:02:16 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%6]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 02:02:15 +0000
Message-ID: <53745cad-b586-4467-8fbb-bb3d47e66d97@vivo.com>
Date: Wed, 21 Aug 2024 10:02:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memory: mtk-smi: Simplify using devm_clk_get_enabled()
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Rong Qianfeng <rongqianfeng@vivo.com>
Cc: opensource.kernel@vivo.com, Yong Wu <yong.wu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: <20240820123426.48694-1-rongqianfeng@vivo.com>
 <101f33d8-9bb9-4722-9a6a-718394246b70@kernel.org>
From: Rong Qianfeng <11065417@vivo.com>
In-Reply-To: <101f33d8-9bb9-4722-9a6a-718394246b70@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0102.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::9) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TY0PR06MB5472:EE_
X-MS-Office365-Filtering-Correlation-Id: ac74b2c7-c54c-451c-e3ec-08dcc1854734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ai95d0RYNks3NDFGTWszYjF0ZnY5Vml2bk1xWFZvUzV6SmVtY1FYZms1dGkw?=
 =?utf-8?B?a2NLb3llNUlvTzdZekZTMFkwQzE2NklEa0VLWUtWMVViZGp6VGxlQk9aak5x?=
 =?utf-8?B?SUl4cGpLcmpQYXdmRjUrTkUrS0pMUGxMRFE4aS9MaE1ldlptSDdJZVI5Nkpn?=
 =?utf-8?B?VEFiTDRhYmZxcjJ3QjBIUVlBVHdFM25hWjBBeVRySTk2U3h2ZUh0OWF0bVJl?=
 =?utf-8?B?dk5kVHFOVGV6UkNka25tbzdJMG9SNWp4OFY5clBzZ01uUTIxeHF1enFCUi9o?=
 =?utf-8?B?S0FLTy9yczg5NWNmZ01oSUJuWnNwdE43NDRwZ3BsLzZGQUN2Qzk2SW5KaVVa?=
 =?utf-8?B?QTdNMUltc1UveUF0alAwNkhMcnhadlUxSnlKRitrd2NvcEE4Y2M1dHlMUHVU?=
 =?utf-8?B?WE5DS1NzeTZFb2hqZXN4R1QvNmM3aDdONXJNcnVPQ21TSXIwOWJEUlUzVkRZ?=
 =?utf-8?B?YnpXSE1nVU9rN1NmbWt2dEpOMXZsa3R5ZW9mbklJRWtqcXptMTVxcUtxaFZU?=
 =?utf-8?B?QUsvNm5JUlRUanYxUFhsWWROVVNtWFo5OEs0YVUvNHVQOE9QdmhSNkZzbHFs?=
 =?utf-8?B?T0FOa0kxUFVUcVFDYVBEL2NicnB5YkkwS3orUGVwUWtQaU5GMXB0V0R5QjM4?=
 =?utf-8?B?TlJjeGMzazBZRnVXZ2tESUZkQ2Q1SDF5S09uWTJRU3ZUNGR6S2VxWitXUlZ6?=
 =?utf-8?B?OWZpYkVOOFFvRFFMWWR2SGxOcTU5ZUw0RHNiZkRac09qNGtJMHZsclhON1lo?=
 =?utf-8?B?SlJJS0lWSEFnUGtyYXZDa3JvU3A0WTZiYTh3REhFTzRFNTdkOGN0dXN2c05N?=
 =?utf-8?B?QUcyVGZQOU5aR2l2Um15RUxTV3dmcUdOeE9QanBoeVdveURqSjlSb01waXVy?=
 =?utf-8?B?ZjkwYzRmdEIxQ1N4QlVVY0JidXZZb1MwMVc0dmJwcGVmQjRwbWlyTFRkWkEv?=
 =?utf-8?B?KzNmMGVYZ0JBbWZqbmRkbDZhSzJGWU1xQTFGcFN0MDdaeGdwVDhVQUU2Sjh2?=
 =?utf-8?B?dDZ0MHh4VllkblRDcXE1aHhjZlNySitScUx3ejlZbmxTNTIrMWRacDR3TW1E?=
 =?utf-8?B?bkVHTjdOUHdRNmNpZFRpMkMrM2lnQ3BnaVZ6RzVITHJnTEtvMUswRTBjVFVu?=
 =?utf-8?B?QW1xSmFuc1VxdjhKOWtoQVlvZEdDVEgxcngwL0VNd3RNOWk3bEZ5NmRoOWJG?=
 =?utf-8?B?Uk5DSzUzYWpMQVRRcGpaZCs3eitOYlRIMzQ0WGFlZnVwTTBzUmtvM2dIa3k1?=
 =?utf-8?B?emUvdUlIZ0FMbXZ4OWdyQm1HbllEV1BvYk5manNtSExGTjhYU2N2VzlSaGlD?=
 =?utf-8?B?eEpqWTNPeDVoMUROVEwwdEs3ZkdMNXpZeTNMSkt6NGR4YXZmb0tqbXhDV0ZR?=
 =?utf-8?B?S0xoOTNyUjVhMndTTlJsd3pUVVhUS08wbmkwNmEvaU5BQUFLQ2p0VStjS2ZT?=
 =?utf-8?B?WW5PcHR6M2IxWHBuNVlCS3VrTTZkOUgxTlJuSFlPUjFrVWdPNE5RNXc4Q3Z2?=
 =?utf-8?B?ZFZMendNL1BjRUhYS0lSaXEvSGxDc295Tm12SHFMQXdEMUwwMDBVSVZKaE5W?=
 =?utf-8?B?a2RMZ1U3STQ0c0xsTHh0djlPdEwzVnRiQlBvalNnQkUzVkVUUkRvSlpyVS9U?=
 =?utf-8?B?ZmhHTXc1L2ZHQjJTYXdkUG0xb1hDdnQycTFsa2ZGcml0UXdnVUtidHpsUmlt?=
 =?utf-8?B?ZHJoa2taeEFidlkwUjNQQTg4eCs3S3QxWlV5ZmhGWFZVOWwrV25sZ3VONnV4?=
 =?utf-8?B?N0NEa3RnTkR6M0ROckxxVWVOWGFkazBSUGVyZ1orS3lRY1FZQllyZEtJVWlU?=
 =?utf-8?B?bjRGY3dyN0xENTdEZ0lYSzR1ZksxWUdhdFpJcCthbDdaOElJaHdQdjRCTkVT?=
 =?utf-8?B?SXkyeFhkWVhCUVl4b2duTnZmdXhJdnNkd08yVlRsMEFFeCtWWWVLS1YrUEFr?=
 =?utf-8?Q?kovrpKFk7aQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUpQOFpEUklyTVdXS2E2VURBdkNCWlduVGlSd1FxQ2lRMjZiWXJ4ejBJSnZW?=
 =?utf-8?B?QStLdXJ2Q2J4WnBYWHJEejFFQy94NGkzM1RFYjUydElDUG9iNGNVZUNxOTJU?=
 =?utf-8?B?K0RMYmFsUXE4SDNQdUl1OEJ2djFPL04vcXMzVXc5SVpPN1VQWFE1Y0VsVzJv?=
 =?utf-8?B?clEvVm1MYlJua09WOWxISHJVRFp3OUJFd29vY3ZibTlHWGhudE51ZjhhdVdl?=
 =?utf-8?B?Y3hXUlJzZ29KbE9UYkpHaUlSLyt0MTVIWXhETjlmOURUMjFyUnRRWE1GaFhj?=
 =?utf-8?B?OFVkTVNZdFFvSEJGNzl2Zm1DUmoveFphbFRRN3FrWTVFWWFHNWVvdGliYy9z?=
 =?utf-8?B?NmdhYXBDVWkwQlhiUVFUMW41eHpoQmZycTljS0EzTm92Rk5RQ0lCMVE5cDJq?=
 =?utf-8?B?RzdnZ2s5Um1zUUVLcmJDdERGekFZS1lma3N5VXkxdjhYcXpZV3ZQUGs2S0FL?=
 =?utf-8?B?dWVVeS9vYzVsbGVlTUFvemU0cW96enJaMy9sekYvS0hJdy9sYmt5TEo1cDY4?=
 =?utf-8?B?bUVLUlpSVFBMdXZsTWwvM3dFMTFrM3M0c0tlT3JLcHJTRS9tM1Q5a2FqYTUx?=
 =?utf-8?B?U0JSMTN4elJSd0Y4czNjZVNRWDYyZkc4Q2lCdWNCYzNkT1hkajB5bkt4S1Yz?=
 =?utf-8?B?ZzMrNmlyTDJJSTl5TlllRVRXS2lnVFlPdkFLNTNjb0kwcEdxNDg5bzJLVksw?=
 =?utf-8?B?czBkbXcyeUl4eWVrc1dLSDZJQzhOaHcyWEJRb084VEtPbUxHK0RiVFVISWNQ?=
 =?utf-8?B?Mzkwbnp4MHUzVXljVy9oMzF4VDExa1hUZGZSZW12eElFczJrQUtycjN3SzZO?=
 =?utf-8?B?TXFQSURyQzVZZUpNTng2bjZGL0Jzbnk1U0pmalZxZFcraVU3b1ZXOThPWnVC?=
 =?utf-8?B?bnRlNG81elVsenl1M3h3ZkFMWDNNSmxJemRIdHNOeStnMXdJQ2hiQTREQjJk?=
 =?utf-8?B?Um1HNGpXekNNV0MvMjIwRWdac3NCanJLQ3FRTGVyUytyMnNmbmJvYW41bjdx?=
 =?utf-8?B?RFN5azN5MWhyL0FYTnYvR2U2cVBwQmkzZG1uazJ3RjF5dnRnZ1ZsR01jZnFh?=
 =?utf-8?B?dXBlSVNVMjNZaXY3UUhaTG9ZUyt1dUhUdGpOaDEwbkNOaFI5OWhQUkxsQlUx?=
 =?utf-8?B?RjlteEEzNUR1V1k3L1RJUXJUM2thdnZkUVFVdTNRSzRESFdmSmlMYUJvRi90?=
 =?utf-8?B?bVVQYm5TMVkvNUNKZEoyc0dGRGdrNG9jZHMxQnVKZVpqcUN2STQvNVpENFFO?=
 =?utf-8?B?NmRMbGJRbWcvVHFyQ21GdHQ3TUJUUlJVWG83d3dFL2p5WVVIcGJQN3c4YUw1?=
 =?utf-8?B?OUxNeFc3ZFhLNzRaY2ZTc2ZmcFJueDEzaGYxd0t1cmxtckRVUmFFdHljOFBR?=
 =?utf-8?B?aDVpdFRZVXRzYnVtZVJkK283QWF0RXBYSDdqSkJUUlNaWXhGOTM5ZEhkbmxT?=
 =?utf-8?B?N3hCZGp2SUptTUNKdUpmc01KZVZob3FNVGF0cjVBL2UrYUdxSzlQL2FhenVQ?=
 =?utf-8?B?N2JJc0tkV1c4NHJtYUNqM09nS1dQSUlsR2ZZUkwzWkZzTVBjOXo3anJEZUQ4?=
 =?utf-8?B?QjFCNFBQd0Z1ME4yVTRmbys0TXBmVFRHc1h6dGN4SjY0enRmaS9BeDk5blUx?=
 =?utf-8?B?OWRwb0pUUG1rcnNSWjllbnBhcWlqdUJPeG44L3dldVVrQjh0ejlwa2NjZjNq?=
 =?utf-8?B?c0hUYUdYdFNIeDUxY2JhYTc2YnUyRzZlRWtoMk1BeGdYYm5EcXBYYjlINFQ5?=
 =?utf-8?B?UCttb3FWL1M4V1paWDhxbDdsUUxOVTMrRmNMd0NXSCtHVG5nVWd4dmNjemhm?=
 =?utf-8?B?YjdSOGdCUmFObG1WSEY0RDJYQjc5NklLN0FQYVZtaWNxR2txclA0V3BpUXBr?=
 =?utf-8?B?UkJjaE1Vd3p2RkhyenhFWmVTeUZzUlNaNFdjQlBqbDlEeno4Y3BZQ3BJUW00?=
 =?utf-8?B?em1rV0NzT3R0MjhteUpweTQ4Qnk3M1dwRngzM3o0U3hMWVA4MjZmaGoxcFls?=
 =?utf-8?B?bmpGZ1ZWQTZYaTZpSUJIVVJkc254SDRsVjh4Yi9WZDc4MTJFeVpWVjg0VTBD?=
 =?utf-8?B?WDlVNTRuU3NIWjBwRVNhd0Q1RG1Ic1g4cm1KQU1UbkZHbVBxbFBUVXV4RVRF?=
 =?utf-8?Q?l4tJy76y+e8HhDJjeJouGx3Fu?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac74b2c7-c54c-451c-e3ec-08dcc1854734
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 02:02:15.1952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFqd1CFVsO3DbsI2rxqd3cWxbJ0zH+aDiCsl8Yo3de6K8TjvFpLsi7fvg5QSWUb6xnynT6vv9b2rCFdkQBCP9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5472


在 2024/8/20 20:40, Krzysztof Kozlowski 写道:
> [Some people who received this message don't often get email from krzk@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On 20/08/2024 14:34, Rong Qianfeng wrote:
>> devm_clk_get_enabled() will call devm_clk_get() + clk_prepare_enable()
>> and the clock will automatically be disabled, unprepared and freed when
>> the device is unbound from the bus.
> That's obvious, drop. You do not have to explain basic APIs. Instead say
> what is being simplified here.
>
>> So simplify mtk_smi_common_probe()
>> accordingly.
> Also explain that you fix bug of missing unprepare in unbind and add
> Fixes+CC stable tags.

OK, thanks for the reminder.

Best regards,

Qianfeng

>
> Best regards,
> Krzysztof
>

