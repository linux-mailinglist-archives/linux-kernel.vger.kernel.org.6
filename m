Return-Path: <linux-kernel+bounces-296669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CB795AD80
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9476F1C22988
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24D9139CF6;
	Thu, 22 Aug 2024 06:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="LoO0BpL7"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2087.outbound.protection.outlook.com [40.107.255.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4193B12E1DB
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308230; cv=fail; b=NIs/juw4Jmd0Cs1ccvrA38vysFVW0Am20CKo8QcUD9UeUceqnoIzyR2YVWKzYrawRfjKTcc+hGOQk5Cb5ZRg6lskQPXz7XEqIJFHUP19lnX5cwCzyuuKPAVIX/rm/r9SprMhGGMmVQEgVRxjOkMlxqahglNhwohECodf/IPMaLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308230; c=relaxed/simple;
	bh=1s0nyRJBvzJPnrv5yqWGVVxraogaoOogwjLPTFOZR44=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=aDsG1v1RUTflv5P9tawu0vQ/Gk6zdqi571MBBTHNnKkmY1Pea8qnIDkmUKKof+s4n1O/ObSx7hOVT2lyEphBtF/3DZLRSH2kHRuQrOs/zbA0OxdVWu35pIxmfWcqk/L+WQ9cJWzzxB/hjuzo1Mq04/fl70AwyAqw4btDPeL+PTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=LoO0BpL7; arc=fail smtp.client-ip=40.107.255.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAycHmLR/Db1eFCx9Kapr6jhH/tBPN7hb6ehj6GmbwXSpXXXyMGV6pjWcJopOK/fYz45JL8VhZjN3PuB9U0rMVaz4BayLyuVE+d88MHAaZTjw/aPwRl+0h0MhtfXGY93TLEuf8bSaQkR6EtvHkM6q3cAxaxAF6lQWAVA+iPkBL1D0ZG6E/sy0rxtrNLWIIo6O0bXbnBQjbNhXq9QeJLsdxy/+XjsgVAzfb29hnLKqPfBqWFZK9vQVypDQOqgpr+s9qAK/zM6j4ql8X3KpR9nmQy6nkhgRc6e5l013yQCjytfNudjHEBr69HzJ3EJ4uYjz91vWseB+j2Ivm7JkaAZXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMue/GgpVw8nABjZci2DVgEuQomrkaZd0cUzq031dwg=;
 b=e6bEg9BQG5rd3j+r60kuRwUkzHMg33LaoPkG1Wfm1eyixXyKKW67WpECd56EurBTE1Z+X9G0Z957z2hsPCn4ST93lylHk3ivtjLV3SwpCtnDA7YjJsuH2CAwgGvOpkuf1oAS/dC3rObqsBkowPrOiavWR5WylkKRfTToNyAM/6owPID1nLdqehseG7Coib7kHTsgIwqBJps5/7syDWwSqAZ6JtSVImNo+lKuO5R10G1XspJBF7rOuimACk35htA9l34/RIojogsNAo11FIQhwWs605yJaG1M5m1mSUuucEuKMvJDfsUzrTdUvO34NYWXfvXBCZ5gO4QOc7DYPEzmCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMue/GgpVw8nABjZci2DVgEuQomrkaZd0cUzq031dwg=;
 b=LoO0BpL7JCSnEQMB60jKOgPezCFqcvOjvnpU2+B0y1NoCr3aShVZZbfL6vC2eS3DPvqYKC9EF9JfGPOFyDc/XUllYDoJWrcr4rl9qvN1LbrtskyUuYsEjzOZN5I99pg8p1hhTzmKqdFRwjWzKUJDC3sk+LpzuIYO+jk+isdEr06fC3xQvQxlG5nZXUw4W7r2U2lsnw8knwlBMIpCUDagRVqK9RQ+Sawz1H7xpQvWOKDunuanJmT66M298kix9UqcZPnWY9TpiuREdERwQZxeRusULlidZqwk/LjW7wNSSdfMP/3oz2vQV3kImN2Qe7wdAR22u5LF9+WI+bGkDBRTxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by TYZPR06MB5321.apcprd06.prod.outlook.com (2603:1096:400:1f3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Thu, 22 Aug
 2024 06:30:26 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%7]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 06:30:25 +0000
From: Yu Jiaoliang <yujiaoliang@vivo.com>
To: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Alex Hung <alex.hung@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Hersen Wu <hersenxs.wu@amd.com>,
	Dillon Varone <dillon.varone@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1 0/6] drm/amd/display: Use max/min macro
