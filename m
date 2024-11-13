Return-Path: <linux-kernel+bounces-407818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B069C74B5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20C261F21045
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0407083F;
	Wed, 13 Nov 2024 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xg9WXFYK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WKU+SFyZ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF8A29CEB;
	Wed, 13 Nov 2024 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509253; cv=fail; b=WV5GCyteSFuJ1xx/8iYolTrn/UnbdbehHL7zG0QhJ8BmNZ8ZwJUJx9yZdCUhwFWsfz1Nl98zlEPjex31TTxcw0pTStpS2k4l/j/BJGFQvqrdQVHZGNzBLGd++1gK9wxPPqyrko529Ii/fbVkRQSBV2byTABBai0/gnKfa3xogig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509253; c=relaxed/simple;
	bh=DBnLq2ixjv7fYtlGQ8cW6udkdeAEFqUDA0NkQXlq0QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t0uW5XLROqRsE9g9jf/0Tu/qFGuTwFSLdTAzGLQCHwwaaAob/cV9SOLNUH4CfDHHlKohiB/kQrqsosVHGe3DS1+qCwgZyGppfer4dFOvlkH9KTw71PKQOb9mbwlsGjV2Wux4AHzQ12HCrTLMREifHkGCnOo1DbfmRb3o2u22A5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xg9WXFYK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WKU+SFyZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADDXd8v013757;
	Wed, 13 Nov 2024 14:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=MikIQB30OpRwYXYbXqqo/3u0FFTr7ss7mcyswkX2NFw=; b=
	Xg9WXFYKsufn6YJaruhEezfasI4kyg4vDuVaAKioBKIO9OtADkjA0x77tAU6VUQJ
	z/PcsF6AU+8UD1Joji3B1xRyyHVcNtPHcLzoS7oqn9MPbDVEqKj0aaS6D/2l4Ln5
	/Wa3ItnNgPNe0LdauWRXOxZuq97U5SwF8DRCvSM6QS1zAufSK3VPBF7bLAYOLl5+
	n3hP/9dhvtZlI5KMThd/mfps61spHBSKodHiBgZH3Y+T6n1Kl1KhQaE0FtZ7ag9+
	oAGPT3vXSitHXS57DjTnLwxrthCFEb8zdSetOJAoMaCDU61Z7sc41iJMDDDmW0++
	4AZ5BHaNE53uEyfTrWK7Pw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0mbf33t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 14:46:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADDcLxn000434;
	Wed, 13 Nov 2024 14:46:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42tbp8s2u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 14:46:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1qAzgnugxALFdu8B6VOria+iT2p/WUY/+VcheOaxiQ3qTGhGfhRkwzl/0VWOO3nMGMLnqXYYpD+GOHXFLph5sHPHLAZmaHH/tDynMopBFoovjs0BydX2/SQhd+uEO8yN9Z8Z0tDYW7uZ3z8qcsJ0YDHJeyfGr9heVd0P5Om2vOrt7XDUUmchbgyFqbd4WfWMN/TiRE5QfKfTVuKFOmp1A7c6iMeZtIEqIPeKuXZjyDLaSsFLdIPCyBI4jVaGJNIF7FCPkuHOcQvWcoNL1HlT2EYffjwR+KMD6szdobmS92fJ1mu1yMSjameqp7FOAzRkl/FdtkA/LJVp1hdSZT5ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MikIQB30OpRwYXYbXqqo/3u0FFTr7ss7mcyswkX2NFw=;
 b=BURcbJB6XUGw+WuZQ4LJd0hl8TA14dkjf3tgXNRbwvLcEXWjycKmKvmgbFB6+/D7IHU4ZM5Qbz46iVTYNt6rjeLqwqAkTmbE9ZC5UGkVE9S6Lpc1FH325e+knOWBs90Uz+ieU2UHwJKZuIYqiqpL6ypUJ1GNcokXCz3uxNSzaEPHfI+zozQE7VTCFj/uq2PQ0ezY+RJTDEDBqCgsCkLPzIsShJvbSfI03TQc9PAz+2pmpJohUq8y1aG73oe+lcVhoVVYE+Unb4q6K/hud85IpiOK4oC5pxMHYuXkd/SOdxq3qGFXGyvVfvLU2LU3pGbCiQTBg762SZfANRfDr5keYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MikIQB30OpRwYXYbXqqo/3u0FFTr7ss7mcyswkX2NFw=;
 b=WKU+SFyZtenautabkn8pJHOsXPRHQuFVjV9KOsdbirFG3K/Q0bWLf7e/2I0a8u+S1E0yYHc7uSd0Wdg8ioDlhLNRtMOHLej4oh0jwi8zoNUOmRtuhbis3u0Jfq2xvzwsIwwedBup5IXUuQQv+CWF5I4NMqoI4TpP1KeISsR8yCo=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH8PR10MB6360.namprd10.prod.outlook.com (2603:10b6:510:1bf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 14:46:47 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 14:46:47 +0000
Date: Wed, 13 Nov 2024 14:46:44 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com,
        oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com,
        peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net,
        paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com,
        hdanton@sina.com, hughd@google.com, minchan@google.com,
        jannh@google.com, shakeel.butt@linux.dev, souravpanda@google.com,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] docs/mm: document latest changes to vm_lock
