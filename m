Return-Path: <linux-kernel+bounces-335253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7D797E320
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 22:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05AC1F210F1
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 20:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA1F64CEC;
	Sun, 22 Sep 2024 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b="qzG8Zztk";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="H1JgRu0i"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E2936124
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 20:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727035976; cv=none; b=fjEiTMvHeMkFb+TvMIgi/lLemvwKt4uzgNVJQivpzkBJzyuKUTXYZhtic914NmOxzZzPK5PlBKYoFf60J4C0J9mTD7C0YoeYE60Pa37cZncU5y6pwYisVB0lRFotrzTNvl6e+AYmK6FhCwqFYunPNcZDFqB6F7cnsaB6Wvd6iHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727035976; c=relaxed/simple;
	bh=2nL+gJE/xUGOiECsRdkY2s0zPbV1/VkEl3IslBMeitQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pcJlqL/+yKTvOl3mTxLi12rMKdRZTh+glFe4p9cefPXgrbzbqpK8Y0UJxY5hiy86pGNAfXz+PDzKLGRpb2TBA7nu61/M3BrI9S0tS56AiTIHOGOH++mOqbWGtnFOO95cV2QSxhe+HiPHsvwCwi6Br/cmZorCRsWyy8azk4w+ATg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev; spf=pass smtp.mailfrom=lkcamp.dev; dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b=qzG8Zztk; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=H1JgRu0i; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lkcamp.dev
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=qzG8Zztkh5s1Lo9kFLi7yd2tIHiUtOP8OPV7KOFTq9jC/OmlZZET4a0WCVAkGTlei2DMVK6mO8caOENY6vLLjx60xtHVGBzdLXIGU23FvWM4AWPDz8sNfvjAfZ7Sy0ZLXdpXedvZLZxlV0k2Q18CwAV9h07C7FVCLRaUTcIwvQqgLRiT7vh6+7QOZ8ADuCrtYq2CmZVdk6MWKikBhrCC5s391+orQ//X4HpzdXjqZUHMMMNO//yXwI7cX7lTVl5L4rx9TyGecoH6yW/ISJ+fF6ggXgLstckrOqS7ZDiPwq0cU3IbEN++yqZeLNZ4Dv3COSn/iem6+o7N5amOD89yrA==; s=purelymail3; d=lkcamp.dev; v=1; bh=2nL+gJE/xUGOiECsRdkY2s0zPbV1/VkEl3IslBMeitQ=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=H1JgRu0i9rjs8jMpsoYZ6W+9wxQxg+2aS7L0IFMyz++04AEIZB+EfAnahidG4fG5IBlk+mmjs1iBt8draySacfkJBe9GUvh6RXIj3SVgxLFBQmKgJ+DKk8H1GglVRZm7nYs5loGXzZe67v9fPi38UVSAN4LJIOPXtzkgPgGBjbrVPPIfXr6WZShDny2YI/xNhJFVbLG8xGxG6uJYR0GmZ8maKVT7Gbmt4xgpKA+Wu+mELQPllllZpl9Rj8OO+1Wt4ard/i8TEobA3Iy990mYMNcHoNbeUqJhlgW4um34eWCfuswuLNT9LUCxfjLnGJmF0DttmOrRubX8JfjkowNQJQ==; s=purelymail3; d=purelymail.com; v=1; bh=2nL+gJE/xUGOiECsRdkY2s0zPbV1/VkEl3IslBMeitQ=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 40598:7130:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1095037770;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 22 Sep 2024 20:12:43 +0000 (UTC)
From: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
To: Gabriel Krisman Bertazi <krisman@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Cc: porlando@lkcamp.dev,
	dpereira@lkcamp.dev
Subject: [PATCH 2/2] unicode: kunit: change tests filename and path
Date: Sun, 22 Sep 2024 17:16:31 -0300
Message-ID: <20240922201631.179925-3-gbittencourt@lkcamp.dev>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240922201631.179925-1-gbittencourt@lkcamp.dev>
References: <20240922201631.179925-1-gbittencourt@lkcamp.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Change utf8 kunit test filename and path to follow the style
convention on Documentation/dev-tools/kunit/style.rst

Co-developed-by: Pedro Orlando <porlando@lkcamp.dev>
Signed-off-by: Pedro Orlando <porlando@lkcamp.dev>
Co-developed-by: Danilo Pereira <dpereira@lkcamp.dev>
Signed-off-by: Danilo Pereira <dpereira@lkcamp.dev>
Signed-off-by: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
---
 fs/unicode/Makefile                                | 2 +-
 fs/unicode/{ =3D> tests}/.kunitconfig                | 0
 fs/unicode/{utf8-selftest.c =3D> tests/utf8_kunit.c} | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename fs/unicode/{ =3D> tests}/.kunitconfig (100%)
 rename fs/unicode/{utf8-selftest.c =3D> tests/utf8_kunit.c} (100%)

diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
index 37bbcbc628a1..d95be7fb9f6b 100644
--- a/fs/unicode/Makefile
+++ b/fs/unicode/Makefile
@@ -4,7 +4,7 @@ ifneq ($(CONFIG_UNICODE),)
 obj-y=09=09=09+=3D unicode.o
 endif
 obj-$(CONFIG_UNICODE)=09+=3D utf8data.o
-obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) +=3D utf8-selftest.o
+obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) +=3D tests/utf8_kunit.o
=20
 unicode-y :=3D utf8-norm.o utf8-core.o
=20
diff --git a/fs/unicode/.kunitconfig b/fs/unicode/tests/.kunitconfig
similarity index 100%
rename from fs/unicode/.kunitconfig
rename to fs/unicode/tests/.kunitconfig
diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/tests/utf8_kunit.c
similarity index 100%
rename from fs/unicode/utf8-selftest.c
rename to fs/unicode/tests/utf8_kunit.c
--=20
2.46.1


