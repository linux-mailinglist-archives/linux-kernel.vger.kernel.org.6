Return-Path: <linux-kernel+bounces-425962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA3A9DECFD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 22:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC939B21C21
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 21:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3F61A08AB;
	Fri, 29 Nov 2024 21:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ChYnKlD4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QTxCLUyR"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EDD3224
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 21:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732916607; cv=fail; b=H+umnNU6p+bC6Gnv1FoO0bKGLMQLPivnrA6CIA1j+VXvTOSJgPxANKZtGtcyXpwaEMkwnIUxLITxiN3RJ8KrIGTYn95jxdakYSezs5g6KZZ7YVqHGZdWRc5b6TpJcm/KY/+f+F9ulsMgF68i9AOEUCJRoccDWzvBkMPxWtJpQn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732916607; c=relaxed/simple;
	bh=1ZWMFY9v8mEAWWR+QJ1C1+Rzt+736+sGnBg9aID0fOQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aKeqtTzRz/FV/mU6gh/RqokwYfhFIoRO1sEojov2pToEtaZZ2jKRg2iZm3KRsQ3lkzS8hbbOCOdlC1imn6gfGrQu0LyKZSQX6kN9813mzz4O2nVJVqHdVMUnMHCE4HMISg0F6XmMyh1LRbSohIYWp8tvF2M8zKioTh6QgF4kDps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ChYnKlD4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QTxCLUyR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATL6ebU026145;
	Fri, 29 Nov 2024 21:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=fGNWBr0I8H7eSGukjg1OrnKt68kCiBpKGTzx2jMvvDI=; b=
	ChYnKlD4N7u6xBhm1XwrgQZWNI8iPHvgEDlMcsNdRwtCgRJC5CFnz/plyUgTwkY9
	JJqmV/EVJnVLOULpGPbkubzeD0Ekfs9kT+vNgxp4N0pCsjYmNA343WPaFCVa1bwG
	Hlhin28BIEuCkh2XaUXX+7LLhH0HBKu4BT9x5pxLSSJBRmF9QRkpnPZIu2tv1ieg
	TXRSmtVQLK6sl0Mh93lICAcv7ypaVVw8gbtdF1SPaU7B/Ez7ZmixOTzdte6kLJk6
	gv+Vy8jKrY8cyITc5+OtQeVmAU4xkacrRnfIWNcR91iF/ARwmNszoogX91NlQ4iD
	yXVtvFjHlJnieL64pPikHw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4366xybs8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 21:43:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATKR7Ic001427;
	Fri, 29 Nov 2024 21:43:18 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 436701rxja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 21:43:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDLv8Dj7O2w0bmcOMh+/AVOMSn86uHqxBTPac1mMdN03RlBbwpqDEOOVmsAWeGn6HgTVMm83+B2Nu1vp4zWb9cAVCJpwYSdW9CYRBfDC7WXn3Ol2+Ch39witSdll9v8GIaVWzw6WCPAd2ABRtPr3/I+A0AA+gDpJcbq1fGclO08tRdGR2lERZT+7qFrDnrWsaDhVEPDF3XvjFtnTyUA/1iJavayaIlr7pP9K8cRGG02kZCh9bpI44n79lCrNEJqSa6adz1v+EJNHuP/kiONRScA+QXf9VyrF2LN6VFXIhySNewQAluZNr+coPBRoy49W0uxdZnXA52JSJkQLVMXAmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGNWBr0I8H7eSGukjg1OrnKt68kCiBpKGTzx2jMvvDI=;
 b=edVwvbLKY3CXT4tDIv343Wm96Bq3pydbTMHuWSrbh7u/cEo8nSCZZAFDsaw5Fihi81zeY3vX8o6Fc3DxK8zWoyuXfqWCqJisHjorHG+yQJQgUOn78Z07PPFGM8bBNdGQCV4pZYXNn0g8WpFKIMg2+Ky59tCkv2Ub+w4CLUnwE7kjkIA8R1k6MeNjUpZnkHGtzlf6tFsuqTTIKeYA+69rF1la1In5LlxRU7YqiCfSBuvnRgXXtfcPh+1eSckyX2VQ0QQrmeMngaNyHnTUkKMhWDdX9HrXMk9BsyHpJDsSI7RlgK3rz7GDau5qX/MM/x5xBlb3gHR2+86YWOROFJmejw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGNWBr0I8H7eSGukjg1OrnKt68kCiBpKGTzx2jMvvDI=;
 b=QTxCLUyRE6FvXHC0tcfLk0qqJPxYRvJRhKTyl2xXmI8jTFol4xpdFNVVY+UlDOfnysfdbhZECSND7zsOOyVPmh9GG1AxAvkUw2wcvWx4K4U30xs/oq+xigV41cCoI+Ygy3x5jfdSmD7bSoctpdmPnnNpQPZHEb4oqS/DsBl6qpI=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by LV3PR10MB7866.namprd10.prod.outlook.com (2603:10b6:408:1bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.12; Fri, 29 Nov
 2024 21:42:53 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%4]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 21:42:52 +0000
