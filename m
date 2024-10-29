Return-Path: <linux-kernel+bounces-386995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8321D9B4A91
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5DA0B22D1C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAA9206968;
	Tue, 29 Oct 2024 13:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hGR7SbAY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VVw65DYo"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8695B205AD2
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730207071; cv=fail; b=rHdokl/UmTjhp7X21YGPv52MtxSRWKkqwDpo3iZtQocr652ZmZ2EPM/9SPGnlmluPZpDhzTYPxI088wrVZQ2pU4zTALGNKA//3ysssQH5+NI4QmHkxwshGMcmMr2wWAnf+SF4ZwzdihaC9IDwoJ0oqzdlOhx+TOiu45zbtr3ODM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730207071; c=relaxed/simple;
	bh=qU29Ww3vOKyQ7Iuuoi/kc1Sgue89dA3wHB+TI2YZLKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oDSLcuiUCQmvQrFbjl9Q4YZm2EWnQLH8g2uGVkazYj82RoYfPGs15akWKaNfP5Au9OlYF1fr8UfYrK7PjJE7VZwGVcdZ8ET74Imxc/6BmfIbFRHuGTWOKM0EtlUGwqjVWks7bKXOizC4IWjhXb/f2qjvx1Wmvwlh1ZBFC3ZmOyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hGR7SbAY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VVw65DYo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TCcKNT008981;
	Tue, 29 Oct 2024 13:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=gD3/8yFb/Fj1edTJvrvVzYBFOVmebuxOTpOZBoSXr+c=; b=
	hGR7SbAYMxDh3M1qX8U0svAyjQcJZGsHZ+MjJqEkMjvoCw/ANiRT/icHDWZSzFiH
	Agla3FNwV8oA3T3wENHXm/HqE/l1py8mMEq1HBXq3mNGhjx0uffWFVvxJgKrNuom
	+2vPnvio9MK9UybP4J+oJhMEbl2GFBuDSCLIkqfCGel+O1mQK9SeoIFuV68NbNEU
	irdzJkWgwgrjVzncZxUMQ9OrWMHRRmo/6bDw7u8Y2WHrkUU0DMUwlk62LRMP2neU
	LaOLifB2HkkINRoXJAHK5g6fQEPwQWYzkV+L8uP7g3kUBl63YC0xXSNCLK2z8f2R
	1mZHXBXUZgCcoThNTIstJw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdqdaq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 13:04:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TBxCZ4004774;
	Tue, 29 Oct 2024 13:04:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42jb2u7hde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 13:04:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VxOlTkGcF2Ms4OMTUeszaHUeUWyf/Zf21hfQo8iV+UhXQGGSBepkW0o6Vu8vNPwp5jbNeLalOMlQX0o5ZlZ9qJYZL4TzzSi6+m+n1K7UhXhSrWv8QVchCD69KSOKhRHDCkY5BUeIAHhKZ9lNR5a59J6+eqOVV7gUqFWaA1AZEPpqkEOrxqJiYa9H8C+yGbFS3/YJlIN03FbX0EJkppe9xNsSLFpaRzvWSrtMvPf1wUtW97m5KdD2cbUBgplhfeAN03CNyraZoXfCT8gtK89/PNOrT0PxlwKIt602sGOQ0tn+F4qzut263eJcAGRSyNe5x7NI2eraDbK1aviY0rix2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gD3/8yFb/Fj1edTJvrvVzYBFOVmebuxOTpOZBoSXr+c=;
 b=EQ3+RfQMDhompRNegaLk7cqmNCEIIg44uEhMTtd6FkiZV/EZ398wfdmtIwxXGNIE6o7idD0uE9fHH9n8Nzws38jb8bRGke69e/SSZCZ2zTShPEY1/3+3JFWNoXYwBPVNaWa5bHj4UdnRQ9DSTVJBJr4F03T3FpF2hGaxYu+F0vxkPEvPrS2i6KVvYo+UviM+Hs67qRGikuqCs0fkCNrMeIzAyNPdhvTUIXDrJjdxPVWWVp1F509sq7BhbxKjz121buq9F/MdbpW2TTmqb91lGHaGVbvFEPApCxx3ZVSGjGKaDXmDqINmRQiyXmWSYE5VbmRIZ6PssQgvtKCGf0xj7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gD3/8yFb/Fj1edTJvrvVzYBFOVmebuxOTpOZBoSXr+c=;
 b=VVw65DYoS6d8BRf6hvMiVktTZRrY2ROZE94t6TrvU+mFGMeAP04cF7+mv7uJ7AQXonZQ0NPVZLa38zvIvjV1G9Rj2we3n4Mb+O07Cje/LHQI07kwIg/Rh4LXEjHf6It+7X0HmJ5gVn5PAmufI4Ve36hsAgHDypytybsoUVzWlwA=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MW4PR10MB6462.namprd10.prod.outlook.com (2603:10b6:303:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 29 Oct
 2024 13:04:02 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 13:04:02 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>
Subject: [PATCH hotfix 6.12 v3 3/5] mm: refactor map_deny_write_exec()
Date: Tue, 29 Oct 2024 13:03:45 +0000
Message-ID: <6be8bb59cd7c68006ebb006eb9d8dc27104b1f70.1730206735.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730206735.git.lorenzo.stoakes@oracle.com>
References: <cover.1730206735.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0025.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::14) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MW4PR10MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 49309bcf-0982-427e-5db4-08dcf81a2919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jP0e3JiIKN8e4TNSqJFA4A2PrXtfeBNV+mucPYORZMpaTdoSZKJODBxSc6ED?=
 =?us-ascii?Q?REZSkOQOus64Xvz3Q043L1KY3kWEzgdq9qdeEkW/zutJLlruXMAWdR6XRuJh?=
 =?us-ascii?Q?NSVlSGE4W+zk05dqJCamPfxZoGfRPb0h+nL6z8WnC8OpV/oKYiYMt9JryF89?=
 =?us-ascii?Q?V64TtK0GyyYPecJGl07MeFa64BroA9OV05yb0E6HelzhOtvLt5G1/VQ4fyZu?=
 =?us-ascii?Q?rqP+oqtu1PdmT8hKppp3WKMnfw298CtH4ucVhl2/BNOqCc9L26CCEdBbamD5?=
 =?us-ascii?Q?OaQFDrkaQ0m+vubuXaUFA6oFz0av4VD+iABxmgw7tRHxZgJ65PWwXYZkSROL?=
 =?us-ascii?Q?ZAw0X2kvm7RmDUel2rA9AE1GisEIdqTU4SIrW21TIzeowNQr97Ez4v1mFy3V?=
 =?us-ascii?Q?8GWTwSmaVOpYpkT/1I6VDs7sm8Bp6uMEhEkumYmvY+awuXWv4meVZS+F19NL?=
 =?us-ascii?Q?NSt7EGntBKKTX4cwe8RzmMUyY0ZMGAuiiFoQDa1mUJd6ySL4a3mWIbXpn7+m?=
 =?us-ascii?Q?CUyVlS5Tk0rwA6GU9/+G4/yVVObpAMIut9TzK4d/X0GFdBAh5Cr1vFU437S2?=
 =?us-ascii?Q?vo9uFw6UWBXEVRMMibc1x7+j2kbOhI/qPozxIdjro2rn56OM2p2USA/F5HT/?=
 =?us-ascii?Q?p1eMqazqPIhDseL8D7vnu8pcq/gUG18EnVpdKNbHmCVZO9sT06Jr4OQSV4NN?=
 =?us-ascii?Q?MwoWFn3BzxO4wb99FG2OJD1NepGPuZOkar2MOk/wFmLsCdmMVTjGNgPGB57I?=
 =?us-ascii?Q?u4JQUlbephcPBVSn+WkmRItOhmkez3tPvTOm+OBOIiJHyqYgXRagZ5uPFjxt?=
 =?us-ascii?Q?l0p5zyXSIQ0Th1uT1sdoP4ywMbisp0prA/3dC4szvKMJwu/PlONUVxhVF1N2?=
 =?us-ascii?Q?3RzQ/TvqY3hIuevjOCt3WkSDtfJz6285g2YMN/JSUp3Ac10gGoCjw+CzBdD3?=
 =?us-ascii?Q?G/2bCJkR8Zs108PDlyPY3xuVB8d8sjwCjMS7MavLqkfdf54Zl+96mUSTvsq7?=
 =?us-ascii?Q?YwJX4xfV3QMVw3GpzYkRaIg6bAJ4ruMVgfZg3WuaXSnA1luUAGn+/45ZEhFF?=
 =?us-ascii?Q?fzEt3piZXFX2Gb/D/Twmv50wnYNl6+wuwIG+P41M8F1LeUiEqnI9o1jHkcv7?=
 =?us-ascii?Q?PT7mieKNH88N4Vw6NF4RU/Yi0ZxBCihD10PTBWo4fnIx9NGoHD82ON0CAAdA?=
 =?us-ascii?Q?JqGtOIM63M23dWbVY4fp2tbhaOR9XbleJuIMaa7RVJcUq1AJfmyqkZQrR3f8?=
 =?us-ascii?Q?kkBMg8d3BsxuP5GZL7z1Ah5ST4ehwQH0TJiSkOUqg3xcKV7DBmrpI0Z/b4St?=
 =?us-ascii?Q?Kl25KSCCsF4zmSbHpHIbiZFd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FkY67PY9bnXC48FxNtWU+HmvhkTSmC1WtVoSxukFTFc/rVRbJNL+Q6xHzZh4?=
 =?us-ascii?Q?WplpSHhiy5vApt3ihslfl+b9+ZaS7dzSGdfx73TZBWRExSJSHMqWlVdtZ09V?=
 =?us-ascii?Q?xnlVCSwjz9M/udQB7En6fe4Y4HWux9me+Sd3WfyaBWG7vYqqyQ92sjQwNcUM?=
 =?us-ascii?Q?9EHFK5PNtvJIQkBV29sIEbD36JQmdYul8Immz3Fa4uShlhen5L+8xHBJEGXs?=
 =?us-ascii?Q?8T0vbgrjDew3HEu+VBEOwabttcJcRlVcL0ITtpiU236dq+UskfOpWGGNgAde?=
 =?us-ascii?Q?C7gjHkMHfuXwh0dk+l9IhHpqYTXx3X5FF3QEnupIInxFUL+t6CorQLOpvnQv?=
 =?us-ascii?Q?Ih3lK6uXvDffxzDp4NeVeg8vtJcERT1QqpRo5eLE5r/HkYUiyLTMIsTnA3tg?=
 =?us-ascii?Q?uGgVmRk6q8ggTXGcWKWuTJq56dkOHntfaPTO7GuIjJouz802kLUwtcyTr6iw?=
 =?us-ascii?Q?D7UA5eENyAOLcPeqFw1LJejmnLxVhdtQZu7EjY+umPxiPLsclkIhlGl9U+4c?=
 =?us-ascii?Q?L3dQ/EXjDYsmae9716ASEk4p6TbmilPfrkWdWQwAz95Y4pRIQPn4oxBduu9N?=
 =?us-ascii?Q?FqLIKcBHQHNoKhCXfcmm3IUs7M/cP5mOJbhrDCcN+QNgM6rtkR3g6nmIgUDV?=
 =?us-ascii?Q?eSzgaVzFW8w2pGOCFOvrWgckP1xZzhZhyP9Bo8qwwZyHnCLFPAaMID3dVUev?=
 =?us-ascii?Q?UMI3kbOcRLcOWtJ4GIqTTkNcdz9Y14uYYxCWpYXO7o2nhRJInSlshOKZZ1lM?=
 =?us-ascii?Q?/MpjNr0H3J6vjl0s8/GgqcSSafApb9K0ban0wk+Rh9zw7nC7Am1Nm2mPB0+0?=
 =?us-ascii?Q?Pjzr5p9xqycIG0NzIsCMDpBpoVzy5qadsD7TXrP/dUrPX3BZvgmMagm4iHEc?=
 =?us-ascii?Q?74RzMuTBAG69K3bEKBgbbBY3mVRqwb4piZ24B9prOXLDTZyNj711oMzb4dq4?=
 =?us-ascii?Q?P2ZBkcP3U9y04KScRmu1PAD39tVQrVBClgfK51CWePeTQwMc+TSvXU1N8pgG?=
 =?us-ascii?Q?zCrP/ebu4EGh/nhLd8Z/PLg50RQdktgvzrz2FvIXja0k/9WzJSscNBTvaABp?=
 =?us-ascii?Q?Y6WnDN8IemIzSf0opAQfvAU6s/c0M+MHRPn1RxpDzQ3XxEJkB+652DZvTQMm?=
 =?us-ascii?Q?2yYncb9fZVzdjJa7UHFcjI3vLDUgaON7iRtMSIKRUCNuPwq6nq2iRXP3lVe+?=
 =?us-ascii?Q?RrqxUAGLJreir3bf8w3t8bbvGzpfT0zdwKarJCc023wNFrSxpIqfWvAiZGJq?=
 =?us-ascii?Q?41ssXuZgmn9AIXpPMK/1zqpXEP9fIDdwx1XPOuAspVxe2AQA46/Jwg7utH5b?=
 =?us-ascii?Q?4H8AbaCvhvg7BAOGGJw1qlnDmE6WAcdf9Cyh+s+vXoo6vqvOUDQ3kt7552gu?=
 =?us-ascii?Q?xmk6YVlGowH1raO5xZQddtpRB2V+3hILQ1haWcE+kwibIfM935RsFKb6xRNN?=
 =?us-ascii?Q?bkJpLe779G3J7Q4n717CJAF/bKC0kk2BY7+tHpLSUVVxlHNwSbtizMsAapOZ?=
 =?us-ascii?Q?jy6lSmUGIVFrLBvkvH7WZIGte866jUvWbPEtMfof3x7drj+QMW3EF16usPGV?=
 =?us-ascii?Q?piwDArRJFOiTwtD5O0yHoYRX28f/avVf9eV/Rq78z/+tgHt1LceKn1ihVjnu?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YuRQhsa/yW+7s57V5zbDyoUmsbnSwgtiJyjjSoeCKhkkbEqDzNu3v+4Z0FmJGEanA/yP+cEohcT/I2t2vw00s/FTNxpFM46Tv1L7Zddio8vJoy/8JHRC9xvZnRxOBctMcu0zQskZGf28gC7kadS6Itp5+zIxiWvJZCWU1OslfZ3SXe1m4g9VG/cp7ssVlJIeQt3UfXPzO56QOk59RfDqXbp7rmT2iseqyNNauCtYYZ1WP+0sDAz6DoX5qcoT9U2gdtacEwyovNEPwroHX7nBu3RYihVdqb/KKOGO+CWQ3+g2OPGGAKYXFLRMuKMrvDO8sHG7ydcIwjp4wZdXii/kchgVc40eDmEMlhoErGG7u05Uuvc/JWtru9tal2tWcBu7k158sxc0q4BfS+ahcn+k60qejz97orbFTlmbHa0rHn/KTYIoWa7Io6Z04MbNTiYUriWBOgbeMJ5MFDV5W3tYQeuMBHFA0gjZXjwbzQ8v9Siy4gpOZgBl+cr+7l75WLkNvIGKBxB3XUBDIxj09xBlQz212/1ckWVAJ+8PUSngXWgzGhDtAzVR2Nx4yC3hS18UNTeFM+cCyojDycqx66iyuKuHhGGSLZrimG5fLmvWoks=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49309bcf-0982-427e-5db4-08dcf81a2919
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 13:04:02.5785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Cr3qM2Xn03MM0wYqvQUbecOnPgxjS3APONPHefzKsx7NwdxqHN6ES0obWYn9elAlLqOSoBw4P8jGN/5cHjcxb90FKEbN2q+DmjkhaUknrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_08,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290099
X-Proofpoint-GUID: yd--8GXVUFi8pe2mdqE4u1G8Y1cWvKSC
X-Proofpoint-ORIG-GUID: yd--8GXVUFi8pe2mdqE4u1G8Y1cWvKSC

