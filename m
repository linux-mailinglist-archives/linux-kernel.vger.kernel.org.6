Return-Path: <linux-kernel+bounces-349490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FA898F6E7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BE22B2381C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 19:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2302E1A7043;
	Thu,  3 Oct 2024 19:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b="uQHWzEZo";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="TVL4ogQu"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D021AB524
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 19:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727982985; cv=none; b=rsxKPLUbFvAkmSEtW/rrJ09oraBbMLR5d3ppKPDNLoU2ohQwINRxU+RxSHwUxi+nSfSaf1+HJVSzizH9RWmVbI2ZNa6U3ctwZ0xeE9v6ahgz73FwS0Cr+GMbtL63LMkH9+NdUclPfwACMvktuO+MhQmafumNn0srmVDlujLLVh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727982985; c=relaxed/simple;
	bh=2z4u3JtN9/K+dytqShSPwhux+dCrAsHZqqo0uIc838M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HO2EZMNpXiZ9ZEXZd46eRGoCUoOjnPUcHDxlux9JPVSkLtYM0nd13zELq5Y2fTH7zfKpIu01IF92e45OPgeQE38UrqzTVTq8PxzNO9NrgCvyx4joaVMEivs5Mf7BpXGVUzeXOKGLIzSUe3gzP9vUH7lzvPKLvFT+vDyRuee1CIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev; spf=pass smtp.mailfrom=lkcamp.dev; dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b=uQHWzEZo; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=TVL4ogQu; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lkcamp.dev
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=uQHWzEZoKTJtMiS/eI4Y0o2yl1RtU92ZlrxPvluKt/qvuOP3/CFhX4N8wHdXV7+LDQNvna4kJVdl99SjjBEGbQ4chzBMenBUd3hzHU9Itn+7YsnTtJcKAs80u/6XyZAP5+fxUdQgS1JH2sduj3On9WUipPUEEopoLw4nheqjpFQO4Pu2yaFAvGvW9k78z3xfmWSfQMtx3zfUafSiX6pcdvrYl52LoOzA1HvPySUJEtCmL6NAVreeZYRZ5TUnzzmAyiHVhgUEPikliLlkDRyBraoK9MtT/qgTMebLN4fZAmOaQTF+alfrh2ta3q3SB+qoLy/9Y2TVDRUIfBUHv/n7qQ==; s=purelymail2; d=lkcamp.dev; v=1; bh=2z4u3JtN9/K+dytqShSPwhux+dCrAsHZqqo0uIc838M=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=TVL4ogQupoTGjYgc0ghQ7Vs0PNpUIwv8BerdlJL/0/Y3EN9OPKyP4mo/GtKvPYJSpW2Q6Efn8MisCyZOf+kJnFn/kCSO0DumzD9OUf3ALefLm2Hej/y/9VyDQq1GFyoHdISixKgGtexfGOY3aA5SbOHjfDyWhC1uEh84DpJN5kJqVd9FYpqojeYv4/CiBBL0dHEY4Eiy81sMymYd+/JBfBe9nBzH53QEp1uAPbLo0we+qLTAvZu689MbLS2k9fbNePs1ExdBkuqQaSg36xdwVrsZIaUH5kUPhtPN1el8tOiX719AR71p91ysnAAEqD0E/RyuguMv4GT2xUuo3RTWrQ==; s=purelymail2; d=purelymail.com; v=1; bh=2z4u3JtN9/K+dytqShSPwhux+dCrAsHZqqo0uIc838M=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 40598:7130:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1775879529;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 03 Oct 2024 19:16:07 +0000 (UTC)
From: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
To: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Cc: Gabriela Bittencourt <gbittencourt@lkcamp.dev>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v2] checkpatch: add information on warning about `help` in Kconfig
Date: Thu,  3 Oct 2024 16:20:00 -0300
Message-ID: <20241003192012.3736-1-gbittencourt@lkcamp.dev>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

When writing a short help paragraph for a new KConfig option, developers
are prompted the following warning:

`please write a help paragraph that fully describes the config symbol`

However, developers might get confused about this message, giving that
they do have written a help paragraph, but checkpatch is not happy about
it, which can be perceived as a false positive. That happens because
checkpatch considers a fully descriptive paragraph one if at least
`$min_conf_desc_length` lines (as of now, 4 lines).

To make the warning more clear, output in the message the expected
length of the paragraph, so developers know better what checkpatch wants
from them.

Suggested-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Signed-off-by: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4427572b2477..8a6b6c22b175 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3660,7 +3660,7 @@ sub process {
 =09=09=09    $help_length < $min_conf_desc_length) {
 =09=09=09=09my $stat_real =3D get_stat_real($linenr, $ln - 1);
 =09=09=09=09WARN("CONFIG_DESCRIPTION",
-=09=09=09=09     "please write a help paragraph that fully describes the c=
onfig symbol\n" . "$here\n$stat_real\n");
+=09=09=09=09     "please write a help paragraph with at least $min_conf_de=
sc_length lines that fully describes the config symbol\n" . "$here\n$stat_r=
eal\n");
 =09=09=09}
 =09=09}
=20
2.46.2


