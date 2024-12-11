Return-Path: <linux-kernel+bounces-440548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 099A69EC0A6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 01:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C10192826BC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 00:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CE23D81;
	Wed, 11 Dec 2024 00:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNECI96T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7EB259C;
	Wed, 11 Dec 2024 00:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733876653; cv=none; b=Inn3YhXgj9uz0dHeZklZS8TM5Fs/aXE96zEnUxwpP3x0An3TRki6XSiQYDgj9mqi1FxIDlYqwfM477avJROEZxMrpAyrC6J7159FrLjiTLyUNx/Gvk8OmL2upOPII6IwgeKTQaXp2gn95AFJLKIwpH5DJsp7JI+FUGAHH8tglec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733876653; c=relaxed/simple;
	bh=5db9h6vEYljnH4SdvZ/1gtkuSb6es2XIyXpEQw0tmcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X8q8yH4QY/+3cSVVfO8eDYr8HevKY25IiqYY+vgzvisNsfTM4mhQNLunD6ahlSJDdBnGgewQiufAk9FJMDyT/kBVUfht1P7Wjts77gM8rdnNVUcQPL0QIX55L6qxCp3AEQmQJ/lMWY5IA0LL+4J2IJ++6ME+kliHAqq9+iJwOZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNECI96T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C09C4CED6;
	Wed, 11 Dec 2024 00:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733876653;
	bh=5db9h6vEYljnH4SdvZ/1gtkuSb6es2XIyXpEQw0tmcI=;
	h=From:To:Cc:Subject:Date:From;
	b=gNECI96TdAa//mtsHM2Lh34XqPUdaoz2Gakb24BH4EXFbCWb5Ve+hxJaXKU1VtCYY
	 RipJdgsN6oGju2zUuvthVP1BwPLQnjg6HFlSQf00NjQOiU4wjWedA73aVSGD0EvX8F
	 bx/E6keRXdVTeaqfUFyvL+H40KBw6U+B8aHkM6cftfmAV5VuurQtVf25nyZUXjKGtY
	 o1owOLFds0ZxdXZxzSJY2OXqwb01sS/VbouNobBlx680sW+8pzbg8J+Js17hPnsSkY
	 +a15X1DYcN15uHDm3m1q7P2fdcyTyzfsuw8JNHjT5two+NcQxIhH9zfvuFAaUFJpl/
	 7QfPxAeFxLNzA==
From: Stephen Boyd <sboyd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v6.13-rc2
Date: Tue, 10 Dec 2024 16:24:11 -0800
Message-ID: <20241211002412.449222-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 52fd1709e41d3a85b48bcfe2404a024ebaf30c3b:

  clk: en7523: Initialize num before accessing hws in en7523_register_clocks() (2024-12-03 14:54:12 -0800)

----------------------------------------------------------------
Two reverts and two EN7581 driver fixes:

 - Revert the attempt to make CLK_GET_RATE_NOCACHE flag work in
   clk_set_rate() because it led to problems with the Qualcomm CPUFreq
   driver
 - Revert Amlogic reset driver back to the initial implementation. This
   broke probe of the audio subsystem on axg based platforms and also
   had compilation problems. We'll try again next time.
 - Fix a clk frequency and fix array bounds runtime checks in the Airoha
   EN7581 driver

----------------------------------------------------------------
Christian Marangi (1):
      clk: en7523: Fix wrong BUS clock for EN7581

Haoyu Li (1):
      clk: en7523: Initialize num before accessing hws in en7523_register_clocks()

Jerome Brunet (1):
      clk: amlogic: axg-audio: revert reset implementation

Johan Hovold (1):
      Revert "clk: Fix invalid execution of clk_set_rate"

 drivers/clk/clk-en7523.c      |   9 ++--
 drivers/clk/clk.c             |   2 +-
 drivers/clk/meson/Kconfig     |   2 +-
 drivers/clk/meson/axg-audio.c | 109 ++++++++++++++++++++++++++++++++++++++----
 4 files changed, 107 insertions(+), 15 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

