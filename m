Return-Path: <linux-kernel+bounces-294620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4D695904D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2DA1C208D4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 22:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C481C68BB;
	Tue, 20 Aug 2024 22:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ZygTGB3u"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022129.outbound.protection.outlook.com [52.101.43.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58BE18C929
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 22:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724191966; cv=fail; b=Arx3v7p2msFaWLxsfiLKPax2B0YHk1o9Yfgo55vKzoHjfWYaUogtVDGZ1SSAvosw35uxKGZX86N6yF12KuO01K7yP3q4I4UXcG/1yLR4dK3tf/dwJNaoTN49jj39thppA51s5snC+f0n39I2lUw2dWCe3FIsVr3ofWB80K9jbcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724191966; c=relaxed/simple;
	bh=ImafF1xm2X2N5fUtt7Q4xIF8PTSdfCI1Cjei1c5yyJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OxTHcT5fjEiL84fM3kp7M1Ag5T4UYp4PqwAhSUBwiT/xvKrDGaMS0A4uHhi6RehMxu1p3kKN8VzxVZl970nLhcd4QDZZ8XFrI9Q+IA2wRpou5+xEIu7s/zRO82WwLkLuWq0C8vuzRczX/bxWbXPX8go6ETiPrsmPLMfXBAT+xjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ZygTGB3u; arc=fail smtp.client-ip=52.101.43.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5yM/SmJe6IK+h7HDCFXIxi+VgUX6YRyqeDvBENgf+P4OXoIpGy0+NL5WUo8ROS6nhYQwF9nMfuI03QVNJym0BzwQDkKONqwRNO9bS7L4C/ntwX03B6HcmHs3o3gF2TRf0lU37PumdHWpKZbGt1x7XXFK5KOJMWg/Uy5PmTcreBRXB1BknOBaSn05RPHz899/AahN/oZRgLmVSkGphZGDB2zjzQqc5iGP5D1leUjsBFx8drgn0I/j0TZ96gcwjUP/ZZElMHdPLhfGKE+Q8u8daetyrZC/CzuP6xAE504r5WR6IbTrYe0kD1fb1d3wHa7u6JRc6lW2yzDn1a2iR//TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFvWZRecnX0N1ux2PHO8A48Q6TMXZBkQUslN0TESaiY=;
 b=Kg+SSW6zH1eQAkDEq6mmcYQVFuh82qkHVsXn32Bswi5jMGdfqs5DQV435sQNcwatTpSNEzxWXRmzVP+HFbU4X5UP9o/RDqaWaDpQwqG3Nkl8dtkAXFtcdAPxw/4ZzTVb0K0MyAedlJpKjNYwHsAuOmH66ZsszosMe5pexftpJNKPLj9FaAdg60EmO4Y8QHl3Jq5a80OfiPpLIs5n/S24e9Jw0XewG0fpyxhnin6tqEABscIFSVFfDeBNRrL6p5EToO7U1ChFGWlgx7TxryxhQlArssxKx6JMVNzfuzhn+4AUxb6CGaJKKNB6lHJVWknozXjrUTHYoedb4m2+UqMv2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFvWZRecnX0N1ux2PHO8A48Q6TMXZBkQUslN0TESaiY=;
 b=ZygTGB3ucG1c9YB3j7BavIv4lPra2HxicUBFk8uCis736Mpeej5QUs0Y97Mm6o+VB+iKcVSj96Z4n30gl6scNjPuM53YjrQeSVz0jyIeLxCe6O9PbudMYbePtz/sNEBERkmg3pXK1y9J/s3PHAWxhJvS7M1aRjHmT7CJCn4fkz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 CYYPR01MB8601.prod.exchangelabs.com (2603:10b6:930:c5::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Tue, 20 Aug 2024 22:12:41 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%6]) with mapi id 15.20.7897.014; Tue, 20 Aug 2024
 22:12:41 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: james.clark@arm.com,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	leo.yan@linaro.org,
	ilkka@os.ampercomputing.com,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"steve.c.clevenger.ampere" <scclevenger@os.amperecomputing.com>
