Return-Path: <linux-kernel+bounces-511638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8DEA32D95
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 304D27A3102
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4113725A35B;
	Wed, 12 Feb 2025 17:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a3yGdceO"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4A5221D8B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739381727; cv=none; b=mc0XYFnhYEQo7PnJBbDvPNKK2yKHiW57ZMYi2Biru9cZKO9brl7SKUK5pcEK1q4Gq/ySUtpMgBOpKyxCTbeFHnB/IhASEfjhmLn62MkGehZX4qKqbZQYjIK091Lps2GZeqER9DTRnSA5P/IaraOGqksSu5KcMAPdUFk8KUw0G44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739381727; c=relaxed/simple;
	bh=DmIiZ2cNyDza2EZG7jYnHi0w3VtiTMAgGpnc5F1FT7E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CGAu3h5Q1ELP15c0f+nKgo7SNQ/G7pbVnVA1DbOa72BsE3Zm6U868MpHKJyvbeDNp0Dv/7EgQrZLfs3mT+PktDx6Olls2gT0Fg6/xwUfZ0ShNnKAvDzuwn7314myEsuLovgvCGWcwkK6tw3aostcnZJnVuI6x0l/yfCpJrkOJKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ndesaulniers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a3yGdceO; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ndesaulniers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21f683ce1e1so97946125ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739381725; x=1739986525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hWFh39SfdAe+FH4gJJJshDsRQ2bzGMNj6/EbGI3RyTQ=;
        b=a3yGdceOk4oUg04H+EluYRxLaLpBHw56mh8y44ONg4024HH9MQZyP53WFUJzTeAxAN
         ruoQ31rE630NUXFZKPEUw8fPcC1tmQQD9JoCXZm3EuWiqQdTz61K8+RV7Q1xIkqWqyUP
         M2cSUrPcN4hIR2ttunnKjGkBgGlBKHgb3rM/jBSNo+t8FFQR9PSF6tUlS+XrwDgaJRSH
         u43VQfHBY+KxxYDa7JOWzIFqkqqSKZ3q/FWelTyQVej/QRg7PZToBQbOlP/zEfWXzcjf
         HJ0WwxYrNAeOctLPgyLO3UpXfHTNgF4h9lEQae7cocJ3UOLXm58r1nS1IfVdFEbW+4nP
         FrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739381725; x=1739986525;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWFh39SfdAe+FH4gJJJshDsRQ2bzGMNj6/EbGI3RyTQ=;
        b=M83Qz6v3UZnj9V0EODcDrp/tVJK08dZl5exIT789HN41Dn0ATUEqQjOxPM/XgAx64c
         neC2es6x/Vp9Dew6j0hNk6xyUWKXbg0YJuRJAYF8mTHDnGCdQ4sh7Dbis3oAj6Dj5LQe
         pDUT02UDiNqmKqO7ADrVAgY/Xeoc3klJkVRChqSU0Lr0bwRD8wjwQgbj2jNofKgFX4XQ
         QdAbXIG26PFgsGH0WzmP4MjFofFFTbJMxzkbSTYrpXVyncHckWQSoMJfRsdjlDe43Tje
         2mkfIXWp5sXIDSuZOCKeSD2r4mUxvF25pbn6sEQdCeK9o/d7B/N9q7FoLbV7ZyIRU9e8
         zmLA==
X-Gm-Message-State: AOJu0Yx/4z/S9JibUTmXdrdZNkuRzgTuKNweIIr/MTxpVQHLJd2tOUsO
	eyv6ShNRyGGnbr1UJxfHtm4h8VLJO70QkZ+cCaUoBQg7QYuBuZVqlXXCg25oz6m1crVcxwMjCRM
	Xbx/wJyaJOVKNn+VboFkVmAperA==
X-Google-Smtp-Source: AGHT+IFJ738kGSCpjhT4ELwx3ZlmVU6gIzFmuKBoey0jugTABMc3Bc8VZKMJf0T0RB1k8sUzVs61ppK/9A0cDw622k0=
X-Received: from pgpf9.prod.google.com ([2002:a65:4009:0:b0:ad5:4620:b05d])
 (user=ndesaulniers job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ec8b:b0:215:b9a6:5cb9 with SMTP id d9443c01a7336-220bbaafc9dmr64415855ad.5.1739381725458;
 Wed, 12 Feb 2025 09:35:25 -0800 (PST)
Date: Wed, 12 Feb 2025 09:35:20 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250212173523.3979840-1-ndesaulniers@google.com>
Subject: [PATCH] MAINTAINERS: update Nick's contact info
From: Nick Desaulniers <ndesaulniers@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Updated .mailmap, but forgot these other places.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 Documentation/process/embargoed-hardware-issues.rst             | 2 +-
 .../translations/sp_SP/process/embargoed-hardware-issues.rst    | 2 +-
 MAINTAINERS                                                     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Document=
ation/process/embargoed-hardware-issues.rst
index daebce49cfdf..0e19d2f0d6bb 100644
--- a/Documentation/process/embargoed-hardware-issues.rst
+++ b/Documentation/process/embargoed-hardware-issues.rst
@@ -308,7 +308,7 @@ an involved disclosed party. The current ambassadors li=
st:
=20
   Google	Kees Cook <keescook@chromium.org>
=20
-  LLVM		Nick Desaulniers <ndesaulniers@google.com>
+  LLVM		Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 If you want your organization to be added to the ambassadors list, please
diff --git a/Documentation/translations/sp_SP/process/embargoed-hardware-is=
sues.rst b/Documentation/translations/sp_SP/process/embargoed-hardware-issu=
es.rst
index 7d4d694967c7..9d444b9c46d3 100644
--- a/Documentation/translations/sp_SP/process/embargoed-hardware-issues.rs=
t
+++ b/Documentation/translations/sp_SP/process/embargoed-hardware-issues.rs=
t
@@ -287,7 +287,7 @@ revelada involucrada. La lista de embajadores actuales:
=20
   Google	Kees Cook <keescook@chromium.org>
=20
-  LLVM		Nick Desaulniers <ndesaulniers@google.com>
+  LLVM		Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 Si quiere que su organizaci=C3=B3n se a=C3=B1ada a la lista de embajadores=
, por
diff --git a/MAINTAINERS b/MAINTAINERS
index 25c86f47353d..3f339e23dadb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5663,7 +5663,7 @@ F:	.clang-format
=20
 CLANG/LLVM BUILD SUPPORT
 M:	Nathan Chancellor <nathan@kernel.org>
-R:	Nick Desaulniers <ndesaulniers@google.com>
+R:	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
 R:	Bill Wendling <morbo@google.com>
 R:	Justin Stitt <justinstitt@google.com>
 L:	llvm@lists.linux.dev
--=20
2.48.1.502.g6dc24dfdaf-goog


