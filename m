Return-Path: <linux-kernel+bounces-294114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40635958966
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB540283A17
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FEA190477;
	Tue, 20 Aug 2024 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="nYSyuu8Z"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2062.outbound.protection.outlook.com [40.107.255.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E58712E5B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164454; cv=fail; b=XYViu2ybcrcWKXKllBzv1+eWHmW+5NetR4GJGLynXfU+SfLnA/Bejg6BxZhnYb3c30Er4b+QOYfKNwhgEJlicM8NxzjcE1XW88SbYDzGkSN4GPRMhCs2n1RJY/S++AxYLRAjYLWI47tp4p2br47R5kh7kTrnFlehMzLV/YO6YGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164454; c=relaxed/simple;
	bh=EmWFuykWgLt1Zb7U+lJZd5xIUYWYV/UOWBNpTg9AEg4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AliUocrGI17W+91D7xlHR7J6AhTxFuCALv8QFoGkUEbo3rcnfVSWVqO8sgOBC42cfQuDcSj7ConYJtUf0peuwI5RkNZR9MxcPo7QKoUI5S5peU6TMfI3jkEbWzAVhzXRkvgkGr07bYeMWD2qw6enGcYqiCYi1kE9AtPNGPJgfyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=nYSyuu8Z; arc=fail smtp.client-ip=40.107.255.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=beSC8osAGkuUs5npTHJyC+ugSne7Oc3WL3JSaqYiRYV6jZ8miLWO3mbUzk4DNjZA8e8Io/gGSts3NqaBbaICQCMwNMOOw1/bjl/+q3GVixH5EEEqrV7EE4Ym32yBtwTJbL6L0DGCLOFommg+vE+Jooq8jknj2ng9h5pU0c4DJKkGqz0yEwyDGjFG8Xfo9CWzv3UV0pbnHnNZ7jnKiex/lH5qAvQwQuJtH0kRKyinyKsf+WJvvpWmwAgaTc2l8sL20E9it6QZC3O2yELc9JJgj6YhMEZZgVXbmouPR5gmTp4HwtPGMeh34jnvOebPNygV0Ika9VBlni6nYbgMcBTwrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8amlR0ISfgjw9nTTh8sFWiFDiBnEjI49OgX7OSyz9A=;
 b=MFueHqg6lLYTvbEtXiQ4TbMZr3tWoV/OUvVXNNIyCxrbnLasxnHm+iSEQDToe92oFPmo11vwEF7c758wawAg/Epx6KEMVWrFf6avmD5cOyevHFTZdboiivJU7KWSSXAFqALNy0bmaCyjzOzmMDfwY6ExVv4PyoH5ZnK9LTzT+QsN3mi3ovK5nGuN0RlggFNo3vtIK6AmPH90VtA0tXeWcsIibAfBHoB57jTR7x8RRodvSq6CmyJbzJF1ZBgxcqh73jnagMMcLr90aypJe/CtvBET72/XEc9Hi+Pru3qOUHMa3JhFaCmTRjk/Qjq95NIja1n6kELePzeOdXcTHuSGag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8amlR0ISfgjw9nTTh8sFWiFDiBnEjI49OgX7OSyz9A=;
 b=nYSyuu8ZXOEbYS2j+r+EjS2JHeG+H4tbK9bx6Z4fEY3EPZ+kKtUKRZCH20FsbfGnheOJ+NDYS/rMVR3N/2NKT1tx0552AXTUgfQx2i/Z77KGouh8d7XWn3J9jaF90LPAgxf7oUOnpT0MQa+C8p0B220RRjclNCxPpnoia8l8uiwCEpmbgH1db8m/94b14rXCVeL4shx+9BdDT2sqC6yHc+Fb8ZUl9giFj2a3ReelAMk55ceKnYi2vbM7i/S1h80kr8oKxz+SynA9k0K8aAQYhJyDtPlbu/GU2D2JkKj6xtp8BUDSQbaJlYlix/tZ9iztqFK1mCizz5EGvp8mBTNOFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TYZPR06MB5346.apcprd06.prod.outlook.com (2603:1096:400:1f1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 20 Aug
 2024 14:34:07 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 14:34:07 +0000
From: Zhiguo Jiang <justinjiang@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH] mm: vma remove the redundant avc binded with old folio
Date: Tue, 20 Aug 2024 22:33:59 +0800
Message-ID: <20240820143359.199-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0048.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::17)
 To JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TYZPR06MB5346:EE_
