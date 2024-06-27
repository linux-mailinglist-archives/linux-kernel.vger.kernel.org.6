Return-Path: <linux-kernel+bounces-232828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C8291AEC8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0C3BB26254
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C5E19AA4B;
	Thu, 27 Jun 2024 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FlwCnYzg"
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01olkn2060.outbound.protection.outlook.com [40.92.112.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF1E37165
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 18:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.112.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719511798; cv=fail; b=bz5IbjLZ1PUv7kzjBv9AYl7ldSnlVy0ZNXxl+ySRUsWExAYZU8MwVyspdyfYaUfEmqwDgQfgQsM9n9H5V4+nLLwaj0dLcEPvIiHlm4+koXlmlMTR4pXnBOxE0ctvxtF5YtZyUtFlPnyXf3DYtSjROq714IFpOba4VQ0E1b1R5tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719511798; c=relaxed/simple;
	bh=buTCTOwxSQFjn7MP2/jh3A2el8xAMZSPyNCXAlP43Sc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KDNuQ5gZCjh/OrP+8QT/64DiCO/GT+UpU1xG5pkrv+d7jxga83sL0X1VgQqcLFKXQCmbymrsDX5WijPtBs2Mu1itT9724XFsmauLAKlKexM2Wjzg3UC0c2YDIQxuMurzT/yDsuHYBAtuCAGmCFcSM6Y0Ui/hgdO8CD8Y5Tmo3AU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FlwCnYzg; arc=fail smtp.client-ip=40.92.112.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSLv0uZ/g9vBqYTm03st10RU0jvcsgmICJWJcUVoLLkFFOvQ9LWZ33/KgFbPWTR9jDYreO8beKmwpMnKMp0PV4VW/MTp+iBnz/nG6WW+Kv8OBQe4DjXaXy/jvhHjU++DWO8x6QgOFAJOxtTg0RJehODjMCJ9gVDh5/ouuoO0CfpD9XRAzRhB6gLRsG+Jd1UDDQr4o92+OsqboOyFXiKIbTaJcli7lY1palqOCHo4VLIEygtmsSLSq7PBzDf/CukGYiS0pArqG9gEDkMKscwJTbnQgVrckUDaYmxJF3Q3QZNZqPylzqxLoNpd9ivhdx1vwHDfhd+PJSCRr2b+hrvcHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDlpvFlZXcKeZwO7aSpGVT1rAbtS3Ua56OPI90CVRo0=;
 b=fasFNTmrTXEnDTx5Lquc73b9K7h7LYKR94vlsugsNpTadRzoaKj73g08zEx22NJz9+jNuOm5BTJMjfOO2iP/uh9Rp5fUjv/e5CrEAf3wKt44eEe144F0bda6DtfAvKu1YoMj2DfM690Ur9MR7oX/Ql2MdjNdaabP1UXwTR3t6raMAWhPrXFD+fbTLKyqOlmPcpskk1In40HO+jCjfkhjdvcFA7aDWffu3Rvg90lSFCqmeEMOwwpfEvqTSAC6m1szBhau1+ZXiUuBMaHOuvpFPT6LTS5f/vANUJqRXn0QjvZ39XWYhW7gcS2lS+A9sqhN2OXd4BlGKigfzgrHIUDNVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDlpvFlZXcKeZwO7aSpGVT1rAbtS3Ua56OPI90CVRo0=;
 b=FlwCnYzgyxvE4lgX3Zb5hGQx07Hu8maMU28af+MJrWfegKV4OTuDD0TxYBHIg+bcGOtZA01hLgNlDLFVYZNMSO3c3eHgj97ngSLveRxm8S+G1J4BbLjIzfeczPO5jp33ycmd/87BIxcdBYtG3d4uAZa+t063YgynCqD5j1mELDfm5WdO8xqbJu+ufuOEpW7cU8iSNu+c02sEvEgVxdmncsYU3UNrANPNYsrHhrDQlaHW51APrE0ZR8e3hPS8tbD5oZxqOloWZq8MvgEP6FXxZD27il50WTVVOM/5E/F8LrY2smliBgmJq9PPfAAtiwdxHjUGgAoPooKFH0fEDDipgA==
Received: from CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1da::7)
 by LO0P265MB6677.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:30a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 18:09:52 +0000
