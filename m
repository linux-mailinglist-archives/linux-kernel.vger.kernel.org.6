Return-Path: <linux-kernel+bounces-392151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 328789B905B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA384B219DF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BFD19CC08;
	Fri,  1 Nov 2024 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jbsa5hgT"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF4219ADA3;
	Fri,  1 Nov 2024 11:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730460938; cv=none; b=nPy4ZvqnuZapdS+xv4dHoSaJ9bYBchVF0tLlN6eFt7p1+JPPDb8vj2yyNqYUcPYdG5RWK0o8baDpeiv2yFn7Y5ayT08aOLX4JnjQZh0sFmD4Jj9jIjzEjBChDw8xhuXd85uAHfTmNyjgzyg1ypf2NzS2cIXzCm6pSmyyUu+DgXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730460938; c=relaxed/simple;
	bh=OBhPChA8s8Dc+umDI49V1N43mJSBAQiOmy3fpFUG4Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/ZknCVXN0S7viDnLHPPkFcv8gOc6uUAcA5Jp+wG+ke/Tl5gxZIEBhoNs3VPmNBdN0T3a4JQKP0j7MrWbBFW65sD0wGrtCpgwd4mlURpI7l64nReV9qp67TSb+E0Ay8A2kgrTanPpzk1zPWOocD78c5zM4RT81+P1XNOkDvJNB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jbsa5hgT; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so2468037e87.1;
        Fri, 01 Nov 2024 04:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730460935; x=1731065735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPvBTsGwndTwYO6VaXqIZ/ZxbQA7G7GioFDW4oEwjmY=;
        b=Jbsa5hgTjto5KoKAaaiwQ2Due2Cng/So08KtFlUo6qHipilIH6wb0R8aKobtZZQ4kN
         yH7nXDf4BbZIVAa6/INY8mjtpXmIhb1I2WwAYq70pdoGJz8KCSThQT6Cbqp0vaaCHSVz
         BsW38daHWIwHufs2bD2IObANmUlHXrJ1kjrHbNw25K3IWbUwLnofSO5efZfqc1MpMVhX
         Y1nrmTTQxeYOlE1RaB4fjYIAqNJNYx1R5Q+LodUkPVNeGCNRfv8PK5N9r7AmDn20sAOG
         yvqHWb2TCsDujBP+eZe2e4if5XS6egI2THfUgabctPhwRvwv4bPTyfR0hxAPjix7gM3r
         1V5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730460935; x=1731065735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPvBTsGwndTwYO6VaXqIZ/ZxbQA7G7GioFDW4oEwjmY=;
        b=Kmd4ehHcLjAjGzWZViaTEfuh6qnx74sxGpWEcAMQqmmhfRZATspCIn0Gw7X8Xt3jws
         gdQRnYJP8QrWNI9+Gbs72nDfyPZ8fH2zvY7X4fsEd3sab8WlzqA3g7x0c9uOgv6vBPCW
         gQEwb7+03weIFgJiXetstbvqkBc6x4SlObI2vVzyWCi0CxnLLrDoLDKkCwna9WWMj+1r
         yLKEpgG87IN3x3O4R6s3mIEysAC74pw9MG8LfP91UWweYYzwOZBhSjLgm46BlGFku8eO
         n+LgEkO3eO+iEKqXu8kV4nIw7+1jTWTWn/eDaAqtdgVmfIAzN4puQOPbVpM68WHyI07k
         ZvSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKgqSqLbsWIPoyQlaTj3SL6Xdu6GvHQ3VNJ/BZpgD7KA0IepbkkJg4OTstBQ8Lg7qAi8VxBNViQ/fBT7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Za6qv2T/9Cv+9ZkZtHMgCiNac4O9Kj40ipOktJLRzn+4ScUc
	xOOflX/A7iT9C10rbgAx6bKJPFV7u2MHqx5A2T2zpzkk9qTumrIR3b7XOw==
X-Google-Smtp-Source: AGHT+IHHYYBfIIlKIM4PYbeQ4GxhMhvqFbUJS2TcsZNQr6oLIkTrmFBWqfTcC95bpVHSYQgYybHwGw==
X-Received: by 2002:a05:6512:104d:b0:539:d10b:e389 with SMTP id 2adb3069b0e04-53b348f9681mr11904412e87.13.1730460933819;
        Fri, 01 Nov 2024 04:35:33 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bdebf80sm525163e87.306.2024.11.01.04.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 04:35:32 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: daniel.almeida@collabora.com,
	a.hindborg@kernel.org,
	linux-kernel@vger.kernel.org,
	dakr@redhat.com,
	airlied@redhat.com,
	miguel.ojeda.sandonis@gmail.com,
	wedsonaf@gmail.com,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v2 1/2] rust: error: Add EOVERFLOW
Date: Fri,  1 Nov 2024 13:33:23 +0200
Message-ID: <20241101113422.2615566-2-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101113422.2615566-1-abdiel.janulgue@gmail.com>
References: <20241101113422.2615566-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trivial addition for missing EOVERFLOW error. This is used in the
subsequent patch that might require returning EOVERFLOW as a resut
of `checked_mul`.

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


