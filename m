Return-Path: <linux-kernel+bounces-201269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08C38FBC2C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EFDA283BE1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE1914AD2D;
	Tue,  4 Jun 2024 19:08:19 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820C914AD19
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 19:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717528098; cv=fail; b=mZDiFNMhfzgClf2UKU7KnbnuOb0KhvSkJXOZOvKAflMqHKanO6Y3oIqH6z7bFLOzgdvK0siw1PBkKDBPaP9hfNOVtHY3cHGh0k3QEhH3iFjZHNWR8NJolvdNnB/j6pHTF8+8kU/eSzdgVAp8xQLbivosXmtoTGxvGy1XlxMaP9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717528098; c=relaxed/simple;
	bh=FtvOMUL0D/NyK9mF7XsADaWs7XODP0micCfAWVWoMIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UWIBTmikSK61k3wT/jY+BfzcLyadtdAzicKESujEPNKIL8zUWP778t+7D18fwU+3atrMxS4MAZ7iHyzyzgs93EhWAhxGsygSOsfyVNybHcW7DOMqwAK09fYtvu1Q8FMNbUtWKKKr8JbHCRFNs/XgXhY3HnrWcRC0Aqn4ytvcJaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454Bn1rH032558;
	Tue, 4 Jun 2024 19:07:52 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3D85VovpMpIP3gEPDnwwZ2HPQaQKSoqbRhMrOZ4Pqj1NI=3D;_b?=
 =?UTF-8?Q?=3DQGPOI3tyg6eDpgmn1rP3Pf9NjoDPbgpr6NiR7z9bbgdZEd4Yj6OAtz4Au6bF?=
 =?UTF-8?Q?Q1KI7lFv_aXkKIZCRV6C2640hhVo+Mi24nkm5grtmJsiAgvtot8/S0VIWd080QJ?=
 =?UTF-8?Q?JFvXusrR+Ckvb0_DeVcfnJCcxk5ViU9RNTB3zU5xLq5PxKLcODFRC0/17k6GK3D?=
 =?UTF-8?Q?39iYnQewmP8Tp6qHAHrG_n5ZvTJ5Ex++qVzbx5lpT9Q7j1UtGlHH9B6q8qJUN9N?=
 =?UTF-8?Q?uD+Wsc7oxi1nakqEuIYjxbNRaC_u8I24Q8EostFh9eti1UV5/SJjn3WsufGM9vT?=
 =?UTF-8?Q?eVzEIrWaXxOjFBk4xBaUGpMcuMPibYF+_PQ=3D=3D_?=
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfuyu5q5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 19:07:52 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454HQeBQ016188;
	Tue, 4 Jun 2024 19:07:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrsaj0e3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 19:07:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvgVoqFtLHhL054LGTEERNwCk2iShKgd/xj21NJ9/csYA5HsHCpNAT4NC45+RAs5ioZeJLwNELsPH1zeWJL+1P4Se9f1ZJzOk2EXSLWiMY3YyTqIwwFPLmFwTBS8r7w5LzSjI92LTb8u2zy+ZkP16/2tLitLP2j28qCfz1oFBNzMsyYQNsTu+B3hxpAVX4jrxg1e1+ODrc8EjLpAJtdHMzGoqzLm+ZBQI2H732utlxp4wUYcbee8XhYLjAWYT9OIiWFTrupDai2xLxrbaVi3wt1itykTWvdoq06jK9UWkE79elVO7/lZkRbeFmt8byeeGdMEcn8wL5lhaPH2bDTRFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85VovpMpIP3gEPDnwwZ2HPQaQKSoqbRhMrOZ4Pqj1NI=;
 b=cHaoklsJaPQccHkd/KekEvJNOQu6kSxfS7Q4Wvxs1zYVlv3dwrjD32EhA/AsWiMZRnr2K/vKsXa5KCA//E1LAEUPAuL8vvkhy8QnAy7p00y3uMh96kMkBGPtxF2DoartyjAquBwdewRjJPFSzoU5ivtIv1VB4iY85+xHvaVaE5LFImYaNkw8qFAKc6OHA9Q+3N/7eamhKUh5MvwZ3yd//E0gTLEK/RIggPAFhHlB0U7ncpjH5MdmR4gW6YFxxxR110fBMXHzYepMpmD/9v50vqlj2fKh93F9ENCSe5k29mt0ePKRqWxbTNH/VnX8z9MLwlpor4JPjqfdS+KH/N4lsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85VovpMpIP3gEPDnwwZ2HPQaQKSoqbRhMrOZ4Pqj1NI=;
 b=PfeTXkkwJDCtkDYeBY63Oc/9NhjTx0+WZAGRoYp2PIxjNENNcaluXa278lJTa0QusFmvY8HagSKlztDPb8AJEHaaXB4J9nXs93KYwfRaSERHlG7zmvCHW79IBMxORumxojwTuMHARuZG2+F5Eva1aTMhCHpcUrbDN9H0V8wz9OY=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SN7PR10MB6954.namprd10.prod.outlook.com (2603:10b6:806:34f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Tue, 4 Jun
 2024 19:07:48 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 19:07:48 +0000
Date: Tue, 4 Jun 2024 15:07:46 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        zhangpeng.00@bytedance.com, willy@infradead.org
Subject: Re: [PATCH 04/18] maple_tree: introduce mas_wr_store_type()
Message-ID: <hk6t5c4fw564ne4znymgwhoo6blgbtjnk623thr6zgfd25uvjf@pkhk5uqzykww>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, zhangpeng.00@bytedance.com, 
	willy@infradead.org
References: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
 <20240604174145.563900-5-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240604174145.563900-5-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT3PR01CA0077.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::25) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SN7PR10MB6954:EE_
