Return-Path: <linux-kernel+bounces-301188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D300095ED78
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89FB62842E4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5885146D6D;
	Mon, 26 Aug 2024 09:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="zWJ+fGCD"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2116.outbound.protection.outlook.com [40.107.22.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C61146A6B;
	Mon, 26 Aug 2024 09:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724665021; cv=fail; b=qrUk7C2KlSMFI5x9KVRNFd7tSaYd1BCeOu6Z/wfvCBKeDM5c2LmkefqaHqct5RbU//H51vM5+AqIger4BBxZ+lZJ9JJTN/+AyJtYfL0GGDJWUUIrt33IfisYQzMm1VEtAZ1zAt/1MGv8kUj4SzPZY2Ty9pDe7ilqnV40M/oE+J0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724665021; c=relaxed/simple;
	bh=Xk1clGUXVrmwgz6BJMOsSZgEkr4mqHbqE+TfOKEAiAc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sBOnhaG4N4Hkzg0iQE+uNXoMSl27vMFbpLb3q9lTKSpqdtwheIl8i7iNi14UwQnkU5hAQBI+cEkLV40YSFGG0+umxeJhn9hR/uP4Fuqd8ZrJwy7gLdtBkWG6xq6ZByv/EXyMmN2+Sc1HDtRkTX1q4UfuKXs4BhTnWDomKJx14Ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=zWJ+fGCD; arc=fail smtp.client-ip=40.107.22.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwRQ3pBpK1tVLWNUJvVvm6P5EDEyZE0ddjNrWyAM5oud6J5XsQNCHjCL2WgQmM1rF7cxthrBYtayiA3psfgAqKJjQoOm9CcWq+fe5DaASQjSsH7YpPgvjGmUWlND85kFuHQ3dipwle83pASR2/NV1AKXfewnhUjXwEJxeqsa40NtJmybaGxG1ueF6WPoJeTWYAsyj/Nc+7r10jRObIk5upvm0yG6QpanEHyMwXuKa3BCDO+CQUKdJzpS4SVUx4YJRECFK8y60eqJzh4JnyYUJ9ojw6XZ1Mp3N5ilxqtERO+EH6h+408GAyoalR18oF/u0yXlPDXqamBhA7kFGIXJYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPtg7SvKx4wYK9V0lQ83CA7upuKSLZPrtPKknafm6Hg=;
 b=qGoeCleiibPZaWsBZ/bBcWuHLLeNd7MOuCYe2gVEz6tpwrWA/aAtN0iPeyHloq5qhGX7q8S3Y4eG6/5IM/58Zmln5nwwiXrum+WoY4YqmJicP1pA8o0NTmyGZ2mRr4qgW4aWY2vswWwIKZB0o2FeuCckMvVaxUb7r4YNCDyTCXN31OeVFJO1htn+d293kxs4PVbJYvRX77/LrEn8k1SU1pW/GSM/0JvwMFHJp/IKZcMpaGWWBAuypoLJPF4T6CwpuC6pnnVN/m56Uctv8ldC3n+I1M86eckv9jw4u20NwIPQnRsecMAsr2ZjldrWGwwRcOeboWJI+GN6Ly+WHtQ3Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPtg7SvKx4wYK9V0lQ83CA7upuKSLZPrtPKknafm6Hg=;
 b=zWJ+fGCDuo6irx/hWK0WdIuJqgmPMBy3rjED7nqbu44S4HgUDMTNEaZ6ftQtgX7Hz1gDefC+VX9CKqcg91Mlt0IOITxINZzhKPEylDIOMvd6my0fcQgjY79Mk1Lz6qmV9Hrdu55TMb+nwScOyTY4t4TwrpHBFeKorzqbFd18et4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by GVXPR08MB11183.eurprd08.prod.outlook.com (2603:10a6:150:1fc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Mon, 26 Aug
 2024 09:36:54 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::4e72:c5d4:488e:f16d]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::4e72:c5d4:488e:f16d%4]) with mapi id 15.20.7918.012; Mon, 26 Aug 2024
 09:36:53 +0000
Message-ID: <acb0bcba-82de-4d67-9000-7c50a8456ff1@wolfvision.net>
Date: Mon, 26 Aug 2024 11:36:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: gadget: uvc: Add H264 frame format support
To: AKASH KUMAR <quic_akakum@quicinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Daniel Scally <dan.scally@ideasonboard.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Felipe Balbi
 <balbi@kernel.org>, Jack Pham <quic_jackp@quicinc.com>, kernel@quicinc.com,
 Wesley Cheng <quic_wcheng@quicinc.com>,
 Vijayavardhan Vennapusa <quic_vvreddy@quicinc.com>,
 Krishna Kurapati <quic_kriskura@quicinc.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240711082304.1363-1-quic_akakum@quicinc.com>
 <2024071126-napped-cobbler-4693@gregkh>
 <0f3fe4b4-5451-480e-a9e4-11ee921521b9@quicinc.com>
 <07d9e1f4-201f-47dc-b692-b1aa14511420@quicinc.com>
