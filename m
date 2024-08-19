Return-Path: <linux-kernel+bounces-292669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AC895728F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4088E282958
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5B8188CBE;
	Mon, 19 Aug 2024 17:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="mcictMM/"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B248176AB9
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 17:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724090329; cv=none; b=fjPXFGe1OwXps7qVKzjLbtDN4zU59fUMoBhHLMNNmFGFVuzbzFJBMXa7ppezNhQARpvwdheu84IF6BMKf+ce3q9Z8dQlx/FKaFTUIA6zQH+6cBXb3+q1DhyG8BtLuyeI/Gr7p7Sr0hWL4f+axlVEM+MNyFAKtALJHw4X1SyscYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724090329; c=relaxed/simple;
	bh=yLyg9V7XhkvVXxauBZI5xtyTwT6dA9OEKL3nbZMAijo=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=IeAtG8t1iZuZXULWoW3/y0GdiV5IdSrq46AzpkmF0ilNzJuTLgqIPNu6r3pCp83DA2I0FHjLtLHDWmSvOLlgJem4rbdDswG4dSfeInao6FYv+Fe6Oa5gKID6qtjKMbo8aA1a0KB68nVjnYrnAwtyWWyOb3u6GWMc0ctixmI9BHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=mcictMM/; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1724090320; x=1724349520;
	bh=yLyg9V7XhkvVXxauBZI5xtyTwT6dA9OEKL3nbZMAijo=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=mcictMM//pGL+W+7t4/Sa+T5rP98itAqQ/FXUfTGlUBUUNxusdEamApWh744ne16k
	 6QHulSwI44w4d44QgpmR2O7h4g0MxtGh1xyds86pbAFhr/tp9cWJ6jHh3CJ6RWo815
	 SyhZFuq4Y1yrczAPBgfiJt98chBfy1jgHn/FnxXD++hMX4QUJEYiqUbdPLtQzYbsoG
	 ZpKlcGfXz9fjuEQG+kTvlckoAlOAYkuuCA/3nN1VAO04Ij5pm58FGzOPmNr63XUOy7
	 27Q47uEdEpiU+Iv9EH/mYhzdeKRdjPp9JUNNtno8PK4ZLTi1bFQ8wH/KzZ7lIFjj+0
	 zv/O2Xwi43CBQ==
Date: Mon, 19 Aug 2024 17:58:34 +0000
To: anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, jstultz@google.com, sboyd@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From: Piotr Zalewski <pZ010001011111@proton.me>
Cc: Piotr Zalewski <pZ010001011111@proton.me>, Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH] kselftest: timers: Fix const correctness
Message-ID: <20240819174814.139344-3-pZ010001011111@proton.me>
Feedback-ID: 53478694:user:proton
X-Pm-Message-ID: 0c572e0225d05ecc79ba83a6ca58e75e9ec342dc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Make timespec pointers, pointers to const in checklist function. As a
consequence, make list parameter in checklist function pointer to const
as well. Const-correctness increases readability.

Improvement was found by running cppcheck tool on the patched file as
follows:
```
cppcheck --enable=3Dall \
=09tools/testing/selftests/timers/threadtest.c \
=09--suppress=3DmissingIncludeSystem \
=09--suppress=3DunusedFunction
```

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Piotr Zalewski <pZ010001011111@proton.me>
---
 tools/testing/selftests/timers/threadtest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/timers/threadtest.c b/tools/testing/se=
lftests/timers/threadtest.c
index 76b38e41d9c7..d5564bbf0e50 100644
--- a/tools/testing/selftests/timers/threadtest.c
+++ b/tools/testing/selftests/timers/threadtest.c
@@ -38,10 +38,10 @@ struct timespec global_list[LISTSIZE];
 int listcount =3D 0;
=20
=20
-void checklist(struct timespec *list, int size)
+void checklist(const struct timespec *list, int size)
 {
 =09int i, j;
-=09struct timespec *a, *b;
+=09const struct timespec *a, *b;
=20
 =09/* scan the list */
 =09for (i =3D 0; i < size-1; i++) {
--=20
2.46.0



