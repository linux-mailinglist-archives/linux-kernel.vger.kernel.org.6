Return-Path: <linux-kernel+bounces-218594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE68490C268
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 05:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402FB1F24F83
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117DA19CCE2;
	Tue, 18 Jun 2024 03:20:00 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A779D19B5BC;
	Tue, 18 Jun 2024 03:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718680799; cv=fail; b=YfAIFaYWHrGHw3amABw8CFUeTPMeu1f05E9BxROnW4a6pbbpJUJG7PpxtCQG+M6Y16pirCzTTRxaida01LGpn5qJFV5SFAgQKQLwhJzCSjpA8VJq6xT20DHCgyUvXE89pP5k8Kj+sMTZ+6trd3fF8SnfeE8DTwlVbWpBJ3vljcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718680799; c=relaxed/simple;
	bh=ChNAqyUZIIS8muMlAqDCh/ZwWnZmM5XLnzXpP6cip30=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Sr3qNuk2yIrTJsOPtxhZWeX0hOC01SrPBoPEL70bGVT48N5mQTKsuaGyc1AslYAYAJekz2yvPJhM2RytrtFHdgnaM4yzHbZ4ypH1R1/QVKol/VfslnvRSrFkTBLbwKw1Kjotb4pQrdaeGnKZkD6rK1kq5J+dHDTbv5J2Uo8pcZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I3C9HR001607;
	Mon, 17 Jun 2024 20:19:44 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ys682jagq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 20:19:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l04YyKAh9gCXNYkSZ+67ech9bkSwH5m8r5f1cPZnWvSLYwxQBv0Ci8LP3VNhqPAKtNp+fWNjFoOCZ+uI6AYipl25lbxtUoDFe/t9faBVgTMv+FqCXTVUOlTxeU4wDH5ZXbh9KD6nwzJI60NpE5MpSRE8ISoCzfbuIm4SfqIrEzi6+P26Wbes6JjLPqiJiVni6UHaogDXFP4/TMFIXr/+UgKUqwpSt07UjD6NDJyvzbbYD9i5GTYbNR4lkL3ZyaCRpNhxPr1nq0q9kIVN3VxdV8UBQX7bQNqjPz9/ARIfRREcdfFN/yoBJUvF7C/HtF6ZI81TNUuwtcCbjopZ1hOgsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o396iQvrfI9LVpA5w8y8NEQesZx9/7oXOBPrevSPO7U=;
 b=iHgUUkE3RgeqR5hatHqXOSoyv5t4V5mjUoyDJt5x41MO7eYOCUV6zC+WEBM3Eyh79TE82Kkc/mcI3tUUTYYcdlO0DXGqzKS5gSUvqR+rmjuhfLVr/tOfCO69zYtXSsI+BheUVNy2M8/vuMA9SY/tMP25Nx7PCBnPGbxynqQGK4tkUhZ3AicQqOJETXOLpYAuPN5HiXXx/U/j+8oBSNvRc3/V+oDHvF9nIDmIlMXqJtbvQ26jZ9zNHt9gk8qvA6dUPMszi+D/GUxT2xS3KYpW4ZU8UpctPRcGKYgC3Lt7sJCCVjdPFoc4+WQMVnAbjpBR+IPXNoA/w9budRlgCenEag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by BL1PR11MB6025.namprd11.prod.outlook.com (2603:10b6:208:390::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 03:19:39 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e9d7:7193:8b2b:f0b9]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e9d7:7193:8b2b:f0b9%3]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 03:19:39 +0000
From: Meng Li <Meng.Li@windriver.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
        quic_uaggarwa@quicinc.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: xu.yang_2@nxp.com, meng.li@windriver.com
