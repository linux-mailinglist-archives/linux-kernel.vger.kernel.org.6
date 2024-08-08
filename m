Return-Path: <linux-kernel+bounces-279172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7DF94B9E8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502791F226D9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A88189BAB;
	Thu,  8 Aug 2024 09:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="7Wa7JwFv"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427E8183CCB;
	Thu,  8 Aug 2024 09:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723110229; cv=fail; b=S2NDTJVJq2K0csdl2MLzYjmvvuJJ4ctcwPIMRnE2EYrD25EGOSp1GIunREy4R1QJBYcWVLyVBKxXx/Y0tS8iAlNt+UJXOZ1VzE1bvUya6s/BiK5iAAj3XxH8s30G4NiSFnt8+WMexWDMca10N8EGENSJqus9CYqzqUjkdNQLKtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723110229; c=relaxed/simple;
	bh=6uvYqANwN1IMJgZ6JRVuMN+vP3okBuO+xtVQaU8Lw1E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sWPh+dYWwK3IeTM0f/QfQ+o7eqvilox624xPQGSuzUElNAazGEOJ6jbmLVQ5MVdj0BmNj9rT6PvSeFroJDigZ1gtlyVFyGligjIwUm37y1xIMHlo5CvI6piMeklya1wbCOOOU3qOLE2BidPoy00bKIY+QOFU0m57Khw/Lq+tUG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=7Wa7JwFv; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UdrSVJRa9rdWWl6X7QGXciDk2pykJvvml/QZxr76JmsXYU5zUrG/+EwFZllwN6HJumg+YqGKxLYgiZSfUXRJBqvfx7f4ZsewUuPG2DzdDfVY4va2yKSsMIbnSHH5qOrfIXc6Q6ThQSUrYLlc8s3nCrpFwH2mNCL8W3aE+ou6p1KvJNExEGzfBx3X2gDr/vFowmx5nQ044dJDt7xnweclo9jsPmhLmTsR6cOd3wS8cz37a9RQihAG2u2DXRkVGjIDey8GRrLeUqohG+vBq9MF+FIRobX1g3F/eVitMNYQgtUbfftN/fnhfXrrAHNjg89xdFr9iMw08VcUbth0sft3SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uvYqANwN1IMJgZ6JRVuMN+vP3okBuO+xtVQaU8Lw1E=;
 b=abgFMTSocYte0y3dx5nCMFlDhWidGYX9moQJpv2UGM+vQRVDbSdlk43LWmNA/tzqEXIMt/nGPvCya2i2d0113nEltseVaMAvbFAUeuTNLZBBZ08MKlt7RpSvd1KH7eRhnzxR77gzql1Lnm9MPjZdzuK5TNe0hOPxKdlMNrRMM78J8bqXqM2neQ845e5UeOFtJSqtf8iE0SKcR8AfbYOt/DCDi3ApA4R+XUEpMpdFUHP0eXZIt4rr2gvrsXf//7JFD9/Fx7011FxXmd9d+FPqAcYE2Hz+SC16jFVfWpwDuRLUVaJADMx/4SRsuUvI37GQdpbTTLa+eeWZcV3V4f+dqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uvYqANwN1IMJgZ6JRVuMN+vP3okBuO+xtVQaU8Lw1E=;
 b=7Wa7JwFvEZrP3PxMQBXAHx0Gj1QX3slm3XTR8d/93/hqjX2wVeRx9LFedWx0DF6OyROAWJYmMEYUldtrQ8pdaBJ/dpaNRANSA5kRWJqx1Y09wEwUC4DfEr6uFdaSDi1TPJ4cZXpGeeYyfPKJtCPBkpgYnu5Xuo1bPjmOzD8veUwalJnSzHvtAZCDoaRtQMfmpvt+QDQgpFGZU7Wcy+groWD3VTY4ZVDNp/jrv4PZFenj1w5cwhRIzXk949ZE/z8qvNTiB4Icy73o3bP7ExdGX1e1BMgqE1YVmpO4HWbPiLBkHPkvTpV4pvYz4cFYK3ZCk+xlEqql7CGI1b8wsH7K6w==
