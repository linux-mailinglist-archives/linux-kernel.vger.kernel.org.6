Return-Path: <linux-kernel+bounces-227121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1B691489B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CA0D1C2222A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25713139590;
	Mon, 24 Jun 2024 11:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4EvkGc6G"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75481137C2E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228438; cv=fail; b=hpLno//zXnyS5qiikevVRwVhJ4aM6qMRZjOQQ6mw3VDkdOYKfgvRa+CpcOpXsOaFe0Y+oj9HRcMfgyoRNUeEHsNCl5JID2NHev2cunfmIQaXHDAY9sS5UiP3cnbbkAeRNFPsLC+qvCFVYaPAVtCc8JsaeXboZTyF7sks/MGJzvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228438; c=relaxed/simple;
	bh=h8MzAmjJn+AayjSZoR2jiJsxmnwn8kZqaBM79ZasU44=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hHRKv56dbf4F2f2pMo+3yMDOoM/vt4Zoeor42V8WE9fNtWuhxfWBbLxayS7apkrb01vY8BlQv6HG5rdWbCl8UZtWzYq1iyzVqf4knPUpciuztODxld8ZMdduG8RjJHQAZ2RTIxT+1spLMppKFwW7+xPvPgW26HZHyJQAOrjsfes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4EvkGc6G; arc=fail smtp.client-ip=40.107.95.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOfKJPCu68ElYKl5vVmHmKjDMpOpAw0lrd+cuaP/NLxI0Zi57NUTb4cqJkOHzFitO/L+/Mv8MRj6ljm4BSQmnkbxR90/9WpahjbD1yY+CMNNG9xcsbTufkdshDOSE3PYWcU5/qGTtbCbgCIkoCbV+VV5SIcMKfTAaJ51QTS30kMZ5P+5mIsPNt5BOz2O++5b2nwxUobMDanxatlJQBYFQYrWLd+CGEet33L5tKM13NQWvypLucDeOh6p4+JGqn7suz4OphXQhcQzhkJ6MGTQ3COzEBKsh10v28hbig9ivLxgH/P2qWjHFEp7g1sfhLb5dWP0LjZrTNTjxWMPYcXo0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLwpjuFHUzXMCGynb7b3zf9hTAMe+KdSDoGtR4ndtfg=;
 b=nJEhZyQngUoURYqLfipgUSQEKp9zB3dzf6kT7pthF5ND0eoEs1fc1c84RcTFGxtnPL5ysHRCw+WHjqfwv4lcpkCrReNZFxZjWLzab7YlykXjGf6FYEvi82q34JBabzlQmiRitsXgOJcBCsw1L7vSpF/775ayOgsJfwc9HmEh+ENF1oaIKGgNo1eBzkSy4Q+ApiRTxyJwbjDJdJKNSDUIo5NBVFTtPL71aMBm8AShtcoKdBritVopgCREcWgZmz5EIAtKDfIfFGzp7Oi4zPdVk/9OyxrzJ1RS5BLLF7SKYnlPYgBxwPPYnh0MowvzcSrk8lGR5rCIWlmXoVDwXZwlvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLwpjuFHUzXMCGynb7b3zf9hTAMe+KdSDoGtR4ndtfg=;
 b=4EvkGc6G5IigVtulYQWl2x4AJNVYm6L5WdWDjYaKmLJL4nrfvIO9QC/pnl28x/HlPMYjm/pH4+C2TmrrXypLr8zkXbKTZNj83MGq+usVnOBMyT3numlZleuxxG+RDKMXHfgws+31b/4RaIlha506nGq0Xc/XZISIOhJU3/xZf7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB6935.namprd12.prod.outlook.com (2603:10b6:510:1b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 11:27:14 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 11:27:14 +0000
Message-ID: <560ed759-2409-4682-83f6-ed3866d484be@amd.com>
Date: Mon, 24 Jun 2024 13:27:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] reset: zynqmp: allow building under COMPILE_TEST
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@pengutronix.de
References: <20240621-reset-compile-zynqmp-v1-1-ede43ab18101@pengutronix.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240621-reset-compile-zynqmp-v1-1-ede43ab18101@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0107.eurprd09.prod.outlook.com
 (2603:10a6:803:78::30) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe4558e-e057-40fc-ed63-08dc9440989a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVh5OHFGYVg1ZDRUTE9XK3Voc0UxRHdXRTgwZTZjMUx2LzBBbnNpOU5QNng0?=
 =?utf-8?B?c0R0R0JnQWJoeWlXTHFKaFNraTFIMmFHVDVQY0gxWEpLM3R2VW1ZcnV6dnpY?=
 =?utf-8?B?RjdWb3FpSnp1cVF3Nk8xeHdlTUtaMjBWWnJhTUtqRUhxL1NubUFtdWZzUTVj?=
 =?utf-8?B?a0d5bXdNdGxiMzlhME9tR0drZUp2dHE0VlFMUlRpTE1qRjd2NUdlVEp0T3c4?=
 =?utf-8?B?MWM5VS9XUjRMWkoyL1VTZU5jWlpIcFVyMktjNzlsSHUwQ29DMTRQMFpPaUtI?=
 =?utf-8?B?TWhTUFpYenlYQUUxcmM0Q0trTTRqQkx5UDJkM1NlUThCS3Ivc1VRWGxtRzVn?=
 =?utf-8?B?V2VQR2hEL1VQVmV3aHNEUUprd0hXeEFVdVpHS1JZT3hZMVJZNFVWRVZmS3Iw?=
 =?utf-8?B?MnpQWnc5SEpWaXdmOEdNTnh0cFUzcGlTVkxNTytmbUMzaktaczFCNUMzbEZv?=
 =?utf-8?B?OGorUVZJNnpHVkpBcVlxLzMrOTBGWHVjQ0NKK2tINDZBL2FqbnJTV3JrUld6?=
 =?utf-8?B?SXZVMC9QaGtrcUcyTE8zUUM1M2RLZDlJMXhBNDlFeVQxcFBZUlZuMnc4T3NN?=
 =?utf-8?B?czdPWWNHWHVucDJ0T1lKMFRjSnU3eGlubkRyeGJ6MS9iYUxzRWFjMklOUjVK?=
 =?utf-8?B?d2c2THBNQnprWG9ndkFMWFdCaFJnc3lOSHJnTkNNcU9PWUFJWjFwcG8raEFZ?=
 =?utf-8?B?ZllPOFVDTW0vM3pCdi8rSGNYMFBCN1Y2bk9SYVRaS2xSRFozK1hLVGg5cjNj?=
 =?utf-8?B?RjIxTE1EajcvMDhxZ0R3MmMrTExEZVN0bDNMSHJqdWdmZzJpWGdPSThTMmJ6?=
 =?utf-8?B?d2xTY0JFMFphRWtZYlRrRUphdDFXYWxIa1VLTnJGZDBTaE5QYXQxN3JRNzlZ?=
 =?utf-8?B?YXU0K0NJdXI0Yms0a0JoSUxuVW0rcE8rZGgxdzFsUUpyOGs2Vk5qUUVnTEFk?=
 =?utf-8?B?YjdlVXMvMFYwYW9HSS9aK2Y2VnFjdnlmUStFcWcvZFlFWXFRT0VUSktPdHhJ?=
 =?utf-8?B?cVYwNllLV2d2SHFxT0x3bkdDUzg4eXBiYUxmQm9kbkE5Wk96TjVUTUw3WFY5?=
 =?utf-8?B?WlVvdnBZQlFKTk5LbUpXQUk3d24wZGNkME9PWFBGN2dYZ0gxMmpidjJzTTJY?=
 =?utf-8?B?bDh2cWc5cUprYkd1c2xJVTZacmQ0c0lucHpvOXB1Tkd3b1V6NkNGUlcxR3U0?=
 =?utf-8?B?RHBodWhDZTc2Q2pLN2tYbi9Vb2U0K0gwV1AzVzFUejFTMFdRUUxYcTVBSHVu?=
 =?utf-8?B?QzAyampVTGJxZkcwRmNhZWlWN1NVTDR4aERFMWpiQnRSd1E4TGlTbFZid2xy?=
 =?utf-8?B?TzdRK1dGcll2WXp6dFY4bVlnRkgvMVJSSkRaSjJnU1lpWE9JWGdXYVdRZ25Z?=
 =?utf-8?B?aDVpNVpDU0p0dmhBYWJoZHpzRWVJQS9hTU53eEg1a1cyOVhpSnVOaVQ0L0gv?=
 =?utf-8?B?QjEzYlFvT0RzaVVGOFR5WmZnclR4VzNWUHFpL3B2ZlY2L1Z3ZFgzUG5UQkx4?=
 =?utf-8?B?cUp3TlhhTWxuUG1sMUhxVzNYWVU4Tm1Ua3Jpdk1IUGtkdEdMMnlJZWZIQ2l2?=
 =?utf-8?B?K0RlVXFKWTkvN1NvUGNEQXZKWGdJaGRNcXRsYlBqYXpnMnYxZ1dHRlpyU0dW?=
 =?utf-8?B?MGRxbllnMnVvTDE1bzF1T0VoSVVCOVNxT2lYUlVrTXpROFo3cExCUjNuWlRJ?=
 =?utf-8?B?MnFjSG9SZWJtamtoaFNqZUtWTC9mTERwdVZOeklIVGlac2NpdnN4RVk0Si9w?=
 =?utf-8?Q?i27/lIgG5tzL5bY9e/5JLNf7wuV+8Sz8UaTf6JN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUlBZGZvTXllUjdqaE5qSE9RdEo3YVBOOVExV2MyRGlaU2hVaW5lRXhXNFEy?=
 =?utf-8?B?SzFOdW5ld2tIalUwazdWVEJGMUNRWW1WTEl0YUlwVzNNRUc1dVdseS9KcnVY?=
 =?utf-8?B?Z2ZkUVpNcGh2NDV3RllKVDZnZVRid3FmWWk1YkpxVzAvQkxZREFDVTdWeG9u?=
 =?utf-8?B?NmN2ZWxNa1ZqWHlBMDVlV3czcXBibEVtVXc1Z0dwVk9LZzlUbkJDTWxpR05j?=
 =?utf-8?B?RXI4V2pIZmZCZ2ZodDFuWVU4R1JLZTBpRnJLcm5qeEF3aTBnVCtlYWFmdmFr?=
 =?utf-8?B?Z3hpVTAybElmdStvbWo1eGNGVGhFY0xwWEk3M1RyOUdOeTU1aXBpcExYRndv?=
 =?utf-8?B?Yk84MVByeHJYSkQzWVZEY3g0a25UTU00ckk0UjY2MVlrS0d4OWZCZ1NMTS9l?=
 =?utf-8?B?NmZxdWZHSHJDamNvVmxvdjB5aDVPbC8rUytHU2J0ZXlPMUpiWDVySFFPbVdp?=
 =?utf-8?B?OVhJYWZ5cHcvcTRkSnhSUmxIc0l6anlhVHhnZzJMNmZGa2tNSzYyanE3bmtU?=
 =?utf-8?B?djY3MEx1SzViVk85ZlJZbGExWk1sN1M1MTBvaDFObjBPUUxLZlhoYVpjU01t?=
 =?utf-8?B?d0tCeUlITEpDRzQ1SDhDY0ZRamxnVVpaVnZDWlRpQ1FqSGVVYmFSKzU4S0c5?=
 =?utf-8?B?dWJWdHFua0M0dlFWamZldGtwZlFmQlI0QWNwT3pveG9Va3lkd3VUWW1qLzQr?=
 =?utf-8?B?bFVEK1dLSHlWakpRNG15TU9FSUxnYnRhbVJaTm5yTlZYMWNIVlhXSmhVUDVI?=
 =?utf-8?B?ZU5kZElVR0ZHNDNrZXk4MzUvSzZqZ2NrMHlvZWs3VHllaER4ck5UZVRkUkZF?=
 =?utf-8?B?Z0VOUlBVQW83QlkrL0pqUTQycTZ5Vy9vM1NxdGViV29tL2YvbkV0MDJxZ3l2?=
 =?utf-8?B?dk1hSjByTkRpRVpRNzNvaG51QTJJenIzaEliR2FESmp2QUhiRlVBSzQ1amk5?=
 =?utf-8?B?QzBpMGVNdzdiS28rUjFQUDkyaXJLWGZhcXlHZEFCdmxBNkMrY2FoaVBPRTVr?=
 =?utf-8?B?VkZGOFZuZFZ5dXJSRlVvZTZma2FIWDFHMlNFdHdoV3Yva25BeVVkSUYwMGlo?=
 =?utf-8?B?WE5tKysyanNscEdzdERxdlgrZnUyWUFZcVpZcURLVW9XU2ZwRjhJbHZBWi8v?=
 =?utf-8?B?MjJhcVFrYXRIYW03UUFlaEZOZmZCT2NBUENpdlhmYnJkalpsT3hWRTRXVUk1?=
 =?utf-8?B?Q0k2Nm9YY3dzekg0bWpZVWxiUk5ubTZRVExWbkt0aXBmdXBlQUYwcFU2S25k?=
 =?utf-8?B?dEd5NkxJTXI3YTd1TWxldkpOWDFLS1ZaY0l2cnJldTFueXdsUkU0Z3E4anNN?=
 =?utf-8?B?M0pwSzY3ZHhILzJkcjBaaUV4OEdaMGU2WjE5ZmFlTTc0ajdXOFUzSjk2UkJ1?=
 =?utf-8?B?L05lOUVhNjloUXVUckQ2eGhxVU5KanAycjBKV3MweFdPOTlsQlk2U3ovWVRZ?=
 =?utf-8?B?bks2N3FkUFJVQnMyczN6bkE5dXFkZzRQbWpseGNJY0JxaktrL1JZQ2Z3Qysz?=
 =?utf-8?B?Y2dwdVhncE1sWGZvN0tEMDI5a09EYUZEelFPSENlaG1idmVKMFpnQUhNV0ZF?=
 =?utf-8?B?VUNUbFhNN2dPbkhWTitaYU8vUmw0U3Q5dDU4dEtJd01vdHJ3d2JTYVd3Sisx?=
 =?utf-8?B?RmFwRGo1TkJ5Z1cvVnNKRmtFcVJzaWhPTG5qQ1ZrZVllYWxWM3BJcXovdHFU?=
 =?utf-8?B?aHlrZnNLODV3VG9ZNTYxcE93T3F4LzB2am9IalBFTG9Qckk5cWRSbndGTnAr?=
 =?utf-8?B?eDJZdk1XV2JXejFPWGEyMHlyS1g0WklwZ2xNb0R0YXo1NDM1dklTRzNpSHNB?=
 =?utf-8?B?RUlET0NwSGlTd0ZQK3kyMUhpd1BERG11OFdLandIZldGeTdVZEZCZzdsZVVF?=
 =?utf-8?B?azc1RXhCOG4rRy9YNVdlcWpWeStrWFRGemp3eTlXK0tuNHBwTXlTeUUwTThM?=
 =?utf-8?B?Y3ZtVW5FQlNRRG9SdXBCSEMvd3NQRFRHVkZ0UzdicjEza21TdVgvYUxyV3lj?=
 =?utf-8?B?R3J0dEI1T2NhUGdDdjlaSjg2Qzl2Snd5am1rbkg1UzhLd21EZTltN01vWmZC?=
 =?utf-8?B?NVpuMXhNbnBDOUxjUUQxaTdheHRadERNTHVJeXhZU0tZODhvNmJuNURuWFYx?=
 =?utf-8?Q?cqCFlQJNCo71BwuAZ0iqK3F6k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe4558e-e057-40fc-ed63-08dc9440989a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 11:27:14.1583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5d2W3lK52AYuyMD/bZRaoIyZY3ANiiWYC5TqAfp3gaU740BkAy0rKhGC8CrwzeNU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6935



