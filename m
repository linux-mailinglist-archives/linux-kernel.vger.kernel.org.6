Return-Path: <linux-kernel+bounces-212701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5543D906509
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C9521C23182
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 07:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42B213A41C;
	Thu, 13 Jun 2024 07:27:05 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4F2139CE2;
	Thu, 13 Jun 2024 07:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263625; cv=fail; b=TOGIpyaKpgPa2r2PFo+vGeHUb4NEoRoAmQrGIR4dqq7m1cd6G5hxo7BU0vqFBsaNIm0ObblZXtLxNN8IShjFTfk18GtoXrDbqpSQlxfM273u8PzVAW+M5HvErk6+TT7U07mB9TAYT2l/lxlumxgB5MMFsj/1ovcjnTRgbFCf5/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263625; c=relaxed/simple;
	bh=bX8SDpZtn8Ob28JIJt0Go60pV4nTpliBzxLX9y+wpnI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mv8LDqa9Yy+spNgVeOml6j0+574M+rQK/i1VbN+YzCzUtYo+S1pAdOA5xJ32GRx+bpsZSlpAaqkjTA8iCMnKaBmxvAsP43WfRT5x4s+f+L8Q7KYF+UGYqsZ7O0PN5UD2eLRXSSk1S4pyJClyKT5PmsdFlpINcpSj60blbkLhKkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D4t26f013473;
	Thu, 13 Jun 2024 00:25:59 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ymptg4n12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 00:25:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwhVwJjtRRfDu0oXbrJdaTResnT8gBiiiSb+UxGavupXLUVFsyTOxwMfcs0wsYGHU6pkCRZ7l4jrOe0e9KIzL/Z6vkSszIbB/ZBGITyE32Ec9+PUv2bPG+PGuzLGAPtqga/GXRH6XXdVKDLKBpsmadQs7MPNIM5vIdfE5NZxdGx9RbV4F65Xk7met0hZD2DEkDnCQzYyiDDsDZTEvCpiiwcdkKqWylheU6ZquaEhnVknEQZ5CHFF7V0PwiYTm2SmyMBI5YHtVeh1j46Iwg7sHM9iT8pCCayyp8O3GBbo4EEHZfeF8PLAfgMQPI3up6gqUKfCBPBmYg5V4UWgk83XSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGbI87pqKmTIFJTFRHbBIahm1tlJINBCldZ5f98JD2w=;
 b=TQ8TjQkC7+CgJB+PLhZfkGqptnZur9uwuQjt4Pdm/KIjPdcNWigcg4WwoUzBx0LQ/urob+woTeffyWGY+mQ7dcCGoKSVfkXe7VDC/oItYtxyC35uiEMWh23QuhNis1rikDr1i3IG2gXItHkiEIFLSWBQGpil2+2EXzij6eXdw8M6+T1o5JpZ45chF9mRNlOvtgSfygQV1AvZ18Zt5R5myZZIM+WkC55HdjG+QHfp4D/PwjIgoZ/f6wRZjlddb84r+nf3eq/zncSCgPnZzo/dgkA9nSnAoPPyDFfSQuVwkRoj8XwQlMcKYsrRxK29NcP3HvzyMWBiFrQlxnA9GkUHMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by IA0PR11MB7354.namprd11.prod.outlook.com (2603:10b6:208:434::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 07:25:57 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e9d7:7193:8b2b:f0b9]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e9d7:7193:8b2b:f0b9%3]) with mapi id 15.20.7677.019; Thu, 13 Jun 2024
 07:25:57 +0000
From: "Li, Meng" <Meng.Li@windriver.com>
To: "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "quic_uaggarwa@quicinc.com" <quic_uaggarwa@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: dwc3: core: remove lock of otg mode during gadget
 suspend/resume to avoid deadlock
Thread-Topic: [PATCH] usb: dwc3: core: remove lock of otg mode during gadget
 suspend/resume to avoid deadlock
Thread-Index: AQHavWKU0485a3wnY0+iuiKoykc8vrHFSs1g
Date: Thu, 13 Jun 2024 07:25:57 +0000
Message-ID: 
 <PH0PR11MB519110C2888B65821D0F4A3FF1C12@PH0PR11MB5191.namprd11.prod.outlook.com>