Received: from BN9PR11MB5289.namprd11.prod.outlook.com (2603:10b6:408:136::10)
 by MW4PR11MB5799.namprd11.prod.outlook.com (2603:10b6:303:181::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Thu, 8 Aug
 2024 09:43:43 +0000
Received: from BN9PR11MB5289.namprd11.prod.outlook.com
 ([fe80::93b4:c87a:32b4:c395]) by BN9PR11MB5289.namprd11.prod.outlook.com
 ([fe80::93b4:c87a:32b4:c395%3]) with mapi id 15.20.7828.029; Thu, 8 Aug 2024
 09:43:43 +0000
From: <Andrei.Simion@microchip.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/6] regulator: mcp16502: Add supplier for regulators
Thread-Topic: [PATCH 1/6] regulator: mcp16502: Add supplier for regulators
Thread-Index: AQHa5LhEn97L1tgXxECJyG0oBvR81bIT7XGAgAAYs4CAADuWgIAI470A
Date: Thu, 8 Aug 2024 09:43:43 +0000
Message-ID: <f078e908-b44b-4187-8e9d-a3d253cd352e@microchip.com>
References: <20240802084433.20958-1-andrei.simion@microchip.com>
 <20240802084433.20958-2-andrei.simion@microchip.com>
 <98f91a56-946c-4a40-b908-45f4c6c6d66e@sirena.org.uk>
 <f318439f-b520-4b86-99a7-eb9a2e47525f@microchip.com>
 <e0db4f2b-ce4f-4560-b586-1d8dbb75c7ff@sirena.org.uk>