Content-Language: en-US
From: Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <07d9e1f4-201f-47dc-b692-b1aa14511420@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P194CA0034.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::23) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|GVXPR08MB11183:EE_
X-MS-Office365-Filtering-Correlation-Id: e4d4f26b-cbc1-462b-ecc0-08dcc5b29eba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGNZaHBYRWE5U004RWRoWjJvSmtlQmN5cWgyblJEczZTaExZczY3eTBiVk5w?=
 =?utf-8?B?eXZIT0tLV0xyTWxkMDBudnovWDVmaHhJSkNnM3krZVUwS2tSdG52a1VjczUy?=
 =?utf-8?B?NFQvUG56VFVucWZuKzBWeWNmamVTbENLdW1wTmNXaW5YcjZkREdiZ3FpR1FZ?=
 =?utf-8?B?YU1NTTVFYzFuRWJ4enJIRlpJNm9RejZMMkVVSkR4UCtyRHowY1VTNHpXMk1u?=
 =?utf-8?B?MW9ZNWZ3ZytNNmxsZzNmRW8zd2k0by9BRWxUcFR2YVl1OFhidFZ0UXc1eWx6?=
 =?utf-8?B?cEkzdGZQUWowYlhUL21jaG5NSG1HZDc3Vyt3bXNPQlJ3VTV4VXU3Y0kvTmN4?=
 =?utf-8?B?akxKU3JqUkxsMlBEemExak1aVzI0RnlyR3ZRajBkWGU2Z1dFS1lNNHNRd1c3?=
 =?utf-8?B?M0ZVK1ZOSGxhUldlVitSQkJrTHFKa1pUbk9XblpmWkZtK0lnTXNzUjM1TkxH?=
 =?utf-8?B?OWx0RVVMbDRKeGZ2SWgyYzhDeENhY2U2QjlIcTY3bXpTbStybmpFalREMWxs?=
 =?utf-8?B?ZFIxeG1abnVnenltbHBRSVduQnZITmR1dTZZRjVxNkhTRHg2bjc5M21QNGhy?=
 =?utf-8?B?MEozUmdLS20yRmg4N0hCaktrSmZUMzd0M3VlQUpvbk1RUzQyODg2ckI1eWVj?=
 =?utf-8?B?Y1Q3TllvWE9UUVJMeUErOFJDUlcxMmFDM3NlMmVockhqUk55OUF0NmNBQy9p?=
 =?utf-8?B?SVcwYStyc21rTkdMWW9aSkJMQzJreDNTZHV1OUFNV01RVnN3VlBEcm4rM1Yv?=
 =?utf-8?B?REZPUXNKbVkvZUlXOGtoeFBBekRxQ0R5YjR5MFNrdVpoM0ZCNXpnbVkrU25W?=
 =?utf-8?B?TzlHUytvYVpEK1JQd29nKzFMMkNKc1R4VTRScnpFQjlPSW1qdTlPOEFIUDY0?=
 =?utf-8?B?ZEJtQ3I2U1VrTHJIdTlGN2lyY2t3TVdGNmJUZ3lWcEo1a2c1a2czNGJyTDBM?=
 =?utf-8?B?QXh2b3Z3ditxRHpFSWZyMGVvano4Wkx6am1iM3FRRytJK042c1dhcjNMdU1I?=
 =?utf-8?B?UFVTUEVqWktsV1d0YzNlZWdJKzU4MlhKK1BUUTFNck5IRlRtTVNIUmNtaHFZ?=
 =?utf-8?B?MkZiNEFseFF5b3VwSithZllqQjh1Z0U1Vys2SUc5Q2hoQTlUVFFRRnRRaWRX?=
 =?utf-8?B?YVVzaXNQZTFRZGZ2TUJmUXVtb1ZUSldLb0M5OUh4OFZGaHNKUmtCZk8wTnZL?=
 =?utf-8?B?cmNEbVdBbDJQRUVRUkVNQWsxaE9zQmNlQVIvSWlBV3ZGS2cybVhDcjFwZmdQ?=
 =?utf-8?B?SjRCOFZUNXl6ZUhraTZCN3l3RU53THBpdVB6QTJWbm43Qnc3blpoNXoxUnEv?=
 =?utf-8?B?SFNlMldueUtnUlNEZ1FYUXlNbnRneDdrbTlGYUdyUnFtOEtPTjJHZ1lwd1ZX?=
 =?utf-8?B?bDRONWY4QmdUbGR1Zzk3Vnl3YTd0SVBiWkpsaHIxL1hGc2xVVXMxNk5SVW8v?=
 =?utf-8?B?elRlek9NN1g5L0ZFZnJYUWFoTzQ0amJmS3pZTGN0bzVTem9hc2hvSFFrVHhr?=
 =?utf-8?B?eXJaWTRHaVY2Q0RSaUdVYnNoMWZnMncxazN1TmxUZEh3SlVqbzRNa1RsTTlN?=
 =?utf-8?B?QWdTOStseVNjb0VOK3JYejEzbE5WWE9tSjVodDgyb1Y4RDh6RWtsQnB3cXph?=
 =?utf-8?B?RXhWUFIycWR1eEUrM0tXdi90R3RWZmlsRXdmd3VSdXUzVitOZUphMkgxTHVt?=
 =?utf-8?B?Q2dkODlaOElhY0NaNFBVUUhRK3kzWS9uRWg4QW1NYjhEYWErR0draUY4UWNo?=
 =?utf-8?B?cEptVTdpV3REbkxjcjlwRUE2QUZKanAwdGk5b2w2SDhGQUIrOWk0S3dJNm1E?=
 =?utf-8?B?VlJEdnVoN0p0US95Q0lYdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blhqVXJtaFd2OWlsZ3NVL3NlUitYRGNFMU91Vks5ZTl2NVYxZ3huUGRmOWha?=
 =?utf-8?B?UlQrT1lOUUtQd2dSclF1b0F2ZWpoMjJGR3g5ZytoQkZDSFlhTU1PcS9qUGhW?=
 =?utf-8?B?Z01iUUpRRkMvMTVxbmtTWnhoTDZpZmhzNVo0T3I1VTdEMzRPY2IvSEFidWsr?=
 =?utf-8?B?dlN6Z1ZBWGVNZG93OGNSdG4ycGxmYVhyVm11UzdZaXBTUTZJcm5US2JwMG5k?=
 =?utf-8?B?VjIvbHl5Vkw1RlpKaWNXcThpUG9MYXB1TDZlM1duZ2wwVFhQcGJvdWRHbVl2?=
 =?utf-8?B?U21EYmd4cWphMUJjRHBFY3Z2QXNQMWhyNVVuRTF4NElHUU8vZ0hFN0FXcFB1?=
 =?utf-8?B?blMvbFFlTW05bFFJT2JBS1B3OTNnbGoybmhxY05WR0YrZDA4K3Y0NlZqQ0VS?=
 =?utf-8?B?TlliU1IrZEd4Z3JicW50K0ltTHJpMXJwV3dVTUEydDFFaTA2NWRDRlZ4RVNo?=
 =?utf-8?B?bDdRMGZaVGsxSDhQUmQ3eU5OY0ZjeVVQQ1dPb1FrZGgxaVFTTWNtb0tSTU9G?=
 =?utf-8?B?UkJHaW1lWUhFd1Q2NXdmUTlvOWJ5QVFCSkRzR1p4V1FOdnBGYnY5bEIycTFL?=
 =?utf-8?B?RStwSUc0anhaMEMyWUM5cTZwSWRVeDBGR0NyMHRFOTEwZ05ndnZrcWs0d24y?=
 =?utf-8?B?NGxIQmpTQzhhTU02eUJMaVRSQW5Tb3UrSWY4dVk0dzBmUFk4c1pSUURBb2ta?=
 =?utf-8?B?eGxsUXdJVm1GdDB3a1RiaXdRMG5VNUUyN3gwRXVqTTJWMWVUQkFJSDRlSTBZ?=
 =?utf-8?B?NnhsVHFCUkZKZElQRHZ3bjltN0xpQWM1bWpVSXovTXZHOXEyaXoycmdmNFQr?=
 =?utf-8?B?cDdPRWVTV1c5YmpBVTFQbEtkM0cwN2NhZWlsY055c25aRWRpanpyTGM2UmtV?=
 =?utf-8?B?cHpKdVNZbFYwcTgvSHNwQ1Y0cEhkRGJzU1V5WFNIcVdkaFpFNlRBTWtFSkNx?=
 =?utf-8?B?c2wrSWNXNTlGVjdUOVh5Z2FsRVpURW5SVXRjTC9sZDVybEdZV2R5eFJyTVpx?=
 =?utf-8?B?NG5UMUp6eU9Ic0NGa1hNUVg2Z1ZKWXAyajgvVVhMeHFzNVYwOWJkemZyVml1?=
 =?utf-8?B?cWZQdFpzbzYrRzNXS3dPK1EyTUdkNmVMQ3pjMjdseDR4c3FHRVE2cVRhQkhD?=
 =?utf-8?B?WU4ycjE1dndGd2xBbkx6Z3RVUWY4dWp6MXA5UE96MGFaVGFKN2FYT2g0OEdO?=
 =?utf-8?B?MVpkMTNHelZVdGlhWklNTkdtUWRveXRNSDJnaU92Vys0REdOYkcyRTlUdWps?=
 =?utf-8?B?TW01bWRGOHNXUmVma1J4b2x3dEU4V2xFelFqTytWelg4TXlQT3c3WW9lRkZt?=
 =?utf-8?B?U3A0TVJ4MkNqYmdKdE5WM3pSNjBUWDVDT0ZlcHdJeWhZR1lyVzJNUksxelhv?=
 =?utf-8?B?TFo1cHo0cGtKMkpsWURTeThZYTJmZDNCN01lZlo2a3ppaHM4Ti90WUR0QTZz?=
 =?utf-8?B?M2Zwc2Y3Vkg3b0dUc2NZY3ljK1JTcWM5YTY4Vy93Zkh5SmdZWGtyWU1weGdm?=
 =?utf-8?B?WjJrQ3RicDRXWnlaT2VpNHNlVEVPRnpkOHdWbXE1MmFLMDFlZEhLNSsxeUtH?=
 =?utf-8?B?aFZvZTUrU0d2cUFIbHl5cDlFSlhQMEFVWTNVTmxSU0puendGVk9tQmpOUFZy?=
 =?utf-8?B?UUhsVDR5OXdGbmkrdmJ1R1EyRFRGbmRZbDFXRVdaV1g0TjN0djE2d2lFWDEy?=
 =?utf-8?B?cTRqV3N1WTE0Y25RdVMycHZLQ1l3S0pTODFENXdZdUVFdlg5dFZFUjhYY29T?=
 =?utf-8?B?VXkvaU95ajFBbGd3clV4WVdDUlZ5YXBDekhWQ1dPcU01SE9CTjF5cWQ2cGtG?=
 =?utf-8?B?UzRmSU5EcGlaOStNVTZUWWc1dG5laVAvRXQzS0RVem1tQ0R6cHdpNEgza1Ew?=
 =?utf-8?B?bTZNVU96T0xZa09NWkErMGRKTXozMW1RS3V0cHBleWRWU3pPZkFFM3pRZzhl?=
 =?utf-8?B?ZXpCU3hFQ2phTUIySi9aRFliYWxVaHdadG05MW82b2hJM3VENDRRMXhqdUxi?=
 =?utf-8?B?cXhkTVo0a1g4d3BGZFYzYzJyak5TZm9sNFg5bzVkZkxieks5dmp1ZkxSS0Jy?=
 =?utf-8?B?QU80ZUowUmZVT1U1MnBMRDZBSkxPYWp2dmdUVEhPVHFsMXpEbTdSY1Z0Y1lo?=
 =?utf-8?B?MFNvQnI3NE52UFA2Rnk5WVF1UjMvNjgwa1FndHJCUkRuZGRZYWY2M0JHZTdE?=
 =?utf-8?B?Mmc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d4f26b-cbc1-462b-ecc0-08dcc5b29eba
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 09:36:53.8766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 12MtUX0BOpshkHaQIjakpzKvRekG65/LptuaAFGK61NOzmD7NVvdW1WLnkn1dgsMJXec+mXFhfGmtps98KhIPgeiRTrumCHaTQ3oM+/GqqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11183

