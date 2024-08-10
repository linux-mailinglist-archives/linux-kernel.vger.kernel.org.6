Return-Path: <linux-kernel+bounces-281787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FA294DB50
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 10:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C169A1F221E9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 08:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBD414B081;
	Sat, 10 Aug 2024 08:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ExPgPpOw"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2033.outbound.protection.outlook.com [40.92.42.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AD934CE5;
	Sat, 10 Aug 2024 08:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723277038; cv=fail; b=SZ4MWGM9dsv83Pm3j/0+nVDKAPtUXg+s9c04xNj4oZikA25LNSVxnhYjpT813y3dtdw7eYvBaspdrLjQd7wcNsLXnI5J6e2GMxu0jc6P4/G7U9kjjlG/c4K7qFNHISKFwmNqBEDMjHsihNW2nTEj97CwkOhLFgeQA9E32xObLF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723277038; c=relaxed/simple;
	bh=f5u7/HOWtC3oS9BWDOOz4KxoWLRlqmrS7rql1RDNLSE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XJE+RTtJ6y5ZZDr/O1UDeDVQj2VyDXE0PmiJ9TnvXcJNhy1P0JSbE10C60j8FDHDA5XwrMaz56zx8pMbIhiH9CgDzpw+sivEGaKK38pdmwgCjGvP5ZFz+HBNVBjhyBFt13K8W1VJoaowOAXaLCOD26oOjqDxHEJJQ1tnAVhSx+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ExPgPpOw; arc=fail smtp.client-ip=40.92.42.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qn6bYJo4DDY/gGFfQvSrRdsITQvs8skjGEbwvcQrSNnCJe3oJgTfLgTT4Wqxxx8cIWwI3Gi90QXJnnts38bUTpW9Uwm+h4MKDBXoUKAIRbcNJDuMb+43epSqypKTWJ3hFYIwudatVoFeVJFkfgYmDVU22DtMdICvriT3fNTBSpGuMNgHOw91NfwnDQrzQo+kQnkbxSfH/Tz/HuW33nni5YdkLt+2pQKQaXiSC5EIxLD1peczKZciUR7NeOFJTC1oSpB72Fk+Ldq/EJxa3RmD3Uzey535cFUsOeMEcT8L+axO+HorXTVjhPRXp65ultIdmgMSSDUjnwsweIMx2kDCxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mi3Az0JRlQjKq+1wQWxafTGjvrVZazpXaXtVblE35I0=;
 b=UYnZD0Oj3wMRJHlCX5cQjeqdDuW3AvRtxM8NLC2POMookpti+4iQ5WW1UopD1Si+K89vE4nMIpAvcZR/INQG1ulc+Tr0TLW31515g0UkdxY5dJ4GhJNA+YWeFtSSbfAA6V4j8fieibnhZfYxzy9XmGmlwQrkG2MhYhyergZnLJ769+1MM0KKBjaNG2zrD2cAyyjuyvvjJLDqrm2iViuYi6F4L6o/lW4coUu2OCddvi5uttip7H1QVIFIIuBc2SBPYfk7Hko2qZZghnj5SDE8F5Ifl0dEi95WkFKCAE+XQuI7Hivel7llW40RoXOfjljuCRpqsyuXoYtUQ7ctuFSBaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mi3Az0JRlQjKq+1wQWxafTGjvrVZazpXaXtVblE35I0=;
 b=ExPgPpOwnbrurTK7djWgV13tvdz8XdX5Dryb17X6KKCy/UAUZyW4bD2tol3mYbhfk532EdRbA/NJc6moaYGVxMPjGryUgjfa1PJFUsPTaf+bk0nF+SjvFW/yJcGp6AhsW8zjwkzl8MynOmH3cZB9vSd4FTqo4JDnDxk2jHKdSDb5as3G5FJsUg7KXKebZcvse4kirdia4qeSzEQwYmPkAEwzhh48G2GRdEQp8p/kcdqepiJis2iTs2HPOgYkpwhOxHO9nmUYOOlWBqOZnmS9hN8cngF80CQ8QBuWeo7vMp5utXDc3oZ1FeflI7kwOzAwD5+pXPhCn3QNbgDVz4wZMA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB5117.namprd20.prod.outlook.com (2603:10b6:510:1b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Sat, 10 Aug
 2024 08:03:50 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7849.015; Sat, 10 Aug 2024
 08:03:50 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Hal Feng <hal.feng@starfivetech.com>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v10 0/4] riscv: sophgo: Add SG2042 external hardware monitor support
