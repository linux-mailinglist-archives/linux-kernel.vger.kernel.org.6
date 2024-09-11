Return-Path: <linux-kernel+bounces-324187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42571974916
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 06:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 183B1B22E0C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 04:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5F2433D0;
	Wed, 11 Sep 2024 04:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="OnIBw6p2"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2077.outbound.protection.outlook.com [40.107.117.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C03EC144
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 04:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726028885; cv=fail; b=pI85t8MZ3bGTu+/norSk0DfLPvPFUYvSj9LGfH4JMlRZu9YXZIQd+9ZqnuseSj8mm2cDC7aValgM4ZS/DmtgBu/qbJU3a3Ki2OsbwH0ISoddq83xdN4Fknq2AT2k25BKC4xyyRUbzTcaDW9pSpQDvwO4zvjGdXKT8RFMHD9l12Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726028885; c=relaxed/simple;
	bh=jg99VwXMUqBk8hFT9jdKk1TJ6Aiw0Unq28LN2pV4HEE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ch9XhnoQcdudGMAkEhbqJO+Xh3/2d2oRUo0kvXwR0ALMpXYu2efMYzL/KNbcfHsqPvzLp9rXgdXvT9rhSEPaQpcEl+97VbeUsmDGNbEwp+rPTyOVxbeK2ZAZoZkdUHqGIqggr13Q0RCNwKa1dFogA6df8Hai3E8POxC9GvCvpas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=OnIBw6p2; arc=fail smtp.client-ip=40.107.117.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTViOJBeDzAvpxe6KhyA9T4LMCGEumI7H5NsemVjDiR5R+h8wMcRb21fuLt7wiQeubkNgMbmvzutJGjtZN2qRYqoq5tsnBYX+DORcBbzRFf341Xg7aZRjadXFBC7JhyVX+FR9mn/2lce7xOg/EeSdZFW+LJ30umigaMuQFfB4tfM2Z3ZgojuaLrUkA44FzfmeeTabWFPzDQ2ZNIP6KlZ9Yeg1xVv7TVeyljCNC9xBMbJMsx6GWdW5Ha8/rDkHFIXBwxP8C64nw4GN2C6/KkbxCcYKBBjgzuqUqoENDSDQUMeGWYGA+QqnXNkeCvG59BlbQaYAVYmB3aqzA7MU4au3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcBUyffg+z0fI5hY6qSreYTpoictkJFNyHA4kdjTV2I=;
 b=BO9BYG8Eoqh8dpKwjkS371sdWWRwdKo5VfKBpUQbsnb1Ey2NT1ifRaekyiGc9HMiBQsd3BXTs5SBQOeOyL3YtWZ2lcUxI7Qovn9uO6DmWiPr83ad4NqdjyZzjwCbU0v4IT5rEaT0Hh9TaAB8/DLV7bxjDyRVb4dsvm6Aa0mx0lzqPvgTcYcebT8yxzSmysVEswgFQ+sLHTbWY2Ns7QHEGwuj3Y7ZxdeW8o69LspdvG0HC9R2tNkGWyshubN6uSsNed13k02oTbGLQvziv7cmBzm9XAvFxSUPR56x2tDute/royflVxgAsYJpQaBAANuYUauMbnSmWxEGRhNZLASwQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcBUyffg+z0fI5hY6qSreYTpoictkJFNyHA4kdjTV2I=;
 b=OnIBw6p2EuzWhuL0UXdrIYjwhlpOgrhTeFGu70zPgGIrq7xx2dnmPWfHiR/Pn+PXOP4moT84ALVmG6rvAiQ5ICStrqiMRizCwNjvFpa48nzlvUzFe0drttInPIR7/zX2KBdVw35NztnxXdvxZaqmz71oxCiTk2Gy/Jd2fjPBT2+/HSZRsKlx+e0mnxzkM/h/PexcyGErP4rWAAahlw3AenjljVn2XdpAx6hzPoOhCyiD/ajOYsUOJWRO4Jfwe+yFMsYiUen1w2b4DzBQ1cfntJW8fPpYi+hLKVpSWL0+ZDDcRWZGKO9bxwXHX+wFiBdQAFLyaq0BDhrVWCz7yzZlVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by SEZPR06MB6928.apcprd06.prod.outlook.com (2603:1096:101:1ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 04:27:55 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 04:27:55 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: christian.koenig@amd.com,
	alexander.deucher@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v1] drm/amdgpu: fix typo in the comment
Date: Wed, 11 Sep 2024 12:27:38 +0800
Message-Id: <20240911042738.3886250-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0024.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::11)
 To KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|SEZPR06MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: ccbe1495-e6c2-4d8c-c8db-08dcd21a1b58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HEOBXYEANom2zf1KXipBUBhSfnIor4carXiZVVLUDtBe4pbxgEdshi5fSAJw?=
 =?us-ascii?Q?+/IYUelpjd1K1M58GOXVlLWxjMKS5nbetdX4SqHIvltT2HKD1MLXP3x6yGy3?=
 =?us-ascii?Q?T7y5CZ90TxYR+p3hwdYgZcN7+r1we/n/n52olicu4+vSzxJmzf+UU+7TtSXp?=
 =?us-ascii?Q?wLtfiwfLR8cyBLdXlpIIcoqymD6OkgHvX/vGLr/rT12gaO9AL4Uyo/y9elN7?=
 =?us-ascii?Q?gahUH+SAESFCAs3rG0siI0h3c+YAEP3zm9rCC7mC5Q9aqLTUw2GpEAeqGhzv?=
 =?us-ascii?Q?9KqPKVdrsWdsy+W/V6+1FM2BVDvTKf4w0CE6zDvkQJw97sEYaOzA1j3KjK1x?=
 =?us-ascii?Q?doTUkBwccqBukbe6H4kbE95VS+oMAgAAgN2Rh9YhlssdDSfd8+lSX8hP7VBy?=
 =?us-ascii?Q?t6zFukrJwrgEMfjYSrFgBoGghzf0iQxtCZaPoxSV8FvC93FYcfh089m5n+sR?=
 =?us-ascii?Q?MgKcqqX+rMmQhytJvOuPtDmJD2iNGMxie5RHXp1DewX0cP3hk94qd7RBxIBK?=
 =?us-ascii?Q?Lb7AKU8NQnHC83ZophA5B555grUM254CxyudrInvhow19v3PXPEbT/aXt0yn?=
 =?us-ascii?Q?RJClsNBqGWj78qeM9xaHtXzI4yqcL643Flpm+PswJT1Ir7au9szfJ9GQFjhU?=
 =?us-ascii?Q?z5YUJDAe5oEcNPybyMxlEzVtQaYSiKPGagRYPeMcoCju0wQmsPjMP+cUfnrG?=
 =?us-ascii?Q?Q8rO/bz9ZJivvkCjJeluDKJ8pZ4MgQKwEwtxtPqHyR478hAznGI4ppu2TT0P?=
 =?us-ascii?Q?pT5yw4OwnlCj3GXkcmtOrlAVloW0KW83bpnhok5wTuYNwgC9l+3Ttgsa6CzV?=
 =?us-ascii?Q?o4Ke/1rLT3z//19XvdQ3HEHMXcjGpWWCpqPqfKA5ENwlm94Hi8DlNbjIvh85?=
 =?us-ascii?Q?YeQMibHAgVrFrZe+IAsYoU58Y25kKd1soP+DBe4uTyzcGdKIZXGx2Hm3DrC0?=
 =?us-ascii?Q?gIea6KCY7VniksZxP6MLchz1GREB/kmspHgta/5HeLxHBNdJ/N31qrK55D0a?=
 =?us-ascii?Q?14v2aw/qiKZIajpIBAE3AlAAmadmOrFRuqE1kP4g7Rnet68v4a0TFck3pZrl?=
 =?us-ascii?Q?YAZBweeP7GPgM7yk1pr9He3Qml2rEYHjvh+r8tPXhxZShzfoat1V/anNyM9g?=
 =?us-ascii?Q?FIHZj8tQc/anjlfLW0K8FRqE6vOaE8LVYj6YEAMPA0A4gXjpCgQJgIAO59dX?=
 =?us-ascii?Q?ppTg/Fk4DIz6viuVlMLiFlCOr48stuSRDbirAG1EmZI58cYZY3BrvtDg04PY?=
 =?us-ascii?Q?io/VqXhvCnKxojQspxgqsX7s4UA6aWxMYb8kAgxkR+iRJvSSPfK2bz4ZPPhW?=
 =?us-ascii?Q?RJkFYEYWYQAhDOZcBAY2XEG8H8OvYKIjTGA6mMZCYeA+MkdFEHxW57YYoMM5?=
 =?us-ascii?Q?aK6Q57tXjt/SdbHPID9PER8Et/eON5eOD6nf1sJqMHUwTmWfDg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zonBbq4oC846IvNj797gqSwFhfjoPyiXCzcJt5rCJfIuT9AEUqnlnPick40l?=
 =?us-ascii?Q?pBgJr6CvSc0wrUPJJHKdEdzzAI6EwEP3uNgjazqsqUC5SwslDEgNHvt7zxqQ?=
 =?us-ascii?Q?ex60XV94HY3YuUBtBiOSk3+sVRQlHXIo91z0ioto1K7E/wms9vbG1F+yMsuC?=
 =?us-ascii?Q?XxMO6vwrVafYLGniLLmcVQvBdtddxifw8x9gwox6n9214AdFpKLJ3TM7hwjl?=
 =?us-ascii?Q?Ns3mGP1HYl6AxsEoyCWutUb6P6+FR+PWSsrq5SMMcAuMybFRP4mcY0gieg8+?=
 =?us-ascii?Q?DE5It4TGGwUhvK1bWGJHSNPKW8q6wEJC3CyUeHv3IBqZ3i3zDcFw1eBM3v7u?=
 =?us-ascii?Q?VJkIHQRpzZOgrMW0UQadBJF9i820ROO7ZsrZPbipaHIk0Nqxk3mKe5tm+Uku?=
 =?us-ascii?Q?RdZjJ8OnoDEIGxRpQYPnK7bCiN+2lCZBFCPKgMQ8NLNGxoXdr03UAEwyfXjm?=
 =?us-ascii?Q?naGUApS8P0Sh0K9kRIHRNb5w9AX8lKG9d6azpiNerUrw38HFi1hHJZy3zNxd?=
 =?us-ascii?Q?kQSTf2fiUUqZL83gA9LqHfWbWrIb+Jr5meiACdHRcjrkSotXyol3B9Iejmld?=
 =?us-ascii?Q?eudp21qQtgWcVaH12xQg+4J29YGAHGlxWYpzflEOXiseCxJ8N483zMFrrQG0?=
 =?us-ascii?Q?Za375UuXTGS6I6vWsQksHxLzfdYfMGBZRmQbhl0dNxdCrm/9kWDdjjNL5M5z?=
 =?us-ascii?Q?jSDnpaVcJwFv7iEjzxpPkd0ad6s9jc9oYv7nDRtok+TVIslrXk0FO0xLj7Za?=
 =?us-ascii?Q?k23YogHTJglvciz0YyzMiPVwJKYPsKI+ZmvqQVCr3zEtA+uuIU20duoJCc9S?=
 =?us-ascii?Q?Vq4nmFyjreCbTK8lS2x3kIesJdLK+AhR70JYVX1CqZcRX3Vjgp3qMOoVXjy8?=
 =?us-ascii?Q?q67aG2p9Ws4Mg91+4KJ2ZFSARwrgRQMIYdiRpHjZ5IcF+WLsRrw3//TB5ch0?=
 =?us-ascii?Q?i5ayWB5eZYH002ujCJN952j5LkfMZTkvVlOccYZq38/fpgADnLhQE6MPMDso?=
 =?us-ascii?Q?W/crbPKNRAPAwZaptUlK3N3gcVzEHZrgBtMJCRNpaRA0qHuvu6ZTxvB7r3xL?=
 =?us-ascii?Q?ObqnUgrr3n92LPMKdJikNtB2gS39OyPTAVlpRD+go2yR1YhgaRW540nj/8Kz?=
 =?us-ascii?Q?ehAQfBAxHmhAUscsvFm81ahTOZYfbYdcxV2Q1YOMoPGW0W/tfnqAlilYBOsn?=
 =?us-ascii?Q?qxtRUf94/UfCC2Dfq+FdAV0MCkEOYTKwlhc4UYncFLWKAd1vMYPxG8kroDBb?=
 =?us-ascii?Q?Gl4RUFuiJE84MloVVA+z5jb11lEav53G23M2xn+7NwzOueZujb8U3/YhglfB?=
 =?us-ascii?Q?ZCA7AADwyFUzCnYHUkl6ggxysgBNzWoKkYl5f8kDvQyyCj8HyAcMgJbYrPWJ?=
 =?us-ascii?Q?CLB6cIOFxi7NEjfw9w/rrShKRXjQJ2AyOlWc60NWv5nd5vGx4OWVCQcZDh8A?=
 =?us-ascii?Q?kuVyc6vgrBghpG4ES7rCNeP+DBRqhqD6kECUqcsiz51DvtiIe8qbagsBihaB?=
 =?us-ascii?Q?0yMUQFZ4pi5Pu6JhBsd88wxdUzx9pHuIAChuOMW8lu3eDTzaoe/z1Xzkt16w?=
 =?us-ascii?Q?0qa9zbegxDz7msKhg7HAJ0FcyB1DSO/xvvo9JmV0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbe1495-e6c2-4d8c-c8db-08dcd21a1b58
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 04:27:55.2040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNruxFD4Kp7Gzzu6c1E03ObiyH2uhmDcw5aI3OUSUZu1174nVnek4gHEKbWEXZsOeVpYJUuR1ZdbAhIzDpbB7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6928

