Return-Path: <linux-kernel+bounces-174633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DEC8C11FB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 17:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ABBA1F21D57
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 15:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2779716F26F;
	Thu,  9 May 2024 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="kq6c/DGN"
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739DB16F26B
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.142.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715268468; cv=fail; b=SIjfY/SyLQ1hgHfy6N5q00lefSqXeCLC6GIyYG5/WDM0SrOXD7mocbeGJ7Q1W64F+CK6G8gQruNC9MEaR+Hh/lqukx6Ap6GV155RylToMPeWQz5LKG2CD3S/DFFNdBZRJy22W0rlJHiQ2DVoDMAiio4NG20ibLuxGZ97Ow/Vlks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715268468; c=relaxed/simple;
	bh=76uv52mBRtYGSik5adytDBa4JBDLunYS6ZqwvvboSF0=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=S9b/81su+Q7/Sdt2dz/Oi9dZ+wbSvuQhz+eUpRIr3j/15Y6iRVs1ielGRH+NXcXOkox2Dy/0Y9c//FFJIszTJjW7S0JAWOVBU71vqgvc3ZOX9IBHkqWwHZzjLJxKJeuf1FjTO1jFdADN2OkzFdgYG703Nz1yx7a72Nb8Ty4QVK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=kq6c/DGN; arc=fail smtp.client-ip=173.37.142.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1607; q=dns/txt; s=iport;
  t=1715268465; x=1716478065;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=UIHhPiNQXLCrKWkSfzlKYokJSGxsT7lZ1SivSHex1X0=;
  b=kq6c/DGNNT4BkOrczBdfxnmLfdqQfruOzM/c0l6Hc9MgTCmLt0P29qZD
   kd4Zf8F9KeO0GGiTjSw6ioEqmMQdcSw5Q13NJt11DDFPytJvQnN3kHE2O
   9XaNdyHV5914Ds0EWk032hU8wOdMskNJaEqww/OM2jgsS/BAgs9iHO1/i
   M=;
X-CSE-ConnectionGUID: +LMlJtrLTESBxYBDVl2dkg==
X-CSE-MsgGUID: LseaxIkbRLyIXZaGJhPDBw==
X-IPAS-Result: =?us-ascii?q?A0CYAwBJ6jxm/4gNJK1agQklgSqBclIHc4EKEkiIIQOFL?=
 =?us-ascii?q?YhtA4thkimBfg8BAQENAQFEBAEBhQYCiDYCJjQJDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEBAQEFAQEFAQEBAgEHBYEKE4YBhloGEnkBCBVREScEARIIGoUPAzEDAaVOA?=
 =?us-ascii?q?YFAAoooeIE0gQGCGAXbGw2CV4FIiBAeAYo8JxuBSUSBV4I3FB0+gh+CJAKEE?=
 =?us-ascii?q?4IvBI0iTIFailqFfHiIOVR9HANZIQIRAVUTFws+CRYCFgMbFAQwDwkLJgMqB?=
 =?us-ascii?q?jYCEgwGBgZZIBYJBCMDCAQDRAMgcREDBBoECwd1gXyBNQQTR4E4Bol3DIMxg?=
 =?us-ascii?q?XcpgQ4WgnpLbIEeAoJqgXcOYYNZhF1hHUADC209NQYOGwUEHwGBGAWmDoETb?=
 =?us-ascii?q?wIIB5N4kRCgGUxwCoQTmziGKheEBZN4kjeYYiCRVZZoAgQCBAUCDwEBBoFlP?=
 =?us-ascii?q?IFZcBWDIlIZD90weDsCBwsBAQMJimgBAQ?=
