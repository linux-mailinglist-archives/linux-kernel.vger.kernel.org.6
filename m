Return-Path: <linux-kernel+bounces-216683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E16C90A2FB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 06:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D83C281CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 04:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC7716C6AF;
	Mon, 17 Jun 2024 04:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="D+4zxC5+"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2052.outbound.protection.outlook.com [40.107.117.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C11CC136
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 04:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718596934; cv=fail; b=qK8TAdv6Wzsiofh5b6Ggu0ELV22JsMrxU+6DhFKKTGYvMASChpxuN4qireJ1aJMM2ql9zQe7N4imjFWaqxL5UMAAdlvM37tVq633sSU5lbqnysLoi50mEVRrPwwd52lgus9M06lEBx+AWld4MY5R9fyntL2zCq/WbD8waDlT25M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718596934; c=relaxed/simple;
	bh=Ooc/KDG2TKgxzwd86cZO2MW1REab7qcpiMZWga5CSvI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AgOz73K2+Q+NLW4bI4DQh4mfNNtfN25X8IOCH1+4SUzAfMqFMKHcdVMxh6JmWYg9vKkdnE3k/vSn1H1JzNs9Brk7dTo6p/o53qBdmB9I6XWJeF8yjVpCe8+HLrvGeWnxwMRHGsOaiY2hWp4da7ceBJGwxE6Pk0R1f/35DfygIBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=D+4zxC5+; arc=fail smtp.client-ip=40.107.117.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cu33DeTlQ71+Cz0evRyGK/ZTIFXDZ7frlyWOFsrLDTZWpNweoMHgBpU9bF/7j66np7VIbZ11DoyTwVUfsv77SJoMCp5vidvRGSSaGDuwVC48WzgGc7ZJVj1UUWU3rUG4YjfQmFEpfbJQwdU39tGuEGrWk24hJcW/P14UGxKl6yy1x3JdRdIp5nUdXfxhj6JL/1K4hNJ/D3sER4Kd7c0j2htwB0iH7yYEWeYb8BRuuUzqkHpwL3y1eheDCIumm/HCcVz71ArQ6eiMpi8YrH18yDOU4rUuay+Wi994Urj9c7gu+RiK4Dq1uEy85pKnnl+Wt6MVULBXUd9u2F6JOfP8xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cy2BpcQdXDhTGYoFeDgfP1iV/N9T/bfo1Fh7gh32dRE=;
 b=O/duolwpmm0eY/HYhS0/zsAoRTKPwgim1jw6zUpKKwwjqETMoEOzhvw7LF/S2sqhbQzKObsNzSwQjARVctwAjr5BQlxUqT9jw+KajnElqKVO3gj/2hyDCYmRMLbnBF7QATnnwIvOYccE31kkhWglZcmHkZvn1IpQZFODMaEIsYbB46+S14nRVO3o4D2Lk/OMpajXwEWSRjvHnmWNqkMh5dMDnKOnAPdesDE6XrhRV4PjTyWJ7q/r7LYab8EYDNgrPF9tFR6XofF+MHmn0iA0MekrPuPKt6Qikz+zW1kaCKG31MDwcZKMKVrV+kCbO6D2r0LmYqdJhTKiIIHvM/3Agw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cy2BpcQdXDhTGYoFeDgfP1iV/N9T/bfo1Fh7gh32dRE=;
 b=D+4zxC5+5RR//O99sCym29GCl64q6WoiHQHn+NZwuVYH4M9mksPyY5rQViRguyV0WYd6bMa7mkcoS4rKJouAiYKgsod1s+KO2ElHTfQHLryFzKkyFtWwHW+FBM9C64iCqPFWbEgED1+oC7h5w68BMGg7Ctxf/62gud5nHtYZc/Y41GQXeVpFW+fl5AJzVP2Ekn+OLCdhtVjmomd0IrjUlqeF6iYPcEyIPdjaeFG3BPF3+v0BD7781qToB7IjL9TETxIOi20YHXf8UuIt104t3agNa6PHSQ6AEpiY1hKgl0raUPfjflfkWcb3GT7hQ2oy0SGSrDHzn+kMyPTmOeeTQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by SEZPR06MB6532.apcprd06.prod.outlook.com (2603:1096:101:185::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 04:02:08 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 04:02:07 +0000
Message-ID: <c46a07f5-f504-4c6f-af54-cfa00f987ce3@vivo.com>
Date: Mon, 17 Jun 2024 12:01:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] binder_alloc: Replace kcalloc with kvcalloc to
 mitigate OOM issues
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Christian Brauner <brauner@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com
References: <20240614040930.11119-1-liulei.rjpt@vivo.com>
 <ZmyOJJmA7h6sZ_8A@google.com>
