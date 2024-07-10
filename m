Return-Path: <linux-kernel+bounces-247255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C5E92CD2F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A40286B04
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD5A12D74E;
	Wed, 10 Jul 2024 08:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="noEG4sBb"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2070.outbound.protection.outlook.com [40.107.117.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A5A12C81F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720600615; cv=fail; b=E74RnvKHp/8tpBQFRWtiDh5ATO/or9YYjkv26FSuTan/Nd6YFEFrlXdO5bnJJoXGD9e6sceA03dXbDqyGQBwHRSI67RyADZpoZX7CeJuzcrmSYmy5X7++R/sYywe6x3vyB4ckt4RipjBUaUYCp3mkENW/Ktpbm7kOVjSx91xALo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720600615; c=relaxed/simple;
	bh=aBYQ37obFAQEnam1B3hLadBhr71ILfaDbZ/0kO848+0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aYpMQlhe4lZ3f4du1PL89D2gLti3TJ1pM9jdtNKhYv+gD01qsR4Q4m2MlYgxofCPdt51wlSxA+by9hXBme8hly5NbnBD2YNc7sGFF/i5PL78In+BbPGt/rn2Uy6w7wu75G7LmbkA0ITSerYh3SlDfPjKJfXGXDwps9uBt7U3j+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=noEG4sBb; arc=fail smtp.client-ip=40.107.117.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhTCsfHdkIT91NgVkTih7c6rkmVDPGAUB9393Eb/OsXlULlFNOkOTpELQqsxIoOYfKmUMGh7cgc/DqY3plVd1dKwa/JO73OwmnVA6gQbqPlwJ8WaWjpLbzDgmx7uKfhVOZImxm1g6TolqVEaNQRzwvsxbFJfA1YrgO/s8fhxV3CTBKo/SI8xbLpzPiV8eTgYZEjPgLXq1tea4HV/E9dbqzFV8VCvFb9tr8pN39458ZiCVBsk04fO1UwKeh59WLx+b+q7naUfnMMWBSGIP690VNSad1IDNdrl+MNCiW4mD+T2WJCM3XzoIBXlLeoc13SaJbcle3Dv7VUsCBZie6tp3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErDNvj0HDvbg1Qm9rfp1tR/SZOARCOdDKlwtcRepnjQ=;
 b=lMdx8EJx1VSRdFp8b0KxzDp/tEljrRjCIjDYLFugg6ESf8b/Z9AY/hmB9HcrkPpOjqvSeLfULctbE4DXD2P0K+ggf7e96n5rBN7tsNgAl3LjkgTLxb++xqoPnd6y1GeH5U5eVBBlcf6H36wJRwdi1S8g5MBaDuQCL7FaPBKtZcwtJ29cPp2NOdCAdoFHWJYVpTR6vNsV+TIwOvM+g5nY6I+AerOMmDwnnqPD5pymMPNz5N6DKB/4MQn7zUzuvfOXpEvXsQ7ueTaplRUqWZzyCZrhx9VYJ7O+GBVIqhGdmE0zOtFbLnj3v5wd7oNVYa2ePWg1lS0WFXK8TFCSwj0yUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErDNvj0HDvbg1Qm9rfp1tR/SZOARCOdDKlwtcRepnjQ=;
 b=noEG4sBbmAwavGZfymW6TuNrcmb9bFTV4RUhZ37OIk+VkwCmImIh4RVX6/XZjEpZ388auTFZsZW18QUs/SSghW70WqPfAkpRWyLnwKdCGR0DYk0oMUwCST2B/44ehBmjp7tMNZaIe0yFZv6jpNFWYkDCGBxN7aR2at1rLhC0xFCzQMkTKhpE3/aQftruZEGFCEnTOLbl9n7rqTHVGnE7mvRNLAC3RA00zughZi6trFjGfmxeaT7si4KFx3K62iQzTQeNjmsFZaVH4lJizzM9RcVFFMJjZhvAiZ/B7K2JwYnGi9C6PamtFaEb6BIDoWLDwb+awRNT9JyH5DhDsy65OA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEYPR06MB5792.apcprd06.prod.outlook.com (2603:1096:101:b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 10 Jul
 2024 08:36:50 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 08:36:50 +0000
From: Zhiguo Jiang <justinjiang@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: opensource.kernel@vivo.com,
	Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH v10] mm: shrink skip folio mapped by an exiting process
Date: Wed, 10 Jul 2024 16:36:41 +0800
Message-ID: <20240710083641.546-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::13) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEYPR06MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: ede492a5-59b3-4b80-7fee-08dca0bb713a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+ygJ3iWGnq5aM8R2aqGyQb0IyhwpupSVc0tvNNTHxmoU0ouW7LRVKzw4VezD?=
 =?us-ascii?Q?ynvq3iNo03WPY0PA+BUQQlYUbbzGt/E+j720iFHDjHZHEnI1O4aEAs1f0bME?=
 =?us-ascii?Q?Jha73TC2M3M3Ip++7UE9kzsqCLIKJ9kgy2saFhWux0KbgjIWu5bCtNdNJQSO?=
 =?us-ascii?Q?2lB2E+qqDVSiH75swbKbvrarWEDAqkgDshc/oa2Bzast7mYHc5WXsBl7NGAD?=
 =?us-ascii?Q?41zkgg3d2j/S03MiZ1v0xTxvDE96NcNUsTBb+DRGFP000FpU8N7dJFjLN3v2?=
 =?us-ascii?Q?EP8+D4M9izoz5dtJMRIlsqYO2GgxijDV8lGXYK5rIzH/tSUTPJ9TU5ZXPk8z?=
 =?us-ascii?Q?bFsrZt+qmv1klx8zspP5pZomBJf6rCv26lDVQxEkrpDXI5pMQlwOGNfCD3mf?=
 =?us-ascii?Q?Xe/+MrRd0iSdANbq/lImqJY+u1GjjHcbnhuTJM4imOwqdsmYFn7bYnyirb22?=
 =?us-ascii?Q?quPy9v3TqCRBCDAC5vQRD7Sdb+R02+fXwIVUbtUf8X6rcZtczlGpZIFf68qw?=
 =?us-ascii?Q?Ibr3igQlw8iVSpb5B6ZZbn0h4azoAEFA345vpxqJe1xUabYwcFuIs0MGSwJX?=
 =?us-ascii?Q?a2J3LiiRZ7JNoHhGSNXAunTnAzZzJZUhIWljz+77nJ8zuwQFMgiZ4sVsfmcq?=
 =?us-ascii?Q?wLogq7pQjZXj0DOgP00+pawVrSm0WkEqNeQYxeeectMmaF/cPwNBXlJBPX2+?=
 =?us-ascii?Q?0ioZcEH5xcp8W8Jnz2X+qsDSmpwZ2Xurv8Zx0dDPOPp7m6lQLAXBiICc1Pnw?=
 =?us-ascii?Q?fmrlfr8tAqfYqZAx7JBPFgZLgF5A0ITPFHxG/JHLStV6qpwHZPy/WmxdOGoR?=
 =?us-ascii?Q?5X37dtZToz/UCPVt1xgV/0N8q8UfbKzwPiNY2yWEq+D9lsbrMSBOUTFb/xMC?=
 =?us-ascii?Q?MyKRN8RztEJk9LzodA+kOGqQ2+e5o1fda9KYunnZMsR3qfvUfUpRYmcdsYVi?=
 =?us-ascii?Q?C3xmEdkuonlWh+2BxIRdd/QD8LIavBdbMA9HJiwkcwunV4uLLXi31P6yXO9N?=
 =?us-ascii?Q?xDytjUs41EfQkXKFY0RNFDnf8FFGgOnWXg6rEKSy/R5F/EDJRBp6tlBGrXqq?=
 =?us-ascii?Q?r7eoxTqSeBGGrjYg+UxfGbyKy/DGqgQrz8Ae6OMdQ+JRHmOFxR4pQVNic8t/?=
 =?us-ascii?Q?Lk/37S5qGaysAG69+oM7fqekI5CTGhGoV5M5XdSWMtUYq43+grJ2k4uVkQKX?=
 =?us-ascii?Q?jPDeJXteGcwKD9RCmNKl7fl9wxdtoPwDEhprZdRT98GWaVFcpJY1FHzSa9K+?=
 =?us-ascii?Q?AJwaidW++Lk3ZraQPBy2azDTQ+u+nE7u0rFfFfAOGFz5OpVylmx9MDCcPnxi?=
 =?us-ascii?Q?lDcR11RZDnKI7bMK7fh8TAAyvsepg3XKZlWtUbaEgl4WjbjeRihsiY34B7zX?=
 =?us-ascii?Q?F8yFrTo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OKdvZI4AvKCGtjmkD0cqbjaevRSxqBNtcvlflfFDruKnIm1/r//LB25qgkFp?=
 =?us-ascii?Q?on7rlK5oFPwz2XJpzFYXD9gU7C6ENTJ2lQNYceSBezucpsuHS+tJpRx958LY?=
 =?us-ascii?Q?EJAPuVQI/RTBR1KBC3nz305q3ZMV1iPqSlx/kwz4vzYk6kHKqgWW+o+j0/k8?=
 =?us-ascii?Q?ZrVQCXts55TlrE0lxZwBRi+uQVouxHYSCxAUJE7+9zarM0YEap9HV23Ura4G?=
 =?us-ascii?Q?Qu6UGf6IVGRZ1/EheKmQrbfyxb8oTuu9/4HtHvqjHqZveB/VgFnix2Xd0bLn?=
 =?us-ascii?Q?6ZpKJRUto5Wn+BkSRJ6N43cKpaXSOUTNsdqUXMCqV3IiOhLeLhhThHSvu8SS?=
 =?us-ascii?Q?/3+mwQR8bz6hPTJY8MXxKagoBsKqomC7Bu65jnO9RpQsN8VZOdaA+z3XtcBL?=
 =?us-ascii?Q?Y+pb6npdvOcDdPUSgKa2WKbTCv2RXGzu/yOPN91/73Axeh2/tp5kGFnJczqb?=
 =?us-ascii?Q?wGptLziXtUa7MRooP7Z+BLJBMjV1B3lRsZUxQFDTkvbhjYl88SkeYqytSDrv?=
 =?us-ascii?Q?kw0CWVySEWbbrAnvypGaF7sS63nnyCVddgi4QvSLMcgNpUjcC6/A85H5AaTa?=
 =?us-ascii?Q?WqnKgHwfmD8NK/crKu7KFC6evawyMrCliCozUOAbOAGqO/dr3beJoXExYVM+?=
 =?us-ascii?Q?dfyGA+qF499kWee56ouElqFejPm7hxQQlvN2/uRL5q6PJhyy7+t+pCje2oxw?=
 =?us-ascii?Q?eApAKblX4+SSMLEBOq4bv3GeqJIbsElYAbnzCEMN7/wdP4ydYlUTkNyOEnj6?=
 =?us-ascii?Q?5HuORKuW0XqDZaPPT5WjKLgOszSMLwDC30aQRM9t5H8T4iR08hbMpp1qc04b?=
 =?us-ascii?Q?iC2MgsjIsXwDeH5zo+D1QMtH/sEG5tcaIck7R3lKws1CSzitGIIHce2pVXM3?=
 =?us-ascii?Q?7h61OTu8y+5s4gAK6w7IyA6XFeI2xnZqx0O7B+dujZW2s75bNoMMJJBD/Q50?=
 =?us-ascii?Q?ko7jcklwDE6/lMqrZaMIVTkq4mUxQb3WCYWMqm+P6dwBus66eqIkq33D/QcU?=
 =?us-ascii?Q?gs9WQ/7FG7oJfnFxQGZdz9VHPF3LckBxttI95KMmVgRvZgk1SeW5SWoCLrFG?=
 =?us-ascii?Q?xJPfJoDERcUEWNS3BgO2z4n3kr5GbZ7ZTHwMvQ5jYJoN3IZSi2mZ9kAm/xlr?=
 =?us-ascii?Q?gbKa9VVKDoMxl6UkNfJkgB/RgFnGN7VpF1wF9LzSVuo6B5WsAYwZV2BPUgNj?=
 =?us-ascii?Q?NORo97SNhnvACSexxGzTOfSUty8v2S5iC9J4eH1M/yFQp45nmzldQsKAB+2y?=
 =?us-ascii?Q?woW1qndN4lm5DnnSF6re/HSt2NpkHR3Jmu2WNmS8mEJsvYijgyRkxlDM62Gw?=
 =?us-ascii?Q?vr3tMe+NOmDZzlcQ+adLV2C9BYQVKDU9O+Dv69Moa+euRwGrUSeUC7VMDqCN?=
 =?us-ascii?Q?16rZYdKoiUda3OZSfz+Y/aHpii2JuOgZR153WJORj2E76QJoJHovfGQGuP8P?=
 =?us-ascii?Q?cLvy5qDnm4CAxdNOoszJ4OO5MiAyFNNBRpuECIU8ya/pM2vtPqvrym53otZk?=
 =?us-ascii?Q?wUdtnnjbBFS8IYSDNR7Ey8acO2mMPahThuKUfGphJntKaaHQ3EsrPMznM4Oc?=
 =?us-ascii?Q?UQ2obxLMUA44LEko1onZ0UyyLotbg3pIBZ5qCR8Y?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ede492a5-59b3-4b80-7fee-08dca0bb713a
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 08:36:49.9994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jWxg5veRD/791fSHWYwJL6qft+GLZWxg4pPQAI2yvLrD9K8+8tObJxLAnZ6nJGRC0p7LAr9dbPFsY4tcbxAubw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5792

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

