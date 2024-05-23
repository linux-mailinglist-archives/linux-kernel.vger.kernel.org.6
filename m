Return-Path: <linux-kernel+bounces-187947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 373688CDB27
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 21:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE85E2818B1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 19:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37D684A4F;
	Thu, 23 May 2024 19:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P6KVC12v";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W7hi55/L"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF43483CDA
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 19:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716494338; cv=fail; b=lQduLhvxpl188GeR5/Onh8kyVATVWGOcy2sX/XsD9vicZKHIxy0SrWtXVrVhZdcqs5cVTv2oQG5nxxlYsjOLe7AT8YT4lMd6nEkjcu5W4HkXFKo6hwyfaVP9+9xXgE9RArmYNuvfmGS6QYKVJlj6bm5eMTDg7lReQdOQ8bFLYgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716494338; c=relaxed/simple;
	bh=KjtptegY6nBK5nDVXK7Gksa59h6CZe3VDIaB8GQff8o=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J7wngTBSlTgvtdCLTg+ml9EvQykR63dxjFU7DGN5uPBPx097TdV6rbBlpn5Q3UocIs7njkv6wodShxRAHBCGJls/TlpQxfmuz4kSEqvRL60TtVjixrhdyn0sBL6p7C6dEwaW20k55SFQSXh4bfRZfrhO+rb5iomKUKsKKSjVxMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P6KVC12v; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W7hi55/L; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44NIwwWW026905;
	Thu, 23 May 2024 19:58:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=mGtRngsEWGnePsDR6FY+XcWMFaUVCHE9JZs9ZHoMvYY=;
 b=P6KVC12vo1Wc6P4x3J0p2SrEl8NMCXmTy/l0g5Qidq1Bj2L8njShkqY7tlf1GeZgwWEV
 gD2BC33fUHcIJseM5qZCyx6naXvhEclXhiC7F0dI3ZQiwX6Pg0wkO/AOqz445ZO2lSpM
 tmkAvI16wC2EqLm4ImE0jupUWompvMzkZAXmo2MVvxarVewXzioslR0xSPSVCSHC4BeD
 dz8oWCVZTHq3sBnmMGxyFJV5bSSqlZ0jz/o9GcA/7geHkGhOWmUtHb4cLFhp2WXDqRJW
 SHdDzUxk+yjNA2ytfpJal7/D84ZxgOqSw+bZ2dHGw9Z5aw0YqMEKxZMPFel/sWvE1nSq KA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6k46b41q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2024 19:58:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44NIcCvv005006;
	Thu, 23 May 2024 19:58:39 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jsbebqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2024 19:58:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcuvCY5RGlzIhbN9KbCa8M0NaTk2IwlZdawJniyRY0m8XNMtX6uWofmI7p9e+ECtHRiVFFQR3ZS+7ufjP9ehzJYk4FsTPVAcjSU+lSoNxyjgkRuNj91B6G5DEulNi1ow48MTbv2bzpspBgsAVutDKqMV0Ats7SRfUYgB8UU2jWGZkhzMzEVq6QZgCdpOZAZWL0Fs4KDbPi9AlkqyAPQY/aPTm6V3aP264mdDEEsS1Zy6RsQApsacJUcgdrAiXpZgyD3fYOVea1moRyPR//GWQcH2aGqeDGstkxw10Gu4+yUtqjBgbF4VkL+Ndwp3VszgOoOi88jfGBEB0ssHotXdFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGtRngsEWGnePsDR6FY+XcWMFaUVCHE9JZs9ZHoMvYY=;
 b=XxHxXppyb2bMTubKGPsFUdT5pX3fBdzL/p6hLbQm5EzHgN8Gq3r7YuJEz6MnXfDsw9uc0WAiqw5rvl1X0GQpbry7zWEMOrU+w26cfEu1segJKOPLRK1mEXV+oxRD9HzS0LQLHCvixlaFBQUkxZz1rtR/eTFKoGreOV3gVNPSi+jkIlizl1c4GYa+b+Owh4q8cW6ng3I57x2swGxbzI4saLPpjC9q+hjvAbfFrGy7wyPYHzyxgox2vThwiCMbEHfsvA/86w4Ir2MFTFpbXuxnJ9OM5yuhaREs1qCLShEvlPqWFw/LHkcoADxQYwDsHNYh0w9VtjhGTYMPY5suxn5XpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGtRngsEWGnePsDR6FY+XcWMFaUVCHE9JZs9ZHoMvYY=;
 b=W7hi55/LwoFtSaNaa3pwrUm1iIbqCWe/RZHEMeYShjYA4fs1pLY0P7Grs+5/+Cm9baI3Iq2XdEOiX15bKhtqU5YoBfkKXGxMBvf9LFZzSqtGrgS4+T0vmOQFmdZTAWQx9R8/n3JRfWE/moc4SawZshH5mVnAYRWVQ0dDxY8lA8s=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by PH7PR10MB5829.namprd10.prod.outlook.com (2603:10b6:510:126::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.38; Thu, 23 May
 2024 19:58:37 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::3db0:ec21:1957:f1b3]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::3db0:ec21:1957:f1b3%6]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 19:58:37 +0000
