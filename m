Return-Path: <linux-kernel+bounces-555680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C78DA5BB2F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEEEB172099
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019EA2288F7;
	Tue, 11 Mar 2025 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wau/oR09"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556C2226865;
	Tue, 11 Mar 2025 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741683135; cv=fail; b=P8IPfYE0AUUpJJ7pMKj66WsmkVFYq0REdGGKK/tVipOEfdngLkmoP0VA3uFSH2S3y1rNGRe974FAMdBOhpc9+Vir43tqwj6pGXvQK2UZDG2toJehJCvik1+MQahHdXlUVs4uhQ8B6HJwu0PvvzANPoeLKbkCqEGEyEbVCifxHFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741683135; c=relaxed/simple;
	bh=eU2Rzhpi9U9ttSXj3PKZzQorir4eFWz0Q4ciBjFVU5Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f76Nz4hc13RuGvpRc6uxdF6eIUyreVQ6xqzxX2tCtEH7lycXIliJZzuSV2u9ti+YpnLfV5LnShVGl+AYzZByQIf9GpbntB44BrOQX2iRu32gJkSxMzZL22tUOt2ZKGMMIutUAOQ5xGuWcSqpp0l8ciVzpMcMxaztkSWObEUnnNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wau/oR09; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iysc71xyLHmcY7lwBhyEYlyAXuZMf/FrcOxblU18L/ZJain5I2XTdKV7gCt9wcAR6y5IxxHVqX/d60LxpWQs2ZyZ26mSYuW9amrBADbeHCHI+2lLrk3H8+XMjUSoMl0gRTTSI1ClbaqXO3jffst/4a3vL01db2ABfUG+M4FhkVNxkCit7Bj59Lp4mNzcMRZ7Y9zTqE8O7x720aVyGGA3U+zoGABluFWNJi40yNoP8xN+mXVwCQWDIj9pvSDkNTtHOoo6uSmNO70VPq73ioTsIlyhjT04HPXW0o4TJGQEZMvXdW/BL5uUA+9Czym4ylh+o8Nx8UMQil8fnpnkbszBEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdRGSdjGfJkV/g4hrWDBRqlf4eMXpz3/aGQSpHr398o=;
 b=WlitRqstQasJ76UpKhURr7leNCGHpiN77w8Up1H4JIxsVvhLIWariQEdTkojHFKqjghzuGFyp/UNeKc+kgbUKSw/YfDgkFZBylJwZJMdFnqshdnyIj90JkBaM6zUImmKTFLQEgTAQs3La3EMc4XT31if1wCbbk6dHzRujn16XJML8hKdH5KEhIa8edM6hDIr+jOY1BHZMpO791dJNm2XgVDtVNY8YiBAZwZQld6SyjVQMG5ynBs+ytOTIDaThdGU2HxxEyCL4qvcBxJ0w1RjAtB063YOvWPYRNNDPzJFcaovr6v1sxy//1CNSYnErFouI9T8Htc4AUC/VRWBScDVDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdRGSdjGfJkV/g4hrWDBRqlf4eMXpz3/aGQSpHr398o=;
 b=Wau/oR095Pn0F8JOLpUmqGFz2n8HTk+K3jWsJhKKykHPF+GBUbJKUvmhz8QT4zJLiEYQ4Vkc0G3yCq84mX/mm747bvYfr5b23UT2WY7TGVA9RR9/ttNm+x09SS+YYzWDQKIDG3se6cbWzvHoVsqv9afax0xhlRJIYi+60usWDbA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 08:52:10 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%3]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 08:52:10 +0000
Message-ID: <a8592497-5204-47da-9801-a254b0852fe2@amd.com>
Date: Tue, 11 Mar 2025 14:22:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/amd/pmf: fix cleanup in
 amd_pmf_init_smart_pc()
To: Dan Carpenter <dan.carpenter@linaro.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
 Patil Rajesh Reddy <Patil.Reddy@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
References: <43ad5358-f5b2-4cfc-85b4-e7ab8c7cf329@stanley.mountain>
 <32c6c456-94f0-f077-040c-09f67d60953a@linux.intel.com>
 <4a14c0a5-d6f8-4df9-b947-a0d3c3ef02b3@stanley.mountain>