References: <20240613072310.1927966-1-Meng.Li@windriver.com>
In-Reply-To: <20240613072310.1927966-1-Meng.Li@windriver.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5191:EE_|IA0PR11MB7354:EE_
x-ms-office365-filtering-correlation-id: 6a6fc1d4-2eb2-4c99-79c3-08dc8b7a114a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230034|376008|1800799018|366010|38070700012;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?aLfeyVYKmpAINiMAbE9xw9ATB536f61XtCfZOLuTyLRqGoecKwibJRwhwrp6?=
 =?us-ascii?Q?LZvocO1Nw1cOb2hbFY/+diScnph82S7gnDXEd5xcbp2+Ydjf1pCv1TR340z5?=
 =?us-ascii?Q?QvLKYaHdpS4afC0x54niyhRzhQkWG1yJban3npVYGelnmGea3b9tNoNOKxgU?=
 =?us-ascii?Q?9bcakMyO/UReLocvmH6G0j9VFWO6YAL0v+NEAunw2WGxkUps3k4bykjv1Fym?=
 =?us-ascii?Q?rAeCWxu49UjQkRhh07Hjm3HNkXYaPjMT1bzTKDbQxlgcr1lS5kNDNKJmdFR9?=
 =?us-ascii?Q?8yL/m9EnDqBIxCXH2/l4qSgg1AhKjCx2X/8+Ev5UpYBPk+90Bqr7uaI+mYyo?=
 =?us-ascii?Q?txBkowZiyLm1OKC1WIpQknQ2oAWbx9m5rNBnb3e09pC0m7kqWhIWrwJ0mHqg?=
 =?us-ascii?Q?kILkbh/WOPKNZkonffs8//FPgVI69r6G+vZBdeQLJ2WOvjZCGQFaV1IQGVma?=
 =?us-ascii?Q?ln+eyM4MErVdlB8lI6SjpP1hMrwWXa2slZHOqzDaxVXcLdnwPKL5q81Zf+A2?=
 =?us-ascii?Q?j+GBPjpCKEz01LA6ka/Y/w2xHA08BSC14h2IFXpbK/xs4l7PollVlDNVMgON?=
 =?us-ascii?Q?iqivjd07sxhhxYp+LFyVKUGgfFrpMGpGHoDwwC+cV8udzu85f4u/ueHxN8Jd?=
 =?us-ascii?Q?MT0j7a9igzIUp7Rh4IfMDIEeI9P/Sk90VBHTDH4+W4L5CWIlXfcdEL0gShXI?=
 =?us-ascii?Q?u3oewLzervLcYTsL9QrqZr+EDQ/v5SbRBAzrtqUPDvEpO82WHKUGuFv7mDe7?=
 =?us-ascii?Q?roT4sdFVLofhsa6yqSpg3ofTh/E1b4xqb6lQpxEWupsRU4nMxecj/Anqo5QW?=
 =?us-ascii?Q?eyVEcx2rYZNa40DCfNEXBS4wBIUH3pEdcRvQrPvkUQUMiv4H53Jz505Z/rfZ?=
 =?us-ascii?Q?Ig3TMvWk8PFrSsc8KJvHUsLwh6l84esUjsCYwVVRMt85auqPlou6lpfZxoIC?=
 =?us-ascii?Q?flWt4o5LufQif1lCAu/3v/59T0Ul0aa6ftsluk8U3t0gHxcDx1codwdMh++X?=
 =?us-ascii?Q?5tKoE5orZoGUPCl7CNePwUHHdMUpsOkyi1L6XUoAcrCHqjwncYMe2BHRqupn?=
 =?us-ascii?Q?fk0MxZQD6AL8Z+JRr1/rGSj6GTzmRZRaxh7kVnPn8Zc/Fgn40bOA9D278dNP?=
 =?us-ascii?Q?BusxrbREIYxfRuzJtKHHUoM8kbK7D+Mbh4lvurkzWeuh766ONwacDbvYi21L?=
 =?us-ascii?Q?V5k+EOF+Nws7OPIc0CEBZeS2GH3Rmtbe4gS8pPUlMUagUdh50BTl9hOVLNc5?=
 =?us-ascii?Q?pUVnEsjpaoGc6qHzbvHReKB5rUNQVH6lmwNNqUiwePo+6bxa7bQH63bvEWj+?=
 =?us-ascii?Q?bXEgT8zzSS1/4OsUc5Uz6/GEl1GMghKHZcthhN5+yW/G6NxLpUMPiWc1r6rt?=
 =?us-ascii?Q?1FF5Wr0=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(38070700012);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?mMKWVBThhPTAkyJB/DF5ItypPzRSPWo7nW0oOcVbZMrwqwyWP+/LaZ6fAjCu?=
 =?us-ascii?Q?E3l2fpHbaawiRs2rko7r4YaEfc4ezfhxfi8p0ULMNQO5HoMgEc1fnvEohvfv?=
 =?us-ascii?Q?qLQoAtCX5VIXbd1jnQoyXK7rHFeYhU9A7LyDt9yDWZQebUssPGg2ZiHSEXO+?=
 =?us-ascii?Q?Qc9hlcCIq0+M2lqAH1ujaZUfkr5udWJdl2KrQHQdADDT2CCcpqEKqUeqhvtz?=
 =?us-ascii?Q?ztaxcrVkasjrJZmVnukeltAds5nEPAm6exPj9QH5Ww6Ixex9lHo+Bxru7hva?=
 =?us-ascii?Q?GdbXihYbf31wjiNDrkykQPYTNeR9Ti+ZIh38L57Vl8D9g7Lovd4cRd++3g9Z?=
 =?us-ascii?Q?DalI+Tcswsnp8awLW1atsirSPnwVCP72GqAwWbohpm/g6gOgEphH47LFQ8EI?=
 =?us-ascii?Q?prQbDDGDF9aNIzFm+l0m3D0IT4S2aOZzoUNxWJ+GVJ9hO4tuyIGD9AaPTlC5?=
 =?us-ascii?Q?ejtkCpldRsQFOIkbhvSL5gdGMyruV9ha6hGkh2+XhyYgCEhIWQIb5deIBX13?=
 =?us-ascii?Q?xAG8PljZB6aP+1lAjmNZZWAnRVDbq/x74hHmUCy3P5KAVS+GnsjNqAN+XgeF?=
 =?us-ascii?Q?zsVvSVtzB7dmaz8+HJUE0IwM54dU2TUTqRI7kToJEs2An9GEelSfZvUWtSFz?=
 =?us-ascii?Q?uiSijUIUUMy7Smg9fEJlURgekFq9XgfLPFVPEo1W9d4SILVTz1KufUoJrKO5?=
 =?us-ascii?Q?5yys2rhEYda8rfHXkQuWlEaDhDhCHVu1Jjh3VAM1jyhE3RwsjsaK8Zgc8uts?=
 =?us-ascii?Q?SvT6FlZ+JsWhOvWREkUpbDcwAaHnwjEwY1Ci78Tz5OWI4Xay9x7MZ3voBT2q?=
 =?us-ascii?Q?Px6W0TmjAUNnmoniZKUIEtGpYCe3LN5m7VHPLrqnnTNYvlo+ZNya8wTzQrSf?=
 =?us-ascii?Q?zi5aObbnqAyaMuDMNm1ry6ae6yiRkHxDY4durtfdffYvvOmDKPxv8Sgc1ECP?=
 =?us-ascii?Q?QB+h4os1RzD/ZRqKactaFi0DR5e70a7enrFgKFav8H6NVzQKdPtzwsuJqyzl?=
 =?us-ascii?Q?4GX5ooCnnTbEZENDeGrc4UQONZNOqCFfejeTL9vpO51mvu3jmOEGyT+oOH6C?=
 =?us-ascii?Q?rVubRqnbnOJwIr+wIGSgXI62UDzi6gblE1n8NwRLSB3ufZY7OSqrUVDSfRkF?=
 =?us-ascii?Q?h1oV36vV2ah4PtcPcYnHilXC9CaA44Bj4lsd34bjp9pI04DEnx/6c+5N94X/?=
 =?us-ascii?Q?wmot9OaKY2fPTHowKvrWoji5GptTss/KKJ2qDfH9d4k5hJN5ps9yktPUJl9/?=
 =?us-ascii?Q?khOY9igXoOt4w1fT7dha2BDKHO0tTYjkQ/fTwaF6AHLGf+ahhxlSw668uhqw?=
 =?us-ascii?Q?zB4D2bXJUPTok/Kn8EoCKUn9dpACizp3URv9S2qaCmfxdIfJpH785pSQPhai?=
 =?us-ascii?Q?iTZ7sViWhTKbs5eSqGgt+A4Xg8Loohftye570kMq2L3UjjrtN3fKzLbR+54P?=
 =?us-ascii?Q?lqUTxv3aHI2je+s71nq52SJbNshslivwxOH1xnICrPEoEATRSmyLdyIZQiDT?=
 =?us-ascii?Q?3/L4jFQXgZGOIe3U6nb4YM6JjvGg0tWyeXrOp0X2OkOwEvlQ9OYjVAdxTRX6?=
 =?us-ascii?Q?ex6HoJLnRWcXhjKmZWJTFKA7OHfZ8Vyyb58PqDBo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6fc1d4-2eb2-4c99-79c3-08dc8b7a114a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 07:25:57.1948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KEAWR8BaPgqCYcYUSaBkgHtm7/Fbd5tOI6a33ykg7+z3U+QJZbQs8SDyrAgJUQ/HVWOLKr+OZJx9L5SWrFRsjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7354