Message-ID: <cb88f1e9-4e95-436e-90db-4ea58e30fdc8@oracle.com>
Date: Thu, 23 May 2024 12:58:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] mm/memory-failure: improve memory failure
 action_result messages
To: Miaohe Lin <linmiaohe@huawei.com>, nao.horiguchi@gmail.com,
        akpm@linux-foundation.org, osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20240521235429.2368017-1-jane.chu@oracle.com>
 <20240521235429.2368017-4-jane.chu@oracle.com>
 <e6827d64-0f05-6874-7566-35d56782a6aa@huawei.com>
Content-Language: en-US
From: Jane Chu <jane.chu@oracle.com>
In-Reply-To: <e6827d64-0f05-6874-7566-35d56782a6aa@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::15) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|PH7PR10MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: dac60e56-beca-4792-cae6-08dc7b62bc29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?andRcEpGaFZEbW9XZmdBbWUwREpNYmhkalRWNitreE9jb1ExNUlaOTZlS0Zt?=
 =?utf-8?B?ZEpDa2N3eUVBN2V3MGp0Z2FzQWdWK09pRm50bXh3OGFaU1doZExKOFZmQ2h0?=
 =?utf-8?B?SnZ3aUJFTEJmUmFsRGp5L2hEM3NrQTE3WUVnZEtOcXo0MFh0cGtUSHN4Zk4v?=
 =?utf-8?B?dWJBdmkrV3lHdjc4OUo2SnNDOWErV1J6RU5FSnRIUnVqZjlEc0tSN3FMRUFq?=
 =?utf-8?B?dXhLSitzejFPQ0xkMEpkQWg5Y3lRUVZBREh1a09qUHladGgydkpaMVpkVnE5?=
 =?utf-8?B?WU5LeXdTQ0YwZmpPWDZaVGV3N1g1aTFYd21NWnExOC9vYmRlYTBTSmpNY3Jv?=
 =?utf-8?B?N250QnY5OXZQQStaQm9Xc3ZMZTRNM05Rb212RHFlMFFlMlpMdWhHRTByeTl0?=
 =?utf-8?B?NWo4QzRsSEhDdEk3TzNGVFlqVnRBOHJwdXAxandQL0ZxU0N6VUl0bEswK1Ju?=
 =?utf-8?B?REJmYitIRm55SCtGMGsvTVFTYlV1dXBTQTgrdmVKRWIwU3NjcVhZMVVqcFBF?=
 =?utf-8?B?ak9Da2d3TWZWbUdmSkpFTU1PVFQ2d2kxd0ZqaFZ0L3FyL0ZnQ3JWN08zVDA3?=
 =?utf-8?B?TDlzcXR5RlRHRWpEcDJHdWdSYlFuOGhUd1ljdTEvVndNY0xZQVkxUFQ3L2Nr?=
 =?utf-8?B?QXgveW5hVDB6eTdhYVljbjdZMndTVnZSMHZobjUyNVhmL2hiY3FoVURkUHhl?=
 =?utf-8?B?K2RFVExrU3BGeWpZUkovTEpNWXhFZFE2akNmU1ZCQk1UYlBzS2lFNU84eDAv?=
 =?utf-8?B?bkJxK0JsZEVNSkl1VDZVZnNPM3RTVVBzcFBQK1JCQVpwSnNNOTFNMzhTKzdk?=
 =?utf-8?B?ejZ3c0d2NXdmcFV4K0J3LzZWekFabG5qWCsvdWErbDVDQTN6TVF4d1U2WWk3?=
 =?utf-8?B?cXprV2pZNC9DckVpd25TZnd2VzBtVEZBL1BsMWJLSVBwYk5ESXFiQXNFbGky?=
 =?utf-8?B?QjRVQ0p2eGdJa0dxTVVtQlQrUkUwZ0k2dDVFSHFZemo4c2VaWlU2UHFaOXJX?=
 =?utf-8?B?VEpaZlo5RCtjdmU1Uy9YY25SL05YVnVVblowY3h5K3pySlIvcXFnWnlQcDlN?=
 =?utf-8?B?TXVuSEZZekZsY01CbEF6RVc2WXlITGhZeUtPdmxiNGdydXFzazg3WldTODNt?=
 =?utf-8?B?bk5ic2FwSUVVcmNET0VKZE9Yc1g4SGxjWjRraEcwbjdsVVdzYXhOWXpBV3Rt?=
 =?utf-8?B?QjJ4RGFXRC9pL3dNcVcycTBiQ1Z5RGhSN0dxeWd5VHJjQ3FybUN5QjJ4eUtv?=
 =?utf-8?B?clRiQTNTMkpNYTJpTGIrTVI2UzBjZjIrZVM0NXNpeTRoSC9CdkZ2TTArVFlT?=
 =?utf-8?B?aGdvSkhYZDVFYmxvaG5RZ0xXTHRZSzVsbndLRFdiNVlhT1RHbEFjUHFFSVVx?=
 =?utf-8?B?NG9HbjV3aFUzb0N2b0JsdFpmeTRiTEE4MmF1elRPK2ZqRkpISFA3bGJUaS9P?=
 =?utf-8?B?U3g1RUpKYXQ2ZzhFUE5oNFRkM0k4b2FXc0Z3VnB4UUI3aFg2WW5vUDRDOGQz?=
 =?utf-8?B?S1k0ZVJla2w0eVRsZG5GdWJ4dHFuU1pyakdSQU81bUtDeXJRVDc0SFRhWUp2?=
 =?utf-8?B?M0FzbXJFUVlxVXVtc0NoRHB3QmRnU1U4SEtXdkk2NTJxNDZvMzF2OFN0TXJj?=
 =?utf-8?B?RVNuUTVIdUI5QnlYUHpUOUE1VnN5b2xyYk1Mdi84VENoY2FRdGxmRUFsQVFo?=
 =?utf-8?B?RmQ2T2FlOGNCU0JJZlB6WHRoSnNKS2NuQ29PcWdkTTlrMjcxRlhQUnFnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MHJ1MnhUYTV1dk1sTE02dCtFakl5cFNiMmRWV2JPU1k4YmRNZlNWc3lEL29y?=
 =?utf-8?B?MXB5RWh2MTZLYU45Tlc0Z0FuZXMyMGxSd05zenNHRWp5SnF3Q1pwS1l5dVFo?=
 =?utf-8?B?bDZjQ1pkSkNiVVVEdS9HbXEySk9Pb25aVTRsbzNKQzVDWWpoMHlTM044TWJC?=
 =?utf-8?B?YTZMcGtYWEdxQ2M2cUFvUWVDRlcyUU1xZ3dCemhmTmR1b2UxdFoyWkdic2Nx?=
 =?utf-8?B?MXZFbTIzcFRFOXlPTWRqK3dETUVCLzBocWhtUHk2c2hOK1NpWmhaKzFEMENk?=
 =?utf-8?B?SHQrc1dtZ3M1TlJLc3BIYjRhdUZYSG54Y3hneSt6NDZodWFUbk9McSs2Wk5R?=
 =?utf-8?B?cXRLYS9Jd2E1Y2M1TDk2RVZ2citoM1BKbUk0NlhKMC9KUm1GeTdMVXpRZXVM?=
 =?utf-8?B?ZVpTSEFxc3Via3FpVjZpN0Y5VTBYOWxVN3BwODE3TGplUWNNWVBmLzhWa2Nt?=
 =?utf-8?B?UDlJU1BLRWJaN0pORWxwTGgyZzRaeTVmd3B0VmhVNGJhbGhSYkNzQTRXRmRx?=
 =?utf-8?B?QTFENm56TmZEVEg4WE1jb2YwQjJiVHY2L2J2SG1NbDF5bElBY1FjNy9XdmJu?=
 =?utf-8?B?VnpzdUcrN2dMM1RPdmI3V2FCYWRwc2pFYlVZMFpzVlVrOTBVczJGb3ZBZnV5?=
 =?utf-8?B?UXVDN1c2K2NKbkR3OUZhL0htK1ZKTnprcmZxN2NEcnF4eVZQLzZBNFZVa0NB?=
 =?utf-8?B?MmVqemZnL0xmWER5Qm94dm5SdmJzN0xxaFo4NkQvSEF1U3Fqa3AvZU52dzhr?=
 =?utf-8?B?ekJFNGJoQndXRDF5TVZnTmhFMk44YUtGaFNPdjRVMnVGNzhlRVR1cnRYNXlO?=
 =?utf-8?B?MCtlTVA1N3hyNHNwV1lUbWhEYXkwUmRtTVdOUlo4VmdoeHM0bGNwNFNadzE4?=
 =?utf-8?B?NVhPbERuc09Vbjh2SlMrN2JiQldIMFFORWc5OUlSMm82WmdWelFuR1l3UUVp?=
 =?utf-8?B?aWdIbkpWQ3I4TFNWeGZ6ems4cDdLcXlySFJlZzNRRFlrUktMRDJua0RmR3pv?=
 =?utf-8?B?OHF6YldBSmtuQXNiZzBmWmF1VDNTY1Y1RkNZYjBOeHVLRVhGR2lWZ0VyT2hK?=
 =?utf-8?B?QWtCWVRwTk1ya2s3NnFPLytrWHBCdFdaLzFyYWlSZTlNQm10OWRtQzdwVVZI?=
 =?utf-8?B?MzcwM2lvcyt4Ri8zVzhuYzQyQUxmRFRERFVzQWxnQTJsTnc3cUQraTRDNG1h?=
 =?utf-8?B?NmVvaXpBUFBzQVA3VTZTbEJiOEZBK1NIVlcrd0tLcmYxSHJ1TVlQSXBxc1Qv?=
 =?utf-8?B?M3YyVHJYNmtNYW1rcnlwbEZSalA5K1RTMXpld215aUxscFRzTE51aEo4eWZB?=
 =?utf-8?B?MzJzUXcrM0FMQ2pPcFByVnQ1Vm9RcDUwYm1SQmxDbWd4T1psSnJ1NTZaTDZi?=
 =?utf-8?B?TDQ2eitsK2pBeGgyK01UOHQvWFIzanlDbGZVZ1lEK013ZHA4RXZWeDR6Qit4?=
 =?utf-8?B?bndmdTc0cklZb2VLL3M5ZXppK200TEkzSUQwN3JaRmlJWms5dDlJU3M3QjhG?=
 =?utf-8?B?WDZVa0hTSFBocFp4UXV4QWo5ZytINUU5OXRnb0RNTHZPczMxSWMybE04UkpN?=
 =?utf-8?B?a3ljVG9zbDkxSVFJZkdJUlMxdkdZYUlsemFPSm1LaG1uRmYrYjNaTjQ2SEty?=
 =?utf-8?B?Z3dQeW9JTllFWjRVKzlUZ2lvYlhJS25nelhxM05HUnJGeWZ5TXo0NUpIREZQ?=
 =?utf-8?B?em03Y0RRMXh0Mnp4dmZmbWlGV3NuNFZOWjF5bnJ1MHRnQjJxTVdxcXVkR0sv?=
 =?utf-8?B?ZXFSaCtOY1hXRVFwSGIxN1gvTi92d2ZMNDlSSjh4TFNPMVlaODB0aGV2WlN4?=
 =?utf-8?B?N2owSnNrRHlBb0N6SG1aOFdRMXg0c3RDSlM0UXY0MGk5QnRnL1ozLzMwM1ZZ?=
 =?utf-8?B?VmFtTjJlR1gwZktBN0FBeXUyVVgrOEJTOS9Vd2xxMVIrdzY1dWxsODJCd0RZ?=
 =?utf-8?B?ZTRqWlU1ajYvVlJ3OGZkNlJDUUhrOFg2b0xQTnhlWGtzaW9tR3JlaTlyTm5a?=
 =?utf-8?B?MGcxN0VZZWdraDR2eTFNRWJyazQzbnJGU0paRk5KblYwVFJ6ZStrM050dlNS?=
 =?utf-8?B?VElyeUlnTlZvN3h4dGt1TEtBaU9ucmtKQ04yaC9taG8va05PeVpVdUd3c2F0?=
 =?utf-8?Q?jn8Q7OeOmzGz+Hg3KILT1bcS3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	P+tOXzK811dYVJ9+sO29FPfGkuYxLYFQcYnBkWbP13uGPVOtTogNsjhHQlJcMUYUBw601h0fqoLy+MyXJjD1UvcrxE4PmBfouqr4XE92aaFf3sLl+Vwbdj+kXlW/p7fLKENIZWjPydHvalnXI4m3hjf3gEKQ9cHY9GNtwr+NLQDUtCaAhFu1uRzGKDR7PN4BHomZbETGoBHLapVf5/CP4LWI8Fx3ejr6hB8NraEPo6/nwZ4z4zx/5qyawEOR4r1rBRMX0MECOK/07+SrdYjkaA9iqKicoB3AKumFVWl5YXll7JHtYegv3Q8jg3FSjM5SAJ6B/NUHAisi6eiQQbyWQXsltEKm6FbfiHDhicdMwP+4iiQTrf7dncCepc6hEPJtfCeme8pudYt9GbWvDzl9z4AdBkGEzH73tvzF80cafxj8S69cPELtbnZdsGUIhBMEZkGqhwgQor149HqtvIcz+G0WFBVyvtZxfT0hTPhVcMQOD9/aw5YXDs87MUjSJzztrfct9Zfk8I8+c7LR541td+AvOJR0UsJhJWx45Vl/vwdML+NMBPU0o/Ex/ArcRIkhHvca1Ie94OetjwhV9tuULG1EGpRUAxVfFAi31xW8rUQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dac60e56-beca-4792-cae6-08dc7b62bc29
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 19:58:37.5093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dw69Za6OrLdyzVU3u8vUSxLFj1I+m3MJvDAZaTwqL5QcbeNaI/HBQbxDE4oAQESP1DPED9lNcXP7j/u6ScHMNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5829
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_11,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405230138
X-Proofpoint-ORIG-GUID: X7XDQNl_ivX6MXc8YWGdWrWykZOqgvVM
X-Proofpoint-GUID: X7XDQNl_ivX6MXc8YWGdWrWykZOqgvVM

