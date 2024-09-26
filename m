Return-Path: <linux-kernel+bounces-340263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69469870A3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D7202835A3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30491AB6D9;
	Thu, 26 Sep 2024 09:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wilbur.space header.i=@wilbur.space header.b="COl4eMbq"
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEB11AB6E3
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727344116; cv=none; b=eksBIVxH/hLPprhSN3dT/GTofvBQDC5Vw0SmNCH2G2IS9+tpd8RYWmueEKdrCIgt3tm5LvNJPOB8VAbQL3Xj0zF+sUG3i7H0VN5JMJkqt0jLx9+8lVsytOsBhvhdZHO90px0AtyvQT1BtudNzoVRSSIGhSKGgn3lmLrQm6nserg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727344116; c=relaxed/simple;
	bh=3tBeuOwiClzAPfIKz8orXYZJC4rlLSsEGiFmPz+ZR1c=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=RZhDmXOOO1X4Sp1DfiNYjngbMuZdxrC1f/i53n/fOwKEJMV4fJwBf59NNGl+KLA3zlA5yNkuswk17w2a4abum3DW5lAA1UOW8tASdDZkhLRWhXCte8hrX5iqNrXCEarXTBSHvhbIdkcvK+AakxWWdCTmJ3YfPAH+0Ilm9EJ52GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wilbur.space; spf=pass smtp.mailfrom=wilbur.space; dkim=pass (2048-bit key) header.d=wilbur.space header.i=@wilbur.space header.b=COl4eMbq; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wilbur.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wilbur.space
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wilbur.space;
	s=protonmail; t=1727344111; x=1727603311;
	bh=3tBeuOwiClzAPfIKz8orXYZJC4rlLSsEGiFmPz+ZR1c=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=COl4eMbq2UMne6AhRp0mMqv83nmvHjPZYzC7tfW49Iw18FKFrGt+Gyw3Cq1/odbfG
	 uLzPiu/Wjl1zrnHNu7c7m8Dj3zpB/zpQY+PUAZPwdub6CqH/NautVpBCBGIQ9HbdHr
	 J8g2TRJOqCqEGep4h86F68fo4rQqHct/5l29ObDltihn7yevjBUnlGilpVfoSSsovW
	 Pfj2o4cLWpr7LLHBPLqw3Lomm6zFlUFob30LK+th4YKMdefuTKvWTXS5jNSB4mOI42
	 K5JGpYtFBkQp10UyxHp1SynGbfOzr17P64T7WorIYfqB74ViOF5uJEkAHaGTzfGj3Q
	 VepgU1OVCH4/Q==
Date: Thu, 26 Sep 2024 09:48:28 +0000
To: linux-kernel@vger.kernel.org
From: "Jonathan M. Wilbur" <jonathan@wilbur.space>
Subject: Skip building vDSO entirely
Message-ID: <J8ZEKS.JKAFCY4LP2XL1@wilbur.space>
Feedback-ID: 15180831:user:proton
X-Pm-Message-ID: 76779a38c1fb44a4fa2983067fb18af87dc10c1a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

I am trying to build the Linux kernel with as minimal tooling as
possible. To give you an idea, I am writing binaries like "bc" that are
hard-coded to do only what their invocation in the Linux kernel build
steps require and nothing more, and I plan to do something similar for
"ld" in the form of a single-file C program that can perform the
absolutely minimal linking needed to build the kernel.

Based on my research, it looks like not a whole lot is actually needed
from the linker. I believe a minimal kernel should be able to be built
using static linking with few special flags, if any. However, the one
big barnacle in all this is that vDSO is a shared library and seems to
require a lot of shared-object functionality from ld. If vDSO could be
omitted from the build, it would cut down on the code footprint needed
to build the Linux kernel significantly. I tried setting CONFIG_VDSO to
"n" and CONFIG_HAVE_GENERIC_VDSO to "n" and neither of these resulted
in the vDSO shared object's omission from the build. I even ran an
"allnoconfig" build of the Linux kernel, and I see that the vDSO shared
object is still getting linked. Eventually, I ended up modifying the
Makefiles only to find that I got linker errors ("undefined reference").

I wanted to ask (1) if I am doing something wrong and there actually is
a way to skip vDSO (on x86 / x86-64), and (2) whether for some
technical reason, vDSO absolutely must be built, even if this feature
is not made available to userspace.

Thank you in advance,

- Jonathan M. Wilbur





