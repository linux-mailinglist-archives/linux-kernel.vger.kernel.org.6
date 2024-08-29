Return-Path: <linux-kernel+bounces-307619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5682E965071
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13FD028661A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B321B8E9F;
	Thu, 29 Aug 2024 20:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGcykTYL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE0C1311B5
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 20:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724961902; cv=none; b=SkNwNCBjclj/zIZ0DRN3PnyCmnEsNtsA1HRqyho7b6Sat750++90cXdGqyav6TXbv2phRQK7gJQKiFhoBbwFTfkU42OpMK1WXHZDAQQ/hfJC2k07F27eOHwfsLi+OPShccbyM89JCXyHacCuz7e1Mh2YlGXFvwbe5FKllMMyQL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724961902; c=relaxed/simple;
	bh=9vTlWTNT+mxgyrmG0dESXThyO8SLw6oK0JGDKZTsEHw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JysMnwvQSdL9jL6inP9pwJAEf3hqyLaQHL5Ocp2GoqcG+De+zz/e0Ny7VK+C//NsvbPke0dGE6Sgdy/caqj9De3VRR664WELgtmv9sjIGKvDeqe+mW944YcBJ17lfpTFywD65I6ng+xyJvm/0ThYOiTHC590+Is/Y8Nr3PzgBd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGcykTYL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A71C4CEC1;
	Thu, 29 Aug 2024 20:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724961901;
	bh=9vTlWTNT+mxgyrmG0dESXThyO8SLw6oK0JGDKZTsEHw=;
	h=Date:From:To:Cc:Subject:From;
	b=BGcykTYLWRMeRkNVlI3Wm6b6xgZzC6TnyN0LG0EOVMWgZlUW3NYHF5e5WX+jAeT91
	 OoyJKH7CiLcO0GQ1w6cToEp2++DKWVh8XtDDqN5oyXDluT1Qw9GDapY8/5Y84U3brh
	 T1cLnHS4xqwK1sNq+rv4uVsk2Zw0ppSQcTrqUc4B7LRwAo+l+46ioM6NZjFRVkWMHL
	 yRb3M3AE1G4FI22Bdzb6dvlhkPVRea6NTCBRaFpyhP6NyOwT++yhy2it2pZ9kohve2
	 T+YUVkEHScn/8Bcg53tzHC00dN+KaRBdKLGLCXcEKWuqD/AgWhFFfLlM2q7bL9wrIl
	 48EXZfszX8T8w==
Date: Thu, 29 Aug 2024 13:05:01 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Greg Ungerer <gerg@kernel.org>,
	Kees Cook <kees@kernel.org>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [GIT PULL] execve fix for v6.11-rc6
Message-ID: <202408291304.2B20D61BE4@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull this one small execve fix for v6.11-rc6.

Thanks!

-Kees

The following changes since commit f50733b45d865f91db90919f8311e2127ce5a0cb:

  exec: Fix ToCToU between perm check and set-uid/gid usage (2024-08-13 13:24:29 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.11-rc6

for you to fetch changes up to c6a09e342f8e6d3cac7f7c5c14085236aca284b9:

  binfmt_elf_fdpic: fix AUXV size calculation when ELF_HWCAP2 is defined (2024-08-26 13:00:38 -0700)

----------------------------------------------------------------
execve fix for v6.11-rc6

- binfmt_elf_fdpic: fix AUXV size with ELF_HWCAP2 (Max Filippov)

----------------------------------------------------------------
Max Filippov (1):
      binfmt_elf_fdpic: fix AUXV size calculation when ELF_HWCAP2 is defined

 fs/binfmt_elf_fdpic.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
Kees Cook

