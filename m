Return-Path: <linux-kernel+bounces-230266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CACA917A9B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01EC4B258C5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1844715F404;
	Wed, 26 Jun 2024 08:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZdRW8QPA"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C0315F33A;
	Wed, 26 Jun 2024 08:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719389640; cv=fail; b=GJxRzAHxribFBfwEum3t24s9O4lq5N0ToFrp4hq9eEFwUxcdQCfH4ZSQnUvZ552b1tMtQ6yRUDVex+kNi0qBTCChR33OMlDvjvivfHNse2Vh81pj8JoHP45l+n6P3POm2WUMSBj8ODzZxY/kCiGiTxZI9RG0esSBCB3D+AmzrI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719389640; c=relaxed/simple;
	bh=rKvawwOx10k7soioutQAdorH4Ym+t/0OuH8xXsoDruk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tbbGGT8kx5GCyC+Kqpefkr4ZegsGcsWCaWMv4wprGvENJ7pedrUDYjR4IzDyh+VBGWROfdm1Px0Pi6X7biNqXj3i9j3W2t/w3av0QadCvZsAph+hKkSIlaT60On+lbH48Z5o5II9YHUZb9shbpd5KG1PjFBSRo27rZaj8OdHldQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZdRW8QPA; arc=fail smtp.client-ip=40.107.20.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCZG27mZSDlUc8PGEu9VLtuxMxpE9LkrZqqfDNLmenc3u+aY/eh/rXcw+s2yO3IJbjHSL0WAB+kgZF2E81d491wIE5msJDByQGZWXu4Q0Z1yZlQbfZW3NXoWanPRdeuoh3KXyA4MIifQqBxY0MCjUJCNTh7rVLhcTiApDmjRBSrQ9DACk3YAtBNOg+av8g/YFgv8V3qZ57BywicrqM/H1m1oim6NpfvElKQ2L/sW9c/r0JqltjDEzdoK2mzvFZLqM/cpRgH5aP2dgrhwZLS8VOluC+SLtfAH8BYyl43tZH9MtIJM5z1y70IAb7u+LsRmLq4vovbOxcUubuiSVsNz0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKvawwOx10k7soioutQAdorH4Ym+t/0OuH8xXsoDruk=;
 b=C/a9xZtDyOWQBU/90wPXkNCiWhcEity1ogmYWfhV95DRNMVGap6b0+Qw235FbWfh/K1XsobhG1exPikYtM15n9RoOvs22YwLkcJYIYDRCN9fjqr/USPZdnVWE3PNvU4iOQGk34YjnyXiYLtZsLYCm/kM2sAu/k7KooxT6P+qGWmqSvnGxWQvaMzpWLNBKHmZ4e7YjrBwnuVG22qn+XL1Sm3aPo2RGnZt3/sd9bCxSvW8Eb6UjTMrQEc1xbUG01ASiO4cSa0gYa612OHFWXz9zx2UFtuowSllsTu2zX5gXYgfQzIY7jeDzXLGjvx79m+NZWOwvRd63o24cgMWuEEl9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKvawwOx10k7soioutQAdorH4Ym+t/0OuH8xXsoDruk=;
 b=ZdRW8QPA7CZbCyWaGX6ysdLI+VRPBl76nZUzCgCxJIGo5T0YqTeYAxUDovYS0E8FeSE/MR54d3ddxiUMxF/bGsBG1zfHWQnRtOeVKaEJsxFF+sJddph58ZGQkl3c6PFBjFmOrvJWYew8Ic8dZYzXHp4WSBJ+YcgyScWOb7fBA1E=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by AM9PR04MB8618.eurprd04.prod.outlook.com (2603:10a6:20b:439::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 08:13:54 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 08:13:55 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Sudeep Holla
	<sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>
CC: "arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] firmware: arm_scmi: create scmi devices for protocols
 that not have of_node
Thread-Topic: [PATCH 0/2] firmware: arm_scmi: create scmi devices for
 protocols that not have of_node
Thread-Index: AQHax5UBcF+q3A99YkaqiEgHA2XENrHZsmXA
Date: Wed, 26 Jun 2024 08:13:54 +0000
Message-ID:
 <AM6PR04MB59419309C8344E41F544826588D62@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240626-scmi-driver-v1-0-f16d777e004a@nxp.com>
In-Reply-To: <20240626-scmi-driver-v1-0-f16d777e004a@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|AM9PR04MB8618:EE_
x-ms-office365-filtering-correlation-id: 2e94a6bc-0f4a-43d9-34ed-08dc95b7ebef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|366014|1800799022|376012|38070700016;
x-microsoft-antispam-message-info:
 =?utf-8?B?bWVyc2VWTmNhNUJzdFphUUZsRnllT3NLMndHcVE3T1ozaEFCdm5KV0xQTFJi?=
 =?utf-8?B?Y1hwNW5kaU12VzN5d252NDk1Z3A4WGs4Y3d1YWlGSVl1eW40eTlSUG8xeElQ?=
 =?utf-8?B?T25USHlvMUlOczJwTlF5ODZCaXIwZDZFcVo4U0NoUXFCaFB0TGUrWmI5eUZN?=
 =?utf-8?B?TlExams0ZmZPZGtmWVdXNHhaN05JMlhEMmVaWEgxT1gzL0ZZWVVndUJrVlZ2?=
 =?utf-8?B?ZFZEVnZ5M0NlYkNPdnZ5NmtKV2IrODhiZWEzRlBzQ0kvakFCYUVFQnQzc0hF?=
 =?utf-8?B?ejhzRTRhRU14dmk4Q2s0S0ZxVTdzVlJCbk4wUUUzVVRqWElGUmJ2cTJ5RFUy?=
 =?utf-8?B?dFBzNjNvdWhpT25BelJlblBIaGV3RmZrSHlPNmoydVU0UFhJZFZYQjUzNC9O?=
 =?utf-8?B?Qm1EbzF3K1RnTmEweDZaYmU4R1FITUgyUVJ1ZG5Pb0NPNUIyTnJjMFNqMWwy?=
 =?utf-8?B?SlBIOTJrSEtEejBBQ3NBZGdxa1hRK3FGUEplL216a29xMitkWUJ6RGcxS2lm?=
 =?utf-8?B?bmprTnF2QmF6QTJWaU9ZTlZsZ1hMUXJnUWZUZG0vTzNkbVJxK1JJSkRHR25L?=
 =?utf-8?B?ZDFkQWxITkY4OFFraVVpbmtoTmJmbTVBVUN3d2MrUi9XL0tmRkxPOXFZZk1i?=
 =?utf-8?B?cFlLNk1jMEswaEdRNWZXb2M0NWpIVFpDMkIxRlNnOWZjdzE4Z0NPYldWeVBw?=
 =?utf-8?B?TFJ1UjEwb0YrRmtCckpIL3kyUDZwVG92alorM3o0bXIzNFJFeGhZSHlhdThF?=
 =?utf-8?B?SVh4TVFselJOVGZpTjlHa21adlJlY3JEalBFNXlaUzI5ODFKaHF1a2kxN2ds?=
 =?utf-8?B?UDBoQUdCcVJCT3d6TFA3eGhKekxNWW5iSFB6T2FUT1FpdVV3REVkaG0zUUV3?=
 =?utf-8?B?WXQ4eHkveG8xaGZncW1aK1BuOThKMUdBRk11VHo5Ykh1aC9LUUt4NU16V3NS?=
 =?utf-8?B?Nnh1SStEd1BZYTUrSk92NVE3NWNtK2lvMktHT21aYWU3aG9PdWwzd1dZcndm?=
 =?utf-8?B?dmhZdmlMZVBUTStOZFQ0OUhqSzR5cFlRNXNnRUZESGtBR3JMNml0dC82eVB5?=
 =?utf-8?B?WmxWVzZpZFhacm0yZWNqOUR5ZlpRNDBoU1E1ZjUxY0FiNnQ5V1Z2NFVPQ2pw?=
 =?utf-8?B?WTZCRDhnU1Ntcy9HMW8vWkdRZWtDb1pOZGpMVXF0SHI5akVRclY3N2FqSjda?=
 =?utf-8?B?dGRuY1RkYnF6M3ZNRmxEWkVGUVcxaWJlMmFIeTlKK2dWSU02ZkFKeDN0bGpm?=
 =?utf-8?B?UDhBTHhDL2MwUG5pbXFVRGs0SmhHUUM0S1cwL1BTUGVxRC9iSmlGYWxrQmFl?=
 =?utf-8?B?ZHNRK0craDNGa0t3UXZUM1VqcmhROTI3eloya2h1d3huUnZQcEJTdDlMRUxh?=
 =?utf-8?B?cXVvellXbm9jS1pjWEFOVkhGUnprWWI1YjBxbldIWGFnWWg4RVFRSEJqMUMy?=
 =?utf-8?B?TEJwK09LbWVIazJGNUc2TXZlclBUbmNuV3JMMkU1SWVVZ1RoQzg1bGZUMHVH?=
 =?utf-8?B?T1JZYlFOeGhQOHViZXNNcTI4dHZPL2hhbU9vN0M2RWwyczJSbWFpMUNNZ2Fh?=
 =?utf-8?B?QTI0NDhaNDVLVU9ENU91SmJJeUFLQ1JyNUJKd1R2MjlMY3lmMjdmL0NoZkxu?=
 =?utf-8?B?Wmx6U2V0TEpXdUppejRtLy93ZW94Um41bjFwOHFDc0RUYVhNbkYzN0lYeU1w?=
 =?utf-8?B?M2MwL2swUnlnUHBzODdkMEphWDdZb0N2UTBIa2VqbjhLRDNGWjZMdGZPNncx?=
 =?utf-8?B?VUJUb2hvYmdmV2xSUmlqMndzZ1UrSVdpWDlOYU1BR05qMFJ2ZkhNN0NxOHZt?=
 =?utf-8?Q?TKTuHiM68XI9KtGZiy5YErSo0mb3TF+/kdfzI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(1800799022)(376012)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q2k1QUlVK1k0TUFvNEZCN1pqWWhadVFYTEcxeG0wN0w1bXNsTllSU0ZnaTZo?=
 =?utf-8?B?dFFjaWR0blBKQWV0ejFCWUFUcy9xRm1SaXNPSXlWbjYyN2Z1cDBGRm0rTTd6?=
 =?utf-8?B?TW02ODhPWXdvL0dJcUUyanZ0V0Evd2hGaFFIQ1NYa3JUZ0xkRi9Yb3RDaU1o?=
 =?utf-8?B?VUVuMGtSYi9CdDhwUHA4OEtnK1lXMDQ4c0NPcU1LeFByUjdiTklDK3J1ZENq?=
 =?utf-8?B?Y3FmTlpPNjJsZXpjYmRtcDQ0dlJZYU5QUTU1ZVhEYUljVmdNMXg4SHZoUHpB?=
 =?utf-8?B?dW5qVGRuZ293anQxeDZ3blFnVkRsWUhHdjRZa1lFbWozQjZXQ1E3SjFkSUx5?=
 =?utf-8?B?WGhsRHI2ekhGU0QwMnBuMjlDSCtZR1BzdnZ0d1lmMEVyQ3ZBSTdNSkg1SktE?=
 =?utf-8?B?S3cwaThBKzJZaXdib1FDd2J0bWVIcUFpeW1CR0VhZGsxRjVNZUM4Z1l2czNt?=
 =?utf-8?B?c2lFYm1QRG1kUGVWMTFJMDF5L050T1RYbjYrT0N4akpsanBySVZ0NGtRUkth?=
 =?utf-8?B?c0x3QVFjdjdQTURHRVk3YS9yWXI2WUtrZ1ZVeEVZclFmOGhZWDY1OUR0dGho?=
 =?utf-8?B?alJIMzYvdnBpVzZVNnNmTS9HeXFvR0JNaHppZzU4Z3JzeXVYa3hFNVMzUVlY?=
 =?utf-8?B?N091bFJJdTNUSU5NT2Rwb1JOT3BJQjIxNzN2bHF5dmtHYmRZSWRmbUQ1dCtC?=
 =?utf-8?B?c01vTmtGWGhxdDRuSVBtdU5zOWdidlhPR0pWazg0MEVGQVJCUnFORVo1Qmxv?=
 =?utf-8?B?dHdGTlFsNFdWaVBEUEduRyt0T3N6Z1Axcm5nNTdnc1NFaXFyKzRjNkQ1K2lR?=
 =?utf-8?B?RkRvSDFFcklJYi92QWk3K3ZSZm1KREhtNC9Qc2pGRXloU0ovaTlTMnV0UVVR?=
 =?utf-8?B?dXVSeXZqRWE1UmpXZmhOeU1ONEFiWDFPRUo0dnFrS0gxUXNKY2lEdGphdjFC?=
 =?utf-8?B?M3Nxb3N1UW9JYzVMYnRmcjVPWmdkN1hiaEwwTUswcDVKK2dHOGVGWDZDd1JL?=
 =?utf-8?B?WjhWUDZaS3ZmdlVva21qNWVXeGRBQytJQWNnM291NG8vOEJmUVVlOVkvUXRV?=
 =?utf-8?B?TllXbDR1V3B2alk2YmZ3Y25SczV5Z2dXUlk5d0lDL09Gckg2bk56aW9aNFhv?=
 =?utf-8?B?YlEzYVBaNS94YXEvcEhreGVLRi9pZFNXMUNLaE5VdHJXZHZPbGcwUU1aaEYr?=
 =?utf-8?B?aWw1bkFqLzQ4YW1ubG1Rc3ZDUXhNRnpFM21HcnVPV29KMXo3RXpMb0NuN3pn?=
 =?utf-8?B?ZnlPczJVQUsxR1JPb09sQ01MYkV3dHVEWlFTbUZuUlI1UXgzcVUrSHYwYm14?=
 =?utf-8?B?MHNla3N5VWgvMGI2alVKSUI0VGkwVnNDQjkxOTJORXdUOW9leEJFTElia295?=
 =?utf-8?B?T0ZTSzVLTGpreHZpeUVLOTljajN0QUVOc2l1USsvd09iZncrRnl5Q0xtcHF5?=
 =?utf-8?B?RnhtRytMRUN4NTVIWHdkUVZQdC80bkRZc3YwOUlvZUVKVk1KOWxGaldyd3Br?=
 =?utf-8?B?VGoxQzROVWlxVmhVeU1LcjBLeExKTW5GZmxKcUswdTdBQmNlWEk1U3ZWbUMv?=
 =?utf-8?B?TnNPayt4Tlhsd0p2bW54TVZzM3ZRWC9HN1o4bWtIeUI0a0JpaHFadG83bE1y?=
 =?utf-8?B?eXYvUnNDVy9LZXdVaVVLZDFqTlM1Y1J5NUJDMUZQd3c4dFR3Q0diOWZCRm1r?=
 =?utf-8?B?cnF3YTUzaGJJNHp0MG9FRnFYekUxOHh5K3oxemF0Q3BMSVhhVkYwRVVzUEhn?=
 =?utf-8?B?S0RiamRSZnJOdGhKTzlISGFPUjhlWm1LQzFoSE9HQThjQkViQ3dzdlF3WXhh?=
 =?utf-8?B?NmI4N1Ficm5yMUx6dDdra3VWY1I3ZlVnQUZNTDF4RWVPWm5MOE8zcGdEeHF3?=
 =?utf-8?B?T2l2azlCT1h6V0tQNTh1ZU9MOHRJaUxvVkw5d0dLUzBkTzVwQmJXSjBML0JG?=
 =?utf-8?B?R2kyQVl2bU9CVjFwK0RkRUZrVmZTMDBrbmtmRzVPR2FMSFJVaHRWL21zZFhv?=
 =?utf-8?B?U1Y3dElBQTRZQm5CRU1LdEZlWlcrNWhvRVpQMUZDNUVEVFpyandBOFJielV0?=
 =?utf-8?B?UTQ2dmNQd2Rna2lCWm9KV3V1a3d1V0ZUOGFzL3FScGl0aHMxdjFJVUdmc2xa?=
 =?utf-8?Q?QiZk=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e94a6bc-0f4a-43d9-34ed-08dc95b7ebef
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 08:13:54.9402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z+6+wvghntterURQ4yBuZLh4CvURnJM3knj3+nwsEwzkaXxppWqyvXw0NRdk163noBNc5PQ7NNwcTkjk0a4+bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8618

UGxlYXNlIGlnbm9yZSB0aGlzIHBhdGNoc2V0LCB0aGVyZSBpcyBhbiBidWlsZCBlcnJvciB0aGF0
IEkgcHVzaCB0aGUgYnV0dG9uDQplYXJsaWVyLg0KDQpSZWdhcmRzLA0KUGVuZy4NCj4gU3ViamVj
dDogW1BBVENIIDAvMl0gZmlybXdhcmU6IGFybV9zY21pOiBjcmVhdGUgc2NtaSBkZXZpY2VzIGZv
cg0KPiBwcm90b2NvbHMgdGhhdCBub3QgaGF2ZSBvZl9ub2RlDQo+IA0KPiBQZXINCj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjMwMTI1MTQxMTEzLmtrYm93b3B1c2lrdW9neDZAYm9n
DQo+IHVzLw0KPiAiDQo+IEluIHNob3J0IHdlIHNob3VsZG4ndCBoYXZlIHRvIGFkZCBhIG5vZGUg
aWYgdGhlcmUgYXJlIG5vIGNvbnN1bWVycy4gSXQNCj4gd2FzIG9uZSBvZiB0aGUgdG9waWMgb2Yg
ZGlzY3Vzc2lvbiBpbml0aWFsbHkgd2hlbiBTQ01JIGJpbmRpbmcgd2FzDQo+IGFkZGVkIGFuZCB0
aGV5IGV4aXN0IG9ubHkgZm9yIHRoZSBjb25zdW1lcnMgb3RoZXJ3aXNlIHdlIGRvbid0IG5lZWQN
Cj4gaXQgYXMgZXZlcnl0aGluZyBpcyBkaXNjb3ZlcmFibGUgZnJvbSB0aGUgaW50ZXJmYWNlLg0K
PiAiDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9ZOUpMVUlpb3hGUG40QlMwQGUxMjA5
MzctbGluLw0KPiBJZiBhIG5vZGUgaGFzIGl0cyBvd24gY2hhbm5lbCwgdGhlIG9mX25vZGUgaXMg
c3RpbGwgbmVlZGVkLg0KPiANCj4gaS5NWDk1IFNDTUkgZmlybXdhcmUgbm90IGhhdmUgZGVkaWNh
dGVkIGNoYW5uZWwgZm9yIDB4MTIsIGFuZCBubw0KPiBuZWVkIG9mX25vZGUuIFRoaXMgcGF0Y2hz
ZXQgaXMgdG8gc3VwcG9ydCBwcm90b2NvbCAweDEyIHdpdGhvdXQgdGhlDQo+IHByb2NvdG9sIG5v
ZGUgaW4gZGV2aWNlIHRyZWUuDQo+IA0KPiBXaXRob3V0IG9mX25vZGUsIHN0aWxsIG5lZWQgdG8g
Y3JlYXRlIHRoZSBzY21pIGRldmljZXMuIEFzIG9mIG5vdywgaXQgaXMNCj4gYmFzZWQgb24gYW4g
YXJyYXkgJ3Byb3RvY29sc1tdJyBpbiAnc2NtaV9wcm9iZScuDQo+IA0KPiBBbmQgbm8gb2Zfbm9k
ZSwgbWVhbnMgbm8gcGVyIHByb3RvY29sIGNoYW5uZWwsIHNvIHJldXNlIHRoZSBiYXNlDQo+IHBy
b3RvY29sIGNoYW5uZWwuIE5lZWQgcGF0Y2ggY2hhbl9hdmFpbGFibGUgdG8gc3VwcG9ydC4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiAtLS0NCj4g
UGVuZyBGYW4gKDIpOg0KPiAgICAgICBmaXJtd2FyZTogYXJtX3NjbWk6IGNoYW5uZWwgdW5hdmFp
bGFibGUgaWYgbm8gb2Zfbm9kZQ0KPiAgICAgICBmaXJtd2FyZTogYXJtX3NjbWk6IGNyZWF0ZSBz
Y21pX2RldmljZXMgdGhhdCBub3QgaGF2ZSBvZl9ub2RlDQo+IA0KPiAgZHJpdmVycy9maXJtd2Fy
ZS9hcm1fc2NtaS9kcml2ZXIuYyAgfCAzMw0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0NCj4gZHJpdmVycy9maXJtd2FyZS9hcm1fc2NtaS9tYWlsYm94LmMgfCAgMiArKw0KPiAg
ZHJpdmVycy9maXJtd2FyZS9hcm1fc2NtaS9vcHRlZS5jICAgfCAgMyArKysNCj4gIGRyaXZlcnMv
ZmlybXdhcmUvYXJtX3NjbWkvc21jLmMgICAgIHwgIDcgKysrKysrLQ0KPiAgZHJpdmVycy9maXJt
d2FyZS9hcm1fc2NtaS92aXJ0aW8uYyAgfCAgMyArKysNCj4gIDUgZmlsZXMgY2hhbmdlZCwgNDYg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gLS0tDQo+IGJhc2UtY29tbWl0OiBkODAw
M2ViMmViMDIwMDM1MmI1ZDYzYWY3N2VjMDkxMmE1MmU3OWFkDQo+IGNoYW5nZS1pZDogMjAyNDA2
MjYtc2NtaS1kcml2ZXItOTZkYzYxYjAzNmEyDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IC0tDQo+
IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KDQo=

