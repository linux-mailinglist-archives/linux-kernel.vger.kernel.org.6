Return-Path: <linux-kernel+bounces-224676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0219125BA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8466B29F42
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C7B156881;
	Fri, 21 Jun 2024 12:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bbJO5Rw5"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2049.outbound.protection.outlook.com [40.107.8.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D491C155C99;
	Fri, 21 Jun 2024 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718973481; cv=fail; b=bBqATTkCugvHPCsB6TWDeod5uhVHEKOzusPQ9JhYi7mBVFZsOCqR3fXnuNWkWZ7yhV8+T0slTIkmi5LKOb5X4mgv618PxPOXS0/xEFTa+1ARG/KFkBLz5ptdIuLxg0stUV6m1l7fuDig5bW27kYz6DHzy7S27Z1okYEeTJ+dvmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718973481; c=relaxed/simple;
	bh=ifvcKPnkdyZCJdLaXKNJc+UqB8hW0htc57pqduz4rXY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HDXq6PRpBgEA9qL4PyOkL61pkuo2+oKThPCjy9ez01V0jN4ZdQXohClBE/TmEN3uvtjOfYtEYXBpwd1EYs7A9/mhWtzMzdFLgGrVdFbvbfye6mkpXtEPcnf8nkan356oXw5jbR2dPrfrWBHwNWFBlHJwI6HNB7WHrGVYQKSKQhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bbJO5Rw5; arc=fail smtp.client-ip=40.107.8.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UN59+e8gkarECBdi+LrSLaZz5nZDj9oJm/r/EkPUZIRsQ6mVxZE04gaOuu6EeaTSX6Ycz8r1q87fc+0PNyb1GcOuABaq5aW+VGJE/ehU0gmI+FKY8/A581/DZL0vJ/BEHQE+IS2wUf+zU0jsuVRtnZ0r2juFmVuWsjGw3kn7Vb/4ldslvjrhSZyK/FR/jGMXQylvi18QDxRjDvnGJ4Nni0kZK9igrudmWZVJD2n7ik6k5j2PIxKHI5YdLvMRqIUCCHEQWHEJMq2zfENldZERj1FBpdXUpRy/6uc9bcI4mhkajYIh6jb9mb86Bp+E+xe2YBuNW7tdXiRiaViuOrwbMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCfbpBhjXdZhw/zabiW/1mSVd8AHxJpCaLe9GfkFW3w=;
 b=Oesv5ZYjPMZJUXRMlOpRZzZZR9Afv2NmePjWSB6a5GktV2gYJqsu6gE7x4yAROxNXuBS9qItRaBKt4Jz167cwuu4HKURcRGRYcPjngMKav4RPtylIrOzXBUrRgT9GGi5oCzRByY9XLdMuqj62J9tWhMSZdYEMlzjscvYP/xcJF5rcxfZdHthjK4LUp6eUty+vymJfLfNNaLN236kt77fGL4P4cjAMz7eLPj2GDlrYdGcetZNNet9uJ2VOkKWc9CRmsQA0YU0152T4ZqxNGb3qFZFAZqE8621enwZ/Hht/U/BaYpO2Ad+zBCIApeh8FY10tKnmeqG2ecX1ikZk4Uitw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCfbpBhjXdZhw/zabiW/1mSVd8AHxJpCaLe9GfkFW3w=;
 b=bbJO5Rw5Um9MEBHxHHfgTVsM6xtL7vQyUfMq2BvYPmLfn0615xOolbA8PYYShZ2RuvQmSFJZa58UJT66XYgPMi5QKxPWzDWkKjsOLOs2PkAKZm76B9qO57W/DnL/d3pw7n9WsVVWPYq8KVuArdgMmMUkDad0j9LfNGqiMML0GYs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by VI0PR04MB10757.eurprd04.prod.outlook.com (2603:10a6:800:26a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 12:37:55 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 12:37:55 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 21 Jun 2024 20:46:57 +0800
Subject: [PATCH 1/2] dt-bindings: firmware: arm,scmi: introduce property
 mbox-rx-timeout-ms
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-scmi-mailbox-v1-v1-1-8ed450735f46@nxp.com>
References: <20240621-scmi-mailbox-v1-v1-0-8ed450735f46@nxp.com>
In-Reply-To: <20240621-scmi-mailbox-v1-v1-0-8ed450735f46@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718974025; l=1198;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=HY7KYsejwshpomZ58pb2C6L5Z9B2yXXXSOg0k0xoEeI=;
 b=K9aR8HhzGkxkxejnSIIJJfuN6NTIF/IQmTQEJRsFBL1aUQvjG3ASUejHWYdJb2KkWqTP2u3DQ
 4WAotzy5FhXCJ1JTUEPsfi46iIIT5EgWxu04M1pAZJZj7yzRVeat065
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0241.apcprd06.prod.outlook.com
 (2603:1096:4:ac::25) To AM6PR04MB5941.eurprd04.prod.outlook.com
 (2603:10a6:20b:9e::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|VI0PR04MB10757:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b221a9-68e1-495a-74ec-08dc91eef924
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|376011|52116011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0hBQkVCbjNROTk2cThEeFVXYTN3eHJZU05wdWhtUHdTZVpmcStGNkZrWTZX?=
 =?utf-8?B?bmc2UVN0aTRQUlNiMmlHQks0Vk1ucjJsa0dvTzl5dWsrczEzRkZoM2lsMDZy?=
 =?utf-8?B?akUrTktDd0pqZEVNKzJtMXdvRTd3d0YreWUrVktWNzUvTEx1QzBMdFZ3T0ZY?=
 =?utf-8?B?L2Zob3Y1alZUdUdxbnNZQklPcytkL05lWGkyaHZYa2F1Q1Y3c25aTzllZE9m?=
 =?utf-8?B?eXBUQXo3NitINDB5NjM5RStJcm11VGh0ZTIrRGtHVGNtc1dJNXRIaUszcjBN?=
 =?utf-8?B?bWZUUjh2N3Jnam9IMnoyMDFmRmcrS3paZlFMY2Y3aXFsZ01MY2RXWmtRNEFS?=
 =?utf-8?B?NFBRL3AxUWN2N2puUm0va05vOUpMdndWclAycDB4YmJUYXQwdWpCczQ4aEZh?=
 =?utf-8?B?Q01DVTBwUnkvSklkOFFMUHZnVklhTS9RY3dzRG9kdlhWVVlVVTlFT2dUYm1F?=
 =?utf-8?B?dnZCVGZpNjhRNVNWWlNkSFAveDd1MEJuNDB2TFpnSWpnelBBUEdwb043QmpS?=
 =?utf-8?B?VksvUUZOOEJwT1NwKzRQOTR4SEZpbDg4TkJUM0pWanUycnFJTFN1VWgrOVF3?=
 =?utf-8?B?TGdDVDVTUUgwZTVKalRTelY3K093R2liR093RkhHOG5QWGhJcUMzbmRTSk9G?=
 =?utf-8?B?bHZKZUZkVU9ubHhpNUZJWmdlc0FkK0s2a01kMXVvMXd6SlpkSk5DRmozVWIr?=
 =?utf-8?B?VlJRdTdTZHBxYlBXK0Z4R3NwcC9yTEU0cDdueDJDZU53d29kQXVBaW5oNTVi?=
 =?utf-8?B?ZVJiem5va1UvNWtZNGl5c0dNQmdyK0tMMzhoaXpOWk9NQVl3eVhFVThoN3o4?=
 =?utf-8?B?MUV0T280UThBa1I1bXFNTnJhWVJmQU9FZTUzdlowd21rekhpdVh2bk5WUkJo?=
 =?utf-8?B?UmRoclJKVlNFcysrRnVMWnM2VkJIVVlSTTdSVzZBN1p2SUpqZXdIRVdWVUNk?=
 =?utf-8?B?azdha2JCZGJhZUk4Tjlob0NsUFhNY0RoanFqZ0hobUsrQVlsR0tWSU1ENkh0?=
 =?utf-8?B?Rkk2bVcyblNGb1BaMVZUeXRpSlcyMUdTR3FFS1gvL0RUcm9HdzV0cHJqME9h?=
 =?utf-8?B?MFJUUmJhazcrb29sOGdKMWVMaWhiV0hsaU42cVY1QmI3ZC9Kb00zclUzbzNl?=
 =?utf-8?B?R0NaU0dLWThjcERVWkpMa0xQZzlsS3RoUk5kNGV3bnJjTXBJUmhKR3U5WjBa?=
 =?utf-8?B?UVh3WlpaNHV3M0h3ZHArdE94MVFUeFRnb3dtV0pWY3BPQTJ4OEx1TEhPZVJ5?=
 =?utf-8?B?R3phK1FYMi93L2JEQ1dzdDhpZUpyeDFwT2ljdG85cU80d0pOZ3RNa2NwUWVS?=
 =?utf-8?B?S0JRc1BxRFVXbnp2UmwyNkYrZHc2SXNmUXErZnRGUEUyN001MXJRT2hvTE1J?=
 =?utf-8?B?Q0t6ZTR3OFlNWkNYb2p0SVpERzFtb04xMGZyU0dGb2N5Y3VSUlFuL2dsQnZ6?=
 =?utf-8?B?cnc4L2hVNkIxRVBGZSt0OW5CalVHakZsY0tlTlB0QlZQakx2Szhya3FqTCt1?=
 =?utf-8?B?RUJ4dWNXdmlQY29zK3BoK3NVdURaT1NYa0szNk1EOFVDa2IydVlwRSsrZFhO?=
 =?utf-8?B?aUJjdVVmMVU1azc4UFJWOW1VWkwwNnFpTzJXdHhqVHdPNzZqbHFJWlQ0bmIy?=
 =?utf-8?B?WWxZY2xaT0x2TjJ3NVdKSVV6NE5UQmlvaWVrVEV3N1BsekpKdXZLYTFvR3dv?=
 =?utf-8?B?SVY0VUY0WU5sMm5WSy9vV3dvdm5zLzRnNjFLWmVqeGs4TXlxUjBHUGc1cloy?=
 =?utf-8?B?N2YwQUMyTTlSVG5HWi9MUlN5a3FYTFp0RVRTSUpxMm1aQUxFcVY2TjRzeTNv?=
 =?utf-8?Q?WLik+oNFWaPAnP9PfPuxpeBrMlnt1Idgb5eIY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(52116011)(1800799021)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTBGT0hkVUxUWFZwNXFHR2VQSXNFdmp5SW9Zc09PdTUwNkt4TzVHc0ZscEhh?=
 =?utf-8?B?a0hSSVVrQ251ODNSem1HS2FKalJoVXFEbW5EbWhFU1VJdDJXUGZSQld3VUJt?=
 =?utf-8?B?VEFoemtLSDFNUXlFV0NWVjRWOCtoNkRZbGphVnU0ZEJzMFhjZFVvdGhZSlcv?=
 =?utf-8?B?Qmcrd1NNbkJJREJ4emRZVlYyWXZoQXdqOGZpaDdSdG5iOEx1OXEveVJMRVJZ?=
 =?utf-8?B?L3FIRmxKNnBZWFJPUndINlloQlpYaE1YcWNtRUoydDdmTFpUUUgxeW1ybmtx?=
 =?utf-8?B?WndMa2orMnZPbjRSdkNPNytVUXNJcTcxNU5Ta004dzJHT3ZiZ0hScjZIUDZM?=
 =?utf-8?B?cGluMjRyNk0zRVYyWHRGdlVJbnRQSDdLNk9wWGNZWGs4Vm9pMGtSbE1veWdS?=
 =?utf-8?B?YnJuMmp2S0xRRTFBaEtNMWhtQzFJZW9odzhZYXd0OWlTMzlIQXFwZ293VWRs?=
 =?utf-8?B?MjRuYUQrbGFnWHAzQk5leG9OejY4ZGVVZlJ0Y2xjWFFiNlJ4NFBzditWbDhm?=
 =?utf-8?B?RVZ4T05ZTVdpNXlSSGRIVjZvVlk5MXh5RUoxaVJ1SEVvUWZsNE1uekdnaVJ2?=
 =?utf-8?B?Yy80Ni9VRmRPTWFhNHlwZDRSQU4zc2QyRzdSMURUVXN0ZFJoZDFsNlhDMkZ5?=
 =?utf-8?B?bWVWTFF4Q0VUUnlZS0hJdDREYmh5M25DeXhoSEk4bmNkclpXSjdmWERjZGVx?=
 =?utf-8?B?MWNUUXJMV2h2NWVTODY1UU5ORXNKWnEvZmZtZE93T1JqSTlYdXBvaEZ6MTJY?=
 =?utf-8?B?TE0rOFRTeEZjV0FxUkRvaUwzTUxtTkZlN1FQUzJTMDlTQUdaT1UxSTBSVUkr?=
 =?utf-8?B?TG9GSDFZWUZxV3NxcXpUMHg3cGxpOWt6amVYSVkwa2pOZi9ESzh5QUxPbmt1?=
 =?utf-8?B?ckpnVFZmMUdNTm1ieUtOMVpUc2NaTXNDMkVTSnplS1c3bVZrZmNBM0c1ZUhr?=
 =?utf-8?B?amlkeWtNdWZVa3BjNHI0ZGp4eWx5SVRtT2FTNWV2UE9odkhqRktwOWQzd01m?=
 =?utf-8?B?d1M0eEZFNHk1cnp5RlJHaHJhaDR2OGhIL05qSTB4YW8wR0J4WFFUMHNKQk5W?=
 =?utf-8?B?WldnYkVTeitoVEFFZFVNWTlWZmVqdDVwNjdVZWliNExwcUFkSGFvRWZyc0Yr?=
 =?utf-8?B?UnNDbGp6UzMyWnpoUWFhM3MvU3BEd2FoemxlZFhqbmxNSmt6RTJGQVR3TXZ5?=
 =?utf-8?B?UWErdFlsaWxvSGRNL1J2Y3U2eFNwNDlDcUpYT043MCtXNDdiMEZCTVpMZkxK?=
 =?utf-8?B?VjB1UkdwS3FrTUsvelg5Nys3Sis3WVlMbEYzYU5lTVA1NTBCN1Y5d0hLN2lO?=
 =?utf-8?B?eGpRUW8rQXlVTWd2QzhPbkIrN0xYNTErZm5McjRhWGRidmtGazNvVW1rdkd5?=
 =?utf-8?B?VTMreForc1l6YzNwR3R1VGNsVS9yUUFnNHIwQklySnFXSjZmV0Z5STl4SlVx?=
 =?utf-8?B?WnFlSU1IZGJMUWdTQ1VieFJSSU5GVmFPc0VtTHpZUkRaNHFaaDRMbzBURG5D?=
 =?utf-8?B?NzE5OVFkUUlCMkNhV0U1Q0ErSUgrY2FXUmRKV1F2aHM4bmpLZ0t1c3ZQY1o3?=
 =?utf-8?B?amd3ZFU0ak5halU0ZUlOYWpiL0RNWXAvL3hPNDNBeXhzT0xoS054UDg2WWkw?=
 =?utf-8?B?aE1HVGJSbitqV2Iycko0Zy9rNC8vL0NGTzJXcmRvTkRmVTVtZFNBb1R6b3NN?=
 =?utf-8?B?Z3UrMDBTcGE0WHVmamdYV0s3U3p1NyswcDNING1DQjFpejdXb0Y4d3R4RWNa?=
 =?utf-8?B?MG9YY3lLYkhTWnpzK1E0dnd6SVI1OGI2bFh2WE1jUEZ3M3djMW9saEgxaFJH?=
 =?utf-8?B?U2dJTnp5M0dlY1kyM3dZejNsWHRTM3RvR21oTDFGNktZNGpiT1VycG1mdDdy?=
 =?utf-8?B?TUo0THI2Wlg3V0tTdWVGb3NjcmlsYmE0VlBYN2JwVHJEZ0lzclpES0UrYVFp?=
 =?utf-8?B?TXRsWERnSkoyc1BhYWdCWjdzRlNnNlZjWVk5cWpSV3V2TUxRT0g1THMrejR0?=
 =?utf-8?B?YzhTdHFvZzhRNUhOeSt5UGVwbFg0QW5SQ3BoempYNVhwNG1hZlFYV00xTDdB?=
 =?utf-8?B?c29qUE5IQzg1NlY1QzlWMVZxTUxiWFNYM0doZ0g1eHRtNHZWaXZZN0NhN1Yv?=
 =?utf-8?Q?uCQUSpIc+ZGjpx3C1eiZAH9FH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b221a9-68e1-495a-74ec-08dc91eef924
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 12:37:55.0502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GYCa1YxF7vKVaJ83hfXcLjGCkRZCEDL5y+hngnplQgVXaNKnH1BUpWW5uwBgnfWXEO8nwAo3BUUeTyc7UIhbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10757

From: Peng Fan <peng.fan@nxp.com>

System Controller Management Interface(SCMI) firmwares might have
different designs by SCMI firmware developers. So the maximum receive
channel timeout value might also varies in the various designs.

So introduce property mbox-rx-timeout-ms to let each platform could
set its own timeout value in device tree.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 4d823f3b1f0e..d6cc2bf4c819 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -121,6 +121,12 @@ properties:
       atomic mode of operation, even if requested.
     default: 0
 
+  max-rx-timeout-ms:
+    description:
+      An optional time value, expressed in milliseconds, representing, on this
+      platform, the mailbox maximum timeout value for receive channel.
+    default: 0
+
   arm,smc-id:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:

-- 
2.37.1


