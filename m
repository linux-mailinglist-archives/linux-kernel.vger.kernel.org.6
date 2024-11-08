Return-Path: <linux-kernel+bounces-400964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F02EE9C1477
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7471C213D9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 03:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3D6198A37;
	Fri,  8 Nov 2024 03:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHbXTsP4"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEA9188733;
	Fri,  8 Nov 2024 03:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731035474; cv=none; b=CF74cch+Vf+NltU+k75IDj0zWJ6YkAMDjqoxuGpCG42ZxZM6vujTSkbyzSNg15C6dI+8qjFuT93EuzgyRHVN50j3EfDlibhG0IiIy98C0rfZdELrn3ACH28RztgpxqC+NZB6+LGVKTWeEcuy0EvprWN/JwM14BX/SF1S+HdwdAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731035474; c=relaxed/simple;
	bh=7Wx11O+Io3/SGr81bR0dmfT3JEbAjknvURxJuu1f6Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWlymrHmIF1I2VijR6nqtDY56KtEZcYfX4zsa+Grt0bB65ZtS0t9yIu5MKF3KzcJHfia0oln9eVgB72ljZIwfHFZZLhkbGV98pCtg7TsUnBaJG555sgwv2gH16+7XY47OJ+4F3YSJVckZzTjdDJR945Q3FKbl7unSLGrjrxuyVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHbXTsP4; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7eda47b7343so1201860a12.0;
        Thu, 07 Nov 2024 19:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731035473; x=1731640273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJO07Fzt7h82Pu5SZ4QeV4i5wfjDN4Fpn4ZRTrNMHdc=;
        b=CHbXTsP4OUTMN8uWAOxMQyb7rvhnelqGVVpD47SU+2wnznWzgmL3rKlSGlYwmHiuzG
         UDqqHgsZZL9qRnO8adlmmFA3L8WNbBFMHTZRYVSlx1lkgtSNpgua+L1ZcIHLJRDokrpI
         X+a6O9Zy+LDiM6uoul4I+a7gNge5CupgsgfvhHAdRxnvWVW0pqHfTv/LOxMsBvckSfow
         YIsBiGiqOHCVKGOmuyuEqYs7e8rVKgFftKtzT/khiwXSQ6ciRY6wsrFE2li0OOmAXaPm
         iZ4lEvNsF5Fb6ilbat4XwO5A9qWIwsDMNOW+vAYVpCKXkiQ6k52xOcJdWq6LptPG/AVC
         IZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731035473; x=1731640273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJO07Fzt7h82Pu5SZ4QeV4i5wfjDN4Fpn4ZRTrNMHdc=;
        b=k1T2XEcDpBGn8NDXm9dCZvtnlYPc9UBlicFWqjr5InHf1QgoMmGHZAm8lkS+h2S3iQ
         aadw4RNN0gxEPa7aW724vL6l86qAOZgraYr7sPBkSv8zLpY0jSo+K/pbnVSABKFr7xW1
         PtfScDFZ7NSPINujdmZA43Fw1RSCrEqv5/Ne01hT/MStNSQt+qHTIA96t5rZTX5tDu7p
         E39wiOiW7MMrtK4n2KPhHYcbcEKBvVXI/K3jFxLIHItyxRkPcQ+1I56mlcfNR1nhK9hH
         XS5PSRFN9KGvmPft3YLs1RQ9RbutUkBsPNYZM6VJTbpu6au4XvRN10ktgOUddWHDiXiT
         Iskg==
X-Forwarded-Encrypted: i=1; AJvYcCWx68kfTHll7ue8gC4efxZnduQuLyocPAvBzbkHqtieO9erkjZP135xwNoPLmh//ZSyUIWEEFOK+exefaMUCv0=@vger.kernel.org, AJvYcCXWJiS2PzzzSsFfS2ZXsxZBieZzQ9iNIaBEjPgUCEpsjqOI5REPB2L0q/QXv/JcUQ/IcQRUqQU53xmxJ6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtk0ySt0aQhw30twFTgcvUcmdEBGn3DLdoD7OWGR8AitqGGs6A
	XufDqvGxD42+bwtbgrgBj0OsuKvKc+ye6IWO+4rT2XYFU+8Ji5F8
X-Google-Smtp-Source: AGHT+IFMTbcsHQ45ek/dOvAbgYhUMxZ9BujD8lfbvnmr+A8VKyrRypgX+l6rtrMPmJJLzIL2sZFyNA==
X-Received: by 2002:a05:6a20:9c91:b0:1db:eff5:f841 with SMTP id adf61e73a8af0-1dc22a42548mr2053865637.27.1731035472453;
        Thu, 07 Nov 2024 19:11:12 -0800 (PST)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079aa86dsm2589816b3a.127.2024.11.07.19.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 19:11:11 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: a.hindborg@kernel.org,
	boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	alistair.francis@wdc.com,
	rust-for-linux@vger.kernel.org,
	me@kloenk.dev,
	benno.lossin@proton.me,
	aliceryhl@google.com,
	tmgross@umich.edu,
	linux-kernel@vger.kernel.org,
	alex.gaynor@gmail.com,
	ojeda@kernel.org,
	gary@garyguo.net
Cc: alistair23@gmail.com
Subject: [PATCH v2 09/11] rust: helpers: Remove some spinlock helpers
Date: Fri,  8 Nov 2024 13:10:10 +1000
Message-ID: <20241108031012.335203-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108031012.335203-1-alistair.francis@wdc.com>
References: <20241108031012.335203-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we support wrap-static-fns we no longer need the custom helpers.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/bindgen_static_functions |  4 ++++
 rust/helpers/spinlock.c       | 15 ---------------
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index 407dd091ddec..9d6c44e277b5 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -20,3 +20,7 @@
 --allowlist-function refcount_dec_and_test
 
 --allowlist-function signal_pending
+
+--allowlist-function spin_lock
+--allowlist-function spin_unlock
+--allowlist-function spin_trylock
diff --git a/rust/helpers/spinlock.c b/rust/helpers/spinlock.c
index b7b0945e8b3c..1c47608c42ed 100644
--- a/rust/helpers/spinlock.c
+++ b/rust/helpers/spinlock.c
@@ -11,18 +11,3 @@ void rust_helper___spin_lock_init(spinlock_t *lock, const char *name,
 	spin_lock_init(lock);
 #endif
 }
-
-void rust_helper_spin_lock(spinlock_t *lock)
-{
-	spin_lock(lock);
-}
-
-void rust_helper_spin_unlock(spinlock_t *lock)
-{
-	spin_unlock(lock);
-}
-
-int rust_helper_spin_trylock(spinlock_t *lock)
-{
-	return spin_trylock(lock);
-}
-- 
2.47.0