X-MS-Office365-Filtering-Correlation-Id: 51ef7233-33be-4130-968a-08dcc1252614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5+fMHezYFjqs9SCp4Ytp1n1tziBR+RgpySNdTdRTVpMWeedaMMhWkfujME0o?=
 =?us-ascii?Q?y9u8zZryM+EJFwJ76pgAUt7t3AtfLj+j6WJdSE6CjIZlgfmzOn6H9pr0NxpA?=
 =?us-ascii?Q?gufq0Ix9p7XQ9oNE6pX4V82lnYEyCL3CLInoduoQaT7t1F0qJF5tciB3hGrp?=
 =?us-ascii?Q?hccIqw2xE8UsNcJpf72oim6SXh/8EF7mn/w9Q3tiiycdC9DtmYA6M3jyZlDd?=
 =?us-ascii?Q?On9BRpZMEKZtd2qCD/WkjRFTE8B04FiQZdkU34pv0hD6BBMIrtxEBQ+/UK9b?=
 =?us-ascii?Q?AcEgGYDFsG5F8bpv8oHBlTkGzm4WmYp9TKUV60/xFzqJ9dvrB7TKDj4iT81a?=
 =?us-ascii?Q?Ml2WFxZGknOf3CALjohYYOfYIGRsYVIZnm8OSYJneaS0ubk+Dgyg4tCD/+eL?=
 =?us-ascii?Q?DhXq+/4uKfzUotThVWnMJIZcSMtl37NpXGff39Lv9MDAj9KNazn5bq+fGVuB?=
 =?us-ascii?Q?1r4gSFfrKDpZmTRBs3HJgNoKr1U7KKEnQxYWnUSaDesD4U7Mh+/hof6T/dE1?=
 =?us-ascii?Q?zFdXu1+dzaYAPKu/eXWAnw4JXHgccjq7ZZLNhlr32EpNnHqJFt76qIlhxchG?=
 =?us-ascii?Q?fE6X5Tgaf0piD5vIoFONlYMQb92aUBLV+mnt9+k/2ZLiVuzyOPUXz/QH/C+6?=
 =?us-ascii?Q?rBfWVo+SQsQtmIKdgD+bikrbnb3h0JcGsHGbaZBAlRHJFGAaDMDIGT3ED/ur?=
 =?us-ascii?Q?hldvc7Y3OvqW74HYEXiGx3qSIkzrnbGcRm4s40cBoDk2S/6PpXfBeK2vsiOu?=
 =?us-ascii?Q?ZkTEQMk1JqBoi2i44tDzZmYz1gRzyO1pYNXrDF/Nwy7ODuWwpzbg1c8bBmHB?=
 =?us-ascii?Q?bVW0YscbZq8sTKMcmWzKUc0q96qXnirhvL3Hu4ECqWkhkGTHZAfNOl7bCWkE?=
 =?us-ascii?Q?OFeCOVUonEiRL3imoXmAknHNmQEnfGJ3JoOYQYlJhFUmY4HyvreVqaU0q6IO?=
 =?us-ascii?Q?NpDIfKN78c64mlNTZqRn2y3BUfF4JMefE3jNwPtaE1gXkxgZ6fxjxZrO20Eu?=
 =?us-ascii?Q?qDViKzkYOSaDQV+Dl8TUqL0dlES3lK+e6+iOuvZlDqpisOTKYrNWgo5012aP?=
 =?us-ascii?Q?7AZQfAjRGBp+8EDhJa8fbLje4+/dphgCj8n9V9WjvFYqplvFZzNc7btcDjB0?=
 =?us-ascii?Q?F3SiuI8AmnB4lQbGtQuw3a/3YXdwM3E3aVWCzH+rDbhECSnSyiS3eLqBoH94?=
 =?us-ascii?Q?BNC/QxD2tDpZrRQJxsXsqTTaB5wcZNJ+9T7QHAj8lR8TefyEoSjJH2brZ6Jf?=
 =?us-ascii?Q?PDZ8dd2hBxjWeQ8azvTZpMyprrLHOP606QJrZXybTAW9KkwbLh1o1LV3Jekv?=
 =?us-ascii?Q?EEQqtUCEfAJCoRhKhmgGGsvke2mGFla3jBKLTudkG2464ae0F8OOk4niVCc3?=
 =?us-ascii?Q?CGmaur948G7OCN3JVe6A+P7F4rbU/pyYAqekUikMXgLovewbpw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LqLkEDjz4SMXeDZVVqSHfMNVb5P4s42LK+28t2jHOPzTQg7tgo9u+MGN9w5i?=
 =?us-ascii?Q?aUbDOBsFxtvRiz1oejLZy4JfY6hq2FCnTvUtLadMft5ad0smAMcDmmN09zPv?=
 =?us-ascii?Q?Y5YFMNLvOpFAhDMs6xCZXmf1kcY6MwbvP9p0H1ZmRpsW9drBF0HZ3G3J4Cm/?=
 =?us-ascii?Q?GoAuV89gR6reRmXQbwxvIZyGRidv1lIZ1TUcAsq+GNdQ/nqrvtJW5ubtOETr?=
 =?us-ascii?Q?QNCeuGmseeAznv59Z/ciYp62/MLvRYiYuvcFQGQh+y5u1G52/n4rQnwsyBsF?=
 =?us-ascii?Q?oqn/mwJqMyolfuMS8JeYT90aQXNmqqb+PITNlqFcvyiPh2R4J6usXO9XtNKA?=
 =?us-ascii?Q?twmrHg/oGjTC9sOz8cNhmioqr7RYwAxB3HTqak96Cy44dnV7+Lw2nOfjrAqv?=
 =?us-ascii?Q?NA0wYs+p0OMT4BE8jsUH8RHCav5qxCgr5J3Xhcil53TXYykkJSWDh8byRXZl?=
 =?us-ascii?Q?QZCr00wYG1Rs4gAZlurEEnIPTw9PB2TH+zs4qO8Hfnmc+R+z592VkQpVkqp0?=
 =?us-ascii?Q?Br2I8cWxidk8QaVwxHPi2iBLacF53df2GvhpHYm665cpnGo+FqdrqPG1SFkt?=
 =?us-ascii?Q?rd3+mnUIeugh03HIKhm1Cw1JAO1RZu4gwsyDfEwz19tRmBozMTZz2BpNdcIu?=
 =?us-ascii?Q?P4EGRapegPsPrwEnaEYaAi/gcbYnWaq+4kUwNqaemncNULlJlkxapTaH7keK?=
 =?us-ascii?Q?CRn5hevgRrwcPk2Y4DU6Ql60kycJA8cdAf9hT06HXfIBT+EbOm34WWY1NhKg?=
 =?us-ascii?Q?QUwtKjc/t2Qxw05Fr1eobLgrJRoAkGwa3AgeuaosPdPGk4fHK5cRBMC6mMnq?=
 =?us-ascii?Q?t3tTBDKKLGtPJ/ffcMMpIm8Tgbd645JvZI3iFBY8GJE1lC4zzJnHIZbr/3+b?=
 =?us-ascii?Q?p17xSlMVMySzZ6XmWr2hGKaKgnhDzIeMBzBX4KXwUQIdBOwPr+Pf399NRLoc?=
 =?us-ascii?Q?RKVbBMQE3vK9Ghhgxprh47FggfZyXMyK2PDRpaS28C79v2e6otFtLpkv8ngx?=
 =?us-ascii?Q?m/j6BrwmKQ0OpiNiF5DoVyp559sgh6P28A9ntcZQeMRNUrXsYWBcIEhQ7vvu?=
 =?us-ascii?Q?TNf2pDAD+Idxe0ueoHtn++MhzZPIYdB+cXgzb4Tq+YpYL5kBAiFPf1BjIfao?=
 =?us-ascii?Q?q0B62ag4RfAwLDl6LGUNbHSwZADwAUjHaj2TPUpd11k8dqc6efxc0EKHq6Zq?=
 =?us-ascii?Q?onl+Nv2qlErhhI8PWdCm8LSv5kJOJarK/2/etrJ+n5XHr/+LZxKxqP9Kbfm4?=
 =?us-ascii?Q?WHe5xzRskXhDP0NaqCsAMy7l5WaaNNDSLvzv9I4vwle4RUQtvZFb4/wluDtu?=
 =?us-ascii?Q?8362LBkRo8PtBdmaG4UHTRVWRwLZlliVEV1CjwNh/3areAfb4o6OYOehAHL6?=
 =?us-ascii?Q?3lcoSrF6SYtFk1VXxzccSXvlkbz5iWgsCx+UveifbKTxv+VEqCHNjAuVFWEe?=
 =?us-ascii?Q?EtSWuWQRu+Uard4TEivS4aIhSMeME2qdu4ohcZsiucCFBt6WihjqfC+OWE1x?=
 =?us-ascii?Q?wFCS12VE3D9+yJRlh5YyKemeW73MxP/Kp3xNrS9xm30cq1TkRpFxiHcr7SNJ?=
 =?us-ascii?Q?ZUSm5JA9Zh/mRuIaT9lh64qTCZOBOBIb30USPSdX?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ef7233-33be-4130-968a-08dcc1252614
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 14:34:07.7876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jsc2EdNc9Qi7LuN4trXnw2BZhThY551HzKENrHdd1z3QgYev8WozI3/ppimpyOa1DAkdaFu4IAWwLD85HDmXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5346

