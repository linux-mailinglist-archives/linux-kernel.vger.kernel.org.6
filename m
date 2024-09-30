Return-Path: <linux-kernel+bounces-344291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF1198A7DC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2960C1F22BCE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31946194091;
	Mon, 30 Sep 2024 14:53:35 +0000 (UTC)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E8019307D
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727708014; cv=none; b=pQOULDrikBO53dFH8QyVHu2BbFu8f3A7b5M3Qgrnh11Kdt/+Lq5vlp1DLzygXywtMefUWyD0XvQjWe1wnVz800NmMgLA1ifxEhFGeZf1X5PJjXmgFHND7FGQifb0WridCWks/ai8SMjeyYmx717gpgoiZgptvvJb5d5n8s335CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727708014; c=relaxed/simple;
	bh=AsFHJkHKHSFk++dqeXbYKRiRHST/DgwRxpeWfGe3RVI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DSAHQ8rFYILtRBh1FtdKhK/gi5tXfV6Ge5kjP/9aniJ6amTcd8LRnkyJBnZT/Q/dEIyJOBWBz8FYNdkghRKbdmadeUW8BCeFvMRwQxFYlOwUhrisT3PxjY8OcmqE8y/vPKs/AnkilM85v85YuthonMER4hOibRVY8/wGK4iPbFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:99bb:7ad4:7fac:370a])
	by baptiste.telenet-ops.be with cmsmtp
	id JetN2D00R4pGYif01etNcj; Mon, 30 Sep 2024 16:53:23 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1svHlz-000wc7-8C
	for linux-kernel@vger.kernel.org;
	Mon, 30 Sep 2024 16:53:22 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1svHm6-000Xmw-Mr
	for linux-kernel@vger.kernel.org;
	Mon, 30 Sep 2024 16:53:22 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v6.12-rc1
Date: Mon, 30 Sep 2024 16:53:22 +0200
Message-Id: <20240930145322.129875-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHk-=wiwVOCZsC6a4dLdb1UjL2fS_CnLNjrPL0XGFbDd9C26Cg@mail.gmail.com>
References: <CAHk-=wiwVOCZsC6a4dLdb1UjL2fS_CnLNjrPL0XGFbDd9C26Cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Below is the list of build error/warning regressions/improvements in
v6.12-rc1[1] compared to v6.11[2].

Summarized:
  - build errors: +12/-3
  - build warnings: +3/-35

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/9852d85ec9d492ebef56dc5f229416c925758edc/ (all 131 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/98f7e32f20d28ec452afb208f9cffc08448a2652/ (all 131 configs)


*** ERRORS ***

12 error regressions:
  + /kisskb/src/fs/bcachefs/backpointers.c: error: 'const struct bkey' has no member named 'bversion'; did you mean 'version'?:  => 504:53
  + /kisskb/src/fs/bcachefs/bcachefs_format.h: error: 'struct bkey' has no member named 'bversion'; did you mean 'version'?:  => 332:49, 331:49
  + /kisskb/src/fs/bcachefs/bkey.h: error: 'const struct bkey' has no member named 'bversion':  => 578:48
  + /kisskb/src/fs/bcachefs/bkey.h: error: 'const struct bkey' has no member named 'bversion'; did you mean 'version'?:  => 558:27, 557:41, 557:27, 558:41
  + /kisskb/src/fs/bcachefs/bkey.h: error: 'struct bkey' has no member named 'bversion'; did you mean 'version'?:  => 557:41, 558:41
  + /kisskb/src/fs/bcachefs/bkey_methods.c: error: 'const struct bkey' has no member named 'bversion'; did you mean 'version'?:  => 292:65
  + /kisskb/src/fs/bcachefs/bkey_methods.h: error: 'const struct bkey' has no member named 'bversion':  => 73:31, 73:18
  + /kisskb/src/fs/bcachefs/bkey_methods.h: error: 'const struct bkey' has no member named 'bversion'; did you mean 'version'?:  => 73:33, 73:20, 73:47, 73:34
  + /kisskb/src/fs/bcachefs/bkey_methods.h: error: control reaches end of non-void function [-Werror=return-type]:  => 75:1
  + /kisskb/src/fs/bcachefs/disk_accounting.h: error: 'const struct bkey' has no member named 'bversion'; did you mean 'version'?:  => 40:28, 40:42, 39:50, 39:43
  + /kisskb/src/fs/bcachefs/disk_accounting.h: error: 'struct bkey' has no member named 'bversion'; did you mean 'version'?:  => 39:26, 40:10, 39:33, 40:24
  + /kisskb/src/include/linux/err.h: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]:  => 28:49

3 error improvements:
  - /kisskb/src/drivers/md/dm-integrity.c: error: logical not is only applied to the left hand side of comparison [-Werror=logical-not-parentheses]: 4720:45 => 
  - /kisskb/src/drivers/media/platform/nxp/imx-pxp.h: error: initializer element is not constant: 582:38 => 
  - {standard input}: Error: unknown pseudo-op: `.siz': 1273 => 


*** WARNINGS ***

3 warning regressions:
  + warning: unmet direct dependencies detected for GET_FREE_REGION:  => N/A
  + warning: unmet direct dependencies detected for MODVERSIONS:  => N/A
  + {standard input}: Warning: macro instruction expanded into multiple instructions:  => 285, 339

35 warning improvements:
  - /kisskb/src/fs/ext4/readpage.c: warning: the frame size of 1120 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 391:1 => 
  - modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0x110 (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0x14 (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0x30 (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0x4c (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0x68 (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0x84 (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0xa0 (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0xbc (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0xd8 (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0xf4 (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps+0x14 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps+0x30 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps+0x4c (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps+0x68 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps+0x84 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps+0xa0 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps+0xbc (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps+0xd8 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps+0x14 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps+0x30 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps+0x4c (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps+0x68 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps+0x84 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps+0xa0 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps+0xbc (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps+0x14 (section: .data) -> qede_forced_speed_100000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps+0x30 (section: .data) -> qede_forced_speed_100000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps+0x4c (section: .data) -> qede_forced_speed_100000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps+0x68 (section: .data) -> qede_forced_speed_100000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps+0x84 (section: .data) -> qede_forced_speed_100000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps+0xa0 (section: .data) -> qede_forced_speed_100000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps+0xbc (section: .data) -> qede_forced_speed_100000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: lib/test_bitmap: section mismatch in reference: find_next_bit+0x40 (section: .text.unlikely) -> test_print (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: vmlinux: section mismatch in reference: __trace_event_discard_commit+0x184 (section: .text.unlikely) -> initcall_level_names (section: .init.data): N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

