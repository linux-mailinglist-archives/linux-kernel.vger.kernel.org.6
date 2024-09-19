Return-Path: <linux-kernel+bounces-333045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2565097C2B4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 03:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE33C1F228B5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 01:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3652BCF7;
	Thu, 19 Sep 2024 01:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="OKEe3Mc7"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2049.outbound.protection.outlook.com [40.107.117.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF281DA5F;
	Thu, 19 Sep 2024 01:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726710435; cv=fail; b=MdE8hZaoF+zIEJ2hB5tDhsL7tiTycLmGrbusHA3I9PX2g7mElon4ongCIjj/OuD6J7DqleBvST2HUict6FLVgsaEAUECWhd9LzbUHCf13Mo7z1+uh4UN58c5za6644KrfC8WhGrlCkKsir020h62RAJuNPmB3Og317dYb06FkYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726710435; c=relaxed/simple;
	bh=S10kcv3ihuU41KEfvXNMwDe9Y92/C8Hxdti6U0iPRyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KECdi02mpL2okboNzYtIQN6ayVIW+yV5c1i+F1xnhG/gyziSUKcUnKywJj01nRZ55qJLh/2d7IpZ/4ZsUxSaHPkD7VPITo2jFPEsTy5eGEqMkOMnHyT0BCqOSV0jlOzNdQlFysMawCKry4DvZ1p+vjwlGxdnG4RxzxIZecEmso8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=OKEe3Mc7; arc=fail smtp.client-ip=40.107.117.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxdTz5g6Q5oN5azZz6MNbu1omyklcLn18vq3APJ5KQxfYRjPOY9Pz2OwTqi9vDt3NsyKHXmnChjpQrSWBuubaZFD0oWTLV1EOsOtR6SI0mVI6gubWLwahJiyiUTDesX8O5Kj9Mv+T+fc5D2CU845xJfr5hBjOmpZnin3eG5AcSaGPNDaBOSolRnnlCXl63sGSQi9QlYmwr17YBUwkC6c4nCmQjRcuBsJrxIq2DEkDMhEtr4+DBRNOOXwvA2zvacXtD8GDoCKAdIa68DlKOPG66+kmoTqEVTtEGhwJVmtDhQG72Vqi1lBGhBBhciLk3VgtTtKbmzIxA96NWRmsnAJjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjOGk9wLThEdw3din8pjMwhhWwhHeJQ2a8nMvEJcUJI=;
 b=yFUBmjrFl/NnAPYQiylOWtvViT2FTc0P3AOHj/L7ebFEKKh4ZSnZfuKOPse00Fyzwnpo3VF9U7t/UmKjCUMu71REWCFA4ws+CI/z/WunMgtF/3jihupM60gCC7D6l6Mood7qU8kPFaKNczM62Lfqg3trbk226iVEZ+V8Id1oi1Uze7tMCeFuLFUad+lnI61+jsk5WrfdhAVV7hvfwm5n3NgPldP+2S4U6X7CYq3leImo3xLEOAHsRDbj9mJrfdHzfqoHj+nW1suXUfrt9ZNFTqhyfUKdhcWaIuJhx4lofN2RmY/TiGrKYjZW9Zl9L+gmwAxJD9x3fHXPs5mN1x4awA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjOGk9wLThEdw3din8pjMwhhWwhHeJQ2a8nMvEJcUJI=;
 b=OKEe3Mc7VJTyK9GsJWxu6+6KPGtVw37vX9AQJwEEKheYNWqpY+DX0y3ocIaFS7WX2eUEU6Q6txkO0tKNMScZWwXmNzPAqBzK3I6v7YURxO5YZ6zOXayyDO/irv7jVwRcUS0YnUvTIKA1kuAZQhhEdt+mDW/wzEr4pATaJ2wW010bnj5EabSqeCGrCmI/nrLLG41mVtSfCIeBJS9RARzCq7UiBUh93TMuVUkOWYyNUiFDmOPpv187zRNYcYnkmiyO4+5Q+j31LdyhhtWdWYnomLbiM1YzsLN0XI5eIvQwOkhxdmyTfrxGMuutzCgdZ3QwLclTNDO1aHI1b+yT0+P2pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by TYUPR06MB6241.apcprd06.prod.outlook.com (2603:1096:400:358::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Thu, 19 Sep
 2024 01:47:09 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%5]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 01:47:09 +0000
From: Yu Jiaoliang <yujiaoliang@vivo.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	RD Babiera <rdbabiera@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Kyle Tso <kyletso@google.com>,
	Xu Yang <xu.yang_2@nxp.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1] usb: typec: Fix typo in comment
