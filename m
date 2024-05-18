Return-Path: <linux-kernel+bounces-182900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C26C08C9187
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 17:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0650DB210C9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 15:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1226B42042;
	Sat, 18 May 2024 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="of7ycTYF"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4071773A
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716046022; cv=none; b=YrwbgYKFBdNq+SBBM2Z0GCfTqrJV+mwDcL5/MgZDG9AU1qU1XzxSWjDW2nbjt6PqE2aIZS47ECdE+4nH2nozlxaoRNxfMM7GqXYz+o33xvfkkw2CK/RQJZcvm0cXaLhlmPWQZIKetZzLCLFEoCM9LfgQh7XBrsqhX35JKMBuPV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716046022; c=relaxed/simple;
	bh=DZy+FWedfRSjJhXJreIAqHEVmdeJOB7Ux1qu6Gfhm60=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CTX7fbD/HJCtNfBnXejMrH9dUSFIAO7Td6jisDbZ/0jBG6EyywB/trO7l+DOAQAtPKEXQ5e+t2law/pm6uRl7d6mrriFBw4YSwLj3GCMXMyoYciFxdz+IIC4UZMsdWvXmDQ+c9/m7Qq45VyjOhQy1xGV/22qD0h3C8tU3CLL5cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=of7ycTYF; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41fe54cb0e3so8547715e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 08:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716046019; x=1716650819; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OE8Bab+aQnKnic0ok2i0M7ubhycGFpj9D9/lEUm4HRI=;
        b=of7ycTYFPISSuN0DJ7BOkbodbW/wqTiiQ4n6TZhRP3q5R07mvZzk9lt8m9My+FlhMu
         0Xqf0LTSuuU2n9o369Nj9lekqeJAcviO3vdESSckHlLzaHfUDwZ+orPLudfrBY8avKwo
         h4NxZML3XyWXAS4GRZ9BLYNdu7Al8PZ8MFpYPqySSy6hUS4RMDHHUGRq6/2P4o0MpqsI
         ebCyBkV8bEgA7d/nU49OXCiDQFPSxgN+O6MpN1q9nviH433I3FgIdPFZmLcVk8SfqSob
         RmAjR3GvKOyUtjWwCh7LVl3vs39VIuWVnFnOSiX5XLgxPvovJRH2he0lE8ZzPTSUd6ak
         TmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716046019; x=1716650819;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OE8Bab+aQnKnic0ok2i0M7ubhycGFpj9D9/lEUm4HRI=;
        b=upTMsaLBzQP8tM1PaUjB8cmmAuztb/kvhqe7R32I6YBl57ENWLP39tju35cqg42i9/
         9nd2iG1CUHdA6BIn5uuw9ANz9VF3S3p6EA8ABJY+WJS+NPdU0K746p3mCudnmRMPn9xX
         WJqVwvwP+hzHDyX8QWDuWlLIKnTC9MXsbUtGwvYa+BTW8eoi0bb3wX/870O6qVvhPKUE
         HWtDKWeHDtbCXVnK6r/f4WDQrfUkJIoEDumJL3om3yDrK9Bg2htNERLZ15u9uwIwRLHC
         e+ln/W0+sIMuhuKzDJvqaDslqMa+4yo+eNQkkHcYyx/3xj0eR1/fKQLpI0/ZuRpVRPqR
         vkUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtbPbvS+kmYJnhTefnRsa2loWgk3gvVs0c7mIxMGqkgZOzp0cf1VaixU7l0a57zNy5Ci92X1Tp99LYu5OyUVh4oR4PAIdTwYkW+7SY
X-Gm-Message-State: AOJu0Yx4vrV4+rGmDMlxq+KsKrl+z0NYlh7/SrDCsZSnUWzM+vHm6ZdR
	yluPpoSeOpdeIQg0HD29MamlO4Nufde8G83okKs9DF0XDhH28b7CQyas35g5VwM=
X-Google-Smtp-Source: AGHT+IE2LBMbm9UMmp01v8qP6lzVyIORp/0rU79NcFZGQPxrqY3NbEU65gobDcsd6f+yrgzPtnLWbw==
X-Received: by 2002:a05:600c:a44:b0:41a:34c3:2297 with SMTP id 5b1f17b1804b1-41fea93a34cmr215543775e9.5.1716046018398;
        Sat, 18 May 2024 08:26:58 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42013b4e9aesm242215915e9.40.2024.05.18.08.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 08:26:57 -0700 (PDT)
Date: Sat, 18 May 2024 16:26:55 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, linux-kernel@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Justin Stitt <justinstitt@google.com>, Liuye <liu.yeC@h3c.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [GIT PULL] kgdb changes for v6.10
Message-ID: <20240518152655.GA5820@aspen.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus

The following changes since commit 0bbac3facb5d6cc0171c45c9873a2dc96bea9680:

  Linux 6.9-rc4 (2024-04-14 13:38:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-6.10-rc1

for you to fetch changes up to b2aba15ad6f908d1a620fd97f6af5620c3639742:

  serial: kgdboc: Fix NMI-safety problems from keyboard reset code (2024-04-26 17:14:10 +0100)

----------------------------------------------------------------
kgdb patches for 6.10

Nine patches this cycle and they split into just three topics:

1. Adopt coccinelle's recommendation to adopt str_plural().
2. A set of seven patches to refactor kdb_read() to improve both code clarity
   and it's discipline with respect to fixed size buffers. This isn't just a
   refactor. Between them these also fix a cursor movement redraw problem and
   two buffer overflows (one latent and one real, albeit difficult to
   tickle).
3. Fix an NMI-safety problem when enqueuing kdb's keyboard reset code.

I wrote eight of the nine patches in this collection so many thanks to Doug
Anderson for the reviews. The changes that affects drivers/tty/serial is
acked by Greg KH.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

----------------------------------------------------------------
Daniel Thompson (8):
      kdb: Fix buffer overflow during tab-complete
      kdb: Use format-strings rather than '\0' injection in kdb_read()
      kdb: Fix console handling when editing and tab-completing commands
      kdb: Merge identical case statements in kdb_read()
      kdb: Use format-specifiers rather than memset() for padding in kdb_read()
      kdb: Replace double memcpy() with memmove() in kdb_read()
      kdb: Simplify management of tmpbuffer in kdb_read()
      serial: kgdboc: Fix NMI-safety problems from keyboard reset code

Thorsten Blum (1):
      kdb: Use str_plural() to fix Coccinelle warning

 drivers/tty/serial/kgdboc.c |  30 ++++++++-
 kernel/debug/kdb/kdb_io.c   | 153 ++++++++++++++++++++++----------------------
 kernel/debug/kdb/kdb_main.c |   2 +-
 3 files changed, 108 insertions(+), 77 deletions(-)