Date: Sat, 10 Aug 2024 16:03:13 +0800
Message-ID:
 <IA1PR20MB4953C5DB4AC5DF01236CE785BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [fUL1MM2j2DHRk5Sq2Af3uE7/7Ch5OAk7b+ng64cyD6c=]
X-ClientProxiedBy: TYCP286CA0154.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::19) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240810080314.382409-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB5117:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a649d99-a707-4c97-74bd-08dcb912f831
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|15080799003|5072599009|461199028|1602099012|440099028|4302099013|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	niZzoufR1FtIbRAcByuqxhSu52kGc7NGr53bu1N9OlUm2GTL8xpvIIPHC+RcrRGo04v0985rRt/FupH6Z2No50zvoWB9bMGBo8FPwDfXUlCUqxnSrRA23MwkhCsBB3JzaKaADIQW7PrT2IQdyDmeYYp3HMz2ysOKhThBu4wm+xy4dP6qxtyprhNG5VDAzq7PJ5uORazBFke66leW1bWO7HVUiyvb3fvouDGJZJVFokO1iwmUR6RtT1W8HwLfcnO+7n7vrWnd8ZrkJZRKJyC72Kcn99mD/t+zTY3dg/OqrVrgrjbMPZYRAi/N1YE5zXxzLytplV8KFjisUf9EA5ParZaENYQQGPUXcZ+VM9KTV8r14k6wG79+wxI1SQ4bDxZl2IV4JwkpFK7U0WB2ZiVs1XVs/AxvHelm52rSq0LVsTQ6xQBUuH7YicP1k7rmussnhdI3NZiRXozpnHCtlmfD5r5VehgM1tRDCdBZOK9C4OmXvqOmj/cU6lk6gJ5d+0KezhnWy30s2aPeaQ+tSfZC4E51cYbwyAh4yyDjVB2s1KvIEj5RoDBl2XHAAqV6NSE7rDGRNAuhRVl4VAzEvfgkfn/WhC/2sT3i54BEtzPCJGhC8TxIx66SKyFN4Dr65v/ppz3vX+3/kYlTd/wii76el4UXhEIpTa7HCzlbS84jR/N9Buf0NlCK7Mzs1Og97Z4lEHrRvsqGJVwuo1OTj0RGvxUbwpQBtrwl67QnAp8RzyX6mGJ3gbXQXql8SL9eldDeLJ8oIdYv/VlqnlZ8WEHdQTIwrr9a2wAQYBkapc9+ouoe5LggTih6r7y1swamXn3jUJ9oZ5bFInOCBtZBqxPmjw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pTfspcu0mgXLvIxMq6VJAQwnU380kp6VKOrVsZk5+li5r2RUXs7rL8i9V/Rf?=
 =?us-ascii?Q?naDMpI5CN4mhUOWknO1O7+YN37bWlruLgxU69pvl+I/8tymmsLqs970yVXk3?=
 =?us-ascii?Q?zwm9Q75CRf5lvmVbNBEYctA99mRhRSS8185iA87X4JVbKCk9pQxZSwmIDC9u?=
 =?us-ascii?Q?qJIIE5yCDJKFapI/sDKJtTi6NAgey/WxMAUSx5FWHtP7WJ482ynn7OJTyBdE?=
 =?us-ascii?Q?aNRCELOPUGqC8aJsjL+Q+S0rqFEuIy2s31TdFGx/v7w6tpq7F6x55HgZ3XiR?=
 =?us-ascii?Q?bOfYqzH/uH7QWAklfEXzpLlDqM2yxqMuyQXrCRgESGDZgB6+Ji/Bv1v0NUJK?=
 =?us-ascii?Q?c/FRg+HM5I3WlSDultKiaJTFUYTehwe5jLf8H3l7sRm3/KBv73jdxGxHdmHl?=
 =?us-ascii?Q?FgplLjXiw6kzhdrNmKaKxE1cvHeCUY7q/bjvkuIm5ADuhrsk9keUkPbzhft0?=
 =?us-ascii?Q?ezJAY+dorKAc+uI95glpP3v8P7+RW5cv0+XeJSMuNuablP19WYrtSuiykUTo?=
 =?us-ascii?Q?mko6JxBV4B8OYgcPAMXpYVuZ2UpUIvtlKGnFeUc649V5vgSFeejNhVBn/I9D?=
 =?us-ascii?Q?DY/pBioRoAwTSEKsi3nifq3fH9qyq140kiaPZb+jZWas2SXhIuYTjsqsJyRK?=
 =?us-ascii?Q?hEEforW0+vAPHjLUjoPEX98SQFx0mh4ZWza9MlOg21irIWo0SPV8av1SZ+4S?=
 =?us-ascii?Q?42FHcSN3nUbgm9Rn3aCczKYUqIESwId9NHKf8lSp10iyVXiGXbnVdcYGDf5s?=
 =?us-ascii?Q?bSac2cltgx/CptjMezhjr7GEh1Y4yqQUhriFG2DZDLFvGUf8Pxuz5Okzrmg2?=
 =?us-ascii?Q?ydYuwLB/SJKzLXTilyL4vvxdxqLlo+WmcdrO2EgZIOeaSd7KznnBZX+lGVes?=
 =?us-ascii?Q?YZnwMZbYRzuLuF+0rC6Cm3yyInKULPgLx2yjyKGEnMO8GtdyX/F8UaQ8LhuU?=
 =?us-ascii?Q?MHVwGiFm5Ldb734ub+1PEU+FOmDXTGkZhgnLdstFZWXB5uY+ExdO339iFu+q?=
 =?us-ascii?Q?0A+hsgoom7344HEAlNbWrzyZZousyL9snVVZi+s3vBge7b+uMMOwB7Bj/G/w?=
 =?us-ascii?Q?g1V9ZnLbVmHyIp4wFEbB8EH23bz9Ql8FuMtdB01jlWPZNzu8jGkttr/URzcX?=
 =?us-ascii?Q?UD4QD/bgSbcNDWDj7YdzTFipdEwbjeOn9FESRiUCq5DkHxdpLSQetCuzFtzT?=
 =?us-ascii?Q?rhZBGzL9hsyIbwJeqvDXGVMqCk8+76rrGXLUqSTEcu4fIbtFJxAKI2PKgGc5?=
 =?us-ascii?Q?a8N/2/w6MZymrkYS9wpb?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a649d99-a707-4c97-74bd-08dcb912f831
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 08:03:50.6542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB5117

