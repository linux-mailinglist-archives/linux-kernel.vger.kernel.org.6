Return-Path: <linux-kernel+bounces-530194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DECA4304B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 480D63B573B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D3320DD66;
	Mon, 24 Feb 2025 22:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gdfh3RDM"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5289F20CCF1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 22:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740437576; cv=none; b=ZL5xhQPherRXMukpaVxWhm2cieSrqVCpZeT2NpwVeWJe+J7tjCxe0ADRBRWogWTsDY2QW8tZ7UfXymccDFYin6c5DRMFUW/Aavs2g1m+HfkKp0nKuouYj7fQDK+pBpI8nEfS1LLfPL5nsb7MmB8VcXYg22/wg8Z7+rMJg7gteEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740437576; c=relaxed/simple;
	bh=wCBUro8X74PEVZGjy8/v6ioiKNk+ksES9zc6oIeICgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSeNxiLdAOa+2lVKWxfVpdaw8jwgUdz2xqvFvJFONMp4boCqYZD4OmYviphwl7E7qV0AR8MQ4Yic/SX7DcTJO2DzRq5QxS+y/R1AmYddO9lOYKNiiQHe7R0QZD/fvBzSC25YIiNMi17SAsW7EH3k/9lEJkMQmaBcVDo67F+GnOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Gdfh3RDM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-216513f8104so11890305ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740437574; x=1741042374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JC+iCaenVWT1qC+wv1WYjnvGE2KwlNSxR7B2FLEJRHA=;
        b=Gdfh3RDMuL/f58E3rRMPSXDE481hOe7+hkV6sRSuAeK3oTMFbI5ngWeB0Co7L4y5mZ
         aimwR4seqrWPPgUf64FJDsh0aRci5+XZd6w4m1Htz3tCk2PTmH3OXypx/+QMcIaOEoJx
         Xk7S0m+RnbXMHNpt5NjlWW9lvB5bk7VbAa9jE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740437574; x=1741042374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JC+iCaenVWT1qC+wv1WYjnvGE2KwlNSxR7B2FLEJRHA=;
        b=HeqiwlllJTbq0OoCYQb0mfMAf75NiVABOH67kN+vp7fG0mr+FLODiKyEyeDTKh9PGm
         O+SZhz35LzGpGiaTvG+seGkcLdvbgZnHMuI+32ZTpre6FdkRJPlcy7tWZLYHcrlB0wyD
         sFhlDFT8vdgvgJX1XIY6R3rRoWI9f7BToybeGIfdxzQcddiCQRn47JDkWSXm93abFc9c
         dXHNPAGDOkxehTTJ0oEvXNb7jrdprHwKsmTIAqZRkBVojafy3nAPM4Pkn9QQp1BveBTj
         1Y2QZy/8wxUDrsUtCKhkqzlW8lMGBHzrNRZ4wzZYX8XHLUdIYpio5vWkMrPIAYetyx9o
         nWqA==
X-Gm-Message-State: AOJu0YzfitxdN/7mfc1VQr72c1xl4LjZ8Sqcgeosga0ZAIVjDpIGv/fD
	HxLzH/GInyxUCiECW7mnCe6JnPNsH4M9aD5ZKyP1Wgmer0N0IL14JqXSC+y7jFNIJ8ErPLowNKo
	=
X-Gm-Gg: ASbGncvh+0+/tR8c+4PtksNwpJEjqLkdfLfCBf3yGXC12ZO8LLjqBjKAdT8DTvIsiar
	03j0yeXvfQ79/LeLxzoDNZaL9YozGPctcF3nDlUASRw4DWBRQ5jha4Jj4csE3UodYdo+OrEIYmR
	TgdZn+lDQjSuM2dkrVTMKH1nCAJVZK7ir8M4xlRYFA6oql5S4jeE/BVpL4qe3IIX/XdYSe7Sl3d
	I6+3kwU/87MeZbTULo4zEEqH2nSn1yvhNnwIgRk5Zd+wVDsnlFO/scuHaqrnrdzhIDrLeq26Mww
	nB0D5d2L4q0AjzJPvuijj8xCLIY/uc+JlStFcByKKI0FAZ2oZKKLafw8aLs0
X-Google-Smtp-Source: AGHT+IFWvMJ1DifgHpp00NgiU+l7P2X3hIfGn/N0QZgxCBlNaoLWIru7jUXTs0mtOdXL84lprXpfPg==
X-Received: by 2002:a05:6a20:3d89:b0:1ee:d621:3c3f with SMTP id adf61e73a8af0-1eef3b1fcddmr10299435637.0.1740437574612;
        Mon, 24 Feb 2025 14:52:54 -0800 (PST)
Received: from localhost (201.59.83.34.bc.googleusercontent.com. [34.83.59.201])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-aedaa6475dasm110603a12.54.2025.02.24.14.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 14:52:54 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	torvalds@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	adhemerval.zanella@linaro.org,
	oleg@redhat.com,
	avagin@gmail.com,
	benjamin@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	sroettger@google.com,
	hch@lst.de,
	ojeda@kernel.org,
	thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com,
	johannes@sipsolutions.net,
	pedro.falcato@gmail.com,
	hca@linux.ibm.com,
	willy@infradead.org,
	anna-maria@linutronix.de,
	mark.rutland@arm.com,
	linus.walleij@linaro.org,
	Jason@zx2c4.com,
	deller@gmx.de,
	rdunlap@infradead.org,
	davem@davemloft.net,
	peterx@redhat.com,
	f.fainelli@gmail.com,
	gerg@kernel.org,
	dave.hansen@linux.intel.com,
	mingo@kernel.org,
	ardb@kernel.org,
	mhocko@suse.com,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	ardb@google.com,
	enh@google.com,
	rientjes@google.com,
	groeck@chromium.org,
	mpe@ellerman.id.au,
	aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com,
	Jeff Xu <jeffxu@chromium.org>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v7 7/7] mseal, system mappings: update mseal.rst
Date: Mon, 24 Feb 2025 22:52:46 +0000
Message-ID: <20250224225246.3712295-8-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250224225246.3712295-1-jeffxu@google.com>
References: <20250224225246.3712295-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Update memory sealing documentation to include details about system
mappings.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 Documentation/userspace-api/mseal.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
index 41102f74c5e2..10147281bf2d 100644
--- a/Documentation/userspace-api/mseal.rst
+++ b/Documentation/userspace-api/mseal.rst
@@ -130,6 +130,13 @@ Use cases
 
 - Chrome browser: protect some security sensitive data structures.
 
+- System mappings:
+  If supported by an architecture (via CONFIG_ARCH_HAS_MSEAL_SYSTEM_MAPPINGS),
+  the CONFIG_MSEAL_SYSTEM_MAPPINGS seals system mappings, e.g. vdso, vvar,
+  uprobes, sigpage, vectors, etc. CHECKPOINT_RESTORE, UML, gVisor, rr are
+  known to relocate or unmap system mapping, therefore this config can't be
+  enabled universally.
+
 When not to use mseal
 =====================
 Applications can apply sealing to any virtual memory region from userspace,
-- 
2.48.1.658.g4767266eb4-goog


