Return-Path: <linux-kernel+bounces-276923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AF6949A1D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366831F2432A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9C717A5AA;
	Tue,  6 Aug 2024 21:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2RUt+FOb"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3293C17A5AC
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722979296; cv=none; b=VIOVm8PXE1vzHwZw7jh2oQ4g/+ehAJgDtdYj7YBnJZPsGcL0S2nxRPne+oM0vFxa+LPOE641SuUnFrspVOKLuW1VnCVp7ZQ94Ktcx08AcUYGCXF+XNbq/ZSkpEeqtenQXNY0IOsXy4aYW0zuccaZfgepbrUKuosneNsbm4XwpLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722979296; c=relaxed/simple;
	bh=YzibuyX/ZurkiUI6GyxkLzm0ZV6PxLde5yZfANw/NIQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VNedqTYHBGTynDNLbtRrbE8UBCs6uRHZxknyut+JtHFa+9AxRJRo/Int527eAipVw1fQto2cTlRc5z7h+qg0AyP9JbIiysPfwQblNopNRERpLMrVPGxRB2WQqLMMfLFtvVCc9uZQ0GRxoGBBozNz+8cdmQ1z1odj+dkELbUrdtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2RUt+FOb; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6902dc6d3ffso28910977b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 14:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722979294; x=1723584094; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o0aAyksQBIufqTGFzbZo39MWvG4cDYo9zi1d+Qwxleg=;
        b=2RUt+FObJTZXU/AW1+tDAdYnk6UOpIIB0UDQG+VAosmZ0w9m3VS0M/H5IThD1VaoUc
         HHLYu5CblXO4lmRZbdVe3Pxa1kRv9fgpgEJa30uxACsX/90zR8i9PxpxbxZzBF9hXcyu
         jZtx8qp3dLmEk0oXSPTswfbbEqPJ/BwxlibYKWYGIPz/hvTpFKGSPbRD2MwSrfXvCP8X
         lzd1fCxN1Kr/ggz1WzVdL/PfkftnTZR+FiAit7Yn3BZJHZeuIYtYGDMC2cg9cymqthoP
         Dx4EwfsuSBGY2mVnht/TtMn+K7YebAzqVjLVeQpQNseLXtj9RoWTdt45B7TUkVqVvRQd
         uV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722979294; x=1723584094;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0aAyksQBIufqTGFzbZo39MWvG4cDYo9zi1d+Qwxleg=;
        b=TS+mAFwcWru3bJ+iZfLLR/mI6ww9icTR4xwGLqKJ6GlAcqnzmq8kZnvPHE4qJ1Goom
         DTP14zsZFWNn4AJ8zfOEhY1SAOlBKEo7DHqYV+S+QMnQhcdm8QDZVDZszpG27if9gw4H
         lhjlwis5d3KEDBZbl+PqHoMnKyRqGvhylM1XKqO0IbDnyLYtnyifqaK/rcoUwR8Ng1ZW
         Cyr/nKONGkg9zRALdMHZVXU5+y4GwPnMrHOu01IZzbeD8hurjmAsLF+7q0Qym0TpPc89
         nJsmGosfpMO/36+v5PbWNc6KkmOcocxqhbOAdswGrq76zEVSnvMfioWw78+OXwNe6gQt
         9lng==
X-Forwarded-Encrypted: i=1; AJvYcCVv6uyyLVv6xHZ66Z1OHUEX3+coK9d5fAz5tFh2Fo6R7bcnVsiSr+tJc5GTdNEL48nxTNEBXq50lZOCzd22qh+bbArWdl42MBN4zcV6
X-Gm-Message-State: AOJu0YxOV+l8rFnZ74TmuXZsZGXLu1rr/xWwqsXdunH6GviJoGl/8Chh
	GybyYNwIkJvt6Iu6ZagzGXSCxCiAkUmdwyCvDhLoMsMR7pSad1OExsBO4gFdoYoSLgdoUTBf0Ic
	RAMGggA==
X-Google-Smtp-Source: AGHT+IHMHXkzQl0MInvIKMa5XRAGjt8JRRLdjto+8iW/bmxLWJhyarBXnt+EN/959FSdYIRtbVwMtymGh48x
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:690c:f13:b0:648:fc8a:cd23 with SMTP id
 00721157ae682-6895ec48440mr10438247b3.2.1722979294433; Tue, 06 Aug 2024
 14:21:34 -0700 (PDT)
Date: Tue,  6 Aug 2024 21:20:38 +0000
In-Reply-To: <20240806212106.617164-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240806212106.617164-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240806212106.617164-13-mmaurer@google.com>
Subject: [PATCH v3 12/16] module: Reformat struct for code style
From: Matthew Maurer <mmaurer@google.com>
To: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Matthew Maurer <mmaurer@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, neal@gompa.dev, 
	marcan@marcan.st, j@jannau.net, asahi@lists.linux.dev, 
	Boqun Feng <boqun.feng@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Using commas to declare struct members makes adding new members to this
struct not as nice with patch management.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/internal.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 2ebece8a789f..daef2be83902 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -80,7 +80,12 @@ struct load_info {
 	unsigned int used_pages;
 #endif
 	struct {
-		unsigned int sym, str, mod, vers, info, pcpu;
+		unsigned int sym;
+		unsigned int str;
+		unsigned int mod;
+		unsigned int vers;
+		unsigned int info;
+		unsigned int pcpu;
 	} index;
 };
 
-- 
2.46.0.rc2.264.g509ed76dc8-goog


