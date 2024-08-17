Return-Path: <linux-kernel+bounces-290509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F13F79554D3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 04:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 665181F226FD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 02:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0CADF60;
	Sat, 17 Aug 2024 02:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="T/aL0wac"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2109.outbound.protection.outlook.com [40.92.41.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEA72EB02;
	Sat, 17 Aug 2024 02:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723861377; cv=fail; b=DFa1nn9Rt3EiGi+Eofx8632kFdJEiVpL9r6jpuzAyPgN+rBl06I0h+gF4/Gkrcc75lTCR32vpFU2Sv+uwHrp3RfGgcjAwXYtsrv+3Nbeqq7BV2AqdbDEtYyQCzkV8hlBf+Q480DJHi0WZEi7RdKxwhUY7w68J/0LfccsMCOHFRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723861377; c=relaxed/simple;
	bh=rT2Et60RfwlYjRsIhnLI5UEhq3nML8nh89DSEDovlx0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=X8+A/oHvADLYSZjWvk2BAoaVLJ6rfWeb2ACrjhisYidpKztfsxvnb6gQWRAEDKzoMR1kJIbK4ox8vbbhHnqORwuLL09K5p9hh0yFU7u1Jalr6JB7NJZNH7UiD56+BOkt45nPcYZPmouqEbrmnvsYX3dbAmzqYNhH/YDiHpUj6nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=T/aL0wac; arc=fail smtp.client-ip=40.92.41.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbNKghWU84k8imnHRphHh+WL0ufxJsM7XCqiQYbRdHh0EK+MgRjVdM29lJ1BFOCDYDx2SzV5gklI949tvorbepe7+yNlcaxq/yU8VUE1rN2gu1+aYtxj8if5rMGrhRcxUGEXLX+SSWzmJUZsxiwctG08DXB/d+ohRKpMQf/PRYgxhgrt05jKRntflGZH11RDOFvpmrLKXc4+x2j6fI1tWSIvOm3Yvj2bsgWp3pS791g/RMqtqHX8J8Uq/AHjCGEIGqpcTpyRDHlx/H62ZTX8pu8jrPZLj/o27f2vuSr8Hc6uk51WnnVqHung6v6QofhEZ9U/bvM5jKre6TdYuOJK5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tq4qGHTJqYcAIh2eSe6DX9dUuYHlkUSeYIfkyk+wZFg=;
 b=F44YGdrWPDeMCaDWyxyUTJQGr6doYzdXyOZjvYUDYaGB6Iq8Wez3IfVcvQo1UXhfMBsR1YZLYmVGtp5slhyyXjw48uwZHa+RSKAaYnk6EBfIzazC7tVPxDrOUGi6iK8VuB5XZX/6IbYnFs64AeQyQLxSTaY9w9Ri+4DhvKRl+R2jfsWJE/pT5qPMGSF7KuVC4nMqce2ys9ADIOdt3flOKGR5zv56vOLi9VcyKl0NXm+8ED72A9hSSKRjsQT3D4kAfekS3wROw5LHUmh1Va87HZcSmigeg72xg5yelwJzWyA3bM0RnnlcaeRTxu0yjeQQHVB2kxEXDngnoi4yq1i4kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tq4qGHTJqYcAIh2eSe6DX9dUuYHlkUSeYIfkyk+wZFg=;
 b=T/aL0wacVEDqRJwnGvw8E9lzFYHHlnVA/IvV9xhjhl6HltczULHfT0DlBKma30MyWf9WmwmPbxRzWWz0YHRmzwHPws3JgpjRl6B1T0jsPvoo09bGVCI2cv253pGrez0ww20iOdebuN7aGXb3YEzU58jm2mAG4gErQFlzFj87NtpXSmf0oMoPcLDRfnR+Ip1AhFLP+EQ77CFo1mAomFXQJ8jbWqn9XIrtQmWZ7PJWPHHrsUHDnKP/iamDdFxaToGKA4UUJKXk6sYpW3KqtL4hUph89ncdKjLKIvYWQPbYCso6YhNJuChPD0i9p7R7M0srPYG+SSosrBDnkJgFfjQDnA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH8PR20MB5337.namprd20.prod.outlook.com (2603:10b6:510:1bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Sat, 17 Aug
 2024 02:22:51 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7875.019; Sat, 17 Aug 2024
 02:22:51 +0000
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
	Yangyu Chen <cyy@cyyself.name>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Hal Feng <hal.feng@starfivetech.com>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v11 0/4] riscv: sophgo: Add SG2042 external hardware monitor support
Date: Sat, 17 Aug 2024 10:21:59 +0800
Message-ID:
 <IA1PR20MB4953DF0AE7210A6D74162952BB822@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [rI2EJhsrZzllPRsU1tLDwtSicwMi9nICDSt6UxZL0oQ=]
X-ClientProxiedBy: TYCP286CA0078.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::15) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240817022201.360862-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH8PR20MB5337:EE_
X-MS-Office365-Filtering-Correlation-Id: bd495841-1cad-44af-6af1-08dcbe637ea0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|15080799003|8060799006|5072599009|1602099012|3412199025|4302099013|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	6o+aQYhBuEDHscHnUNAumv0oca4diNYdGJoP0aM0bflgTdvQ/OBBjpxtwbXr7FoF9oxPah8wjievY37jUAjH6Pq1556JrjMWSqSXPYwsSyWEcqRbzh3b0ZnnT3fpP+N8QkQYZ6j+FO8/qGpKkC3K89bb5iD2oBdEZsUu5ERj8oVBd6rAQzqZckIf1jRzwJfGO+gdhWsucMhycwqlBKV7pWjJDRz0UWEC8tsHouuK++XDd3u9Dvzo3MqPpOZnQaJxw0vFEUxBmZtgfmRs/m3siblZCxlou9rDdtZsn6F+k6/uWGaZT2mdLRALwqy8CmMBbCmyMXqQmtWxHKsPory1QvOtCXZM7m6nLs8rFBEZbVOM/fSQViCoCyhly4bS/Yf4+b7KnjjJVA9Ni0O8j+tAqIJQbCAUaCnQ6qXoI2YWtvcvcHjL5Gy4jp2iNVYZ3uvCw/oHjLcfPY3RG8czxzGYGvCMb0LFQpLqP7FHJUt7Kp7lwNZmLx4iR5z+33r8CjqjmFBEnWHaJUKuClIitTSBfo/6x6Z5nSHm5Uw2/UuPu5XiKkM4pnpKjrOhm506zmw7jU7Bb2hz1JVncvQlNa9/vzsx1+On7shYsNWPNR+vFWC8INZFrXA8WBHqiId2VpL+PXkP5tEyqBQiAhO3XiPh3JGnTOGI9BIkUJxwWONwXPVO7h0qUG4fX7umSp6jhm6R7D0jFl433j4BWiftxB1fl4WvpCAh9CS5/74vDxgcKbz6EDfHZOq2umDd3UKUeRVnGmtCGKr5AABoqdbXGYy+/kBOqA0jM6gDLe8iu4zYheXhyXcVXdav3S5PTs/7uasxDLMxJXPe+ut04yMVDmcjaw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kguQtKVi9zq0kwT9Id2PdZFx5lct2VpVUKVm3KEgHJLFhB2uY9X44/hnb0Xc?=
 =?us-ascii?Q?jr08Y7j8wVqcEB1WGcSEpj8kRKI0zqiKNgCwICrp4x2l/i++GpHAC+3Lttgo?=
 =?us-ascii?Q?7/QiT7tlXyt5k53Ksy89yfUUKkSehMBHvz+uacUAlpOo/L9/erDNjtXn9U+u?=
 =?us-ascii?Q?74fxgMgsdSVHTDnm2vrxe8WXwnHaml7RfEYtIY9EzNzqe3RbSutV13TmofXM?=
 =?us-ascii?Q?1h5dGf2bedxVT1eLLCDBjBckiBFmtKFA8usZ3RwpiKCMrchOYQe5+L5nJtyP?=
 =?us-ascii?Q?nWZglFlVWyhX+9wITt6o3J5WiqwBGo+++YLrTT/9L0chG/60I9c4IfH8fq7u?=
 =?us-ascii?Q?y1/pJg6tsOpcq/EaTjeVx2aqkWMvfThGwjDCeIcT57roXujlutJEckF9+Zxv?=
 =?us-ascii?Q?zJ1ABfsMhi9x10lD4UCPe+26o3oKfRrNothXKVjERxp9OxLDR83hzlpd0Lsk?=
 =?us-ascii?Q?CuYihyBLkbU1u4U7ut5cZbKM0cfU6Y81NDNau+SZak2xMRO1w8gDTzodUwy9?=
 =?us-ascii?Q?zm7FdSvFEsiAHGpythpP27Ts/15lx+M/ATnaxpf6S1PvuzUHnjyJMeE5UGhn?=
 =?us-ascii?Q?2kaLaDGHfPz823ZOZ/HlsiO+VrMvFBg6B8Ifvfu0X2oD//SwsbwS/6Hs1NX9?=
 =?us-ascii?Q?AWFc41TlBM5CUkjHWBcon1hebdSdTxlU1S8shcrSq5o8PsCZ+7uRb0AuN7UF?=
 =?us-ascii?Q?ERisJ6bYvIoyrAj6xIvo7C2CF40aJkYBkt8JLYc+wf8uk0DzN/DPFddn1yV1?=
 =?us-ascii?Q?8VuxSUNIAL72UFXQwq4tmAdb8DyRhuOaZEOuoEAF0FcMxADGaPt6GPtbudHO?=
 =?us-ascii?Q?3mwFG7X7V7oqYnV078GgZi7AgcKBssF06p7ojZE/6vUMJoXmgBhPM8mfwILM?=
 =?us-ascii?Q?UsbDjBfSyZ5dAQ4kUAWnoK2ZRPnJuFdWvNtTTStOm04KnUcD+VqjdRMfESCb?=
 =?us-ascii?Q?zE1u8DDediN+h0R09/EmzIYFE6TSpbDEcXsAiIvauezhWfUa4AVf6NoOfD2M?=
 =?us-ascii?Q?K0X4ZuYLQPJru06aEHgHaVV0N4wHv3z99vE3ccNYbE+8LsZVzurWvGqW7l/S?=
 =?us-ascii?Q?YmbfXfYS++4Ljzs0t6i51AqGQIvkuptlhk9wjnpI2Gudhma/xDNetaIekvLn?=
 =?us-ascii?Q?Sh+tqr67yDtCjr2V5e4iCRideMIgxNFg5kpVXWI3J2fuQC5G/brdAcst/vjx?=
 =?us-ascii?Q?un1BRrXRtHfVQ0hJ5R2szioe9qn7u3EVloMO7ARGH3QdqGQb/+zgj9wof07L?=
 =?us-ascii?Q?AndP70E3cnnteiezOLqQ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd495841-1cad-44af-6af1-08dcbe637ea0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2024 02:22:51.7557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR20MB5337

Add support for the onboard hardware monitor for SG2042.
Can be tested with OpenSBI v1.5.

This patch is based on sophgo/for-next:
https://github.com/sophgo/linux/tree/sg2000/for-next

Changed from v10:
1. fix the hwmon entry permission.
2. remention the extra entry postion in the document.

Changed from v9:
1. remove missed wrong return value.
2. add document for the other interface of the driver.
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
 Documentation/hwmon/sg2042-mcu.rst            |  78 ++++
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |  60 +++
 arch/riscv/configs/defconfig                  |   1 +
 drivers/hwmon/Kconfig                         |  11 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/sg2042-mcu.c                    | 388 ++++++++++++++++++
 8 files changed, 583 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
 create mode 100644 Documentation/hwmon/sg2042-mcu.rst
 create mode 100644 drivers/hwmon/sg2042-mcu.c


base-commit: 3e2b6b3302bb40c75756c74c38ee30cf34cd2879
prerequisite-patch-id: 5e7221ed1c63bb4d68e4a2a0141440e32d29e397
-- 
2.46.0


