Return-Path: <linux-kernel+bounces-391434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D04F9B86B4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 00:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FE98B21004
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1B01E1A23;
	Thu, 31 Oct 2024 23:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AoeayQui"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBC019F430
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 23:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730416242; cv=none; b=dR86ATku+dPCgzTwOub+7M0+YkvUVtXQk1Hg834850L1jPUYTMB39J8DTLSkVEp4KFdpKZYlP3ldbiHZitV3YbAvauCgJD3QfPT4rGJwmDBEoa9GsdCCDgwJ4mjO7gC6tyQqJiZhZMVNPMYsNuiggFqG2dSFtHeoo3zlbK+Fc4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730416242; c=relaxed/simple;
	bh=alNJz6/ehpAYL13/0qVZvJMm5KppznbEqNHWox1Q89k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kpWOG6TT6N4lOj6tVDpUdLIRBkmcpPmKIO2hEm8PJ2jwLfS3eb0POVJe1OsreGVBm5F0p92JHOxg2P+N+3/E3W1sGMtr1j9Hz/PPvVadaNIhw88QGxGdbnDtp+VLsTpTSEzNLcnwFRHHmXEPUEqh+7Z48VOaIcc+nGLgA+ZUbeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AoeayQui; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730416235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6tLpKsOz+MCKUgMitGvEfOZC/jPhgg37ybWqVjxcw8c=;
	b=AoeayQuiY6XDlhDzsGP3D95Qha9T6BEP3sA2ZPe1Vn3dyqzQrUy21Gz0le3U2OP90cL6I/
	3FeP7q5q/uVTV3NyWOXJCg4RyACY6Yy64ARsJw9J2Nm/w9db54sCpdgRV65dZiApN91VYs
	Sz1/QeRjrYOXeGogGk62oTbPUXYJxPk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-gSjDu7Q4PCa0GJGyRMzRrA-1; Thu,
 31 Oct 2024 19:10:31 -0400
X-MC-Unique: gSjDu7Q4PCa0GJGyRMzRrA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBA891955EA5;
	Thu, 31 Oct 2024 23:10:29 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.88.202])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 07C2F1956052;
	Thu, 31 Oct 2024 23:10:26 +0000 (UTC)
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
Subject: [PATCH v3 0/2] rust: Add Lock::from_raw() and expose Guard::new()
Date: Thu, 31 Oct 2024 19:08:43 -0400
Message-ID: <20241031231025.3466571-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This is the third version of a small patch series to introduce
interfaces for working with locks that we've acquired from raw C
pointers, something that is quite useful for bindings like the rust
bindings - where there's a number of interfaces protected by BFLs, or
which require the implementation of callbacks that are known to occur
under lock.

Lyude Paul (2):
  rust: sync: Add Lock::from_raw() for Lock<(), B>
  rust: sync: Make Guard::new() public

 rust/kernel/sync/lock.rs | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)


base-commit: 718c4069896cabba5c39b637cbb7205927f16ae0
-- 
2.47.0


