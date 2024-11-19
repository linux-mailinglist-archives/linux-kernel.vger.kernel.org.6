Return-Path: <linux-kernel+bounces-414209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7A19D24BD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0233B23558
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458B81C578C;
	Tue, 19 Nov 2024 11:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVCzBgRH"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040C11C304A;
	Tue, 19 Nov 2024 11:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732015480; cv=none; b=fvJPIBED9ymtuLbLAgHXN/cAnwMvR7cPM7dOxOrUlc+cHHe3RyfwMvuP4yUxGHsEk4Ly8Ljt7UPUHa/x+oFbS3bLM2ZtRPDFHcWkrfgKQBTi+ZzHokwYgMit/huwsIB27tKT495u8oBMDXvZXJpf5nzNGo8tfScRFuFO8wpXYlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732015480; c=relaxed/simple;
	bh=YgMBOr0XLQpnahcOPOvgyUA0SRqbAjxYOGbBsqCYwtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CMTWtBn0u9zhLMo72gIR5uss0Q5TaY+4ByeDH+v9CQJSZl3rccjvxKzMvimuCr3HBwOUf5+Mh03SOnfOAxZn5XIe7p7cpD6eAV0y/LpbeDQCVMZDkQ1i7mSDa80Yn2eW23ky07gtnd/nEfWpHvBYtdLVL9jWboZOWuS2RadurjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVCzBgRH; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53a007743e7so4627106e87.1;
        Tue, 19 Nov 2024 03:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732015477; x=1732620277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=07UtVhho8S0D2lzIwJjoCBta99cPoEpopuv+zk6Kseg=;
        b=QVCzBgRHZi6Tj9jFaLSmVdZ++p5OcpGHw7OoGCY9dqS1gKLz0Voa4YgB8Rr0tRRxJz
         CTj4RLh9QQ8PATNERluWvf1NPYMvpxpVjrXS/ymnmAzfGbpykH4TnpPbFX+iK1DcdhPz
         XE/xC5uTblK4r9xUgn3bbYpj4OGVX0epEIwJOijNUCh0RrMD23d5lTzvKuZavvVM0rta
         y+GkuNx/vQP6/VTzAtxfwA106fXZyowlF3vWpR4UdFvOqe8efBdt/GGowmzkDeSaB1/i
         MW8SjSA+QiFAIPIU0DJqtGq+0mXZpmlEElWqqeGWyjT1TlbLLu8sCQ5RoIPC5PiCGcam
         DN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732015477; x=1732620277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=07UtVhho8S0D2lzIwJjoCBta99cPoEpopuv+zk6Kseg=;
        b=c5G1XK6Tb5zjbf/VBsvyJ3fgw1eBDV4SHYAJVRl9TYY6TvvBKN8YZXyXdNzdV4MyXN
         dtrksNPz715kdnR/73A95tc1A1yrHg6GTBtfjSbiAH7Td1Jd4pcpkb5Gd1227yFhkZXa
         wbwswwU5BGxn51ksc3esR7k0zxQJ9b0A8z4guHk54f4vJ9qOHt3fqHZbubVzdi18BRNL
         wr2YlMikBLUaNfO7wtohweahiGi/xkLGpyq5P5Y+UIEmstw5OWoL/Npnj0ADdd1KWTRU
         U4ZPMz9K9wz9PeduhREii+VSe5DXQJGOCQeO/luhLXWs6BBhpIa/iiAptm934Gy6wA6I
         qfIw==
X-Forwarded-Encrypted: i=1; AJvYcCW9+J1rGbm+IOeE6Td0fWG1eF/eUgbXUaM2RA07DhtIVfiewxHe3Vv1H5fi2iyZLTzp1TSXXzcHmotnyFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHNKg+eHMcD1OTSu7JaSn49ozPb31oCVryFq4ro6xiR70VBDM3
	iw/RVTznb9+E4HhnmO0JzBTNJOlwKcomnuos5JUxa/kh4BTojMZf+YA1yw==
X-Google-Smtp-Source: AGHT+IFEwgH/qQqqDW3K0M0FjTVj+zPROO31piqFvXey9OYFgWbWJSTuDaFf+mL2sb7FYhUVnuzmtA==
X-Received: by 2002:a05:6512:3c83:b0:539:e94d:2d3d with SMTP id 2adb3069b0e04-53dab295fa3mr7165890e87.7.1732015476785;
        Tue, 19 Nov 2024 03:24:36 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd478279sm271899e87.232.2024.11.19.03.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 03:24:35 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
	airlied@redhat.com,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v3 0/2] rust: page: Add support for existing struct page mappings
Date: Tue, 19 Nov 2024 13:24:01 +0200
Message-ID: <20241119112408.779243-1-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series aims to add support for pages that are not constructed by an
instance of the rust Page abstraction, for example those returned by
vmalloc_to_page() or virt_to_page().

Changes sinve v3:
- Use the struct page's reference count to decide when to free the
  allocation (Alice Ryhl, Boqun Feng).
- Make Page::page_slice_to_page handle virt_to_page cases as well
  (Danilo Krummrich).
- Link to v2: https://lore.kernel.org/lkml/20241022224832.1505432-1-abdiel.janulgue@gmail.com/

Changes since v2:
- Use Owned and Ownable types for constructing Page as suggested in
  instad of using ptr::read().
- Link to v1: https://lore.kernel.org/rust-for-linux/20241007202752.3096472-1-abdiel.janulgue@gmail.com/

Abdiel Janulgue (2):
  rust: page: use the page's reference count to decide when to free the
    allocation
  rust: page: Extend support to existing struct page mappings

 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/page.c             |  20 +++++
 rust/kernel/page.rs             | 135 ++++++++++++++++++++++++++++----
 3 files changed, 142 insertions(+), 14 deletions(-)


base-commit: b2603f8ac8217bc59f5c7f248ac248423b9b99cb
-- 
2.43.0


