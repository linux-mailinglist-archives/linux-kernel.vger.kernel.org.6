Return-Path: <linux-kernel+bounces-330096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8860C9799A9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 02:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 517BD282837
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 00:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37285A29;
	Mon, 16 Sep 2024 00:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b="QrJlEXB2"
Received: from sonic308-21.consmr.mail.sg3.yahoo.com (sonic308-21.consmr.mail.sg3.yahoo.com [106.10.241.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAC61849
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 00:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.241.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726445547; cv=none; b=RjN2SI5bRxlnm/6afOhvvEKBJCr2QXusuuSDYgIODbt54QWcJ24IxppmCEfZB3HtZwxSgAAgDpMrqkRRSRw8GJLpDPEhXDYK+WlcKcqTilQpoanqduq7Ia/A4kxXuxOx+CwWEGQz6L8yWaQXGYtu+MsVkQ7ZBqHGz5QBJXUNsWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726445547; c=relaxed/simple;
	bh=JhF1+toXV3G2v4vEZXAzxyNXk8m1d+R/t9JppmZ7wTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=ajosoHwmq3Uh3u1D/xmBltkCwlnthw3AR+BsQxO5j5h6fzJZbAsKu5DBN08mDT/g5UmrS9gpaowHqVrIQ60h1tY35Dv4ZrU8u4+4pXykZfRpdCJUbac0QkgIdxxU1cI1BFFwds9ZMtCbi1jdO4i6mUl5qOxYugujyf+1KxH6lZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com; spf=pass smtp.mailfrom=myyahoo.com; dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b=QrJlEXB2; arc=none smtp.client-ip=106.10.241.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=myyahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myyahoo.com; s=s2048; t=1726445537; bh=5oNiWVZu9ZKL9lEl58ZCtsgJhu3V38tnkSoSEzwX1ps=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=QrJlEXB2sHLbdpVKkLJzZLGi4QQFJnajo6ZswG1eNpULa+WkeofM/4RCEP74Q9ozoSwZbS0VIDp6bJo9VJXwzxsi+/9Bac9YaFyBAtyCns2a6Catn17lj2zaHQfyIGRpaKyKgOMAzLGJIxSYZqqgxhKrzaHhtzHYjQ/ClvMo8Wh6c8XdG6/8FK50zlnBU9tWbfUZnVDPs9svQqe4ytBupgoqUkvmy0aoJTSOzwTkHjkxuHam+PBcjAdmjjCOO2mIoOfb6fQdN805TxiVLZgXmgndVUr8jwFlJjrlrhXmRKfzvm8ayHKpUdECSMmX4VEnV+OgJxe6C4m4hrpnPPePlw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726445537; bh=TqdQsxdhrwsWHWyv1CSaHXkY8rtgi/Eep62HVD6pPzS=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=t6EPKlgiavbbw+JIRn5DdtF+mt3RwFtd22JEf/e0nbOMxq2HAcrlq0S/yutXHksj8HFj0cDEbs4z4O/HXegzALvpiiU/P2loe6Ggz9ZMPWjD52W2JqaJG5OkZMKrrv3tIvf2DF/9wLdMUZmnk31rI9NVxfUea7J4X4pnlhCbpzwULU7j0q2cLwubqdEptqcT82l0JFASJkemq+dcQwngdS4v4tgX4AtJnbMnCj/1hshja0sPWiVZuy9ol4XrfjV/s25Oi/p6P7A0JoEu340ygul+ZfyTkGv77y5rjxLqJ+ZiSJu0bxae7pDJWNkPZ+K29O8Gb03HFlcYrxQ8QHBr8g==
X-YMail-OSG: a6pW.YYVM1kY0k7DyG9COzp8d5y68xbKRdBg1py.BrYvsCRykSiFvUCGXBfYrpj
 dSDOyDRWj9UzQB49I7CEslXqumj2ZryoOKE8eJAVvUbZ_mA7BGmIf7NqsOAN98I90i6Cs6crneow
 ffMxzYfcfFDuHWZkWaBsQtz5wVPwpoUY75uLO4sVF3Kh0jjMswsdzImZl2TqtZ.jnX1aKk68fX0F
 ioAGCTUk.mRaVPMjm_J8DJk2T1rzVJEpHa1RY0n_sSKkGtb2HHa7ppESgvM1n6uG6agHY9YLkqjX
 kzpoQIPZAKoh5gK4lzn5Vmj1ea6AgP3qsAlHJofplecT_YwJN6yrPkVc7DO2yn.xm5XNihatoWaD
 ZtdzTsEqSkbqutCiRrOWMvaR08..XoC_CPdPoNmXM68bQm_jhlfvywaAJPnziI5mYvJUdTRHCwBC
 q12MtjdtoZuVF3MJz_I0ZB3PR4q_swaUq.56Pge5fs5rPwXUXs4pLPTLsXLeeuE95mfAHrVBpASj
 ptyOqqDAveJ5x_G83SMR3KRf8NmzBdRcoi3QLtKsOX2dV9ZuLH_HwjpMyKiLWc0QmHb2L7UX5Y3y
 gdCyFEhbwocdu0eGWb6fxUueWgi_bq_VqD09b3nPN7WB9hPlXjNShy4F4b9UIKnKAzDAaAXEgUHz
 FTR3j0GavGnNe5hIA6FCkaxwi4713pFOSvBeFEUpHW8TnYI3rnhraPgcIvnRn4MdUDVcbrKW85fO
 t8Q3K7IYUmBiYy1IvlKKsqd.0CZjHbCvqvg275MHCxjiPm.DjVSr2S8eIeigEOgtUN1Kq2WK5u5H
 eoMZeD7j3jdqk78_D1v7Ro7B5p_Uf5pti1yK_SIkv3qAlHV0aWdTHZaV4Vx3fGx_WRkfnL5USIax
 f284GL0KiSYWXenSB.gd0waPUEKjGAU0T9K_0QJiZ0CgQNXcl2QFTs9ICwwCaxvYnKOMXkfzpCW_
 ld0e3oZqZcu3Q5upxnV68fAA_dpgu2FGH1kY9CRL1j6tLtFryCZI3ehStDuzEr98QCfK4R9HKB_e
 JC7bD.RYlrPrJK6BSmBib7QxzcgQzUaJrPNMU_Gl9fVt0zkSj_s2vn1iQFC7GHThK23M.n3JrKAq
 HxChKxTPi4zb662a8XTik8GeiHfxBlKtjCsO.Pud22DYWhvysL6NZSIAubwunYin4IHgej9JCLdE
 8LM1k7Ru6nQ1SljN5mRcqyz1.zE4ip1_.Px.d84pR5vE3aLy8dSg1Rs.ezNnVwOCs7ucCgQy6aO.
 OgrDzDG4JrzXa68edfY_gE66qefXb0gZTO3z5F4.t0LW_7UE8_59OryS97UfZIM9LLxie9J7O.Uk
 lvJPj5UBYPP.7y06xbTdZZyowUpVSP3aOLz0YCHO56aAomPdyHqfHmg636iXx8FjqCYE2xTkMKU.
 uMBOP0XaXkKnNusSaxw2nuuCcW44coY2v86QbrJccunc4YPxnnJEEIIDUaCM3zw2Zkf7yF96DuPY
 b0xsAeG1aFkfMwF9iV8.qqjuTAmVMeGCGAszgwmaoa9Pu9371tyF_vt6f7DGopRjHqft_9TUDOQY
 995mG5qNu3OyIyo.lm_EMpcHER9IXl64j8Wr.5qTYIGVoRJCtA.zVBevv7POlbjf5CZmLtHs2zis
 ERz8Wy.TISPJtXtpMnFl1J96kFAhuRKNEI49WXOkTVlqSwB2NCNLhTwgbjiMZLk.j8clPb7Vzqjy
 UkCGIcXb_zWWGPYdWcT9olJa3AhEWp4tGFqiyZe45b.olZ8qz1KnzIH99DoQgq7UoKj_KSQ.93iB
 XMjCAgMVzxN7xWDUvtstTr.uM1DlfuEb966UeaGoZWcdMYlhjNZQHv56eByqwOsOelkB2BV.apT7
 JJ_p_1PMbmFeU.GkIk9TPkdExttG2KA9wplrnljdMff4EzjtJX_Wwj7tS2uQI6x7i4yPNrueu1KW
 fbt_Kbcn.WS1NmVNqzsqZDm6d2mx63CRtHf6DEZiIG1s_4BC3wZ4LsMJHANmSZ9F_KAU5qv.Kb18
 RbrHpz0sXEK_eiFlG40xNYqK_CC80yxSBnShpew_PIiVCYPRlL27yS982DXOgl27XhU_Q9La1dx9
 C4CPdB9uG.0e9NHJgln0a5tf_hY3nTE_72WGfvTa87bZrNbqXMMuKUeo6cJ9SS7y_3FBFpKTn4X_
 7PZdj7c15eGG1cFQ_fZ6DNghcazd_bXWK7ZL23vTEdLzLqSmV.CGFrZS_rFgNk6fJfP7t1SqlzR7
 S8gCTphls30OKQfdWu.FxngKmd1pr11uKJdJDtduV1VvI9rK8uGwuA6huqsEIPFsIAeE-
X-Sonic-MF: <abdul.rahim@myyahoo.com>
X-Sonic-ID: 5ddb7eeb-6895-4716-a3fa-549a47eaf98c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.sg3.yahoo.com with HTTP; Mon, 16 Sep 2024 00:12:17 +0000
Received: by hermes--production-sg3-fc85cddf6-6lk5x (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4bbec87ee6aafb942a1f782e8b166a4d;
          Sun, 15 Sep 2024 23:41:48 +0000 (UTC)
From: Abdul Rahim <abdul.rahim@myyahoo.com>
To: perex@perex.cz,
	tiwai@suse.com,
	broonie@kernel.org,
	shuah@kernel.org
Cc: Abdul Rahim <abdul.rahim@myyahoo.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kselftest/alsa: add silent flag to reduce noise
Date: Mon, 16 Sep 2024 05:11:30 +0530
Message-ID: <20240915234131.61962-2-abdul.rahim@myyahoo.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20240915234131.61962-2-abdul.rahim.ref@myyahoo.com>

When ALSA is not installed on the users system, the error:

"Package alsa was not found in the pkg-config search path.
Perhaps you should add the directory containing `alsa.pc'
to the PKG_CONFIG_PATH environment variable
Package 'alsa', required by 'virtual:world', not found"

is printed 3 times, which generates unnecessary noise.
Hence, Remove unnecessary noise using `--silence-errors` on LDLIBS
assignment, so the message is printed only once.

Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>
---
 tools/testing/selftests/alsa/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/alsa/Makefile b/tools/testing/selftests/alsa/Makefile
index 25be68025290..cd022fc869fb 100644
--- a/tools/testing/selftests/alsa/Makefile
+++ b/tools/testing/selftests/alsa/Makefile
@@ -2,7 +2,7 @@
 #
 
 CFLAGS += $(shell pkg-config --cflags alsa) $(KHDR_INCLUDES)
-LDLIBS += $(shell pkg-config --libs alsa)
+LDLIBS += $(shell pkg-config --silence-errors --libs alsa)
 ifeq ($(LDLIBS),)
 LDLIBS += -lasound
 endif
-- 
2.46.0