Acked-by: Barry Song <baohua@kernel.org>
Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---

Change log:
v9->v10:
1.Add folio_test_anon(folio) condition.
v8->v9:
1.Update Reviewed-by tag information.
v7->v8:
1.Add tags of Reviewed-by and Acked-by.
2.Add #include <linux/oom.h> to solve compilation issue.
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
[v9->v10]:
1.David Hildenbrand <david@redhat.com> && Barry Song <baohua@kernel.org>
BTW, we dropped the folio_test_anon() check, but what about shmem? They
also do __folio_set_swapbacked()?
Even though anon_shmem behaves similarly to anonymous memory when
releasing memory, it doesn't seem worth the added complexity?
-->
Take folio_test_anon() back.

[v8->v9]:
1.Barry Song <baohua@kernel.org>
No, this is a disaster. Please ask someone for help before you send it.
Neither Willy nor David has ever posted any Reviewed-by tags.
Please do get someone to help you. Stop posting like this!
-->
Update Reviewed-by tag information in v9.

[v7->v8]:
1.Barry Song <baohua@kernel.org>
You should have collected tags such as reviewed-by, acked-by you got in
v6 while sending v7.
-->
Added in patch v8.

You didn't even pass the compilation stage because you're missing
'linux/oom.h'. It's quite disappointing because I believe in your idea,
but you didn't even build it before sending.
-->
Sorry, I overlooked the compilation of folio_likely_mapped_shared() added
in patch v5. Compiled and Updated have been compeleted in patch v8.

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

 mm/rmap.c   | 15 +++++++++++++++
 mm/vmscan.c |  7 ++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 86787df6e212..316a6bb9747b 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -75,6 +75,7 @@
 #include <linux/memremap.h>
 #include <linux/userfaultfd_k.h>
 #include <linux/mm_inline.h>
+#include <linux/oom.h>
 
 #include <asm/tlbflush.h>
 
@@ -870,6 +871,20 @@ static bool folio_referenced_one(struct folio *folio,
 			continue;
 		}
 
+		/*
+		 * Skip the non-shared swapbacked folio mapped solely by
+		 * the exiting or OOM-reaped process. This avoids redundant
+		 * swap-out followed by an immediate unmap.
+		 */
+		if ((!atomic_read(&vma->vm_mm->mm_users) ||
+		    check_stable_address_space(vma->vm_mm)) &&
+		    folio_test_anon(folio) && folio_test_swapbacked(folio) &&
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
index 0761f91b407f..9afe4bb5ba87 100644
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


