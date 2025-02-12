Return-Path: <linux-kernel+bounces-511053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F123A3251D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE80E160A7B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE98720A5F0;
	Wed, 12 Feb 2025 11:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YK/69BO2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cRgfo1oH"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F99271839
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739360186; cv=fail; b=S6BPyarVNwj9rdIX3pURyy2aBpwRekRx4xl+Spw/RXpLT4+kVJ5c0y6twWZkKMmRixNNcDL9vu1geQ5prx0Xz14E8zC2IGZ4iDTc1arDLbqKrvhMBqwJFe0GpydeipVAvLOhLTxKLC+eFF6LUm6NXd6luy/L5izMC8GcD1SDKqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739360186; c=relaxed/simple;
	bh=NyahnSoN6067TbR6HSca27kBXE2ek0HbALjBbV4s75c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A78KlObWcQHs4vwXNwxSIxZJhJiGpBX9a3WtvuJSnagXJxVgtsJZMrUD2VN5T10Amza4irZ2pjsiD+L8Kd8sXdEHCMa5JlcojdWUICY/2Rto1HBdI5WJpU86NB38DcTLammya/XD3poZAWQej6/z4w+jsymSEhZWtj/KlIC228I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YK/69BO2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cRgfo1oH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C1CDFL030799;
	Wed, 12 Feb 2025 11:36:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=aEYGJosKtHIHnJnFhD
	VuPjmmQbwPctgwNh35/dP0WNs=; b=YK/69BO2rEkh45PQQ7jdnwX7HWzjXLBPjh
	fm8YJD1eGo2SHy9nZjwfb9NjnBpVKiw3RTPqPRPXXDOWnyYD/a6CfZXXdEtcpSD0
	O9fVQVZM+BoN2cyQ8IYT17ueznE5RmNVYFOAPPl4ZATTldfIgSalAxAVnsZnMGyx
	png4WUPD4cfVaBNoUTo6ly9trbg4cBCv5FIfD0qC2NYrpgJP/LDbX7mBNjQw5Vto
	5eGmIO6SAlIbmQ9WIqUTvEoHnZ17H0WSodZvN5LjNiLeJHn3/+68tF5lM9g1nt34
	HXBATGv6ONYxUHjtm1I0O/BSbrF3xJfWbFbBC7vyhIJfeeLiDL0Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0q2f6fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 11:36:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51CBYLm9012543;
	Wed, 12 Feb 2025 11:36:02 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqa49r2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 11:36:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdhSjtjijdgFjTBS3Sx8Wb8V+vdIpYmmBHbwfL/ZCNiG/XlY9aGhYVa+xPkI3WteR1juTelOJJLuziCfhrEsQft8pv/6K75OeO+xwGrMN3S4pErO3JAusuTET9Ne0AEdMB0uoCUPWnMLrJk06Faf3BLKyW1PU84mAdpOc6phLnj5EV+U/QFVKKxq77QzwPNQklbLrs1KPfgF88e6UVX0BDrW7i180+YkzJay2ZCbOkqN7UJDs/dUSQKp6maMzpkGU2FboJSAXW9lXJxfpyk4D5mbPBfm9e8pl4qhcIFyT91cmAqRCNnruOSnrV4iwZdu6e7DAdd/Sb4vbRhdQlEerg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aEYGJosKtHIHnJnFhDVuPjmmQbwPctgwNh35/dP0WNs=;
 b=eJqctuC9QvWRJdPmXGB+cfqAySoH+JujcnW1DK69gQqbxxyx78ItKGNldPWtDGlCKhH7q/dvRK2TGXVavUPg0UrKmOATZeI7HgsAgCTZIQVQvijLuKZjGUCfTsA8mvhL+UaZWJ42LkDu+b46dWHTBpXWDpFPlXTasxjkkdp/Aq54fP29pFiglVuY++Df8gmatcfOLz+Y3nX9l/mqX9Y5EPKCL6YCZqC8iMOOSjy9B7NG78mE2Kdydo2Ve3KtbI6FITaHXyxCvo0UfpSX4Rw8OtrzcP6UnKYw68L8dwVh719s9pJa2bJa+/y0N2RvbYM3rs4PdMAUTN0AmH8IpnTCHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEYGJosKtHIHnJnFhDVuPjmmQbwPctgwNh35/dP0WNs=;
 b=cRgfo1oHsjdD7HWFvjP/mFMY0FBj9tm0KLHI4kIAVGqW/ZFx5qrr6DuwrHkyXSXWo+/5OwVZ44YSFrCw+SqxeRLngqQUkfODmGsGjqYXM4ZC7Er4u10xb3d/NMz64dtdanc+jowbboS+nxRCssKfOdiKIYbbHfaCtd8CQYoj+k0=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA0PR10MB6868.namprd10.prod.outlook.com (2603:10b6:208:432::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 11:35:54 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8398.025; Wed, 12 Feb 2025
 11:35:54 +0000
Date: Wed, 12 Feb 2025 11:35:52 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <howlett@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Lai, Yi" <yi1.lai@linux.intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH mm-unstable] mm/madvise: handle
 MADV_{HWPOISON,SOFT_OFFLINE} from madvise_unlock()
Message-ID: <a822501c-37ac-40a1-8b1b-4765ad5fd86d@lucifer.local>
References: <2f448f7b-1da7-4099-aa9e-0179d47fde40@lucifer.local>
 <20250211182053.3639-1-sj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211182053.3639-1-sj@kernel.org>
X-ClientProxiedBy: LO2P123CA0072.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::36) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA0PR10MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: 3489b28b-8ca5-4cdf-909e-08dd4b596944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tKEYIkKMnl3/iFwTcD7hVZjJg+E+GhYIQ0oiSTtdU5Xuv/s6wIm+EPsa/ZW0?=
 =?us-ascii?Q?sm4DLwoCdm7r0yl4AvZbFQpB3SpmJwRPR+/DGxejmgijSipjSwo3O/Ku6GhS?=
 =?us-ascii?Q?svArOUaNy1dVrtknZA5JqJaZ9zByz0Qom3V/JmfDElh3v9x0roGssuQQjRzL?=
 =?us-ascii?Q?lC3iKKIMX0ysJiwM/ejBY5wxgXYlsZOYkxFuoFWNhPMS2cxWNUC048Fg1HuJ?=
 =?us-ascii?Q?CIEzeM5Y0zK/o+AGtityPjts63KcJ8jnPTKk6SRycnJ8JgMnjHo/0dckhad2?=
 =?us-ascii?Q?OdhVaForjRfDKyF4bHC9cUqlbbDvyyeS4DgR+YN3VlJYYxnwUBu6fjcVC2uk?=
 =?us-ascii?Q?iUTnlojiS+OQkUY1f3ym0zusmDXIe+9jYLRRmyvoJpfwoiLq90YE0nH8sJA4?=
 =?us-ascii?Q?MAp2/kc4Vl5i5p/1FH40V9wlt0G/wvZZgH4152dVe0E9jE1NFRu6St6534mm?=
 =?us-ascii?Q?18vJsOy8xk5lYPbr0LcIU2q+Ey/mYRZbHOFQweudx0FpQVYC30OiCu9yOegV?=
 =?us-ascii?Q?HgK3oVCqJ5QDSBWNYxTTC76S5KWcu5NdJNuvzFC0Pc8jO47g44KLl5hxpHGE?=
 =?us-ascii?Q?bsfmFwRAXJw42mKY9IoTOtwfDmdaG1e1jOc+XaGTBJ6sa1d/SZjhUK+SDDh4?=
 =?us-ascii?Q?Ba3fOq8BjeDO9r671PcudzzxTbMr9tPJIPKRoixH/CQjeDtqlOKShskMZghS?=
 =?us-ascii?Q?hrtOez+SNlUFleFxPUH8ZXF7MicOIB2kOjv0DkfhQyr+dx1uvAoHLAlMIAfS?=
 =?us-ascii?Q?jGzjROP+fOBVT6QS2FoXQFbOAxpJTTPe5LdmnGGWcw0HNgAHGQNgGp/kjYow?=
 =?us-ascii?Q?nEHPNx1wyvr3h5tsl0LyM3WfG2+b0m0kwweoFU2WKssdy6TeTZaWH+xRMuRq?=
 =?us-ascii?Q?zsEa4pEyWpMiTQPLYRiMofPKC524tpi59r4tXIzHfzn3kXGmrPzfIzVSkGpR?=
 =?us-ascii?Q?8OxI3Ka6Dp+FFRhgUK+T5ZgCr2TEBylNT8SIPAJOhLtcnwroaPLd7GCb9xje?=
 =?us-ascii?Q?u3kGAqJL2PrAXe3JELhB4mYRlWPh6sk0LrPlgNoyqm0W2FxBYLn4eB4y0EE0?=
 =?us-ascii?Q?1zDGR7sjy26TcJYgymkjCHMJGxSjaxwSH3LW+9km0KfunqTk7sLhI6aiQqyn?=
 =?us-ascii?Q?/W9lV3o6wDJxI0iGC5mMhOWEzW5TEX7j7tGINDRP2nqSBHuU/f7nNPEBMGLl?=
 =?us-ascii?Q?1TqTccw5KAMqseTN9QrjNNADCFq2EUvrpiBzWV0suoyw4t6G7vzgugjDXFE1?=
 =?us-ascii?Q?kuHWGwOzU/z1cpXo8EMoYElS5HFGWJLmo/fwn7J5oGQnM06QnrIUWLQHKTXD?=
 =?us-ascii?Q?Ss1tA4qUTWNrcJ7PsOoU7LOuTYyY4wUINQZWJ13ZZUWZWUCtRS/sxrN3s7pY?=
 =?us-ascii?Q?kqiiCCook4NATlaNvxSErd9TBJHw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iaUtWChcAgtQSlcYrjYKzZS8aTa7Yc3rX0IT5Qf4N4qXdBExtobrfgHdsyih?=
 =?us-ascii?Q?dDsKJnlAcUgKlhJFMHEQ97qCDH0/14SUotvbaGVQbD9pziRhs3kCRN94fato?=
 =?us-ascii?Q?JhAXAgzMgKsOWIB0tmx22xgrY/uFHRLs70wb3EFcJUEvlYzHQN/LqYuIYOyM?=
 =?us-ascii?Q?4sqTORSC8bA/xmds4EI/WS3NCifogoCY4q2Z1BkRILVMQQs4H9Pjo+cKaFVS?=
 =?us-ascii?Q?kELTJqsR9TRwy6vYsMzu0BadfcQ6s088IL8QTDFGeX+xmaCoslcT2ERGKnX0?=
 =?us-ascii?Q?d0ySCjA+oPn/u6GT9uB6UIhbjL7xpXBWiIJn1DmsW6IFvEl2buIRUL2W0rPk?=
 =?us-ascii?Q?ScVST8RZ1Yl7l14qDcM1Nky/GXNvdCyU1UNMoyZchsp/94wQL5E2tO4WAhTG?=
 =?us-ascii?Q?3K8ZJh8M9qkCHmtYnhgSRlvHYDwPu4hORHjK/kg3l2zMXeEN2vNA5ubwQ3vJ?=
 =?us-ascii?Q?k3zYsAoYzqh8AAWnWx5to8yRkSHw/MCgTqcj/DemaCJ0yYFXuBYaay8amW2b?=
 =?us-ascii?Q?8sP/igqn7rVwf+SMK9ltxtleGl9BC9nUIeG1Rjzz9oXltzhKuDd1AVOnqqMG?=
 =?us-ascii?Q?DiZ23CQjyFfnC7BDrjUBcD3f5LcbTutjHT+zXsxb925YXC2qKhBsKHG0+xjC?=
 =?us-ascii?Q?ublXZxJRpS6zsKkETkiQOYFix0R/iMoV/3jI4e3issfYzYcRJ/nh0EzLf3Kp?=
 =?us-ascii?Q?Hg0Sj7Ird55yqk+Tu6qwSvd8oBu0cLSC5/XqLfMDkUgn7QOBZtVfgxUYFlZu?=
 =?us-ascii?Q?VZiOWf0Mlhb+Fh0nidHhAbkGKP0RkkUDcDijavwWjUTqs/xpwaQ5e61r4WBT?=
 =?us-ascii?Q?lmyxizi05ekD4YgkvBJiQwdsZ+sVbUcEj7nxbfVhmPxIP4noKGDNeZ8Jnknm?=
 =?us-ascii?Q?oswGGb4sLx2qu9TmP68bqtG7rW5oqinoUGXVhFuDWsrhQ/zyAqBnyc8J/u5P?=
 =?us-ascii?Q?jKfuk77B4MIMPqf9tACuWFz+z6Fi1xrnET5Oll8V164621CX2XQUzapfcXLz?=
 =?us-ascii?Q?Uu48XzGclYg/yQZF8intvQnEHEf7duy4cKHcGlm+X3aY9K7wVKelvaVy181U?=
 =?us-ascii?Q?u9Cul0OtjnZQ7Gan3zhoH1UXR5FgjoSgzDdxt44Akv3lujxeGpUNNcaHqB/p?=
 =?us-ascii?Q?Duhoj4SVJMDTht7twfFh6vRuFn+QOMbMbCiGcNKmIMkjUUPK862XLxcTrKfH?=
 =?us-ascii?Q?nQSQaPDCZGtOsz3CNFe+outukSZ0Pxq3l+QM/i57pXsku2FRBIimzJba6bhK?=
 =?us-ascii?Q?S8DJObVZ1MMKRUbMpr3nzMbneo7K27Z9aLV5L7wIj5Qr39i0s+3+8W0+VxxU?=
 =?us-ascii?Q?jsKimFa4CMh3/3FTIImmxxeY++iIWWO30SvlOjmcyZvrQDzuF7Jt7amrRgbU?=
 =?us-ascii?Q?auCF19WdGnUgKS+mhcJQ8sTTCGGe0SQvuivmI5wLUOyl0gZzplHBtzWKfh9Q?=
 =?us-ascii?Q?c9nuJEkP1Xx8lS9zlwA/0i7P+8H63dpqChUMl08CtHh7OeC4OjHzb/uJehFi?=
 =?us-ascii?Q?k0g5vYV5M+0ZLkZIlxdNj2+MpuQGpcConGMkz5bJkfN3wj+qXxn1waIi93d1?=
 =?us-ascii?Q?wucqKGZ7CAm9JbEhFrO3eCgNFMMNBv/mp/hcDvlCc5foHYcX6BAuv8QLNeq4?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RHWDcp5e6kSTO4ZwGCzGEfyuIwRZtLDQ7KwhOvlatLtq3WdkYlo7lSe0+TCn/kj9yZ5qu3uYXg8xeoylkTTWLKcKRCWUgaI0J7dJjn27jrDYIglktuDQodSY21b5gu8em+iVMbGVdl01hCpS7bqjnCPUYnwEEycPADHT+x0zxWz29f6MaAO2YnK7OlUDqBXOHoWoshv/fkbx0iABjemWkBQBEyrL9WGnYiXhQSnc/+29cjff2g7W7DClGPKuv721Q0HizaZyEChOl7PRfYt1Q8l2ofjLPYHN258zzMwSFWmEGVzTML2UQYG6mq+sFyDD9DR114Q8OAQnFcuH+ekqljMgyqfoeMxDKv29AqvBnRsEpR6Mwt6doAnSuUzKl9MujjYoFGV1tWJD6qYkRBGzxVFF9SPEpLkXf2BFXlyEX0Qxmrx/LChGwtBVVDzNT5Hl2u8t2rTKSggoQqQ+ByUxUyvDpMkMfmBbtn06K8gwly44EMja3U8KD9SDJY6Va7AooFOEqH7tM28v15gdYdqYBnSUzfEsh1JMc+r+WyQ4uDWa8UK99TYuiooPveAWRre9K6uYcMZkrLcIAntcsvdjC7X28pNhmC/aeA3cvHe9s6U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3489b28b-8ca5-4cdf-909e-08dd4b596944
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 11:35:54.8244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+L9Oxu4UejGEPg07H7u/8NgGYeyFCzGZxmcpceB7NHoPkngPoaKjxGXMbBk58NXvQqq9tshyEfpXk4kd6UdFe7q+HrnxWdJbsHtOvcN4BM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_04,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502120089
X-Proofpoint-GUID: 33S8dNk3Zldj2LEF6GkCXsf14Tlw5qlZ
X-Proofpoint-ORIG-GUID: 33S8dNk3Zldj2LEF6GkCXsf14Tlw5qlZ