After do_wp_page, the vma established a new mapping relationship with
the new folio, and released the mapping relationship with the old folio.
However, the avc binding relationship between the vma and the anon_vma
in old folio still exists, and old folio can still traverse the
unrelated vma during rmap. This is incorrent and will increase the 
rmap redundant overhead.

This patch will remove the avc binding relationship between vma and
anon_vma in old folio, alleviating rmap overhead.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 include/linux/rmap.h |  1 +
 mm/memory.c          |  8 ++++++++
 mm/rmap.c            | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 91b5935e8485..8607d28a3146
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -257,6 +257,7 @@ void folio_remove_rmap_ptes(struct folio *, struct page *, int nr_pages,
 	folio_remove_rmap_ptes(folio, page, 1, vma)
 void folio_remove_rmap_pmd(struct folio *, struct page *,
 		struct vm_area_struct *);
+void folio_remove_anon_avc(struct folio *, struct vm_area_struct *);
 
 void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address, rmap_t flags);
diff --git a/mm/memory.c b/mm/memory.c
index 93c0c25433d0..4c89cb1cb73e
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3428,6 +3428,14 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 			 * old page will be flushed before it can be reused.
 			 */
 			folio_remove_rmap_pte(old_folio, vmf->page, vma);
+
+			/*
+			 * If the new_folio's anon_vma is different from the
+			 * old_folio's anon_vma, the avc binding relationship
+			 * between vma and the old_folio's anon_vma is removed,
+			 * avoiding rmap redundant overhead.
+			 */
+			folio_remove_anon_avc(old_folio, vma);
 		}
 
 		/* Free the old page.. */
