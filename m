Return-Path: <linux-kernel+bounces-174881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD948C168B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CC011C208F8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC2713CABA;
	Thu,  9 May 2024 20:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TNgFNOvU"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2962813C82A
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 20:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284946; cv=none; b=gUCkkWtbw8WXs0mVy2fuWvvnJkfy13hZR/H5HtSvxeevZRwonQLIDz42+FG/L1u9KiHd97ST7WRmlIzZO33Q0+dQD9O5Pd2ZYUdm2ro16AEtKhkJdU13hCEG2NqxLwMwiTsCT73gzQ1PdSJmeGuzSztTGR5+OwdvQShTk7mIPMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284946; c=relaxed/simple;
	bh=XzM7bW4mUcL+MdWLSgy4pPFCyz7AUX0/rTFVbZz4Cks=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q8xJ8k2Wsrm3tOxCiqKyNGyNpfNO0CufpzGLs2YkyCMFAZfqilTuWVbl1Tupe25kRWvDIC9cHoy0lAiAMulwlbU8Y08A/4NtgNvmyeRMO/HDa0BTE+ynWNKXZ/Ki2wYtOWh+oufveoILHaqChCI++6XpYC5ctfMLcqpfSI/5mHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TNgFNOvU; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5cfd6ba1c11so1147870a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 13:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284944; x=1715889744; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ibFWC41ZV4jKFs0EDjRGi9eb9rYUWbe9LL5jTVHUEjs=;
        b=TNgFNOvUDwSzSzaJ4tw+i7vOl78bZqwx798H7mD/omiE83Av15InytXJwanizgjzCC
         wSNIkuKBojsiBJJ7Y9S68oOPfkmfC3QTjdo91uUzXY8RFQdVfTpfAv0qxTBqCTtNQuko
         AwYJi5ORP7CeEXT6S53WXagQQElrKDNGlSg4L2Wh5oYtKIAbenVD1k8u6ga/9MYJpgcu
         zrGPLPVj+GNImrdIbQUCa5OFe0IXRUZaf/aX7dHnONufx2CXNfV0EJUWKQRslIVuOMPO
         zes7Aj6ZDCaP+3r6bVriUXvwfq0qQXqSPfO6WmhBwFUXgaqb5k/UXZJgptuflN9+y2me
         eklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284944; x=1715889744;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ibFWC41ZV4jKFs0EDjRGi9eb9rYUWbe9LL5jTVHUEjs=;
        b=c5eN5t4Ec8XuctgxB7K2doBb3/J5GeNYjDN/EssemLTsbW7rwYG5IcFU7kEDMXASON
         cA8Ahxtp9Z60+YVzoth3c/PiOTn4tsaXcUdzykVnYTLOd+7w9mrj+176uucsxjic3PUc
         Gju19OV6bPNNZ9J/s8PxnwAtd6pubEYDRTQ8PYDVSVc9R1dDY7/PwJeLzjAvU9cKLClg
         4hzD8j9UoZ4fiLgg4NYXAO8vdxNK/fH+GPpt0YvEQpVF9hK93jyo7/LAthxs2ax9tlFE
         K65oLlg1g+fB2KUMvuPeWFVBd37COGZG974oaWNdPVkF7Qe8UOGfKVRTJaPSzkuNiFsX
         u54w==
X-Gm-Message-State: AOJu0Ywz2lAU9DbZyTxpFjmmTn4ETXRrAes2QnnvoNaaVIvNRH6yYrHL
	hNu3/XqNLSiO7XFWDwtV7tR3yehx3H8vfZvePMy6fZgrY9QYxuS2CjdNOtGY4ujDCMV3RPXTDpW
	KHQ==
X-Google-Smtp-Source: AGHT+IEPkGuNPe4HIZuj85oVFOfPMLkPB6Cm4SK3VLdEwwtMiQwP0MRi57NnzjjqYrYIB2JiEx+9LJND0hk=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:e549:b0:1e5:e676:4b0d with SMTP id
 d9443c01a7336-1ef43f4b57cmr17425ad.9.1715284944391; Thu, 09 May 2024 13:02:24
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:26 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-35-edliaw@google.com>
Subject: [PATCH v3 34/68] selftests/mount_setattr: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Seth Forshee <sforshee@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mount_setattr/mount_setattr_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index c6a8c732b802..d894417134b6 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 #include <stdio.h>
 #include <errno.h>
-- 
2.45.0.118.g7fe29c98d7-goog


