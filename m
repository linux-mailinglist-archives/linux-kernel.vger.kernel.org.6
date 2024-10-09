Return-Path: <linux-kernel+bounces-356741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC30C996609
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016861C23C7C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594A418BC26;
	Wed,  9 Oct 2024 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iuy6tWIr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RP36akmn"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1E818DF73
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 09:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728467601; cv=fail; b=At5e50NQRJ5oKDqEppEYwGmcd6cOS2zpswdclFRLkF0eLhqW/us+mgok3W5XwYxRVQdktpzMbVEF+iVjfiBSgDkO7qg2cjs54SEaVK4zbz/fI4oNVD279WliGlXATSJU+Kia3yXwbSTlvST8c5mZWeVoHPe26pe5lhaEaOTh35w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728467601; c=relaxed/simple;
	bh=EkJqBic1bPa8Yznnzv+zgoj5cSLrRxy1QhRGNyu8FR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CmDqUHv+uaLN/xEAk5wmnkoKhlTY00z1F9xuV4/1fqZHW78w1CdODZpqpE3RPMYFl43t9xRJC5EEa+Bsls/revN8S59QJrsVMReaXNjBlUiYEuRLgtYC5aKIm4KhnY9ysKuC1rPo59jiwtN2A0CXV4qQPZ149PCibuWQQtaHqL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iuy6tWIr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RP36akmn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4991tfwD003944;
	Wed, 9 Oct 2024 09:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=EkJqBic1bPa8Yznnzv
	+zgoj5cSLrRxy1QhRGNyu8FR8=; b=iuy6tWIrV+hYDptcKMXwTEn8VGDt2iTrvB
	bADH16mms+oGTYtqACDj/w/DUPK8b/e5t/ggKbmVjk2tjNjAOK19qxkx/4H8Q3KL
	Zq4xQeh9lMgZoaeS6w7CLj4WBgxy9i46qjKbab5t9Fb4Uz8F0v3TeNwoPDDtuk7e
	GdjDiaUto4RdlXdYgqCmnQIvHN1aHc3bdLPNkJO33IFfyp21KMq82r82wKmc+3Z+
	JTi4os4yoZZsVSejOAXf4LdWKG3OIu3+mx0oDjGvALlx8DPBhDRcA0McyiDcl6kU
	uwjxQzLWXUYadcBCs7CDwWy592DTvTKM1KFqPuZuC+GYSaZpsgQA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42306efuc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 09:52:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4997nqcS038241;
	Wed, 9 Oct 2024 09:52:50 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uw8ddvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 09:52:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apbDvdB7j6eUK+kUYfuzcmOwP5zi0YsHg/cELF2lv8Xn6KaM5toIO4ubjZnbD24HRGtc0/C1JdmaRX4kHWOVhLkOcfUWsJeToIIRKu+705C0S9+U007/zKVqeSXk2n/S+i19bOz22hv4bUAgbk8TPeD+Lnp7QRpbNkQhQONhJQoOpDDwGy33Gas+6b8H20cYTlv9LBbkQRbb2EG2aCjSDJgVNi/omdcOrsq+aP4x8PQtFEFoold/CvllWJ6c42QN+xiWIPjdOTRK4swl6Unm+KefudzeJ2mfVddFoDKbZHSFKH7wBzvUo3c4R5Is8sxhE+E5SHjfgnBcKMZP7lSuzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkJqBic1bPa8Yznnzv+zgoj5cSLrRxy1QhRGNyu8FR8=;
 b=qz4EVkXVpVPMqO+3NoS7k/f8gRqF7F5g3sZJZYeeuYfhCQ9YZ0UBHud/j68FVGK5iw4OGSkb00h00UdlrjwQko6rpJ/Thiqfbu0LUHhKKasttFaBMg2X5lvyQmRfxHZyZLxy3v3bYtqSmam2+sFIkWf2mLZwmJAa6+8ooHn7DqESZUNfCgvOFQTB2n15U+hNSuf6HuFjDTnjt1K+7LhOrmZP0Vv8mfjxEN7iPFfWdnoR5qnd4PFmMT/pU4dC6g+vTB7mia4Ho1bfaLebwUsWHRQ/C2yrNmegd05OYyA7hyCKkNPFqsZdHRERSpnoog2fiyMBYOWVQbkLKCrpUJ3OBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkJqBic1bPa8Yznnzv+zgoj5cSLrRxy1QhRGNyu8FR8=;
 b=RP36akmneFvnQFhj2+sA2dHvELaHNG+tgCwkJB5HDtEaihwePBzc9UJPzyI8H5uvhamkAevbGriZEYif1dqplXw06vqR7KIrE9kI3OyagKGan1ChmMYJYigBUAazW2/1yni9Sd6rKk1Hax4yZOOxtmMWeJM/hi/C2/YXRkkJW8I=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH0PR10MB7536.namprd10.prod.outlook.com (2603:10b6:610:184::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 09:52:48 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 09:52:48 +0000
Date: Wed, 9 Oct 2024 10:52:44 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Bert Karwatzki <spasswolf@web.de>,
        Jeff Xu <jeffxu@chromium.org>, Jiri Olsa <olsajiri@gmail.com>,
        Kees Cook <kees@kernel.org>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [mm]  cacded5e42:  aim9.brk_test.ops_per_sec
 -5.0% regression
Message-ID: <e79f17e9-2001-4a73-9990-fcaf764cc2cd@lucifer.local>
References: <202409301043.629bea78-oliver.sang@intel.com>
 <77321196-5812-4e5b-be4c-20930e6f22bc@lucifer.local>
 <ZwTt/wB/mmszSXc3@xsang-OptiPlex-9020>
 <8f5e8ae0-dfaf-4b33-ae79-ca6065dc96ec@lucifer.local>
 <ZwYmTnWEhgWO702t@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwYmTnWEhgWO702t@xsang-OptiPlex-9020>
X-ClientProxiedBy: LO4P123CA0114.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::11) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH0PR10MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: 20bbef8c-9bda-4394-dcf9-08dce848219c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j3fWfu4IVevqRwF0RQI68REPNY3aPUHwnDSEAL5A5rYpLNzQp1vEWVThP+Rt?=
 =?us-ascii?Q?n31qw6R5CwCvPQMA2IjpxCk6Gxwdxhz64xsXIvCpp0Aa98PUcw7K0y6XkV5i?=
 =?us-ascii?Q?OWLEdGx7gc9KQ2vwAlPFdB7fMCdtkKNGbptM/gCd3PGLyf8ZTEjY99PANnmU?=
 =?us-ascii?Q?vfTenTkluYiS7xAYXwVuDBlXkMPPqcPX1vNJQOMRVGp9naulkrWFrlR8IDa8?=
 =?us-ascii?Q?kAaJhB53b0xmDSRNo0OQAvJMXIp+VmRIGZ4f474nPgzFAlC6hwubRWXLzDJy?=
 =?us-ascii?Q?emGsPxL8WPabL3ZJUiQ3DCFoyVjMxjtwnBWf/qS+ySolyJdGD3dWdyxGO6l6?=
 =?us-ascii?Q?Pnk1yxvUeiBGm1RZdEtC5WUlqPbh9nenn3a5V3NtzdnOvWHz5O3OZJixeU/X?=
 =?us-ascii?Q?2A/yui6i3b4FXoPahcijPin65hCNFoxhIW6l0g1zDz5FJB8m6Cnr0bnVXWSJ?=
 =?us-ascii?Q?UIIGQ+H3jZPAF/Hv5DRBvd+2ueCXsQkK1teBrm2c9kWTTHmg1rG742jscmEJ?=
 =?us-ascii?Q?mbwPLl/Ik8gWO/8HkxmhyLibLBA+dDq5OcxU12d7L/leLLbWvhKdmWcCfof1?=
 =?us-ascii?Q?9HQN9H00gUEkr67TT77pzzf6oVYPwrb4Eio0WpjKDbjve7PevtzZBPT+kGRQ?=
 =?us-ascii?Q?i71z7ZBegKuyNhYDyA2y+Miw8mVq8G24EqLsz446/EE8kp1CLbkdzALMMkb6?=
 =?us-ascii?Q?fRvxaPLbHpNE4ZDvIh8JdAmIOi0p4ybXvSVdpWeliUK8GjLXvlEWk2WZJpcx?=
 =?us-ascii?Q?LnGz5FOEHnabJDhiEiQmNp3X/lnXGHsYj5HiwKuH/YtSQrWL0p/Dk4IkfwOp?=
 =?us-ascii?Q?a8e42ZFTl0fnftYozgn4VN0zMIpelTiS11YejfXhpIlN2LVAO1e2/0q5b5kc?=
 =?us-ascii?Q?2ySmVzCnYX1e+adwdaOP9T8+cGOFyx4LxDeRSaqt2oZ2ZcN7qZyBHOHG4oTi?=
 =?us-ascii?Q?9lkGiXy1H+r5Ee0MiTvUvcuqfLKlT3r2b8n8O7GGl/sZELcl63tpeQPjuBNy?=
 =?us-ascii?Q?Vl7rzfH8rIRL8cddRZBFIrZUSvwMEHe92DPtJlGN2DzRwRwo8AH1io0Ik3tM?=
 =?us-ascii?Q?fyqvIPT3T3vYQeoeOAKP+3dPYRwScK60Dy5GIaUBNmsxIJs2mkhc3HA26puL?=
 =?us-ascii?Q?WxqWPsYws5doV8P2CXOxcHx+7Jp6/bhNxW8lclM59riIHY/2Jkk22AK4h35M?=
 =?us-ascii?Q?OL2rjISAKrPK37RKEX7BsGFGio1GI3ymIa3n7Q5SKHEMD/0CXae8sv7V11H9?=
 =?us-ascii?Q?VpyDm2mM7QEphQAwyWmqzo4cBJrD9Lp6OIRf553BBw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CzwlAaCw+IV+Z5NCTnnp1v/52KtI99fyzgrSebr3qQdevdJK7ofnhBSCnC/f?=
 =?us-ascii?Q?DRToK4QsZm6ghB4AaOWlqHlP1+bCDT0FGY6d6qgJWiRVbKD8sf4217Xh96jV?=
 =?us-ascii?Q?vIEEnfD0zqjIp9tHGHxD+SQ8oCi1Z1ZMrtu9bVulRbAKsBLfRVv2kmGStU2x?=
 =?us-ascii?Q?bgWDLjrzISC/L0b1L2GavD7W4IeLSIKt56txMl6/PavJPDRSjygwn5fTET1E?=
 =?us-ascii?Q?5C5BWCxMJm8ACeqI74e2iaeSPemI5FoCMf/CtY/4/UZgDwZW+2DLJNB/6oOA?=
 =?us-ascii?Q?r+sjoShndUk3RjmJtUnxPsyeU/WQ5L1NRASZvPQvXeaTT4qdIvjiI9gIS87O?=
 =?us-ascii?Q?AGdmuFyFrzoM+JjR4c5z0lNGv+imfVgVEDvUVoHKF4XARaSdax5iE5nkpr1m?=
 =?us-ascii?Q?a2Be27+OjqiRqpXuLUceNLyncBI0pW23J95zY5vYuMUeLECaT8CHNNc5Ngch?=
 =?us-ascii?Q?MwfLn3yObCjIs2qov/NmukjpN9hftkhQGKtdglZ+JWAgg3VL5m/pxH1IYx6S?=
 =?us-ascii?Q?eJBH9u6K/x2cX2eWs9IiV65wNA1kI7Mmb0rlqR57JdsXJCx5Am+VvYWlZh/l?=
 =?us-ascii?Q?nv8KTteW7nFFTSlL0leV0pu5sXR5Jh6APvg0sAZT2NJtMD/tcKSeNhuUPvUS?=
 =?us-ascii?Q?t9MUP73vdPJD2zvjyxtGmnqHCQVYyUw51Jt+malu2xX0zX2tP/Gyn1R/Dwav?=
 =?us-ascii?Q?KODNWORlV+W6UCh69g/bVWmSj1/eLzl04a3Bk3xokcWiBjHFyDL1youYF9kJ?=
 =?us-ascii?Q?Qm+gljNOw3aVnmmK9h3+RyYs16VL7fas9ABrY/SXf161fD4/ZsPhjoodSjY8?=
 =?us-ascii?Q?L6r+9XuyurV3y4D5buZzn8HKe0tkz/AN6rdqN7ZbaHQbFcA3+otOlQVBkYsX?=
 =?us-ascii?Q?DODjlA19nYrfDfSLCvhCXy7ANtkxdRFnGhSlFGd0ouWqz46yWMGR0I0QaLWp?=
 =?us-ascii?Q?1ev+V8DT2FcHz1OC2Ny5oqbqS7B/oh10j1W17IQLM6FY+kkKUblVH73CPUUF?=
 =?us-ascii?Q?lRbsFy2shQF3T4lWDGGezbPdRHWQtbHCRwQ1N5vsuEgq3vHAnga1jex8KMuY?=
 =?us-ascii?Q?hCSfu3Xg6VLKvUc6ERjrBmsK58b1yWO36fWQVKo4ydpwpvYn/KMc5G0iTS8L?=
 =?us-ascii?Q?FTMlJkQbHhLd9XixRMJoXZEocUT5f62ENybVHQ4urneEQpHIpMLWXa7cbQbj?=
 =?us-ascii?Q?7eiAlwpBz1e/b0VBNZ5ONGpp6pzbr6eXWFE5kXDYe/it5YZTTJD0+g0mpc9X?=
 =?us-ascii?Q?H7o5000HZjxnnWKFnbIm00kSJvI8nj1kTb5YRUzLxLZwaPS6dlVqD9id3J7D?=
 =?us-ascii?Q?JCqBfDoog8jvTL6rkvTrYjnirDrZ93ZHY/Vo3sAQK5MW6O6NVtkXV49zTzUM?=
 =?us-ascii?Q?GuCy4gJO1sawUkZFT3ozRZ3POkBUL93TFRxupZ7BmPBFTrTSdPiljcdFzua6?=
 =?us-ascii?Q?KuWnyDQXjR/UZny5SqR3Jmizghm8HrdyxVNCu9qQB0bdokNRXil+eg38PUtV?=
 =?us-ascii?Q?JFs6O00dEuHY2C0Oroqa53zOfHb3TtH0z8eF/mNC7POdoqI/u4rRfcQi4EPi?=
 =?us-ascii?Q?58ATdbN/FsYFaF7OPULg3r63xkwazj/CS8olOXeAkdarC/efPUucnvpRsG+h?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EkNgV+ud1tHTkyKNercw/j3KLNcA58bpUvw8lJNNlwtU4J6fAjzvbdY1zguKKnkU9TpcMnFRhz8TVCHzc310CXaao+bV+UDukS94lYbSyAUAerzs5K3TzqblD5MNTyicrNf8XadNlYw9pQStChl7QJpkl5M4dAYAmFVb1bNd23lEDWlM/ylUU7oiwDzcEXjiKubUNZijnUJ/IG+jmNjnfD8C1ZNpE+huEGTxyHa2SNekwadA4aqMbw97Gx9vmWIMyTxDr0wa3Ck+/xIs8eRyFLJMBJwXFctqwuDXt6S2MMlLbtaxkEEVhqQ80AbRsLd+iQa/iWlhvjOjyPhGQk6+s+0hjY+NmOs4OWiMVxMGQtprfHfva0nE2Hx5Xg2buJYYhBFurRFkta0qq435wUw50xoY9MqyBl5mqddGaInnz7XzUCJ651IEkS9TWfrklpCVsjq2tX+hNTyosF8tcge9G8lg5TpOBL57HCdo9tZ7HYqmzsiRbXbhWkqAi1MWiV24OmOpqBEMpAc0oc2C6fnNo+Q8owl8jjdQYJZQpSsXEQ58mHJch9xrRsuazabgNciQKTsj6WUWbXsdsgfEtLkMwxH/kinJtIplyoG7T+LsCSw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20bbef8c-9bda-4394-dcf9-08dce848219c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 09:52:48.0067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7ymTz51HLb8KCOPXBqp3K2XIFsGImxUaIDe5sTfY3LEIMAvBf/WEF136JZY1HjqTjAC/nYwoQGZpXz69PkTFMGZIachcfh4cgBVKAVf8lc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7536
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_08,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410090064
X-Proofpoint-GUID: FGH6X1QIFSd5MOMdGcQl60_owCoqwwXg
X-Proofpoint-ORIG-GUID: FGH6X1QIFSd5MOMdGcQl60_owCoqwwXg

