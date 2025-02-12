Return-Path: <linux-kernel+bounces-510399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A0CA31C35
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4D9166221
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 02:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB851D95A9;
	Wed, 12 Feb 2025 02:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6mbBoqL"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FF81D7998
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739328189; cv=none; b=nPZCSu4r4ldfJ8TsidttFdqQflwe7gOO4Wx4KS3kdbJMrG4sLiaqbZt2Y7ehmekrQcMJjrjMv62WlKFQcX0EZZzcAdBHoJHtz1snQKoURmSIoAEYe7ZJkRiXj5x/1CQeeiryk97cx051WDsOSBZ9Zgx6hBT9Ybgwt1PUuMaaZMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739328189; c=relaxed/simple;
	bh=5W56coMFqyhabdD4o8RwjtrjKsxQHFIT7wKdhuxDydo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVAe2yd03uByOI9qb0/jyy8mAsYXsqqybLzXT6PyecPpIje8utuKX65OZ+uZbvyF2Gjhd8GDufqOxZT3P76zeenTRx+OUv6pimSz0CkTRb4bEFHBtyJkd8QHU2rv9GYyOPZx4T44MmlxYAb7b9Fg+zl18yYq5cYfCV531R6dUpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6mbBoqL; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5fc73d5786eso1783135eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 18:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739328187; x=1739932987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KS9LDdhgAvzOHDmQFDhJhefIgBVpMq9sZGoE2hBV7Ms=;
        b=F6mbBoqLKcAbQdgFfx69j1GAMgydz5bxpJRjqKW4WJlmNrxfkOjf5nKahjq/koXZNf
         v2JUDddWlvTR6Awub7rhSkD2T7j1/XezkpE2xX5E2Kt4Fo4kvoOX8isLeERBtbVt9fb4
         Ldvxok5Kd9rKrwduGfGF+GAWHVNGoxmL3skfwiY8YU+qWWb5zAutUGmHlJK1fWZjPZwk
         /xFCHTxxC9wrAla9//JugbiOjxBzfgy0qMqk5hbXjLTMyNkldLfQWXxmH2pl+O2XYIyx
         6TctJyOUgA3Pyfn/3SLcEd5/JEm0EpnKjEtiO9WhYQRjugx8rRekjoCedvLwUSXZpH41
         LAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739328187; x=1739932987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KS9LDdhgAvzOHDmQFDhJhefIgBVpMq9sZGoE2hBV7Ms=;
        b=FvAoR5G8hPN7JODVxC4zBvZvGZKQ68NAK2umY5KDjlwuT3AR2tZEKnVtrK7pXrQOgq
         QvIp3k6KHe46g/mSuB5MJrHdT0KTTN6mS62EBYU+CAIMz9b/GDiSeRsHO7nzMK/BoSI5
         3PTblIJTjFyq4PmohHpJB/wmqDLCSOsX7CJARvuUQvEx9v7ZcgpIhcFoXd5qeilvOulM
         JhZgryDz6llQZHKUnuak/4HXFTSL0nBy7y92vcDkFEo4VPWzz2t4aaJgSZCAxcmPhGYN
         qIKLgbHb5brJgeP//8KnrCEUnSFXw4MtOd0iMZ3z2iePaQ2DpfOImzOVr1FDZRNP6LfV
         aP5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvhUwDWaVe2TRWozWMJqj/zQCHMktQqgUkXXzwFh32l2/XXHEIElSpZdIt2lGs1oijhuTj6UVTZU8yxAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOS7om1agcItlWwjscY7Z9J0OuIHmuohgyLJ254kJAB5Nsesew
	shGqblcwazo8Odt+GXeJkuK6ouxTVnEuw2EowWyTzAxqOgbE/o8/auwA98yb
X-Gm-Gg: ASbGncu6h5zBfXA3FhCbdf4Jt9QEqeujW0o77/0EFDhsRXGVofBDfr9ruNWc5OjTzWU
	AX3RhgOJvne7dFcPHIk8Jw6jeH7EP+d9IC9jgiW1Fp5Aj/thHqrUHPwqGtSjbiq7xfG8w01+rXj
	LRQQ5JNVwKFe3X2ufQH+XlhaqfJQF/ouYeGRFxrpyU3Ie8hOoe9PQPzMKglIfQ1D5/Rvxk98dfi
	vySKWWGZrnE4UCUdEEpo5YKh1JJC/oHjyF/PFh5MX2JCu6mD7Mercgd47CRaLoGWLY4+MjiHIsv
	q7X6xFsHA4XSgQfNO5JV9xmjs7EJ5X8HlZjk15U=
X-Google-Smtp-Source: AGHT+IHGJ408gS6gy7lau2YKyNZH1aNO6SxynzYMGbOUWsj8s8T7k4ECJGcC8Ajquvmd/Sr57hVA0w==
X-Received: by 2002:a05:6820:c88:b0:5fc:90d7:a702 with SMTP id 006d021491bc7-5fca183c13emr1225735eaf.4.1739328187103;
        Tue, 11 Feb 2025 18:43:07 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:7409:107a:a63b:a3da])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726afa4efb8sm4059667a34.66.2025.02.11.18.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 18:43:06 -0800 (PST)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: gregkh@linuxfoundation.org,
	dan.carpenter@linaro.org,
	dpenkler@gmail.com
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: gpib: fix style at nec7210_t1_delay definition
Date: Tue, 11 Feb 2025 23:35:37 -0300
Message-ID: <20250212024247.176572-3-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250212024247.176572-1-rodrigo.gobbi.7@gmail.com>
References: <20250212024247.176572-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

due a change of the return type of t1_delay function, checkpatch
was triggering a style error.

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
 drivers/staging/gpib/include/nec7210.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/include/nec7210.h b/drivers/staging/gpib/include/nec7210.h
index aa03c234aa60..604085e3fe4f 100644
--- a/drivers/staging/gpib/include/nec7210.h
+++ b/drivers/staging/gpib/include/nec7210.h
@@ -109,7 +109,7 @@ void nec7210_parallel_poll_response(gpib_board_t *board,
 uint8_t nec7210_serial_poll_status(gpib_board_t *board,
 				   struct nec7210_priv *priv);
 int nec7210_t1_delay(gpib_board_t *board,
-			      struct nec7210_priv *priv, unsigned int nano_sec);
+				    struct nec7210_priv *priv, unsigned int nano_sec);
 void nec7210_return_to_local(const gpib_board_t *board, struct nec7210_priv *priv);
 
 // utility functions
-- 
2.47.0