Received: from CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a912:f233:4847:e806]) by CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a912:f233:4847:e806%5]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 18:09:52 +0000
Message-ID:
 <CWLP265MB6516AB499D407C0AB0CF106EFDD72@CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM>
Subject: Re: [PATCH v3] Staging: rtl8192e: rtllib_rx: fix alignment
From: Yusef Aslam <yuzi54780@outlook.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Thu, 27 Jun 2024 19:09:50 +0100
In-Reply-To: <2024062727-diabolic-lusty-7baf@gregkh>
References:
 <CWLP265MB65165E806F938F87CB67BF87FDD62@CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM>
	 <2024062727-diabolic-lusty-7baf@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
X-TMN: [w1jRMv/tabCM/WaeQH1dv2Vejsrxx14J]
X-ClientProxiedBy: LO4P123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::9) To CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1da::7)
X-Microsoft-Original-Message-ID:
 <83aa8ee681fffe7066396f400585e2c8e2da1ab0.camel@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6516:EE_|LO0P265MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: f6b6c685-ca75-46fd-d21c-08dc96d45759
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	W3bMMNVpZP3hHX9svanU8yuVkzZZNX/7iTXdzfP0eZW8blbP0Qg1zylJfAIqNYA4T31i/3Kgi7B3daDoyJJTMRv22p+o1DeRJId+M8urO13dBwHgDlwMrr+3ykij+DTrdqQSMIYQi4qfb4g/fQGPXOMMoJ2CdlFkdMs9VTCWqiH0q0scD2xLwfd3ZibIeLQn6598U7kGdh+9tnhW9KAvI/eUAR7c6NR+n2fYWFv1NwZHKGK0hHHzn3oxRYBfPLGUrKq9NCFXsPaLeoYxfgD4sbFy9At9eLY35Q1s1QQ+Y0m8S5NtJnU14vudUR3qE7FMBRIpD+htdcYTXhz7IKl+qjEmLxskjtgPQXPq9oxmd+V1YD5WvLdkO0xveEPgwd5XaKq1eR18ZL5cHasHD+NHNyGKN8ObiYoJgoQrIkJc4WQAgu9dS4l+zmcbGYsghbbb2BdjbgRrq131PpbvHBhTtFvmDITWRlwLKIzi1S7Jhl6f2KbJR6R7TlBrLhoGJPiSVGa1PzrdD3JiE/whS7C97IqCyX8N7bbQ9XCeqM+xmdLsCnMPOCb1axLwkCZFBRpq
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0dPTnpUenNtb1Z1SGxlODhkODVWYkVycjdnRWFxT2VLY0Q2eDE1UnlVOUhX?=
 =?utf-8?B?RkRsYTh1SnpuNHNYWTIxVWFlT2RBSXIyNmFkY2hKd2diYkNsVUZKT2dHekJW?=
 =?utf-8?B?WEdneVJ0ZWFDdFNKQXVZUWhMek01Z0dPY3B4aUwvcU03WC9PdllING5UK00y?=
 =?utf-8?B?aExNTGR5V0pDb2tIYk9yejVhVzNWbitrdGJ0eGdxWjVvUWd5MlAraWhtM1E3?=
 =?utf-8?B?d2pRc2t3RHVGUFN0UTlPN0JmazJJa2FldzhWMmVzdW1QL0hJeU15ZnluTmVl?=
 =?utf-8?B?NFNyWU1EY2t0MVZxQ0luNGFQZnlzc1Z2MnRNd2s5bTVnckMyczFRRFczOW5p?=
 =?utf-8?B?YnNqdzc0a0dLMk5kOVhLYUx4K09RMWprcmEvY096Q1J1NjRoenNUSW9zRmFU?=
 =?utf-8?B?WTFOWDVZa00yOWNqd0lGM2E0dWJhRVEvZ09PSFpDeUhGeVJLTDFMVDYxVzRw?=
 =?utf-8?B?dUNaLzhYSnA5blFOSTk5ajdxckNHeVFRZEZ1ZGRRWkpDSjcyU3FWY0k3cnNr?=
 =?utf-8?B?Sy9DRXFxM0w4Szd0TWlNTTVQVVFxOGpYUXNFZ0liUURCTGxTdUZOQ2NDS2lx?=
 =?utf-8?B?OWZxK3BBMllTbEJ3MXFrM25DV1prSXNxUCtYaGdJRFRCVkFDVStzNVcvNmdE?=
 =?utf-8?B?RGxpWktraGZaRXJ0VVBKcHhkNVFTWmttTkFwUm8zYWJBZzNCS3E3c2VFZE4x?=
 =?utf-8?B?VmVMcGtaSm00RStzUnc0Ym9JM1psNkZFSVEyZ0FVMUhidjhsOEptUytoV3RB?=
 =?utf-8?B?SUVCM3A3eWRqMzdiWjZ2REZJS2VUWTZIRkxFNDBmQnIrWDFUaFRidTNJdGlj?=
 =?utf-8?B?SkdpdDZOQ3BvcDRBR3U1bThWeFFCekVaOHoxRHN1SFphcGFzK015QkJSZUdB?=
 =?utf-8?B?U2oyRUFOVGZCU3YrdTBBa2dKZnFSZURaV3prcWFEWTJkdFJhMHJRNDV4Qjkr?=
 =?utf-8?B?a1RzWmNFV1BlRVpEYnNCZDdoUGV3UjA1a29yV0ttSnFKbHZ0UzU1TGZrT0pL?=
 =?utf-8?B?MDZxOFA3NGU0VVVuOUhkZ3J1NWFpOEtWeS9pTlVFNW1wM0EvdGdLcXpBMmtQ?=
 =?utf-8?B?K2lvTWw2cWJNSEwrSWxkem9GTXEzMlpEczRnZWE1eUlObnpHYkREd0xpaWRV?=
 =?utf-8?B?aWt4YzJ6cE1UYm9WZExkUEdERUdGT2piSVlDNXBZVEdkV3l4azRjQ29INnQw?=
 =?utf-8?B?WkEvTEdZSGcvRHJ5THdTOUg0bFlCb29Gb1FFTjBZUFVJOFlhcmEzeElaUGNJ?=
 =?utf-8?B?RXVjQVpXL1dTMzN2Q2ZkRnZLcW44a21wWDdBRXgyM09EQzVoR0xPN2lFakI1?=
 =?utf-8?B?UisvZFk5dkRacC9lYytUaWU1NXlDenlYUmZ1K0FuY2N0Ymx5YURBaVlBRnR0?=
 =?utf-8?B?aTEyaGEwN0ZCc2FDbDFLbWx6T20vQlVaMm5MQWNCVXlaZXVnRFhsRUNyRWxQ?=
 =?utf-8?B?VE4zM05yNDRBUkFLUHVGbWpwTS92RFp0VE96aTNnd2pZT05KK1pZTlk5WWFF?=
 =?utf-8?B?di9EaS9WWEdCYnZFcFk4bmN4c2l0Y1pRblVpZ0VrVzE0azFVeHJZdWFYRjc5?=
 =?utf-8?B?U0xRZDBhTlBWa1VuNE9vUnduZ2k2LzhpSDdHbC9RYkhaVWIrL1pJWktLZXMy?=
 =?utf-8?Q?I2irEOEDOSfv6JXzGcufMGipJk/XjBOLDDpPTCXgO6u4=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b6c685-ca75-46fd-d21c-08dc96d45759
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 18:09:52.4235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6677

