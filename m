Return-Path: <linux-kernel+bounces-245798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD31F92B978
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83415286A12
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422A0155A53;
	Tue,  9 Jul 2024 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Bd/KdBK4"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2089.outbound.protection.outlook.com [40.107.255.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C84B1EB2C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 12:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720528290; cv=fail; b=krOY8i3vCU5NkDamIFrLIs15g7Vv2UYEgOfPX7UohU0t/4+chCt2uHtW1dsbkvjSs3keYi739Tf3oS7Ah5drVYyKJoijSCh/+B91tANsmKhSJeu32Wh1g3YOgtnEj7b38OyKYOzihtBNjJ592aKbS9dMFddhip2BsV338eBPPZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720528290; c=relaxed/simple;
	bh=9LuoP6/IQiB4UBkChc2xtraxrXmRcQJyXxsw19ZNe0c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Myi79+3jXUwq7wci0cR9yUcpRaO5TomXosj4o9STuj4VaR7ip1VvEk8bAKG6XBL+XbFq6DY+H1YN6TCGUsL6K2ri5AIQpho3NpUScMeF83HvF1qgMjnnOTCz/oECA1uaciUDrYvbsBaK1w/c1arC2weVcund0dwlWS9BZl1zs+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Bd/KdBK4; arc=fail smtp.client-ip=40.107.255.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhFyGPyfzR8DuLrEMqqABVGh643+saDziSbEWhxUWl+ocEq+EBsH0xI42/TCi8a1+RiUulU+pgiBrQNRkrMof28ANKMh44iQzrsMSti4tg7pNGqHrnN68jtV3C3zChANAH3N0lnpDNWGUOEz3c6cMLEefCswr/blTnR8mdGLPct5rmz51/tqRk9L6fi+U6CBnC7gdqnUKRlUMroLAruZtYnSI5v1oH9zcxO8lXbu1NKf4gqtCZO38w5bBdr6FgKrnA/Dx6KV+9k+Ae6kxbOxN+zqshIlLHk5N3gnQHc3V2yWJ1rC+twCp9dlMoDMu99MVzdaXCgAiYkOkvOn/iGq9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBQYeZ+KKcOh0ASnvZAPiI6X7kMet71fI0cF5lRBkBg=;
 b=dHxRgo4S1lktSMlIDUmcN+/WKV5y67qg6LYOo1Dl6nj1O5rmspyJHEDH3D6d3Bb5uVVuYH4Evjaak9c58KiZLrqPSAH3qkxsDH141QulYvDRgPM2DCXnd8fEMXG9S5tnsTuBPGmOVXyq8ZlGnK7huoLd9+nDG/3nkmcEeEW7NUIwO74M5gEL0nG5Tm+V0TVinG2uurcUDzLxHZq3QvoZIAyzgz01AVjoIRSSfBR5YfejhwtnP18zcvi4RgjZw75eSfCPg4RvkUv8s0FlcHDdtIqh22KDToVO/3PAnCCYCxLQc+Vr/WLTIkb49Yhifqwj7+kgFc5K/3jJzU5dZD9/3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBQYeZ+KKcOh0ASnvZAPiI6X7kMet71fI0cF5lRBkBg=;
 b=Bd/KdBK4DMx5Afbp+4lFxaljop832DOmnVd0ChYJYLcxEzblsXxLDVZJBDgwV2jTo5Dlhr9VpUGXOoqZ3QnE6Mkh+r2+jOKMAQdB+CqRYDUWZXYRghwJmN1J40v851nR0qZe7vlQPQxg/SCOIi2VR3xMJfFbrvJSz9JA/0QAei6CAILmP3cn4FUPpg9VWuzkCYejZ029I+n8lKfDyqysdpnLK0QgaZABIx5pX0icDVYcGxOkDYmDRqjhOW7gU5cWPgkm9PfhvYmP4hXMT102e3EBe/OWRmJwu6HQBAq2/8eHIbzbg+kTEFVszevXVehQWoeVAbkiUfY2BzgEwTtaKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TYZPR06MB6546.apcprd06.prod.outlook.com (2603:1096:400:458::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Tue, 9 Jul
 2024 12:31:23 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 12:31:23 +0000
From: Zhiguo Jiang <justinjiang@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: opensource.kernel@vivo.com,
	Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH v7] mm: shrink skip folio mapped by an exiting process