Subject: [v2 PATCH] usb: dwc3: core: remove lock of otg mode during gadget suspend/resume to avoid deadlock
Date: Tue, 18 Jun 2024 11:19:18 +0800
Message-Id: <20240618031918.2585799-1-Meng.Li@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:4:188::6) To PH0PR11MB5191.namprd11.prod.outlook.com
 (2603:10b6:510:3e::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5191:EE_|BL1PR11MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: d45856d9-bb52-436a-3cf5-08dc8f457ce6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230037|52116011|376011|1800799021|366013|38350700011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?KkekTMUJ3HhQ/fuOKXaP331HzhNO8eJAsLWOelSJECp/oCaDDMJQ/fUU/2gx?=
 =?us-ascii?Q?84KqW5NIs0ZU9LKkrx5fVUrs0tlag8Y80xyHi6HBbS9ZOoZ0qdMKUXF9fKZC?=
 =?us-ascii?Q?nvgyXVAaWzvpvGLr/bEdaCm9z1PdFPchuqcmH41Za1NkehE98gSzSOBH0f1W?=
 =?us-ascii?Q?i2CSySZp0Li3zuTxgy5tN+26UYTNhVRfgzzXuv05hDy3nIOklz/E7Rc8mX9S?=
 =?us-ascii?Q?5Z5MGqpHZzIyUNumA82tjb+EUqytTEXjf+c4okh0sa+sZXGHhUzq0ID97x98?=
 =?us-ascii?Q?rYMNBPJRWtFgRMAWqusYKKK71JdMdM5ClLXvB+BQBxovx9ndANvHuADyUiNL?=
 =?us-ascii?Q?yAfG/1iFfZkwsn5nWk8RzIcMmYfgBSmvswz9Ybs3CQeKpAz0pQL1iTq9QBfD?=
 =?us-ascii?Q?Ag3KhhEbcpjQlSG796RPq/Pf38ynWgAeKKrmdk8cs0bkZ6yq6R+cKJC5GFCM?=
 =?us-ascii?Q?WabHC1HPf5zB1T/G6PRBn9LfdjBNyYLXlpPuRebAwvzikkj1oI9iN2K13ocW?=
 =?us-ascii?Q?V7X388A5+gQ2ZAXSLdjH5gvwFH6DCil8+QLnU4xreaBpvwYjf3mjSwzKiwZi?=
 =?us-ascii?Q?qmnRUo4iOEpJ3EBd/8hbeUgEup/HIIlGgGXbFbX6CC/sMhPfyjBCg9pzvnY0?=
 =?us-ascii?Q?GEKLps5+PRPjLTUZqBkssFcy4y5Z5aRtuX4PC2TUvTUL4I9iUEBzyl6Ovkhv?=
 =?us-ascii?Q?7DwxeuOSzUFEyXfmxeL+m1HksyTBaul9Sqqq+0dI12LQSO1uLEhwm+4GK6KL?=
 =?us-ascii?Q?V7DW6C5wJqq1hxxVYKLGUSyPei9fbvDY7yUvpXy2uOZatYsJG45hE3u4glJN?=
 =?us-ascii?Q?hlqeZ7lqedAKZVVO4Tilt5RrT+fEuQPnU974tdjOenuxl52XbYyb4Bi3bSQf?=
 =?us-ascii?Q?imtF2kxdagwKz6EM1kR2SJc2ubFVNtw8nIv9GbLXrN9+qLqiQnjqILuzpxJ4?=
 =?us-ascii?Q?QMHNKy/h/LrLZVpLHUE4RFFSrYmmhxRCsg0+2McUmoqlnc0UXqVxFEbL6Zsb?=
 =?us-ascii?Q?kTKiWEEjxRnym+HryT5Nk4fQWNOqDPAmhaU0qs2cUP5tZPFB6aQUcNI6ysKP?=
 =?us-ascii?Q?9zIFThBD33tQUNuNbxswqr9V8+XnjO9bM3R8q32x8cZLpcrIKRIVwGZvnIHu?=
 =?us-ascii?Q?qwbKCEtKKk5Kzcl/GycCPkJKXzBkzbJgtjx6cowDdYVN9m4VYKt6m47Gi05q?=
 =?us-ascii?Q?teSiAm9vWNjGreDGocmeQPE/yRdhP4Fx8XJYEREyXVwWTGhgOuuYrtgUbBSA?=
 =?us-ascii?Q?7utdO8YUObQAA4FVG82aX/f6OeY5/MzxkJ+ZEBC4K32xdlcvBzsrvGre87Tk?=
 =?us-ascii?Q?iVZ1DH1BGbj9Smot+xk3vusXyqJO0DTDnZzoOLspSSBvBxm83he6/6pR4lLs?=
 =?us-ascii?Q?KNsWD5M=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(376011)(1800799021)(366013)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5DfFn7L4OmlfHKCHJwWRyFq2lGLbELKka1k8tfbQDujZlZTdQ8sqD24xo63p?=
 =?us-ascii?Q?OKSubZ7U/DemvNuvE3RX6knZrx66RmMMV0o0L+aSbBMkY8A3Pqf8R4bQcF6g?=
 =?us-ascii?Q?yspChQRC33UsYhKOWqZKoB/1ilHkjbhj+ms8BAl7n/6a9U8o/9Cy/utvm3oq?=
 =?us-ascii?Q?VTeYUt5mWAvS8nWdWJYlzOgbFX1Avla4n7s0mDquLyU6o1g3irXMdH7FmIAt?=
 =?us-ascii?Q?nGwuISX6I7z482yzQKxo5M9+A7yUolYXsny0EqVQ48I9p7QxC2V/XPiR0gLw?=
 =?us-ascii?Q?+w3/Ecftgu7S4sw6HknoaVVwWDsIR7uX7oRDb0hzXGnsGN9TtHhpLo4TE6fG?=
 =?us-ascii?Q?SeQEA9t8Az4k4eKm1K2685883HTkYx1DABHBTKne9c6LRmC86oMFGBPkOrGW?=
 =?us-ascii?Q?fFrIOjmYGDmaysnthRZQcUAxA2Ii4Iapd1ph+cS8vPad6PCigkDpJOc8A1Vy?=
 =?us-ascii?Q?4ZbwzV6WtJ/Wttb+79VKLPxWcOrn4f9tvc0SxNN5oIwfWbY9yEndTHG7Thqp?=
 =?us-ascii?Q?rWACKavhf8AJRqq8ydaocbuiQJBVDXCK8SKf8WIk733394OPadYS62QWB9Pg?=
 =?us-ascii?Q?jAKnrEVeTeR9CBMT5cYo51IS5Ev/hO8QMceVXXDpJNbCNzktIIKcdf6u7M2G?=
 =?us-ascii?Q?aJyUN6U1geeyhQf2TVXc7igtGQLsqdK/QAFiXAsuZf6cNZ9j80vfpngcmkNv?=
 =?us-ascii?Q?69TsHyKUY4c0qm/pI1gPG+Yq0KHFa8S5cNvxESVJdNB/Axekc/b4YoTzd7nI?=
 =?us-ascii?Q?9RD6MUH0SquplbeKplO6KtIPxVBQ75q9aPBzhvyXocA50/fAOccm7I+dV4Ko?=
 =?us-ascii?Q?3I/jK1ekZS+rnF/HAehdrCuirqThnRVt88ekGyiM1cRt6KHD7C03jZq1tNtF?=
 =?us-ascii?Q?pevEJGfD8bVWDLXMYiywsN0BZl4VngjXR770vXMf23p8Y7mNJFXUX8vuUjlS?=
 =?us-ascii?Q?Z0XJkOzUTSlddCOWqEzG0jER8S48b8W8o0k/r/W7ATkL8H6+1ivdXla+SAom?=
 =?us-ascii?Q?QaaH6K0GdVL2z56jAuTehtEI6obBZAQn/DUWkI4/OssgOn941PQ0MufL54ZR?=
 =?us-ascii?Q?8wdXOrn+JrkY2kGjRfMQwY7Y/rkIMhuZlLEanPuNoxDA6TgLAb7xcbQ+Imy9?=
 =?us-ascii?Q?Y37PZmN418xttEfUq95zgikobSnFHCPwVgnUZN4/8uFLxIbp251/ozpqIz9k?=
 =?us-ascii?Q?wA67Ack58oqHRWyYdOIs989DaFk/X3B6H3CMZ02/JuaYWQzSFnZ8yz/Zd3jL?=
 =?us-ascii?Q?IwuZVQo0TtbNqhestBa05wxCHkJYNxDdY/EdljVf9CDnmHvbdJ7xOduMEn/K?=
 =?us-ascii?Q?AbfX11tW+48mjd8NZKmaKU+KmSVDq/FivnEMMyq3UQW97jn5WzefK7ZNqUut?=
 =?us-ascii?Q?LABFkcWJLDDsX4c10Ctyc1ED/wiD8DTPY9/FSu961ocfQqq2bW5uBj1M7DJb?=
 =?us-ascii?Q?R8R+guC0COfcitMUb3+FfGJbkvFnGFS27LUSQaQxwVTP8+gozqnL42FiE9gE?=
 =?us-ascii?Q?tv2+pKsupsOdtWlDJHViWExIySll/TmDiLF7t5UWdMetw0q43q7StTXePM3W?=
 =?us-ascii?Q?xctTifapZivw/+X2LZXzvnKxM5qTp2bpBCyS/cdM?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d45856d9-bb52-436a-3cf5-08dc8f457ce6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 03:19:39.2582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPglr9f3UkK33OoimlIMv1akMZYHZ8LQ3ZMjP53DskUtzlgCY6J5JGdWs8IoNfIihPn+XFPx2car9ygqIVc3jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6025
X-Proofpoint-ORIG-GUID: tfgGnUJIzrlpEkCekCxA2hZI9Ob9rP3C
X-Proofpoint-GUID: tfgGnUJIzrlpEkCekCxA2hZI9Ob9rP3C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 clxscore=1011 bulkscore=0 priorityscore=1501 spamscore=0
 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2405170001 definitions=main-2406180024

When config CONFIG_USB_DWC3_DUAL_ROLE is selected, and trigger system
to enter suspend status with below command:
echo mem > /sys/power/state
There will be a deadlock issue occurring. Detailed invoking path as
below:
dwc3_suspend_common()
    spin_lock_irqsave(&dwc->lock, flags);              <-- 1st
    dwc3_gadget_suspend(dwc);
        dwc3_gadget_soft_disconnect(dwc);
            spin_lock_irqsave(&dwc->lock, flags);      <-- 2nd
This issue is exposed by commit c7ebd8149ee5 ("usb: dwc3: gadget: Fix
NULL pointer dereference in dwc3_gadget_suspend") that removes the code
of checking whether dwc->gadget_driver is NULL or not. It causes the
following code is executed and deadlock occurs when trying to get the
spinlock. In fact, the root cause is the commit 5265397f9442("usb: dwc3:
Remove DWC3 locking during gadget suspend/resume") that forgot to remove
the lock of otg mode. So, remove the redundant lock of otg mode during
gadget suspend/resume.

Fixes: 5265397f9442 ("usb: dwc3: Remove DWC3 locking during gadget suspend/resume")
Cc: Xu Yang <xu.yang_2@nxp.com>
Cc: stable@vger.kernel.org
Signed-off-by: Meng Li <Meng.Li@windriver.com>

---
v1->v2:
 - improve commit log, correct the Fixes commit id.

---
 drivers/usb/dwc3/core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 7ee61a89520b..9d47c3aa5777 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2250,7 +2250,6 @@ static int dwc3_core_init_for_resume(struct dwc3 *dwc)
 
 static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 {
-	unsigned long	flags;
 	u32 reg;
 	int i;
 
@@ -2293,9 +2292,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 			break;
 
 		if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
-			spin_lock_irqsave(&dwc->lock, flags);
 			dwc3_gadget_suspend(dwc);
-			spin_unlock_irqrestore(&dwc->lock, flags);
 			synchronize_irq(dwc->irq_gadget);
 		}
 
@@ -2312,7 +2309,6 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 
 static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 {
-	unsigned long	flags;
 	int		ret;
 	u32		reg;
 	int		i;
@@ -2366,9 +2362,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		if (dwc->current_otg_role == DWC3_OTG_ROLE_HOST) {
 			dwc3_otg_host_init(dwc);
 		} else if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
-			spin_lock_irqsave(&dwc->lock, flags);
 			dwc3_gadget_resume(dwc);
-			spin_unlock_irqrestore(&dwc->lock, flags);
 		}
 
 		break;
-- 
2.34.1