Content-Language: en-US
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <4a14c0a5-d6f8-4df9-b947-a0d3c3ef02b3@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0166.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::22) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|DS7PR12MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: d22a26d5-657b-41fa-6a31-08dd607a0244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmszeGlVd2QwN3hJdDdJSTd2UTV2OFJHay96WStNYUNSUXJzRXpnajRuRHNt?=
 =?utf-8?B?bGJHNXg0ODlFb2RPYzlNSDVmYjl4RnpUekNKeU9lSmVTM1ROempzRjFjUTFT?=
 =?utf-8?B?TXkxZHQ5SFp3YmFLUVRoNUJoRmdreUpqTDMxcHZkbnBOSjczN2RzdmZ0VXli?=
 =?utf-8?B?c1AxQnNaSUJObmYyZEc0RU5jb3lnYzRNV0t1WThTQmFxRFpoaTkvZzhhbDhU?=
 =?utf-8?B?TVArNy9oSFkxRkFuY0FIRG5mODVMN0Z0SlZ2RmNpemdSMFNoWFBuTGtDVC9U?=
 =?utf-8?B?dGV2ejlTNFd2SXZmN2JGcmRLYkg4UVp1RDhiYzVnd2VXdDZSUlhlY2RaUVRN?=
 =?utf-8?B?bFdlczJwYlN3UDZ4RXp3RkhlNE9XbHgwMVFxTThUWTRtRE9SOVowbEF3Q3I3?=
 =?utf-8?B?cnlUZ3RrVmJVRDlPaXBkSlpRSjdEbE5YVlBGZlFhRklPWWcvYncrWmovaHpI?=
 =?utf-8?B?aTNSL1lKbzVjRURCanlrSGIxeFFzczhCMjFHRVZSZU9yaTUzMExvMFZhUzdo?=
 =?utf-8?B?UEJDc2VDZzZmOE95akhjb3ArV3EreWFqbXZOZWwza0YySXFtcTJKQjQxN3J4?=
 =?utf-8?B?V2JOcFdHc09wd1RWbyswQ21CRWJqQnJQdjJOSTBIdi9iYWpGd3pieFZjTjJB?=
 =?utf-8?B?L0tCZlZ2bUMzbS9Rb2U1SXJRd01seWhaU2pwb2JSY0FEQmo1eG5HV1g5MGdW?=
 =?utf-8?B?UWhoaC9zeFcyQjh0R3lrNE5uMnN3QVB0T252VDF4SysrWUhHTk1MU0RZRUxC?=
 =?utf-8?B?aXE3L0hVY0cyemJtTGpkYmp3ZHdNSUxPNldYVTZ4M2FISk1YMDB4aHhvVGxa?=
 =?utf-8?B?QXdYaVBNQjVxMHZjZ0luQmJVcmV1ZWhLMXNQdGlYRERSSEJZK2wvd1hTMDda?=
 =?utf-8?B?OFByTXIwTWpWYmZyc2ZvVnFtSmNHdUVpM3c0bEkrRTVGbDRFZnFFU2RRSmV3?=
 =?utf-8?B?bjlEY09OeEt1TlhuRXc0cFJ5RXdMVHFERm1FanlIYmV6Wm5qZFJRNjBiMHI0?=
 =?utf-8?B?TzJ6U1pZamw0c25JdFhGdDF2WkRMR251aXNpVlhUckZPWkJ5S2p3blE1OEFj?=
 =?utf-8?B?cVpCOG5XNWE2dDZXVXo2SS9xbDl5YUcyRUcwTEtJSDVzUG9YY2FrYW5kVVJx?=
 =?utf-8?B?SEpzdVluREcyZFVDdWpCbnpZLzQ0azVGSUYzcUFISlM0UzVDcURJMVI4dlNR?=
 =?utf-8?B?eG9yRXdEWjFoMXZ1c21TbW8vbHFRR0g4d3prMmpvMmF1U1VlVDQxOUtJN0tY?=
 =?utf-8?B?clhqbndnbTAzL3RrZUtEYTlPUnFKMS9USFBxR0xlbFFPVktMNDhFSU9qNGo2?=
 =?utf-8?B?dWxsdHg1Y3BuTzJ0RklvU0F4ZEFuSTEyVlA2ZUkzYWV0b0RZWENubjBTSFIz?=
 =?utf-8?B?MlBLTk1ueURXMUNRSStyV3hoZHptQ0o2TmpVQXBQQ2lheU1kK2NtWDBIR0xZ?=
 =?utf-8?B?M2pHQ0N5V2ZDSnA3KzI5bTQ3ekVvd0NqQ2IxZW9xcmx6OTBSQjdnVEhpaFhE?=
 =?utf-8?B?YncvZzdpYUdDVDRKQ0EvM2tYNlIzS25JVTlFb2hIRHVMb2ZkTWh5UFNSZy9M?=
 =?utf-8?B?Z0c3S1JJYUZLdWdaVEI4TE5DdUExMmQrNEwwUjk5TVpSUDErRm1GWGV3TW1l?=
 =?utf-8?B?bEhsV2lkakpIUGQ0YWFEUm1BOHZ0MTg3TGkrSUNIckx3SGY2cHZ1U1M5S3FO?=
 =?utf-8?B?TWcyYWwreU1tQlIwWUZ2RGJ1eXZzR3ZxTVFUV2U1ZFkvTnc1bnhtcTlYazdl?=
 =?utf-8?B?MW1xZUpmVHBsdXpiL20wSjBUZE1LblE5R1hieVo3bzBSNk12Y2IrdHJLdHA3?=
 =?utf-8?B?ZWNBeDk3eHdVeWowVlJSZWU2ekxjOWpFZGc0dGFhYTZJaEgrRHIrT291NHVP?=
 =?utf-8?Q?F/RxT/xv/ZVbr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REd0UTM0RFJyK2xXZXhGbXJWancxazRXWnB6TFk5N3BtVVlRK0d2cElaT1M5?=
 =?utf-8?B?K3dxcmh1N0lROC9MemQyS3Z3VzhSRjdYd1dJU2Q2bjNuRkFrRXFLZ2FhM3E0?=
 =?utf-8?B?UzI5WU5wRG9Ga2lKSVowVmtlZUpyN1lJN3Z0NndZaHZHZEUvZjNoQ0F1OUJY?=
 =?utf-8?B?bTJXdy9PbkFzVUNHTGRjT1ZkbzhBN043VnJPNTFQeHhPUUZJL1BIa3czNW8v?=
 =?utf-8?B?NDZPanN2S1AxM2F0N2ZpM2JBY21OZHNxSUQ5ZnRkdDRUc25GMmxKdVkzSDZy?=
 =?utf-8?B?ZDRGaE5FaG1sV2pZWGZUbWZpL3ZiZGZGa25OazRSMkU1Q2oyN05vRkJDMTVJ?=
 =?utf-8?B?SzZKT05hR1YyazNYbUFyemNhZENzUGNMYnlZU0ZveTdvMWNwQklRSklSRTJh?=
 =?utf-8?B?a2dEdng4M2VHK3NNalNzNFMwSytvU295NDlCOFlaVzgzWnR3djE3OS9sQUkw?=
 =?utf-8?B?aDAwQUhMK3lzOVJMdG00ZkdYMWJhSlFWcytrbjg0TGNFZi9XR1FKeFgwY3M5?=
 =?utf-8?B?akZLUWczUndtdlkxRzFvOVpVbVZ0WXdMbWkyd2tza2NJdGxZSW9DcTNVeTZq?=
 =?utf-8?B?ZnYvRWJ4UFVkTDh2ejJTQWdTQWZaODRSd0p3U1Z5STl6Mm1maVhYZzFDQkZR?=
 =?utf-8?B?Yk5lYXgwSmRKWkJjei9ndTNFNEh2UUJ0RE55aStxOWJxU1F2OEhKenBkZFRm?=
 =?utf-8?B?aUFLQ01taThwMDhZdk1MdXAxZ3pMWm5odExIZm1BR3pMYk5ldWRCS05PSmlB?=
 =?utf-8?B?M1A5NzFtSVJCanh1a3RraUwvNDZPdmp2OTNuR1VsTUxBQ2RxQmIwTTlzUnFL?=
 =?utf-8?B?eDlNajE2QUFsRVZmQ2UxOUhLVUpzb29qT25MLytkMS91cW5tNmFERjcvM0xm?=
 =?utf-8?B?NG5DdmJYaWIrT1FxeTdsekZzSTR4R0NCcXIzN2tTbGtBS3hMbTdBcGJaaE54?=
 =?utf-8?B?NFFYZmhjZ2FIczkwQUhzTVY4b2hpVE1WMXdqbm9pRFQ4K1hSeW16SnZkM3gy?=
 =?utf-8?B?Z1F4TUFOYkRaa1BKQ2tCTjR4L3RCUitCdnN2NVhWY3czUXZ4R1pUellncUxn?=
 =?utf-8?B?aG1KNjVGdUtqQVFjNVVSM2QyUUhLMUNuRFQvRkRwZFZRcVUxV1ozRmsyQ0RE?=
 =?utf-8?B?VXE1TDM5OGpXNEZKTzhBYWpHU1BNYlVKTklPakYrb2huM2xWZUQ2YjJjM0dy?=
 =?utf-8?B?YXY4dUs1a3JsT2t6NWtEc0toeEVEaWVxU3pHWW1qNXp4SERvLzVnWDlyRjRw?=
 =?utf-8?B?K2QxazBpMU8reWgyVnhzR1J6N1F5THFEQ0FOV0lJTGdGRkZRa0NyTWloMDZi?=
 =?utf-8?B?bWlwdmJMUWNURTRqWlZxR0xXSy9GSkswckUyS2VTUnA3MlFnd2pXR1RVSmJ1?=
 =?utf-8?B?dDJpWjlLNnlOQzJNakdLbUtQYWZCY2FYNklyUGxiUHc4aDZiSW9ZT1pNaUlF?=
 =?utf-8?B?cVpzdlB1SllUOFVZVmVpd2NwcnRsNFZMazU0dU5maXYvOHByLzBkalZxQXJ6?=
 =?utf-8?B?YlRseGVjcXJqSExuSTRINnIxNVNPZU9XRE5yV0tKdGNXN2N3QVNvQjBKNEcz?=
 =?utf-8?B?Qk8vRDNxcy92dU80UTBkWVBwUmdyc0Uvd0liWjhtQTBGS25RMVFhc1FEVVA3?=
 =?utf-8?B?OUdXUDRjSDREZ0Y4UThnV2EwZ2tka0hxa1kzaE83UWxxKzJuWCtCL0RCVytZ?=
 =?utf-8?B?MUNMWFhxNWJrZVowM1pKZXUyeU4xRi8zTTloby8vcjBXZzRVeHU5bzZRUXV5?=
 =?utf-8?B?UTRZV1MvcFR0K1pjOXdiY2lmOUdsaWxuSkNzaCtTR0d2UmJ3VlBDaWVsajdO?=
 =?utf-8?B?aDJXcWY0dld5UjBONHVrS2tUWEFuWHBMTTJCblkxTHNDTjVtdE9ab3A3b0k4?=
 =?utf-8?B?RHNNU3VLSEJhRzlkMUtmQm9BNnJNcExhNGpYc3YrMSs0QVEvUkQxTCtVMEk4?=
 =?utf-8?B?RmRCRFhIMlJSWE51T242TUdwdjNSZVB0cXJ4QWF5dkZtQ1VaanB0eklkOStn?=
 =?utf-8?B?WkF1UElXZ0oxV1NnaVBjaENML0FhNzUwMWhZVldtTGgyTkViVTUzR3V0d0ds?=
 =?utf-8?B?Z09Dem1DQUtsaWE3dnFZWFBjTnZqQlhBeFRZWFA3R2gzWm16d1VTcGpwSk9w?=
 =?utf-8?Q?zqTqeL+NGIYbkR6X1rzb+Ld3W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d22a26d5-657b-41fa-6a31-08dd607a0244
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 08:52:10.0655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBrk9e1vqIs1iUetnhP2lTdsEBiwX2SrjXSCPVFUMoZy3wUJIv7l+rN0EOEiZHOMK1YUmue2Ri9BIzWPjEo61Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5768

