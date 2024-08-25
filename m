Return-Path: <linux-kernel+bounces-300353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A9995E2B0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 10:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 676A11F21691
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 08:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BFE74070;
	Sun, 25 Aug 2024 08:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="pqZw306N"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2052.outbound.protection.outlook.com [40.107.117.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BC258203;
	Sun, 25 Aug 2024 08:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724574488; cv=fail; b=qrAhXk+TcQ6CTh7rXmFbgyAjxKBqV5a/msI0B19nLby1I+4qOLiDEVSonxnsrDJeStS+cqs8ky/Bmr9ej6JFMBjn0R1H9pGvSYchc5gusUL7n1JWuyMqb4ETUmYXX3q6+2hvBgVydGIfJijZvrLBDvI08zgnbQO9lneMF7uXYK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724574488; c=relaxed/simple;
	bh=tDKZOusKI+3jquJo8lBPUZka0hek757x8uTlgNP6szk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=e3IjAufWVOBtvjrkUPb2UWNFLT0A73OXtXikylbDcsaivOpnv22NU4cxXPksp5OoaxH3zT6QgaTrBlZ+KTIk24iPmcEc5guxSs7kU/zmDT+UG7ijLsy189oVLYIVhxPL/aOfsU0ncWEpdtrrVMl8Qw4eVBFGqO4xkhJsu9CBrwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=pqZw306N; arc=fail smtp.client-ip=40.107.117.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PkkyldH643YEvkTQPjffI3MFcXrWsrcm2BJHWtWR5G8bmWDw/rdsMLP5tytS4mDxUl4YqDXU8tQZKQfch4ihnIdm1Dx7hSVIlFTS7PdWEpYS+VdMCDrBokp3gwUn16jhNacHncFxjN8ekAxtBGdInhFdsqAyWV4PofYNuJ1mYA170I4RkKRMdtps8mjWVzHPg6lQlxyfh5uUY8JGqeBag8miraOpeOMsQaZ5bV4Z9xWM+iNtktn4UFCGvsgwSKq/71c79mFqXJgwCd3YC+fZfkoKCX7iEJwJKL8DkH6b0ObPMGghmYUopiEZukJKZxdZXUONIqnOL5KkRzWeoTpU0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDKZOusKI+3jquJo8lBPUZka0hek757x8uTlgNP6szk=;
 b=TBCcyPGO3/Fos27aOCwAcRFzWAeT4zFYXDR3aiak6JVrwfiUYYtHR02KoT1VLfOdx+MQ/WEle+XtXZtK0HsoXEqFtM2qlpihmZgXySZgbg4cvWcqOmVhFXLHkdIUiMOmXYuB5mvdAnSqyjS0CCkc+VHlwCK0hNwAq0bw7144zwbCq7nmwneTI1fZQRRZTddQOCtXSC+vgNhTc7Dq6wmBkoNCZtPIqiQpIcsgJho/2zsbH3NDK5ANPKqPe0nV/9cX4CEmVKX/t/3RPlJOLV2+hsfHzEnXIgg74spE3LKI2/CJ/kKLmBGr4S+9ZHEcxHgl3MLxLHbYyp/6881Egr1Imw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDKZOusKI+3jquJo8lBPUZka0hek757x8uTlgNP6szk=;
 b=pqZw306NWUi9R4BN/cCRdKFBu04Gwi7Bn1tO8KBlc8Melsdot3KDreuQkIx41oqr8tb8m97nGvlp5AxujPRfPJXeARtLAzqSJjI/Uvdi1vGoOUd26jkyF1fPIT/+mVmvCCXZte1bAaJckgHDVSQLuTEJWLwHXxL6FPRngQyKO3CMcy+ZEA75LSdmYz4CuIKtCXLNuGXk6i8RdnOBRKUK0u4G1+SibWpl7KQgHntQYjwzNaRzNdCa7UtdKEiKnTVUm0pAawnPDKjWLWsQjQRAfWqhHAk0G2Ab0PrtDe1GTgoL+uAI1XsQoo98m7v1BvK2s7V1z1ILzUGM9p6vtdZDfA==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by TYZPR06MB6992.apcprd06.prod.outlook.com (2603:1096:405:46::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Sun, 25 Aug
 2024 08:28:01 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7897.021; Sun, 25 Aug 2024
 08:28:01 +0000
From: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
To: Prashanth K <quic_prashk@quicinc.com>, Michael Nazzareno Trimarchi
	<michael@amarulasolutions.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Subject: [PATCH v7] usb: gadget: u_serial: Add null pointer check in
 gs_read_complete & gs_write_complete
Thread-Topic: [PATCH v7] usb: gadget: u_serial: Add null pointer check in
 gs_read_complete & gs_write_complete
Thread-Index: Adr2x1AMNHz5/SWqR8iMW+/vxX+Bag==
Date: Sun, 25 Aug 2024 08:28:00 +0000
Message-ID:
 <TYUPR06MB6217989A40FA4E18598DC694D28A2@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|TYZPR06MB6992:EE_
x-ms-office365-filtering-correlation-id: bfa71fe9-461e-4b93-4786-08dcc4dfd4e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TXpnTzF4czJjTG9DMVNxYStENmFoL21ja2I1TUpVZUtkejZkcVV2di9yMkkw?=
 =?utf-8?B?dFBYVnBsclg3QWh2SS9PZ0l5cWxIMzBOQ1dWQk40KzhDeVFTZThLVjBHMGxp?=
 =?utf-8?B?SG4yQVlnYnQ0b21xdFJBQkRaaW9tSVFVZXFLVDc2QStvbVhza1BxNnRYUzB1?=
 =?utf-8?B?T3NDSVQ1K1JKOGtYeVpWNjIrZEg0YWhNcXphT0VtUVdmMzNMNVV1YjU0bDBH?=
 =?utf-8?B?TnhaaWJoeVEyc3Q2eXBaSzJGVXl6WXp5Si81VlpMRmpkWC9EK2NyYjhUYVc1?=
 =?utf-8?B?WDZzTk9DbXlQOUVON3c5dDlYMmVzZUdxSjAxM0NzRlVKRWRPT1paSWJWcDBm?=
 =?utf-8?B?cmhTekFqcnJEZmkzSXlBcVRqcHdueWJSVURaNm4xUzc0Ni9GNHM0QXhmeW1l?=
 =?utf-8?B?a1VVLzh6L1JvOXF0dFh1bGNjVmtJTldQajFhaTVXdng3SVU0cjRXbjgwdVQ2?=
 =?utf-8?B?WTdnaWFYTkE0Q28zRDRRUmk0ejdmcE5ocnNaNURpTDRyUzBDLy9LTFEvT1ln?=
 =?utf-8?B?K2RtYU1pV3pua1VMa0pwQzM2MmNaYmRTQkJhcjZpNXQxVk50NkpSS2VjL1Zz?=
 =?utf-8?B?L0RPVDZPaExFMVRqa1ZOK1VheE9nYTVCME5lNXV6dm4yVkpnZVBkV2o5M29N?=
 =?utf-8?B?Z21HWlNIZ3BaQnQrRTBua1hMelZJS2NJYWpMUHZrWEw1eVVOSWNCRk5DbFA1?=
 =?utf-8?B?bUtFUU9sSFBiMWxmTnBLZlBkcEdkSWlhSXFyRjUzWE1WdEdDeUNKZFpEVElx?=
 =?utf-8?B?NnpOQjJ4djlua0JBZldsZUEyVFhFanljNnd1dC9vcTk0bnN3TklOdlFHV1lu?=
 =?utf-8?B?dmkzWWxpajluN2EwZFRrUEZnbnN1U2t2UVg5MmhLNU9qK0V5TURoYUFLZXg1?=
 =?utf-8?B?bE9kNFRTY3B6OG8rVXhTRzE3a1EySjNvVGxFZU5Yd2NLQTNtN0E4bjlUdWI2?=
 =?utf-8?B?ckVzU2JYR0ZQTDliamNxSkVRT3AxSXRxYnhTSXRuckRZcnoxc3k3QnZweTBH?=
 =?utf-8?B?SlQ0VzBmcnEzVWd0dFNNSzJ1WGRESUxkL0VKME1EaW4wYWpJZWlPK2pHdmlq?=
 =?utf-8?B?djkrUmJvNm5BM0hTaEhISEc0eG9PVDVhTHBsdEw1V0JreWN1RlV3NjdBR3Vy?=
 =?utf-8?B?TERTQlZnRWsxd3lpd3JuNDMvamNQbE1xZ0w2cjg0bklqRE01bGg0U0hpbXln?=
 =?utf-8?B?emszaGhuUmxDcW8wWjJyM2pPRnMvbjlCZGpTYkVDWVJ2Y0Urd0xZcWkxeDBh?=
 =?utf-8?B?OUdMQVgzT1RTU0N4Vlk3N0l0dmdkT0xwcWhtZmJxa3RDK0dIdE94NnlDUDZB?=
 =?utf-8?B?RzcxU1lMS0g1aXFLS0d0RUtnUzdvQm13QTVxOGJOZytPRWRadExjTmNYRVJx?=
 =?utf-8?B?RzVORmxGQzBqRllEYnNvbFFTT0hkVzRZN1JNTjJUMUxDRXNTYWhLR2pocEFn?=
 =?utf-8?B?VkZWN0w0WVNHRkRhMG5TWWpUeUUydHJDaklNa0owaEJvM0NvaDhYSkhOOUJE?=
 =?utf-8?B?UUk5c0dXQSttblgrTFpkRUtldmFrSHFqQ0NmNFcxSFVHWkdUbHVuYTlyRzNr?=
 =?utf-8?B?WjFHOFBiekFKTHptWWk5WEFjY1BVSFNuNVBIUHliY0dYNzZzZEl0VzVGakl6?=
 =?utf-8?B?bGlvV3VSeWlMOFg4UlhLWkZ2VzlRTXlaYzhWci8vcnh0dDlicGhrS013QTd1?=
 =?utf-8?B?OVFzekp0am9jQXlkczNxbGZqanJmd0pXMHlnVG5Ub1BEQ280UG9ON1NUdTU2?=
 =?utf-8?B?SmpRY2VHN3EwNnFlLzJlb1NrcU9NMmZDQU9ZRFpTczQ5K2tqOVFrV3NGQzVt?=
 =?utf-8?B?eWYzVktRTEJvL0h3clBBOW4vSmRTU3BSdzRLcHNIRm8yRHdsSmx6dnpqZFEv?=
 =?utf-8?B?cWM3Q2VnSzE3cjZuaW5oSXFqajk4WUsvTWJqcnVNTEFkaVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q3I4VTc3TUZzZ1pYMTV4Q1FBc3UzeC9JQXFLYTVtcStxMWxwMWxoVUVNVUNa?=
 =?utf-8?B?eEhzSmpBdlNON1JMZVJlRGxIQkF6U1pSWkFIbVZNRXpIYll4VCs5U3poU3BP?=
 =?utf-8?B?TVI4YXBzSkZpNUVPbGpFYWY0Rm1MT1hYVFRXNXNVZU5udWo0TWY0bldyTWdv?=
 =?utf-8?B?REVGSHF6ZVc5TzJNbnBFdE1xTmZCZTYwMHhNUm5RT1ZHUzhrT3l2S2VXdjI1?=
 =?utf-8?B?bDE1VW5qbXl1RERFdFBXYnZ5K0lKSzVMTWZoc3NIOTdia1hOT1p5ZFJaYzhp?=
 =?utf-8?B?NWFFRldmdzNZOTBMZ29LU1VSZnpZaG96eVJWb2ovWlJPODZ2d25uNi8ySlho?=
 =?utf-8?B?SktUVWxxRWxtV0Z2WTJCYnVxNVd6M2laQWlvV3o5cmt4ZUZ6NDlLT0FSclBQ?=
 =?utf-8?B?MVprNlBEL0I4R3Y2dTc5U0R5dm4wUWx5ejJiR1BUTk9HYWx1RGFjL0srUGt6?=
 =?utf-8?B?Qm1YcFJjRFZJelpjL1R6d3oxOUNoMXRyYjFOVWlLQzlLSDExNkw4SXIxTkJ0?=
 =?utf-8?B?cTRmdWVrbmZ3MWpEbnkyeU1ianVtRVdFUzh4NGpKamR5VjVxM3VVa3NSY0l6?=
 =?utf-8?B?YW12ZzhYUFVBdGV3WUFacys1VEthZFNHNFlQeVZFR2E4aXBlbjlHR2JOOUlT?=
 =?utf-8?B?aEhBem9PS2RMSEtZakdUWWtubUJ2Wi9VcnBpV3dVUXFFem5tL05URXdaem5X?=
 =?utf-8?B?VCtndmcyVXBhQVpRMXdoU3pmb2NGbzBUcjIrTVlHTi9hUGpVS2VUYTczQi8x?=
 =?utf-8?B?UGxUYmI4VnB5eGdzWXk2M2dkcU03ZU1zVk9pelBCc1M1MFRkMksrSUJxajdl?=
 =?utf-8?B?cUJ3YlRmQUdFWGQvYmszUjZKc0NVcmQ4a3hFVGhNVzZYTzBMNXJ6OTVzZDUz?=
 =?utf-8?B?eVlsYTYvV3lwdHp5LzJEWHpYZkRETXd2U3hWVzAzWEtIQmsrbVRVdkswNFVk?=
 =?utf-8?B?TmR6dmorZFpENjFXd0srMTBvOGFtdG96QURPVkt1dVhYYTQzS21RV29TQ3Rx?=
 =?utf-8?B?S0h0V3VkSjV2Mm5mYU91aDdkWUZ5ckIxY21uNzQ1N2tDa25ud0dubTNIcEN6?=
 =?utf-8?B?NmEwVjRvNzVZR1VWb1I1NnNFRFNmR0dsWUlFRWRValZ5THk0L0N6dTNZUU9O?=
 =?utf-8?B?NFJ3UWJFTkptY3BoVDlIay9YZ0tPWjRwWXh5c1BhMTJGQzA5QWNmNHlMQ29P?=
 =?utf-8?B?T3ZzOGl0TmlKczd6cmhPSGdmcEhPZEY1bnNYay9ERVc5WWdrWi9IMXNhMkts?=
 =?utf-8?B?Z2lPZGlaUXlNYUlxKzhPV1VTamE5Z05XRmZIaVNFN0JtU1hvR1dBOGR3VDht?=
 =?utf-8?B?dmpvWDNQNTgvOHdxekh4cUZYZGpsY2NqdEVZSnlMd0ZUT1JTL0NIRnZCQU9n?=
 =?utf-8?B?NzZTajdEOXpvRFhDTFI4Ykl4T3B6cVNTRmhSMVRNOVhPT01CM1p5MUJLVHN4?=
 =?utf-8?B?NU5iYll6dWxrZ3VLV1VYbEtoWjg5OWJRODU0U3lXd04xbHUyNkE4Mk9SSzI2?=
 =?utf-8?B?TVVBTXMxMWdoWHl0MmhickJJUWV3SlRHUFdTT3NHeVZmamF3WElYTUNvaXpa?=
 =?utf-8?B?UVlUNHBxK2FHUVFMalI4WTR3MzdiUmZlYWZGZENGRkhVWXZEcWVvK3RVWkpm?=
 =?utf-8?B?eDEweE9hUTdBYXRUOGdFd3lIc3VJK0phS0kzS0VJOFlNT3l6VnZjcG50NGdJ?=
 =?utf-8?B?d3VJZkNmQndnNWZWUnRRdUlVd3FMRVBsUTAydjJtNENpb1pTcXpCTGVxWG9G?=
 =?utf-8?B?RHp1VVVZK2hLU3VaRXZOQVZaT3FKTjhJRFhiRTFpQzFabXVmZUNHalhlbGZi?=
 =?utf-8?B?Ni9SYXBGbEREcEN1dlh2RlZNdzYyMmIrWmdJYzV3RjdRc2lyckVqM2JGTU90?=
 =?utf-8?B?K0dFd1I0WGxDdTA4bEt0V2d3K3IvQkdNNVd2M1NjTCtjK2U3ZUhsTzdDRXpx?=
 =?utf-8?B?QnBlN1BhSGxUN010OGhpb2hybG42MmZOMUlKWjhnWjNoMFZORHNjTm05U2Mw?=
 =?utf-8?B?Y0lhRWhkYUh4NFBxTXo0Ymh5anJEZEp3ei9rdWtLdUljd2xXTnI3Z3RTMUNk?=
 =?utf-8?B?SHkwS1BOY05PYnhFTGtldHQrQ00rQkc4eFVOSFdLa0F6S29QVkRCKytVSWI2?=
 =?utf-8?Q?AqDU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYUPR06MB6217.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa71fe9-461e-4b93-4786-08dcc4dfd4e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2024 08:28:00.8172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uOaI2MNXYU6U0ICvnJLe5yzuQzyHZSUTo1uFfysNN1t7DeDTYWN/I8onzu525okz8jUXs+lzdbMzmQYwpNE37Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6992

RnJvbTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KDQpDb25zaWRlcmluZyB0aGF0
IGluIHNvbWUgZXh0cmVtZSBjYXNlcywgd2hlbiB0aGUgdW5iaW5kIG9wZXJhdGlvbg0KaXMgYmVp
bmcgZXhlY3V0ZWQsIGdzZXJpYWxfZGlzY29ubmVjdCBoYXMgYWxyZWFkeSBjbGVhcmVkIGdzZXIt
PmlvcG9ydCwNCmFuZCB0aGUgY29udHJvbGxlciBoYXMgbm90IHN0b3BwZWQgJiBwdWxsdXAgMCwg
c3lzLnVzYi5jb25maWcgaXMgcmVzZXQNCmFuZCB0aGUgYmluZCBvcGVyYXRpb24gd2lsbCBiZSBy
ZS1leGVjdXRlZCwgY2FsbGluZyBnc19yZWFkX2NvbXBsZXRlLA0Kd2hpY2ggd2lsbCByZXN1bHQg
aW4gYWNjZXNzaW5nIGdzZXItPmlwb3J0LCByZXN1bHRpbmcgaW4gYSBudWxsIHBvaW50ZXINCmRl
cmVmZXJlbmNlLCBhZGQgYSBudWxsIHBvaW50ZXIgY2hlY2sgdG8gcHJldmVudCB0aGlzIHNpdHVh
dGlvbi4NCg0KQWRkZWQgYSBzdGF0aWMgc3BpbmxvY2sgdG8gcHJldmVudCBnc2VyLT5pb3BvcnQg
ZnJvbSBiZWNvbWluZw0KbnVsbCBhZnRlciB0aGUgbmV3bHkgYWRkZWQgY2hlY2suDQoNClVuYWJs
ZSB0byBoYW5kbGUga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdA0KdmlydHVhbCBh
ZGRyZXNzIDAwMDAwMDAwMDAwMDAxYTgNCnBjIDogZ3NfcmVhZF9jb21wbGV0ZSsweDU4LzB4MjQw
DQpsciA6IHVzYl9nYWRnZXRfZ2l2ZWJhY2tfcmVxdWVzdCsweDQwLzB4MTYwDQpzcCA6IGZmZmZm
ZmMwMGYxNTM5YzANCngyOTogZmZmZmZmYzAwZjE1MzljMCB4Mjg6IGZmZmZmZjgwMDJhMzAwMDAg
eDI3OiAwMDAwMDAwMDAwMDAwMDAwDQp4MjY6IGZmZmZmZjgwMDJhMzAwMDAgeDI1OiAwMDAwMDAw
MDAwMDAwMDAwIHgyNDogZmZmZmZmODAwMmEzMDAwMA0KeDIzOiBmZmZmZmY4MDAyZmY5YTcwIHgy
MjogZmZmZmZmODk4ZTdhN2IwMCB4MjE6IGZmZmZmZjgwM2M5YWY5ZDgNCngyMDogZmZmZmZmODk4
ZTdhN2IwMCB4MTk6IDAwMDAwMDAwMDAwMDAxYTggeDE4OiBmZmZmZmZjMDA5OWZkMDk4DQp4MTc6
IDAwMDAwMDAwMDAwMDEwMDAgeDE2OiAwMDAwMDAwMDgwMDAwMDAwIHgxNTogMDAwMDAwMGFjMTIw
MDAwMA0KeDE0OiAwMDAwMDAwMDAwMDAwMDAzIHgxMzogMDAwMDAwMDAwMDAwZDVlOCB4MTI6IDAw
MDAwMDAzNTVjMzE0YWMNCngxMTogMDAwMDAwMDAwMDAwMDAxNSB4MTA6IDAwMDAwMDAwMDAwMDAw
MTIgeDkgOiAwMDAwMDAwMDAwMDAwMDA4DQp4OCA6IDAwMDAwMDAwMDAwMDAwMDAgeDcgOiAwMDAw
MDAwMDAwMDAwMDAwIHg2IDogZmZmZmZmODg3Y2QxMjAwMA0KeDUgOiAwMDAwMDAwMDAwMDAwMDAy
IHg0IDogZmZmZmZmYzAwZjliMDdmMCB4MyA6IGZmZmZmZmMwMGYxNTM4ZDANCngyIDogMDAwMDAw
MDAwMDAwMDAwMSB4MSA6IDAwMDAwMDAwMDAwMDAwMDAgeDAgOiAwMDAwMDAwMDAwMDAwMWE4DQpD
YWxsIHRyYWNlOg0KZ3NfcmVhZF9jb21wbGV0ZSsweDU4LzB4MjQwDQp1c2JfZ2FkZ2V0X2dpdmVi
YWNrX3JlcXVlc3QrMHg0MC8weDE2MA0KZHdjM19yZW1vdmVfcmVxdWVzdHMrMHgxNzAvMHg0ODQN
CmR3YzNfZXAwX291dF9zdGFydCsweGIwLzB4MWQ0DQpfX2R3YzNfZ2FkZ2V0X3N0YXJ0KzB4MjVj
LzB4NzIwDQprcmV0cHJvYmVfdHJhbXBvbGluZS5jZmlfanQrMHgwLzB4OA0Ka3JldHByb2JlX3Ry
YW1wb2xpbmUuY2ZpX2p0KzB4MC8weDgNCnVkY19iaW5kX3RvX2RyaXZlcisweDFkOC8weDMwMA0K
dXNiX2dhZGdldF9wcm9iZV9kcml2ZXIrMHhhOC8weDFkYw0KZ2FkZ2V0X2Rldl9kZXNjX1VEQ19z
dG9yZSsweDEzYy8weDE4OA0KY29uZmlnZnNfd3JpdGVfaXRlcisweDE2MC8weDFmNA0KdmZzX3dy
aXRlKzB4MmQwLzB4NDBjDQprc3lzX3dyaXRlKzB4N2MvMHhmMA0KX19hcm02NF9zeXNfd3JpdGUr
MHgyMC8weDMwDQppbnZva2Vfc3lzY2FsbCsweDYwLzB4MTUwDQplbDBfc3ZjX2NvbW1vbisweDhj
LzB4ZjgNCmRvX2VsMF9zdmMrMHgyOC8weGEwDQplbDBfc3ZjKzB4MjQvMHg4NA0KZWwwdF82NF9z
eW5jX2hhbmRsZXIrMHg4OC8weGVjDQplbDB0XzY0X3N5bmMrMHgxYjQvMHgxYjgNCkNvZGU6IGFh
MWYwM2UxIGFhMTMwM2UwIDUyODAwMDIyIDJhMDEwM2U4ICg4OGU4N2U2MikNCi0tLVsgZW5kIHRy
YWNlIDkzODg0NzMyN2E3MzkxNzIgXS0tLQ0KS2VybmVsIHBhbmljIC0gbm90IHN5bmNpbmc6IE9v
cHM6IEZhdGFsIGV4Y2VwdGlvbg0KDQpGaXhlczogYzFkY2E1NjJiZThhICgidXNiIGdhZGdldDog
c3BsaXQgb3V0IHNlcmlhbCBjb3JlIikNCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQpTaWdu
ZWQtb2ZmLWJ5OiBMaWFucWluIEh1IDxodWxpYW5xaW5Adml2by5jb20+DQotLS0NCnY3Og0KICAt
IFJlbW92ZSBjb2RlIGNvbW1lbnRzDQogIC0gVXBkYXRlIHRoZSBjb21taXQgdGV4dA0KICAtIEFk
ZCB0aGUgRml4ZXMgdGFnDQogIC0gQ0Mgc3RhYmxlIGtlcm5lbA0KICAtIEFkZCBzZXJpYWxfcG9y
dF9sb2NrIHByb3RlY3Rpb24gd2hlbiBjaGVja2luZyBwb3J0IHBvaW50ZXINCiAgLSBPcHRpbWl6
ZSBjb2RlIGNvbW1lbnRzDQogIC0gRGVsZXRlIGxvZyBwcmludGluZw0KLS0tDQogZHJpdmVycy91
c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMgfCAzMyArKysrKysrKysrKysrKysrKysrKysr
LS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0K
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMgYi9k
cml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYw0KaW5kZXggYjM5NDEwNWU1NWQ2
Li5lNDNkODA2NWY3ZWMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24v
dV9zZXJpYWwuYw0KKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMN
CkBAIC00NTIsMjAgKzQ1Miw0MyBAQCBzdGF0aWMgdm9pZCBnc19yeF9wdXNoKHN0cnVjdCB3b3Jr
X3N0cnVjdCAqd29yaykNCiANCiBzdGF0aWMgdm9pZCBnc19yZWFkX2NvbXBsZXRlKHN0cnVjdCB1
c2JfZXAgKmVwLCBzdHJ1Y3QgdXNiX3JlcXVlc3QgKnJlcSkNCiB7DQotCXN0cnVjdCBnc19wb3J0
CSpwb3J0ID0gZXAtPmRyaXZlcl9kYXRhOw0KKwlzdHJ1Y3QgZ3NfcG9ydAkqcG9ydDsNCisJdW5z
aWduZWQgbG9uZyAgZmxhZ3M7DQorDQorCXNwaW5fbG9ja19pcnFzYXZlKCZzZXJpYWxfcG9ydF9s
b2NrLCBmbGFncyk7DQorCXBvcnQgPSBlcC0+ZHJpdmVyX2RhdGE7DQorDQorCWlmICghcG9ydCkg
ew0KKwkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmc2VyaWFsX3BvcnRfbG9jaywgZmxhZ3MpOw0K
KwkJcmV0dXJuOw0KKwl9DQogDQotCS8qIFF1ZXVlIGFsbCByZWNlaXZlZCBkYXRhIHVudGlsIHRo
ZSB0dHkgbGF5ZXIgaXMgcmVhZHkgZm9yIGl0LiAqLw0KIAlzcGluX2xvY2soJnBvcnQtPnBvcnRf
bG9jayk7DQorCXNwaW5fdW5sb2NrKCZzZXJpYWxfcG9ydF9sb2NrKTsNCisNCisJLyogUXVldWUg
YWxsIHJlY2VpdmVkIGRhdGEgdW50aWwgdGhlIHR0eSBsYXllciBpcyByZWFkeSBmb3IgaXQuICov
DQogCWxpc3RfYWRkX3RhaWwoJnJlcS0+bGlzdCwgJnBvcnQtPnJlYWRfcXVldWUpOw0KIAlzY2hl
ZHVsZV9kZWxheWVkX3dvcmsoJnBvcnQtPnB1c2gsIDApOw0KLQlzcGluX3VubG9jaygmcG9ydC0+
cG9ydF9sb2NrKTsNCisJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcG9ydC0+cG9ydF9sb2NrLCBm
bGFncyk7DQogfQ0KIA0KIHN0YXRpYyB2b2lkIGdzX3dyaXRlX2NvbXBsZXRlKHN0cnVjdCB1c2Jf
ZXAgKmVwLCBzdHJ1Y3QgdXNiX3JlcXVlc3QgKnJlcSkNCiB7DQotCXN0cnVjdCBnc19wb3J0CSpw
b3J0ID0gZXAtPmRyaXZlcl9kYXRhOw0KKwlzdHJ1Y3QgZ3NfcG9ydAkqcG9ydDsNCisJdW5zaWdu
ZWQgbG9uZyAgZmxhZ3M7DQorDQorCXNwaW5fbG9ja19pcnFzYXZlKCZzZXJpYWxfcG9ydF9sb2Nr
LCBmbGFncyk7DQorCXBvcnQgPSBlcC0+ZHJpdmVyX2RhdGE7DQorDQorCWlmICghcG9ydCkgew0K
KwkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmc2VyaWFsX3BvcnRfbG9jaywgZmxhZ3MpOw0KKwkJ
cmV0dXJuOw0KKwl9DQogDQogCXNwaW5fbG9jaygmcG9ydC0+cG9ydF9sb2NrKTsNCisJc3Bpbl91
bmxvY2soJnNlcmlhbF9wb3J0X2xvY2spOw0KIAlsaXN0X2FkZCgmcmVxLT5saXN0LCAmcG9ydC0+
d3JpdGVfcG9vbCk7DQogCXBvcnQtPndyaXRlX3N0YXJ0ZWQtLTsNCiANCkBAIC00ODYsNyArNTA5
LDcgQEAgc3RhdGljIHZvaWQgZ3Nfd3JpdGVfY29tcGxldGUoc3RydWN0IHVzYl9lcCAqZXAsIHN0
cnVjdCB1c2JfcmVxdWVzdCAqcmVxKQ0KIAkJYnJlYWs7DQogCX0NCiANCi0Jc3Bpbl91bmxvY2so
JnBvcnQtPnBvcnRfbG9jayk7DQorCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnBvcnQtPnBvcnRf
bG9jaywgZmxhZ3MpOw0KIH0NCiANCiBzdGF0aWMgdm9pZCBnc19mcmVlX3JlcXVlc3RzKHN0cnVj
dCB1c2JfZXAgKmVwLCBzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkLA0KLS0gDQoyLjM5LjANCg0K

