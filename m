Return-Path: <linux-kernel+bounces-560939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C74DA60B3B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BE5917DC98
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43101A5B9A;
	Fri, 14 Mar 2025 08:22:11 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2138.outbound.protection.outlook.com [40.107.215.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8111953A2
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940531; cv=fail; b=GlR73hok0cQD/+sI0S1tuFEj/5OS/fsrQyjzXlX4SAGnzJW+wmQUXVP2R3TJ+8QrUDxl2YPDbgNJPgFrBZgfcy9zcu1P0B3hOrsh628EMqDqTUACr7f5USvygtNw+wnn47+gOlXNQxpVgSDuwe4Jti9XTXMxp+oOh3CPrUMIE3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940531; c=relaxed/simple;
	bh=7+PXo1VOncHmQUdZBhLxPNiIDK4I8ldyawsy1/9nXUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuK9HBPF5GjwmcTHZzPGNmcPi0YUp2RRutR0SwmUCcQoe0oRf1mktU39EfmiSMgkAHa/fHSfaHKAKwp/fEpmS6BV9qoTMeqObf3yO0i9mW8gtwy87S4nQUIx9m3vWy6czuXRU1IQAPLqzasKobQbGyOAA6oGSE+fAo6IUC7V3Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.215.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1A2LwXnnjGwzm0jhW6i1kp6kG7Jp+1IBSF+i0scWyOmNq8938ItyVSg+wYOuUfCyX2jwNmf6QMTcCK6pZzO/4eXmz/qOOHzq1tcwLwNPdgkKgcdirgrdPhC6nfV1DbKwT0YtQdH1O7xHjqqkhZLzh8UL8uYJoKSZUA0QVRYxMBFDcMVqYaif0kH2ELgc3Idt+oBmIajUhs1lC09yjM2fXUeH9eeAeIwlSi8YzKbYF6nd9Bq3Q9fO9hOCLALT+Y1P5FyV0Wrg9kFXP3rnmTy5A+urXSdInJa5/8R+3tBpY+EsUvyfbfQnbJbn1QtQJURbwuYbJwX6RP9HvYAM81zLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tex/MebeXGnHKQsXjLkqmq7FTMxhAj7lKXMzQ1jvk2s=;
 b=dzyJcaCmMBHoWcbkMjXK3uya9pfM7uE5KztuLKBpXNMIj3fhyeyMbymsuLMQNm+w2GDkP0yQUlkLp00+sbGXpu7DIHfla7Hn08MOuZEgpQgBnjLTEKROobPtW97AvJH0XaZBFpujMUNED1MsahSsVM74Qor7/hrJdl1Cv2T0bOv5MfXMVzEFmYVj06CfbHFX8+Gf4L3gr3bErGv4I+i0Zz4XMtSVYlEG6p9xY7Q53achpr+wM1j6hTm5/ST4nb/KXNgENIl6GNcOMiG2olQVos2mjkuzD82BKDGVpvVEu8FfevfdnaQtfaQxq181ojnbmPJGe4WVJUKMynH+26e0Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2P153CA0036.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::23) by
 SEYPR06MB5646.apcprd06.prod.outlook.com (2603:1096:101:c3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Fri, 14 Mar 2025 08:22:02 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:4:c7:cafe::2d) by SG2P153CA0036.outlook.office365.com
 (2603:1096:4:c7::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.27 via Frontend Transport; Fri,
 14 Mar 2025 08:22:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 08:22:01 +0000
Received: from gchen (unknown [172.20.64.84])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 4E6EC4160CA0;
	Fri, 14 Mar 2025 16:22:00 +0800 (CST)
Date: Fri, 14 Mar 2025 08:21:59 +0000
From: Guomin chen <guomin.chen@cixtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Rob Herring <robh@kernel.org>,
	=?utf-8?B?77yMQ29ub3I=?= Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
	Peter Chen <peter.chen@cixtech.com>,
	Lihua Liu <Lihua.Liu@cixtech.com>
Subject: Re: [PATCH 1/2] dt-bindings: mailbox: cix: add device tree binding
 documentation.
Message-ID: <Z9PnJ0GKhmoHM7nr@gchen>
References: <20250313132405.742360-1-guomin.chen@cixtech.com>
 <63bba0e1-c1d6-4a83-b376-bcf89cb09533@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63bba0e1-c1d6-4a83-b376-bcf89cb09533@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|SEYPR06MB5646:EE_
X-MS-Office365-Filtering-Correlation-Id: 01bfdcc6-6af5-4b07-9dd1-08dd62d14bd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zXGW8hutNLeullmJpQ/V1XV80buZ1dqbka2u0erJYPgIXL/koQYwsLa38Ipk?=
 =?us-ascii?Q?pKLKG9F42lhmz/VPRji9BH3Lyk7uw7ixPnafGusDH7vWI+ToZuYocjhMkLaN?=
 =?us-ascii?Q?vP1qb3wcdC56uS34QqKuUU1wF6W7p4wyBEgNsAF8LzYLIpGTpi9YD/7RmwTX?=
 =?us-ascii?Q?Hn5R1u6xwH9TVTAgDQMold6Wwk255q5gLjnHW3OqrfLK876lMboz3nmrhX3V?=
 =?us-ascii?Q?Dli0rraLJKyGlsRZc++kFMMRqQ2x8pzi3xuuJ1kiYgJoBmHxq7PQH2t1tnfY?=
 =?us-ascii?Q?11E811PJKTSU4t3XuVbtW1G+AQJNaF9W4IATr4QUf4kB+ylL9YBVMQc7/gJz?=
 =?us-ascii?Q?/MeaGuIy22gInvjbflLbWhdTZiAkiSUNWEjuu/TBp+xgFFghP4Y7wczXKnh1?=
 =?us-ascii?Q?4/0Q2JyfOYMMVvozIkngDpAWrfnMLKlszsV8/tTEGlrtQ4klguHcxjXqslJV?=
 =?us-ascii?Q?SEYAjfAuAeIGjr2pduDdpeHf7eIlRFEUWMwqHOtDR5f3dizte2jcwoh7nSWC?=
 =?us-ascii?Q?4M6Dw8Kx9DqM3blRZcjOZsY/wNDIg1oa92A7jdESa8y2qvZeAK1kkOScL/vs?=
 =?us-ascii?Q?VE5lsRHSCsA4d45IvisGDyxNqZ0C/eMvtreVC4MjHCHQqf+1qIWNiMY8KvHv?=
 =?us-ascii?Q?9SE2qvxp21Bn+hE6Pk2cwgIbxPfGhsIZmUdUM9PuFHeOCYAMjhe+idHLgMhO?=
 =?us-ascii?Q?RzFXzvOif72M8ogsL+zOoDfm4wgs4o3x9M733PZkwZAbAo+L1WsBAakyY5kh?=
 =?us-ascii?Q?PxM4K8Qrb4zWBXWQrg2MsmxpRTZQBHm2hkfEJirItOBenRAvZ7wYkIWdhcP3?=
 =?us-ascii?Q?OLzzyppwIGuxBZoHG2IDOE5hBBqR/K4JFlQcHp24MN7lmt9K4b7C4ffSHv9M?=
 =?us-ascii?Q?BomkL/MxOlET9v/xSSYWRRG5qrgALjjgrzoCO964ZQx/ViCHKTUBYYg4895p?=
 =?us-ascii?Q?bVTqzu2oWvDrUXrmIBsZrLIBsvhve2+exfVRBM7ZKpSS8yV9KTlbtojKv6Ju?=
 =?us-ascii?Q?0dLkfDfbOD3kDi0LSjZv+keqtUBAmUpXjjL/dbgj/5zAr9TKUb0I5P2reEJo?=
 =?us-ascii?Q?om1SDZYw07n+Gy2IJmTnLYWNSvovQO/l/NWgEq+4lZnU/JJ9JGBllzK+qmgv?=
 =?us-ascii?Q?DRk72dEslsmi8173x21CXnSJSi+Z7HNqc1lt0X//Iq2AeoXxj20q9u40m/+s?=
 =?us-ascii?Q?lMjTLbONbfTn1zNBYoap0jmVQs9Xr2zuxWak2bu+TDLywT4UiGWqn1RyEWdb?=
 =?us-ascii?Q?4pHxHNH6KiIl9pcJuMeSikl4tSHuGfrIumEJr3+ZNFdberC+keSwuuNrQhrF?=
 =?us-ascii?Q?Fj+LLC4OUOKTXqjkcZfpXJfNG73/FH342Ci+6TzA6qIdZ0221fHUAIkO8j5U?=
 =?us-ascii?Q?opawV8C7BRm0NgKnO9wNmnsb2duynnqY8VMxySJgUcNfn5/ZnuagvMJD9PyL?=
 =?us-ascii?Q?g3SAZsig3iatPOEG5kzCQVCylqfERdNeJYzuvoEC/PICQNsA/uCRmp9Of4yp?=
 =?us-ascii?Q?qJeUwyynQepRyCc=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 08:22:01.4046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01bfdcc6-6af5-4b07-9dd1-08dd62d14bd4
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5646

On Fri, Mar 14, 2025 at 08:25:40AM +0100, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL
> 
> On 13/03/2025 14:24, Guomin Chen wrote:
> > From: Guomin Chen <Guomin.Chen@cixtech.com>
> >
> > This patch adds device tree binding for mailbox from Cixtech.
> >
> > Reviewed-by: Peter Chen <peter.chen@cixtech.com>
> > Signed-off-by: Lihua Liu <Lihua.Liu@cixtech.com>
> > Signed-off-by: Guomin Chen <Guomin.Chen@cixtech.com>
> 
> <form letter>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
> 
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline) or work on fork of kernel
> (don't, instead use mainline). Just use b4 and everything should be
> fine, although remember about `b4 prep --auto-to-cc` if you added new
> patches to the patchset.
> 
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time.
> 
> Please kindly resend and include all necessary To/Cc entries.
> </form letter>
> 
> Best regards,
> Krzysztof

Thank you for your hint. Although I have used scripts/get_maintainer.pl to
obtain the cc list, I do lack devicetree@vger.kernel.org
I will copy it in the next version. Thank you very much.

Best regards,
Guomin Chen

