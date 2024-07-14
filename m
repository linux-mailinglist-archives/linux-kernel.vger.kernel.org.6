Return-Path: <linux-kernel+bounces-251772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C92930991
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 12:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7536D1C20B67
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 10:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A4249635;
	Sun, 14 Jul 2024 10:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="Q5HV8WPZ"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8365E9474
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 10:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720953290; cv=none; b=s9KtYqj7HDwVqapCjeAFQ1p8HWVjgdP1cfUI71EMzYdYNXHIaKAim1D3sNVE351v1QmpE0LxsDuX6UuFQi6EfZQ25RvvgjeyhvN5jyLpqGHEa2/91ccg0paJTuTlosJN0L58Vs0OzItgBOhSVkFSPeEE222+FozDoPIUsPfqOuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720953290; c=relaxed/simple;
	bh=TCoTsuk02vFs+wj9UADhgklJlJC4o+EtzSo1YS5pBA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjk/Pp4twjZjrn25if2VXJF0+J8/tRThp2rItzZz7zToUANX5+e/zgBdGmV5G7TjcGhLugl/LSnT+abXB1/pqUTQPcZX73EHXhNXmIznj1lmkUXtopfHPS6aZO8/gL04sh+OmMGhsfhhvKKrWuWoj4IY6IsgD6QdBTO4Inkn6fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=Q5HV8WPZ; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720953280; x=1721558080; i=spasswolf@web.de;
	bh=rGzxEGjJSZ+8lQqjIYReLGBghDBxm5NKnpuTpcd1B0A=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Q5HV8WPZJQH8WFeb0EhCfdDqpTuIBlDVojS9UhQ43YnUHyJPBzEFQokBndLgBm0U
	 fJIlfUztFrX2O83igcm6UmIh0WkCkqvKkok+9o8XGE1dO3qGaRILHR463fpOH8UWL
	 PKPpJ4lExt3Pp3ieA8x+RKv97DW9OrZ9NV74Cebwcf/zIRXIhfe0ne/Se2tz7/uM5
	 Eh9QdyNhvvrLd3LZGZbF8k6Ul1k+UdGqo+Pgt/DLfz/EuJIDhP/pdRUZeS1fXX5oa
	 0cd8VJCE5wnjJ/CvdHuNIR2uihUK3sJ4gFU+3oZbjlHTYwu0Fm+AnmpT1yR0yorEA
	 hDPq9daCgRX5V0twow==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MJnvp-1smWgT1K01-00L5kJ; Sun, 14 Jul 2024 12:34:40 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: deb-pkg: fix building with bindeb-pkg
Date: Sun, 14 Jul 2024 12:34:37 +0200
Message-ID: <20240714103438.4146-1-spasswolf@web.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: 20240709181422.156829-1-spasswolf@web.de
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T9IW83t5MgxddXywhJhB5sbHXtwgCbYQSIBrfL/hLsPGbhuQDsD
 PcFzCPmSsZRS/1VzXcvoTQ35EDGTU2v3BunuJEfb5PjKmJJWjiRZHzoP2sOpwBf3/IEKKYh
 w8mgK22aaNgZp/8HMRekHu+4HYeTFx6wzUd4SfHX2bfGx+U2A+hx3x7pouYZx5QJCxGW7R1
 jnMmF/5x+WeBQaZSaUbDg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5g2tyLprJpo=;XavcKi6tDn44Nobr7QLvdWwvECQ
 HLVSUw5Pui/6aImQnwza+dtmtRbWQI+bhXhGLM4CukDcq1BgbRyq3L4ofQARCn3XpOB/JKPWs
 Bxy8TVuYeqx/uBUcRZ99F85MTArBKdOzKzWd5z0Z9uLuAYUQNKAjBgm5FR8+svcWnrg1+q/ab
 dDVS2vhW8lSG3nuGaGyHKe2r+gCcRzZPq1r+osD4PD86tsWMeEzH16aqq6kyZhu5yQGBUOLc/
 d+xRuuP2h06lHOXmOAJZu/74vfXBaVGuWAk6FQQ964ZaCU7uJ16kqVvVDQUpdl7mW9U6VYmSM
 k5DKYvcrLrjQhlcroNFw5YRRMZz/uY46fBvNTU/qzahgwZR0RlQNF1Ky97GNknLjfEfDbZDeI
 wzshOH0IaFiaUaTcVHpyndK/mLRzZcqL7hx+VwaHVDz/d1Uufnucy3buJG9c3xi4OmmHrVTfH
 oBYrtMHRWOF3TFP5UdzmN3Dnsu8v/zX+ik4f13xMB0aY3Cc1KekCIkTxBmED8/HlawQorVc9S
 MghvU4OLpNAkg14/PUm7pnlZJpr1iw5KbacfBeQgsALxMzrQx6aLJhDE+TlZ8oIceptPY26AD
 jlHf+mUoWPEFGGJGJAGyEFeqlgsAKYSuMt4ba+w5qhY/9GIigKfKyHKPoQisKTdmHe3Cuf8zg
 qD2F7UOVN1bcdyPhor0J9N9dBCyDEUXw1+JTsKLhF8sZVhvnPV4uMQdJ+yXgRcd9UFulcLl4r
 rYSBq/FwwiH8x0tq9zM9d01TONRNtBWOeR7C1LBe3OCotcnINEquKekHHTjUDH6GkSnGqOW3f
 te+Sa1r+SpgyM/qquAmhyWYg==

Since the introduction of "set -u" into scripts/package/mkdebian running
the mkdebian scripts fails when it is called with no arguments (which is
the case when building the kernel with 'make bindeb-pkg'). This patch
introduces an additional check so mkdebian can be run without arguments.

Fixes: 8ef052389f7f ("kbuild: package: add -e and -u options to some shell=
 scripts")

Signed-off-by: Bert Karwatzki <spasswolf@web.de>
=2D--
 scripts/package/mkdebian | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index 196b14e8ad47..5eb506573a4d 100755
=2D-- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -135,7 +135,7 @@ else
 fi
 maintainer=3D"${name} <${email}>"

-if [ "$1" =3D --need-source ]; then
+if [ $# -eq 1 ] [ "$1" =3D --need-source ]; then
 	gen_source
 fi

=2D-
2.45.2


