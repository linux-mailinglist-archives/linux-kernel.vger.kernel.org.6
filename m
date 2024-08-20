Return-Path: <linux-kernel+bounces-294623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E8A959050
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115681C20FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 22:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FCF1C8239;
	Tue, 20 Aug 2024 22:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="hmlaW/bY"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11020104.outbound.protection.outlook.com [52.101.51.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0E01C7B6D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 22:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724191977; cv=fail; b=lJhtCFNxqblzCfaYglBcg9KA6YShbULYzH98KEOzmIX1qZAAT8oGvWAl2E/IwM0ZIE4WEhvIxYkp7vabWFj0LcUKKrD0tLOUh2k6B1AQchoZ0if6zAY7oHO77EnXQ5umThvrRBPHjl1k/gq1YShc3e1cwB4Qk82Dyb+Zm0qwkRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724191977; c=relaxed/simple;
	bh=WtkQ09LubmclzEAOxVOGY7pbt/5Y5dPhMLRgUHZ1ukY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WZ05c36c5zXQWgbfgTFSNZ/BnkGfUX9mNoscedLR8NpSEgF+fWCy7SrOotcv247hNCgyR/q7ROF327MDbdRXE9jApxAZ+S808Q9TxlyPCoFypu9jlzk/M7PT/nSsujl0nSFWvIRhzQobT5koa3v1raKBubdP7Q2WXlGLy31hNKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=hmlaW/bY; arc=fail smtp.client-ip=52.101.51.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGwPpCx6vwQyu7HLW5JH9jlf3UlVRqJqkeHOYcS6K7OigH3zToXpIP3X/LZbXe40c5c/stQWQz0gBfsKEeLupBTWnhjrsDAr2Kn4geeTSFHIAsG/Ow1enhbe4PB3xp50fasC1kGzq1a7PHy+ha1JJUf959wGOUzdHtfs4lSN0X9fEU9Etg+2xDg+z4UvO/G/LB8AgMdro/DuFUVIzedqrzceNI8CXSxaQSzEv8oRHhtCHq+X4KbX7YwntzCcu+apMbTeZsapNYq4v+bzwKUvvf+SGwV2+TnVLuJ+9k9fDwbekHOtLV/1xbG0piJN+qj2Nz829AL0bKjIYh9knTNyYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiFJ8MvfYUVnov92UnU3n/J++eNtloa8iiECuINsF/0=;
 b=DYV9xFT4JRSpHDWeIbFY/qKWnG60l1h+HttwJLccO+Ark+lKeagDCFT8rB2UhAedE1jeQ3PaY94fjlfP7UVwho1mpr2buOxI6Ydx07JUDaPDe75QtmQzf03KMe/myEzJq3r3TIHLn2jr9wS4+J6+Fw+jOoUArOniVPxGFyTM+l3Gbm1CRZot9uSdz2ypuE/igk7KhTdluBEnbiv3tFCrOEXf+MK0geL3DmL325+bnw3VuAp3qGVHClGbbeaHCarciqCn4Nge2HkSsuOCU4VZdnTQwccsqqUTC05liL4mR33jNcvrYOekCYEMN8fIapdGo7sMg+BBKS/Ewi7l1aE7/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiFJ8MvfYUVnov92UnU3n/J++eNtloa8iiECuINsF/0=;
 b=hmlaW/bYxO69OlLYuXimmZSU6FzqnRHcEgBiL3mwXGruifj/jSf2k9GtHnF7kBIZFE20w6aecmvWekNxN9o1HjGSepoMZ7AhkAnTRbAjGN6AarAdb6MnZk2bsgEAZwupUFcB4g+NNksHGPHUOXpONwsgIUId3LMel4Ttg7lJY6Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 CYYPR01MB8601.prod.exchangelabs.com (2603:10b6:930:c5::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Tue, 20 Aug 2024 22:12:54 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%6]) with mapi id 15.20.7897.014; Tue, 20 Aug 2024
 22:12:54 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: james.clark@arm.com,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	leo.yan@linaro.org,
	ilkka@os.ampercomputing.com,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"steve.c.clevenger.ampere" <scclevenger@os.amperecomputing.com>
