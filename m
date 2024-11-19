Return-Path: <linux-kernel+bounces-413836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086E69D1F6A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 05:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8E928235D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 04:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CDB14A0B7;
	Tue, 19 Nov 2024 04:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wmA2Ys4u"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D1429CA
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 04:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731991641; cv=none; b=KJ5dLMWZCKPvX7hP0vWjSKvydTaW8HxjnJoYgf7nN0JOCEUI/4JgDovwY4Dq68V9dzECdTPQsfzN1VwiQtkONMc4+5kZjSMkzIpwQKFrAiqL9sT/zb0YuHw2VWYfNYzDBSy3JSILpdUqHtZoaZp1CZZYQUuZZTGTJ+tAHVKEs6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731991641; c=relaxed/simple;
	bh=Q/uyyfZvTppkNfK9noyT1ACTXFKS1tYlwTrqqRJ0RsY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NSYGAppUPR0I4d4a5zcz28OCmxXJ605OyGBS7boJDUuoll4gAFwZhAWn+1fSIMEmb4Iy42gvrJgGtRCzJ8suAJts21VteYM2JfyaH3rQa0xO29q6ucE7zJCs5w0NXiZPfI+DRQUbK+L4QG2GEUJMUu1ltz3yTYrYQsZRffi9bBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wmA2Ys4u; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-50d399891d6so1123678e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 20:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731991638; x=1732596438; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mPqe+KWyPScVsgOCo4oxtDNj7oJCSQ2kVcWX01f8TQI=;
        b=wmA2Ys4uI3OWAI0jm4Cw1G4aa2dtX5mG7PilsKv+Nk77ny/O/WZACBSMdYzv+o33nP
         4EJUThER3T/NflBcCds9Lq2qE9D9NBOPM0hHZOHLjA5ooUmNoF/x+us9wwM39b5ZqGAQ
         1QyoYs1npAy8fuhNO7QAzeRftarQgMN57EBHD2z4x7Di+WlN4w2gwKHXGkkQAapHhgRU
         hHNDVFi26lRHq4/FQBArovmiNJuY8W5GdpSKSbCFVPxhpe6RWYxMf1AyqR+s7IBAacnV
         Z32CmBre99XfNK16KgNxYDdJN2jVpdan2Bms8wp3qs4G7yuIO7ZGy/WQ+bCquA2NJmjh
         GVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731991638; x=1732596438;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mPqe+KWyPScVsgOCo4oxtDNj7oJCSQ2kVcWX01f8TQI=;
        b=Mc/XGoeQtdQMPF6mPpeVRnKfqnsSJJVeI93bLi/dQFmMhXLvO5pg4f0NeNZF64MJNu
         Ab8GPX7a3zQ7MW1XGpxkbCGR+bO+xL0jUeXvu/jLt70B36d64UEK7VbFc7ljs5WBnify
         QlPrgpgZxrtQAqqRJxrhe9B0GslCs5xJ241u20ZmBoPAxtSn5Jj8fgl1E8/gI9n76RSn
         DwqeDIDMjhTaRlv2Wbrqy7EIQOEOhhSk2xLeZu5HZkVrm6WwmJa9KyZwzO7u3o4umlfG
         PYIBbQLuaYXRzyeEncJ6xBNmpPAY+Sd05bEgCP4JsY2JsZSplS2APZl2wIHAOfj1fTZz
         vn0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXj1pz7YErlWmU8B692v+fnVaHogjnqX7hwOogLtRU/BjxjlmLwc0hZQBCXRSBJvQR7BN3Uf6Ce4TYntk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgx16ljgzeVVrQz821qPUdJFcGq4HDeXMXM/Ep+QFjZvXkhsSZ
	bHDz553h0CTbdnc5sd/0pwvLztkdgXaot9P4LaUYmX6j9xKVTMYbjw+AWI6q26gGlB7kTSlayXu
	lv9eZtDmAWrf3EMk8TuJPIZmG6St4ahSr/Oy6GEVnJE1W3CsnvK4=