From: Lei Liu <liulei.rjpt@vivo.com>
In-Reply-To: <ZmyOJJmA7h6sZ_8A@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0150.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::19) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|SEZPR06MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d632bfd-7d77-431f-066d-08dc8e824194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|52116011|376011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnFmeENNVzNuaWZjaHFhKzEyTzgxTXo1aSszN1ZZZWxLbVMyZm1rSjRCcFBa?=
 =?utf-8?B?a0lpeUFlMXNlQllkeTNPamRRcUo3UHQwM0tHQmdlWEE0RkRBVWsvMzZuVWtD?=
 =?utf-8?B?MkJSdTkzUUF4ZHpydzVmZHBVSEt4U1VqVXlESVBFKzJWdGRBWllsYUtoTXRN?=
 =?utf-8?B?R1pSSW9rSkhHckR0QWQvTS8rdGE0eWJPczc1TVJNbm1NUnY1RUpmZ0dRU2xT?=
 =?utf-8?B?NGorTUo3Y0QwZ2lDemwzU1ZOVkdkYWNQRmZZL2FqYXVnWXhwOUpGeXoyc1po?=
 =?utf-8?B?NS9mY1pjdFBHdjVQZTNGMzQrRkZvRnRpYzZjcWYzOWo1NDZLaHRtZVdZQ21t?=
 =?utf-8?B?WWpVZEY3bENub25KRG9nYWQ3T3ZTWmZIWDZWbXFIcEJhczNmNUdHOGQ1SG5Q?=
 =?utf-8?B?YVFjd1g3WHNlcDE0U0VxZStJcnNuRy9yZ1kyR3c4a1JmQlQ5ZmgrczIvQW5j?=
 =?utf-8?B?WWIxUXFaMWx4L01aVjYwOUpFVVk1V0U5elJFQStUd0JyVVhtMHl4VnAwMVRk?=
 =?utf-8?B?cmRqbXJKREtkci96aHpZQ3FINGZsdTBoa1lpSFdIdW5Ua1BZamRVN0QzS2M4?=
 =?utf-8?B?TjdVd1U1cXU5OUxQRU1UK2c3QVBqTG5SYkhueTVTSGYrRzRjdjhheHhsM0RG?=
 =?utf-8?B?dmZKTnpaN2ZoVDlPN0ZmT0kwT0NZMU5uNVhQa20yWnBQbjNVdG04NStXcnVX?=
 =?utf-8?B?OG9ZOEVCT0V0UEo0Z1NTdW5BdU5WRHRVZExBWElsTnd6WjBBTGdKeG4rd0Zq?=
 =?utf-8?B?ekkxc29GR1IrcFN3YjRyTHpxTWc1VU5vNkc3TVNiVnhLTHE0OWpWVVFwN3NJ?=
 =?utf-8?B?UUtVaUZTUHZoUTd0RHhOL09SY0V2aWhUMW5pVmlYZEo2aXF1OHgreWp0aU5x?=
 =?utf-8?B?aklJaEVmdC85b0JZd0laT1MrUENkTDE0OHlSN0tZNnkxeHRQRTUvT3V0RXY1?=
 =?utf-8?B?NWVsU0txVFFrQkpTZGVNOXZjWTlPNDBYTWg2OGNXYk9pc1lRWFpQT3l6djd1?=
 =?utf-8?B?bjhJL29EdHRQeGllQ0dMWVRma2tXQTM2Z2pmbG5DS2wwQTFqek9IWlhtKyt1?=
 =?utf-8?B?Rno0ejZ1ODFMaFMvYkkzNVpMUkV3YmZFdW1ueUtJOGpsUG9CaXlBYUFxd0VI?=
 =?utf-8?B?RFkweWFqUHFySG5qOE9Hb1IvMVRZQ3NHN0dkQTdGUVd1MlpaT01WN1FFMXpx?=
 =?utf-8?B?c0c3OFpUMjBKMVd4Sm9iNjJuV0ZlQ1RkR2JtbGZLbUNvNS9TTmhURVNYR1Vu?=
 =?utf-8?B?MDV0b3V0Y2F3OTNIcFZydmFpM1djNjJubld5MGNORWVuN2hlczZkbFFrbUFR?=
 =?utf-8?B?elVWM0RmNWwwVjhWNmp3QTNDakphZ2ZhMW41OUt4aW9tejBVeDBYaTlJVW5R?=
 =?utf-8?B?WWY5Y1IrWm1KUC9kWFZiWVF5NzNOZUloOVNza0swSHU0KzZ5MFdQaG96UjVZ?=
 =?utf-8?B?cUoycFFwNUYrajV5MDZRSFFRaHpQY1VnRVFXZVhSV1VRYjBiTWZrMkZsL0lj?=
 =?utf-8?B?WFB4Z1JIdlZBMWJORHAyT1VqR3FLR1VNL3NjNEtiYjlaZUJYbjVPaW1RbjFJ?=
 =?utf-8?B?ZW1BUXE4c2hVVDFWcElpSGVYUFRSN2N3S3J5N1RmUlk2RUtjd0RBMzNtMnov?=
 =?utf-8?B?bWRyN253L0oxWmQrdHlsMDhBNUdrZWFqZmdQWkVVQ0lOa3pjZlNaWW1nVEVK?=
 =?utf-8?B?dDlRNGdLZWx0RFREMXEwTks0NUpGNGR3c014N0tMbVR5WE0xZCtGSUJBT3pS?=
 =?utf-8?Q?/9c3m7FSB/l18vmgJJYuMa5VbMsh76DdtmEslmB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(52116011)(376011)(1800799021)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjhBUUdaMXY2VVo3YnFrL3pTeVg0ZE5ldDVjNm0waS9iNUdOMWYzV29TRVRo?=
 =?utf-8?B?SkZCRGRJQzJQSXdSdDh3WEhxYmV6a1hxNElmRWU5OW90dlk3UklZc3ZxVGVp?=
 =?utf-8?B?eklsVDJCK1ZUeDhnbmc0NXVNVUhMeWVNQzlIOFhQb2EzS3NFaVpZdXhseGZq?=
 =?utf-8?B?WFpHMzduR2NFZ3phUXI4RnZkajZsOG5WOW9wcklKR1plYVFsNjdVak9nOUxh?=
 =?utf-8?B?K2ZXZ1dlaS9qa1VvR1BtUWNMdGR2MXU0cmhybDR0UWlSbUlVYlVGaXYzSDdJ?=
 =?utf-8?B?VmcvQ21FS3B3QTBZWlJwbDIvVVI2WjlUUzBXem93Rk1ZV3BCak5Kd1oyMUlV?=
 =?utf-8?B?dGRMVTNXY2FLKzhhTGdZdWdFT05yT2xiVHgraE1IcnZzRzBhL1dlT1UvWXA0?=
 =?utf-8?B?Qk03Yy9mKzNNTGdwQ29uakluQ25YT1J2MXlHZFBBeEllS3A1bkxDdG5WOG1J?=
 =?utf-8?B?R0NXRnErQW0zS0tHRlVFZ1ZXMlVac0ZjRmRPOXEyc040OGx0aDltQ1dNVmpG?=
 =?utf-8?B?QU1paUI2Y1BMN0ZBdWN5S21uMmVVN2QxR05FajcwUjArRm5XdWtGRlR3RDZC?=
 =?utf-8?B?MXBralA4bXh5K0h6d3VIZHgrdU9lQkN0Y2lQSnpoejlWN1BsNUVSR0N3WGlP?=
 =?utf-8?B?R25GRU5hK25iQ0F4NmZwSTRGWm5KSVdmSC95UVhjMDVZNG93a1RKc0srSHRs?=
 =?utf-8?B?cHVjek9zZEltZHJ2SGpRT2VFWTg3VU1aSzNpeFU0bXdwNEwrOGJYT0JHdDdX?=
 =?utf-8?B?aXY5c0hGOVVFbC83ZU5reG9pdzdsVUJEQmpTRHp0TFQ0WjI5NVdHaHJnbGcx?=
 =?utf-8?B?UE03YndLN2h6bkpwTTVDcU9FUERNcFk3Tjhzenh0YWRCd0dMbWRPRm1CbXZm?=
 =?utf-8?B?NkxwVTUyWmJVM2RTQUhTTExPQ1JQNFhzUDhIak45amcxbG01QjdwYjFObjB0?=
 =?utf-8?B?NkUxaEdBVngwanFpQ3VjMG8wZXdMenYvZlNlczlEMmlROFFKQ3cwVFZnTTZT?=
 =?utf-8?B?ZXU3RFYzUVBwak5jSlpzc0IxTUZOZWFBRDVaeVJ5UTlOMFdiem9UWTRiTlZP?=
 =?utf-8?B?M3JoQm1PdUpKQ0M1anFzci9KSVhSMDRPQWFxdjcyTWVySmhSUUt1OURTNktF?=
 =?utf-8?B?ZzR4WFJNak5kZFkzMUJmK2FlSEJKTXFtaEsyaWlXSER1QVRld3p6VExNZmN0?=
 =?utf-8?B?NE91WlBJTGpaWEtXeFMyeTV0UFVZY2VqdTZ5TUV6NVF1ZitDRVhFbkxMMUhK?=
 =?utf-8?B?QVNneU4vcWxwVHYycnNyOXBQWjcxcTB1dmxyc1lmUk9kOWJTN2lVdHZLeVlt?=
 =?utf-8?B?TUREMWhaQkd1RThuMklhbEoyR3dRWXdRYmF6WGlpbjBUSVMxSTl1TTdlQXFM?=
 =?utf-8?B?dVM0SC9LZFZRUncvaFY3dDIrNm1SdUVFQ1M1clQ0YVNJRGhaT2pwZHJrZTI2?=
 =?utf-8?B?em9JN0ZtMktqaVFqMnRBTEdYRmJjMXR0L2dCYWtKMDJybHZuME1kZVg3Sjlx?=
 =?utf-8?B?THNxMXJxdlkyM3lIdXhGUnB0a3BGZnc4NDI5dHlNZXhLTnJjY1hTVWFuOVZu?=
 =?utf-8?B?VWFySWtSM2wyeEpTVDcyekE3alFEQzJuTDV5MU9NZWFETFhpdko1V3pTeERr?=
 =?utf-8?B?M2xQUmhsYVRpTW1FUjUyY2p4K3pHNEVEN212M3hoUnpib2M3UmhBaHZKRHdD?=
 =?utf-8?B?dCtucFZhTDJzY3dURkhrakk3RFB2dXZubkk0aHZOSVdxbi9VN0N3NjVPNUhE?=
 =?utf-8?B?amc3NVMvOXdTbTk4UUxxSEphdDNXaUtMOUx3bDdubW1hTmFvaGQzeXFuZkJv?=
 =?utf-8?B?ZjhzMlJITEIzTExuczIxcnhXOG4yNkdqWEIzOWNRbDZwNXB6SFVaaWY3ekt2?=
 =?utf-8?B?VDBFR3hPV2F0akFiNk5ZYmlTMUlzMW9VTWpldlJJYnJIUEhNZ1VCb0g4c2ZH?=
 =?utf-8?B?azZFcURCa3ZvWDdOQmk2MlA4VWJ3T3NJZmFTdWZsbEp5enBVV1g5SWFCNlJQ?=
 =?utf-8?B?SXNMaS95R0lXRFBwYjZSUFZkTXBNMVpkdDRwZ050YkowcmZ6aU15NHpzcWQ3?=
 =?utf-8?B?MFJDTmNra3pXVCtTdzQ5OXo3Qi92cmdQc2NuWGJPWjltN3AvS096M0Y2YWdF?=
 =?utf-8?Q?aAB7XCkWzW39H6J9cKqCvDKG3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d632bfd-7d77-431f-066d-08dc8e824194
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 04:02:07.8838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCD/R/YP8rumMSHcBfBGmpzg3PptDl/wwq73rOUtaHUhig82sG4BR6reFye5TIF095CmcNfFWIeUpSxkoulW/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6532


