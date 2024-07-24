Return-Path: <linux-kernel+bounces-261207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF5F93B41F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66E141C238F8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0B815F323;
	Wed, 24 Jul 2024 15:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kAxJ7STB"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2086.outbound.protection.outlook.com [40.107.103.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC47B15CD49
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721835992; cv=fail; b=osHcigDAqd8df1QdDZmsNai83HXUwgKhFvQU5s2btUXhiYl7fnFZ0QSS4dvkXEULI60UjjRpCUk7WWzWchZhOXu7Kml3t1Vc2zk6tFa7zkCLRg+rUKH8+fqNfEb/wE5J03YGYEbovRkI2aSx2/VroNVp+mLUuw/S2jqOB5PNYlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721835992; c=relaxed/simple;
	bh=8AD6/oyw5maO8G3UDbDr2ZOWPiM7trJt/A903JRssEo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oftzKPV3NFYh6/Haodc0XshDmIiQEwFDh0iDsqNz9XvpCYJ+msNNmSWWc+wmqTZyAdiiwEeeFEho91pvTJl8zI0Q7TnDFqc9c7pPby4lod9czP5dKkQH92IpZEvNoTqYJlky6omPPqD7U9zU6LMo+8Onb47DRZ/y9YUu79eyVZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kAxJ7STB; arc=fail smtp.client-ip=40.107.103.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5eKVmHUDVhl9/BUz0qqvhhXz6099jSlA00Y+qW/KrCfnA8GbdHKe8lRPkz4CVmSDbwC4I2exWKsmqoYhZ2IznHkJUcsD1wj9n+SFKPmc1eEExU60w0UToX1UYmaDufu5A8kqPaLQoFujsodcNIBY1YQ/3LH1XaQN9LombJQ4/ZMBfEJ5OoNkP9jJn8CCTCvB1i9hRJGoK254uCIr7zVCBh+81FVMDCS/IVBEbjTNgzTUJuA5Ek3PxO6+9AUXqVMH/aJZEybSrchT5hyybMsNxRRhaYzrChpfhUi4guM7dJcJibrj6DSIB2D/mHsGWLZERiTzkoQeRFWlaNAAXJukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4JXtZRVQMARG9qMgKwkntLShr3lq15YWhLhU+kDbuA=;
 b=q3fvJMfno1+ven8LgqtwIzTua7vjX1+93EjwHocXR4Mu8RsEwaXFjxUSlRwZ+cr+wFdI2MQHRMYYf1S1mm8iupFtLnwKV0FZ7rp7VdUupKwU0cUI+2ORM/QB8gMu9dR1TpASNlY1S2HlQOr6oTH/jTl3lY7EM1KGoFQUBvUgAGbIAErlg9yQVUp6tkQiNI+D+pZZKAJYHOOtPZBHLKcL+ZDeUMEavrqVxzOzCI/eo/aBhxa8fzuR67GLyf10flynBAQOXQemfTlNkXUT/mlY2rL3EB4mBPMOMpV8sV7xjUxMsJHaT6Hx5rpdp1KZhZ45X4mHLh6z1AA7BWIt0VDJ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4JXtZRVQMARG9qMgKwkntLShr3lq15YWhLhU+kDbuA=;
 b=kAxJ7STBo6rnxGtDfqQThzNbEBHICtfj7kNiq8N7mWaaDOL4ipEhajZrcfUYwNZu12WSrTELCytJdkSs2CG53ATWZLPFm7cF1r5f4hed+iOiroakSevWagcuQ2TpfwQLkewKvt25ApG2VWqZI+bGvGJOKZNzISuGEx3XNmRUUiTjwnlfYSetKcvVEa7efCp8N7li3T1eQbUR7pY1rdhJAK4LHN62OXNZ9dTfGu6FxX+f22dBzhdIfhs0L3fDyriM+X/OgvqXHsAnwkHaMbYlBLEkujXFOqwZVezxjATZUXvAHAn5/SJEG8E7e348YNx3oNb32g13ocb9AJ3rrquICw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 15:46:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 15:46:27 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 24 Jul 2024 11:45:52 -0400