Date: Thu, 22 Aug 2024 14:29:26 +0800
Message-Id: <20240822062947.1318340-1-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To TYZPR06MB4461.apcprd06.prod.outlook.com
 (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|TYZPR06MB5321:EE_
X-MS-Office365-Filtering-Correlation-Id: e47bf223-12e6-41e0-b690-08dcc273e84f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vYpZb8Li/r1miyxEiMb1Rj5dTMymzsxgVeAKqH8vrOvXhVx/M/dbYSJIE2wE?=
 =?us-ascii?Q?+6rCz/CQKLNPMW1CHiEZt10AAv+SgDIoXkR+QAUSqx6Drm/eGHI+Qe+iop/7?=
 =?us-ascii?Q?4Iea2vLNNnmsmFc/6fckfoJBC8WWltqicrxSpvK5125qsrk6tU/3Jt+W7KUb?=
 =?us-ascii?Q?E9lsCTzHXkVIqAmxqpi3fcQV9x1S74U3ZK381YSv4dIHEu6h+HQ+1UFbD5zM?=
 =?us-ascii?Q?MBNWyOdVlhmQxnP7BCignS/c9jDetn1xRuOn7UyCtFzGOw5rBrENQyBQGyJm?=
 =?us-ascii?Q?mlMb9zfgWfEmk1NkOtGebJSWFBYyhFLeovV/2zol2SxERk2jAyQiiw56CAP/?=
 =?us-ascii?Q?84V4yEvNpTFPZ2PSZF6aOMWWmFfWQOjjQEW1R56Pg+ROoeAoswsmfJUfhEbv?=
 =?us-ascii?Q?gCdHvXSeWSnoCSzVK9IW/BI9o2WKxUgbB78rwpT1f/dLHwVx9rhhnFp12QBr?=
 =?us-ascii?Q?Kd1hT9LFV2yaCtzyBmkmXZMY5GrkzZh2W53cw0/1YNm2IIFDDWtRvTFbGv81?=
 =?us-ascii?Q?laTpz0Lduy3eJNb8V/kEnXOr13ouFPWlCQKgEftnQLVXgfdoffZCuSlInkz5?=
 =?us-ascii?Q?UTbMRbk47pQLaMHV1E/5VBViw662awGVF1HGlTzp4Ew4maHsnT3eQYAbquig?=
 =?us-ascii?Q?TJZYZmaI1v7ETMBbF9e9rk9s8ha4Nwz0FvHHSyEQkJmJawdGQhD7It3/6sR2?=
 =?us-ascii?Q?nrffrSY2QMqe5lqX2ssSs9c1tmtUnAVvJWfgXt4D6+Tlp1bHvDIrE8Wi8PFR?=
 =?us-ascii?Q?sHYVX9JLiR8Wc0af92UNm/aEmkNLnb7Wu2+zT/kRujXJXrjUD7GYfb2w8NMR?=
 =?us-ascii?Q?fL/RRQXgKytB7xcmJJPZJeTDpWyhsp0+ZwmAFDWc23N92up/K38zEsUEbiXq?=
 =?us-ascii?Q?RAwLFvMhNhErzAkwJaWYFwvcuj9WVr4XMJg/r+7mwQ/VhO6LwQgfqK9VMQXm?=
 =?us-ascii?Q?nkyGu8ApOnsCCAQWIbN+PYLwC6YUzuB6XcZs79WyInXhMO3Zrp36CjPCMByE?=
 =?us-ascii?Q?7zH90zYj+aLge5Iyp2/I5AXZNCj9BGoavAFW0kYBp8RN5OdzpCfe6c5daR4P?=
 =?us-ascii?Q?o4Agr748lTLNtbhXbBB8T2KRox/Pg2NKRyTNj8Kv9d5H0jGtCFYcGZXm8Is+?=
 =?us-ascii?Q?eX7ZyjgOKNkLpNnQ5zrfD8tieuQkTrJHx4LAV5mvPYUTUxGKIslOwBpC3V14?=
 =?us-ascii?Q?ZfYmr9HI2JOOvZW5ATJRweVWF5f45HBkx7xwLeUnDI8OKhSStBY2F8iZeCKF?=
 =?us-ascii?Q?d7/6U5Itryx5bMqcHIjIwVAW84hQCcT1YSwqTLg3n2LQboW5/rLu5GfWtAnF?=
 =?us-ascii?Q?Zf8fUPjzPkiJtWjrl9aDSBNfPNrA/0qME71i3FK5Jocx+M2M8B2lY/a+vz1p?=
 =?us-ascii?Q?YwfkDhv57rM60MC+zw965MXZSoKFhvMSUAq1ba/+Lzw5QDuUKkuVSz7QHDrn?=
 =?us-ascii?Q?ozFbPqLs4Ds=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LkAvywnkQCPOEZrxmDWeTVmPiinG1r1a24eW4DeXWJhLC6fktTouSCWXogET?=
 =?us-ascii?Q?2B8KRAF4+wZmloI5cpViGOiW/tJVXG6v6y5WNPrbYrKLbhYZ+fBk5tOFkqX6?=
 =?us-ascii?Q?EXGvpJsRkbFwIKmYPGENn2oYTBbjETR1jOnQAku/JfdaaerPmYaq04S1npV9?=
 =?us-ascii?Q?83KjZMkdbx3DNUFvSDmadh3mDIxsjDARLLsMldHBs61PODIOOsgaMewjiaD7?=
 =?us-ascii?Q?CqpQ3BsSJEZIyh6JF/jvGgpLLyf55ZGentgRTRKCMKqsz++sO2yOuEb2OBUw?=
 =?us-ascii?Q?ST6XGsoxQ44AKP70HP2Uy3Zjskd3d6SooGRxZYKjRiLywz7Tbu4MgsfEwz6B?=
 =?us-ascii?Q?ijtJnz6tC0RwZqjhxR7UDsIPOiCzv8VFVUyFzdA2wBkp3S54He3/AvhVe9xD?=
 =?us-ascii?Q?VYRLWLbJRh1WWtoreXgklXnPL6XjCq+NHIEPpDya+obXffaPPUpDoAdysRxI?=
 =?us-ascii?Q?7ULJDxcwiKPuOZavqKH5NG4lrXTERJmKsuRqMqs90si05vsyHwSaTaEtD5uz?=
 =?us-ascii?Q?PWRUKofruQRJmqXBbfDFl1BqgQiICp1U5Il488yuuP0NpwAcWJ4qivUrbbO9?=
 =?us-ascii?Q?U8mRchzcvVuLxBhI1C8Shfnzd8L3VRDKfCE68mn6aiLQIt9Zp7j7YzgeYYIs?=
 =?us-ascii?Q?u57L7HKJ+c+eXS6wu7D94ZvrKxWPWUvNwaynpx6vhoxTCBR8m9MAeSIrtjmA?=
 =?us-ascii?Q?PVXx32cVca/DeQzLD0cykgFVFTCthgD6iUIqYMaPIfsTlmc3aL34xwY1+RTw?=
 =?us-ascii?Q?CGFg/ir9IGIj7p1XLBeMl7XlhnsVenAerjHVFs1ql7VCb+ac/+Suhc0NzDa1?=
 =?us-ascii?Q?HkD7HWp46TRWf+ssZiFLEjx4SIg32jGk9WgCK6KQt/Wah5wL/BhF2hYuvBBK?=
 =?us-ascii?Q?4LBlwdEvu5+ua0YbZ/g3q2bD5CbZVWaGvivAUAeORFehtASiOuV1mi6CN6Nu?=
 =?us-ascii?Q?NB78AEo73sjoED9zOhBt/F68ySEipiYfktKxiDj8EMDg7Zjaj3ubkajaSlHS?=
 =?us-ascii?Q?xmTaYRG5neqTv8F7r4pGpuUrgmMXpMqfRNp2baVrfKf+bntfFiBQxpXaoxHx?=
 =?us-ascii?Q?nS1hEmcm4mgrymMa8v3xCd9ZBK2jZfk+UlQVL94ftC3qfFgOXdnqcHXtRwuE?=
 =?us-ascii?Q?8LTzAeg2D2kBMngRyBDDGPAq1CXFfPNwaZHWRYy12YX8oXSTcUWIK+OT9cpI?=
 =?us-ascii?Q?UmZaUs2qDQ0XH6lkZs9P3keeMN/VlCo61HxvNAwMR9ijOPXu6qMobQRk0c2Y?=
 =?us-ascii?Q?02IGo1vTk7iMrBhwIQZX0eQN/AoP6jiD5MFxd+N3XNZplU9DjrFpvoeuvK1z?=
 =?us-ascii?Q?V17wZ+fNDRgP2XINSg4zFgfRrXHK/Qh4ry9m/tEtt0bXnyIu5PipNSwZNrBN?=
 =?us-ascii?Q?R5u8N24n2u571fbEbvigdjZ0+TspCDORVtKeHlqeuCIlH1OeNo3cm8SPk3kv?=
 =?us-ascii?Q?Ntehp5H9dBaHnxSpRkE75nE2ewhW8i84gatKKGoPDsEOSC0YiiMsyvjfeLSN?=
 =?us-ascii?Q?VrGpNOdsKV6mqUcNDzCkYbasA6JhT9VqdASDgNQJnc+2vbwZjWCfSSFD8H84?=
 =?us-ascii?Q?JKUxWVJ2Um2e5zpRmGggf42bs6c0//7JjqfW5nhz?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e47bf223-12e6-41e0-b690-08dcc273e84f
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 06:30:25.6359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mB6wlACBFz4VMjBCPwI2yLk/VcQCB6cIpvAgzVWPd947Jxi9oRpaeoa4N2mmNJwFvXht8VntTDKdjt7cK6qXlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5321

*** BLURB HERE ***

Yu Jiaoliang (6):
  drm/amd/display: Use max/min macro
  drm/amd/display: Use max/min macro
  drm/amd/display: Use max/min macro
  drm/amd/display: Use max/min macro
  drm/amd/display: Use max/min macro
  drm/amd/display: Use max/min macro

 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c            | 4 ++--
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c | 4 +++-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c            | 4 ++--
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c                 | 2 +-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c                  | 4 ++--
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c      | 4 ++--
 6 files changed, 12 insertions(+), 10 deletions(-)

-- 
2.34.1


