Return-Path: <linux-kernel+bounces-415029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF409D30D7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 00:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BA94B2345C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 23:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2121D2715;
	Tue, 19 Nov 2024 23:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SwRohGek"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FF417BB38
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 23:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732057920; cv=none; b=cG8xcl43y2lYtxDIM10J+DPeMKEd1AosoTPtPGfNeieqF0biGaX7WpUWyCnQ3Ig31eWyEM35Aezxo9dYviCy4ylppyhywO/57VQkbL9XNKH8Mzy5PaOXLGwbXhheK7gl4cBzqENDW6FtIYR2aYZpILCDrNgSOVVOadFPdv4d6GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732057920; c=relaxed/simple;
	bh=H6zFyPLJsQs0C1j4owdm0akaGy8YbNOzRJtp7SdaLB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nndjGVRW3l1nPOubMsJNbYUYQqrO4C9G9p1vbSEz0QdxHkOfda64rLYYmA0S/uEbp+bt2j12dxVYG+0lK8i5zPdAghQ6kuwe536s+8vvCUKf4hcJjqLd2NwJzeI5tGNlzif/uuFkjbzWwfLxsbgD0nD+g2vjz9u/Dz1Elv37Lnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SwRohGek; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732057917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bi/Aj0IsGtjX57Y2W6moM2xOST0I2AXVDNrA9rXUiVc=;
	b=SwRohGeke8oeBIAm9sciEFaY/2em/DRHDesV7c+HUtO5FqnSqSAi7nnB1UTqAMHSOuzSV0
	0v7zKW/u11ndg+co6Q731teidFiz/vWjwUWEOCQWF8nlAXYt4sQcAUXL2UGIva4sV8erqK
	vy2tp6rFETCiFMMqeA81RqnzlN2BMe8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-qCUTvLsGMA2Zz6mW51UGYw-1; Tue,
 19 Nov 2024 18:11:54 -0500
X-MC-Unique: qCUTvLsGMA2Zz6mW51UGYw-1
X-Mimecast-MFC-AGG-ID: qCUTvLsGMA2Zz6mW51UGYw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E2DFA1956083;
	Tue, 19 Nov 2024 23:11:51 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.88.23])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BBB6B30000DF;
	Tue, 19 Nov 2024 23:11:49 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>
Subject: [PATCH v4 0/2] rust: Add Lock::from_raw() and expose Guard::new()
Date: Tue, 19 Nov 2024 18:11:02 -0500
Message-ID: <20241119231146.2298971-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This is the third version of a small patch series to introduce
interfaces for working with locks that we've acquired from raw C
pointers, something that is quite useful for bindings like the rust
bindings - where there's a number of interfaces protected by BFLs, or
which require the implementation of callbacks that are known to occur
under lock.

Lyude Paul (2):
  rust: sync: Add Lock::from_raw() for Lock<(), B>
  rust: sync: Make Guard::new() public

 rust/kernel/sync/lock.rs | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)


base-commit: b2603f8ac8217bc59f5c7f248ac248423b9b99cb
-- 
2.47.0


