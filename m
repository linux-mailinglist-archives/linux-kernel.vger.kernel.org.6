Return-Path: <linux-kernel+bounces-253138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3A3931D24
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 00:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B9C1C219FA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 22:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3786C13CFA5;
	Mon, 15 Jul 2024 22:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eErREg8f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7909061FFA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 22:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721082213; cv=none; b=lIJBugFxETjAbOGUF2gYCeOrwZWECrn6rh9b/rWFQs/Srpps5OZzsM5xDqf0reTu1tgYQKoHhR6fWICaISwiT5dw2M0yv7dNj/iPKPdNirFL12TAyK2yUnrcThOwDmJQOZWCsIuhCvXqyaqqyeAbwNPPPKucbATYOpjC9Z1yea8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721082213; c=relaxed/simple;
	bh=I+Bp+SayNWo+JNEy6ZGU8RBtjgOteV7X8f9C9h/2G7U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q4tScGOnl4+IdMOq9njnCLxLmnIHrjMVNkYfaykKrWK6HalhHoQ3rhzQWSASEFkmRg0zMB9Til7wXdjYt3hLBPjnGuYgAjLhXITrxESBlzvvDXtxdLQiVelt3NTQRgkokRNxTeZkPOoMbAAaxfR6/8vZLIhTZLZ0JhnE7JITpw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eErREg8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9826C32782;
	Mon, 15 Jul 2024 22:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721082213;
	bh=I+Bp+SayNWo+JNEy6ZGU8RBtjgOteV7X8f9C9h/2G7U=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=eErREg8fzRKHK6FaKdCeJBHmM+aK5objOyFWJSL9YuXomxXEjtFbHlsYKub7gOLa8
	 AvnVmLG6b74bM/Y8yufTFmEg7VSFWRi00NklBw00B2e4Z+0JKpq4SOKS3g+hBG1e0F
	 xVzYdClCrqCczTHtkzXXTs1naLg7w+g9n5d8yzZZKPjyGFcn+G+6qjiooddunrx7K6
	 hxje1DPHhfdB+3aHV+PR/u6saR9n4onF4O2qzOvJEQfIWMyudUsIoCceQgEtDSm/g4
	 8fvMSUJ67ztaM6QyEuLRQJWgBpvVgUhAXJCxRjMznM/Uj2OiJWsqW5+Hrc2YEggX+E
	 MPyX8jE1XFB7A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8E245CE134B; Mon, 15 Jul 2024 15:23:32 -0700 (PDT)
Date: Mon, 15 Jul 2024 15:23:32 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	kernel-team@meta.com, elver@google.com, quic_jjohnson@quicinc.com
Subject: [GIT PULL] KCSAN changes for v6.11
Message-ID: <6d532a3c-709f-4038-8482-34dc2dcbfaae@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, Linus,

Please pull the latest KCSAN git commit from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/kcsan.2024.07.12a
  # HEAD: ddd7432d621daf93baf36e353ab7472d69dd692f: kcsan: Add missing MODULE_DESCRIPTION() macro (2024-06-06 11:21:14 -0700)

----------------------------------------------------------------
kcsan: Add __data_racy documentation and module description

This series contains on commit that improves the documentation for the
new __data_racy type qualifier to the data_race() macro's kernel-doc
header and to the LKMM's access-marking documentation.

----------------------------------------------------------------
Jeff Johnson (1):
      kcsan: Add missing MODULE_DESCRIPTION() macro

Paul E. McKenney (1):
      kcsan: Add example to data_race() kerneldoc header

 include/linux/compiler.h                           | 10 ++++++++-
 kernel/kcsan/kcsan_test.c                          |  1 +
 .../memory-model/Documentation/access-marking.txt  | 24 +++++++++++++++++++++-
 3 files changed, 33 insertions(+), 2 deletions(-)