Date: Tue,  9 Jul 2024 20:31:15 +0800
Message-ID: <20240709123115.117-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:4:197::16) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TYZPR06MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: 8172bbfd-dbed-42f3-a89e-08dca0130b45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NHcB8MDXSPojbZvMZzgxtgWVb8rwB4eQd2o6dqa37rBhD+QZr+5gOaYk8qNW?=
 =?us-ascii?Q?ht5AXvx0NxFLzNSJOhrP2E5PQROTnduEuHSYvSuhxkq9QCg5BFyO9uvGAbIX?=
 =?us-ascii?Q?P3BKRFpzuawgPVk6keprkfJQm0OCtMvAZ8oRMbfAbECP1uz0689BAsuCl9V6?=
 =?us-ascii?Q?53/tFpG9xaTSTDElkqMsJFM5qgCt+cRBQ4XwcB5I0G+sz6LJl5bDUn6zJYgi?=
 =?us-ascii?Q?w7mjIQgS2OT4GwML3wzn9gBvLAnAK/o3e21erXbcoqK3dTocDNiDxp+7O2UG?=
 =?us-ascii?Q?oPeDTmF/rjzCzljiLA0xRixpdq0H4M4haOKCcWb4dDI4J/t7/00jwfHaFtvA?=
 =?us-ascii?Q?wN1bOISOd22HN5t1oSP054NM+7QqKJBqMn2dwA5IPsUsZDPc5ELSe8+sg3Wr?=
 =?us-ascii?Q?ZG4kg3DyT8zBdy6w8KsmUCrk714Ym4zfvW8SMih7qRNgkqWhwOmQOaTOlT7W?=
 =?us-ascii?Q?G01Gbgzwkv3zY7JJ+oG/2ZsGQKRlj/kO/U/L61qFMwQqb8j6HHiQCwPH0NOW?=
 =?us-ascii?Q?+uBZXMdoyXo/WcPxWnBbQ3coFo76UIDXTUtokaMKrd1bOL16uKsc//G8eBzx?=
 =?us-ascii?Q?3kdL7FkM1DwZ4LxferCzpQNejMMa7SOuHVG6Ev3BKYFa+FC0eQd6NzBW4kSa?=
 =?us-ascii?Q?2zNlFmm0L99aG7VFaoY5ddUzwcbCCnaRD60QlW0zhI08qkhBwNaFs6YJ+wpZ?=
 =?us-ascii?Q?Qewlf+K7ArvBHSDKMFAroJcnOgBTopZolhhoAilbhpEnlZ00tJ9lT9EqssjL?=
 =?us-ascii?Q?uCjbo3yL1oVq4WjiDF/5PnB6utJXEtgavQFBoW7uTV8yymDn3lnpoSOwWRFg?=
 =?us-ascii?Q?h+SzVCOtZ0OpiyACbry8PGiWxNiFTO+bNzqJIQUTJNzw4HNUfuExyl0eZbmg?=
 =?us-ascii?Q?eitB5r9y0OdDb2PT0IqpG5rI9aOCIo6+E3aYGPOoHiYRPg1fUdsUbyOQp9yz?=
 =?us-ascii?Q?UuT7YueIzFu3gW4UWZV+lenbes+28LKxFWv4Ca6xyn8GzUhz195pr4PE0NEV?=
 =?us-ascii?Q?mTSSV74Lwvk3M3rJ+vpVmJw0/sHhGTsICtvf7Pscin5R1e9yle+Ph+7HxKgU?=
 =?us-ascii?Q?qq9VIoFYw7ilf3BrFvqc5Zq7l2opvFDloruyaSu/EqK9OzbAmchpXQ/yL+3c?=
 =?us-ascii?Q?iG7tjaYMCXxh776WAg+UjA+MQ7Fgs6floL18e1R0srpdCjsh4fNElfMd4RA3?=
 =?us-ascii?Q?hcqtTEBrETeWv+mlKUGGPzo1ePbJvCCEN+WZ3TPskoNrgXmTJZXZkF7Kh1lo?=
 =?us-ascii?Q?zq3nPkFXe/cK/l5PtmYkkWU50LQwBiF8PNMIcklpHjTcQJdFLmktCTMhiWGF?=
 =?us-ascii?Q?W2g4To0RqaywIubLpFzawpA1ODK18Duu83MFeXgj78Ey6FG52+IUadc+CspE?=
 =?us-ascii?Q?nUT65PI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YLhT8HpZBrXzNC2KsMRIVz3GaF5oa3rfRQI01o6BG3wNZNry3qkpAD/hcB+P?=
 =?us-ascii?Q?h4lcGHCWNk7iRTc95+OWqQScZt/mFjj/CFAJUaN1WuxoeWcPd+7xCgs7A7qg?=
 =?us-ascii?Q?lISidRWD6ifkocLzERq+qTTr3L3fw3hGBhWdlS3FOsReNX+Jdr9oPNtIZLcp?=
 =?us-ascii?Q?zhZ2yEi2ViKxTdokgh+o37SSzmo6MXFPkqzo1mixEsdVu+niMH6p5K0cnNv1?=
 =?us-ascii?Q?q18zE1UHglLPf1MD7extBtxBXwvRzou++LEy1ge2uqkPdvJhndgAZ87GuOeO?=
 =?us-ascii?Q?RfZcMAZzCZa4LfIUY9f9SKfuH2y2MQGhPQbzMusAmXe8Kczv9AikZPYoK2P4?=
 =?us-ascii?Q?8SEty4tX/Fz/3WpaKFoh8yE/nXdRjMQQuoCsMlZI9TfvV7pnZvCOTAZGlkDt?=
 =?us-ascii?Q?w7M+U4LKuub8dxZ8GHCW412h1wNKCqLN87A3UO8vAdOqcp3FbhJ3rT9Ta44C?=
 =?us-ascii?Q?Y3A21sKSbjoLMVtEU9W5LjvaBuKFhn9TwSItehQiwfgLjlECW+kI7CQ9aIrf?=
 =?us-ascii?Q?2KRaHf66eAxsHTX2TYWmxJ1S3YGJMiRCa7I4OdYnaRmJXZTfhXmjHZ3rCsfX?=
 =?us-ascii?Q?QJuaTBJj33NOtqv/w1ENqpN90HBx7DHlnv8KLyl5sgyZfGTCBR6pFR7a/JTg?=
 =?us-ascii?Q?ZA/ePw2RxH+G1dOt9Yq78QaZQavaDRPfkRL7cwtWQYlz272NVWPZq8rBrD93?=
 =?us-ascii?Q?uks4QyRNnya+Z9KGO1dmfhmmU0+eZvEQclB4wRRWeKvtICD5teKsqNpZwNBs?=
 =?us-ascii?Q?IScBdixjX9V/kd6paxHBEXRqCs3BXVundM2a3ZATsuEJTUPUD4ks4nwCaVyx?=
 =?us-ascii?Q?8xJD2r5a00SRkSHZJx7ZHtGSO5RfcqT9j107ICH3Kuq5zQWC0o51evXaYteR?=
 =?us-ascii?Q?ELDf+DYP/28A4xFw/aHSxAPruxM5Xd7DUBpCMH1wK6bjBYjAOsqYvNy/9DP4?=
 =?us-ascii?Q?J/h1h5XcvajwTNYsj9A5p6/hInCoIm0ZCGJmAjpXsLbalocN1vE2G2gIW2ju?=
 =?us-ascii?Q?Ul+32L8lpU4M06jmiJZJthIQ3Arv9jsfzILsCxUhEEZkhWdkNv4f3RUuaemf?=
 =?us-ascii?Q?6NRzRtrP8Z/F1YQ1fmjvw9Xm2cxSVYPbUzgTO1RJmpDnWUuo/cG++DrgYXlW?=
 =?us-ascii?Q?NLxwCbb13bhJ1rPouk6xWuet/hDRIUozQLSFdSAPb0kMWKMCy5wX50Pmvpq8?=
 =?us-ascii?Q?DNvoiuw00qduR1I177JN0dI+7wheuSynR2XNvHl8rxVTdpelaEL53BA2HegH?=
 =?us-ascii?Q?Bb5rEjkpv06Ycs8/9nx7r2EcMEYu7/mfN6HMDjWlvW+rIalQrvyo6GM8FXqS?=
 =?us-ascii?Q?YNIBA0loY9u2WY1V7AhcTTqhe1mf333/RRnEu5hbJxaYQLwb/3mKbyhCKtvk?=
 =?us-ascii?Q?Znvp99Q3QrGPYlMr4wYkJxH+PqWgPqXXnSWND6j4rOXZGCFs0sr08xACGFyr?=
 =?us-ascii?Q?ugt+B45LhZEOHrH0H0kST1WdxFvrtDkXE731p420g0OyRVJiirZkVECyUtxS?=
 =?us-ascii?Q?6p4FKl4m5Yx/bjGioGC8KoyK4yJ51P8XwJbvwSRkZEeTppTVp+evJiDBFsvJ?=
 =?us-ascii?Q?FxWVugjUwmCyF/zCKVowQbvLtqw66VeIqP9A1Min?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8172bbfd-dbed-42f3-a89e-08dca0130b45
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 12:31:23.4948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03u1lh/EEbKaDaXaPzMreotVb2ag6rcuUgbg3Xez4eW9cE/Q6rfvnc2hRLJRrW4NVDJMQ97LWYaCEI4cYyxOJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6546

