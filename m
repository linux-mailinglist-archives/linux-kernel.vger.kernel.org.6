Return-Path: <linux-kernel+bounces-188419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C027C8CE1C1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1BD51C20E66
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7C6129A8E;
	Fri, 24 May 2024 07:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V29NG5FD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20894129A79
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716536950; cv=none; b=R3BD1mXCSawW30gwzcdBik7/U3JS8rkP6VNRGqjHl876cwlRmwP3sLxvlzXUFA270sO+E5f9Z9LtR3xIL1T2FiNBfWutKjG5dB93veLhR9BuUIlOTMTAXPABjUSGVoqq6ZCHcc+ranoa0L0CsPnWnMbkDNwl9Bm+jTBsAqIFD+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716536950; c=relaxed/simple;
	bh=utlEHUqwLb0a9EkIt9qkYExkZRdM5VZro1Uw5S6l5Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OdVh2g3ZPbdpiDMc2lMSLdMY3/LA0qSDzZF4hMPhgh4KR7sNfRhMKoGYzpMPXdPqT6gRaO9nZfVE7Oog1J83EfqfcXE3JtoL/KRR4CZ7ol88H5NJKAkCSUzFa8aTcZsuFwm/MOcmrO2oENvXq47W2kgmO9jgSD8FkgHAxaqW4mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V29NG5FD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D49AC32782;
	Fri, 24 May 2024 07:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716536949;
	bh=utlEHUqwLb0a9EkIt9qkYExkZRdM5VZro1Uw5S6l5Rk=;
	h=Date:From:To:Cc:Subject:From;
	b=V29NG5FD+m/SpbxXG1zyZg8HiEe75McinZuFskrQFIvssmjCd6vc59Qv63vd6h9m2
	 ItY6j4V4KU+AsD+Zbgfy26qOBZRnw1YTczzWUaAyeNx1jQOo74Ndc2ijCppSFp2+uz
	 XjI5ijl7NLlcSTcqsB06g4bM4ltK0EqlggpyzqRA=
Date: Fri, 24 May 2024 09:49:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fix for 6.10-rc1
Message-ID: <ZlBGcsni1Clme5hU@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit dd5a440a31fae6e459c0d6271dddd62825505361:

  Linux 6.9-rc7 (2024-05-05 14:06:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.10-rc1-fix

for you to fetch changes up to 008ab3c53bc4f0b2f20013c8f6c204a3203d0b8b:

  speakup: Fix sizeof() vs ARRAY_SIZE() bug (2024-05-08 19:44:21 +0100)

----------------------------------------------------------------
Char/Misc bugfix for 6.10-rc1

Here is one remaining bugfix for 6.10-rc1 that missed the 6.9-final
merge window, and has been sitting in my tree and linux-next for quite a
while now, but wasn't sent to you (my fault, travels...)

It is a bugfix to resolve an error in the speakup code that could
overflow a buffer.

It has been in linux-next for a while with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dan Carpenter (1):
      speakup: Fix sizeof() vs ARRAY_SIZE() bug

 drivers/accessibility/speakup/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