Message-ID: <d91debb6-2075-4e1a-af0c-2f3a658cabb3@oracle.com>
Date: Fri, 29 Nov 2024 22:42:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] execve updates for v6.13-rc1 (take 2)
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Nir Lichtman
 <nir@lichtman.org>,
        Tycho Andersen <tandersen@netflix.com>
References: <202411210651.CD8B5A3B98@keescook>
 <CAHk-=wjMagH_5-_8KhAOJ+YSjXUR5FELYxFgqtWBHOhKyUzGxA@mail.gmail.com>
 <05F133C4-DB2D-4186-9243-E9E18FCBF745@kernel.org>
 <CAHk-=wgEjs8bwSMSpoyFRiUT=_NEFzF8BXFEvYzVQCu8RD=WmA@mail.gmail.com>
 <202411271645.04C3508@keescook>
 <CAHk-=wi+_a9Y8DtEp2P9RnDCjn=gd4ym_5ddSTEAadAyzy1rkw@mail.gmail.com>
 <20241128020558.GF3387508@ZenIV>
 <CAHk-=whb+V5UC0kuJkBByeEkeRGyLhTupBvpF-z57Hvmn7kszA@mail.gmail.com>
 <13223528-74FF-4B68-B0CF-25DCC995D0A0@kernel.org>
 <CAHk-=wgKgi5eqo6oW0bBS2-Cr+d4jraoKfVq6wbmdiWWsZbMLw@mail.gmail.com>
 <20241129033419.GI3387508@ZenIV>
 <CAHk-=whi+OgKMXoPQ+48i=_Cu_Yb5_QCv9U9+Wpg0-GumHZSXg@mail.gmail.com>