On 6/21/24 17:24, Philipp Zabel wrote:
> The ZynqMP reset driver can be compiled without ARCH_ZYNQMP being
> enabled. Allow it to be built under COMPILE_TEST.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>   drivers/reset/Kconfig  | 6 ++++++
>   drivers/reset/Makefile | 2 +-
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 7112f5932609..9b914f8818ef 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -328,6 +328,12 @@ config RESET_ZYNQ
>   	help
>   	  This enables the reset controller driver for Xilinx Zynq SoCs.
>   
> +config RESET_ZYNQMP
> +	bool "ZYNQMP Reset Driver" if COMPILE_TEST
> +	default ARCH_ZYNQMP
> +	help
> +	  This enables the reset controller driver for Xilinx ZynqMP SoCs.
> +
>   source "drivers/reset/starfive/Kconfig"
>   source "drivers/reset/sti/Kconfig"
>   source "drivers/reset/hisilicon/Kconfig"
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index fd8b49fa46fc..544ae3488e3f 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -41,4 +41,4 @@ obj-$(CONFIG_RESET_TN48M_CPLD) += reset-tn48m.o
>   obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
>   obj-$(CONFIG_RESET_UNIPHIER_GLUE) += reset-uniphier-glue.o
>   obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
> -obj-$(CONFIG_ARCH_ZYNQMP) += reset-zynqmp.o
> +obj-$(CONFIG_RESET_ZYNQMP) += reset-zynqmp.o
> 
> ---
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
> change-id: 20240621-reset-compile-zynqmp-6e6bedc658af
> 
> Best regards,

Make sense.
Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

