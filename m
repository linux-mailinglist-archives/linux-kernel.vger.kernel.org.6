Return-Path: <linux-kernel+bounces-305326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CCA962CF8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 617812826E5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452231A4F2A;
	Wed, 28 Aug 2024 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="r67Y167W"
Received: from mr85p00im-ztdg06021801.me.com (mr85p00im-ztdg06021801.me.com [17.58.23.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6931A4F25
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724860120; cv=none; b=sWZwE0m/3egU9mpgR7TLmk/hPAl6EBEnXjr8fAP0+UNjB9fEMMVhTL1EZ6R9lgz5GObWz2qw/ux/x9Zz/XGu4ebPqbGRIZ75Cv8Dq0vXrJZ0JkFV9VOOVhLrn1fiojmG8pRv7FcRo/h4L6rPaFEwu2inxqN8rLoOylb6UYx+nQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724860120; c=relaxed/simple;
	bh=+gEZweTiORwEDH7zUhcrgB0RC68urOkyGA5jdfF74Ek=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BWRJJTyn+OtYpUl2tKf5SxZf/rtTCsJOZMrdwl7geVnCLMPlIMo85zpfwsc0Fh766lI8u4HGA9XK/NFfimuHPEvJIwBoWS7aw5Go4F87X2f9SAO4fZWMvMbSp3vi4PWEo40tPRsbJ2hP5D1Djx4DtyUOJ65RualyitUAlE7iv0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=r67Y167W; arc=none smtp.client-ip=17.58.23.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1724860118;
	bh=+gEZweTiORwEDH7zUhcrgB0RC68urOkyGA5jdfF74Ek=;
	h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	b=r67Y167Wjg/fQPQK5Ch6FZYx1skCNM41eVXREJkxGiPZMH2qmvhEoSy1Da1tVdXz/
	 K83j5p7Ly5n9BdfCiVhKlyx4nwDR2H74zUy67hkisiis5di4KITR8Yqh1bu9b2HYUW
	 AHuls/nkxNRXtACKZZoUW/DXEpozImHvtruc+rgeySDDfmr09ty8VJb2YGQgandWhk
	 yXXqTDykFQ2MIXt2yDqjcp2UPiV0NrVlDfTPifqEOUxIbgBNY10LND0wcx3yD//L0O
	 AkaIrnmJttPVeq666Di8D4rhfAezA+Mlzuzpm1LE1cEP2mi7tF/dWUcoWjwlKlYKnp
	 DrrrPcTVBR9xA==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06021801.me.com (Postfix) with ESMTPSA id 92E11D003C5;
	Wed, 28 Aug 2024 15:48:36 +0000 (UTC)
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
X-Proofpoint-GUID: RmYT-O6kbuHHF4usLYXKs8gu_yhZjix5
X-Proofpoint-ORIG-GUID: RmYT-O6kbuHHF4usLYXKs8gu_yhZjix5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_06,2024-08-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 adultscore=0 mlxlogscore=904 clxscore=1015 malwarescore=0 mlxscore=0
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