On Wed, Oct 09, 2024 at 02:44:30PM +0800, Oliver Sang wrote:
> hi, Lorenzo,
>
> On Tue, Oct 08, 2024 at 09:44:24AM +0100, Lorenzo Stoakes wrote:
> > On Tue, Oct 08, 2024 at 04:31:59PM +0800, Oliver Sang wrote:
> > > hi, Lorenzo Stoakes,
> > >
> > > sorry for late, we are in holidays last week.
> > >
> > > On Mon, Sep 30, 2024 at 09:21:52AM +0100, Lorenzo Stoakes wrote:
> > > > On Mon, Sep 30, 2024 at 10:21:27AM GMT, kernel test robot wrote:
> > > > >
> > > > >
> > > > > Hello,
> > > > >
> > > > > kernel test robot noticed a -5.0% regression of aim9.brk_test.ops_per_sec on:
> > > > >
> > > > >
> > > > > commit: cacded5e42b9609b07b22d80c10f0076d439f7d1 ("mm: avoid using vma_merge() for new VMAs")
> > > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > > >
> > > > > testcase: aim9
> > > > > test machine: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 64G memory
> > > >
> > > > Hm, quite an old microarchitecture no?
> > > >
> > > > Would it be possible to try this on a range of uarch's, especially more
> > > > recent noes, with some repeated runs to rule out statistical noise? Much
> > > > appreciated!
> > >
> > > we run this test on below platforms, and observed similar regression.
> > > one thing I want to mention is for performance tests, we run one commit at least
> > > 6 times. for this aim9 test, the data is quite stable, so there is no %stddev
> > > value in our table. we won't show this value if it's <2%
> >
> > Thanks, though I do suggest going forward it's worth adding the number even
> > if it's <2% or highlighting that, I found that quite misleading.
> >
> > Also might I suggest reporting the most recent uarch first? As this seeming
> > to be ivy bridge only delayed my responding to this
>
> we have 80+ testsuite but a reletively small machine pool (due to resource
> constraint), the recent uarch machines are used mostly for more popular
> testsuites or those easy for us to catch regression per our experience.
>
> unfortunately, the aim9 is only allot to Ivy Bridge as regular tests now.
> the data on other platforms I shared with you in last thread are from manual
> runs. sorry if this causes any inconvenience.

Understood, sorry I realise you are providing this service for free and
again to reiterate - I'm hugely grateful and glad you helped spot this
problem which I will now address! :)

>
> > (not to sound
> > ungrateful for the report, which is very useful, but it'd be great if you
> > guys could test in -next, as this was there for weeks with no apparent
> > issues).
>
> we don't test a single tree, instead, we merged a lot of trees together to
> so-called hourly kernel and test upon it. mainline is stable and is our merge
> base for lots of hourly kernels, so it has big chance to be tested and bisect
> successfully. -next could also be the merge base some time, but since it's
> rebased frequently, hard for us to finish test and bisect in time, some time
> we even cannot use it as merge base since various issues. it's really a pity
> that we miss issues on -next ...

Sure and I guess from my perspective it can be easy to underestimate the
combinatorial explosion of that.

It'd obviously be a nice-to-have for you to be able to take into account
-next but absolutely get it! :)

>
> >
> > I will look into this now, if I provide patches would you be able to test
> > them using the same boxes? It'd be much appreciated!
>
> sure! that's our pleasure!

Perfect, thanks very much!

>
> >
> > Thanks, Lorenzo
> >