Hi Akash,

Thanks for your patches. Very interesting to see H.264 UVC gadget
support coming to life. May I ask how you tested your patches? What does
the user space stack on the gadget side look like? And what is the USB
host in your setup (OS, application, ...)?

On 8/1/24 08:15, AKASH KUMAR wrote:
> Hi Greg,Daniel,Laurent,
> 
> On 7/11/2024 3:13 PM, AKASH KUMAR wrote:
>>
>> On 7/11/2024 2:37 PM, Greg Kroah-Hartman wrote:
>>> On Thu, Jul 11, 2024 at 01:53:04PM +0530, Akash Kumar wrote:
>>>> Add support for framebased frame format which can be used to support>>>> multiple formats like H264 or H265 other than mjpeg and YUV frames.
>>>>
>>>> Framebased format is set to H264 by default, which can be updated to
>>>> other formats by updating the GUID through guid configfs attribute.
>>>> Using Different structures for all 3 formats as H264 has different
>>>> structure than mjpeg and uncompressed which will be paased to
>>>> frame make func based on active format instead of common frame
>>>> structure, have updated all apis in driver accordingly.
>>>> h264 is not recognized by hosts machine during enumeration
>>>> with common frame structure, so we need to pass h264 frame
>>>> structure separately.
>>>>
>>>> Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
>>>> ---
>>>>   .../ABI/testing/configfs-usb-gadget-uvc       |  88 ++-
>>>>   drivers/usb/gadget/function/uvc_configfs.c    | 570
>>>> +++++++++++++++---
>>>>   drivers/usb/gadget/function/uvc_configfs.h    |  34 +-
>>>>   drivers/usb/gadget/function/uvc_v4l2.c        |  80 ++-
>>>>   include/uapi/linux/usb/video.h                |  62 ++
>>>>   5 files changed, 714 insertions(+), 120 deletions(-)
>>>>
>>>> Changes for v2:
>>>> - Added H264 frame format Details in Documentation/ABI/
>>>>    and new configsfs attribute path for mjpeg and
>>>>    uncompresseed formats.
>>>>
>>>> diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uvc
>>>> b/Documentation/ABI/testing/configfs-usb-gadget-uvc
>>>> index 4feb692c4c1d..2580083cdcc5 100644
>>>> --- a/Documentation/ABI/testing/configfs-usb-gadget-uvc
>>>> +++ b/Documentation/ABI/testing/configfs-usb-gadget-uvc
>>>> @@ -224,13 +224,13 @@ Description:    Additional color matching
>>>> descriptors
>>>>                         white
>>>>           ========================
>>>> ======================================
>>>>   -What: /config/usb-gadget/gadget/functions/uvc.name/streaming/mjpeg
>>>> -Date:        Dec 2014
>>>> +What:
>>>> /config/usb-gadget/gadget/functions/uvc.name/streaming/mjpeg/name
>>> You are changing an existing api, how will all existing code handle
>>> this? Will it not break? What is ensuring that this will work as-is ok?
>>> I have modified all existing apis in kernel and have handled it and
>>> all existing formats
>> are working along with H264 in this change. Only user needs to change
>> configfs parameter
>> path according to updated path in documentation in Userspace.Currently
>> H264 doesn't work with same
>> structure and we need add it differently as a result these configfs
>> paths are getting updated.
>> Daniel and Laurent can you suggest if it ok?
>>>> -#define UVCG_FRAME_ATTR(cname, aname, bits) \
>>>> -static ssize_t uvcg_frame_##cname##_show(struct config_item *item,
>>>> char *page)\
>>>> +#define UVCG_FRAME_ATTR(cname, fname, bits) \
>>>> +static ssize_t uvcg_frame_##fname##_##cname##_show(struct
>>>> config_item *item, char *page)\
>>>>   {                                    \
>>>>       struct uvcg_frame *f = to_uvcg_frame(item);            \
>>>>       struct f_uvc_opts *opts;                    \
>>>> @@ -1936,14 +1941,14 @@ static ssize_t
>>>> uvcg_frame_##cname##_show(struct config_item *item, char *page)\
>>>>       opts = to_f_uvc_opts(opts_item);                \
>>>>                                       \
>>>>       mutex_lock(&opts->lock);                    \
>>>> -    result = sprintf(page, "%u\n", f->frame.cname);            \
>>>> +    result = scnprintf(page, PAGE_SIZE, "%u\n",
>>>> f->frame.fname.cname);\
>>> sysfs_emit() is made for this.
>>
>> Sure, will change.
>>
>>
> can you suggest how to support H264 format without changing userspace
> nodes,
> as H264 format structure is different from mjpeg and uncompressed format
> and
> using same structure show issue as host is not able to recognize H264
> format frames.
> 
> Thanks,
> Akash
> 

After only a quick look at the USB Video Payload H264 1.5 document, I
think there should be a folder
  /config/usb-gadget/gadget/functions/uvc.name/streaming/h264/
with the formats
  /config/usb-gadget/gadget/functions/uvc.name/streaming/h264/name
and the frames
  /config/usb-gadget/gadget/functions/uvc.name/streaming/h264/name/name
in analogy to the other payloads, namely mjpeg and uncompressed.
Naturally, the attributes will be different to the existing formats.

What exactly does not work with this approach?

Best regards,
Michael