IronPort-PHdr: A9a23:VD75zhLzGkCHGSDfcdmcua8yDhhOgF28FgcR7pxijKpBbeH/uZ/jJ
 0fYo/5qiQyBUYba7qdcgvHN++D7WGMG6Iqcqn1KbpFWVhEEhMlX1wwtCcKIEwv6edbhbjcxG
 4JJU1o2t2qjPx1tEd3lL0bXvmX06DcTHhvlMg8gLO3xAZPKp8+2zOu1vZbUZlYAiD+0e7gnN
 Byttk2RrpwMjIlvIbp5xhrS931PfekXjW89LlOIlBG67cC1lKM=
IronPort-Data: A9a23:QzKhuq+8JUFynb7k/9e0DrUDzH+TJUtcMsCJ2f8bNWPcYEJGY0x3x
 jMcUTiHPvrbYzHweYt2aYmzo00EsMXdnIRnTVRkq39EQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEzmB4E7rauC4xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4uiyyHjEAX9gWIsbzpFs/jrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dsamR
 /zOxa2O5WjQ+REgELuNyt4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5nXBYoUnq7vh3S9zxHJ
 HqhgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/wmWeG0YAzcmCA2l1Gagc2PptJV1jz
 tYIGRohUBTZi+G5lefTpulE3qzPLeHiOIcZ/3pn1zycVrAtQIvIROPB4towMDUY358VW62AI
 ZNCL2M0MnwsYDUXUrsTIJg3mPy1nlH0ciZTrxSeoq9fD237llMrgOW2b4ONEjCMbeFOk0+Ih
 2HMxUDoIyEoPfO9yQKp2G3504cjmgu+Aur+DoaQ8v9snU3WxWEJDhASfUW0rOP/iUOkXd9bb
 UsO9UITQbMa/UivSJz2WAe15SXCtR8HUN0WGOo/gO2Q9pfpD8+iLjFsZhZKaccts4k9QjlC6
 7NDt4mB6eBH2FFNdU+gyw==
IronPort-HdrOrdr: A9a23:t8TbPq1hVcQZhd8ThWlJgAqjBeFxeYIsimQD101hICG9Lfbo9P
 xGzc566farslcssSkb6K290cm7LU80hqQFnbX5Wo3SETUO2VHYZr2KgrGSuAEIdxeOktK1tp
 0QP5SWaueAd2SS5PySiGLXYrRQpeVvm5rY49s2uk0dNT2CHJsQljuRZDzrdXFedU1tP7Z8Pp
 ya4cZMujqnfloqTunTPBM4dtmGjefm0Lb9bzA7JzNP0mSzZDWTh4LSIly95FMzQjlPybAt/S
 zuiAri/JiutPm911v1y3LTx44+oqqu9vJzQOi3zuQFIDTljQilIK57XaeZgTwzqOazrH43jd
 j3pQs6Ncgb0QKRQoj1m2qs5+DT6kdt15bQ8y7cvZIlm728eNsOMbsDuWueSGqf16NvhqA77E
 sB5RPni3MeN2K/oM263amGa/mv/XDE+UbLVoUo/iViuYdyUs4hkaUPuExSC5sOByT89cQuF/
 RvFtjV4LJMfUqddG2xhBgn/DWAZAVFIv69eDl1huWFlzxN2HxpxUoRw8IS2n8G6ZImUpFBo+
 DJKL5hmr1CRtIfKfsVPpZLfeKnTmjWBR7cOmObJlrqUKkBJnLWspbypLE4/vujdpAExIY73J
 7BTFRbv2gvfF+GM7zH4LRbthTWBGmtVzXkzc9To5B/p73nXbLudTaOTVg/+vHQ18n3wverLs
 pbFKgmccMLd1Geabqh9zeOKKVvFQ==
X-Talos-CUID: 9a23:b64MbG7I8MYbmwiGy9sst2oxHuI5aFnh4Uz6M36SJVhtErGWRgrF
X-Talos-MUID: =?us-ascii?q?9a23=3Aau8bygyyM0fs8wYGzqMQqFxAqUWaqIC1BUkdsJY?=
 =?us-ascii?q?Mge2VFBxCMhi/jAybaJByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-core-3.cisco.com ([173.36.13.136])
  by alln-iport-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 15:26:37 +0000