Subject: [PATCH 5/5] Adjust objdump start/end range per map pgoff parameter
Date: Tue, 20 Aug 2024 16:11:31 -0600
Message-Id: <b30454af62f9a06080c77c1bd0c7dd20782bfebd.1724104248.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1724104248.git.scclevenger@os.amperecomputing.com>
References: <cover.1724104248.git.scclevenger@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXP288CA0033.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::30) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|CYYPR01MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: ace6a6ac-e831-4fcd-b858-08dcc1653560
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEZqNUJ1Z2w4ZWRUWWpDU0F0VlR0NWRiSURzWTBhWkRsU3lRYWtha0NhUjdX?=
 =?utf-8?B?RTBhY1FKTE5LL0ZtU3I0SEpoNVY3dDh5bENGY0JPSWxITVZzbm9ZdFQrQjY2?=
 =?utf-8?B?QzJrSC9QK3JYQlZPbzFGNUp2VHpxN0xacG92Q01ZMll2aElaM1U2S2o4UG4z?=
 =?utf-8?B?S0kwcWhwVGVpTlo1enl2ZDJXUG1HYU4zdlJZZE1YeVgyRTlVNWZUYVF1RWlB?=
 =?utf-8?B?M2J2MXhxVnBVVG5DVGNaRDBtQzluYzFuWnlXeUM4TmdIWFBpT2JjcFJoc2Zr?=
 =?utf-8?B?aFFkWTh5bFd5cWtEOVRYS205eVpyK25yaFRZdFkrWkJ6aHZxamw5RWs2TjVa?=
 =?utf-8?B?ekRJUEJrcUFLN3kza3VJc0tXcDNoSFl5Z3hkOTF2WDZ3Mzc5N0x4UzhkeTkw?=
 =?utf-8?B?c3lWQm5HckY0Sk5VYmp4N3BhUjNiK1I4eG0xcHovcm9ieDNIcjd5VUFtQkd3?=
 =?utf-8?B?dWlVRW5XeW15UG1VNzd6Vncrek5MRDVmTjBTUzRPdTlnbmt2bjRQWHdEWkZZ?=
 =?utf-8?B?dUJuUkJwWUtNMUxoT2k0QnlSbEJIdTVobHRORkVXMEJVMXVmQ2R5T1dtdGZM?=
 =?utf-8?B?UzMxd1FTOXVESW95ZlR6RDQwV256S25KNnJCRDVhNGZIb2VQanJOd3BCS0JI?=
 =?utf-8?B?YnNpZ0ZvMExoS0NBS3E0a3F5MTh1YlpsUk5JVE5MSjRzamFOaE10ajBabHEx?=
 =?utf-8?B?YTNHaXMzRGdKU0VvOC9wMHNkcFVHdVpwdG9LQlJRK3RUMWFKV1R1Ym1LUUZD?=
 =?utf-8?B?bFo4M0VIWnY1SVUwZ2E3TEh0VHNOSzA3NnAvYnVDSkVGZmxCOEg1NUVhZEVh?=
 =?utf-8?B?UFdMazVrZHBvNTA2aUlESlF6WXh4NzdiU0J0VXpXdC9NM1FSSHQ0RTRObFJ3?=
 =?utf-8?B?UGN4M3NFSlNOaVR1bk9nbHl4LytkaEoyY1BvZGVNY2FCNjVHU1I4RGMyb09D?=
 =?utf-8?B?Tk5vRzgweHo2L2dkWHhrb3VVZEdsMklxYXVyOEFKRGVrZm0vTWFXMHRLbzhz?=
 =?utf-8?B?b214anRpTThObS9WTHNHWllFNVp1VjRvalVIZmxrZCtuUHZQT1RlWEt0M0N2?=
 =?utf-8?B?TWtibThZeTgrTWpucVpxWlFERlJ5TUlnWWxYQkF6VVdDZC9HMlVObUFyaW8r?=
 =?utf-8?B?cE80YmQ2czl2T2t1a0hwRjRxTGd4d2l5Wk1mdmFUVS9zSGRSSWtaLzQ3R2ZD?=
 =?utf-8?B?QWxHNVRqNFJadjBBNVZKQlJMTEw2d2tOdFhhQU1SV25oS0NIREdnOVBUTEds?=
 =?utf-8?B?RDJoY1dYdEZYZ1hCaEpNRFhicnJBODZNVCtKUXZHaHlBSHU5NHMrOXdBTzdi?=
 =?utf-8?B?Q2pHTFRyWHNBSmZhK0hMMXB0VTdudjRoM1l5NTkvTTVqSzAyajljd2pVaklJ?=
 =?utf-8?B?NXFCeWFPV0dlMmJ3THF1ZzlXNjFYaFp3U3ZRNjdVTzNtbVFzd0N0akdwZmV5?=
 =?utf-8?B?Qlo4bytBTTlPMHlVWkVGRDVpc25BeUZCMGdBZzdXelJmb3Q0RzVGU0RBTVlG?=
 =?utf-8?B?UzJaNklmTmhnYUdNK2FuVERUa0tqRkdnNStJNUhzWFgwc0FRNU9JM3dNZytV?=
 =?utf-8?B?bmZ5akxkTE1WdWlyUzIxQWIvbzVwL0ZheFh3VFIveW9vZDVzR2tBTTFNK1ZL?=
 =?utf-8?B?bTJVUUJoYVQwS3RpR2tudldWMG5heDVueWx3RFRHRXJyMnV3K0NIN090eG1V?=
 =?utf-8?B?ZEJtVkxkKzRNMFdUWTNZdnh1RkdvQzZJOEN1eDdWMFNheml4cnVhaGsxeHNX?=
 =?utf-8?B?ODZWV3lBVU1qN1FVaUFsa1pPYlh5WFl4aThxN0R1ZHN4Zi9hckV4eEp0eURY?=
 =?utf-8?B?ZVZHY2lsb2hSUmdTekM3ZGhFdnJUbVhHcUVIY0VRS21NMlNQb0wxMUYzekU5?=
 =?utf-8?B?Q3F5dlNEc1YrUUJpUjJUamFDa0pyZ1VKK2VpYy9sOGdiMHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnQzREVzMmh1RzJ1dDh2WkxweEhKaVBCWVNsTXM0ZHNRWUgrV216Wi9ZUEl0?=
 =?utf-8?B?clFSNzNoMFhVbXpIYm9KM25KenlqRlBwSHJZRVVTTGpQa3d1MUgra1VIaTJE?=
 =?utf-8?B?VDVXTFUxMm15WkhCbHIxSEdqaHZ1WnFtaURmaFBKMHB0Tm12ZWk1akVmc2w3?=
 =?utf-8?B?T3FIU0s4NzNFODlPekFXQURjNmlDbnNpa0IrR2xyVURhUnA4ZlJ1TCtaQ0VV?=
 =?utf-8?B?WjNNN3VQZVltR3hxNy9pUlhMdllTRmN0L3RFSEtwYVFHT0xiVzdLWkg1ZG1s?=
 =?utf-8?B?QkVHd3VqR1RGaDFTYmc5ZGJwcXZTWExiK1JkVWxkOFB1M1FBK1BLRkJKTzhq?=
 =?utf-8?B?My9FZXVJNjhTRXlBWkJiRHpwN2QxalVvaVRjYjNaZkl5SjVPcWhKRTVSd0NN?=
 =?utf-8?B?WTRvMGRnaWpOdlp5N2YwMm9YK2plU0o2Tmk5amhLTDFzSW02MjlBOGtSRVMy?=
 =?utf-8?B?b0cvRkpsT2RWaFFpa3VVbzlFWTlraS9ZS3htUGluTlZ2akVudVdha0lwOFF0?=
 =?utf-8?B?eUx6U3dlZDB0VnpSMzFLSVBqQjdVMXl3SGtiMGZHM3ZneDM4cTBtMi82NU9Y?=
 =?utf-8?B?cStnajE0VnlqZXRadGhtQWo3dDF5eDg0SWhaclIrY054T05uaW1GaUY4Rm9L?=
 =?utf-8?B?U01YTk1tZHZtWW5UcWpVemtCUnM5d2hBT0VTR205MkI5Q2QrSjJLV2Y0VlBR?=
 =?utf-8?B?a0ZqU1hubkgyVUpPb2ZxQ2JKK3BVdmowcm1LR1JrVWgvQmcrMDl5MmFueklr?=
 =?utf-8?B?Tmw3SjVXMTZ5UUk2YkpOT1Y5ejU4a0t2b0lSWndZQm1FMFhpZDVKVHplVmdy?=
 =?utf-8?B?cklnajIwbnBuY2FHUjlMWjcyY082dDlmenhTS3A5T0JqYVpQREdZV05rdmR4?=
 =?utf-8?B?Sm1jcFVLZ2tsaTIxKzEyNVVEb1pFMGFKR1VwY2Fsb3B1V09QMk5QOWdzY1Rm?=
 =?utf-8?B?V0RocjlXV0M1Zm1sR1YrTVVwOGk4SDNyS0ZrMWtKbzJ3WWl5cVpFSVR5d2Zt?=
 =?utf-8?B?RlRGNEQ4dERJREk2T24vWVpTNGZYUTlYSGsvSkI2MzBqSmNGUlo0QnFOcXU4?=
 =?utf-8?B?ODVxaVFSbloyZXZWdno3S3hSb0cvTVR5Y21KUzA0NXp1TWtzZDRHT1MvM2Rv?=
 =?utf-8?B?aEJDL0ZxdFpoRDFNbDJYRFZzbVNOWWgwV1IvUmFvWGZrTFEvWVpqZlNaZVhr?=
 =?utf-8?B?ZWM1amtZOENGOUh6bTViTll3RllqNzgyWnIrZXVKV2ZyUWs4TENYbE9rTjF6?=
 =?utf-8?B?MHk0eGtoNlFLRmg2QzdNY0ZHY21JQi9MN21LRUR3YW1saUFFSWcrQXBLdkdk?=
 =?utf-8?B?d3kxR2hSQURtS0YxalprbENtcGtDQ3ZIbmR4ckw0ZHdSTzFQdHNWeUxJMDdU?=
 =?utf-8?B?OHdXR2pZQVhrWWtocXhrdFVRNWhiWjc0UDErQ1ZUYjU1QVo5MXMxcXhUelY5?=
 =?utf-8?B?NFVuekpackRnSzl0R0Y0RE1FOVN2UXUzVDE4Ny9mWlEzNG1zWDYvdEdEMjdU?=
 =?utf-8?B?ZjB5UDEzYW5aWFVsaDBpN0twYUVSc0owWnV1Y0gxc21GOE1iNzV2ZjhSV3pC?=
 =?utf-8?B?aW1Lc2w0MjNQNno3OHBNOHVSZFZRTXJOejU3ZVVBdUVLUnZ5azhwUDlKanpX?=
 =?utf-8?B?eDZkT3ErNTRjU3BYLzZWU25GRGFCZm9NYlc4NkJjbjFwYWFBMzhVL1dZT0R3?=
 =?utf-8?B?NTlMTHg1TW5ueDZPa0xERGlzUGhRV1VMME93a0lLaVV6QmhYV0ViNTV4V0Zw?=
 =?utf-8?B?SlFkeUg5SGVTMjJQdThkNVcrSER1QVo1cDVwQzZ4VnBqVE80L3hIY2VIWG1D?=
 =?utf-8?B?NFhsdjV0NkhHMEZxQVZoemxBcGtneGE2RDdBVW1iYWVieUl1YU1tUTZFa0dt?=
 =?utf-8?B?WUNFUjFIZlg2c29scENoQndhWXo0MkE5N011WjVQNGw3Z1dsMDJyc3grN3ZD?=
 =?utf-8?B?bWRrcVRBSkRLVnU5cW1DSU8xRGQ5SG1jeDU0dkk0SmpLQ0pCUnNSMWlYVUMv?=
 =?utf-8?B?N0ZYTktJdU56QUJDNG9NbUt2cmw5V00vNXZ2UmlWRWNWWDZFMlg5Q0MxQk0v?=
 =?utf-8?B?WWFyUDNtN2ZPQnlSc3UzNnNCaE1DSjRrMm5OMzMwc0lWUHoxRldFdWlNaWln?=
 =?utf-8?B?U2F4NEYxWHYybEdGWXFrNXUxSWdYa25pWXFNdFRHTnJRUEFmVGpENzhkejdh?=
 =?utf-8?Q?ugpKe39QoUGAzt6EsY9mfAkSeVsGxOJ3VO4dlFzW72Ma?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace6a6ac-e831-4fcd-b858-08dcc1653560
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 22:12:41.3591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0QybbHsH4sbKeumO5acDM+BcGTJQjN7HXXyftPWg7Z8L3YanpVSF8JtIcAALqmjHXpzkacVqkwSFyxAUUZOK28hFiaES0OfwSGRE7uSLaWYFdHEIGvecQHYcgJWcciY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8601