diff --git a/mm/rmap.c b/mm/rmap.c
index 1103a536e474..0b9111c59dc2
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1522,6 +1522,46 @@ void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
 #endif
 }
 
+void folio_remove_anon_avc(struct folio *folio,
+		struct vm_area_struct *vma)
+{
+	struct anon_vma *anon_vma = folio_anon_vma(folio);
+	pgoff_t pgoff_start, pgoff_end;
+	struct anon_vma_chain *avc;
+
+	/*
+	 * Ensure that the vma's anon_vma and the folio's
+	 * anon_vma exist and are not the same.
+	 */
+	if (!folio_test_anon(folio) || unlikely(!anon_vma) ||
+	    anon_vma == vma->anon_vma)
+		return;
+
+	pgoff_start = folio_pgoff(folio);
+	pgoff_end = pgoff_start + folio_nr_pages(folio) - 1;
+
+	if (!anon_vma_trylock_write(anon_vma))
+		return;
+
+	anon_vma_interval_tree_foreach(avc, &anon_vma->rb_root,
+			pgoff_start, pgoff_end) {
+		/*
+		 * Find the avc associated with vma from the folio's
+		 * anon_vma and remove it.
+		 */
+		if (avc->vma == vma) {
+			list_del(&avc->same_vma);
+			anon_vma_interval_tree_remove(avc, &anon_vma->rb_root);
+
+			if (RB_EMPTY_ROOT(&anon_vma->rb_root.rb_root))
+				anon_vma->parent->num_children--;
+			anon_vma_chain_free(avc);
+			break;
+		}
+	}
+	anon_vma_unlock_write(anon_vma);
+}
+
 static __always_inline void __folio_remove_rmap(struct folio *folio,
 		struct page *page, int nr_pages, struct vm_area_struct *vma,
 		enum rmap_level level)
-- 
2.39.0


