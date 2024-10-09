Return-Path: <linux-kernel+bounces-357797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB11997632
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18775B20BD9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7481E133F;
	Wed,  9 Oct 2024 20:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="cdb0FEEt"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023094.outbound.protection.outlook.com [40.107.201.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B49D1E04A0
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 20:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728504466; cv=fail; b=ny6M3kcp6tshx9JF1fzcclkjc3YiBPKmXK48gREi9VEZb09fy2EZ+j7KBATCys6L2mxdO+hZieyn/3C4M41F95bVa8uQTypxzri/jDjMilEL/gPfswxaoWbCyHPgSwMUqTkPdh9M6SBLlTQhBPwWKvBIXovY2jRsoB5NqZp3wqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728504466; c=relaxed/simple;
	bh=ZqMW8Av4KQ3JkNxtyNOOUc/NnBzAlbujVGBBfvtX7II=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=JzeI0WBe5ZwxI297WzQGgfb5rVpi0lbi6V2SE9BK7WvH2MhgNLcIdXDlmEQKBO8vKYByFZKYeFEAxpjWEtulTQxv1PnC8Wy8xEljUDZFccEjDvdxui1Acni7qOIdS7/ixGhGbS/xBcKHK4w3Zq1Wb9bJYnO+p5y6RBgbRIgIcQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=cdb0FEEt; arc=fail smtp.client-ip=40.107.201.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D09cjvixtAXP3nZ+RUI3BUuVYNKo+Gy/DIygfPXnefd2Lmvb63NM0+qxTUf+urmAtS7/NFqc1/FUp9dBoqEJSSXvnWnrDZTWKQbM8jNOtx+rjKyd8ksumzx9FXcfcZJrkaqGFHwq1jRhunp4gvvw2+fG8vH7LCO+vHaYK4iKdSZ+3LnvASB4WjVvGXds+moX1QMGMtmlw2MgrvBOi/ybIefLeAMgdbMA+LybWODFkb/Wr7gzZiVlXGW2uqQ9si0MqWYIoyilVOj63RVENSLYdnu4PhBlOtyg/k1EJAiwZlClR1JtYtjUAbNLxA8NZG4BWc3Im7ff7w0To9pXfPIXKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwQZwfum/H6l5nEDhYYHx15gRoEJYrEHSAz/56H3ACw=;
 b=BDWg+6K6bJr/3iSlnuFQ5R+o9lM2qAy8KEdSUuuL/Dxw3ndyoKM27fFdVK01lQYsXu8jL+kRLJDjutTJzJSyB+hcqw+EhjcCV+Y3JPzEcu8171vwTu2qbJSx+mFSNuwrn7HmvLAZ1LQXWeuTafLy4JUpde9q8Z+pNUbjGsMO3EYlwcFceCkwRTvlOJ1Lz0FND0Wlm5+nLtuUrkz0lOu2NlmzWAyH8Mkd+YFdOeOpQWcaQHjR7toH9ArUUthoBt6sNXXtIE+PMrUNKA0kXV75yAB8su1VLrG6YBMBLZCXR7ROfr/u2Dz/GiD0Rw4HDtBZF58nhNrsc7pol5fq9jX88A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwQZwfum/H6l5nEDhYYHx15gRoEJYrEHSAz/56H3ACw=;
 b=cdb0FEEtLLzUFiDFhpuQiBFB/7eXK2Zfrhj/Uv0H+Je6yof7JMmD5j1jCmBgRnahQjTGXMOk/zrHWBZsBkhvR3dOxNsjOCbO6QO84laZFeuFP7rE3SJzajCyU5pXfl0zTdKOV9b+zkb0N2NifbCet3CWGijINSO01p0SQDg9kek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 CH3PR01MB8491.prod.exchangelabs.com (2603:10b6:610:195::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.31; Wed, 9 Oct 2024 20:07:40 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%7]) with mapi id 15.20.7982.033; Wed, 9 Oct 2024
 20:07:38 +0000
Date: Wed, 9 Oct 2024 13:07:33 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
    Jing Zhang <renyu.zj@linux.alibaba.com>, Will Deacon <will@kernel.org>, 
    Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] perf/dwc_pcie: Load DesignWare PCIe PMU driver
 automatically on Ampere SoCs
