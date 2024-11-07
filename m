Return-Path: <linux-kernel+bounces-400819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6347C9C12C5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867EC1C224B1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924211F4723;
	Thu,  7 Nov 2024 23:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Vi1i+x3l";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="I0Wsvbh+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Sdoz/gD9"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40429198E99;
	Thu,  7 Nov 2024 23:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731023553; cv=fail; b=OV/RpFi90j+RtsENdQQR+N+r/umHzR0ZdNGsjdbQVwnoIRxgh163oAHLZKL1JFSZ9kf9ipNFub7ohGhf6lpr9Zi7j2KEZrv8yIRhMzLlqcGZyDISbG7yCb3OT1jlyPnXr2YBjhFsxeXf4HaIJCyuzAifFTR17kuKCVthM6PpkA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731023553; c=relaxed/simple;
	bh=R75sKh8VPgdIS7+D7u1E4JSzsbevNf0hXhOkI5NLa8g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jl0n8AGkhVZd+qSjPDueJ5lXalvi/0hfh78YsL0VTcggDvFnhTA9Cvff5cps1zzQoiVkibx5PlrNVncz5UZ/hxUC5by0FYT9KRRgtDiQ7Kj7T0dUUNhXdC5mkHg8M4S92psvV1b0i1pXAMFPg4eEvdBjstXqk9GXJL9O1EDCNn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Vi1i+x3l; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=I0Wsvbh+; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Sdoz/gD9 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7MbGTG025334;
	Thu, 7 Nov 2024 15:51:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=R75sKh8VPgdIS7+D7u1E4JSzsbevNf0hXhOkI5NLa8g=; b=
	Vi1i+x3lWsEh1GD2sL3HTGpHBbca8KdJ84wV4bZOzyqPCWBQ+KQi0CTcvpO4g+FB
	nBDEM1WpFHcmoJ9bin3B4GK2c8S4etL78d5PIyLYvnRlz9T20zzuehX3JqaGkc6s
	MdwVaPbTz15RBXywIsstoJAxQ73qZTZy369kJEy5tsWGupLb8MyfF1/5PNaVM+P4
	ona6ELSlal2cqdggXqUkfuKP4L4E0pMeZdOYKo7l28wzeW3xtGBOy1dl5N3wjC+0
	P3/rjccOAKucFLV9/wycrgwbWDcu5IY33UC/arO9uXoLYod2C76yo7kdbpZxoDXd
	QoydyVNU6umZ86vwvlRFMA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 42s6gnrafk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 15:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1731023498; bh=R75sKh8VPgdIS7+D7u1E4JSzsbevNf0hXhOkI5NLa8g=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=I0Wsvbh+WQvVABuztl18SZOgxXst4mtC4TbGZkpyjclcX6VKLyngOR6sJOLS9RejP
	 uASjDBod4Kufr4DDXB2Wk6g64XM7nxMtmS+xXk1Jm91uE9v4oAh/lDVmBmqlX8E5cR
	 a7sLruMF5mzlX+nFEulNUkKCxY5YtyIEaOk2RkWRTSH71MzFFCRYOeN7shiNidOqwy
	 yyQo4OV9EXEbjjmM1kP1wmsZDaOUWZC2t2/AXz5/NoKqRKSmALs9hsaJgimnOEW8hA
	 TIXSSuZZwyfgEPbZDKxIl0kh+vpgp0E9y2qnT1tv0DfrYsCl6Jdfu+K8+Nn7FkcgHP
	 ferKa9Uc6ytXw==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3BE69401C3;
	Thu,  7 Nov 2024 23:51:36 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 69F47A008A;
	Thu,  7 Nov 2024 23:51:35 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Sdoz/gD9;
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id F37BE401CD;
	Thu,  7 Nov 2024 23:51:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLyNKFyI9wLBjdmGjr9oSUS8p4Xu31DPgYQ13vyT2N2R9bgy8a8Rp+jfN2p1fOfmLlJLNew3siZttbjkYJIED/juEgbAz07/t8S+7mw/Qw1eP2H1Ym+qAbZe/StSFhaWj2Tf3eU/PKdId0TJMQtF3z8ry5Eoor0C3SPUfGJ5ysLg7tFFxNtZYlUW9hA1e/HdlNeeoaDb8b++6FBoQysHY63//Yj9Jk9+4SbFdx7qeOpjcX6K5tV8hENPo5vsyfSh348FwUpuZYdWMwEqPTZK8mwzgszmkd15nsgtbLXG63qDFSAn2L4JrhQtTHachE6p0yWjrmDR577NnSrRdWBytQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R75sKh8VPgdIS7+D7u1E4JSzsbevNf0hXhOkI5NLa8g=;
 b=lmX7Hfaj7nxKNMLonP2ZU969vNUwUAMTW+nhyzRyIcFmW6v2E0oC6Wsafbnn8gXPM8yeiwUg2ON1O5fcFmN0EHhCMUpsJFqfxgpUviuDpH90ljZk0C46toDFDx6NjUJpNEE1g3gJqF3jqEDpwH/kcphm1wfgDcjeu6M75jCU6Uewg6tbldXs3PbHQUXGzJAz6pzNLkkKWhKG2kfwgWLGLCT9KRATNHe2ffYHNGO5S5NRkSCrkUFJOvNIsYUF35M0kfms3W02YQPpG4SL7j8NnqSZ5i4qcoKDcImHlqspVuk7XtcPPQy4lhKNS+z3dOYgwMc6bWjI2w7SMFykGiHgHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R75sKh8VPgdIS7+D7u1E4JSzsbevNf0hXhOkI5NLa8g=;
 b=Sdoz/gD96x4nB1tyBcH8xnoh33v/k5bMTtjNvqYv3wweQJ+l+D2uOA8O5xkeXhvSyPEvRjvnTwgFPHI1I39BKGoNTvHQWqB8PwRky80IKB4St9kN+u7eQCMtsPCdMqSwfKDmyesbACPmP/7zz65Jrc+hZMJTeji9nETlSECAd3o=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MW4PR12MB7437.namprd12.prod.outlook.com (2603:10b6:303:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 23:51:29 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 23:51:28 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Guan-Yu Lin <guanyulin@google.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "kekrby@gmail.com" <kekrby@gmail.com>,
        "oneukum@suse.com" <oneukum@suse.com>,
        "yajun.deng@linux.dev" <yajun.deng@linux.dev>,
        "niko.mauno@vaisala.com" <niko.mauno@vaisala.com>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "tj@kernel.org" <tj@kernel.org>,
        "stanley_chang@realtek.com" <stanley_chang@realtek.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
        "ricardo@marliere.net" <ricardo@marliere.net>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 0/5] Support system sleep with offloaded usb transfers