Content-Language: en-US
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 xsFNBE4DTU8BEADTtNncvO6rZdvTSILZHHhUnJr9Vd7N/MSx8U9z0UkAtrcgP6HPsVdsvHeU
 C6IW7L629z7CSffCXNeF8xBYnGFhCh9L9fyX/nZ2gVw/0cVDCVMwVgeXo3m8AR1iSFYvO9vC
 Rcd1fN2y+vGsJaD4JoxhKBygUtPWqUKks88NYvqyIMKgIVNQ964Qh7M+qDGY+e/BaId1OK2Z
 92jfTNE7EaIhJfHX8hW1yJKXWS54qBMqBstgLHPx8rv8AmRunsehso5nKxjtlYa/Zw5J1Uyw
 tSl+e3g/8bmCj+9+7Gj2swFlmZQwBVpVVrAR38jjEnjbKe9dQZ7c8mHHSFDflcAJlqRB2RT1
 2JA3iX/XZ0AmcOvrk62S7B4I00+kOiY6fAERPptrA19n452Non7PD5VTe2iKsOIARIkf7LvD
 q2bjzB3r41A8twtB7DUEH8Db5tbiztwy2TGLD9ga+aJJwGdy9kR5kRORNLWvqMM6Bfe9+qbw
 cJ1NXTM1RFsgCgq7U6BMEXZNcsSg9Hbs6fqDPbbZXXxn7iA4TmOhyAqgY5KCa0wm68GxMhyG
 5Q5dWfwX42/U/Zx5foyiORvEFxDBWNWc6iP1h+w8wDiiEO/UM7eH06bxRaxoMEYmcYNeEjk6
 U6qnvjUiK8A35zDOoK67t9QD35aWlNBNQ2becGk9i8fuNJKqNQARAQABzShWZWdhcmQgTm9z
 c3VtIDx2ZWdhcmQubm9zc3VtQG9yYWNsZS5jb20+wsF4BBMBAgAiBQJX+8E+AhsDBgsJCAcD
 AgYVCAIJCgsEFgIDAQIeAQIXgAAKCRALzvTY/pi6WOTDD/46kJZT/yJsYVT44e+MWvWXnzi9
 G7Tcqo1yNS5guN0d49B8ei9VvRzYpRsziaj1nAQJ8bgGJeXjNsMLMOZgx4b5OTsn8t2zIm2h
 midgIE8b3nS73uNs+9E1ktJPnHClGtTECEIIwQibpdCPYCS3lpmoAagezfcnkOqtTdgSvBg9
 FxrxKpAclgoQFTKpUoI121tvYBHmaW9K5mBM3Ty16t7IPghnndgxab+liUUZQY0TZqDG8PPW
 SuRpiVJ9buszWQvm1MUJB/MNtj1rWHivsc1Xu559PYShvJiqJF1+NCNVUx3hfXEm3evTZ9Fm
 TQJBNaeROqCToGJHjdbOdtxeSdMhaiExuSnxghqcWN+76JNXAQLlVvYhHjQwzr4me4Efo1AN
 jinz1STmmeeAMYBfHPmBNjbyNMmYBH4ETbK9XKmtkLlEPuwTXu++7zKECgsgJJJ+kvAM1OOP
 VSOKCFouq1NiuJTDwIXQf/zc1ZB8ILoY/WljE+TO/ZNmRCZl8uj03FTUzLYhR7iWdyfG5gJ/
 UfNDs/LBk596rEAtlwn0qlFUmj01B1MVeevV8JJ711S1jiRrPCXg90P3wmUUQzO0apfk1Np6
 jZVlvsnbdK/1QZaYo1kdDPEVG+TQKOgdj4wbLMBV0rh82SYM1nc6YinoXWS3EuEfRLYTf8ad
 hbkmGzrwcc7BTQROA01PARAA5+ySdsvX2RzUF6aBwtohoGYV6m2P77wn4u9uNDMD9vfcqZxj
 y9QBMKGVADLY/zoL3TJx8CYS71YNz2AsFysTdfJjNgruZW7+j2ODTrHVTNWNSpMt5yRVW426
 vN12gYjqK95c5uKNWGreP9W99T7Tj8yJe2CcoXYb6kO8hGvAHFlSYpJe+Plph5oD9llnYWpO
 XOzzuICFi4jfm0I0lvneQGd2aPK47JGHWewHn1Xk9/IwZW2InPYZat0kLlSDdiQmy/1Kv1UL
 PfzSjc9lkZqUJEXunpE0Mdp8LqowlL3rmgdoi1u4MNXurqWwPTXf1MSH537exgjqMp6tddfw
 cLAIcReIrKnN9g1+rdHfAUiHJYhEVbJACQSy9a4Z+CzUgb4RcwOQznGuzDXxnuTSuwMRxvyz
 XpDvuZazsAqB4e4p/m+42hAjE5lKBfE/p/WWewNzRRxRKvscoLcWCLg1qZ6N1pNJAh7BQdDK
 pvLaUv6zQkrlsvK2bicGXqzPVhjwX+rTghSuG3Sbsn2XdzABROgHd7ImsqzV6QQGw7eIlTD2
 MT2b9gf0f76TaTgi0kZlLpQiAGVgjNhU2Aq3xIqOFTuiGnIQN0LV9/g6KqklzOGMBYf80Pgs
 kiObHTTzSvPIT+JcdIjPcKj2+HCbgbhmrYLtGJW8Bqp/I8w2aj2nVBa7l7UAEQEAAcLBXwQY
 AQIACQUCTgNNTwIbDAAKCRALzvTY/pi6WEWzD/4rWDeWc3P0DfOv23vWgx1qboMuFLxetair
 Utae7i60PQFIVj44xG997aMjohdxxzO9oBCTxUekn31aXzTBpUbRhStq78d1hQA5Rk7nJRS6
 Nl6UtIcuLTE6Zznrq3QdQHtqwQCm1OM2F5w0ezOxbhHgt9WTrjJHact4AsN/8Aa2jmxJYrup
 aKmHqPxCVwxrrSTnx8ljisPaZWdzLQF5qmgmAqIRvX57xAuCu8O15XyZ054u73dIEYb2MBBl
 aUYwDv/4So2e2MEUymx7BF8rKDJ1LvwxKYT+X1gSdeiSambCzuEZ3SQWsVv3gn5TTCn3fHDt
 KTUL3zejji3s2V/gBXoHX7NnTNx6ZDP7It259tvWXKlUDd+spxUCF4i5fbkoQ9A0PNCwe01i
 N71y5pRS0WlFS06cvPs9lZbkAj4lDFgnOVQwmg6Smqi8gjD8rjP0GWKY24tDqd6sptX5cTDH
 pcH+LjiY61m43d8Rx+tqiUGJNUfXE/sEB+nkpL1PFWzdI1XZp4tlG6R7T9VLLf01SfeA2wgo
 9BLDRko6MK5UxPwoYDHpYiyzzAdO24dlfTphNxNcDfspLCgOW1IQ3kGoTghU7CwDtV44x4rA
 jtz7znL1XTlXp6YJQ/FWWIJfsyFvr01kTmv+/QpnAG5/iLJ+0upU1blkWmVwaEo82BU6MrS2 8A==
