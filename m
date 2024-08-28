Return-Path: <linux-kernel+bounces-305380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80844962DD0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3A1BB2193A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A491A38DE;
	Wed, 28 Aug 2024 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Wl35fPhm"
Received: from mr85p00im-zteg06023901.me.com (mr85p00im-zteg06023901.me.com [17.58.23.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C576A158DB9
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724863265; cv=none; b=kYHaD0uXqmF1Y7Al86p4tB6mu/wg95fkFxaU72GR+M3WKt6lqCR2Z07QyI/PFiM8C5jXASYxXhzXagi4nrXYigIcjLHI0cGDQvHOftuAsHtWnI7Z4f4OBE4o8CiCEGoMByXHM0rF6bFn1hz3+KYDiDeF+OfgvQEAgi8NOnEW8Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724863265; c=relaxed/simple;
	bh=8Fqr6S47c1intx+qchcWUSjwinUC4Gn9HAU7fgdRepU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PbKAhwYpsOv00wOThqysD7yyG5OR/sNrUEUmrmSlD/gSlu6QTzb7O+nysCUgjlg0JkQY7rOk9FaC6qfDIg1J9xtM8Y403e2qAFPjqwtqHrnOHxhCRHRBBBgnnGhYCMSe84tYoQBM3VnZGfbmLHGSAnLGyBWZ1oIW2HYRafohrpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Wl35fPhm; arc=none smtp.client-ip=17.58.23.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1724863263;
	bh=8Fqr6S47c1intx+qchcWUSjwinUC4Gn9HAU7fgdRepU=;
	h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	b=Wl35fPhmyLDTSDCBUElwdYNHGfOLIdKgVpFouUeLADI00NCNXGYhVV8weWCYwvMKi
	 rkICuN1xHj57Di55WBt7vp01tEG7e/3kgkQPF79xfDKirgeKpBzdvNi+Tsyb6z0YXo
	 Ei6WDat1qqGbe2Qgrvfw/IXLoS5k5bCouS9L4/g9ABoEqC1qsJlHSH6QnqX3jdaX3o
	 +DhHajHLlS6E+74u+t7I7LNX07U50ueudcwdC5evV1UNW6ZhCz4kPJGSiXzCaDNTrn
	 jh8J3thbcw9v0Bqop+Ou3Gz4lbftPULn8vGo/gumT6zT7vgkCnfsteFBJVpMRLYrRu
	 ZyQ4DYaepkFUQ==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06023901.me.com (Postfix) with ESMTPSA id 81E2E6E0331;
	Wed, 28 Aug 2024 16:40:59 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH] prctl: allow prctl_set_mm_exe_file without unmapping old
 exe
From: tblodt@icloud.com
In-Reply-To: <87ed68wz6j.fsf@email.froward.int.ebiederm.org>
Date: Wed, 28 Aug 2024 09:40:47 -0700
Cc: linux-kernel@vger.kernel.org,
 Ryan Houdek <sonicadvance1@gmail.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 David Hildenbrand <david@redhat.com>,
 Kees Cook <keescook@chromium.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C96F1571-3E1B-44BB-B505-6C25F43CABA4@icloud.com>
References: <20240827215930.24703-1-tblodt@icloud.com>
 <87ed68wz6j.fsf@email.froward.int.ebiederm.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
X-Proofpoint-GUID: RwrzqJPBbpo_D5q06J5hr42-dqrzoCOQ
X-Proofpoint-ORIG-GUID: RwrzqJPBbpo_D5q06J5hr42-dqrzoCOQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_07,2024-08-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=880 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2408280120

> On Aug 28, 2024, at 6:32=E2=80=AFAM, Eric W. Biederman =
<ebiederm@xmission.com> wrote:
>=20
> One of my original concerns is that allowing changing the =
/proc/self/exe
> has the potential to make /proc/self/exe unreliable and specifically =
it
> has the potential for a rouge program to hide itself by setting a =
false
> /proc/self/exe.
>=20
> That is part of the reason for the red tape.
>=20
> Maybe I am wrong but I am concerned that your change may be making it
> too easy to change /proc/self/exe, and would too easily allow setting =
a
> false /proc/self/exe.
>=20
> So it may make better sense to have a special case for interpreters,
> so we don't have to worry about people setting a false /proc/self/exe.

After sending this it was pointed out to me that the ioctl actually =
requires CAP_SYS_RESOURCE. On one hand, this resolves the problem of a =
rogue program - it would already have to be privileged. On the other =
hand, this makes it that much harder for FEX to use because it would =
have to rely on getting setcapped during installation, and we'd like to =
be able to make use of sandboxed binfmt_misc[1] to install FEX in an =
unprivileged user namespace.

I would prefer resurrecting the last proposal for a special case for =
interpreters in some form, given the above and also that the previous =
proposal would always allow you to see the interpreter from a different =
/proc file, *somewhat* reducing the security concerns...

A thought: Being registered in binfmt_misc already means you're =
privileged, so it would seem to be ok to allow the interpreter this =
extra privilege. In the case of unprivileged/sandboxed binfmt_misc, it =
would be sufficient to only change the view of /proc/self/exe for =
processes in the user namespace with the interpreter registered. But is =
it ok for a view of procfs to be dependent on the user namespace and not =
just the pid namespace..? is there prior art?

> Looking at the code I am a bit perplexed at the moment as I don't see
> a check currently to ensure the new exe_file is actually mapped.

Yes - since the check was just to avoid confusion with =
num_exe_file_vmas, not for any serious reason, it seems...

>=20
> ...
>=20
> Beyond that your change reduces replace_mm_exe_file to set_mm_exe_file
> so it would probably make sense to combine the two of them if you
> are going to go this far.
>=20
> Eric

[1]: =
https://lore.kernel.org/all/20211216112659.310979-2-brauner@kernel.org/=

