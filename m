Return-Path: <linux-kernel+bounces-576175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6429DA70C06
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB4B57A2A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C921E253F26;
	Tue, 25 Mar 2025 21:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SuzzHNzM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E071F1300
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 21:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938123; cv=none; b=aIL6M4GI2DBXWbMdBFvz/GYSQUSijaXHnhcxx18N2Ems1I9PCzV8+LV3HQ5lTM+kExPxRYazOtqTa6DjfuJmo1vZ/Cn2eA2oFxz0bfovzKdx/OuDnu5DPsld40mFbJ46N/4JeU3qhRjVBgskeeBYuIWhxWuFNL5uBi0BxUkDSUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938123; c=relaxed/simple;
	bh=aIZN0H+vRPvUvu/EgbjorzUci/LLtLkNYYQsA1h8uN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=quEwRGQQiU9zOcGss6t1/NXJbNSdvF0G5MCALZwRTesiqE/mvsctXYz1t5gmHx75g1Co/rAUTwdXLjsMudocRjOj1Onzf87I3Pum9fHcOW6wPhI0orQ3TMoGjxvR7+2ErjpC5kRmWz2zHYVPA+GQ9IvLG/lcfgOBsAXBGEZTiAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SuzzHNzM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742938120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MsV2w/Rn5mfBpb+ogTXQ4dOfXGpaAgBdA4ur9xVQST4=;
	b=SuzzHNzM9+d+0aIpw68D8bO4ufIseFP/D/ZV0T5YoKVHNvMBLHsl9alL4+4t1YZwk8zZGj
	vEr9bKu9/qNOJN8AZqxj/JsXWLDfUuUaq7AcXpiCQYNEp8v5zfci27aNvgcDYNptm7ByCR
	4GfxkxQB4lHaGICnRyChWhPrVW7p92E=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-1Esz6RrROoSxfU32bi7beA-1; Tue,
 25 Mar 2025 17:28:37 -0400
X-MC-Unique: 1Esz6RrROoSxfU32bi7beA-1
X-Mimecast-MFC-AGG-ID: 1Esz6RrROoSxfU32bi7beA_1742938115
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1160E19560BB;
	Tue, 25 Mar 2025 21:28:35 +0000 (UTC)
Received: from chopper.lyude.net (unknown [10.22.80.20])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C772819541A5;
	Tue, 25 Mar 2025 21:28:31 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: Maxime Ripard <mripard@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org (open list:RUST:Keyword:\b(?i:rust)\b)
Subject: [PATCH 0/2] drm: Make some resolution info unsigned
Date: Tue, 25 Mar 2025 17:27:03 -0400
Message-ID: <20250325212823.669459-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

During the review of some of my patches for KMS bindings in Rust, it was
pointed out we have some areas of DRM that are storing resolutions as
signed integers when it doesn't really make sense. Since there's no real
usecase for this and it's a bit more obvious when writing rust code then
it is in C, let's fix this.

Lyude Paul (2):
  drm/edid: Use unsigned int in drm_add_modes_noedid()
  drm/mode_config: Make drm_mode_config.(max|min)_(width|height) signed

 drivers/gpu/drm/drm_edid.c    | 2 +-
 include/drm/drm_edid.h        | 2 +-
 include/drm/drm_mode_config.h | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)


base-commit: 5da39dce1fa3c81dc6552a16a9f748ba2980d630
-- 
2.48.1


