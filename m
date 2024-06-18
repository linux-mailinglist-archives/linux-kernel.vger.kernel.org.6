Return-Path: <linux-kernel+bounces-218499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEF290C0BE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0713B215C8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E115672;
	Tue, 18 Jun 2024 00:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="KZd7JFj4"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2111.outbound.protection.outlook.com [40.107.244.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5A2DF5B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718671896; cv=fail; b=fz7qiMOS1+ESU26CikjBr8DmmAC30DRskvD3Pl4GswvxR6eozruzncj+8ZXsl5ryg+odM57aUwK+90+FTngGcZxsY0D2ShjXZsh68uKUmDoaK4dl7Ohund4VtOY2lZaABQMvU1UcOaGN8xmp78bC56nOTT9u9GyR1CTGLzQHH0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718671896; c=relaxed/simple;
	bh=fJuituEzTECseg+rzeofFj6lh6rzr6BDc2okSgJMTuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s5jIMxQ+l89Nsluvmnc3Q8A0zv43OokHVMOUncdz4YDtIok5x5IhzTItk8cnIUzcjKovzIXCLtLTsaw5ogCvIjxb9CIjuszKRgyAXLEfDuGeL0Rx3kqEEEw+V5jTI6dmbJVPYsm+tJrGOXEe0HY31JXEHlqcml3G0QCeeErTXok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=KZd7JFj4; arc=fail smtp.client-ip=40.107.244.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSf12xWvpjabCqldpbfKidgKoXbmFEqHMTZi0EHMIZMZuDvOrUWGj4VzVBd0xdznZVkBJInf05AlVOZHMNze4mQAu1Cps3qw9XRtO8421FjRAA6dm/yigtcpMC3sGjDdzAdt2cdxF3/8s4mrbQ81deL1aCIQ6R58n7+AEpTAADPYmKQCJXWHEXM/DCArc0QZ301Apfu0Csw02kSx/4j2CtL7kvkMeC1z5KWKQ8jv16h7C2rXE1nmQGhvVnE2VB895NYKmcvFX7u3VKJVH4EVU9c0EmZUU0ucsWDdhNRPLHP7hAVuqnYxmg+E1wxDizn6SHSPJvN+65L6sqYwgTvSPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sxc/nQHmPvo+ExHbbWQAPJrcukAcjBKpsaZsjAevwk4=;
 b=ix02j+NZ2m7OxN7Rsu12cUQo5bNANBmD/idsv3WLZujYQI77eXPYp9w+0KUrlyxNbVYV1pmP3ibD8uziob54clCnDC0O3PfA4/sEfuRhAgKmpwIK75AdRcvZ193hPt4vHWvcqX+KY0RfNa1Jc098KFsKlaI4KSGHC9OPZFcfZz5q0aIWSfpKQPMSPgkCYYOhiTPdTUkwe9s5IfE2n+2iymne27vcOjw4ApsrEJ+56X2z4btrNuep2ATNiNqCtiyg6Z8qJCUZHtxmsgC2YiHnXYbWHbUaBQSX2rbFrxlzNstg7eVKQC2tAglpz4js1pxuTYnYXGWX0f0YVUgip2QMhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sxc/nQHmPvo+ExHbbWQAPJrcukAcjBKpsaZsjAevwk4=;
 b=KZd7JFj4ysSlm72/DBCpNI8vErTrN3GQEIqxu0cygU9WNcmS2SKaTvnEXy9tPkF0bRBiRLEmobL6e2BdpzKxgQV0Q1dtEslOgkj87/dHYgHOnJh5NhaqDQQNN/V2R/NHYwCB+lo4e1NokwZyp/vqZsteXJEbJPijmPF0Hr+TMFs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 CYYPR01MB8410.prod.exchangelabs.com (2603:10b6:930:c9::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.30; Tue, 18 Jun 2024 00:51:32 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%3]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 00:51:32 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH v4 1/2] perf/arm-cmn: Decouple wp_config registers from filter group number
