Return-Path: <linux-kernel+bounces-404035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED96D9C3E3C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DE3A1C21A32
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099FA19DF40;
	Mon, 11 Nov 2024 12:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QqU8NYR6"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C60F19D8A2
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731327186; cv=fail; b=GcM6RabijPGuZuPnDLRwuyDtejjXtVhOoBvYV+yiLFq623/RJn9L4QCLJAH8WzxJb23gM/gakbh+0gpEMF1HG5sikpMTB9ZyiurSPR7nKqC82OL/FPvXBjCAQ7dwg5acs/qZmWRMWO5JuW2aq87+C/5gIa3teYNW24afWSawsxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731327186; c=relaxed/simple;
	bh=z6a4pKaqIOyrN2gL0AbLuuHPNMwYxwCPO4vdcrFTPWk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=t42EMNxYyt5UORFcgGgV8Rsap5/qKWFSiGPuPoNE4upERrODCOtP/OjsM5kZRWjNVjKqL8ULvOfBRu1jxbxOe+5j2NtZrClWRxnsaub5fbbX8ydKPem8O6JWi+vpmtx6+zpNweLiModACDQ3u1WaZrhbb+dmdF9nVwOPinh47Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QqU8NYR6; arc=fail smtp.client-ip=40.107.21.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BARXhhtQJis5GXUIlYdriOZ3zWg5Be2jpZ6rpMJA6K1PT+ZBRyj+UcmfUdoTgkg+8NnJxjp5x/rxbQWQLpITc2TGi9iaCTWJuViYn3aVRRle/WOqTdCX0EEB8Q/Qzr66KU7QfA/qKNoud72b/e1nFUQVgxAZnei01yVwxxIzB1bJrdieyVk3dQjpBAovmEL8vubIk9h9ZCgnltvXAG6+o/0x5WlKBS0GdwP73rfoTMI42Ec9s18ei8yWGE6sPaH6yrjGHV9rOGCh904/2IuR3Uopx2P4+RHdd0Ve0U7jWnUySrVbWim2x/Npp1XpOpuPF3wwspyvxrm2kRYZDU70WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6a4pKaqIOyrN2gL0AbLuuHPNMwYxwCPO4vdcrFTPWk=;
 b=DqsAq7TeOI/Xe2vSUCWQqTFPgy8r6npFQyazLCf9n3Cad5tKHtrkvx4f0nQp7gIRH37HaM2XC97HvY01DZSs14ciQ7yzL5lBBaFJSjSZV25L7EQJaZGWw0igp1TBLRbLm5rchmr2g/szKfxtdavJoS13L+UULT7rgdiyvwu6huO0sy9OfL2UYEVdW3lxOwgD8paEfCDoEYnVq7FE5JMvTCzdOGTqe2RTGpHYG+L+5ci9v+8gUeW8Y+oY2NEdzikCFhX6uEhy1hc81SjfKdC9P1S9KF4WscFkEzerSGpVk5YjxstPGt0OFyQJgNGn35sexp5BxrbT5VIncAJqpm85LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6a4pKaqIOyrN2gL0AbLuuHPNMwYxwCPO4vdcrFTPWk=;
 b=QqU8NYR6Tr5W6wbm9YGHRcmyV43EyctKJlzeNpDdkuGJl6i8MPmt3p6ahSCD+ukzw9ahrf7c1S1UnuoXwy0uvTehhdSt6tk1LyCYMRC7rq0C5GE/rUW9IegwAFVk0WVc6U0jAW01tT6KFv76p2atGtsFeCm8SO+6rHhFxSCS2YR6rAqmfhHKTaaH3gcX5rH3VEkTKGIT4rRXiXGV0ArFIL5RIIQ5+CV27uMzx56WUBibYupS8kr7zsLn/lUeMgokrm2hD3ixZoYs5EkpHPP4hJvpqt7Qw8h+3FwH8Tdo91opDjGsCvKmwRzUIXPxTiJg33drlIJBxrTxcFJnRkXi+Q==
