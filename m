Return-Path: <linux-kernel+bounces-335736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 091A997E9E4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75D3E1F21077
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1952F197A88;
	Mon, 23 Sep 2024 10:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M1ydThi/"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82BC1957E4
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727087066; cv=fail; b=jTJNgTl4von3MNVC0oU3t2lsN2w93iO4V52QQv0q2fgWLZFXodJskZWfvwLYQDyESDgTx5XZ/qCI6RE29WnTB8SBeU4FdfmkmAM/jG9QCUlsT7GdC5Z8+SpDuaYIQeGhmyP8TYzTMk8w2epJaONEYtivjvR8i88CA8caSPHzfQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727087066; c=relaxed/simple;
	bh=Ul8kPRHHWk4dQxL9eG0f6XRgYEoK6+LjTbQ6m4XP6Tk=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MjIRUPbwGqR3dtzq43xsLdursf+/oL4qQW0c3X82dYb6gzdK2JxnO82XjQ5bPLb3Yxpf8KvDJLzWrjwIWXmU1VtC72d2kaRCQd/Bkhk8M4GCdUonfXctn4FzQEkF+7TgMmPkifGlp24seJXLwFE1e+PulvBllwx8KjaSEeg6Wzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in.ibm.com; spf=pass smtp.mailfrom=in.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M1ydThi/; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48MNT9n0027249
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 10:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=pp1; bh=SrbQknTfBUKU7
	GmT9PVxGkan6rOuYhJzMQp94tyAsX4=; b=M1ydThi/15ylxVZlfuH9+sOrV9QZK
	zIfRaQGk6WdKJ703xlx7EdoN8yLNJNpoqa3GiSyW7262OArp7yGzC39sSbwVGFqS
	96zOKviFKCN61/9+DSVOnx3ZNsWUbGAPhYg4rdTCaQX2AnDkoQSDKrpcBRswpgGC
	j3Pr5pM2mY6jxdN1QF/eN0vsciK7rOfdTVbjs0/d7yBrK8kJUI8+m1FrhWWbD3/T
	l0rf4xLiiu6STcLcrNJ+QfytcZ65WRs6Yk0j+AsT7yQBKT3KIRN8OPkaI5dOWxBk
	xoon0/AZ4PwzrWHMstw2YR6K2wJFeXxbPGieOIGDKnnfBbBKi0lNBAnzQ==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snvau49h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 10:24:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUXGJ12VMzU56Z3sLv4EhvJxc5y8lJsu804lvDawD4y4fRGaYXoTPmOJIjcJrbF5gxNuJIqYsl0VihOlFaOn8vkgQHhPO/SJw2NmmDcVgvfUiy8VphBE/XHnlNhgS5QqBaBlgcJusmReJlNF1zdKLSsaPW5dnqiLwq52/MjGVSFwnkXA5Mci8+kIHi7uhaXjCk3Se0+zfqu2rTz4XPy/chAIFt8dwjvhwGUBJHtXD8O9awmCcLmyKtnQtsIOKEXipXqcEVCIuQq4cjP1sAMtQkWKYXsZlAe4tYd7+BsJ5RWCXXzZzsmkKduvNdm0AorPM86EcLDN+dv+3wqe54/jEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrbQknTfBUKU7GmT9PVxGkan6rOuYhJzMQp94tyAsX4=;
 b=Wv7pP/x4bfkq16F4lfnRjI8Hlr9Jxi0xH0wex6LXXUcq/t4+spGWe9wjGmfG8PvlR0ab3kEvVZJHffKbgyd7UPNKL0wRsQUvBltm2wiGUiu8IfX7dB3c4510QEE46lCfJC7vjJ7MAw5mOZTIysHt3bF+IqY8ku87NgR1sU7FmEXTSqlPExPbxb05ey/7dC4Y7MPeLlVhia/7Gj21OP5b5bTwqJCK+JdYKTJwPuMETZraOL8FdP6pswyd63flKg4uai9Y8a8FSQZykX1XZ9pL+gN/fYyHr96UnqsS5np8sFLK2k1FaToh7xxu4rmp8+lY37/7f6BQKoSretMBc2IgPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in.ibm.com; dmarc=pass action=none header.from=in.ibm.com;
 dkim=pass header.d=in.ibm.com; arc=none
