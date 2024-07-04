Return-Path: <linux-kernel+bounces-241478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C96927BB6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE6828691E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FE41CFD5F;
	Thu,  4 Jul 2024 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jEQ9TaNc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1DF1B5807
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112973; cv=none; b=RZkrtaog/zknyxpDDWIImSJzZErcPR8aL848CbCvXOGW/1qfhHOD+QajsdngyPECkPgwoKuRJPW+BeiBYs3ZqTvsbP+Ow78zrUBruuvxa8edUWN70w6cruguep/IalQw1GCuzOFA39Q03EFt6Reabqq3q7tOQdBDTJg3UMfCGY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112973; c=relaxed/simple;
	bh=p0HGLvz39MagYLHLnfr1oEDeeFWEr8ljFaHWqx1Mx/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i9OXwwLvNEdJn6EeoMIl6JekzQcBDvBTI2iWwphVwPwbru9xM7ce4ko0NRHA/ykXdtFI5EZ35pO/GLmlB40buyz7JilyW94X02yCOSocuJS3OEVAw1cXxcOIEO4xqBIfx8SFU72+3DuplP+MvIEEuP/K+CTKVayihLrnpdbBAx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jEQ9TaNc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720112970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hONGpcUApGTU4b0CZyPLQC6URu9ThOSHp+V60iJ0Myw=;
	b=jEQ9TaNc9WovbYag5ENQ0RV26JSy7rCrhsNxf3qcz7JNlGsfPgWmw3qKfXsTr/Nrqdsmj1
	3SgEo/ej6Mm50MtuoiW9a5hgKL4Koaf1E3TzxbW0nNwwJm3NFgQqQTvcbrPz5FS7EOLQS1
	3PwxLs1o6BrTiQK3BGs0hvIpSm0R8+k=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-U7SB8OlBPpugV-_32m7raA-1; Thu, 04 Jul 2024 13:09:28 -0400
X-MC-Unique: U7SB8OlBPpugV-_32m7raA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52e9557e312so779836e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 10:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720112967; x=1720717767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hONGpcUApGTU4b0CZyPLQC6URu9ThOSHp+V60iJ0Myw=;
        b=nYLE0yirBhiPBMAEDR6Vu1TzeiESBx2e5oTHpDTba9iAcxbBAs3hziM/eWSEtVEnDr
         dKQPD2cS5P4X1DXXP24BZy4LCZpjTfW7z/TNKAF1speQqbFK+HpQ596r6mylSmYl8DIU
         +Pno6ia6uTdPj5GzgqnNLcmUHo9GVMg59OUa8UHn/CCTLnmy71EQh9V2elcw6PP8yZ6r
         40wXW2/PKnMKg3Onu7whAa43SPjSzSnRB134dR3RTBfZ79iuYfBVrVNdX6AkP3SWsb6j
         PP9ZKoiX/73hKxSui/eb0WMVFel0EtSjU86QcRO06fbMredfDYqlNTQ0ARS3Kv7P5diC
         rIdA==
X-Forwarded-Encrypted: i=1; AJvYcCWwnFyzogO33Q1ImbN60v3V+rmpsygAqA5q18nrluCH+FKLw2LIxtSwUY2Su4y4v8MCEh71W5pNWM3JkbBYRKmQ2o/vjwvy5rQB8Ntw
X-Gm-Message-State: AOJu0YxB/qlyEa7K8aCkFLaJ4tIlt66dUesa+4Fssi7QwLBF0jbdOeBN
	Ei9Q9n/p+Yw5CO6FYuVXuHKl2A8MyXSkl3IHrfD7VlsTOjzk56hJtG0anGpCDaFNsmiUboY/DzY
	2N4DknAuEplGx4YdYMK+4JLjMhiphWfsFLrb+FHODBl7r6ig7lIBhX9X22MS/xg==
X-Received: by 2002:a05:6512:466:b0:52e:7684:a385 with SMTP id 2adb3069b0e04-52ea06e5329mr1615801e87.52.1720112967319;
        Thu, 04 Jul 2024 10:09:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNkphbX7wDz7FOEWh9y4mJC6b0DinFkiDszVdH52GQKQkvJI8z95H8cNwAYSlHgH0L4utJhA==
X-Received: by 2002:a05:6512:466:b0:52e:7684:a385 with SMTP id 2adb3069b0e04-52ea06e5329mr1615776e87.52.1720112966875;
        Thu, 04 Jul 2024 10:09:26 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d5100sm31134025e9.4.2024.07.04.10.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:09:26 -0700 (PDT)
From: Danilo Krummrich <dakr@redhat.com>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com
Cc: daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com,
	lina@asahilina.net,
	mcanal@igalia.com,
	zhiw@nvidia.com,
	acurrid@nvidia.com,
	cjia@nvidia.com,
	jhubbard@nvidia.com,
	airlied@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH 18/20] rust: error: use `core::alloc::LayoutError`
Date: Thu,  4 Jul 2024 19:06:46 +0200
Message-ID: <20240704170738.3621-19-dakr@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704170738.3621-1-dakr@redhat.com>
References: <20240704170738.3621-1-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use `core::alloc::LayoutError` instead of `alloc::alloc::LayoutError` in
preparation to get rid of Rust's alloc crate.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/kernel/error.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 55280ae9fe40..20306588bc9e 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -6,7 +6,7 @@
 
 use crate::{alloc::AllocError, str::CStr};
 
-use alloc::alloc::LayoutError;
+use core::alloc::LayoutError;
 
 use core::fmt;
 use core::num::TryFromIntError;
-- 
2.45.2


