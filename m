Return-Path: <linux-kernel+bounces-346623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB4098C6D6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AD82B234C7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3770E199234;
	Tue,  1 Oct 2024 20:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="a0Wiscy6"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020076.outbound.protection.outlook.com [52.101.56.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8ED2B9A5
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 20:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727814707; cv=fail; b=eJVkebLoTcrAJTok74M+p6GkbMaZmU0x0FpahFzSs3UX6iaCv4ut3LtHdHhm4ltX7S06CYUeVuX0oTbd9QawDVh6RObqc3qkQZ0A6cnW5uuH9EHDcFBawu+pPHws87zr0GSCqL2pLuZhV8tNdoYKJZ/9hU1z386N5p8cDOzskr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727814707; c=relaxed/simple;
	bh=JFFbBe2ocZ+F1AkszlzjxpMTOK/sBcX2nSSgc6FrT4w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cmdwiW1uYIiW2bWyExk461PDkOazMTEj4Jq24RAbonxM1929NmSyyB8JPVbyIB35dHqjBODd/4ZWrz5C9q7UdqGy+qmsK+3Pp0u4LBPrFuLW79AcykPgHGz7bupkcAxcmMcrHvulHYC/mp3rcQh7lEL3Y41EIKjX3C3midNOmJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=a0Wiscy6; arc=fail smtp.client-ip=52.101.56.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x31jDkTrnz1v2V58HDQ1t2XdYess0+f4smbjruWFAYFifmaAlMsrm68Z0lt9Wv5NrTf/L3d84zSWY3b24qR+KlGnPAfUM4aX288uTFl8TO+ZUP8sqwAEO7fV4JoJX7Uko9j20+WI/j7tFTkqaQcivK5xqYyNzkxRn2P5d5uoUMj9ahye2bguFt3YQDfGzwMaE+ikMGD8hgG2uqUgUnEQ6U/aQ7zuYmaUkC2u98XuUafdQDRx3j5dpcedAQAyj8rjhM2k3vjx5ZGwNuJrZxMcEyh1ZPz4D6HHeOPLxCUeuHEbiU0wtL95Y1sJGrW5q+sPKEx4eUf/39fw8qFNgv3dlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFFbBe2ocZ+F1AkszlzjxpMTOK/sBcX2nSSgc6FrT4w=;
 b=YDeRsGRfrmRiLPv1M+0eoEpo/0N0fJjDZg4q824ra0EFCxObOdwTX7ZH35+jWbR3muTg46hFuUn6vNf/OgKXzLW5qMPdtuUOub4mvGpvdouIOyHNsrwgsx5SPtzV932mndcV0nxZ3OoC2HYmqfaIbTOCfGh6diaJ61aLtwww5aeErskwKm7eX4GhOXS3MgDp7RqmRC488coSBIti8/RaEvqXmfB7DPea43V1My7kxynmN3JnvSZc3+b1IFeBur2O9ecC7rk1Qv7dmdVVh1yBZ2CY7DeZYFHSzE9qAE/Gql9Q/sGP8rF3E+hnwr+P0W/anz+2dithRFPMhrNdB2dZ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFFbBe2ocZ+F1AkszlzjxpMTOK/sBcX2nSSgc6FrT4w=;
 b=a0Wiscy6hv29zlisXM7gotmZqGhDtxwB41g8TJpfznib+22ZaZOOK92fZoowsfpj3otKz866AhaNaIqqP1SABPm7GYJjuY+rSmh5dCRUjve67LhluyLWLxQw5ujMu71Hz3s/MkTDzjblUc9gPRiyfJ0y13jt8PLb5M3EDjmRx6k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 BL3PR01MB6897.prod.exchangelabs.com (2603:10b6:208:354::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.31; Tue, 1 Oct 2024 20:31:41 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7982.022; Tue, 1 Oct 2024
 20:31:41 +0000
Message-ID: <25b82e36-c142-4d50-8ae0-ccd2e0687744@os.amperecomputing.com>
Date: Tue, 1 Oct 2024 13:31:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix L1 stream table index calculation
 for AmpereOne
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241001180346.1485194-1-yang@os.amperecomputing.com>
 <Zvw/Kghyt9zUkupn@Asurada-Nvidia>
 <45b97496-29a2-4111-ba38-3c8bcf9f8b4d@os.amperecomputing.com>
 <20241001191800.GA1369530@ziepe.ca>
 <0e84f3c0-09d6-4485-ac76-ca296d1ee07e@os.amperecomputing.com>
 <20241001194620.GB1369530@ziepe.ca>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20241001194620.GB1369530@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:610:b0::34) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|BL3PR01MB6897:EE_
X-MS-Office365-Filtering-Correlation-Id: 7834ab5e-ce8e-4980-f9de-08dce2580e87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlJRcDFidmk3d05Xa3RudUdIMVpGY2tqMkM3QVpBQkpGZ0tTWTRBZFMzbit1?=
 =?utf-8?B?bnpoQTVuRXhwclFKVlRYT3Qybk01MDBpZ2Z2cVpQMjFya0x2dlhoRlFTVmhy?=
 =?utf-8?B?em1LTWhQbDBtcUFqcElJYjhTUkt1cWVwT2JSOVdNV1ZyREwydDdzWWlYQ080?=
 =?utf-8?B?NmREVm1OM0V4NkVmMCtNVmVtNHJXUzBRQzlpdDNYZzlPVGVIN2ZGdzhxL1pj?=
 =?utf-8?B?c2Z6bVdFcWlzQm40eVVHZ3RSckN6dXV6U3hYK3VZY0lZWERsYk5HbEhmZFZU?=
 =?utf-8?B?ZTA4ckJBVUNBRWovU2g0NjdubzhpOWRQdlE1dktBSWhXUkljSVRZMSsyQ0s2?=
 =?utf-8?B?SE5sM2xLU0dkejVnSmJEK3kyY3hBM1h5RWQxTnkzWFZTdHZ4RTRlVFNJTHRQ?=
 =?utf-8?B?dTlIZC9HRnhrQlIvZVRIWHRyeURUTng1ZTN3T21DclkycjZreGpJdWR4Y2h2?=
 =?utf-8?B?azdTQXBnRXpRNDkrQnVDK0xISGxBRFo1UmplVlpkSW0wbForN3FrbnNWaXZs?=
 =?utf-8?B?S0FrME1GU3hka1FaMzdJTHlhRXNpL0EvVm9taXhnOVEyOWRvNlVZNU4zTnpk?=
 =?utf-8?B?R1VNSkhDQWJUaXkwb214cWovVm9oUUNwTDhORk9LS2hEeUI5cEJZMFA5RjBs?=
 =?utf-8?B?OW9ibzNDa0RKNi83TE1lVFpyeWNGTFJxNkIvNXpaT2duVUJqanczeWI0aGow?=
 =?utf-8?B?OHppZXRYVjJmeGhvT1dYQkxSeHZ1dDVuMzdKOVpjWVFENHJHTmErYTB3eXBq?=
 =?utf-8?B?a3V5bEhrZ1V4VElZMmw3VUhCSDBqYTJoKzdtVTEzTFlubnpzbDdoZ25lS3ZX?=
 =?utf-8?B?MHJzTWtvUENOcmRsa2U1WEtXNnJZNm1RdWF6NTJYSXJIZjhvN1N1QVBSOWwy?=
 =?utf-8?B?M0dMNVVQbVZsclViRmlCYmRYSHV6RUN5d0JsY1RUY09qM1RsV0FzOUdyS0du?=
 =?utf-8?B?djNwdGowZm9oRkM3bDRBNGJyQ2JVelY3ZDZnRFUrSitmMU9vamxKeGM2ZVh3?=
 =?utf-8?B?NUlHRG5ieTRYSU0vbkVHaG85RWEwRHR6MmorVGtpRmdxdlh1Slo4WjVVMnpz?=
 =?utf-8?B?L3ZpYXR0d1NXaDQzdFVKa0FnVGJiUEtWQk9pajhvSnNGemRrS1NzbWpMbi9m?=
 =?utf-8?B?TWtBMXZKK21RdlpPUS8xNjV5UVFUWDdMNHNoK2Y5OGRSZWR2YWpqdTJ0MTBN?=
 =?utf-8?B?cGZGQ0NsYUt1WURoT1BLSFhINWJBZXZBUHp5U1dCeEZoK2Y4ZTZNV2hyM0RX?=
 =?utf-8?B?b1BLUTFMSk92RDBMbWkxOVNkQ0t4V1NtODVVeHdoU2lDN2l5K2I4aHh3NnRy?=
 =?utf-8?B?NkZUeGRrdThLQ3VZWE1hNkNuVnV2M1ZSVHpqUy82L2dBdlZjTm9NaHdCSU9u?=
 =?utf-8?B?S1o0cCtkci9XNkpXbUVIelNNZEhoMVc3WG9VVTAwVmVnWHZBVjdkT0x5S25P?=
 =?utf-8?B?N1NBOTRraFI4WlA3OU5lRkh6YUNQdytjeGd1TmlSS2ZzUjBKeklUNm5HZ3c0?=
 =?utf-8?B?ZnZGZ2JXL0dwK3NOdEl1a3VLNjVvOVAzd1ZSUFkwOE90V1VEY1lwUlNPR2Rq?=
 =?utf-8?B?dXVDTWFyUVhVUVpqUUpxYWdaUlBqZkNzMW1FZ3pnM1UwVUVTbU90TCtZVzRj?=
 =?utf-8?B?Rkc3M2VoY0RrdGxiRWUrZEhBangxTWdLN2VsTzBPVGh2SWI2VUV4TkFpcUs5?=
 =?utf-8?B?OExncEpaWXA0VUJrNlNza1p2ZkFYc3BhU3NzeGZsR0Vjd2ZZenJLeElnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1NBeDhJc2lzc2J0QXcxNi9ERkwzSTZsNEhFVW53WXpsWVZoRWllb3NoYkky?=
 =?utf-8?B?bmMvb3N5TUREc3NRdW9hK2RMNHpRdDdSMUFVSGpjeFJFWU1PWU5CTTVHN1NY?=
 =?utf-8?B?Y1J0ZU1DS2l6dUNhaFEydm56ZXZCQWtYRUloazJqNjRjTmR4SGQxMTZ0c1lV?=
 =?utf-8?B?RkVRVDJsdkJ3YUxTaFppU2JwaFhXaCtuVFo4aGpRYkpEd0piMkw3WmJjbk1E?=
 =?utf-8?B?dzNRTEZPRWIrV2JPSDdqblNNWmFzdmVWekFaUlVRR2dBdklZMTBsWXlUMXd1?=
 =?utf-8?B?eXA1TkEydUxWYjRVMmNCV203QU1JdytXRVd4ZU9pYUxhcC8yOU9zUlROS2ps?=
 =?utf-8?B?eU5wUVpvdkhQVzNkWmU5RFRNOWZHcG41bTVQMUtiNDBtWUEwdDN3TVZvbHFW?=
 =?utf-8?B?amM1QkhnREV6VGxWMVZzTUhvZHA1eFNpOGlVVE9xWCtMRFlXVTdNOVgrMXdh?=
 =?utf-8?B?KzFBSWpZZkpzZ095bFNKNmZqcHlzRzJ1SDQ1bXNTVGVCYWJjOVVsZlAxRlVr?=
 =?utf-8?B?d2dDVTA4Z0gvcnhRTXJFY09HZTBqUm42QjVrV0hrNGNLSVlsR25FWWV0cGJX?=
 =?utf-8?B?TUFOTVAyTGRvZ2llMFBaM0lFUWF2b253R2wxbDIwSFIzR2VQaUs5dGpIQmFa?=
 =?utf-8?B?dFJOdmI0OHNuQ29mekVReDdJeWNGWmxESGsvZFIvRmovdG5JTU9JZm1PNGJP?=
 =?utf-8?B?aXBicTE5Umk5bldvanBucjRtZUNrRkgwUk4rQTVEMEx5MUo2NDNydlR1Tkh5?=
 =?utf-8?B?RTBENFBNcDBCZkQ0Ty9WNHJHWEpQY1VpVm5EWDBFZWQ2d3BMT0NNVjFFZWJk?=
 =?utf-8?B?M3gvU3p0ckpXSkp2NnlpVTkveEg4aTVwa3RsRzcrUzBQTUUxNVlYdFExbk8z?=
 =?utf-8?B?T2NEZjlQbFQvK3Y4enlTQnVXeXkzWTV2emtIQUN2c0JTblZESytWdHU3MUxu?=
 =?utf-8?B?Z3VxUW9vR29NUFJEWEJrdlc3NUhvSEdDODdLNzNKajFaZ01yQTJ6MUE3STZs?=
 =?utf-8?B?UjNUSE5EalZrZlNsdDR0Z3RlU09ueGNQNHFFczJWaUdDeWxYOHJPNHVsVzUr?=
 =?utf-8?B?bk9YNG1LQ1dOV3U4NDZtUXh4aFU0azJvSUdyd01OcDhqdjdVWEhPcTIvM3lZ?=
 =?utf-8?B?VjJBcG16V1hyRldETG5CTUQ1bFRkMzlvNVFiZ2lvVEZya05aU2xldkNiVXVu?=
 =?utf-8?B?SGxFSkxOZHE3QkJlUEh6eHBpVTlyUXJWNEFIMHZhQkJSVXBIUjRCeStSbDNS?=
 =?utf-8?B?R05JWWtNTk5xcWN0azBMU0dRRmlXYzNhMEFNWHNGMU8zUGZBZWdkYmxkbzQ0?=
 =?utf-8?B?d0pxV2RQOWU2NzB5bVZNOTBvZDdwTEFxc0gxTlBLVkhwODdLVElhOEVGY0Uy?=
 =?utf-8?B?QUJKWHhnVlFzUFZLNmQrL3BGaGgyR2I4aGJNVE0yL2xOMnRJQS9uUDJBV2la?=
 =?utf-8?B?Sy92U0VTUHNGeklzd2NYaXVWREUzK3MyR0h6aE1VSExYbExsMUJLQ3duM3lI?=
 =?utf-8?B?Z2wrN05ZMUpwc3Jldnh0U1FBL2dRbjJYQ1ljemkzbEhWaXhaTFR5d0lESHJF?=
 =?utf-8?B?d2RZZVA0SHpGVVJ2MGxSZnV3ay9LS1pFZFk1QXYxdkRNVUdzMVdtUVBCY2RZ?=
 =?utf-8?B?SWMwT1VjZ3BlVS92cGlDT3FTOTgxS21scVFmeUx0QU5rWVN3d2tqbFhKQnFM?=
 =?utf-8?B?UkVjVVo2ZG5QanZWNTU4Ymh1THhsd05WWkxMYUNCaGpXR0laVzJyZmdUd2Zi?=
 =?utf-8?B?OVAyN3hmR3BOMlhlTXpWOUZuNjlRSjR5eVhJazVoUUUycEhqaFh3VEQvTWM2?=
 =?utf-8?B?WTIxWFkxUzlsdmxBc042OEppbDAxOW9IMkRneWYyYXdsMVNhU2RROHgrRmFR?=
 =?utf-8?B?eVIwcWtqb1hHY3BUaTRqY1hBY2tqZ0FsaE5oMHZ0Z0xqWVo4T2J1QWdVanFC?=
 =?utf-8?B?VWhWaEx2SkVoMmc0akoxdE9rREpSY3E5ZnRIbUNZU1FsZjFOVEZJN2p4a2lZ?=
 =?utf-8?B?OW5KT1I3bE4yWjdsUFd3TU1BUVpqK3IydmVXZCtyYmpnRXlrK0craFJIWkMx?=
 =?utf-8?B?YWd2WEFMVks5blVVM0k5SzhWUityMk43UmMzK09XK2NVaWtidGFZWDR2S01C?=
 =?utf-8?B?OTVieDJCNDZVWGhqZUJrNUVWRk5ybUV1WEh1czZjNElET2t1RFFwMGFuR0dX?=
 =?utf-8?Q?M9GzjtTp7+/4Vuh9Z7YR0EE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7834ab5e-ce8e-4980-f9de-08dce2580e87
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 20:31:41.0137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fl0hm6cnnXOkG2Jcaz0eAUO7CGiaHg4X1EyHby6T/I0wLDNwb5llwOoINRtR0gH7yRFDlMAo3GcFofd3oYQYezEzK1gQGyOQhQ/B/fOMSWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB6897



On 10/1/24 12:46 PM, Jason Gunthorpe wrote:
> On Tue, Oct 01, 2024 at 12:38:56PM -0700, Yang Shi wrote:
>>
>> On 10/1/24 12:18 PM, Jason Gunthorpe wrote:
>>> On Tue, Oct 01, 2024 at 12:09:03PM -0700, Yang Shi wrote:
>>>>> Also, there are other places doing "1 << smmu->sid_bits", e.g.
>>>>> arm_smmu_init_strtab_linear().
>>>> The disassembly shows it uses "sbfiz x21, x20, 6, 32" instead of lsl. 1UL
>>>> should be used if we want to take extra caution and don't prefer rely on
>>>> compiler.
>>> Still, we should be fixing them all if sid_bits == 32, all those
>>> shifts should be throwing a UBSAN error. It would be crazy to have a
>> OK, will cover this is v2.
> Maybe just make a little inline function to do this math and remove
> the repated open coding? Then the types can be right, etc.

Fine to me.

>
> Jason


