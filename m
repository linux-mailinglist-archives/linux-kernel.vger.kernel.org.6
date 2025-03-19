Return-Path: <linux-kernel+bounces-568059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 474B1A68DA6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C81A188B426
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2512566CF;
	Wed, 19 Mar 2025 13:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kWPfYOq4"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2054.outbound.protection.outlook.com [40.107.21.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFA517BA6
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 13:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742390347; cv=fail; b=j8XuVem+4OXSB2iMRUG9z5UMbzfRmB+Vlqy9QHxRdDZ+ut7iSbMRTJvX4Hv5Y3+Rw95wSJdLLaHNTllf0fbFi/fiKMXkwadX6E/QqAmRi3aqjTJ9YM8zDRREITuPKjLdmpfeHYmdjX1rA6wyZWZIa6jX24JL528RMidEX+fG8BQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742390347; c=relaxed/simple;
	bh=FXRQF+E9kGpguf7swZ1wq2g2gGGG3xZFlwref9mTOLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pEzkC/D5wirW4adWlAAFZrMuONX9MdNXy6ZDrWQMhYsmNvri4Azx5SlF01QNr1qE8dY1a6hbK6T5EkwWA4hLRGpiF9oUdYXsQCyNaZ01l11rXlMVQWSK/wnGUnIoswaff/aDzZaFj8ixGF7vkldOlhqfccLNCw0bV4Z7gkYS+H8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kWPfYOq4; arc=fail smtp.client-ip=40.107.21.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WysNIKCbmASNq/5tnT5wulpKtKEvRMeYbWsUHHwdnocTtRDrJ9kY/SVbGmZfpf/vE/vy0SVHgT+R1KpcTsJN/38fI5Gti42gA/DS8oQp7WOT12ZMIsei2STn14Un2rgOGDRIT4XlRqvsjaDM1aaMWpcpcA2JA8msoFd+0CbmYr63u3yfkoYEJ93FuXdY9S/xu0g7u+ahePPGRfvuTHLEOGOfLP1FOsFhxjhEUga8X7iodAFH/DaIeX7KIri6xo8Tkr7AqJ2VPUOG4ixnP4YlEfBpVCDY4e3yBN7QJPNGGQuKDlcF0eHW+MvQsT5B1leVZmDpPJ5baP8bH2VWbXsOqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzKD+LskatwvAfUukScPOk0bolwN+f9EvuYzpSi32jA=;
 b=Jsk9r6D8VcDw+2J4MqmGciKg6apHXagh9yJlwSck+s7U/vym3HLBlhPI7qc72PjzG2y0WITp2jDtdYfEy6DwS+rm4+4xXPN4GK4hAz0v+GXIHNitvIywok/LEDIGT0WOwsN7v5KZsE9ypW6oDxomx633ccBIr18a/K5sYa2bSotKaiJa99k6JXrI2nRcZjely1jlk/2TgttrBOF9Mg6Bz/Zm7tvcduyc62MmIKHY4PjOnR72tB1P6gVrSWLXxi2+2+fbJPqiOjTWbTJt/KmqjupPNYyNV+RJEeuQ29lZVGInAnwJXFbIIiSsPmsfakvFL4FNcFYeQvz9EqP+3l/ZOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzKD+LskatwvAfUukScPOk0bolwN+f9EvuYzpSi32jA=;
 b=kWPfYOq4WUQz1BJn9T/IK3MDHQ9Mtt1hIxEZFwlYeL5fq+r36sqDGSgnky18nIPqRPefwKsn6TkU7g2svvPThPQEODgpr7VR3Hhld0M8pKETdzaiIgm6CQq2mc6QGkOKXgYxnETcP7XC9yA4moAyOet+qNP2InmO6iYcA44FpMr2RLqesgyqkH3X4DSsGKErVT2c1FnX7oXadsEpE1a2xeGE8VtFnLiGlk4ol31iLNPkdx7u6iYm/tXVNGc9zFiOJfb1j/Djajzv46lGG02BvaPayxUa1gxxQaMODU7Ot/ARr21fFeJWTIP8q5U2FQW7t+yjr192eX0IkI65vy8XTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7144.eurprd04.prod.outlook.com (2603:10a6:20b:11b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 13:19:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 13:19:00 +0000
Date: Wed, 19 Mar 2025 09:18:52 -0400
From: Frank Li <Frank.li@nxp.com>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: master: svc: fix signed/unsigned mismatch in
 dynamic address assignment
Message-ID: <Z9rEPLAmxrqP61sz@lizhi-Precision-Tower-5810>
References: <20250317101516.19157-1-qasdev00@gmail.com>
 <Z9l3waI5EdrWmYC3@lizhi-Precision-Tower-5810>
 <Z9mGK0x8fsWvbTvo@qasdev.system>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9mGK0x8fsWvbTvo@qasdev.system>
X-ClientProxiedBy: PH8PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: 2010f076-85e5-4319-36dd-08dd66e89ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3NlSkJadlByazdyN2xrSVJHNGFYcERnV25iTUozeEo3b3NOYTZreTRVUzB3?=
 =?utf-8?B?MEo0QUZHeXR6b2RyTU5JTGZsRE43VHJwbHpmNlNlbG9KTjNLSTlvek5HMGZm?=
 =?utf-8?B?ODJQZ0wwZVJIWE1xb1drZHV0a1QrK0hUNXlLRzNZM2hMSUdWOGo0aUhZNzJa?=
 =?utf-8?B?OG5mby9HY0o5VjM3SVFGM2QramZLS1AzYm11ZWUyNE9ISkdPNUhHbTRjbDVG?=
 =?utf-8?B?U24rMFhZRTlRZlJlamdoVHc5SU14Z3ViczFuRmRaOUNCSmFKSnJqWHp3T1dy?=
 =?utf-8?B?VVhHRDVkc0ZKbTdKSldmbnRnWXRUbTVIemdJV3RYSFR1cmVDNFZqZDdRdm9r?=
 =?utf-8?B?dk5ieUdLVHRkYm1UdlN3OTNadldqOHlDdVZxY0JnUjV5VVRrWGRjZUsxTkp4?=
 =?utf-8?B?ZlQrTFNlV1hiRmtvU0V1MThYT2lHcG9IQlRaeWQ4UzQvQkZoaGZIM1cxUVJC?=
 =?utf-8?B?QWxpNmJsY0FuTitZQ1FzUGNBbU13TU05RG12alRObDFRVy9uYlF6R1ZHditR?=
 =?utf-8?B?TXFZTHVhTFhMYkszZFRZVGdQa3pETmJVK0VydlRjb3ZnSUMvN0g0SFBwckx1?=
 =?utf-8?B?VHA1TzZ1K0pXT0cxNDhwbUpwaDd1SjVTNTBFZmVqUGM2R3k1cHRXRTdwZ3hh?=
 =?utf-8?B?SUx0ZlIvcWhRUk5TdXhPc3ZQRWw3VEZhbHFmNDFGZm5VZjczekN1eE53TGZO?=
 =?utf-8?B?RWhmL2NBNE5BTFdmdy9ieU5zQzhXSFV0TUsxRHMwd0VFb2NTUytVSjBJUXBy?=
 =?utf-8?B?amNPaGpFMGJGSngvRGpET3RjMXh5eGhoVDhaVUkrWFBxMGp1NDNPMTBlWTRF?=
 =?utf-8?B?Ly9jWWViZ1JqbVowK1huYWNIVEdCVHhuTHVDUFBCajVIcHU4UnBiclJVV2VH?=
 =?utf-8?B?enkxVU1IUDJjbWFYd0JNRDhxUmpGazVCZzZaZy9xSGRscWdEeDZlazZIa24r?=
 =?utf-8?B?WHB5QmhKeUZkR05odDFFckxnanJFWTM5R20zUkR5cnBiMkwvOWswS0hRcVlR?=
 =?utf-8?B?b0ZUVGNPNjJ6NEVJbHRFQWNjMVhJYnNxYzBmSEp1alJObm1RVlpjMkVjV2xi?=
 =?utf-8?B?MjNhZlZadnl1V1k0K3IzTnRCTDRwSnUzN1JGZFRadEpZQitNcW85Y1NoK1ZC?=
 =?utf-8?B?TkgzU2JRcyt3Sm9ML2tHYVhmV1lnUEh2ZWovMzFhUFRCTG1kaWI0REVqRVdJ?=
 =?utf-8?B?V0NaMUwrM0FzUUR0bWZzOE9RUGZUdmI0a09odEViODJBV29VMDJTNkI4bkk4?=
 =?utf-8?B?bmhEUlIwdU1YQm1aMytZOG5ZV3IrVXRmeThyQVlBbHphYXdUbmJBcVU3aHNw?=
 =?utf-8?B?aHBtWmZ2U0hZWFJkeTVvc05XU0pjeU4za3VRT0dvcXpYaVMzMk9HYldBdzgv?=
 =?utf-8?B?S1I2RU5MZ1N2Wm1HWDBUeTBNYjhHeGN5M0ExMUp2QXlQWElHUll1c3YxVmJF?=
 =?utf-8?B?alZkdkgwdGh6TjlZVktqM1lobnhBZTUrNUxZaGlHQ3R2QS9oRUJNMVVISkFZ?=
 =?utf-8?B?TjNBVnBwY2VXOVVhTkowa0djNzN6TFZmNVc3QXR4UkY4c1VySjFoOEZDM3BK?=
 =?utf-8?B?d3JIMXhzUnJkVmpWTUpDMjhld2x4dlZhSzlYVnZsYmdZVmtBWEtIZ1hZTy9Z?=
 =?utf-8?B?SDZrOU9XM2F2enhuNmI5UVV2K1V5UHB1YmlEM09tWkoxQ0FNNzIzN0xJenlQ?=
 =?utf-8?B?Yk5lT2RQa1pWTHoyUlh2d01TRXJ3WTkzc1NHRE9hNHlNSVZQU1c2SmNBcS9o?=
 =?utf-8?B?NDF3eUlLVVRGRk5mZ0F3N2VVV3NJVm5oTThpemIrbnVTeFRvUjVKWDZVUldN?=
 =?utf-8?B?ZDRWSDV1ZmxPTGx4dGs5TUxhbUhwOXo5ZXd3RnduaE9ZR0t0cnFQbUtGa1RU?=
 =?utf-8?B?OVF3clJyblpwb1BHZUhCRXFDNWp3Q21qSjRydGFzTTRaQUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVZyajZzRW4rRXBoWW1xa1g2MElJNm8vMVUrRTN4R3lMbGV5RHoza2hsOXRY?=
 =?utf-8?B?NStPQUhhUlkybUxMNGxselRZeXFJNk9KWGZnTElyQzJ2QWJpU0hDazJPRGRO?=
 =?utf-8?B?RGNsTndpS3hoblVCcVBPV21FWUtnVVU5eUhkV1o1czFSdGVzdTJQOEtzLzY4?=
 =?utf-8?B?aC9udFZ6SVdGT1c3eDllZ1lFaElIMlFGUHQ1ZmRONTVBem5FTnZBeFFnRFdz?=
 =?utf-8?B?OXJSTkxrL2daamczSGRRdzREaG50Q2FicnpXSkFzYTZyb1ZvcnFtZFhueFMv?=
 =?utf-8?B?ZG9GNEJNTVVVVWhDdm9CRHVGVDlzTzI4b1h5SWtXQ1h2anY0d0k3am9ZWTFw?=
 =?utf-8?B?bzJaRHlsYUFMcDUvRzlUcU1kallBYjlodHNMVnV0ZDR5ZTU5Z2hQVm9HdFBw?=
 =?utf-8?B?VlBQeU1GaG9XemI4OHdQRTRqclFTOWtLWDVPSkZadTU4dlMxSmFQMEpERkZ0?=
 =?utf-8?B?OWdHR2dkbVJmVFB2Q3lCaVlNbmR1OEZWYnR1YUJyWDNsQVJXNkZ4bldkSFVW?=
 =?utf-8?B?cVZlNDFNSEJTUFlHQ0pFSklBbVpxT0FSTmQrc2R0WUl3T0ZwdXVDam9QVUx4?=
 =?utf-8?B?TTZSRmJvOUVVdTZUUzBUV28wTW1VemtrbXZabUJBdnhWWXdhUlZIdmJvYjZ2?=
 =?utf-8?B?a0UyVm1tVGpZUTFKUzJOa2NiM1RnQmlGMXlqRkZOMzU5VWVIOGFoV2w4NjRF?=
 =?utf-8?B?NFhtcloxU3dPZWs3akZaOG1mbDAyeGlCTjVUcXJOd0gxckFvbnRLWDJOSTY4?=
 =?utf-8?B?dWMrRy9oWGRPNXJEZ0lpZm15aWVJRzhDUXhvaGFFRXF2OVpReUN1cGNlTUxj?=
 =?utf-8?B?RFR2YTZTOVVodW5jK0Jib0FTMUNEcEROMThaNmJIL1VwS2FWZDZ5azMrbDc3?=
 =?utf-8?B?UXhtMmw0YnJSamJCWGJYdHhVUUduVUplQndxby9OVEpNajJsWEVtc0U1clpr?=
 =?utf-8?B?N2pPaDdjS1NhME1YSXVtdk5UaVAyVmkzU2JHTVVmMGM3cnJKT1VGb2hFbFRz?=
 =?utf-8?B?emxPRmxMVWV5ajQ5MlpDMUpiNXdFdjdaTVl3a3F3bDJEQzNUTEZJY3VCY3Vv?=
 =?utf-8?B?a2JqT2Z2ZTVQcmVmaVhpeTI4WWRSRzNqajMwTnRWdDdKYmFQSml6KzQrQS9V?=
 =?utf-8?B?SkY3Uzl2eGMzQ05YNlBiZ0lqZ0VZaVIyWm8yNE5UVFhlN3F4bExGZHdOZnVN?=
 =?utf-8?B?WXVpSnRHcHNsLy8vVEp3REF1WFY3VGFyVVF2c1dWQVlONEFDZDBCNmVMZEdS?=
 =?utf-8?B?RDhac09BaTNjQktOM1ZjN0dVR1lLaUt2V2w0WHRHRmhGa0dnaTQ1SFJwaFJG?=
 =?utf-8?B?ZzIrL1pQbVpZNmJySnlHMWY4TVhpcHd2ZzlJU1IxTGovM2cvSVpQVmlsRlcw?=
 =?utf-8?B?c0owWUFKMTlnR2xwTVp0VnBibFVyTHNTSHdhNGJRSjZBdDUvczZTSFcxZFZL?=
 =?utf-8?B?bGpMYTFJQnQxREN3N2l4OWl1UDZOQm5DTDlpcGZvdzJlVzVzdEZ2OS91eVM1?=
 =?utf-8?B?MXh2dEQrR3F4eTNnZnROTGlxNVNjTXAwRFhWdVJxd3Y1THlTWjJEdUR6R3Bo?=
 =?utf-8?B?L2ZJQ0IyNkc1WERrUU1uMFByZ2RrMk9kOVlKYWppRiszK1VaWDFIOUJXeEp6?=
 =?utf-8?B?LzA2M3BDelY1aXRQWnJ2SkFYZ29OVy9zNHg4bWhabkJPVjYrQ3J5YzRFVmZs?=
 =?utf-8?B?a1RHZWNuUS9uaVNaWHZJR0VkTjdwbGdwaDZRMDUxazZXejMzY011QzBUdk5p?=
 =?utf-8?B?Z2NkTzJLakI5alNyWFJ4WWo5Z1BwOUREcDlMU054UEF5bU9GdGlnaVVySG5j?=
 =?utf-8?B?Zm1MZUI2OHhIWjFFalY2d0NDaXNxOGFpc1VWYlZJamFwQXpEbko5UG1zanM1?=
 =?utf-8?B?RHRwelM0S0F5TE52MWtGN1ZZd21QbStYcTE2dk9zS3ZJeGd2aHdjRUxMYWwr?=
 =?utf-8?B?clB5cDY3d0R4djZhYjFoOGJ2ZWZKYWJUeTU1V1FaaXNwQVJPcVROTEQ3TXZD?=
 =?utf-8?B?Ylk5OWpETitwb3hiY2wvcDRpc2VSMk8rWlM0UEFFMEZQdWZmTVMxQWxqcXBW?=
 =?utf-8?B?dkNDTytqcEtOTGZneFFwZnNCWU02N29LcFBUTkFGblRLYmdMbk1DcEI3OXk1?=
 =?utf-8?Q?W4AA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2010f076-85e5-4319-36dd-08dd66e89ca5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 13:19:00.5645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YjhVureJMigUE5N2l+G/JkYqwUW9dYUhyYUrM9PjBerP0/+PMfVMSY1jM0cEj2fGw3ueDOp2FBva+GLJCvAOgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7144

On Tue, Mar 18, 2025 at 02:41:47PM +0000, Qasim Ijaz wrote:
> On Tue, Mar 18, 2025 at 09:40:17AM -0400, Frank Li wrote:
> > On Mon, Mar 17, 2025 at 10:15:16AM +0000, Qasim Ijaz wrote:
> > > svc_i3c_master_do_daa_locked() declares dyn_addr as an unsigned int
> > > however it initialises it with i3c_master_get_free_addr() which
> > > returns a signed int type and then attempts to check if dyn_addr is
> > > less than 0. Unsigned integers cannot be less than 0, so the check
> > > is essentially redundant. Furthermore i3c_master_get_free_addr()
> > > could return -ENOMEM which an unsigned int cannot store.
> > >
> > > Fix this by capturing the return value of i3c_master_get_free_addr()
> > > in a signed int ‘dyn_addr_ret’. If that value is negative, return
> > > an error. Otherwise, assign it to the unsigned int ‘dyn_addr’ once
> > > we know it’s valid.
> > >
> > > Fixes: 4008a74e0f9b ("i3c: master: svc: Fix npcm845 FIFO empty issue")
> > > Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> > > ---
> >
> > Thank you for your patch, but similar one was already applied
> > https://lore.kernel.org/linux-i3c/174225158210.1593610.10018812780731849409.b4-ty@bootlin.com/T/#m5120e1c362e7e57f4cab139a45410fde421c2f37
> >
>
> Hi Frank
>
> I sent a fix for this issue on the 9th March, which is before the patch
> you linked which was sent on the 10th March.

Yes, but perfer original owner to fix this type minor fix.

https://lore.kernel.org/linux-i3c/174129444617.1163689.11942276093411687387.b4-ty@bootlin.com/T/#t

Frank
>
> You can view my orignal patch here:
>
> https://lore.kernel.org/all/20250309164314.15039-1-qasdev00@gmail.com/
>
> Thanks
> Qasim
> > Frank
> > >  drivers/i3c/master/svc-i3c-master.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> > > index f22fb9e75142..eea08f00d7ce 100644
> > > --- a/drivers/i3c/master/svc-i3c-master.c
> > > +++ b/drivers/i3c/master/svc-i3c-master.c
> > > @@ -998,9 +998,10 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
> > >  			 * filling within a few hundred nanoseconds, which is significantly
> > >  			 * faster compared to the 64 SCL clock cycles.
> > >  			 */
> > > -			dyn_addr = i3c_master_get_free_addr(&master->base, last_addr + 1);
> > > -			if (dyn_addr < 0)
> > > +			int dyn_addr_ret = i3c_master_get_free_addr(&master->base, last_addr + 1);
> > > +			if (dyn_addr_ret < 0)
> > >  				return -ENOSPC;
> > > +			dyn_addr = dyn_addr_ret;
> > >
> > >  			writel(dyn_addr, master->regs + SVC_I3C_MWDATAB);
> > >
> > > --
> > > 2.39.5
> > >
>
> --
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c