The releasing process of the non-shared anonymous folio mapped solely by
an exiting process may go through two flows: 1) the anonymous folio is
firstly is swaped-out into swapspace and transformed into a swp_entry
in shrink_folio_list; 2) then the swp_entry is released in the process
exiting flow. This will result in the high cpu load of releasing a
non-shared anonymous folio mapped solely by an exiting process.

When the low system memory and the exiting process exist at the same
time, it will be likely to happen, because the non-shared anonymous
folio mapped solely by an exiting process may be reclaimed by
shrink_folio_list.

This patch is that shrink skips the non-shared anonymous folio solely
mapped by an exting process and this folio is only released directly in
the process exiting flow, which will save swap-out time and alleviate
the load of the process exiting. 

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---

Change log:
v6->v7:
1.Modify tab indentation to space indentation of the continuation
lines of the condition.
v5->v6:
1.Move folio_likely_mapped_shared() under the PTL.
2.Add check_stable_address_space() to replace MMF_OOM_SKIP.
3.Remove folio_test_anon(folio).
v4->v5:
1.Further modify to skip non-shared anonymous folio only.
2.Update comments for pra->referenced = -1.
v3->v4:
1.Modify to skip only the non-shared anonymous folio mapped solely
by an exiting process.
v2->v3:
Nothing.
v1->v2:
1.The VM_EXITING added in v1 patch is removed, because it will fail
to compile in 32-bit system.


