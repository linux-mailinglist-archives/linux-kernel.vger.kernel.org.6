Return-Path: <linux-kernel+bounces-258902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4E4938E1F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 13:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E7661C211B7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BF916CD3F;
	Mon, 22 Jul 2024 11:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="W0CanuZc"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3431417597;
	Mon, 22 Jul 2024 11:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721648295; cv=fail; b=eghOiWe3NumTbIa7fz5GgDpbNg9QvVlugxdO0QT9sjIDTF1lqfTyL5HslERtVbhKOxUCcbXLy1o1MQD6Z6q6DN4oLSypMDkdn2QZPD5mptJ+EyEWbfBBJ+T1OgG89tAJd2svH8EGdl0IGSdwatIDRcSloendrla6hYpLsGevYUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721648295; c=relaxed/simple;
	bh=HqkJCc79eAyPaDHbfc1LRdZMbUcxKxh1d+PIoi09f1g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aJjqGGBRNc6a2VpsPyW7JDD4aFlX4DsM4QJ/QeuGQl9xokpCki0whbQmIYhm/1B1sJNdtQpsDnYyZp6PJj3XxdXhR7hria+54FaGb9//Ey+zjXfscnGiII2fnwenAH9w4MSLLyLsYCoKO2ZE6LJpdDbuupS86b+xzEHclq753hQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=W0CanuZc; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46M8G3C9003625;
	Mon, 22 Jul 2024 04:37:43 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 40hkrwgj2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 04:37:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUzAEnRw8S/30Ysuf8TSGV6JC12pXwVH35yEITiL1EVz3jtzjo9YT3HV5Hu+1oYedPlVwqrQTLh5VLVfihEykqdD60mRK1Nh3XHzH2DZcoTs/EcbQzCrfKP0CtXsgHudwGLYBynyuI1UuPkbPQjbdXFsfvggV2FSmiqDeWt9vWZ2ob4keFH/vIQorSsJqKRReLqod5e7TRj6cSrLqEw/pG5fcu6447FFuoQAxnT+YKQSjfX3fukfnj/JLAThBASyzOec/DU5KhzfmbyYy+vqy1Ym/h8ZwMIMh5e+QCe1qJfHO4bY7fH5SifDpp+FTsftgDkIZ1URW/nznxCdtz82qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOgN5KCzN0lrzVR5u4+p4JNWr8F2SMKYHNeEnJtpgOs=;
 b=UtZYEMespIovjsgK1DCVbur8k1kfGzzx3Iv39F8A8rep/G/xJtnoj/g6Z6ZwKgA6Ti4AzHuTRgbvSa+9RbRlcNAbJY8O0lX2uDWf26A9zTNW77duJUvTll2sfbKBFSQxwQwRW0rN34fw0hhoOBno0SKEC/LfJKx0p4CqlvohelSg1OrOD1eWJ21HRM5p7O6yFu/o2UfvwjNYXs0iNrdryKNb85LozU52WGrgG3pjMYwXTVTYo2hJoxIDo4fKb1ovhfd7UU5OVkc6Sb8H+Zta0wtQtxfUkHmFt9Au2POESy3Oo2tjjkSGB4iBKmuXcVoXfAvkZJEvv8ZeiuNf3YgfUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOgN5KCzN0lrzVR5u4+p4JNWr8F2SMKYHNeEnJtpgOs=;
 b=W0CanuZchpc2xP93Sa96uL1fj3E1vcKrzkqjpsXqVjHOCkcZgpAxi6sI/yq5XcCXTJaoq8T/kSI9NrcjsZb1S5gL4r/TyHnoify23FDvY1Fn1oKq/az/qCvQqCK0HM7josmp0hSrkKQ9wbCcwaUxrhYckgrS/mJ4DOFhf66bUVk=
