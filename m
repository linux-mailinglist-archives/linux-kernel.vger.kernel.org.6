Return-Path: <linux-kernel+bounces-305327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE07F962CF9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588C81F27600
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1791A704B;
	Wed, 28 Aug 2024 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="PPAYi3+i"
Received: from mr85p00im-hyfv06011401.me.com (mr85p00im-hyfv06011401.me.com [17.58.23.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FBC1A4F32
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724860122; cv=none; b=RTVIuhrB5GrrcsikbBx/l+eLYhC7PZ+znlfi1ejDU3a7flAQNDJLHldSdaRh67Kjhr6J96fzBQxyOkffBBkzW5c5cNAF7Qa1Mdv9HbZPaQEO4XgJ+ubM+efP648hBPyEh/WuBSDhuM+BF8QTmG/KwK53hIxvnZj5Ey6pCd3nHz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724860122; c=relaxed/simple;
	bh=+gEZweTiORwEDH7zUhcrgB0RC68urOkyGA5jdfF74Ek=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GWIaU8vL0Mo77MJrkQEZIbhFeaqwpNnplLDBCqyIIWu7Im/UsMy/X/YTBkNAkJz161hDYIJtf1B+cs83rVvPI5sgkyJ4eDFRnEDlORmB2WdTuEUbk4g1UmUuTT38OUonwqK9P0zJNhBJjRuvt0heqwvDQ3l2UuJqE9cKEZro2YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=PPAYi3+i; arc=none smtp.client-ip=17.58.23.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1724860121;
	bh=+gEZweTiORwEDH7zUhcrgB0RC68urOkyGA5jdfF74Ek=;
	h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	b=PPAYi3+i72B2ukDfe0e7IgFDQrjo+HkGQVQn541CZ0T1hBQlrI4X4PyjQdDs/w4x5
	 E+wcEL+OwI+igTZPkYCeVLsRq4dF0q1gj3gZzgz2Te1zzopz9hjIbQuzV8GWOPHOBd
	 Ahpox7/sfzTTdhPIu2LYIu1bNcPp+YmQqmmBPxH75fZf0RuNnN3+j+4XtZzuyBV4Cb
	 D9jTyKRU22ha5OTquD/F95bFmTKNzIFdAJoiUkImLZa88gQUWU91MDtZx1gWCdgdl7
	 X5gFxblw+S4aX6U2+wiDxxo6CBPmRmU1C6+ufPPEMTookBdL1RE6fVlG4yXA5iSwtm
	 ViXF6Y9QDM5Bw==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-hyfv06011401.me.com (Postfix) with ESMTPSA id DD205357AB66;
	Wed, 28 Aug 2024 15:48:38 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH] prctl: allow prctl_set_mm_exe_file without unmapping old
 exe
From: tblodt@icloud.com
In-Reply-To: <a22f114b-e86d-4ddf-b13f-4020b53c97c3@redhat.com>
Date: Wed, 28 Aug 2024 08:48:24 -0700
Cc: linux-kernel@vger.kernel.org,
 Ryan Houdek <sonicadvance1@gmail.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Kees Cook <keescook@chromium.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <27F75C31-4DCF-42E2-AB91-948F1A5615B2@icloud.com>
References: <a22f114b-e86d-4ddf-b13f-4020b53c97c3@redhat.com>
To: David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
X-Proofpoint-GUID: 7atR005Hkp4m_CJRh9HTZSHpA_8_0kwT
X-Proofpoint-ORIG-GUID: 7atR005Hkp4m_CJRh9HTZSHpA_8_0kwT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_06,2024-08-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=904
 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408280114

> Interestingly, the man page states:
>=20
> "You can even type /proc/pid/exe to run another copy of the same =
executable that is being run by process pid."
>=20
> Is that still true (with that binfmt_misc magic) once we change =
/proc/self/exe? Or does it with changing /proc/self/exe to point at the =
non-emulator exe even work as expected regarding this documentation?

This is actually one of the reasons for an emulator to want to update =
/proc/self/exe. If it points to the interpreter, running /proc/pid/exe =
starts a copy of the emulator, but without any idea of what program it =
was supposed to be running. If it points to the emulated program, =
running /proc/pid/exe will still start the emulator because it's =
registered in binfmt_misc, but with the emulated program. The intended =
result is for references to /proc/self/exe to function the same way they =
would without the emulator.

~Theodore=

