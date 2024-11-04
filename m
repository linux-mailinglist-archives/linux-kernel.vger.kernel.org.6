Return-Path: <linux-kernel+bounces-394431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09F39BAF14
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A2621C21E1F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 09:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AE31AC88B;
	Mon,  4 Nov 2024 09:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iETcMSyI"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EBD18B483;
	Mon,  4 Nov 2024 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730711250; cv=none; b=TJE32g9qJXeZ09IRJvFtLT0AW9jyclZ5EEF8VE213vnQmoWJGcjBTaIolpgNGpvd0uYqW8wer3+43kwERuGn+2D3xKRygKzmXu+Pcyf3OFM4flWyTvF7LEYOBL2pIlUyEAwV5fzwmASp1l7UFsJiYdmp4rvrDUT/8s/6IWFTOk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730711250; c=relaxed/simple;
	bh=giPXNvWrJ1zsJQZkQd2B2RCDaNpLkxleapOqDDfQfhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mmPAmPPTOAE3q/bip7oc3XtXmxKAangp95zxvl1BZOAhU2pAdSU8MEdswxJroKUkHa3BJo91G41OnB29UAvZMz6u2Ye16MEVm1dTrgPolyOknPscdulpJbjy1fZsesagZ+O/gRMeMyYxIxmbWXwmE4grFATpVyg2QTN4SslK9EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iETcMSyI; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb470a8b27so45620051fa.1;
        Mon, 04 Nov 2024 01:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730711247; x=1731316047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLgsd+vXvTVhRmFeWAr5s+0uMHQtIheW0N8cf6W+eAo=;
        b=iETcMSyIXa21l7qbgNji1JoIuvh1G/g5XHpFY84a2OF1Ivrd3HcwY0r/COvP8jhC07
         IIChIRIloITKdqrs0vWnkxyNmgJPOt4T8dWFjH+MdwxDwTziajjdIIj+eFzReujKxHZu
         WoNQXEMP7w7CNT4mYeOR5XP3ZRx5jsjs2On6pChw5bQRn6x8Zt5W1o5a54pTchE+Krmv
         cUdQs8uMKAjwWgPrU9bg0Yh/4yb0YR0PTyX1riuuooECjTeXIoJ+r6l0JaYX4Mi+v86P
         PdLb7F7ZdEbIVh3qgxeMhCB8SkrTYCZpKQpmjnHF4sHy+YcKw4pyOzUHmIIKUkHeFFyO
         FVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730711247; x=1731316047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLgsd+vXvTVhRmFeWAr5s+0uMHQtIheW0N8cf6W+eAo=;
        b=aJr0Ew/5gZpIR5V/mqHc0S32uRA8DsLk+xxgn+/rt8BrhWZZ7W9/h1jmh48ucRSN7a
         xPPgfR4ZFrgu4naNkOI/BabMb3UrUhH43vBJ3WoWJDbR30vnrNtmIQU4MOebclDejDqK
         lwHCH8nkry5g/0LaOZqoyC/G9pcwAgDx55kcwl0lM3zKTMhfVxV3wQ0tXnsjqVlO5Hfq
         uqasqUlgsE4YFyYM3vY3kVMmq0K6armhX0aMNj4KwVg0jf2dm8GSgY1nlo2r+yX2vsPC
         j0HIrwHo0c8k/xbYoIyy6Nc36eHtDcdAO0Fny7JqnxT2c6aAce9M/vzmOAQj39H+jfIB
         IPWg==
X-Forwarded-Encrypted: i=1; AJvYcCUp18BimRRWN8DaDO1io4F0ix+EMJaWKxE80TCyFvkcxhZd6ET9Vag31reEtlHPmOJUSzxri+U0nst/ELs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywibh+PVvB0nQBDspihZfkdjDSJZf2EDvZLBy7VjzOMfb6CRrJn
	UGnXtLqfg3EaSNdyeOQhkMURiNzVJhKS2npH9FWXagbDnW3rbKik9faZtg==
X-Google-Smtp-Source: AGHT+IGucAB/Ohqh9d0qNbYVZEz5HnatSkqMiJwf/69rUT2e2x9kydyAXGpeCtd+pCGjanSi2jjouQ==
X-Received: by 2002:a05:651c:90a:b0:2f7:6062:a0a9 with SMTP id 38308e7fff4ca-2fdef252a0emr48199631fa.7.1730711246471;
        Mon, 04 Nov 2024 01:07:26 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef8a6070sm15829991fa.89.2024.11.04.01.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 01:07:25 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: daniel.almeida@collabora.com,
	a.hindborg@kernel.org,
	linux-kernel@vger.kernel.org,
	dakr@redhat.com,
	airlied@redhat.com,
	miguel.ojeda.sandonis@gmail.com,
	wedsonaf@gmail.com,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v3 1/2] rust: error: Add EOVERFLOW
Date: Mon,  4 Nov 2024 11:06:33 +0200
Message-ID: <20241104090711.3000818-2-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104090711.3000818-1-abdiel.janulgue@gmail.com>
References: <20241104090711.3000818-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trivial addition for missing EOVERFLOW error. This is used by a
subsequent patch that might require returning EOVERFLOW as a result
of `checked_mul`.

Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/error.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 7cd3bbab52f2..92bfdaaedb02 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -63,6 +63,7 @@ macro_rules! declare_err {
     declare_err!(EPIPE, "Broken pipe.");
     declare_err!(EDOM, "Math argument out of domain of func.");
     declare_err!(ERANGE, "Math result not representable.");
+    declare_err!(EOVERFLOW, "Value too large for defined data type.");
     declare_err!(ERESTARTSYS, "Restart the system call.");
     declare_err!(ERESTARTNOINTR, "System call was interrupted by a signal and will be restarted.");
     declare_err!(ERESTARTNOHAND, "Restart if no handler.");
-- 
2.43.0


