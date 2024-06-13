Return-Path: <linux-kernel+bounces-212732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D3B90656F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D333D1C231D9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 07:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181AC13C693;
	Thu, 13 Jun 2024 07:43:04 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45A357CBC;
	Thu, 13 Jun 2024 07:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718264583; cv=fail; b=M5b0JEQYwZuKAwIg/RxPZQphdDzR+r6nxrep7XiMrQEuN/uVABjI+5osy1IJEZ1Vgin96czV2IgKQ8RUCwSsAQ1gTPmaPHhNes+gomzdj/WOVUYs0MYREcg+kOdMss6tYjfkzSrsdobW1rnA/al4oYsHw3RUXHTzkRUoIiWkUiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718264583; c=relaxed/simple;
	bh=ZlTn6Zji9xGqIANYancB7Q+PmxH0ilsxHmnBWx5caQI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lWfKE0OR8iplXAraa3hNLVWONsPN0Sj0Oqi8RKnJwIzgFG2v5sVf1oVVNhMNYudqwHXq95q7qN5Vk845WWzwuBcMrkU5NDNZa7/l4WP5KngDFyZXf6PT6jkxoaOueyKwhhZOgXHrohUemCq2uXjKkCSeLRaOtCw9XYALB4cBBZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D5U2b4030655;
	Thu, 13 Jun 2024 00:41:58 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ymptg4nbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 00:41:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOfqfp2+xIqs+cQznsprQj989d2c2fSEB1f2p4E2gusENvw60uvl8q56IUDO9LrJ2EdnUwGynBiMHAzhHCqEcT2T0bUImi4Z8pTYv6j4b4sVGjqQItYbGxsJVzzxwQY5Ka6ZoQaS5yR9zsdn7Yo0iieb6IcjqE/xPt8OR+ELCzDqN7l+F1S0/SoS3nd3ijx6YD9d26NnysgXzq4Pq+NMIFmEbTI0FdSYxmALt9u2AAMvBRFT8MeqgkbpZT/YY8ogU3icDi8GzFyV4lInRXreYOUZ+YoXfER6CmuoHekBeMHajWZuCGsI9t9EcjRm+ZZese7ld6VuVAHhOgd3e+ZN+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFeobAfWHrUTY6QaCgO2Z5ZrF/dmeRDtTR5Hi7TWEhM=;
 b=P7C9h6D6Xo/wCvxdpwvAG98EUhdotQM8fzBhKyn7BmnVWIHGJnYMHhbKKZgO7P5PhrOemeg/b5phNTQE4B+XQulWtVL2o8qf2Ty+wmCax8s83O5RJlyPvV62ymHU5KAVOOfCfFlwa3Awpx4PU/5FHtU1AIbyi0EWSZ4JfxNo9Ludr5egMhIFxms6MF7w9G1iZT3R2hRvo87ncVm+a0sdHKpfzzLKXphhxMFo/OCv8oVm8d2MG7KWBKFRu2oaf6k/xnk0QPcsPxY/yBezSQw+K89RuhmYqQe3xfDCUWfi77Bsq1UnyyP/kgEdgHOu9VOS3yCnt1QxT1oMEg05Am/mUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by CY5PR11MB6512.namprd11.prod.outlook.com (2603:10b6:930:40::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 07:41:54 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e9d7:7193:8b2b:f0b9]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e9d7:7193:8b2b:f0b9%3]) with mapi id 15.20.7677.019; Thu, 13 Jun 2024
 07:41:54 +0000
From: Meng Li <Meng.Li@windriver.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
        quic_uaggarwa@quicinc.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: meng.li@windriver.com