In-Reply-To: <e0db4f2b-ce4f-4560-b586-1d8dbb75c7ff@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5289:EE_|MW4PR11MB5799:EE_
x-ms-office365-filtering-correlation-id: 8f0c4939-aa3f-48d4-2c78-08dcb78e977a
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?alB0Nm5lNVBjY0ZmUlZlVFRCaDFFZWs3YnlMNVE1MXhLOE53dzB1am5tbTBD?=
 =?utf-8?B?ZmIwT0paRVplWWQya2NNaUtPOG1OWTBBYTFGMkR4cVI2Qll1TXI5SmNuZ3Vl?=
 =?utf-8?B?OGtDbnRHVXlPaUZ5WjZoOTY1S284V1dmcGRqMFFyWEZnZDdab3RCTHdSQU1I?=
 =?utf-8?B?NHpNL2h1MG5wODg0a3I5a1FkSTgrU042VlY0VXRrYlFhMkVkMWJHMnNEdmNh?=
 =?utf-8?B?aEZFdXhIL29NTEx0cDB4cG1hdVdIRkxXWEVSVlFjT0FicEE4RFUycTJ1TE43?=
 =?utf-8?B?MzdNZ29Bc1BPNXdNOGY0ME9CcVkra2o2YWxNTGlNcG5VSXU2dE1DbHcvSWFE?=
 =?utf-8?B?eDVIb0l5elZUSzVmcnA5azhwN0oyNjZoVWx3MkdIcHlPcmkweXh2WmRRTEtr?=
 =?utf-8?B?bVovWXA5eXVEVUZiUmpsT1BUWHpjNTRPRnJRbTVzZklxWkZha21MNW1XdVJ2?=
 =?utf-8?B?NTY3N1dZTXpyZzNxNU5ldGh2VUQycDd6cTNNckVud1E2WE1ZM3NXQ3kzdzdG?=
 =?utf-8?B?cVhVbkRUdVZwWm9SQzdnWVNSd3REeWRoOVgwUE9zL3dwbGdvOHJUWTB0R0VF?=
 =?utf-8?B?VGJhSlN3Vjdwbk1QZVFGWUlFc3V2WW04YS9HZXcvSjdjUEZoVUNaSHZQUER3?=
 =?utf-8?B?dmNMVEt1MHFGYTNJMmgzZGFoUWJJNXE5bUVybnI4OFJrUEhmQXp2VjZyS0hz?=
 =?utf-8?B?cmFsakNQeC9zbFJrQzNOSE02UHFuaW81OHN6QytTRFNlQ3dsbE5OOU5CZUZG?=
 =?utf-8?B?bGFPUW9jS3dEdjB5U0lERDNhbFUydUN0ZEpZWWdWQWozT1RTYjRLVm1xTS9m?=
 =?utf-8?B?cVg1YTNOSFAvUU5ZM2o1TDMxMEdKWHRBOVRTSkJHYkd4WHFjZlJjOVJXelpl?=
 =?utf-8?B?cnFJVUtOMEg0Ym9Vcm16Skp1R3d6MkpNem9HUlQ2L0RUcWQwV3hUcWxPbzUy?=
 =?utf-8?B?dzRCMEk5Yjd1RDIxYlljSkwrRzNTTEQ4aSswZkxxeS9tbjl3RWtQL1hTQXZD?=
 =?utf-8?B?TnRCZjdRTUdUS0paZjMvNjJ0R3NRWUZhU2xvOW9DOXZlazlwREkwN0RtdWxn?=
 =?utf-8?B?b2dTZWpPLzhZMkZhMk9rLzc5Qk5mV0pTV1o4dW45c3NHcEVTS3VnejJIRG5K?=
 =?utf-8?B?RmFhNlVvYk5EaVk0MWtTRHNhRFRnWGN5NStHYkxvdFNnWWlqaFNBYWVFaTVZ?=
 =?utf-8?B?alhSdk96bEZ3MWs4bjJDNFBZR2dDNWtFZVljQ1JDcU0zTzNXTFhMNFBYRnNv?=
 =?utf-8?B?K2Nib0pBU3BDVk5aeitvdTF5TU9mUm9uV0VSbVV3dnZ5SitudUNOSXZoSWxE?=
 =?utf-8?B?OGg2bmFta1VHd1JnV056eWJhY092bVN3Q1dWN0V3ZDBDLzVJempPNXdxa3la?=
 =?utf-8?B?UWRObkFyTnowLzg4QzRzR3FrZk1zVnhtVmE5VTl6THFEVWF5Q3VRNkZoMm9J?=
 =?utf-8?B?RExMbXhUMEhXY0ZmelF0YTd4TXpBdEVPbzVFRU5mV2xROWs1YVV5M0d0UVE2?=
 =?utf-8?B?M0o2cnExaW9ocmFGZEJGc3NEd24vR1dGYUM2ZWZPOEI5Vy9EeVR4YXdna3dV?=
 =?utf-8?B?Uk4yRTBXQ0J3UXRCeWU3WXg0dTB1RjdpRjgrRnhKbWMyVGQxR1ZtclpoRWl4?=
 =?utf-8?B?RklHbSs4N1Q4ZUx2RysvcTdESzhDNnFUZUYwZ2lHbDVZTEd5U0htdmFjWlFZ?=
 =?utf-8?B?L0VIbEZIaUtDaGlRcnBxM20xRlo5cUEvM3dwZUlVc0crdFNuN0s4SUxxU2R3?=
 =?utf-8?B?ampMbVlXWG0yRnQwdm9jR3llWmkwdSthcFVVOW1MVEpLTGZmTit1bXg5TmFH?=
 =?utf-8?B?cmQ4SUJ6MkY1RmV5cVRBS3c1Y2haOFFZNnJOSlN3SGpVSDJCWFJMbHpTdEFE?=
 =?utf-8?B?TGVSRGNkR3FiVVJwcUZyVUNwbVZ5YXhXcDJSRFVmN0I1bkE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bXZZT0ZJc0drc0VIYjEwWUxkeDFFT3E2N3BMTEdUZk9HR0VVbWJab0NpME1U?=
 =?utf-8?B?cTRON1FnMXJVTHJmR1B0cXNkdGlkZEpRM0tOOXRvMTlIRGpsK1R0Q2ljQytG?=
 =?utf-8?B?RnJObVhmWVd6OVkyVnp0eTRJRkxPNklnRFlXNWVmbkxXYVBlNUsxMkJSVXhC?=
 =?utf-8?B?YktJNHZrNHV0OXdjWlhObHlmV3pzN3BOcUxNUy92Z0huVmRnczRlUXR0dTQy?=
 =?utf-8?B?eExtc3pET1Z0QjhmSG8wdTNCamg0WFdBNlh5NFJ0Y1piK0cwQmxpK01SOVhv?=
 =?utf-8?B?V0h3QjhGUlRvTkNHZ0tnS3d6b2ZPVERkOXBSNk9NTnV3TmxTRjNkRXFhV05m?=
 =?utf-8?B?bGh3MVdYckJZKy9waUp5RTN2MlpvblJ5TUNYYTd1K0hmSHk5M1RjN29pQjRl?=
 =?utf-8?B?MlNVaEJQWlF2M3MwTFA3T1Ftc3lUTTFFanVCTEZJMGp0VE9MZGR4eGFFOVNv?=
 =?utf-8?B?SG9UNVlzWkI2NGVJL3NNR0lHajErb2tEK0psWnQ3eGk3STdGR3d6RlpzMWhk?=
 =?utf-8?B?d0V2aGhEKzA2VVAveUlrY0lSOGVMYkowdHozL2lYbk14YkFBajZkNXdnaEtm?=
 =?utf-8?B?a1BvMnZFT2I4THB1N3h6Umt6ZHoyM0JlSUlHa1dYVDE1aldaRVJoa1luWUhP?=
 =?utf-8?B?NjRJZGVyZVZvbkpwME5UL29kNkQ0YXg2SDFrMkppRUlGdmE5TWhaWEMwQkpz?=
 =?utf-8?B?MS9vNDMvRjQveHluWnBnTVhlMGFHK09SRndsNFFDUFdVVUZGNTZ5RGZrVGhO?=
 =?utf-8?B?dzhNU1llUVYwWHdqbHJoc3lHeHUvR1RPSDd6TUsrczNmMUc0ZS9Uc0pIMXVQ?=
 =?utf-8?B?c2xvTGRnelBqUUQ3ZERVSzQxV2M4dlo4ZDJsME5qSTlaeGFuRXRnc1VTWlF6?=
 =?utf-8?B?QzArdkg0STd3NGFHVk9aYnZDczFodDNYM2cwMG9vRTVYWTZXbVQxWDBJTWRt?=
 =?utf-8?B?S1ZCU3YraW0xZVdqR0N4dUNGSlhkUjJ5VkVDOVd3QzZ3QUk4UXFhY0l6UERt?=
 =?utf-8?B?OE1ud0QzWWFkbE41OU8xSUFRNkExTlB3TEV4Q2FLNUx6bURnY2FjS3h3Vm9L?=
 =?utf-8?B?UlVQSkcwaEdDZXJ0dDhRdmhtSEx6N1ZoTFhCcW1BTWxaOGlyTkU0cjdLWlkv?=
 =?utf-8?B?QWRlRDQ4bHVkU1FsMlVJMEZEeVFjK2E1VzljZHkwS2w2Snp0bTY4UGgzUTN2?=
 =?utf-8?B?UFYyeDEwVTZKVHlrNy83QjdiNWRyaUdjZzNVZWE0aURVazFpTlN1cHV3SitT?=
 =?utf-8?B?QnVxMVQxWXVqNUgwWUwzTGx4TmhDRzc2NXNmQjV1RityN2Z0dkpEM3FqUnFk?=
 =?utf-8?B?Qkw0NitYZ2JwK1JWTlMyeSt2aC9PYzZ1R0x1RHRnQkFBeDJJM1BTdUtuZDFZ?=
 =?utf-8?B?YUlXYmRVWnJlUXRxQTNneFFhUUlMMi9pSGFpSW40SGM0ajFjRXVHRFVOa0Fh?=
 =?utf-8?B?WEpBVFlzeHN0bXVVSVJrVHhkZE94aVBVTW9vWFJ2akNLY2lyREx3ZkhVMjdu?=
 =?utf-8?B?ZDFIUFA4d1pvVG9GZSt0Tko5ZE9IVktBUmZqWmJURDV3anh4cHgvZFJjWGtF?=
 =?utf-8?B?L3RuM3Q5Z09oUThlUWZNa21nRXNiUVF0NVd0a2NDWi8wN0d3cW1UV0hKdkJ0?=
 =?utf-8?B?bm5pMzgvTFRJWnNtVHVhakV2VnN5aGs1Sm1mODEvR1N5cDZveEFEbDVuYUZa?=
 =?utf-8?B?MDZwRU5HZlhwTXMvYmxrUElZaEVOT3Rqd2lFdjdtV0FXUGFTYi9Na0hZSWdw?=
 =?utf-8?B?aHpiWDdudkFhemlmdUUrbVAwM3h2ZmtnOHZKUkhRWU5ld0lKbXdLR1NKTDNk?=
 =?utf-8?B?NGQwaXVFczdVUmJ5V1ZSWEhvby82Ukw2OG9MeURucjZQUjFrVHQxSVRnUjRY?=
 =?utf-8?B?Q0p5SUtXRVBTRHNvRzBrbWZ4WEdQRk41c0lUTXNaWHl6alhHYUdDVmVjTlU0?=
 =?utf-8?B?U0NielFNS0tSZ0hHcTNHVTNCUW1rY1NSYXNiU3BEYk96M0VUNllhNW00a052?=
 =?utf-8?B?VFRmWCtwQTQ3OHdGTzJkVlVKNmp2SjVnUjhXZFlVVGhxQnFZT2RzdUsxYmhY?=
 =?utf-8?B?Qlg3NkU1WkduSVFBZXFTZTdlMVlyVDAvOTk2cDRGbmUrQURiTS91QnFaZkJx?=
 =?utf-8?B?UVRlQ2xMRjBzZTk0Rlh4cG9NbmM3WTVWdHlGczhXWHZKV0Z3SGlIME5xSlla?=
 =?utf-8?B?YUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD2BFBAA1412CF42B402F3A9B4844432@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0c4939-aa3f-48d4-2c78-08dcb78e977a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 09:43:43.3939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xWDumY+M3Z2uOaByzi/4TQtwdfHMybHo+TkqS3w29BBdcY2zEA3JOigxI4+AfhzZygnG10Oo4Z3o5vSjMb1wR34Qv8dvx2xM0Umdg48K+lc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5799