Received: from DM5PR1501MB1992.namprd15.prod.outlook.com (2603:10b6:4:a7::28)
 by PH8PR15MB6183.namprd15.prod.outlook.com (2603:10b6:510:250::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 10:24:20 +0000
Received: from DM5PR1501MB1992.namprd15.prod.outlook.com
 ([fe80::1c30:c2b6:865d:27b0]) by DM5PR1501MB1992.namprd15.prod.outlook.com
 ([fe80::1c30:c2b6:865d:27b0%6]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 10:24:01 +0000
From: Vijay K Puliyala <vpuliyal@in.ibm.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Failed to load firmware error in radeon gpu driver code. 
Thread-Topic: Failed to load firmware error in radeon gpu driver code. 
Thread-Index: AQHbDaJPvwW+Woo+Fk+HN+tM5rCp9A==
Date: Mon, 23 Sep 2024 10:24:01 +0000
Message-ID:
 <DM5PR1501MB1992D1D5EAF3C093BBBCB2D4F86F2@DM5PR1501MB1992.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1501MB1992:EE_|PH8PR15MB6183:EE_
x-ms-office365-filtering-correlation-id: 92ca375b-f67c-404e-ff7d-08dcdbb9d7b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?9MxsZnNdHorJwgMF6PkVSb3HHu7862cyKsykVkx22IoeGjPR9TNl31ckIf?=
 =?iso-8859-1?Q?Dy3gkQvfdEGOUrqHnXAQkRPEIAIyLLAlq15wfLGh7FfKrTVBbAsF/C2YA3?=
 =?iso-8859-1?Q?8Tua+0Zl2x0v5HnV64R0YPwNZM+nb8J2uQgJSkrj+XoDHf+coZkwu8Nr+d?=
 =?iso-8859-1?Q?n4y7GrphNwa5Se6p31LhWEpKu24C6fu9Ktbs0dafuG++jPajQciDIMPErU?=
 =?iso-8859-1?Q?7X6jXCKwPiTy6qxZrn+xJGVYbTCtO6V9phDmaHNzRND3x36HcJDp1Phdbg?=
 =?iso-8859-1?Q?h8jnUUF4u/z/Oj6S6NBOLUM3In51xPF3etMduhMyD7VvkQ8egWA4me4+yi?=
 =?iso-8859-1?Q?d6KXcFbsQOqwFjALZHba8B6OQ8q8JFUwQdNNYfMxI2vL1Kw8ARccor5q40?=
 =?iso-8859-1?Q?aCAOiCDGDbNJt/HIblEtYpu6kFhuAVGC9PYBhwp6suaY37EpxVl/SlYgS2?=
 =?iso-8859-1?Q?M08NgcjDCg+4hLEdCRuLgqMesgr34AryabMr09b8LFnF2d5TAAHPos3qvi?=
 =?iso-8859-1?Q?ly63nAz3oGihG4I3EDZazN/Iw6UlpYysU/LAsAzzZk4uQ6aK/yUEJU9Fly?=
 =?iso-8859-1?Q?pjTQ3+OW5g6WwbqecRJvyfINvFDnP/wZrVoQU78mp+aoCVTX9LHWwuM5dF?=
 =?iso-8859-1?Q?RFl/AR537QC86at1PlgAy5NgS3NIEVdqBWQ84lJK6wHWZOEnym4JJoLdA+?=
 =?iso-8859-1?Q?kE19x1tNpNYHRiAkRJB6IaYM8zjG52qGA4XecfIc8IWw0OH2tWBxRr0ctd?=
 =?iso-8859-1?Q?YS5wb8XVW45r00/Ap2dLVsEtl09EnEzwlwYdpbRsxOYQe2azJke0F54e7i?=
 =?iso-8859-1?Q?W4A5lOymhYa3mOFFetNCD6uvxXnwoZoREw+Q4nvHIpYY0Q0xazp/vX+IEx?=
 =?iso-8859-1?Q?yJ+Yq/j4SaeKccfoeS+iTXjEPLIa7byv4q99/VtARxAmu82574LFD73IQ4?=
 =?iso-8859-1?Q?/yVN1i5+5Qcbq8IEZEDPTUXtS6XREUmsjbafFt/KVAWG/W8tpU2PmIltrL?=
 =?iso-8859-1?Q?D78L1NXIXFE2h7EQSSmXqt8itUqrgw3IVyoHkcDrZYGoRWNn96ZXxcX5If?=
 =?iso-8859-1?Q?WSb37K3a9qsl2dvH908dyeDf6k8n9RCkjDblQp8pcgzkwRijaoMBjyIgs2?=
 =?iso-8859-1?Q?nvnI2xyzzgLCREW0ATTf+t3PlQv4swmgQx/Z7BZE611v5cxBICIlG0vOUA?=
 =?iso-8859-1?Q?aSJgoBsZ4CJEWZCACAqHbuMyHA9KzOIMQEOFViutiQfvfHa9MpCRjwTSqw?=
 =?iso-8859-1?Q?CVaBYUOgUhIC7WQKwBoGArmNGErqp/SmwdXEOadEwHq1e6ByfDSRkUfs9a?=
 =?iso-8859-1?Q?SrO/Tx8T/5cGPkV2yXCuHNeqOYxSzq/k/N2e5WuiZ0dBAjF2KqBSeuXEWz?=
 =?iso-8859-1?Q?fLi2D+3GMMI1OIeyChtSanCTeuvfdvcQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB1992.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?GyZk2QLbuZP1TPFDdA0dv/c8p0RNOLwRnS2eDghrJHy8EmcMDRwUZd+34a?=
 =?iso-8859-1?Q?GO/5Mp5NN1wiVz0iAPxTjxb2cefHHwj93nvB7Y9GAGK3b+HKbW7FGVHJpm?=
 =?iso-8859-1?Q?OUPVO4aurpHYcj7dapBZbkmipnclNuozlQmPi8XPoVhIgeG6XrxVvEvIMi?=
 =?iso-8859-1?Q?9z/+YbR427oJXG+O10h1edaiW9f0/PeHiEKY0ZohWX01MmXP1pSNYZLVlE?=
 =?iso-8859-1?Q?T70rIWcPSNp2qyDYnCq0oHJ+vsaWilvkYCYtVc3CSLU5LlouN0hPbpXj+N?=
 =?iso-8859-1?Q?PjQb/S5vphtvHFvZVkLLHGdgz0IvHIxqBisONSbNM0K1EJCKVDjzo7hHFP?=
 =?iso-8859-1?Q?Ewi9JD9VJudUGoK2JX/UNuoCwwx9nMNBT0rmTlUd/cxBwaN9XXt4RdtB/Q?=
 =?iso-8859-1?Q?NTOFML5420dB+OtsG9fUWFsSdQmiu1tCiXe4N0OE+eWNsee++c/DuPY6z5?=
 =?iso-8859-1?Q?VLDe/r4PyMflEnjDud+qlmuZNskCjdLrPKJlQJCtmZvfwQM+K4Un/5PiDd?=
 =?iso-8859-1?Q?7zmWlZGZQ2F9yChsqIjfbW1lnshZJFHqzPrCsD7qmi7t0s5CAoMxzW3XOp?=
 =?iso-8859-1?Q?LXm8yPq/ziuzXRQXYDBbvGb1GzFPI0XmOhaNZ+JJiqg/v6HGDSMSzGcHyI?=
 =?iso-8859-1?Q?zv6wEiHjJ8a68SebfzQ2AvM9O5/RSpKZY2NSUO1GhUvwXjRQxze8CHaDcW?=
 =?iso-8859-1?Q?E5IYOFo2dAe3jmSZvvvkeHZOblZoN2nD33+c9V5VifdbD9TFpuFjB5Enls?=
 =?iso-8859-1?Q?r4vyP9P8v4278ajozY0n27678T1gZ+GNMjwsDLOrZYFNZpN0wuY1O/+GQz?=
 =?iso-8859-1?Q?xW8VxDnfbAW8SpIi0V8ryLgAIccfuzZy5bwU4tCfPw/qIyKD+HWdkmnakA?=
 =?iso-8859-1?Q?+JzkyToZzswPXrXsHohPO5kWsdNrw2mtnlK/DqynfIrcgLGMxUf8eGlSEy?=
 =?iso-8859-1?Q?tHAthF50ADh5LJlvdcEWGih0BZirswFQ2M5t215cLIOCtKT4A8ftQCV3hD?=
 =?iso-8859-1?Q?FAACQsmi5IoIrUwu/WQPBLj+wj0+0sse/iPmTTmmJ0DCI9m6YyQQT+nmPh?=
 =?iso-8859-1?Q?+rGhaWX0ac+dipjN/MYgJF120Wh1pRJVexgqieXdlpwIpNpKD8uGv7KoHY?=
 =?iso-8859-1?Q?H6NNNIkfXsSM7bU1HzXrD0hM32wKoylPwZU6IbFWcjr5cf29oa3diF+tMg?=
 =?iso-8859-1?Q?TaUQw7NcKegUiaOkUAFEyzLbqHt+fUcquSJ/VajW9ej761f3KpGu+jNCY9?=
 =?iso-8859-1?Q?/LXmekc2c1zYhXFvJHvqzB9eCnncpxLqXiYjA63jGQ9SSwD6qgmC+0bPj6?=
 =?iso-8859-1?Q?HdVp/CZuET5zz7W47YNuNlo4CworgJ69gzswWk459n3NxM7OYN1Drs/pO8?=
 =?iso-8859-1?Q?qb+3i9NaDqxQWK1fznC0bw9/MXu00JjNn5FNQWXrgwvG8zrQFNWuYwDNY+?=
 =?iso-8859-1?Q?E1rjZt6tp9MSHmfnTho85lMNv5o/L9RGAWC4tpZt/KzyeQIa257QH155+f?=
 =?iso-8859-1?Q?qSZcu0DbDP8WXfmcTQoJ2aJ2YzQgBn/jzJbx8YrqSTiZPuF9T1W/HQmJER?=
 =?iso-8859-1?Q?FYzvzGHBvQIc1BmmsmGMX0+Q9JTzwk24Okml6dWCOOsMSXKva0fxhGiuHZ?=
 =?iso-8859-1?Q?xS9EFGkQr9lFY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: in.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB1992.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ca375b-f67c-404e-ff7d-08dcdbb9d7b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2024 10:24:01.3635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dfB74RFFfowp85r5LCH773lgCZmMu2rD109/CLuK1TY6uek1nhNQHRhlwLq25mqk8aIddZUKhd/8rdEt+ECciQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR15MB6183
X-Proofpoint-ORIG-GUID: ie1wv9mioBSPNIeUAnHYmXTE36wxAvAv
X-Proofpoint-GUID: ie1wv9mioBSPNIeUAnHYmXTE36wxAvAv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_05,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 spamscore=0 mlxscore=0
 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409230074

We get Failed to load firmware error in radeon gpu driver code. This is com=
piler warning being treating as an error. I fixed it was by adding below di=
ff.=0A=
 =0A=
error log :"radeon_cp: Failed to load firmware "%s"\n", fw_name);=0A=
=0A=
diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r100.c=
=0A=
index 0b1e19345f43..170404be09ae 100644=0A=
--- a/drivers/gpu/drm/radeon/r100.c=0A=
+++ b/drivers/gpu/drm/radeon/r100.c=0A=
@@ -1059,7 +1059,11 @@ static int r100_cp_init_microcode(struct radeon_devi=
ce *rdev)=0A=
 =0A=
        err =3D request_firmware(&rdev->me_fw, fw_name, rdev->dev);=0A=
        if (err) {=0A=
-               pr_err("radeon_cp: Failed to load firmware \"%s\"\n", fw_na=
me);=0A=
+               if (fw_name) {=0A=
+                       pr_err("radeon_cp: Failed to load firmware \"%s\"\n=
", fw_name);=0A=
+               } else {=0A=
+                       pr_err("radeon_cp: Failed to load firmware (null)\n=
");  =0A=
+               }=0A=
        } else if (rdev->me_fw->size % 8) {=0A=
                pr_err("radeon_cp: Bogus length %zu in firmware \"%s\"\n",=
=0A=
                       rdev->me_fw->size, fw_name);=0A=
=0A=
Thanks=0A=
Vijay Kumar=0A=

