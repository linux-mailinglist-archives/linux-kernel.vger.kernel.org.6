Return-Path: <linux-kernel+bounces-170184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EB78BD2F9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89143283FC0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD44156F50;
	Mon,  6 May 2024 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aMOuE3eL"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2057.outbound.protection.outlook.com [40.107.6.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB12B1E4A6
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715013634; cv=fail; b=DX4tk+7y1qenI6vh8/ZSYGTKMF/FNZ3GdxiA17RHTEJfLJJOE2xOfZXqEXSWUNDfDzIm+1+NBTW4ddJB2zGQ1IvxJOlcwTIPGPl9ZdFbJoX+PLn+VKdl/hDPwEEY/fXxDbHyMZBUYroJXtaX8icSW2LLSrpHsCtNoxgjv8RfjU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715013634; c=relaxed/simple;
	bh=Bz7J9sHFqnldrqDjmFpaZPmFPCbeJg1rdyukwLTo1Hg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BObgOi7wI5UYsGTRUq566lK/zDpaswDrTdOfKMqZkhzaxE9tWZNC2rdVPFkwOyZjiPE4uwtabnhFbE8V4LcemmX9g/T6jDXdqgo8zXtjTlV1sgHDhDy6VA2kiAi3MlFROSysBDMplY/YmpZaju3j7nWhFjGTNavIl1/q7udrLAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=aMOuE3eL; arc=fail smtp.client-ip=40.107.6.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPRbGu+2PLXIbo+b+afT92opVe0JhYE7dsM8ZxVfo9e9NlDxusWpM/3lLw/PTTSrEgatQGUdDklaK7RWE+AdoBaA4lL4vswAlrcdKmajKO9RXKjj5D2XG/aWwm0r7D2QpcEXtYmhCQqnAqyN8oZ8+8guQvZ6J6fhgvHAwpD8laPdnvbJOa3YNwdq+AHpiLjXhXHHxiXZLBlfF/MnHGmZkVBn6ozkYmWX0Yz8mnxJuRJ1px5ZDbgdhlLslBEaXz10o52XLtuUPtQuQdQnkTNJIPm/oxwBUpYz+F3SeU22HSocS53kUhMZ0d1eYq0kBj7ZphuXdTF90qD5ZR5zFV71xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZa3Ui22bl0O+Rohjhbh5GVtdNA8CI3VASFPs59f3Xs=;
 b=DMcBMOt7T9AwXerGTR+yQekyOdXGehLgYFKyQBtxYiiEIffUfrV9+aaiyFpB7fHK25MTnx6itOoyQXzqoY78o/40bHZPqQ4pIhpzc78aAhp2ILjZRhA6STXK07N4HSDkxB2c9bgCc8ZFP1IA5E9POaLve6+g0S4Nq0f5VOVjbU++4EbR+Ze8kvDV088BwQMl3t0rcuFhLn6h08ATwiOVeVeL03MOalMtY0k1cfO4XxSSFdrWZL2gnX1M6wOgz5RGJnkijk4gnwWnm3XFQAY3NZeeEQPp+KThuyNavOUMe5VIzqfxnZMUDSavwrp1hgF/aubgdiEYwmKkHUfvyV8RTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZa3Ui22bl0O+Rohjhbh5GVtdNA8CI3VASFPs59f3Xs=;
 b=aMOuE3eLtkFy6iRLqP6IHrpoYILrz3mV5ff66uK1V1ertfaf0HZ+v+iPlv5KkJaqe7TGEKz3mh0Gr1pjesfVK+GmYiyY7FAc8lWq520oj/L7RrkKcBubsiuvvBMDkC7yuV+nOHT2IUpqMPLLS25e+Lm/QjAoDxD2vpnRx9tVT2I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9049.eurprd04.prod.outlook.com (2603:10a6:10:2e4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 16:40:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.039; Mon, 6 May 2024
 16:40:28 +0000
From: Frank Li <Frank.Li@nxp.com>
To: miquel.raynal@bootlin.com
Cc: Frank.Li@nxp.com,
	alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com,
	imx@lists.linux.dev,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] i3c: master: svc: change ENXIO to EAGAIN when IBI occurs during start frame
