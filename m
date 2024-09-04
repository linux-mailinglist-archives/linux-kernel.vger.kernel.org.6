Return-Path: <linux-kernel+bounces-314095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5359396AEC6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 04:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9ECF1F2481B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 02:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F9A3CF65;
	Wed,  4 Sep 2024 02:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="S2pvgMdu"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2070.outbound.protection.outlook.com [40.107.215.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E0B10A12
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 02:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725418109; cv=fail; b=IWQgQf06ZMU0ufg/jxCIDRI71mKTQrEpBuCjUNhHesyGqZvIAU1b/ApupRPyHZGuvFFOOsqAw8K9ElggvzO6eWn3Vd8QaxjDU1LoTxB5rfVI0SbMTmF2wn2KDVYvOhfh1RDsdY9UwKxkByuLHJnZprhgJoc21c8r7+yho6z5tsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725418109; c=relaxed/simple;
	bh=1b+/6aaV1s5g0V/Cq9bad8BXT+JqbOHkta4+4gFHJTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dBByNYPE40b0koCCtubnEYqIsr5MQ9te7tFvYUT7QfnReibrk/iBNwSBUoS0JaqvaAmjqY69culI0NfCTYfOnpjkPFiZtMx1JpNWZU49ZKE/XbSe3Diwo6GlLtIbZZ18cN2TTcJwmY5GIHP5v7DAeFMdCGZ+K+qvz1pMmBPV0kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=S2pvgMdu; arc=fail smtp.client-ip=40.107.215.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VuM7z/6bdPrKGzZIY3t92gFua8eEreGHaQJaBJKTuuzQgLLe13/2P0d4gJBThLUAmZmd2zMrVQLiAjITcb7qfO71xecYcNpWWquAjiRfXwF1y5fHN+6+Ex07oXpdAyQ2WOLsXLTlHlyR/q8/NsiICxT3r6gpuARKfnZzR1l0jDcKvWSoCq3YNTpuI1QTYk7bHUNMJg8TCKeU8aZRgurgYmJ9Oi7pC9pbeoH5DTDYTkUIxbGMM8KFa8653v8vHs8LUkJnjE/6HsrepWV27C0m+nrMboWS5b0lAtnLukULPoqAxxzO6F3W3NP5Ll1WhuVAi7BHzDZxSgU9DNjV/duPNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxOkrzGJMbmEbHRmSaBo9v0KrrM/NdKn0fO8tF6qT+Y=;
 b=FNqQCu7wQzE+ykyH/7l+Vb7iegsuM2LbvajYCNmGWlMBFw55Wuye76PXmC61WyR/Atr6uM4cuRaXlVFpWuIRPpIfOQCOcE0HebCWcykndf8Un+/cYeznDX9vJRc3UIxzoBawGFMNGK+gepHfLfmSnPQbk/UwKSJhOZqIVuX8p9xTcrBIgVJ1zAPsukctKhi8y/PX6AtKpK0BJ+SNgazpna9EZqY4HGIFwzKmSztC+QQjjOWtAd4tVRNBa6sdJo/L9DuavHX0jyLQ5LejWdwAcMeIP41p8VXg4oUtfBFxwYa3Z+w+f36eLCbmo7joI1/KmCaO3uPlFZBqiNSGvhdTLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxOkrzGJMbmEbHRmSaBo9v0KrrM/NdKn0fO8tF6qT+Y=;
 b=S2pvgMdudKxC5bNbcYcNqBasBiboFaI9MKfaQQbMcm50HZZEvXotT27C4nm2KXlK6QwNf3viiNtiqucnUNyGqhOoaaXr7cS+raYKoRenDWEyCHJXgd96lJOayCpXmhpJtsvMwZ1emfUspylz+3xDWWTxwnvDKwQBNDu9ofuwuY58aDAadmRxmF5ANGK/YHu0wDWIz1KUlhwpBkGa5F+xT4zqH+7qQAsZb6jnvOaeBzlzYENZf6IyaHxpuNA3gkdPrZ2fNNsmoaSzj8LueXc2j3SuEK93y41mhb60JZrESfYZVBquqgWnCj0IWU+JS+ScOPYo1d+G8RyQr/0ex3iLmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by SEZPR06MB5045.apcprd06.prod.outlook.com (2603:1096:101:47::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 02:48:19 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%6]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 02:48:19 +0000
From: Wu Bo <bo.wu@vivo.com>
To: Huang Jianan <huangjianan@xiaomi.com>
Cc: Wu Bo <bo.wu@vivo.com>,
	Wu Bo <wubo.oduw@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	"linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [f2fs-dev] [PATCH 05/13] f2fs: set inline tail flag when create inode
Date: Tue,  3 Sep 2024 21:03:24 -0600
Message-Id: <20240904030324.3412718-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <9f381694-2573-4f72-9177-54e2b5c07652@xiaomi.com>
References:
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::14)
 To PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|SEZPR06MB5045:EE_
