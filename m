Return-Path: <linux-kernel+bounces-577562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A77FA71ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB961891343
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3662255E27;
	Wed, 26 Mar 2025 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3zqKRdIx"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0022459D5;
	Wed, 26 Mar 2025 19:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743016028; cv=fail; b=t3kQdMHzvISgPhT+wNZRl8fXSNE7tCy+GpM2Yd/kRGHKoRwT2eaQGHeOsobIL/FtgxmwGAukCUf/W5lhCCDQxa0hgYqKCHX2lriGW3oOfMmidhDv8ZOYq5YFj/r6WQpilZ2FcDQUOVPeoz/NCrYNqL3Wim/PPYianLyZi1Dw7oM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743016028; c=relaxed/simple;
	bh=TdiWOxivo3gEtkxQS6C2etJcSty0iHgsVWeq5q3UB4s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K/ekGMlwPFgP5552In3jtkbcuAY8FsxZ1190ivZ7HS8rS6eXFqpI7qg70uL3NYlPHP0QUk0aBfN1TRHCxoAvY/ns3d8eQw7gBJXh9xHk7uIziFWN4FWH8ATRzfQk0ZfTI5XmYFtR+ECZIgRVG7lvRNJ/6hDbUmVaLTF0FTWdt2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3zqKRdIx; arc=fail smtp.client-ip=40.107.212.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyk01iSkTIDb20Npj4OG4GPgN7z/CszvK/n99ZQFQx5MsW/F3pp7ELZFDNc7L++MYxdx1UNRKOxsdQuoZ8xho+S7A0Vn0w349UEnsqNSirK7rKZOlTRVLnC8SCsEGrLmGnmKOUzpHAinCf4MT4/mIdQXduHXsssLHn7xKWRpKnkaBFIyRhcoDBn3Jagbk3O9Gcisu8r6p++rMsHcSJD/qdewdAERMn7pvStm15P49dBI3+ZzHDHYWC2rrukcmbBlAfHPeKYS7iJzbqCVolJwGusygKcBk6oTLhe8kr4H/V2Jd5MIPCdR13nr4xxtyD0vpGSEZn3WTQnk3/u/3H6YcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdiWOxivo3gEtkxQS6C2etJcSty0iHgsVWeq5q3UB4s=;
 b=QJ0gEzjuo3zuIeOtlPUBhKCjPmNq0Ju9bL0Mk7dE0aeiovdwJx2WcD9xE+SJKha2Uik7FBPY0ubKWHIooE4scKrKt6/sUOGTkSf00slfqmkEvu2QbHWq3dm4cTjp+JUiGGDD12OSu9BzyTrIOr+uh1gsGG8yb5GESvVJTNtChOxKixLpSQuo+c/CvP7Kss/GrGFtUjHOUobS317BzbOL5m20sZtmR1821ScODce6FKLkM7Um/b6jlGxea3TTrmgsXbhZJ5bUHL6SfovJVgWlHxosEvgWiz8vrTyOPe8eWqgMl1RPe/ECxlhDtotWig5UNx4VG2YQwKqcpNOHltCSxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdiWOxivo3gEtkxQS6C2etJcSty0iHgsVWeq5q3UB4s=;
 b=3zqKRdIxfmXlu5kxG6cnSdpSuvA6p+IS+9p3f4f+Vs4Z0hHWtFREklREU+dVsozIvqIwZfpvR6n6D2A6V8FdZmO2iUoiSfcSSWZH1onJK5Rgr2j6STCNvvS2O5Hsbn0InEoR/o+cy+WtHEj+J7paoJCz4kBX9FRX2fAo2sILB+I=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by CY3PR12MB9606.namprd12.prod.outlook.com (2603:10b6:930:102::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 19:07:01 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%7]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 19:07:00 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: "Simek, Michal" <michal.simek@amd.com>, Mike Looijmans
	<mike.looijmans@topic.nl>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] usb: dwc3: xilinx: Prevent spike in reset signal
Thread-Topic: [PATCH v2] usb: dwc3: xilinx: Prevent spike in reset signal
Thread-Index: AQHbl9iJ46KeKR9l902Y4q7prF/3O7OF1JIA
Date: Wed, 26 Mar 2025 19:07:00 +0000
Message-ID:
 <MN0PR12MB5953877D84F9830C70A9293EB7A62@MN0PR12MB5953.namprd12.prod.outlook.com>
