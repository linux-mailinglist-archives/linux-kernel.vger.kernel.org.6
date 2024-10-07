Return-Path: <linux-kernel+bounces-352846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39148992528
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86D328193B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 06:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4FA15C14F;
	Mon,  7 Oct 2024 06:54:49 +0000 (UTC)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAD51531CC
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 06:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728284089; cv=none; b=ezCUD+dFQSBQkTucody8+AMqnxrTERmBT0UjDn4O3mZQ6dhsAZ1uMNi6IueEyU3UMQ7Avg4XDardgh6/XOg1i0quO+PZJXYqqw91NkvhWzxu6EnbRR3m1wX8PcQZkcOgYtCbXU3I7xJg7l4q4S4rMs16a6RDGsl2+llDRKeqnBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728284089; c=relaxed/simple;
	bh=8yUFlRvmsfodMfhc3Ul5RKHg9MZwn+JI+Wyej+bGlcc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ocSPRLY/heGx5fcjQ4hFp3US7/vfYOUdIBRl+1SLWZfNzBkHCB6BX7a+N7JfrnlltwKxqGg5cLvItsFj8lEvq7PDjOHuYo8rGjOVXtebf2N0zgZXzaysh4oS6e4WmzWqItSHufwBZdDnfGAfWML6ZEg1L/wGqznAbaTINRuo+jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:994d:7f2f:4d2e:ae08])
	by andre.telenet-ops.be with cmsmtp
	id MJud2D00G0tRtd501JuduX; Mon, 07 Oct 2024 08:54:38 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sxhdU-002qJ7-5S
	for linux-kernel@vger.kernel.org;
	Mon, 07 Oct 2024 08:54:37 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sxhdd-007jDp-Hh
	for linux-kernel@vger.kernel.org;
	Mon, 07 Oct 2024 08:54:37 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v6.12-rc2
Date: Mon,  7 Oct 2024 08:54:37 +0200
Message-Id: <20241007065437.1842113-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHk-=wgMS-TBfirwuxf+oFA3cTMWVLik=w+mA5KdT9dAvcvhTA@mail.gmail.com>
References: <CAHk-=wgMS-TBfirwuxf+oFA3cTMWVLik=w+mA5KdT9dAvcvhTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Below is the list of build error/warning regressions/improvements in
v6.12-rc2[1] compared to v6.11[2].

Summarized:
  - build errors: +2/-3
  - build warnings: +3/-3

JFYI, when comparing v6.12-rc2[1] to v6.12-rc1[3], the summaries are:
  - build errors: +1/-11
  - build warnings: +34/-2

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b/ (all 131 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/98f7e32f20d28ec452afb208f9cffc08448a2652/ (all 131 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/9852d85ec9d492ebef56dc5f229416c925758edc/ (all 131 configs)


*** ERRORS ***

2 error regressions:
  + /kisskb/src/include/linux/err.h: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]:  => 28:49
  + {standard input}: Error: pcrel too far: 1060, 1061, 1059 => 1059, 1061, 1397, 1060

3 error improvements:
  - /kisskb/src/drivers/md/dm-integrity.c: error: logical not is only applied to the left hand side of comparison [-Werror=logical-not-parentheses]: 4720:45 => 
  - /kisskb/src/drivers/media/platform/nxp/imx-pxp.h: error: initializer element is not constant: 582:38 => 
  - {standard input}: Error: unknown pseudo-op: `.siz': 1273 => 


*** WARNINGS ***

3 warning regressions:
  + .config: warning: override: reassigning to symbol UML_NET_MCAST:  => 15122, 14879
  + warning: unmet direct dependencies detected for GET_FREE_REGION:  => N/A
  + {standard input}: Warning: macro instruction expanded into multiple instructions:  => 285, 339

3 warning improvements:
  - .config: warning: override: reassigning to symbol UML_NET_SLIRP: 15006, 14765 => 
  - /kisskb/src/fs/ext4/readpage.c: warning: the frame size of 1120 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 391:1 => 
  - modpost: WARNING: modpost: lib/test_bitmap: section mismatch in reference: find_next_bit+0x40 (section: .text.unlikely) -> test_print (section: .init.rodata): N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

