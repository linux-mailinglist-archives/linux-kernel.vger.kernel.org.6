Return-Path: <linux-kernel+bounces-175009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E2B8C189C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 23:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E4E28593C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 21:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83B8128816;
	Thu,  9 May 2024 21:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="cVLK9eyf"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2118.outbound.protection.outlook.com [40.107.212.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2990385653
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 21:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715291193; cv=fail; b=NmgEDjIrfclwInNjJYkjW91CyunjwID5vwE7aQjA7I0s6c1LPv+n7cAZLCED+9eUxiHGzKW8yJWfUx1tj8/udkpzetSWEPdj99lod/O1FPUbExNFDSkoGbCfckCQEeBzYRQrt3hRwOuaOnVBdg39qAETyUHQa5LEqXHZHv5Octs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715291193; c=relaxed/simple;
	bh=5ehXQkr0Ylh6+IPEH/TpRYvQjS9dVjxT16mnjFR0duw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bw45xk2qxa70eGtg/7svXh5gMsSXCBy7zJwEw6HclmUtvwYo7TUkhoS7Pc3K4JEuUnqHU8qlqchK4kLaAYCUq8B7kgz1Pa/Jj4MY+VkU4gUhtWLQNfcXaFXGwhYlKegp/3fkK61P80SF1wPjbmZh6tbs/8exNZZcCwXVgRV+AuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=cVLK9eyf; arc=fail smtp.client-ip=40.107.212.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhLd+E6qG7o8PZHLrU8ZrQA9xizfGc1Kqps8v6V7UHWlsbBrlX/kohqhgpPfCoVHABUyw2Bm6tRs2ysEG5IrIKyiUziY9iVWgLiyldQU83EPUstKm6K3Cx7U0A5gZ3+VSbP9f+yBiRLsBqQlNBz2Lo7yUMXm780x00G4hRcF5j2ni2vWGi5Oc6DH9wEzhThaSbQRTIRj4wkms6nvSddJ95M0Z6CC78ZLCP6UBSs4phGu5vz9LZzdz7zk7GkSq3Adx7wmWWD/ddglOrbn2bq4d329RK4ao5HYIxWdkSi0cYqXIn/7GQk6asq0kZrmR/VkoTXpGN0NUshrttjbkEYcpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q53mqEHhBO+wnQOveR60D8Br36bOwVqdj57EJPjcYrQ=;
 b=Fq++oYZK9ckC7wbISryFoFpM4O/nUcWowMnCDRYRj95WYxCt6zs61N5HSozUdyJL83lJoCit48o/NSo1XjQiHQLhGkofVT/eSHlP1zqUAztV1vfaxBfN9klO9ou9DsXzGcUreqLFIK7tNiCq8FiQWYB3cLl/XAQwQeeMBHLh9PTXoHt340zzipXkjRCXzHgHdRj0jfIIE9N8sJIgq+2+YJ3uxsvrAAEq6lxEilkP6+VjwywdeBqIdYZxLzAOGWqJ2oc0yNQ9qvdD0ZDCOYie6CfZ/aSDtvudf/6RX83WGMEjNTQjrKMNcxh5NAeyWnYyxzx0RJJiCuizJqwvPbnrlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q53mqEHhBO+wnQOveR60D8Br36bOwVqdj57EJPjcYrQ=;
 b=cVLK9eyflPexnP02vIRBfutTwCzzcJkW/jwUKHTFsVzEgzlmYDt5FMbFji4/ZdM1Neyvfmu5HEth06BW3FfjVO0YxCRsbkz5GB0b19oPST2sV+xNauQalpabSnbTMiBCBduqlzw+douo8aycHkvDnJ3X14N8DqxRIBHD0XWdZRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BYAPR01MB5463.prod.exchangelabs.com (2603:10b6:a03:11b::20) by
 SA0PR01MB6188.prod.exchangelabs.com (2603:10b6:806:da::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.46; Thu, 9 May 2024 21:46:27 +0000
Received: from BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955]) by BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955%4]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 21:46:27 +0000
Message-ID: <328c4c86-96c8-4896-8b6d-94f2facdac9a@os.amperecomputing.com>
Date: Thu, 9 May 2024 14:46:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: force write fault for atomic RMW instructions
To: Anshuman Khandual <anshuman.khandual@arm.com>, catalin.marinas@arm.com,
 will@kernel.org, scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240507223558.3039562-1-yang@os.amperecomputing.com>
 <c9c3c0d5-bb61-4eed-8b89-b0341a2c6f5c@arm.com>
 <bb60d304-3341-472d-a4ee-d31b4754c39b@os.amperecomputing.com>
 <5e6158aa-09d3-4665-878e-17358aee10cb@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <5e6158aa-09d3-4665-878e-17358aee10cb@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0059.namprd07.prod.outlook.com
 (2603:10b6:610:5b::33) To BYAPR01MB5463.prod.exchangelabs.com
 (2603:10b6:a03:11b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB5463:EE_|SA0PR01MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: 450c16bc-350c-4c1a-a632-08dc70717a5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjRTNmZWcnpxY2ZSTWpaaEQ4cEZ6Wkdobml6dHFYQUE1T1UxOFRBMExhY1Ex?=
 =?utf-8?B?SlJnTFc1N1BoMXlGS1VUWE9oclB3QjMxbklxaFlENFlYVUk4UWpNNmdBZXdP?=
 =?utf-8?B?SkE3dWFjK2QzS2hiV1hsenorNzVPOVQrVk8yUWl0dGRzMExydkRuRlJJWENR?=
 =?utf-8?B?K3dVd2ZYN043NU40SXRDK2xxKzJUbUJPUFZkVmdNRURoL01aZ3VERjBXOVd5?=
 =?utf-8?B?OGI3UGo4RExuNFZtY3JwdVhNNFZjL1BGSlRZc3c5Um5uK3NNRlFBaDU5NDNp?=
 =?utf-8?B?WE9McUlJNWVwcVp6eVhLUnB5dFQyaTNYY1BOUmVTRGJjZnR6Z1BMLzQ5WUZF?=
 =?utf-8?B?OUlQdHNHNXVBcGF5Vjg4dmN6VDVFcVh3Rkw0WlorTFdVTUpBQ2lGZnIxOGg2?=
 =?utf-8?B?ZVk1cmtod0E1bFhtZkNQb0tSbzZPVXhrZ2Y0ZlkxRjFvY29DTlUxejliQ0p6?=
 =?utf-8?B?cDJPTWl2SXlLdER0ajlZUHNQNE5zMkczeHE1bm15V1drQW81c0k0ZjlDWXJZ?=
 =?utf-8?B?OWJSd2lJWGNUbm01NUpsN3hneXE1RCtaMVdRY0hpbjlmc0QraDBzZUhqZGZi?=
 =?utf-8?B?eUxnNDRaYTBtWGNucVg2TWdYL2o4ZHdPelM0NUptaG9DVCtGdkJtaUpSbE9S?=
 =?utf-8?B?OGI5clVqRisrMVRJS1RhUXpsSml4UEIrT01HZXNDWTFmUGpvVnpxNDdrTlR1?=
 =?utf-8?B?ZVZUb1RKL1Y2TWtWL256WUx3NXgrZkF4S1IzS0dzSmVZZkFoZzVNSmxwQU5t?=
 =?utf-8?B?YnZ6WU0yWXRLNFFCS1hTclNuby9nRUUyYjQrNDByN0V4QUpFNGxJajFHYWpq?=
 =?utf-8?B?cnI5VURnMFNzaHYwbGh0cUhycWRnQVN6a0w3Z2dZNXhYaklJSkdaUkV0bThW?=
 =?utf-8?B?NG0vZDJjK1c3UU5ldG5tZ2RnQWw2NHVFdTZuNER3M29zTEJtUUprblpLdHk2?=
 =?utf-8?B?dDlXTmZ6eEU0aFhnVzBiejJCcUpXMS9PZkpKeVdtTlRPWmJneXNBZ0lrMVVZ?=
 =?utf-8?B?VGhaYlZTKzk3UFVyQmJRMCtnc2hVazdXN2o1dDdEZ0hIWkwxeWI4TnZvYVAx?=
 =?utf-8?B?a2x0NE1zcU1nSC9PbUJQbEVaRlNURHl3Z01JcEpacmlkN2ZwL2g4Q1Vyd1BB?=
 =?utf-8?B?L21VcXFmMVh3d1dHTXQ4aTBXMGZRZGJqOU4vcHVyck1ZOUtZOG9hR2M2UC82?=
 =?utf-8?B?ckJPMVVnc2tKRC9ZSEJ3cXMvbXZldGlTTE8wQkFSTVNhQ3RIb0ZPTnNHd1lS?=
 =?utf-8?B?aExIOXgrVGpMU2lZRVNYYUxLWFZTc0JoSDI0OG1ONEtvNE5PdkcyWGpSV0lr?=
 =?utf-8?B?WWlQMFlZeUdPQmRXTlUzbCtvLzVtTW1ZdmFVS0dRc3VwOENMMFNGOFoybDJO?=
 =?utf-8?B?ZTZOSnJlWlFneHpVcVRYK0dkWkFPYnF4bE5FWXF3U3VFNWI2WFZWZHQxNVNM?=
 =?utf-8?B?R2NrR3c2RzRaYmloVWREbHNsSHBaUFl4VUdUOUxoNTNNZ0pWNnlEWG8vKzRZ?=
 =?utf-8?B?M3g2Tm9MYVJhS0Q3Q0JDNllLRkFmZFd6NUdWL2J4RFNsYUZiaDdoT0h1VG9T?=
 =?utf-8?B?NkpMTFkwaXZHaVB6RVpuNlhqNW5yekhKQkg2YXJXV1lpenoxYmgvV3ZBbUdw?=
 =?utf-8?B?aU1VRlY3V1ZyeVRxbWtndnM2dU5LdS94RmFpQnZiZWRRVnpvTmc3TnJKd0Vm?=
 =?utf-8?B?enF1Q0JVMkIwOEE2dlhyV0VtbFBxaFc4alZyZ2xSK0h0WERtZ0NCd09RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5463.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NU9mNSt5UmZtaW5rbEhFeVJVMVpEVFFXVUFiYk1TWlVuTnl4VEh4RWtiUFVI?=
 =?utf-8?B?WmR5NDhsYWtmdnR6ejB2KzhQdEpGQmJLMmlnNnJnN00yTUF0c3luVjRyNENI?=
 =?utf-8?B?VkMxcDl4V0oyZjRQMGJVTDhhQ2pVOEFxRTBmajdCdnFXZk1hT1paWnovV21N?=
 =?utf-8?B?U05DcURZL0JqOXczenZOS2wwRWV4Ri9iYW14QnVnNmM1dEo5MnhlVE1CUmJP?=
 =?utf-8?B?V09NNWlsK1BiM3p6cDJQM212WWZteFp2ZTFWNWZJNUJYUFJvTlhzcEY5L0oz?=
 =?utf-8?B?TVVXTUIvMFhLWVIxcU0xbjFKcjFLNkZLTUR0UlZmRUJYQm1aak9URWVLSE9C?=
 =?utf-8?B?NnBoeWxTTGhSOVRBMkZVS0N0OGUxR1V3ajJkK0dCYTF1VFZkVDRhY0dGWCtL?=
 =?utf-8?B?Wnd3eHY4ZDVkYkJnRTdPbm12T0ViVXVISkJKeGhMUUFiZmt3K2JmTEdRUk9X?=
 =?utf-8?B?Sk00WnBDakxTVzBtcnEwQzJEOUNpYXBJcTZsa21UTWdweXJqaHhUQjhxaGds?=
 =?utf-8?B?WGNVbmw1MG16WXBDa0NiVFI2NzFGZjlmbkxZSzNxbnB2K3E3ZW5XS3BqVTNy?=
 =?utf-8?B?STdzSWtoemdlMWllbEJTOXhjRGprOEpjQWtmVjNLMXYvUXVzUHR2dlZ5ZHR3?=
 =?utf-8?B?MWhpOHZLbmNLM09WYmZCUUUzRDZqRUJjeG4yS01ERXJzVHF3VllRdnI0cW1T?=
 =?utf-8?B?TkloWDVJaWZkWVJ0RjUxc2hZQ0ZkRkoxZGVhVjhsNGxiSEwrMloyajBhN1VG?=
 =?utf-8?B?akRxVEVXdGdsZElxR3JiL29PdlpvOFkvM2R1Q2xVUDhBL1JkUHJETDY0M2I4?=
 =?utf-8?B?ZmxKVXV1aCtmMTJnVmErTnprMWRJTE1EYVVhRzl0VTNOdmx3WlBLcEFIRlRK?=
 =?utf-8?B?UjlIbUw5b1lnd2g2VWU4aCtzK0JoN0psQlB5WG56TjY0cENKWWF0Zlc2NGdo?=
 =?utf-8?B?a0JUa0dLL3VlNGEzVDVuTjRnaWRxSTNTMjlzaWdudTcxVklYc3JMTnBNUmVX?=
 =?utf-8?B?K3hjWTVERHU0cWlCWGtsK1hCTysvZ04rVDl2T2hXSnRZbVJhcnZsU1B4dUJz?=
 =?utf-8?B?VlFmNU4xQ1lSYUNWQ1RFc1JXLytyQ0FKY3M2R2RiQVVibDM4VURNRWs2TlA5?=
 =?utf-8?B?Z3hlQnVsdG5ybmVCY3Znb3Fuc0pkQ0xCeFBWZ283TDBFdk8xNUF6OXViSmFY?=
 =?utf-8?B?RXQwVjNCZkJJVmdDMUlZVFpWZ2pjQ0xiU2lRQ2FjY2xETkNjemhzNUFsRE1o?=
 =?utf-8?B?RjRENGE0Qkg5MDNMSzJGS1dFTGhGQnhMUHhic0RMTTduVmVGakI5dDVqNHlm?=
 =?utf-8?B?aGVGOVI2endWZDNpaW13TEhrQUV3Y3VKdkt2OEVTZVMyWC8vWXBMSmYvWG51?=
 =?utf-8?B?S1RLR3N6U05GTkRPVGdoNm1KMm5KVmpZUW1yTHE5djVaT2hvOWFsQktWSzUw?=
 =?utf-8?B?bWYxa3BUM3QyVU5KSFNzOXNaaWNjb0dSRWJucGZtcU10M1FhV1E0VzdhQ2I1?=
 =?utf-8?B?Ky9rYUVIMmtJY3NKbXZnTDRNRkEzVUg4UnVPcHNzRTliK3JvM0tQV3Vlczhs?=
 =?utf-8?B?YW1kVzFNbEh0aGE5WkhBUHB4UC91VUprd0VTUVNDR00rb3Q3YUF2MEx4TUth?=
 =?utf-8?B?VndKYW1qVlNwU0dqK1J2b0RnOWdIUGJyZFg3ODVodXJhM2N6dEVDUTFJaUhp?=
 =?utf-8?B?S2JJS3JRY2hSKzdjNFlHcEI5YW5PZTJpeldxWFlSN3BZNUF6b2lqOFR0eEhw?=
 =?utf-8?B?RnVCaU82MGhpYXZWU1JGeWNGOUdnbnhHbFlTR2daOXZ0YS96N3hHNmRxZlc1?=
 =?utf-8?B?VFJFT1cwVzdwRHdhZGtOUDQxby9wbGZoR3VJODA2NlJaVU16QTE5VjExZVBU?=
 =?utf-8?B?Q2tZMjlqa2h3UnhubWdKMXRKV3h1MWkxcWFldEUydm9aR1k0anFRYnRGRDN0?=
 =?utf-8?B?WmtTN2VKU3doemFvK2paSzdjWCtSTzhMYkgvdEtrV3daZ3h2MWN3dGJuVE92?=
 =?utf-8?B?dk55WHRMZmZnSU5uTUxsK1ZLaUlYNit0SWxvTkRPK1dMbWdqSzM3ZjFjUW5R?=
 =?utf-8?B?NjRHdVdmZHZrRGV2bUx3UDRlOGVuSUpsYjVyUmUyZjdRSGhvU1RqcDR4eU9M?=
 =?utf-8?B?THJqczQ5WGcweVJhakNKaVdjcEJpTHBtdWo1cmF0NWhyR0g3VUYrdUpTU0ta?=
 =?utf-8?Q?K0W9jEg+yu2bGC+hLG3YL/E=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450c16bc-350c-4c1a-a632-08dc70717a5f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5463.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 21:46:26.7928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zg6u6hVbIjKSp5KZTwh8F9KvUzL/CKfCQXxA+MPqR8E05oFgayHitm64WdGTgk48tTGt0Yv2dGjWGK8GEyNQD1w2SZD5/zPErBaH1DGQtdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6188



On 5/8/24 9:31 PM, Anshuman Khandual wrote:
>
> On 5/9/24 00:07, Yang Shi wrote:
>>
>> On 5/7/24 11:45 PM, Anshuman Khandual wrote:
>>> Hello Yang,
>>>
>>> On 5/8/24 04:05, Yang Shi wrote:
>>>> The atomic RMW instructions, for example, ldadd, actually does load +
>>>> add + store in one instruction, it may trigger two page faults, the
>>>> first fault is a read fault, the second fault is a write fault.
>>> It may or it will definitely create two consecutive page faults. What
>>> if the second write fault never came about. In that case an writable
>>> page table entry would be created unnecessarily (or even wrongfully),
>>> thus breaking the CoW.
>>>
>>> Just trying to understand, is the double page fault a possibility or
>>> a certainty. Does that depend on architecture (please do provide some
>>> links) or is it implementation defined.
>> Christopher helped answer some questions, I will skip those if I have nothing to add.
>>
>> It is defined in ARM architecture reference manual, so it is not implementation defined.
> Sure, but please replace the "may trigger" phrase above as appropriate.

Yeah, sure.

>
>>>> Some applications use atomic RMW instructions to populate memory, for
>>>> example, openjdk uses atomic-add-0 to do pretouch (populate heap memory
>>> But why cannot normal store operation is sufficient for pre-touching
>>> the heap memory, why read-modify-write (RMW) is required instead ?
>> Memory write is fine, but it depends on applications. For example, JVM may want to "permit use of memory concurrently with pretouch". So they chose use atomic instead of memory write.
>>
>>>> at launch time) between v18 and v22.
>>> V18, V22 ?
>> v18/v19/v20/v21/v22
>>
>>>> But the double page fault has some problems:
>>>>
>>>> 1. Noticeable TLB overhead.  The kernel actually installs zero page with
>>>>      readonly PTE for the read fault.  The write fault will trigger a
>>>>      write-protection fault (CoW).  The CoW will allocate a new page and
>>>>      make the PTE point to the new page, this needs TLB invalidations.  The
>>>>      tlb invalidation and the mandatory memory barriers may incur
>>>>      significant overhead, particularly on the machines with many cores.
>>>>
>>>> 2. Break up huge pages.  If THP is on the read fault will install huge
>>>>      zero pages.  The later CoW will break up the huge page and allocate
>>>>      base pages instead of huge page.  The applications have to rely on
>>>>      khugepaged (kernel thread) to collapse huge pages asynchronously.
>>>>      This also incurs noticeable performance penalty.
>>>>
>>>> 3. 512x page faults with huge page.  Due to #2, the applications have to
>>>>      have page faults for every 4K area for the write, this makes the speed
>>>>      up by using huge page actually gone.
>>> The problems mentioned above are reasonable and expected.
>>>    If the memory address has some valid data, it must have already reached there
>>> via a previous write access, which would have caused initial CoW transition ?
>>> If the memory address has no valid data to begin with, why even use RMW ?
>>>
>>>> So it sounds pointless to have two page faults since we know the memory
>>>> will be definitely written very soon.  Forcing write fault for atomic RMW
>>>> instruction makes some sense and it can solve the aforementioned problems:
>>>>
>>>> Firstly, it just allocates zero'ed page, no tlb invalidation and memory
>>>> barriers anymore.
>>>> Secondly, it can populate writable huge pages in the first place and
>>>> don't break them up.  Just one page fault is needed for 2M area instrad
>>>> of 512 faults and also save cpu time by not using khugepaged.
>>>>
>>>> A simple micro benchmark which populates 1G memory shows the number of
>>>> page faults is reduced by half and the time spent by system is reduced
>>>> by 60% on a VM running on Ampere Altra platform.
>>>>
>>>> And the benchmark for anonymous read fault on 1G memory, file read fault
>>>> on 1G file (cold page cache and warm page cache) don't show noticeable
>>>> regression.
>>>>
>>>> Some other architectures also have code inspection in page fault path,
>>>> for example, SPARC and x86.
>>> Okay, I was about to ask, but is not calling get_user() for all data
>>> read page faults increase the cost for a hot code path in general for
>>> some potential savings for a very specific use case. Not sure if that
>>> is worth the trade-off.
>> I tested read fault latency (anonymous read fault and file read fault), I didn't see noticeable regression.
> Could you please run a multi threaded application accessing one common
> buffer while running these atomic operations. We just need to ensure
> that pagefault_disable()-enable() window is not preventing concurrent
> page faults and adding access latency to other threads.

I modified page_fault1 test in will-it-scale to make it just generate 
read fault (the original code generated write fault), and anonymous read 
fault should be the most sensitive case to this change. Then I ran the 
test with different number of threads (1 - 160 because total 160 cores 
on my test machine), please see the below table (hopefully my email 
client won't mess it)

nr_threads           before                after            +/-
1                      2056996            2048030        -0.4%
20                    17836422          16718606      -6.27%
40                    28536237          27958875      -2.03%
60                    35947854          35236884      -2%
80                    31646632          39209665      +24%
100                  20836142          21017796      +0.9%
120                  20350980          20635603      +1.4%
140                  20041920          19904015      -0.7%
160                  19561908          20264360      +3.6%

Sometimes the after is better than the before, sometimes opposite. There 
are two outliers, other than them there is not noticeable regression.

To rule out the worst case, I also ran the test 100 iterations with 160 
threads then compared the worst case:

     N           Min           Max        Median           Avg Stddev
  100         34770         84979         65536       63537.7 10358.873
  100         38077         87652         65536      63119.02 8792.7399

Still no noticeable regression.

>
>>>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>>>> ---
>>>>    arch/arm64/include/asm/insn.h |  1 +
>>>>    arch/arm64/mm/fault.c         | 19 +++++++++++++++++++
>>>>    2 files changed, 20 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
>>>> index db1aeacd4cd9..5d5a3fbeecc0 100644
>>>> --- a/arch/arm64/include/asm/insn.h
>>>> +++ b/arch/arm64/include/asm/insn.h
>>>> @@ -319,6 +319,7 @@ static __always_inline u32 aarch64_insn_get_##abbr##_value(void)    \
>>>>     * "-" means "don't care"
>>>>     */
>>>>    __AARCH64_INSN_FUNCS(class_branch_sys,    0x1c000000, 0x14000000)
>>>> +__AARCH64_INSN_FUNCS(class_atomic,    0x3b200c00, 0x38200000)
>>>>      __AARCH64_INSN_FUNCS(adr,    0x9F000000, 0x10000000)
>>>>    __AARCH64_INSN_FUNCS(adrp,    0x9F000000, 0x90000000)
>>>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>>>> index 8251e2fea9c7..f7bceedf5ef3 100644
>>>> --- a/arch/arm64/mm/fault.c
>>>> +++ b/arch/arm64/mm/fault.c
>>>> @@ -529,6 +529,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>>>>        unsigned int mm_flags = FAULT_FLAG_DEFAULT;
>>>>        unsigned long addr = untagged_addr(far);
>>>>        struct vm_area_struct *vma;
>>>> +    unsigned int insn;
>>>>          if (kprobe_page_fault(regs, esr))
>>>>            return 0;
>>>> @@ -586,6 +587,24 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>>>>        if (!vma)
>>>>            goto lock_mmap;
>>>>    +    if (mm_flags & (FAULT_FLAG_WRITE | FAULT_FLAG_INSTRUCTION))
>>>> +        goto continue_fault;
>>>> +
>>>> +    pagefault_disable();
>>>> +
>>>> +    if (get_user(insn, (unsigned int __user *) instruction_pointer(regs))) {
>>>> +        pagefault_enable();
>>>> +        goto continue_fault;
>>>> +    }
>>>> +
>>>> +    if (aarch64_insn_is_class_atomic(insn)) {
>>>> +        vm_flags = VM_WRITE;
>>>> +        mm_flags |= FAULT_FLAG_WRITE;
>>>> +    }
>>>> +
>>>> +    pagefault_enable();
>>>> +
>>>> +continue_fault:
>>>>        if (!(vma->vm_flags & vm_flags)) {
>>>>            vma_end_read(vma);
>>>>            goto lock_mmap;


