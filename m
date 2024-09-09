Return-Path: <linux-kernel+bounces-320569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A23D7970C09
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 04:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97821C21A8D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 02:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBD01AC458;
	Mon,  9 Sep 2024 02:50:55 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16274111AA
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 02:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725850254; cv=fail; b=pG+Pn8W0MDgq+tV3xymhkFT7Q5S9cGKh5DG9NO6UJscDo+tnWD+Qp+6p+XRXBGCF/1o2DAX7nQ3oZMbsYur1547oDv/5f/LvDugJyh9fBdDWeZWjViUDHODL7ZsL6TrbWgEq2bdvcJvbw07DAdOV1O4QBqisjZaeICi3ARpEufo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725850254; c=relaxed/simple;
	bh=PksScQXnTigekt0jnc43MybnXAPlzoykj7PZ+1h7qoE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rxyGoovcClM77DTZEcx861UIyMhsTV/uutZv+omGl3ozAHc5YtsY7qlafZM+B8tHfMVqE7MKd7C1VKQduLs30x44lZX7IPuJeeqO0Gfnvk/zx8Y+fflVUIhzZISZLst1ly5aoeDOy8WmVyyGkKU/AzGMOaqiNzOE1KEX8dC4G84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4891sSn9003685;
	Sun, 8 Sep 2024 19:50:49 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41gj4497nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 08 Sep 2024 19:50:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhGtm20Bvwl3oGodgBnvjDya0U7yw/teaqZZwXXM8f7loIg4nPKNuNiTWApmWyrotnFQv0GvlLom1u6X+J9LiJCQOhlpKqFXf91sJ0vu66rzXCYGUHYGyhNYnij97m1Dlu6Ic4qANL3D2iqaRCJqo7eQRShzm4L4Kzyh+5Z60z0LGxe0vTaIjlrVYXSqppmKEpb6kvJf8HZhhacIIwMPdkqBOm7yEP4AYymHC+aH0NIfHyYhZ8eAh3abH7MCdKWnL/QLkiKO2Vn0rc4+moQLCCTASQBOt5Au6RnQvOBqH6M11x7YcvIQh2FRrq1bSxrbepDBObIqeUPAIPSgW0deLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuRI9JagwF45NlJ5bMXHAnobvz6BgA7NTLyI8LQIvmU=;
 b=ypo7QG6RxryYzfbO49+mV+qg8eEtpvQJRsrb676z2RuMcYLW+Uykn65oKBTdDwZ5NZ0p9Ls0gNkuMatQAqwP0KhoieT3uvGeHwuKHhJ9stflwkWQf9OyJAEVWCCwzoQhIM7+Mi0Kh1Ir/7mlEbyUJCaEKtU+yM82GmJk6fB/mAdaOUCgGECfXSqpednUZmrl000RsFa30PHanq309Pm8x1BjhLMs2cCSBwPTYZVAP9P6GQJD8ptdnPLrGYwYeY59UJzzMuGsBTbtIb3yTOTKoDYIV7wI+8TvGJ7EqjwZT6Nx/KMVlfbD7rUcY7353UBW5+pw2DbZFQsV8CHIkmq/Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN6PR11MB2671.namprd11.prod.outlook.com (2603:10b6:805:60::18)
 by SJ0PR11MB5895.namprd11.prod.outlook.com (2603:10b6:a03:42b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 9 Sep
 2024 02:50:45 +0000
Received: from SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326]) by SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326%5]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 02:50:45 +0000
From: guocai.he.cn@windriver.com
To: rpeterso@redhat.com, agruenba@redhat.com
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] gfs2: Fix slab-use-after-free in gfs2_qd_dealloc
Date: Mon,  9 Sep 2024 10:50:20 +0800
Message-Id: <20240909025020.2230023-1-guocai.he.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0061.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::25) To SN6PR11MB2671.namprd11.prod.outlook.com
 (2603:10b6:805:60::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB2671:EE_|SJ0PR11MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: abe08c56-40c0-4f63-08bd-08dcd07a339a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8+oGjkevkMZwUK+nYrEuf012aJ2taqxw77npbOy2DcASvFQVX+ImsuB3E2YJ?=
 =?us-ascii?Q?s8PoYSM8rnI1gt9YPcMQzKvGwodq+mxPLbXsdRFLqOL/m4Lt1wT/YFtsGzJd?=
 =?us-ascii?Q?t/VIpcRcBbbZr/N8oed0f0sQXvveOk+/t+I5d9FMtFLy8cj60Aop007qSZa7?=
 =?us-ascii?Q?r5lt9kfHuJ96MpeUw0kCR4kGUMNCiyI9991R8uHA9zFV8hKiCx0oN0kzBDRn?=
 =?us-ascii?Q?ULyB6LP/3vBh0tBNB70q4RLKPCdrv05XKcS2Y1R0uM2hJquK5CpAj/6mep7X?=
 =?us-ascii?Q?vRQsrzR19/NlX9sfHthObJxl9SRjSB3T+UputQv40hAO0KDZY2a8PyxsXYG4?=
 =?us-ascii?Q?Wom9XhoLPZTxfJDMiq8CDbf+7WgpovjCxOJrUWfnFXmNO0Q1f7xgdxJ4SOkG?=
 =?us-ascii?Q?V/gYZXerY8+xvoBKiSe/wXUTJ9M3rodGWhbtEsws7XOfNW81wfwfWAOFP6ww?=
 =?us-ascii?Q?Q72BPz0GnPs9KOMG83TkbkSDABjNCnNLEHLY8As+u58+iyssCbFKsLb7fAxZ?=
 =?us-ascii?Q?w5usuN1Am6SHhKyoiw3ve2F2ApEHjuSBTOvPpTQC7KBT6PgtqcsTjD0/yXiJ?=
 =?us-ascii?Q?MFAGR+/tkBPGBIdyT1FE7mE2B3qGeZP+84WmxJAdYdLFe3XqYqhWKCRNX2Ju?=
 =?us-ascii?Q?bNgqmAW80cPKErX/TXSQnPJ82pjFni4yTrf/78shTHrhHFxI0crrlAaiF4nf?=
 =?us-ascii?Q?sSrgauMe0iSvyqgqAMDml+gcsRWioXr8aPBm4meDItMyDCbO8jkUdpn7N8ux?=
 =?us-ascii?Q?Pm96ae1HH/Mp7CYFQk7BhYZUapK0wHYgagR7Bvh/h0H59+zNOmU7K0rvGyqm?=
 =?us-ascii?Q?iZiSOstugUHkb7W/4njmCSsEltinlse0koqFM6gRK6tup7UUWdGrIxOb0/e9?=
 =?us-ascii?Q?7IHegJO75ZjSGt3pT9G/IH02WaiT0U6gZ/kXLm5rNIP3DZg3uGXzk7r93tYL?=
 =?us-ascii?Q?saOb701OJRDJI1oC3HF3kWqX7vIF063Y7su2wL+Om/L3AZnKRJ301vG/9GuZ?=
 =?us-ascii?Q?jinz/DrALKM+4h2tDVMHs9xWutEwJXYblqkcTEMecOUoLQ13TTgMOvVRFyKL?=
 =?us-ascii?Q?YEDsPJOvRBOyPkLWk5omiLe5aR+3wuCagw63nIxuCr2LxIik66Mfl7jiyKbH?=
 =?us-ascii?Q?/wkAIfNpukvMGGkzj4ncDbspiZ47KGEI+LQSdFwhiPe7ZdJO8eOjz2lG9lcT?=
 =?us-ascii?Q?BfpxQOdBlGHxVsDSLCXfE+GcWr2X4N0yVRv4ezZgDVbZdqvJsDthibIXJO+L?=
 =?us-ascii?Q?0rDue2hiXwlW6VqeEVmwXUctYyQO6fPx9GUH68ILtiXYzbcswua8mKW9DVnH?=
 =?us-ascii?Q?DyMMVERv+GfnFzTzl/SldblsR4DXHlQqU5H1Lqfjjel8zkLo3GlJ49N0UVbx?=
 =?us-ascii?Q?Y5VduJQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2671.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wHRqGa1FXLefLc7CFpKjD7Q0pDlCOSOM/efpNzJz2L8Ip85ZHtolfSmfCH7U?=
 =?us-ascii?Q?LgqgFahev/oBqdi2vS0dVp5JKkrDJ7INmh5NIOgGmSPlKXkj2F2eb2se3mm6?=
 =?us-ascii?Q?2W4QCoaxCIG/mIRjTLM3+UhhCL7L37ESty8LiJ7y1rcmsA/QCJx1tGOQmDqe?=
 =?us-ascii?Q?sSumvjPJaFnm8cdZxgxmmHF2L2lOO95sbceCPD2pbm4Xvqps8qZpN/Dcod5V?=
 =?us-ascii?Q?t2Ya9fMfEeL1e/AbSugCQMiBFRGNMNkXSF2+tLKIKGhhAukww/ydxWz8hat5?=
 =?us-ascii?Q?ivoOgfiTTInrXo0zbztDkzOyK2pc7HKmlPPueVUa0pVOhSVsfJ3lBoWQtgSp?=
 =?us-ascii?Q?hNYedbJTnbEgNBQ5sIDrQOWbWxX9PjCcDPIz5tBFHa6zTI1TThwpozMCoTP2?=
 =?us-ascii?Q?TzIqcZgRF01jyvjw42RIrjc6H37vnArYYejddo1NZPFV/09TxTfRdk0wZJr5?=
 =?us-ascii?Q?zwLCu9Mlt/pIXSmVtsOJKSOHgx9BfSRLKaYExv5BIA6cpf1o/MsmYX4DNn53?=
 =?us-ascii?Q?CnRPG6GAD/Cj8p8Ezti0DBsB5dZn7gOpKqA+fC3a/+STpa0UGO7GTS86JyFe?=
 =?us-ascii?Q?YBhs63AJPTpHY6/VHhSilqBTILw5smI8xGmuBrwCjiGGlRiE/S3DuDMx9coc?=
 =?us-ascii?Q?PIqHOZ1oSfVj7MkyWCPLX2g+kg0H7GTjy0UMmfWquqDyKUIGoEXUXeus/oCe?=
 =?us-ascii?Q?1HssRreIXLzRmhLFbJky2342suR4ZD3/WySSIrZKJsjw92Zja3LKvjpE/Iqu?=
 =?us-ascii?Q?JnjqOi/XR8Ig/0z7dICvEfzxTJPz32bYrPy3zQMzHJ8vd5VaY50JDHZhtcM+?=
 =?us-ascii?Q?iH8Z2SRiPt2S8reoCMcXOdKHASi7M1lD+BEQhTzKiEIGTblmhEnDLJQftNuZ?=
 =?us-ascii?Q?wfB55cp5ZaUVZoE9gN4/ix2Os3AEBedXysQtu1fPKbp7sbaW8fDMVYfzOPba?=
 =?us-ascii?Q?OxU3bmFqtWY+I78yzK1W0MjOIeqlwYirVOBfBl9AKCzoH3+Qyp9JT1hwJj1j?=
 =?us-ascii?Q?MVtrR1oBttoEJUdgB9VZHT5ygi6685HeG4SiBPRNtaeee0LcWYJyAICsEI8j?=
 =?us-ascii?Q?wQjqOknlJYGhURTT+CuPiybNWkWk4bAcC3vLITWvfwamjbZW0Yx5MnEwwbex?=
 =?us-ascii?Q?lAN9bL/Ro6hOV+le4YdaofcWVAD0CvaUXRRPN8Rwem5yaLO1Xvbd0MtEBRbG?=
 =?us-ascii?Q?pjSdM557Vtgca3NOKCyeZD6PWzMH/ZQsmX2Ox/w8enTsOKAfj2zLgR9jg0rV?=
 =?us-ascii?Q?I5rTZG6YUkxGFZu/XSCvcgFFuoK3kMSpSas1hsjEO9b5pxfPYaea9sSws/1j?=
 =?us-ascii?Q?NFoztkfbiTNyhHGOmFJXNQY2UzOWPjPtC8cG8ENo53Rdgoqx+CR9wgfERBfg?=
 =?us-ascii?Q?QwbyIcnEmb1ySP7bbh4gY2bCoTm/lY2GB1gUCX3KtiOXl+JrrvA0UMVAvskN?=
 =?us-ascii?Q?Op4MsZRMP0b0Wfs2IZPBU3gqpZiDvzh0ANkL451VAmCh6GXP6vKl0Z6xoO9/?=
 =?us-ascii?Q?fGZxOXRGG0dTxUGD6oDE7yoVMEol3/F29mWW0Ag854GtRCF+qg5Aw+PQN4zL?=
 =?us-ascii?Q?HiPJ/gdlzv6tadNUMJT2fYSJECKmBoEK1N7U+ccTANIQdFl9Z3xon9sDn5X7?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe08c56-40c0-4f63-08bd-08dcd07a339a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2671.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 02:50:45.2269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bVFBeUP+95vi1IpMQOPqTfNT4YRjzEhY1YBqgjKgRPqiImlYGzYitng/uITkIFJeInz/jTIl4QoXxmHcK3TdN8uSHIrCsv7+TOxiBbiBI7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5895
X-Proofpoint-GUID: js0_G6VT6mbOUZeEVfvaJtvlMheLK5B2
X-Authority-Analysis: v=2.4 cv=DZxFqetW c=1 sm=1 tr=0 ts=66de6288 cx=c_pps a=O5U4z+bWMBJw47+h9fOlNw==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=EaEq8P2WXUwA:10 a=bRTqI5nwn0kA:10 a=UqCG9HQmAAAA:8 a=hSkVLCK3AAAA:8 a=edf1wS77AAAA:8
 a=20KFwNOVAAAA:8 a=ag1SF4gXAAAA:8 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=kJy0AXKTCvhfZgbxjNgA:9 a=cQPPKAXgyycSBL8etih5:22 a=DcSpbTIhAlouE1Uv7lRv:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: js0_G6VT6mbOUZeEVfvaJtvlMheLK5B2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-08_10,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=919 lowpriorityscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 clxscore=1011 phishscore=0
 bulkscore=0 malwarescore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2408220000 definitions=main-2409090022

From: Juntong Deng <juntong.deng@outlook.com>

commit bdcb8aa434c6d36b5c215d02a9ef07551be25a37 upstream.

In gfs2_put_super(), whether withdrawn or not, the quota should
be cleaned up by gfs2_quota_cleanup().

Otherwise, struct gfs2_sbd will be freed before gfs2_qd_dealloc (rcu
callback) has run for all gfs2_quota_data objects, resulting in
use-after-free.

Also, gfs2_destroy_threads() and gfs2_quota_cleanup() is already called
by gfs2_make_fs_ro(), so in gfs2_put_super(), after calling
gfs2_make_fs_ro(), there is no need to call them again.

Reported-by: syzbot+29c47e9e51895928698c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=29c47e9e51895928698c

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>

This commit is backporting 7ad4e0a4f61c to the branch linux-5.15.y to 
solve the CVE-2023-52760. Please merge this commit to linux-5.15.y.

Signed-off-by: Guocai He <guocai.he.cn@windriver.com>
---
 fs/gfs2/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 268651ac9fc8..98158559893f 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -590,6 +590,8 @@ static void gfs2_put_super(struct super_block *sb)
 
 	if (!sb_rdonly(sb)) {
 		gfs2_make_fs_ro(sdp);
+	} else {
+		gfs2_quota_cleanup(sdp);
 	}
 	WARN_ON(gfs2_withdrawing(sdp));
 
-- 
2.34.1