Date: Mon, 17 Jun 2024 17:50:55 -0700
Message-Id: <20240618005056.3092866-2-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240618005056.3092866-1-ilkka@os.amperecomputing.com>
References: <20240618005056.3092866-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:610:4e::35) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|CYYPR01MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: 336d5231-fd85-43cf-31c3-08dc8f30cbeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|376011|52116011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HdiAHWE3tzOSsJ+rhOqG3Tg4I1sDt6GFporPQt/W49PkFPx2utyXzhHqnVEz?=
 =?us-ascii?Q?QlQba9bd6Wm71BMxNZmsD0m9rNrsj0Wf1AsEF4v/J5kDdRtg96BePkDHEpfS?=
 =?us-ascii?Q?8UvgDw6sOqM6PcYfC7UBrXa/vBBFkN/cRoJqgPqa6sZn0cB7blg6egEYnxTV?=
 =?us-ascii?Q?Urc7a3HOts0KsCHlkOhnxhTQQUWi4lQlI5crcgEkM+sifLwgC8x8cVsjUoZY?=
 =?us-ascii?Q?QWiSz0PSa8UXZvzyXmDiNyQhixI1wlPWSJJWpDRhmn3EgyWPospM8VnS6wlT?=
 =?us-ascii?Q?hQELErqJNrBU/Yb6pUz18oNUqkgKAOEqgVbELVHyfvSUFXIcLR68BrmwmN7y?=
 =?us-ascii?Q?CwuGrpyHJYhQOnuCCWa5+SXg8J14NjV67DMIUpXynRiGXHUx1lTSm0sTNwMS?=
 =?us-ascii?Q?XaPA+Xa3BO9bfj3gNpiXb7J/gIQmValVpZHtXfIrLFOoXv2D8mt9/MVFMI/g?=
 =?us-ascii?Q?UnTUBh6sfHFPbGNicKkpEEH1XYBeaOWqejVXMYsJ3Kq44pWTMB3zNWtPXiVb?=
 =?us-ascii?Q?NOQnNGp+1THBak8FjTScexiAUF8WYo+E6YNw6CFmipdMJRBRoV1W82VjQtWO?=
 =?us-ascii?Q?hvapSUtpEjZfjE3POEicSMMelxdFVOJ465/lCTHPhLb1I02t+MpUmCYv+i1L?=
 =?us-ascii?Q?LndF9bHQwjpVsjisduVx7fmWZjTK9hpMQQc5KkdnAARm0DVjZ/FAPSuutZ5S?=
 =?us-ascii?Q?qI4C/vkJN/VYfCcVU2Py6rwNKIoml0PnnY3UUzHt1HGosMfPHPvWZgwIKcle?=
 =?us-ascii?Q?llUyVE/zpjDveKIF63jogyDZ6FBs0RnWdg5brjvHpBgZhR3ADZ4jmxt/KoWV?=
 =?us-ascii?Q?i434RuZ45No9m42mdSr+K0kO3WNGhPfe5kIzfBg7wyzKGhXT0NfhHnwN4xhl?=
 =?us-ascii?Q?B9TIcj5o2c59yQj9wePRsbGqu4UYkRUMXEUS134KR2HxBqSkzgpMhOey53WV?=
 =?us-ascii?Q?qH0tfFXeINga3ouJO1JVCySKE55lO1LE4hpup4IAUU74l1xH63bN1BXdjNAb?=
 =?us-ascii?Q?+x4odDEqm8z3rSEcKoZod8xescDUPmrzqBIKE3yZUOpnZi0T1wG549lpUZOX?=
 =?us-ascii?Q?aU6wBCILgo7qA25ycCvprYGfVtpHBlF9azMOonhVAC33Fr1wtrTOZik01h0g?=
 =?us-ascii?Q?JJ8913D4s5gJcRr/+tMUcjKHbJ0kJp7F7Elc+2OsGI1zQic7gbuyZ9BQ+Uud?=
 =?us-ascii?Q?nkeByctDd5R1ZxTC20HrejheNHa0muEa1JY1ZpHDNZ3fgiIMbmO4Xkine9sg?=
 =?us-ascii?Q?23aGGSXiCwg6ZsiX7m/14Y/WILnspg1NHkkv6V+PPMusWN6V8TWq3Y2OFT1P?=
 =?us-ascii?Q?6baO+z9594E5HNFVGKrqMu6XPi+G/xwGJwC01kHYQqoIro/oJM8iZkbG9+Sw?=
 =?us-ascii?Q?IwCDcwU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(52116011)(366013)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nxeeqYuMn3CRFtbbu+KN7gOcMM5EImuJKcwiOO/A1npcIV0IuSMxTyK+opzl?=
 =?us-ascii?Q?e+OrM7UdGp3Jv/7vvE8WhBKkRDJDQzrtkELu+b3Ed9jaNujxQxTwEUoCdc/W?=
 =?us-ascii?Q?tme4KzlGI0CShPE6rTlwAZWbbbq8uU9MdPdw0DaSwSWHyI34EN1CF9nRMx8w?=
 =?us-ascii?Q?GdYXBa8hoPSZ/axiNwsshi269s4sANRNM0SrrDPjN0kKufL+WhBeufR+1OMk?=
 =?us-ascii?Q?qtyQxdAPuBuPK6P4fH5SBitTVEJP/r7ac4rhBqXUHgsKLxyg0mFx4iKDxeIr?=
 =?us-ascii?Q?c2gFYHMKCrLbZudbZ7fESypWVHMeap4Twf316P2BUpnHaYMeoMzXkCrsvuSi?=
 =?us-ascii?Q?QacF7i6o9AQAMTP3Nk1KbtaIizNSkFNWtv1f4o0BAysQJs9bvnkBgbqUdcrU?=
 =?us-ascii?Q?XKN3Powl13wVo0/olV2KH8RaDP6P8HPXyvjQjSFHktQlTJiK+IVB3TOjoqw1?=
 =?us-ascii?Q?lb5t5n0UBdmebvlrMaUok1CzVf1dlG0oRLfrBOy/779vDKpHElg874HANRwo?=
 =?us-ascii?Q?GgzC3jSIeVV0rVCqvlni5sEds3Rob7ySAp7XL6OgGLW6WySy1pd7YkdsGV+K?=
 =?us-ascii?Q?af7Vz6GIajhjT6iD/AoVsCI6+UWL/UYFGTOjDIT9fG42JBduQgRPrhsQkVdJ?=
 =?us-ascii?Q?8xDpXQLn60306JkXxSaJ2zhAqqYjeKo9zjXesgBKVw3FiOgMhJ4U4IigpsKJ?=
 =?us-ascii?Q?raJQf0nh232j+y5LHwPPXWzf975/H/lOR7/8PAUoqjJEOSV/iaepLL5TEGJt?=
 =?us-ascii?Q?U87HwNzaxAO2Y7gziRs5hCyAHCK15WaljS6LY9JXfSXWsBwTk6TnhGUCHZ3u?=
 =?us-ascii?Q?3MVJdDBKUMkJFkOApBbdXw+WpNYctcvQ60Oz6RgUJ8Y8ucVNV082oM3mZNxf?=
 =?us-ascii?Q?TrPI+xHB7UQYkQPVYAT85D8jd1BKlAJrPT0SPIl8SxR/YrnKe7yI7gBKOjOq?=
 =?us-ascii?Q?zITRinehrFLZz8O2eT3JRN8GYZbv3Fvv6tvmAi8/3TkNPSFX5bODhfD6TpZg?=
 =?us-ascii?Q?JE3XyYmfdhKtP1ZwWOrNa16I/SGwIQoR48nFfpla0pKW+IQ1FzmXQx+HlFHZ?=
 =?us-ascii?Q?YyVHldiusI/q1t2Ur7aMLcZ/2kEM8vvpUHwbeyxiTKA8hcfpKJF5XBQsCus8?=
 =?us-ascii?Q?WALyI5QUul4rEaaBYVniowDSSMGBsNZeZgmp++Ue4yQ7PpK/tHKuc7qLrKE8?=
 =?us-ascii?Q?eLNj3ol7qbIAGJkFpIG+5UXZ7be+knV/SQPlk7V+8D5dnLwCQPUGh6kh8NnT?=
 =?us-ascii?Q?ppsnN8zhByrjTQtiWHEyvd1j8DttKdsIuLHNLfrT/zF1rakPd3zo0CkI3ajM?=
 =?us-ascii?Q?k4bksHZcLWCi2DQ3Jz6NbIBXO43n2mXn+gJN0fxUJzDOClE4QK1r1XnleXm3?=
 =?us-ascii?Q?BjOM5zo3H+iojKMvEFeLLsRDeTzyIwNV7Wc9irA3n/gE4zAji7Wd+V3fWqW8?=
 =?us-ascii?Q?Xn14BubgkdxKz0o4yd5Lm5qWUJgWY4S9ZmzGc/BX3O9Adxp8b71mTFe44k6p?=
 =?us-ascii?Q?GYZ7f76HVN5RpngHSdTbBjjNzEOCq2anTRbaOxlKMefTDKDkmfuItwi/KpUP?=
 =?us-ascii?Q?ShwjSZPiQgaO4ARaiWwrpfbR33VYxB85xVym70yvU+PXPaUh7J9LQqbzKL49?=
 =?us-ascii?Q?N2+dFq1K7wUcDazdhevCodI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 336d5231-fd85-43cf-31c3-08dc8f30cbeb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 00:51:32.3290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32rrMFQEMYfghgwMRtbs3rMHP0myWj6GS9hf0z1dZsmXveJnnOiOqQ85b7PHmOz2sJnlWrnEFDy4SYlHB+LnqMNfZZSO1De45bog+LDUrY5MIxIXKkzts6iOTxJ9IRLC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8410

