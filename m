Return-Path: <linux-kernel+bounces-532524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F07AA44EEB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AF077A1A33
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AFF20FA9E;
	Tue, 25 Feb 2025 21:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rj9BSboV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2910F151991
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 21:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740519106; cv=none; b=E/E/7FNGJqy0+lARDb3UafELufRs48AZr/TNdq4VuxlmWyy86Skb6J9pQ0vzH3TLxiOqzcOlYTInntMQyYQnKYcMLbbqnaXaYztFMYfM03uyhCudLDxNT2m94OcFL8gPx/nDwQaEiL42O9fJPa0gCkdi4rFktWZo0QWWnLXrTtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740519106; c=relaxed/simple;
	bh=xlg464ew3opO/LyRYtVloxvbMwY7+YtKVzHRJlUTBTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ill7FhOW+/FODQb2bxWJhqueL5muzUgU2czMfFXxy/EuJpovd1qhAa+D8O4K2neB9Y9e29kFW53NpZsaT48NNwYCmuZpRF5AigyuBONbgRRuxU4p7Ieu8EMlbkUMufgiEIqoeEieq0TiqWfvPopXG4BJpB1ggj5jNLwqwaNBwpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rj9BSboV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740519104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sZKXJkPcoNRAgFvPogAot/4joh9+80KcwrTaxPccCHM=;
	b=Rj9BSboVyUtqbiq7mEHJy/BoGmJ9hMUam+g2/kt5kWBdJ+E60QK1UbKcdEhsM5HxtZ3y2n
	yA1XmQqZ5S7/gTxSxaoTDEqu8X+UhJfWG02E01HStMXrNAPRAzigcR0YS/vKMMfBPOVKy1
	bkTTLv8bg7KuBGZmE3ekEFLPDdBfYKA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-Io3cleewMbmc_qAoa5t7nQ-1; Tue,
 25 Feb 2025 16:31:40 -0500
X-MC-Unique: Io3cleewMbmc_qAoa5t7nQ-1
X-Mimecast-MFC-AGG-ID: Io3cleewMbmc_qAoa5t7nQ_1740519098
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD95019357B1;
	Tue, 25 Feb 2025 21:31:37 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.65.234])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8A7CC1955BD4;
	Tue, 25 Feb 2025 21:31:34 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] rust/faux: Drop #[repr(transparent)] from faux::Registration
Date: Tue, 25 Feb 2025 16:29:00 -0500
Message-ID: <20250225213112.872264-2-lyude@redhat.com>
In-Reply-To: <20250225213112.872264-1-lyude@redhat.com>
References: <20250225213112.872264-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

I think this change got missed during review, we don't need
 #[repr(transparent)] since Registration just holds a single NonNull. This
attribute had originally been added by me when I was still figuring out how
the bindings should look like but got committed by mistake. So, just drop
it.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 rust/kernel/faux.rs | 1 -
 1 file changed, 1 deletion(-)

diff --git a/rust/kernel/faux.rs b/rust/kernel/faux.rs
index 5acc0c02d451f..41751403cd868 100644
--- a/rust/kernel/faux.rs
+++ b/rust/kernel/faux.rs
@@ -19,7 +19,6 @@
 /// `self.0` always holds a valid pointer to an initialized and registered [`struct faux_device`].
 ///
 /// [`struct faux_device`]: srctree/include/linux/device/faux.h
-#[repr(transparent)]
 pub struct Registration(NonNull<bindings::faux_device>);
 
 impl Registration {
-- 
2.48.1


