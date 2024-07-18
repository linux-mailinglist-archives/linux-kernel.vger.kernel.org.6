Return-Path: <linux-kernel+bounces-256260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78518934B94
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 829D7B22539
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89518286D;
	Thu, 18 Jul 2024 10:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vc85SqjO"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B621EA74;
	Thu, 18 Jul 2024 10:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721298086; cv=fail; b=JqdIMQb7sm1A/cHjcjipV5XP3WVNGtpdp0VS22Txd/p3MkDeWyLQEbeWtnZ6GWAmyZ/QlXkWezPwF8hDjZq+nnDJFfSg7uvHYUMO2U8PRYEwzSnVpuw7XBS2IqCztng8+5bl46w0IJvGJGykPJKxPaBuFdFnYfGTkzWYRR7YiRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721298086; c=relaxed/simple;
	bh=ZQhr9LXDWbuFX70WRcKkviOUOMDuiEm4p3pVY4pJ1mQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=pPLckfs2ZTS947A6flByJNpKrdZb9oSdmpFm9IaN32bvQ6KT0YfXUF5U11v34MZ/HzUJMlvcT+/YByO8DisHr0wh1Mg7FqMroAsRmBrs4N4dzUVurdvbSNXyHWW7lHF6OGYDrJwxgL3XmxJvoFrl/f/5dYgaglfTmxHUI72gBIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vc85SqjO; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUe8SCVMqxsVZhsUOLnARjTo8QiReG3eTa4d8ZJWeCi3trq8E7ptky5ntI7Xm7m38sKBgboe/xS96J2Qx8AxakJyGwGTNGbz77nudyzwM+cweMbXQCJD8ehdpNFPyI/Geo7rIFmU6AvUbhDr1zK29K/GoZrYPylzeh6M12PZNCgXA6s79xpNeUuCF60C6yKq+ks5Dc1Xt2p3rBwPMHXDaHfKGQ5U9wkEpmKCXvdhwsGQwsPEBPHHaJd3fDQhSFSChwsFdNWP2iDKwFecWpbVDKRcP5iN4XzWeI7xeao9H9KTJoDDVP0wtbgM+ROtwS7AOEsZkqetlunwAlmlcVFsNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuTzJdV253oMgl3+QoI674MAQk71fsLw+aj/hUSt+Es=;
 b=DNRFles/EJm6QhYV1Nbugj1V5aRiU5xFsljUOXDV0tBxYOc2b9CTcNsO27XYJq0oKSaoLsIuSsg0dYDQ9iISCsZwfXkwSh+tWaJ4NYU7BLdioWqBlOFAmwt4O03TJcrDK74H0yUrHoDFjB3NY5nnsmHF1wevPv9FVbmcqtbjSX1a2THA0B2xbpzOvtb3qm7fb/VXXb6P36aZdZhAisNHgmgVvR7h12UdHtr/NqWBAW9OPS/FxizaPh552MIuXQgotSsHSKLkYfuX4B/HFweJqv4wXVpKk5lpk2Y8Flb5yFJLa6ekQMv9xt7apmdsG1RJU6AzkD1ftq5Poy15JOnPDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuTzJdV253oMgl3+QoI674MAQk71fsLw+aj/hUSt+Es=;
 b=Vc85SqjOjDHn1gWEsD1Dk95tuLIeoOc9zStJ54rz9RsZnLVLs6ZbJHENIWS4nt7a+jM1K2oB5iwAsDacLYIQ8w/uWWPnCAhRibaIsrdyEFaJGfHDLRtpoW+QurWjJhITCzJt8b7MWBRM+wOiiDOboMrJ0nuGL49k2LPA5B0D5ko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10)
 by CY8PR12MB7244.namprd12.prod.outlook.com (2603:10b6:930:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 10:21:21 +0000
Received: from CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753]) by CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753%3]) with mapi id 15.20.7762.030; Thu, 18 Jul 2024
 10:21:21 +0000
Subject: Re: [PATCH v2 1/8] hwmon/misc: amd-sbi: Move core sbrmi from hwmon to
 misc
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, arnd@arndb.de, naveenkrishna.chatradhi@amd.com
References: <20240717081027.2079549-1-akshay.gupta@amd.com>
 <20240717081027.2079549-2-akshay.gupta@amd.com>
 <6e8245d5-8c39-491e-9fd0-1be88be7b00a@roeck-us.net>