Received: from MW4PR18MB5084.namprd18.prod.outlook.com (2603:10b6:303:1a7::8)
 by SN7PR18MB5316.namprd18.prod.outlook.com (2603:10b6:806:2dd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 22 Jul
 2024 11:37:40 +0000
Received: from MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905]) by MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905%6]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 11:37:40 +0000
Message-ID: <35f28f0b-1014-4058-a073-96464a278a0a@marvell.com>
Date: Mon, 22 Jul 2024 17:07:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] [PATCH v6 5/5] firmware: imx: adds miscdev
To: Pankaj Gupta <pankaj.gupta@nxp.com>, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
References: <20240722-imx-se-if-v6-0-ee26a87b824a@nxp.com>
 <20240722-imx-se-if-v6-5-ee26a87b824a@nxp.com>
Content-Language: en-US
From: Amit Singh Tomar <amitsinght@marvell.com>
In-Reply-To: <20240722-imx-se-if-v6-5-ee26a87b824a@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0010.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::15) To MW4PR18MB5084.namprd18.prod.outlook.com
 (2603:10b6:303:1a7::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR18MB5084:EE_|SN7PR18MB5316:EE_
X-MS-Office365-Filtering-Correlation-Id: d9c7809d-5f7c-45a8-1239-08dcaa42b143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cndlcDA1Qm9zK3pnKzFFU0xMME9yUmtyZ3FaSVRiQ2JoVG9WUDg0YWFreFBi?=
 =?utf-8?B?d1l4UXduK01ndXVKSXpxUk1JSGF1RmFlazRaUVBlaE5KelA0ZWc4V0VqZURu?=
 =?utf-8?B?MHI5ZzJUYTVGbWtEYlBZbG5GZkFGSjVtOTNVdzQrYXRwVTZVcFdPV0QrR01M?=
 =?utf-8?B?WVd5bHJQV28wSGNiaDVKU0wzZTFuOFdiTWR3VEJsSDBiMVR6TmxtR3pDVVV5?=
 =?utf-8?B?ckRFVzVrbWk1bEpGeWVaUmU1dDNmMmwzTFdaSDVMVGx5WlQ2b1lmWWo1TFBC?=
 =?utf-8?B?Sk5qZXBiaUMrQm5WVDVYUFZjWUJCeDdCUjkremtqUE9zbVduRlZXT0hQRXFB?=
 =?utf-8?B?MTZaQy8rVkQzQm1BVFR6VklaSGIwNVpHNllZMG1TU1lmWlVBa1pQNmtKVWMw?=
 =?utf-8?B?cFFFVkdRUjVUYldrZ0s1N0RIcC9GdTVabXpJTFFkLzhTQ1AyemRoMjhwM0xu?=
 =?utf-8?B?dFVmS3BHbVJBMXZxQm0vZDF2MmRYdlRQaytlK0pWTDIwR3k2OWZiQjZWZk1P?=
 =?utf-8?B?elJ5UWpCVHF6eHNXTUs1ekRMMnF3VHBlQ1pLNWZHMng2TE1kdnVkaldmVDZ1?=
 =?utf-8?B?bkNFajdwVE8wNHhSSEQxWE9yNVo4SjZnS2VPTVZjeHhOdGhVR254cTJLeXdu?=
 =?utf-8?B?MmdtM1JCZC9FUW5rVks4K0h0MW81WWNIVFZIeU5VWmpBeGVwNzFIaVo0SFRi?=
 =?utf-8?B?ZDhvUWNzd3ptYS9ETXdyU2VyY21qVXhwNVp6TmxvM3ZobHN6cFlZMEYyZTZU?=
 =?utf-8?B?T0pOVGhFZHhFanNrNGpMa0M2MHJKY2kvYTR1K0x4RFI1ZC84ZDFnWUhGWXRs?=
 =?utf-8?B?eUZEK0dhWThtc2QvZ0w5NkxlbTVDK0huQmc3M2xKalJ4TjY3U1dNY2FRQ2RV?=
 =?utf-8?B?OVlZOVpWTHV2U1BMeEtVdHpxaEpyektGbHJVY0wvd2MxSTFGY2ZTY2FvUzlI?=
 =?utf-8?B?QWdGV3AwSEhua2hKV2JwWlhRMC9uZmVmTGQ1d2czNW1HUVNwUHlZNUVRWkNB?=
 =?utf-8?B?V2E5d3I2L3BRdVdQc2J0K3pvSnFYMVl5YUs2VEtneEpqSHUzMkloMDFocjBp?=
 =?utf-8?B?WGgvY2ppdTJRMFlYVkRwNmtpTzZjTC92bnFyQXBhZ1hNN01QUXE2cEZqQXJZ?=
 =?utf-8?B?WFNvVnBFTHFCREwrSEQyZlU1QWxjaVVwUm4weHNHMG1tcmJYbktMWVdIZjky?=
 =?utf-8?B?MUozTnh4ekp1QzdkVStwcnoyNWxRYW9FcXFjTTRPQkJHUERId3VsY0xydXRh?=
 =?utf-8?B?eHB6ZXRLYzJ2cmZ3U0FXU3FRSXRKcnA4MHd6dXJVQ2NpeW56aTBkNFFETkJz?=
 =?utf-8?B?aHphZGNuYjI5b2Z2MTBjR1NrQkVSYjdFUnRiMm9ZMjdTZC9iUW1rR2tpd1Nt?=
 =?utf-8?B?bDQ1RXFNRXVKazk2MExzLzJGeE5meU5rNm9wYnJad2NJR3ZmWGxOZzVpeXlK?=
 =?utf-8?B?cjdicTJISFNIcDB4ZzNMTWJIWU5RSkhiQlBRZUIvMlcxOW9rckJBUE0wcytR?=
 =?utf-8?B?Z2hXQzMvR3gyY1Vzd0ZnODcvdEhoMmxTM2xsTnkzcURIQm9VemJtQ2RlYTJs?=
 =?utf-8?B?bmFaaGNnMWxERjRsL3R5RzRnaXY2bmE1ZGNPQXJZZ1VwTVNwYk9xZ1FTUWFw?=
 =?utf-8?B?VVJ4Q0ZpZjFhWllFbFlBMTRIbTdrQ0RpNkFzb0o1UENZZVRBd09SWDk0S2JY?=
 =?utf-8?B?aVl6NEh1amN6OWJFdVVpNW1PeFRVbUtDTDFsSVp6UG41THVqV3hVMHpoU2Uz?=
 =?utf-8?B?Wm5YZVlXSDlkeTkwcGl5V3VkVm1sSUd3clVwNGx1cmlmNWVHSE5CVUVlM2Vu?=
 =?utf-8?Q?nGgvzDNoc1qDmgYQJGVR1+04eaoaKmjZ2UeZI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzFvR29NcTU0NnNZS054WkFvaGtJd0l1Z09za0VoVFhyd0lwVnIyWGJNTE5L?=
 =?utf-8?B?VjlMNDcvdE1pL29Uc1NVWmRPU3AwY2l6MThhN2lheVFmWmFuU2o4WnlxK2tU?=
 =?utf-8?B?cDBZV0pkdzdDM1dLOG11RDl0NnNsZ1ZnYXBWVjIxaVVCbkhhOU1RVTUrR0c5?=
 =?utf-8?B?NzhtVE0zZ2hFUHhsYmJOUzdtRHBZaWJLYXdUZ3FFTUhZWEhuaUc1WUpXNHg4?=
 =?utf-8?B?WWZUb29EK1hGSXdNTVRDV2tuL2YyeGVwWUlPZVRaUjhRYXZhblNvVnZtaEk3?=
 =?utf-8?B?SThFT2RhNEdYeVBKU01rSVlNUXhSdlN5OWVmNUQvR0doSGNRZTZJbDBmQkh5?=
 =?utf-8?B?Z2RzbTNoMURVTzA3ekVqcUFaQ3FSNDRTK1RDa3NPT0VFc1pURm9XRVpPd0E1?=
 =?utf-8?B?QnFxNThGL1VvNVM2cWlka3VOazhyT1ZuZ2lXbWxESFllb3Y4YXAwZ1RKWnRB?=
 =?utf-8?B?d3R1eFRQNjNRRmpRTjh4YzVZc0RGSStPM3V6UUtTUkQzUmVOa2txR2xHZ2FH?=
 =?utf-8?B?TUd0WElna1B2YU1hcXNGMGx4dG52Rjg1YXNGZSt1dFM0b0NHZklUakZGbmVQ?=
 =?utf-8?B?QjdSNmlKZlRsK05Na1BlWHQ0ODkvTGtuallaM3BvNFFJUE1wTlVQeVIxUThv?=
 =?utf-8?B?aVBGanMyaUdyL2tXOFJocURVeVdyL0pSb2xmNERDMTBneFJaVHBsZWhsRlFN?=
 =?utf-8?B?aFlJa01FeEk5NnpQaFBKYlF2eEl4SWdBM0RtbTl4aTZ1YnpQY1k2V0N5OHgr?=
 =?utf-8?B?S2loc3QrUU9tN2lhSDFxVmZNVjIzUy80MkNTdDg2SzdYZFp2aDBRUHJXVEkv?=
 =?utf-8?B?bXJSWUhSUkxadks2ZGd5NGcwdmhqbC9OSW9vQ2hrTG9xc09NaEdTV1UzWmRV?=
 =?utf-8?B?Y2VwaHFIZXkzOEpKSnQvYUxweGFDQ3Z0RW1uTFduWG0xbEVkNGFyVUduZGNt?=
 =?utf-8?B?bFJ5QmxSS2lBdHpJUWZ6ZEloenpIbU56RC9ORTNvK1JaS3duWjUxNEFxMGNw?=
 =?utf-8?B?Nno2bldrSU41ZTJ6aktCMDJqM2JwckdaVkt4WmQrKytUeGhqRmY3MFhHb1Rx?=
 =?utf-8?B?cWJQZnYrL3BDNE84aVJLZXRGYytvTWVrTS9xd1hnWXpZbTVLTUk1dFlxcXRR?=
 =?utf-8?B?OXEyeHBNNmY2bUZwVDNTaCtKcWJxdUJaQW9vUHIxaWNraFYwS05ITHE2NEtO?=
 =?utf-8?B?UGJwV09qT1o5NGRUUGd6L3NIZkRtN1h3YjNxZm5lWHVxRWVVUStOOTZtM3ZO?=
 =?utf-8?B?R2hXemRIWGxLbEgwOUQrcUE3ZU5FWk82cWtyVUdyQ2Rxb2RCM2M4MzVZMjlV?=
 =?utf-8?B?cVY1U2JwWXRzZzh2V3JFWU9rVjIwWXVvcGhDcG0rMklzY2tuWTRMRmsrV1FZ?=
 =?utf-8?B?OUtMS3BwUEpGN3ZWS1hzK3c3UE5zenFxWitlZHF1MFVTaHcvYTF3bitHUXF1?=
 =?utf-8?B?dGVDUGkrSmNyc1J1SXF4NHdSUlUvS0xpN1NZMlhEb1lQNUdpNjdCMWptb0dL?=
 =?utf-8?B?Vm8rM2FrWnZCL3lSL3d2Um5UU2xjSXpRMkFvRU1GKzF2WmhkUUxXNkxVYXVN?=
 =?utf-8?B?SlBEOHBqTGJpMjVHK1ZvWFErNE5YZmJsSTMvUGMwL3U1eG1aME0xOHI2WXFK?=
 =?utf-8?B?NE54em5tbW9idWVDZ0w3ZjhBL0JzWmlrekh0VXZVNFNiVnJLYXhuVWlXZXV4?=
 =?utf-8?B?UnJaSnc5a0ZSc0JTNkdMbmVkWTZCcmkxMmt2K0Vzb1BKakFNMHdqYUM5ODZ6?=
 =?utf-8?B?YzBqU3lLdm8ycXhZMkx0b21rRzZrOEc1cjdUdXBxalRRQWN2UGJSZkRWVVZj?=
 =?utf-8?B?L2F6a0xxTDdQbWpMcVlFWUMvSndqTzRSdnU0aE1LMzBEdzl2VnJQMFJiaDZ0?=
 =?utf-8?B?cFNVbGlRM1ZBeWlMN2ptdUNrTFIySFRTeVY3L0JMK2RiTmpJY2JpcVhRNjE1?=
 =?utf-8?B?dU11M1U2SDl0TDRVWmFncVFBSnMxcmJEQUdjb3Z6WmZuNHdRcFdwZ28zOXpp?=
 =?utf-8?B?cmYwT25nc0Naalo0WXNQZUdLZXpvRG4vanRpWjY3akZ5TTZjenpDNDhiYVJ3?=
 =?utf-8?B?dXVjRnVGdXEyTGtqSUIxNHVvdENZUXpRenVBbEFtN2x5Tm5RUUw1VmVXQmVM?=
 =?utf-8?Q?vA7UR65Qcoj0HeWCbNRxnc7kF?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c7809d-5f7c-45a8-1239-08dcaa42b143
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 11:37:40.1077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwBIUGxO/od/Ttj82Tps60poNM0BqoOkotJrHmnZTC3Lxs28QUdWE7MHD9PzzsPrAmfb+5Z05Ci6mSNJybdIWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB5316
X-Proofpoint-ORIG-GUID: iY1PwLnXFDQdFu9ZpK4WdWnwZVH7F8hk
X-Proofpoint-GUID: iY1PwLnXFDQdFu9ZpK4WdWnwZVH7F8hk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_06,2024-07-22_01,2024-05-17_01

Hi Pankaj,
> 
> Adds the driver for communication interface to secure-enclave,
> for exchanging messages with NXP secure enclave HW IP(s) like
> EdgeLock Enclave from:
> - User-Space Applications via character driver.
> 
> ABI documentation for the NXP secure-enclave driver.
> 
> User-space library using this driver:
> - i.MX Secure Enclave library:
>     -- URL:https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_nxp-2Dimx_imx-2Dsecure-2Denclave.git&d=DwICaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=hqz6ztDhob0jujItfaaf7PHhtqSHj4aoWie1-b4nAGXTUrSyBQtV9W-WqLaM_utz&s=C67hc24yMATzUglvGvywzpn0Efjurb6sOLm2V_9VpsI&e=  <https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_nxp-2Dimx_imx-2Dsecure-2Denclave.git&d=DwICaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=hqz6ztDhob0jujItfaaf7PHhtqSHj4aoWie1-b4nAGXTUrSyBQtV9W-WqLaM_utz&s=C67hc24yMATzUglvGvywzpn0Efjurb6sOLm2V_9VpsI&e=>,
> - i.MX Secure Middle-Ware:
>     -- URL:https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_nxp-2Dimx_imx-2Dsmw.git&d=DwICaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=hqz6ztDhob0jujItfaaf7PHhtqSHj4aoWie1-b4nAGXTUrSyBQtV9W-WqLaM_utz&s=NACAFfnEzGKFI7FlqdL4kxlt8PtxeXRorc3IWanqgtY&e=  <https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_nxp-2Dimx_imx-2Dsmw.git&d=DwICaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=hqz6ztDhob0jujItfaaf7PHhtqSHj4aoWie1-b4nAGXTUrSyBQtV9W-WqLaM_utz&s=NACAFfnEzGKFI7FlqdL4kxlt8PtxeXRorc3IWanqgtY&e=>
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>    Documentation/ABI/testing/se-cdev |  43 +++
>    drivers/firmware/imx/ele_common.c | 192 ++++++++++-
>    drivers/firmware/imx/ele_common.h |   4 +
>    drivers/firmware/imx/se_ctrl.c    | 677 ++++++++++++++++++++++++++++++++++++++
>    drivers/firmware/imx/se_ctrl.h    |  46 +++
>    include/uapi/linux/se_ioctl.h     |  94 ++++++
>    6 files changed, 1053 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/se-cdev b/Documentation/ABI/testing/se-cdev
> new file mode 100644
> index 000000000000..3451c909ccc4
> --- /dev/null
> +++ b/Documentation/ABI/testing/se-cdev
> @@ -0,0 +1,43 @@
> +What:		/dev/<se>_mu[0-9]+_ch[0-9]+
> +Date:		May 2024
> +KernelVersion:	6.8
> +Contact:	linux-imx@nxp.com, pankaj.gupta@nxp.com
> +Description:
> +		NXP offers multiple hardware IP(s) for secure enclaves like EdgeLock-
> +		Enclave(ELE), SECO. The character device file descriptors
> +		/dev/<se>_mu*_ch* are the interface between userspace NXP's secure-
> +		enclave shared library and the kernel driver.
> +
> +		The ioctl(2)-based ABI is defined and documented in
> +		[include]<linux/firmware/imx/ele_mu_ioctl.h>.
> +		ioctl(s) are used primarily for:
> +			- shared memory management
> +			- allocation of I/O buffers
> +			- getting mu info
> +			- setting a dev-ctx as receiver to receive all the commands from FW
> +			- getting SoC info
> +			- send command and receive command response
> +
> +		The following file operations are supported:
> +
> +		open(2)
> +		  Currently the only useful flags are O_RDWR.
> +
> +		read(2)
> +		  Every read() from the opened character device context is waiting on
> +		  wait_event_interruptible, that gets set by the registered mailbox callback
> +		  function, indicating a message received from the firmware on message-
> +		  unit.
> +
> +		write(2)
> +		  Every write() to the opened character device context needs to acquire
> +		  mailbox_lock before sending message on to the message unit.
> +
> +		close(2)
> +		  Stops and frees up the I/O contexts that were associated
> +		  with the file descriptor.
> +
> +Users:		https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_nxp-2Dimx_imx-2Dsecure-2Denclave.git&d=DwICaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=hqz6ztDhob0jujItfaaf7PHhtqSHj4aoWie1-b4nAGXTUrSyBQtV9W-WqLaM_utz&s=C67hc24yMATzUglvGvywzpn0Efjurb6sOLm2V_9VpsI&e=  <https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_nxp-2Dimx_imx-2Dsecure-2Denclave.git&d=DwICaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=hqz6ztDhob0jujItfaaf7PHhtqSHj4aoWie1-b4nAGXTUrSyBQtV9W-WqLaM_utz&s=C67hc24yMATzUglvGvywzpn0Efjurb6sOLm2V_9VpsI&e=>,
> +		https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_nxp-2Dimx_imx-2Dsmw.git&d=DwICaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=hqz6ztDhob0jujItfaaf7PHhtqSHj4aoWie1-b4nAGXTUrSyBQtV9W-WqLaM_utz&s=NACAFfnEzGKFI7FlqdL4kxlt8PtxeXRorc3IWanqgtY&e=  <https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_nxp-2Dimx_imx-2Dsmw.git&d=DwICaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=hqz6ztDhob0jujItfaaf7PHhtqSHj4aoWie1-b4nAGXTUrSyBQtV9W-WqLaM_utz&s=NACAFfnEzGKFI7FlqdL4kxlt8PtxeXRorc3IWanqgtY&e=>
> +		crypto/skcipher,
> +		drivers/nvmem/imx-ocotp-ele.c
> diff --git a/drivers/firmware/imx/ele_common.c b/drivers/firmware/imx/ele_common.c
> index 3a6584d6f6f2..8167ae201b83 100644
> --- a/drivers/firmware/imx/ele_common.c
> +++ b/drivers/firmware/imx/ele_common.c
> @@ -78,6 +78,149 @@ int ele_msg_send_rcv(struct se_if_priv *priv, void *tx_msg, void *rx_msg)
>    	return err;
>    }
>    
> +int ele_miscdev_msg_rcv(struct se_if_device_ctx *dev_ctx,
> +			void *rx_buf,
> +			int rx_buf_sz)
> +{
> +	struct se_msg_hdr *header;
> +	int err;
> +
> +	err = wait_event_interruptible(dev_ctx->wq, dev_ctx->pending_hdr != 0);
> +	if (err) {
> +		dev_err(dev_ctx->dev,
> +			"%s: Err[0x%x]:Interrupted by signal.\n",
> +			dev_ctx->miscdev.name, err);
> +		goto exit;
> +	}
> +
> +	header = (struct se_msg_hdr *) dev_ctx->temp_resp;
> +
> +	if (header->tag == dev_ctx->priv->rsp_tag) {
> +		if (dev_ctx->priv->waiting_rsp_dev && dev_ctx->priv->waiting_rsp_dev != dev_ctx) {
> +			dev_warn(dev_ctx->dev,
> +			"Dev-ctx waiting for response mismatch (%s != %s).\n",
> +			dev_ctx->miscdev.name, dev_ctx->priv->waiting_rsp_dev->miscdev.name);
> +			err = -EPERM;
> +			goto exit;
> +		}
> +	}
> +
> +	dev_dbg(dev_ctx->dev,
> +		"%s: %s %s\n",
> +		dev_ctx->miscdev.name,
> +		__func__,
> +		"message received, start transmit to user");
> +
> +	/*
> +	 * Check that the size passed as argument is larger than
> +	 * the one carried in the message.
> +	 *
> +	 * In case of US-command/response, the dev_ctx->temp_resp_size
> +	 * is set before sending the command.
> +	 *
> +	 * In case of NVM Slave-command/response, the dev_ctx->temp_resp_size
> +	 * is set after receing the message from mailbox.
> +	 */
> +	if (dev_ctx->temp_resp_size > rx_buf_sz) {
> +		dev_err(dev_ctx->dev,
> +			"%s: User buffer too small (%d < %d)\n",
> +			dev_ctx->miscdev.name,
> +			rx_buf_sz, dev_ctx->temp_resp_size);
> +		 dev_ctx->temp_resp_size = rx_buf_sz;
> +	}
> +
> +	/* We may need to copy the output data to user before
> +	 * delivering the completion message.
> +	 */
> +	err = se_dev_ctx_cpy_out_data(dev_ctx, true);
> +	if (err < 0)
> +		goto exit;
> +
> +	/* Copy data from the buffer */
> +	print_hex_dump_debug("to user ", DUMP_PREFIX_OFFSET, 4, 4,
> +			     dev_ctx->temp_resp, dev_ctx->temp_resp_size, false);
> +	if (copy_to_user(rx_buf, dev_ctx->temp_resp, dev_ctx->temp_resp_size)) {
> +		dev_err(dev_ctx->dev,
> +			"%s: Failed to copy to user\n",
> +			dev_ctx->miscdev.name);
> +		err = -EFAULT;
> +		goto exit;
> +	}
> +
> +	err = dev_ctx->temp_resp_size;
> +exit:
> +	if (err < 0)
> +		se_dev_ctx_cpy_out_data(dev_ctx, false);
> +
> +	/* free memory allocated on the shared buffers. */
> +	dev_ctx->secure_mem.pos = 0;
> +	dev_ctx->non_secure_mem.pos = 0;
> +
> +	dev_ctx->pending_hdr = 0;
> +	se_dev_ctx_shared_mem_cleanup(dev_ctx);
> +
> +	return err;
> +}
> +
> +int ele_miscdev_msg_send(struct se_if_device_ctx *dev_ctx,
> +			 void *tx_msg, int tx_msg_sz)
> +{
> +	struct se_if_priv *priv = dev_ctx->priv;
> +	struct se_msg_hdr *header;
> +	u32 size_to_send;
> +	int err;
> +
> +	header = (struct se_msg_hdr *) tx_msg;
> +
> +	/*
> +	 * Check that the size passed as argument matches the size
> +	 * carried in the message.
> +	 */
> +	size_to_send = header->size << 2;
> +
> +	if (size_to_send != tx_msg_sz) {
> +		err = -EINVAL;
> +		dev_err(priv->dev,
> +			"%s: User buf hdr(0x%x) sz mismatced with input-sz (%d != %d).\n",
> +			dev_ctx->miscdev.name, *(u32 *)header, size_to_send, tx_msg_sz);
> +		goto exit;
> +	}
> +
> +	/* Check the message is valid according to tags */
> +	if (header->tag == priv->rsp_tag) {
> +		/* Check the device context can send the command */
> +		if (dev_ctx != priv->cmd_receiver_dev) {
> +			dev_err(priv->dev,
> +				"%s: Channel not configured to send resp to FW.",
> +				dev_ctx->miscdev.name);
> +			err = -EPERM;
> +			goto exit;
> +		}
> +	} else if (header->tag == priv->cmd_tag) {
> +		if (priv->waiting_rsp_dev != dev_ctx) {
> +			dev_err(priv->dev,
> +				"%s: Channel not configured to send cmd to FW.",
> +				dev_ctx->miscdev.name);
> +			err = -EPERM;
> +			goto exit;
> +		}
> +		lockdep_assert_held(&priv->se_if_cmd_lock);
> +	} else {
> +		dev_err(priv->dev,
> +			"%s: The message does not have a valid TAG\n",
> +			dev_ctx->miscdev.name);
> +		err = -EINVAL;
> +		goto exit;
> +	}
> +	err = ele_msg_send(priv, tx_msg);
> +	if (err < 0)
> +		goto exit;
> +
> +	err = size_to_send;
> +exit:
> +	return err;
> +}
> +
>    static bool exception_for_size(struct se_if_priv *priv,
>    				struct se_msg_hdr *header)
>    {
> @@ -99,6 +242,7 @@ static bool exception_for_size(struct se_if_priv *priv,
>    void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
>    {
>    	struct device *dev = mbox_cl->dev;
> +	struct se_if_device_ctx *dev_ctx;
>    	struct se_if_priv *priv;
>    	struct se_msg_hdr *header;
>    	u32 rx_msg_sz;
> @@ -114,8 +258,50 @@ void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
>    	header = msg;
>    	rx_msg_sz = header->size << 2;
>    
> -	if (header->tag == priv->rsp_tag) {
> -		if (!priv->waiting_rsp_dev) {
> +	/* Incoming command: wake up the receiver if any. */
> +	if (header->tag == priv->cmd_tag) {
> +		dev_dbg(dev, "Selecting cmd receiver\n");
> +		dev_ctx = priv->cmd_receiver_dev;
> +		/* Pre-allocated buffer of MAX_NVM_MSG_LEN
> +		 * as the NVM command are initiated by FW.
> +		 * Size is revealed as part of this call function.
> +		 */
> +		if (rx_msg_sz > MAX_NVM_MSG_LEN) {
> +			dev_err(dev,
> +				"%s: Msg recvd hdr(0x%x) with greater[%d] than allocated buf-sz.\n",
> +				dev_ctx->miscdev.name,
> +				*(u32 *) header,
> +				rx_msg_sz);
> +		} else
> +			memcpy(dev_ctx->temp_resp, msg, rx_msg_sz);

It is categorically stated (in the Linux kernel coding style guide) that 
this rule does not apply if only one branch of a conditional statement 
consists of a single statement. In such cases, you should categorically 
use braces for both branches of the conditional statement:

if (condition) {
         do_this();
         do_that();
} else {
         otherwise();
}

Also, made a similar comment on the earlier version (v5) as well:
https://patchwork.kernel.org/project/imx/patch/20240712-imx-se-if-v5-4-66a79903a872@nxp.com/

Thanks
-Amit



