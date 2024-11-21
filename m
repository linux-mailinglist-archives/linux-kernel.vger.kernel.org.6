Return-Path: <linux-kernel+bounces-416995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A5E9D4D6D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30343B28A18
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D351D7E37;
	Thu, 21 Nov 2024 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jQFAZTE+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zwsjwRgy"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A891CDA18;
	Thu, 21 Nov 2024 13:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732194284; cv=fail; b=UQNkeFFUz52QE00znKrEzEiHLV1ZOhQ+KQzEYsWHRBSOnPt6PN4vjMoLpQaVu95zarl0nNarwEWK77bqNk7ozFuH6qAgbzGNRBd7BJ9rpsNlC+TsOCCn+ZaJmVDOeKatrh9uYYj7AwMR14Uo40mdxf+MipM8onYoBoaNvXWsy3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732194284; c=relaxed/simple;
	bh=V3SiqNmH39Yv0Tr9Eduxza8BSnJngGOKp8QpYEg4WpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LXHX4wjUQsRyNKi+d0vaZjtq2h7wvqMQyAcj9HAnYYNZhuUvbKDgOuWfv4PCM57fO12J5uKss3CnpPaJfXGSB/2oCQfuTJ6jZ4rD4bl+wos/dMjprkM/dan/kDedZzqpK/iQMvqy+cTLJ/lrI+eH1M9nrJQeQD/vK2yNyBMGh3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jQFAZTE+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zwsjwRgy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALCtYsA006857;
	Thu, 21 Nov 2024 13:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Sios1lXAeM9BCJSXDbSMZDSqeIbeNsXvyBXL7wTm8xY=; b=
	jQFAZTE+bbuxmu9JUtFMRyRlwIb6I7oKxkz27OwDdUZStW/qA8e5U599cgiKWQBO
	IYSkUH6DLa824QrG5loQ1m82aJKUR8VRw2RKRkvuQ0kKJW5Zw3CEi1lTy5nlYDcZ
	zl2DmtiOnzLhhP0EmAZl7cnFYR/7QaBB1i/1P+q/WA1qUYxyLYqai8M28ji0LHdN
	oLUUyXDBFSkokkbeD9FrpdkZ91kgWdp6EhBv2C+SVFr6baFZoNgA9tKWwvx1biWc
	oKRjCdDOpOvnq6NKJiQAv6JghoqjGRonwKOz9qnvCIA6dqbx+6PdTXfTGwmyPixu
	+vQhGlSSL7CDrCCuCRHlRg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xkec1px8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 13:04:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALBgY5T008575;
	Thu, 21 Nov 2024 13:04:19 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhubmn12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 13:04:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vUtxVvG8gHmKWqYX9T9/SeVZYcYzT4GdMeG98zEhb7wja28ei/3QrKIztek09c4UwPRJ4Qwe9jEP0Xxc3s4nKz6y+F1xBIpSUSCwNxpB3dJ5+xAmhePHgmLSj+sMYlca6UVCN5dbrQ9UV6UFkNRjLewpwmze7Fcp/zu8Y7yHm5h5EvLJr7TZiOvsVJfl8Kp7LVZ8n3JAMgkVyuMNYtl8NarhL1O+EZM/ctqkyf1zG4R3nTd+LmkHCLvMp0EHHksjeNBr9hNGMVvt/w109pOpc0g0o8lQLQiIR0XLkrItA/WVfGT71f3nrl3MXg6Rjf+ISpLAVCDMzBQy8irh2O+HdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sios1lXAeM9BCJSXDbSMZDSqeIbeNsXvyBXL7wTm8xY=;
 b=SLnDBrCCaskvDUqYcy9eAvNsgKnowXpWil1/qrDJ9uXAQEnEoF9NGu557ZF+A7R6xd576aYRls853M9sUSoFqjAHXWjeOAfaSn3sUOGVv1Mtwg5mIFFoOyEpH2fclU+RUhB2AtzXkmJXdmtx2QXrJpm5hNrbNyDrv7/LwY6BKStRv9lT22jpgzjuqRrrgEi+bnaOioiTHyXCCXVH/3WgiPVlgBVb9sw+/c3aH/1wSka6TKALuIGkyks7mBe6dwzowUIQqpdAVclbHPMQXakHUnRCxWovYBJorktkDkhNth9l6NNLk7+8IdmyCn5YIXLOJwz2uzgPEOuu2rCqqFN5ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sios1lXAeM9BCJSXDbSMZDSqeIbeNsXvyBXL7wTm8xY=;
 b=zwsjwRgywwPM1KlkFKYXRxo3eP/sfESOz9k+5ir0h7ppL2ImP1uh5QDtlRJLLUFtq9LEWxzPmYUaPookpPaePiYBFUecRnC7YjSDB5cCcdruB6rFRYFPWLfzsZIIKHTUfmOy9FPp2ATY+wAb/o0lqLibnMgU7Obe8hMHt7KBazs=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS0PR10MB7341.namprd10.prod.outlook.com (2603:10b6:8:f8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 13:04:12 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 13:04:12 +0000
Date: Thu, 21 Nov 2024 13:04:09 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
        Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v8 5/7] mm: rust: add mmput_async support
