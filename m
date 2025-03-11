Return-Path: <linux-kernel+bounces-555394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 001A5A5B6D2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 03:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A43E93A8D57
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 02:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5EA1E7C27;
	Tue, 11 Mar 2025 02:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JMhGny2o"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0095F1E520E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 02:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741660672; cv=none; b=mLnk9Smx+ewPQSzw5n/UBSnMeUILCZYVdf3Ua1oy3WKusgbB5ALQSlI8t/Ut7s5/1IJm06LjZ0tc0KOTbreeIRaplxdQQzDYIS/cjYLzPcszbl949DwZ8BTggzn9A4/jpNuZvcLyxreOBnCdT0swBfB+R3mLudg/rm8f5U+kCb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741660672; c=relaxed/simple;
	bh=hh7QDsywcXB+6disdfK5pr9T8ubWm1fW4QiNis++4VA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dp63V+VozYbUEt6L23bgea4XAm4rmPouN0eGsqSHpsmMlGbmKrKaCD7uzaCv7K9misO9zC5MJqAhF1DIzquMVTrstUilVlUtNml++i3la9PP2KUfwOxFlrbtE5IymwirR7cZIxPQxc4yEVIjBAndtuE6ZOseS9wOQGvPUVNd3nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=JMhGny2o; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2234e4b079cso88530885ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 19:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1741660670; x=1742265470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1EJIiSH26iW36iQ0AY70VtFe7J14wVFHIbN5UzXmWNM=;
        b=JMhGny2ohaL4dT2gQ+rZcQbfAnckNl3h8rXMQpctLvpJmwhA2GT/aWwrfFAh2BUvf5
         7qyUkrPEiin91wP/MrOrL78HqgGvfPH3PMcdE+ynYSc5XXBmi0K8FTGZ7S6rL0m9oV5/
         4F9IARyhLjC6KzQguBRKZ0tSSc7nNff0oX/X3faMMwtan0p+g53A10olLu8tEcOoRasr
         I46J5Y4A/1TR1irDJsmhXws7KZVvhxL9Scf1eY2CQ82N45KJeiul2Fqw4dfV1ujkZpwy
         RNlhZoCZvuGZ17sLdFve3qT07JfAxerTvTjDFuvi2nj7JdiqzJIL/DWqjCwSh7RHZyRq
         khjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741660670; x=1742265470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1EJIiSH26iW36iQ0AY70VtFe7J14wVFHIbN5UzXmWNM=;
        b=vJ4pIoBSZ1E+4elX+OhsfUnb8I3DYSrmp4j/5MhFPhGejbPLXdqVm1WOA+VO+HVFIW
         fHeInQPaEUYK2ighYlLVkZaUG2pOhP3ktxgShnzYS0z27kC+cGCWOGkyzv077l3FYvVV
         dgoIrLtkGaqwhbghC1pOz9JU0fXAT7L+9hvJKoB05o6nROukHK2VmQVxtcKjx9sJS0zr
         1z4YOSU0gX3goQxXCz6lBdN0ddY810l28FsCPJZvXDT77Td7NU1N57dA3T5tOPfQE3ML
         pKDQYgHWoIyjLlKm3Pcy3jUZTyNgYKUxFK2rMCSg8TQhE7Kcji2c8FuN2RC0Hw4/DtoT
         D++w==
X-Forwarded-Encrypted: i=1; AJvYcCUfL8CDCAvKX8mDRy/S0tl/fKr4/ZJsjpCUHeqz59Nniu9EH+rKsOVUz1JK/NWBIqOOvGFuhQtel1BjE7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5tBOTwt1RJYmjqU+NqCdXMb3Vf7TB4rs1WYaXcV8m3mA0DOEc
	ASk5GezfobMo9Of8JpZx8/0k15I+NvQR9WFlWxZ4Jc6Wp6ijmjtuBy2tk8NhNdw=
X-Gm-Gg: ASbGncv8H3OlDTlnEh7w/R7W3C1UVQqeioDvkgF2r4U2RfCqPyqc8+DboZOKpBrAmW0
	zOZEQFtzh4BPdsfl4UA8vyfng8u+8s+sJxHsy6Vg2N24PEQ8ix97e1WE35tD+dpQVemJPzeTUL4
	FRDmPuebjJuy9v4uqCjYdvwgqEzgl81svKjDmdYtqUkp8LwAeCLtH4aCBN5Kpywv6sYUWo0ShSx
	Sakem5pR7ueREIVuxyKL6VW4W31R9VVRRWX+aLjFd//kTBfDJbllp9KDsiBmB2pdDGCnw2x2Fa0
	hJNMVajFR4gYHuVsJucEgt02CgYOCipjbjXbJdpdDtbyVzEIggurSCE0LNrIOu/GG86ciu8keZm
	DzvuI
X-Google-Smtp-Source: AGHT+IGqOQCr1tOk5CkVd1S+i7SxypBwbxwvlNPK+GIp3D5+3dsq4NswgC6lEGNZin82dMDVWEMT1Q==
X-Received: by 2002:a17:902:e88d:b0:21f:768:cced with SMTP id d9443c01a7336-22428886828mr219614335ad.8.1741660670288;
        Mon, 10 Mar 2025 19:37:50 -0700 (PDT)
Received: from cyan-mbp.internal.sifive.com ([136.226.240.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa4a79sm85850615ad.214.2025.03.10.19.37.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Mar 2025 19:37:49 -0700 (PDT)
From: Cyan Yang <cyan.yang@sifive.com>
To: akpm@linux-foundation.org,
	shuah@kernel.org,
	david@redhat.com
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cyan Yang <cyan.yang@sifive.com>
Subject: [PATCH] selftests/mm/cow: Fix the incorrect error handling
Date: Tue, 11 Mar 2025 10:37:30 +0800
Message-Id: <20250311023730.56658-1-cyan.yang@sifive.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two error handlings did not check the correct return value.
This patch will fix them.

Fixes: f4b5fd6946e244cdedc3bbb9a1f24c8133b2077a ("selftests/vm: anon_cow: THP tests")
Signed-off-by: Cyan Yang <cyan.yang@sifive.com>
---
 tools/testing/selftests/mm/cow.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index 9446673645eb..16fcadc090a4 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -876,13 +876,13 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
 		mremap_size = thpsize / 2;
 		mremap_mem = mmap(NULL, mremap_size, PROT_NONE,
 				  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
-		if (mem == MAP_FAILED) {
+		if (mremap_mem == MAP_FAILED) {
 			ksft_test_result_fail("mmap() failed\n");
 			goto munmap;
 		}
 		tmp = mremap(mem + mremap_size, mremap_size, mremap_size,
 			     MREMAP_MAYMOVE | MREMAP_FIXED, mremap_mem);
-		if (tmp != mremap_mem) {
+		if (tmp == MAP_FAILED) {
 			ksft_test_result_fail("mremap() failed\n");
 			goto munmap;
 		}
-- 
2.39.5 (Apple Git-154)