Subject: [PATCH] usb: dwc3: core: remove lock of otg mode during gadget suspend/resume to avoid deadlock
Date: Thu, 13 Jun 2024 15:39:59 +0800
Message-Id: <20240613073959.1939608-1-Meng.Li@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0004.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::6) To PH0PR11MB5191.namprd11.prod.outlook.com
 (2603:10b6:510:3e::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5191:EE_|CY5PR11MB6512:EE_
X-MS-Office365-Filtering-Correlation-Id: 945c1d45-699f-405c-4489-08dc8b7c4ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230034|376008|1800799018|366010|52116008|38350700008;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?NWtEtlrjUbn2yT83ZrnsQPG0Frv2gx9BJ32KjPS4S7ktZTAz5mi6wNaRgt8E?=
 =?us-ascii?Q?Venx1EGQQcimj2XfmoGX9vD2tsq1DQASSQY3+R7lxaQ/jdQ9kBehlXEr22bx?=
 =?us-ascii?Q?nYLl9b6wG0WIkTEtxFrHWW6g6ixeRlX2llXfr5un+JFiz+GU79WnCOpiZvFS?=
 =?us-ascii?Q?TTGmp8A0XtqvmFfviA1DEk7YAqoUc54rey20GaSYnukruxp6j/96FzccLBQd?=
 =?us-ascii?Q?msz5tjLHYkrQVU2gXL8jC8tVg34K692wYPnj+Pp6wPHF9RRHJxz7099VmFoh?=
 =?us-ascii?Q?Ro+Dbj7lw+IbRVv6UinbMheIl+IdlZY78zYMIRp78sb0Sg2IMgOEp2y/5eC0?=
 =?us-ascii?Q?F/SnYTKZw3ZNxqs6q+jO93XFVgmpFL+Krh2zhgHE7aDv8g+qU4V7A+W0+KM7?=
 =?us-ascii?Q?VEmIO9UhT+E7XDAgRT7n8C2JUNPezTp1sWZyjcjKIKjfb9OQb84DCvk6PoMw?=
 =?us-ascii?Q?JwSAV2rttjzvcfvUl7+vSbKEzW1P/jpbijSvydxdmY28k61UQDfL/OP2aFqk?=
 =?us-ascii?Q?L1Hze9Iiz/cozQLb5sYim4VgPSE+G0JAHxmptE6vkn6+cadvsDXWyEBHfJj/?=
 =?us-ascii?Q?prrMkk4s3oe3fO5YdY9UgbBMkCV1C2Y0wqHDAenKrRBlsGimZ+m10U6vIHgB?=
 =?us-ascii?Q?n7GtmzvDSGlG90N7ZXqg4YFaUaLYzGVCB6V8u0OHgk0yfhIREvMtyjBofG71?=
 =?us-ascii?Q?NMJcb3ejfmQGZuJgSIc3076PMtiEXO4yvkEFriLmjhjA3hEGDgT+mZuZEen+?=
 =?us-ascii?Q?P/w4z6gpTQVFy+XlZHGGX2TEMFpZianVDCvnlUVvLcHvkBpejpZne4RWvldG?=
 =?us-ascii?Q?XaT99pzypikF3mFYgp8J5QqJewPUH53LA31JFYXZcr22R1FssZaRSFlPoUSX?=
 =?us-ascii?Q?8Ihf1TNsrP7F7qH7ZsO+9ntH+NKnlqPo8olQHBlvI4FY9AImt28z28Aeckpc?=
 =?us-ascii?Q?7I3UvsbmDYIUU76Z/A3GVqwrs6xvyXxES/ZsTb0kGE+2ZE/SdiV4ZyPhLMHg?=
 =?us-ascii?Q?nKZtc7sVVZJ1h2o1SsF7oxwP9K2vGEDts49D1iwWY2cfUQ8w2hWohiXL+IWX?=
 =?us-ascii?Q?SXmi8UI5a/p/nGvWVpCpxrKisg+ipwu18cjcFp/QgmgtdHUIvxMyyDPAXpke?=
 =?us-ascii?Q?0aVsvA/XZsa0QZ+FkHN3M5cWrizUT8Lo4G7s6J1yIbPbubLonGDAIjfjH8cW?=
 =?us-ascii?Q?cG/5t71Wy8ywo+I4xnk2L+j4nzKNdr93h6Rdt/W82gd64jJHEIxNMPb2ut4s?=
 =?us-ascii?Q?OyOpPF8Y+Dl+bN9SXMZhxXjGneq6GIqEis/8MhcD3PbeJfo+4dZ02/e2KV/P?=
 =?us-ascii?Q?xf+9ZX3YPl26GYa1xEU2w3YCxMz8OlbxT61k4f/hkQOALuB3J90PwUWFTJYw?=
 =?us-ascii?Q?bivKvw8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(52116008)(38350700008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?58ehlOTMv9NJ+ppmE+PFuwC6G/5xb58JyOYaNYqDRaeBcJSJWlupRbkWjkhF?=
 =?us-ascii?Q?tuI4ROUSyYBFy8xTP+BRtF6RP38YMv8FROzVfLs87w60+yi61NRrQpH0zTIY?=
 =?us-ascii?Q?5/AXCDLUegqno0+yxRmlK54BqsBoOHSGLwkueEQX0BT33m6mDXXIWUV5WXNM?=
 =?us-ascii?Q?klAnhhhlyJE6DoON2P8ksqWe0ldUPvyxi3vSjC8jZ82+frzw7EvKO2eQRvuG?=
 =?us-ascii?Q?iYD3YEVLgOjw9XqveOAgB8CSE+gUZcKUE2QhDf7tflX45e+6X8xEIFptbTK8?=
 =?us-ascii?Q?7m+kDKdZkKOcenAOKLnsiT+M2y6hkSGcQmshLJAIr0fX85WRnQ6GQuUHoL6i?=
 =?us-ascii?Q?0IGnLvVXumJ1hTkxkpPf3XKO1iJXx4sORcqAxB3vuNCdIJuAB4aTflK6slW2?=
 =?us-ascii?Q?41NpgkBlexDapIjcLnh86oL/Nek8L214obwHwU8rQ1IB8Pj9bcPRMsxmh41Z?=
 =?us-ascii?Q?CJ7IF9dSah14vDHzMzcmzc3lEFFi6lpCifl5vMgRE7AFsotcSb3qzoIKrNU+?=
 =?us-ascii?Q?2yZJ4SzAyCPT1MFHF7UHklycydEc7GdZAGAupMoUImxAKcVwOiCHczP1REL4?=
 =?us-ascii?Q?rG2+nGSxNcYKaEAf68H1QWtW0nQWKRjBDm/VZqV3goII/ue0ZYSlV+aSir7/?=
 =?us-ascii?Q?x+wTNqu0R3zQcNJ8vfTyZxbgF8Qe0knGVrzQBsx+SXByGl8XiiZ/SBImmaUg?=
 =?us-ascii?Q?VItbnYPRtcmyNOhwQOjjczMsbWO6Vx4oCZIf9DfkXYpzXedDajwBjAZ8+5/x?=
 =?us-ascii?Q?tqJSqlLDinokX+oNzB2YfspfOi76C2lG462svt+9dYd8I+aOlJE+3UmJFAkH?=
 =?us-ascii?Q?yXNn3hA3ahi/bMWb3+DzwMIgvAx7/ZoXgxz3hTVfMKZmTlY8KPr+DdREKBkZ?=
 =?us-ascii?Q?F6/otn+Rb6q4MGjcHm25V+kS6eTWHMZ7R7PIHNT1I8bKfo0bHWkERe7iWEHN?=
 =?us-ascii?Q?a6eum068zfrIEt/I5IagQ7vc2vZPF9BwUtsvfUO6OYodWuJ4HX3voFxgt5hY?=
 =?us-ascii?Q?9QZfSev4RaAXHvPS8anGlPE+EKwHipGwN1TRgZXK7CXk4+gPqvvhF9ORE88F?=
 =?us-ascii?Q?/yCIDDzGdXAe6kr2F/zvg2uj25XwOrZG1OABumcU7mSOarYMWdY+AIBPVa0N?=
 =?us-ascii?Q?L1MMGRQ+wPRr6lgzm8Rmk82WKc+/D1h611DKlOoAn2lZsaeXkPAgT0B0mcdl?=
 =?us-ascii?Q?nOI4n2O8xJ7W+tY32Oik2Y2zCGeuWVs9vikJD5juPVWkKivDy6LX3wUin8e7?=
 =?us-ascii?Q?G/6u8rKAiG4QbijQTqGHF/W+w7SQUlJsfGdF6llYsT6a8c4zFMUDRnEzOz9Q?=
 =?us-ascii?Q?ov7ejy9KsS4Q33SvZ3tRjRLwvuD6MZqrSkFYXNHIAjfgyU3mqyWa6LeijOLO?=
 =?us-ascii?Q?FnZY7DwZBiCi+ippjlMNBFIUI2MCgri8iuVKzyO7Ly+duZQE2b5ncs57khwW?=
 =?us-ascii?Q?4IFp3HsELk2Vhsy42KhN2wCKuSGbcLhc38tYA/jX8KxNkewRiGK/SL5KHuDV?=
 =?us-ascii?Q?cl8LS/pq9HctMThfATG/aTv6v7FYoR06KY7LHLUVoPRTiokKyLky72CqpOCf?=
 =?us-ascii?Q?6EFXaD/KG5FYqtfJd+kV+DmTAYiNOgu2hLUdhDq4?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 945c1d45-699f-405c-4489-08dc8b7c4ba6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 07:41:54.2800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Unfw4dY62p3wacX+K3A4O56Jw2+Jlr2yvCOvToLqKtYBKcrvwiuH4Tk6SHjJO6N1uwnCjZMV80D92DGLa3UPwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6512
X-Proofpoint-ORIG-GUID: TTbIR7SrIhwv6gHiD5vhzJO0N-RgJMvP
X-Proofpoint-GUID: TTbIR7SrIhwv6gHiD5vhzJO0N-RgJMvP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_12,2024-06-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.21.0-2405170001
 definitions=main-2406130053

When config CONFIG_USB_DWC3_DUAL_ROLE is selected, and trigger system
to enter suspend status with below command:
echo mem > /sys/power/state
There will be a deadlock issue occurring. Because dwc3_gadget_suspend() also
try to get the lock again when previous invoked dwc3_suspend_common() has
got the lock . This issue is introduced by commit c7ebd8149ee5 ("usb: dwc3:
gadget: Fix NULL pointer dereference in dwc3_gadget_suspend") that removes
the code of checking whether dwc->gadget_driver is NULL or not. It causes the
following code is executed and deadlock occurs when trying to get the spinlock.
To fix the deadlock issue, refer to commit 5265397f9442("usb: dwc3: Remove
DWC3 locking during gadget suspend/resume"), remove lock of otg mode during
gadget suspend/resume.

Fixes: 61a348857e86 ("Fix NULL pointer dereference in dwc3_gadget_suspend")
Cc: stable@vger.kernel.org
Signed-off-by: Meng Li <Meng.Li@windriver.com>
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


