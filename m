Return-Path: <linux-kernel+bounces-191899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D8C8D15C4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36BC71C21CC1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF5B132464;
	Tue, 28 May 2024 08:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="uykWsVUR"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB72350297
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 08:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716883469; cv=none; b=gapP4T5ZbrCB1ecoe3q+nqffFYnFkqFKo3/MAnH1st4kXH9Sic5bGYuy+6IQQdHpLfp9laLRO/s2Y38gXlAOlGFaUNFdq3ne68qWGsK3Dlv3mOvSGdahS4lD3abC/Z93ePYKTFBwmp7B/3WV0aUs1+ELZYCIgctgL8PXaJdH3HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716883469; c=relaxed/simple;
	bh=4RV5VbKP+X5saQ/w7slHvHhnTf+qNYOaQ4+j0g7V21w=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=VCT2WAEznQ8IocVSySyq5dSpqrZlasXW77l7M9Kis0JhZTQwvMeR/Zn3H4PMtoll1HaNqmpakQYdIKzBcrLX50S4qBY3D73qhYfYSUpf2YN4oDZ3Powhi3guoxal3vWtF0q7qijNxDwm6rLD128P7oQpN530GtNYKEkorN6N9tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=uykWsVUR; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716883436; x=1717488236; i=markus.elfring@web.de;
	bh=bbgNyi/+EIYLCzUxZT7diaC1goU6a+vThPNJP//ZidE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uykWsVURrjxDnWqaZnMuvEx5oVNIAMOO6IQNIWJk/il44crEcbf5/4s+QZeCcsX3
	 mZ5dEU4OC3aiw7GE1So+PyjDO31n7A8N6JJ+kip2vDAkbh0O3DPB0KSMDnYiqPvzE
	 58IvBT7707j7ZM2u8derGaGkNjZSHeKz//lLviJK8EMFjOOEnMpo9eisTE58zJbe4
	 LTGfc1hZWQGqDPOdQqXwZGPqrtH3O1TYQU3hNWYmilv7hKJWlGZUjB7vwKqciHCn7
	 IYImt1pylv0owRlOIbUNde7lPi0Ri8bloYrTQNW88tFKRLISth4SEEp+q3LhCl3oT
	 rORrnhVT3+Bv9LYImg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MS17h-1s5dJv04kt-00QESD; Tue, 28
 May 2024 10:03:56 +0200
Message-ID: <1b4714f8-eb5c-40c6-aa3f-eb6eb7be209e@web.de>
Date: Tue, 28 May 2024 10:03:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li zeming <zeming@nfschina.com>, Ben Segall <bsegall@google.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240528071446.59197-1-zeming@nfschina.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_sched=3A_core=3A_Remove_unnecessary_?=
 =?UTF-8?B?4oCYTlVMTOKAmSB2YWx1ZXMgZnJvbSBjb3JlX3Jx?=
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240528071446.59197-1-zeming@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a0cuAab6fOD/m4PwL6zI56abUEI6F2kPN5j8FW4ooxxwZT5jlx6
 lPkJvpfjpAdtapiNnI8clTZ3rElueoZHwz2Snh3L24cTkLDkfoM6v5FEtfiSSEuZDFZOUBs
 HeZN1Eclsxl1k3Tz8mOov0RrhcPd4wqWbQsLojVe+PqfSOeVd+sgc6G2MbmI0MHWolU+5Sf
 CcjYeIz7Jhs2NZ+IuJHGg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cBzi56AyxGc=;WGe6KXMrCwTz3V1iGSlL73wsLL0
 Y0NUDvRT79iedSL3ZfWIBbu5gjAplcxsC/lE73SUzDBKlk6Rkq2M//YhluNUHGlgqukxOS7gh
 vKuDMTr2fvbK+OqZ7NU3qODKTkGHFZ07gvPMWIfOReEKSdeMHEDBNB9ttX4wFYbXPgL1lJUbR
 LYyacvgI/BDzjgRqQKNZmvGG7ud4CB4d3QA5zwmtIqWYtLNViBbX2hZNanLIriplXRVQkhJmp
 f8Un7nhPOluvnBOMTzTFhRmMb5FrAUa/zlhYOnIfcBDKPDz98rRNgyjjrS0FUjtSEt6JNDkT+
 wKb8j8IbwC6DFR6uBuWZ0fa818Rfo3l8MTtBQzgPajsOCqMHV6x2xvUPWvUKHrws9jxICxniB
 7NiQHqqBtRJopGamrIvi0gRQXj2JMqphg3MOXoan9ySsCaxfnG88SP2KkD/a0olpRqwD6dp1C
 Yg/tdBhUH+byrlml2wDkhm3ri2VZRAC5WdPW8EQo6GSs6FePKmBMXHenYLCatK4d0dowWf+Mo
 IZrblfET0AQ/5mDGCLFefZsK9ZSVk+wb2/hqTqun+K401wOPMQ3vxst0Wn+JjldZminxHVnzf
 bJzSnbcGJer4L/GEXMJMRC/seOvmu8/ykXfc/Ke+KHUArfc3nAWPBHt0IPhtu/Hb1LbFBuJ6j
 r1Q3ghrWWC/O5RYpUCQFqMy5iqJT/BfziCjDQeubS9YGa9dPb59PzkCVyVoy/FENUQ0Xzs9hN
 6wjkI8BWL4fiJv2/6QZ+UVmgfWkeDJBKR0HmvJ2rlpkU1wG5YKHMCgzUqg+/nqzFgbykvC9m8
 a8J/sLhRkQhJtLPZrENhd5GwI8wNkKzGg9rNxb4t4no8c=

> core_rq is assigned first, so it does not need to initialize the
> assignment.

* Would a wording approach (like the following) be a bit nicer?

  The variable =E2=80=9Ccore_rq=E2=80=9D will eventually be set to an appr=
opriate pointer
  a bit later. Thus omit the explicit initialisation at the beginning.

* How do you think about to use the summary phrase
  =E2=80=9CDelete an unnecessary initialisation in sched_core_cpu_deactiva=
te()=E2=80=9D?


Regards,
Markus