X-MS-Office365-Filtering-Correlation-Id: d8474a11-df64-43f7-1d1d-08dccc8c080b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OU1QVUdOVXdEcFJWQjVBK3lHanI4MVprNnFUQ3RPc3BGcjdNTDFJeDNBM2NW?=
 =?utf-8?B?T2JuRXRtZXZMdUVURjlIZlIraVFGdFZUT0ZFaXRQcHMvZWNrMTZucVlXTFhO?=
 =?utf-8?B?NUJkN1pDc2lVcnVmQktDRjNNbzI1SmxaZmFCOVJpYTJENVp4YTlDOWZjQjNI?=
 =?utf-8?B?ciswQzlIYnozWmFWTHF6SVk5c2ZwUlNHRXB3QjNCWDNPS0pKRWsrWW90ZkNq?=
 =?utf-8?B?L1RIZGRjTnhKVTJveTNQdWRvMHJnRGttWm10aUN0VFI5dnNiMHd1dFNXMDYz?=
 =?utf-8?B?R1MrNFArRHlSN1FHV05pOGMxSnQ3VXUwQ1pZNGpPS05zT1VEZ1JhUEJRL1R2?=
 =?utf-8?B?QVV5N1ZBWDBOYkJqcUg1RVh6ZytBQ1h0SmhhcGxsb1BPc3pRMWIxNEgrb1Bv?=
 =?utf-8?B?KzFKTlVhNUc0aHZvcERUQUxKSGdZVzFONk42TlZHY2lad2c1ZUhYYnlWSms5?=
 =?utf-8?B?eVJKaWQ2aEZaMXhEanpVNERtNExac3FHc0xCckRaY1JRVktXeEZjcTkrK0Zv?=
 =?utf-8?B?ai8veThKVzk5SG5ObFdaRzdUK3NpZlVndGhieWhiQmxMOFB4dnpMbjhLWi81?=
 =?utf-8?B?SHZYT0dxdnNYNXovNjMwUzFmK3lJVnZnT3dBSEpvdVV2VkNrUWNrRGFxL0wx?=
 =?utf-8?B?VG9UVGpEVUpnbGN1ZldWVUc2ckprZVgwbHNhS0FEUU1aQWcvQjl1S1lHVy90?=
 =?utf-8?B?TitUSTFjc0NhY2phMmZqeTBSZEZXU2w4TlpYVW9MSndpYXk5Vm8zNjBiVjJ2?=
 =?utf-8?B?VThwM0w4dVJnT3ZUSDNYZkVoT2prcGxhRmJWNUM3eGFKbDVGZnZiNk9HQW54?=
 =?utf-8?B?K0FzTHlMR2plTTlWVVE0cXNLQUhhMlVzVHZ3Z3FaU3c1ZEtZWmxEK3V3WGk4?=
 =?utf-8?B?bHlnSzc4N3FPc2gvNmdjYlhObFREdjM5dFJrQ2RDSWZXLzNpdU5MVmpaQ0ZP?=
 =?utf-8?B?cllQQjY1MTVxc25DdHdKNndPVkdEdE56NXU2RzVtVDlQTkhxNEpKd2lKUHl3?=
 =?utf-8?B?YVVNbnp6cEZvZjc2KzNMZzI2ZVptTVF3MFlFcjh1OEhJMEJMYkVlN3hWUkNl?=
 =?utf-8?B?U24vem15aWJSOER5bTkxdk50OXJROFFSY2ZNdXp1d1h3SXptTlV2MjZjdkYw?=
 =?utf-8?B?YkJiR3dHQ093S211RGpTV213R1FqTmhXTzYxYTVnTzd4TTBVNEtQbjd6VU15?=
 =?utf-8?B?WG5LMFdjQUkrTGpTYnluNGswcjA2Q1YvL1d1QTg2emQxempYcUx5dXh5OERr?=
 =?utf-8?B?VGhvN3ZqN1UvUk9hZTIwcGpPMnExc2VxVmlKTlJaWHJCOUprMlgyRmpuaEJi?=
 =?utf-8?B?SDRISEdoQnRsWnBTWFZMUThyeDBhZkNVMUhzbG9mOGRyS1ZPd1RQeVIvMTNr?=
 =?utf-8?B?QWlUOUYzWXJ3eSt5VVljUXFEWTV6STNBalBITWVGbHBmL2pXNTBGTEprakNw?=
 =?utf-8?B?T1BzWUZXSVFnZ052bUR4ZEhNaDhUUTFTbktFdHEzK2tkemxLcWtEWUhBcmFY?=
 =?utf-8?B?L1Z6R0U0SDhUV1ZyMkY0bkg1aktOOEpnYUwyUkhxZTdLbWQrdnhzZldjb0JK?=
 =?utf-8?B?QnM4alBsRWYrT1g3V25TNmthT0dZQ3NPcGsvQW9uQzlyTVJDU2lJZEFQSko3?=
 =?utf-8?B?Q3I2NnlIdG9Lak1sSWNSUFJ5MUFZT1pzUGNUbmNCSk9Od3luL2V3dklpbFVn?=
 =?utf-8?B?bVhkM0NWNzhTYXA0MlRsZVoxSDdqY2owMHN5YW9IWUtrVjhhUVliRG5mdHRy?=
 =?utf-8?B?b0JVWE5GbDRlejN5MUo2NTZUUkxIbytLd0liUmlEY3VLTkNDZXZCWHhVZkVH?=
 =?utf-8?B?TithUnpVbEIrSW1Zb2hxejAyU0FTMWwrNmFOUjRWYlg0YkdFcVhuc2JSNXBK?=
 =?utf-8?B?b0RrLzBDSWhIa1lwMWZFY3hycjRabGFrby8rVktSMmJ6RFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmFualZvcTYycGFzdEl1OWFXVWZhbThkdVVQWWxCZ3VKMWlIOVpDZ3RvM3FM?=
 =?utf-8?B?RXpsQVQ5bkx2cHhDOWVaV0ZQTkM5cFkxWEJwNjVnRG5XOHZFWklLeTlMTXo1?=
 =?utf-8?B?bkUza01pMExpRUFQeHVnYTVXR2Zac0ZkNUNNRURlMk1lRUFpTGxncVNYQlg5?=
 =?utf-8?B?YXFHeE5VMFRZVDhKa3p2cUFqYnE2UlhoaWQyK2d3VGJHUUt6dXFsQ2lUSll2?=
 =?utf-8?B?enhiRXU4Z0dpV29EcG90ZzZ3cUZQZXhKM1NpVkJYUGtEWnIzQW1DbDNydjBp?=
 =?utf-8?B?TkUyemxJNEFQcjZUSHpLdnZCWHV0bzRzckVUWUxCSWVDYzJrQkZFakl3V3Ba?=
 =?utf-8?B?UWFZTHZuMVgwNEdIVGRFQ3JtUXpzVEdKZ3M2aG04K3RGRisxRGdlSytLRGNN?=
 =?utf-8?B?eDB0a3RTSU9QQVBpQVpLQmdlRURUbHJQVlplNno3WHNvdlU2MlV4UFE1eFkz?=
 =?utf-8?B?K1dzQWZmU2paQ1hnK3VUMGZqZzltKzYwVUNObUc5N01jK2ZxZSs1SUFJenIx?=
 =?utf-8?B?UENCUHByY0ZHbXNBUEdGbjg2T3RMWUlsQ3lvSFc5aC95dXZFMWhDMUlqRnYz?=
 =?utf-8?B?WkNKNDdNczFZanBObE1QM0RyMG5wbkdPVERIaGxjZjBmUFpMS0w2Ukgyb0VS?=
 =?utf-8?B?Yi9sZWQ2Z1NQS0ZJQVlGT2l5RlFQendmMGVjSU9BalRzdHg5dlMyV0VUM0Z2?=
 =?utf-8?B?dnRDaVdVeEFwVk02Zm4yTnZWc0NsenM2VHJtZDFFYWNtNytxWWplSGVnZXAr?=
 =?utf-8?B?dEdVM2VmQTg2dkJtdmFCQzhkZmtoNEw0eXNRS2U3RlJRNVA2Q01tQjExNlRS?=
 =?utf-8?B?M09oMW4yT1ltaHR0cGcrVHFCZTJKQ3VaaG1BRGVCakVNbHFxelF1QjVaY1I2?=
 =?utf-8?B?K240Z1BlNSthYVpQd2k2Z0F5UDNkdE1OK240QXRtck1UanFGV3hWZ2VMWDZk?=
 =?utf-8?B?cnZ3eE1nWHh5dVA1WlRyUnVUd21na20xRGVncU9Va1k4YTB4eGlBTDNBTTVT?=
 =?utf-8?B?YjJZc2NtSDR2MmFLbjlrRHA3UkdOSzJPV0kyN1pTcjN0M09yaWlBQk11WThl?=
 =?utf-8?B?SExvUXdYYUZrOVJqUEtieVRxek9CK3p1TGE4WHRUV2RnTDRsL2xYNldDRlQ2?=
 =?utf-8?B?QkUvSjhaREdwNlJ6RUZTVFFYdmMyYitOM2dkeTZ1MTFVWVdTUy8rS3pOWE5D?=
 =?utf-8?B?TTBkSkw1ejRXdkVtNHoreGpraWxUZ2dSREVlbTEwZEpmYzF6N2IvN1p4bllm?=
 =?utf-8?B?VG8yUmxleHYva1c2bytZWE11WHM3SU5qbWpmTHVTYU9NUUJ3aEs2VlFVQmRJ?=
 =?utf-8?B?Qmdka0tBc2xRV1FVQzh6SnJ3M2dHRnI3WVE5SG45VHArblEyQkpFQ0FKRU55?=
 =?utf-8?B?UFRNZUxmNVQ5djlFd0JSRG1JR2JqYjB5RkJ6bTRIRHU3cDJPVTFOQUV0YjhE?=
 =?utf-8?B?QWlVZC81akhiTEk3cytZU1JtSGZuSHlNdmhyV3BuNjlNYXFCWjgydFpLL2gz?=
 =?utf-8?B?YURLemprVk0rY3NnZTVTSUR6Q2JJYnhVcnVmdnQ5aGY5UGhJT0V1blJscVNH?=
 =?utf-8?B?ZmtGNlNMRVdEN25OMkxqUzB1eDhGVkYwMFU4Q09qeHBlM2V6TDlJWnZ2VjY4?=
 =?utf-8?B?U1JvM3FGQ1lkRnZUYldCUWsyLzd6L1ZrOWFNV0swWVZvQzR6dlBvUktpdVNP?=
 =?utf-8?B?enpXeHRHL0pSNDZLU2xRU2RkdmZwaEYwTFpDUjFtMVJwY014ajlzZ2VoRWlp?=
 =?utf-8?B?NUpwR1RFS3Z1cGc0OGZEeUlaYWZXMnpVTHc2bnlJek11c2lXQ2NsOFJReU1Y?=
 =?utf-8?B?OVVXZWRzRFpzeDcvbnZLY0E1b1JKTFZZVU1xZVhna2pVeHZSVWN0cVFLUTdR?=
 =?utf-8?B?ZW5DVExLUjZVMGhEemQrdTZOZGtua0svY1ErenUwTG1IOERjbCsyVm1aa1V4?=
 =?utf-8?B?WW41S0pjM3I1cCtSbWhsckF2c2Q4Mit3ZGozazIwNmI2b3U0czE3RW55Y0N3?=
 =?utf-8?B?SlFVMmF6SFJZdlR0MVZCNllmOGxIM2JaeDJvam1LVitvY2FsUUxvM3MvRTVL?=
 =?utf-8?B?Wm44SWYzYXRoa0VxZ0hTUDJsVFUzUU1ZSU1QU0VGZURsd0Qvb09rdXVCZ1pZ?=
 =?utf-8?Q?ifdYbfkDg5JajwtBLJx6mMvTM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8474a11-df64-43f7-1d1d-08dccc8c080b
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 02:48:19.2757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: isHTqYBhYnDf4DIUvkHTJrrvFF8Is64AMtM3WRMhhdAUMT94b/wcTRtBC0ph16AbwLHl0q+QHzupHnOMUg48WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5045