T24gMDIuMDguMjAyNCAyMDo1OCwgTWFyayBCcm93biB3cm90ZToNCj4gDQo+IE9uIEZyaSwgQXVn
IDAyLCAyMDI0IGF0IDAyOjI1OjE1UE0gKzAwMDAsIEFuZHJlaS5TaW1pb25AbWljcm9jaGlwLmNv
bSB3cm90ZToNCj4gDQo+PiBJbiByZWd1bGF0b3IueWFtbCBleGlzdHMgLiotc3VwcGx5IFsxXSB3
aGljaCBwcmFjdGljYWxseSBhbGxvd3MgZXZlcnkNCj4+IGNoYXIgc2VxdWVuY2UgYmVmb3JlIC1z
dXBwbHkuIEluIHRoZSBiaW5kaW5nIG1pY3JvY2hpcCxtY3AxNjUwMi55YW1sIFsyXQ0KPj4gZWFj
aCBub2RlIHVuZGVyIHRoZSByZWd1bGF0b3JzIGluY2x1ZGVzIGFsbCB0aGUgcnVsZXMvZG9jdW1l
bnRhdGlvbg0KPj4gZnJvbSByZWd1bGF0b3IueWFtbCAsIHNvIEkgc3VwcG9zZWQgdGhhdCBpdCBp
cyB1bm5lY2Vzc2FyeSB0byBhZGQNCj4+IGluIHRoZSBiaW5kaW5nIG9mIHRob3NlIG5ldyBwcm9w
ZXJ0eS4NCj4+IFdoYXQgaXMgeW91ciBvcGluaW9uPyBMZXQgbWUga25vdyBhbnkgdGhvdWdodHMu
DQo+IFRoZSBzcGVjaWZpYyBuYW1lcyBmb3IgYSBnaXZlbiBkZXZpY2UgYXJlIHN1cHBvc2VkIHRv
IGJlIHNwZWNpZmllZCwNCj4gdGhlcmUncyBhIGJ1bmNoIG9mIGV4aXN0aW5nIGJpbmRpbmdzIHRo
YXQgYXBwZWFyIHRvIGRvIHRoDQoNCg0KT0ssIEkgdW5kZXJzdGFuZC4gVGhhbmsgeW91IGZvciB0
aGUgY2xhcmlmaWNhdGlvbi4NCkkgd2lsbCB1cGRhdGUgdGhlIGJpbmRpbmcgaW4gcGF0Y2ggc2V0
IFYyLg0KQWxzbywgSSB3aWxsIHVwZGF0ZSBhbGwgdGhlIGR0cyBhbmQgZHRzaSBmaWxlcw0KYWNj
b3JkaW5nIHRvIHRoZSBtb2RpZmljYXRpb24uDQoNCkJlc3QgcmVnYXJkcywNCkFuZHJlaSBTaW1p
b24NCg==