Comments from participants and my responses:
[v6->v7]:
1.Matthew Wilcox <willy@infradead.org>
You told me you'd fix the indentation.  You cannot indent both the
continuation lines of the condition and the body of the if by one tab
each!
-->
Modify tab indentation to space indentation of the continuation
lines of the condition.

[v5->v6]:
1.David Hildenbrand <david@redhat.com>
I'm currently working on moving all folio_likely_mapped_shared() under
the PTL, where we are then sure that the folio is actually mapped by
this process (e.g., no concurrent unmapping poisslbe). Can we do the
same here directly? 
-->
You are right. we might use page_vma_mapped_walk_done() to bail out.
(Barry Song)

2.Barry Song <baohua@kernel.org>
By the way, I am not convinced that using test_bit(MMF_OOM_SKIP,
&vma->vm_mm->flags) is correct (I think it is wrong). And exit_mmap()
automatically has MMF_OOM_SKIP. What is the purpose of this check?
Is there a better way to determine if a process is an OOM target?
What about check_stable_address_space() ?
-->
Sorry, I overlook the situation with if (is_global_init(p)),
MMF_OOM_SKIP is indeed not suitable. It seems feasible for
check_stable_address_space() replacing MMF_OOM_SKIP.
check_stable_address_space() can indicate oom kill, and
!atomic_read(&vma->vm_mm->mm_users) can indicate the normal
process exiting. 

I also think we actually can remove "folio_test_anon(folio)".
-->
Yes, update in patch v6.

[v4->v5]:
1.Barry Song <baohua@kernel.org>
I don't think this is correct. folio_likely_mapped_shared() is almost
"correct" but not always.
Please explain why you set  pra->referenced =  -1. Please address all
comments before you send a new version.
-->
Update in patch v5.