On 5/22/2024 7:31 PM, Miaohe Lin wrote:

> [..]
>> +/*
>> + * MF_IGNORED - The m-f() handler marks the page as PG_hwpoisoned'ed.
>> + * But it could not do more to isolate the page from being accessed again,
>> + * nor does it kill the process. This is extremely rare and one of the
>> + * potential causes is that the page state has been changed due to
>> + * underlying race condition. This is the most severe outcomes.
>> + *
>> + * MF_FAILED - The m-f() handler marks the page as PG_hwpoisoned'ed. It
>> + * should have killed the process, but it can't isolate the page, due to
>> + * conditions such as extra pin, unmap failure, etc. Accessing the page
>> + * again will trigger another MCE and the process will be killed by the
>> + * m-f() handler immediately.
>> + *
>> + * MF_DELAYED - The m-f() handler marks the page as PG_hwpoisoned'ed. The
>> + * page is unmapped, but perhaps remains in LRU or file mapping. An attempt
> Would the page remain in LRU or file mapping? IIUC, MF_DELAYED is returned from two functions:
> 1. me_swapcache_dirty. Page lives in swap cache and removed from LRU.
> 2. kvm_gmem_error_folio. Page range is unmapped. It seems page won't be in the LRU or page cache.
> Or am I miss something?
Agreed, I'll fix the comment.
>> + * to access the page again will trigger page fault and the PF handler
>> + * will kill the process.
>> + *
>> + * MF_RECOVERED - The m-f() handler marks the page as PG_hwpoisoned'ed.
>> + * The page has been completely isolated, that is, unmapped, taken out of
>> + * the buddy system, or hole-punnched out of the file mapping.
>> + */
>>   static const char *action_name[] = {
>>   	[MF_IGNORED] = "Ignored",
>>   	[MF_FAILED] = "Failed",
>> @@ -893,6 +915,7 @@ static const char * const action_page_types[] = {
>>   	[MF_MSG_DIFFERENT_COMPOUND]	= "different compound page after locking",
>>   	[MF_MSG_HUGE]			= "huge page",
>>   	[MF_MSG_FREE_HUGE]		= "free huge page",
>> +	[MF_MSG_GET_HWPOISON]		= "get hwpoison page",
>>   	[MF_MSG_UNMAP_FAILED]		= "unmapping failed page",
>>   	[MF_MSG_DIRTY_SWAPCACHE]	= "dirty swapcache page",
>>   	[MF_MSG_CLEAN_SWAPCACHE]	= "clean swapcache page",
>> @@ -906,6 +929,7 @@ static const char * const action_page_types[] = {
>>   	[MF_MSG_BUDDY]			= "free buddy page",
>>   	[MF_MSG_DAX]			= "dax page",
>>   	[MF_MSG_UNSPLIT_THP]		= "unsplit thp",
>> +	[MF_MSG_ALREADY_POISONED]	= "already poisoned",
>>   	[MF_MSG_UNKNOWN]		= "unknown page",
>>   };
>>   
>> @@ -1013,12 +1037,13 @@ static int me_kernel(struct page_state *ps, struct page *p)
>>   
>>   /*
>>    * Page in unknown state. Do nothing.
>> + * This is a catch-all in case we fail to make sense of the page state.
>>    */
>>   static int me_unknown(struct page_state *ps, struct page *p)
>>   {
>>   	pr_err("%#lx: Unknown page state\n", page_to_pfn(p));
>>   	unlock_page(p);
>> -	return MF_FAILED;
>> +	return MF_IGNORED;
>>   }
>>   
>>   /*
>> @@ -2055,6 +2080,8 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
>>   		if (flags & MF_ACTION_REQUIRED) {
>>   			folio = page_folio(p);
>>   			res = kill_accessing_process(current, folio_pfn(folio), flags);
>> +			action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
>> +			return res;
> We might reuse the below "return res;"?
Yes, will fix.
>>   		}
>>   		return res;
> Besides from the above possible nits, this patch looks good to me.
> Acked-by: Miaohe Lin <linmiaohe@huawei.com>
> Thanks.
> .

Thanks!

-jane



