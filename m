Return-Path: <linux-kernel+bounces-201057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2231F8FB8C0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB632895C2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE4F148310;
	Tue,  4 Jun 2024 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="o7fq6v/W"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842DC26AF1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717518076; cv=fail; b=DvW1iK2uwrVu6op6CdXA3UY/vF6m3WNizHoKT/zPmQRHv8FbHUX4XgpsnLFHzxzjrWyI0+1IZJL4So376L8OUx1JxzmwihLsyMW3L8HsTQ7z/ojmwHf74aAcPMAKKTe9MUvfhm8TA/HPFyoGOYrAjzIrqdRQq/bPCIoCRmceUw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717518076; c=relaxed/simple;
	bh=Hs8TO0ECXJIIp8YMOUq1gWLRmB1/0fb/1IFLFfmLeMg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LbPG5lsRZbZeBRNRHVZBl3AYW8vPOr1dHLQoH6TL5wESrZapeiBafoUExyKOItZIa0O1gEf1E/f4BRm7WrdlF5z47J7Xzp3O4gQs/nCR6js/wH//GRknEwPh8bVj1+FB6CMS0hvz3oBMrl4KtVy7qV2Q1i9Ugqpc0wVUge2Rkrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=o7fq6v/W; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4549Ajc1030226;
	Tue, 4 Jun 2024 09:21:10 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yj02n1taj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 09:21:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2SA1h37dWsGYIffI25OHPoJMQdK+fv0hyLM4h4Pak/FgMWL20Ie9FzVsuF50hcm1Gh47+SvW5ErTqtSIhLLk4DeVj2iRk+rRLMvCBQCfJ8Rr3jeyPZ3TXX21o6bMog7fEMIl7tIDYRF8+1O43ODDXgHTpe1QjY3t6awgibvngkY5ttFLZHz8x4FWwB2ka5ntIFQnHpjekwl8AoE+iUBa4RaFHRwM/uAr+zPkIVeVjTUuJrYVoquhql+K79y6ITm1z/dsfXdzT9QNl6w18NiDWI397Ty0cqIVTJhMsrStO8ypauzKXH7I+iM+7wf7f93Wa7K6lDde2ySm39L0CRMHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRRfyHcr4sNcTpY6xCEsQWMnXDd7ATER0TVcLZcS8Q8=;
 b=Wd7k41o38LuYPdl/GCFFrk2o8kwZxf24rNkmAQo4m4RWrxpuTAF5tx9siaTtErP/C7ihwG56etIYKxbqlfqakCB4RNRg1q9PFmB3uvk4c2IlOl6smT5NiUN85AWiTj45OwbkLWoZ+P8DWW9aFUhgtUKx1avIlGWa9BqagJ6vikTa+eUeausABdQBunlc29QYbMoWKu9+EMVO2Yha7T6gT9DtfvKa7nqqGz+vOW+PAY45a48+YN27MiHY4ZMMcfQMOkx0Wc4Eztb9+JGOFah7MoKBgx0SLkYzvH0/gfsYB0Lhk/2t3Ll39fVVNapIGi6BSP1DZXcc0stpxOOWc+TsYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRRfyHcr4sNcTpY6xCEsQWMnXDd7ATER0TVcLZcS8Q8=;
 b=o7fq6v/WF4ty5pFroRgofY9amhJ8/2AQhRv5uXdQVE7bYfH8aSgIr++8QG02AFkekkS0cYZ3mMEkdygIZxfwy2I3dRUwc6EtmTMyyn1uWfjAJsm+ql6dEs7/10qcxKIScINc+2tBv2wO8Dz1jlXzhOaGby+dJ3cbMg8qREEhu/8=
