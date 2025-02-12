Return-Path: <linux-kernel+bounces-510667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D782A32029
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77C5C188D05F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5022046A1;
	Wed, 12 Feb 2025 07:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bcnxdZMm"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2105.outbound.protection.outlook.com [40.92.47.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD910204682
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.47.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739346162; cv=fail; b=B237KRLFePVFjFAgIcTZyOfGNxCnd4P4JlccFKiExSIwYLDSXE757Q4kTZUTCqnf2qCVJg16BsPi5ZPN1wDxkQyETcQ9ySM+qfu4grarM1rZ0azgP9tita123Rkwhv4SiKaYJwtiuuiu7/tSxY+8ejxflSmQKiHWS5EivOA2lVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739346162; c=relaxed/simple;
	bh=Qq9eae/SZKkcn7X9Wu2dadJyoNJOOBATSpDOjMPa1dY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g6iG79L0F+8n6cIS+yREyKuEFDJuUo4ReAU61C9NpH7fAS1Kf68/ETLkNl/Clinc2M8TK9PIBbkoLwRf5UdjDi07OlPz+roGD2SZ96awfZ4atdg8Cwi0jjQOHGv2NqaHBllvtt/RtKlp2uIcERVFM8BuK/5McKSsqjfkQimSTwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=bcnxdZMm; arc=fail smtp.client-ip=40.92.47.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lvb3ua1UdurJNHDI5ccOekD4D+JbUd2detfk3VGM6P7J617oxVXprWHTeDH2ql400QLGCUHXhXcdL6poDC4U7EdAupH/15J4G8qb6/c1SrsjoG4jdHPHX276XL9Ka4TZ7Yi7q0yFNpJ+p6t9YFdPw4M4Ja2O22o+tKGkIEOuwnY0MCpz+OY9BEu6NJ1pTVXeLogxB1sV4eg0CFv9Q6z5YpVHGdyrAmkuD2OcWj24Qj+S4TDRXBy3MwPsNYn9v2D4zHlpmq7v7ZxESxG9ObWxIk3S4M9qsQrfV37R+neGXhaC4nFN0a4Xx4ru1a/pTU5Cmuv2Sy4EoZWYEDSzrYsi4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qq9eae/SZKkcn7X9Wu2dadJyoNJOOBATSpDOjMPa1dY=;
 b=cdIoR2ewejq4fekzWRza9BgO0Ix9eciJSB5LUhj+3gZEjV85f9Y0NCK+xc0wQEp2wWUe4FOoPXkMc5ZTZKyuX8CWOhCr4LD9ZyvFXCQsh/4ZxLdO/EowR5ykKUGddngKucoBmgP2yTQDhVg20CZkhwzWXJHqMVwBO466pyvye3IqEOIlfDHzlCq71087xQM1+C1aIZco3XAS8YnGdXyo1fZVs5UMrm2tiw13u9PMpNnQqds4dOyXX+BeeRsjNIw/knfreQJZh8gjH0sejjeY7CKPnP05rjd1T/5eLpcEtf696BrnwbJQDhzE5VKNN8G45vpB6t7qQ2WpdraIL7NGiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qq9eae/SZKkcn7X9Wu2dadJyoNJOOBATSpDOjMPa1dY=;
 b=bcnxdZMmux9QaZ39jH6wWqqi/yhWzkIbJd3rfX9PYFdGPrplTfh0WyDU19S5R/NOt+cAXYqURf2qadXdTqPn3yWZcaq486QywNZtkfO9Wd45XyZboEUef8iTz9dhNdvJVI+jRh3i+lhkfBBaYBLwIVzciv3OVnckH3oXg+TLcF7RGn9aTtOeFVqRC3RxqDc3PDh8NFfRSLsd2P1jKlLZnkoSFwpaDjsNaheSbp3wxWAn7jBD3R7ExODa8Af9UgAbmuQOLPjnuU478dfmvwq1ZTBHA7C+zdbG7Qxc53HjibbR5t7EGs9bMfEJJYGvrul9bpoWYPe1+2pgJ3hq5tgf4A==
Received: from BYAPR12MB3205.namprd12.prod.outlook.com (2603:10b6:a03:134::32)
 by IA0PR12MB8206.namprd12.prod.outlook.com (2603:10b6:208:403::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 07:42:37 +0000
Received: from BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::489:5515:fcf2:b991]) by BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::489:5515:fcf2:b991%5]) with mapi id 15.20.8422.012; Wed, 12 Feb 2025
 07:42:37 +0000
