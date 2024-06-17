Return-Path: <linux-kernel+bounces-218121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BE890B984
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A46C28A6B0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D70E1993AD;
	Mon, 17 Jun 2024 18:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENRDcx9t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3D1197553
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648214; cv=none; b=NYYSnyWyi4A8GEzVO7hJiX+00CLtL0v2KcbAMBi2KGeL6/ct75gOru47eKMzhi/qa+HUNJOjP7woRwwAMebIaH5jqwqolP1LBrJ7mmzkXclmuIfV/ApJV+mrX3xsfqYwKrGWYwPVgY1KQ+xw1y66GcwVpqVRdjnJi/8ZY2orLXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648214; c=relaxed/simple;
	bh=xdolQoqFnN4ARnR+vGjrqoUqakhWeW/JccYZ+xwmMJs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LXdE8t3kWkFx/JduLVeeMDTFB4AaoGZrCstqJF6MevGCibtL7Q0bCrQ/2DK6xHYsiZIc8zIlONlrqrUtfTfECJ6SzKO98eDp4xr+ILKOC9QWnc8TMt6EuMYHaJ1vK5V11KtSNLJbR9Jr0UNmZaT57c0VlFRUPGp6OO+PeZZHgS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENRDcx9t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45835C2BD10;
	Mon, 17 Jun 2024 18:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718648214;
	bh=xdolQoqFnN4ARnR+vGjrqoUqakhWeW/JccYZ+xwmMJs=;
	h=Date:From:To:Cc:Subject:From;
	b=ENRDcx9tIzIoy/fIog7/o0sdMUh7fQZPjj32z9Tze2bFwI5GS+tfWCQI4flaOJVES
	 oMHO49nijcvwiGdawoO+60vnQ0PuPZbR8gCeKJ/W5sPDXcVR/6xqH1ZQv0Zge2YXvm
	 kWjRsdJ4Q+vVWhGiFDToyTIcES98BEGVHriE11lw6RJM+xmpUNUgag5rT60PoRKT/S
	 z4+RbBzYzHzWMrGQRmnfPvuLX9+s9WuDnIVpjrR/7S0G4q3lqqt2oAgsG+6OMfC4gr
	 ltmjDCw8uil6hlK2gDo5rePOHIowLbtlQ7Lu3CM8dobROUmLmUy98UnhikukcuenOj
	 wU/yjZ33QLx6w==
Date: Mon, 17 Jun 2024 11:16:53 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
	Christian Schrefl <chrisi.schrefl@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	Paul Moore <paul@paul-moore.com>
Subject: [GIT PULL] hardening fixes for v6.10-rc5
Message-ID: <202406171116.7CBA01391@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull these handful of hardening fixes for v6.10-rc5.

Thanks!

-Kees

The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.10-rc5

for you to fetch changes up to 1ab1a422c0daedbd76f9f25c297eca48986ddea0:

  MAINTAINERS: Update entries for Kees Cook (2024-06-17 11:14:06 -0700)

----------------------------------------------------------------
hardening fixes for v6.10-rc5

- yama: document function parameter (Christian Göttsche_

- mm/util: Swap kmemdup_array() arguments (Jean-Philippe Brucker)

- kunit/overflow: Adjust for __counted_by with DEFINE_RAW_FLEX()

- MAINTAINERS: Update entries for Kees Cook

----------------------------------------------------------------
Christian Göttsche (1):
      yama: document function parameter

Jean-Philippe Brucker (1):
      mm/util: Swap kmemdup_array() arguments

Kees Cook (2):
      kunit/overflow: Adjust for __counted_by with DEFINE_RAW_FLEX()
      MAINTAINERS: Update entries for Kees Cook

 MAINTAINERS                         | 28 ++++++++++++++--------------
 drivers/soc/tegra/fuse/fuse-tegra.c |  4 ++--
 include/linux/string.h              |  2 +-
 lib/fortify_kunit.c                 |  2 +-
 lib/overflow_kunit.c                | 20 +++++++++++++++++---
 mm/util.c                           |  4 ++--
 security/yama/yama_lsm.c            |  1 +
 7 files changed, 38 insertions(+), 23 deletions(-)

-- 
Kees Cook

