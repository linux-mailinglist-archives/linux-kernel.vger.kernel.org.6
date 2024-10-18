Return-Path: <linux-kernel+bounces-371245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06469A3881
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 222ADB23473
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CC718E03C;
	Fri, 18 Oct 2024 08:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/lRxRkT"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6A115445B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 08:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729240110; cv=none; b=FCphFflTFq5ANR4PPneJ27Zh8HkMTdPR7jJ/okoDX5y28ANTq0zk7hAYgrwPA6TNTqRGr/UkQjcHhKqqGwxU+Bd1No6+jFzvDWAaeUbn4HTg5Fk1ofVKT8m0iJ7W40mzxySxrZ15SAoI+j86QiRXcWwf1h24xP8f1l4HP0NZ2iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729240110; c=relaxed/simple;
	bh=LI9qeWd+INrMgIv0Xj9Wn4x6GWKT/UJ3XXt6igzTfKA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jf10JM1F59uDr6LD/UMat6KZfSO0t0F069t2j+43Eh1nuoCGlGx0j/lT1uJrv4aZrLmwYLwrSSCn9J6RIdLzy1M1qKnlf6L0QmlzGCqOVEjPzmWudgp9XVL4nyMzQQ3yGeUQ/d5LwW3SfNySAc1KwIZuBg2JlXp+hnlK547z97M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/lRxRkT; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20e6981ca77so539555ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 01:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729240108; x=1729844908; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w3R+DG0W9j/rrWWMMX7Q5Mr3+2LO1x036RhMhClSpMc=;
        b=k/lRxRkTGbujVJ5M3sa/U+ap3pxFO184MpiJenLMyRH/BtQCWmoR6pW9v0Fvg/WzeR
         5oxtbzFNX3Tkgbd38Za0AcbMq1CFMy0YhVev3ESjWdNGKkN0GyI1wajO5D5Z3crFOibV
         5uH/jeJ8jb1amhWWg8eUv24S7gZs4Aaxlm4pIak+D2c6fzhQkxCmN8BhYH8czrYZlaMo
         2uY3wEbhalKKvfji75A9xnDWMv/cu+gsfPUG+60PW1OV68wV63owKOGX994iAyIl4GDO
         wVr69WST8mEj6lksRi+o5kuJV7hRpXaNlCLBZ2QqsizkhMYMJkwSiSsfYo6i4/2mxNQV
         mk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729240108; x=1729844908;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w3R+DG0W9j/rrWWMMX7Q5Mr3+2LO1x036RhMhClSpMc=;
        b=HKdhwoSp7yT9PeaZP1GyNfZ1f4FFos7snc0k1h4hnV2x8GrWBuZr4n+KcQ7PlG8os9
         LI2EQDVLKQ+3SF0U7EexBzywQXGqeN2q+Mwd3HDeZDClxuUzNi1oO+p6csJ5V1ZrsbsP
         UkHNB/GNyfBLzKh1b6D6wu4ytYUvh67HR0pfHTEIlmQVckAROaKiKhJDApWn/gi7LxwO
         pz6ezluu4JTC/imHs3/BYm2z4miJsDg1PPAhAVYWgMGyliWWaDn1zixW7zGAo2ephJl8
         78CbTZmBznG0+bdzbwaYZ72EG76PDFVABYdCoyYi4lKlqrCYyBm3OYmTmMDz/6KQAuDn
         9o3w==
X-Forwarded-Encrypted: i=1; AJvYcCW9m1dbUgO6k0wP0J7RvLc0YYnlVgwFD20dHDp4F7WXIWoZzYGctgUfXM0FYjVV232gkuWg2G/0sNyAJeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaNMnqsxASCZ4fmNyOxEelc00+saec1LxlsEzSDZX3bF/eWNHn
	pXVR/MqarLZICJ3k6AHs+5x8RKXUeiNgRbvG//B5zCc5fvrBwsJT
X-Google-Smtp-Source: AGHT+IG6iaZBZPpJWzw7Y9WwIiStxX0vWeUl7cQ3qA8msS64tetUPmBTp8/tEJ+3U+xyeA10M9cozw==
X-Received: by 2002:a17:903:990:b0:20c:d428:adf4 with SMTP id d9443c01a7336-20e5a8f3e51mr25219225ad.38.1729240107661;
        Fri, 18 Oct 2024 01:28:27 -0700 (PDT)
Received: from mail.google.com (125-239-144-11-fibre.sparkbb.co.nz. [125.239.144.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a8f75dbsm7976085ad.195.2024.10.18.01.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 01:28:27 -0700 (PDT)
Date: Fri, 18 Oct 2024 21:28:19 +1300
From: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
	naveen@kernel.org, maddy@linux.ibm.com, arnd@arndb.de,
	chentao@kylinos.cn, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: paulo.miguel.almeida.rodenas@gmail.com, linux-hardening@vger.kernel.com
Subject: [PATCH][next] powerpc/spufs: Replace snprintf() with the safer
 scnprintf() variant
Message-ID: <ZxIcI0QRFGZLCNRl@mail.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The C99 standard specifies that {v}snprintf() returns the length of the
data that *would have been* written if there were enough space. In some
cases, this misunderstanding led to buffer-overruns in the past. It's
generally considered better/safer to use the {v}scnprintf() variants in
their place.

While at it, fix some style issues pointed out by checkpatch.pl

Link: https://lwn.net/Articles/69419/
Link: https://github.com/KSPP/linux/issues/105
Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
 arch/powerpc/platforms/cell/spufs/file.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index d5a2c77bc908..f766821fe3bf 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -2320,13 +2320,13 @@ static int switch_log_sprint(struct spu_context *ctx, char *tbuf, int n)
 
 	p = ctx->switch_log->log + ctx->switch_log->tail % SWITCH_LOG_BUFSIZE;
 
-	return snprintf(tbuf, n, "%llu.%09u %d %u %u %llu\n",
-			(unsigned long long) p->tstamp.tv_sec,
-			(unsigned int) p->tstamp.tv_nsec,
-			p->spu_id,
-			(unsigned int) p->type,
-			(unsigned int) p->val,
-			(unsigned long long) p->timebase);
+	return scnprintf(tbuf, n, "%llu.%09u %d %u %u %llu\n",
+			 (unsigned long long)p->tstamp.tv_sec,
+			 (unsigned int)p->tstamp.tv_nsec,
+			 p->spu_id,
+			 (unsigned int)p->type,
+			 (unsigned int)p->val,
+			 (unsigned long long)p->timebase);
 }
 
 static ssize_t spufs_switch_log_read(struct file *file, char __user *buf,
-- 
2.47.0


