Return-Path: <linux-kernel+bounces-342715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAE7989206
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 01:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06C52843DE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 23:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C358187875;
	Sat, 28 Sep 2024 23:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b="OLobDaid";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="nlekskVz"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B871DFF0
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 23:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727566989; cv=none; b=uAuwI8rZsTHI93Dp6eee2EiiuT+1HqR0s8aby5UjAohUbdEt5mgOvta1Xlg5X9+7u4fUmsVFJKuz1oFA6XV+HIQiwhIMNoR48tIVmH6/mFQNFqLQtszHF51GQ5OUkN8PTEh+YEGEIQdAzLCbVS626DPlWDVE65kEd/D+qL/jop0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727566989; c=relaxed/simple;
	bh=BWCVkPWkmquLZakojwWCB1NPLhmscnfGPhreYqIdQOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b9eOe1WZKh3+Iz4ogYAK+6c+v/R6WM9WWPqyLpTSxWGZrID1SzSXrHlGf4uBt2IC5zdEyjKKTUd+O362+nEZexCPuKtCWCyFDBBV/F9e3pUbIq7llMalsdGrjx1WlOepW6xTjPqAK48S7IxY3X2FYOrFhc5erV54p0MVrg1dXog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev; spf=pass smtp.mailfrom=lkcamp.dev; dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b=OLobDaid; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=nlekskVz; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lkcamp.dev
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=OLobDaidpSlfZgzzWq0ATmqnyDTY7bncWC0s2v31brlJS1u4/dHCsGywWb/+kGwYxFMQ05rsgeq+JQwJHYaCOmnKldL8V5kS5+PQnOOLgo9f5igo1dVHhJDZ8hkir9auGU3xk611ymHVauQsHV43ERj01F+i7i+ymebi+7OjqW+gTff38bXzsPOpwDWN9X5+qNHYqsjNbKPgXaBzD6BkIIwQmMVs6Z+NjHzk4iSmRe9tdyH6iJAbxvn3ktcHJuuZOHMamPwl5BAMCmOIIyzu2TC7PoOLAhxhpXOZTWcTLBijEMKPH9QHYoRkDoisQkKIBumUSQKaH4wTEIkyMOZEqA==; s=purelymail1; d=lkcamp.dev; v=1; bh=BWCVkPWkmquLZakojwWCB1NPLhmscnfGPhreYqIdQOg=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=nlekskVzgzqhNCpI00Qfg3eoaY7I08GudKMM9TNh6X9MHmwnNzFYS9K4QLuqrzmV1m6mEByrmOY692Enh7cxHb2HKr2ESNYb4KxhfSFabNHjemMki+qruoH+5iSjoDASu2hHfpd//71mtqFh/Ju7Lbr35/4ZkdhQ5/3hK2NEvtFW+LTo9YYPU59ZJy4sr0PQ5WYpseVqnxyr+h2hjsAzgzbQXmnrewZB+WSLptPevQfjNS8I7jiylw6KBOxn7R8AJrR0OMdfCsTnqXX2nQDBY3wNj4xk2yDVdXPz7b7QY1iuSeW40KH+16BBzavrijOAgu13A92OUA0GKfKTRJsBIQ==; s=purelymail1; d=purelymail.com; v=1; bh=BWCVkPWkmquLZakojwWCB1NPLhmscnfGPhreYqIdQOg=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 40598:7130:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 975610571;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 28 Sep 2024 23:42:50 +0000 (UTC)
From: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
To: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Cc: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
Subject: [PATCH] Add information on checkpatch warning about `help` in modules
Date: Sat, 28 Sep 2024 20:46:44 -0300
Message-ID: <20240928234649.193664-1-gbittencourt@lkcamp.dev>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Add lines number information to warning of `module help` on Kconfig.
On the creation of a new module, if `help` section is smaller than 4
lines, checkpatch.pl gives a warning asking for a fully description. So
add the information of the minimal required lines to be considered a
fully description.

Signed-off-by: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
---

Hi all,

I'm kind of new at linux development and I'm not sure if that's the best
solution. It is just an easy one that I found that fixes the problem.
If it should not be done as I proposed, I will be happy to change the
solution.

:)

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


