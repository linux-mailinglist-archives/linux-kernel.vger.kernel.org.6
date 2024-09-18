Return-Path: <linux-kernel+bounces-332211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 265BB97B6CF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 04:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9471F228ED
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 02:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A765F12B17C;
	Wed, 18 Sep 2024 02:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="tVHUG1dn"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020106.outbound.protection.outlook.com [52.101.85.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2E610A1C
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 02:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726626534; cv=fail; b=G9+WfXq2lTQqHzM/WuaUyqjawtaEXAQZ6S1CY+fQDkTS5LyoO+V4HefY0XC3/AIbG2vHFdn7YD/CQfwEoPHIqh0E2xqKo7/rcMXDE6mO0267DfIwEekj0LuVIP70JRzs6/LFjW7PWYqVUPH1PzVKKEaDtQ2WWzno2+HDEAiZRy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726626534; c=relaxed/simple;
	bh=Hqab7qh8WuQBXuqiFisNAfEWID4x7/kQ+LJugIbhaak=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ILUhVSBRi3kLTXv+/lRhsHnp3fbmTNqhXTm6AdUTYhU0ozc7bWKGskXPEbR1zwTWP3DXHAkILngGpyKREyBjqRLfU3WB4UCsd8DMaNZ29uhfAWorB82I8Eygn8GG+BNKNne11sXDXnXoq97QrY12rbMf5OZTNGX+/XJD++UlMHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=tVHUG1dn; arc=fail smtp.client-ip=52.101.85.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T44BLxbMKLDnJUCXYQI4Ragv3JO73hvErqSmLLDh7DCxnv+6VCj+5LHMSbNo5YOEU+27bE593r7DZ2Mr5DTSH8C1pPZc3SFlAe+rUGUl3VEg5A4M87wj1Nb3mEWm6r3WlV9JLuKIyVwKQPQj7SFJcasxxKGJRF/95J3zBMkuqbVqhOPunyvK31rc219jF6AMxJhXsCE4PRXfEGsFd9R/RWR6nMk4VO0ykZPdPi763wLAHVF7CirxTDuFhZnE5cLKmzxTtjoYB+Rm8+2YBvww2TKVGxxX/FChU+IMAYW8VJyXl/Occf8mu/qgfQsqf/oZk9rJWN7pVOIHS/+hLVt86A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDloi8ybtqeOzal7rAU/2dFqTC0AVHKs/wMnTrY0PBI=;
 b=V39JcGiuFVhZNQprIDjYFjNW+i4I6QjbdGBTa8H+rIZ2f3zwAJsGXQa9iyn7iYTxZvYAOnpHskWwZtoWYLFDtAk3/gkSuxtDSnLIvsAbjOKlGxyHsYbGmjX3ba31vZSpefa7kZ+x074QZZ3Q32SV54VdmfuOhnXfhmps8bSydb48wFrnoBpitZxTuONdr9pOFFyXDykfSOtoCVW6gcE8Q+BTsxgNIKgaA+5eWXjz+ueNTVLYdw2ClWW8FoZK1xuqnSMEVkgVE9h39mHpPAPSHUf7SqV+Lxhrm1isFB7KpD/owWfHFJ8jgTTc5R7rE1uUsz33qAkE392FAm1wfCt2zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDloi8ybtqeOzal7rAU/2dFqTC0AVHKs/wMnTrY0PBI=;
 b=tVHUG1dnfezfnRxXnpO805ZiX0S+HxQNB/0DFFXycmlW8XIvPWHjWbd83TDMkAhLy0mPD7taMjKfZiVftNlJKsVrcYuTykjXW98QNS0H4oUhhmA7N8gXrzBJ6UxfqHQiyC8uw8zg4OpYl+57c+FRUmdIqMQ9EU0FAbSDYkOjSy0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 MW6PR01MB8628.prod.exchangelabs.com (2603:10b6:303:248::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.24; Wed, 18 Sep 2024 02:28:49 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%6]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 02:28:49 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com
Cc: patches@amperecomputing.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH] sched/fair: change the comment for vruntime_eligible()
Date: Wed, 18 Sep 2024 10:28:13 +0800
Message-Id: <20240918022813.4579-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0008.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::15) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|MW6PR01MB8628:EE_
X-MS-Office365-Filtering-Correlation-Id: e628aa91-acfd-455b-49f9-08dcd789a097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yPjhysL+/WraIUNMermfZg9b7rIHfMYXHW9K3bNcPtWhIumTVwM4Fk4UkkHM?=
 =?us-ascii?Q?lemHYAiWdST0qhh0BkcWNLEAtqd5djioaNpam/E6rvI7FroTAREuHWgfv353?=
 =?us-ascii?Q?gOtH/iTBiky/1KbzS3AQ0btLI4Yh96rosqNbmQmwg5vPo4MvGIBYnwaQpjfI?=
 =?us-ascii?Q?cB9+9nlZE51LHttYM75nXktnytzwniJBmf5gXy030wdBuO0G8bCg0pgffa58?=
 =?us-ascii?Q?lHvliHUKSUBuIG14M0aTkTXlfovhj+RzfnEQ9iUPf4gszSGtZfDsirNqv6AY?=
 =?us-ascii?Q?+o+Vvaxe9WYWUg78itVRoHfoPLhuG0A59m0EioKWK7CL20qkCtR4wZSrBF0E?=
 =?us-ascii?Q?/iE2rs9NQU7gCNtPzp/3tpIjI3pv6ECQdmIgwu70YAdGd1F9q2HU2d+GUKXv?=
 =?us-ascii?Q?Xkvxmme4CjJLjly8I5MFYkrHdSXml6FwCoe7TlzNiif1x6Dbyh7IL5om55Xv?=
 =?us-ascii?Q?Fa1Kt+OeQCK8LWyqUP2pobuNfJPHY4NxXhNnJp2gVlBxouJBPcuGgpVBtbch?=
 =?us-ascii?Q?6AQQR6mjZoX8975AG1i5POnEFiWLwZOChBdBqBB3vWPsxmuH2mnN8CpKdYAz?=
 =?us-ascii?Q?uD8ui8FW6lUlyf5gA59qD4r6k1y1oqmDtjyFz5tHSVuZ8F1YdbEel9ALFO3i?=
 =?us-ascii?Q?HFPQf6lc57W6k/D5WUYT8xdFS/mMiCzQH8C6KwLoyt0uVUoL0m6UUYPQFYj9?=
 =?us-ascii?Q?OM7vtyRlsIP1+0kTN47HOBTUi4x1fmN7+TyCXTg34yfHRDekx8+//jccReA5?=
 =?us-ascii?Q?y10rVlO1Pkk5r/kk/oIHDSeEGSMOIHp+tJFK+dufdfysIt5ROB0Gyqbnqp35?=
 =?us-ascii?Q?v+6IGyjvf48VhBFr4TPy0L0X6JHSafZhLWQRkS+lkECJXuEn6WF64pQvKXvM?=
 =?us-ascii?Q?13YbGxDaNHUin6Po3bKeskzOaB4qctrka3CD2YvLxI86OnVQoXpcF+2T/fiO?=
 =?us-ascii?Q?frwhmaP5Yst3nip+gl4P560PBDn0W/ACWCeGLdtmTUggwU1TasAqlnwqU+K3?=
 =?us-ascii?Q?Ip9sG89mKQTI02S+kxtyF2OtZB7QlUZMt/X8uMBOZpbF1vteZf1oHnAeuSs7?=
 =?us-ascii?Q?ABtnrW0LL50JqLh9A9eXnEtU3YbnoAfgH91uY+r0PUHCi4d8LTQ8YDydPqUS?=
 =?us-ascii?Q?YYpaUXiuMTPhZdMExkzNVLK+6V50WSfgXZr6jj+4Vco+pEPLxOiKVVD71GwT?=
 =?us-ascii?Q?XzVkZC3AsZI7tdVFiuPy4Az5qVusYU81BL54OggZOsCsfiRCoHMUAFvc2ne0?=
 =?us-ascii?Q?KQ/NIAh6aoXJrsWsVRKm2SdZLJ4p0EYRR90yiJUdnNOLwt/+5tkzU1a4nf6E?=
 =?us-ascii?Q?8iQVf8DJo9FX+ODK/breFQ0pGyoE8G38zUSeC4E7YiZpQOx/rbYba6hdafFW?=
 =?us-ascii?Q?9w8YmCJ+bb1FnmoxLYrMmTxtFf+N8Eg/rJxntWUp3v4jm65I/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gDXhKaAOcvPL4gaNmjdLrc5YuGxzDPucs8NvnTujCgovXCB5WHRc4A7grLGf?=
 =?us-ascii?Q?Bj5nnsilzPBU31sKL2OJIW8+uxptudPle4GFvGQKpfDl7zC9lmJbX/y0rudk?=
 =?us-ascii?Q?RE99yX8M4VnUluivVNpSNFtA8Q9PC8CTNxPSjVDJ8VsH0M6mmiDrPvgmmEPj?=
 =?us-ascii?Q?jb69LYV386FckokFnR2tKgzg7plI+w0MafMIEKUEPLoaFDmIGb4sNEoQ03fv?=
 =?us-ascii?Q?UuQDNL+cDE2TAoZkNWwTxz3TXVWBELCyCouLgt63ogXQ0tY4e9dMn08vUJgx?=
 =?us-ascii?Q?2wmK936vuv46Eu1TZSGnDqOiyjNxWqITsNCIFJ+XjeTI9EM3EzjSuXZM1Hpr?=
 =?us-ascii?Q?0WwFfn3W0imH0VAYosnd0k81nicjozzx7pp08I9MB1KJLdlWP5mNQhJUTVIN?=
 =?us-ascii?Q?2y/iuhV/IuONmgv0rgNrArETl4Uh2WahPtMlLEGDoIq+eHhGvH9jE6nMrV9b?=
 =?us-ascii?Q?HnBKW+57i1Qm9NLl6GkGoIIKXS8TgdBokzSPqjOgHjXC8CD9HV1Oq6rx1fmY?=
 =?us-ascii?Q?lPPdNe5OLryRUlGOUYvNpZR6/50rA8tTM2Di+zlPij6OfUg/cFnduMmAKEPP?=
 =?us-ascii?Q?ba1urUOfoshjTHdZOZJlron0Z49IeTXs3bcWKBiqenAUF4cS02imnM5w3IzN?=
 =?us-ascii?Q?64KZHAMMT7gVXNID5vfukaPI7kbIEqKx7b2C7lH1thQP3pkFbyhPMyTwuvfS?=
 =?us-ascii?Q?xK/AAxxfRM+X28FctJJ356uhaiW4SyS3ioeaKDXJILQV4f7zzQBsekM6/UM8?=
 =?us-ascii?Q?WU81rnyWAitJrASEOJQPNvhqOGNN4Z6XoNaQYkSc5DhtJXodS+sQcfk2jNSm?=
 =?us-ascii?Q?5c+QXHtGFKa/CVJr7l+rmCdbRTfbOT2zaThIwmB/tBK13yiYFUVZ64B26utA?=
 =?us-ascii?Q?SarJROgnXQuTwZxEgqBaGL1k2S/k3nzqMFKnD0WFEHTyj82sXOJwht1lXNWd?=
 =?us-ascii?Q?hWFWHOWpMDSXwrg0oidL4yWB+2dh1eZRjO6UGQMvS/Fgl69g5RcsNFblCi2q?=
 =?us-ascii?Q?cDke10+a4yXH3zr/kVjpg71/lTS+PqaXIvbcwI0t7zRfvEW1CNfI7OiWfLuX?=
 =?us-ascii?Q?s+jxw+sVOu+qR2UTfZmKuFTPobQ0fiNwYviyOCqXGrHjI0o6pcd7ao8D44kk?=
 =?us-ascii?Q?uJX4tvXcUGbcyhdflZ19/i7zzdTeupLriWDxfVMY/35c8Ya2zQONRBYU0+lB?=
 =?us-ascii?Q?LJxwIBOWJDfk2PvBYeQZxEDsqaFnI0kh21e7AFUTJS++SGIK3vbXbkXZ1fZ2?=
 =?us-ascii?Q?1p59UQeRVZRPXGFsDrTOJYaT2vY3hpdXolGzkvcsyh8bjPIqiaLYmBvMT8M1?=
 =?us-ascii?Q?H3vlBnoKjPmLAYwhYzVnf1Nioimptb34icODN5GENryWM48EJkn+LQZf37Y2?=
 =?us-ascii?Q?wUpcHcEZ7mgCMDc6sADA0L/P3Pw9LcI+t+pijEg7lgenbEoI08UZSwzRnUoU?=
 =?us-ascii?Q?73cA9q/Vz85z5GpUG1baHlRumw99Ti+7MRsvK28rruDY6qN0koK44F+jL2UW?=
 =?us-ascii?Q?KIdsFpdjTL+aVNRRQgv7SnA4Y3QFZE6DZ3sgP0+Ff0XDkK20rCBhuPxiKbqw?=
 =?us-ascii?Q?NrW7aP5D0CWoNBvtsMzEjTU7ab7Mm5gFtv5EaTQ4DhGfxx23mbHumWoVTpHd?=
 =?us-ascii?Q?xGN2n6v3T3wIqXpwYP59ZTQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e628aa91-acfd-455b-49f9-08dcd789a097
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 02:28:48.9664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhOdnd0J/vDbF/+JKccToENz6mQ+RurkXhiicXGvWu4T1XeDUcmfHm70wCCI1QIxXSP0hc9w+/invH1Zu0ToffbxJQ20yXasUfp4/V/fBvOEmATK44z0nwjZ60UAt/zI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8628

Current comment for vruntime_eligible() is confusing.
Change "v" to "v0" to keep align with avg_vruntime_add():
        v0 := cfs_rq->min_vruntime

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 92f7cffe8860..9ed51ac2c16b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -714,11 +714,11 @@ static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
  *
  * lag_i >= 0 -> V >= v_i
  *
- *     \Sum (v_i - v)*w_i
- * V = ------------------ + v
+ *     \Sum (v_i - v0)*w_i
+ * V = ------------------ + v0
  *          \Sum w_i
  *
- * lag_i >= 0 -> \Sum (v_i - v)*w_i >= (v_i - v)*(\Sum w_i)
+ * lag_i >= 0 -> \Sum (v_i - v0)*w_i >= (v_i - v0)*(\Sum w_i)
  *
  * Note: using 'avg_vruntime() > se->vruntime' is inaccurate due
  *       to the loss in precision caused by the division.
-- 
2.40.1


