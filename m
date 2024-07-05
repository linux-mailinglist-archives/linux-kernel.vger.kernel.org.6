Return-Path: <linux-kernel+bounces-241878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DECE92809D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 04:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2A24284924
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 02:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5D61CA81;
	Fri,  5 Jul 2024 02:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CYtFAPeC"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D621C6A0
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 02:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720147933; cv=fail; b=BUyVY8xWfTaVyMEUHbHJ6wVTrc84hXY3hJRDCMZuRV73jkx5xFHUrQSnh/rnNlzT5rgWHYqynZ8aF562bLj8aIAbFVah4QZ9HRrZYpgaK5lRYG7tATJjwO0PIWoJ14KNoAgEwPNA5OyTVzDpwQDzpTfMOkmyCGYwpvExBa88J8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720147933; c=relaxed/simple;
	bh=mc/YZY1BiSdrG+3GjOVg87WMAjJ0KoRn7dCepLAkML0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SR6t1uN//z6FHlkgj4bITmeYI9urlswxJvAZXX2KPr7x5ZqwSLo9sGfzAlf5xAbyL8RkDei+qWnFZ/NEmKaFVQdDobinVJhmtMjhbNUI/uYtNt6mPLNU3nDutx2rWXro1FyUbIoLBNQXlFAtRbacMnLdiO0XX0Y+L4X0jxfVKyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CYtFAPeC; arc=fail smtp.client-ip=40.107.20.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhOZjn+r6bBSwR8KTnKakIWT1MpsX+2IE2AqihJZY2yYbrK1tfWACNFDsUSmoWYoGi+L1g7UCxYxIDi1jreXllNiq/ranZyPX3YMuNf+zIdiba/DgGo+/+Reg7kwY+8K5Dn03WDFJMEBexKPkZWnsEFDv1skZ1H/cAJ63SG2j9r/0nSkFZcaTdPmGLXu8YMDLFk6p5ihf3y32PtaUf6N/L9PvXv76h4yByukQPpZMnv0INTAHUFVgbcb7KK1gYfom/uJJuPm4lgSEw4ARQGEdtZU6+ICBhVKOePxugtG8AxJlzO4E0y2mx201mv3f3sI3i7WuZxQ0aYnhcKgMqEfZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mc/YZY1BiSdrG+3GjOVg87WMAjJ0KoRn7dCepLAkML0=;
 b=CwBDmRxCSgDue5s9vmUaqa4OJaFTLSN/fjhW9nsdEXS70SXXUawdOFIbDkpNkPe4XHJkpOc812ElcOCyLq2Oj8rkYSaJlelSij4PP5MWbkEfwtnJWsmEbtv2KAnjhD/x6FFj35ExfLlPe5u3vEG1WpwUMGB9zojhbRUjwEGkIQznOdXy1q2ssaJLfh68lxvop4pL2VM6Kka5tuvPmpgOylbm2Q1or0wu/5YXRM/h7g8g79JM0+hSE6UNpXHqwRSY8MgXB4xXxq2fXR8+2SLf6TzrDdQwlHDCficLUkBioBr4iigXYGH96sPZRX5TXYH6kg9IYNgNJGzr2OcEUag0pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mc/YZY1BiSdrG+3GjOVg87WMAjJ0KoRn7dCepLAkML0=;
 b=CYtFAPeCOjEpMyf2/1MxJslCFbkVUNjJgQP4bZ9RFYGOQgcj/nH2b8qBp1S7x6DmhUPCIdCMi1pA95/K+nD1Xte4641/RUrk2N29Un1qyT55RZ7Z9EzaEg/oqtBwQh6j7bxfioWjjISIYo8CZZjcFbn3m1XXq9uijqpHPR/dHc0=
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by DU4PR04MB10813.eurprd04.prod.outlook.com (2603:10a6:10:586::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 02:52:05 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%3]) with mapi id 15.20.7719.029; Fri, 5 Jul 2024
 02:52:05 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: "Ciprian Marian Costea (OSS)" <ciprianmarian.costea@oss.nxp.com>, Shawn
 Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, dl-S32 <S32@nxp.com>
