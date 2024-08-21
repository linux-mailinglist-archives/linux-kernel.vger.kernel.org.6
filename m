Return-Path: <linux-kernel+bounces-295168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D949959815
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E3B3B213E1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDF61AF4ED;
	Wed, 21 Aug 2024 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="qk4WO/8G"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2066.outbound.protection.outlook.com [40.107.215.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9A31AF4D1;
	Wed, 21 Aug 2024 08:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724230383; cv=fail; b=LjZ6Au9HKEWkZkc7/O0slVnm6iCDEmA7qaqNSTCyJ9G/CAIAIaRPCxZvvLdIIde2mw/7tyha4bIRizIxEUd2Ng42s0gT/VIjNqHRoGFU4cSYXe7vazGRXOw69e0/OFyso6nlyuiWzD2jUhiwa/2m1/jYW1Y+L2Dsk/zXcad9wQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724230383; c=relaxed/simple;
	bh=y4QEukpU5xD45n6HEi550tPzi4DkH0yUQyIPT/vzSUc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=H7o1MXyU8cUoZhJiw7e6bVWMVeUuPDBVhduFZjKZVs15DXYePr3bOt9E7f29HsA3GMMM7DhJpfRxTsLkppmYTmPBJ/NObdimmfMW73Yz76n/oGnJyDtFITuH2eA3GK8EzJQaqX4Lz/tEih+0Eeim9t6zzp1CaBoXoUPZq6UzUKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=qk4WO/8G; arc=fail smtp.client-ip=40.107.215.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ul95arpx3NEh/Myk2m1SUbFI4OHDJsS3HFwW8EB0A0UoPGNhvBusUzz+BU8u35CHy3u0xKXX2AjxlYbPRkKSSGdr3gdtmesCPZhMyz/TOp6RnAsh79C00R9QAgLKdK83VDoER1Hqe94snADer7p83POzLtWcHyy911+dr1BtsPA3OOST31Ficygo1QXb5rwcc69RrgANf+/ws8i6EUB02ql3mfmAVCOA09Qr5pfda95e4qeFgxjO8z+j0HHPF0+Lz677KZ3MQNkkqO68rWU7vfi35PD22crUgYv7CRtOFdKdOCE2Sy8Gpg2lY60HKdYOeSMpZ5bD+OQ0dz+CJbplyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFfKy5PZVpsw8SorO7mm1yVV7hoGftDbeN3fXUqDyPw=;
 b=uGur08sYzA9gZesbS0l1u31t9ArONmLMbvVVd+rsbdDSDP20BkjtjSbPT+6pYr5J+43edfHmq2WuM1ezCAFS1vtvXox/bunYMUrWnjyePEvgGPNauQw2slM7ska1+V+kifnnQpxwyH2Cb5IwSnaQE/CiOXzrGGy3Cfki16s7jt0aNvfZx77mNTLppti0U1FGHA/jl04sXnuyjBawDSg5tmdZvBLZpLmFy29CZnRvCifkGapc7ai1bVYG2RggNDjdSiTKV0K/oP2LAOJUacZArS3ynshQhjrZohUDvyGMhPMdM2+nKNd7pQ4ASrxL+ryYQ9DqcRe5maIZjTiKOO1F/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFfKy5PZVpsw8SorO7mm1yVV7hoGftDbeN3fXUqDyPw=;
 b=qk4WO/8GQftTou1IEU8PyBiQKQ3wlBEntX3mkzYmt2oa8EdDW0J8hQLiKs7uawQXkudMoCF26rBzbhgRrj6xNcoPmhnRMETFDhFbT6BkLtUH2AXd7GpUWiVBE68ixGKxK/9+5Cy1rFWDUPaki58X/hNcaBJIsro2GlHP7hLNG0kK3lv9mo5y++IumkkBjCpMRDUGdkcEpMLkUAvSHtnyhlTa8oQuk1bbixcGVybH/sHMKnCOf/jGSHrg+jUfGlCYfKhp86nmMXXT81RddF6ABr/75AgZ1+cJWHoaVL+v0kYpKYq/FnZ2z4aJTcQchnWcRHYUf2pUzIkeABCRq9EYdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com (2603:1096:400:283::14)
 by TY0PR06MB5005.apcprd06.prod.outlook.com (2603:1096:400:1ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 08:52:56 +0000
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a]) by TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a%7]) with mapi id 15.20.7849.021; Wed, 21 Aug 2024
 08:52:55 +0000
From: Yuesong Li <liyuesong@vivo.com>
To: gregkh@linuxfoundation.org,
	vz@mleia.com