X-MS-Office365-Filtering-Correlation-Id: c6fe4c22-14a5-4d46-8f3f-08dc84c99ff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?bFcWlEfDw/VTJkGgtJQ9gDbQuHizfykdiPCGdBnQBAo+l6ASyDm3QSPQmZCq?=
 =?us-ascii?Q?ndRoO9p96CvxcXE8WeNRV6zGW7EQLJ9UTD9BlR9rRF4LcLIIQgic9DQRedBd?=
 =?us-ascii?Q?Nt7W6sSD6WW/86i+zx6AjD/058gL/YNkCwLI696Uj/NLZW55vIUpKGnaL1Dh?=
 =?us-ascii?Q?YGi1wKzfh7gSlBACfNwB2thVRkQD/hOXnu40IG9JWhxHwJvo4r6CkSXleXKy?=
 =?us-ascii?Q?OZQvPjvMMsXasoGH6ng33kxegAJqamGX1AuTPuFOVaF0TCksNPvU8Np94bng?=
 =?us-ascii?Q?dfxgyt2q9LS9KiKV89QjXOfwJh8XhjPvhQ7/8Fzx0bh2gqmwNDBM4JPMWvmT?=
 =?us-ascii?Q?iPaA9gAbA5bmrJvtvSk53rqfZY4Y13MCufam1ZeNvYgyz9fVQFcRSRYmvg1e?=
 =?us-ascii?Q?kZT6HYzbuSSVm4CqU7bn1ijFs6NWLOZd8lag79MLU875fsdLdZjBkJqnmTxU?=
 =?us-ascii?Q?7gAIgb7LSLXQpFI/ATaE6+kFRegN0utjrTZ95ciMqrYTgdcIfsZVzleZTjwq?=
 =?us-ascii?Q?H+YW/AfD0zqETTSoNIq0VZ/BW2hBoVlyser3s3610IRVO2faFqMDgMNCgunM?=
 =?us-ascii?Q?zq1TlRRORgFD1uLyqV3DKyLjmt8mPrXRujOFd81RXxwrOuLVmE+PjTHZ2/Bz?=
 =?us-ascii?Q?42qOGMiwUbo/UJt9qMkda3bXrkV9e1aDxd41BJMMDxOEjIEyp69WZUbGza1i?=
 =?us-ascii?Q?m5gJkIy+bSNteD5Wt3fTW1kZJAEuxkFBZfnmlCgwTNhTkkFVM+Q7URiFuJ1D?=
 =?us-ascii?Q?HyLqYvi8JNu7Ntyd24KxddUq3RbRIbe5ZcMD1GHJ2h7UmjYeURXdECw/xWO9?=
 =?us-ascii?Q?Bv01RkZk1PqSPdjH8T173NVv6/8bqyiZ9H61Vr17PJFnZ3FoQy2sgFZlpChd?=
 =?us-ascii?Q?ALI0TtceKPuVaaXoRNxAJlqX4xOSiNljforbUsQ/AUqH264vVKlkkWvoyuBu?=
 =?us-ascii?Q?vrpYJsUBvWW+RAI9VUkji179Q4aKU9bVrUZ/b+EEs/QncPZypo6+bSsVDEWe?=
 =?us-ascii?Q?JLzZbdcKMKyGraZk2DhoUi/TlipIiuIArv3yQZh/TKeVkm3f6jQ7lR/z666T?=
 =?us-ascii?Q?JtyNmR2976m2wN0QbyEY6UDZfZphadTY9EZBCcIGVz597Vhof+aXO3gQd1ni?=
 =?us-ascii?Q?YKEAZQSQhRe5SdEgMJ4VA/HNcTqdT8ElIBtMj8CvugS149Okjvda9BkJobhQ?=
 =?us-ascii?Q?INtfvcV1YHAp8SWxKsxAdRWAvggXvIxdxNE6dwfNA4+gHvSAJXAhCekMBA1U?=
 =?us-ascii?Q?9zTGWnDFdfvoulILX7QNKKiT08BR4fcIjBc4F2XxMw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?u2bBe8sbV9wogB7ttvdf6aGQIG6JS+PzPVqiUnwscX39cJ84ed51V2vb9exm?=
 =?us-ascii?Q?hFjTij5goSWQur3ZphcEEc8KSHrJOQ/gCsck2EpUGNY3GDVMFSkEW3ZUT6he?=
 =?us-ascii?Q?/GZK5ZcMFYS/olaFQEBJZRcwlgZpK84l3S+hKaDyM9CmDBtLfJ1SQT5VCH9m?=
 =?us-ascii?Q?sBjiBuf1oBf7WRnRuVbKRYSRQ2sIRDsQqV1NXtxx8qi4XIve8Ofmz3if+N+r?=
 =?us-ascii?Q?lF1+Gi4DVn3MFOPjkoLciwSLh7EA/CqcLh6eZ4anbXwxGSBcMvbaKn+zM9DM?=
 =?us-ascii?Q?N+lGPzH0PUyKalr/CjKJTvc7wY5ppWWWIYLjPLvG/pGVuznszb20q+JCy853?=
 =?us-ascii?Q?Z14JuSUqw7eewyX6ATKYT4HXZRFtPLT5WHvEObq/NAxicxO4zweesnnLKI8i?=
 =?us-ascii?Q?4bgH60fKnWjLm44DdP2utdRnQcNWy9OQGsfe6DbKOQ5VdAfIZlGZJQ5gUCXG?=
 =?us-ascii?Q?g4CINmXitFj/U2rje6KyYyTzDPvWG2aLKauIaBHF3qG45VBokiXV6kBa97Od?=
 =?us-ascii?Q?oom0YXQB8jOMr9O89l9EhIY25zcEyF5Iws+xQMt93gHOUbOi0mw1VdacILnl?=
 =?us-ascii?Q?4SwEMCVLWLB3SccxI7MtJ6h/XdqRSVLxEMn2fXOIfJcO/MxKJkxBblWFxUri?=
 =?us-ascii?Q?8Ra0vZdvUGbuaB3hJ995ibUNxrOBY41i3rg2AyxZCYRCR8f46/jIxa4vqa42?=
 =?us-ascii?Q?ai8JNIoYWC4q7eeTpDV4fcobV4tk2UFq2Go62pFNHwLH6b2FWlmYQBRrOsd3?=
 =?us-ascii?Q?TjjynQ5qraZTC1W0mxgQc6S9issMKQYUnadj17TjIReCEZzru+aahawt63ih?=
 =?us-ascii?Q?oFXkZCCkUQOoIas0rfRSriGAvQPFiNyeY6+byD96Lez/EQQ8jE3tL/M7Gbvz?=
 =?us-ascii?Q?JAedL2SUTXpT9x6/Y/y9okxTUlii4Y2RR7X9pnZmY7rq1zpunOw7VlOEwqyU?=
 =?us-ascii?Q?4DSNsxEAyf98kK7JTxQTpQUe3BqcZejyfg0WaDyBVEh9FzUbeus/QraeJRlK?=
 =?us-ascii?Q?jXMpcFjeoSO/FgnzwrJYsD+GeoT3NXEg4pMGu/VuGi66myOApuUlWwTnPE+2?=
 =?us-ascii?Q?kAw7I79DM4wiT24pA6cLMVfo+WFIdhlHykEViivfS2ekuMmPlGwd0buQyD+b?=
 =?us-ascii?Q?dhnjuAxXk9bu/pjEUG2Ag5siSuDI44RTZer9HRyONAb9htPPcf/l5dd5mQFm?=
 =?us-ascii?Q?kVneG0LN9vh8EeMolx5Cs1DRXa5QH+0JOj0mpHSeZ/j/wpQk7oxvp23fJ1DC?=
 =?us-ascii?Q?TIXGOHIXZ9nIlKilQsxy9npv1vJrjsKkoVsCEhPnBnwOmPs4wMV41piOun9c?=
 =?us-ascii?Q?SA2OPHAb1hDdgSzNEzWT1jmMFTj/lxClbilLbsOTAmP8HTCQVX7xJuuUYKUx?=
 =?us-ascii?Q?o/oMrNNG80utSW3zKVDMqGK5eIDvWBSFthqtk66Svx6eJTzu5iktQ1DPmJ6G?=
 =?us-ascii?Q?h54RtmskqgaMjoPTnMlMShN7mjK4l6pR5jGlv3c7WTr5G5CzNUuakrRxK2eD?=
 =?us-ascii?Q?+7rGzpA4WKlxZK/xe0h70A/j4OogaE/Psexix1+aNGARWtG9IPWf71mIBXa/?=
 =?us-ascii?Q?XicaP4lCswjjuZltz8HSD8/CoGbRG8GlxFq/0+oe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZCCTIJL7X5QM8r/cPNikbMFRBCm14NT/FHP9vKXH+MJu4pLVDAReW5KWf/0HYu9dHJ71AHi1Po+OZ3GGjd8+VVH110fyC6x4SzS69y4RCLHKrlVRzJu165vZpYVMr4fOB8bg3Y1jcFRRzGQE8GJRz6yYeBifWUlGon5rodOLK3FfPr1joSGYfgCuQ9p95gm9UDzmIJVKKbma9gAtWlmYPt2SUGRdwY6pC+WTEnIJRYc/mgdyrKMbnWmL3/tolYE46PjpRDdFOG3CkurPLEGT6IPkWL2PPmkEmuijbxG4fLMu9sZMdePDzLzy9uh8E7erVPeczSLgc0dbkeRPDtbXLE3zir741fOHminSF3ynUUENQjao82Gj8/FWa5r8lxSEqwvTIZcGoqzjpsCpZQ1vx9cP225ak4e+OgjYWsZ+mChE2wror9rZTWkitAElXO01mKPibOGi4xLv27xM/o5yOVmbwzk+raSAzXWDrHsmjA5JeFhQEhNU1bFjZx45SmBwiVCXFTWhUke4b7fG17WGweK8tulpDliE52xf/ic5ccBfdXD1IaOAnBGb0lNpMKQjazs1WmhVFkOXWI7qNzVTXNuNyCwLEId7mQEWBKa8rwI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6fe4c22-14a5-4d46-8f3f-08dc84c99ff1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 19:07:48.7956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g9FOdHAZFGeYkhBP7rC6s2/hYuo16NIXUZw3+co6aORNJR2k7Z4A04+AFuhdv2J6Iq73bsE+n2Q53/bi8RvYEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6954
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040153
X-Proofpoint-GUID: ozW_IGZBCkUVWyZ-fD7T3VrUCLEaRRK8
X-Proofpoint-ORIG-GUID: ozW_IGZBCkUVWyZ-fD7T3VrUCLEaRRK8

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [240604 13:42]:
> Introduce mas_wr_store_type() which will set the correct store type
> based on a walk of the tree.
>=20
> mas_prealloc_calc() is also introduced to abstract the calculation used
> to determine the number of nodes needed for a store operation.
>=20
> Also, add a test case to validate the ordering for store type checks is
> correct. This test models a vma expanding and then shrinking which is par=
t
> of the boot process.
>=20
> mas_wr_preallocate() is introduced as a wrapper function to set the store
> type and preallcoate enough nodes.
>=20
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  lib/maple_tree.c                 | 210 ++++++++++++++++++++++---------
>  tools/testing/radix-tree/maple.c |  35 ++++++
>  2 files changed, 186 insertions(+), 59 deletions(-)
>=20
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 2558d15bb748..b37fa8690558 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4278,6 +4278,150 @@ static inline void mas_wr_prealloc_setup(struct m=
a_wr_state *wr_mas)
>  	wr_mas->content =3D mas_start(mas);
>  }
> =20
> +/**
> + * mas_prealloc_calc() - Calculate number of nodes needed for a
> + * given store oepration
> + * @mas: The maple state.
> + *
> + * Return: Number of nodes required for preallocation.
> + */
> +static inline int mas_prealloc_calc(struct ma_state *mas, void *entry)
> +{
> +	int ret =3D mas_mt_height(mas) * 3 + 1;
> +
> +	switch (mas->store_type) {
> +	case wr_invalid:
> +		WARN_ON_ONCE(1);
> +		break;
> +	case wr_new_root:
> +		ret =3D 1;
> +		break;
> +	case wr_store_root:
> +		if (likely((mas->last !=3D 0) || (mas->index !=3D 0)))
> +			ret =3D 1;
> +		else if (((unsigned long) (entry) & 3) =3D=3D 2)
> +			ret =3D 1;
> +		else
> +			ret =3D 0;
> +		break;
> +	case wr_spanning_store:
> +		ret =3D  mas_mt_height(mas) * 3 + 1;
> +		break;
> +	case wr_split_store:
> +		ret =3D  mas_mt_height(mas) * 2 + 1;
> +		break;
> +	case wr_rebalance:
> +		ret =3D  mas_mt_height(mas) * 2 - 1;
> +		break;
> +	case wr_node_store:
> +	case wr_bnode:
> +		ret =3D mt_in_rcu(mas->tree) ? 1 : 0;
> +		break;
> +	case wr_append:
> +	case wr_exact_fit:
> +	case wr_slot_store:
> +		ret =3D 0;
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * mas_wr_store_type() - Set the store type for a given
> + * store operation.
> + * @wr_mas: The maple write state
> + */
> +static inline void mas_wr_store_type(struct ma_wr_state *wr_mas)
> +{
> +	struct ma_state *mas =3D wr_mas->mas;
> +	unsigned char new_end;
> +
> +	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas))) {
> +		mas->store_type =3D wr_store_root;
> +		return;
> +	}
> +
> +	if (unlikely(!mas_wr_walk(wr_mas))) {
> +		mas->store_type =3D wr_spanning_store;
> +		return;
> +	}
> +
> +	/* At this point, we are at the leaf node that needs to be altered. */
> +	mas_wr_end_piv(wr_mas);
> +	if (!wr_mas->entry)
> +		mas_wr_extend_null(wr_mas);
> +
> +	new_end =3D mas_wr_new_end(wr_mas);
> +	if ((wr_mas->r_min =3D=3D mas->index) && (wr_mas->r_max =3D=3D mas->las=
t)) {
> +		mas->store_type =3D wr_exact_fit;
> +		return;
> +	}
> +
> +	if (unlikely(!mas->index && mas->last =3D=3D ULONG_MAX)) {
> +		mas->store_type =3D wr_new_root;
> +		return;
> +	}
> +
> +	/* Potential spanning rebalance collapsing a node */
> +	if (new_end < mt_min_slots[wr_mas->type]) {
> +		if (!mte_is_root(mas->node)) {
> +			mas->store_type =3D wr_rebalance;
> +			return;
> +		}
> +		mas->store_type =3D wr_node_store;
> +		return;
> +	}
> +
> +	if (new_end >=3D mt_slots[wr_mas->type]) {
> +		mas->store_type =3D wr_split_store;
> +		return;
> +	}
> +
> +	if (!mt_in_rcu(mas->tree) && (mas->offset =3D=3D mas->end)) {
> +		mas->store_type =3D wr_append;
> +		return;
> +	}
> +
> +	if ((new_end =3D=3D mas->end) && (!mt_in_rcu(mas->tree) ||
> +		(wr_mas->offset_end - mas->offset =3D=3D 1))) {
> +		mas->store_type =3D wr_slot_store;
> +		return;
> +	}
> +
> +	if (mte_is_root(mas->node) || !(new_end <=3D mt_min_slots[wr_mas->type]=
) ||
> +		(mas->mas_flags & MA_STATE_BULK)) {
> +		mas->store_type =3D wr_node_store;
> +		return;
> +	}
> +
> +	mas->store_type =3D wr_bnode;
> +}
> +
> +/**
> + * mas_wr_preallocate() - Preallocate enough nodes for a store operation
> + * @wr_mas: The maple write state
> + * @entry: The entry that will be stored
> + * @gfp: The GFP_FLAGS to use for allocations.
> + *
> + */
> +static inline void mas_wr_preallocate(struct ma_wr_state *wr_mas, void *=
entry, gfp_t gfp)
> +{
> +	struct ma_state *mas =3D wr_mas->mas;
> +	int request;
> +
> +	mas_wr_prealloc_setup(wr_mas);
> +	mas_wr_store_type(wr_mas);
> +	request =3D mas_prealloc_calc(mas, entry);
> +	if (!request)
> +		return;
> +
> +	mas_node_count_gfp(mas, request, gfp);
> +	if (likely(!mas_is_err(mas)))
> +		return;
> +
> +	mas_set_alloc_req(mas, 0);
> +}
> +
>  /**
>   * mas_insert() - Internal call to insert a value
>   * @mas: The maple state
> @@ -5506,69 +5650,17 @@ EXPORT_SYMBOL_GPL(mas_store_prealloc);
>  int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
>  {
>  	MA_WR_STATE(wr_mas, mas, entry);
> -	unsigned char node_size;
> -	int request =3D 1;
> -	int ret;
> -
> -
> -	if (unlikely(!mas->index && mas->last =3D=3D ULONG_MAX))
> -		goto ask_now;
> -
> -	mas_wr_prealloc_setup(&wr_mas);
> -	/* Root expand */
> -	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas)))
> -		goto ask_now;
> -
> -	if (unlikely(!mas_wr_walk(&wr_mas))) {
> -		/* Spanning store, use worst case for now */
> -		request =3D 1 + mas_mt_height(mas) * 3;
> -		goto ask_now;
> -	}
> -
> -	/* At this point, we are at the leaf node that needs to be altered. */
> -	/* Exact fit, no nodes needed. */
> -	if (wr_mas.r_min =3D=3D mas->index && wr_mas.r_max =3D=3D mas->last)
> -		return 0;
> -
> -	mas_wr_end_piv(&wr_mas);
> -	node_size =3D mas_wr_new_end(&wr_mas);
> -
> -	/* Slot store, does not require additional nodes */
> -	if (node_size =3D=3D mas->end) {
> -		/* reuse node */
> -		if (!mt_in_rcu(mas->tree))
> -			return 0;
> -		/* shifting boundary */
> -		if (wr_mas.offset_end - mas->offset =3D=3D 1)
> -			return 0;
> -	}
> +	int ret =3D 0;
> =20
> -	if (node_size >=3D mt_slots[wr_mas.type]) {
> -		/* Split, worst case for now. */
> -		request =3D 1 + mas_mt_height(mas) * 2;
> -		goto ask_now;
> +	mas_wr_preallocate(&wr_mas, entry, gfp);
> +	if (mas_is_err(mas)) {
> +		ret =3D xa_err(mas->node);

mas_reset(mas); was silently dropped here.  I don't think that's wrong,
but it should probably be mentioned or commented on.  I believe the
reset was necessary for the rebalance case, which may not be necessary
anymore and probably not an issue here.  Since the state is separated
from the node in the maple state, it may not be necessary to reset at
all anymore.

> +		mas_destroy(mas);
> +		mas_reset(mas);
> +		return ret;
>  	}
> =20
> -	/* New root needs a single node */
> -	if (unlikely(mte_is_root(mas->node)))
> -		goto ask_now;
> -
> -	/* Potential spanning rebalance collapsing a node, use worst-case */
> -	if (node_size  - 1 <=3D mt_min_slots[wr_mas.type])
> -		request =3D mas_mt_height(mas) * 2 - 1;
> -
> -	/* node store, slot store needs one node */
> -ask_now:
> -	mas_node_count_gfp(mas, request, gfp);
>  	mas->mas_flags |=3D MA_STATE_PREALLOC;
> -	if (likely(!mas_is_err(mas)))
> -		return 0;
> -
> -	mas_set_alloc_req(mas, 0);
> -	ret =3D xa_err(mas->node);
> -	mas_reset(mas);
> -	mas_destroy(mas);
> -	mas_reset(mas);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(mas_preallocate);
> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/=
maple.c
> index f1caf4bcf937..c57979de1576 100644
> --- a/tools/testing/radix-tree/maple.c
> +++ b/tools/testing/radix-tree/maple.c
> @@ -36223,6 +36223,37 @@ static noinline void __init check_mtree_dup(stru=
ct maple_tree *mt)
> =20
>  extern void test_kmem_cache_bulk(void);
> =20
> +
> + /* test to simulate expanding a vma from [0x7fffffffe000, 0x7ffffffff00=
0)
> +  * to [0x7ffde4ca1000, 0x7ffffffff000) and then shrinking the vma to
> +  * [0x7ffde4ca1000, 0x7ffde4ca2000)
> +  */
> +static inline int check_vma_modification(struct maple_tree *mt)
> +{
> +	MA_STATE(mas, mt, 0, 0);


Don't we need locking in here?

> +
> +	/* vma with old start and old end */
> +	__mas_set_range(&mas, 0x7fffffffe000, 0x7ffffffff000 - 1);
> +	mas_preallocate(&mas, xa_mk_value(1), GFP_KERNEL);
> +	mas_store_prealloc(&mas, xa_mk_value(1));
> +
> +	/* next write occurs partly in previous range [0, 0x7fffffffe000)*/
> +	mas_prev_range(&mas, 0);
> +	/* expand vma to {0x7ffde4ca1000, 0x7ffffffff000) */
> +	__mas_set_range(&mas, 0x7ffde4ca1000, 0x7ffffffff000 - 1);
> +	mas_preallocate(&mas, xa_mk_value(1), GFP_KERNEL);
> +	mas_store_prealloc(&mas, xa_mk_value(1));
> +
> +	/* shrink vma to [0x7ffde4ca1000, 7ffde4ca2000) */
> +	__mas_set_range(&mas, 0x7ffde4ca2000, 0x7ffffffff000 - 1);
> +	mas_preallocate(&mas, NULL, GFP_KERNEL);
> +	mas_store_prealloc(&mas, NULL);
> +	mt_dump(mt, mt_dump_hex);
> +
> +	return 0;
> +}
> +
> +
>  void farmer_tests(void)
>  {
>  	struct maple_node *node;
> @@ -36230,6 +36261,10 @@ void farmer_tests(void)
> =20
>  	mt_dump(&tree, mt_dump_dec);
> =20
> +	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN | MT_F=
LAGS_USE_RCU);
> +	check_vma_modification(&tree);
> +	mtree_destroy(&tree);
> +
>  	tree.ma_root =3D xa_mk_value(0);
>  	mt_dump(&tree, mt_dump_dec);
> =20
> --=20
> 2.45.1
>=20