Message-ID: <322783ad-ddb1-4444-8c81-4c3d368fac66@lucifer.local>
References: <20241112194635.444146-1-surenb@google.com>
 <20241112194635.444146-6-surenb@google.com>
 <CAJuCfpHuPfkq4Js02gvAPy=g4mB+55hR9VhXsiTa6bv8uXXNCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHuPfkq4Js02gvAPy=g4mB+55hR9VhXsiTa6bv8uXXNCw@mail.gmail.com>
X-ClientProxiedBy: LO0P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::12) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH8PR10MB6360:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b72c3ed-c217-466d-1257-08dd03f1ffe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elpWdWdkTWFyUi9mNnZ0WHBCVmFVUzYzMlY4UWJQSHB6MXFOVGoxZkJYT2dS?=
 =?utf-8?B?SXpySnJJVlhncTJVVlk0V3pOM2ZGTU1MY3k4bGE2R0c2OU14WnR2MkkvSHBy?=
 =?utf-8?B?Q2g3bGFWYXUvVHY1REFWS1RKMkVYajFlelF0b1hvWmlyRjF2VEMwY3c3Ykdu?=
 =?utf-8?B?ZFpQVmUreWFtZFY2UTBOdksxVWZMWUJ1MlY3eGI2djUxTzYza1VhM3NFTSsv?=
 =?utf-8?B?RjBOMEtGQS9QRzVxZXVXeTN1a1dkSFlFTFpzUTFXUzN6dmNWZVEzYlFjdjZV?=
 =?utf-8?B?L2dPZUM3cXRURzJXZXFtUmxkbE0yczBsYWhyS3BhbWhBc29HelE4RWlLdFBU?=
 =?utf-8?B?OFNFdzB4RXdpN21oQm8weWM0S0UxRXludzkrVkpjL1QwSGxYK0VITWpTbnEy?=
 =?utf-8?B?aUNNc28zaEZjNjNzOXE0QjJoWUVYKzJHN0NnbkdKUG5vVEFERTU3ajlkMm9z?=
 =?utf-8?B?endKK2MzKzlab09xUWJDY2YvZVYwVUFwU2ZVazZSQ2xEVkwzNVUzbWpmWWI3?=
 =?utf-8?B?MVVSbnJuRk1VeDIvTDhTZ2xJd0RJS3lmZE5yYlBMNVAvRHV6cERad25kWE9M?=
 =?utf-8?B?bk1TaU4vWUJJSjFFd0JoYjRQRmRWWjBaemNLWWZ3N1RUd0twbEVweFo2dTNv?=
 =?utf-8?B?MkxydWVWTDF0T3pmZWh3eXgxUXlCVHM3OEFadmZ0VGdyWG12WlVZa2F4WnVp?=
 =?utf-8?B?V0FJb0RrWnBEMUh2RmF2Z2ExQ2dKYWoycGlINlhqZUM2cExrVERlMis5V25x?=
 =?utf-8?B?YnRWRlNaK1ZjempTQm1ISFlTMUR0WmwrK3RWalhYQUNVWkdCVjBTeTRvNkZS?=
 =?utf-8?B?MG41dFU4RndVSDl0a0FEY2E5TVArTjVNbzRYV1lLcUxwdnZhczJmZERQdVlk?=
 =?utf-8?B?WTJLTUVtcXR5cElaN2VJVDZUbHFDOGtaWDdrZjdoMW95QVovRGErR1RGR3dp?=
 =?utf-8?B?cXdVL01rVmhiUFlKUzNRSVhMMkQzY3B6UFVBRFlGSTZPUGlaQlpRdFY1SzMv?=
 =?utf-8?B?ckZPQXBsUXBJcW1HVXBteGo2cDBJVFJTdlNaR1ZIRG5uaGllNFR2UkVicDZq?=
 =?utf-8?B?L3daaFhOcmVORVdGbGtjRlUrblVNU28rVjJBVTBCWlgyU3ZrQkVkQnQvSDNS?=
 =?utf-8?B?NWcvNVpsRytVeGQzZDU4MzFnb3gvUVF2Q2djeG9acHdjSmNKY2tHR3FYVEI3?=
 =?utf-8?B?am9Jb2tHRmR4d0RGQnZPa1M0M2V4ZHdTMnlIK1R2ckY4NFBmcENHb3lLbDFK?=
 =?utf-8?B?eUtyQ3ZjeVNjbkNaWVMrVFZ2TFBTbUJXU1pCbkw1YWgyTDhyRlZJdnpuY1ZV?=
 =?utf-8?B?T1Z3RlVmeEJSdEdzeXUrMlRYR1hwZHczSi9HWkRTSG1USWg4cEZDOEM5Qkhs?=
 =?utf-8?B?RHJEMEg2WlhOdnN2RHkrOGFsZDhackdHWWpxKzlkemNWSmt3MDVzTEU1TU52?=
 =?utf-8?B?b21Jd21YK0M3WjVqS1ArM0ltZlZqRys1UXY1RmUzQ1dhcVI4ek5KVFdhNktJ?=
 =?utf-8?B?eWpsUm96TTYwcXBvMFhqTXFLOU1LV3NkZjNXNEhESUsrbUtuVE1Uc2xnNEsy?=
 =?utf-8?B?ZnlubkVlRDJsWGxTc2hsQkFOVlh1cFkvbXFheEhja3pWOG9EMEVlZzg0NzJ6?=
 =?utf-8?B?MThjd2U4RzFJd09VRlUzTFJzRFN4UHNwakkza0J4M0ExLzI2c1dxZENKSWxG?=
 =?utf-8?B?dzdFMzUydWhkczAvbCtZN054dm43bHdZdzFlYi8wdGFJRzJPZEpma09DcVd0?=
 =?utf-8?Q?FrK86QeLZo5JYIlnxWE7TtsOzNDRNXROmb7LKXS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGQ5QlNVRnJUN1NtUElabDFTcGtqR0JYN3B3djZGT3FhR3l1bTlwbWExNFRv?=
 =?utf-8?B?QURWOHU4b1RYNU1Qd244QnllcWM5c0pETlQ0eWUxU0JFUWdrT2QzczE1aTJP?=
 =?utf-8?B?V05ZdmlUaE5Gd3NCTE12c1I1RGZacHdsYXlpdnZSekY4K2p0dEQybVVqWm8x?=
 =?utf-8?B?Q0pRQUVENkZ0dk0vMVNLN1dZQ1JZNk5DdldVM2VuOHRzYUdIN3BZY3AvMWQr?=
 =?utf-8?B?SldKdmdwWXZnZFlabnNhekRFWDBHR0dLS2l6QXJDMG56SVZyVGE2aURDZFgz?=
 =?utf-8?B?dzhDQUJYV3dBWGJ2TDZpa0VudkZwYnBjd0Nrb0xka1ZtMVg4MFkrZDh1bmd1?=
 =?utf-8?B?Q1JYVEpGMVNpUVBuOHFoSldFV2N4cXR1Wk5ENVRFYjRTajJWTWVRaEw0YnlB?=
 =?utf-8?B?L0hORno3djFBNEkzZmMwUXk1eUhtbC82M1NmNDdRbS9NbStZeDNlZ2E0eXVB?=
 =?utf-8?B?TEpsS1Z3andNTHlrbEZHY1krbzJHZm4yTEpEdUtUNWJmNFRxdXNMN21CWWQ5?=
 =?utf-8?B?dSt0WENOdFA4cGpXdDhZL0pWZUxRRUVGd3oreWRidi9WR1lpODhZVDFBdHJC?=
 =?utf-8?B?dTlYUURWZlZ6VHljU2RmbWdaWEprZEtPRmlWZTNpeEYzOUJDY1Y1SC82ODdP?=
 =?utf-8?B?cWpyMmhFVWxBa21sSWpHTzBmd2FBby9uOFR2dkZ3ZkMvaDAxY0VycDhWYitT?=
 =?utf-8?B?eG9LeTg1bGhNV1ZFWU5CUFdsTFpjT2xwUWthOVdLNUtFeTM1RnhYR3J5OE9T?=
 =?utf-8?B?dHQ4alNxUnZJTWVqaGlSTnZQRE51dUZYaysyanpJbUs1RG1NRXNTQlpFRUt1?=
 =?utf-8?B?WGcrdCsvcEN0MTJQaGZnekozSEFYVkhCSEZ2NmYyUCtDMmJyYUFQWEZjNXhs?=
 =?utf-8?B?T3NwdG9ZZ3JUdklETjgzaGJBcEQ4RjRwZVJUSlNuM29qdWdmb2hRTVBTbkVh?=
 =?utf-8?B?OXVVMk5VT0plSUJBUlZzL2ptVUZKSWZYRi9NUjVrcTc5MVM3QmhxYzJ4ck1w?=
 =?utf-8?B?VjJ4VFNJblorS09EaU9OOFlNU01Sa3pjYU1mMEFHVFkrd01LVzRKc3NpNjZ6?=
 =?utf-8?B?SVdqTW8wYm41NmZvYWdaMW5OTUw0SWtvbkptcGhTU2VPY005ZU82VkdTQkNS?=
 =?utf-8?B?SjhnZVdOMVEzVnM1NkVyYjJ3WU96MHoyZEhYaVFJdWRMUDl3SkgrY0ZTenly?=
 =?utf-8?B?RWJuSVpreFA2UkhrWUdSN1l0cWQ1cUtQVlBvR2VsWmtORjFiVUtQU21IZTFT?=
 =?utf-8?B?a29IR2dZVi9nWEt4TXFtNG4vODZ2OEVmbWV4R2VwSnhSekZ4ZXBxSmcwUW1J?=
 =?utf-8?B?WVZHQk9IekVjMTk1dWxBWjVJb01GZ1N0THA5MjZPYVcxSjVncHVEZmVvcEtv?=
 =?utf-8?B?VHdXNjlXRVZQNlhwMjdtZHo0Q3BRcUJRNElMdHpZeEpBU2VDcG9qQndtb0h2?=
 =?utf-8?B?N3Q1MmlWbXhwZUdLZzhXMXdKc1BSSDY4VjFWT1VScGJQYlF1cWJIaWJoNEJE?=
 =?utf-8?B?NEREMnJBR3Y3WmpxUlcwWlhHY2lLNUtHUmRPOEkvZ0MreWhMNW1xa1UzaGdG?=
 =?utf-8?B?ZUJEQitRR0J1a1hjdVEya0lsNlBzeWR0U21NTTZNN0xxdUZraStwOXRNbzl6?=
 =?utf-8?B?KzNMQjFJTGFiVndFb0pwRGJIdzVjZU1Va1NOMkNyU1dXamI3TnIzRjYxeHVO?=
 =?utf-8?B?bXZ1SDQ1cDUyM2NBWVdzRlB3MElvMy8yRXliUXlzQ3g4d2FZRElObXZKS0Jq?=
 =?utf-8?B?OUdDODM0TnlrK2JxSnQ3OFBMMjl4WXd6cHhSRFdpTVlQaW5JaFUzd3lvTUZJ?=
 =?utf-8?B?TmJJZEJBNVlER1E0QzN4cFp1VzkyNXVnRlRpcjNoUlFLR2ZkZGVxTTNZY1Z0?=
 =?utf-8?B?QlJheWtUeFB1MnhlVlcrQitCb04yckwvbmNVSE50eUtkT21Cc0tqZWowaFBV?=
 =?utf-8?B?Nm5vOG1KZmRobkJTTmJGNHNSeEI3Mk9keGQvZ2dDRUNpTzdIcGN3ay9saGJP?=
 =?utf-8?B?K3ZJUHArV3JPK1pKK1c4dHp0bStDaldhUmU1bjhieFQyQk1xa2ZIWlNyUEFV?=
 =?utf-8?B?eTErV0RvQ08vQWFIRVYwVVJLaXM1c1BqM2dEaXBja0lBVW91U1NMNFRES3d4?=
 =?utf-8?B?ZVBYZWtZRG5zUG8wbngvK3BjNEJNRnhhcklzcGVHNFRiYzJsVmNGVnlaRUtH?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T44K0gjUqcnsGcuLsRj+YqrSuE5+uyIl9dESVqsvkIv2WLfiZfnFj35OMEcEnC1vlWP7CJqOI4JtuN83VGQSaLPm+4CB2ZlsMUtptxD70WehQSx1fqfwAbmj78L3pvX3/YSuBZSlyr796200qCMN7FfkISPT3YOzjSDACzAUrfHHsxnZ27HykEEUc9ObISyoW77iFC/W9vlgTEsFegZfLgHPv4JSo+f89YbfSQtyNgN/BZuRnyBal3rwTPcNn4hz/+VdZiD4rQKuMnuEenqt5UdBbb1RFNw6/02iGIqHbaJyss287gUAUFLh2RmUYwtr+y0fa3fQlvFdI/kKsO767mWr+XGf9sSgIfog0nz6NxyDm0IBXLWhe8k7yzsym/kXUAKGuvaptwiHpS94sNudOS91pyoP+q4VJTnAK5Wb7qZkCMn25vB5gKZrzY5fzeWcM35aJPWsqVtYeQ8oicdMFd9HF0J6eumsWPLLWqEbx+S2aErUAhEdXOWawq2U5XRQTL0E5JSk0qEwfw/s38WtPWqewg1eiPpbkKsCb6o2wQXsU7BUwHc/TDrbPVjrWpgd8aqtfthWoQoDICiRAPlMIiuxpsGa0MEpAHxHujfzOis=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b72c3ed-c217-466d-1257-08dd03f1ffe2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 14:46:47.2514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wqu9K9cqwbdW2TuZWLAUWNCWgqh5fQ+9WdFttj2j9t9w3+x75TW5jc5nBqLJeQ292yWDmoUazy9J1j1/x8hzhddOdrUGRnfvopfF0A9jPE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6360
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_08,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411130124
X-Proofpoint-GUID: 0YQbEVKSzvKZ4GbBm0A8Fv6KF2k4gMTV
X-Proofpoint-ORIG-GUID: 0YQbEVKSzvKZ4GbBm0A8Fv6KF2k4gMTV