Date: Thu, 19 Sep 2024 09:46:26 +0800
Message-Id: <20240919014646.1635774-1-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0042.jpnprd01.prod.outlook.com
 (2603:1096:405:1::30) To TYZPR06MB4461.apcprd06.prod.outlook.com
 (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|TYUPR06MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: 120ead0e-e333-4fe1-be90-08dcd84cf931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8gOUJhPDUENcFf++R+hVNefTy1uNSEgaWnP9Yx/5Q4I2pVE/lGNkpOAA7Qf3?=
 =?us-ascii?Q?MsCSYqs3hdjga0OENYJWo/9oSOH65Tus90Hk3UHgr980d2OAWEynS4EN4c4+?=
 =?us-ascii?Q?nAneotbbNYwwGwKIcTrD3LknRVVm4iIMntzof4jVZIqHRHQTztj/mYyVWGDz?=
 =?us-ascii?Q?PgHd1K/sl9Jz8rey8/FUGS/lPwLVV/U4PlOVSpid9fBligH3XY2f7ZvW80J2?=
 =?us-ascii?Q?+lqWHMeLtiSWwtiebRJCcvbQvqPljchIwlMPDq9Fa7zQaF0qPaKPEMLbeziY?=
 =?us-ascii?Q?jhJNMdu9mHSJk3cplPdIpqPt2c6KTUvzctWJzLhBGiEWGwl3Qaat0WACMfmL?=
 =?us-ascii?Q?3Tvkkf7mCoo8rwneYQt7Kwvi6VyP5kgk8cvuX/zkHrRN2mLyRrKB6W4afkN4?=
 =?us-ascii?Q?12wKr64b60v6QBg9QzlzXBNfiQlIECxauwm/m5NuUQF0yLHeF9/bE0O42s/O?=
 =?us-ascii?Q?AyYcGPQbTSuV54anTX7R2jEsNodj/Cxa72bBSwQeKfuE/L3OoAHPEGb/pb23?=
 =?us-ascii?Q?Mx8QwSe+7fuARLbns1SG8Xkvo7nSVOEO9Za8jELVoCmlu/aW6GW55/YxlESS?=
 =?us-ascii?Q?C/+UEabYS8eVR9+FSh09KHmHjm8FXMNGv8rCLQuPLECghgfto7YU91VKzHOT?=
 =?us-ascii?Q?ZBZVE9pa+nILX7cRa3A2mi8YTfNRPPQck8wBBhIFNGXmtF3nqWqQtHYW2Up0?=
 =?us-ascii?Q?sm/JXchA4dZttFzXr1BNRGUkaCpxAEsphU/t9YkwRTXyjWOum+AQn7yj1c4n?=
 =?us-ascii?Q?5uQEveN5U51g+dpiIaQ0jYJZv6Ytf7MccS5Ajpar2J2FdrdPY+AttcxvYEfm?=
 =?us-ascii?Q?wIvXRuXDNmc6jYrcOMT1CdOGzqryLLXmxVXkvtwj2rMXLor4VTPMu0w+2EzE?=
 =?us-ascii?Q?/cWI1OhZIePllS7ICXDC+esl/64sjKy8CDwtQV3pEc3d0UK/4TPFn3swq9OI?=
 =?us-ascii?Q?qZtIJkUj3ULlUZ3TRYqjTMOD8RTbSMsImq6FEgNaZ5Tt2fZ9clcvHZlE6C1i?=
 =?us-ascii?Q?wPihru6z4DWrnDd15TJ/+KM3cRQBxNk7PicxlLLXa8NPROgwzeOJZfNDe9Vz?=
 =?us-ascii?Q?XrqrvQMseQhQ8Kx9MuZQ34MzkUoJSDgVMHPDHuNQvQ1h2LW7S7NcFioy+hnF?=
 =?us-ascii?Q?YPJ+a/mOfJ98A++xCSfCkdiLXuYPXXT0GcPr34v63ClUqPBxnZUQaD8Ie4Sg?=
 =?us-ascii?Q?pEH8DwXLpublUZFo0NxoY6hW3D7ORfEoX/ZsL99w1h+aEHQRZoWn3W6TcLay?=
 =?us-ascii?Q?waOZdDJzbCR8ENefwSku6eJFmdTF3kYNFWLNrGJtp7wEg9MFp+XbYpDXZJ3k?=
 =?us-ascii?Q?E5kKQqtG3G9dGCZpkFedcHf7LpfyDoPdS/xBgjYxpvsTfV8Y/gvwDCZ/DyRN?=
 =?us-ascii?Q?NIttQsLP0+KSya67Gn7D2bmClW4bjQt4mevsevl9OAOncyDocQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9NgDb5uVaaVLQgL4y44+B6EEWEk3jGIz0apoyH+l9d1jQGMOjDG+yg9ncVZP?=
 =?us-ascii?Q?pfaOnCai6ddoZnnV9B7KLc8RW6LfO6tpPzaMDgZbkzBWbFiu7EDPlEqHu9wX?=
 =?us-ascii?Q?73N5lN1+8OYOMpdsnvBOVoJZWftPpTY10rRKSFA6T3PBRCaxyGKaGxCvEPx/?=
 =?us-ascii?Q?vwxicWtSbBeddNVEV3RBmnofPz+r9VXLsr1ideBx31hhSkyvtb0LCmrY0g5/?=
 =?us-ascii?Q?vp11p6TpTcZykT5fl4nRXfaOWYUMAoKNm1SuWinST8kwc5VO/PQyVsG7BB0a?=
 =?us-ascii?Q?MBOxXcITKLSfin2aYss0KZK+G18nTuPqxp1Vxb08qRsRagu8S4mD2wUHuk9u?=
 =?us-ascii?Q?Wcj744chtnZ1iuM/KT/EA/VqmCykTTiXBFV1CClW6LCKCTcRja9PerRK0wGk?=
 =?us-ascii?Q?VxfOWGR0QZPqBHA0n0rV2Y9EX9caXuT4Zqk6anNLWZRmjPnVJxcbmWpTDRv7?=
 =?us-ascii?Q?AsQKxhKO7huTNafS0gGRnO3a3OVlXY3/2EAUPrO/lIYMewZjJQ6cDkmoVTCd?=
 =?us-ascii?Q?H71j5DP+ZWCNHam/8ZSn+L4g3lMFZ02VvfJ4eG5cHsImzbC+8jPshNdo9X79?=
 =?us-ascii?Q?izKT+vIgfafWzj7TVcH8vaEGH2dgKM7iC+6vzChVXyydtzPYU138ooBTuf5t?=
 =?us-ascii?Q?pLvzPigId1D7mxR4aMuUmjnf1uWMBvDx4byP1BXXxfEyh1Jtvjw+YQks2IIL?=
 =?us-ascii?Q?SXY6blRPWRS/fZ2HSJAPoTX91MtH+JrXk99G4IgBYYKjIuuFcWmOba5mkKtI?=
 =?us-ascii?Q?EVNPSUYLBEo+m0Yq/vpI2+xcqvcsncmNefN0uXbzmTZfyZvOFfvaUIwx/rfg?=
 =?us-ascii?Q?XZ0tKjO3mdP+BrEO/Nv5FDcVohIEfbqesXmxBC2ZQMeIQZAiYPaU+OFdMuUt?=
 =?us-ascii?Q?98xm0DHzyEemn2VVyIrvEd+FgkmdZX0L7TS0QPUxxKkVAxMbx7/VdEcq9h9A?=
 =?us-ascii?Q?7rv4rpRwRn/daBjOT0hme2k01aw6PFSiFxwl82TapdQ4e7QQ+e6EsR/tijhK?=
 =?us-ascii?Q?FTzwjmCVjpSw662oDcXxezNKaGQ4eP3sId5H5lKIJQTj1GfKemlMxygKIQ8I?=
 =?us-ascii?Q?pQGm3YT78Qscqj9LNMvQkWwAHAfcTL2k+gSMrJo5MWX+oGCBFGmZWwhgFjoK?=
 =?us-ascii?Q?A8swTQWhrZU3RLhizZJvpwB8xvJNsfXNn4jSO4JbwcWTnUGkYdS0kWzQIOXN?=
 =?us-ascii?Q?VJJO4in8EHPGcErOYvv+SDCC9ddc7QN5pGOp6c79J+CYdU8WqSVelo3C+s3+?=
 =?us-ascii?Q?vf+YvVXQ33wW5XrtgDhLRglexUCCszRQLyaqpktC6YK9GDX3sVAPmqOcsc+d?=
 =?us-ascii?Q?ouFaKTCXkrin5Art6ObF46JCAML4P6vuGdcS33v4cBsQIV4p8GrSkTIXdysa?=
 =?us-ascii?Q?+QS+9xRuYtYStFmYBEe6JAhebCUEK2ZLOVrpiX+Uahl8JNSdOPbHOapBB4nW?=
 =?us-ascii?Q?TeJfuejlUNLsmj8gjRg8p+CpVfTvi22H7+fu00A2ilfbWzgSTwJfpG2UMtIC?=
 =?us-ascii?Q?UILmSqkbzKGoDq4BUCyY2Cm1mvNiqLMMkhdhm3avGw8N6h5vqtPx9PW/bZo3?=
 =?us-ascii?Q?BHtq07T3oprXGxoM4u0R2rpyWe0Ev8H8qXYRuKW5?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 120ead0e-e333-4fe1-be90-08dcd84cf931
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 01:47:09.2341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+83m/1jldgiUSq/pvW4qUffWpOnNaG4n9fXECvy/MpaYZSZSSB3ojm5YlIdDF8lgpbiaUqVDRMeRxOHY8DAdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6241

Fix typos:
reseet->reset,
reaach->reach,
compatiple->compatible.

Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
---
 drivers/usb/typec/altmodes/displayport.c | 2 +-
 drivers/usb/typec/tcpm/tcpm.c            | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 92cc1b136120..2f03190a9873 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -729,7 +729,7 @@ int dp_altmode_probe(struct typec_altmode *alt)
 
 	/* FIXME: Port can only be DFP_U. */
 
-	/* Make sure we have compatiple pin configurations */
+	/* Make sure we have compatible pin configurations */
 	if (!(DP_CAP_PIN_ASSIGN_DFP_D(port->vdo) &
 	      DP_CAP_PIN_ASSIGN_UFP_D(alt->vdo)) &&
 	    !(DP_CAP_PIN_ASSIGN_UFP_D(port->vdo) &
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index fc619478200f..b6486beda6ab 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5270,7 +5270,7 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_state(port, SRC_UNATTACHED, PD_T_PS_SOURCE_ON);
 		break;
 	case SNK_HARD_RESET_SINK_OFF:
-		/* Do not discharge/disconnect during hard reseet */
+		/* Do not discharge/disconnect during hard reset */
 		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_USB, false, 0);
 		memset(&port->pps_data, 0, sizeof(port->pps_data));
 		tcpm_set_vconn(port, false);
@@ -6066,7 +6066,7 @@ static void _tcpm_pd_vbus_off(struct tcpm_port *port)
 		break;
 	case SNK_ATTACH_WAIT:
 	case SNK_DEBOUNCED:
-		/* Do nothing, as TCPM is still waiting for vbus to reaach VSAFE5V to connect */
+		/* Do nothing, as TCPM is still waiting for vbus to reach VSAFE5V to connect */
 		break;
 
 	case SNK_NEGOTIATE_CAPABILITIES:
-- 
2.34.1


