Return-Path: <linux-kernel+bounces-175939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FF68C278C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 17:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28CE6B2324F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1FC171668;
	Fri, 10 May 2024 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wdjjvtrz"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818281E502
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 15:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715354581; cv=none; b=TS+AKFeboyYHK/o+X+szQgoGuezH2UENhL0BPNQfhVvGifkl1i8pZZ4emeEh9BI6+4xUdkX3k8g3FSkCCGHrMCwJ78L0pPpdIcl/OGXOIyhVDa+m/af2XW1rGIPJA82FjQwvQU1K30/1Of+wvMq/w+nHXa3G9j2V8TmQgTxxVdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715354581; c=relaxed/simple;
	bh=xDmeGB3ZsvbdC9b0Eap8RfCmxjnpKodqPjIW7iJ+0cA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=au0NQjtsa8+Ebj9IWw48Gh/TUhbo3W5bN5rKlr3VmuOIkbwfsW/S+FEDEj5fSszraUOLnxRiHV5ggSUMjTkVwMvHRLSHnTtvq8jOFHWxcLw/ExkXg7Yluzc1qGqcVPKPi3EhYiUeXgMudu8pQ0jLIlHvfZnkNPcds2nCgMFOURE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wdjjvtrz; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a5a0013d551so250392466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 08:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715354577; x=1715959377; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BP4hiObhnrJXL+AshuqLMzgV0aIGD7OqswBGKEywkcQ=;
        b=wdjjvtrzfxJbVJe2qYnLGpcFGHz2/giNsfEJFuWLweXJnUQbvKqZ4QQI19WYVAAybq
         NBdfPRAoOakva1F1pSWjYhEK5YuytDZUzE5CxE4HzDwM9PizaFGkrLSwaWvw+6RybydK
         91UScMG8dLLsNcWJ12QCvOAyjiNas7ScLh1qaqyS4dF+BMiaHUECUEZBOVXJwgfzvWDJ
         lEJCd8GUR/2hVCfaGYjU3yCAX4/hb0PeaeB1/tZx+OmMntjoIYiYEK396G+UQmZ/BNcn
         NtV+5dauAyWI54DjTnvJ8kiD0EKKLEp0xZwJtsWgEw/B9am0kauGhBSH2l5bAUKHHCmB
         cb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715354577; x=1715959377;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BP4hiObhnrJXL+AshuqLMzgV0aIGD7OqswBGKEywkcQ=;
        b=v1SrINDROBcJ8VbOLNaNF/Z+ruL9Ku6/1zIK3m8gnnUw4nwzOWGx9+W+wVgaMULJvV
         DQHeuaGdufo3fTsOQPkTkq9/TVeaNKAXjtOzaG7cJ1Wer10aun9vnF44VQVBJxKaJIeu
         kQs6MKg5aiVSQbV7DCJXTdRebZ2PRxnKvTfU2sHC3xRhs4EbYKaYvQUvlORXp+IjYFXX
         UPg+0DCycyrdHonW8uOJQXwIsGRm62GFuQoRgdnd/gfo7hV6DtFDSvf0yktWRUs9iRfK
         NfyizTSZs+3v4/rtg70MJghnMghLGdiPXvp02dRqXTmMUb89KCKE4BWzDiQeejGhE7DD
         YRZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYmKINfwad8DwBh7Pcr7lSifGPm2jIohR6OZxiY76emKUNtk9v4cptidqZTeTTE64pZ7Z9/bGGXG6y/7eNdWR/1lBEljekMjumluL4
X-Gm-Message-State: AOJu0YyXAmrIUFqrpfLh04T88M1u4syjcyfzMD4RMdJ3AQdvB5hE1qqE
	qv2xYr0FiIePGAq7nlrumw3zjmpxtpzXXrN2d7qy5iTCw8SA3GgvfKTZkFT+FO8=
X-Google-Smtp-Source: AGHT+IECyncmlyBZlx8POXK4gXnXiaTjEWCp1Q9Ts1yOT/JsMxgrlDRoEy7sB5jOG9XSuixGma2Gug==
X-Received: by 2002:a50:9ea5:0:b0:572:a731:dd18 with SMTP id 4fb4d7f45d1cf-5734d5c2570mr2746612a12.18.1715354576789;
        Fri, 10 May 2024 08:22:56 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c2cb52asm1925091a12.74.2024.05.10.08.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 08:22:56 -0700 (PDT)
Date: Fri, 10 May 2024 18:22:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] ext4: fix error pointer dereference in
 ext4_mb_load_buddy_gfp()
Message-ID: <eaafa1d9-a61c-4af4-9f97-d3ad72c60200@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code calls folio_put() on an error pointer which will lead to a
crash.  Check for both error pointers and NULL pointers before calling
folio_put().

Fixes: 5eea586b47f0 ("ext4: convert bd_buddy_page to bd_buddy_folio")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/ext4/mballoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 648989c125f2..9dda9cd68ab2 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1717,7 +1717,7 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 	return 0;
 
 err:
-	if (folio)
+	if (!IS_ERR_OR_NULL(folio))
 		folio_put(folio);
 	if (e4b->bd_bitmap_folio)
 		folio_put(e4b->bd_bitmap_folio);
-- 
2.43.0