Subject: RE: [PATCH 1/4] mmc: sdhci-esdhc-imx: disable card detect wake for
 S32G based platforms
Thread-Topic: [PATCH 1/4] mmc: sdhci-esdhc-imx: disable card detect wake for
 S32G based platforms
Thread-Index: AQHazhURkfQpdtXN2UG6Eg8bk0WUJ7Hnb3Jg
Date: Fri, 5 Jul 2024 02:52:05 +0000
Message-ID:
 <DU0PR04MB949696DFB27BB7D0574DF64F90DF2@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20240704132116.2865864-1-ciprianmarian.costea@oss.nxp.com>
 <20240704132116.2865864-2-ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20240704132116.2865864-2-ciprianmarian.costea@oss.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|DU4PR04MB10813:EE_
x-ms-office365-filtering-correlation-id: 24a26c96-5fd7-425d-afc5-08dc9c9d745a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U0pWUGJLNUdZZHpUOGtOYWcwS25LRHV0YlpRVXQzTlQvVGR2QUc2SGdiRlM3?=
 =?utf-8?B?OVZoL01hS2NIVGhlRGEvbzYwWllGVE82NW5scmhVaHBGYkFFRDY4M0tsYXRY?=
 =?utf-8?B?dkxKR3B2bUVuV0J2RnRIVUE5QUpZKysrZ1I3MmJvTzlFb3lwcUZlVm84Um5F?=
 =?utf-8?B?UTRadmlzS3NoWkk2YlNXU3RHY1FpTlZjR0J2VjliMW16Q1I0MDNvUWllaUEz?=
 =?utf-8?B?enRwNSszK0Exa0RPM1g4UDZiam5Ec2xCUjhqYjBlK1VoVXkyZ1FNSk5VbGpY?=
 =?utf-8?B?K1kvZG5rNlFCbWhKUmN3cXJVQm1KWHdnSE4xRzlkdTM2bXhYU09pb0ZiSit4?=
 =?utf-8?B?Wkp0dXZMRHhINHRWUmhrYndhZjNqTHdYbWhGYU9ud3FOeVFzL2JHK3lEaTIz?=
 =?utf-8?B?b1RhSHB1d2wxTUUwUTg1RWlUQ3NnRmszMkFSSnZUT0VRamFqWUUwUDFNb2pl?=
 =?utf-8?B?bzRNYTZNOGlpbU1WZ1gxeHp5bUQ1ekw1dGVyS29odGVWZGJUMDI3NkZrYkpD?=
 =?utf-8?B?dFdWZTd4Q3FzdW4zTy9jYmdibmVJcFp2cFNuTWZObmJoTk1oS0drY0JNRDhY?=
 =?utf-8?B?dkRsQlJrb1FkbFJRbG9NV0VDaDkvamJ1aE8rczRNelFGSlVKUm1yQ1hNQ09H?=
 =?utf-8?B?ekpCQzh0TzdiWHFZZjl0Ri9hVzkwdTdySXU0RHJ0VlhudE1MQVNTNk1STlRH?=
 =?utf-8?B?LzNwOU1XSWNXMmxBN2ZFRi9sUFRHL2w4VFBnb2pCNHkvaVdleGZCemUwbWF2?=
 =?utf-8?B?ellYM204S09ENW5lYUZJSmFWaFlvTzIvdGhYamFibFB3bUlHV1BJK1pnSTVk?=
 =?utf-8?B?R2NjU3ptKzVzUmxZaEF6dUFzVm82S2gyT3ZkOXBjTUx2QnIzNHVpYVR6aHlU?=
 =?utf-8?B?d0x5NStWQmppR09OTmI4b1U4Um9kcWpnelpqWlc2OEdSQ25yeUw1V0VKQy9L?=
 =?utf-8?B?dFZHWFAwelE0RCtBWHRDTktHYmkvek5EVVdIT3AyOHp5OExRMHY3TStEdFVP?=
 =?utf-8?B?cFJ5ZDdKY1ZNVWdFQkkzTGJKblNrSUl0YWoyTWlMZ3BqQnlqaUk4dW9XU2Zo?=
 =?utf-8?B?cTNFbFptbFFjM3VpbkFXUkJvREtiaUxHUm1TTFlNOGtBSDdhVDRGd1RuOENu?=
 =?utf-8?B?eldidVNrMFdEdzhOclRNRFRUSmtnMTJSM2ZZMEpmSEs0WndzRGh0RzIrVTl0?=
 =?utf-8?B?MEhWc1p6Z3lTMVZoYUFRL2gwQlFLUFJSRU5IdVdtWkRKaFBieWhsTCtwSHJp?=
 =?utf-8?B?cm9qNm1udlhPQWUwVlhJNFZzNEFqOWhTM2xNOE4vNjBtVlpYSUFvQ0l5ZVpn?=
 =?utf-8?B?WkFpN2k3NW1MMHFtbit3aGdrZjVGUVJWMVp6S21sY1hvNmlncG1uQ1U3OWFV?=
 =?utf-8?B?aGVONkZrcmZ5QTYvQjBPdFd0WDFGK3ZBNzBUb0lsQzNJeXdxaUpDRWxmVFl2?=
 =?utf-8?B?Z2lpTXIrMnU0UlEvSDd1ZFhQelhxWU9rbU5TTTVHLzdDVlJlWDhrellZQUx4?=
 =?utf-8?B?cFp5Ylc5RUpzM0dGZTNGRit0c2RwbWpZTDFUMURCclFiODM1TGxlNllCR2JT?=
 =?utf-8?B?cmdFSzhyMWVienIwbWpEdEtqcWt1cDM3ZFFJTnllbVpWUGxCdWZvYklrVUsw?=
 =?utf-8?B?YW05aVZPVlhEa0JmZ3haeFAyOTJTZythR0p1T2xzaGZGQ3lrNnQvV3ltcHh2?=
 =?utf-8?B?QjRGY2srR3N6bjlIWGJyK3hrek9qSjd0RGpLbUxkUmFjSC9RTXZ1aFozK3Fv?=
 =?utf-8?B?KzNObVNTNy9DejFiVlR2dTRXRzVycGNidE5yOHQ5MU5CK1VzZXR4eEpZUkJW?=
 =?utf-8?B?ek0yd0JaSTdVby9rc2NmNnZwZVFGVkYyeEhoZjd2SmxzUmNKWUVHSGEycDRq?=
 =?utf-8?B?NnFJOVp1dWdlNEI1QWpQOE4xWC85c3g5Z1JOQU5UU1lQL0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OStPaGZsc2F5RHZ4U2Z5OHU0SWx0cnJDK2F2eUpBOGI4a1VSeFdETmc0d3hr?=
 =?utf-8?B?VENPTTJ2UlpaU3hLb2xTdVo1SWJJaFRBdXJXWk5mV1FmZUtPRVVNVmtzSjhT?=
 =?utf-8?B?SnJYRVFRdXQyY0QwS3N2Ujk2TmV6OUMvYVd0RTJvMVRrbnZjcUE3RFZkV2Q3?=
 =?utf-8?B?RFhjenpPS0t2bk9sc2l4TjhCNkpFVy9naXRhVWFSMzFybjlFYTlWaGIwU0Ni?=
 =?utf-8?B?YzUwVHl6UzFTY3dCTk9LR0ExSk54OWdXRXBTYXRhWlh5Rk1rakZyUzk4VDZ6?=
 =?utf-8?B?c1V2Tkh2dTUyMkpzaFdUMVN1Nis3eFVhdkpOWWp1NmtiTTBnWk02ZWpmMEYv?=
 =?utf-8?B?QytNK2p2WUJCUjdmVEdXMjhDdEdJVkw1SllQQUVhc3FiREF1YmhIUS9kNlE4?=
 =?utf-8?B?b0tlM2ZHQlJlN2o0elVKTTZjWTJEcmhNUTkrK09XV0pmM2YrWGU3bndJS1VP?=
 =?utf-8?B?eEp5eU51VVIrNFVUSmNEWGJKazhJeXpLc0N6c3diR3p4ZTNPeWNLY1Rhc3JG?=
 =?utf-8?B?OXppOEh5dGpYS1RXMk9iU2RLTUo2NFluSXh1bThINm83L25JY0hGQlVCYnJQ?=
 =?utf-8?B?aUg3MUVVVWo3ajV3VXJOU1VmaFBSVDEyVDhrZ2NBeVcza2tpVys3YU1leU82?=
 =?utf-8?B?SVFGVDlsWk55V0ZWcVAzeFpqZTRJODIydjhLaEdpT3hNc0RmbzgyU3ZMbmRF?=
 =?utf-8?B?SE5wRUJ0bjk5Ty9wS0VGWnRFb0JVcnl3U0FSM1FKbFFsamVUMTNsSXdmMGQ0?=
 =?utf-8?B?MUl0ZjNlRU1udzVnNEtQM2pCeFcvbTFnMDhIRDNCOFhicFR1YlNZVjhQWmZ3?=
 =?utf-8?B?ZU1zSDVZZW5ZMnZSVVNGMHdTZUtJUGNWdkhpOExCZXNJaU16SG5PVUgxeExm?=
 =?utf-8?B?R1AzOGk5S25YQlBUSi9LSE1NU0xGUlRkemZOUjYzZ0JyUFBUTXo4b1o5azV0?=
 =?utf-8?B?T0dSUzFFWUNOalYvS0Y1dVpsQlN5ekZycFBVNi9GR0RYYWJVL0tYckx1eDE3?=
 =?utf-8?B?NE1zcFI2S0hneFpYN1ZvR0cyVUZVZUZvZTJBWU1iRy9HK25tTjh6UDBMdnAw?=
 =?utf-8?B?VmYrMDNJb0ZGWG1pSmFoSW5SY3krQ2Z5YmhidkhpZXhqVitNNitWeWFNQjJL?=
 =?utf-8?B?QVRDeFpyVkMrMitUNm0wWkFSUXhPa3V5NnRJc0cwWW9EQXdjTEdlUldrOHRQ?=
 =?utf-8?B?TDlUVjg3Z3JKSkMyb2ttMlVpMTJ3eDhJUEY0Z2lIaWtzUFFXT2V0dUhjY0xC?=
 =?utf-8?B?NFl0c0VMVDkrdEQ0VUtYeFZMWmE4VjVSd25DTU4zbHNwTnhaVzV6NDBnQnZk?=
 =?utf-8?B?T1Q2cjlDa0FEd3NiSXhsWlp1RHdaUDZVWEsvcHpqLzZjVlBBUzQ1WHVQQmFR?=
 =?utf-8?B?Uk8rSVdwRmc2cGpETHNFeUYrcjhlU0JKVWtPN2kzUGNvaklvMytPZFUrSjNJ?=
 =?utf-8?B?NTdlbTZZMWIzbHBRWTRlWWQ0ajRZMzFSNFREeDFTUXpaTEhWRkhPSmdQSW50?=
 =?utf-8?B?UE1xWGpKVEl5VWRxUXpjMGx3Qyt4UGdCZm5HbEMvQk12cTNjNzhJMEdzcXZi?=
 =?utf-8?B?eU1JK3BFL2NQRlEyeGZTUHFERU1IWlluOWxVUUxEc2lEb3lsanhDZFlGTTJO?=
 =?utf-8?B?WkIvUmtxTG8wa1owZEFzRkduMzlXVmlkMWYrcFBCM1dRS2R0d1IvRWZzVmhi?=
 =?utf-8?B?c1BDOUNLRko1cGlyZVhIZTRSb2ZEV0dseHJvK1dQREx1ZnVKaUxVamVNZm01?=
 =?utf-8?B?RVFLMjArV09vcDk1OTYreE50aUc5YkRrWTlXK3hqbHdiZDI1dXp0Zkw0MVBy?=
 =?utf-8?B?aEtHNlhvTFZhMmFNVWhuSS8wcFVRbWFtVjBGTXd2ZnRtbkZlaVRFNng5TDV5?=
 =?utf-8?B?NTRlbFBvVmYxZ1VVaUE5Y1hDQ0R6VXYrWFBiT0ZoQzF6VWw2YVJJUWxoc2Yv?=
 =?utf-8?B?TG10bmJ0Nm56ZHBZT3hhNXoxZE5PNzYyZHlXS1R2aXE5SGpwRnh2UzJoOWxN?=
 =?utf-8?B?aWk5TVgxUldUdW1lN1FIK01vOVFvZVRqb0M2NHR3UG5wSUFmSXlnOGZBYzR4?=
 =?utf-8?B?Mmora1RnTUZJVnFjU0xEaTAwenlIb0wvU0pLSm54VEtCaXRIcGxQRjR6dmtr?=
 =?utf-8?Q?Pa14=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a26c96-5fd7-425d-afc5-08dc9c9d745a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 02:52:05.5270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /L0PGKEXOk1xTni3OZB0RDwBLr9wFK+XPIhutgH1vvJZwWipi35PyFWK8UM4UGvydc6TnRcMLppwsyFHyZehyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10813

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaXByaWFuIE1hcmlhbiBDb3N0
ZWEgKE9TUykgPGNpcHJpYW5tYXJpYW4uY29zdGVhQG9zcy5ueHAuY29tPg0KPiBTZW50OiAyMDI0
5bm0N+aciDTml6UgMjE6MjENCj4gVG86IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz47
IFNhc2NoYSBIYXVlcg0KPiA8cy5oYXVlckBwZW5ndXRyb25peC5kZT47IFBlbmd1dHJvbml4IEtl
cm5lbCBUZWFtDQo+IDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+OyBGYWJpbyBFc3RldmFtIDxmZXN0
ZXZhbUBnbWFpbC5jb20+OyBCb3VnaA0KPiBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+IENj
OiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBpbXhAbGlzdHMubGludXguZGV2Ow0KPiBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGRsLVMzMiA8UzMyQG54cC5jb20+
OyBDaXByaWFuIE1hcmlhbg0KPiBDb3N0ZWEgKE9TUykgPGNpcHJpYW5tYXJpYW4uY29zdGVhQG9z
cy5ueHAuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMS80XSBtbWM6IHNkaGNpLWVzZGhjLWlteDog
ZGlzYWJsZSBjYXJkIGRldGVjdCB3YWtlIGZvciBTMzJHDQo+IGJhc2VkIHBsYXRmb3Jtcw0KPiAN
Cg0KSGkgQ2lwcmlhbiwNCg0KWW91IGRvIG5vdCBhZGQgdGhlIG1haW50YWluZXIgYW5kIG1tYyBy
ZXZpZXcgbGlzdCwgcGxlYXNlIHJ1biBzY3JpcHRzL2dldF9tYWludGFpbmVyLnBsIHRvIGdldCB0
aGUgZnVsbA0KdG8vY2MgbGlzdC4NCg0KQmVzdCBSZWdhcmRzDQpIYWlibyBDaGVuDQoNCj4gSW4g
Y2FzZSBvZiBTMzJHIGJhc2VkIHBsYXRmb3JtcywgR1BJTyBDRCB1c2VkIGZvciBjYXJkIGRldGVj
dCB3YWtlIG1lY2hhbmlzbQ0KPiBpcyBub3QgYXZhaWxhYmxlLg0KPiANCj4gRm9yIHRoaXMgc2Nl
bmFyaW8gdGhlIG5ld2x5IGludHJvZHVjZWQgZmxhZyAnRVNESENfRkxBR19TS0lQX0NEX1dBS0Un
IGlzDQo+IHVzZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaXByaWFuIENvc3RlYSA8Y2lwcmlh
bm1hcmlhbi5jb3N0ZWFAb3NzLm54cC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9tbWMvaG9zdC9z
ZGhjaS1lc2RoYy1pbXguYyB8IDggKysrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMv
aG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMt
aW14LmMNCj4gaW5kZXggNDBhNmUyZjgxNDVhLi4yMWQ5ODRhNzdiZTggMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gKysrIGIvZHJpdmVycy9tbWMv
aG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiBAQCAtMjAxLDYgKzIwMSw5IEBADQo+ICAvKiBFUlIw
MDQ1MzYgaXMgbm90IGFwcGxpY2FibGUgZm9yIHRoZSBJUCAgKi8NCj4gICNkZWZpbmUgRVNESENf
RkxBR19TS0lQX0VSUjAwNDUzNglCSVQoMTcpDQo+IA0KPiArLyogVGhlIElQIGRvZXMgbm90IGhh
dmUgR1BJTyBDRCB3YWtlIGNhcGFiaWxpdGllcyAqLw0KPiArI2RlZmluZSBFU0RIQ19GTEFHX1NL
SVBfQ0RfV0FLRQkJQklUKDE4KQ0KPiArDQo+ICBlbnVtIHdwX3R5cGVzIHsNCj4gIAlFU0RIQ19X
UF9OT05FLAkJLyogbm8gV1AsIG5laXRoZXIgY29udHJvbGxlciBub3IgZ3BpbyAqLw0KPiAgCUVT
REhDX1dQX0NPTlRST0xMRVIsCS8qIG1tYyBjb250cm9sbGVyIGludGVybmFsIFdQICovDQo+IEBA
IC0yOTgsNyArMzAxLDcgQEAgc3RhdGljIHN0cnVjdCBlc2RoY19zb2NfZGF0YSB1c2RoY19zMzJn
Ml9kYXRhID0gew0KPiAgCS5mbGFncyA9IEVTREhDX0ZMQUdfVVNESEMgfCBFU0RIQ19GTEFHX01B
Tl9UVU5JTkcNCj4gIAkJCXwgRVNESENfRkxBR19IQVZFX0NBUDEgfCBFU0RIQ19GTEFHX0hTMjAw
DQo+ICAJCQl8IEVTREhDX0ZMQUdfSFM0MDAgfCBFU0RIQ19GTEFHX0hTNDAwX0VTDQo+IC0JCQl8
IEVTREhDX0ZMQUdfU0tJUF9FUlIwMDQ1MzYsDQo+ICsJCQl8IEVTREhDX0ZMQUdfU0tJUF9FUlIw
MDQ1MzYgfA0KPiBFU0RIQ19GTEFHX1NLSVBfQ0RfV0FLRSwNCj4gIH07DQo+IA0KPiAgc3RhdGlj
IHN0cnVjdCBlc2RoY19zb2NfZGF0YSB1c2RoY19pbXg3dWxwX2RhdGEgPSB7IEBAIC0xNzI2LDcg
KzE3MjksOA0KPiBAQCBzdGF0aWMgaW50IHNkaGNpX2VzZGhjX2lteF9wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCQlob3N0LT5tbWMtPmNhcHMgfD0gTU1DX0NBUF8xXzhW
X0REUiB8IE1NQ19DQVBfM18zVl9ERFI7DQo+IA0KPiAgCQkvKiBHUElPIENEIGNhbiBiZSBzZXQg
YXMgYSB3YWtldXAgc291cmNlICovDQo+IC0JCWhvc3QtPm1tYy0+Y2FwcyB8PSBNTUNfQ0FQX0NE
X1dBS0U7DQo+ICsJCWlmICghKGlteF9kYXRhLT5zb2NkYXRhLT5mbGFncyAmIEVTREhDX0ZMQUdf
U0tJUF9DRF9XQUtFKSkNCj4gKwkJCWhvc3QtPm1tYy0+Y2FwcyB8PSBNTUNfQ0FQX0NEX1dBS0U7
DQo+IA0KPiAgCQlpZiAoIShpbXhfZGF0YS0+c29jZGF0YS0+ZmxhZ3MgJiBFU0RIQ19GTEFHX0hT
MjAwKSkNCj4gIAkJCWhvc3QtPnF1aXJrczIgfD0gU0RIQ0lfUVVJUksyX0JST0tFTl9IUzIwMDsN
Cj4gLS0NCj4gMi40NS4yDQoNCg==