Message-ID: <52cf60c5-b987-4c37-b7e5-caaf425a9fd7@lucifer.local>
References: <20241120-vma-v8-0-eb31425da66b@google.com>
 <20241120-vma-v8-5-eb31425da66b@google.com>
 <5762ab92-3091-46cf-9565-f59cf917b470@lucifer.local>
 <CAH5fLgjDfSL+7XB28sYmq4e40yxBv97h7jQPs=9Qe4+_3f1FRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjDfSL+7XB28sYmq4e40yxBv97h7jQPs=9Qe4+_3f1FRw@mail.gmail.com>
X-ClientProxiedBy: LO0P265CA0008.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::11) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS0PR10MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: b2e89262-e2f9-4ccb-04cd-08dd0a2cfe80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2ZON1JacHJrTjlTRGw3ejlYa0hmLzFjN0ZFNDdVb2tsejE2R1ozVWtYamxn?=
 =?utf-8?B?WE5xSW5pN1FyeXRnM2JpZDU4YjV2T2dianlaZ0pkRzNYUFE1eW1wZWd6QnF1?=
 =?utf-8?B?ZWkxblFwTFhFd1lGR3oyQ1VQcW1TdUI2SndOS2hBMTFtOXB6T2FiYUFwNDR0?=
 =?utf-8?B?R2NZbFBjalM1dlIrOHpBbFJEbUdOMGJQbVh3enh2UzRHVjU2a3krUXpraTRS?=
 =?utf-8?B?VEVRR0NaMDl0VmpBZXVPVHRBellpcmRrR0g0VnRkckVaRkVERElrcTAzcUl6?=
 =?utf-8?B?MkxFVC8yMUR2YzE4Sm9QZXNIUXdzZTh2SHNXSkU5cFh6SjlZbkZuanh2aTV3?=
 =?utf-8?B?QW8zV1JwWm1uOVlJWTFERGI1NVJZZXVLWDV5TDB0SDRQSkVnWHFWN3AvSDVT?=
 =?utf-8?B?OFFWVnJPWnpaWGtUV0N6cVdrU2xTak0vekplZVRZcksrZG5LTDBxNzF4V3BB?=
 =?utf-8?B?bVpVTjhlUUozYVlJWkFGbnhyVGRQSzNwSFg0YTRzS2dnc2ZaTnFWVjN6QTB2?=
 =?utf-8?B?dThpekhseXlHTFRQT3gvdUNtNVh3a0tYQzZhczJFMjJDS1FxY0tvK2RvZktB?=
 =?utf-8?B?cE9TNncvYThMdTdyVUpwL1NrYnZFRTVQZGdXQ0JHWnIyeXpUUUR4RFFZQ3o4?=
 =?utf-8?B?bnRPNmRhTk9sNlBydmtTNERxWHpnNTlFK3R6bDlPeU5xa2d0ZExHQjBwNU5a?=
 =?utf-8?B?QmVmWU9NRDM2TVNJUDE1T2xubC9SVEVTbzViSm9kNHU1U3czaUVPL1MrL2tu?=
 =?utf-8?B?d3F3ZDZFcyttLzVXN0lEOXFpY05PdnBXbUpQUGxQdHRkU0xkWWpkOXlHK015?=
 =?utf-8?B?REdQN2NPK0kxYXBkbHdMZFhVT29sWFFkVktRcUdiZGY4VHp6dGpRZVJKK3hk?=
 =?utf-8?B?TWhYTjFnWFBBbCtkNkJJdm1jeUIvd09ERHU0OWkwRndYVGxBNUlJVnUwM0Jr?=
 =?utf-8?B?UmNLUUVoR2xOTTEzN0FzQ1F4T3BLKzMzY2xsK05YcmxLSEZhYVgvVXZBRVpk?=
 =?utf-8?B?WldiRDNaK2JOVHFXQmlHTUk3dEVNWkVZbHR6bExMV1dxWlRxZVIzemhBZU00?=
 =?utf-8?B?blNIalRaeVFZNklWVGZtUVEzYTdSSWlHenB3emNLMnhKTTBCc2FIWG9jaDVF?=
 =?utf-8?B?bDJuUC80SVJMQzVMQzJ5WVF0dStBeWduckFCclhYNUluaURoSURUS2xyWkVn?=
 =?utf-8?B?SmdkeUpLdFB1K01mSDlYaHZXWTRGVlJBOHp0RlY5dU5vbGkyMDhVKy9ZY2hR?=
 =?utf-8?B?L1N4WENwaUE1ZDdKMnQ0RVpWUHNvK1pIUEVQM0VIZGI5cGQ0dUVvTzgrWTFi?=
 =?utf-8?B?QUxwRFN3MkZKR0oyWUcvM3liOHJWYjVkSDRxZGVDNVRqNjNMZE9GV1R5TFg2?=
 =?utf-8?B?ZXdNUVdKNzN1VVVndmcrUWpNVUhjdjg5U3pacjBkeGIvR1RWVG9lcDFIU1Q4?=
 =?utf-8?B?ekdiQ0hoUTlWNS9mRTlHL2FPRWZUQUQ2SjhBZzJqeUQvVG9pc1pMSHZkQTVO?=
 =?utf-8?B?MnRJSWRId21uMklhN3RKN1dQK3E3dWFzVGUvQVM0eXVmeUd3bk9zTEsrckN1?=
 =?utf-8?B?QTU4NG5MLytjNGpFZjNleXI4VmdJQWljbVE4YXV5TTJWd0o1cjJVTWI2NlY3?=
 =?utf-8?B?YkcrWUF5WEkvQzJ2MmNDV0hqZW1NN21iblpDSVRidEVZK0NJMTU4OUhISC9n?=
 =?utf-8?Q?onEq3E2azTCw6lc2MZDw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmZReE1GT1hkQXNmMG5jeit6ejVtUzR4NzhBdFhvUVFsVHFVc05TNTdnTll0?=
 =?utf-8?B?ODErRUpBRGFqNTNaQk1qamNyaThZbDllK1JXNGw4WmJGNjNXZm5ybWMvazlK?=
 =?utf-8?B?emdVUFlaNjRKakQ2QTg3MVZadVJyYk9Dck5sLzZUeFM0by9DcTVjVXNBUXpi?=
 =?utf-8?B?ejhsN1Z0ZWlkQlUwbDRWZ0VPSGR0L25QY0VKKzRuakhuUjlFWHNJbUYyR2RH?=
 =?utf-8?B?Zks5QzNWcm5WQXpzc3JlNmM1cUZnUHZXaGVTN3YyWlhpOGdKMS9aL2lsRHV3?=
 =?utf-8?B?UkFMbFVlZndmem1sMlpCZ2pheUJsUUVsQ2dFdFBkUTFLb2tZY0twb3hGbW9i?=
 =?utf-8?B?aWhZZkdKcm94UWlkb3F4c3JHM2JjTWpMVktVWXRkb2Q5dHZXcWhJd3B3TmRq?=
 =?utf-8?B?bjRvcWxoRi9MaVVXT3VQa3RTTlhZWS9NdVVkY1dsR3dVaEVFSGtHWXFTYmhI?=
 =?utf-8?B?OXN0NUFnVU5QcEo3MG0ydUhGMUpkam5zWlpNRUpKbDZRNlFpV3ZRcU9BUng4?=
 =?utf-8?B?K1lwK3VDQW1EMVdRSzBDenB0OGMvNCtVc01YQkRUMk5jUXVYb1FKTnN6RXhW?=
 =?utf-8?B?SjhDUWppMHNla0RwMUNxMERMSTk3MmQ2eWI2b1lRd3VHTk0wNkZjY0VtWmpY?=
 =?utf-8?B?U3ArRy8vMEI2QVU1ZjB2SE90dmEwUklXUDRzdVRUbGtDSUpWaWFXdnlYeVJj?=
 =?utf-8?B?MDFiTjcwTjRzV3hRSmxQRG5LM0I1eTk1M1pheGlpbkl1RFI3UWlhcTJjdDBy?=
 =?utf-8?B?K0k4UmNGVDUrVEF5b2dFM0k3b1hmRldlbWVsdXZMdURSVVlIR1VDWE5JdWJD?=
 =?utf-8?B?aWdnYmdIS3VXYURHUHIvdng4Mm9NaXZJYXh2Vnk1anJsMFpNL0xGbUsyNS9k?=
 =?utf-8?B?L1p2bTNtc2hoZGJjdE9DekVzRzR0SVN0bmNGbnlpa3E5Q1VvQmpLRkVMb2x1?=
 =?utf-8?B?Z2s1ZWNjZ3dmSkZ0UGVKeTJxeUZXWXN1U3lnYkxvM2h0VWVCd0VRclJBRkV3?=
 =?utf-8?B?c1JVNTF6QXBCL2c2WGF2Yk12b01lSm5rclhiK1VyZTU5dUg2RzRYUDhIWW5H?=
 =?utf-8?B?dlRZWUxXQnFxZVkxditkZ1AybGV2VkthOGY4bW9CSlBLWDQ4cENTVEUrWGZK?=
 =?utf-8?B?eEZ3cmVyRUxyYk9iK1I3WTdpa28yZ2diTDJPM3VjWjFucDd0RVYrT2xMKy9G?=
 =?utf-8?B?RGhlZTJNZENiR084V01zYnM1WmF4ZGlHQ3dITVRJbU5kYndqdFhlak91NU9I?=
 =?utf-8?B?WjJNbSs1Y1dldE5MV1Q3L0sxU2JBTjJHbCtMVW5mMld2emVoY2VXUm9ETzZP?=
 =?utf-8?B?QnV4MHdjQUtjSXN3TlRGWkNIK3VxcmZ2L1VZUFJ0T3ZWQXgzKytGZ0pRWkVT?=
 =?utf-8?B?VWtFY2I0VDVzQkR3ejU1WVpMekZOVXVWOWtmM0RkM2ZQQTd4TStnZndaUUI0?=
 =?utf-8?B?M2d4NFNiUk5FOEtqcWVYOGxlK2U5Rm5BOThBZ0lqOHRwUEEvaXBkaHI2VXBH?=
 =?utf-8?B?RWdraklFQ2luaDlNMkg4YU9Ya0FnaS8zL0hIc3RyRFVGeVJualpFdzFEOTJ2?=
 =?utf-8?B?TkU5RzU3cllFUVlDT3J2cFgxT1BqV202Um9nV3RBeFNtb0RlbTVHV25SVUc1?=
 =?utf-8?B?Y1Z3bDlFZUg0dFVSRHplanBJOFNQUy9uL2t1VE84eVFlV3Z5UlNya3prazEz?=
 =?utf-8?B?b1dNUWhIS1hHd0RPSHRIdEN2Q0pBSmFDRzhHMllKUlJWL1NvR2w0UEptTHpp?=
 =?utf-8?B?dEpQS3NyTFN2dHFYdUxDSDR0dkY3ZCtjVEkzaFY1dmFOQjZ0RGU0R09xcXd0?=
 =?utf-8?B?SUt4b1JrZ0RvUnFRR0lLYTRJdTZXTzlhV1kwZFR3N3U1YVBESGRjWlRSWUN6?=
 =?utf-8?B?akZ3blFOOFhlbmtJbUMyTEhEM0xtN3h2ajFOWGRzb3lzdU94ZnBMdmlLV1BJ?=
 =?utf-8?B?a3ZMOEtmczR0V2J5Y3pZYVMxcXRpZjhQY0ROeGFZeHdwZFBUaXdYazJXbmww?=
 =?utf-8?B?cFJpTXkwVzNjS2ZQNzNzT3ZEU0hTaEVDRXZoK0NQaWZHZFFhOVBMZWN4emk4?=
 =?utf-8?B?bUp2LzZiZjk3alJIUkJ3R2xkSEZSWmhsYlpGTjQ1OUsveVJzYUdaUnpuYkR1?=
 =?utf-8?B?ZUJZY0JVRG1WdDdSWFZUM3ZCUjg1NVlzWEU5QjBhTGc0Vys0d0NvNlNlOThZ?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tGF7YOY5OZYQ2j6zZWxsUitSGSBxnaBoH/inb7ULgiD8mXahCuqOBjcsry9XxMxSmjoDNj7HPDwpC0TnN/Mlr175AMOB/Xep8ypBF9VGxgxzhT42shz1WAljliUt8Sti32+9YOr7pA5rPL8VHvlzynRpOxyU0nDeF28Fk1442aCy3t+uWdvS09w5KQYZkDpL/9eGuF1Dj3oVFdI0qcbqnWGBioVJlBeKuyouUEEgmTXh6YA/JBDVgwuen1lpzd7JIc/cgjecbBUTDJxNvOSm6vr+3X23uHS05ByCZwA3sisP1tLyiT2zAwcxlPSKR0v0FzkHxQyPPWleGBjc8zkSSlXpaWFglmsuOw2hG7bmq2ScbyXXOuhTh6U6fvNSsDxsVvzLLOObsykPxvzO6XV7hd0I1a4bgnQAAZrijW3l190EAwqfSrcrRz3r2CNDRvP2wWtLEyThDqg6r8mHP2IKC7+GZmDpDa4AExkPBvp1h3nVvTbbCCO9FsM+7gG1A6Hz3Wyb/Boovegk9RvSR4Dku8B6cH5hQlUsZxeduB6nPfvAMFpL1AzEGqJwopeXE7x4zMO8T5Mz3iodMreTswIfiNIZE//AWhGQ8qpT0wJ1JY8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e89262-e2f9-4ccb-04cd-08dd0a2cfe80
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 13:04:12.2187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ALsurQGJzbw/5iF/NkAQWaVHO8qJKvEcEdeP0rfcs8MuT0nOOcetktvQQu+OzKF38BF+ShlGJxQ7I+cLowazYOJrV82xZLgxvZpBoEeEM34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7341
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_09,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411210102
X-Proofpoint-GUID: hqTEIBa8lPEqN6QGbEXTmVQr4IDn7dX3
X-Proofpoint-ORIG-GUID: hqTEIBa8lPEqN6QGbEXTmVQr4IDn7dX3

