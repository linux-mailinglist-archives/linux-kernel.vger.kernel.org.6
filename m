Return-Path: <linux-kernel+bounces-528945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C591EA41E46
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1279E1892ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7907125E455;
	Mon, 24 Feb 2025 11:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7OrqsXu"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E55F25D539;
	Mon, 24 Feb 2025 11:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740397838; cv=none; b=nRhSKAHWotjRuhDAb01kSvxhUasoP38cMLIxRRcijoINfLm4ogJj+imov+mJABV56dsORBm3nol+JXQig4OXaMQ0Qyme8VXO+KIlk0nEHJHVWhBhEZ5RdMMmkomxInbe+y5DbNjTiToqbxdKNAIGkWqL0T5Y5mUFIw8HMABFk/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740397838; c=relaxed/simple;
	bh=Udykfwl1MXc4gc2RuJvVXlL7EQdbeTE8wi/JhuNvidI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFkt9kjmxL42Cpbj/XuyPP7biAGpp6nOoiK/CweEyvCM2B2DHICH7tyey80OlB8h4eTXBFrF0fA7Z1En7cLRtbP7DagazIgakuCnhHEygPmW2e89JRVfzwOvRvRwFHpsqdp7kVOGjpsGeoGqIAJWXgVP1m/nrJkoG4jtRGsMo/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7OrqsXu; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30761be8fa7so39899901fa.2;
        Mon, 24 Feb 2025 03:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740397834; x=1741002634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5JPny/8xmUL6JVDTY7izFghOi6X6ho5qifwBno3Gtg=;
        b=O7OrqsXu/+yf5muJrCa+p4Ah4bdCuv6Yc3980+/+ITeoindgNhQpn4xBmWXAm0pvOp
         49TczuYVVfKoXigwSgi9SRUgtkoNXGyAFLKfdfOstpaUyCbU2Et3G8BPrdekCB76bfgU
         SpE//Yfj0uusltqG+BACjcqzp0UFTTCxxq1cygsOqr/Xm7AkdY3NPqmbokqpYNbJTl1s
         W3lTz6K4/Z+u0aQ3MGPeHdBVRy3UsIp+r9sboYk+TE1SWY73t/POSsNbdZHEmI+DYw2L
         D9QVJ47C1uay/klLl++PDsxJL9i8KTIEqusBxBQbGilYaUIwNaaoPKCYcttgsCoRYFcl
         PvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740397834; x=1741002634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5JPny/8xmUL6JVDTY7izFghOi6X6ho5qifwBno3Gtg=;
        b=kS/BtxrQaMvP3rqfUTNJfPKDs24IngLUMK9YtO1OIq773x4HmUNA0ne1HFRdW4/req
         h45hshuOTqpmA65lySKLTSTnLHF1KRQvUfMVnyKJXgUz8uLQNDSPC05GFwehnACEM9/7
         ftDkhZT16jxwe7rS9FKntv7zEIfpAfmEceAwanw/bf0WbjsPv+VCVMPYLga4T9LI2ITI
         vY4D/6ZPM8JZRic+KwntI6hw0/WyZSj4B5ySl+gObRBNWPP9NsmrbtbkH8QvLUT7S4JT
         xIt6Wm2zmC7y0a371EqlhLcSX8RrhRAykdkVMW1noqrzEeHit64PKd7OpX/2jawtQA0+
         f4Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUd3tQlnnVcFtxw7FhT1PlaasE5czmenBk0NIq3b04Y2Q32RMM3nJTd+OeYgmS1r8Faz3NaH/cZhGyz5HPlb8U=@vger.kernel.org, AJvYcCW080PxEtRpH53vOwVdi+Jqu36R3/QT+2m04kmgOoVRFehICjviGCv6ojN5MgLQKk8ll5rrzZ3uuz52auI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGxHTEiUQUaKCAH8a8ZIhqTjvHhV/SyXh++Pi0wEzIkmeRRDo3
	cH5Esn1/rPFo6V1CAd8a1yRtW1+ekwI9KgViZaYWLdkwBQSFGJDG
X-Gm-Gg: ASbGncvXJjAuyPMIsqVN2l7R9JjpSwGV4+VzKLK/nTmmjjFux1iNH9oFAqBNYQ2ru0c
	maT97WAIO77JiOK4dGBKrEJ8u3MfqmFSjbNoL3eBjfHvnbUnvadPiSwW/90QpYANxC4dgKXpUHi
	aKUZlAcA8kcVSp7HV5Yy1QWXUg6bFC8sxuzigNCHhxTQPA/hpA3ruR0VmluawNab0XrazjBmePY
	QIgmHWOXzZJmkaotZaWO6Oe/KCx5IIG7OAgx2rpp8JmyBj310wSRxrH60S28atu2p7IW/KdQ6FB
	eM2ePG4K1H9JPEtqPIHTrT9MAzaFq0r4UT93nE1XwP+ZPwgJpogl4pOugKbrN/oMmEkWL/zr
X-Google-Smtp-Source: AGHT+IFrKGi4N2or557v/brTgU0jkI7F6CLygpynjgZaBX85qdtVnhp8hzxjA4KruxbreK67zbDtcw==
X-Received: by 2002:a2e:9b09:0:b0:306:10d6:28ad with SMTP id 38308e7fff4ca-30a5985cb24mr38650751fa.8.1740397834139;
        Mon, 24 Feb 2025 03:50:34 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3091f26cd5bsm33174541fa.18.2025.02.24.03.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 03:50:33 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: aliceryhl@google.com,
	dakr@kernel.org,
	robin.murphy@arm.com,
	daniel.almeida@collabora.com,
	rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v12 1/3] rust: error: Add EOVERFLOW
Date: Mon, 24 Feb 2025 13:49:05 +0200
Message-ID: <20250224115007.2072043-2-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trivial addition for missing EOVERFLOW error. This is used by a
subsequent patch that might require returning EOVERFLOW as a result
of `checked_mul`.

Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/error.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index f6ecf09cb65f..1e510181432c 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -64,6 +64,7 @@ macro_rules! declare_err {
     declare_err!(EPIPE, "Broken pipe.");
     declare_err!(EDOM, "Math argument out of domain of func.");
     declare_err!(ERANGE, "Math result not representable.");
+    declare_err!(EOVERFLOW, "Value too large for defined data type.");
     declare_err!(ERESTARTSYS, "Restart the system call.");
     declare_err!(ERESTARTNOINTR, "System call was interrupted by a signal and will be restarted.");
     declare_err!(ERESTARTNOHAND, "Restart if no handler.");

base-commit: beeb78d46249cab8b2b8359a2ce8fa5376b5ad2d
-- 
2.43.0