From: "Gupta, Akshay" <Akshay.Gupta@amd.com>
Message-ID: <e0bb9cea-fe65-f421-ecae-a0f6326c6417@amd.com>
Date: Thu, 18 Jul 2024 15:51:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <6e8245d5-8c39-491e-9fd0-1be88be7b00a@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN3PR01CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::13) To CH3PR12MB8909.namprd12.prod.outlook.com
 (2603:10b6:610:179::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8909:EE_|CY8PR12MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: 268300a1-cec7-497e-f890-08dca7135e3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rk1iNTNrU3drVUFpMWQ5QUJUam9QQUZtSDlydGtaNUpXdTc4WFpQY3NSSTlX?=
 =?utf-8?B?Z01KU3praVNia3dTRStSY3hJSVhPRDh6SnljUmppMXNrdmlzSEtVcTVzYnZR?=
 =?utf-8?B?TUhnNFBaV25FcW9GN0VQWnNCMlVFTGpra2NGSW1hbFdQMTc0enAxby9udGdz?=
 =?utf-8?B?M1E0UVAxMHUxcFVCZWZHZXZlZ2pTSFpQczVXYll4QU5qRVFicXU5Qk1Nek9O?=
 =?utf-8?B?bjV5UHBaMWYzSFNZeVk4cWZaT1plakEzalNweW1vZkYzMEV0TVphbGxiM2dX?=
 =?utf-8?B?RDJaaVZZSHN4d0lRNmVNWkh1L1dpcHlPTmVlNDNmZHBaUHkrSFlFS1BXUXdB?=
 =?utf-8?B?V0Z0VGh5MytoRGczOVEzV0t0N21FR0gvYlBhRGJDZU01a3lQWXRLNWcwd1o0?=
 =?utf-8?B?L3VqalpndGpIclBxa1U5QnhOUE1GbUxXb2p4WHVoWmtBVjg0bGxkWk1kVTJX?=
 =?utf-8?B?Uks2aGRmUjRyaE11MkZjMm5UQ05YYm5oY09vWVQ3VTl4UHFXSTQ4S3RDYmNI?=
 =?utf-8?B?a1hyVGxtZFZwUVRsQ0EyS1NhNVEyaXVIZU1meUlWUURuZkNPOGlFak5jU2cz?=
 =?utf-8?B?WlhFUnphREJFamlObzdReDNYVjJiVzB0WGhUUWQyOFpCZ3IyTW1aaUxiZ0hv?=
 =?utf-8?B?TVovOXh6K1RqU2VWQVl1amVGWHFVUTU5ck5tbGJZSWFsNGViRWEyRGtxWGhK?=
 =?utf-8?B?b3VXWHZYd0x4dXpTc2N2OE9PZU92L0krTmZOZ1RPdTRQV1ZESkRFVzg1d3JO?=
 =?utf-8?B?ZjlaS0FpNFl3dWgyM1hQdkc3bDFiUWVEY2pjK1BaQTFzZ3RPVHg1UTBhRDRl?=
 =?utf-8?B?aEwwZkZ5dEt5bGVDOHV0WjI4elFlUFhJNEs4MWlNME1DVkhjVGFocWhYdUVV?=
 =?utf-8?B?SXhROGszUGd1dENIOHRRTnBieHhIdXhmTTZXYlhwUGhMeWRiejc1NlY5dG5H?=
 =?utf-8?B?dWdDT0ZEUXhNdVRUKy8wVUtUOEVzQmZoeFpOWTZjVG5QWVJoUy9xbis2R2RL?=
 =?utf-8?B?Rml2dHlVSTBIUXdZRVU3VUxUL1JxY2FYTGxkQ2JGT1hlVlQxbUlwdVhZcVk2?=
 =?utf-8?B?MnRSSW5Cd2w4c0h1NlNOZmg2a25NZ085enpLMUtHQkNJMy9xU3ZNNld2Rmwv?=
 =?utf-8?B?R2hPTkhjRS9sb1dkY2hLOGpjbHVHOVZOLzRTbjBsakt5dVZUeHp3S05LOGtr?=
 =?utf-8?B?cjNhQXE2WCt6dlVXT2lEZm41M2tOZVZkSTZrUXljMHkzaXM1ayszVzM2Ujli?=
 =?utf-8?B?S3hBc29BRHRVTGdSUmROTnI0cUtoZHJoRFlLRy9Cb0lCNy91d1pycUd5UStv?=
 =?utf-8?B?MnlyQlhvQTltSlhqRkFlZjVaU2lHWWNJOW5zWFFUVVE1MXRHUVRZYTF6Q3dt?=
 =?utf-8?B?R2hrcDBtZUF4TGMrUVpZTUlWUHdGdHJ3eUZ2cFhkdG54SWczZ282eUw4S1ZL?=
 =?utf-8?B?Qlo4QVRjS1pwTmtxb0FDanMxL0tLcjBrenFMUDY0MHQ2Q2pNd2xDY1hBbkFl?=
 =?utf-8?B?akJ2Nnd4UVREOWxHS0lUb0xPQjQraEN5SlZQVUJZMG5FalRLc0xQbmJ0V1lJ?=
 =?utf-8?B?RmF5aFduemVpNnlOTnFITEkwMTNtczVsd29ydENKUE56NFg4eWdXNzJwME91?=
 =?utf-8?B?TG9LNWF0Wi9XSmNSTnU0Vzd6S21pUDBncTBYTEVzaXB0dU84eEJIVkdRY2JG?=
 =?utf-8?B?VWhKWDRaUWpJWjJFS2dTTGxNQUxjVHZsd0NaaGZVZU5rUy95aENuVUFDdm5x?=
 =?utf-8?B?cm16WmhhZElVdXVzYlZhajhOZHY2VkZpc0ovV1JPN3dZQmplOWlUdXM3MHdr?=
 =?utf-8?B?dHlaUVZabityVVVtbEF4dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8909.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekxMc29kZ0FFZEpRNVNBZm1ZYWJyVmFxSjZPRytIT2g2eDVLeHQvajNmQ0RP?=
 =?utf-8?B?QzFXN2hEVTJhbkZ6SlJGKzBJNThYQW52WFdlNzdPODlkTFlFcm9WVGxiNVJ2?=
 =?utf-8?B?M0ZwZk5wU2JrUmhkTTBQVGwrQUNHNWt5SEF3S1dudXVJVlJWSklsek1wKzJw?=
 =?utf-8?B?Q3dLRnA4cVJiS2Z0N25ieE9BbUVLbFZiOFNsNFpUa2Nsc3lhZ29QZURFWkJH?=
 =?utf-8?B?a1hOVElrbFJldlo5YWVhdXVXUEpjRjkwRUZjeFpzMmcwdkJUL1dySkNiTmpV?=
 =?utf-8?B?VHEvWWxnUkNKRWk5NHVxZFNLSW5FaXFPc243M2NEbnA4SDdmeXFUUmhadEt4?=
 =?utf-8?B?bDFXNGZ0R2ZoeWNoNllHTzJwK0FsUXdCYzl4SW5HL095RDE2SlhTYlVpVGcv?=
 =?utf-8?B?T3VxckM2N2VrUVI2Y3JsR1hPYS9wVHdIWW16alZ3RTM3NkM1NjRqMXh4YlN2?=
 =?utf-8?B?L0hsNGprOGdpODh4cGFtdUlPSDhzVVA3UFprOE14eXJtdXdFdSt4TEhERk9x?=
 =?utf-8?B?T2JjZ1pXYVc5Tk9Ddy9Bbmx6TFRZSkVlSStPazRub05XQjhMWldMa1EzSVRC?=
 =?utf-8?B?N2NZTTR6ZzMzZDd2c3BVSS9hRjhobmpMcWV6LzUvT3FBSjhuTVBuU1VQMFB2?=
 =?utf-8?B?MEMxb2VTRVVQeGhoK01TVWhZTmE3dmVqVit3RlhwV1FmcGovZmNCVjVqQ09T?=
 =?utf-8?B?dEh0VHowUzAvZERkV3EwTGxieW1lOHlNdEloRjdSSllacDl1THYrM010bDVX?=
 =?utf-8?B?VXJoa292N1hOeVd1eG9zSzZzSmd5UW9tWmxuaWxJbUVWbWFMaUExVklmWU9w?=
 =?utf-8?B?ZFk1NUFlbmJwR1FuRkFHY1g5UFhwR2VZaTJ4MXBYS0F4bVhydkZkYUJxakti?=
 =?utf-8?B?cHVPTng0OHA5b1ZPZWVEU1FudkJrVEZlL3phZHFqVlMrVGdFWUY1VXJoUExj?=
 =?utf-8?B?MzlxUnAzS0VSNytZd3RaYjZFM3NZRU15RzdXQ1ZCV2p5dmRPbEdrTDM1SW5o?=
 =?utf-8?B?enYvZ2hPcC9xeWdHRGI2S2htdUE5ODJ2b1F0ZDAvd1AvWVNodzFGSVhxRGl2?=
 =?utf-8?B?Y0MyM003TmRFZVBqR1ZXaFV5Zzc1dkFZRUllbnZldkZmbWJZUjJhZWFRU1Bw?=
 =?utf-8?B?RzhYcmcvaDdnM2xiUGNJWVNla0h6OCs0ZXRYd0dIVTNJSkp5d3Y2RkxFTndt?=
 =?utf-8?B?KzNVWUN1MmkxNmM1Sno3dG9mQjRhUkVsUE9zSUZjVHpkVVVOSEthV0IwNDRq?=
 =?utf-8?B?SGdHQ29sa2FXdjVNbnAzcXFaQlREMmlIeGRNQXZwZUZvbS9IL3FZd0d3QStB?=
 =?utf-8?B?VUo2SzBxNXRqVVBtdkw3QmZiZGRCRkNtS1BHOFljVGJSWFpPK2x4b0piU2ZJ?=
 =?utf-8?B?QnNFbi9Tam9Bam1ock84TnlMQzllRzFwdVlkZFJrRE5pMkFBeXcrTW8ycUpZ?=
 =?utf-8?B?MFdkSUJHRWpycU1SOERTT3RraytiT1NFbmNPRXkzMmRoYVNYSFZnN1RvdGg3?=
 =?utf-8?B?NlFxNmlkQXJaRUlXbmJpMjNLb2diNDZxWEFKdk55dXcxclVldUNIUmdROWJo?=
 =?utf-8?B?VzBCMVVNQytEN282SFlLRjlER3VSUmdVSnQyS0dGS0lqTGk4RFZQdGZXOHAx?=
 =?utf-8?B?K3F4OFRGdG0zSHgzMUFDRkZBMU9veVJRQUlYenY3RG1vS0FnblRDaTlEV3kz?=
 =?utf-8?B?SXBnV3orSXZiZzRUdFY3VGQyeDFaaHRyNHYyM3YwajExOEtyS0t0NjNLTysr?=
 =?utf-8?B?SGdvcnN1bUlackppZmFOaEFsMHZUWmpkUUNBeGc0cTRXbkF1TmZPbmNWUmFp?=
 =?utf-8?B?aWcrM0ZOR2FSU3JJdDVzZXFjVmhkdTRkcnVRTyt0QWx2Z1ppWVczQVpXUnRC?=
 =?utf-8?B?ZDc0UHkza1hsOFNUTHl1a3dzSHh2VWw4UWg2SEgzb0RYNUJ1VDBON3Y5WHIr?=
 =?utf-8?B?RGM1bWJVa0U2ekFaS3VSaUZ2WHZDTzBnd09LdnpxOEtpVDVYZnRCQ1pRU3dq?=
 =?utf-8?B?NkxmT0YvVXhrQlpNZmdKdzlYaDVrSDk4WU5YUEY1Mi94SDA2ZUhsK0pLYVM1?=
 =?utf-8?B?U1duRkNmVGd5Smh5cDhmSzVuL0pjbEJPR1FzOFRHb1d5bkxmc00yaW9CYjlQ?=
 =?utf-8?Q?ACVS/DWY0PtMi3nZ9Hk9D0wBC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 268300a1-cec7-497e-f890-08dca7135e3a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8909.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 10:21:21.0109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dkzJeg3MFMsEeAzjj5Z6l83uyqnS+Top/FNi67P/hHMaktHldqBwkWblZnZZS6qO9ptJJMpujtwvF4m4D4Xgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7244


On 7/17/2024 9:56 PM, Guenter Roeck wrote:
> Caution: This message originated from an External Source. Use proper 
> caution when opening attachments, clicking links, or responding.
>
>
> On 7/17/24 01:10, Akshay Gupta wrote:
>> This is done to support other functionality provided by the SBRMI, which
>> does not fit in the hwmon subsystem.
>>
>> - Move the SBRMI core functionality and I2C device probing part to misc.
>> - Move hwmon device sensor to misc as only power is reported through
>>    hwmon sensor.
>>
>
> I fail to see the logic here. Why would the supported sensor types
> be a reason or an argument for moving the hwmon code out of hwmon ?
>
> Guenter
>
After we move the probe of i2c device to misc, we were using 
platform_device_register_data()

API to probe the hwmon sensor. Greg did not like this idea of probing, 
previously I have explored mfd cells

approach but was not accepted by MFD maintainer, so we thought

of calling the devm_hwmon_device_register_with_info() in misc itself.

I will update the commit message to reflect the same.

Thanks,

Akshay


