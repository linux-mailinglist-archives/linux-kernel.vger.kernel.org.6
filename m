Return-Path: <linux-kernel+bounces-364237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F336099CE69
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEB0728722B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D731ABEDF;
	Mon, 14 Oct 2024 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nl4zCvvI"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC731AB507
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917001; cv=none; b=qSojlperpWgK3sm72AQhvCJXkXm0ae42tVefEKeriOge6vkCwZrLckaUQM1A4hL7oTuHZNv5uT0kbvSG7gEhbs7evgzdM/AKo/qZ63/yxohRsz8K/3D0mznEImbvJt+5k4XEfLUE5es2L1Ua5OPDMBHJ96I2UoF2Py0/ULrGdpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917001; c=relaxed/simple;
	bh=1Ab4Ey5QXU+vB2NJeLjQPkHniyVRC+1msLRZlD5sSSY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QhyVaY2QMfpVgkQViJ7LXhqnT9a6vJo1ehxwxYTCXFGLOAaxRPfKA2VfI4+HTqbUfnWFszzeNXblk257jboHUlEYMOdSfRph7SiEqszR8DN0MbF2rp2B4PcJiciMFy8JVZx6r5Ck9b+QfPLTT7YsFvvaY7eslf19DGIm7g2v6MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nl4zCvvI; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e31e5d1739so64803547b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728916998; x=1729521798; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tkrU2MksDek0g6FFQZ48XdTMy4B6SNmPFuBaH6YaEgk=;
        b=Nl4zCvvIfiEkVvYfYuZvO0JHP9INbkCapbpI26g20J282qMQ8COJ9Icd2czJothPWg
         CRAueduo2UkBZUB0E+b0UALiiCusM9XS5EZDKgDqxZVIbbXa/NjkXEzwZe1A2eqzsr0d
         ldT+eCPgUV7qalEjH74SeugM4gdXUiy9tJ/WsvFxPx0WGTJPZ/mMRRRWYtJGm6gvOD1x
         p262qOAWAtMCN05fvfPSbgOlYqJYxLBxqxKE1WeiA3eqtv0oUD+2EXhUdWxYPyPMVule
         r7YqIhPsUXgGXBNbKCLIBBhBg8ldoOl9tniE0eTVUXkWivqY/p01kIDKr1+bJc5YZ5Bf
         amkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728916998; x=1729521798;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tkrU2MksDek0g6FFQZ48XdTMy4B6SNmPFuBaH6YaEgk=;
        b=vPIYVxLLtmNbtynVoKUs50ppY84AofQloZin//EI2DQ3umWDNeHtI9wS4RKhiFGl0S
         LGHGJibL+HMBhoBVqkRPh02b6HHQ6tmqSMjFqQdRt1Tln4aYNjZ+KaREX4NuxBcVhhgH
         yOIm8tmg/Y899p+Eq6Zd3nmkvigdQiEL2ZOsrX8ogAsW5JnFJeeZK6itnzkuerRKh1mR
         ReU3gx3VbjcsZCICrP7tA53umZ32YNPjC09/+jjnPoDxvKwBqc9ujItlEJj4qbbeBK3H
         FTFDKZnJWM7kawPflvYwkKLwpySxD85xIJ91wf2vw7fllBbWhDg8bQUMqgHTtWblJNzJ
         JsVw==
X-Forwarded-Encrypted: i=1; AJvYcCVmNfAWGGqa993Lp4/+G4NObbKxPkEXMSTOGNehP01npZSsFLgRTlLaxCRkRVGDbJFfNRkoNLOjCcxoyW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmsO09+qiLsp4RYIoBFa+XoaKEIX91o7gHuR2JIdScwiI/LigO
	rWSGIFfxwcC4F4Fh1oqQGTCzyWdVW6i2qbCx5jmJfj+bwLR19OolHlZTnscl8WOoU3ia786auA=
	=
X-Google-Smtp-Source: AGHT+IGOZIRVbybxKmRG3LAhsJlADqwyPTuCZyf6SS8Mn6P1fCKW2Tjglz37+tpfNKxAdvOyMUBeqVzD/Q==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:9a7c:c6fa:d24e:a813])
 (user=elver job=sendgmr) by 2002:a05:690c:4449:b0:6e2:2c72:3abb with SMTP id
 00721157ae682-6e347c85db8mr2957767b3.7.1728916998286; Mon, 14 Oct 2024
 07:43:18 -0700 (PDT)
Date: Mon, 14 Oct 2024 16:42:53 +0200
In-Reply-To: <20241014144300.3182961-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241014144300.3182961-1-elver@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241014144300.3182961-2-elver@google.com>
Subject: [PATCH 2/2] kcsan: Remove redundant call of kallsyms_lookup_name()
From: Marco Elver <elver@google.com>
To: elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Boqun Feng <boqun.feng@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Ran Xiaokai <ran.xiaokai@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

There is no need to repeatedly call kallsyms_lookup_name, we can reuse
the return value of this function.

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/debugfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index b14072071889..2af39ba5b70b 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -179,8 +179,7 @@ static ssize_t insert_report_filterlist(const char *func)
 	}
 
 	/* Note: deduplicating should be done in userspace. */
-	report_filterlist.addrs[report_filterlist.used++] =
-		kallsyms_lookup_name(func);
+	report_filterlist.addrs[report_filterlist.used++] = addr;
 	report_filterlist.sorted = false;
 
 	raw_spin_unlock_irqrestore(&report_filterlist_lock, flags);
-- 
2.47.0.rc1.288.g06298d1525-goog


