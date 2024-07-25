Return-Path: <linux-kernel+bounces-262012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25E093BF55
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DDBC284E37
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC89197A65;
	Thu, 25 Jul 2024 09:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pj0zkRrI"
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FA116F8E8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721900859; cv=none; b=uWUdVYOBZathNhQKTiTGZSJU/Lt0pZroT/1cCcY7alu5udg4Jo0EvNc2hfmLNVeh56ox9/uvWjtNHLn5dBdyZuwbdKAG9NbUTOt87yQnB3La3b7MWdI6BiCUmo1ypQbDiyqZtYCEuIbjUFUZTp2ulUQ1CbCg6vbBDK97M4OwK4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721900859; c=relaxed/simple;
	bh=VHnrK8mfrqp92FvzKcOHlbhtPGYu+/a5YFmfje6sRzY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ae6+q24n/hr+UL/xm+flZ5jn9hILbqUK+3I8TeDmxTjqzZ1l4xkB3kD6IJ8T68JeeWGqLyEaT88Azua2NyAyMBOHUYM1QDb3d7EtHd6oTLgFS2AcUGxoHZAHe159lY5qNtYulNSK+cRpn8uWGqwdqxBMvKyB673+vwfUCIIk86E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pj0zkRrI; arc=none smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so10485021fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 02:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721900855; x=1722505655; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vh6BnYvxX7cOZnOXp4A2FChUwK4hyixoaOdLFscobUI=;
        b=Pj0zkRrIcRXnVjaHjf7qkpAi1meQtJt1pGhtvGgnjdIle4u4WKIGHz61m7IqzIGfbo
         bm9EOZR1CXg8bJmhUc7+bTgR0Ad4kZv5tvYCHhfu8FnOlt94NxBnvnNzlzglcTU2Sc08
         CI7Wl+kzCX8a47PeFse3g5ElKfAFzHzJT+S3RIxSnZH1N+8tj6nCacnxyhESlYyc5nx6
         YJoxcOBf6lvXWg0JtKGC/9/9K4t0Uvnah3/8nmRi8PohpbwZVPZYDEMXzMVDaEOQXCs1
         IcnGzonSX8aKHTUpOobeAacRsRpq/9sWjysBZGlreSMf4I91AwgLBAG9gBSe9tkJUVv+
         eUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721900855; x=1722505655;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vh6BnYvxX7cOZnOXp4A2FChUwK4hyixoaOdLFscobUI=;
        b=DgaSYaQ0AAKsXXDR1J2+N3Y9AFQdAqZd3gMzkV1OUMXVOn9Pf7cQOeaqPEoGYl/pZQ
         GCb2+lmRm0z5/PYKkHbSfi+6sa3FmqzNbDkTGvozpKSUUSv2OeNN8oVJcTQSqB629C2G
         bv8WwyCHYxQLYPmdhzgxI+sZ9qQ/5B1oVUmt5xtBvG6mkZo0127nrPjMHBbzUioakTAM
         uRI3dRR3klOYODbw77GQt856rt9WW02SQYwPlR4sie3WvSRn9MQq3yVAsFl3kK2lisdU
         c0Ah91DRf65yDckkQHjmhNdi+TdGcrO8hA0fxCg8V775xRLlTKpdqmnVLzpfVRHL203P
         kfWg==
X-Forwarded-Encrypted: i=1; AJvYcCW0S3h7Wpy4iK/69NMCqGtcARy8CqClMZqNAvfgXRiJ7kZmmPdmkZWDjOYVFkmsLt5p/tbz4OWu5Z5SElll52vn1WM4fKmhYmc2Zz/t
X-Gm-Message-State: AOJu0YxSac/KnWWT1poHAu6tSUg+yRfA4dvquWd9CVEEw7wxd+D0X4SV
	iJUHvPjB6iY9wQR6eQfA3RGrhHtq+ZvCKRRE88deEuT98jhVP1T1HFjM42BOTrs=
X-Google-Smtp-Source: AGHT+IGNgwufr3Cr3jQ74vQshSOAsTk3pUl7POv3vHPQp5dPk860e9tKtodMAbWBLlzlQ9SH/Or4ow==
X-Received: by 2002:a2e:9497:0:b0:2ef:2f17:9edd with SMTP id 38308e7fff4ca-2f03dbf2e63mr8456341fa.44.1721900855508;
        Thu, 25 Jul 2024 02:47:35 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36863aa7sm1550832f8f.109.2024.07.25.02.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 02:47:35 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:47:33 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, linux-kernel@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Zheng Zengkai <zhengzengkai@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [GIT PULL] kgdb changes for v6.11
Message-ID: <20240725094733.GA2524052@aspen.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus

Sorry this is so late in the window. It's not even a good reason... I
just lost track of which week it was. Happily this is only three small
changes and all have been soaking in linux-next for a month or so.

The following changes since commit 6ba59ff4227927d3a8530fc2973b80e94b54d58f:

  Linux 6.10-rc4 (2024-06-16 13:40:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-6.11-rc1

for you to fetch changes up to 9bccbe7b20876a34c70b13430ea1b308fc8d5a7e:

  kdb: Get rid of redundant kdb_curr_task() (2024-06-21 15:49:29 +0100)

----------------------------------------------------------------
kgdb patches for 6.11

Three small changes this cycle:

1. Cleaning up an architecture abstraction that is no longer needed
   because all the architectures have converged.
2. Actually use the prompt argument to kdb_position_cursor() instead of
   ignoring it (functionally this fix is a nop but that was due to luck
   rather than good judgement)
3. Fix a -Wformat-security warning.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

----------------------------------------------------------------
Arnd Bergmann (1):
      kdb: address -Wformat-security warnings

Douglas Anderson (1):
      kdb: Use the passed prompt in kdb_position_cursor()

Zheng Zengkai (1):
      kdb: Get rid of redundant kdb_curr_task()

 kernel/debug/kdb/kdb_bt.c      |  2 +-
 kernel/debug/kdb/kdb_io.c      |  6 +++---
 kernel/debug/kdb/kdb_main.c    | 18 ++++--------------
 kernel/debug/kdb/kdb_private.h |  2 --
 4 files changed, 8 insertions(+), 20 deletions(-)

