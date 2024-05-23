Return-Path: <linux-kernel+bounces-187672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D79D28CD63E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A671C20A2D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE28863AE;
	Thu, 23 May 2024 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BQF/Kfck";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kNdi4PhD"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8272901
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716476089; cv=fail; b=V/FS9TsmDSkFMrO8ut2eIClrlyuzMh1gyz6Fzyhe30SYnCd3iG1CgSULCwik5wAqsfsvy2oX7+//ErsAYEJpm3Qe1J+6AHOqPKes2QLy7rYx2MFXCYUP6xipsU9ypbfpHwQuusexF0eCwr/cEL0KBItsn2v7yUtNTHCOkIerOwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716476089; c=relaxed/simple;
	bh=RIBBFlFpkRk7EsAkZUM1igN2lWAVfjrFYmzYmaLIRjY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F56qIEM96ShBDF/a5u7D50DJD5CG0NdR2YRk7rr3mhjH2iioB8YLTWQ/GKzXG66v/2/e0P670Qjxp4Vxv8GFUGKEwotI/c0kLjXZxno7QnsyVLfT/x3qPT96H7B4XBOL+GT92sI53CJkxElHPiZcK/AQhiaRRAFthGYXLY159A8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BQF/Kfck; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kNdi4PhD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44NEi0Ec004382;
	Thu, 23 May 2024 14:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Vc4CfOIzdURe8EEFccWJbiltjz6PlSDf48ALshbHXNs=;
 b=BQF/Kfck72ibDbQ4GFK0m4KxnHRPK9jdqaIzcQOVsU2PBSHvfQ++lA86l0H2CesG/hRA
 lzZOOhzYdrut8KA2B9IC+HBVDz2uKR6NUDKtwZDQz/bwQLq0Pa8HkJOqptZxPCRmYUmc
 WeYxNOmSyhqgz5LQeti5mzJ66GuzpD8iA8EW5crYck9LmFqPr+n3t9uQgxxy7y6q4Tq/
 C0psJ6tUruNHwne2ILZf+nu94V1ik5ItX/EpdiyKmRPluBr27knFVTJzV+sKZSB+gneY
 hJrHAwUUd2P/EQyPe9CLBQw2hsQ6jbxamKFQgzBFZ0AlClpAkRgijv/YixjNh1ZEBOd5 Eg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6kxvac7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2024 14:54:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44NEVIZL005063;
	Thu, 23 May 2024 14:54:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jsb1w5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2024 14:54:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEsky8YZdwrDerqo1hyjwaF3hOljZI2GYGoQNNtVsxvvPAauHsuClke4pAi3OmFKpIzQbBgdkL0pSAWPdFqXp3IaJ7yVjCNXxp56GR2jvS9rJIqd3c2Z9VoWl6QAdwqjUtAZwgmiY5kJgvzc5T6cw9rN+RuuPz9FVG+Y9+wnM3SqhjLPk1332G9ylDbN9X8HsLM3zy6r+mPLHxSSl6WEnxZ74NEXbfoXoITTmtOQS23V7kOLLH9iYIkk5dlnLJNYAOhSsweoBtYX8OxbCSHB/gZVok2V1SnVjHsP8j3ut8mIEIBBjLWKGVlAEjZA2wDYJpLDJt7kfAr0jOIR36gyyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vc4CfOIzdURe8EEFccWJbiltjz6PlSDf48ALshbHXNs=;
 b=MqirF4E87cKG8zOz6RYT7lsb4VYg81yfWPmosmn39XlfXNgzdflXk2Me/F1YChJdz3rOWG4KLpNyMX+K7Kbn8rDUe//LSSkfEcIZfoJS6oOO/lXKwYQPF7bI0bM9mVTso6q7iZEl3Le39h8PHkqr5lS+qRJ7b/+BTwwjtxuuKKhTF4NA9jCgcGrGpd7wiOz+PCPwhoocGRGOQMhEmVx5BCD7sCp6SO9IYIPq5eVJ4EGnH0j7EeG3Majr85DilrCVS2WwX9nKVydEIOs7SmBzlNYqUf8PekZT5UNS7hbJOK2hgDxLRWBFLBtM22U/Ri8FQkvDcDUSfX84kQkphChstg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vc4CfOIzdURe8EEFccWJbiltjz6PlSDf48ALshbHXNs=;
 b=kNdi4PhDjcjEomNvz/h5POWzryoAbVSDz2LlraPDr3t4LCLIEPOI5m3iq9U6yKsRQb1s5dVIGZFKBjqgMS+apEXt2skilIHGD4g2jMK4JdPvuFwlgCmzuSBnm4GJon1EkjUy9+1MNfo9UUG2xB12WPFzxUzilD17mxDfBfizNwQ=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by CO6PR10MB5553.namprd10.prod.outlook.com (2603:10b6:303:140::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 14:54:38 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%4]) with mapi id 15.20.7544.052; Thu, 23 May 2024
 14:54:38 +0000
