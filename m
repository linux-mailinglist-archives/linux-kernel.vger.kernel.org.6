Return-Path: <linux-kernel+bounces-254650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D819335D7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 05:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 077B0283867
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 03:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811C2748A;
	Wed, 17 Jul 2024 03:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ckWU9OXB"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2354D6FB6;
	Wed, 17 Jul 2024 03:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721188132; cv=none; b=opOwgspkUDfVkXb2KRlcmA7RghHMf12JVrdJPR4pz19RScrj4H2r269l5K2aQk3so1FpVI2ssccX/Vu7rJlfXOkVvJued2WFqFemqE2pI7AYhCWljcwZRHj9YP4FRyuOwAMKsphVcQM2i/8lqj9/KLie4fFxNd1RLgNirN/dWNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721188132; c=relaxed/simple;
	bh=3rizoNJHWqAi5XUS9sTp6Lvh3KvDzcL96tk1X0GfAn4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KSiFRE+K96ogROlZyGXBsQ/TEovjQv6j8rRbUX9Z7rlBgN22WF285y7QOOE8BEClyZP8bKlixCAZiH/wuewZNbpKCZKLXGcuTbyuJCuyJ/xEuchcRgD39LjlTz9kDFtNptjrG4w6XFiYjKiJuwuTppSO3CPoOtNJN+j+fxM18yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ckWU9OXB; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WP23W63ySz9skV;
	Wed, 17 Jul 2024 05:48:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1721188119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3rizoNJHWqAi5XUS9sTp6Lvh3KvDzcL96tk1X0GfAn4=;
	b=ckWU9OXB3ADVB0Ur6C/GhoH461G+zsKYtmnqrRB7TImH3MqAfUeRsFgGCAD02CQKZRhHIM
	AWBAKbOKzLiTGG606/Yy+reY5kJBlcnw67PzCf6xapN5JIoBAzRQON3527hDXaxPw8Ozkk
	tGYxEM08K+SnLpR/lPfHDH2LIE0rWb8OrfcU0N3Zv9DIlCwHLvzs3YgMfp+0XNvpmEWLGQ
	Bqq+01cU6v2muJcUCyDlRQ153utK4JECflkTOGF+zOjlbMv5ZkU/JU3qE9WwcYW3lAL9fw
	hUC4zIux5IaD7x3jkGJxMbNKoWYErICL4WCe69t4HdrnA7BHQCxG0AsqZCPtTA==
From: alexmantel93@mailbox.org
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: My first patch: Implement InPlaceInit for Arc
Date: Tue, 16 Jul 2024 20:48:00 -0700
Message-Id: <20240717034801.262343-1-alexmantel93@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e980da15b275561d490
X-MBO-RS-META: 5bi88pjhbg3xudjbpbfya4tb9qt6jyo9

Greetings!

This is my very first patch for Linux. I have lifted my arms up, placed my hands on my head, and tensed my non-existent abs. Punch as hard as you can! 🙂 I am happy to receive any feedback or critique, especially regarding whether these are the correct mailing lists for the patch.

Over the past few weeks, I have read a lot of the kernel documentation. However, if I missed any crucial parts, please just point me to the chapters I need to read, particularly concerning the mailing list part.

This patch about Rust-for-Linux, specifically for the in-place initialization:

Link: https://github.com/Rust-for-Linux/linux/issues/1079

Kind regards, Alex