On 6/15/2024 at 2:38, Carlos Llamas wrote:
> On Fri, Jun 14, 2024 at 12:09:29PM +0800, Lei Liu wrote:
>> 1.In binder_alloc, there is a frequent need for order3 memory
>> allocation, especially on small-memory mobile devices, which can lead
>> to OOM and cause foreground applications to be killed, resulting in
>> flashbacks.The kernel call stack after the issue occurred is as follows:
>> dumpsys invoked oom-killer:
>> gfp_mask=0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), order=3,
>> oom_score_adj=-950
>> CPU: 6 PID: 31329 Comm: dumpsys Tainted: G        WC O
>> 5.10.168-android12-9-00003-gc873b6b86254-ab10823632 #1
>> Call trace:
>>   dump_backtrace.cfi_jt+0x0/0x8
>>   dump_stack_lvl+0xdc/0x138
>>   dump_header+0x5c/0x2ac
>>   oom_kill_process+0x124/0x304
>>   out_of_memory+0x25c/0x5e0
>>   __alloc_pages_slowpath+0x690/0xf6c
>>   __alloc_pages_nodemask+0x1f4/0x3dc
>>   kmalloc_order+0x54/0x338
>>   kmalloc_order_trace+0x34/0x1bc
>>   __kmalloc+0x5e8/0x9c0
>>   binder_alloc_mmap_handler+0x88/0x1f8
>>   binder_mmap+0x90/0x10c
>>   mmap_region+0x44c/0xc14
>>   do_mmap+0x518/0x680
>>   vm_mmap_pgoff+0x15c/0x378
>>   ksys_mmap_pgoff+0x80/0x108
>>   __arm64_sys_mmap+0x38/0x48
>>   el0_svc_common+0xd4/0x270
>>   el0_svc+0x28/0x98
>>   el0_sync_handler+0x8c/0xf0
>>   el0_sync+0x1b4/0x1c0
>> Mem-Info:
>> active_anon:47096 inactive_anon:57927 isolated_anon:100
>> active_file:43790 inactive_file:44434 isolated_file:0
>> unevictable:14693 dirty:171 writeback:0\x0a slab_reclaimable:21676
>> slab_unreclaimable:81771\x0a mapped:84485 shmem:4275 pagetables:33367
>> bounce:0\x0a free:3772 free_pcp:198 free_cma:11
>> Node 0 active_anon:188384kB inactive_anon:231708kB active_file:175160kB
>> inactive_file:177736kB unevictable:58772kB isolated(anon):400kB
>> isolated(file):0kB mapped:337940kB dirty:684kB writeback:0kB
>> shmem:17100kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB
>> writeback_tmp:0kB kernel_stack:84960kB shadow_call_stack:21340kB
>> Normal free:15088kB min:8192kB low:42616kB high:46164kB
>> reserved_highatomic:4096KB active_anon:187644kB inactive_anon:231608kB
>> active_file:174552kB inactive_file:178012kB unevictable:58772kB
>> writepending:684kB present:3701440kB managed:3550144kB mlocked:58508kB
>> pagetables:133468kB bounce:0kB free_pcp:1048kB local_pcp:12kB
>> free_cma:44kB
>> Normal: 3313*4kB (UMEH) 165*8kB (UMEH) 35*16kB (H) 15*32kB (H) 0*64kB
>> 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 15612kB
>> 108356 total pagecache pages
> Think about indenting this stacktrace. IMO, the v1 had a commit log that
> was much easier to follow.
Hmm, okay, your suggestion is good. I will consider updating another 
version later as per your suggestion, and trim the stack.
>> 2.We use kvcalloc to allocate memory, which can reduce system OOM
>> occurrences, as well as decrease the time and probability of failure
>> for order3 memory allocations. Additionally, it can also improve the
>> throughput of binder (as verified by Google's binder_benchmark testing
>> tool).
>>
>> 3.We have conducted multiple tests on an 12GB memory phone, and the
>> performance of kvcalloc is better. Below is a partial excerpt of the
>> test data.
>> throughput = (size * Iterations)/Time
> Huh? Do you have an explanation for this performance improvement?
> Did you test this under memory pressure?
Hmm, in our mobile project, we often encounter OOM and application 
crashes under stress testing.
> My understanding is that kvcalloc() == kcalloc() if there is enough
> contiguous memory no?
>
> I would expect the performance to be the same at best.