Subject: [PATCH 7/7] i3c: master: svc: manually emit NACK/ACK for hotjoin
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-i3c_fix-v1-7-bfa500b023d6@nxp.com>
References: <20240724-i3c_fix-v1-0-bfa500b023d6@nxp.com>
In-Reply-To: <20240724-i3c_fix-v1-0-bfa500b023d6@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Parshuram Thombare <pthombar@cadence.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Boris Brezillon <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721835962; l=1155;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=8AD6/oyw5maO8G3UDbDr2ZOWPiM7trJt/A903JRssEo=;
 b=NVQR/STY999tK82BWZmJWzz48Ldla2y+1bpy7jeCH5M3rNEXgYj2Hd3ufwIsSx2iMb2vJ3Eoo
 oEcZmcGFtm5CQfNO/tnsG6nnlQLD+owSo3uRPyE0hHniUOyiHRovvLi
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0008.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8963:EE_
X-MS-Office365-Filtering-Correlation-Id: d4e6e549-5d11-4031-ffa9-08dcabf7c77c
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Vy9RMEJOVFJrbTJKY2xFQVBCeTg2WkNUcFh6SktmNU1lbWg5ek90UTI2WVVz?=
 =?utf-8?B?U0pvQVhTNUkyZkpPUy9sQWQ0aWRaNGIxdkxhUUovRmVJWnFPaXBJZTI1Z1Rs?=
 =?utf-8?B?ZUkwQnpKZkQzdDVMeGxWa3UrUzJOSFk1bFJVbm9HU0QwM0kzcU9VeXdVbEto?=
 =?utf-8?B?WHlhTVpRRlUzb2NxQjJ6ajBla0ZtUmJVT2VtcUE1cjFjbzBUTnBMOE9MSXpj?=
 =?utf-8?B?SUJtVzZnMHY3dTFORnZiYUlwSHp0aDQ4RUdlTUlYM0xJU051WDZWTUNxY3J6?=
 =?utf-8?B?UnBNT2FEL0VWWjJ5MjBiTXdlTCt2alJ0ejZHV1pMcDUzM3c0Q2VJTzcwU0cy?=
 =?utf-8?B?Sk5ZcWVhc0RBTTZ6Ui93ajBHU0I3WFlaNUgvMDRLaGFBTHJncktveWszMHZp?=
 =?utf-8?B?TEJ0MFdPZnA3SmNwY3prNFMySEQwUlNqTnE1QVFrc01nVTdWZ24yODNDdys3?=
 =?utf-8?B?Qm5KanhWUDF2K1dGdDFJZXJ0TkFENWhyakRnQWdXNWdMOXp2Tno4ZVIwa3Va?=
 =?utf-8?B?bEVDck10STlvZ21FczlhcnJhZlVFamIzTTkxTG04RXpneGpNZGJCejI5NWJN?=
 =?utf-8?B?UERUeE53bHdyZ2VQVHB3Uit0SGlNdDEySDREMzJuMnhQZmx4UGJXK3VIVUFE?=
 =?utf-8?B?MjlZd3d2N25kZXNGZjJLcUdTOG5CMHQwT3FuNm9jY0xvTUc5a045SWVaVVRE?=
 =?utf-8?B?aTBhc0VMYUpxeitZV2dLZlVLUGZ4eFFOd3A3Z3B3RFUrTDVQT3dUMVhuTFI5?=
 =?utf-8?B?MjI1VkRJSXhTa09mUGVOd1BvTUV5YnY0RFduVmlTU1lJVCsxa2xUY0J5YUlL?=
 =?utf-8?B?N3FWME0wQzA4YmMvc2NNZ004aFI4UDY2T29neWRna3pGYmdBUUJURlpYWDRC?=
 =?utf-8?B?YmNZTmRHVzBWZU5sNjBGTE9hdUl0OG5OVGhubnVLZThGemFpN0hXVXZOZGV6?=
 =?utf-8?B?dFBKNTBmeXBYZWhLMXVYeUZFcmF0a2NyMDg3L1F6dXhhbkNQTGhpdmpGSERO?=
 =?utf-8?B?TnhUT29Oelh6TTVpbWFlWXc1eGY4SjI2cHlFbzJyVlFiRnI3MFFCKzl2ZEZ5?=
 =?utf-8?B?SmlWSE9FUjBWV3ZoTnNGTkE5aGxkVmJkNVM2RCtOTTB1UXp3OVRqekw0Z2VP?=
 =?utf-8?B?dmwyNlovMVZiZTN0a1Q1KysxeU02SG1IY1VKeERzRUpoVHpnV0ZoMXZibldH?=
 =?utf-8?B?d2xPbWo3S1BON0dZVFAwcVQrTGtkVUpJS0E3OWozaDZROXArNlg0OVRCY20y?=
 =?utf-8?B?VnhmV0hwVEVMQ0pMQXhyU2tzZ25kVEJuN0hlTWhpeVFQQ0VySlRGc29VNk15?=
 =?utf-8?B?YlRNRVdrc3ExWk5oeVVGaTdjU1RlYXkzeWRucXFCNWxMTUFndi83ejBuR0s0?=
 =?utf-8?B?aEdjeVZYWk1RdHErc1FEM3Z3aFBPalNJNnMySmE0NGhRKzBjTTFnaWd5UlZw?=
 =?utf-8?B?Nm9mMTkxSUpSbFRKNEZuWVk4eVk3Y3ZIT0d4V0VncktUQkpMR09JN0VSY2RT?=
 =?utf-8?B?cmVVNFJDSi9WNEJKNUtOdW9HZWFDQ1RXdzdZenBMWS85aUY4czZXVTh0aDFI?=
 =?utf-8?B?NGduYno4N1h2SjFMNm1XTlg2NVBRdmR4bmxYT3h1K2V3QVpoUkxFUnJqTm5a?=
 =?utf-8?B?Rk5wL08rY1JQYTdlUXBsRUQ0aVR6cVlZekljQ3hLbUtCcFpRY2swRForREVG?=
 =?utf-8?B?TnZNNXk1UmJYQytWNGJubjRFbnlBaGdVTUkzbTJSY0FrOUpnMlhndjR6amtM?=
 =?utf-8?B?d3FUNzRXa1JSamc1SUdBSHE5YTdGdXFIcU9NUlZOMlE4SUFVZWMyamhQMWxM?=
 =?utf-8?B?K3lBeDRkTnNmbzRsa0x6dml3NUpodnFSaEo2VTlwbkRxSnZ1TEdyY2dEYWVX?=
 =?utf-8?B?K1UwQXpTZkpubWsxNDhFS3pHNGNUNXI3NXlNY0hXVVlyU3c9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?YzIxWUUzMjJtVnlYbTdKbW1Cbi9FOWN1OFdseHJsZnVDM2dGcTU1QVJEQXUz?=
 =?utf-8?B?akwrV1YxR3F6d1VaeCtVUGU1djRzYmpXVDd6WkxqVU1iU01PR01EWUpySlNo?=
 =?utf-8?B?U1FibC9KRmVLQm9DcjVoYnlFdDVRUllRcWdWQTNvSFhVSXRmUmgzMWlMK3R1?=
 =?utf-8?B?VkZvUko2c2xmYXdUbFlzSnJJa0lMWkQzQjNNQlJhT1QrQ3h1OVhDemFhWHND?=
 =?utf-8?B?UG1TWkhBbjRCREZjUzJwZEVSM2xMSlo0LzhNT3UxL0RZV0I3dDlOdG12Snd1?=
 =?utf-8?B?SWNwaWJ2aSt4MkNNd2NLMlRGMnFLZ0VHRmN6N2NHUndwalpJMHh6dDhWZzdS?=
 =?utf-8?B?K0NhUnA4NWFpUjhPZkozQjgxNlA0a1dMZHhWbDEybTAvVTc2RHIrTzdldEhy?=
 =?utf-8?B?SE5xUzdHOU10OWZBdWxlaERTMjN0Vy9TdlJha0lQQnd4MGdsbHlNN2tQOFZO?=
 =?utf-8?B?SGVjZjhxN3k0SHEyZy9GNEhRWDFkdFI3VW5IWmZTUzU3WkN6QnRHNE5SYmln?=
 =?utf-8?B?L2VxYm00L1lzRzA5UHRWb21Xd2N4dXIyemIrWjhxK0Y1RjJybEt1dXZoVkNl?=
 =?utf-8?B?L0huSlloaUduK2hxSWVSRUZCcU1PTlpwN3lKWGJkUUhma0lZdktQcjhwQ0Zm?=
 =?utf-8?B?R3J3SVJJMHFubm1RelZwamxxelkwZVhnUFFHMWR3Sk9idXlIcG8vTGhRZUJ2?=
 =?utf-8?B?OEVRdmYwc1l4VW5rRGNrQW9YemFnNG5mYVJ2Sm1XSzcyK0RwVW40SzVrQ2U1?=
 =?utf-8?B?TFM0Z0lWMVRGSW5aSGtDTXRGRGMrbjZKRWdJK0FndEtXZXZ1VHBYbS95eGU1?=
 =?utf-8?B?ZGFuU1QvekI3azdFZ0pidTVoeTBGTCtmZ2pkQ2xIZUN0WnF1bnJTem8vQ2RL?=
 =?utf-8?B?Ty93d29wbHlBQ2NkNjlIQ1JzeTRhdTkzSStiQjU1VzhZaTgzcUhsdTRyTEMx?=
 =?utf-8?B?TlI3aXI3UlFESTNnazU0N0gwNUZCUHhDU1NmNUFDNFhLS0RGa2tQVUx5YUVs?=
 =?utf-8?B?WTlKdnVpZlZiZzE4K2R4Ly96emVJNlFSWlZlYm1MRU9UNlBrcDQvd0NmK0xH?=
 =?utf-8?B?R2xudFlsa3JoTkhrOTZwUlVDMU9BTEpHSjN2QTJyelJ4bVNKTWtRQmpPTFI1?=
 =?utf-8?B?d3Y3OERpc1orY213Um9TYlptTGVmZXAvbUZlRWhEczhVemwzWXpyQ3Z5M0ZH?=
 =?utf-8?B?YVBxNytWUUFrYURXT09Ic3Rra2F4bkw5QjNLaFBsenNtR05ERWVBTDVmaXl0?=
 =?utf-8?B?NVZiL3I2SmMyazJyUjFYQUhEU043RUpCdjNERGJVOHhkamxiR1lFUkhsL1ht?=
 =?utf-8?B?Zzl1Z1I4Z051c1djNzl1TTh0VElzc09WTVZHRmc0UGlFU25kM3JzamxkdHMz?=
 =?utf-8?B?Q3pzd3lLRXo0eWlBTkJrVEVOTmFJaTEyY2ROOXpSYnVqQ3dHV1Z0QjlxK3d2?=
 =?utf-8?B?ZFF1eHpDZkxrdUFHTkdFWlg3K2g0TTJjM3B6bFJpbUNTYkxCK3dqMEUrYjdI?=
 =?utf-8?B?ZFVqdm9IZVEzY3pKc3FrRE5zclBoZHl6cTVsTlZtcGZXSVJlcEFuejRCOWJt?=
 =?utf-8?B?UVE2V1N3YTdCTWNRanc2cm9GRUg0cnhacVdUZmlOSlhCbW5rVmVvaERXVmcy?=
 =?utf-8?B?RVZCM05jcjlMTEx1R215NU5GQ01NVGlvL2M1NlljTmR2SStTeUVCVVVBMnBa?=
 =?utf-8?B?TStEaHZ5VmxPRFpVK3NGTHYwTUl6WnhJVnEwc0NqeXUyWVNFU2h3VjlqMWNz?=
 =?utf-8?B?K3NwcXBad1F4UitMOVRPZkpTcmNZODJuTzJTb1BsRFRhOUFkRFFPbHdUVTAw?=
 =?utf-8?B?NXQxZkVJM0ZteVkxbDBORU9pak80UW9GVW5sNy9TVTBKMzZudys0NkpCVEZJ?=
 =?utf-8?B?RGtBSkFRUlk2TEI5R0JnajBScFVoVlhiNmZiVmJRODh0UUI4b0NYak4wd0ht?=
 =?utf-8?B?dTBiYmpCMmQ5NkNoMTgrUnNBSERqTkZ1QXhxdmZSUEhVUWtoUnFmbnRxVXFt?=
 =?utf-8?B?U25PR0F4THVVWFd6bU4xc2xrWnRUcEZLY0VkZ1U4SUp6QkNmZXJjQmIxTkxD?=
 =?utf-8?B?TVRtdlV4MDFYSVlVYVIzeTVjSERyM0RFZHNILzA0ZUtSbE9zaE1iNmR6OVFH?=
 =?utf-8?Q?lUPJ3ONH5Ac/7VarRx+Q5od5X?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e6e549-5d11-4031-ffa9-08dcabf7c77c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 15:46:27.2991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PlNxrwA3uqt9pkxnGLUkZQp7NmCZMLJIPQkV8RG3k+N+Be3hipRJOGuHnUhn65xzp0KGLEnSdWysdyiPHYIRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8963

When the address is arbitrated at send address, the hardware can auto-send
NACK if it is an IBI. However, manual emission of NACK/ACK is needed for
hot join or controller request events.

Add an event type check to send out NACK if the event is not an IBI.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 5d19251238ff8..36e01d0430747 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1113,7 +1113,15 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		 * start.
 		 */
 		if (SVC_I3C_MSTATUS_IBIWON(reg)) {
+			int ibitype = SVC_I3C_MSTATUS_IBITYPE(reg);
+
 			writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
+
+			/* Hardware can't auto emit NACK for hot join and master request */
+			if (ibitype == SVC_I3C_MSTATUS_IBITYPE_HOT_JOIN ||
+			    ibitype == SVC_I3C_MSTATUS_IBITYPE_MASTER_REQUEST)
+				svc_i3c_master_nack_ibi(master);
+
 			continue;
 		}
 

-- 
2.34.1


