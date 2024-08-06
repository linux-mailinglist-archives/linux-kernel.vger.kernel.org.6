Return-Path: <linux-kernel+bounces-276911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE56D9499F6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E946283C78
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264A216EBF6;
	Tue,  6 Aug 2024 21:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sMR8GsLr"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68AA15F409
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 21:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722979275; cv=none; b=K1m4T5EH4GUVibDErpexTrn+UtV9cFZs9qPOZUMpAVndpOoLHfQHpLGaqGcGZWrmy1vbQ2Vsr6wSeF1XHLejllQ3++Ktt8+2yNAIotZvymfdvIsGmoSi61+fcyCJJP8+O1Cxdt28NWyk1PkwoofoaXGOTFZC2n/gQbjzBja+bRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722979275; c=relaxed/simple;
	bh=iji02Oc/3eVse8/8b0a97tqkHPOd2ny7+/1oh5B8hHY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bu1oZwZinf/YuR3U9I4QuEFxX6riArMkZzucL0KX+OQspRBnRLlbZRbqxEVV95Ubdm99XzQIeswMXm6p3TkQyDtVY2aVSMMx1y/rKVa5NVaZi+VYAcs2FtgzO63xUXYU24xKdvKBEsO5L98Nu21JOH6szuPPpf/c+ofMhEEHb04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sMR8GsLr; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02b5792baaso1994232276.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 14:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722979273; x=1723584073; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jOl8CtEcN1RVp67UAYoE5SQ2BHxlCocLL/lZKU0oS64=;
        b=sMR8GsLrWGGLnAivD0/ZcacpSVIAT+HyrCJr80Ljsgb+akD+gu0IyhTaRPMVbRCOwQ
         e29Km3ZQI0bm+x05zroBtWzX07TIXLAcGyeDLoQiBYtddkf/TO1KZwjswxtlila8Nyqi
         mZbCjf/GGXUanauQs1mzDSILPh2h5e+XpQV6VyMTe2djpqs5qacmhEuD5JkXhCT2Llc0
         gBga8E4G+3s3M2jZtVWgdJMcNxy95wSE9E37NY+GoSuD1gyh/LtDgtz85emICnvg8d3g
         8TtXaCp5Gi0CLB6K1Y61NlKDXN7borzFDdwip7Tc2ASj+IHzVzaHhCnjXmYl/TEIL0cS
         aHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722979273; x=1723584073;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jOl8CtEcN1RVp67UAYoE5SQ2BHxlCocLL/lZKU0oS64=;
        b=t71C7RjYQoL7jpbLhX3IEYhYhrNwS49AvY9vEk5Exe+HmPUvZGdVmt+nd2KRs45eGz
         Y0zXowTb9Wk+g+2FbwEYvdJSyG/tejIw9WTShkUx67hSKhmngEhVEaYtkfFw6ZLSPE16
         /M5vUtCyijPdJpAlrWEYviyLAfFDdfqGvgNrqcNSDsGOLkLuidgP4ih9XY73rgbWneuQ
         Dh15t22ldiOvgBI84coqcxQpQEkBF2Z02efcDmUqvdOnozo/OUAqmznbN5ZDbCZ/uKCE
         j6kcasgRREcDY4eF4ZNtK8dfOrbhvLFPvCFLdHWEH7Jf0psfDgcrnC8Ahs0btKNzeZOy
         KD6w==
X-Forwarded-Encrypted: i=1; AJvYcCVl6mzAXAnGNplwbuu8SwaxEjhDxGvoLq61nnwoh16Ps1I6QofwPCRQbGvZPCLtGs8rQFVg1xBCnOC3WRNgP+AW8IYGrlLEUBcBebDq
X-Gm-Message-State: AOJu0YyfKAZyG9mGiRmPZbs7k6ahSoSQk07ub0iedgieLApMxhdge5L9
	HhZ+eSACn1AAxkNpYGVWXebXtzKsVgG9zdIlfKbrm2nHeNB1U02RnwDaZuKcYTejfpXu7xnGVO5
	AFPq3sw==
X-Google-Smtp-Source: AGHT+IH68bwpdjlnY26x/2+wcQZQXwD9UHybE1nA22cklT9RgpSzraQUX4QVqW9CAA8bhLmB1AIfRzUuzphh
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:6902:188a:b0:e0c:301a:1d8d with SMTP
 id 3f1490d57ef6-e0c30666c8bmr256479276.4.1722979272769; Tue, 06 Aug 2024
 14:21:12 -0700 (PDT)
Date: Tue,  6 Aug 2024 21:20:27 +0000
In-Reply-To: <20240806212106.617164-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240806212106.617164-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240806212106.617164-2-mmaurer@google.com>
Subject: [PATCH v3 01/16] module: Take const arg in validate_section_offset
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

`validate_section_offset` doesn't modify the info passed in. Make this
clear by adjusting the type signature.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index d9592195c5bb..141a964b6b13 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1645,7 +1645,7 @@ bool __weak module_exit_section(const char *name)
 	return strstarts(name, ".exit");
 }
 
-static int validate_section_offset(struct load_info *info, Elf_Shdr *shdr)
+static int validate_section_offset(const struct load_info *info, Elf_Shdr *shdr)
 {
 #if defined(CONFIG_64BIT)
 	unsigned long long secend;
-- 
2.46.0.rc2.264.g509ed76dc8-goog