From: zhou stephen eta <stephen.eta.zhou@outlook.com>
To: Mike Rapoport <rppt@kernel.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBtbTogb3B0aW1pemUgbWVtYmxvY2tfYWRk?=
 =?utf-8?Q?=5Frange()_for_improved_performance?=
Thread-Topic:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIG1tOiBvcHRpbWl6ZSBtZW1ibG9ja19hZGRfcmFu?=
 =?utf-8?Q?ge()_for_improved_performance?=
Thread-Index: AQHbd5I+MclXFgUVVk6Vm36iiqWOEbM78nGAgAAPzuqAAAHupYADAMsAgARNm60=
Date: Wed, 12 Feb 2025 07:42:37 +0000
Message-ID:
 <BYAPR12MB320544222BA694E050BCF5AAD5FC2@BYAPR12MB3205.namprd12.prod.outlook.com>
References:
 <BYAPR12MB32059CFEB36A5FC7D859B69FD5F72@BYAPR12MB3205.namprd12.prod.outlook.com>
 <Z6YfqcOx5FACtvae@kernel.org>
 <BYAPR12MB32056738A6225C6B5D61A01AD5F12@BYAPR12MB3205.namprd12.prod.outlook.com>
 <BYAPR12MB3205B550D78130A3858535C0D5F12@BYAPR12MB3205.namprd12.prod.outlook.com>
 <Z6izcu5M3LRM3GzC@kernel.org>
