Return-Path: <linux-kernel+bounces-192182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD588D198F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C65D28890B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D62416C69F;
	Tue, 28 May 2024 11:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ErXr+ajk"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0F57D07D
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896016; cv=none; b=AFhnhfSFeAM8In1XxAu/8JHsFpRlederPca9hg6X/+SKdrvd7UeIcdOT09tKWaUG4dJKQ5/j8f99vRvO2L3PeBIzJqA6295kIq+tDBy7gCOWY6VBpqK6DChCW9UN1DnfO+HQfkVrUdAqpndc8O9wtOHLrQ6kF9ETkouMR4HMZ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896016; c=relaxed/simple;
	bh=pVkfCfXwvpGITqeArgg8XorBGEqsQIg7EkQ5urfJgbQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cfa/3Z4PbVLTg3nKDeBVR6N10bM26Vh57kXn7KxXhx526joRqqShtpYPa7f3CuueXeuOE5o1A2zEWdUurYauhCw9zyFv+GL7lLlff8BHGsjndwQh13jhUBCTRk50SJ7BjObdqaGKrk0sSdM4DsZJEGLpZAJwtCLYMbVb++6jCjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maennich.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ErXr+ajk; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maennich.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-42120a4c56eso2143285e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 04:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716896013; x=1717500813; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pTOxhoHq0Nkxf/74IFjzbYdMxemeJfpZA9XvBTvTfc4=;
        b=ErXr+ajkwW8QC39Mej+rxdrFeYUwVnx/x0bXfsBYisomxuLsZpmRb8iBz6j+fd1Wzp
         omwdzrak9vItrH6+cW+YktjF0vAmUUmG1XS1XR25aLRpYq/hHFCnUoy7At3g5EVgZp5Y
         8zSj0Uz40Ztpbv0TaV7ljrJ8WgqXb3HnRhUWoVYesIvoQsUGC0DYkaGb563A+vXYyIIW
         y8ej/2RESLsXc1B6bz2EPbldrQJeJ4Y9UYZt0e3loev6KU/jvHBfmkU78qmlMVF4wWc4
         Md030pqFfjorYLkp2UFfkCx1Wsv+gsdOoib+EOCpfUgoUduH3Dt3mGUn7Ns/q9zYguCr
         mizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716896013; x=1717500813;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pTOxhoHq0Nkxf/74IFjzbYdMxemeJfpZA9XvBTvTfc4=;
        b=kg33HftfGNH52QLmrJ/k4tVsTjpDly5FTyS6a2ite5I6vS3Dshw4l1gkF7ulwCOl+T
         fepUzBvrFLJnyEhQXDnRigEPmlEnc4bLLf69+wWxHW1ftkhIKCANH5wO3gbymvzIB/Jc
         8ZX6JxHvRWX2dIDAOK7SnhgOhlB1B8HwVK8O9Ubw/MxLP2eyADDvWpv6vDYOozTubS7S
         TkrSzsX6fWxPvB183A+cuCKmBY3uHlVoXse4Pmou3BgFTzk5MzhF22rJ33L7E3b53Z+8
         TdRU+IRffbFL8uu+BIr1oFdqQEu1FS6f1A8/mCofNkpkh1Lt2osvyXrAvHBrfXVRB9A8
         2V1g==
X-Gm-Message-State: AOJu0Yxat12y1Zxn+do78apIaB9po0iaLyj/C6yg1XqhW80Iox2rBGME
	lXIM9p9a+RH+g3e4pc/3czUFQOpw5kCOj/AeJcxxumyJuDSx00nOJuAUe1RgcfdbqAFjvK2I3UQ
	DJs+KHku8YX4s+jGBTRz1egUTq85Vj54mfsYOuaH0gLllZJ6U4mtaZxhq1RDwE+glPzN1f0jMlJ
	QiQIzyfVt7T+D9OOULzSxhdJ4jTD9GPawQIkf89FH1C1KSBsrbCc0=
X-Google-Smtp-Source: AGHT+IEZuPpg1yO7fn0IEIKwi0X1YijuMLbkk9FqYxMx51RJlFRj8VX6O6wgo1ofZTORDUJHHcMrL76AmO0uAA==
X-Received: from licht.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:f9c])
 (user=maennich job=sendgmr) by 2002:a05:600c:4704:b0:41f:41fc:318b with SMTP
 id 5b1f17b1804b1-42108205095mr2453645e9.4.1716896013057; Tue, 28 May 2024
 04:33:33 -0700 (PDT)
Date: Tue, 28 May 2024 11:32:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240528113243.827490-2-maennich@google.com>
Subject: [PATCH] kheaders: explicitly define file modes for archived headers
From: "=?UTF-8?q?Matthias=20M=C3=A4nnich?=" <maennich@google.com>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com, maennich@google.com, gprocida@google.com, 
	stable@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Masahiro Yamada <masahiroy@kernel.org>, Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"

From: Matthias Maennich <maennich@google.com>

Build environments might be running with different umask settings
resulting in indeterministic file modes for the files contained in
kheaders.tar.xz. The file itself is served with 444, i.e. world
readable. Archive the files explicitly with 744,a+X to improve
reproducibility across build environments.

--mode=0444 is not suitable as directories need to be executable. Also,
444 makes it hard to delete all the readonly files after extraction.

Cc: stable@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Matthias Maennich <maennich@google.com>
---
 kernel/gen_kheaders.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
index 6d443ea22bb7..8b6e0c2bc0df 100755
--- a/kernel/gen_kheaders.sh
+++ b/kernel/gen_kheaders.sh
@@ -84,7 +84,7 @@ find $cpio_dir -type f -print0 |
 
 # Create archive and try to normalize metadata for reproducibility.
 tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=$KBUILD_BUILD_TIMESTAMP}" \
-    --owner=0 --group=0 --sort=name --numeric-owner \
+    --owner=0 --group=0 --sort=name --numeric-owner --mode=u=rw,go=r,a+X \
     -I $XZ -cf $tarfile -C $cpio_dir/ . > /dev/null
 
 echo $headers_md5 > kernel/kheaders.md5
-- 
2.45.1.288.g0e0cd299f1-goog