2.Matthew Wilcox <willy@infradead.org>
How is the file folio similar?  File folios are never written to swap,
and they'll be written back from the page cache whenever the filesystem
decides it's a good time to do so.
-->
What do you mean is that the file folio will not have any relevant
identifier left in memory after it is reclamed in the shrink flow,
and it will not be released again during an exiting process? If that's
the case, I think we only need the anon folio is skipped here. 

[v3->v4]:
1.Barry Song <baohua@kernel.org>
This is clearly version 3, as you previously sent version 2, correct?
-->
Yes.

Could you please describe the specific impact on users, including user
experience and power consumption? How serious is this problem?
-->
At present, I do not have a suitable method to accurately measure the
optimization benefit datas of this modifications, but I believe it
theoretically has some benefits.
Launching large memory app (for example, starting the camera) in multiple
backend scenes may result in the high cpu load of the exiting processes. 

Applications?
-->
Yes, when system is low memory, it more likely to occur.

I'm not completely convinced this patch is correct, but it appears to be
heading in the right direction. Therefore, I expect to see new versions
rather than it being dead.
You changed the file mode to 755, which is incorrect.
-->
Solved.

Why use -1? Is this meant to simulate lock contention to keep the folio
without activating it? Please do have some comments to explain why.
I'm not convinced this change is appropriate for shared folios. It seems
more suitable for exclusive folios used solely by the exiting process.
-->
The skiped folios are FOLIOREF_KEEP and added into inactive lru, beacase
the folios will be freed soon in the exiting process flow.
Yes, the shared folios can not be simply skipped. I have made relevant
modifications in patch v4 and please help to further review.
https://lore.kernel.org/linux-mm/20240708031517.856-1-justinjiang@vivo.com/

2.David Hildenbrand <david@redhat.com>
but what if it is shared among multiple processes and only one of them
is exiting?
-->
Modify to skip only the non-shared anonymous folio mapped solely
by an exiting process in next version v4.

[v2->v3:]
Nothing.

[v1->v2]:
1.Matthew Wilcox <willy@infradead.org>
What testing have you done of this patch?  How often does it happen?
Are there particular workloads that benefit from this?  (I'm not sure
what "mutil backed-applications" are?)
And I do mean specifically of this patch, because to my eyes it
shouldn't even compile. Except on 32-bit where it'll say "warning:
integer constant out of range".
-->
Yes, I have tested. When the low system memory and the exiting process
exist at the same time, it will happen. This modification can alleviate
the load of the exiting process. 
"mutil backed-applications" means that there are a large number of
the backend applications in the system.
The VM_EXITING added in v1 patch is removed, because it will fail
to compile in 32-bit system.

 mm/rmap.c   | 14 ++++++++++++++
 mm/vmscan.c |  7 ++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 88156deb46a6..bb9954773cce 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -877,6 +877,20 @@ static bool folio_referenced_one(struct folio *folio,
 			continue;
 		}
 
+		/*
+		 * Skip the non-shared swapbacked folio mapped solely by
+		 * the exiting or OOM-reaped process. This avoids redundant
+		 * swap-out followed by an immediate unmap.
+		 */
+		if ((!atomic_read(&vma->vm_mm->mm_users) ||
+		    check_stable_address_space(vma->vm_mm)) &&
+		    folio_test_swapbacked(folio) &&
+		    !folio_likely_mapped_shared(folio)) {
+			pra->referenced = -1;
+			page_vma_mapped_walk_done(&pvmw);
+			return false;
+		}
+
 		if (pvmw.pte) {
 			if (lru_gen_enabled() &&
 			    pte_young(ptep_get(pvmw.pte))) {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 80f9a486cf27..1d5f78a3dbeb 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -863,7 +863,12 @@ static enum folio_references folio_check_references(struct folio *folio,
 	if (vm_flags & VM_LOCKED)
 		return FOLIOREF_ACTIVATE;
 
-	/* rmap lock contention: rotate */
+	/*
+	 * There are two cases to consider.
+	 * 1) Rmap lock contention: rotate.
+	 * 2) Skip the non-shared swapbacked folio mapped solely by
+	 *    the exiting or OOM-reaped process.
+	 */
 	if (referenced_ptes == -1)
 		return FOLIOREF_KEEP;
 
-- 
2.39.0