X-Google-Smtp-Source: AGHT+IGOA7V18nmrZN893zZO79R7F6VuICVIukkpYSjvoyaNP8NEtMqd1I7vjaEq/dCjZaYX+KlmiqJ9X3+ZCLGH27o=
X-Received: by 2002:a05:6122:3d0d:b0:50d:918d:4da1 with SMTP id
 71dfb90a1353d-51477ee3893mr14556462e0c.3.1731991638505; Mon, 18 Nov 2024
 20:47:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 19 Nov 2024 10:17:07 +0530
Message-ID: <CA+G9fYvLE55OjpQ4xs_w15+xBYi1BPJf2xTTFORA1zWAvqw91g@mail.gmail.com>
Subject: include/linux/mm.h:4224:20: error: redefinition of 'pgalloc_tag_split'
To: linux-mm <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Sasha Levin <sashal@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

The arm64, armv7, riscv and x86 builds failed on the Sasha Linus-next tree.
Please find more details below

Build failed
arm64:
  * build/clang-19-lkftconfig
  * build/gcc-13-lkftconfig
  * build/gcc-13-lkftconfig-kunit
  * build/gcc-13-tinyconfig

arm:
  * build/clang-19-lkftconfig
  * build/gcc-13-lkftconfig

riscv:
  * build/clang-19-lkftconfig
  * build/gcc-13-lkftconfig

x86:
  * build/clang-19-lkftconfig
  * build/gcc-13-lkftconfig

First seen on commit sha id a5b57900c6611b0a44e95b4ed011108435b43898.
Good: 6f9dfbd5bd86f54c62ebd3a7b41fb37ac4520762
Bad:  a5b57900c6611b0a44e95b4ed011108435b43898

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
-----
include/linux/mm.h:4224:20: error: redefinition of 'pgalloc_tag_split'
 4224 | static inline void pgalloc_tag_split(struct folio *folio, int
old_order, int new_order)
      |                    ^~~~~~~~~~~~~~~~~
In file included from include/linux/mm.h:8:
include/linux/pgalloc_tag.h:247:20: note: previous definition of
'pgalloc_tag_split' with type 'void(struct folio *, int,  int)'
  247 | static inline void pgalloc_tag_split(struct folio *folio, int
old_order, int new_order) {}
      |                    ^~~~~~~~~~~~~~~~~
include/linux/mm.h:4228:20: error: redefinition of 'pgalloc_tag_copy'
 4228 | static inline void pgalloc_tag_copy(struct folio *new, struct
folio *old)
      |                    ^~~~~~~~~~~~~~~~
include/linux/pgalloc_tag.h:248:20: note: previous definition of
'pgalloc_tag_copy' with type 'void(struct folio *, struct folio *)'
  248 | static inline void pgalloc_tag_copy(struct folio *new, struct
folio *old) {}
      |                    ^~~~~~~~~~~~~~~~
make[3]: *** [scripts/Makefile.build:102:
arch/arm64/kernel/asm-offsets.s] Error 1

Boot log:
---------
- https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-17648-ga5b57900c661/testrun/25904050/suite/build/test/gcc-13-lkftconfig-libgpiod/log
- https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-17648-ga5b57900c661/testrun/25904050/suite/build/test/gcc-13-lkftconfig-libgpiod/details/
- https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-17648-ga5b57900c661/testrun/25903704/suite/build/test/gcc-13-lkftconfig/history/

Build image:
-----------
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2p3Kl6GpLiKKJQQYlKrOay5O3XI/

Steps to reproduce:
------------
- tuxmake --runtime podman --target-arch arm64 --toolchain gcc-13
--kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2p3Kl6GpLiKKJQQYlKrOay5O3XI/config

metadata:
----
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/sashal/linus-next.git
git sha: a5b57900c6611b0a44e95b4ed011108435b43898
kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2p3Kl6GpLiKKJQQYlKrOay5O3XI/config
build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2p3Kl6GpLiKKJQQYlKrOay5O3XI/
toolchain: gcc-13 and clang-19
config: gcc-13-lkftconfig
arch: arm64, arm, riscv and x86

--
Linaro LKFT
https://lkft.linaro.org