Thread-Topic: [PATCH v6 0/5] Support system sleep with offloaded usb transfers
Thread-Index: AQHbMCbRNkihBlwomEiG+YhoXO400bKsf5aA
Date: Thu, 7 Nov 2024 23:51:28 +0000
Message-ID: <20241107235121.moqnd2r5znidhi35@synopsys.com>
References: <20241106083501.408074-1-guanyulin@google.com>
In-Reply-To: <20241106083501.408074-1-guanyulin@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MW4PR12MB7437:EE_
x-ms-office365-filtering-correlation-id: 5831c2ee-6b9a-4028-ad2b-08dcff871942
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Wm5WTVRaVGhDYmI3OXJydDMzYVp4M1JmV0I1SU11em1RcEtsT29STXpwdzlD?=
 =?utf-8?B?b2V6RGdweWxvdUwrV241d0NEeVJvR1ViUTdKbmxpVzZxbVpIUU1ISFo5QjZq?=
 =?utf-8?B?d0xXUUZSZzErTldrTWRORmpEU0FRQ2R4RHdWbmE1a3VlN2xtekY2WXZaL0pL?=
 =?utf-8?B?d2dsTURKdzA2VndSVmFrQUZFNmtFQ0tJTXN3bzZiY1JZNHhGamhkanQxL1B1?=
 =?utf-8?B?RGx4bzd3Qlk4dytGbWtZQ1hxU2pwRzVYU1REaXpOYUZyTDkxUmlBcnE3Q1Fh?=
 =?utf-8?B?UU11aGs4SStxN2xkbCtucUlPVytxVlJQajFoU0tobTU0aEVzM0hlcWh1MEhu?=
 =?utf-8?B?WUp4L2Rkb2N2aEREa2o1V1BqeUtRSGRrOVJxRk04QUUzNTZ0QjdEM0hVblF2?=
 =?utf-8?B?TlhpS3M0R3llOUZSVUwwQnJwaUZGRmJnem9YYnVtbkRnbjhtQjl3cFRUOHE0?=
 =?utf-8?B?YmRoUEFlMTBzbjEvVW9Ncnl3dWgzQ1dPMzRrSDRORm8wcStrMDEyKzV2MDVT?=
 =?utf-8?B?YmRUU0ttK2FIUlRSLzl6RXl4c0gzYjlXRUh4Zjd5OUF6TGVBdmovZGx1SDlv?=
 =?utf-8?B?Z1hibjViWHNpSHRXVlRWZHUwRGF5clVHYXlJbWdNR094RXhtekRNcEl0MnR5?=
 =?utf-8?B?QWVJZjhjTUtuNnBlUktwdEZVaWRUTDd5b1FETzVYenN2THRhaEQvTStuQ3JQ?=
 =?utf-8?B?eVpzRS9Uek1KaG5SSzR6cjVzdXFIcTIvVlBDUXVZZ1lwa2Z6K0RQUVQrcS9k?=
 =?utf-8?B?Z1hMSThCSmVnekhSbllkaFJKcElVWVMwTnozZkh4SjlZbUVCQmxpTXBZZ3ZW?=
 =?utf-8?B?N1E3alJySDdSNklyUU9zTnhRd0k1cHN5cHpyNHFpOGkvM3oxbW1DeTJ4M3dQ?=
 =?utf-8?B?T2Y1aWl4cnh3eUFFWktYNUZZcXIrZkZ0aWwybWhrQytwQ3JTTnREVXJVT3ZY?=
 =?utf-8?B?dHRiTDRXTjdrYXVQZVJJUXVRT0hrc3dhU2dLNmVveGw5ZnlTSDF0aFpZaVhz?=
 =?utf-8?B?WktQeWpiY2wrOXVrZEphY0E4MGQ4Ly9PandZcGw5cTYxaGkvNlFOUEZIdzNO?=
 =?utf-8?B?Z3ROZ2tuTXhjWlpMaDRTTmxpOFNtQlNVU2lCUFBsbjhQSEdGYkZubk1xQXJE?=
 =?utf-8?B?RlNaRmZqc2lXUmZpYTRKeFpjK0ZjdFE0R2paaU5GZEdaVDRoQS9leGZqTDNL?=
 =?utf-8?B?eUdaNGg4OXdGV1hKbTg0aWwxbnpQV1I0Q2YzQ0hTcmtBbDFmUDNKdU5lSzEw?=
 =?utf-8?B?enV6VTBFYkd0VmJxTXFLU0l6Rk9BcFZJdFlFR3NwbGd1UkE4Y2pvTDN3Snoy?=
 =?utf-8?B?VTcwby9NMlM4YWNQSVc2UDJZeVNEOHlXbTJMckdlVEJRcURlc1BLbTVZN3pj?=
 =?utf-8?B?dnVKMjJ0WXdtZnBJZkdtK215TFRTUzViZGl5NnBMbVNkUzJLMVMwRldIVXBE?=
 =?utf-8?B?bEk3dllidVRBYWJ4QXNiTjdQelJOVmUxMXM4YkZPN2hMK1dxQmMzTW1ESEdP?=
 =?utf-8?B?dlZmUE1YMVFYL0R1cVZYYlJPc1gxZnhZUkpTc1J6ZVcvQjVVcFZXQ2IwV1ZM?=
 =?utf-8?B?b2lXRXIxeEhZamQ0VFZEWXBEV2RnWnJiVW5wUFV3ems5QUYzck03NTNCdWp6?=
 =?utf-8?B?aURNckpmQ1dMbWs0anI1VnR4Vk9nZG13M3psNkV5Y0lib250WGpRNnhYcGN3?=
 =?utf-8?B?Y2ZWUnRXTXFZVG1CdTVYMDR0WUlYRVBxdFB0UkFUYy9wN3pRVHU5NTB2Tm9E?=
 =?utf-8?Q?WsfFfL8paVcekhcI3vzBd+AsnDdcpFlAVLsFhJt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWlXYnF3dFMrOVZvVXVlRnE0SFRmVE1FWjg2bWRaSzVaS0ZrTUpORjlBOXo4?=
 =?utf-8?B?OTgrQVF1Q3YzZUJKY3lmd2FPRFJISTM0RnlmOHk5NmZuWUNQV0h0bjRFSEUx?=
 =?utf-8?B?aHB0RndwVG5NYTI1TXFDcm0xNDdhbVhReGJ2QWdwcUxlS0QzclBwRXNyMkRW?=
 =?utf-8?B?cXFWTEREeVRYV2tVOHFrR1lJY0FvYi9wVStZbmd0b2lUYVJOWnA5ZlNTcjlY?=
 =?utf-8?B?T1dGZFBmTGtTSStFQW40OEdoQ0l5a2lPZ3NrNCs0dzA3U1FFTGxBNjQ3ODNQ?=
 =?utf-8?B?L3lTUE1YVWNiUTdGYjU1NWVNVlVCWjc2MkxvUW5mSC9ZdVlud1VWM2ZpbHZp?=
 =?utf-8?B?K2xqMEtsM3FNT2k0b1UrMnY4TUtDL2FJM2RyTktnMkJpa3U0cXV0WEJndy9B?=
 =?utf-8?B?aDB2d0FTZmpsQ3ZRSDQwV1hId1ZyR2ZxeWh2dFprcDNZSzJ6UStDTXV3ZVNJ?=
 =?utf-8?B?Y0VwQ2Nmb3ZMdHg3T3RyWWVaRWZhS1F1TkhZdVpTWnlCbGErZ2RHOHFkM3hT?=
 =?utf-8?B?WmxLeEJQWkYrNS9PbTFEVFpISE9uclRMNkRVQ1JOVnU5bThsWTQweDFjOVhq?=
 =?utf-8?B?ZnhmRkpEeFp6NlUwYkJvWHA0VU9iYnhTMmdObU1qNGJUcUw1OXdWRVpFbEd2?=
 =?utf-8?B?UENxV0FiV3hGV3Bxems2WU12MjNUOEdCV2JzZ3dVcGJkZXUwdDZwZDk1d1hG?=
 =?utf-8?B?ZXp3eWhuZ0RYK2ZzYnlPeTUzMFhqV3QvZ1phbUpiYzE4RlNLUGpIS2gwV1Vn?=
 =?utf-8?B?REEwcjJ6NDd6M2hIRXhIVTQvWHpFQnk2Y1Q1bFZtak9tckZZb3hrc2Rac0ZT?=
 =?utf-8?B?ZkNsQVhDeUxTS0dUS1lORm1FZXhvZW9MNHdYck40SXJCeVlnMGpTSEdUSWNF?=
 =?utf-8?B?elZNaDZRS0pFbnlETzFZRXl2a3hneFgybklDcDIxcGQ1TUlyRjhGSHlrM3Zp?=
 =?utf-8?B?WHdZTVFNelVDeXkwdldTMWtYVkJrK21jSFRTWFFWdDV2L3d0alhnOUxGcFNU?=
 =?utf-8?B?cGozODV2dzQ0eHlmWm8va29CdXdCeEtYcmNpY0N6ZWFienZlcVZnSEFPdWdQ?=
 =?utf-8?B?d0FzRytyQ1AyNmwvUTBoc3doVXViTlh3amV0eTc1eGVJbERRVExib3ZjL3Bj?=
 =?utf-8?B?K2ZnNjlvaGkwQ2lLUjFqUE1JR2ljbU96SVZSUGwraTVWOU5vakdGQmMrVHNR?=
 =?utf-8?B?c0tqZkRqbFYrbjc0NmJLQzVpRExHUXBRZDBaRTB4bHNuaEdNNER0UEdvVWRs?=
 =?utf-8?B?YzdQbHVnZ1EyQnFSdnd2bG1sUkZqMkNTa3NJT0haNlJZZUNsK2F1Rk1QcXFD?=
 =?utf-8?B?c2pGQmQ4R2t6V0tlMytOdmh6alRGRUNkcDlrclhPVFpaazdnb0RKUkRuS1pC?=
 =?utf-8?B?dzlpR1JiTE9lL0F0VEo3YW1ITk44akd1MkM2RkRRY0dHTUV4eDBrTDdSWUt5?=
 =?utf-8?B?dWtVV2hucHp5d1NudkxHWUxlSTNSTmNiQVMvWmxrVzl6cWtGSktXM0l6Vm9S?=
 =?utf-8?B?NU5udjFNMGhzaWFWT09pbXVtZHd4SmJha3kyOUkvM2ZWLzU0VE4xQ1YveWVh?=
 =?utf-8?B?OUJzMUtMRDZxVDRHZEVrRmppNDRtNXVXQ3YxdVVRNHkvNS9oN01IWmpBSkhH?=
 =?utf-8?B?Q3BLMlIrSmlpeSt6T2JjcVN2Y3B1L3hCSFlqc2Vwb01PM0NKRFFmemVERFJQ?=
 =?utf-8?B?dVpwWGlTQUdFL1JPKzV1Q2RBeDJFNCtmUXdXZ3QwVHdFZ3U1bjhGNzZrekF1?=
 =?utf-8?B?VUl4SENmZFlickRkeDBNRmhaL3VINVptV0ltN3NCYm9jWnJOZzFRY3UycmFn?=
 =?utf-8?B?anFjY0lkaStDS244OEplQldlclZDcWlYUDNhU21HL09NaGJoaEdQN2poTEVj?=
 =?utf-8?B?U3dSOGtEUDR5RFMyb05pK2hCK1Z3OERickZKb0tML0hWdXZZeVV0Vk1TakF6?=
 =?utf-8?B?a3kxemVpc29NV0VMZURobi9TSS9ld3NVMHZkR3o0THVoMjdVb2dXbmhEaWRE?=
 =?utf-8?B?Ti9OV0cwd25PY3dUa3BMcjVDdXRCS29HR3kzTW0rUTM4TlhPTzJEeU1kampa?=
 =?utf-8?B?cHNtZHRmZzMzYURxTXdTbGloblpGWEV0S3NJbVJHcENMN3hpeDZWQVRtK2tz?=
 =?utf-8?Q?cfHTDtiZa+aWJzm/i8RTAv4zk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A78F1A26A62FE746ADE7E2E63B917AD0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oK04OAKDRg+V7VquVceW0NZjloZPSn+V20D1DwsHn7Hm6YA36ib2CrVzJ2xtA80SZzNOxzfihRCoVd0yb929aBq4pt4JyT2Ai/AQPBdtRSV75q/2WezFhx6prNrIFJgfT6U8k1noAH3xYkT/+yC0++xvxhGt67xa3VNErnoibNmn3N9+jY78Jm0iTGbtn/IAXpfIO345I+bhXcebiwFIRB6LcBrGjo3NX34rogC2fVtXUFhAXx7WH6AlPFrwlipe6Ji+PcrqzMXd2CUVWY3Uy7zT9eCdsEWw9cAj1W764ha+RTegxpwP/5SNnAUxa4g7x64T2a2aYNw26UXwv5qke8npJcQ5ppuD1qeqHK0Umt5Da1radjE25jVEmiCwqX8RdPj+ot54bG+N8pUlQBX8xZ+sVxXoOgtPJZYfNpfcF/Ils/3eQimSYz1EFgQCvr+SM3wvOX3a2bNVEWtiataqrOeMqDVkpm1Gfu4u1M6ACIme/enb9AZW9p9vzY2YVljiy2/eVhsQ5M/3n/HrNEDX7wWAC5Yur2fWwTYwnKxhmcXZsbmrWfOSvgXxT2ftWzsUa8vWE3GcmI/qgl7ptQgq5JN29Pkp0gI5coVx20+I2CPCc+EsOcOLRN1VefkkQv74rBJXYwAIOHHJY+Oh9fEhoA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5831c2ee-6b9a-4028-ad2b-08dcff871942
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 23:51:28.8727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: px6LAAuqpFCfW351hPB+STEOobyp6dRAC5oKGqgJLYjMB12N91AeYHW+jGqp0/4N0e932vIqNyXga/wnuLReAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7437
X-Proofpoint-ORIG-GUID: 9qIfHVWpjz0yDwTefs5SPA6Ehbt4Had9
X-Proofpoint-GUID: 9qIfHVWpjz0yDwTefs5SPA6Ehbt4Had9
X-Authority-Analysis: v=2.4 cv=QowM3kyd c=1 sm=1 tr=0 ts=672d528b cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VlfZXiiP6vEA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=puh_iJZIGRfNyMnnZk0A:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411070186