In-Reply-To: <41a0090c-5c2f-42d3-b8a2-92ec094fab96@linux.alibaba.com>
Message-ID: <50ad8d7c-6ce1-28d-987d-fa4e285f629c@os.amperecomputing.com>
References: <20241008231824.5102-1-ilkka@os.amperecomputing.com> <20241008231824.5102-3-ilkka@os.amperecomputing.com> <41a0090c-5c2f-42d3-b8a2-92ec094fab96@linux.alibaba.com>
Content-Type: multipart/mixed; boundary="1372433909-14716538-1728504458=:3612"
X-ClientProxiedBy: MW4P222CA0026.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::31) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|CH3PR01MB8491:EE_
X-MS-Office365-Filtering-Correlation-Id: 6627d137-7e97-4a0f-6665-08dce89e0620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzNsbTVJWFhydTVaV0VQNDJoQk52eEd3WmFxZ3oyRVlLZnphc3M4UkJuSExS?=
 =?utf-8?B?UExsamJyMUIzSFY2R1dRcTNwbE83aGRTQ2FQbVZldUlVVVBvd3NLbHp3ZVFK?=
 =?utf-8?B?UVRsVDhZREgvSkt4NXMyRktPUzBrMXVucDJ2ek9hdURKRk5PUDY3bTJ2YVFj?=
 =?utf-8?B?elkwOWNlby9OWTZHa1h3T0xSZEFpVjdEL2dGT2cra1BiYUFaYWFqNEw4YVQx?=
 =?utf-8?B?TGFySGx0RTNQR3cwNHBKTUczN2ZjRm5DS3crak5kQlpqY3B1SGdVOW9XQnlK?=
 =?utf-8?B?WlZIWWNQRUt3Q3d5Y1FSV1hGS0l1NDZKNUwyRitYUmVRYUN0SWJKWmhHWEJD?=
 =?utf-8?B?VjlnWEN5QXB6bjRMZWt5WHFXeXVza0F4UUJPU3ZBYndmVGh2ajNJSmJHUWV1?=
 =?utf-8?B?c2l0d0hURDV1RzBHcEtSUU11b2NESkhNdzdhVE9XTjE1Z3FLR01jRVlJaktZ?=
 =?utf-8?B?YS9GdHQydHAzK1ZpN09aV3hGNFE2VFBXcndzWWFrZEZnYmVyUEJDczA2bVNh?=
 =?utf-8?B?YlZzb2ltL1Q4ZURmNFk1Z1VaNG9GbEtHVUlBa3Q1ajZ4eDN1RURVNFJNa1Mz?=
 =?utf-8?B?dmtzbjUxdy9uU29XSXRWN0UxOEYyMEl1S0EwVm9paThPd3ljcjVDd0c2Kzds?=
 =?utf-8?B?OFBXNVRvekt6UkNubkR5R0h3NnNuNnp6VjI3MDR2UVBYaHpjWk93bkh4OVUy?=
 =?utf-8?B?WENQSmx5Zi94a3V2UXJoK0NwTDl6SDRLNHVuZlkzYm5ucElwd1NJWjFIcDFh?=
 =?utf-8?B?WWI4VDIwdU5sQXYvNks5U1I2bi94eTh1cjFDcFp4NDFGeTlQV295eW94ODUv?=
 =?utf-8?B?NmNONFhVbXJGWHlVdUFPcVpIaTRTTGhPU2FyZDhHc1BHamdnRWpGOEE5eFIr?=
 =?utf-8?B?VlpOQ1dHbjU0WHl0a3Vob3JwZXl3UGVXMFVrdnlCYWtSZXQvWW1qZWNCcDJK?=
 =?utf-8?B?Q0lhd3NoZkFPNkJyWnc2b3FuMDd0K0cweEpCTG9pL1VDcTgvV1YzRHc3SFMx?=
 =?utf-8?B?SEQ0SzJmQnBLYURCcXFacXkxZzdjWTk0VFVVbS95c3JtZkZ5bFJKbDNwVFU3?=
 =?utf-8?B?Rlp3a3phNjhWSVVlR2UzRlQ2TSt5UUZnVnlzcUk4SER0UCtOWmhiVHVna0xQ?=
 =?utf-8?B?WGd4cm1LUmVGYkRHTWhhcXNFN0tHbEZLRU5sL1BlWGlEQ1k4WEtFRzNuVDk5?=
 =?utf-8?B?RkJlYS90ZUJFN3Z0TkFwRDF1SlBQVUdyQ1VCR3k2SWdHZkxCWTJDS2VHQXdw?=
 =?utf-8?B?cWUybFlmZUZUMDFKQ1ZsOG1JWXltSnFIczR3TkMvWUd0dkpzVjlLLzZkellS?=
 =?utf-8?B?WG9TS0thNWd5QXNxSXlsSXBJbjdzd2hXVlk5ODVhUGw2WVpMOE1kRVIvRGpq?=
 =?utf-8?B?aytJQmpGeGc5bkNCUklzTVBTNmpsYUZFQk9jQ1o3c3h5c2RVcnBnYVlDVEgw?=
 =?utf-8?B?ZkU0U29JV0MwMlRyYWtJMmt2Z25mU08rZlVQQkJHZjdzZU4rZ2E2MDdBbFpp?=
 =?utf-8?B?M2Q5UXBJM0V1U3IwckRMZE11U3V5aHlqQkIzVC9lanFFaTZIYXQ3U1dVeXZ1?=
 =?utf-8?B?dWdIZVVXNTBVMXRMYzVxcFh5NEExanBaMm1RdXZlV0U0bVRpdzhsMlplYTAr?=
 =?utf-8?B?U2FTZ3ZtSFNkY0Y2UUNKMDQxeXhMQ3hELzA3TkUyL000aFNyVUVWd2RNc0wv?=
 =?utf-8?B?OGFqd3B0NXJ2bXdSWS8xMlgwZnVqSTB4YmorTDM2a2hWSUhpMTJLb2o0a3o5?=
 =?utf-8?B?NXZmWURDWU5xczMwSjNjZEgrSFZNVFJpbytBbUtrQmhmOGtZbWFGTUpvd0tQ?=
 =?utf-8?B?WnVnRDBzSkUyUndSS1FHUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGlVQ0piYTVaaDhtTW9jNXBWR1VoN2pwZzMzZjFWS0J0ZnJROG44VG1uLzZK?=
 =?utf-8?B?S3liZXF4R1NWdEc1eW5mZWhQWTJRMDhYektNTi9zSUo5OGZOUFJzNnVTL1FC?=
 =?utf-8?B?VG9oSDl5MUdNT0VMQWE5YldpM3gySGlOZHhidCtLTEhsdUdOb3luUE9YQXpI?=
 =?utf-8?B?cUhYY0d1Y09Gdk9Ma05wMUZMcGFPVXVRRG9tNUZYelFnL0NVL2N1TU1JMkZ4?=
 =?utf-8?B?elBDR2owTmtCaGh3dzNnZTZBWGM3OXJWUnpKazZmMnUzL0FFemlYbmcyb3BZ?=
 =?utf-8?B?T1ZZQXM5SklzekRtbFJ0UU5BWEFNOW1YbmVmZTlKdlVQcURqdUMrMCtWYTl4?=
 =?utf-8?B?WGE0ekt2eXI5cWd3aFlCMStnSjZNVmNOSnJRTGtqV2R4WmlzQUI2TGgrdFBk?=
 =?utf-8?B?c1AwenR5eE03Y1BPUHp6VGNDQVJ6NU9vZ1FLNERkSXl5eGt3YWNYTC9EQUVr?=
 =?utf-8?B?eTcxZnROM25qbTIvbGZScUpVWHdOTXhKckxvYkFnOElwZzc2RjN3dDhObVEr?=
 =?utf-8?B?MDVERE1PcWZMTHh0ZUxBTWJ4bGdPdktBL1A2VWJTMkE4TWo1SGtZcFRneExL?=
 =?utf-8?B?Z29xUytsU0paZ0tvcHZrR3lzTDB4MGhPOVA2MnNyZTN3ZW9nZE1XZ1dma1d1?=
 =?utf-8?B?a2xkeVlBelZBUW1oelZzTnRHem9BaEFuSHpPVllyMS95KzBpKyt5UGhCbFVM?=
 =?utf-8?B?Y2NNaTQ2SnpPZEhlVkFCTFNWbmc3djNUZFJTOGErZER1RnozL3M1Wit6Sk5m?=
 =?utf-8?B?QmJOR092VDVGdzB4TndwODlDT0txM1k1RXQva2Noc0taN24rMGErVnhWTWtX?=
 =?utf-8?B?TDQrc0ZXajZSY0VoalUxdVhPcHdXcy9zTFJVaHNRY2ZnZGp6NEFkdnlKejRY?=
 =?utf-8?B?NklpSkxadGxWcjJuNkhvQitpOTZCdzFiS0tOU1FkVDhjL1oxbEVMTGNkMGFQ?=
 =?utf-8?B?Z0QySzA2ZitpTGJEVGVRdkNWMXVTaFZCZno1bW8yZ0JQcVZsVm9Gb3pIb3pN?=
 =?utf-8?B?NEh0YXdubGVaNWlackwxR01oQXFHd2VGTnpKOGlLcFV6SWhNNjNPRDZUYlpm?=
 =?utf-8?B?dFhkVmZVNzI2b0NiU1hpdmFqQlo4Mkp6THBHbnc2bWhqZk5XYXBKdmFrRm40?=
 =?utf-8?B?VC9SZEdnWllIbjhURFR6Qklrckc1N2xNSnlWUWkzVm5sWWJQb2wvbk5kelA3?=
 =?utf-8?B?bmUzSEJTRVR3TWZZTUwxTVh4YXRGNkJKU1p3MDJwVFRJRmEyM1F6by93OFRM?=
 =?utf-8?B?M0lXWXdnRWVvb0xDNXNZUkxTd2dRNWt6MDBKdHB5K1E3Q0UwSC96dG92SHQy?=
 =?utf-8?B?V3l1RVEyU0E0dlVVV2R2VEZ4UHFycWpSQ052RHk4MW94TGs5b0hMUmViNUE2?=
 =?utf-8?B?Zkh5TjFHVkF2bDlNZUE4ZUJ1QUlLVGl4UFNaNTRMbGN1a1pqbWVRWnNzYkdp?=
 =?utf-8?B?MWx4dW1qNlRzdUd4QkVyY1R3QjRWQnF6QVJMb2FoMnJUM3REcFBBamgrTjJi?=
 =?utf-8?B?VENzY1MxZm13OVlLaTN1dHNVUGt3aXh4cEVhNnovQjFMRlcraS9LSkFlU08x?=
 =?utf-8?B?V3lwc0gyTDFka0t1YXdNWTJ4cXRYTW04d0RBMnF2K1RzR1huSGJJMERwTGNP?=
 =?utf-8?B?am5LTkJmZ0RYOTRsU0lYS1dQaC9wT0dSQnowUGtHZjNWdnRZYm9DcVVQbUFx?=
 =?utf-8?B?OWRkcXdiN2RPWDI3YXl1N0lOVFVGNE9oSnZoelZFZzk4ZHVMZU4wZ1gzZlRG?=
 =?utf-8?B?dk9DeTZBQ3N3c2gwRVl5bEZtVklvalp3ZUVmeG0wU2pmOTRDSnhMdElpWGJ2?=
 =?utf-8?B?cC9BRzl6SW9OQ3IwbGdUTi93a3lNcitoaDR0ZFhaQzlzQ09DT1RWNVNwclBj?=
 =?utf-8?B?bDdCUHVjMHJvT3hyUTJvNDMvY0xwbEVLbnFLMWxBdVJLbnptVzNzK0d0Y09O?=
 =?utf-8?B?TTRoRVl4aS95OWlnNW4rUnpiZGZ6U0NUdDBiSmNQMk5pcjg2MVVMYytPNWpX?=
 =?utf-8?B?NDBnNUt3bDJLbERENmhMWGtPTUlUMmtjT04rMGNHQzNyejVVMTIxMStpMHp3?=
 =?utf-8?B?NnRVbXVMNmtjYVcyZkhBNFJGWTRjNmdpWGY4MU8vVFlnelZINzBzWldWRHpT?=
 =?utf-8?B?RjcwWVAxZHBEZXlBU090SW9tZXFhc0dxRFFWTnVleEhvRXdPU284dmhseTg5?=
 =?utf-8?Q?ipQoQe/yV3GUxC+c9JqQvCc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6627d137-7e97-4a0f-6665-08dce89e0620
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 20:07:38.6052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4cdTiI1uMQysvry0rKqlZjjVcYhL7F0H2Foh7qS63q7J5NHWmMgdKDNPAsdgyxYcAY6kOs7mr4MP73jtVjUsptFUy7b7zTOaTWHt52nFhoDNh8jPbCrQtUIepkhEPnat
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR01MB8491

