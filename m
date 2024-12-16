Return-Path: <linux-kernel+bounces-447415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28929F31E4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7E9C167A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4317F20627E;
	Mon, 16 Dec 2024 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="rSnVWTdG"
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF87206277
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734356673; cv=none; b=dbXTSWENkreVSEc4nvgZ+bHsFxfVOeTQrqMPUJTD2P1y+jvow9t7uFiyUPxacMBJuhtPxvfoPopXdtHQIKYfFJFmL2RvC5ECGD3xguELtoW1XjssW4aEJ/TcKxXvJwJSRuZrBx8SMp/r6DzQU0l0HR/HhKxA9iDzo5zf53urG2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734356673; c=relaxed/simple;
	bh=D2VX6cwA7e9+c68GMQllKclVGTc4bRCG+8FblovD1+Q=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=JfF/rtPeSGpklSPjCWiLeZuQXGDK00qHRBpiDMrOjTXcrIAqMtxb1dNsafKq1I2fXvODE/FPaxzR8477o5yTOJAAMbhqL5XLkqq8FCSkZwR/yPHdvKVrseRJAGYLwpaj7B6SWinGTepQa6D+W/QiXvfFRYkXKk1m/a/XtVq+R9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=rSnVWTdG; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1734356668; bh=D2VX6cwA7e9+c68GMQllKclVGTc4bRCG+8FblovD1+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rSnVWTdG+x4gPPu6whgdIzR0makTx3NBy/SG3Jiqc95dit3ZS2+fmB8BD8B5Ld2sA
	 1CETfZ2xHFdL+YiKnZt8z5FqqrnlMuW0Vb+PiGwD2qAEAHuNiESP5+p+SijgzLjid9
	 JodXFI0UXKsZ6YZkT6u0hhbZBn8FNz9fRZFMZWlQ=
Received: from pek-lxu-l1.wrs.com ([114.244.57.34])
	by newxmesmtplogicsvrszgpua5-0.qq.com (NewEsmtp) with SMTP
	id B1AA9266; Mon, 16 Dec 2024 21:44:26 +0800
X-QQ-mid: xmsmtpt1734356666tpay90c69
Message-ID: <tencent_2A63576BA6DFB370836C496EE3B4C4505705@qq.com>
X-QQ-XMAILINFO: MqswyhUqVe0CopFLYuoTfRPZ5k1ZzPTEYpyLwEeoNLrsWSVKSocLtollm+iy07
	 3fzn/NxVKYwLmLlKpitp6lGjI7Ppqd8qqFRvSdaoFEY9wqdfqf1PccGcu/8DI0W48Mvdb3iTO9VH
	 C6d9bR9IZvs7LnjDI/t+hsEdnDfQxXeYnvxJu2ZJRvCot4EfGTYkJQHgORZeaLdeh68mtWekuUTz
	 36d+UQLdpbDYfxl9SA1MIbZyzn5mfzEszO67vnF3nYBLUUt+cr1f+TRugtQP745AaoSJqIh0HbY+
	 rA/U6LjT+nHrU7lmar9FfzTe1RLJt+uNu6UyHjbgjjpgbiUXqW3JqwwAGkyQmXG0jKGONLlbzC3W
	 H/3uZsZKg/mnrJgSF2TImW4KyU6Oy6Ee/QG5GiNLOMknWI7n0XDxAZpFewI1ULCf/3GOWu3qo6tQ
	 DqqYrWCB71j3lPKvTSoP/OYeSMtxv5yiNvwQIsUbDiNnTtQ9DEmrSNfu5TFr26FBvBhNm/JmNYSy
	 Ru9NBsZppTLxGsN2FIzjhLYD433H54B3JAiBERTAsiwaNqt/UKuIeFMbE09IFWYfILCiJszMG9Du
	 yUkkoHETaPEE5iG04iuD4yIg2gaWmtFCTgdRuDxqFgzxCPT76DkdO91ptuOhV/I2JwBYYgDPTJb8
	 8WdjBn6Y3vN2PLsqzEnk+Gg/LgI/zkmPATIBR/wNfpsaiz+nHYvSgP+GH3pinzAH3sSmPl2tM4ye
	 dUa2zCoFl8uJnJitoxwLY4LdIFhP9QvCsNBqZbBEALVzOpRV2weVjIl4O3Z0stmTPiB+1f2chjPq
	 e12SKbMopOcNCSngNLJykqjkH0xQvHkBnNwz77PdCKSY7CyEoJa+Y17kJnFswyzkWHaj2Uf3Sxo2
	 W+qCri2vt+ekNkeZyZAzxqhsty7eGWfscWM02RerIAs5TJpnLXZ952prUGaA2ytsOMXxP4lf6qab
	 bPNHoBSGYvQxM/FMKm2F4aSDvYPriI
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+345e4443a21200874b18@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [trace?] KASAN: use-after-free Read in ring_buffer_map
Date: Mon, 16 Dec 2024 21:44:27 +0800
X-OQ-MSGID: <20241216134426.2377566-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <675fe376.050a0220.37aaf.011e.GAE@google.com>
References: <675fe376.050a0220.37aaf.011e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: https://github.com/ea1davis/linux kt/syz