From: "steve.c.clevenger.ampere" <scclevenger@os.amperecomputing.com>

Extract map_pgoff parameter from the dictionary, and adjust start/end
range passed to objdump based on the value.

The start_addr/stop_addr address checks are changed to print a warning
only if verbose == True. This script repeatedly sees a zero value passed
in for
      start_addr = cpu_data[str(cpu) + 'addr']

These zero values are not a new problem. The start_addr/stop_addr warning
clutters the instruction trace output, hence this change.

Signed-off-by: steve.c.clevenger.ampere <scclevenger@os.amperecomputing.com>
---
 .../perf/scripts/python/arm-cs-trace-disasm.py  | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index d973c2baed1c..6bf806078f9a 100755
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -187,6 +187,7 @@ def process_event(param_dict):
 	dso_start = get_optional(param_dict, "dso_map_start")
 	dso_end = get_optional(param_dict, "dso_map_end")
 	symbol = get_optional(param_dict, "symbol")
+	map_pgoff = get_optional(param_dict, "map_pgoff")
 
 	cpu = sample["cpu"]
 	ip = sample["ip"]
@@ -250,13 +251,25 @@ def process_event(param_dict):
 		return
 
 	if (start_addr < int(dso_start) or start_addr > int(dso_end)):
-		print("Start address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (start_addr, int(dso_start), int(dso_end), dso))
+		if (options.verbose == True):
+			print("Start address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (start_addr, int(dso_start), int(dso_end), dso))
 		return
 
 	if (stop_addr < int(dso_start) or stop_addr > int(dso_end)):
-		print("Stop address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
+		if (options.verbose == True):
+			print("Stop address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
 		return
 
+	if map_pgoff != None and map_pgoff != '[unknown]':
+		if (dso == "[kernel.kallsyms]"):
+			dso_vm_start = 0
+			map_pgoff = '[unknown]'
+		else:
+			dso_vm_start = int(dso_start)
+			start_addr += map_pgoff
+			stop_addr += map_pgoff
+			map_pgoff = '[unknown]'
+
 	if (options.objdump_name != None):
 		# It doesn't need to decrease virtual memory offset for disassembly
 		# for kernel dso and executable file dso, so in this case we set
-- 
2.25.1