Received: from SJ0PR18MB5246.namprd18.prod.outlook.com (2603:10b6:a03:443::6)
 by BY3PR18MB4738.namprd18.prod.outlook.com (2603:10b6:a03:3c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Tue, 4 Jun
 2024 16:21:07 +0000
Received: from SJ0PR18MB5246.namprd18.prod.outlook.com
 ([fe80::5a7c:1cb2:fcc8:8966]) by SJ0PR18MB5246.namprd18.prod.outlook.com
 ([fe80::5a7c:1cb2:fcc8:8966%5]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 16:21:07 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Jerin Jacob <jerinj@marvell.com>, Srujana Challa <schalla@marvell.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v7 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Topic: [EXTERNAL] Re: [PATCH v7 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Index: AQHaqqXUeJduCBvv+0e3+QVunpJsgbG32TAAgAAF9zA=
Date: Tue, 4 Jun 2024 16:21:07 +0000
Message-ID: 
 <SJ0PR18MB52462AA2A9F15103D5198CC5A6F82@SJ0PR18MB5246.namprd18.prod.outlook.com>
References: <2024042950-refurbish-duckbill-77b4@gregkh>
 <20240520110630.2568767-1-vattunuru@marvell.com>
 <2024060412-amulet-unflawed-f37a@gregkh>
In-Reply-To: <2024060412-amulet-unflawed-f37a@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5246:EE_|BY3PR18MB4738:EE_
x-ms-office365-filtering-correlation-id: 6eab1b7f-0344-41c8-acf8-08dc84b256a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?SOQbWRerQc6rVPnZuFzdtkGcoj9uKfQhRyCgWiHnWpoNZnFJrgpQ9uYFRsi0?=
 =?us-ascii?Q?86/h8KX7z75uYPZ3fROLHlp9n+FoeL9FlcAoWcCU2QVjZNsgYoYmpvpVSwYn?=
 =?us-ascii?Q?xexLxbANji8tG1bNVtpK+1ojwhjwKkGqrzzn5T8kA5RLgWC6C+eRBTlrp6FK?=
 =?us-ascii?Q?Z+AmjmJF2jwXZDCalrRMyYfTVzhS1vznLrwv6B+CL2jf5KnOZFN7qVY/y3oe?=
 =?us-ascii?Q?4M/Rf1iHkbVxlC3AMG1wQp+CrXe48a9v9OL9D0z2swmVX2AKYcuTCD1ElJnu?=
 =?us-ascii?Q?dtkFYmS6R+0ZwI1LbSykoZH/PCogysZYn3d6O4AUC+S3NkwFnEkghCiRO8Hh?=
 =?us-ascii?Q?rGqkdFDXNc2r/niyIiZ+pDwLCfl/VLfNXZXBtpnYrMTZMo2RJjmyYLMee0/r?=
 =?us-ascii?Q?rb9iC3jUMCLwaiL78AH+znOGkP+jI8hyO2vWfPvZHlNc/C6c27+L8BPOBBaL?=
 =?us-ascii?Q?1A40qJoHrFvywdwIta9SiN3AK+3usSYfzOa0VX6XCYFCguhNtbCgkPjkTrj8?=
 =?us-ascii?Q?To8acrvzlG0tukxYjIkxsqAtcgiqopCOD0XgdwPC+SQQPBOBUXsS49xQAxec?=
 =?us-ascii?Q?ow2P0lfhtmKSB34jH2hg62zhCbzUnGSeYmUHo/i6oyfDs5WMhn1mVn4Xojql?=
 =?us-ascii?Q?A9hjrHjt0tcDqaN1fM/tmkrvNQM7hwKrpyKqzyhafztdJwgWDAwSY4ES/7Oo?=
 =?us-ascii?Q?GUJWYybYwmatE+D21TfrwNUUJ5crWkyxJ6/Cj9ZjteOAtCE/pXbV3aOyihUf?=
 =?us-ascii?Q?sVATeHPb69MtrIbpNoICPRLVkUcVHaH/amNbLkOiYi8GElGM4dSZBMgdmFgs?=
 =?us-ascii?Q?C57Mypuu47PtTAfxnsQCWRrzTIhGT1F9TWrP9n1tPyMiEhk5xQOoDx+d+Z+K?=
 =?us-ascii?Q?D14g7IdJK8cEhGx7NyYS35fvaiRb2dxvXoWYMNbryUQU1Ecig41ec+yBNDfu?=
 =?us-ascii?Q?2z71EeJzqNzogCx6EWOPZbsMsmu8O1ZepL30QVICTQDZsc5a1BwtKvansRf9?=
 =?us-ascii?Q?qfN/0ulpX80As8xfURQduJhsz/0KQs2YPosMLwWjvOOGRjqHKcj7Lu2cgGX6?=
 =?us-ascii?Q?gYDvOrpvJ+p99j7IcBKkx73nC8ggNy4c3+UG2lOuTpSv1kpjl1MZ4tiuKMoP?=
 =?us-ascii?Q?4sRbqPSFSGrkWrpR5GqUvBPXzTiElv0ccn36bzfCj5MJ23Yh2AxBrtULnqSo?=
 =?us-ascii?Q?Q2ng1qVR0aPZyk4McRQym53pPGHra3QfUnyOxq8Aqzw8nlvMiBMp1JY92fc7?=
 =?us-ascii?Q?3Go32tpBCfNvokodEm3WyueNjz8Rtykj+Q3fTqXSxVnFOHlXslGyLh2PPoBl?=
 =?us-ascii?Q?KUcmOZlBWn53ghRqiE5nu1tp0mNJlgy3fdDVMRprgCPRNrHI55x+o1GdIblx?=
 =?us-ascii?Q?88R93Yw=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5246.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?j2ncDo7tR3mTSPawS5bt8TAcUOGUQArM+YS18R1zo1r21wNdBUwi8/QqGBMQ?=
 =?us-ascii?Q?Q5o1sbXOcFH0QwhrxRVVV4EDph11wHVMH1w1KIidPmv/jncwkEtSMD9VWA7A?=
 =?us-ascii?Q?irp6fXhKoX3btHlgqwQc1PW7L2KUoYUkqS5WVRY3wNzUg9iWjsuECdewfkQ+?=
 =?us-ascii?Q?Vq4/ka2M/kCAKuoGgFOBxWojq1wXf9kFp57oTNoQmNQP6nwARzxX5P0olt4e?=
 =?us-ascii?Q?UwTXHFnFKb8eR5El3N00kAEntFMI04HinbPDpOFoFjtizw24Oyl1g9TlccrZ?=
 =?us-ascii?Q?NpEV19f2K5qxrp9d34mk1FjiHfRA/KF+J0DkTU3xjJpPiDfGYHxJ8LzigCwJ?=
 =?us-ascii?Q?QL34N0kRsGNZJVzj3bNbjMyfxIHmEUAPSMRbY7EpZZvb4dFsOANx5RLowoDr?=
 =?us-ascii?Q?AQPbtEmdUmbDOA2q9wPP7ailu0VM3hZ84ceX4zAJMmYFLe5EEpJyhriiBnLX?=
 =?us-ascii?Q?+Wkx775TCCvSFTFDRMjigmTwyXJFnyIMSI5hE+PaGa4XKk/W/Vbq+Valc/sR?=
 =?us-ascii?Q?uY8PhTkG38BrievhbZwXIt4tQJ77w1wV51d/4bnUnGhh4cybBOpd1MJpiHJP?=
 =?us-ascii?Q?hggt0hQzfEaHUC1p8N89hTMvHWl5XnjrjkBc6PsXogT5430HClz6X4x5Rt88?=
 =?us-ascii?Q?GMNWRr694xSlIKPjpNJoGgNkRG0lZN2YaFz4vP4o2Mnam9wl8kdLGEUsBC7d?=
 =?us-ascii?Q?qhfYTaR+zJ9wbXeJ6FF8ziwCrjz8t7kCpaPJHotqR9/2vdRbsNTP6PEpiwbx?=
 =?us-ascii?Q?+r+awV9a8TdvJwDpDy45f+5tKFeW1JEO8IYGjULQU4rUahiM6K4e9bd5Bzmf?=
 =?us-ascii?Q?VxfI6sr6eN5VPfqP2WY5cXY/eMeGVsOHdVi251zxiNiYSdpzZGvfh+ljFrNV?=
 =?us-ascii?Q?M3on1cq7lUYlSUday1iEUVEYo4WPHqHEiqvS/7/4TnnAGFTjoTcS7fQMArEM?=
 =?us-ascii?Q?gkzrTTW/JoWO0bMSENPkYhYFNqWJnTNi917YQjEgIslsGPTI0WX3GsLiM5wM?=
 =?us-ascii?Q?fs4SywvpTyOZtb9+D7SLG4KSJNKEJ3ALpFtAeDxpPz9WgGFYS214pJdlMfVv?=
 =?us-ascii?Q?9cJS86OdgO0pXgEXWOgqjW8zk7z0gcwv09d+agwjvFAPcqWAVPH3bcXZ68LT?=
 =?us-ascii?Q?s1gfUcBiPedvz2mtFqAM8PlMbFh7lQ2HvXh2aq+XzNps33InKyEcjnLE3ztV?=
 =?us-ascii?Q?yAKjmOx429GKnFyAyKRn1pqfy7Ld+lvcxNwJP0qHvNFAtgl3NRXMtxcJbGKO?=
 =?us-ascii?Q?4yJFhoy/3KeP999ic/uekBVOH98fvXZrek7o51F3p/JHMJTSbN3Lbz3ktCXF?=
 =?us-ascii?Q?iBgnGxRDapAZ4iISeDgkQ6vMh8o/6wrUvcUudY96wr/sPbTeTv8xx+5e9rSP?=
 =?us-ascii?Q?75aZHzMh6dG+OcWHjTxgI6G7k463n6VeImxmTI2+Rg1nGjjr5kJcPTvDPeev?=
 =?us-ascii?Q?qPIhTux+M4O3lZjhbiG0I5MFo0JeJ2vWD83b3oukxsPS/FXdlOwVcs8x/j8j?=
 =?us-ascii?Q?DoB+3SUpNQaNiYQC4qL2V7L1++KgjaYTrUn3MdU7YnK4M0bEDpbR/7XO2Fd3?=
 =?us-ascii?Q?E2HOIwo7e8OEPOOncq4TSY4kfmZOPPMveR52PUFM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5246.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eab1b7f-0344-41c8-acf8-08dc84b256a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 16:21:07.1569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bgv1v5/E7AukeFPbLUE/zj9T/ErQRhVU7b8YG+3XLEIPnTSOvyN53206KkgPhM9lQSAHCNtDAAqnFHBtO2wu8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR18MB4738
X-Proofpoint-GUID: _dKFahet5bgBl8r66yaghfRrmNXWYtzC
X-Proofpoint-ORIG-GUID: _dKFahet5bgBl8r66yaghfRrmNXWYtzC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, June 4, 2024 9:23 PM
> To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
> Cc: Jerin Jacob <jerinj@marvell.com>; Srujana Challa <schalla@marvell.com=
>;
> arnd@arndb.de; linux-kernel@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH v7 1/1] misc: mrvl-cn10k-dpi: add Octeon
> CN10K DPI administrative driver
>=20
> Prioritize security for external emails: Confirm sender and content safet=
y
> before clicking links or opening attachments
>=20
> ----------------------------------------------------------------------
> On Mon, May 20, 2024 at 04:06:30AM -0700, Vamsi Attunuru wrote:
> > +union dpi_mbox_message {
> > +	u64 word[2];
> > +	struct {
> > +#if defined(__BIG_ENDIAN_BITFIELD)
> > +		/* SSO PF function */
> > +		u64 sso_pf_func  :16;
> > +		/* Aura of the command buffer */
> > +		u64 aura         :20;
> > +		/* Command buffer size in 8-byte words */
> > +		u64 csize        :16;
> > +		/* Command code */
> > +		u64 cmd          :4;
> > +		/* VF ID to configure */
> > +		u64 vfid         :8;
> > +		/* Reserved for future use */
> > +		u64 rsvd_85_127  :40;
> > +		/* Work queue completion status byte offset */
> > +		u64 wqecsoff     :7;
> > +		/* Work queue completion status enable */
> > +		u64 wqecs        :1;
> > +		/* NPA PF function */
> > +		u64 npa_pf_func  :16;
> > +#else
> > +		/* VF ID to configure */
> > +		u64 vfid         :8;
> > +		/* Command code */
> > +		u64 cmd          :4;
> > +		/* Command buffer size in 8-byte words */
> > +		u64 csize        :16;
> > +		/* Aura of the command buffer */
> > +		u64 aura         :20;
> > +		/* SSO PF function */
> > +		u64 sso_pf_func  :16;
> > +		/* NPA PF function */
> > +		u64 npa_pf_func  :16;
> > +		/* Work queue completion status enable */
> > +		u64 wqecs        :1;
> > +		/* Work queue completion status byte offset */
> > +		u64 wqecsoff     :7;
> > +		/* Reserved for future use */
> > +		u64 rsvd_85_127  :40;
> > +#endif
> > +	};
> > +};
>=20
> The ifdef is cute, but not correct, sorry.  Please use bit shifts to hand=
le this
> properly without any #ifdef needed at all.
>=20
Ack, will fix it next version. Thanks for the suggestion.

>=20
>=20
>=20
> > +
> > +static inline void dpi_reg_write(struct dpipf *dpi, u64 offset, u64
> > +val) {
> > +	writeq(val, dpi->reg_base + offset);
>=20
> No read needed after a write to ensure the write made it to the hardware
> properly?

Yes, as it's an onboard PCIe device, writes will happen properly. I will mo=
dify it as write followed by
a write barrier to avoid any reordering.

Thanks
Vamsi
>=20
> thanks,
>=20
> greg k-h