Subject: [PATCH 2/5] Add dso__is_pie prototype
Date: Tue, 20 Aug 2024 16:11:34 -0600
Message-Id: <b597585883b7f920c65bcacc0b9df9be3d569435.1724104248.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1724104248.git.scclevenger@os.amperecomputing.com>
References: <cover.1724104248.git.scclevenger@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQXP288CA0033.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::30) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|CYYPR01MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: 19020fd9-2d4d-4240-c709-08dcc1653d3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zbb3d6mTDBjvM/67VgJzuTeCadoDP5Jhp7b17s+FfWH/SiF1oC6oULnEXcxD?=
 =?us-ascii?Q?C2aoAPXtgigjhYCakIU88Y6u92hHskuLbQ3HwqQtPD4i3FBMmUDteCptr5zI?=
 =?us-ascii?Q?MvXSWhWC5iMksF5inzf0NQugUnezb5YDnzDcfsrAFw7jC5R0H/n5iXlbTMbi?=
 =?us-ascii?Q?1S8nGFp3L0t7FJNjPFp1BfkcceFWGzF3IWiFFwon/GFIT9qSg4jWWod8a7yE?=
 =?us-ascii?Q?SmNGBxa6qOtzBdGbHmzu8IfAiE5Fdmm4C/bKhSfk9mULjv+efaRKh4KTwfB0?=
 =?us-ascii?Q?RhUHUIodWvGLgEfp7O5vro1+i8y1AMWunf9bX/EDLRaxED3CVoi3e10jFFzn?=
 =?us-ascii?Q?l22oOnmGcEwkVgtw/01u6QkO70vyY9wlMZpBj/ez/RFWsSTBhgsuGisqHoF3?=
 =?us-ascii?Q?Zq/ZkUbLXqX8m3k0HZenE7Cobr6HowkWtXoeFRtxmcXxX29J8CpFMx0HeZrV?=
 =?us-ascii?Q?lEF498RmwYAcukJ1At8NMvN20jGPJa5eW1MLgyXyXUc95057C6chDPw8ZCCv?=
 =?us-ascii?Q?ywNLf3hjSWrHfk/ABX653JAP5R7XYUsqrCb24jXj4nbSPJKMhnnaNhcaebJI?=
 =?us-ascii?Q?k7S4a2UAR0yDlhsvyw6+hEYntV58oBa5lypiSPUrMgJ3WN5gmFeF/H7GTdN9?=
 =?us-ascii?Q?KLYsSxN9ExR1y8KzBDZbLP3kGIBiQWu2RUNsemY+iDmjtGHCCIXwbUmzKOmY?=
 =?us-ascii?Q?apljdIkoBUjzxsrBWK4gykkmoF1zE3q3RIjCcK61ovYNKVEKFcOsnmApzAWD?=
 =?us-ascii?Q?86wfWGOegYkhnin5oJwT5wkfNuFEzd70DpkydJZslXqyZW39F1my6imz/hAV?=
 =?us-ascii?Q?eRYQ1PX5t7XhCPMYiv94NVwDqsaum7EIz3PwMBtX1xbBqzSAyYb8fhjjfwOT?=
 =?us-ascii?Q?0KZY75RChA92XZCkJxF2iShSmA74PJoJxVSJ1uw8BCzM4RAOXLWC84pgF9LH?=
 =?us-ascii?Q?GQd1Q5y+RF7VeiZj2N3+zQOImnwquh3VdYxyALS0w6SptK65T5Pbn+qztIyn?=
 =?us-ascii?Q?kbosuTMZCxVXIypuhNcGQR3U7tdyIhMkeBKoxf2iOd+HVju650s8FD2mHK9M?=
 =?us-ascii?Q?MLxTeDxsYaN9jv4RdrT8/XJ/MPYizc/uB9U9mrAGq8H9/vCgnDg9kmHRPZJr?=
 =?us-ascii?Q?WpWrKqZ7H2pQ4aBqhDASQKyPu+hXzZlWC/rOZOo0DVOOdIzmCSCJb1y+NfWh?=
 =?us-ascii?Q?K0swi13MaP3ZLCR4ga13Cq+MjvL6pb/7ypCc7mEE8WHshPWF1JbCCRNxbPa7?=
 =?us-ascii?Q?LEJ+pIKSChBZz8VPiYqTP4fJc9n64unnTwAdd/++8jfWRFQWVtkM9+P4X8UU?=
 =?us-ascii?Q?i8dj6jXxZxHprVaFgMPFNWbruAR3EK/9gMZ7J1KtcCYL3p/EL4QU7GJnd2bu?=
 =?us-ascii?Q?6fNFkQlUkqEfVfqQ8MdrZHuCDdSQdeGdBrwsOFn0KU0tSEr+Kg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k1Jfl0ygP+TQlaIR6qfRVk/TqGea377LGeL+spEx9mXpqHF9GE99f8Ke1hNR?=
 =?us-ascii?Q?MFRHZgAlRuBLDWtTeSN2KC7F2fCwopv75YEz//L4Ru+UdJrIuCxzsFfwLu4p?=
 =?us-ascii?Q?RTWe9TOlaYrb5AwgtUbkn9XQ9x0BfX3zrmoKRRAOUX9VKwDORLaAKUk6gLVR?=
 =?us-ascii?Q?uU5Fv5BZ2SlXh9wqrIdDl08BtOWmQzzJOIA6y+2qohzolceNi4G1oybZCyPa?=
 =?us-ascii?Q?DDZ5GSH46OPEo2UP32hulCgZC/EvGB7MvT/ETmi5Gz2oh7w6F13h9Zd68ltl?=
 =?us-ascii?Q?Mu5aNde2Bnn7SlsXRlZTD55h+/KWGBFt4wXq8tx6Zag4DMWe6v4Ht5SEnuBM?=
 =?us-ascii?Q?dBv9BigYgYR9CG6lHQm5e7MZ5Z37qwoTzX/woRG5FTCoNMvqJ7P2kLbPpLzh?=
 =?us-ascii?Q?UnZJN0YIv4aQi7MazKEiOhZvoWeat3OviSAAcN7XRcbE08PAKBT1wuL8zsRu?=
 =?us-ascii?Q?99Riu9yeod8DUI86l1BLDGiOyoIIK0nV82doTiZBdqOhKpuzKxWQRJtmD5a9?=
 =?us-ascii?Q?gLbove7Asqx0hNsrFWiYoNPt6PKja0EVAu1FsOo8lYocn4v43aMdemGKyjSu?=
 =?us-ascii?Q?ur6D62ShqiR61/0D4D2dd5jT7Psh1suKjaFDmpqd31r6KPrxI1OinJrGv/NF?=
 =?us-ascii?Q?QSjB0q2z+sX4jnrujEuYum8lvOGtl1TRQi4k3Lq7u3ZauRN6YbcOvatTYGhC?=
 =?us-ascii?Q?b0eJCshvW2bpr5xwBSUgvOzkA4RXnoKmIDLYIlKUPhJB4z8TL9hOHUfPAf88?=
 =?us-ascii?Q?7aaanq9scZPYQ6xcvvoT9dDHzvvkBoplvnNHeRYdtlkZHZ1TRywoz2Ns7cFk?=
 =?us-ascii?Q?vV622aiorTKXo7QXU6gvnqGl/T6tQpdQ1jDGT2fM733UqTmHvDkm560u55Fx?=
 =?us-ascii?Q?xzE3cUfVmH+C8Wq+neOQCsZXJuFXL+Nd9r0t2FbG6a8J175FQ/g6LrCpLfN9?=
 =?us-ascii?Q?BYz2qiDaQMU2QzAKgdjAGVaxEnDQHYwdZG1+gW0T8t8YAV8Q0pc0qN+m8JhQ?=
 =?us-ascii?Q?Y/GmbSWnyhiqEFmF36g3DIhIJCyhTs/YbrMUn2xE6IRKR+nCwI0yELxfSRP9?=
 =?us-ascii?Q?2k1lEtl+gjCOtoCzEHphrmN9RtEkK+oH+Ys/8vsEevnWQf678GP8UaOy2S4O?=
 =?us-ascii?Q?qKdi7EsTsjBH5sZSXnGbDoGEOd3nmGZYF1IQInY8oGzBkcF2gnZpAs2EJdP4?=
 =?us-ascii?Q?C/6RTZDK3zHcmaCyOOMNDppb41MHpAJVVHx9pHTH8YUJC8E8Wq7f7ciBzY3A?=
 =?us-ascii?Q?r98PXJWM/un9zdwW6TwVs2HhlrTR6i2P2vlz+iywaj+qVVYxt4azYJJmFm/c?=
 =?us-ascii?Q?E33xb5zfpRPKBhhKw70ev0AFLWu0eNzcaCvUjCVNvEJZzRrrwFeAowcig9B+?=
 =?us-ascii?Q?dN3ExgxHpaL24YgZeHEmYVbkuf2aExCbJa47jaWCGgsqhbzAZkhtMseHmIZa?=
 =?us-ascii?Q?Ln1fOX+kZGY5PmDF98oEgGSW1eE8Y+zXRgNbsAMVT9xIj/Hw3NMnDLlsQZ9k?=
 =?us-ascii?Q?qew1vQTEzjSs004gRhT7b1gHkbDj4CsxzHu8cOdH1LcaxVd/TaXBEkLqTIya?=
 =?us-ascii?Q?F3sDrWaie3diB/nTCju1eHrhtFc3HnD2f0a8AtEz1ym1nPzXzW6Vq4jdwE5s?=
 =?us-ascii?Q?BESdnNOU1+p7ar/0hOwuihYa8yuNo1Q/UX9ejHDskEU5?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19020fd9-2d4d-4240-c709-08dcc1653d3a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 22:12:54.4836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZYzzWj8GojAIortXRqWJDZpXd0zztyZfmh5WO3AYWdDBeBr/jOtXhKpLSColXoTPNylIp9HsZORBo3L1yrZzZk8y+1pm4dB5K9p0Bj1nMIsCFE+XUiYCOyszeViQPxl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8601

From: "steve.c.clevenger.ampere" <scclevenger@os.amperecomputing.com>

Add prototype to dso__is_pie() global.

Signed-off-by: steve.c.clevenger.ampere <scclevenger@os.amperecomputing.com>
---
 tools/perf/util/symbol.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 3fb5d146d9b1..33ea2596ce31 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -127,6 +127,7 @@ void dso__insert_symbol(struct dso *dso,
 			struct symbol *sym);
 void dso__delete_symbol(struct dso *dso,
 			struct symbol *sym);
+bool dso__is_pie(struct dso *dso);
 
 struct symbol *dso__find_symbol(struct dso *dso, u64 addr);
 struct symbol *dso__find_symbol_nocache(struct dso *dso, u64 addr);
-- 
2.25.1