In-Reply-To: <CAHk-=whi+OgKMXoPQ+48i=_Cu_Yb5_QCv9U9+Wpg0-GumHZSXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0076.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cc::11) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|LV3PR10MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: 25cd5e77-0f21-43c9-45cc-08dd10bec703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmtjeW1GNWtnSWhDNjE1NkNPbHBWNW40ajFSeTh6Tm5GM2Z2UEVTTjJJN2Nq?=
 =?utf-8?B?MitMK0ZIODFnVW1uTmRWeVRkdU9KekJML2txajQyem1MU0N2MTBvS3NXbk1R?=
 =?utf-8?B?dzJIbC9aWFNGK3JPZk9CRWVQV2ZhN2FidVE1ZWJ2d2RhcGc2Z2hFWWJid2Fv?=
 =?utf-8?B?K0JYTlNtSk5kSC96YWorY1UrK2Z2dUFWTmhnYUNYYjVRVmFhZHM5bmRYcndi?=
 =?utf-8?B?VDJqSnFBdmFCdFZwTS9URFM2WFQ4aTlrUENoc2NuWlRlQmhJOHJWNmxzb05r?=
 =?utf-8?B?b0d5T1ZFeE92cjJDZ0NPRDI2Q1d3Z29aT0RzRmhtR0lRK0hXa2pOb1lOdmFu?=
 =?utf-8?B?SG9tb25xemowRmU5Mm01ZkNxQ0Z5M09oR3g3aDdOTFhjUWdlOVJGaURyQ2Zr?=
 =?utf-8?B?K1BTemFRa1dkUFNMbHZsSzJ6MUNNUkdWblBVVHBaMEFaeUR6NUVoWVV2OWNO?=
 =?utf-8?B?U2FyaDlvY09FQTRJNS9yNjFNWEtRc2lEaDRhTldVU3UwS053MlAyZFhabUNn?=
 =?utf-8?B?MkVFRnR1b2Jza3VZMVdxam5kUGpoa2ZiMkVtRGEzWU1WaHRzUGZGYmhrdWor?=
 =?utf-8?B?N3huZUVEKzhlazBjTTZxcklGOU1VVHRPYXpSZlhXMVpkQUFRdXlNTVJ0NFZT?=
 =?utf-8?B?NUQrZTVOMTY2WmxFK3kzWTJNcHIraVkvUENTVUV5aXAvUHBTejF3OVpHTlY4?=
 =?utf-8?B?R3prM0hRK2syRnk0eGVFTmtDMENaTmtHeHVjS05ob2VWMzB1M09QNWk5MHRM?=
 =?utf-8?B?RHRmdkpkcTkxcjFJYzJnVldmcmtLVitEQjV1d3dXQ1dTaVZpUUlsUXVxWEgy?=
 =?utf-8?B?SlB1ZFpHTnJrb3hSQlIySlZvazlNeWhOck01QUJqMGhJb2wrNWpwckp2S2p6?=
 =?utf-8?B?RnNMK0ZNTVhEdnFMN2k2OEljVXFGTkJTSDhWRExEMHFBV2srMmdhMkNXVVQ3?=
 =?utf-8?B?dVFGdmpSVzlRc3ZHY3FDWlRGNWVnemVOaVpBb3drQWsrYXNseUV4VWc0Vmpq?=
 =?utf-8?B?M1ZmN3dDVUl3cHJ5RVVXeXdOZlM1VHl2bThyNjhCYUsweUVDU1k3c2I0Y1Fl?=
 =?utf-8?B?anRZaDN4YVRLdnBNdWlaSENHT2w3U0p6ZzJvMUlla2o1dEhsUExyQ1U0eUZs?=
 =?utf-8?B?SlVDeWFTZlZyRlU1K05kZHhrUVFLNjhBUWxvTkRIeEJ2WU1EVlFDNmMrMmc3?=
 =?utf-8?B?dmdkdnA3eXZlVll4dkVxWkNYVHVSNHN2OFpSeDRTNERlWEc2a0twWUc4V1ZF?=
 =?utf-8?B?R3RnS1QwUGxzdTNjelcxY1RZd2Zxd0xnYjFEQnA4ZlMzb01Vayt3Z051cDlT?=
 =?utf-8?B?UmpvbWVqdU1MdzNYK1lBUllwVlovdk9BNUllZFFQR2k1VFBSSkFKWDIycDJU?=
 =?utf-8?B?bWQ1eTFsQk9RNFJmZ2k3L08yYmo1aDJLTlVWWWlQdmZRTXIvQ2xELzRRSkd5?=
 =?utf-8?B?NzFRNTVoci9peGpkQnppWW55SGRrTjFWdFdiTWFFNkw1bFY0VHJBOE82SFds?=
 =?utf-8?B?YWtXVFAzQ2Z0UlVYWUF4U2pIdmRxUDVmcVhqZHEzNE5wSXpZMTJDV3hTQUZD?=
 =?utf-8?B?M21nR0ZBR2praXRoT3I3ZFpiYU1ZTE13Ly82L0N1dlM1ZVoraWhKSzJLWUV4?=
 =?utf-8?B?ZmdidWdPTDNldityMjVvUFNHYjUrbVhDQVhhakNtTFdPZ2hsejJHTEFueFpr?=
 =?utf-8?B?NXFNWEUzNll0QnhXSUZVZFEwTGFTZVVsZHVuNzd2VGp4c1FYMnVtYStJZGt3?=
 =?utf-8?B?aEJtSEtna1c1OUxMWTFvTEZXWXRCRWZITzNnb3MzekhLUHdiajQxOHZKa1ow?=
 =?utf-8?Q?LKeB4SC8LiD4Gbc5h8Qj8BNJb30QbnLJsiFv0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2ZSZEtpTTh1R3V4RHRjNUlsYlljb255TE5tNUR6RmtUNWI1VncwUTBuYk8v?=
 =?utf-8?B?STZ2aEFrRWhoMjlDc1cyblZ0VlVwTDloK09BeFI0bExwNm9SV0NvSjMvSks2?=
 =?utf-8?B?ekM5cTVyeTczVDVyNmVDdXBQUjNpSi9XTUpnVHdkd3F2U3NST2xmbjlBc1pY?=
 =?utf-8?B?VnU2WldlM1M4R095Ky96ems3UTNIL0ZHUEJ0cWdJeTZzbFNETVNKT25ZQy9r?=
 =?utf-8?B?NTJraXhzVWJDMlhyaVJiZGIxSkJFRDA5bzY5UXBxMXZzajVCbFVqc3JieDM2?=
 =?utf-8?B?UkdhRC94enh6N0lyWXdFaWEzamRLcWs0Q0VES3l4aUltK2poMWNCZTFUZkZB?=
 =?utf-8?B?cjdpTkJUa2swTjhnekxOckpYZGNiVXBLRFd3QW4vV0ZSRWFSTUpWVlJ5VHE3?=
 =?utf-8?B?ek5neEJ1THJvWWJtaE0wekx4MEs2SGd4UVRIRWdRL0RoaGZ3T0F5L3hBbXFw?=
 =?utf-8?B?QTJhdHFCaW4rMTE4V25tcnJiZi80MytNWEJDV1FGWXcwaVB5WUw2OVJiWHQ5?=
 =?utf-8?B?S1U3dThENFg2aHNrUGNlbEc0K3h3UzR4VW9tSURrMVI0cDdBeW5RVVFxemJC?=
 =?utf-8?B?K0lTR3MxU2FMTW44Z2ZwUHdGRFArMDh6MGNwZmJLQndPK1ZzUngzSXRnZW5z?=
 =?utf-8?B?S3M2NjZZNlZQdXlkZkJDc1JXMXg4U2NwV3ovWW42dmgzNmhxN3ZKdDl3cWd3?=
 =?utf-8?B?bldSUEthcHpzYlphYnlpdG1aanA3bnIyWjRUTHFUWFVFak1kS2ZneGR3aTNH?=
 =?utf-8?B?Q0g2Nk8rZ1dGc2JSS095b3Y1QmhyZ2tRc1BRMkduYjhiMHNjK1QzYmd1NTlM?=
 =?utf-8?B?UGlpR0tCendCSUJ5UHVqZnZmK2o4Q01zMkpYN1E1M1h1YTgvcFgyWFUvNk5w?=
 =?utf-8?B?YWVnckhwM1RkRWk3ZUxVSVJRVkRLYWJMSE51cCtiUFByWWpZNG93RFRkdXBO?=
 =?utf-8?B?azcwcFdudmltSDkrWkZobUxNU0ZPU1dBWTE0RWlrbUFUZEg4bktFMFd4RU1p?=
 =?utf-8?B?ZllmQktKS2lFRmx6dmladm8zNiszaWF4d0tBVTNUMU4yYWVQYTQxSDJCUUFT?=
 =?utf-8?B?ZnJ1UHdRQzE2SXAzbXdiaEx5a1lEWnpvMHhINjZWRVdKVStaM1BBWGMrVm53?=
 =?utf-8?B?SFJkcTVhUEYyQmxVUzRTMkRqSkk3OEQ5UTJzYWovc01uRFA0eTF3L21rN2JU?=
 =?utf-8?B?eUdpUjNaN3p4emF4M3FiK0U0VVJ3WnhVbCtLOFRpT0RsT3lUVnhWVEM0MnB5?=
 =?utf-8?B?Rm12N3htWFltZWZNeXVzY0QxbkV2aGdZaW1zNTN2NDAxeVREZks0RnRNRXVU?=
 =?utf-8?B?eWlwTmh0bmZXV0x3MGtlUGwrTlJnVFNPQ2lGc3ZqdUpHV3hEMUl2d0JETndN?=
 =?utf-8?B?U2o3TGpnM3BnYmpISkVMcmxoVVFOREJFQnNDaWJYRnBvbUFIUTI4aVZmK0h4?=
 =?utf-8?B?RlRlQXZYMU90M3l3N3lBSXRQQmRyUG9HZy9vOFBVV3k0SlVka3JqUDNidVdN?=
 =?utf-8?B?MXR2ZUdZb0NlZlBJRUpzNDNSbFhXMHRqd0kvczZsRlVpckp4U2lpTG5BVll4?=
 =?utf-8?B?NVIwWldvK0s5UVMrdHh0cUdyMHA4YkoxWlZYeFRNeW9IVTIyc3ZSMXNTTVkx?=
 =?utf-8?B?RnF5SW5qd3cxblJHakVKbVpiOEZWdVVtRWdlMVRQcnU5amNURUpCN2VDS05k?=
 =?utf-8?B?S1p4NWJIYzhveGYybisraU01V2l3TTdHQnBKMy8vU3J2V2tadlEyR0xuMlpj?=
 =?utf-8?B?c0FUUG83M1NhYnRtYVNHaGphNFJMYjZtdC80V05MalplQlBGcHVVSXRFaldq?=
 =?utf-8?B?a1VzNDg4OW1pUGpoVUphN3h4Z1BkNGhPUFJKdW5WdDhpYUxQVTg3UXp2ajBq?=
 =?utf-8?B?L09pd2lMN3VOUHNsVDZ5dTBYL0hPK0ZGYWZpdEFlb3poWnZjZ2FFQU9Sb0Yz?=
 =?utf-8?B?SzNtZTVlMFdITEFrZGV3L2ZNTGtXTE9Pc3lxY1NkWVMyVFNUcWZJbkNVYkpa?=
 =?utf-8?B?MUFJT0xXc215K3J6M1FuNXplMjFTOXlVM1U3VmozUU1XVTY5aTc2ME1iM3Ft?=
 =?utf-8?B?bTU2L0tpSXVjVFlyS01WdDFUSUwwNHp6eU1lS2lQRW9MVWh1TmhlSnFKRmJT?=
 =?utf-8?B?anN1ZDZ3RUhDYmFEQ2F2SFczczNCTDhSampwSHcyUTd0QkVmN3Vabmo3cnk3?=
 =?utf-8?B?T1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SR2bjWGdcbQH0XW30dAOPaXV1sIfcE2o9uL6Q2oAqgnp5hbZ/4gjL+/tnPQEhca7nfqJwhs+iyiba5SFr6BnUpbyO4hQX7WgMXODGxJAZQDPsc8PvMf+6Z1gGWTV5HsmbGG96a1q/xZqAIgeq2SGRsSnCBkEobedrPQpBnBoUPh59gcRjFyjxw/52lqqf8g51i4dS8+EucEBTTOzbWsXzW0xWh7jhaOPRHGzuRnEWreYSYJ6bzWOEYQkMz0VBCHkMWpf8n43FZnha7bkr+Aag+yWzwQsA1ZAZMc6EJEIt3dKe929JSJEaS22LSlsbWjhri/+V8W8GB7RWV+b4MY7k1kfmQq25vwFB7+3FrYGe9NVS6FrphXj/tHp7tcpo6Sj1b+ntVWmHtxO/dgf9A0XWAwWcfGQvxUm2nD5Swx12XL0Le+RM/sNj+EvAM/u1qYc31DksBqHUbeF3p+K9w+ubjwq7+aUBMavOpzAr+GpZyWhhgRF0qVij8vZs3HlvctFOMlIFO5QXWi9xrYmo5dUfJNcqKIN5nvGB7Bo6soSSDmYYMTdKwj89V2KrB+HyAwtawdKyf5wthbd9yfBJhLhSbzYxU4U9PJR15L9FhAvK6Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25cd5e77-0f21-43c9-45cc-08dd10bec703
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 21:42:52.7900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IpV7dPuZarfyNEyaEIf0SPigPlHuR2bZNpVmKNGUBpTs/XRbXV96xGsGP8UR8iEjq7CJhNCBZq8J6tOx6kM2YqilZQpoeOYtF2WU5gzfw0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7866
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-29_18,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=948
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2411290175
X-Proofpoint-GUID: NE_q6Cl3iqsHEWZ6FG19oum4wz-erFQ0
X-Proofpoint-ORIG-GUID: NE_q6Cl3iqsHEWZ6FG19oum4wz-erFQ0


