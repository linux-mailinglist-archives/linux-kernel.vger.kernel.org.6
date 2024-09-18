Return-Path: <linux-kernel+bounces-332723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D4D97BDBA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D66A91F214FC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF3318C027;
	Wed, 18 Sep 2024 14:10:39 +0000 (UTC)
Received: from MX2.LL.MIT.EDU (mx2.ll.mit.edu [129.55.12.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809B518C01A
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 14:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=129.55.12.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668638; cv=fail; b=sr4hbDjvOdzo6C/j4F/TLe0sR7DLwfT16+JmOCREk+HHZDXTbMHcsuz+19OHTfFLmPECV2TIrIKAKqgMtuxVrxdvwWBVzCGGR22Vh0O7hlGipIzkCGLyYnYaVFyNJoNUu531VdpPDwjT7HbIUrzBkivdrlFIhcLFoyoIkQvdKd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668638; c=relaxed/simple;
	bh=rncqps8VLD/vU5lclPwZs/b4JTlHOCHNcHv+sOezYC4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XZvSya5MY6u9AVxWdlvmq+VJup58INWO9XJbRrdqus2xmswkXfpYE8l1OV29rds50sdd04gBoCmdb8j5a8V9kvG3ayKTnJwoW5AM1O+5T8tuyYXAiqM6tHcilMwX0hPMalnVh0HvPvlR9LswcoP2BgMniCfWFf2skNQBRUM9fyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ll.mit.edu; spf=pass smtp.mailfrom=ll.mit.edu; arc=fail smtp.client-ip=129.55.12.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ll.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ll.mit.edu
Received: from LLEX2019-02.mitll.ad.local ([172.25.4.98])
	by MX2.LL.MIT.EDU (8.18.1.2/8.18.1.2) with ESMTPS id 48IDmUIb100262
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 09:48:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=coKfaxsEU0v8eL8UBW5aKwMVq2DqhCJn5SdwW5ltQ2/s832D4vQ1Yza94WB7o/W67LbFDVjDbeX2xphkdL2H6U7V2JRhxY++2x1SB7SW4JHubCpqoUZeV79RWoQ8VIOAjImtSGIiqjIpUZzo1I4wV107rdDAHftil0UNN2zkoR9fTNl/Fr1Ref7kQu3RDvjRDtk32L6REt/TfYE/yD4ggeHKUViF3LblPCmQU9dNpfYasGpS/TinhIARUOtMRkbawOegeihZtffEOCllB9by1SzZC6QPXcE1m4TjzN5P0eZEafq99gdkQbim7qEIlSxqQc9UuHrk9dXAwxSqTn5dnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9U8yG5x8dYt65SLz1pmZoQpWuSWZr2YZCAeKEjFD5+s=;
 b=RvnyM+ZSV5JisS2FLSoF0sri5ZYSsdEslMyKzDuKQUdQHyGT5zOzvWmaBQBdpVxJalytm+8CTj/9VLNAxif4fXDFz5MORPZLDZbAO5abXR19hJreuDTSKb9uKZPL92WjxHJg7gmBziV73wq3hHhsxNDihra65vSpPveujG01ikcPUoT/vMprQLB25LZd7P9QprWVFqlM5YL4TSWhIBVux1EvLunfeJB7JomZq8TBxDu4fl/jzxw7HvaoEGJARwtS5aKjViUs8E3Aap6q917h1c79j5SyX5XA9Cq9ejwKtD/PrLLJBvDjAs3k5/k7b+qvXIGU5uosgU32Fzqzue8WIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ll.mit.edu; dmarc=pass action=none header.from=ll.mit.edu;
 dkim=pass header.d=ll.mit.edu; arc=none
From: "McKee, Derrick - 0553 - MITLL" <Derrick.McKee@ll.mit.edu>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Upstreaming compartmentalization support
Thread-Topic: Upstreaming compartmentalization support
Thread-Index: AdsJz0KmO38h72oeT7qFyQfRdo5+/g==
Date: Wed, 18 Sep 2024 13:50:29 +0000
Message-ID: <BNAP110MB1870973603BB2663E0EA80CED562A@BNAP110MB1870.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BNAP110MB1870:EE_|BNAP110MB2014:EE_
x-ms-office365-filtering-correlation-id: 972e447d-baa5-41de-8ddb-08dcd7e8dbbf
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?V3kZA6MHJADprc95KnOAnzNKF3GhMdsimaLKRy/Tm7KYNTNwO2SqgAq5FDTZ?=
 =?us-ascii?Q?Os+zVPX7NmWW6F94Xw15muCEvgS9ZrLB2XaXIW7d7yNhBtKMsomqfhw3rGPl?=
 =?us-ascii?Q?6IT2usFfaDjwGmuzKwy6rLMOjhhy1qpi+ZPH5I4uyKJkRFP2E2bDgtfpnSCO?=
 =?us-ascii?Q?tohtvhAoaUlmNPSKZQhm1NITiNDWPDSIaKOrrrzbLi/9bXduaQ9wr7F1zkIp?=
 =?us-ascii?Q?ItNSJnwELMwvT5IrsZYhdoftEPS99IL589gJTc9kwmOI5fAcKVbwyS+zJeoT?=
 =?us-ascii?Q?xIaOUc1svnJn850Rlrt9msx6K7qihc9VpPYObl601gFZnetj1Va7Z3E6+FcH?=
 =?us-ascii?Q?1Wi1U4m9yYOqkbCcyfPzd9iYPDsJ7xhUuPmqEal3INw5m9C2apAMUzNGFgWR?=
 =?us-ascii?Q?uqP0DQxmOqfnjSF7WaOMiq96tYNNeSB2grPJNhBxWFcJxqp0BWk8belc3FXo?=
 =?us-ascii?Q?xDPptyu8AXynnLnx2eSEm2xYEWj3IjpELF5K9+OrCkc7T+tUMsiXWrpxVkN/?=
 =?us-ascii?Q?oIQg75WDT3u1iWmo8RQAVDe9MXQB/0RjXoQF8cV7Fu4UW5/y18pt2yZVtEPe?=
 =?us-ascii?Q?JyeUmJafZL2cvS2nplaOpaEv9AaNx0QnyRMIJKHHZX7KswjDXNojcnn1v0sf?=
 =?us-ascii?Q?9lnVp8GPzMeDFVIUOpG7vOK/Mm1Ho0ljxjMg0EOo0q3so6pLraBIvWxu7a/4?=
 =?us-ascii?Q?sc/j7shmHUy27nWbL7jBdJrez8He4WL51rCtOnCMVyt3q2Al8fSwGfja8ggl?=
 =?us-ascii?Q?vW7a/ftjnqsktKSj3gCNu/nCNMdgTLpHQWYPiXe3VkbfqaGF0dq4kpZ+5XD+?=
 =?us-ascii?Q?30hFvBmBwlNwchPwT/RQfY5SOqWv/4AToABoo5H3EUQzk6Yw6NEzqPnC/MbH?=
 =?us-ascii?Q?RkZ0GnRSiPcnK7a7saX9jnT66e8hqrW8qSgTvylFzdAhEw72wxWiZ2R8nIGE?=
 =?us-ascii?Q?Nxzfvx/Ywb6LNKPJGu69/W9RHpZUhiqgZeU/t0JENXJlsclQsGFPACOmhOGl?=
 =?us-ascii?Q?AQJBleIFqppo9Yh+53ZRGRHS3IrAC3iWy3Grtd3WlcQ/sMUPSjg6k+Q9+PzT?=
 =?us-ascii?Q?G79TT0sKPazbcK16L20mmuHBTJTH8Wq5HsHvfH1AWXiu+icb59Zoumik/uGj?=
 =?us-ascii?Q?fUOvlKzIzjjVzkoZxm95oCIlXwtN3kPgDubNbCrEP8vSQlw+BqMyT7MzlK0D?=
 =?us-ascii?Q?JPIOCha5ko/T0vB30i3OE4zstG4XNfqoS0WI1fnZlyEbt4gnyEkB1qnNNpP+?=
 =?us-ascii?Q?+K18BBkwHOdyZdm1+oUxrIJ8u2byLRmeKZYkKhwW4IiIBCfj8ShTZNrBKLXf?=
 =?us-ascii?Q?YJ2e3XcM+2Mr4f+VkXyR94F9TjYmwIwWoqDpHQun0y/vNqb6lmwLoTub1DwV?=
 =?us-ascii?Q?ee7ppCw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BNAP110MB1870.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+BIscjye/y97qcFu7nasU9O2/bhVc/2MLbN40aZ1zqYYiWviOi97TV/rwO9d?=
 =?us-ascii?Q?upHStJ7jaY5pL8Tc3rxb72K6+lcTVv+TfFmKWaq5fvvXDDOrP/IjmX93p3qb?=
 =?us-ascii?Q?FX6bQQ8zGWF4zn/Y8upIiYi2Tc/SqlZ7QqaZKRbaLmj+ZG5NGXaefmuPs8jw?=
 =?us-ascii?Q?JssfsHx8a8bfE3O5qnwNNrwCcqLr+vD3yIAOHYpU1i3HOUJ/NkEc6+OqzKQK?=
 =?us-ascii?Q?WkzQj8WYV9Yi6cxxZUI0tEp3q8FHXCZZ2hrzEsuJYCKcdgw8C73BukA4Ij5M?=
 =?us-ascii?Q?gzvR1qKS4xQOYUdF51a0me9PKvRNQcTh/S00YrstYFIHalfTYLh78UFfAHnk?=
 =?us-ascii?Q?W3h2oinc+/z7bvAo7sQhTBeDiuYP1XAk3WwtkxFeXk6h6p3o7fxpDjeqqE8J?=
 =?us-ascii?Q?SqK9QdpKyP4l154zCazme+n8eb8ZGP8ssq1esaHJKIkGEsjBGsltCDlV0EdC?=
 =?us-ascii?Q?snZW26PZ+FZ+B9RKu0B3UvBf1MqF7Wg/m5ZgJzyI89SMdziHiCxIKXVEUqFt?=
 =?us-ascii?Q?pRnh8V0yZbyadyfQ+29Cq5dg9NpRcqf18kFmaAYIpTRyUzekhbZ0/CUfesRk?=
 =?us-ascii?Q?r21AJbZLIQ6uHNM3BJg0J7mW8T7E6f1++r0JtSnwd1tUk/esmhlUF9VDHgp5?=
 =?us-ascii?Q?LkmYVEB6gqEpmYcwi8O1TEXixBy+ruIVkqMUmf5ori2sTCQMN3gkZU9GQE4i?=
 =?us-ascii?Q?nkpEGAItsw9gKdcaRELfUfvkAfGGr8xBD11XbUEeUZ2uuLGaQCGYNY1aecRh?=
 =?us-ascii?Q?I+9lTXnzcVTDSH0r5SbApSQOzZZq1Gk4Je9QElfBnRE04ttCc0c4GSykpUvG?=
 =?us-ascii?Q?HaP1/b/9kPZDND3612NnNUn+vHWtZhP7izLz9WS3w7nsSZIN4Qy0tlDqaHnm?=
 =?us-ascii?Q?Kp01kziWoZq2wd8/CxGbK6BjHGSEEHCeas4OJQuytfK+h6To6q01sGvQe3Zd?=
 =?us-ascii?Q?VTWCfxvLIAHJFLZ1EUbZVixXuJKzwRftiD+Bjqsw1se6qFpndilKeQ8mhvra?=
 =?us-ascii?Q?s7qNWrWZydiV3E6eKsr6N5u7rrnkZKMShpe0urP8cD6HZ/KMarjxNby/BxKH?=
 =?us-ascii?Q?Aa5oKGAv7BeG2gFI4ocWGelLRfySJ9dYmDPaBAg6l/YNi1VusrjlgkqDS2Qz?=
 =?us-ascii?Q?hH8VizgU6O5b5PKhDcxVal1DASOJGYj529W45rYYEtsrhwMlTZJTsuitRf0j?=
 =?us-ascii?Q?cqn6EWipS2/V8e1dgWfHHMraguJw6IFqkMIdZrGRKNGMgdQG+UXSUBHtkvYa?=
 =?us-ascii?Q?B7wYkcuay5pz5yJNb4CFwR9LQyQ1pgrR+aQUnCh3U7kCMxFyxrPHcG+PqqJC?=
 =?us-ascii?Q?1bWzR4hZo+e+1IGcPVGfsxflbKtAa3tbf18Ca+ldxf6b8CBdGxLpP5lo148L?=
 =?us-ascii?Q?ZUsCXeVRwqcUzszTanHr73HE2mehrws4OkNtRWiXz4GFkicpEhrjqMK6Xo10?=
 =?us-ascii?Q?0+HmhAQc+O6SD6uX/fdmV6YYKLui2IGyy90q/xh+wezSovsFCp5BjkzacLrC?=
 =?us-ascii?Q?fsgPDjm7KQTzj1Ssm/L59nNp6wAgTWX0tzE9?=
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=2.16.840.1.101.3.4.2.1;
	boundary="----=_NextPart_000_0006_01DB09B0.3001A5B0"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BNAP110MB1870.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 972e447d-baa5-41de-8ddb-08dcd7e8dbbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2024 13:50:29.8712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 83d1efe3-698e-4819-911b-0a8fbe79d01c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BNAP110MB2014
X-Proofpoint-GUID: 0Gd1ZarLBANRWjkb5xlpR9tOiim0tear
X-Proofpoint-ORIG-GUID: 0Gd1ZarLBANRWjkb5xlpR9tOiim0tear
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-18_10,2024-09-18_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 mlxlogscore=758 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409180088

------=_NextPart_000_0006_01DB09B0.3001A5B0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

My name is Derrick McKee, and I am a researcher at MIT Lincoln Laboratory.
My team and I have developed a technique that allows for adding
compartmentalization to the kernel [1], which effectively creates a
micro-kernel like separation from the monolithic design the kernel has now.
We are looking into the possibility of upstreaming our changes.  Before we
spend the considerable resources needed to get the code up to the high
standards needed, we would like to see if our approach is acceptable by the
community.

We enforce the compartment boundaries through using an LLVM compiler pass
that is currently not in the LLVM source tree.  This pass analyzes data
access, and instruments the LLVM IR to mediate access to ensure that the
compartmentalized has the appropriate rights.  We plan on discussing the
integration of our pass with the LLVM developers, but we do not have plans
on porting our technique to GCC.  Is there an official policy regarding
compiler-specific functionality?  Are compiler-specific functionality
acceptable?

Additionally, as part of the compartmentalization enforcement, the compiler
pass adds new functions not declared in any source file.  I know C++ has not
been used in the kernel partially because it also adds code automatically.
Is such automatic code generation acceptable as well?

We look forward to hearing your responses.

[1] https://www.ndss-symposium.org/ndss-paper/auto-draft-257/


-----------------------------------------------------------------
Derrick McKee, Ph.D.
derrick.mckee@ll.mit.edu
Group 53 - Secure Resilient Systems and Technology 


------=_NextPart_000_0006_01DB09B0.3001A5B0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCErMw
ggOKMIICcqADAgECAgEBMA0GCSqGSIb3DQEBCwUAMFYxCzAJBgNVBAYTAlVTMR8wHQYDVQQKExZN
SVQgTGluY29sbiBMYWJvcmF0b3J5MQwwCgYDVQQLEwNQS0kxGDAWBgNVBAMTD01JVExMIFJvb3Qg
Q0EtMjAeFw0xNjA0MjAxMjAwMDBaFw0zNTA0MTkyMzU5NTlaMFYxCzAJBgNVBAYTAlVTMR8wHQYD
VQQKExZNSVQgTGluY29sbiBMYWJvcmF0b3J5MQwwCgYDVQQLEwNQS0kxGDAWBgNVBAMTD01JVExM
IFJvb3QgQ0EtMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAL91qARBjjibZuLnL2n+
ryiBT7PMGrQnekpsKv13kTaOz94zyMTT8Bd/fERg1JjySFwO4ncw+o9KKRSFvpC6mMnvXu/PD1dH
amiZV/PNfHzQ20hPvAeoYnqik0e1XziO+FFUBFClURbkRcOrlWLr4HsNk4/wtnRHnt+3q7kJeZx5
G1djrFp2ezvsrfnrXeh0XGly5T/avFioANwe75DlSDAiqALmlo/gRauyvljZIsovynTh/SZjqW8k
SuI3AO8Wy5xfCRVEjYOXOGNQSaxWmbZAnhujZvaeduBpZZERcz4KY/FYnFfgCvva2NO3U8dNpGKL
U5yrstGMQQMLFF8QEBMCAwEAAaNjMGEwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQU/8nJZUxT
gPGpDDwhroIqx+74MvswHwYDVR0jBBgwFoAU/8nJZUxTgPGpDDwhroIqx+74MvswDgYDVR0PAQH/
BAQDAgGGMA0GCSqGSIb3DQEBCwUAA4IBAQB6mHxH/9yeWjCoZWEND51AGzAfI2Uq/fx743zhdNHK
xVAn0q6hvCUMKPkv4quuoHKethRICdH0JA4FYOpvgthE6NS6FoksYWAn3EiEBApY5V8EfMBUmshf
NtkuvSKrx4XauHefI1OoGIurLI1OL8LL7FS0SSpP5vwoP8PIFumBzOWoQQ+v+QnHpdnyO6EprJDv
fdfqLawtdWHw8Ahb8+wJtK/ivYlYUlrWuIZiLldGAYmtO3mSkjtNiz4EPGDs95LtGLfpofFVkSrs
dgnGIzKZPlg1dATKe+bam+qagRZHCrxAV6sYPvPhv7po4ouB9HOZLyYWkMspG5jipsTvSHCSMIIE
wDCCA6igAwIBAgIBGjANBgkqhkiG9w0BAQsFADBWMQswCQYDVQQGEwJVUzEfMB0GA1UEChMWTUlU
IExpbmNvbG4gTGFib3JhdG9yeTEMMAoGA1UECxMDUEtJMRgwFgYDVQQDEw9NSVRMTCBSb290IENB
LTIwHhcNMjEwNDE0MTEwMDAwWhcNMzIwNDE0MTEwMDAwWjBRMQswCQYDVQQGEwJVUzEfMB0GA1UE
CgwWTUlUIExpbmNvbG4gTGFib3JhdG9yeTEMMAoGA1UECwwDUEtJMRMwEQYDVQQDDApNSVRMTCBD
QS04MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAttKiUZi+ezd6XR3/UBsFtO/XphH8
qPCL1l7Qjq9d3pew3w9mRG5+16+VG4OkSdbg1/C/9G7Qf4E+b1UBcpRT7dMWQ4+czMj5hzJMX8RL
7tMvwgKyNGvIg6WcLm11NY0r10sesBaYVwerNQrkE66PBfTdFq4x62r7CO1GHrnpkzhIpn9GghsA
xeY5V2Z+NrkglNXTaSfUrsr1Did6A6FaOHqUfX02zXd5Rip5vvLK6y8eJlYcZpRZYDsP6wwPuSgv
8lDa/c/28y5egk1EEG3wIBXedgv+mnZ8ZIoAIkhreCZvWrAp8PLotMBY2YoyWVKmpoebfXuaUBB1
0bVHp491wwIDAQABo4IBnDCCAZgwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUB6lj96pk
z9L6G8h9ATWJ3kgVtGswHwYDVR0jBBgwFoAU/8nJZUxTgPGpDDwhroIqx+74MvswDgYDVR0PAQH/
BAQDAgGGMGcGCCsGAQUFBwEBBFswWTAuBggrBgEFBQcwAoYiaHR0cDovL2NybC5sbC5taXQuZWR1
L2dldHRvL0xMUkNBMjAnBggrBgEFBQcwAYYbaHR0cDovL29jc3AubGwubWl0LmVkdS9vY3NwMDQG
A1UdHwQtMCswKaAnoCWGI2h0dHA6Ly9jcmwubGwubWl0LmVkdS9nZXRjcmwvTExSQ0EyMIGSBgNV
HSAEgYowgYcwDQYLKoZIhvcSAgEDAQYwDQYLKoZIhvcSAgEDAQgwDQYLKoZIhvcSAgEDAQcwDQYL
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
EwJVUzEfMB0GA1UEChMWTUlUIExpbmNvbG4gTGFib3JhdG9yeTEPMA0GA1UECxMGUGVvcGxlMSkw
JwYDVQQDEyBNY0tlZS5EZXJyaWNrLkFyZGVuIFBhdWw1MDAxOTY2NzCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBANBUE55VuaKRN3yywslKETerDNrpHbuJhbL69s56RcHJ5kDx5yVAh3zG
I7pJzSpdgRMdRNqJFUozGsx5ZUklOOcUDtSzFJ00ZRDFCUS//ECnoWsHFfBiCFPb5eL9sGcgM7vK
J4L2opBlNDxCZWVmMrC+QQ2CPOggIFDkeKBqxuFivVEpi3Cg8wGMaBz+vjieNuiXdM5K4io9MleO
myRkoqoHIrgpcLD7u8IkzIYrZnn4v8Ya5isMwtxGfe2krRWozYTAzUS0jetVz8xvz83/9e7L/BFT
Dhn1mSNECxIRy6NeUXuyH6bj9XdMLPpGlTNNF28+g318VPtNyb4oNfN4tzECAwEAAaOCAgwwggII
MB0GA1UdDgQWBBR1/NmifJZ821OZt5iDu6cUoDlgCDAOBgNVHQ8BAf8EBAMCBsAwHwYDVR0jBBgw
FoAUB6lj96pkz9L6G8h9ATWJ3kgVtGswMwYDVR0fBCwwKjAooCagJIYiaHR0cDovL2NybC5sbC5t
aXQuZWR1L2dldGNybC9sbGNhODBmBggrBgEFBQcBAQRaMFgwLQYIKwYBBQUHMAKGIWh0dHA6Ly9j
cmwubGwubWl0LmVkdS9nZXR0by9sbGNhODAnBggrBgEFBQcwAYYbaHR0cDovL29jc3AubGwubWl0
LmVkdS9vY3NwMD0GCSsGAQQBgjcVBwQwMC4GJisGAQQBgjcVCIOD5R2H7Kdmhq2HFYPq8EWFtqEf
HYXL3jKH/4pzAgFkAgEKMCIGA1UdJQEB/wQYMBYGCCsGAQUFBwMEBgorBgEEAYI3CgMMMCMGA1Ud
EQQcMBqBGERlcnJpY2suTWNLZWVAbGwubWl0LmVkdTBOBgkrBgEEAYI3GQIEQTA/oD0GCisGAQQB
gjcZAgGgLwQtUy0xLTUtMjEtNzkzNTA1ODctODk2NDE0NTU5LTI2NjIwMjA4NjctMTQyMjEyMBgG
A1UdIAQRMA8wDQYLKoZIhvcSAgEDAQgwJwYJKwYBBAGCNxQCBBoeGABMAEwAVQBzAGUAcgBTAGkA
ZwAtAFMAVzANBgkqhkiG9w0BAQsFAAOCAQEAeu23SlL3y8Z7xtulQ8nBpap/jYc8chDMaAD+v0je
EcvtTyIxyZhK3aVZti1xmXubvzA/X3ZzNK4nAPxhChI4+ObcFSz9XsmvoijOb8hPk4FhcKB/KjpV
jxWsYWzR2NRNTzq1w9SXMwVACDWjsBYKDKRBmPxLwskD/3ccY/y82ZFafIT/HA1aI5MWc3e4qF1p
gt2HsUWj9eUR1TYme2NdXtEwUG0/G2zm5TND7FwtO/sWfa9FWbeFYVbPX/sd35agDE/1RzTrZRgp
3VcBXUy3Tw3038HqoISz4nJnY6VY6dlM299Fc+gmtSCMAI+7zpiscnF4BJkXLOfE5X55v7x5gjGC
A4owggOGAgEBMGgwUTELMAkGA1UEBhMCVVMxHzAdBgNVBAoMFk1JVCBMaW5jb2xuIExhYm9yYXRv
cnkxDDAKBgNVBAsMA1BLSTETMBEGA1UEAwwKTUlUTEwgQ0EtOAITJgAAWfx7pCKQvmHEfgAAAABZ
/DANBglghkgBZQMEAgEFAKCCAfMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjQwOTE4MTM1MDI2WjAvBgkqhkiG9w0BCQQxIgQgyixjdB1M1gh3rS85XtCyzKkSeGpV
6/BFeM74QvPva9UwdwYJKwYBBAGCNxAEMWowaDBRMQswCQYDVQQGEwJVUzEfMB0GA1UECgwWTUlU
IExpbmNvbG4gTGFib3JhdG9yeTEMMAoGA1UECwwDUEtJMRMwEQYDVQQDDApNSVRMTCBDQS04AhMm
AAAJ70wlw6vbZKRjAAAAAAnvMHkGCyqGSIb3DQEJEAILMWqgaDBRMQswCQYDVQQGEwJVUzEfMB0G
A1UECgwWTUlUIExpbmNvbG4gTGFib3JhdG9yeTEMMAoGA1UECwwDUEtJMRMwEQYDVQQDDApNSVRM
TCBDQS04AhMmAAAJ70wlw6vbZKRjAAAAAAnvMIGTBgkqhkiG9w0BCQ8xgYUwgYIwCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjAKBggqhkiG9w0DBzALBglghkgBZQMEAQIwDgYIKoZIhvcNAwICAgCA
MA0GCCqGSIb3DQMCAgFAMAsGCWCGSAFlAwQCATALBglghkgBZQMEAgMwCwYJYIZIAWUDBAICMAcG
BSsOAwIaMA0GCSqGSIb3DQEBAQUABIIBAHlAeMtGmIkUjtT05KqjS93OG+PGZEjsITNSEvUcNxRG
4UNcDXPg1T0tP4WtoXBVhG5Q3ytu49tWMZvyBgCLrc/Y1m5GqMZQIACfJJHrAXux1y+cwEUWfUa2
Z2xReZ72gzzE00WPoGJrxlrS2HCh3ykLVuK1XNa4z+yHVnRDvaVvVFpAbbGVvNkdL1r88krp77gR
2BBACU1QJlXJByi1Ilt9p1Gt5GEuGukT0DlEsncSjVfAy84JrOcnHJS6ug2sSq1lrxsaZ//YgvVM
B7nhEzna0K7E74nZUW1B7gxhE3Lwajc5XRM/zhJTkDDFgTYakm5VtqrMLTKZobQADP6oxHAAAAAA
AAA=

------=_NextPart_000_0006_01DB09B0.3001A5B0--