References:
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.92a20336-7677-4cd7-9893-b0e0da853ba9@emailsignatures365.codetwo.com>
 <20250318064518.9320-1-mike.looijmans@topic.nl>
 <b106b46b-f00f-40bc-aafc-f57a879fe090@amd.com>
In-Reply-To: <b106b46b-f00f-40bc-aafc-f57a879fe090@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=cb72b078-6224-4675-a5ed-be2e586d5f15;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-26T19:06:08Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|CY3PR12MB9606:EE_
x-ms-office365-filtering-correlation-id: 414e57d8-a6f5-42f4-a6f6-08dd6c99635a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eGlua1N0RUprSDA2OGExR0NadzdtbjNlY3NYQ0ljZ015dXBTUkdkem5WdWxE?=
 =?utf-8?B?by9wR0RxYUkzOFhsbS9FaVZRZU1pN2lKcnFTZ29Zd1dqTHY1QTVWNFIvR01S?=
 =?utf-8?B?SnFWK05mc1FNeDhwbk4vWSt6cmlaL2t0ZWVzVDZ3ZXN5RnFsWXZuVjZiY21F?=
 =?utf-8?B?cWMrL2crQmhhSGs1cnl4aHArSnNjZmE2Tkt2eWp0TEEwNWhhRDVxbGh4S1Fa?=
 =?utf-8?B?LzVjV2ZWeVpUOEhtOUk4STRmUm4yc1ZqV0dEYTJvbmVoSmdHNEd3QUJ6TFVy?=
 =?utf-8?B?bERHc3dmZWk5bGsyYjUwcnFBRGVYSXhtYmZrNnU4M0FzQXFhZmtqVlI5bDd4?=
 =?utf-8?B?ZUZ4N2h4Nk9MdFNuR1ZyL0J0cXpOK3RncCs1ZmZweDR4N252aFFSZnB2SGxB?=
 =?utf-8?B?bHpucVYrTUdUVXZTdkFEVkkvb3NIS0c4NDVRUEQ5Z0RSc0pKS3pXUlp5cUsy?=
 =?utf-8?B?UVZoQmpRQTJHTStUL0Q1SnJVZWd3d1VNRUN1dTQ5L00vRkZNRWVUUkpIck5q?=
 =?utf-8?B?L1Q1dnFJVC9xQ1BWcTZsWmpSMjlScGlxV1B2bHFqSlExSjcwckVhQlVFM0dI?=
 =?utf-8?B?OWY5WHJyWnFDTFF3R0xwMXNEalh0Z1pGNm43cUhoNUVaRDgraEhMb1c1aUF0?=
 =?utf-8?B?bjBtUzQ4UFdodXB2UEdycG96YzhuWXJlMllsODEvQzRJWk43NytyM3FOc1I3?=
 =?utf-8?B?Qi82L3FnTE1IamF0OTZ3Z3FIZEtneG9mVmxERjMxclEycnc0TzU4KzZDT09E?=
 =?utf-8?B?Tm5xeWtMZ0RKcWFSQkU1N1d6MERsQThzck1oM1QzOGphTUsrTXJDMDhGc29x?=
 =?utf-8?B?TGZvcUZaZTNBSjJ3eDNjbzIvOUFKTHNBOEtuSWg3NmFOcFlkcUZXaWpoYU54?=
 =?utf-8?B?TEI2RTZadmFsTnVhOXQ4U1VBZ2M1NkFjRUQyN0JuSDc4T3U5Y0xtK1NOaHZ0?=
 =?utf-8?B?UnFaN2FmS3RpeGFMSWlrczkycGcrYTdvZ1ZNWHVDMXJwS0tJVVFFSFJPVWR4?=
 =?utf-8?B?bTVVV1l6dlV1NHB6c1lHbVE5ZnFLWlVQSnJXQTNuSkhtSG4xVnNTKzdnK2dF?=
 =?utf-8?B?ZXBwWjU0ZWxPZmxYekZKR3NyeSs4b1hJbFRXdG9POUpQREFzaGVDaGhxOTZr?=
 =?utf-8?B?VjhIN1V3Sm5LUzhQSlR6MXYzVURvZkZmTmdMNG9zNjVWNzVrNjJ4aC9ydWZv?=
 =?utf-8?B?d2x5SzdtaDBXZlZxQTI1cHA5dFl0Z1MzTjFQK2ZaWitlU0s5dzg5dlZXSjgy?=
 =?utf-8?B?bi9Uci9DdjNLZHlOMHY3eFp3czBvamplZnI1UkNjUGZ0T3F4TzJzLzBoWXpE?=
 =?utf-8?B?TWxnZ2IvRUE0bUhqQ0JSdzZEVDNobXFIZDFRV3NkQzdzT051VEtjMmpuT0Vu?=
 =?utf-8?B?NkFialF3ZWViRXBYRjF5SGN1eFZjczNlcWFsTFAzaEw1K011QjZvWUVLY3ZW?=
 =?utf-8?B?eTJ0K3Q5cW5wUlBaOUZvVUVBMWtFN0pBM21aeUlmdjlNS2w1OFJvK2J0OG5G?=
 =?utf-8?B?b0g0aE1lMWNxcnpycy8vYVRMRmMvbjRZSHVhYUMrVnRWbWN4WGlrK1JLakt5?=
 =?utf-8?B?V2xjWW40cnJDQ2NXZ1Q2dEJBSmR6aU1zUVJ4UUU3NytzdzdJeWRiVVBnMnp0?=
 =?utf-8?B?K2Nqc1BXSng0cG1sVWF4Nk40cHBOUFJIUlgwbm5YOW4vUVVnWEtBUm1QMFpz?=
 =?utf-8?B?czBoNFpSRERHZUFBM0RnV3VucmE4RjVpM1ROTHhzaUFycEpqd3RSQk0rUVpH?=
 =?utf-8?B?MnErUkIvSG5KMldCYUtCV2pzSkhGNkZMaVlRWGYzdWVXQ2s5T0sydHBtVVFp?=
 =?utf-8?B?ZlZkQTk4L1FsbVhzM3ArRStlTXRmQ1ZXOXhUcG9iUnBjY2xxVGlNUDdxNFlL?=
 =?utf-8?B?SU43WU1DUFBGWTJaK05iK0ZuNXlhWW1yU0UzYlBiV1RuZGJzc0ZaQ000N2Ju?=
 =?utf-8?Q?84a00U0OKvnPV70ZICUytfupuPzLocns?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d2JqQ3JETTVrd3dOMEl4OHoxV3ZCZHR5dkFBT04zbVd3ZTJYaSt2Vy9ubG9r?=
 =?utf-8?B?MEoyWVpJNmxVdGd4enN3SzIreXVZdkowTDZGNTJ2cVV0WGhGWk5XWVhnQ3lQ?=
 =?utf-8?B?RVBhU3JVMUp0QzFCQkcwK0orRkVkdnhFamxGRHZOQjV6ZlB3UHc2dDEwYjFi?=
 =?utf-8?B?L05UT3gvekdTRWl1cnRrU0RFaHpZNDltNGliK0tRajZ5T0ZsOElCTHZ3TmJ2?=
 =?utf-8?B?Y3JuZDNUWVVkVUJOK2dhM3lVT1JJVlJYaFFJQWNENjFOQ2pGcUYvRWVobUZt?=
 =?utf-8?B?SG9yR05TNlBSU0VELzlObVV4Qm1oUXlTbTZNYXFUK0EvcTM2MnBuejZXY2xp?=
 =?utf-8?B?dHplNmJQc0tlcHBNV001Vyt6M1lRZm5kNlZ0QVN4QVBQaE5UTk02UUNTSXdn?=
 =?utf-8?B?dnQrSXQzWEc2S2dUeWlJaEY1UUJaYllLNnp4K1R2WGg2SjFIS1F6VW9SMTUy?=
 =?utf-8?B?MHhNMnRBQzh4ZzRKOE5oWnJIVlpLZWFveEJiK0ZKVUZIYVBNRGVzM2FlZDk5?=
 =?utf-8?B?OEVzSXgwd3VxUFhlSmVaT1p6T0FKb2lYQlRHaitIa29rRHlwSzhkL2gzZUxH?=
 =?utf-8?B?cXZlaGV0OGw5UVNLWWxCZUYrbmlDcDlvKys1R3ZzZWNSRDJmMmhEYW00N09G?=
 =?utf-8?B?MGRvZFBsNWVGTlFUZTk2cXNxT1V1cnB2Q1d2b0tuNUtrbWllWGtPQTFyUzhN?=
 =?utf-8?B?VlZnUlczWGVpeG5iOC9oRjBiQWpZc2Z1NDRZN0c1YkNINkJpQmVVUlNPd3l1?=
 =?utf-8?B?eFd2WDlqQzZ2UnREbGE4cDdYVEUzV2tDZUtRamdvQ0lyYURSeTNqbE1FbjBX?=
 =?utf-8?B?OStaSHp2SWlvcnIwWVN1OUovWENKL0wzOE40VVdybzIyRmpQRm9vUTJ6bWg2?=
 =?utf-8?B?cHpmbkc4NnhLbWc1VHBWQmdQMWdweFRSMXc4NGZiais3RkFxbnBrRDZpeDdL?=
 =?utf-8?B?cjd2bVZaaUU0STVnY3lEQmozSnRpaUsrdVBsMUI3b2orNFJvNzhQaGo1OUcy?=
 =?utf-8?B?WW5ib0dtYlhoUVBUWVhKblY3WEQraFgvZUpOTUZPMTFDVWpGK2pOdWdqMWFE?=
 =?utf-8?B?SW5ibmJiay9hZ295ZjYyZ3ZpbmZwemhzdkliZUNjN0VNMCtIS3lqVXU4ZnFR?=
 =?utf-8?B?cEtDdmRRL2NPY0tBTEZGbFdjem01aUlpS1JZQmNWM0h4YnllWktxYVBtd3VD?=
 =?utf-8?B?QUw1azMrNkRmMXduYzltRG8zK1RHM0JteERHTmhwK0FvUmVMSDNPTGN2S2Nu?=
 =?utf-8?B?dDVaUWdNYjF0dnBKeEZNTUFzbklSa2pjcyt2bzZ0MVBNWWpOZHk1dzNVUk1Z?=
 =?utf-8?B?andDbW9uWjBZMEhtUXM3OW1USy9VOFRSK2FscmJCaVQ0SkVZeDhaR2VXQkFx?=
 =?utf-8?B?UklLd2d6V3p0MU0xcXBRZTFtUEhjK1dTRklGamY0eTZtR1o3ekNWZ2JySGg5?=
 =?utf-8?B?WDJ2MDNCTFB5YWZFMzR5Yk9zYkU1SFBZdWtGYkZNR0ZqY0pOK1VnNlhkQUh5?=
 =?utf-8?B?MUx2ZXNveEVZb09DdVRsMU1ucmdxR09OeVVHTXF2VVpxcUpBa1dYZmVJY05n?=
 =?utf-8?B?U1puRmd6RlV6M3BnUVQ2NjhwNnJiWEhFcFZQdUEwTVo1ZEttRElXOGJhaFBO?=
 =?utf-8?B?K3RHbnhNcWhBUFp6R3phZzlRUWJ5NzlCR2pQbHlFSDhXcFdJS0k0aktEVWRs?=
 =?utf-8?B?akQycWtQVnZMaFhjZHJVUkpGQkJrUngybWpudVhxSzIwNWVUb09xRU5tdnFN?=
 =?utf-8?B?ZXVGazRTVk1LUzdvNEZPQjBlWVkxUWp1ZWwxSFg3TjU5dWYxa1gzU1NJY0N2?=
 =?utf-8?B?ZGxEVUpyUzd4eFRGY1lXN1lYcEw3UFpFQ3lkcGFuZ2Zhc0NsU1FZVTFPSXpy?=
 =?utf-8?B?WW1vdkNnU1I1azhpeFRVc1lwTFFCOXI5bU4zY2dIeCtiMUhGYkMvZkFnQVgx?=
 =?utf-8?B?Z3VhK3dFSWtValh3ckZ2NDNPUmlweiswMjJNN2oxUTI3YWpBMnhJVlg1M3BC?=
 =?utf-8?B?eEtBUjZUL1prVG5qOGZaUFFhN1lDck5jek9iWm9MSnNpamRYODkrY0xSdkFP?=
 =?utf-8?B?VXVOenF4TFhPVEIwQXN4SE5ZT2RsQnNBRXVrR2RtQXo1L0RTUlllcGw4bHJU?=
 =?utf-8?Q?yzgY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 414e57d8-a6f5-42f4-a6f6-08dd6c99635a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 19:07:00.8522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c0i+SNqqFJJsSRJNTAb4jSknRzu/RnC24pB85SpzO6fXqDvaLzWC2aNqktX7WAt2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9606

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaW1laywgTWljaGFsIDxt
aWNoYWwuc2ltZWtAYW1kLmNvbT4NCj4gU2VudDogVHVlc2RheSwgTWFyY2ggMTgsIDIwMjUgMTow
NyBQTQ0KPiBUbzogTWlrZSBMb29pam1hbnMgPG1pa2UubG9vaWptYW5zQHRvcGljLm5sPjsgbGlu
dXgtdXNiQHZnZXIua2VybmVsLm9yZzsgUGFuZGV5LA0KPiBSYWRoZXkgU2h5YW0gPHJhZGhleS5z
aHlhbS5wYW5kZXlAYW1kLmNvbT4NCj4gQ2M6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxp
bnV4Zm91bmRhdGlvbi5vcmc+OyBUaGluaCBOZ3V5ZW4NCj4gPFRoaW5oLk5ndXllbkBzeW5vcHN5
cy5jb20+OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBr
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIHVzYjogZHdj
MzogeGlsaW54OiBQcmV2ZW50IHNwaWtlIGluIHJlc2V0IHNpZ25hbA0KPg0KPiArUmFkaGV5DQo+
DQo+IE9uIDMvMTgvMjUgMDc6NDQsIE1pa2UgTG9vaWptYW5zIHdyb3RlOg0KPiA+IFRoZSAicmVz
ZXQiIEdQSU8gY29udHJvbHMgdGhlIFJFU0VUIHNpZ25hbCB0byBhbiBleHRlcm5hbCwgdXN1YWxs
eQ0KPiA+IFVMUEkgUEhZLCBjaGlwLiBUaGUgb3JpZ2luYWwgY29kZSBwYXRoIGFjcXVpcmVzIHRo
ZSBzaWduYWwgaW4gTE9XDQo+ID4gc3RhdGUsIGFuZCB0aGVuIGltbWVkaWF0ZWx5IGFzc2VydHMg
aXQgSElHSCBhZ2FpbiwgaWYgdGhlIHJlc2V0IHNpZ25hbA0KPiA+IGRlZmF1bHRlZCB0byBhc3Nl
cnRlZCwgdGhlcmUnZCBiZSBhIHNob3J0ICJzcGlrZSIgYmVmb3JlIHRoZSByZXNldC4NCj4gPg0K
PiA+IEhlcmUgaXMgd2hhdCBoYXBwZW5zIGRlcGVuZGluZyBvbiB0aGUgcHJlLWV4aXN0aW5nIHN0
YXRlIG9mIHRoZSByZXNldA0KPiA+IHNpZ25hbDoNCj4gPiBSZXNldCAocHJldmlvdXNseSBhc3Nl
cnRlZCk6ICAgfn5+fF98fn5+fnxfX19fX19fDQo+ID4gUmVzZXQgKHByZXZpb3VzbHkgZGVhc3Nl
cnRlZCk6IF9fX19ffH5+fn58X19fX19fXw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXiBeICAgIF4NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IEEgQiAgICBDDQo+ID4NCj4gPiBBdCBwb2ludCBBLCB0aGUgbG93IGdvaW5nIHRyYW5zaXRpb24g
aXMgYmVjYXVzZSB0aGUgcmVzZXQgbGluZSBpcw0KPiA+IHJlcXVlc3RlZCB1c2luZyBHUElPRF9P
VVRfTE9XLiBJZiB0aGUgbGluZSBpcyBzdWNjZXNzZnVsbHkgcmVxdWVzdGVkLA0KPiA+IHRoZSBm
aXJzdCB0aGluZyB3ZSBkbyBpcyBzZXQgaXQgaGlnaCBfd2l0aG91dF8gYW55IGRlbGF5LiBUaGlz
IGlzDQo+ID4gcG9pbnQgQi4gU28sIGEgZ2xpdGNoIG9jY3VycyBiZXR3ZWVuIEEgYW5kIEIuDQo+
ID4NCj4gPiBSZXF1ZXN0aW5nIHRoZSBsaW5lIHVzaW5nIEdQSU9EX09VVF9ISUdIIGVsaW1pbmF0
ZXMgdGhlIEEgYW5kIEINCj4gPiB0cmFuc2l0aW9ucy4gSW5zdGVhZCB3ZSBnZXQ6DQo+ID4NCj4g
PiBSZXNldCAocHJldmlvdXNseSBhc3NlcnRlZCkgIDogfn5+fn5+fn5+fnxfX19fX18gUmVzZXQg
KHByZXZpb3VzbHkNCj4gPiBkZWFzc2VydGVkKTogX19fX3x+fn5+fnxfX19fX18NCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeICAgICBeDQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgQSAgICAgQw0KPiA+DQo+ID4gV2hlcmUgQSBhbmQgQyBh
cmUgdGhlIHBvaW50cyBkZXNjcmliZWQgYWJvdmUgaW4gdGhlIGNvZGUuIFBvaW50IEIgaGFzDQo+
ID4gYmVlbiBlbGltaW5hdGVkLg0KPiA+DQo+ID4gVGhlIGlzc3VlIHdhcyBmb3VuZCBkdXJpbmcg
Y29kZSBpbnNwZWN0aW9uLg0KPiA+DQo+ID4gQWxzbyByZW1vdmUgdGhlIGNyeXB0aWMgInRvZ2ds
ZSB1bHBpIC4uIiBjb21tZW50Lg0KPiA+DQo+ID4gRml4ZXM6IGNhMDViMzgyNTJkNyAoInVzYjog
ZHdjMzogeGlsaW54OiBBZGQgZ3Bpby1yZXNldCBzdXBwb3J0IikNCj4gPiBTaWduZWQtb2ZmLWJ5
OiBNaWtlIExvb2lqbWFucyA8bWlrZS5sb29pam1hbnNAdG9waWMubmw+DQoNClJldmlld2VkLWJ5
OiBSYWRoZXkgU2h5YW0gUGFuZGV5IDxyYWRoZXkuc2h5YW0ucGFuZGV5QGFtZC5jb20+DQpUaGFu
a3MuDQo+ID4gLS0tDQo+ID4NCj4gPiBDaGFuZ2VzIGluIHYyOg0KPiA+IEFkZCAiRml4ZXMiIHRh
Zw0KPiA+IFJlbW92ZSAidG9nZ2xlIHVscGkiIGNvbW1lbnQNCj4gPiBFeHRlbmQgY29tbWVudCB0
byBleHBsYWluIHdoYXQgaXMgaGFwcGVuaW5nIGluIGRldGFpbA0KPiA+DQo+ID4gICBkcml2ZXJz
L3VzYi9kd2MzL2R3YzMteGlsaW54LmMgfCA0ICstLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3VzYi9kd2MzL2R3YzMteGlsaW54LmMNCj4gPiBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy14
aWxpbnguYyBpbmRleCBhMzNhNDJiYTAyNDkuLjRjYTdmNjI0MGQwNw0KPiA+IDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy14aWxpbnguYw0KPiA+ICsrKyBiL2RyaXZlcnMv
dXNiL2R3YzMvZHdjMy14aWxpbnguYw0KPiA+IEBAIC0yMDcsMTUgKzIwNywxMyBAQCBzdGF0aWMg
aW50IGR3YzNfeGxueF9pbml0X3p5bnFtcChzdHJ1Y3QNCj4gPiBkd2MzX3hsbnggKnByaXZfZGF0
YSkNCj4gPg0KPiA+ICAgc2tpcF91c2IzX3BoeToNCj4gPiAgICAgLyogdWxwaSByZXNldCB2aWEg
Z3Bpby1tb2RlcGluIG9yIGdwaW8tZnJhbWV3b3JrIGRyaXZlciAqLw0KPiA+IC0gICByZXNldF9n
cGlvID0gZGV2bV9ncGlvZF9nZXRfb3B0aW9uYWwoZGV2LCAicmVzZXQiLCBHUElPRF9PVVRfTE9X
KTsNCj4gPiArICAgcmVzZXRfZ3BpbyA9IGRldm1fZ3Bpb2RfZ2V0X29wdGlvbmFsKGRldiwgInJl
c2V0IiwgR1BJT0RfT1VUX0hJR0gpOw0KPiA+ICAgICBpZiAoSVNfRVJSKHJlc2V0X2dwaW8pKSB7
DQo+ID4gICAgICAgICAgICAgcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJSKHJlc2V0
X2dwaW8pLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJGYWlsZWQgdG8g
cmVxdWVzdCByZXNldCBHUElPXG4iKTsNCj4gPiAgICAgfQ0KPiA+DQo+ID4gICAgIGlmIChyZXNl
dF9ncGlvKSB7DQo+ID4gLSAgICAgICAgICAgLyogVG9nZ2xlIHVscGkgdG8gcmVzZXQgdGhlIHBo
eS4gKi8NCj4gPiAtICAgICAgICAgICBncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAocmVzZXRfZ3Bp
bywgMSk7DQo+ID4gICAgICAgICAgICAgdXNsZWVwX3JhbmdlKDUwMDAsIDEwMDAwKTsNCj4gPiAg
ICAgICAgICAgICBncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAocmVzZXRfZ3BpbywgMCk7DQo+ID4g
ICAgICAgICAgICAgdXNsZWVwX3JhbmdlKDUwMDAsIDEwMDAwKTsNCg0K

