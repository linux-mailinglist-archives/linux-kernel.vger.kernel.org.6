Return-Path: <linux-kernel+bounces-410147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 306639CD51D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 02:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A36C283098
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 01:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F88130A54;
	Fri, 15 Nov 2024 01:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXkZUGLF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46C53307B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 01:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731635143; cv=none; b=WisbgJzPIkK7wgjyvQRz1nUajxi4oGHuwY3kCZTeOO/Dk7QnqMx4CXfetcULQikbM9mLfX76NaHg4rHURE0nnlaqEy9srg6dnq3jPzYoFeOsFD0CliytrSiDgG9WjAkOH8iUDXX5hapoNd9/UVNIr3p2vZ/Jdy0JRTWjGw4vNfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731635143; c=relaxed/simple;
	bh=t0raWHDJz1Uphre6I/cYKzrzoueC9YFL2e8Dr84DiKk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EMvRJJ6LMLRDmG6cC20vbuBV97Weeh6tfj4+IC5wGTwzSsxfI91Y/+pQIAUry0Zjc/8XdoKif7cIPUXjUnPM9L6U1qsKK1TfNGZklzDhq6fqX5ZCIZTz4OJhDNZ+6OCBrUEHO4T/moTfYN+chpK3lh3G7J+8Uyt45W98uNhluic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXkZUGLF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E26C4CECD;
	Fri, 15 Nov 2024 01:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731635143;
	bh=t0raWHDJz1Uphre6I/cYKzrzoueC9YFL2e8Dr84DiKk=;
	h=Date:From:To:Cc:Subject:From;
	b=YXkZUGLF3pNNYCyDYsPijekWAIO9Wzk67CC3cH7mn2db9e1heVCZyZoELWps2lkKh
	 IM0DieLqi1S3S5TiG/j/VK6SbDrmQKkFw8A8bHplUqc8vWgyY5qyX5slVKatdXK/CS
	 PHJb/X3nlr2LdYzCBqt7iFBqQjlLNnwxu5OgbfzCxadXivPFcWXbYNRxf1MyaJyGQJ
	 xNWb/sSnBDf82B8Ud+omcLY0GhuyvguYlbrQV+TSCUOr1Njvv4DsGqPGQkewva+KsI
	 8R9l9KaXUoWY773fMQLECWmiPbGb3t/U0xIP5vHSQQelbiNq/oqkduLimhrKIz0jtx
	 nrKpTsJmTfWxw==
Date: Thu, 14 Nov 2024 15:45:42 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>
Subject: [GIT PULL] sched_ext: One more fix for v6.12-rc7
Message-ID: <ZzanxsRGoDnxxa2x@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit a6250aa251eacaf3ebfcfe152a96a727fd483ecd:

  sched_ext: Handle cases where pick_task_scx() is called without preceding balance_scx() (2024-11-09 10:43:55 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.12-rc7-fixes-2

for you to fetch changes up to a4af89cc50f3c1035c1e0dfb50948a23107f3e95:

  sched_ext: ops.cpu_acquire() should be called with SCX_KF_REST (2024-11-14 08:50:58 -1000)

----------------------------------------------------------------
sched_ext: One more fix for v6.12-rc7

ops.cpu_acquire() was being invoked with the wrong kfunc mask allowing the
operation to call kfuncs which shouldn't be allowed. Fix it by using
SCX_KF_REST instead, which is trivial and low risk.

----------------------------------------------------------------
Tejun Heo (1):
      sched_ext: ops.cpu_acquire() should be called with SCX_KF_REST

 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
tejun