Received: from alln-opgw-4.cisco.com (alln-opgw-4.cisco.com [173.37.147.252])
	by alln-core-3.cisco.com (8.15.2/8.15.2) with ESMTPS id 449FQbkb005308
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-kernel@vger.kernel.org>; Thu, 9 May 2024 15:26:37 GMT
X-CSE-ConnectionGUID: GDvJPN7bRt2sDDYdtdCURA==
X-CSE-MsgGUID: EGA1IU8JRemzRQqnePeDgQ==
Authentication-Results: alln-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=balsup@cisco.com; dmarc=pass (p=reject dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.08,148,1712620800"; 
   d="scan'208";a="29414408"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by alln-opgw-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 15:26:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdyFa+1obaIPe2Jlked3YzJsa0jGU5m2UzMBi9Ze6vA8yBMZS2Ch9GLZ0RxvfT/paGgGAW9UMRnz+3kRVIQM/Yj1r8isOoE0GFgr9GOTLq9ja0DH+wZkwZ6WZYLxqRdxiXmaEED3zECi6lenAp6yt+YKHdZRjf/9Vh33Nv6jwMsfH6Bv3zrOxS2LNd8rYa7ZGz08GHqk5Fo1+8nKcThrZXNIbBhYkI46z6fyr/1pAEmqNJg8fX0L+kJGQtEMP1zDb/vWcwFyATBSf1AnGdtq1hBwqb8ljQt5UHZUJkWOslbPvS6TK5cnIteGStq00Of7BBAa0L3/qH/bPqFC6oToPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIHhPiNQXLCrKWkSfzlKYokJSGxsT7lZ1SivSHex1X0=;
 b=UMjC5nPk55GYU33A3IZbaDiCK1v5i6owCVoIBUzoE/0q7vOfj+z6DvODyYkp5lsDjLzB/hrLI/RPBsBhCNMFz1p2yMApzzUxcy2gJwJw63w81XTNwSWm+Ix4QpvD5OtcBVRsWtUNUafY2mAnXHsEt8MXSJDPGYIJJIlBl1PuVRJydtGi75h8oT0XJN82a1rIOAYIZOf7Ya7QpmAW3LEdl0bVA5EfcIoRhNc9lw4cGQurL/hEvLsH56UVSQNKUvwNt7LovoaWbJ5pa5iBcFqEYbJOwVRUUfraKa77GWcBz+9fU8FSjuXmOYdqXdeiG6gT8mqXuBPxulUNT7Jjw+7pRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from SN7PR11MB6604.namprd11.prod.outlook.com (2603:10b6:806:270::18)
 by SA2PR11MB4875.namprd11.prod.outlook.com (2603:10b6:806:11a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 15:26:34 +0000
Received: from SN7PR11MB6604.namprd11.prod.outlook.com
 ([fe80::2df5:8924:5093:9b61]) by SN7PR11MB6604.namprd11.prod.outlook.com
 ([fe80::2df5:8924:5093:9b61%4]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 15:26:34 +0000
From: "Billie Alsup (balsup)" <balsup@cisco.com>
To: Muni Sekhar <munisekharrms@gmail.com>,
        kernelnewbies
	<kernelnewbies@kernelnewbies.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Seeking Assistance with Spin Lock Usage and Resolving Hard LOCKUP
 Error
Thread-Topic: Seeking Assistance with Spin Lock Usage and Resolving Hard
 LOCKUP Error
Thread-Index: AQHaoiVG0oAXLW6sfEGq1UjTh9JUCQ==
Date: Thu, 9 May 2024 15:26:34 +0000
Message-ID:
 <SN7PR11MB660461A6E5F3FB4546B5BDB9D9E62@SN7PR11MB6604.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6604:EE_|SA2PR11MB4875:EE_
x-ms-office365-filtering-correlation-id: 2bc39dc3-e859-47f4-2b36-08dc703c6934
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?X+LOfD6DUIcbcSJK/HeXRT/x7yDhfIMR6wQin1Wcu1bLTQt4ALeWkgWsBJ?=
 =?iso-8859-1?Q?WRlMjQ98mwpM/1o+VIaEKEKamHQMULeOEqRL73csHZVrlkvM18o8WnBfmQ?=
 =?iso-8859-1?Q?L2F1zZZkgnI0BrAC8msuz4ArrTZ/m4l/Vgd2rTyv0ONCRLehGsXz3xBDGz?=
 =?iso-8859-1?Q?QOptwCXEmtW/WkkpNRxPBKtAX3A6PtmSbkMVQGx1PJ3TnrVREM+u0uNZc/?=
 =?iso-8859-1?Q?uOjSakzaqC/XfQ39Lor3dtv7Z9Q4Q15sfMdg99fzNxzt4e6BLmvyN0WKEN?=
 =?iso-8859-1?Q?3R7ldkTpV2LkW0IoQiQnB+sD3PqDBEourGLsiP/6nDFS+riLFgswK1KSs1?=
 =?iso-8859-1?Q?Ta6bG5aV8LQ6cSKNgG90R7JtFv8GqnZAnEFZq1PdXfFa2aXOIkgQlQSksH?=
 =?iso-8859-1?Q?ONIKWEvUJnqdmjow3SrQGQsSPzdAjVfaJgyucgGwQaGr6P2M9pNKAE4IYY?=
 =?iso-8859-1?Q?LPufeS0fBn+dJsUTxqCV0Cemby8+Y93kHfDE2p58SNQri+DfLMrdHe8rmc?=
 =?iso-8859-1?Q?Ie2wQYCfM3X/i5a/MscelSOOKysuVTntkcWlo+R/C0w53p+jhXb2ekn5Cu?=
 =?iso-8859-1?Q?+EthOZhOq7wMzIaF3LGqEj7+FeFGSS7lFYCYJt3tBzYc26HneLWVRHG5YQ?=
 =?iso-8859-1?Q?IyPAHRU9rMOCRoDKwT5Qq91Ftb+TPediP85mRubqvFQz0x9T0lO+IHcd9P?=
 =?iso-8859-1?Q?2RT0HzPvYFEW1b83rGVw4K3z6t2tCFYhZfjkMXwF5qMx21Zfk51uXKJazO?=
 =?iso-8859-1?Q?Yc3FUXp/FN9UHqETbgZAy4gQ4PwJvSPYWPEMWxEAPFGKHgazE+HoZA6pF0?=
 =?iso-8859-1?Q?IQQoedp9ruU+pBVlXiZMA/L3yxPBmqa/u4FxkddOV3RbG3EBh1xuvQ+9c1?=
 =?iso-8859-1?Q?j6IHkeGlNTdMUGhsBxJpGcGol1K9Rn+vt49n6UOcVZR6kTelKCM4Y8gPXm?=
 =?iso-8859-1?Q?wSltYIhU/VJ3qnl/t7M9mg6QmCpogT1sbyrgHbkV1tsV4Lqypai4zOPQIr?=
 =?iso-8859-1?Q?mHYwY29yUxLWpHZzqzcnYzkn3jASaX34/UmQypYRAoF/jC4nBJO0LxpH5J?=
 =?iso-8859-1?Q?6o9KY9A7c/AcU/yUhP+HVmUsFIaktrKbGI3luQGihgWTer2gY06PR0uRnP?=
 =?iso-8859-1?Q?Abr6PbAOvyiCqAPtscLTD/hsGAnBueqsXrRvr8SkaqkFHoYQ4dXzPKLUQ5?=
 =?iso-8859-1?Q?Ayjh+g8S+vzB28zj5f5xQmqV+skHalWi8wchxXOWhzLFbPNX6qH8L+s2EW?=
 =?iso-8859-1?Q?ABs+oLDK8w7a/xp3MfqcjOrZAzYSNTXUNyyexlf2dz7NNobWF3wo5rZO0Y?=
 =?iso-8859-1?Q?W5XVXMP07x9QVkMVMfiErrrY4eQ2auXl1VcHP+nTXs0u1L7lSknkopJFpa?=
 =?iso-8859-1?Q?Ss/wDtvhFDzDeam4xzz0JA7Lb+vIl/XA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6604.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?4cQy+2YFu8BX0hszs0v/zzWs7Wyjm389TNSFWWVZNWAXKXpY+8YhFcuegG?=
 =?iso-8859-1?Q?uwK06z4VXCYle43p65JqYMjZoeL8FzRAq1JC1G5tk9rkNKZep5Inono70y?=
 =?iso-8859-1?Q?lWOoZ+tpdGGAZ5Z4g1zmFhpNkbU1udJpJJlwbg8+zrIjVWkOFW59YAVocB?=
 =?iso-8859-1?Q?DlOImfuQg7qgHC69ycvWIbkL83Zgb94mI8DLvaJ8WYwvkd0C3sgRd+OLIY?=
 =?iso-8859-1?Q?wF/Nkg65cNlN4Qf/Ee6QUEElFmRfCivJW1d3ggOdyZJRXqHQbebDGOid7P?=
 =?iso-8859-1?Q?hyc/ODGxSSaPLmXhjaX39t+YF0Qw2nwoOM+bfoBJnqqqJuRJdHIUR9m43r?=
 =?iso-8859-1?Q?i6dRyqfm2LNVHgWWiCC4Gu2CA1glxy0tUe+LDgawV+nMgqBLiI0vvXhdeX?=
 =?iso-8859-1?Q?qSreYYw6BqfTrBhYrv7VuGPJEHAPpNEneUqqw3AQZ4bFM5fXoHSDnoyDCG?=
 =?iso-8859-1?Q?5mTN2Kq82kGpKJhPwuILkkPVVk6vqD3MnPcFUeA8qgDEIloCogEux16/Fc?=
 =?iso-8859-1?Q?Z3VkL1ovnIOpggoKQuI35OLeUGzKjM1Xu7ipXRNHqqs0ZKEMAVgA5Debaf?=
 =?iso-8859-1?Q?20a1jzu/2C8mneIpSR9Yn0Yh7REyo0iPoQtxX+grCI/KNdjJFHSFfhWAJM?=
 =?iso-8859-1?Q?kryPQkUL7/RlEey/j6SWo2YKVMxT1y/nXsiXVAXEs0/F2kC8sBM2lbrnZV?=
 =?iso-8859-1?Q?PWdhEvBMLEAwCtLEMuLfxgXfbjukzI8iisNacyul3mmIzGlSH+RDOlk9Q4?=
 =?iso-8859-1?Q?0Sw60wHPEP7rmKZbp52t5t+azJxd+yTVUxUctx3YL7uDeR+JzNAnLWHol4?=
 =?iso-8859-1?Q?kzv3klpHUGdgnH8LpcAhiPCD2ULh4+2YZXcfANBRp4ghGGKc4XI5H3r1rK?=
 =?iso-8859-1?Q?XzEDGtqfoxj30Eyl4XoedCDE/vlhP2eVMfMtIdNIinCEHcBMppknjqDY/o?=
 =?iso-8859-1?Q?Az1+pITUvE6wPcwm0KgNnhMsHQyORRjLZ6HIN7K4McwW9DQSNQcS4oLjg/?=
 =?iso-8859-1?Q?7kKgDOD8cFyP9wjSl/OB5YB7A/zRxsq6fa09SwWRW04GBABjk/JAAmL9q1?=
 =?iso-8859-1?Q?hNO+NJKiQzy0hgnJSEtc/i8QskCT62fdZd6ILpNbnrRwjlWxxLp/TPF5nB?=
 =?iso-8859-1?Q?bRlE30YbebrtTKKtcLHB0ZcRIvaWedV6W4W3v7FctyDyxrS8X24u72v08N?=
 =?iso-8859-1?Q?gFlSoSdk9kHpEFdfIOoer3R0Wni7dsMeTmEIuCOCLUn3MgKgPyFu1JZDmb?=
 =?iso-8859-1?Q?LP678gNK3FhNdoRSvEuvLMVaXWBWDNlFOy3cH5Fmbg5+QHYJ5QIVZDdT14?=
 =?iso-8859-1?Q?2ig3uYu00JzM0n2zKvTtIt46L6m0eSvaBpvumFBei+t1YA4+8CRhc/Y3vB?=
 =?iso-8859-1?Q?CZmOaXa1LkYNCAB9939gmxFsMV0pK9Kp0/q40F6tYb8kU9K/VIrKYscyXY?=
 =?iso-8859-1?Q?zxe2a9eg7qr8OMvyor57KYevIE6alwD+ReV68oPlGAPLP+Rxy2hWn+LdtQ?=
 =?iso-8859-1?Q?urdRQrSzLle1TyhUM61oP3cAvOj/asg/jIk1bPFZYzyDz9FNkYo6j04RWa?=
 =?iso-8859-1?Q?NRs3CJmb3fQFrnEHvV2pwKCUuqQlBuUB3Kk7MuscREsjkhV7lyMozXlEnc?=
 =?iso-8859-1?Q?HcN0t16kn09yJ+1BnnjKrdGYtQuvqTHFy0P8NZIQOS8ye5rksqtc5tCSjL?=
 =?iso-8859-1?Q?hhDl+feoWOA+6MLz6ng=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6604.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc39dc3-e859-47f4-2b36-08dc703c6934
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 15:26:34.4618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lJJq9pNOYujpXGhtI2Jq5jE2U4NAJ9L7bOWLhnNc3MxHJMFgY4/REao6yZfERw2ef9FtWznNWCFoORTynDpVCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4875
X-Outbound-SMTP-Client: 173.37.147.252, alln-opgw-4.cisco.com
X-Outbound-Node: alln-core-3.cisco.com

>From:=A0Muni Sekhar <munisekharrms@gmail.com>=0A=
=0A=
>Here is a brief overview of how I have implemented spin locks in my module=
:=0A=
>=0A=
>spinlock_t my_spinlock; // Declare a spin lock=0A=
>=0A=
>// In ISR context (interrupt handler):=0A=
>spin_lock_irqsave(&my_spinlock, flags);=0A=
>// ... Critical section ...=0A=
>spin_unlock_irqrestore(&my_spinlock, flags);=0A=
>=0A=
>=0A=
>// In process context: (struct file_operations.read)=0A=
>spin_lock(&my_spinlock);=0A=
>// ... Critical section ...=0A=
>spin_unlock(&my_spinlock);=0A=
=0A=
from my understanding, you have the usage backwards.  It is the irqsave/irq=
restore versions that should be used within process context to prevent the =
interrupt from being handled on the same cpu while executing in your critic=
al section.=0A=
=0A=
The use of irqsave/irqrestore within the isr itself is ok, although perhaps=
 unnecessary.  It depends on whether the interrupt can occur again while yo=
u are servicing the interrupt (whether on this cpu or another).  Usually (?=
) the same interrupt does not nest, unless you have explicitly coded to all=
ow it (for example, by acknowledging and re-enabling the interrupt early in=
 your ISR). Certainly the spinlock is necessary to protect the critical sec=
tion from running in an isr on one cpu and process space on another cpu.=0A=
=0A=
From a lockup perspective, not doing the irqsave/irqrestore from process co=
ntext could explain your problem. Also look for code (anywhere!) that blind=
ly enables interrupts, rather than doing irqrestore from a prior irqsave.=
=0A=

