Return-Path: <linux-kernel+bounces-557154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3738BA5D44F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 03:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D4C3B73E5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 02:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC435145A03;
	Wed, 12 Mar 2025 02:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1PzqSQ00"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28395684
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 02:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741745533; cv=none; b=YBhxwZNcTQG8niz8Mm9iAIdbq+xxvR9itWfWZzpaDWQNoZHlXQb32A4PeLT7zmcv3963RsBln9iox+jsntkDW+yv5XaQc4jsFEFWctRgNQVLLmWGv3yZvR75CyInsrTh26047MFKVNRxd5It576W8/43u2cWAt2zaIaa5Q7KvAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741745533; c=relaxed/simple;
	bh=hSVQhdZ4pcaTXi8WujkuLi21M2hXtG1UnOBrQGdjTro=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rs6P8wLH93zvAZjNfyqLuLV0F9oHudcVpZkL5UCEIQ+EV08UbZBoRGcDouqsduikfffxttjAAtPQosj1i88zyhNPZtWl32qkCJ+gfCbPvM3vA6yOe2biffzRr7rtszQkiTrtQbGjnE9OKN5heX86Ku2Iis+o2dkeh+Th3Mqwgxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elsk.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1PzqSQ00; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elsk.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff6167e9ccso16756658a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 19:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741745530; x=1742350330; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dL1+gxzev0XtD2Z0UuOLlz+T+qpC8rSy8gjN4glIZ9E=;
        b=1PzqSQ00Z1Wp4eYWLyksuP11WrdcHOGyVg6LniILD89l3PZFFfzbynIQsmsiYDLRaK
         oT51Cz50YWDd7IgTd19BgkEx+rFst4AsNbIOUwZEqb+9UTvvCwGll7XcX/EpDLxgyFaY
         JO/030iF4wYiO87FhKi+PqnkpCKsjqxQMFN+zsezAEMAs7jyhnA+4yRXyhPF9s7xhPMx
         kiAj/etoRcUWSZ/1vN44EUl8Rp4zfIL7HMgpNWNjXW2tN4EcK7S4CGpI7aePGQhICG0p
         75suJgtGd5GnZDruTqEhnCC1ye1eKIx4/se+UU7CljNe9RWNHwkv809VumS5VvBLoU9V
         +Lgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741745530; x=1742350330;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dL1+gxzev0XtD2Z0UuOLlz+T+qpC8rSy8gjN4glIZ9E=;
        b=iUrpFOr14FXOb1RQu9JnfsbYMA7cLOsXJNQOpkSNTz7+8GcmCixJw8Q1iSZJ0uOM+U
         /o9aOKODWxPr8d5n1R1KYl4LpF0auZ+R49xnenfopMzWljGzG+wF2ZbNENY2m3icpCQL
         e8knMQsVJgnumsrfpmCFrAodC6GO9wvBY4Kfe1tFIDPLk0Y2+iRTMaKX64Z7ysLDO7B0
         7DiStTP6qCJz9pZ1q4w2rl6EceH4nr5ePoWK9nzj38bD5J68KnoaWZsTJbE/Q50Akp4F
         Iu5sHtzepfS09Jb+/rCxoWgff3Sckl8TS1Mtml0vGOb1UeSn0Uq2SyvsaI7yqZAqvZIG
         8Z5g==
X-Forwarded-Encrypted: i=1; AJvYcCXUfRTRqLF31+mi9083/Ucd9Hw1/0s6apbAp/i45BD3RkMt//Ig3LQ1hegx3ikjMVfcq03PL9mNwm7qJaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk7E33Z49koSiqlW1TbGYmy/NEHZoheMjZxsblrkJUeilltauF
	Kyt4sM2Bfakd8SSvaoXO9gewOiW97C9v/rU4Wpc9sG2fYe7MjhGuhbVfIjwGVWwHAfRwXg==
X-Google-Smtp-Source: AGHT+IG/VBPxbBcaru6ycm8/KwheisJ94/ITI6u5b+sVpdpQf774Gwv6a3lVIJn+qhyyXYenb6Qa2ukT
X-Received: from pjbsh15.prod.google.com ([2002:a17:90b:524f:b0:2fc:3022:36b8])
 (user=elsk job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:bb8d:b0:2fe:b016:a6ac
 with SMTP id 98e67ed59e1d1-2ff7cf5f7aemr31009808a91.15.1741745529975; Tue, 11
 Mar 2025 19:12:09 -0700 (PDT)
Date: Wed, 12 Mar 2025 02:11:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250312021154.102262-2-elsk@google.com>
Subject: [PATCH v1] setlocalversion: use ${objtree}/include/config/auto.conf
From: HONG Yifan <elsk@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: HONG Yifan <elsk@google.com>, kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

setlocalversion reads include/config/auto.conf, which is located below
$(objtree) with commit 214c0eea43b2 ("kbuild: add $(objtree)/ prefix to
some in-kernel build artifacts").

Hence, the setlocalversion script needs to use
$(objtree)/include/config/auto.conf as well.

Note that $(objtree) is not necessarily `.` when O (aka KBUILD_OUTPUT)
is set, because of commit 13b25489b6f8 ("kbuild: change working
directory to external module directory with M=").

Signed-off-by: HONG Yifan <elsk@google.com>
---
Implementation note: Should I test -z ${objtree} before using it? Otherwise it
looks at /include/config/auto.conf which is wrong.
Or should I fall back to `.` if objtree is not found in the environment
variables?
I could also `exit 1` if $objtree is not set. Please let me know what you think.

 scripts/setlocalversion | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index 28169d7e143b..88f54eb5a7c2 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -186,7 +186,7 @@ if ${no_local}; then
 	exit 0
 fi

-if ! test -e include/config/auto.conf; then
+if ! test -e ${objtree}/include/config/auto.conf; then
 	echo "Error: kernelrelease not valid - run 'make prepare' to update it" >&2
 	exit 1
 fi
--
2.49.0.rc0.332.g42c0ae87b1-goog


