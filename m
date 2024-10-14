Return-Path: <linux-kernel+bounces-364138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE3399CB8B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368691F2141B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81CA1A76C6;
	Mon, 14 Oct 2024 13:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="EsiMtrt2"
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256D24A3E;
	Mon, 14 Oct 2024 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728912327; cv=none; b=pmdSGmZsMKACPVPiajm/NHXFjlAzXF5REOcem06kjYoCsBbk2nudga81e0DZNuexz8ds1MsbNQRQ2eeB2DbeBdyQKOT5G1CTArRHOzASLD0NlQk8Ox3KnR/bd2dgM0s6BcWUv8JyHZsjP9Yslts2hgk5F2yip1dt942MLnQOM74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728912327; c=relaxed/simple;
	bh=4LGnfpkdrhF1YL3rvudBoKrIi8xLytH39iOImBS+mrQ=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=WD7E11q/lAvW7dqF7LE+s2JW/b+CqwfBz1S+e7NjT/SapbvVbrAriwDbaCdW2adGm7qLI0iJpyf4XkdY9UAEkZmkVqTxSGRPYrS4qLip08z12KqUYBIrAbS8ogodnq2fQO88MT9ND9R92A3XsvQzwWs7f31DTv79GlfjD12hfHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=EsiMtrt2; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1728912316; bh=H4XTFw7v8vCO+XabILM0Ibb3Y5M/RcjK/LPhy5OtS8g=;
	h=From:To:Cc:Subject:Date;
	b=EsiMtrt23G2NVxT06GQlGcL7cV9MRN44TmtMBiyLAyYzIN+ogKS4mZs9mxzCucQkZ
	 zdSUNCGsVyHjs3QzmHIx+2y6SUkZl6evpbpVF0nt7r0qH0BI2emdSzRDe8Z8PDDEAb
	 Pq5qfC5lIjwb6rrVJ+9dSJ20dUcNf3XrcXIB93IA=
Received: from localhost.localdomain ([223.102.38.92])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id 30219638; Mon, 14 Oct 2024 21:12:02 +0800
X-QQ-mid: xmsmtpt1728911522tpzhnxlg4
Message-ID: <tencent_550DF0359B0E9E22F23DD2351984BA552708@qq.com>
X-QQ-XMAILINFO: OPbu+gyh5MQoJrs7EgkVdP7dJMAxmNv+0Y/fQpaEzM2i9RJ+FJDjQFujMdgbw4
	 08ubMUoXpelTZVDfzV5CrnqQNixNFzHQMyFd09HH5v2EYfZuu8jPb5YrkFC3v1GjNCEMmL7LFEJT
	 rgMoBivEHZtcYdFq+SZaNnKj1bZPIQaS0nsfMqUGTjoCxvjEArOasJUutlQe2yD7AqbIHa5jU0ZD
	 hzbAU5LRBth6TKupAYqCPaCH5V+naL3xgJF9NM49IsXw6T8ycphB/YdgeOgUDeHf3hmG0pPN+8P4
	 GKsA5x6YiAE5/6NIUx2r1SOzT46h4OjYn4MkuHbS2Uzu8hHYkJ1zc2Q75XUZO0FkgxGPUg9hKkkx
	 w/saRE6QA3HyQ/6sY08bs4LFKa9qbeMd4gq81NlIuC2kfKA9HUaonrdIRi+lFXZngj+VcbxoYkjh
	 76ee8h4rYg+TDcKUWBRJhhldqdp5J0wCwAEK2XkpiS4sSbcpIQXduH85glf3lCI0H6pnkp5RlPlF
	 NT3rGi4nPtDMx7DMYbpxK/z5T0gca+G/z60f3WQYprkvQcMr5mqOfni/MBtdScD7Z3YfQcHnNM4G
	 zNTcMp8iVtMwFCvAoLr2JnoAwA2WcNMIkl9F3nI2PD+C+C7QTT6ramvsLv8opjA7bbjtT3iBykKz
	 f0Vr0NKng9MC3DSXijgP8eGuJlt23ETLUzTI8CizWt1ZOiu1iXvBjXNXRalt2rLyEK9CTOUOzTrI
	 p2bYCQonAJl6M1uDiHGotN7kkdi3GvU5p0Bq/+49tbBTgMP8WevlBPyzyWadmykuBJ0Z8pBHJY0a
	 bnqEkcrNGqLAwFV/VgOSIfXVnEvEc+Sa2YxExB2x+jK/XECI8cbML2GUdFLLbeZATH5TwI2fxrmU
	 eMVZsLCjOiuHjeDWWUnus9uUK27aBUz/8DEXkvJTnRmTJF6jBGRNx+Ciu/xzdFl9AXo53tP5wnyL
	 M5gCSLzU//8PsN0ZK7wAoNULCCtfhzAZjOR48UzXf+6JKGivuCtb0Hqxsn3tJa6DxtMuJkEIINjE
	 zMXbujhNmqUNW6GosTLMkyGJBN5jnaSjO1pooQKovGF7ByjIatp+U8ZedMLfuJS31IxhDw8+iw4q
	 PYtdzFVbnaX34j+jOVQ16EW+BkvA==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: chun-awa <chun-awa@qq.com>
To: alexs@kernel.org,
	siyanteng@loongson.cn,
	corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chun-awa <chun-awa@qq.com>
Subject: [PATCH] Fix a typo
Date: Mon, 14 Oct 2024 13:12:01 +0000
X-OQ-MSGID: <20241014131201.7463-1-chun-awa@qq.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: chun-awa <chun-awa@qq.com>
---
 .../translations/zh_CN/admin-guide/tainted-kernels.rst          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/admin-guide/tainted-kernels.rst b/Documentation/translations/zh_CN/admin-guide/tainted-kernels.rst
index bc51d7cff..33c36e1b5 100644
--- a/Documentation/translations/zh_CN/admin-guide/tainted-kernels.rst
+++ b/Documentation/translations/zh_CN/admin-guide/tainted-kernels.rst
@@ -80,7 +80,7 @@ BUG、Oops或Panics消息中的污染标志
 ===  =====  ======  ========================================================
  位  日志     数字  内核被污染的原因
 ===  =====  ======  ========================================================
-  0   G/P        1  已加载专用模块
+  0   G/P        1  已加载专有模块
   1   _/F        2  模块被强制加载
   2   _/S        4  内核运行在不合规范的系统上
   3   _/R        8  模块被强制卸载
-- 
2.47.0


