Return-Path: <linux-kernel+bounces-203947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3E28FE234
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB72A28849C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794B113F45F;
	Thu,  6 Jun 2024 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="0Sjn8JvX"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2137.outbound.protection.outlook.com [40.107.22.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDDE13E8B0;
	Thu,  6 Jun 2024 09:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664651; cv=fail; b=efEQThqHqs9ECKYNcGL2Jjb/+HjgNX9ua4P90V2hSMSWiCMtLXTpI3vwjA9PGFNpSe8KQopD7yMdHnJfhFKQMtQ+W0T7MfaPuDzwiewckPDms286DeCn4/18JlImR2njtklOFwmtS6RCuNUABx9bC7+9oOhPbTeG+sszgQMLko4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664651; c=relaxed/simple;
	bh=oGHAmiaIXUBlb1bL754L4bhEDbYyEsEujOoaumKhU5Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=iGRBQdMo2brXHwBrI8LC+HUn1wewLQxL8TdqLI4S/OTI2Mpcuo3v6wG3O/XZW42tmO+FQ/M1rIfEG2AcsYQE4yjvhI9FJudV575CluOzk6d8nV4EPsXTx2pO5z3wu0RF0piSmV+yZnkXh4vQGrH4zS4OHkMytUxdNMZoMtgnfFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=0Sjn8JvX; arc=fail smtp.client-ip=40.107.22.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qqly8M9vKzho9rop16OrtqL17MPQzk5iWIuFHnWepelOMD0Yo3H3LvHCTJF2YNizyEihJ91cvtuuVXbwt6ISAI4chbVNNcOQ70mF+HM0LZULyPcQAfj4nnhFmTpUktWQgK4fKf2GFIJ6bRLlvxq9fgxnBs0VfgO+XYyNFLhc+O+M+lrHKOO7BoSS8/3+FAaS0DnShEXOgSXQDkBuV73AmROV5YieH7JUmVIMUTJ3bvXGzC+IwrhuALHaGJfiMCCy+5UeG2S6XIBO6Gg0Cb2eoG31QMSlw35vRZ9pdwz7oCQtzhl/A9i+0kk0E8PxA9gv4cY4CHNEAVBLdk/BZbwJhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgVPp8pUkqh1jiJMjjW5QlfFUuPCqjWn94zVfmSvdT0=;
 b=mOxJ2igyqVy8UbCbwqHZzRNMaMN/PmAGTg4DdOZanckbSiM4Wfd4Hpmc3A9mG6rd7vTu+lao+yB+OWgbnlenYuFOguvYjx+qrhl+JkmtxBgJzSNhrAvWEpKlYlL/h3BJpRtUD5Psuc0tlz04esgpL3D5kIUmOfhh5vBmI8/gbxl4SCLIfEU/uzseXm4L0sthY4B9bszWgPPOqlUd0+wL5bCZozmA0wCtkL9rEeajZuXvMOLpvJiZ2YQ5QbnPFHVoAAOzh9FYHXrx4SIZe6nm3gOLniBkbC4PjLR2x+MjlPMea17LKNBxqRWVCpmu2ysMwdXkedzPBdApbS4Q7K/Qyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgVPp8pUkqh1jiJMjjW5QlfFUuPCqjWn94zVfmSvdT0=;
 b=0Sjn8JvXW7UV7tPN5zxsQxeiO2G0CtF4PcZLTq+nmgzfxjdUa9DFfQkvWx4iVOFf+I+NhI7TevxwppMMhNHB0ksn6FIEmyypgLpovvXcwi0idTQMgDJUuXApV/dNOnphc2QMnTfciB2x+sscrGgB9hselmOwUesqEliefmTg26k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DB9PR08MB9513.eurprd08.prod.outlook.com (2603:10a6:10:459::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 09:04:04 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::a08:11be:8709:f5e1]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::a08:11be:8709:f5e1%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 09:04:04 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Thu, 06 Jun 2024 11:03:55 +0200
Subject: [PATCH 1/3] usb: typec: tipd: drop second firmware name read
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-tps6598x_fw_update_log-v1-1-2b5b8369a0ba@wolfvision.net>
References: <20240606-tps6598x_fw_update_log-v1-0-2b5b8369a0ba@wolfvision.net>
In-Reply-To: <20240606-tps6598x_fw_update_log-v1-0-2b5b8369a0ba@wolfvision.net>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717664643; l=2278;
 i=javier.carrasco@wolfvision.net; s=20240320; h=from:subject:message-id;
 bh=oGHAmiaIXUBlb1bL754L4bhEDbYyEsEujOoaumKhU5Q=;
 b=r4KNoC8k4VSaEhfrsjFcfiHVzBdM9agVHEPIE02+v6efdb+cmOpugYSW7DXUW7YapQQ1R+99x
 rU94TB5UcGbClpBuPM2ufQHxaW8jRn+Y97sPiHBxm/Ag7ZGCt7v1C5l
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=Vxk2/0sGIxM8rsKnceszFuSuHVfQwa1Yo8+is7BX2nY=
X-ClientProxiedBy: VI1PR07CA0310.eurprd07.prod.outlook.com
 (2603:10a6:800:130::38) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DB9PR08MB9513:EE_
X-MS-Office365-Filtering-Correlation-Id: 149ea9b0-4999-4dc0-e74f-08dc86079ce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZW8xejZIZ2dlbU5FZlBTQk5rcW1RMGYxY2xwanJ2QWw0c0FkajJvUDNPRUZm?=
 =?utf-8?B?WnJlNW9UL3VTalFscWxqc0lIK1pVaHRCVTRqU2wwNGlMYWM3d3FHc3R1TEpN?=
 =?utf-8?B?Q2RYVmRKMjhOc2lkYWRacHZKS0R3SUxYelBOaGlSODk3cjRDcVdWaWI2UUJJ?=
 =?utf-8?B?ODBnMVUyMWgxdEVTYVJlSGtQcmpZOFA5VUFKZUZQV1dxRjQrZmdrRFNiU1No?=
 =?utf-8?B?QkFXTWZRTU81Tnl2VmJVV3FIbFlpeGJjTit0U1RVakUwWFJJOWc4OWkyL0E4?=
 =?utf-8?B?SUw2R1h0NVMrL3NMcXlDS1laSXVST0dVMmVOT1lPbmhhTlFaOWZlbGc4UEhh?=
 =?utf-8?B?OTBTazkwS3RFUkdQeXlRekdKYlovbklHVUtraHRla2sxcURlMy85M1h1Rmhx?=
 =?utf-8?B?UW5RWThsNm9oNzV4bXhMREFaTDZHdDlwWmU0Y1R1dG11ZFVGa1A1UHA5ak9v?=
 =?utf-8?B?NW4yVjNjZnY0Q2hJMlZsUWNEa3Y1dTJYazJ4azBjUHcrSzdpVGlMR3pCSDc5?=
 =?utf-8?B?OVFhSWZoR1lsSURSdllsZ1hxVzYxWWhIQXc1VTMxM3gvNjU0K1FjaUxySXpR?=
 =?utf-8?B?L0drSnR3cFMyYTNoZkhlYnQwamQ0TGhWTmRBQ2RwL3dJai9JNFFkRUprWXNO?=
 =?utf-8?B?UktMVC90UEd2WGpIWFB6c1hsYnRwNUk0UUs4alRSdEcwRVZhSWhtb0N6WUU4?=
 =?utf-8?B?MU80L01UcjRXUld5N1FCQThweUg4TlVBYmRuTTY4c2xXOTJxZFkxVmY4eElV?=
 =?utf-8?B?Q1BvdndSUk4ySGFGNTByMlNPejdWNVhHblpBNVFCekRtdzlRdTFLdkNCTDFZ?=
 =?utf-8?B?K3hUVlhQeTlXbEp5SUVrRjUxRVJxblIyejdrOXdCSFZEdTUwMmJDM0Q1RE01?=
 =?utf-8?B?R2lKejNVMWdTWDNVaUxsSVpIWDNsUWFzWHRtc1BQYmZNK3k0WHZ4L3hnMEMr?=
 =?utf-8?B?WDNLMURkN2I0dnU5SzJUT25RektLTDc2RmVKeEJDQlJkdnJNTnMrZVIrSW9a?=
 =?utf-8?B?V09tWS9kdW9SbUpzYVhzZFVKQ055OEVlU20wUm1ZbEVMWUpyZmNiVEVWNHRL?=
 =?utf-8?B?aHYrcFBFVytDODl3eUc3MFljdFNtZTVIMW84cDVsYkIrNTBheWdEZ3dYcGFN?=
 =?utf-8?B?OXZnWnlibnUwUDl4WFJteUtpSlZFNHQzdm1SMmtINnBwWDlpOXgxb2ptM3Jw?=
 =?utf-8?B?TktpYkFhbE9hWnZNb2VkaDMzdTZad2FibXgzSG5kMzVFemVKYUtzNy9tK05W?=
 =?utf-8?B?YmNrdkMyQVM4d2dVczRWeXg1MXAvb01SZDZFNFpYU1owNDM5L1ZiNVQrRGZs?=
 =?utf-8?B?ZlZUcEJ1eW92QzEvcUYxR0dqYmo4K1VBVzVwRi9reUZocWtnTjVBUERSeStw?=
 =?utf-8?B?QURDLzJvS01SUDdNTEhYdW9nODREUWh2c0xvUFprd1NYWTcwbnVKOEdOd0JJ?=
 =?utf-8?B?cDFURmVjdVlUeGRQZ3NwVFc5N0NlV1ljWmx0T1Q0L3pWMEd2V3huVEQ3bCtQ?=
 =?utf-8?B?dTJ0YkdyL2JBUXczYm91WHVIUVRpcEI0YVA4VllxTXZGVDhsemp0MStkYmw2?=
 =?utf-8?B?Y1VLcktCd2tuOXdSYU5GY2pUTkg2djlyZGRhQmhic0V3OStzcG45WjVKTzBi?=
 =?utf-8?B?UFE4bWtIbExsM1FrbCsrZGdpSGp1bHlKeVE3VjBsS0dFQlFpT2JtTGlLSUs3?=
 =?utf-8?B?NkJSUUgrclRmajh2VzVFUlpITkdLMm9mWWQ3TUVqYkNwYkNJcWl3VXp0cGxU?=
 =?utf-8?B?YllkeU1hZWNlM1RiTU01MzNjdkZpdnNDK3VjOEs5K2dxbW5jMVVxNWFDQ0Y1?=
 =?utf-8?Q?/whfLzIIawnZUw1+WYamCyDB3KopZXViWLDi0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFBUVkZQYlh1Y0JuektnKzUzR2JiSWdCWUI0d1U5d2xjNllHZGZFQ0lDYnR5?=
 =?utf-8?B?NERHUWtiNGkwNnErQkM0NXJ5R0kvUy9JMnFpRjFQdUNJUHlUZnhsK0FqYmhQ?=
 =?utf-8?B?R3J3clVlcjVMSnNNbmw2N0lvNWllYlJmekxEMVRHbjl2MmZ5VWFJTlZLdVk5?=
 =?utf-8?B?aHE0SmkzM1hjVVNaRldENkhMVmxyMEtWZCtaM2dxNExiS2ErRDczaExQMlhC?=
 =?utf-8?B?U0R1WW5lUythS0pUaDFDdjdGaUlTTE93c3A3dUdUejBsN2RrUkhIUWNTcmJ0?=
 =?utf-8?B?dFZYcjB2S3dPcnFKSWMxd0lMbS83SWVtSjR1RDhiUytjTUhkUTQ2ZW94dUVL?=
 =?utf-8?B?ZEphSnk2MXV4SUIvWUNrQ3FoWmZtaU5saXJhcmdKcElkaVE0YlB0aWMyVTk4?=
 =?utf-8?B?K1luMHRITmpsREhHTGh1ZW11K0ZFRHRGRXljWFFqTnErTjJVUWlUT2xHdDN5?=
 =?utf-8?B?ZWRvajkvUm8rQlFaRHB2eElTamVaZWx1ZVVYRkdoOTJJRjVJTDVhd1lQSHMr?=
 =?utf-8?B?Y3YxZTdxR29jQTdkWG84RUhCSVZ0VnhOVXdDQ3JDZ0dGYUp1VWNHVUMyQ2lM?=
 =?utf-8?B?Z0JWQnRwd3gwVnk5YW10cjgyRlFsNWNEbnVKSFh1eHVnVWJnOWtCOVlSUXpB?=
 =?utf-8?B?MEp1cFV3MkZvMTAxVEpkUW5FRkJ3ZVV5ejN3amx2Vkt5YlNvWjdIVzNtODNM?=
 =?utf-8?B?QzJuR3dJV0NDQUFKc0hzNW1wU3JKMHNLNzVvZU5jcXRoQmQ1cVdDRzRzb1c3?=
 =?utf-8?B?V25GNklFakI5Nyt5NnZPUDRZdFBVamM2dlNMOGpqVVpmUlBNZ2NlVUJLTnpT?=
 =?utf-8?B?dm5PRk1zU0p0ZmR4VlZEL3J0YVlpL1g4Mnl0S2tZeSt1dVpUSXBqaWJtVE1w?=
 =?utf-8?B?blpkcXhCSW94NEd5aG1IWisvNzYraHpmcDZ6UDNGOEc3cWxCVlJrWlBCYVdR?=
 =?utf-8?B?Z1M4YnJkMk9xOHVVblltREZJV2x2eDc3V2oreUdDVlMxd1NlK3JXNnRmQkgz?=
 =?utf-8?B?MWMrQ0VNdi8rZUh2OFdyamo0TGFSUXdrU0ozdlVhaWFVU042UVY3UlFXMTdN?=
 =?utf-8?B?L2o3ckltblBaL3ZaQWl1TkRSb3NKL2IrQVZzdHBoc0xIVGEvRGRGNXNBZHJq?=
 =?utf-8?B?cnlINldQS2U3dnZVTGtMTitDTGoveVh4NzU4c3FWSTIzMXh4LzVnTWx2MFRL?=
 =?utf-8?B?WWNYRThNM2I0L3A3NHFrKzViWU4zdWJ5OHZ2NC9NT2E3OG9yY2dWc1lZQ2hK?=
 =?utf-8?B?djNXelhwdWU3Q3lXWlNYVlBkZnBDNWI3bExXTFNnZTIyYTFyVUlYZlNWaGdh?=
 =?utf-8?B?bWJ6S0ZsNnRyeGE4bG5ucXVTVmphRHpsOUNBL3NoeU1RWUtKeUplWE1YQTlO?=
 =?utf-8?B?dnVpaWtVdXlJMlI2NUNSL0tUQnBBUHFsdW84ekErWExQMi9XNFVoQ3h4UXFv?=
 =?utf-8?B?RkZWaElvcjUvRk5MR1A1cHJCSmJIVlM5ZHlzVkorSXloQ0grbjl1U1pkUTky?=
 =?utf-8?B?eVU4UmsyREtqUTRZWkNSZytOVzU4U3ZCRDBQdmdLNktwN1EzMitVSkU2WllN?=
 =?utf-8?B?c1NhSjU1cVVrNDlhVGh4dVlnNHNuMTY2NkkxMm8rNTU4dzNrNXVTb0lUNy9s?=
 =?utf-8?B?bndFb01BK3NBOW0rY0syRTN4NnYyd3k5dEM2TmZZK3VTYWpqZVZUMlc4Q0FF?=
 =?utf-8?B?VUZIYjFPSmZpdU1QMFpOV083VlVGOERteTljWlpSMFJtRkVMYU1CSUhoQ25q?=
 =?utf-8?B?MFdDdzZybVVlaDJkTUNTOEcvTGpEY1U0SFVGVUwzQUJGNTU4T1hjWnFRZThP?=
 =?utf-8?B?eWhjQmFobXM1SURSTzRKSFg4UDdOODRoM1BHUC9CaVAwbjBLYTZUWW1IdDdV?=
 =?utf-8?B?cVBvNFYvV2doNnNFMjhrTUU5ZTIrQ1lpNUQydnNkL1BrNUN6RG5yMVNmZ0VY?=
 =?utf-8?B?d3JPa2M1NUExYVV0MzZPZHdYSTR0YTBjSXhmbmd2WE1BVWVSYXR0UjlLbTRO?=
 =?utf-8?B?dDlyL0NpSVdDclE0SXY5cXVJNU1hZ25INVZYTmh1bG1MY0ErY1JSQkJNKzQ4?=
 =?utf-8?B?Q3kvMDgyempWTG5zbmRydDdJbjI1T1U5YXlWL1ZidFo5eHg4UHcycVYxRFYw?=
 =?utf-8?B?cXNONE1IMkJsamhTTkl3YnpyMXNOSkJieVBEWVZSaTZ5TnhQank4enNtQ2sz?=
 =?utf-8?B?dXc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 149ea9b0-4999-4dc0-e74f-08dc86079ce5
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 09:04:03.5791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: laNCqxEUZNcPkI0p1r9DfuI1GyHVylkNayYNcbGEbIXCZdHF6MXGUKlp18jhoL3F9e6WM2hffOJmde9IqKTD0lVfQ3RKNcApWBjh4Z2YKFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9513

tps_request_firmware() reads the firmware name and there is no need to
repeat the action in the device-specific implementations of the firmware
update mechanism.

Provide the firmware name as a parameter in tps_request_firmware() to
avoid repetitive operations in the device-specific implementations.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/usb/typec/tipd/core.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index ad76dbd20e65..851b0d02727a 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -892,19 +892,19 @@ tps6598x_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
 	return 0;
 }
 
