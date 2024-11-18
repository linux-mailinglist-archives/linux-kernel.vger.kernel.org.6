Return-Path: <linux-kernel+bounces-413244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554A49D158D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C9EEB29406
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78711BD9FE;
	Mon, 18 Nov 2024 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YXuZK9Mi"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E50B1B393F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948084; cv=none; b=I3creuGgM0DqlW7JaYUh9JUf5sPB1MDJSzLL9nWhE8B6Rb7eurtngTePddf//L1/NP6GjtENuiK6rydhd3NKX4hGRPlkWIdemw3bTnt+9ZQh/AhQcZE/AwNKdDC+Eu3rgaXgz+hjlGt2hClj0aoVKxMUd0nIC3A9y6uinDS0uAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948084; c=relaxed/simple;
	bh=OkG6FDF12WezB2znLdp4NK+o20weZKCRYd59LIRoqa4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lloa73aQNZApMWLalv1m3bQE8/MxgUUpOCRvriu77OzfcPRGoUgHfCzeD0pHELfq9Ylu2H/b5w8MzCJOe2g9vERqNPEhWqyLKZ4yI+VXiAho3wS067QZxFSf4Rp1k1s5/KQHiyxXNbixZ9vgcWynx69zxePTJe4Cy/cJ7+IcLkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YXuZK9Mi; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-382376fcc4fso1126674f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 08:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731948081; x=1732552881; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/QHNoXMHuXKnItR3FRMIyKXlVWkteInpy+dVr5mduUo=;
        b=YXuZK9Mi8jsktb7Rv8qZuKasnGZTtR1KZmmDwjhzK0BudPmBzL0mSEbfpAt3Nzet19
         1Yd/v5B8MQNSFU9dkcYgIjRVwXlAQZPnY7piiMmWZq8DwhSQhUMjO7jWWh5BktaiS/SU
         aRzeCtlYJ1GPS+EFof2ypQ5MHY3wvK3xvywhXBIIkQiGZs11mjJVwyg+YVFV8qvFsM/u
         N1tpJxJDGrrsfN+GzlP4iV6x1IhfZTXhq5Qb/8KLljeeZ2PDwQrwkStv+K0lAH5iPypK
         dcnOV0dqSemH9wD1qHLPCjH2h96mQ280blAlOIcGwTI8x+9v15dBl5eE8bLL+jC/lf6U
         GHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731948081; x=1732552881;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/QHNoXMHuXKnItR3FRMIyKXlVWkteInpy+dVr5mduUo=;
        b=ezTO4+DIoXdlBNfPIm64OXczxNdM5Q9bmglPM1htU3IdedaN5hGdLN32mzrfwa9bgx
         ZHTT0cdoVZmohbKEahPOX6+n0V3r9/AZaY8U8407M8bk9GPiEs/ii/0nRnK5swIjIlsD
         UTbm1G8GiIyMISYF45GJy0gFtMLzda1k7bLTeK4Nt37Bj3osLZXJeRPZwksytHoPSGNA
         Ohr1Mlt1cGdicGD0Rr+FqqDk/9hDHCp3YTw3rCgmdYUnTaFTHfQVhcDCn5psf3zWkCmD
         73+MaGQ8M+LqemPUER6hqoksk3FOBIl7LIyC5WX8dA+YFChbFqwfkg7SacOpb/QIQqdS
         mR3w==
X-Forwarded-Encrypted: i=1; AJvYcCVQRJZtAhrbmkwsWG8cOdC+YNCOHvoJ2kUbJFgKE6393Vhzb7KUjcy+saIgb90XWxBuUiCjyTqMhEEO020=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRMK0vehrQG3Ukxdib5/6skHlfEW//Q7hcERfiMlXyhEEWNuPr
	LOihkzI+5SR3gSRbNPkBo9Z7Q1Inl38XmXqOgz4V2wY8Te6+jJMxHh4zkBpmrtE=
X-Google-Smtp-Source: AGHT+IFnreNdDw3QcEqQY7tS1CAb6Cw+yerGJhNLjow4qy3Z3qdgi1fjSy3+RZGNcrYUEtWlGL0BDw==
X-Received: by 2002:a05:6000:178a:b0:382:4b6f:24ea with SMTP id ffacd0b85a97d-3824b6f28bamr1100599f8f.11.1731948080717;
        Mon, 18 Nov 2024 08:41:20 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3824259de02sm5127398f8f.53.2024.11.18.08.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 08:41:20 -0800 (PST)
Date: Mon, 18 Nov 2024 16:41:18 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, linux-kernel@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Nir Lichtman <nir@lichtman.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>
Subject: [GIT PULL] kgdb changes for v6.13
Message-ID: <20241118164118.GA31090@aspen.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 81983758430957d9a5cb3333fe324fd70cf63e7e:

  Linux 6.12-rc5 (2024-10-27 12:52:02 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-6.13-rc1

for you to fetch changes up to 24b2455fe8fce17258fab4bb945d8e6929baeb77:

  kdb: fix ctrl+e/a/f/b/d/p/n broken in keyboard mode (2024-11-18 15:20:22 +0000)

----------------------------------------------------------------
kgdb patches for 6.13

A relatively modest collection of changes:

* Adopt kstrtoint() and kstrtol() instead of the simple_strtoXX family
  for better error checking of user input.
* Align the print behavour when breakpoints are enabled and disabled by
  adopting the current behaviour of breakpoint disable for both.
* Remove some of the (rather odd and user hostile) hex fallbacks and
  require kdb users to prefix with 0x instead.
* Tidy up (and fix) control code handling in kdb's keyboard code. This
  makes the control code handling at the keyboard behave the same way
  as it does via the UART.
* Switch my own entry in MAINTAINERS to my @kernel.org address.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

----------------------------------------------------------------
Daniel Thompson (1):
      MAINTAINERS: Use Daniel Thompson's korg address for kgdb work

Nir Lichtman (3):
      kdb: Remove fallback interpretation of arbitrary numbers as hex
      kdb: Fix breakpoint enable to be silent if already enabled
      kdb: fix ctrl+e/a/f/b/d/p/n broken in keyboard mode

Yuran Pereira (2):
      kdb: Replace the use of simple_strto with safer kstrto in kdb_main
      trace: kdb: Replace simple_strtoul with kstrtoul in kdb_ftdump

 MAINTAINERS                     |  2 +-
 kernel/debug/kdb/kdb_bp.c       |  6 ++--
 kernel/debug/kdb/kdb_keyboard.c | 33 ++++++++++++++------
 kernel/debug/kdb/kdb_main.c     | 69 ++++++++++-------------------------------
 kernel/trace/trace_kdb.c        | 13 +++-----
 5 files changed, 51 insertions(+), 72 deletions(-)