Correctly spelled comments make it easier for the reader to understand
the code.

Replace 'udpate' with 'update' in the comment &
replace 'recieved' with 'received' in the comment &
replace 'dsiable' with 'disable' in the comment &
replace 'Initiailize' with 'Initialize' in the comment &
replace 'disble' with 'disable' in the comment &
replace 'Disbale' with 'Disable' in the comment &
replace 'enogh' with 'enough' in the comment &
replace 'availabe' with 'available' in the comment.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 57bda66e8..2ca127173 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -511,7 +511,7 @@ static int __aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *h
 		return -EINVAL;
 	}
 
-	/* udpate aca bank to aca source error_cache first */
+	/* update aca bank to aca source error_cache first */
 	ret = aca_banks_update(adev, smu_type, handler_aca_log_bank_error, qctx, NULL);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 189574d53..e9e599ff3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2853,7 +2853,7 @@ static int psp_load_non_psp_fw(struct psp_context *psp)
 		if (ret)
 			return ret;
 
-		/* Start rlc autoload after psp recieved all the gfx firmware */
+		/* Start rlc autoload after psp received all the gfx firmware */
 		if (psp->autoload_supported && ucode->ucode_id == (amdgpu_sriov_vf(adev) ?
 		    adev->virt.autoload_ucode_id : AMDGPU_UCODE_ID_RLC_G)) {
 			ret = psp_rlc_autoload_start(psp);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 61a2f386d..71069b198 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -882,7 +882,7 @@ int amdgpu_ras_feature_enable_on_boot(struct amdgpu_device *adev,
 			if (ret)
 				return ret;
 
-			/* gfx block ras dsiable cmd must send to ras-ta */
+			/* gfx block ras disable cmd must send to ras-ta */
 			if (head->block == AMDGPU_RAS_BLOCK__GFX)
 				con->features |= BIT(head->block);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index b8bc7fa8c..74adb983a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1970,7 +1970,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	DRM_INFO("amdgpu: %uM of GTT memory ready.\n",
 		 (unsigned int)(gtt_size / (1024 * 1024)));
 
-	/* Initiailize doorbell pool on PCI BAR */
+	/* Initialize doorbell pool on PCI BAR */
 	r = amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_DOORBELL, adev->doorbell.size / PAGE_SIZE);
 	if (r) {
 		DRM_ERROR("Failed initializing doorbell heap.\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
index 6c1891889..d4f72e47a 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -153,7 +153,7 @@ static void imu_v11_0_setup(struct amdgpu_device *adev)
 		WREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_16, imu_reg_val);
 	}
 
-	//disble imu Rtavfs, SmsRepair, DfllBTC, and ClkB
+	//disable imu Rtavfs, SmsRepair, DfllBTC, and ClkB
 	imu_reg_val = RREG32_SOC15(GC, 0, regGFX_IMU_SCRATCH_10);
 	imu_reg_val |= 0x10007;
 	WREG32_SOC15(GC, 0, regGFX_IMU_SCRATCH_10, imu_reg_val);
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index fa479dfa1..739fce4fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -365,7 +365,7 @@ static void nbio_v2_3_enable_aspm(struct amdgpu_device *adev,
 
 		data &= ~PCIE_LC_CNTL__LC_PMI_TO_L1_DIS_MASK;
 	} else {
-		/* Disbale ASPM L1 */
+		/* Disable ASPM L1 */
 		data &= ~PCIE_LC_CNTL__LC_L1_INACTIVITY_MASK;
 		/* Disable ASPM TxL0s */
 		data &= ~PCIE_LC_CNTL__LC_L0S_INACTIVITY_MASK;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index aa637541d..e65194fe9 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -710,7 +710,7 @@ static int sdma_v3_0_gfx_resume(struct amdgpu_device *adev)
 		       upper_32_bits(wptr_gpu_addr));
 		wptr_poll_cntl = RREG32(mmSDMA0_GFX_RB_WPTR_POLL_CNTL + sdma_offsets[i]);
 		if (ring->use_pollmem) {
-			/*wptr polling is not enogh fast, directly clean the wptr register */
+			/*wptr polling is not enough fast, directly clean the wptr register */
 			WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], 0);
 			wptr_poll_cntl = REG_SET_FIELD(wptr_poll_cntl,
 						       SDMA0_GFX_RB_WPTR_POLL_CNTL,
diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c b/drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c
index e4e30b9d4..c04fdd2d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c
@@ -60,7 +60,7 @@ static void smuio_v9_0_get_clock_gating_state(struct amdgpu_device *adev, u64 *f
 {
 	u32 data;
 
-	/* CGTT_ROM_CLK_CTRL0 is not availabe for APUs */
+	/* CGTT_ROM_CLK_CTRL0 is not available for APUs */
 	if (adev->flags & AMD_IS_APU)
 		return;
 
-- 
2.34.1