On Tue, Sep 03, 2024 at 09:50:41AM +0000, Huang Jianan via Linux-f2fs-devel wrote:
> On 2024/9/3 16:54, Wu Bo via Linux-f2fs-devel wrote:
> > [外部邮件] 此邮件来源于小米公司外部，请谨慎处理。若对邮件安全性存疑，请将邮件转发给misec@xiaomi.com进行反馈
> > 
> > Set inline tail flag to enable this feature when new inode is created.
> > Inherit the conditions from inline data.
> > 
> > Signed-off-by: Wu Bo <bo.wu@vivo.com>
> > ---
> >   fs/f2fs/namei.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> > index 38b4750475db..13c295ea19de 100644
> > --- a/fs/f2fs/namei.c
> > +++ b/fs/f2fs/namei.c
> > @@ -315,6 +315,9 @@ static struct inode *f2fs_new_inode(struct mnt_idmap *idmap,
> >          /* Should enable inline_data after compression set */
> >          if (test_opt(sbi, INLINE_DATA) && f2fs_may_inline_data(inode))
> >                  set_inode_flag(inode, FI_INLINE_DATA);
> > +       /* Inherit the conditions from inline data */
> > +       if (test_opt(sbi, INLINE_TAIL) && f2fs_has_inline_data(inode))
> > +               set_inode_flag(inode, FI_INLINE_TAIL);
> 
> Should f2fs_post_read_required() be checked here, like inline data?

To ensure the conditions for enabling inline tail are the same as for inline
data, I deliberately use the inline data flag to determine whether to enable
the inline tail.

Thanks

> 
> Thanks,
> Jianan
> 
> > 
> >          if (name && !test_opt(sbi, DISABLE_EXT_IDENTIFY))
> >                  set_file_temperature(sbi, inode, name);
> > --
> > 2.35.3
> > 
> > 
> > 
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