Date: Mon,  6 May 2024 12:40:08 -0400
Message-Id: <20240506164009.21375-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506164009.21375-1-Frank.Li@nxp.com>
References: <20240506164009.21375-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0296.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ca8e3ef-70fb-45ca-4c32-08dc6deb3cbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?caXBGyI0hsfDtUD08pnPfAfozW94zQnHmy7012Fs5n4AHkqeQcTgjkBxB7oi?=
 =?us-ascii?Q?+NnM6A8QAhkSxOGVs/ydYFkwAT/ZyS9+rIFj54g9AfbhunaXp8QXaDWhvNDV?=
 =?us-ascii?Q?5Jw5UG1U6u1xEJkUqYEtPcH3OMvcG+d1p6mpmDjEBN36PI7BY8P5j83GhKRV?=
 =?us-ascii?Q?iCwA3TW4GxfHlgFykHvEqr5P+deXysrhZ3kyILIzr0JwFBS5NWecytnvfa/Y?=
 =?us-ascii?Q?oyeTiz7eucGqRzZxH2UMDnOkSl84Qoi+b36IDDVThA4oQa2m3XjzaaCQrk31?=
 =?us-ascii?Q?BrxfJvV3tRxpgk5wwB6RpijQxxb/pV9IwBkwRSlfbrNfnTT4BIB1tzJ4TfkG?=
 =?us-ascii?Q?M0eT4mOe1+APT5opbVmYkjw/Z8/tao0neJLt5GsB5kKvZKYjjaIJs7anGipr?=
 =?us-ascii?Q?93NAZv93URapKjV6yEvecJILM1W2nrSxhRO7AF4QFgFEq06tKtMNnyJg/Trv?=
 =?us-ascii?Q?KsDf8PZFLRioUgKcJcPrm7AC3G7o/R7inrMTbKoC1P0Yx4D0q8Ujpl/P6Fm0?=
 =?us-ascii?Q?k4pgCcJ7w+A2m+jeKUB3NnhczLvZ+NNsgUjbl42P6CLVshGs24PLZTFOtyHG?=
 =?us-ascii?Q?8ewHp4g8/tqXA4Je1gKk80U35wF3GsOjJtR3oICOv1HtwVpK8belXbJ5HNLb?=
 =?us-ascii?Q?7xiB0xY+Fc1POZF0NlxpwcztxSUYPZQcrb8a+lY4HeA1AJNxpRhxhntgizF1?=
 =?us-ascii?Q?j18P1G6Et1uajlwlsZdTMQxKsNF9Nk+XmLLkM9ZiAWOzYBszvbe+5id3fewV?=
 =?us-ascii?Q?d+V0Zv2llYMAy9NLn7qDuf1k63qrQJcYuUIhUJ+kU62Rh89VVXGAmZI8LFT9?=
 =?us-ascii?Q?e+aYY04C61M57nVYecIbjrPsFZvJdPoijXrGvBovncLRrUHFZsPiCoyKrsdl?=
 =?us-ascii?Q?BFnBODmheurANELVWALDeR++bzMq2l14NlqKAyrGhNLYVaYB7edXCHQHMeSc?=
 =?us-ascii?Q?OkL4vSn1egX1IujkY4vhqGsdcJe/ogzM265HM+W4KOW8c7UF/eo3qSDmTQJ2?=
 =?us-ascii?Q?Y2CKz1JsHy2Uy8Bp5/c5mmsxPPiEmjsJRMCf5DSbFB/m1Xi0vi1iBUf1fLiW?=
 =?us-ascii?Q?TYNti95wKXvc/fuh8xFwFyO75cUMlFLQoGjKTE/1sSFw2zadecH7I8+D5CPg?=
 =?us-ascii?Q?iJDjsxm9Fp0m0Y8qIq31GMQma9XUc8a/qmz6rL97x4f+ajmtzlWmmG9uWgKQ?=
 =?us-ascii?Q?KpYeSgSuz3Qfhq/GMPMJnkLE2s/P51c65WmNpyaUETLEwEHH0wgHMqCm0B7t?=
 =?us-ascii?Q?DqCTLGqKOJsQNkl/jZG5oBvnxX9/sILd5G9nAwE9Xo8/mvGD5lMDYSl7w7Yy?=
 =?us-ascii?Q?1k4VCkuf6qDqSyXNakPF645SCsfob8kyok5LM+EsUToapQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+5w89qb59irigpgcgafwVjYHSsS1CMp6BayCPQumfBt5Dc1crZsUj0oS15uj?=
 =?us-ascii?Q?fKKxLHL1J+RoydlcP7PiDzEghi7Up1kMKQTPrn2lxrpMkO9kCciMmIu/YujM?=
 =?us-ascii?Q?aR4ZLHG6xiZXKKPKCDBgDV0zdbXivCOmpblK1X441hipX/w71pCnob44a3na?=
 =?us-ascii?Q?WcGLMnVeTIOQmQJnaAGuDCAk8gGKldlD8FhP6vBsFbMq32Wd8NhgGdc+ky0F?=
 =?us-ascii?Q?a2Zvn/DAV4evKYJGIVVkMIyXaErbz5P65L+I3tpt7GJ3iQElL+0PCFNc02bk?=
 =?us-ascii?Q?H26VITQdm2pIV0zlLlDBPZ4DkUUWE688aDL+MJX/9UCbt1jFoCipePJZp7gr?=
 =?us-ascii?Q?mnA8VR2Y84LQ2yaPIOnLZyy50KmmmjnUcPg4Oze3MwDArYT1NEamCrYFSzTR?=
 =?us-ascii?Q?Z6aGZ6vXtVgnTpeZTOhdRbUM6jtpIftHIXBFdLKtokYKH2EfuQgVMD2ShMpo?=
 =?us-ascii?Q?0umEXaqO2SeKETQqs4GDrfVa+IqZyHEHAPcp3T5yEp9kdTphvkRhi41f0TK2?=
 =?us-ascii?Q?YCaDNqJUwKh68JisPb/DeA/pdP5ecREIJM/OTWWcOMRWpd6fGcVkUMB3UvIB?=
 =?us-ascii?Q?Qmftkd9O+Gx2Fo9YMUVyrhN+zHpBPh35NpflhHDAuU5YXAX9d4LkjEK1TZdo?=
 =?us-ascii?Q?73CDXfKyF4lKodmG1NpybPf5Yun7T4BRFwW2KKdyvkA0GFKwDJ84NeKU/353?=
 =?us-ascii?Q?LfY2SdXIC8PdP98JX6fJ0N0cB2j9KHS7bVb+v+8CNNOzNMqS0V5aVjJdWnLr?=
 =?us-ascii?Q?ML1P0zihXrPBpW3C0lT45UgG9MZFt+wGd4qemmA47Puds7s0gxZ/VTAOifZt?=
 =?us-ascii?Q?qxqD/BkQDrE3id3FV8d3VhH8XOaLFBMbKOsSAQt+XosX9fM+0YYQf+PpIxaf?=
 =?us-ascii?Q?GFA/Hu7TTfEZ1AwW5R2gmG2WYxOhOgSc0lkg3V5rKfoGkYlFl6BjZPsG3cHk?=
 =?us-ascii?Q?hZ/W16xaXwyQhq87V4XmGvCt7KDjLR3xi/u23riPDZIOIF/8KXkP9vp6mkiG?=
 =?us-ascii?Q?lhlLfmivyjBi2lqUD3kodUkAFps7Nmh3c5/+GSr8h5doKqAW1NAvSZSQ2DL8?=
 =?us-ascii?Q?z+FciCK10PqeGF/ETn5S4DxeZIrBHzf0YRMA8qcjOkXP0iPMK/F3edox0YOt?=
 =?us-ascii?Q?ZKuQxCJXK4RxThTORS/miZSYU5pg9SfWUsvl1LC/40KbmuKdJ0K7QcdEy5zj?=
 =?us-ascii?Q?fEnQWJsjcJndwJcqe6kAWOiZQaJzUpiZizlbyyIqHiSWz8/+3F71HfXlsgfB?=
 =?us-ascii?Q?jPGHRUuf1VEc5D9Gk3IFB1M9QbdJQ8fiU8AyIOw1byjCXT9svQaJrhBsXUHF?=
 =?us-ascii?Q?FnwYd0ettnyLVBmF573s/MVnybbeCNtlKQ/ZHQmDbPiIb7qvZfteD4hgLerz?=
 =?us-ascii?Q?OVpHQ5Y8+PukwfD3cQAMwlYpRM0RbQGtHSpZGNzIC6Xle523u20w6u0eAY5J?=
 =?us-ascii?Q?lPuezkIR3ugcTkYaRf4ue1OGLAkgut8uNcJGeOBcZx26gf3UyswHi6sI0lot?=
 =?us-ascii?Q?CVyyOokxZE3y18hH1K9Z7sdt0OkBJBm1JhhigzfsH3zTnra7PlGlnhKRFiaK?=
 =?us-ascii?Q?VpwV4vy6fMNGl1JmxEs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca8e3ef-70fb-45ca-4c32-08dc6deb3cbe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 16:40:28.6499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONRGNs81xPviuHXw2IOpy3vjszL1+nsQAHD0kErRpCAskRE0FasWl9RGM/VU5ed8NHp0C/5TMAKoT9szWoGyww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9049

svc_i3c_master_xfer() returns error ENXIO if an In-Band Interrupt (IBI)
occurs when the host starts the frame.

Change error code to EAGAIN to inform the client driver that this
situation has occurred and to try again sometime later.

Fixes: 5e5e3c92e748 ("i3c: master: svc: fix wrong data return when IBI happen during start frame")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    change from v1 to v2
    - none

 drivers/i3c/master/svc-i3c-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index fd8de54b13667..94e4954509558 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1080,7 +1080,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	 * and yield the above events handler.
 	 */
 	if (SVC_I3C_MSTATUS_IBIWON(reg)) {
-		ret = -ENXIO;
+		ret = -EAGAIN;
 		*actual_len = 0;
 		goto emit_stop;
 	}
-- 
2.34.1


