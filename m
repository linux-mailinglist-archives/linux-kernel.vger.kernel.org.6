Return-Path: <linux-kernel+bounces-539937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D81A4AB07
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 13:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0EEA168D59
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 12:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8151DEFC5;
	Sat,  1 Mar 2025 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="C5bnyU29"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C217923F372;
	Sat,  1 Mar 2025 12:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740833480; cv=none; b=Zx3XNcj4bsTkoVPUOB25JF8WYc4X4WeGcEBQNzppVY6BRo3eYeL4f0fQ7tqAcRE4yQcv3HpIM0N3EcR3oT/0o3hgf8UYTXQEOG+90+cXQ4YRqnpftG+gcUGQbeazzEmHq6eKBiQCYzovWc9QNM1Zsuz4afUblRXKDhniHOTUx1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740833480; c=relaxed/simple;
	bh=JG9TJ2L/zACNt5mQUh/jkFvy1Qa2TfFfH4f4dtsjYRI=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DGV6CSAnWa/lJ0vPPvHV9Xpct7R99vWxrKGa5zXUrGIr3AUgGXJf3b69uptKDWVEBQ45eV0YsxWOviWjmpSacN5qA4RJwOVdv7DI4POGRE2mFxFgwVZuPMapgVQ3tEkWuxwgJM0WL8rVgUi8slybJ0xZGDsioLQnk/u6Y6pTVTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=C5bnyU29; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 521AZo96011094;
	Sat, 1 Mar 2025 13:50:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	JG9TJ2L/zACNt5mQUh/jkFvy1Qa2TfFfH4f4dtsjYRI=; b=C5bnyU29jfv1dGHc
	Mkz6xW6Qc+ZTWsNX33wJs2piEgGT3bRtxBa+NLFA8vMm1puc1yZfthmUV+pK/sGr
	OwfCmEg1qgxrK1I95qlpaWBNxO/4APnsieL7nAgtZ1DDGRlahwWy7C5PZsZntx9+
	CDfp/OA96bMyZzSf9DeS55BImW3Oqv7VIyTFbEITQUBs8v1wnd67vmy7IXg6meCp
	Fu1CX+qDR2JtBIoPQd/NawJKSvPBh+8jPFiMDL76Gy79AeD6PQGsESRKKv46urmq
	9nTTuiPTKwNo4EGUHSzVGLKGZTe57+bdkqU2j/0VR9eZJlI9lZTMHd9LmJr+f9yr
	LDpakw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 453tc4avpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Mar 2025 13:50:48 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 875A6400B0;
	Sat,  1 Mar 2025 13:49:26 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3E5CE586DBE;
	Sat,  1 Mar 2025 13:45:13 +0100 (CET)
Received: from [192.168.8.15] (10.252.9.148) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 1 Mar
 2025 13:45:11 +0100
Message-ID: <1ae59b115cb2e4570c6e77a01bcdac11dff03ae1.camel@foss.st.com>
Subject: Re: [Linux-stm32] [PATCH] ARM: dts: stm32: use
 IRQ_TYPE_EDGE_FALLING on stm32mp157c-dk2
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        <linux-kernel@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        <linux-amarula@amarulasolutions.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Date: Sat, 1 Mar 2025 13:45:08 +0100
In-Reply-To: <20250301115116.2862353-1-dario.binacchi@amarulasolutions.com>
References: <20250301115116.2862353-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_05,2025-02-28_01,2024-11-22_01

T24gU2F0LCAyMDI1LTAzLTAxIGF0IDEyOjUxICswMTAwLCBEYXJpbyBCaW5hY2NoaSB3cm90ZToK
PiBSZXBsYWNlIHRoZSBudW1iZXIgMiB3aXRoIHRoZSBhcHByb3ByaWF0ZSBudW1lcmljYWwgY29u
c3RhbnQgZGVmaW5lZCBpbgo+IGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2lycS5o
Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IERhcmlvIEJpbmFjY2hpIDxkYXJpby5iaW5hY2NoaUBhbWFy
dWxhc29sdXRpb25zLmNvbT4KPiAKPiAtLS0KPiAKPiDCoGFyY2gvYXJtL2Jvb3QvZHRzL3N0L3N0
bTMybXAxNTdjLWRrMi5kdHMgfCAzICsrLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9z
dC9zdG0zMm1wMTU3Yy1kazIuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvc3Qvc3RtMzJtcDE1N2Mt
ZGsyLmR0cwo+IGluZGV4IDVmOWMwMTYwYTljNC4uZGNmMTdjNDkzMDIyIDEwMDY0NAo+IC0tLSBh
L2FyY2gvYXJtL2Jvb3QvZHRzL3N0L3N0bTMybXAxNTdjLWRrMi5kdHMKPiArKysgYi9hcmNoL2Fy
bS9ib290L2R0cy9zdC9zdG0zMm1wMTU3Yy1kazIuZHRzCj4gQEAgLTExLDYgKzExLDcgQEAKPiDC
oCNpbmNsdWRlICJzdG0zMm1wMTUtcGluY3RybC5kdHNpIgo+IMKgI2luY2x1ZGUgInN0bTMybXAx
NXh4YWMtcGluY3RybC5kdHNpIgo+IMKgI2luY2x1ZGUgInN0bTMybXAxNXh4LWRreC5kdHNpIgo+
ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvaXJxLmg+Cj4gwqAK
PiDCoC8gewo+IMKgwqDCoMKgwqDCoMKgwqBtb2RlbCA9ICJTVE1pY3JvZWxlY3Ryb25pY3MgU1RN
MzJNUDE1N0MtREsyIERpc2NvdmVyeSBCb2FyZCI7Cj4gQEAgLTY3LDcgKzY4LDcgQEAgJmkyYzEg
ewo+IMKgwqDCoMKgwqDCoMKgwqB0b3VjaHNjcmVlbkAzOCB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBjb21wYXRpYmxlID0gImZvY2FsdGVjaCxmdDYyMzYiOwo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVnID0gPDB4Mzg+Owo+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBpbnRlcnJ1cHRzID0gPDIgMj47Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGludGVycnVwdHMgPSA8MiBJUlFfVFlQRV9FREdFX0ZBTExJTkc+Owo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW50ZXJydXB0LXBhcmVudCA9IDwmZ3Bpb2Y+Owo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdG91Y2hzY3JlZW4tc2l6ZS14ID0gPDQ4
MD47Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0b3VjaHNjcmVlbi1zaXplLXkg
PSA8ODAwPjsKClRoYW5rcyEKClJldmlld2VkLWJ5OiBBbnRvbmlvIEJvcm5lbyA8YW50b25pby5i
b3JuZW9AZm9zcy5zdC5jb20+Cg==