Message-ID: <749c70b7-b405-4ce8-8418-69172c5cd515@oracle.com>
Date: Thu, 23 May 2024 16:54:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2024-35876: x86/mce: Make sure to grab mce_sysfs_mutex in
 set_bank()
To: Nikolay Borisov <nik.borisov@suse.com>, cve@kernel.org,
        linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
References: <2024051943-CVE-2024-35876-d9b5@gregkh>
 <3eadcc8c-d302-4a70-a16f-604285c1257d@suse.com>
 <a7bc8570-4001-43b6-902f-d45de27fcb02@oracle.com>
 <01e1183c-46c3-41ca-8b47-d008747c164a@suse.com>
Content-Language: en-US
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <01e1183c-46c3-41ca-8b47-d008747c164a@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0167.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:236::10) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|CO6PR10MB5553:EE_
X-MS-Office365-Filtering-Correlation-Id: 75e7f13d-0568-4fe7-4b25-08dc7b3844bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cmRoWG1tUk02NUI2aWpCbHRGR3FXREw1THNyLzJNYUJaSUk1dC9YZnBLRTdL?=
 =?utf-8?B?dElZQ0dSYzBOQ200UDVGdXR0bEdzbDJrbzVxVnlmWCtXZ3VzVkl0Y0hvNzZD?=
 =?utf-8?B?NkhWc2hCTHFDeXNwYnFLOUs5YjEraDY5QVQzeW9JZUFsV0RvSldUa0FYNVZE?=
 =?utf-8?B?Z1JYMSs5U2tKQUphUHAxcWtsemFwQm9wSDRJdGMrcThrMHdubWF3WS90cmR0?=
 =?utf-8?B?TzdxcHJZQ2lONW5wN3ZUNzlYS2tEaU5uUlBSVWU3eHdBcUpoL0JFNG5GYXFZ?=
 =?utf-8?B?RkFiT2hvVWoxU1NTcCtLQTNTVitUMVVWTmRTZEJKT0ZpeW5UYnM3S3pjbFo1?=
 =?utf-8?B?QTAyNmgraTZMdHRnc0JhMmhiSmxSNjRmeTAyV0grNUpXSlFIZVcyOGZZYlQr?=
 =?utf-8?B?K2R4R3lWQUNlWnJicTBUMW5DT0FHR3BQSVNUUzIzZkl6cWt5UG1YR2dLUENW?=
 =?utf-8?B?ZW5VbncrVzE1YjlIcDZwc0pib2htMlFXelVKQVYyZXFOWGlGcmlnbVhSZHp5?=
 =?utf-8?B?eFRZYUNYc0lWRzFIdUtvR3lCVWIzeU9SVGZqd3U3RDRyY2tzb254d1BzemtW?=
 =?utf-8?B?RlNaSEFKTDVVVGI4TE5TaTNiUmhBSGdGTUt3NnNvYUJtQmhWY240SEZXVmZK?=
 =?utf-8?B?OTAxMUJLMk04djFOeHh1YzZHSTU5K3hEallpQUNrR01PQ0laSlljRXZmejRH?=
 =?utf-8?B?cU1qVGUwS2xpUWdTY0FVTlQwbElqdmsxclBtK09rcVRXSGZZcnZhNWJUa3Vs?=
 =?utf-8?B?SGRYck5CTm9rZ0lDcDBYdzUvNnZuYjBzUUpYakZkaW5Pazg2emc5Mk4rd09O?=
 =?utf-8?B?aGdKS1ovN0pOL01SbzBycFZ0WGtYQTNSeWs0SkRpclJCMVloUU5lWFp1QXI0?=
 =?utf-8?B?ajdqVEs0cFQvL3VMMFk1alBmWURDT3ZKTjhianhMU25aOFV4Nm5oYjdEUG8r?=
 =?utf-8?B?d2tiL0xNaDduT2t1TFI3VndlUjJmWDEyZXY2RlBQcS8wU25zYnBkZ0VXcTVx?=
 =?utf-8?B?RWdkd3JFb0NNUmZvNXo4d3lRQWtLSHc1blpyMm8xcE81VmI1cVc1bFNTZUpB?=
 =?utf-8?B?QkIzVWNOZTdJKzFuVXJENWx1U2k1T013ekZaSWJNbkhEaHZQbU1vSzhHbzRq?=
 =?utf-8?B?SGVmRW95U2NEQlQyY1BsRVNXWFlhTDRZVlhmZitwQjZiQ25wS1p2SVlVWmhl?=
 =?utf-8?B?dDB4UDJReG0wL3daY2pSYys2cWtMczJVbEhrVDg2ZCt0bmxSK05BbXNIdFVr?=
 =?utf-8?B?QmFqd2hpMnFlNlQ4NDNGSXZNcmdJYjVNNW1Tb253QWxxS0JEUS9ZU0dRb0RI?=
 =?utf-8?B?citPR01HTm9nM2lXU283dTg3MG5pTWJ1dnorQjFYbFBrUGVBNUZsRHBFUkVQ?=
 =?utf-8?B?YjFlSTN5ZlN1aTZ6T0p5WVMrd1BVMFRCb0I5bHlKZGt2ZWRNZUg5K3hDek0r?=
 =?utf-8?B?NGZyYXQzVURGMi94Y2JzQ2NSK3FaOURBclA4aThDb1JveUZQaXlXVTRJQURS?=
 =?utf-8?B?dDNhcllqWXhoRlEwY2Z4VzRmaUxSRmtZcU9yeFFDN2hldlFOWll1ejlTckpM?=
 =?utf-8?B?ZkVOM3RRR2U2ejdkRlhDL2dwaTh0Rk1FbklNQkRGbmhlc2pvaGV3MzBuUGp1?=
 =?utf-8?B?UVFPaVNBRTl2YmNuR1l0Y3R2UHpaNHQwS2JUY3Jlb0JCUWMvS3lyMFdaNHVs?=
 =?utf-8?B?ZjMxSnIvUGhvK0lZdyswZ0Y5d01JRUxuazAvRFJtTVpzYzBVRTF5NjVnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aTFUeVJYWGxRbVBqVm1YeTZTTS84NnJrVnpvVnhzcGJ2Z2RBeDdhRGFHcERs?=
 =?utf-8?B?RTBnSkpBMU9aandtQzhzU0RDSXNQeW9vRGNYS0xuMDloemxvNjNhN3BQbXZw?=
 =?utf-8?B?VFNxL3hJUFZXdGhXOFRDbzRkMmxIMTFNRUgvZGxRbWFtN1JwcXdSdm8rK1c1?=
 =?utf-8?B?Z2ROajgyR0tmTVNMRWRRdnd5KzQydkVCYVNUdTBrbUZ3LzZreU5vK0M4QXhp?=
 =?utf-8?B?UngwR2YrMmNNaUdjaHpaK3d2QUJScVJMZW1pR1NLeSt1ckxmZ3c3cnNFOXhQ?=
 =?utf-8?B?cXIrVnZqQlRaZE1CTS8yaGwrVHFoNUVZaklrUThjaVN4U1crOUpsbm10L0tS?=
 =?utf-8?B?cnVkMlZGUjVoRWZJRHR1OExCS2V2V2trSjhHVXlqZGo5S0o4QmwwZTJFaVZv?=
 =?utf-8?B?YzZDckNlNkFOMXh4QW9uR2N5SGRSTDFWMVFNUXFmakhUUG9iRWJxTGtsTENt?=
 =?utf-8?B?VGNUT1RORktxNXdiL3hxSUtvR1N2SjFlSm4yM24vWWh4QUJ5dHg1MGxoai9E?=
 =?utf-8?B?VmI4L2J5N2ZCUXo5ODV1U01lc082RTdiUnVzN2ltU2JKUFR2ZTVHWWJKNktC?=
 =?utf-8?B?Z216WHpLSFZTd1loK1NLR3V3ZjlJR05CemQ1VzlFaUJIWGZjQXdNWUE5Q1l3?=
 =?utf-8?B?ZTl5NS9wTy9TQlg0dzRadWtIeTZ2ay9EVFIzUWZKMk9oNng1dWJ3MEJLTlA2?=
 =?utf-8?B?MjIyRXZ2R0xqSmxlTzQyejU0TlRRZGVLY3JZN1NxQ21JTUtZV2tHRDJkeE1s?=
 =?utf-8?B?aGI3amFWQ1pRc3NNRHpjRE81SzllOGhEVklUL2ZxOC9zUXNlN2dDQTN1Vkpq?=
 =?utf-8?B?MFdMWEZkOTFoeHZBbVgrRWdSeEJQR1MwaUU2L0diUzlLaGxpREFPV05UaU9P?=
 =?utf-8?B?V0hWdTM2eUNxaCtpVllSMzdEOXptSWNOQjJCVGpBSVU3aWxJSlBZUjRMR2VY?=
 =?utf-8?B?VUsyejBRUWF0bHZMbCthcUIxNlB2Ym9mSGJoNnBWemZXQ0wvOFMwN0htb2hp?=
 =?utf-8?B?ZDJ0VmZCNjkwK09oaWNDcnBVNEorQSsrTUUxVE5PYjBvNlRkYkhTQlB3RklV?=
 =?utf-8?B?UnVXUDBySTdEaDZWeW1VNGRQUXBKcnlHUWJ2TkVNYno3Z3piYlgzQXBzR2RF?=
 =?utf-8?B?STAweFpSSzE0TUpwWEFHa2RhMVRqV00rVW16TzlZa0gvZ0ZXMzIvL1kzNnBT?=
 =?utf-8?B?UVFKVXgvSC9uRzRsK1h0dlJ6UHNUOFdweEN5bXZ3VDl4ZldDcHZ3VDAreFh3?=
 =?utf-8?B?dDFkYWdiYlRwM3ErckVSTDc3ZVFrN1lJRVk1Q2lXeWh4WE8zYmdYRko5NXZS?=
 =?utf-8?B?WER6eEEzY3c0ejJHS3Z2SkZOelNpbjlBbjhZWHEzUVdVU1N3T0NndEVIOHV6?=
 =?utf-8?B?WG1BeHpxTWNhdmZBemRhZU8zRm41ek81WUtMQ1FBVnlBRXdMdmgydFBERzJ2?=
 =?utf-8?B?akJ6RzNuNW9vNHJQWjYvOTdYbUVmMUVIK05la3NDbGgzaFVEeXF2MUJNNy9P?=
 =?utf-8?B?b2N3WW9EZ21xRFB4eFFnaUpSWlNYaTRnMGxqb3dHQmc4UTVhZGlRYjdCZnhk?=
 =?utf-8?B?aTJoWUxCZzBCZ3kzWWYxYko2Q3Y2VjZvR1RKcnBLd1dpTFRqeEFVUmQ2TTlo?=
 =?utf-8?B?eUlvVTNGV0NXOWtTb3pJRDdEMGlqc1pWTDVyR0pZUjVxODFsUGRPNFFHRUF6?=
 =?utf-8?B?NlZrZ3Nvdy9oNlVCZ0lVV2VPemVKRUs5RlZaaGsvazdnTWtzZEZqYTFPYVRm?=
 =?utf-8?B?dkxRREllb0J2KzM2TUhnVlorSzVLZitFMFZOaDJBc2lQTnJPOUcxVmFaWmNE?=
 =?utf-8?B?NjUyenJGZWcxQzFCcWVNajFsblBxY3lrSnR4UEVXa3JtTkZiNHlsV3F1Q0xl?=
 =?utf-8?B?ZTBidUw2ZWhGNTF6a24zQXlkS2xpNTM3dGUwd1hzdjNqeWVWNE9SSUtpYXRK?=
 =?utf-8?B?bnVram1HemxqeE85VWlCUFlGOWQrUTNxRW9IN0ZhRWpNSmE1bFdkQU9vaHd4?=
 =?utf-8?B?WGJlQ2F4UFYwcFZMN0xUekQ5SXZvN21LZTZDdjBGVU0rV1VQN2NRUVlsT0VF?=
 =?utf-8?B?RHBGSFhVTzBoZmNQK1FvZE5tazh4ZE9rQVNxNjg0SXhyYThGcjN4Uzd6c0dy?=
 =?utf-8?B?UTVUdWlOWmlHbVhDY2doSmgxbUFXVUkxTzRJMCtPQVlIY29yaVo5aVFuMHE4?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	LN7xcfhgXEQEvABkLWh0ptUzfUO6OWXj+srZQU/9Wspf9NAoMVXxHW8pAkNDrxvspix0KBvmtIkcSOJ8ujs2i+O709Cm8k3F8wHMF1uHVyUXXKug9Dn0h5uzywGANfIk07tJ5R5pb+WpYsA6CXGRH31hvGQ6aqexyTENvpWM1anQ9bvx+5FpncH0n530iHVBNxDZ0+Kq54sthY4H/VpbVoBET7UHrKzAc30YcS/4L9pGq4SoQkZ2IhPLM6i8MetmwqZ6BmbODB/h9FTsqSBClh9xt4KItGGNYjDSQkwHWaW8DpJW1UTr27g0W/KkTyVTkMElsKKlbeDK00tnyomBsJWbfPSvNgAJmGSS3fWk1bA8GQc/mNe3w69qMikf365Nsza4NhGLt/0lotpgAItJFa4BMhxjjEAWoqu10TVMSZ31A5FfBCWlPSTd/xJlLK51aD73RD52K5QL+VmO1K2ZoC4TnG3ON/22m6k1m07yx7daSsMsGSPvad49mziWlhT7NubZCT9Md9Z3pMTXesUlvGdiXfKwpNInKiCMpWnih/CFusyglsjTJjGLQrP928P8jvU4AJJaMlGce6mPnrp4v9cO4Z4evRfVLLUbC5xPnMo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e7f13d-0568-4fe7-4b25-08dc7b3844bd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 14:54:38.3812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZR2S6k4O/IEfZF1iBKzGOdHAMNi+t5HCmX2h4fuIfpGG5gFMBQtn5MPcuytzwGExtaaLE1CUsmMJ2XjllC51WlK+QDvMgsVHXOx6qcTeS70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5553
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_09,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=772 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405230101
X-Proofpoint-GUID: ItnbK5ELI2kPCPOg_9zufDyFt3HSV9gM
X-Proofpoint-ORIG-GUID: ItnbK5ELI2kPCPOg_9zufDyFt3HSV9gM


On 23/05/2024 15:58, Nikolay Borisov wrote:
> On 23.05.24 г. 16:54 ч., Vegard Nossum wrote:
>> On 23/05/2024 12:24, Nikolay Borisov wrote:
>>> I'd like to dispute the CVE for this issue. Those sysfs entries are 
>>> owned by root and can only be written by it. There are innumerable 
>>> ways in which root can corrupt/crash the state of the machine and I 
>>> don't see why this is anything special.
>>
>> I haven't looked at the issue in detail but it sounds like this
>> potentially breaks lockdown (which is arguably a security feature) so
> 
> How exactly does it break lockdown ?

Well, I don't have an exploit and it looks difficult as there isn't any
user-provided input involved.

But generally lockdown prevents anybody (including root) from inspecting
and modifying the running kernel. So if this bug would allow that, then
it breaks lockdown.

Glancing over the code it doesn't look like a use-after-free, just some
unspecified concurrent access. I can't tell if it's exploitable. I'm
just remarking that "requires root access" is not by itself a reason to
reject the CVE.


Vegard