Add support for the onboard hardware monitor for SG2042.
Can be tested with OpenSBI v1.5.

The patch require the following i2c patch:
https://lore.kernel.org/all/IA1PR20MB4953DB82FB7D75BF8409FFF4BBB72@IA1PR20MB4953.namprd20.prod.outlook.com/

Changed from v9:
1. remove missed wrong return value.
2. add documentation for the other interface of the driver.
3. rename repower_action to repower_policy.
4. use break to unify "return 0" in is_visible function.

Changed from v8:
1. rename critical_action to repower_action, and add some comment
2. remove unnecessary wrap function
3. use guard macro to simplify mutex process.

Changed from v7:
1. add mutex protected and fix the return value when writing
"critical_action"

Changed from v6:
1. restore the driver name to sg2042-mcu
2. remove unnecessary wrap function and check in the driver.
3. add dts and config entry.

Changed from v5:
1. rename driver name to sgmcu as it will support more sophgo chip.
2. move some attr to debugfs.
3. add standard crit_hyst support
4. add documentation

Changed from v4:
1. use fix patch for binding ref.
2. use unevaluatedProperties instead of additionalProperties for binding

Changed from v3:
1. add thermal-sensor check.
2. change node type from syscon to hwmon

Changed from v2:
1. fix bindings id path.

Changed from v1:
1. Move patch from soc to hwmon.
2. Fix typo.

Inochi Amaoto (4):
  dt-bindings: hwmon: Add Sophgo SG2042 external hardware monitor
    support
  drivers: hwmon: sophgo: Add SG2042 external hardware monitor support
  riscv: dts: sophgo: Add mcu device for Milk-V Pioneer
  riscv: defconfig: Enable MCU support for SG2042

 .../hwmon/sophgo,sg2042-hwmon-mcu.yaml        |  43 ++
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/sg2042-mcu.rst            |  77 ++++
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |  60 +++
 arch/riscv/configs/defconfig                  |   1 +
 drivers/hwmon/Kconfig                         |  11 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/sg2042-mcu.c                    | 388 ++++++++++++++++++
 8 files changed, 582 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
 create mode 100644 Documentation/hwmon/sg2042-mcu.rst
 create mode 100644 drivers/hwmon/sg2042-mcu.c


base-commit: d2d190621b60d77496d36659e1621b20c897b25d
prerequisite-patch-id: 5e7221ed1c63bb4d68e4a2a0141440e32d29e397
--
2.46.0


