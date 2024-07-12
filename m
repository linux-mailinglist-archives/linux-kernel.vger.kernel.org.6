Return-Path: <linux-kernel+bounces-250285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D3292F619
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC1D282AC8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B8713D8B3;
	Fri, 12 Jul 2024 07:22:05 +0000 (UTC)
Received: from mx9.didiglobal.com (mx9.didiglobal.com [111.202.70.124])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 82ED214039D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720768925; cv=none; b=Z9SDQgt0hnCFqHDlJhcKkqijvgqd2XOTAAmdVb6gOZXX3Fhlccxv8x3yICwLvGdeyZiC0y7GptQ2EpDr4e7vdiT0jEyACmCes1QQ4SNN/jj7CyqSLrHP1JMmS20CbX4+NYxrQIzPFdmvMJexRn7cD+JLCCOBlMpvFKDggpmc8B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720768925; c=relaxed/simple;
	bh=a7MpaZwKbemigrdhVZTBtJ/oSbd7DW6yWyD7C/ABoK4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=vA3BgXQs444dgeRMCDFCCpuItBBgVDoOxhaq5NpiEsoZnNTa36n3iV8bcBUjqezp1JtstusEjZZIOCIrZsQg3EMQqHvTBXWLJY/5qcPK0PWD2qH2Ov6EfdGgn8bmUmTQTXW/pX7zTSTlCMo4xYW50utKq3s8szUxIYrf0xkbATk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; arc=none smtp.client-ip=111.202.70.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.65.12])
	by mx9.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id 0E54618C8DADC8;
	Fri, 12 Jul 2024 15:18:23 +0800 (CST)
Received: from ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 15:18:28 +0800
Received: from ZJY02-ACTMBX-02.didichuxing.com ([fe80::34e0:2b02:390f:20f4])
 by ZJY02-ACTMBX-02.didichuxing.com ([fe80::34e0:2b02:390f:20f4%4]) with mapi
 id 15.01.2507.039; Fri, 12 Jul 2024 15:18:28 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From: =?utf-8?B?5byg5YWD54CaIFRpbyBaaGFuZw==?= <tiozhang@didiglobal.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, "mhiramat@kernel.org"
	<mhiramat@kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, "zyhtheonly@gmail.com"
	<zyhtheonly@gmail.com>, "zyhtheonly@yeah.net" <zyhtheonly@yeah.net>
Subject: Re: [PATCH 1/1] tracing/sched: sched_switch: place prev_comm and
 next_comm in right order
Thread-Topic: [PATCH 1/1] tracing/sched: sched_switch: place prev_comm and
 next_comm in right order
Thread-Index: AQHakLITnjuNapPR10WQekCFw15ofrF1KT8AgG5UVQCAABTzgIAPo3YA
Date: Fri, 12 Jul 2024 07:18:28 +0000
Message-ID: <615A1A93-6B4C-4E4A-8B35-D98325822648@didiglobal.com>
In-Reply-To: <20240702122931.4b6679af@rorschach.local.home>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB2E5ADCBBA86F4BA6636532EEDC4DDA@didichuxing.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgU3RldmVuLCANCg0KVGhhbmsgeW91LCBJIHJlc2VuZCB0aGlzIHBhdGNoIHdpdGggbGludXgt
dHJhY2Uta2VybmVsQHZnZXIua2VybmVsLm9yZyBvbiB0aGUgY2MgbGlzdCwgcGxlYXNlIHNlZSBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjQwNzAzMDMzMzUzLkdBMjgzM0BkaWRpLVRo
aW5rQ2VudHJlLU05MzB0LU4wMDAvI3QNCg0K77u/T24gNy8zLzI0IOS4iuWNiDEyOjI5LCAiU3Rl
dmVuIFJvc3RlZHQiIDxyb3N0ZWR0QGdvb2RtaXMub3JnIDxtYWlsdG86cm9zdGVkdEBnb29kbWlz
Lm9yZz4+IHdyb3RlOg0KDQoNCk9uIFR1ZSwgMiBKdWwgMjAyNCAwNzoxNDozMyArMDAwMA0K5byg
5YWD54CaIFRpbyBaaGFuZyA8dGlvemhhbmdAZGlkaWdsb2JhbC5jb20gPG1haWx0bzp0aW96aGFu
Z0BkaWRpZ2xvYmFsLmNvbT4+IHdyb3RlOg0KDQoNCj4gSGkgU3RldmVuLCANCj4gDQo+IFBpbmcg
OikgDQoNCg0KSWYgeW91IHdhbnQgbWUgdG8gdGFrZSB0aGlzLCBwbGVhc2UgcmVzZW5kIGl0IGFu
ZCBhZGQNCmxpbnV4LXRyYWNlLWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcgPG1haWx0bzpsaW51eC10
cmFjZS1rZXJuZWxAdmdlci5rZXJuZWwub3JnPiB0byB0aGUgQ2Mgc28gdGhhdCBteSBwYXRjaHdv
cmsgY2FuDQpwaWNrIGl0IHVwLg0KDQoNCkFsc28gYWRkIGFueW9uZSdzIHRhZ3MgdG8gaXQgYXMg
d2VsbC4NCg0KDQotLSBTdGV2ZQ0KDQoNCg0K

