Return-Path: <linux-kernel+bounces-556196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B271BA5C250
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E986716E4C7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C7F2222BE;
	Tue, 11 Mar 2025 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k2yLkTxQ"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7B51D86FF
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699115; cv=none; b=G1dX6M11lxkhkX/8U9fZVmKpTsdP7jlyIVUKkd5wiECUEyAsXoei88QU83gMYb4ffSFtBXCTDyGGxfvGv8LEBcZjvxBUXR3aiK60d9BrtuOnFBvKLyh3Z8Q1MNYeQT+pgJVoc2qgKm32H9ZpIfGSlsNk4nkBDIfE9fwXBpmSKEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699115; c=relaxed/simple;
	bh=oSXuPp+IUOl5G2aP9gTCdmTe3j7rVMOxHg2aJoo6Efg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a2YC6HhZxZ3FXYSmYb/pkDLvhPcsfhAh7PY1vJ2FpCBQqZPS+GPHo5CT5nUayxzs+YbABsymZAHst9R9NYNGytBaQ5CGcUZuyf3O79rA46CbMjqvKWhPE9jFEabvpTG50GxaS9T6DaIQt9Oc2I49PWrU2976gpsYDXOdthFvrLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k2yLkTxQ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43bd8fd03a2so26654925e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 06:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741699112; x=1742303912; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vce7eh8mPMitMWqdtTQW3Xgxbt0OG8W7iuQCUiRo4Hc=;
        b=k2yLkTxQ2K7t2n59+V3hFbYpdZD6A/EB8ugtx/QgGx4dtG91o0lsNwbTBFftlyrDcG
         ePsgnqUCvkeAkHYrhj6BwgbSa1fWnDN+qRvKnxU9L6jlBvk3otMVj1HvPhoXhtWyXQ2i
         VnNoWZWUXpyDWrhcPhsM7OZgIqBeGCdoRw6VENCQQ+HI2VtPi8iGMoaeHQQxj1iSlLDS
         DlyBQHd70iZw9jkzdb4vocACpbwwOi1JEoZl5ogskJJeLzl5L4ANuY7D/R5CreBMEvnl
         GeuBxaep58xgXsyCeYvf+UsrFyfl8qKBcDJDNLNEn9iJQQw6u45ttvXHX9FzaUvz7aOB
         lXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741699112; x=1742303912;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vce7eh8mPMitMWqdtTQW3Xgxbt0OG8W7iuQCUiRo4Hc=;
        b=eN+lZN5MgyVDHGgzugUSbHwNrtm3jUJKq55qZNzFgIvyBl2G+7hmAAAWVsQQlf/4fH
         IPukOm2XhvloOE5kQyU18gMdp3/JCcZmC0i74/fX47HosEKLO62xFrfCvpf2b/eYZ//t
         lAFqZzphyaKNZhbUVUxJ6AjIrdWIbgntkw2Np2ZKxTcwo5cwCgaAZu3gfDvSuHAcYlMi
         nantEpW8IDkNuyfcYUJcnnM1ALey6C2wxvpSQq46XVI3sqwmhTAa/FMJeOiwqSALdDZ7
         qvnDCVK6Eyt6BGfRHV+Q0piJlsW9yY0VlRYS0RB9Qu3f9xRRgwImNdrRBoqsksdq6qt5
         rIcg==
X-Forwarded-Encrypted: i=1; AJvYcCXjDxyZ7Y+XzIkrIpttHqLRy+4+QcrGwHFuN05wrQi6Imj5mOuBv/SiyORyYgnF88i2RDcknQ33X0BJZtw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd8ZET/sJL9NP0VlTMGzCQOube/YF+dPqJkZ/hAX7sTdsK6ZKY
	IwHGylsXeuKzGlKw0vFQ1cS4jtLREn+RKrnkwqbpBKOPP5L+DyXpqWBkw6Igw6fH9Yysv+AMuKI
	Bsw+VFMfS4Q==
X-Google-Smtp-Source: AGHT+IH0f6ArUDAT+Z1aqU0gEtWgWP4WVJVxUFx2+ko5jUv3CK2PIBB6GlZGbkJUJj1SHrJwdvtnC7ZX3WPGDQ==
X-Received: from wmbbi10.prod.google.com ([2002:a05:600c:3d8a:b0:43d:7e5:30f0])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:45c6:b0:43c:e7ae:4bcf with SMTP id 5b1f17b1804b1-43ce7ae4f6cmr119062035e9.0.1741699112009;
 Tue, 11 Mar 2025 06:18:32 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:18:18 +0000
In-Reply-To: <20250311-mm-selftests-v4-0-dec210a658f5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250311-mm-selftests-v4-0-dec210a658f5@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250311-mm-selftests-v4-7-dec210a658f5@google.com>
Subject: [PATCH v4 07/12] selftests/mm: Skip map_populate on weird filesystems
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

It seems that 9pfs does not allow truncating unlinked files, Mark Brown
has noted that NFS may also behave this way.

It doesn't seem quite right to call this a "bug" but it's probably a
special enough case that it makes sense for the test to just SKIP if it
happens.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/map_populate.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/mm/map_populate.c b/tools/testing/selftests/mm/map_populate.c
index 5c8a53869b1bd287b09a250edf628a66c25c2439..433e54fb634f793f2eb4c53ba6b791045c9f4986 100644
--- a/tools/testing/selftests/mm/map_populate.c
+++ b/tools/testing/selftests/mm/map_populate.c
@@ -87,6 +87,13 @@ int main(int argc, char **argv)
 	BUG_ON(!ftmp, "tmpfile()");
 
 	ret = ftruncate(fileno(ftmp), MMAP_SZ);
+	if (ret < 0 && errno == ENOENT) {
+		/*
+		 * This probably means tmpfile() made a file on a filesystem
+		 * that doesn't handle temporary files the way we want.
+		 */
+		ksft_exit_skip("ftruncate(fileno(tmpfile())) gave ENOENT, weird filesystem?\n");
+	}
 	BUG_ON(ret, "ftruncate()");
 
 	smap = mmap(0, MMAP_SZ, PROT_READ | PROT_WRITE,

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