On Thu, 2024-06-27 at 15:43 +0200, Greg KH wrote:
> This all should not be in the body of the email, please use a tool
> like
> 'git send-email' to send patches.

Oh k thanks, I was trying to use git send-email but in the end I just
copy pasted the email into Evolution as msmtp was not sending emails
for some reason.

> > Fix alignment.
>=20
> We need more description than that, right?=C2=A0 What would you want to
> see
> here?

Yeah, I guess I would like to see a more detailed description like "Fix
alignment to improve readability" or something.

> >=20
> > Signed-off-by: Yusef Aslam <YUZi54780@outlook.com>
> > ---
> > =C2=A0v3:
> > =C2=A0- Used the correct email addresses.
> > =C2=A0- Developed against the correct git repository.
> > =C2=A0v2:
> > =C2=A0- The email address of Greg Kroah-Hartman was wrong.
> > =C2=A0- Developed against the wrong git repository.
> > =C2=A0v1:
> > =C2=A0- Developed against the wrong git repository.
> >=20
> > =C2=A0drivers/staging/rtl8192e/rtllib_rx.c | 110 +++++++++++++---------=
-
> > ----
> > =C2=A01 file changed, 55 insertions(+), 55 deletions(-)
> >=20
> > diff --git a/drivers/staging/rtl8192e/rtllib_rx.c
> > b/drivers/staging/rtl8192e/rtllib_rx.c
> > index 84ca5d769b7e..1f6c4a3de5c2 100644
> > --- a/drivers/staging/rtl8192e/rtllib_rx.c
> > +++ b/drivers/staging/rtl8192e/rtllib_rx.c
> > @@ -410,7 +410,7 @@ static bool add_reorder_entry(struct
> > rx_ts_record *ts,
> > =C2=A0	while (list->next !=3D &ts->rx_pending_pkt_list) {
> > =C2=A0		if (SN_LESS(pReorderEntry->SeqNum, ((struct
> > rx_reorder_entry *)
> > =C2=A0		=C2=A0=C2=A0=C2=A0 list_entry(list->next, struct
> > rx_reorder_entry,
> > -		=C2=A0=C2=A0=C2=A0 list))->SeqNum))
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list))->SeqNum))
> > =C2=A0			list =3D list->next;
> > =C2=A0		else if (SN_EQUAL(pReorderEntry->SeqNum,
> > =C2=A0			((struct rx_reorder_entry
> > *)list_entry(list->next,
> > @@ -736,7 +736,7 @@ static u8 parse_subframe(struct rtllib_device
> > *ieee, struct sk_buff *skb,
> > =C2=A0	/* just for debug purpose */
> > =C2=A0	SeqNum =3D WLAN_GET_SEQ_SEQ(le16_to_cpu(hdr->seq_ctrl));
> > =C2=A0	if ((RTLLIB_QOS_HAS_SEQ(fc)) &&
> > -	=C2=A0=C2=A0 (((union frameqos *)(skb->data + RTLLIB_3ADDR_LEN))-
> > >field.reserved))
> > +	=C2=A0=C2=A0=C2=A0 (((union frameqos *)(skb->data + RTLLIB_3ADDR_LEN)=
)-
> > >field.reserved))
> > =C2=A0		is_aggregate_frame =3D true;
> > =C2=A0
> > =C2=A0	if (RTLLIB_QOS_HAS_SEQ(fc))
> > @@ -876,13 +876,13 @@ static int rtllib_rx_check_duplicate(struct
> > rtllib_device *ieee,
> > =C2=A0	frag =3D WLAN_GET_SEQ_FRAG(sc);
> > =C2=A0
> > =C2=A0	if (!ieee->ht_info->cur_rx_reorder_enable ||
> > -		!ieee->current_network.qos_data.active ||
> > -		!is_data_frame(skb->data) ||
> > -		is_legacy_data_frame(skb->data)) {
> > -		if (!ieee80211_is_beacon(hdr->frame_control)) {
> > -			if (is_duplicate_packet(ieee, hdr))
> > -				return -1;
> > -		}
> > +	=C2=A0=C2=A0=C2=A0 !ieee->current_network.qos_data.active ||
> > +	=C2=A0=C2=A0=C2=A0 !is_data_frame(skb->data) ||
> > +	=C2=A0=C2=A0=C2=A0 is_legacy_data_frame(skb->data)) {
> > +	=C2=A0 if (!ieee80211_is_beacon(hdr->frame_control)) {
> > +	=C2=A0=C2=A0=C2=A0 if (is_duplicate_packet(ieee, hdr))
> > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
> > +	=C2=A0 }
>=20
> That's obviously not correct.=C2=A0 Did you run your patch through
> checkpatch.pl after creating it?

I did not, thank you.

> thanks,
>=20
> greg k-h


