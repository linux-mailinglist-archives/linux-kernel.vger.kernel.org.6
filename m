Return-Path: <linux-kernel+bounces-529326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFB4A422FD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB4F07A4307
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5E215198B;
	Mon, 24 Feb 2025 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KdlWrHlJ"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17142629F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407237; cv=fail; b=ZNgZ0RldH+VFqULP89yVwk5TOtn7tH4gQbGoZ41/kDoC5hESo5tYuwvn8UJJ+R5CxmP2CjTLUAr4hO55ReA9NcDGtYu+EaZ1zhk4N9UsX81VIbjmsXWzeJvpDv93aRlo3Sv6/NKe3sjCzvJBc0CYRkWAa3FSMRKg32SYckEze6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407237; c=relaxed/simple;
	bh=80gMgBel8CaZD5CXP4coDOMrJdWm02c80UUxXSKK5V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rv7SDVcmNrJJz4ZtpGJQNAQVty1/65cNUGwgpafQrGsOLyiqR5EQ+n0anRmV2/YH7i9HXof5s8ZqwECkenVvhN26+xwp4U+vhvI8QcVJZPpszak7weGSLqaiYTP6AHogoM73ddTsG6wcxqOh8cP7vHThn0AKT2SesVJ6kkG7zhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KdlWrHlJ; arc=fail smtp.client-ip=40.107.101.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+V3O8Ylrx656ozL6Kzi/ZgAbyiWMvddO71W1g3EAajjyCkV5ElwIVZceEafAgluAGgbvDeSpA0nYCVzTg/GWze6XHF1nep9yqY7rK0aDMa5INBL4Zltuprm67LPy0A4EW8ZyDeRCrDbbXORRlEfbVFtm934wZlJPasNBQ31y47lSwNFHY01nJeF6vF7O4cNWKfjifsAmSM8PWM4VxhATvjRmlaIW9K4b6LdAHOSCR1teQjqbnkKpRm5j2P80J9Uxy0sgz5sibHzCV6kgm5EVvMY1jxDC/5KETW2Egn9kYrtUSE0wKFP+VYZxOuiOS0VC2pOxBG2nCdz+a8zXTXJoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbD6IiDfT5798lvhocUGwXP0nLzJikwYDvOR1QokIdk=;
 b=XQoqqCS17nq6b+/hEyIG4wm1PR+HJIHNl4sIP4eVHvUXPWOFeXA323IVfXmjn6V6H+QdmkK8TNE7iMVS3JsuIkkHkXGl46HB4SxK8FeU3j6CRBXTBLRHaLBNb/ceX21pqAins6bNJhfUXCeH+TxgsNU0nTmuKpJKm2+tKi94gluVx0aMFGZZ+9c8nyf/UPP0BVHThY79Ope1FjurH0OWCB5puiqsCrDKQ99WrpPGxxZUxSID8A1WmyBychIlRsPB43Y7ONsl4Gbwr1EiPjDa2V1OM+BA7cGpelTCFFdHOb65+Sh7L9brGnwnH8F8OaSBpK0KBFzTeJbAfzEypnFAXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbD6IiDfT5798lvhocUGwXP0nLzJikwYDvOR1QokIdk=;
 b=KdlWrHlJSUjpmbVvfHoIXxUja518o6xgkpntQrFlmz62ysRgNMkiYw+362VqroFlgv8sDL3M6JfIdhuqxpV9NDAGqKTyGSehaGT2jIWx12qTxgbTuld67tT7SQP3N35tu4/tzRWF8N8RrIzIlweDm3+UD3d2h4aShEXQHbWgJAP2f6rytXWW8ljPBJN5bZff9XjbS1iERxHuKVHOw0e+eDn+BdXlGjrvgsqUAu92YtpTZDHbvQ/mOAFjBH9C7DhIj21co2wFLe2AIB/BQnHZWK9QzTr08pmXZ8IC07kLW0BsvnG+B0t93TjJ9U1jHVE8X2nXzVtLVId0otZKasYqSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA1PR12MB7638.namprd12.prod.outlook.com (2603:10b6:208:426::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.19; Mon, 24 Feb 2025 14:27:12 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 14:27:12 +0000
From: Zi Yan <ziy@nvidia.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Frank van der Linden <fvdl@google.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 2/2] mm, cma: use literal printf format string
Date: Mon, 24 Feb 2025 09:27:11 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <DC24FCA1-FEF1-4819-A898-D0704DC963A2@nvidia.com>
In-Reply-To: <20250224141120.1240534-2-arnd@kernel.org>
References: <20250224141120.1240534-1-arnd@kernel.org>
 <20250224141120.1240534-2-arnd@kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN0PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:208:52f::12) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA1PR12MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b63ecd-104a-457f-1b74-08dd54df5440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sjgQ+eH1DLFJsP1LBL0CilEeYXHFBbblqxVYEKZouO2ij9J5wrNhf/d4YQcm?=
 =?us-ascii?Q?IWl5+04GbFCq1nfAKMnsFNw4OwYJ4c81aQfJ7JGiyK4opdCFca960lg3NOh6?=
 =?us-ascii?Q?16Y6A86GQOZv+J3ek76pmtKeWCju7qMfL8+ED/wTSikF0bSXqwSc10DSxiPW?=
 =?us-ascii?Q?x3GvNmjEPH8OWrO9REvFNT9T9EKOfmyKwjGsXV2SoP/kAxMR2F0YmJ6N8jix?=
 =?us-ascii?Q?cbQJyyUxRygbeJ3ZrLjh6SBeFKd3QZlXpkTrGp07YIw9W6KUWrl4ZSXkGTIc?=
 =?us-ascii?Q?hXA6xbYkFF4rAuu55pECi9dTdShBjnr3fh6gW/I2HIfl8u9An4bBk6/2Nmr2?=
 =?us-ascii?Q?aGBhwDfM21GSSNMY+ZoOWICpqM8ewnyR1iAppc1+7t1vSYDEI/NP6k91oPAB?=
 =?us-ascii?Q?Q2DIdwIcX0dik4YVr6MHydqSio/UDkpbXXhyNcKRALK5JEMJRCg8ON7FhVQ+?=
 =?us-ascii?Q?o9j/Itmbw9CGy699oPssuwshcdVvyLMSicRrJKNesuVhjiTHw1w1ur1i3q8f?=
 =?us-ascii?Q?iDjuDrIcHPC/r0iKUZqvHiZi3dxfjuzWwQJ54HCa4dAHAm2bL/5mOaS3E00u?=
 =?us-ascii?Q?ULiKp4dTy09wtgQ3tawaAqKdLNTkGrunsnTtLTTYPyQt2SxRGmliZyl/4M8G?=
 =?us-ascii?Q?SG7iS2dO9CNAlDsv75hWgilzAwifnR5od9yvXAE1lFzZu5/t0bhdQ/1Ueuxx?=
 =?us-ascii?Q?5aq4w//xBRCyDCyjzfXly4c0wOEhQR0VuBrx6il2QXLhk/YWZbYTe5OGcnbv?=
 =?us-ascii?Q?O7bPXXMQCW0hzf5dHhSlyYv6zBjwte3McrAbf5nLQCeR0yNYDuiUGDAgOGk9?=
 =?us-ascii?Q?ZUbjxxRYRvR6K5woYcEu1k3vkjqRV2igei++QW3UkvIysOPeP6+EGiw0hD8u?=
 =?us-ascii?Q?3Vh27EXgLzD7SQ+pjom1npxsLfk/Cnx0NzDZug7C8c5u/i9rvAALExIVCugR?=
 =?us-ascii?Q?Y6gs7v3VsF3b2iIP4953NIm5eAWsWenWQg7pdSwoK6MprCxryK32/jaNQoSK?=
 =?us-ascii?Q?9XaljwlgaF0/gd2tOaTy2VuKSiaNxLa6/4NNdOSv1jtVEbL3OyOnhcMvieCy?=
 =?us-ascii?Q?I3Aezj3bo2pkBwlY5i59h5zggkPVkLMKWiNCKAgaDUZeFtAXfNcieca6rydY?=
 =?us-ascii?Q?O1eUMOqDDRxxVdCkVTs35idC2blUL/s3DToxMigNJdqhH/8Yxbx5Zmm5muuH?=
 =?us-ascii?Q?8MLfCAZ8asBPfGKu+5aK9kfZjCdnEytSMC6W1B/LROUWvnhOc2CrcPGzkXl5?=
 =?us-ascii?Q?0TOR6Qwr9XE0vTaUGRlCyfmchwp1TN043YdX+6xQwQfxkUXhIu/gkLz4r1yd?=
 =?us-ascii?Q?+ihRl7vdOhfqaKqMA4bd0+vef+OOeGFgH2Irx+bANbcxifs9DjY7vyglIxTe?=
 =?us-ascii?Q?u7SXWGo0u73dIx/0GvLRr5F1kXqS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jjx5SxU5e28mm/aa0QTAAN/W0C5NRftYRKJ+V2Oktd6PZEZsYgqRII6J5gQp?=
 =?us-ascii?Q?rqFfh0BcQ+JFTcp9+coEt/Qyq1WO1skuADu0nX1BusKfkAmKNTh36jK+1wnV?=
 =?us-ascii?Q?TtgaA6z6y1P74vKlkcYXQW+arPpm+jVfgEfhTL/xdX9PlnThoC9UQhZMeW+e?=
 =?us-ascii?Q?VSGhao9/Vy/Gmnaq1BZYfGXQEDxtNGbqBUcL4Q79PqLhRJ+RGhS47Er2a4pl?=
 =?us-ascii?Q?WU1FrIW+XIGiQIdTKQs6hDkWQAcgEKwgQhFwV2iUAY5YN9r2UJAx1OWAt0eF?=
 =?us-ascii?Q?dnR5n+SrBjE4O8VIFZz+VG5U1nrUoIcGsaA3IW8kYm31au899wz85kHiIWQy?=
 =?us-ascii?Q?kjxVrz6+ni2M3vATZrETM13uhIPEhmnSzpCaayqgXAK2AHJqpYY1fGIQzziA?=
 =?us-ascii?Q?gJMYR18w95o9RRNZCU+A/kA4C8Sq7QurwHhKahRZyb4HEOo1YHw0plQkcvSg?=
 =?us-ascii?Q?0wDnGWQbTdIJ5/Gqu3EmisQek/JyZF+bwEi7v0MJej1IoLcuUItosMZcEd/N?=
 =?us-ascii?Q?10fEfV1f/hUjGTyx9dudVPPS8SKP2GNPR+RlQ5unjr6qwOGlzvGrGfx3Yijk?=
 =?us-ascii?Q?+/zh9zJOBjw39THjEC+nJH5+VAQ9TFGwEP+MEZnCkPSB1LUIOX8JPaXXnNiS?=
 =?us-ascii?Q?CgDxnSR5YnjCcY8aqRhKH0dMoVuuhoRvW4H4XvlbnhxhwmCx06MM7gFX8zuu?=
 =?us-ascii?Q?TMymKzDlrYIOtGabLl/4WkPwrg9U+dXujJY+W9MC8+HktTHp2ATbYNOEB6lX?=
 =?us-ascii?Q?HzApkPhFPGsGDcw+xT38ySDZIGdOacrm5o61cNbdGT/QdmljtTnmsXFSQbZX?=
 =?us-ascii?Q?cITcrCwnN80uWU3SFzceX1A+JD0rJ4mNuO/AVgxcex2/rrqnSSCW/jB77peW?=
 =?us-ascii?Q?4TbWFdFepxBFyYnpWNsRgrpTP+yvOdfKqcw3xa+8U1/47QuGlUnYit0AB+7e?=
 =?us-ascii?Q?dppHCz6RSlECC3IEeTY7cYLPFWaFQaKpJeuOk13/mQapLMgEZ6TUbbbXllV5?=
 =?us-ascii?Q?qI3p0z5iDbXB+xKAj9yXuwxMKnEmoSaT+sM+mFtQblVhLqkZ8UeyDUCZtr/+?=
 =?us-ascii?Q?jOAwtHPebYmReawKjwa627ijBUAU9Fmsn5E6o0RsNGRdOsMQvw24dCi+o8Z2?=
 =?us-ascii?Q?NVa6XGbGT4276NX/AWmw+d02Q6rdt0FerSHPpCGamevmnNAv7Cnkdz9Z8SwY?=
 =?us-ascii?Q?ZK/Oxqm5SSrWXr4cd/zQqrlqKWB70WoDqAApsRRiM/vDlzORUasMcebAp76u?=
 =?us-ascii?Q?NwP21GUSJgWpndVvZqbya0cr5ygp0nCmZK8CblG6W8DT35WFD27JHYEPCLHz?=
 =?us-ascii?Q?cCRuarGZhj5cjtRSPjXrn03I+2CmmcDoe3LIEbBnTSTHEXd4fv42SL9cdvkf?=
 =?us-ascii?Q?4G7ATAgTP6DeDoY5At+s4IWRL6Gqr+VMzMvyYXpfqTiEtrOWoAFBlJ6e3Gbf?=
 =?us-ascii?Q?Tfsl8oSWcELOBBe1bqqRjCZ4ujlMCD+RXEtAjw7ig6PQgrCJm0jWPzCp7qZR?=
 =?us-ascii?Q?Set6hCcmbFyXPZcg0i5nLcbl8MzIabwJxy8j15fJ5c4iMklMcYq8DAXFFY+X?=
 =?us-ascii?Q?mAWjI2ePF5twu1ZgzdPZkqXJhBaAGj1vOWWmU0NF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b63ecd-104a-457f-1b74-08dd54df5440
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 14:27:12.5411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SxifNOG6QNNwluMn1WsfJeV/no747s3O7rNSyLj+NrKYW5Y5jViiuMwUoV5hxPFC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7638

On 24 Feb 2025, at 9:07, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> Using a variable string as a printf format can be a security issue
> that clang warns about when extra warnings are enabled:
>
> mm/cma.c:239:37: error: format string is not a string literal (potentia=
lly insecure) [-Werror,-Wformat-security]
>   239 |                 snprintf(cma->name, CMA_MAX_NAME, name);
>       |                                                   ^~~~
>
> This one does not appear to be a security issue since the string is
> not user controlled, but it's better to avoid the warning.
> Use "%s" as the format instead and just pass the name as the argument.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  mm/cma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

