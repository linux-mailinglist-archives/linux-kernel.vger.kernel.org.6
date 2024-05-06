Return-Path: <linux-kernel+bounces-169743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B96748BCCF2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2FB01C21083
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6270142E74;
	Mon,  6 May 2024 11:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="VL+BUmJT"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A20E6EB51
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 11:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714995612; cv=none; b=tKtsnfP7HRW11INlFDFGqnMNWPcP2p92K/1uG6aiRj3pjG3KwxsMNwZnWM4jCszfnh8K/mxiQoLaZGLN6yn1f98DZNX4eig6R2VBq2OWAlJ7mCVMwJDZyMsrONkulpv2YEroin17WwPu1TH1SOILZ+yH5n446VkOiJ5j2G+elh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714995612; c=relaxed/simple;
	bh=64zvPI4wk4W3R/ef8iMMnRvP7Uy3a8dWKU6vsmusvck=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=NUxtYmhadntHjD7eZKIPqxPFu81Ys/JD3G3hO2sVwLjOX+k4HYxncf06+POx54SPGHnvhCCcl/2ZnJe29kWN6xeMggXbLmRkpiB585eYtijUJTTP6WlRcLJctUJy3hM14/VWiQyWBZWiGePKa2uEt51Y/sqXynUMGfyK4upjiPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=VL+BUmJT; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1714995297; bh=hsX8YMhBB0dEFpKuGmFTU8gw8zAdcF/L5mLr48zWyOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VL+BUmJT4AfdbUl2JsmIXAFPaK46z/iNMQl/H7U0+tF1CvC/IuBvOCfmMkiDVUGp/
	 Ehhx/BnW/eQWWnSeMfFrWC8vwcngPDsXesqcgBXmVb3rCmDUMp/BC/Bu9Dy/pXfOIC
	 dvBDA1iylQXOoQUc0HBHxiqla0NI3b8SxkYo77qw=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 8B79FC07; Mon, 06 May 2024 19:34:55 +0800
X-QQ-mid: xmsmtpt1714995295tyxnug4a2
Message-ID: <tencent_8FCF868D9725D00DF592245DE4DD86997807@qq.com>
X-QQ-XMAILINFO: NvH2zBBgt3uT6SfvEicVD2J9yaxUVknkQAQi2CD+YHShS8Q0BXyKhRJ+bWDx//
	 +dQ0YyFHEC4NWnv7QwAp9xIpP7J9Yg5UwYAOu9wvJqqJx6M1vi2zPat1TCYJB/W2RrDc3hxTSEGv
	 1WgCtb/4is8psNQQCo/qNGtmXHfoTBQ96qp3xrw0o3mxANzq6X5z77aiZ/zz8Qmi8KQNW6LjkMxP
	 lhgwsfGXKQLIWYO3DxZmiFaZqKhWJHprhJM96cAkuBsPzpTS4WqUEQR8xMmhyzy2vN4SvDj1HBTt
	 FPtlp71GGfKbzhj147nuqhDDjeIwmsb84G7Wyb2JeMHoiHMGSjuNG26jv1UMctOro6zwQbHluPDu
	 bacBSgmaY0CDc1qnLi0gEhnjUeiCO2Qm42OksX1u8uUvy6ta/ht+7B8ps2geU+OdSOR1Hr9O38fq
	 pXofBS6OSMTHjST+7PB6YzCZtqzboRfFiXQT2rZgzoydRAKEYNm3zZFoqSl8fuFChxxig6vv92cZ
	 pt1zavu+i3iyx40bLgPkIEeQUQNtR8/VM+FkG7mqNm7rjsVEOmbFP0jTCdbgQ2Y2qcIgAFPnQ918
	 EZtwh8Js6zjusOk75XH63vwZDBLcsjnOlUj/rQY9cfj+BAa9nFXqqfHWB6dqvKp3ghGgeHhHtddi
	 qedhUjUuaKnN6+MLqvX/y3pGX2UbOqOzKX+rySvWaCW/tsoonzBIb+8W6ZynpLEIYe3oDPgNoPwa
	 tefjgUowUdOnGOanP/+r6G907XvoWoDVGjWp9vvrWOPgdQgS4lKJMJQJtTDCOB0vV189r/LJtQwp
	 7QLqwDqpZO6Sd0IleY79ErtmF+wNcVB9ynQkHVn2AwMCSaUuz3WKI3uNcxi9SW9VXj5HSYai2PSI
	 r/YcqjeSwXaZJsO6ETaGu6JFx0U52FFzUXo+mwY1czsbViGrCBMskKjY6GTogrWA==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+594427aebfefeebe91c6@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in rewrite_old_nodes_pred
Date: Mon,  6 May 2024 19:34:55 +0800
X-OQ-MSGID: <20240506113454.1913490-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000000498630617b740d3@google.com>
References: <0000000000000498630617b740d3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test oob in rewrite_old_nodes_pred

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 7367539ad4b0

diff --git a/fs/bcachefs/bkey.c b/fs/bcachefs/bkey.c
index 76e79a15ba08..1b2cb956b2e0 100644
--- a/fs/bcachefs/bkey.c
+++ b/fs/bcachefs/bkey.c
@@ -577,7 +577,7 @@ static void set_format_field(struct bkey_format *f, enum bch_bkey_fields i,
 	unsigned unpacked_bits = bch2_bkey_format_current.bits_per_field[i];
 	u64 unpacked_max = ~((~0ULL << 1) << (unpacked_bits - 1));
 
-	bits = min(bits, unpacked_bits);
+	bits = min3(bits, unpacked_bits, 63);
 
 	offset = bits == unpacked_bits ? 0 : min(offset, unpacked_max - ((1ULL << bits) - 1));
 