Received: from DB9PR04MB8409.eurprd04.prod.outlook.com (2603:10a6:10:244::6)
 by DU4PR04MB10911.eurprd04.prod.outlook.com (2603:10a6:10:58c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 12:13:00 +0000
Received: from DB9PR04MB8409.eurprd04.prod.outlook.com
 ([fe80::1436:d8ba:25b8:1637]) by DB9PR04MB8409.eurprd04.prod.outlook.com
 ([fe80::1436:d8ba:25b8:1637%3]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 12:12:59 +0000
From: Gaurav Jain <gaurav.jain@nxp.com>
To: Horia Geanta <horia.geanta@nxp.com>, Pankaj Gupta <pankaj.gupta@nxp.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
	<davem@davemloft.net>, Silvano Di Ninno <silvano.dininno@nxp.com>, Varun
 Sethi <V.Sethi@nxp.com>, Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
	Sahil Malhotra <sahil.malhotra@nxp.com>, Nikolaus Voss
	<nikolaus.voss@haag-streit.com>, Ahmad Fatoum <a.fatoum@pengutronix.de>
CC: "=linux-crypto@vger.kernel.org" <=linux-crypto@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Gaurav Jain
	<gaurav.jain@nxp.com>
Subject: Recall: [PATCH] crypto: caam - use JobR's space to access page 0 regs
Thread-Topic: [PATCH] crypto: caam - use JobR's space to access page 0 regs
Thread-Index: AQHbNDMMMkY3rZEWkk+2aM3NGRaWFg==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Mon, 11 Nov 2024 12:12:59 +0000
Message-ID:
 <DB9PR04MB8409952DA39B4A88F0102D79E7582@DB9PR04MB8409.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8409:EE_|DU4PR04MB10911:EE_
x-ms-office365-filtering-correlation-id: af32097a-e02b-4c30-b9d7-08dd024a2f1b
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+nj0FeGwa4G+vNb+YiGi+aCQYOHqoAPym257kkpOoinBnQcM/j9FhXqGoXG4?=
 =?us-ascii?Q?iSE2TJHRedlJBeiws5k7AQmI4IDxKgW/WGhkd88ote6PEOY8WFght2jfW/tB?=
 =?us-ascii?Q?3y4s3CgTatVks1zH5kU9UOTSnYni/NASXkO6H9yA00ndnxXlUZ7dwv3pYlrG?=
 =?us-ascii?Q?+2NsRrgyhfhKvZYnnXA8gqiPSGPdkVWaIs1QftksK1pUIu2by5ggyyrPCk1X?=
 =?us-ascii?Q?b65K1HMGQSVksjKQTKyRRDu+XT6vR4HKHWroz4twm9uBWrHqHRx/rzHqfb68?=
 =?us-ascii?Q?r9ej4eCpdhWRZcIAm8YM/7mhna+87GXGgmB+Ux++tMKgmKkSm0jOJpIZa4yY?=
 =?us-ascii?Q?NNvlC8tsToF9qn0MRi7krLAJgik2H/M2OmsPV/5+angZa2BQVajxUUJRiigz?=
 =?us-ascii?Q?PUPnklEMC4U5Lo5XtRoZJBx6BH40yiqG+d0ofYSizbWJkRLEH2MHhXytm5vY?=
 =?us-ascii?Q?qsOQHKaVji11TZJo+VqtiYCBDP01TTlCio5r+q6FDmi1Dtkli4jZ7Akuuxta?=
 =?us-ascii?Q?M7OHT0X/r4X9KdsrNGKsfePmtDjBCASM1f0uDyy6sbF8S0O1sG5bz+n3vNFh?=
 =?us-ascii?Q?j+2F5emCFBYt5/Y9XRoA/aU9q1jTKjHOz1o1IAjq4OoGuK5F6cB3Ut5rmc2A?=
 =?us-ascii?Q?+szXSQYc1D+bpTLkQhUdslShHXOcsTfKncz/ixFKEHP67gWqfHNVTJyL8SZD?=
 =?us-ascii?Q?RpmGkaU8iKPJFAyKqP6KXQZJd0YNwXd4569jz6e0b9pY5NRQbgwqn7khh4tl?=
 =?us-ascii?Q?NQmhYNVzkJkOWapJfTi79AS2+b5ZS1sBAcOpyarIfvqGAhqn1NNR0nt0aQwB?=
 =?us-ascii?Q?pGXOCJ+RJTDCHbOQ9lbd/Tn9CTzyR3OwVk8ILQmDtg19qh+vKIWE9n8GtnQ5?=
 =?us-ascii?Q?WyLvzYVSnwd/yfZOP1r5BAG2Es4hkM97kFikpAhCTqaF1OJo6w+noMxOOONB?=
 =?us-ascii?Q?V5yAUxRAkPwTnJU3sv7c9dRp9SxPkYNFK/DGeAetBJP5hgLi4MmQ/DPWF06u?=
 =?us-ascii?Q?YaaGae6efAeOGbNryhiDaxgvb02Qd1VCS92P3nuKPngDxOkLxzwyG6uff6NO?=
 =?us-ascii?Q?vHD38QktBipNBSk6A+Ork/b6/Vex0LcdZZ+L8FVF527s/mlxIXW1PMdrMdCN?=
 =?us-ascii?Q?OGm95kYst2K3pGtOItja6/7bHiD7tVbU14eXaaO5wkpedJcKLvF0v6RnHDl+?=
 =?us-ascii?Q?uzcEg8feNs10Iu61HNXH0D3U139MIGg/A1i2Rv58POTFvs5w5SaDFGuOQtxM?=
 =?us-ascii?Q?qZ2Rk8lF3iMmE/5K5NhMp94VZ0CtgYCxq+ac1iemlquauAJIPP0tx2OWYdsa?=
 =?us-ascii?Q?O8gRVUBboT0y5/ytCJtO+ZIj+P+9mIwjngn3EF3eOZrzKkpESINL/UsczS2Z?=
 =?us-ascii?Q?3bllP3CrqFdzFv3P3ZzdfBarVsML?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8409.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1b1cWiATNTOK33/sGgO6MG5bc67K+jDvlZrPaH3IViC3aILLxQ4jRVqwvUNm?=
 =?us-ascii?Q?5iMQWK6sCXCrSHWxgUnqe5zqLvGA84EBIFhlxWvy4r0/1fzobKd6/xwhO9vB?=
 =?us-ascii?Q?L9OiAiPY+Cmky7szedThxoJ2dMD25OoR/Hv0jaImHojEijG0zbSrs3CTvCWs?=
 =?us-ascii?Q?G/N8wXp8m/9fDRi4pJwIAw1VRwxPb4TDdITspz0Dia3XYvR+a6haGZoDGZca?=
 =?us-ascii?Q?X6UWLgCYR4pKewqsLMWYo4hUKBICQqMQKhi8Eaayk8ZFiyuIH0vQPc2Ai4Pm?=
 =?us-ascii?Q?1AlPW57WLwSv51bFLodWNN5t5MzMME26sS4UykmvMPDd9yfadQb8prtN0huk?=
 =?us-ascii?Q?SWhRhUH1aKfu1LWs0FCoNJPMdel+8c9XNmbAB2ozLHnndoYLK8C3yHIWhfl4?=
 =?us-ascii?Q?khJcDXZFJ56UvFPZUt52CQaDTqzAZ/MACJWMNDbGYQ15l+lqeUYzYEYF1WMG?=
 =?us-ascii?Q?n26/95LEy+N7EmV3hfBe4yYhgRUdK9rluFf4cI7Hpc5FpvZZw/bYJF3K0Pes?=
 =?us-ascii?Q?Z/Es5wQPGAhdtAunJQ9l36l1C4r8tyyNptTED3uWynplEa8Uelm9Q0wGPTVd?=
 =?us-ascii?Q?BEN3/D+UAz5If5US+vmS29PeH9NpIf7jcfFbrOe3x0BaVdy9/yCz2z942jSr?=
 =?us-ascii?Q?GhYBTNlVM/faIZiH9m/s+e+08sqWDcnl0IHM+YXVDw5kwfeqriZrcNqBaQLt?=
 =?us-ascii?Q?aowe+kbGnF/bobgfUI97VG61l9U/G3zGKV2zTriQp4Nhlmk8UmMer9Qhhay4?=
 =?us-ascii?Q?CiGn4tbz/Xl79WtrejmsyTvjCKoSukUdCml8HMauufUJmsK7nrY9BnaEpMF4?=
 =?us-ascii?Q?jLPH3wNdfBpiPRLsKbpC+stdhl/9LksPCpsyuqUvOLx/0aRIudCd+U06UEUi?=
 =?us-ascii?Q?BY/7DTALKyTIBdz4L5ISP+93Govx+DHKZwaiS6NLM6koLw2TpbULs2sOB+8g?=
 =?us-ascii?Q?rmeltkvlpt6Ucmib+tLKK9tGspS6agQTc1I6QWgAMioOupDaVidxsoS/ckWn?=
 =?us-ascii?Q?bgbL9B1T3v/OOOwacF+YuocpSevVkBmZCwS0Yz9N3EGoS4mztpY8s/irxzac?=
 =?us-ascii?Q?eIDlcHZKnF7aaH0aKkWr5tRLYr98/dn75Fcyl4R8OCmNjwDeN/62HE65e5oW?=
 =?us-ascii?Q?njLCAanZFVerRPeS4GraMkZx+DWaMgu78W+AHFeec1hVUAHdc2TnQ5FA1LtS?=
 =?us-ascii?Q?HGW4FvO97DlgT2HvTAsvY0yUUnP/MOMmiE+1JtHx4D16rMY2mjEIWZuvy9Lb?=
 =?us-ascii?Q?UeGkJCAGX5mbP132QVfYe4YkT7pvjgK+VGNKKwnD29Tlv9oFLdQ8L99qJQ5I?=
 =?us-ascii?Q?L83vq7sy1qAoDfOYBllgME2l/q/L8dBraGDYyotGxz6sCUa94rlg3PdACPkx?=
 =?us-ascii?Q?GjYBCX64oVlhI3Ziteu9gQM7/H5ZDbzVYYfcnkbyYtdpREkdAUqmvFlStxr6?=
 =?us-ascii?Q?ljsFqIHL8ubQjvgDapn1aV1dknqcdUelxno3o4aooxrKq0k+sv+xBgVnu+N8?=
 =?us-ascii?Q?bnixCWx0YqJe8XcsH4FkTbqbN0A/9o436eVkn78LbT1JP3u8fW5HTrNpQwno?=
 =?us-ascii?Q?oay5+Z5madJdKmEUVMP1nTljPcL0RHhM8tdvoS3X?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8409.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af32097a-e02b-4c30-b9d7-08dd024a2f1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 12:12:59.7128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: st3XP3m8B83KVrw/TPHsbRlitE9QPXHfEp8bZPwQ9yJHSA313xrXOWhAlHThMkVYadKcp82XckPnHMao784VKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10911

Gaurav Jain would like to recall the message, "[PATCH] crypto: caam - use J=
obR's space to access page 0 regs".=