1.The main reason is memory fragmentation, where we are unable to 
allocate contiguous order3 memory. Additionally, using the GFP_KERNEL 
allocation flag in the kernel's __alloc_pages_slowpath function results 
in multiple retry attempts, and if direct_reclaim and memory_compact are 
unsuccessful, OOM occurs.

2.When fragmentation is severe, we observed that kvmalloc is faster than 
kmalloc, as it eliminates the need for multiple retry attempts to 
allocate order3. In such cases, falling back to order0 may result in 
higher allocation efficiency.

3.Another crucial point is that in the kernel, allocations greater than 
order3 are considered PAGE_ALLOC_COSTLY_ORDER. This leads to a reduced 
number of retry attempts in __alloc_pages_slowpath, which explains the 
increased time for order3 allocation in fragmented scenarios.

In summary, under high memory pressure scenarios, the system is prone to 
fragmentation. Instead of waiting for order3 allocation, it is more 
efficient to allow kvmalloc to automatically select between order0 and 
order3, reducing wait times in high memory pressure scenarios. This is 
also the reason why kvmalloc can improve throughput.

>> kvcalloc->kvmalloc:
>> Benchmark-kvcalloc	Time	CPU	Iterations	throughput(Gb/s)
>> ----------------------------------------------------------------
>> BM_sendVec_binder-4096	30926 ns	20481 ns	34457	4563.66↑
>> BM_sendVec_binder-8192	42667 ns	30837 ns	22631	4345.11↑
>> BM_sendVec_binder-16384	67586 ns	52381 ns	13318	3228.51↑
>> BM_sendVec_binder-32768	116496 ns	94893 ns	7416	2085.97↑
>> BM_sendVec_binder-65536	265482 ns	209214 ns	3530	871.40↑
>>
>> kcalloc->kmalloc
>> Benchmark-kcalloc	Time	CPU	Iterations	throughput(Gb/s)
>> ----------------------------------------------------------------
>> BM_sendVec_binder-4096	39070 ns	24207 ns	31063	3256.56
>> BM_sendVec_binder-8192	49476 ns	35099 ns	18817	3115.62
>> BM_sendVec_binder-16384	76866 ns	58924 ns	11883	2532.86
>> BM_sendVec_binder-32768	134022 ns	102788 ns	6535	1597.78
>> BM_sendVec_binder-65536	281004 ns	220028 ns	3135	731.14
>>
>> Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
>> ---
>> Changelog:
>> v2->v3:
>> 1.Modify the commit message description as the description for the V2
>>    version is unclear.
> The complete history of the changelog would be better.
>
>> ---
>>   drivers/android/binder_alloc.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
>> index 2e1f261ec5c8..5dcab4a5e341 100644
>> --- a/drivers/android/binder_alloc.c
>> +++ b/drivers/android/binder_alloc.c
>> @@ -836,7 +836,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
>>   
>>   	alloc->buffer = vma->vm_start;
>>   
>> -	alloc->pages = kcalloc(alloc->buffer_size / PAGE_SIZE,
>> +	alloc->pages = kvcalloc(alloc->buffer_size / PAGE_SIZE,
>>   			       sizeof(alloc->pages[0]),
>>   			       GFP_KERNEL);
> I believe Greg had asked for these to be aligned to the parenthesis.
> You can double check by running checkpatch with the -strict flag.
Okay, I'll double check the format of the paths again.
>>   	if (alloc->pages == NULL) {
>> @@ -869,7 +869,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
>>   	return 0;
>>   
>>   err_alloc_buf_struct_failed:
>> -	kfree(alloc->pages);
>> +	kvfree(alloc->pages);
>>   	alloc->pages = NULL;
>>   err_alloc_pages_failed:
>>   	alloc->buffer = 0;
>> @@ -939,7 +939,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
>>   			__free_page(alloc->pages[i].page_ptr);
>>   			page_count++;
>>   		}
>> -		kfree(alloc->pages);
>> +		kvfree(alloc->pages);
>>   	}
>>   	spin_unlock(&alloc->lock);
>>   	if (alloc->mm)
>> -- 
>> 2.34.1
>>
> I'm not so sure about the results and performance improvements that are
> claimed here. However, the switch to kvcalloc() itself seems reasonable
> to me.
>
> I'll run these tests myself as the results might have some noise. I'll
> get back with the results.
>
> Thanks,
> Carlos Llamas

Okay, thank you for the suggestion. I look forward to receiving your 
test results and continuing our discussion.

My testing tool is the binder throughput testing tool provided by 
Google. You can give it a try here:

https://source.android.com/docs/core/tests/vts/performance


Thanks,

Lei liu

>