Cc: u.kleine-koenig@pengutronix.de,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yuesong Li <liyuesong@vivo.com>
Subject: [PATCH v1] driver:usb:lpc32xx_udc:Remove NULL check of list_entry()
Date: Wed, 21 Aug 2024 16:52:45 +0800
Message-Id: <20240821085245.25348-1-liyuesong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0200.jpnprd01.prod.outlook.com
 (2603:1096:404:29::20) To TYZPR06MB5709.apcprd06.prod.outlook.com
 (2603:1096:400:283::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5709:EE_|TY0PR06MB5005:EE_
X-MS-Office365-Filtering-Correlation-Id: 58c973f7-4220-437d-a483-08dcc1bea645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MRMckOxo+MjEujuPZRyecKs0tMJAYrDWjOpHGUtrS0IumYzS4OxyRfqsE4Ez?=
 =?us-ascii?Q?IvXYWccdo4MD3YGpSs6oRENQTZcclPdoLm37Tr1FcIOIrrTRaqD2L8D1mXnG?=
 =?us-ascii?Q?rjpr0JW8WK2gHd57uB/3TFKSqkNxRF50rPIuJY5jVukxwPa5eRjcpPaEXPtD?=
 =?us-ascii?Q?9b5J0nzFVvfy2jNwTanYGyriW3pJV9b3G3lvm09BcJkr3HkPGRK1ZOjGmomM?=
 =?us-ascii?Q?Mp8kEs3sQkdLaByHbLbxg158tFZk3nUyN9cbBdOyAkxWNHUxSjfp1LVbqO/t?=
 =?us-ascii?Q?UNu4CgqQBjl5Y+mWF34dM6iDR3TUWJUlpKtRH48f6rgrvWiwSnuuSsdMYN5C?=
 =?us-ascii?Q?XowJxRn5huu8YAA7F95wc4N4fMlGBAQTx2M6E4Nm3xkHVT045+7YK2l/j6SK?=
 =?us-ascii?Q?fVlRk+yZotLQCGpNNBAXLjMF+ffeXqYOSyLcL6txUYcnjm0qRJ2oDZJC5/Af?=
 =?us-ascii?Q?JfAUwASYrqrgJlkMjz999+oodbKtaWIuiWFEe8Fp1AcvXXyW4sv89o0MuaKS?=
 =?us-ascii?Q?NBBexmp8qPppPf7UOAbzKcez8RsiuQ4jYfWqfQWZHHLfzNC91PaA/sWGkVUc?=
 =?us-ascii?Q?A0WIlj08kpSnelbUjhJsbPwFyx+dRkLMuwYLIeddTD6ftoSpOYhYDLsiU/ji?=
 =?us-ascii?Q?NQy8bgR1dmf+cdTNbHJ6FRqgyYghbdMZYsw9inEkbHzmGoULibW33Hi//gnL?=
 =?us-ascii?Q?6a4Lqz8fHlTS5mGnoZFn9SAswbo7NMqU+YCqgumH4124Wk6vTK6m+avkrLTw?=
 =?us-ascii?Q?QRYqGrhDOABlrtufch6600E+L3J2FRZ1xJ7alhwJcxhEtrJSgh28xc9WLUO6?=
 =?us-ascii?Q?0JtcpuMKFTKSBOC3oReUohdEbQJO5TJXWjf9K0JBvw305GqGuA6xfa3OrVjK?=
 =?us-ascii?Q?xF+kWdngQtllDlvemJabfbPposZIXP+6LOM0eMkPY2E5LFVRbBWA5BcM2MMI?=
 =?us-ascii?Q?dRo1U/CGgoR9ehunQSaWybkE4ilucIECFzYrX0OznPSgTrt6EKPVk2hI8dKZ?=
 =?us-ascii?Q?ieRD/MQ/cK2KFYK5Ajhqpv8dmJzfPjHdhYJ3v/gt0LQFm5aKYHApB6sviD8i?=
 =?us-ascii?Q?hlz8d7EDnsUaDOvnIPrfQLoOkfmT50lOupj61bJpxsthkyT0MDkFgg6ho81K?=
 =?us-ascii?Q?8vod9HN97XfKYaJ4pmlIw6UEkf9cJVyo4ufw8B6TZBAxNgvpAcv/cDuJ9ajw?=
 =?us-ascii?Q?ERYFrgz96BYcSd6BOMBeCaUDj/waonMjXMOGkr9pP2Vi6vGM4PqIUVEkwFJD?=
 =?us-ascii?Q?RCknwvXoTg6t73/dsSumVUENZIZg2sLIM4zflYCT+iTVIZMrFxKiSNVkPn3e?=
 =?us-ascii?Q?L0TDNwPme8fsTREfM+YNbUGG4tWiOFBtB3xKiNS1aWk6GMyEgnhCbwl7/W0f?=
 =?us-ascii?Q?eIWgpYfsQlYylyv3imn9fO5S6KuZxKugQGj40rIRArPOKWZgcw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5709.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?outoLfRlpqFOQRUoma4pR/Thyl2dBdMyX/DA7e/fDbmvc0M5kmfUK9Dngos7?=
 =?us-ascii?Q?vyzHlrWvwi0PZv95T9Up7/cfJgiEh8NZQNJFuVNqElV9JeOShfea8WXa3Vso?=
 =?us-ascii?Q?QpgX+KLpxFgyHbiWdjSL41YihIs6xnpL/8z/YytrlWCKD2DlaDSEcekeilya?=
 =?us-ascii?Q?jOuUeKMDkSRHZYg/ApurlIy6L8omt03DlDUZ5CTB9cMEI+38Puisdd0qXw6I?=
 =?us-ascii?Q?+uz4pxhycuNfliUpViZBEwkVrBn85j5EBUAGd4YcZTA9KABCM+4wQya5vvXR?=
 =?us-ascii?Q?Q0ifBafDzqA5HV5nxUIGkFuV0uFROWUWJIkIog/scgZytKOJB2DsQM9h8J4e?=
 =?us-ascii?Q?cOHS6tgLPgiAZ2mvrgdx6JndR4C3uz1t8ZmYbL/oagWjy0GhYhEBrc8L1kmk?=
 =?us-ascii?Q?qJapY6FUzIbnOm8vPnnZ5J3YnVDrnwtoNisYviUd7dBq8aWCnAk9qR3XkeEE?=
 =?us-ascii?Q?vCz7s841qOvSHWO18L/2/wq8/dXZP/RZU6EioSY3bLQGfDBpajedHlXau4bK?=
 =?us-ascii?Q?S1+np8J4r17o9EkPsGGJoHsJw7V+29hhWYeBrAe4wXzDAkP2H0C6n+GKMMj5?=
 =?us-ascii?Q?FALb17Gf2oLIYrln+o16vXPwBeHM3grYdpCgnBNGifSnObTSdOQn4Mhbj68p?=
 =?us-ascii?Q?C8Vs+YH1QLmC1VMUTZzNYEgyxVzWWC1NvEjwaz1JQo5tbW48YKmiw0mJOJsr?=
 =?us-ascii?Q?zei77ugJxOqrcAW2EV41s+LKYA39/nimEnhOEHKaLm+fD1nvE6aberMpOH5S?=
 =?us-ascii?Q?xxjOjfM8dRNy4imfTyG4aPiKcG7vdEqJd5K2VwCR6256Fob5r8aTAfUESWyF?=
 =?us-ascii?Q?9fxTmAF/X8x38Sag2vE2xfNw5r6sVYLN/zdOpMggLjRfc+dRkmoSCZN4MUft?=
 =?us-ascii?Q?3YrbZcQnQ4xvNJ/Br8wQq+oorJNeN7q2Ulp0eDiAMaDsTlOMWW+axoJIV+K7?=
 =?us-ascii?Q?h7MixPgakvufk6L2ARTqTFe8v0TP4cxX+343yteEvH/PyMUMrdqyo8S+qHY9?=
 =?us-ascii?Q?SeVlmlU/6bM4MlBVzeDfJkSNVyLf8XjILQt05qZcOwho/1Vb9EcjLQ48a8KJ?=
 =?us-ascii?Q?gqm/sylypTKCX/Z0/zJHNjTsdLP+DWEfqeLHlYohujxq/fdykqBeWEJbvJvW?=
 =?us-ascii?Q?0hYxfXTVdpHy5aRaaj5QvlE3RJ9lLFXZDjnZp4997qRtTUE6/f1o2NvkKpMG?=
 =?us-ascii?Q?KD/Uaz40tVFlqMWjHWxOQYxWIziB0roFgqIPooBPqC8JZnMDRWvzr/mCZrF7?=
 =?us-ascii?Q?5hJlg7ynSyRkKq64FO0B/w9qTjZqGhGKEUUe8by7wKk/8DZLBALSZTVA37RG?=
 =?us-ascii?Q?aADx5mbpK0+BTu2ZlNjsWds/akmcRrCp4OHN6ZBFDVZbms79LuoHq9bzybrK?=
 =?us-ascii?Q?gHLXiZFGYRG5pbL2vMjdWqgj1QhHD93DuxKPfl5kt+JfdzQbHJ93y5bo74VG?=
 =?us-ascii?Q?bv2k3YdzeIEW5gFQk17J1U+eeJM8ebWc1Tpa7QEjsZX4hHLGjYW82D+cpk+K?=
 =?us-ascii?Q?VhlbhnjqJ+BSzkA9lCy6H1Pkqwa+LelzrcSJvA3jUp9NLJiPkt/M1L6l6nVh?=
 =?us-ascii?Q?CXeayRi5asqcOzjLYaMD4d2QhHLIrUBlGg4fEqGT?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c973f7-4220-437d-a483-08dcc1bea645
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5709.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 08:52:55.8887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4kROfHFmFyOnkY0GBbyOqi7oO5Ztpgjt1qprwMAUvm68SOP7A6Gnhufyib/MMIQpW0bhmyRs/k9os6zxOQdZcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5005

list_entry() will never return a NULL pointer, thus remove the
check.

Signed-off-by: Yuesong Li <liyuesong@vivo.com>
---
 drivers/usb/gadget/udc/lpc32xx_udc.c | 67 +++++++++++++---------------
 1 file changed, 30 insertions(+), 37 deletions(-)

diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index d5f29f8fe481..3bfd889ed56a 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -1487,31 +1487,29 @@ static int udc_ep0_out_req(struct lpc32xx_udc *udc)
 		req = list_entry(ep0->queue.next, struct lpc32xx_request,
 				 queue);
 
-	if (req) {
-		if (req->req.length == 0) {
-			/* Just dequeue request */
-			done(ep0, req, 0);
-			udc->ep0state = WAIT_FOR_SETUP;
-			return 1;
-		}
+	if (req->req.length == 0) {
+		/* Just dequeue request */
+		done(ep0, req, 0);
+		udc->ep0state = WAIT_FOR_SETUP;
+		return 1;
+	}
 
-		/* Get data from FIFO */
-		bufferspace = req->req.length - req->req.actual;
-		if (bufferspace > ep0->ep.maxpacket)
-			bufferspace = ep0->ep.maxpacket;
+	/* Get data from FIFO */
+	bufferspace = req->req.length - req->req.actual;
+	if (bufferspace > ep0->ep.maxpacket)
+		bufferspace = ep0->ep.maxpacket;
 
-		/* Copy data to buffer */
-		prefetchw(req->req.buf + req->req.actual);
-		tr = udc_read_hwep(udc, EP_OUT, req->req.buf + req->req.actual,
-				   bufferspace);
-		req->req.actual += bufferspace;
+	/* Copy data to buffer */
+	prefetchw(req->req.buf + req->req.actual);
+	tr = udc_read_hwep(udc, EP_OUT, req->req.buf + req->req.actual,
+			   bufferspace);
+	req->req.actual += bufferspace;
 
-		if (tr < ep0->ep.maxpacket) {
-			/* This is the last packet */
-			done(ep0, req, 0);
-			udc->ep0state = WAIT_FOR_SETUP;
-			return 1;
-		}
+	if (tr < ep0->ep.maxpacket) {
+		/* This is the last packet */
+		done(ep0, req, 0);
+		udc->ep0state = WAIT_FOR_SETUP;
+		return 1;
 	}
 
 	return 0;
@@ -1962,18 +1960,17 @@ static void udc_handle_eps(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
 
 	/* If there isn't a request waiting, something went wrong */
 	req = list_entry(ep->queue.next, struct lpc32xx_request, queue);
-	if (req) {
-		done(ep, req, 0);
 
-		/* Start another request if ready */
-		if (!list_empty(&ep->queue)) {
-			if (ep->is_in)
-				udc_ep_in_req_dma(udc, ep);
-			else
-				udc_ep_out_req_dma(udc, ep);
-		} else
-			ep->req_pending = 0;
-	}
+	done(ep, req, 0);
+
+	/* Start another request if ready */
+	if (!list_empty(&ep->queue)) {
+		if (ep->is_in)
+			udc_ep_in_req_dma(udc, ep);
+		else
+			udc_ep_out_req_dma(udc, ep);
+	} else
+		ep->req_pending = 0;
 }
 
 
@@ -1989,10 +1986,6 @@ static void udc_handle_dma_ep(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
 #endif
 
 	req = list_entry(ep->queue.next, struct lpc32xx_request, queue);
-	if (!req) {
-		ep_err(ep, "DMA interrupt on no req!\n");
-		return;
-	}
 	dd = req->dd_desc_ptr;
 
 	/* DMA descriptor should always be retired for this call */
-- 
2.34.1


