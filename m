Return-Path: <linux-kernel+bounces-377954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0449AC900
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D385B22D4C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F7E1AB6C2;
	Wed, 23 Oct 2024 11:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBaPrw9K"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30A31AAE3B;
	Wed, 23 Oct 2024 11:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729683249; cv=none; b=Omw0XV5K0yKl4GnYbcYV8fFPcCHVvsQBukg6MVu+ORRwhskufF4glVzbmx+Sn9C9rrlApkyODTTJJPv6Bkc2ralPKF89IOq8iEhHx69IIW4Y+whPxEGeCzdCIrwld3xMaSc/bKvYPqrvknVEsbBLRuhOHFFL+iL9yJKbVr3lxs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729683249; c=relaxed/simple;
	bh=fUFI4EnpwGEUITcKvJr/bs3uCqQh5s9+NH1h5LgbXSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQME0iiyL0tQSvKERl28T5ZEPxGRQaj2oLfWI58gmG6RghnUlaaO1WFAZ1Xh4ujs/dQgYtdPKrhRP0ZK2RAE13VcEl3bEWHptKELoER1+KDG9Ha7p4kJSAqnQryxhGue22mMrJDCp0whDDIa6KSZPgQvJldbS4CZ4pPXfhNkCIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBaPrw9K; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539d9fffea1so6314763e87.2;
        Wed, 23 Oct 2024 04:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729683246; x=1730288046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmC/EeDa3Q0ch/gdUQTmvODuhBMfga+D0P0cHhZdT9U=;
        b=IBaPrw9KO/EALm1Gb2sESH4eloytaECdCPHxWGbDMR8gNW0onuehEPSBvFbZhn/75P
         10npMYO46+mLgO6A53GNfXi8HN7/PD+TptFAP6GKz5Ewa1ZdcpFL5JRMWBPOq6GfiLjM
         KwF8qZmkHJV4BnqrHKCstvWEdUgdvsk9Y31XqH+AVXSOrUfcDs2HlWl6nm18nvp8FMPa
         RtJuf083HazBvNv0FyawWj/ONLjfFIR6x1bdwieh9kbSaKPuqd1dWpUZ57c1421GquQ/
         B3pgadV3PkCqo6ctYD+sjlWEHfQzOLLt/eqvQxsRKpY5E2XcpIhL8tZdf0PFNVTe4dAZ
         /NkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729683246; x=1730288046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmC/EeDa3Q0ch/gdUQTmvODuhBMfga+D0P0cHhZdT9U=;
        b=HhRNtunZyXaG7MsWvVKSx4SVNG7ryzA5MQLyTdM221t6rMkYm0fs9naPP/JJwXuC4M
         6muFIkIdmx9FX5A9b2+DrKKCKGzTmt/+lHvw7n8Fuim0Knt2LbQSf48+zy6o68mtc6iE
         Ds9YPA8th0CrdBGdvoQjgdhlzc38XNd3+JDrxs/Vb0cdyAUUWFD25ypWWcdq5PN/9hpp
         YY/xOyrBd8cUiMHlxX+uAoQB9XoEROyQdzuQq3n/FPj3MqkCogsuZK1JkwOAllgZ7n4g
         BTPXJtBnNo6agpjX+2n2Nqat6RN3oeUxvH24yDXf6K1CwbjYIC+RVNyYjKkQWZ6N6BWe
         58wA==
X-Forwarded-Encrypted: i=1; AJvYcCXXPaJUqUtPXNEYX0GQfa9xhq286eQSWyaAZUQYPA2CYQY0MLc0RamoaW+Ef2/v4whjQ5DkNSofJ38mjfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAdBpeH+tfCEy+gE1zCZ4ZX1ZM3B83OF1sC7Xo0jXJn4vXtgid
	zHQefvaRaZfp0Ex26+fev/qkP2YPz56l4qrGNsDf7RK/7g2oTMSPvlxEvg==
X-Google-Smtp-Source: AGHT+IHO6w/4mhHnWmURqfYcCZVp6LC1QiZISNjBFAjtVBfO54L+EKPRyA0s20+XSdQfZ+XDeqtZsg==
X-Received: by 2002:a05:6512:10c2:b0:539:e8c6:7c1c with SMTP id 2adb3069b0e04-53b1a341d11mr1121624e87.20.1729683245603;
        Wed, 23 Oct 2024 04:34:05 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a2243ed31sm1029769e87.254.2024.10.23.04.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 04:34:04 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: a.hindborg@kernel.org,
	linux-kernel@vger.kernel.org,
	dakr@redhat.com,
	airlied@redhat.com,
	miguel.ojeda.sandonis@gmail.com,
	wedsonaf@gmail.com,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH 1/2] rust: error: Add EOVERFLOW
Date: Wed, 23 Oct 2024 14:32:50 +0300
Message-ID: <20241023113309.1724992-2-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023113309.1724992-1-abdiel.janulgue@gmail.com>
References: <20241023113309.1724992-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trivial addition for missing EOVERFLOW error.

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