-static int tps_request_firmware(struct tps6598x *tps, const struct firmware **fw)
+static int tps_request_firmware(struct tps6598x *tps, const struct firmware **fw,
+				const char **firmware_name)
 {
-	const char *firmware_name;
 	int ret;
 
 	ret = device_property_read_string(tps->dev, "firmware-name",
-					  &firmware_name);
+					  firmware_name);
 	if (ret)
 		return ret;
 
-	ret = request_firmware(fw, firmware_name, tps->dev);
+	ret = request_firmware(fw, *firmware_name, tps->dev);
 	if (ret) {
-		dev_err(tps->dev, "failed to retrieve \"%s\"\n", firmware_name);
+		dev_err(tps->dev, "failed to retrieve \"%s\"\n", *firmware_name);
 		return ret;
 	}
 
@@ -999,12 +999,7 @@ static int tps25750_start_patch_burst_mode(struct tps6598x *tps)
 	u32 addr;
 	struct device_node *np = tps->dev->of_node;
 
-	ret = device_property_read_string(tps->dev, "firmware-name",
-					  &firmware_name);
-	if (ret)
-		return ret;
-
-	ret = tps_request_firmware(tps, &fw);
+	ret = tps_request_firmware(tps, &fw, &firmware_name);
 	if (ret)
 		return ret;
 
@@ -1155,12 +1150,7 @@ static int tps6598x_apply_patch(struct tps6598x *tps)
 	const char *firmware_name;
 	int ret;
 
-	ret = device_property_read_string(tps->dev, "firmware-name",
-					  &firmware_name);
-	if (ret)
-		return ret;
-
-	ret = tps_request_firmware(tps, &fw);
+	ret = tps_request_firmware(tps, &fw, &firmware_name);
 	if (ret)
 		return ret;
 

-- 
2.40.1