On 29/11/2024 05:44, Linus Torvalds wrote:
> On Thu, 28 Nov 2024 at 19:34, Al Viro <viro@zeniv.linux.org.uk> wrote:
>>
>> Just one thing - IMO we want to use the relative pathname when it's
>> not empty.  Even in execveat()
> 
> Oh, absolutely agreed.
> 
> Good catch, because yes, I messed that part up in my suggested patch at
> 
>     https://lore.kernel.org/all/CAHk-=wjF_09Z6vu7f8UAbQVDDoHnd-j391YpUxmBPLD=SKbKtQ@mail.gmail.com/
> 
> which did this dentry name thing for anything that used a base fd, but
> yes, as you say, it should only do it when there is no name at all.
> 
> So instead of basing it (incorrectly) on that existing
> 
>          if (fd == AT_FDCWD || filename->name[0] == '/') {
> 
> test, the logic should probably look something like
> 
>          if (!filename->name[0]) {
>                  rcu_read_lock();
>                  strscpy(bprm->comm,
> smp_load_acquire(&file->f_path.dentry->d_name.name));
>                  rcu_read_unlock();
>          } else
>                  strscpy(bprm->comm, kbasename(filename->name));
> 
> and it probably wouldn't be a bad idea to separate this out to be a
> helper function that just does this one thing.

Probably a silly question, but why not do the same thing in all cases?
file->f_path.dentry->d_name.name _is_ the basename of whatever the
normal path resolution machinery ended up with; why not use just it
unconditionally? It handled empty paths already. This also seems to
match what you wrote in 
https://lore.kernel.org/all/CAHk-=wgKgi5eqo6oW0bBS2-Cr+d4jraoKfVq6wbmdiWWsZbMLw@mail.gmail.com/ 
(no argv[0], no magic strings, no symlinks):

> dentry->d_name really *IS* the name of the file that is associated 
> with the 'fd'.

Vegard

