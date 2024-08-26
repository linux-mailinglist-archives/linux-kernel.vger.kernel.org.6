Return-Path: <linux-kernel+bounces-300679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 161CA95E719
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 04:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B8E281170
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 02:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEE056458;
	Mon, 26 Aug 2024 02:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="GuxTw2FT"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010032.outbound.protection.outlook.com [52.101.128.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FC6CA6F
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 02:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724641024; cv=fail; b=n0flLV1bGEcSeJF7vQlTDMWcIQcz/q4B2QMenJfrwL2V+XQfKbiUvP5RGioYpfhymdplYUrGmm19dx8WgLFBZvSfnr/zq6474DK4l07QoUtdoX1AhzFnVx53lKF11eL5axbgVICUHTsZSjh12MFwmn6e9mvhSSJcXF/EuKkpLCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724641024; c=relaxed/simple;
	bh=c1/jnpFrFDQTMeB7lDoo5rYZcoUw0ZLf3xxd4J8vcXM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hD9Lv7lwf8/BtnNoRmPeEDN7idIjBicNFzPIEr3o5vBTQ5CosUexmh0FOclMyAmW09W//Ft92Dp4NMqfJmGTPtiopSWo4xElAkSNBgTPocwfA02I/7MyXr01UeVLzNLEKtZ3ugv6aByHvNkn++o0m6VLrRWV0/QMrRvrGy3Zgb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=GuxTw2FT; arc=fail smtp.client-ip=52.101.128.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g3Y/Xd66jtQm1LH+boeL6dH6bk/3hh72si61ChAKAQeWJhhrjQM4tNROOoNwyrfDCLKJtsUF0TtZHiIgXQKMWfurHkE0Qdj477BDwfSFYpZMCoUJrz5S1A69WsQmXI0Q1tOggR/LBDFPuJZpbIPXLygpJpawItdgJLF47HHKcjduPRLW1CPoJgyDOQIMTrhVhOVhTbUgu1GQy1EkayK2IpcI0tad98VcktFql+VMY1Wuq/udOrS852Qs6nr+k+CjVPIXhRjm+P8NnmTue4O0hVsko16F48NxJH8xDDm0shuRI6+8fqJV61Q8oh+vPA+/AW6E1GQ0w7o+iC486gQRQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eUzxdl/WLzr65pAQgOmgc8GIvlro4iQPLT/ymqav4c=;
 b=ubt769U/+CwElmD8WS0d2iQDRewVdBs1004FCn3BmCR+kQcHwJPyI0pz7ybmBgraXXO1BJwS1JwCvKX5MDuV9f2W4jnpu1x/UWMf5yqV2xraY//g2FNBSj07a/rY+SVM+G46mfTYMyVSRXPYIUJinmUS4fBwIfl6DGbk4UfRG2xMOPjc3CUGos/b+Pxc9sJAULNJuqZ2TJbffQWM8zi+FX+smKfNY7f/ZG4m6ABeACqVQweQeDwgjDUbxJhe/10oCxe/7WV/mcHDnMykzv9KgvaGPdtJVoitepAypO/pT2S5I0W/mL7wPKUiGClCdMyceVC/HudUg0nLUc6R69nztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eUzxdl/WLzr65pAQgOmgc8GIvlro4iQPLT/ymqav4c=;
 b=GuxTw2FTXdndQGgyNi2cUWlaJXkTOGF+CmhAlc4uD7N3KUAm0C6CS4sP6jCI+9j+y4ivcX7cYN8fOrOPnrRoCUcGA3amhDr1sEPtAW9JljiLgWeiERnxXu904zcFKYy8O66VMuxls/WajWkZiMYWV0Hy2mzM1N6Wgsr6x6fno18lA/G9XImKC1BNE7CexIyg+DXA9P3l5ZlXo2s7Ij5iBCzonWOflV0Yy68yhV8vAGTF45A+qigSdfqCb4SwGb8mwZNfeuQ/QMYMTs0CIyFNhWSS70LbrPUjRJ14sV/dQdJAddKf5QPxMOGhzTcEQCCPgJ5aTOiPJgpodvnE3DBGrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEZPR06MB7077.apcprd06.prod.outlook.com (2603:1096:101:1f4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 02:56:53 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 02:56:53 +0000
Message-ID: <1e91129f-b577-4d58-8797-5e06911ed524@vivo.com>
Date: Mon, 26 Aug 2024 10:56:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vma remove the unneeded avc bound with non-CoWed folio
To: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, oe-lkp@lists.linux.dev, lkp@intel.com,
 opensource.kernel@vivo.com
References: <20240823150206.565-1-justinjiang@vivo.com>
 <73ad9540-3fb8-4154-9a4f-30a0a2b03d41@lucifer.local>
 <4dd13a4c-e968-4a3a-98e5-97f28036deff@vivo.com>
 <ccd9b00b-1f36-4f2c-bd48-47f7a7187772@lucifer.local>
 <48854609-290d-4868-a1cc-fbb2920af80b@redhat.com>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <48854609-290d-4868-a1cc-fbb2920af80b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0161.apcprd04.prod.outlook.com (2603:1096:4::23)
 To JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEZPR06MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: acb9a64b-8d6a-408c-369d-08dcc57abd50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2ZRRnIxMHl5T3hHWWlXTGhFK1hDUUNOdjJ5Y2F5T1kyamlOcGZ6K3V2NnNI?=
 =?utf-8?B?WmU1OUN2TVpvMlZHTGtRbDdFdEVNWTQ3SE8rY092YUNLT2V2ZGdWazBocGFw?=
 =?utf-8?B?NzVlRDVNOHhVVkg2dnFjVExEVzl1aVQyVmFEZnI2bWxVcGRZUzVjaXFMbVM5?=
 =?utf-8?B?bGNGS0NCRkxSb0p0VDk0Tk0wL295YlRPTVV5dkRlNjVkYlBqTi9FOWJLNzBr?=
 =?utf-8?B?K2djcHowc25hejV2M3M0T3Q2RGM2UldEVUp6eXhwTjkzejB5c2VwUWVweTFo?=
 =?utf-8?B?MWF1RktrYU1HcDNZc2pNSHUvZzdHYXZWMVVJOEJ1QnpFQVkrcGc4MmwzMGNK?=
 =?utf-8?B?dEJPenhvTUZtd0NFRlhxdks5Rkg2MUtMeUhFdU1jaEJHM1ZRODZrK2EwY3dy?=
 =?utf-8?B?NU85MWdxVWpaT3J0VWVsVUxDZUZVQUkya281YTV6R3BXOXhyYktYSTFCTjlQ?=
 =?utf-8?B?bkliQndEQ1BxZ3Vhc1U1Wlp0enN4Um5KL204cGg2NitBUmFlRnRmNlAxMnRu?=
 =?utf-8?B?MFhCZVdEYXlZbkwxK2poazA5akpwN1pvem1VSDIzYVpGci82T2F1R3RmS1lC?=
 =?utf-8?B?dHF2enRtMkZYU2MzdDgya2cydzN3WWx2N2ZxY2VudWtWWTY0a09UVTIxZzJB?=
 =?utf-8?B?UHRud0VDQXFqUHlqRVdRU1lCN3pqYXBGMVRHWWJsc3kvT0hudGxDQWU4L0Vn?=
 =?utf-8?B?aU5nTkFDdHE3ejZRTGRncndwaWM0M0lwVTlxcTFkTFUxRVRENFp6cGZtSTZJ?=
 =?utf-8?B?MzgxSkVULzM0UC90QkVEaVZZdjROZFpNWGc4K2ZvS2trck5WRWpDb050Rnpu?=
 =?utf-8?B?WXBaLzZiSEFMa2drbTJPKzV4UXI3S1JTMlZSZWdNK2JWVlMzRWRuU1gvWUdM?=
 =?utf-8?B?RjkxTXBhYnd0TnQ0VDg1ZVg5Z0FKbjNzY21XYWJMaTdFWW5CdDlNM0U1TVJV?=
 =?utf-8?B?bTZIWnBPK1ZnTG5WKzVDa2FleDF5bzR0K3Q2QU9iTnpzZ3hLRnEzeFdjZEww?=
 =?utf-8?B?azROYmR1SVo0OUxPYVBSR0NGWno5bUdHeDNZQW1CZlJwMS8zNXNteFpZNzhO?=
 =?utf-8?B?dUFoTGNRWk1KSmpxUXlTbjJjQkRDc2doUUl4RDN5MENMaE9wQndKeGpSY0lr?=
 =?utf-8?B?ZHY5M1kxb3dzYWtqelA3NmF2RVVUNlozVElJdnlQb1g1VG41RHQrWld4SFox?=
 =?utf-8?B?SjlqOXJXYXNKb0xNcWxVZ2djNkQrTHhSUkJ1V2NQQi9pUTlLUGh0cGhURWdz?=
 =?utf-8?B?VTVvSUlMOVBpeTdWZHpGcEFHWXNSTHo1S1htOGtNUk1oeVFOTkIrVlJGa2gy?=
 =?utf-8?B?elJXYjlzY0w0c0pqMlpROXFpaVJLT2FNTjJVQVA3V2pUUWhscVVCV0U3czFv?=
 =?utf-8?B?ZlNqclJWVFlWZWpaMWdrMElsdmR4aFFGcm9sTEJMbllKTEcxQmZoSnBRRVRo?=
 =?utf-8?B?MmY0Ly9hVElQN0QzVzgrSDd2eVgxNEluaEZ0eDd6S0RoNmsyUElVM0JuSWZO?=
 =?utf-8?B?cE83SmpJVnNxL21QOXFFY3AzemxXQnVXR3k3cS9laWJDMzZESlEyd0dpUGNK?=
 =?utf-8?B?OWp3MjAzd0dxZU5QSFdJcFlIU0t5dzkzNDlOWndkcFFrT2ppZWZXUVNaU09y?=
 =?utf-8?B?TG00alVpaE9XRFhnU0ppQ0x4a0JhQVBxeStoVVdFNEZYbkJveC9ZRmtWRkVU?=
 =?utf-8?B?OUlnc2xYek40anZFSkh2VTdxd1YyaytJdXl0ZzBGRGpvT0grQUVrMWNzL0FK?=
 =?utf-8?B?U1ZGVVBkZnNDc3NWdEZrOVZCR0pwZGtxWnNiVUMyOTRRUXQwdGhJMndBRUor?=
 =?utf-8?B?ZE1Oc1JMRjQ5S2wzNGwxdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlZvRDFCdXBBei84S3gvRnlIKzR6MGszWEExVG4zdjdlek9zbERPL2xOZisw?=
 =?utf-8?B?U1ErOE5xUnBXTmd6TUlPZVB2MnVuVVYzYk5nVmJLOFgwdjdaOE8zTkl5UnVQ?=
 =?utf-8?B?VStZT0ZwRDBkMENzY3FSRWtibzBPTXZzSE5SdUM2bk5nRDhrbW5YcUpOLzBr?=
 =?utf-8?B?RVBZd3lsS0R2YjNSSEhtUmpobHdCR2txVDNxZWtZT3JGaWlyTE12ODF4cVBQ?=
 =?utf-8?B?ZWppcU9qWWhVc1Vvc2FiZitxMG9sVkgwaUY4b004YVg5RUxjSlJMWXR6bFBP?=
 =?utf-8?B?TE03eW9uZ3ZldkNlUGtZeFZ6WmJmc0cyQXk0dHVBaitJYUlQcDdVYkU4QjMr?=
 =?utf-8?B?NE5Fc0lTNDFXYmlSVkZSbEd2YVhXWGlaK1J3WkRPRHNjY055VlN5Y255aE9Y?=
 =?utf-8?B?Zno2QTVYaE5PTFBmVituQ3ZUYVZWQk5GRTQ1ekZvamZ6Sm1zVVJUaXFUSndl?=
 =?utf-8?B?VGJqSnJCeXFDS05tTy90Y09Ld2xteHM2V0pWVDUxK0phaHpjN2JseHJST05I?=
 =?utf-8?B?RjZCZ3BVdkFKaUhlZi9uL3N4eTNaMDRPTERUM3Fua0xTQzR0Z1pkZnRSM0J4?=
 =?utf-8?B?K21Pdi9mYzBFdnNTdGs3QzQzN1RPT1FVV0JGdUZncUtjd1ByM3Jqb0tIcjAz?=
 =?utf-8?B?UnhMelFTTVBYaUNsakIxbXpUbzBSMGJ4ckpyWTRsTkhlK1VoYU9ZS1BSMGha?=
 =?utf-8?B?YUlEa1QzZ0xnQ1NOYUU1NXFlRDVuTnpJQjI5RWhLci80MGgwZ1NSN2g2NTl2?=
 =?utf-8?B?b0dCZmtaQ0IzNXlBeHlNR2xEeGdHMFpINmtCeUc4UXcrZkRHUTkzRGE2eXIr?=
 =?utf-8?B?eGQzNy9KeTZyYzZMbjBIdHhXU2NBbVAxQ0d1akN6QXBqR002QnphcXdDZG9D?=
 =?utf-8?B?UHZpc0srOGhFay85NFM2OVB4d2ZLbEZEKy9hR1lUV0I1NTRFa3ZUS3VMbWNv?=
 =?utf-8?B?WlJWUUhFNVZxeWNIdDBYUkJNWFZrQzA1Y3R0Nk5uTE5CR2RJejlPc3NLOTZ3?=
 =?utf-8?B?SEJicWR1WEYrQzZGamp4c2o2a3M0UUE1eEFkMXVWZDV2VXAya3dQdTR3V3Ew?=
 =?utf-8?B?UWlhSUlnMVBRUnhRNnpZWDhBM3RaQmNZdzRCYkZ6YnF3YXpLWTRSKy8xRWNM?=
 =?utf-8?B?WXhxaC9pdXRET3hjOWVPTjNpTXpHdmc5eGsvNE56WVdUSklEblhrb1p3Tml2?=
 =?utf-8?B?ajQ0bDFhcmlCMkM2WXl0YmRBbWdnWTJmOVpna3lZVWpQQVY1ZzNaUDdmUnpu?=
 =?utf-8?B?ZTRra3lyWmFtQjB2bEZUYUFoL0QrajI4VkxBV0F1OVlIeGYxZytCUnJBWThK?=
 =?utf-8?B?OUVYSXFEdGkrS2tnUW03TEwwdGNUaUU1THFYREpoVjJ0K3VyNUN6RDk1NVow?=
 =?utf-8?B?RkRPRnRyQmVmRG1BVUpObUZUMkZYcXNsaUdnNE9xdVA0UVFjSVgzQmhyeGlC?=
 =?utf-8?B?OVowSjBuOWt1aTcvcE9nTXB5bVE3dHJhWWZSK0JJM3RDVnRVcFVYSi9oNGk4?=
 =?utf-8?B?TzV0VGFrY3JKb21SQjV3SWFvdEtENWRqZ2t0a2VWazduNk43QlJGMk5CUE5m?=
 =?utf-8?B?WXdtM0Z5cVJNOTMrenhnS0E4RWRYQXZBNVowSVlqVDlNdk9CdXZCakNIOHQ3?=
 =?utf-8?B?QUhicWRoc3AxRUVGdE9yVUFsV0RUVjZYTGFMT0RYSVF2QnlWbnNFQ3lWOVV5?=
 =?utf-8?B?RWt6ZkkwamVvWmFVem85ZCtvNUw5R2RzSnpJeU85aGdnK0ZjL2ZzajBaQ2tJ?=
 =?utf-8?B?KzNTRkx5S2FCUFExWU9RczlUZXJkQWZScE0zUlF4Z1BERWdraDJ3TEdnVXJy?=
 =?utf-8?B?VHFXYTVVbHBvdzU2S3Rsbk1vcHlCNkIyMnpkUGs2WFNRWW5rcExNR3ZWMG5Z?=
 =?utf-8?B?ZExadlVUeHo1V1h4ODFDeFBUNG5qU1BqMGt1cFFMemNBSXFpZThLME1HbW1z?=
 =?utf-8?B?OEo2V3RnRG5lUFkvU2UxL1ZlV2ZxcEJuYjBHSGozQkFhTTNDdktYN2ZXK0p2?=
 =?utf-8?B?Q0E3OFlsdGNSL0cxalVnQUxBOGJibkJnay9pOVVGV1BKMmpYeHk4UUYvd3c1?=
 =?utf-8?B?N3orVDB1RWs4QjhNZVdraFlub2pPTXREWFdPTUx3WU9sSFhhQUhZOU5qeG9w?=
 =?utf-8?Q?wb3K0B2y9k/9Ali2deI9M4PY4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb9a64b-8d6a-408c-369d-08dcc57abd50
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 02:56:53.4171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQcdG1jFF+UbWqph3ozDAeDcugVB9avyGpYSqn9jcNlWGaLn0zheAV5C+8uAs4O9ccS0XFikVFrY/cw5fD+goQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7077



在 2024/8/26 2:13, Mika Penttilä 写道:
> [你通常不会收到来自 mpenttil@redhat.com 的电子邮件。请访问 https://aka.ms/LearnAboutSenderIdentification，以了解这一点为什么很重要]
>
> Hi,
>
> On 8/25/24 09:39, Lorenzo Stoakes wrote:
>
>> On Sun, Aug 25, 2024 at 01:06:40PM GMT, zhiguojiang wrote:
>>> 在 2024/8/25 0:26, Lorenzo Stoakes 写道:
>>>> [Some people who received this message don't often get email from lorenzo.stoakes@oracle.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>>
>>>> On Fri, Aug 23, 2024 at 11:02:06PM GMT, Zhiguo Jiang wrote:
>>>>> After CoWed by do_wp_page, the vma established a new mapping relationship
>>>>> with the CoWed folio instead of the non-CoWed folio. However, regarding
>>>>> the situation where vma->anon_vma and the non-CoWed folio's anon_vma are
>>>>> not same, the avc binding relationship between them will no longer be
>>>>> needed, so it is issue for the avc binding relationship still existing
>>>>> between them.
>>>>>
>>>>> This patch will remove the avc binding relationship between vma and the
>>>>> non-CoWed folio's anon_vma, which each has their own independent
>>>>> anon_vma. It can also alleviates rmap overhead simultaneously.
>>>>>
>>>>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>>>> NACK (until fixed). This is broken (see below).
>>>>
>>> Hi Lorenzo Stoakes,
>>>
>>> Thank you for your comments.
>>>> I'm not seeing any numbers to back anything up here as to why we want to
>>>> make changes to this incredibly sensitive code?
>>> I added a debug trace log (as follows) in wp_page_copy() and observed
>>> that a large number of these orphan avc-objects still exist. I believe
>>> this will have a certain redundant overhead impact on anonymous folios'
>>> rmap avcs, so I want to remove it, which is also the most essential
>>> value of this patch.
>> Sorry nack to that idea unless you can provide actual _data_ to demonstrate
>> an overhead.
>>
>> And even if you did, given the original patch was so completely broken, and
>> in such a sensitive area, I'm going to need to be VERY confident you didn't
>> break anything, so we're going to need tests.
>>
>>> -- the vital part of debug trace patch:
>> Thanks for providing! Will snip for sake of making it easier to reply.
>>
>>>> Also anon_vma logic is very complicated and confusing, this commit message
>>>> feels about 3 paragraphs too light.
>>>>
>>>> Under what circumstances will vma->anon_vma be different from
>>>> folio_anon_vma(non_cowed_folio)? etc.
>>> In anon_vma_fork() --> anon_vma_clone(), child vma is bound with parent
>>> vma's anon_vma firstly.
>>>      /*
>>>       * First, attach the new VMA to the parent VMA's anon_vmas,
>>>       * so rmap can find non-COWed pages in child processes.
>>>       */
>>>      error = anon_vma_clone(vma, pvma);
>>>
>>> When child vma->anon_vma is NULL in anon_vma_fork(),
>>>      /* An existing anon_vma has been reused, all done then. */
>>>      if (vma->anon_vma)
>>>          return 0;
>>>
>>>      /* Then add our own anon_vma. */
>>>      anon_vma = anon_vma_alloc();
>>>
>>> new anon_vma will be alloced and filled in this child vma->anon_vma.
>>> Then during CoWed in do_wp_page() --> wp_page_copy(), this child vma's
>>> new anon_vma will be different from folio_anon_vma(non_cowed_folio).
>> Thanks for the explanation, but I was suggesting you have to put this in
>> the commit message rather than in repy to me :)
>
> You still have to locate the mappings of the other, non cow'ed folios in
> the child's vma *by* the parent's anon_vma,
> so don't think you can delete, on cow,  the avc, which presents the
> whole vma?
Hi Mika,

This patch is designed to remove the avc binding relationship that child
vma anon_vma different from parent vma anon_vma. You mentioned that "non
cow'ed folios in the child's vma *by* the parent's anon_vma" belongs to
another different situation. Of course, if it is possible to remove avc
from this situation, the effect should be better, but the implementation
is more complex.

Thanks
Zhiguo
> But I could be missing something, it has been long since I went thru
> this code last time...
>
>>>> Confusing topics strongly require explanations that help (somewhat)
>>>> compensate. This is one of them.
>>>>
>>>>> ---
>>>>>
>>>>> -v2:
>>>>>    * Solve the kernel test robot noticed "WARNING"
>>>>>      Reported-by: kernel test robot <oliver.sang@intel.com>
>>>>>      Closes: https://lore.kernel.org/oe-lkp/202408230938.43f55b4-lkp@intel.com
>>>> It doesn't.
>>>>
>>>> Saw a bunch of warning output in dmesg when running in qemu, bisected it to
>>>> this commit. The below assert is being fired (did you build this kernel
>>>> with CONFIG_DEBUG_VM?):
>>>>
>>>>           VM_WARN_ON(anon_vma->num_children);
>>>>
>>>>   From what I saw, these appear to all be cases where anon_vma->num_children == 0...
>>>>
>>>>
>>>> [    1.905603] ------------[ cut here ]------------
>>>> [    1.905604] WARNING: CPU: 2 PID: 231 at mm/rmap.c:443 unlink_anon_vmas+0x181/0x1c0
>>>> [    1.905605] Modules linked in:
>>>> [    1.905605] CPU: 2 UID: 1000 PID: 231 Comm: zsh Tainted: G        W          6.11.0-rc4+ #49
>>>> [    1.905606] Tainted: [W]=WARN
>>>> [    1.905606] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
>>>> [    1.905607] RIP: 0010:unlink_anon_vmas+0x181/0x1c0
>>>> [    1.905608] Code: 48 83 7f 40 00 75 1c f0 ff 4f 30 75 ab e8 d7 fd ff ff eb a4 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 90 0f 0b 90 eb de 90 <0f> 0b 90 eb d1 90 0f 0b 90 48 83 c7 08 e8 4d 7c ea ff e9 fc fe ff
>>>> [    1.905608] RSP: 0018:ffffc90000547cb0 EFLAGS: 00010286
>>>> [    1.905609] RAX: ffff88817b265390 RBX: ffff88817b265380 RCX: ffff88817b2cb790
>>>> [    1.905609] RDX: ffff88817b265380 RSI: ffff88817b2cb790 RDI: ffff888179e08888
>>>> [    1.905610] RBP: dead000000000122 R08: 000000000000000c R09: 0000000000000010
>>>> [    1.905610] R10: 0000000000000001 R11: 0000000000000000 R12: ffff88817b2cb790
>>>> [    1.905611] R13: dead000000000100 R14: ffff88817b2cb780 R15: ffff888179e08888
>>>> 00000000000
>>>> [    1.905613] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [    1.905613] CR2: 0000555bc5d97390 CR3: 000000017c12c000 CR4: 0000000000750ef0
>>>> [    1.905614] PKRU: 55555554
>>>> [    1.905614] Call Trace:
>>>> [    1.905614]  <TASK>
>>>> [    1.905615]  ? unlink_anon_vmas+0x181/0x1c0
>>>> [    1.905615]  ? __warn.cold+0x8e/0xe8
>>>> [    1.905616]  ? unlink_anon_vmas+0x181/0x1c0
>>>> [    1.905617]  ? report_bug+0xff/0x140
>>>> [    1.905618]  ? handle_bug+0x3b/0x70
>>>> [    1.905619]  ? exc_invalid_op+0x17/0x70
>>>> [    1.905620]  ? asm_exc_invalid_op+0x1a/0x20
>>>> [    1.905621]  ? unlink_anon_vmas+0x181/0x1c0
>>>> [    1.905622]  free_pgtables+0x11f/0x250
>>>> [    1.905622]  exit_mmap+0x15e/0x380
>>>> [    1.905624]  mmput+0x54/0x110
>>>> [    1.905625]  do_exit+0x27e/0xa10
>>>> [    1.905626]  ? __x64_sys_close+0x37/0x80
>>>> [    1.905626]  do_group_exit+0x2b/0x80
>>>> [    1.905628]  __x64_sys_exit_group+0x13/0x20
>>>> [    1.905629]  x64_sys_call+0x14af/0x14b0
>>>> [    1.905630]  do_syscall_64+0x9e/0x1a0
>>>> [    1.905630]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>> [    1.905631] RIP: 0033:0x7f4416ae33ad
>>>> [    1.905632] Code: Unable to access opcode bytes at 0x7f4416ae3383.
>>>> 000e7
>>>> [    1.905633] RAX: ffffffffffffffda RBX: 00007f4416d5e3c0 RCX: 00007f4416ae33ad
>>>> [    1.905633] RDX: 00000000000000e7 RSI: ffffffffffffff88 RDI: 0000000000000000
>>>> [    1.905633] RBP: 0000555b8eed1378 R08: 0000000000000000 R09: 0000000000000007
>>>> [    1.905634] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
>>>> [    1.905634] R13: 0000000000000000 R14: 00007ffe7dbe9190 R15: 00007ffe7dbe9110
>>>> [    1.905635]  </TASK>
>>>> [    1.905635] ---[ end trace 0000000000000000 ]---
>>>> [    1.905638] ------------[ cut here ]------------
>>>>
>>>>
>>>>>    * Update comments to more accurately describe this patch.
>>>>>
>>>>> -v1:
>>>>>    https://lore.kernel.org/linux-mm/20240820143359.199-1-justinjiang@vivo.com/
>>>>>
>>>>>    include/linux/rmap.h |  1 +
>>>>>    mm/memory.c          |  8 +++++++
>>>>>    mm/rmap.c            | 53 ++++++++++++++++++++++++++++++++++++++++++++
>>>>>    3 files changed, 62 insertions(+)
>>>>>
>>>>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>>>>> index 91b5935e8485..8607d28a3146
>>>>> --- a/include/linux/rmap.h
>>>>> +++ b/include/linux/rmap.h
>>>>> @@ -257,6 +257,7 @@ void folio_remove_rmap_ptes(struct folio *, struct page *, int nr_pages,
>>>>>         folio_remove_rmap_ptes(folio, page, 1, vma)
>>>>>    void folio_remove_rmap_pmd(struct folio *, struct page *,
>>>>>                 struct vm_area_struct *);
>>>>> +void folio_remove_anon_avc(struct folio *, struct vm_area_struct *);
>>>>>
>>>>>    void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
>>>>>                 unsigned long address, rmap_t flags);
>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>> index 93c0c25433d0..4c89cb1cb73e
>>>>> --- a/mm/memory.c
>>>>> +++ b/mm/memory.c
>>>>> @@ -3428,6 +3428,14 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>>>>>                          * old page will be flushed before it can be reused.
>>>>>                          */
>>>>>                         folio_remove_rmap_pte(old_folio, vmf->page, vma);
>>>>> +
>>>>> +                     /*
>>>>> +                      * If the new_folio's anon_vma is different from the
>>>>> +                      * old_folio's anon_vma, the avc binding relationship
>>>>> +                      * between vma and the old_folio's anon_vma is removed,
>>>>> +                      * avoiding rmap redundant overhead.
>>>> What overhead? Worth spelling out for instance if it's unnecessary to
>>>> traverse avc's.
>>> I think this will have a certain redundant overhead impact on anonymous
>>> folios rmap traverse avcs process.
>> This is again nowhere near detailed enough, and again I'm asking you to
>> write this _IN THE COMMENT_ not in review.
>>
>> I already understand what you're trying to do (I think the fact I provided
>> a _working_ version of your patch as an attachment in this thread should
>> give a clue ;), this is for the benefit of people coming to read this code.
>>
>>>>> +                      */
>>>>> +                     folio_remove_anon_avc(old_folio, vma);
>>>>>                 }
>>>>>
>>>>>                 /* Free the old page.. */
>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>> index 1103a536e474..56fc16fcf2a9
>>>>> --- a/mm/rmap.c
>>>>> +++ b/mm/rmap.c
>>>>> @@ -1522,6 +1522,59 @@ void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
>>>>>    #endif
>>>>>    }
>>>>>
>>>>> +/**
>>>>> + * folio_remove_anon_avc - remove the avc binding relationship between
>>>>> + * folio and vma with different anon_vmas.
>>>>> + * @folio:   The folio with anon_vma to remove the binded avc from
>>>>> + * @vma:     The vm area to remove the binded avc with folio's anon_vma
>>>>> + *
>>>>> + * The caller is currently used for CoWed scene.
>>>> Strange turn of phrase,
>>>>
>>>>> + */
>>>>> +void folio_remove_anon_avc(struct folio *folio,
>>>> I think this should be 'oldfolio'. You're not looking at the copied folio,
>>>> but the unCoW'd original folio.
>>> Yes, thanks.
>>>>> +             struct vm_area_struct *vma)
>>>>> +{
>>>>> +     struct anon_vma *anon_vma = folio_anon_vma(folio);
>>>>> +     pgoff_t pgoff_start, pgoff_end;
>>>>> +     struct anon_vma_chain *avc;
>>>>> +
>>>>> +     /*
>>>>> +      * Ensure that the vma's anon_vma and the folio's
>>>>> +      * anon_vma exist and are not same.
>>>>> +      */
>>>>> +     if (!folio_test_anon(folio) || unlikely(!anon_vma) ||
>>>> The folio_test_anon() is already implied by folio_anon_vma() != NULL and
>>>> doesn't preclude KSM.
>>>>
>>>>> +         anon_vma == vma->anon_vma)
>>>>> +             return;
>>>> This is all super confusing, the 'parent' is actually anon_vma
>>>> (oldfolio). The newly created 'child' anon_vma is vma->anon_vma. Should
>>>> probably rename each accordingly.
>>> OK.
>>>>> +
>>>>> +     pgoff_start = folio_pgoff(folio);
>>>>> +     pgoff_end = pgoff_start + folio_nr_pages(folio) - 1;
>>>>> +
>>>>> +     if (!anon_vma_trylock_write(anon_vma))
>>>>> +             return;
>>>>> +
>>>>> +     anon_vma_interval_tree_foreach(avc, &anon_vma->rb_root,
>>>>> +                     pgoff_start, pgoff_end) {
>>>>> +             /*
>>>>> +              * Find the avc associated with vma from the folio's
>>>>> +              * anon_vma and remove it.
>>>>> +              */
>>>> This is a meaningless comment.
>>>>
>>>> This should be something like 'anon_vma_chain objects bind VMAs and
>>>> anon_vma's. Find the avc binding the unCoW'd folio's anon_vma to the new
>>>> VMA, and remove it, as it is now redundant.'
>>>>
>>>>> +             if (avc->vma == vma) {
>>>> In testing I found that a lot of the time this isn't found at all... is
>>>> that expected?
>>>>
>>>>> +                     anon_vma_interval_tree_remove(avc, &anon_vma->rb_root);
>>>>> +                     /*
>>>>> +                      * When removing the avc with anon_vma that is
>>>>> +                      * different from the parent anon_vma from parent
>>>>> +                      * anon_vma->rb_root, the parent num_children
>>>>> +                      * count value is needed to reduce one.
>>>>> +                      */
>>>> This is a really confusing comment. You're not explaining the 'why' you're
>>>> just essentially asserting that you need to do this, and clearly this is
>>>> broken.
>>>>
>>>>> +                     anon_vma->num_children--;
>>>> So we know this is broken to start due to VM_WARN_ON() failures.
>>>>
>>>> As per above dmesg analysis, sometimes this is zero, so you're
>>>> underflowing. We definitely need a:
>>>>
>>>>           VM_WARN_ON(anon_vma->num_children == 0);
>>>>
>>>> At least.
>>>>
>>>> But also the naming is broken here too, anon_vma is actually the parent
>>>> (oldfolio's) anon_vma...
>>>>
>>>>
>>>> This is also just not correct on any level - the anon_vma->num_children
>>>> field indicates how many child anon_vma objects point at it via
>>>> anon_vma->parent, NOT avc.
>>>>
>>>> You're removing an avc, not disconnecting an anon_vma.
>>>>
>>>> So it seems to me you should have logic to remove the avc AND logic to
>>>> disconnect vma->anon_vma from (parent) anon_vma if it points to it.
>>>>
>>>> You'll need to be careful about locking when you do that too, as anon_vma's
>>>> lock on the root anon_vma, but in isolating the child anon_vma you'd lose
>>>> this lock.
>>>>
>>>> I've tried to write code to fix this but haven't been able to yet, this is
>>>> fiddly stuff.
>>>>
>>>> (I think this might have seemed to work at some point in testing because
>>>> unlink_anon_vmas() uses the avc list to determine what to unlink, rather
>>>> than looking at individual anon_vma's but still).
>>>>
>>>>> +
>>>>> +                     list_del(&avc->same_vma);
>>>>> +                     anon_vma_chain_free(avc);
>>>>> +                     break;
>>>>> +             }
>>>>> +     }
>>>>> +     anon_vma_unlock_write(anon_vma);
>>>>> +}
>>>>> +
>>>>>    static __always_inline void __folio_remove_rmap(struct folio *folio,
>>>>>                 struct page *page, int nr_pages, struct vm_area_struct *vma,
>>>>>                 enum rmap_level level)
>>>>> --
>>>>> 2.39.0
>>>>>
>>>> Again I question the value of this change. Are we REALLY seeing a big
>>>> problem due to unneeded avc's hanging around? This is very sensitive,
>>>> fiddly, confusing code, do we REALLY want to be playing with it?
>>> Thank you for helping to identify mang issues with this patch. However,
>>> I think this will have a certain benefits for anonymous folio rmap
>>> traverse avc overhead.
>>>> It'd be good to get some tests though unless you move this to vma.c with
>>>> its userland testing (probably a good idea actually as Andrew suggested)
>>>> this might be tricky.
>>> This patch belongs to anon_vma rmap's content, and it seems more
>>> appropriate in mm/rmap.c?
>>>> NACK until the issues are fixed and the approach at least seems more
>>>> correct.
>>> Thanks
>>> Zhiguo
>>>
>> Please see the attachment in thread for an example of a working version of
>> this, this is sadly fundamentally broken.
>>
>> But you're going to really need to sell this a lot better, provide some
>> numbers, and provide extensive testing and a much, much better test for
>> this to stand any chance.
>>
>> I appreciate what you're trying to do here, and it's not totally crazy, but
>> we have to be so, so careful around this code.
>>
>> anon_vma code is horrendously subtle and confusing (I actually had to
>> reference my unpublished book to remind myself how this stuff works :)), so
>> we have to tread very carefully.
>>
>> I definitely think we need ASCII diagrams if we were to go ahead with a new
>> version of this. But then again I'm a bit of a fan of ASCII diagrams...
>>
>> Please cc- me on future revisions of this series, thanks :)
>>
> Thanks,
>
> Mika
>
>