Refactor the map_deny_write_exec() to not unnecessarily require a VMA
parameter but rather to accept VMA flags parameters, which allows us to use
this function early in mmap_region() in a subsequent commit.

While we're here, we refactor the function to be more readable and add some
additional documentation.

Reported-by: Jann Horn <jannh@google.com>
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Cc: stable <stable@kernel.org>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Jann Horn <jannh@google.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mman.h | 21 ++++++++++++++++++---
 mm/mmap.c            |  2 +-
 mm/mprotect.c        |  2 +-
 mm/vma.h             |  2 +-
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/linux/mman.h b/include/linux/mman.h
index bcb201ab7a41..8ddca62d6460 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -188,16 +188,31 @@ static inline bool arch_memory_deny_write_exec_supported(void)
  *
  *	d)	mmap(PROT_READ | PROT_EXEC)
  *		mmap(PROT_READ | PROT_EXEC | PROT_BTI)
+ *
+ * This is only applicable if the user has set the Memory-Deny-Write-Execute
+ * (MDWE) protection mask for the current process.
+ *
+ * @old specifies the VMA flags the VMA originally possessed, and @new the ones
+ * we propose to set.
+ *
+ * Return: false if proposed change is OK, true if not ok and should be denied.
  */
-static inline bool map_deny_write_exec(struct vm_area_struct *vma,  unsigned long vm_flags)
+static inline bool map_deny_write_exec(unsigned long old, unsigned long new)
 {
+	/* If MDWE is disabled, we have nothing to deny. */
 	if (!test_bit(MMF_HAS_MDWE, &current->mm->flags))
 		return false;

-	if ((vm_flags & VM_EXEC) && (vm_flags & VM_WRITE))
+	/* If the new VMA is not executable, we have nothing to deny. */
+	if (!(new & VM_EXEC))
+		return false;
+
+	/* Under MDWE we do not accept newly writably executable VMAs... */
+	if (new & VM_WRITE)
 		return true;

-	if (!(vma->vm_flags & VM_EXEC) && (vm_flags & VM_EXEC))
+	/* ...nor previously non-executable VMAs becoming executable. */
+	if (!(old & VM_EXEC))
 		return true;

 	return false;
diff --git a/mm/mmap.c b/mm/mmap.c
index ac0604f146f6..ab71d4c3464c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1505,7 +1505,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vma_set_anonymous(vma);
 	}

-	if (map_deny_write_exec(vma, vma->vm_flags)) {
+	if (map_deny_write_exec(vma->vm_flags, vma->vm_flags)) {
 		error = -EACCES;
 		goto close_and_free_vma;
 	}
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 0c5d6d06107d..6f450af3252e 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -810,7 +810,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 			break;
 		}

-		if (map_deny_write_exec(vma, newflags)) {
+		if (map_deny_write_exec(vma->vm_flags, newflags)) {
 			error = -EACCES;
 			break;
 		}
diff --git a/mm/vma.h b/mm/vma.h
index 75558b5e9c8c..d58068c0ff2e 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -42,7 +42,7 @@ struct vma_munmap_struct {
 	int vma_count;                  /* Number of vmas that will be removed */
 	bool unlock;                    /* Unlock after the munmap */
 	bool clear_ptes;                /* If there are outstanding PTE to be cleared */
-	/* 1 byte hole */
+	/* 2 byte hole */
 	unsigned long nr_pages;         /* Number of pages being removed */
 	unsigned long locked_vm;        /* Number of locked pages */
 	unsigned long nr_accounted;     /* Number of VM_ACCOUNT pages */
--
2.47.0