Hi Dan,

On 3/10/2025 20:22, Dan Carpenter wrote:
> On Mon, Mar 10, 2025 at 02:43:51PM +0200, Ilpo Järvinen wrote:
>> On Mon, 10 Mar 2025, Dan Carpenter wrote:
>>
>>> There are a couple problems in this code:
>>>
>>> First, if amd_pmf_tee_init() fails then the function returns directly
>>> instead of cleaning up.  We cannot simply do a "goto error;" because
>>> that would lead to a double free.  I have re-written this code to
>>> use an unwind ladder to free the allocations.
>>
>> Thanks Dan,
>>
>> Could you please amend this with the information of what is getting 
>> double freed, it took considerable amount of time for me to figure out.
>> I assume it's ->fw_shm_pool ?
>>
> 
> Yes, that's it.  Sure, I can re-write that.
> 
>>> Second, if amd_pmf_start_policy_engine() fails on every iteration though
>>> the loop then the code calls amd_pmf_tee_deinit() twice which is also a
>>> double free.  Call amd_pmf_tee_deinit() inside the loop for each failed
>>> iteration.  Also on that path the error codes are not necessarily
>>> negative kernel error codes.  Set the error code to -EINVAL.
>>
>> Maybe I should start to consistently reject any attempt to use 
>> cleanup/deinit helper functions instead of a proper rollback. It 
>> seems a pattern that is very prone to errors like this.
> 
> I do not like deinit functions.  They are so hard to review.  But I
> detected this bug because of a Smatch warning:
> 
> drivers/platform/x86/amd/pmf/tee-if.c:540 amd_pmf_init_smart_pc() warn: missing unwind goto?

Thank you for the fix. We have a CI that runs sparse/smatch/coverity
to catch all these issues and unfortunately this was not caught by the
CI system.

But, I can confirm that Smatch is triggering this.

drivers/platform/x86/amd/pmf/tee-if.c
  CHECK   scripts/mod/empty.c
  CALL    scripts/checksyscalls.sh
  DESCEND objtool
  INSTALL libsubcmd_headers
  CC [M]  drivers/platform/x86/amd/pmf/tee-if.o
  CHECK   drivers/platform/x86/amd/pmf/tee-if.c
drivers/platform/x86/amd/pmf/tee-if.c:540 amd_pmf_init_smart_pc()
warn: missing unwind goto?

Thanks,
Shyam


