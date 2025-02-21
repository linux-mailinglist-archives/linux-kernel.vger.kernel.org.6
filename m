Return-Path: <linux-kernel+bounces-526446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 188E9A3FECA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D36703A4324
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FC6253F15;
	Fri, 21 Feb 2025 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RFc0oUwi"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10C2253B73
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162362; cv=none; b=mkJ1pykkV0WkwqGQK7C34tiF+x9DdLby652fGoezuoIEpxX/4Eb798qtkSQl+BWaUDl1yAVwJJyCb1xtgphooyMKzCrOiJxPRsxx3a0ZjJPKJj5VNMQ6N82eTp1sKIU08yFzPPO2IVl4v+td+C3E7y0eYQGGreFD6Cr/Ia0GhQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162362; c=relaxed/simple;
	bh=Jd3sS0uhGXgTw9um/6BzDZdcnVVUyQaC/pjolFnZ02M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HsitDBxnWVLZU43Kbnw2DuWwxHcF9Kt5I0w2X/WMT97DjmZPX5k42Si6mJ6H7iu0aNnzbxVabIXdeW+nEQK0WhTZ0KOZj9n+9D9bwJNk8ThBm8jP3IyGX/naaUc7QoePzGAZxWhChtitYwpS8G/eMj4nqKML7xt1lQ9NgMLTbwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RFc0oUwi; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-438e180821aso12556635e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 10:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740162359; x=1740767159; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mTW4zFHgqMTpKYtsmp9+cjJMhtMM4lVL076gYjHeNng=;
        b=RFc0oUwiD/QeWDpIxa0dDUicD/kdqhmSfuHQ6ZvEmLwg5KUDPIH0RBnnpL/k2HH0J2
         xRRIeK6wOh4twSFeR82nH4RZEmY7kdx0chDJjIxwLgPvYO+fEJ6EcfZ2cjp5CQbAVRFW
         6U+ir3Tryi0/pSrDcSLYAHRx3YqcMy+Xbj5UCZYDlg3KJqMcmfud8Ny7BhhHGmRLTso3
         fGJ62tetieZF4F+UZrhMyBEXQrKzJmPQhVm7rqdGQ+jyHMLXQZ+5KA6r3SEYws40uHx+
         HQrQ80gOcAdkNB1l7Q/wSzGjNSMgpFHuNCY2XkqtFPfE0xlB0ZbIViqwNaW9CEaF6ISE
         8sKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740162359; x=1740767159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mTW4zFHgqMTpKYtsmp9+cjJMhtMM4lVL076gYjHeNng=;
        b=vAKX/IFJKYHZY8t6vDcr6aU1dtabZQNzkyo6HCg2buYIqTjyVzRn/P7RvL4D9f3oSA
         IpXvP8zXjHEWISO8S/H3ZlfE/k08TldfolmZXj7/nLAhKfGLelfZFm1l2EEs/jhfxKuT
         FVOE3j/f3zP5Rv3JsReY4kjQJ9KVVB/FdCr8Oma1Qzt5jLIBavroiexM2s/8SH1nrtcT
         Nl9Ye43Z67IRhtDgxaRPXGsGYDiVtHDNqTn/bna4M8K0Iw0dz5N3gaRSiQL/KI13vQec
         JnxvqTW9rlyrzqt0ox04h7x3H5Ov9wIfhYKy4Y7S9iLA9YQR7qcRwKbpKaPyy5yb05yg
         74Bg==
X-Forwarded-Encrypted: i=1; AJvYcCV+zpHxOIxixd0aYJfhjXjG1I4pNoLO4shEQRGzzRGkwwNDfK704u8PsubYw316JyH9sLTaYVC3rGQesAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIRkd3RWYeTipZswQ1n2KgiQlDagoTrOiVjxOThlnms/t6jDYO
	C0ld1NTtzbZS9td8hxbn9DGkwkxGta2io+VCdgEn6kl+uKxTZalg1dwMtPPHiUfQVg2PLZF8tT/
	VItBLQZ2nqQ==
X-Google-Smtp-Source: AGHT+IH+lec5x9erUgvTpG9GeO/CGpjb1ve0Ipn83JFb9w83c23OEehpnp+ZQ8agucCyadGiN7t3B4OuYtYozw==
X-Received: from wmrs7.prod.google.com ([2002:a05:600c:3847:b0:439:80fc:8bc0])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:548a:b0:439:9a40:a9ff with SMTP id 5b1f17b1804b1-439ae1d7bb2mr32069955e9.1.1740162359413;
 Fri, 21 Feb 2025 10:25:59 -0800 (PST)
Date: Fri, 21 Feb 2025 18:25:45 +0000
In-Reply-To: <20250221-mm-selftests-v2-0-28c4d66383c5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250221-mm-selftests-v2-0-28c4d66383c5@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250221-mm-selftests-v2-6-28c4d66383c5@google.com>
Subject: [PATCH v2 6/9] selftests/mm: Print some details when uffd-stress gets
 bad params
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

So this can be debugged more easily.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/uffd-stress.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index ec842bbb9f18e291fa51de0ed8d1fbf9aaf14372..be0c93f24fccd618f52d54ff36d9a5540f420e46 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -456,7 +456,8 @@ int main(int argc, char **argv)
 
 	nr_pages_per_cpu = bytes / page_size / nr_threads;
 	if (!nr_pages_per_cpu) {
-		_err("invalid MiB");
+		_err("pages_per_cpu = 0, cannot test (%lu / %lu / %lu)",
+			nr_pages_per_cpu, bytes, page_size, nr_threads);
 		usage();
 	}
 

-- 
2.48.1.601.g30ceb7b040-goog