SGkgR3Vhbi1ZdSwNCg0KT24gV2VkLCBOb3YgMDYsIDIwMjQsIEd1YW4tWXUgTGluIHdyb3RlOg0K
PiBXZXNsZXkgQ2hlbmcgYW5kIE1hdGhpYXMgTnltYW4ncyBVU0Igb2ZmbG9hZCBkZXNpZ24gZW5h
YmxlcyBhIGNvLXByb2Nlc3Nvcg0KPiB0byBoYW5kbGUgc29tZSBVU0IgdHJhbnNmZXJzLCBwb3Rl
bnRpYWxseSBhbGxvd2luZyB0aGUgbWFpbiBzeXN0ZW0gdG8NCj4gc2xlZXAgYW5kIHNhdmUgcG93
ZXIuIEhvd2V2ZXIsIExpbnV4J3MgcG93ZXIgbWFuYWdlbWVudCBzeXN0ZW0gaGFsdHMgdGhlDQo+
IFVTQiBob3N0IGNvbnRyb2xsZXIgd2hlbiB0aGUgbWFpbiBzeXN0ZW0gaXNuJ3QgbWFuYWdpbmcg
YW55IFVTQiB0cmFuc2ZlcnMuDQo+IFRvIGFkZHJlc3MgdGhpcywgdGhlIHByb3Bvc2FsIG1vZGlm
aWVzIHRoZSBzeXN0ZW0gdG8gcmVjb2duaXplIG9mZmxvYWRlZA0KPiBVU0IgdHJhbnNmZXJzIGFu
ZCBtYW5hZ2UgcG93ZXIgYWNjb3JkaW5nbHkuDQo+IA0KPiBUaGlzIGludm9sdmVzIHR3byBrZXkg
c3RlcHM6DQo+IDEuIFRyYW5zZmVyIFN0YXR1cyBUcmFja2luZzogUHJvcG9zZSB4aGNpX3NpZGVi
YW5kX2dldCBhbmQNCj4geGhjaV9zaWRlYmFuZF9wdXQgdG8gdHJhY2sgVVNCIHRyYW5zZmVycyBv
biB0aGUgY28tcHJvY2Vzc29yLCBlbnN1cmluZyB0aGUNCj4gc3lzdGVtIGlzIGF3YXJlIG9mIGFu
eSBvbmdvaW5nIGFjdGl2aXR5Lg0KPiAyLiBQb3dlciBNYW5hZ2VtZW50IEFkanVzdG1lbnQ6ICBN
b2RpZmljYXRpb25zIHRvIHRoZSBVU0IgZHJpdmVyIHN0YWNrDQo+IChkd2MzIGNvbnRyb2xsZXIg
ZHJpdmVyLCB4aGNpIGhvc3QgY29udHJvbGxlciBkcml2ZXIsIGFuZCBVU0IgZGV2aWNlDQo+IGRy
aXZlcnMpIGFsbG93IHRoZSBzeXN0ZW0gdG8gc2xlZXAgd2l0aG91dCBkaXNydXB0aW5nIGNvLXBy
b2Nlc3NvciBtYW5hZ2VkDQo+IFVTQiB0cmFuc2ZlcnMuIFRoaXMgaW52b2x2ZXMgYWRkaW5nIGNv
bmRpdGlvbmFsIGNoZWNrcyB0byBieXBhc3Mgc29tZQ0KPiBwb3dlciBtYW5hZ2VtZW50IG9wZXJh
dGlvbnMuDQo+IA0KPiBwYXRjaGVzIGRlcGVuZHMgb24gc2VyaWVzICJJbnRyb2R1Y2UgUUMgVVNC
IFNORCBhdWRpbyBvZmZsb2FkaW5nIHN1cHBvcnQiIA0KPiBodHRwczovL3VybGRlZmVuc2UuY29t
L3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDI0MDkyNTAxMDAwMC4yMjMxNDA2
LTExLXF1aWNfd2NoZW5nQHF1aWNpbmMuY29tL1QvX187ISFBNEYyUjlHX3BnIVlwdGhVSWRPa05G
ODVTcWFUSWtpeHh6ZnBUdlVNaldhUF8ta0ZJX2llMWJpT3RJMkRYa0lPWmx1WmVlcjB6djVuUlds
b01UNHFHNlZydzdmSkhMT2taVSQgDQo+IA0KPiBjaGFuZ2Vsb2cNCj4gLS0tLS0tLS0tLQ0KPiBD
aGFuZ2VzIGluIHY2Og0KPiAtIEZpeCBidWlsZCBlcnJvcnMgd2hlbiBDT05GSUdfVVNCX1hIQ0lf
U0lERUJBTkQgaXMgZGlzYWJsZWQuDQo+IC0gRXhwbGljaXRseSBzcGVjaWZ5IHRoZSBkYXRhIHN0
cnVjdHVyZSBvZiB0aGUgZHJ2ZGF0YSByZWZlcmVjZWQgaW4NCj4gICBkd2MzX3N1c3BlbmQoKSwg
ZHdjM19yZXN1bWUoKS4NCj4gLSBNb3ZlIHRoZSBpbml0aWFsaXphdGlvbiBvZiBjb3VudGVycyB0
byB0aGUgcGF0Y2hlcyBpbnRyb2R1Y2luZyB0aGVtLg0KPiANCj4gQ2hhbmdlcyBpbiB2NToNCj4g
LSBXYWxrIHRocm91Z2ggdGhlIFVTQiBjaGlsZHJlbiBpbiB1c2Jfc2lkZWJhbmRfY2hlY2soKSB0
byBkZXRlcm1pbmUgdGhlDQo+ICAgc2lkZWJhbmQgYWN0aXZpdHkgdW5kZXIgdGhlIHNwZWNpZmlj
IFVTQiBkZXZpY2UuIA0KPiAtIFJlcGxhY2UgYXRvbWljX3QgYnkgcmVmY291bnRfdC4NCj4gLSBS
ZWR1Y2UgbG9ncyBieSB1c2luZyBkZXZfZGJnICYgcmVtb3ZlIF9fZnVuY19fLg0KPiANCj4gQ2hh
bmdlcyBpbiB2NDoNCj4gLSBJc29sYXRlIHRoZSBmZWF0dXJlIGludG8gVVNCIGRyaXZlciBzdGFj
ay4NCj4gLSBJbnRlZ3JhdGUgd2l0aCBzZXJpZXMgIkludHJvZHVjZSBRQyBVU0IgU05EIGF1ZGlv
IG9mZmxvYWRpbmcgc3VwcG9ydCINCj4gDQo+IENoYW5nZXMgaW4gdjM6DQo+IC0gSW50ZWdyYXRl
IHRoZSBmZWF0dXJlIHdpdGggdGhlIHBtIGNvcmUgZnJhbWV3b3JrLg0KPiANCj4gQ2hhbmdlcyBp
biB2MjoNCj4gLSBDb3NtZXRpY3MgY2hhbmdlcyBvbiBjb2Rpbmcgc3R5bGUuDQo+IA0KPiBbdjNd
IFBNIC8gY29yZTogY29uZGl0aW9uYWxseSBza2lwIHN5c3RlbSBwbSBpbiBkZXZpY2UvZHJpdmVy
IG1vZGVsDQo+IFt2Ml0gdXNiOiBob3N0OiBlbmFibGUgc3VzcGVuZC10by1SQU0gY29udHJvbCBp
biB1c2Vyc3BhY2UNCj4gW3YxXSBbUkZDXSB1c2I6IGhvc3Q6IEFsbG93IHVzZXJzcGFjZSB0byBj
b250cm9sIHVzYiBzdXNwZW5kIGZsb3dzDQo+IC0tLQ0KPiANCj4gR3Vhbi1ZdSBMaW4gKDUpOg0K
PiAgIHVzYjogZHdjMzogc2VwYXJhdGUgZGV2X3BtX29wcyBmb3IgZWFjaCBwbV9ldmVudA0KPiAg
IHVzYjogeGhjaS1wbGF0OiBzZXBhcmF0ZSBkZXZfcG1fb3BzIGZvciBlYWNoIHBtX2V2ZW50DQo+
ICAgdXNiOiBhZGQgYXBpcyBmb3Igc2lkZWJhbmQgdXNhZ2UgdHJhY2tpbmcNCj4gICB4aGNpOiBz
aWRlYmFuZDogYWRkIGFwaSB0byB0cmFjZSBzaWRlYmFuZCB1c2FnZQ0KPiAgIHVzYjogaG9zdDog
ZW5hYmxlIHNpZGViYW5kIHRyYW5zZmVyIGR1cmluZyBzeXN0ZW0gc2xlZXANCj4gDQo+ICBkcml2
ZXJzL3VzYi9jb3JlL2RyaXZlci5jICAgICAgICAgfCA4NyArKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gIGRyaXZlcnMvdXNiL2NvcmUvaGNkLmMgICAgICAgICAgICB8ICA0ICsrDQo+ICBk
cml2ZXJzL3VzYi9jb3JlL3VzYi5jICAgICAgICAgICAgfCAgNCArKw0KPiAgZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmMgICAgICAgICAgIHwgOTcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LQ0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmggICAgICAgICAgIHwgIDEgKw0KPiAgZHJpdmVy
cy91c2IvaG9zdC94aGNpLXBsYXQuYyAgICAgIHwgMzggKysrKysrKysrKy0tDQo+ICBkcml2ZXJz
L3VzYi9ob3N0L3hoY2ktc2lkZWJhbmQuYyAgfCA5MiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKw0KPiAgaW5jbHVkZS9saW51eC91c2IuaCAgICAgICAgICAgICAgIHwgMjAgKysrKysrKw0K
PiAgaW5jbHVkZS9saW51eC91c2IvaGNkLmggICAgICAgICAgIHwgMTMgKysrKysNCj4gIGluY2x1
ZGUvbGludXgvdXNiL3hoY2ktc2lkZWJhbmQuaCB8ICA1ICsrDQo+ICAxMCBmaWxlcyBjaGFuZ2Vk
LCAzNTYgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IC0tIA0KPiAyLjQ3LjAu
MTk5LmdhNzM3MWZmZjc2LWdvb2cNCj4gDQoNClRoaXMgc2VyaWVzIGlzIGhpZ2hseSBkZXBlbmRl
bnQgb24gdGhlIHNlcmllcyAiSW50cm9kdWNlIFFDIFVTQiBTTkQNCmF1ZGlvIG9mZmxvYWRpbmcg
c3VwcG9ydCIuIFNpbmNlIHRoYXQgc2VyaWVzIGlzIHN0aWxsIGluIHJldmlldyBhbmQNCnVuZGVy
IGFjdGl2ZSBkaXNjdXNzaW9uLCBJJ2xsIHdhaXQgdW50aWwgdGhhdCBzZXJpZXMgaXMgYXBwcm92
ZWQgYW5kDQptZXJnZWQgYmVmb3JlIHJldmlld2luZyBkd2MzIHJlbGF0ZWQgY2hhbmdlcy4NCg0K
VGhhbmtzLA0KVGhpbmg=