On Thu, Nov 21, 2024 at 12:39:37PM +0100, Alice Ryhl wrote:
> On Wed, Nov 20, 2024 at 8:47 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Wed, Nov 20, 2024 at 02:49:59PM +0000, Alice Ryhl wrote:
> > > Adds an MmWithUserAsync type that uses mmput_async when dropped but is
> > > otherwise identical to MmWithUser. This has to be done using a separate
> > > type because the thing we are changing is the destructor.
> > >
> > > Rust Binder needs this to avoid a certain deadlock. See commit
> > > 9a9ab0d96362 ("binder: fix race between mmput() and do_exit()") for
> > > details. It's also needed in the shrinker to avoid cleaning up the mm in
> > > the shrinker's context.
> >
> > Oh Lord, I didn't even know this existed... I see it was (re-)added in commit
> > a1b2289cef92 ("android: binder: drop lru lock in isolate callback") back in 2017
> > so quite a history of being necessary for binder.
> >
> > I see mmdrop_async(), I guess that's not needed for anything binder-ish? A quick
> > look in the code suggests this is invoked in free_signal_struct() and is there
> > due to some softirq stuff on x86... so yeah I guess not :)
>
> I didn't know it was so binder-specific. I assumed it would be a
> relatively common use-case.

Yeah, seems not so much :>)

>
> > >  // These methods are safe to call even if `mm_users` is zero.
> > >  impl Mm {
> > >      /// Call `mmgrab` on `current.mm`.
> > > @@ -171,6 +213,13 @@ pub unsafe fn from_raw<'a>(ptr: *const bindings::mm_struct) -> &'a MmWithUser {
> > >          unsafe { &*ptr.cast() }
> > >      }
> > >
> > > +    /// Use `mmput_async` when dropping this refcount.
> > > +    #[inline]
> > > +    pub fn use_mmput_async(me: ARef<MmWithUser>) -> ARef<MmWithUserAsync> {
> >
> > Again, nitty, but I wonder if this should be as_xxx()?
> >
> > But I guess this makes sense too.
>
> In this case, the as_ prefix is incorrect because this is an owned ->
> owned conversion. See the API guidelines:
> https://rust-lang.github.io/api-guidelines/naming.html#ad-hoc-conversions-follow-as_-to_-into_-conventions-c-conv
>
> If we wish to use a prefix, the correct prefix is into_.

Ack.

>
> Alice