--1372433909-14716538-1728504458=:3612
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT


Hi Shuai,

On Wed, 9 Oct 2024, Shuai Xue wrote:
> 在 2024/10/9 07:18, Ilkka Koskinen 写道:
>> Load DesignWare PCIe PMU driver automatically if the system has a PCI
>> bridge by Ampere.
>> 
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> ---
>>   drivers/perf/dwc_pcie_pmu.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>> 
>> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
>> index 3581d916d851..d752168733cf 100644
>> --- a/drivers/perf/dwc_pcie_pmu.c
>> +++ b/drivers/perf/dwc_pcie_pmu.c
>> @@ -782,6 +782,16 @@ static void __exit dwc_pcie_pmu_exit(void)
>>   module_init(dwc_pcie_pmu_init);
>>   module_exit(dwc_pcie_pmu_exit);
>>   +static const struct pci_device_id dwc_pcie_pmu_table[] = {
>> +	{
>> +		PCI_DEVICE(PCI_VENDOR_ID_AMPERE, PCI_ANY_ID),
>
> Hi, Ilkka,
>
> Does all Ampere PCI bridge use this IP?

I have checked Altra, AltraMax and AmpereOne SoCs and they all do. 
Unfortunately, I don't have access to eMAG at this point. If the IP
will be changed and the feature won't be supported in the future SoCs,
I can certainly change the logic to accept only certain SoCs.

Cheers, Ilkka

>
> Best Regards,
> Shuai
>
>
>
--1372433909-14716538-1728504458=:3612--