In-Reply-To: <Z6izcu5M3LRM3GzC@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3205:EE_|IA0PR12MB8206:EE_
x-ms-office365-filtering-correlation-id: cbfba189-6448-4910-1d5d-08dd4b38d23b
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999004|8062599003|19110799003|461199028|15080799006|15030799003|8060799006|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?VjkrOFVjaXFTSDd3UlhmVzhvZk1hTklIb0krRnBUTlZPeHRGaGlaMHozSFY0?=
 =?utf-8?B?MWFnWVZxNHVNaXFUc0RyK0lCSU90UUp6UVIrWjF1RVJ4NWQzSDM4VCtraFJJ?=
 =?utf-8?B?cCtyMG9FajZOK0c0bkE3MlpQTFhNWExqQ2NsYllHeDJ3MVY5UGxrcG1oMXJE?=
 =?utf-8?B?Q2xDandVRTdOZjBiazM2RlQ3eHFGU3JxRS9VNDN1SDN2SG44VTk0UzZMQkg1?=
 =?utf-8?B?VGRmVjZuSHZqaGtJbmxDOE03ei9XTzFHTDZOUGJjZUh3cGFlOFlTeU84L0tz?=
 =?utf-8?B?UmNYQVNoNTFwOGdLaDUwaGVjWDJWQzZkM05tY1BpbzVpd3FqTEU4KzBlOXhm?=
 =?utf-8?B?WFMwSyt2bjhKK3FaL0dpYktzNTdza2Z4Z1ZlK004andDSkV6Qm54TzV1L0Zq?=
 =?utf-8?B?YVNubGoxSll4QTg2VVhFOTdPOUhzbERDaUUyaXhoOUw3MnNmVm9JOXdYMndI?=
 =?utf-8?B?Z21CY1dnTVVybG4vK1g4NnVJbXlBS2pDL2F0K0l2dnV4TjlLTXVaSjQ0dy9G?=
 =?utf-8?B?dHdOczE3R3UrWjhNNHI5VGFaUy9HeW8yVlVyaVBRdHhZTzhleDRISytiYlh1?=
 =?utf-8?B?SXlVNmR6aktlWXdmdGlGTzVadjZ1WVdmVVVqYUdzc0diS0x6U0NXczJSQ2dV?=
 =?utf-8?B?NU9XaUdBOXpDdzlFOGQxYzdNallNaDA1dTIyRmVycDNFaHRYWW41ZWZONjY1?=
 =?utf-8?B?VWxVeHMrS002bnp6cG9iaUZqeExVNXUxWENGV1g5VW9EUVA2K1hUeUNqRzEz?=
 =?utf-8?B?SXRGQlo3MWJoY0U3Sk9CcWNqSS8wMjF3NnA0VTN3b3FrQW5uL0RwUi9tTUJM?=
 =?utf-8?B?TnlJekR1VCtWTWpsSUxGZnhIT0hJemZ4M0U3RllwV1lXUm1NWW1pTDNnQ1h1?=
 =?utf-8?B?UFh1WldiSTk0T1JaWFAxdHRUSjd2bHZSRU1kZTZvM1JPbTgzWHZPWGlOWUhp?=
 =?utf-8?B?cmlHckZtYVFpVGlZM2dVa2hWaXNHVjhyaE45QXdOVEZRdGFyRU1pc2dSeEli?=
 =?utf-8?B?RUtpTThxSGlZb3JKblp5d3J1VGhTRmM4TXE2dGpHOWhxeHNES1BqUUp3bXV4?=
 =?utf-8?B?RWVjWWN6SGpQdkhIU0o4RldhV2RTTC85d0Z2dUtqSDdnbkhFY2pGaWFNM2J2?=
 =?utf-8?B?d2U2K3kvdU5OVFB4Y210b0RBbUNhNGM0dVppSDNTaWduZ0pHbDJWdjU1MXRj?=
 =?utf-8?B?NkY4YmtReVFpK2JZSDFMdWJkajVRb2p2VjdVTTV2SWtFZGtORThSVzNzQXN2?=
 =?utf-8?B?Y1hrUDZuZE0vZmozK1ZGbFNaYUNwUlFHZWNzdnZhODZpVUNVYmRyZithd2di?=
 =?utf-8?B?NUhUZDBuQjl2Z0lITE9xMXNYUE9qSUcvMDNXVHJTUkVGaXQ4aitjalZkL3Yr?=
 =?utf-8?B?ZkFTeHNWd25ac05QdCtxK242Wk5lSnlJQ3JpMEJxTjRNK09lOWordUFxd0Fs?=
 =?utf-8?B?OFM5RjZBMGxBU0YzNlZjU0wvaTZtM0k3Wlp2OTZ0bGkwTlUybi80WmJHcnJT?=
 =?utf-8?Q?blWYG8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Unora2Q2b1NxNkxRUStDQmsyMnduT2FOMG9ZZUJtMTZTcThRT0ZnOUFBVHA1?=
 =?utf-8?B?R0E1ZkRFeHYzN1FKaDJXWmRMUGNIeUViR21FaXkvRDlIWlJKM1BvRmpacjZH?=
 =?utf-8?B?bDFsL2NYZHcyREZvNkFKT2p0em5idXBaWDkxS1J1SlkxVC9nenFiRDVwVGVS?=
 =?utf-8?B?alZtUnNMQWRaOHdQSjN6UHVLampwcWFMUjFrMG1zYjRyK0pMY0g5MnpHakVT?=
 =?utf-8?B?Vm5qd3ViRnNCWFBmcTIrSFhhTTkyMTVjTGxMRXAyYkZhUDZFUU1iVnFZVkts?=
 =?utf-8?B?SGVNNmRJN0pyQWEwRnNGVTlsaUNVc1o5OU5vUW13am1WRysvNE9vSWZmRzFN?=
 =?utf-8?B?TEVmeWgvcGk2eURXMUNCTDhlMjArYmsvajNZQ3hPTmU5RXRRRnFRS3R6elFh?=
 =?utf-8?B?cEhKYTRoSkI4MS8rVDZwZ3AvcUFBY2pBTWRNS25ldnIxSHNvK1ZwemlQMGZ0?=
 =?utf-8?B?OXV0QTlYSVM4SVMzR1I0VG12Z3NsMUJLYVpIaWlyTUM5QUdYUUNzUGY1OC83?=
 =?utf-8?B?YVlpNGVDZzFYT2s3cThQZlVLcVIvay9ORDJiV3F6enByd0JRQmUyUHQ0NzFl?=
 =?utf-8?B?RWtUMXV6WXVqcXhYMW1nOFhYVU1xTTFFeXhVYksxMGpwTnd2SmY0RUlCZnRJ?=
 =?utf-8?B?bXozejBzd2N3QTdCSE9FTWtBWVlkNHF2WE1najdhbnhvenhQWTRmT1gwQlpr?=
 =?utf-8?B?dG1pRmZBS0JxbjFIaktzQnFjQ01uaCtQSXIwY0Y4cXdPZnlkVFArQUdvTnZW?=
 =?utf-8?B?bWdvUk9XQlVFRTVGQUJNMzEvMi9lZ2tZR05Gc0g1QU9sby84L2Q4MUh2YlRh?=
 =?utf-8?B?NlRUQnpzUlJNWlpkdDduVFFvdi9JN0VVOUhzSTZIR2ZCcUJqVmljYW9xS3Nv?=
 =?utf-8?B?UVdNUDZOblhlS2F4c0N1QVZoNys4dm41enl5Szd5d3UyUCt1MWRkOWpDZGVT?=
 =?utf-8?B?elJncGhpSjRrNkFHWC84bFRjM2h5cit1WjdlN3FYUFB1Z0VVUlF3SnU5MlpC?=
 =?utf-8?B?Y1dvMWN0K1dKQytIYWpPcngvNEdvYUdWL2ZxYnZTeHZqS1N5OHJEWlpzaHBy?=
 =?utf-8?B?Yy9KMm9uSFBMZGpyVThzaU1xMHlYOFdCWktBNlFTYjZ3d2drR1pxYmxIcTRh?=
 =?utf-8?B?alJxdVJUVDhmQmwzdnhycmw4bVdWekdNSkx2YVV6MHJBMDNxKzJ5VnN6TkpE?=
 =?utf-8?B?TnpVM05GRXhzY1FnWldObDJxMUx5T3JrZkNaNkkvS1lBaC9nSzlaZTFLc3JQ?=
 =?utf-8?B?YnlTemZDcmZVUFVjYlBOR0pqcWNYc3hwdW8vUVlZaWVHdURVN3N2clpOTm1k?=
 =?utf-8?B?b091SHZ3dHVnbndla1hrS2x0NnFzcGVCWlJNaWVLWHNwRzhnY0N5RmhsVmlZ?=
 =?utf-8?B?SzZhMFgzK0doV1VxeUFnZHdSVVI1bWR5SWthVENuZXV5citDWWtQRklEak1x?=
 =?utf-8?B?TmVvcWlVY3BwOVZ6V2dJZ25oM3FUQTNWWXJycFNVZUtaNzJwNTV3S3lvTHQw?=
 =?utf-8?B?VldRdVVsbFlieGkraGdZakVBMFh5WVhUUVRBTHpZcWhoaWxEL3hHZTFpdEl1?=
 =?utf-8?B?WlZsa0xHN2FndURxMmppNzZiK29ocUcyRVN6ZTV3NTJMMlpVTDErM0RVV1JJ?=
 =?utf-8?B?ejJvaGdFZU9TbG5kTENLaEo1Nm9XdGFQODZVbjFsaHFpeG1DRVdrUzBiYmgv?=
 =?utf-8?Q?AI0dI7zoynuWC3OeEK/1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: cbfba189-6448-4910-1d5d-08dd4b38d23b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 07:42:37.3398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8206