Previously, wp_config0/2 registers were used for primary match group and
wp_config1/3 registers for secondary match group. In order to support
tertiary match group, this patch decouples the registers and the groups.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/perf/arm-cmn.c | 97 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 80 insertions(+), 17 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index e26ad1d3ed0b..f2349d23df57 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -590,6 +590,13 @@ struct arm_cmn_hw_event {
 	s8 dtc_idx[CMN_MAX_DTCS];
 	u8 num_dns;
 	u8 dtm_offset;
+
+	/*
+	 * WP config registers are divided to UP and DOWN events. We need to
+	 * keep to track only one of them.
+	 */
+	DECLARE_BITMAP(wp_idx, CMN_MAX_XPS);
+
 	bool wide_sel;
 	enum cmn_filter_select filter_sel;
 };
@@ -617,6 +624,17 @@ static unsigned int arm_cmn_get_index(u64 x[], unsigned int pos)
 	return (x[pos / 32] >> ((pos % 32) * 2)) & 3;
 }
 
+static void arm_cmn_set_wp_idx(unsigned long *wp_idx, unsigned int pos, bool val)
+{
+	if (val)
+		set_bit(pos, wp_idx);
+}
+
+static unsigned int arm_cmn_get_wp_idx(unsigned long *wp_idx, unsigned int pos)
+{
+	return test_bit(pos, wp_idx);
+}
+
 struct arm_cmn_event_attr {
 	struct device_attribute attr;
 	enum cmn_model model;
@@ -1336,9 +1354,34 @@ static const struct attribute_group *arm_cmn_attr_groups[] = {
 	NULL
 };
 
-static int arm_cmn_wp_idx(struct perf_event *event)
+static int arm_cmn_find_free_wp_idx(struct arm_cmn_dtm *dtm,
+				    struct perf_event *event)
+{
+	int wp_idx = CMN_EVENT_EVENTID(event);
+
+	if (dtm->wp_event[wp_idx] >= 0)
+		if (dtm->wp_event[++wp_idx] >= 0)
+			return -ENOSPC;
+
+	return wp_idx;
+}
+
+static int arm_cmn_get_assigned_wp_idx(struct perf_event *event,
+				       struct arm_cmn_hw_event *hw,
+				       unsigned int pos)
 {
-	return CMN_EVENT_EVENTID(event) + CMN_EVENT_WP_GRP(event);
+	return CMN_EVENT_EVENTID(event) + arm_cmn_get_wp_idx(hw->wp_idx, pos);
+}
+
+static void arm_cmn_claim_wp_idx(struct arm_cmn_dtm *dtm,
+				 struct perf_event *event,
+				 unsigned int dtc, int wp_idx,
+				 unsigned int pos)
+{
+	struct arm_cmn_hw_event *hw = to_cmn_hw(event);
+
+	dtm->wp_event[wp_idx] = hw->dtc_idx[dtc];
+	arm_cmn_set_wp_idx(hw->wp_idx, pos, wp_idx - CMN_EVENT_EVENTID(event));
 }
 
 static u32 arm_cmn_wp_config(struct perf_event *event)
@@ -1520,12 +1563,12 @@ static void arm_cmn_event_start(struct perf_event *event, int flags)
 		writeq_relaxed(CMN_CC_INIT, cmn->dtc[i].base + CMN_DT_PMCCNTR);
 		cmn->dtc[i].cc_active = true;
 	} else if (type == CMN_TYPE_WP) {
-		int wp_idx = arm_cmn_wp_idx(event);
 		u64 val = CMN_EVENT_WP_VAL(event);
 		u64 mask = CMN_EVENT_WP_MASK(event);
 
 		for_each_hw_dn(hw, dn, i) {
 			void __iomem *base = dn->pmu_base + CMN_DTM_OFFSET(hw->dtm_offset);
+			int wp_idx = arm_cmn_get_assigned_wp_idx(event, hw, i);
 
 			writeq_relaxed(val, base + CMN_DTM_WPn_VAL(wp_idx));
 			writeq_relaxed(mask, base + CMN_DTM_WPn_MASK(wp_idx));
@@ -1550,10 +1593,9 @@ static void arm_cmn_event_stop(struct perf_event *event, int flags)
 		i = hw->dtc_idx[0];
 		cmn->dtc[i].cc_active = false;
 	} else if (type == CMN_TYPE_WP) {
-		int wp_idx = arm_cmn_wp_idx(event);
-
 		for_each_hw_dn(hw, dn, i) {
 			void __iomem *base = dn->pmu_base + CMN_DTM_OFFSET(hw->dtm_offset);
+			int wp_idx = arm_cmn_get_assigned_wp_idx(event, hw, i);
 
 			writeq_relaxed(0, base + CMN_DTM_WPn_MASK(wp_idx));
 			writeq_relaxed(~0ULL, base + CMN_DTM_WPn_VAL(wp_idx));
@@ -1571,10 +1613,23 @@ struct arm_cmn_val {
 	u8 dtm_count[CMN_MAX_DTMS];
 	u8 occupid[CMN_MAX_DTMS][SEL_MAX];
 	u8 wp[CMN_MAX_DTMS][4];
+	u8 wp_combine[CMN_MAX_DTMS][2];
 	int dtc_count[CMN_MAX_DTCS];
 	bool cycles;
 };
 
+static int arm_cmn_val_find_free_wp_config(struct perf_event *event,
+					  struct arm_cmn_val *val, int dtm)
+{
+	int wp_idx = CMN_EVENT_EVENTID(event);
+
+	if (val->wp[dtm][wp_idx])
+		if (val->wp[dtm][++wp_idx])
+			return -ENOSPC;
+
+	return wp_idx;
+}
+
 static void arm_cmn_val_add_event(struct arm_cmn *cmn, struct arm_cmn_val *val,
 				  struct perf_event *event)
 {
@@ -1606,8 +1661,9 @@ static void arm_cmn_val_add_event(struct arm_cmn *cmn, struct arm_cmn_val *val,
 		if (type != CMN_TYPE_WP)
 			continue;
 
-		wp_idx = arm_cmn_wp_idx(event);
-		val->wp[dtm][wp_idx] = CMN_EVENT_WP_COMBINE(event) + 1;
+		wp_idx = arm_cmn_val_find_free_wp_config(event, val, dtm);
+		val->wp[dtm][wp_idx] = 1;
+		val->wp_combine[dtm][wp_idx >> 1] += !!CMN_EVENT_WP_COMBINE(event);
 	}
 }
 
@@ -1631,6 +1687,7 @@ static int arm_cmn_validate_group(struct arm_cmn *cmn, struct perf_event *event)
 		return -ENOMEM;
 
 	arm_cmn_val_add_event(cmn, val, leader);
+
 	for_each_sibling_event(sibling, leader)
 		arm_cmn_val_add_event(cmn, val, sibling);
 
@@ -1645,7 +1702,7 @@ static int arm_cmn_validate_group(struct arm_cmn *cmn, struct perf_event *event)
 			goto done;
 
 	for_each_hw_dn(hw, dn, i) {
-		int wp_idx, wp_cmb, dtm = dn->dtm, sel = hw->filter_sel;
+		int wp_idx, dtm = dn->dtm, sel = hw->filter_sel;
 
 		if (val->dtm_count[dtm] == CMN_DTM_NUM_COUNTERS)
 			goto done;
@@ -1657,12 +1714,12 @@ static int arm_cmn_validate_group(struct arm_cmn *cmn, struct perf_event *event)
 		if (type != CMN_TYPE_WP)
 			continue;
 
-		wp_idx = arm_cmn_wp_idx(event);
-		if (val->wp[dtm][wp_idx])
+		wp_idx = arm_cmn_val_find_free_wp_config(event, val, dtm);
+		if (wp_idx < 0)
 			goto done;
 
-		wp_cmb = val->wp[dtm][wp_idx ^ 1];
-		if (wp_cmb && wp_cmb != CMN_EVENT_WP_COMBINE(event) + 1)
+		if (wp_idx & 1 &&
+		    val->wp_combine[dtm][wp_idx >> 1] != !!CMN_EVENT_WP_COMBINE(event))
 			goto done;
 	}
 
@@ -1773,8 +1830,11 @@ static void arm_cmn_event_clear(struct arm_cmn *cmn, struct perf_event *event,
 		struct arm_cmn_dtm *dtm = &cmn->dtms[hw->dn[i].dtm] + hw->dtm_offset;
 		unsigned int dtm_idx = arm_cmn_get_index(hw->dtm_idx, i);
 
-		if (type == CMN_TYPE_WP)
-			dtm->wp_event[arm_cmn_wp_idx(event)] = -1;
+		if (type == CMN_TYPE_WP) {
+			int wp_idx = arm_cmn_get_assigned_wp_idx(event, hw, i);
+
+			dtm->wp_event[wp_idx] = -1;
+		}
 
 		if (hw->filter_sel > SEL_NONE)
 			hw->dn[i].occupid[hw->filter_sel].count--;
@@ -1783,6 +1843,7 @@ static void arm_cmn_event_clear(struct arm_cmn *cmn, struct perf_event *event,
 		writel_relaxed(dtm->pmu_config_low, dtm->base + CMN_DTM_PMU_CONFIG);
 	}
 	memset(hw->dtm_idx, 0, sizeof(hw->dtm_idx));
+	memset(hw->wp_idx, 0, sizeof(hw->wp_idx));
 
 	for_each_hw_dtc_idx(hw, j, idx)
 		cmn->dtc[j].counters[idx] = NULL;
@@ -1836,10 +1897,11 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
 		if (type == CMN_TYPE_XP) {
 			input_sel = CMN__PMEVCNT0_INPUT_SEL_XP + dtm_idx;
 		} else if (type == CMN_TYPE_WP) {
-			int tmp, wp_idx = arm_cmn_wp_idx(event);
+			int tmp, wp_idx;
 			u32 cfg = arm_cmn_wp_config(event);
 
-			if (dtm->wp_event[wp_idx] >= 0)
+			wp_idx = arm_cmn_find_free_wp_idx(dtm, event);
+			if (wp_idx < 0)
 				goto free_dtms;
 
 			tmp = dtm->wp_event[wp_idx ^ 1];
@@ -1848,7 +1910,8 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
 				goto free_dtms;
 
 			input_sel = CMN__PMEVCNT0_INPUT_SEL_WP + wp_idx;
-			dtm->wp_event[wp_idx] = hw->dtc_idx[d];
+
+			arm_cmn_claim_wp_idx(dtm, event, d, wp_idx, i);
 			writel_relaxed(cfg, dtm->base + CMN_DTM_WPn_CONFIG(wp_idx));
 		} else {
 			struct arm_cmn_nodeid nid = arm_cmn_nid(cmn, dn->id);
-- 
2.40.1


