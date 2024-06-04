Return-Path: <linux-kernel+bounces-201004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3A38FB7FD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30CD5285FA4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66465149DF0;
	Tue,  4 Jun 2024 15:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SO/zn+px";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HnAJBJPh"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B0314A4C8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 15:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516163; cv=fail; b=UZ4QKh9nmdL4nZWxfbwEiqf1pS7Ut74EVfDXsfSsQ2UxTqcSUimklEZYNYoFqDFX5G9llfvDyQdZehraAkxzDycnVzthujfGqCYRKT0TzFdy42M3DqNb32JiZ8GDYitFDqkrR5T0TasOw4hRv3YDfP+PKn791mbAjJL3IeW/fw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516163; c=relaxed/simple;
	bh=Zqgappe+YSFazdyPiDJJCPDzwjt/EnTDjx5AgEdsi6E=;
	h=Date:From:To:Cc:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=MrZfbxw6bx72NI9wZCd8tFRK2Aw6+e+lcFpwV1vHfJZvWiQbhEVeaPguhjGaXbCDvh+k+2/hSSuBBNgqkCmnj8r+LwBc3U2g8mwSo4rxYvTE8Y0/K7IvHMH+hFvRNY/ghe6Ql7pIxnKwui0SlyX4t6jwk54F49eyKPEbTE98ToI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SO/zn+px; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HnAJBJPh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454BmnJC004596;
	Tue, 4 Jun 2024 15:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=cc:content-type:date:from:message-id:mime-version:to; s=corp-2023-11-20;
 bh=M0an5CGtNJfv3kNHyoN9/2qDFefqllyrdAnYjxnfjPs=;
 b=SO/zn+pxqCt5VyRJlkLwjGBFaQjsC+LBrWEM7Ip+pwZh9xnDRK091NerwEH9qzZboYHW
 /X4lmZNtmlRpMStvxmx5d+/o1JmpMfNPNOUqW9ZBkqo+pIyw36lZZfeHwPNCB7FOuRuJ
 y4K/dUujwcGXfS3Wpp2NRryMITyiRsOvMRiFObPHJrVPJm7AU/kMYoBsVR0p8WwUHupl
 jRFbVptIfeET2TOfuFTFgWSbCm0EWlbl3xvl4A1igp0URz8ffEXQ4U6CM74aK6iUwuQO
 imzufFPFBkYT0rtmGV56ku5DAIZ5sBxIpKk7qIPAZGmyz5+ztNwo+Hld4qrNDwmJWlOZ KA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv05dbym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 15:49:15 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454EQLld015566;
	Tue, 4 Jun 2024 15:49:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrjcgs9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 15:49:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+jB703EfUaiNi7TA/PTFMzbtSiEeL9yfHVK+0G5P8sVC3Qo49+OH6hN79RtZp/d62l+ctqBW8iTiygX6ivBMBXb22EVnqA7m4qqTE+XFWWm7Mz0DBuT4EAZlDn9I1+cFxsQS0XKu9E45PzB37HN4QJnUUuklsekVMgLIs8f8AIdBEXLMPEvtWt0RKl85zbaGs9jEEz3uvF/tUbLPPevtWl4L/nFCKHx5mN/Rfyb+KWHbDf1VTF3lgYUUBF4LwjfAQuzPij5Azt75I5Kg8NJDRuscZgXV7Vn7Cl+POvF8B86vsyZ4vMFB/0ZZvLyQlwHuiupg+2JqW0F6xa+dCKYYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0an5CGtNJfv3kNHyoN9/2qDFefqllyrdAnYjxnfjPs=;
 b=jqg1hBgK//TaBftBkrUYnBklcw8QbTc9aMzEZKUyr2Wurp1mRpsDfdDUYoNE5jveb6SbXf2vYSm1c1x0R5fxENCt81Gm3i1EXlPl0GFO2ZTw6TmBPFiP/gPjEsrV1PW3gP2NTxwZt1uAZ1LvqYvwcudcYJEBITmImUHVZi9nArSWRCSy++jOgJG+AblXVbMC8gc19AqM8yG6frP8jKEZzeCIiINsdAxmXO8RAgwnfttZL2kJr0wC3uBTKgB+UajMVu8xeedJ+CAUL3Fm3qqyYkB9ElEci7gecvU6fv8xM8ImAQO9WMnSfYp3B9efiZCWoKWs4ZZw1TEUUQTm5Y4Frw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0an5CGtNJfv3kNHyoN9/2qDFefqllyrdAnYjxnfjPs=;
 b=HnAJBJPhWC3YduP0j5gAwiaXUQtI7csFSMaljLBeZtnKtP9T822HvryhFUadLJ9wnpDTgKnq8cdCPtHp2mI5y3K2exz0rZVIiEI2rDG8b6/lsIJAxOswYFhG6oCJlIDJRT5YRTVgLIVi7adAm4cWMsEc4+d691WMZXBEerCsQow=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH8PR10MB6359.namprd10.prod.outlook.com (2603:10b6:510:1be::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Tue, 4 Jun
 2024 15:49:12 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 15:49:11 +0000
Date: Tue, 4 Jun 2024 11:49:09 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: syzbot <syzbot+c67d06ab25a9bc4adf35@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        maple-tree@lists.infradead.org
Message-ID: <mfpcd7cotdxsnz2tjlgyownecexd5rbw5ujjs7vue6hkllasfr@n3ua6lcfizrr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4P288CA0025.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::10) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH8PR10MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: 066be5d8-a052-4013-5821-08dc84ade0ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?y/iLBq3HmcOhadu7r2r7sKYMScMAtQLS4mDuexcewLumxY3GvwH41TdbB6CX?=
 =?us-ascii?Q?YhdDb5+l3LzH9hrcN2zcmvIrzy9pgAkaBCNLREWDBQVCAo66DqCXexndYpgU?=
 =?us-ascii?Q?dwva2HYV0HvwcEGKr31nO7DENu3UTTKqhRxkqAWr9P4xHeMAGPfnZ/Kn4y5K?=
 =?us-ascii?Q?v8JvBXoRLLNTAL2dm7RD1YbG0/e1bfvk9KYamtqIMb7ajNR68jxFoqOaOoXm?=
 =?us-ascii?Q?g/5H+LKXbFX1/uoNV5qjgfSqsZtoQojcZ2OlvTlPWN48hInLYn5zkJ+knI08?=
 =?us-ascii?Q?wbyjeurCVNV2SRj25/fcJRRM4TK6S5Zd6B38Nx9a42HtbRLKOQx7lg0oB93R?=
 =?us-ascii?Q?m/yVlvUm8RZNH3nxBvN1onWxg0/gr876UDkqfbP1T3ElvG5kgso/U8Gn1xvX?=
 =?us-ascii?Q?4itSigkzteOi6KYfVu8muzcrvOKQzBm8Et9wbQuefsm7pr3nN0lJL0u4Swgd?=
 =?us-ascii?Q?J0X3KVTmJQ+cffJ1ykFdBT9+PQyPeu0X4v3SvCSDKDcIHPc3Gd3CIWX2Qwf7?=
 =?us-ascii?Q?SZ1tXxBSeaRLp0Gc/bdNmhs4X8XtwVjiEIfVe/Y7JzSQMtPK2a3OaolEE4yW?=
 =?us-ascii?Q?wwxCa9dLT8LxX9XivRafDTj5reSurDWl082J26k7aHahijL7qwU/PP6r3MiW?=
 =?us-ascii?Q?i6u5Eodzp0Qnjf8gXtuJWbjJC+gDlIrNPp5+5ncj7cwOukcRrrBPG1qooktT?=
 =?us-ascii?Q?vxSANap4dTVVyF9Dy7uyWYkpZ7RPg4wa36YzGK1lxkg8HLfuZSb0l0YVjiyJ?=
 =?us-ascii?Q?UmVPdVrKt3eRGZM6Jnw2bvm03i+EsexyVr1zQ84aXm9WUSoTIMJ+2NpGnsjj?=
 =?us-ascii?Q?WjsOhHRqUQra3rAlIRC2Qc9NlGaj54+lXqCSs978128ACB5o0lWS4i+zNhpJ?=
 =?us-ascii?Q?hEDvHgqgtP7k9aDHlesyLV/dgQEYcERC4FXRS3opxcDbyv+9sXIB94hUSyYP?=
 =?us-ascii?Q?xQDDgk34M2tTBxvlnsQhQNkEf8guqOB/MtoYsnIIr8XDmC1W6LliENhFmAzR?=
 =?us-ascii?Q?QOWWh2AolYuk8xPObg9r0nOMuOho660yZqkX/WUtkdUdpcZKoALByN6ckBzS?=
 =?us-ascii?Q?tiUQloy0ueE+yZY2qZAgoP13160TVPXPgwdEyCL9fgPzxBN9pq4bDUHlrA5p?=
 =?us-ascii?Q?CoR0cPcM7B01jLtiPU10mWMvxfd4Ej0wiSR3u6UVxNVcvTatxOFhNKhsxBF0?=
 =?us-ascii?Q?HD1FK7nTo5S0oR3P76TQAt7fTrIvc2NIoks4ZY5by9T6BIoaxKexvpbMTNk?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?aq8zhHGrLkBdBpf8Z+KfajFJA08q23W7CZTdIGSXvH+O0jegmZ5R3flN9H3m?=
 =?us-ascii?Q?8ViQRBCSRNCujV39SFSiSWfLFabf0iKG+GsPmdB3/Gsa9EIFi+gd0NO0XLMA?=
 =?us-ascii?Q?1Wl1YqeWYDQdxmx04zQKUtWFLkAcn6VRTyd4pb/xMf/uQzyzvfdRSfwYEPdF?=
 =?us-ascii?Q?0XSaeTm2aDeXKMstBccr1DMgzd/lVGYeriBir/wfSrYNLENpkPrZXf+DFLTv?=
 =?us-ascii?Q?c29E+eIc6fAyuo1swRPrVG+8krP/VqlI9pJZmkv9eM/kinPCWxaai7jNuBM2?=
 =?us-ascii?Q?+xwta9DCbkVLSlsM2+pJUlYh7ELCxsHbcjSW45Hsilmgp5r5Q0RqsB1dxIWL?=
 =?us-ascii?Q?EzSeIlt/SanzUEMSxID+Gnu64Xt15wR41feLeibw3PvQ1s1H6Sz+dFSuuUsw?=
 =?us-ascii?Q?1aFPLAp3PqL5byN+q33oqYfmVneaoPJ53Yuvjoh1dg6f3kwYzzRSanmwM++3?=
 =?us-ascii?Q?w5gcywB9YNomOQ0XtmLLMd+mHSqxqyhEKG5IvVnlSByHT1rA9df1vd+uw5+d?=
 =?us-ascii?Q?rkMFbVlXoJ2U7kPjGqsbR7KAg7GvZlEAvO5SIQeNxOIslYfXj/8JW5OJ2WQ4?=
 =?us-ascii?Q?rM494fhRdM5CBd/SaDwoS9SQ/4ZxgQV8RvIiIcfWcj8CJ2Cx51Ygi7kfE7Ck?=
 =?us-ascii?Q?1lRNpp/gkKYtp/GXEcZepHdcxrkkDaKmgvPwPz3mSccPjBtLstx5ryVMafAF?=
 =?us-ascii?Q?2jXndIXqjpLBf9LT07PasQuEYDrEhH2xXwm8KSFzqqv81Ynq/QSzcPdUHp52?=
 =?us-ascii?Q?MZD0KzWDXBKG7heQzevdZ8NFKZvTdirTu+E4dSosrYDd6+Vjrq3HN4tzHxx+?=
 =?us-ascii?Q?+JpkaDtP/OfcnLJ+eb8ZKP61GMQRCnSL/N8ttDaB2Wnsn3pJ+OqzYOVKyRVS?=
 =?us-ascii?Q?Tv8dFDVd8iwXY6k+lMKoHA0VjzN/O5gCXLt/K7OK7MIA02B+zvOnGlY/9zZi?=
 =?us-ascii?Q?GkA90MMpGj6ZmYnLGbguDD6PAxhWGN8kv+hPSuOGHN1KJcd7tX622tB34QBd?=
 =?us-ascii?Q?vcTcMdiZqBkyVLTzEuTW9IxYeQDJERE1a9O9ahZmHXfN/BerDvlaMYeSFhma?=
 =?us-ascii?Q?KqpkGymgrX322lG3iEkNpopMNiY4z+Wz/fdOZH30JOYw5YtCYCXOrjceVCVi?=
 =?us-ascii?Q?eOSc09qMqN+MxI2K72IjKJ4McN8iDkXpaIx/c+MArYKqojTw26fPasXu5As/?=
 =?us-ascii?Q?LAnQxFBfYlAaxjdluopK6UIlPlYZPf+u4KkBDZo3Tc+LHxfou4iQeEPIhGny?=
 =?us-ascii?Q?Uc+7HmdptuUlAQJt0CvRD1+6b9LXfHD4LygF6POq88oyh6woO+Lb+ufBmzSn?=
 =?us-ascii?Q?fnFVx/fWzqubSKf+dNFWm/Uhm0jiKzDoIkT0s3o/JE0nBnhmjigpHMjlbpSA?=
 =?us-ascii?Q?joh8IUJS74gTXiPs0yxy/a4Ih5qst+IXu6RH3n4VJbUlRhUvDARm0tb8IKAZ?=
 =?us-ascii?Q?wTYxeFi2+O3lsWoMcCAoC8Wac8pt32ZFdcsd3xQTtRtAdW+/IPsYsA5dZ5be?=
 =?us-ascii?Q?bdKtI9RCoWApn5bpHeSul1tZquZIdzdjFq1dMpMcMcWbV31r9ivOv5U3xB16?=
 =?us-ascii?Q?LrUnpgblMwVVTI+B/UzigJHIu5bgah1jqf4n/7mt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Xi75u6nWsMCbpIafTq/2CJhQjRp2ttrjcwIQSAqz/HOtDTggbWafmSeRGnbjFIsrHUY1ySpaTeVMHsoijoiT0HZYtrvzHAot5Tfx6m6Bnz9SoAdSq1Z4MC8uu7KoLYE21y24VulaR2dbV+HXFZuHZnqaFtWd3f3ddxwjGBc1NMvH4dQKnRgWMxZOCqlf4IrStWrZkWj6NY/a2lp8UGVH/ww0wLpjvF0ZiLZ0a0jUTvgL9/0vhMz8iJ0JbT++heicVZnHtTcQoDNfRxqhvsqCZ6TFTndFfesVsV3b1obBMicjbGweyNWesba0tP0upSZn5gq1SUEZkUXNN6/2abR4J6edi/q6Dczl7lAgkhdYeTxmBK1KGJlmtysdoqNNuLnxf4BEIif10OtAG3wgWi4W6m5Yd1O2Q0Rxd/shzlKlFs+MXkCBQSCrBujLbaDT6/ZGAlw3M5ix+QYI6hRdGkpLG+dmAica9tU2q/YuOz/0ruV1rkotjwdbpsGJPzg63m/Eo7lyJnCb61Kuvr79EI5suype/fdym/AqMfzaW2T1F+hpf/nL3rveeA6iVk+O1ikz9rCRO/pH1BSnW0ZtmSlKihzNBpAOUZ8cM5noHdmbNB0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 066be5d8-a052-4013-5821-08dc84ade0ed
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 15:49:11.9118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ZYQAPuy0jckOs06fIO34gnZYaLMo6BvuWAGpf3Tg573QG0QGyQwQSMJoBi8fDOnGyJG0ZJeSeCl8gLVI4YCWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6359
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=894 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406040126
X-Proofpoint-GUID: WKZ3oiiaNqXELqZjp7IFW2oAlab3M1Pa
X-Proofpoint-ORIG-GUID: WKZ3oiiaNqXELqZjp7IFW2oAlab3M1Pa

maple-tree@
Bcc:
Subject: Re: [syzbot] [maple-tree?] BUG: unable to handle kernel paging
 request in mas_walk
Reply-To:
In-Reply-To: <000000000000d09b25061a11f454@google.com>

* syzbot <syzbot+c67d06ab25a9bc4adf35@syzkaller.appspotmail.com> [240604 11:18]:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> BUG: unable to handle kernel paging request in corrupted
> 
> Unable to handle kernel paging request at virtual address 007f8000826099b8
> Mem abort info:
>   ESR = 0x0000000096000004
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x04: level 0 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [007f8000826099b8] address between user and kernel address ranges
> 
> 
> Tested on:
> 
> commit:         63ab6007 maple_tree: Check dead node in mas_walk() whe..
> git tree:       git://git.infradead.org/users/jedix/linux-maple.git syz_20240603
> console output: https://syzkaller.appspot.com/x/log.txt?x=14842a16980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bd6024aedb15e15c
> dashboard link: https://syzkaller.appspot.com/bug?extid=c67d06ab25a9bc4adf35
> compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> 
> Note: no patches were applied.

This trace does not look to be related to the first reported issue
either.  It is difficult to test fixes when the issue is not reliably
reachable.