SGkgTWlrZQoKPiBJIGRvdWJ0IGFueSBvcHRpbWl6YXRpb24gZm9yIG1lbWJsb2NrX2FkZF9yYW5n
ZSgpIHdpbGwgcmVhbGx5IGltcHJvdmUgYm9vdAo+IHRpbWUgYW5kIGV2ZW4gcHJvZHVjZSBhIG1l
YXN1cmFibGUgc3BlZWQgdXAuCj7CoAo+IFdpdGggYWxsIHRoZSBmcmFnaWxpdHkgYW5kIHBvdGVu
dGlhbCBvZiBicmVha2FnZSwgSSBkb24ndCB0aGluayBpdCdzCj4gd29ydGh3aGlsZSB0byBhdHRl
bXB0IG9wdGltaXphdGlvbnMgdGhlcmUuCgpJIGFwcHJlY2lhdGUgeW91ciBwcmV2aW91cyBmZWVk
YmFjayBhbmQsIGFzIHlvdSBzdWdnZXN0ZWQsIEkgaW5pdGlhbGx5IGFncmVlZCB0aGF0IG9wdGlt
aXppbmcgbWVtYmxvY2tfYWRkX3JhbmdlKCkgbWlnaHQgbm90IGhhdmUgYSBzaWduaWZpY2FudCBp
bXBhY3Qgb24gYm9vdCB0aW1lLiBIb3dldmVyLCBhZnRlciBjb25kdWN0aW5nIHNvbWUgYmVuY2ht
YXJrcywgSSBmb3VuZCB0aGF0IHRoZSBvcHRpbWl6ZWQgdmVyc2lvbiBydW5zIGFwcHJveGltYXRl
bHkgNSBtaWxsaXNlY29uZHMgZmFzdGVyIGNvbXBhcmVkIHRvIHRoZSBjdXJyZW50IGltcGxlbWVu
dGF0aW9uLgoKSeKAmW0gdW5zdXJlIHdoZXRoZXIgYSA1bXMgZGlmZmVyZW5jZSBpcyBtZWFuaW5n
ZnVsIGluIHRoZSBlYXJseSBib290IHN0YWdlLCB3aGljaCBpcyB3aHkgSSB3YW50ZWQgdG8gcmVh
Y2ggb3V0IGFuZCBkaXNjdXNzIGl0IHdpdGggeW91LiBJZiB0aGlzIGxldmVsIG9mIGltcHJvdmVt
ZW50IGlzIGNvbnNpZGVyZWQgYmVuZWZpY2lhbCwgSSBhbSB3aWxsaW5nIHRvIGV4dGVuZCBteSB0
ZXN0aW5nIHRvIHZhcmlvdXMgcGh5c2ljYWwgZGV2aWNlcyB0byBlbnN1cmUgdGhhdCB0aGUgb3B0
aW1pemF0aW9uIHdvcmtzIGNvcnJlY3RseSBhY3Jvc3MgZGlmZmVyZW50IGFyY2hpdGVjdHVyZXMu
CgpBbHNvLCBJ4oCZZCBsaWtlIHRvIHNoYXJlIHRoYXQgdGhpcyBpcyBteSBmaXJzdCB0aW1lIG1v
ZGlmeWluZyB0aGUgTGludXgga2VybmVsLCBhbmQgSSBmZWVsIGEgZ3JlYXQgc2Vuc2Ugb2YgYWNj
b21wbGlzaG1lbnQgZnJvbSB0aGlzIGV4cGVyaWVuY2UuIEkgcmVhbGx5IGFwcHJlY2lhdGUgdGhl
IG9wcG9ydHVuaXR5IHRvIGxlYXJuIGZyb20gdGhpcyBwcm9jZXNzIGFuZCBmcm9tIHRoZSBpbnNp
Z2h0cyBzaGFyZWQgYnkgZXhwZXJpZW5jZWQgZGV2ZWxvcGVycyBsaWtlIHlvdS4KClRoaXMgY291
bGQgYmUgYSBsb25nLXRlcm0gZWZmb3J0LCBhbmQgSeKAmWQgbG92ZSB0byBoZWFyIHlvdXIgdGhv
dWdodHMgb24gd2hldGhlciBpdOKAmXMgd29ydGggcHVyc3VpbmcgZnVydGhlci4KCkxvb2tpbmcg
Zm9yd2FyZCB0byB5b3VyIGluc2lnaHRzIQoKQmVzdCByZWdhcmRzLApTdGVwaGVuCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KRnJvbTrCoE1pa2UgUmFwb3BvcnQgPHJw
cHRAa2VybmVsLm9yZz4KU2VudDrCoFN1bmRheSwgRmVicnVhcnkgOSwgMjAyNSAyMTo1MwpUbzrC
oFN0ZXBoZW4gRXRhIFpob3UgPHN0ZXBoZW4uZXRhLnpob3VAb3V0bG9vay5jb20+CkNjOsKgYWtw
bUBsaW51eC1mb3VuZGF0aW9uLm9yZyA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz47IGxpbnV4
LW1tQGt2YWNrLm9yZyA8bGludXgtbW1Aa3ZhY2sub3JnPjsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZyA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4KU3ViamVjdDrCoFJlOiDlm57l
pI06IFtQQVRDSF0gbW06IG9wdGltaXplIG1lbWJsb2NrX2FkZF9yYW5nZSgpIGZvciBpbXByb3Zl
ZCBwZXJmb3JtYW5jZQrCoApIaSBTdGVwaGVuLAoKUGxlYXNlIGRvbid0IHRvcCBwb3N0IG9uIExp
bnV4IGtlcm5lbCBtYWlsaW5nIGxpc3QuCgpPbiBGcmksIEZlYiAwNywgMjAyNSBhdCAwNDowMzoz
MVBNICswMDAwLCBTdGVwaGVuIEV0YSBaaG91IHdyb3RlOgo+IEhpIE1pa2UsCj4KPiBHaXZlbiB0
aGUgY29uY2VybnMgcmFpc2VkLCBJIHdvdWxkIGdyZWF0bHkgYXBwcmVjaWF0ZSB5b3VyIGd1aWRh
bmNlIG9uCj4gd2hldGhlciB5b3UgdGhpbmsgaXQncyB3b3J0aHdoaWxlIGZvciBtZSB0byBjb250
aW51ZSB3aXRoIHRoaXMgYXBwcm9hY2guCj4gU2hvdWxkIEkgcHJvY2VlZCB3aXRoIGZ1cnRoZXIg
cmVmaW5lbWVudHMgYW5kIHRlc3RpbmcsIG9yIHdvdWxkIHlvdQo+IHJlY29tbWVuZCBhIGRpZmZl
cmVudCBkaXJlY3Rpb24gZm9yIG9wdGltaXphdGlvbj8gWW91ciBpbnB1dCB3aWxsIGJlCj4gaW52
YWx1YWJsZSBpbiBlbnN1cmluZyB0aGlzIHBhdGNoIG1lZXRzIGJvdGggcGVyZm9ybWFuY2UgYW5k
IHN0YWJpbGl0eQo+IGdvYWxzLgoKSSBkb3VidCBhbnkgb3B0aW1pemF0aW9uIGZvciBtZW1ibG9j
a19hZGRfcmFuZ2UoKSB3aWxsIHJlYWxseSBpbXByb3ZlIGJvb3QKdGltZSBhbmQgZXZlbiBwcm9k
dWNlIGEgbWVhc3VyYWJsZSBzcGVlZCB1cC4KCldpdGggYWxsIHRoZSBmcmFnaWxpdHkgYW5kIHBv
dGVudGlhbCBvZiBicmVha2FnZSwgSSBkb24ndCB0aGluayBpdCdzCndvcnRod2hpbGUgdG8gYXR0
ZW1wdCBvcHRpbWl6YXRpb25zIHRoZXJlLgrCoAo+IEJlc3QgcmVnYXJkcywgwqAKPiBTdGVwaGVu
Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IOWPkeS7tuS6ujrC
oE1pa2UgUmFwb3BvcnQgPHJwcHRAa2VybmVsLm9yZz4KPiDlj5HpgIHml7bpl7Q6wqAyMDI15bm0
MuaciDfml6UgMjI6NTgKPiDmlLbku7bkuro6wqBTdGVwaGVuIEV0YSBaaG91IDxzdGVwaGVuLmV0
YS56aG91QG91dGxvb2suY29tPgo+IOaKhOmAgTrCoGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmcg
PGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+OyBsaW51eC1tbUBrdmFjay5vcmcgPGxpbnV4LW1t
QGt2YWNrLm9yZz47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc+Cj4g5Li76aKYOsKgUmU6IFtQQVRDSF0gbW06IG9wdGltaXplIG1lbWJs
b2NrX2FkZF9yYW5nZSgpIGZvciBpbXByb3ZlZCBwZXJmb3JtYW5jZQo+IMKgCj4gSGkgU3RlcGhl
biwKPgo+IE9uIFdlZCwgRmViIDA1LCAyMDI1IGF0IDA1OjU1OjUwQU0gKzAwMDAsIFN0ZXBoZW4g
RXRhIFpob3Ugd3JvdGU6Cj4gPiBIaSBNaWtlIFJhcG9wb3J044CBQW5kcmV3IE1vcnRvbgo+Cj4g
PiBJIGhhdmUgcmVjZW50bHkgYmVlbiByZXNlYXJjaGluZyB0aGUgbW0gc3Vic3lzdGVtIG9mIHRo
ZSBMaW51eCBrZXJuZWwsCj4gPiBhbmQgSSBjYW1lIGFjcm9zcyB0aGUgbWVtYmxvY2tfYWRkX3Jh
bmdlIGZ1bmN0aW9uLCB3aGljaCBwaXF1ZWQgbXkKPiA+IGludGVyZXN0LiBJIGZvdW5kIHRoZSBp
bXBsZW1lbnRhdGlvbiBhcHByb2FjaCBxdWl0ZSBpbnRlcmVzdGluZywgc28gSQo+ID4gYW5hbHl6
ZWQgaXQgYW5kIGlkZW50aWZpZWQgc29tZSBhcmVhcyBmb3Igb3B0aW1pemF0aW9uLiBTdGFydGlu
ZyB3aXRoCj4gPiB0aGlzIHBhcnQgb2YgdGhlIGNvZGU6Cj4gPgo+ID4gaWYgKHR5cGUtPmNudCAq
IDIgKyAxIDw9IHR5cGUtPm1heCkKPiA+IMKgIMKgIMKg4oCCaW5zZXJ0ID0gdHJ1ZTsKPiA+IFRo
ZSBpZGVhIGhlcmUgaXMgZ29vZCwgYnV0IGl0IGhhcyBhIGNlcnRhaW4gZmxhdy4gVGhlIGNvbmRp
dGlvbiBpcyByYXRoZXIKPiA+IHJlc3RyaWN0aXZlLCBhbmQgaXQgY2Fubm90IGJlIGV4ZWN1dGVk
IGluaXRpYWxseS4gTW9yZW92ZXIsIGl0IGlzIG9ubHkKPiA+IHZhbGlkIHdoZW4gdGhlIHJlbWFp
bmluZyBzcGFjZSBpcyAoMi8xKSArIDEuIElmIHRoZXJlIGlzIGVub3VnaCBtZW1vcnksCj4gPiBi
dXQgaXQgZG9lcyBub3Qgc2F0aXNmeSAoMi8xKSArIDEsIHRoZSBpbnNlcnRpb24gb3BlcmF0aW9u
IHN0aWxsIG5lZWRzIHRvCj4gPiBiZSBwZXJmb3JtZWQgdHdpY2UuCj4KPiBUaGUgY29kZSBpbiBt
ZW1ibG9ja19hZGRfcmFuZ2UoKSBpcyB2ZXJ5IGZyYWdpbGUsIGFuZCBtYW55IGF0dGVtcHRzIHRv
Cj4gcmVtb3ZlIHRoZSBzZWNvbmQgcGFzcyB0aGF0IGxvb2tlZCBjb3JyZWN0IGF0IHRoZSBmaXJz
dCBnbGFuY2UgZmFpbGVkIGZvcgo+IHNvbWUgY29ybmVyIGNhc2UuCj4KPiBVbmZvcnR1bmF0ZWx5
LCBpdCdzIGltcG9zc2libGUgdG8gY2FwdHVyZSBhbGwgcG9zc2libGUgbWVtb3J5Cj4gY29uZmln
dXJhdGlvbnMgYW5kIHJlc2VydmF0aW9ucyBpbiB0aGUgbWVtYmxvY2sgdGVzdCBzdWl0ZSwgc28g
ZXZlbiBpdCBpdAo+IHBhc3NlcywgdGhlcmUgaXMgYSBjaGFuY2UgdGhlIGtlcm5lbCB3aWxsIGZh
aWwgdG8gYm9vdCBvbiBhbiBhY3R1YWwgSFcuCj4gwqAKPiA+IC0gQmVmb3JlIHRoZSBwYXRjaDoK
PiA+IMKgIC0gQXZlcmFnZTogMS4yMiUKPiA+IMKgIC0gTWF4OiAxLjYzJSwgTWluOiAwLjkzJQo+
ID4KPiA+IC0gQWZ0ZXIgdGhlIHBhdGNoOgo+ID4gwqAgLSBBdmVyYWdlOiAwLjY5JQo+ID4gwqAg
LSBNYXg6IDAuOTQlLCBNaW46IDAuNTAlCj4gPgo+Cj4gVGhlc2UgbnVtYmVycyBkbyBub3QgcmVw
cmVzZW50IHdoYXQncyBhY3R1YWxseSBpbnRlcmVzdGluZzogdGhlIGJvb3QgdGltZQo+IHNwZWVk
dXAuCj4KPiAtLQo+IFNpbmNlcmVseSB5b3VycywKPiBNaWtlLgoKLS0KU2luY2VyZWx5IHlvdXJz
LApNaWtlLg==