On Tue, Feb 11, 2025 at 10:20:53AM -0800, SeongJae Park wrote:
> On Tue, 11 Feb 2025 10:51:41 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > +cc Naresh, Arnd for another reports/discussion of the same issue [0] while
> > lore/lei is broken.
> >
> > Hi,
> >
> > Lore breaking means I missed this :) thankfully you cc'd me (_this_ is why I am
> > so adament about people following get_maintainer.pl procedure btw) so I was able
> > to now notice + reply :)
> >
> > This is totally my bad for missing this on review, so mea culpa.
>
> No worry, your reviews are always very helpful!

Very kind of you to say :>)

>
> >
> > [0]:https://lwn.net/ml/linux-mm/CA+G9fYt5QwJ4_F8fJj7jx9_0Le9kOVSeG38ox9qnKqwsrDdvHQ@mail.gmail.com/
> >
> > On Mon, Feb 10, 2025 at 10:32:01PM -0800, SeongJae Park wrote:
> > > madvise_lock() does nothing for MADV_HWPOSION and MADV_SOFT_OFFLINE
> > > behavior, but madvise_unlock() does mmap_lock unlocking regardless of
> > > the behavior.
> [...]
> > >  mm/madvise.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > index b5ef8e03d8b0..b8969457f3ef 100644
> > > --- a/mm/madvise.c
> > > +++ b/mm/madvise.c
> > > @@ -1577,7 +1577,6 @@ int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
> > >
> > >  static int madvise_lock(struct mm_struct *mm, int behavior)
> > >  {
> > > -
> > >  #ifdef CONFIG_MEMORY_FAILURE
> > >  	if (behavior == MADV_HWPOISON || behavior == MADV_SOFT_OFFLINE)
> > >  		return 0;
> > > @@ -1595,6 +1594,11 @@ static int madvise_lock(struct mm_struct *mm, int behavior)
> > >
> > >  static void madvise_unlock(struct mm_struct *mm, int behavior)
> > >  {
> > > +#ifdef CONFIG_MEMORY_FAILURE
> > > +	if (behavior == MADV_HWPOISON || behavior == MADV_SOFT_OFFLINE)
> > > +		return;
> > > +#endif
> >
> > I agree this fixes the issue but this is horrible. let's abstract this please
> > rather than doing the same crap that already existed, only now twice.
>
> I agree abstracting this is a better idea.

Thanks!

>
> >
> > > +
> > >  	if (madvise_need_mmap_write(behavior))
> > >  		mmap_write_unlock(mm);
> > >  	else
> > >
> > > base-commit: 8bf30f9d23eb5040d37e6e712789cee8e71e1577
> > > --
> > > 2.39.5
> >
> > I attach a fix-patch concept for something I think that'd be nicer, do with
> > it what thy wilt! :P sorry I don't mean to be 'one of those' maintainers
> > who copy/pastes code + demands somebody do it (by no means do I do so), but
> > since this is so small I feel it's kind of quicker for me to do it this
> > way.
> >
> > Obviously take it or leave it/adapt it/etc. This is compile-tested only...
>
> I further ran the repro program and confirmed this fixes the issue :)

Great, perfect!

>
> >
> > ----8<----
> > From 9fce3e47bf0fff2a2291be66002af346cdbca665 Mon Sep 17 00:00:00 2001
> > From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Date: Tue, 11 Feb 2025 10:44:26 +0000
> > Subject: [PATCH] mm/madvise: fix madvise_[un]lock() issue
> >
> > We are asymmetric in our locking/unlocking in the case of memory failure
> > madvise() behaviour options, correct this and abstract the memory failure
> > check.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: SeongJae Park <sj@kernel.org>
> Tested-by: SeongJae Park <sj@kernel.org>

Thanks :)

I accidentally seem to have included some whitespace errors which Andrew
kindly fixed up :>) so apologies for that!

>
>
> Thanks,
> SJ
>
> [...]

Cheers, Lorenzo

