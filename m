Return-Path: <linux-kernel+bounces-277096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4232E949C54
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64EA41C21538
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A22C176AAB;
	Tue,  6 Aug 2024 23:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="FzZgnCrj";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="aJy4TXLZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="dJL1hLAB"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A37B171E5A;
	Tue,  6 Aug 2024 23:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722987033; cv=fail; b=E2gO+HeIgEPaDVZBuHSLPNG0qao0AlJdMc+z2gbeZDBt7HFvY7ix/VHg5QxyOF/SX71y3y2ddjfz4QbdV8yAvopz9LAAbtTsuxEAnJoyjizEJvgdsRV7F70zNeoFpFXd0okJKVdXC+JKxajO6/8WDESbQdFvaBD+MmPT+UdMgKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722987033; c=relaxed/simple;
	bh=vkWTjWrzF3oudndD0RLGI8/13amcY6cmnffySS7GZZA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dojMEyuL9+RGp/AYAA05uLGYjzOsVPBfrJegbvS557xf7DfoOtvCtYKfA/6IQgURghIhk3n+fLgbvouU1b5YLc+D4TO8zmvREhF/wI6afLZw6c7+Qysckd0TLyK90QJHt12U2N/xI47QstdyrL13H8jp3l/u9QDwT9jpirjplKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=FzZgnCrj; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=aJy4TXLZ; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=dJL1hLAB reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476MJh6N025824;
	Tue, 6 Aug 2024 16:30:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=vkWTjWrzF3oudndD0RLGI8/13amcY6cmnffySS7GZZA=; b=
	FzZgnCrjg1JHOx7YDioMpSQDgByylvDnBZcEN6GbO8ZwoZr7duaEdL8DAWN2lM/w
	Sd5KyakQga723ITO60DZHSHnpSFDbW3fjHRjg9G9DXsSut0DfUN50srLcS4u2drN
	oP7rp5WsiDMb+aexrBLMmwZST0ZS2zXU5r5FqChkQUavnmLKtjL6N+DYMNMEoA6+
	vGvxuUGrIA7pdi/z6AhUbskCXVj29mTrQRjEDr0I12y/S8/geAZlEW38pTEUgjXX
	ZEQL7Wl9uG+f1iulXHnUTqjYgH7lDEi4SkHTmR8KRq1ylNYoL6ZCM5L5nvhQIHY6
	YKKQ4CCwOzMDLDj8/jMyCQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 40uujb8deq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 16:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1722987021; bh=vkWTjWrzF3oudndD0RLGI8/13amcY6cmnffySS7GZZA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=aJy4TXLZ4+8TzMF9ZpRxlxlSDepjaAq2L6Uh9DXYW2WbQeeEXHyLl7mdsi7y0iR1r
	 ZC+nb5RDtWR2tWvD1FkzYNvKuudUiOu8+BDc3i5VzeSf+TB87WQDvacxKBU1+UOkSt
	 UEdE8eCNwKfbH9MK6kmX6jH1TX9OTtMeLEY1nI+SesqEoIkyWm37aGyJOU6yQ3HDcG
	 /kzJfeDnu+BtYDGXGAKBdK0xaIeWP6x+ICMBRHhorvutKfiT0aLBv2X8lH14THnN8n
	 kllYoCU5uKdCiO8mkKtA+/GTSKBNTyI+QSBsPRNdzlD7ZxeeSf39qC12wVw5NEL6Cs
	 9q+q5P+Dlkc2A==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3D3134048B;
	Tue,  6 Aug 2024 23:30:21 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 21F2FA00AC;
	Tue,  6 Aug 2024 23:30:21 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=dJL1hLAB;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id B627F4035D;
	Tue,  6 Aug 2024 23:30:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUv+YkZmc5wqx1j/NQJWIWpO2xj7q0EKNDudcmj5XJHZNfzuVSa+SyJgbEVK+rfk6JPQlvwJDGTvcjnjfAKuFsmh+XKnst/hQMNgrSrl6pl+1r/8Kx3wP29i/ST2Szapwc3vhygtThsq1p3F4/Qz9liqrgHv6M4fQRl/oBUL0nQIG+6Xq6Gpmadu9S8+hxTmKeI3OTvLUrQQ7t4g3CuRJjTr9WhJpVapySVhi5IzYl/Wwvg++zfGfG3g4w/lb7gf4JW47Hp+COuESnYocpp6N4rImvzDOdy4bJffZUABDKyIkEt2RWarcWuJR63YDyYNMk8duMP1SrP5ePnkf+oUsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkWTjWrzF3oudndD0RLGI8/13amcY6cmnffySS7GZZA=;
 b=CVbZqth9iW+oSP4a/1ivgq1zxrTuqqep5iY/2u/77R/VTsPoIflAlsGoOLqnlxB2czQKEo7/4tPLg74qpi4ak7SMXIkrRfWVFmQ0tOPOlJrnbc+WvbogAhWzo5DYPiOBAERryNpgeaUeYPtO3bGSV900KrdTG+osM207J8l6eP/UBJNk08vMnHJKQ7pGBJh1eNIfk+/O997viSoyyMmGyAmGVLxu5M5sYs9rB6DLDwDY54swjeWxU2bKYqq3rTQW1tZLe8Eg4+Hlg/OIZhI3j3sAd1gg8I3/xHV32ghlASwluN4PQDJ84sDrlFAEG8OssBXiAdDyy7mOwoI04nhL6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkWTjWrzF3oudndD0RLGI8/13amcY6cmnffySS7GZZA=;
 b=dJL1hLABX8FjD/FMOd/nQ0RaCKTqfPDfBJdGCb2BABB3qIYNitbVLRgAWjbvM7SzhnQUYHoXh87PO509Hce8sIOJTNNiwbvjppGXuxUR5TEOuKiIUis9MwrHaD4KUG9IEwn80Me/ShIqhDcAkoaKCO9C3mszqOchQiiJ590d1gY=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA1PR12MB8588.namprd12.prod.outlook.com (2603:10b6:208:44f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 6 Aug
 2024 23:30:15 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 23:30:15 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Use of_property_read_variable_u32_array() to
 read "power"
Thread-Topic: [PATCH] usb: dwc3: Use of_property_read_variable_u32_array() to
 read "power"
Thread-Index: AQHa44ZLK2TXyl0fEEKdCtRh0v8GHLIa6hyA
Date: Tue, 6 Aug 2024 23:30:15 +0000
Message-ID: <20240806233011.trvr3scmjqvu44g2@synopsys.com>
References: <20240731201407.1838385-5-robh@kernel.org>
In-Reply-To: <20240731201407.1838385-5-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA1PR12MB8588:EE_
x-ms-office365-filtering-correlation-id: 71aef010-7601-4880-a67f-08dcb66fb9dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eldUYU5ueVc0UHVmUUFBV2daNVZIOFpYaXJhSnMwTHlTQ3ByTGV0c1hpQVAx?=
 =?utf-8?B?bk5LVzBBdXN2dTMxSWgyT1duMk1SWEZzejZ0cmtET24xV2krei9FZGw4M0ZH?=
 =?utf-8?B?RThkUHFENHVMQ3YxOTZDNTViMXBVRStXc1E0aDhuMkYrbHVHZjJmcEJacFVS?=
 =?utf-8?B?MllXanBvY1Y2WFRaN2MyUGl2RjA2elhLWEFqaUJyNU91MzFTMklQUE82U1Yr?=
 =?utf-8?B?UEt5KzdFMFgzenNyZnhrL2xNL3hsWTgxN1Frd2tSRURteGgvQTNTbExIYmtl?=
 =?utf-8?B?RktENzBYbDZKNHBidjZ2VGRlcnJjd1FBTEwzTXFCNzF0RnNhYnlQLzZtMEoz?=
 =?utf-8?B?K0pkUEVQcytIMU8zSnJxUWpIZHdWTEVLK205czlNdjEraThWWC9WTGN2cG9v?=
 =?utf-8?B?MXZnS29HekdtVVd2ZHV6bDZiZHJTNXVlSnJVbW9GTHRxa0p2NmJ3YUdCMlZD?=
 =?utf-8?B?WUgwVXhuaGNzY1J1eHFLYmZhZ20vNHg1OFd0TVdrTUJ1N0s0TWNLa1g4WnlL?=
 =?utf-8?B?OUNpck5tRThjUWg5ZTRiaEw2Mm91bU9makxRSm5EckN4WGZ3WktwOGxkOWJR?=
 =?utf-8?B?ZWJDbUliejVZWU9HWk9GWndBYVF0Mkp0R092bFUxaXY2R0lzL29Vd2I0OCth?=
 =?utf-8?B?OWxhekg3QlQ0ZlN3RmZOTmRtY1NxRTJ6MEp2bFZIdXJ3R2dWZFpaZEV0ZHZu?=
 =?utf-8?B?K2NPdW81KzFOMEp5ZGdkWE94WWo5UUZUUVNjT3NYL0VISEg1QUJES050UU9i?=
 =?utf-8?B?VFJhRzJOMUtYbE9TZmovUkhvQUdZWHRhMEIxcDVSeWtlaEJCWHJPTXQ5N3Zz?=
 =?utf-8?B?TklrTkcxYmoxM01UUCtPazRvbkZuOEhaeitFK1ZFNWFVWTdBcXhuN1ovditj?=
 =?utf-8?B?Wjk1YVBHb1ZyV2xNZU5kZjh6dkNrN3YwdWdoUm1SUWpFUG1SRXlsUDlranRa?=
 =?utf-8?B?R2ZTQVljMnRFSmsxNmxIK2tMLzZiUkR5WUZicFY1SFNRQ2Jabys4TWFRQ1gy?=
 =?utf-8?B?MXI0QW1XTUdQUmxvWGI4VTdjbDQxY0dqdFBuOTNHTnczK3ZkVFNDMlRBNVpO?=
 =?utf-8?B?Z0NpU2R3ZCtJQWpCSnRubFBJOVRYV05CNmdZL3RYWXFINXpKYWtmYXRaSDg4?=
 =?utf-8?B?L29zZzZudTRmd3FQTVRKUHpZUTNoL3ZjTkFaRVVjbFpyalMrVHk3L3FYUzY4?=
 =?utf-8?B?Yk11cDlnRW9ZYlVVaThybWdiNmtrRWw3V0tuKzV6Z2Z2anR6cVRFblVpOWl5?=
 =?utf-8?B?Rm50Nm1PR2Q2QXRKRHFLQkJnTVpjK3NkNlQ3dElmQzFHbU9CQm5vU3d6SkFh?=
 =?utf-8?B?K1RESzlRdm5yMkhHQUU2ajQwN0YwTTZGTGxmaFNWanpFaVhUbkhRWlU1bjdD?=
 =?utf-8?B?dTBRY2VwTjEya1g1YXExVlRxNmRvVUVad2xSNzJjMkpnNGlMOUs3Z1RQa1JI?=
 =?utf-8?B?ZXNEUDVxYWRrRnNpZFluekgzNmxQOWhrZk5VdEJjU3ZMS2V1SzBsTjNOV21n?=
 =?utf-8?B?Qk1VZWVCUm9xdmdRY2dwekwrM2t0WHg3TjZxMUgyKzRYWTlKRFFsNDRPS28r?=
 =?utf-8?B?VTR2blJBUFF0VlZhZWlRelVjRjZqalJQNWRVYUhtVkJCa0NLVXFHcHBaS2Rr?=
 =?utf-8?B?MWlRbTBuU1BzaXE4cU0wT2RwbVpNaVBneGJjQUliTUUyWmhRNVpkek1WZ2Mz?=
 =?utf-8?B?cHNLcFJFYlA2WHFxNGdERnFkelJ3ckNsUTBXTkF5S3JKVk10UFAzS3hxeVB2?=
 =?utf-8?B?UXpLSWNOb0hNd0lKK3cxcXBxbUFXODBSNzFVeCtPdnRld2JVZVhKeHNSS2tk?=
 =?utf-8?B?K3d4c2w2bVlvWnhKYUF6N1NqRnhaVVhlbnM3S1Y1dFlyaEE0TG9tQktYaWt6?=
 =?utf-8?B?bXgvS0FRamovak5GeE0zaktBS2d3YnFsVnNmeFFwOGhjY1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WDQ3d2hGSWM2YWFJRzcxak9tL0lIMVdaWEJKNStJdVc4QUthaFF2NllmU1dh?=
 =?utf-8?B?c1BqUkduT2pGbFNLQjlQMzR6TDN4WkhQWlFCc1RuYU5WTjdPZWtaNnBYazlM?=
 =?utf-8?B?SCt3d1RnOFREZ2R1cHBLYzNvVnlTU3FuZGlySjFZS3NIRStYbDc0a1YzS0l5?=
 =?utf-8?B?a09aVzIrSWFwLzcyWjE5MEdpeDVFeklUamVnWDl2N3NiRGJXQXZxeDRvQXVJ?=
 =?utf-8?B?a0xOUlUvM3dqOURrMFVqcWhWek5qS0NxSUhva2J0SHJ5UFFOS1lBSkVGYWZD?=
 =?utf-8?B?Qk9lNE1neFJDWnBnMEN3REx2T01KNGpiQ1E4TjY1a2E3MFRXT05YanVqZ0Iv?=
 =?utf-8?B?V0FBcmZZMG4xaHc3VGJEMVJZWEZDQUZ4SUUrd0V2S1U1azRpZVJoamdXNjZB?=
 =?utf-8?B?a3plSmd5bE0xVXJqNVJBa3RraU9TeEczditvTFZ5RktyaUllSUdCeExIME5Q?=
 =?utf-8?B?S2FQY2tpYXpCaG90T01laXpFV1JGRWlQRWhpSUN1WGZTL0V1aGl6Q2pobGRI?=
 =?utf-8?B?S0lFY2JlMFgyYlR5bXVjcHQzdDg3bXpkTm8wVmVjRnNmbjVnREVSOCsyYnBF?=
 =?utf-8?B?TldUM24vRit0a0pGK1MxcDAwUkk4dkdvUGN5bWNhc3d2UXdnZ2JIdmxrNERH?=
 =?utf-8?B?MW5ISEhnS01PK1VwZUV1U0FxSCt1Rk94RkU2czl0RG1zY1FJcUppSStSa3By?=
 =?utf-8?B?ZW5iOFZmOEl1Qmx5Tk5Db1pLbVFBaXdSa2tjUzRyRGpjeVVlaEpIQ0lLcjlY?=
 =?utf-8?B?QkZtR2p5K0tqQXJEcE9oMGxPelV3aHQyV0x0anh5dlozRjUydDRTaDdOelUz?=
 =?utf-8?B?SVZPQVQ1OEpxQ2hBdmJsUU5YcGR4Q0tsNmVkaVByeG5qRWtnK291NTFMdzZV?=
 =?utf-8?B?ZjVqWW9TVnJDSFBjNzY5NGxSck0rKzAvVzJqTk5XbUdxSE82RHQ1dFlhM3ZE?=
 =?utf-8?B?SjluT24wS0xtaDc0REpCOUdwMVVjeVdmQXkxRGttamhqMWdWbDNwYUFRMDJX?=
 =?utf-8?B?QVJXTnAvbVRSMm9xNWZ5OEcyVElHNnVxT05KcmU4Y2pjQ3NWeTUrNEk3d3ZJ?=
 =?utf-8?B?Vm9lK2FDRU1uWGRweExabDBOU2xTVmplY1VvNjVVTmJNdWd3TzBxMDFrT1cr?=
 =?utf-8?B?Q0V3cHdUQWc1RXg4QXppWEJXVXVDaUVTbkxTYXI5ZGxDUXhoalBaZkYrbXJo?=
 =?utf-8?B?cjlkRXQ4UXMrQUhyc09MM1Rtb1FHWGlqSk9qR2FsQUdiVjVFbnNBWG1iWWhF?=
 =?utf-8?B?Yks1ZmFhUEhRamZTT0RNRTJiMG9LUy90eUFEeSswRjFydEhKajZvS3dUcnBT?=
 =?utf-8?B?UENGZ2k3MmhPSmgyWUt4QzJIQVoreHhjUEgycGRTNVFhUnhYaEZyQUwwT3Fi?=
 =?utf-8?B?cllOa3dTNHEreUxkbW9PQ2F2VHpJbXk3THdPbkE0RVkyc05QWUQ4V0tSY2hR?=
 =?utf-8?B?K1FjcTdZeWNVdE5xNWVRT2NXeXlvWkV3TEZDRmJPZVBIU1B5THZFNGlBaDhy?=
 =?utf-8?B?TGlIOVRBOW0wVmpadE1KNHkzRnJQTC9QbFMrcXJWOVZFbzNqK2V5Ym9JbEkz?=
 =?utf-8?B?c3FNTUFoMVNWZzBXVHo2SmpRQjk5VTZkNy9qTllXSnFVTWlScUR5WXVvS0Zy?=
 =?utf-8?B?alcrbFQ3MVZLWElpVTZhRXlHaTlFTDMwcllGMTd0SkNzcE9BYU9NWUh5WE8w?=
 =?utf-8?B?SnZQc1plcjY2V2svOUpRUU9BNE1wTkhvWkVqckJJMjhWOGdIaUJ2OTFFam5n?=
 =?utf-8?B?T3J3ajlsT1VLNXAzSXJHcjZhS0VVd3JncFZ2VFM2a1FWZm5VTzRlKzNxYkJX?=
 =?utf-8?B?N090ajhwak1BZU16bzNkNkdTanFVVnNDeXljZXIvWkZOWklBbDhyTVI2WGRj?=
 =?utf-8?B?K3JsRmJSaUYrVkxvY296a1RKb3pDMEg4NE41elhNRGgzeTlmaWdFMFlldEZ0?=
 =?utf-8?B?aUROZEtDR25OVDRPTkNxa2xGMitsQmFudGc1UFZTSU1mNDdnZzBEbEJrb1dC?=
 =?utf-8?B?WkVlNXlXY0kyN2c3VHRFMW93NjF4aVYvYmFEazl6eWVOVmx0Y25jSHJCbnI0?=
 =?utf-8?B?MWk4amJjWVVtc3RCYXZ0S1o1R2ZYSVVId09jTmxiSm9uVmc2TnpBUTd3NTUv?=
 =?utf-8?Q?scNjWpDdW53vdkMDI3XU7OVO1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E31AB2ACA42F9F409C65280DDF174C2A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xvTcYsEhsQSgKHezNv0MzDPmEboyvECldYWTNde1NFqMdLynZIcHm2VmTPF9upE26YxMKA79kS8qbXVCcdjXVauj6gE7bXIo7GqhTwDResR3bSqyaldhFX7SyYx/fbCdViCyAf4ByTq8xAh9YaNtRYGsSBjiSnBe6vbqHvGYTIufFZpC7v9r5oWFgilgLbIAL9auoo4T/vqcrQXQwE1ZQZuIkQgOK5h7tO/0fs3w8zFe0yj5SAHe/Rwp9/W1S1ucy974/PVNPSDG8P+nm4zoPuY5B3NxSHXvKhleIJj1d5GZ68GS3JEkqX1Vf9lEjNz10a3/EV1S77Pb3OcFJvu1eXormUPpmgmNoLMgh3ggO6+6Nf67gZkrTl65jqySMzlsiEC/YgDHfmLANBKgZyBW2P+bL/1WqjuLvEluFF6AVzl0+2fflFTOUvppY6t3g6unCz2SicpMpDr+pbooG0lhy2R7hFbqw6BdzG5ibynfLxFZ9WTavhURSCncdD2A3gl+p3VeljYUoKbxol2t8JhOJ0JMmIcAwE+2ACdBDKhb7OrnC/KY9BmtgcZr0y11vv6V/4+BdWCGldLYNUaFSqVbRDbghKYTbEU3RaKRnqX5oxfX6WzdkiyxWf7MpXMcJBciWRr8a/f/uvkkTQdy8K8I6A==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71aef010-7601-4880-a67f-08dcb66fb9dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 23:30:15.5205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: byJta/Y/XKg8EzuLC7ZJJaT4ZQKmBhe4h+q7/vc4qZWgOg3rs5a0xJOXiQB5dKINWwjVzrPUm1N7ldZyFjSKfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8588
X-Proofpoint-GUID: uAkFkT-BrYRHQFHG5WsK334Mx5NJ7Zo-
X-Proofpoint-ORIG-GUID: uAkFkT-BrYRHQFHG5WsK334Mx5NJ7Zo-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_18,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1011 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 impostorscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408060165

T24gV2VkLCBKdWwgMzEsIDIwMjQsIFJvYiBIZXJyaW5nIChBcm0pIHdyb3RlOg0KPiBUaGVyZSdz
IG5vIG5lZWQgdG8gZ2V0IHRoZSBsZW5ndGggb2YgYW4gRFQgYXJyYXkgcHJvcGVydHkgYmVmb3Jl
DQo+IHBhcnNpbmcgdGhlIGFycmF5LiBvZl9wcm9wZXJ0eV9yZWFkX3ZhcmlhYmxlX3UzMl9hcnJh
eSgpIHRha2VzIGEgbWluaW11bQ0KPiBhbmQgbWF4aW11bSBsZW5ndGggYW5kIHJldHVybnMgdGhl
IGFjdHVhbCBsZW5ndGggKG9yIGVycm9yIGNvZGUpLg0KPiANCj4gVGhpcyBpcyBwYXJ0IG9mIGEg
bGFyZ2VyIGVmZm9ydCB0byByZW1vdmUgY2FsbGVycyBvZiBvZl9maW5kX3Byb3BlcnR5KCkNCj4g
YW5kIHNpbWlsYXIgZnVuY3Rpb25zLiBvZl9maW5kX3Byb3BlcnR5KCkgbGVha3MgdGhlIERUIHN0
cnVjdCBwcm9wZXJ0eQ0KPiBhbmQgZGF0YSBwb2ludGVycyB3aGljaCBpcyBhIHByb2JsZW0gZm9y
IGR5bmFtaWNhbGx5IGFsbG9jYXRlZCBub2Rlcw0KPiB3aGljaCBtYXkgYmUgZnJlZWQuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBSb2IgSGVycmluZyAoQXJtKSA8cm9iaEBrZXJuZWwub3JnPg0KPiAt
LS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvZHdjMy1vY3Rlb24uYyB8IDE5ICsrKystLS0tLS0tLS0t
LS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1vY3Rlb24uYyBiL2Ry
aXZlcnMvdXNiL2R3YzMvZHdjMy1vY3Rlb24uYw0KPiBpbmRleCA2MDEwMTM1ZTFhY2MuLjFhM2Iy
MDUzNjdmZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLW9jdGVvbi5jDQo+
ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1vY3Rlb24uYw0KPiBAQCAtNDE5LDcgKzQxOSw3
IEBAIHN0YXRpYyBpbnQgZHdjM19vY3Rlb25fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCj4gIAlpbnQgcmVmX2Nsa19zZWwsIHJlZl9jbGtfZnNlbCwgbXBsbF9tdWw7DQo+ICAJ
aW50IHBvd2VyX2FjdGl2ZV9sb3csIHBvd2VyX2dwaW87DQo+ICAJaW50IGVyciwgbGVuOw0KPiAt
CXUzMiBjbG9ja19yYXRlOw0KPiArCXUzMiBjbG9ja19yYXRlLCBncGlvX3B3clszXTsNCj4gIA0K
PiAgCWlmIChvZl9wcm9wZXJ0eV9yZWFkX3UzMihub2RlLCAicmVmY2xrLWZyZXF1ZW5jeSIsICZj
bG9ja19yYXRlKSkgew0KPiAgCQlkZXZfZXJyKGRldiwgIk5vIFVDVEwgXCJyZWZjbGstZnJlcXVl
bmN5XCJcbiIpOw0KPiBAQCAtNDc2LDIxICs0NzYsMTAgQEAgc3RhdGljIGludCBkd2MzX29jdGVv
bl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgDQo+ICAJcG93ZXJfZ3Bp
byA9IERXQzNfR1BJT19QT1dFUl9OT05FOw0KPiAgCXBvd2VyX2FjdGl2ZV9sb3cgPSAwOw0KPiAt
CWlmIChvZl9maW5kX3Byb3BlcnR5KG5vZGUsICJwb3dlciIsICZsZW4pKSB7DQo+IC0JCXUzMiBn
cGlvX3B3clszXTsNCj4gLQ0KPiAtCQlzd2l0Y2ggKGxlbikgew0KPiAtCQljYXNlIDg6DQo+IC0J
CQlvZl9wcm9wZXJ0eV9yZWFkX3UzMl9hcnJheShub2RlLCAicG93ZXIiLCBncGlvX3B3ciwgMik7
DQo+IC0JCQlicmVhazsNCj4gLQkJY2FzZSAxMjoNCj4gLQkJCW9mX3Byb3BlcnR5X3JlYWRfdTMy
X2FycmF5KG5vZGUsICJwb3dlciIsIGdwaW9fcHdyLCAzKTsNCj4gKwlsZW4gPSBvZl9wcm9wZXJ0
eV9yZWFkX3ZhcmlhYmxlX3UzMl9hcnJheShub2RlLCAicG93ZXIiLCBncGlvX3B3ciwgMiwgMyk7
DQo+ICsJaWYgKGxlbiA+IDApIHsNCj4gKwkJaWYgKGxlbiA9PSAzKQ0KPiAgCQkJcG93ZXJfYWN0
aXZlX2xvdyA9IGdwaW9fcHdyWzJdICYgMHgwMTsNCj4gLQkJCWJyZWFrOw0KPiAtCQlkZWZhdWx0
Og0KPiAtCQkJZGV2X2VycihkZXYsICJpbnZhbGlkIHBvd2VyIGNvbmZpZ3VyYXRpb25cbiIpOw0K
PiAtCQkJcmV0dXJuIC1FSU5WQUw7DQo+IC0JCX0NCj4gIAkJcG93ZXJfZ3BpbyA9IGdwaW9fcHdy
WzFdOw0KPiAgCX0NCj4gIA0KPiAtLSANCj4gMi40My4wDQo+IA0KDQpBY2tlZC1ieTogVGhpbmgg
Tmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGluaA==