X-Proofpoint-ORIG-GUID: 6gYXYomTSUVgL_7QRxKuziiLHCFf2JYQ
X-Proofpoint-GUID: 6gYXYomTSUVgL_7QRxKuziiLHCFf2JYQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_12,2024-06-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.21.0-2405170001
 definitions=main-2406130051

Sorry! please ignore this patch that is for the linux-stable kernel.
I will create another one for mainline upstream.

Thanks,
LImeng

> -----Original Message-----
> From: Li, Meng <Meng.Li@windriver.com>
> Sent: Thursday, June 13, 2024 3:23 PM
> To: Thinh.Nguyen@synopsys.com; gregkh@linuxfoundation.org;
> quic_uaggarwa@quicinc.com; linux-usb@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Li, Meng <Meng.Li@windriver.com>
> Subject: [PATCH] usb: dwc3: core: remove lock of otg mode during gadget
> suspend/resume to avoid deadlock
>=20
> When config CONFIG_USB_DWC3_DUAL_ROLE is selected, and trigger system
> to enter suspend status with below command:
> echo mem > /sys/power/state
> There will be a deadlock issue occurring. Because dwc3_gadget_suspend() a=
lso
> try to get the lock again when previous invoked dwc3_suspend_common()
> has got the lock . This issue is introduced by commit c7ebd8149ee5 ("usb:
> dwc3:
> gadget: Fix NULL pointer dereference in dwc3_gadget_suspend") that remove=
s
> the code of checking whether dwc->gadget_driver is NULL or not. It causes=
 the
> following code is executed and deadlock occurs when trying to get the
> spinlock.
> To fix the deadlock issue, refer to commit 5265397f9442("usb: dwc3: Remov=
e
> DWC3 locking during gadget suspend/resume"), remove lock of otg mode
> during gadget suspend/resume.
>=20
> Fixes: c7ebd8149ee5 ("Fix NULL pointer dereference in
> dwc3_gadget_suspend")
> Cc: stable@vger.kernel.org
> Signed-off-by: Meng Li <Meng.Li@windriver.com>
> ---
>  drivers/usb/dwc3/core.c | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c index
> a8fb10cc65bc..9bb4ab409bbb 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -2112,7 +2112,6 @@ static int dwc3_core_init_for_resume(struct dwc3
> *dwc)
>=20
>  static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)  {
> -	unsigned long	flags;
>  	u32 reg;
>=20
>  	switch (dwc->current_dr_role) {
> @@ -2150,9 +2149,7 @@ static int dwc3_suspend_common(struct dwc3
> *dwc, pm_message_t msg)
>  			break;
>=20
>  		if (dwc->current_otg_role =3D=3D DWC3_OTG_ROLE_DEVICE) {
> -			spin_lock_irqsave(&dwc->lock, flags);
>  			dwc3_gadget_suspend(dwc);
> -			spin_unlock_irqrestore(&dwc->lock, flags);
>  			synchronize_irq(dwc->irq_gadget);
>  		}
>=20
> @@ -2169,7 +2166,6 @@ static int dwc3_suspend_common(struct dwc3
> *dwc, pm_message_t msg)
>=20
>  static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)  {
> -	unsigned long	flags;
>  	int		ret;
>  	u32		reg;
>=20
> @@ -2227,9 +2223,7 @@ static int dwc3_resume_common(struct dwc3
> *dwc, pm_message_t msg)
>  		if (dwc->current_otg_role =3D=3D DWC3_OTG_ROLE_HOST) {
>  			dwc3_otg_host_init(dwc);
>  		} else if (dwc->current_otg_role =3D=3D DWC3_OTG_ROLE_DEVICE)
> {
> -			spin_lock_irqsave(&dwc->lock, flags);
>  			dwc3_gadget_resume(dwc);
> -			spin_unlock_irqrestore(&dwc->lock, flags);
>  		}
>=20
>  		break;
> --
> 2.34.1