On Tue, Nov 12, 2024 at 11:51:47AM -0800, Suren Baghdasaryan wrote:
> On Tue, Nov 12, 2024 at 11:47 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > Change the documentation to reflect that vm_lock is integrated into vma.
> > Document newly introduced vma_start_read_locked{_nested} functions.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Thanks!

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

>
> Sorry, forgot to CC Mr. Corbet and linux-doc@vger. Added now.
>
> > ---
> >  Documentation/mm/process_addrs.rst | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/mm/process_addrs.rst b/Documentation/mm/process_addrs.rst
> > index ed74685ffbf2..c8935509173e 100644
> > --- a/Documentation/mm/process_addrs.rst
> > +++ b/Documentation/mm/process_addrs.rst
> > @@ -675,7 +675,11 @@ RCU critical section, then attempts to VMA lock it via
> >  :c:func:`!vma_start_read`, before releasing the RCU lock via
> >  :c:func:`!rcu_read_unlock`.
> >
> > -VMA read locks hold the read lock on the :c:member:`!vma->vm_lock` semaphore for
> > +In cases when the user already holds mmap read lock, :c:func:`!vma_start_read_locked`
> > +and :c:func:`!vma_start_read_locked_nested` can be used. These functions always
> > +succeed in acquiring VMA read lock.
> > +
> > +VMA read locks hold the read lock on the :c:member:`!vma.vm_lock` semaphore for
> >  their duration and the caller of :c:func:`!lock_vma_under_rcu` must release it
> >  via :c:func:`!vma_end_read`.
> >
> > @@ -739,7 +743,7 @@ keep VMAs locked across entirely separate write operations. It also maintains
> >  correct lock ordering.
> >
> >  Each time a VMA read lock is acquired, we acquire a read lock on the
> > -:c:member:`!vma->vm_lock` read/write semaphore and hold it, while checking that
> > +:c:member:`!vma.vm_lock` read/write semaphore and hold it, while checking that
> >  the sequence count of the VMA does not match that of the mm.
> >
> >  If it does, the read lock fails. If it does not, we hold the lock, excluding
> > @@ -749,7 +753,7 @@ Importantly, maple tree operations performed in :c:func:`!lock_vma_under_rcu`
> >  are also RCU safe, so the whole read lock operation is guaranteed to function
> >  correctly.
> >
> > -On the write side, we acquire a write lock on the :c:member:`!vma->vm_lock`
> > +On the write side, we acquire a write lock on the :c:member:`!vma.vm_lock`
> >  read/write semaphore, before setting the VMA's sequence number under this lock,
> >  also simultaneously holding the mmap write lock.
> >
> > --
> > 2.47.0.277.g8800431eea-goog
> >

