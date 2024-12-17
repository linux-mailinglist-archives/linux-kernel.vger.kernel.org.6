Return-Path: <linux-kernel+bounces-448341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CB69F3ED0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 01:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0141887964
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFC0AD27;
	Tue, 17 Dec 2024 00:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIDWMKAO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8258467
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734395695; cv=none; b=Ru8ZCtv8h9Gub+gqPK5LfywxM0GvAQPEWYOVLyAxISwR3SJfrpXlWQkyDq4OUvDXTDPn685AMK/z//BSfpph9D4JmJyPsgYvFWDZ9WHuzcaVpgfVj5n/4SSzRKWYm2jOmu8k9BDp8vx9VV4jdTr1do/b6wPR9L5Fv0n/B31vhwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734395695; c=relaxed/simple;
	bh=A51xpEcvnpkQ2K9xRu3KVcigkxSrou9Jh5x/UyvO8Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kupTBdTFaiiQf9kxCbmYhHaWrjrH9x7xcLIQrb6Z/TBAAm39hEkKlptunacCWAvbtdYjBfNi1RgGrf100P4n53C87vWGRKJDGME4KqS/mq+ge5zq5Ku9nuc0AIw7x9ez31i544C53wouGNimYmWUSUxVae1IsoxW5rCfoqM7ArM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIDWMKAO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA63EC4CED0;
	Tue, 17 Dec 2024 00:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734395694;
	bh=A51xpEcvnpkQ2K9xRu3KVcigkxSrou9Jh5x/UyvO8Nc=;
	h=Date:From:To:Cc:Subject:From;
	b=hIDWMKAOnZN57VuzFjcxW8ODr7SshXUsFYOXwgUNyAIV+ZVXrXElKZJTN81Y/6qYI
	 B6BnO5saIe8m9Yw2VzNLVsWX2rbjsJKKuWuxrUoYHgl4Zlovaxc7fUaj5goKaZ+Fve
	 MtMGZ3KEyEzBBAfFOPvMQ7sjTH3E7e4yZMxrvwX1272xvrKf5RnzVPxb6eypf6gkWr
	 P9bhlAYz1WV316AwfSt5hLmHKtGcsXVBTirvsU1pFFH2Lw+6KUj8VAEpabrogIFtjO
	 GctaNaN5GsvvU9YwZypS6Qmd9OZYmgX0rZuJtPqQ+x6S2lgUeOXE4Rmy1brnOnJocF
	 Hb5gy1njMtUAg==
Date: Mon, 16 Dec 2024 16:34:51 -0800
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>, Nilay Shroff <nilay@linux.ibm.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Yury Norov <yury.norov@gmail.com>
Subject: [GIT PULL] hardening fix for v6.13-rc4
Message-ID: <202412161633.8F8CF08C@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull this hardening fix for v6.13-rc4. Silences a GCC value-range
warning that is being ironically triggered by bounds checking.

Thanks!

-Kees

The following changes since commit f06e108a3dc53c0f5234d18de0bd224753db5019:

  Compiler Attributes: disable __counted_by for clang < 19.1.3 (2024-11-19 08:48:27 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.13-rc4

for you to fetch changes up to 239d87327dcd361b0098038995f8908f3296864f:

  fortify: Hide run-time copy size from value range tracking (2024-12-16 16:23:07 -0800)

----------------------------------------------------------------
hardening fix for v6.13-rc4

- FORTIFY: Silence GCC value range warnings due to warning-only bounds checks

----------------------------------------------------------------
Kees Cook (1):
      fortify: Hide run-time copy size from value range tracking

 include/linux/fortify-string.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

-- 
Kees Cook

