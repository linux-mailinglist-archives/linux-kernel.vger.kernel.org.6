Return-Path: <linux-kernel+bounces-253866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F26932812
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A69A1C22C42
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2FE19CD01;
	Tue, 16 Jul 2024 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="jFeICd8j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JoQvLheI"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9188F19B59E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139317; cv=none; b=iacREkTpESV8MVaekKsrTUxe8P5hfQbtUDegnCgNRDkLwDmnEEwNCbRE35Ev1rxm8ErJKdIUH6y1gJ24/urCkPv0FojTBaGuxW8DgoHfT+Z0c+HNa/sdu+PbOSPLX77jlpvgCiSi017c99iVcfanqPvoegLpdCVM3bPcABfej50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139317; c=relaxed/simple;
	bh=HlGdOd5dqkSqcrwCMdWmkz/K8kHNjKq9mNZ2Rtya5eA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BcLDkZvjboXKIw4rKOLblRn4T531ysWr1JTzrj4GiW8gKUzaV+3TSB1rv+LZDxCAi9AOjuyjHVVfY4aHa1lYSKlXyi1sHDppYztCIi7LjAmnTNiR5ZVCKGa+XtuEm0wrRljQiDKo/leLkyGlXLHBhE/wRLq8yS4yAyCEClbh47U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=jFeICd8j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JoQvLheI; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B937911480AA;
	Tue, 16 Jul 2024 10:15:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 16 Jul 2024 10:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1721139314;
	 x=1721225714; bh=8NNf6PSflYzXxqJ9whA2dYuWQM3qAulX8kNbAmc/R5c=; b=
	jFeICd8jAzm0zV9OJUfDJ9n7+4rOSCxUhk+EM5z8mZIlhdy9uC2l11epV2bFGlzJ
	dcGf19MeJ19+zkwJtB5GODZ6YvZPQsWuyLRrot+bFyJNKqKKyMI0QuqHsKJJVINl
	a3JNwqKmptwhmCv9Dk2Rs3dcfNBmYLih2DJSstCT6Zac0KSUdqmDTwNoXHitMI0W
	zSWlFo9WFkDt3WOcNQ4fNpltjJNASARMtVacfmZR4segCNVbHDeobf/pzeEpokW1
	ifL8JJI7HGQAY8Hy6rDZFGpW8H6Lm/iAA59Zg9kH6RHuIswjc/x6xXaJ/Sgqguk0
	2T8JNcNTZNV5+wYSXYEdJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721139314; x=
	1721225714; bh=8NNf6PSflYzXxqJ9whA2dYuWQM3qAulX8kNbAmc/R5c=; b=J
	oQvLheIeuwxxoFzyzCxWE7IqT1RjpR6Ow1mbH8Bic1WOrEZSuyR80snDWTHD42uV
	3vXDXZs9zGA5CjVaIVpUUwRF/53+8wfnzh5N37yD7eODD1LyBt7vFNJU5GPOMyAQ
	W28CQgyg0Pu7KYYWwAxBJX9KqYhOG5FmlhqML0+DyyDFp0NyZzyPF8xmiH4eNvQO
	FSmNUaStL8JWi0hwInHWIOSG3ouOzArCmHeGgC171Jor07ti69DRz2f9bZv6faoF
	WB2YIHMTuPjom04dKitm/fJvLBwhDSmnP0Zz9N2dkqio4pBanQg2VHdaTcqDt48r
	5rsZANDgu7/m9ZIIK/yjg==
X-ME-Sender: <xms:cYCWZuNxEiSlVaR1j-zR4_Ajj0yUQouEtJehXXrROLRS6r6cP9tKhw>
    <xme:cYCWZs-LZg20IRtGFtXgXsqzyQuaZpliUPazPdoq5LtpjwthvtfSmd8Pe5zLf25KO
    x2NogUw670fvIYI6U8>
X-ME-Received: <xmr:cYCWZlTZeTIGAmNCBZCiGXKCCzQWTss10y1MrboVjFBrQBdjTWVxgHz2UuRXwXGD2Sx4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeggdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefhueev
    geffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:cYCWZutsdm2TZC2aYJRSSO-1nODunbO89h2CsQcROJKB7UoZZb59PQ>
    <xmx:cYCWZmdGL3BLuqfhYpLGSq2OlkDmztVeBCWlSsK51SwY7RWxgzE7-Q>
    <xmx:cYCWZi0gPPf0D8-c1_v798WfGRlo4Idn84-3WGnV-mKqWrqShUMQKg>
    <xmx:cYCWZq-ym2taSYXE9khWce8iK_3WGfgWE54uQbizVWS7Cs9_dRsVlg>
    <xmx:coCWZsunViBP52x4B3yRz0wZujsCic3ogXfqmn_CEyVAk4sjetsctSgM>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jul 2024 10:15:11 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 16 Jul 2024 22:14:59 +0800
Subject: [PATCH v3 2/3] cpu/hotplug: Weak fallback for
 arch_cpuhp_init_parallel_bringup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-loongarch-hotplug-v3-2-af59b3bb35c8@flygoat.com>
References: <20240716-loongarch-hotplug-v3-0-af59b3bb35c8@flygoat.com>
In-Reply-To: <20240716-loongarch-hotplug-v3-0-af59b3bb35c8@flygoat.com>
To: Thomas Gleixner <tglx@linutronix.de>, 
 Peter Zijlstra <peterz@infradead.org>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>
Cc: linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1087;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=HlGdOd5dqkSqcrwCMdWmkz/K8kHNjKq9mNZ2Rtya5eA=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrRpDelTuJ/17SztVfxmv7UyVnLyltANExbmdIl94KgVc
 u2f/M6zo5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACayfRUjw3dDpqOrpELbQ3Xd
 Y42sb6z+HOy/d89SnUs3P5mH3BGUUmT4HyGvJzqrxMPkVF98ZaR78XT5v/8y63cIy1m2qesezn7
 OBgA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

CONFIG_HOTPLUG_PARALLEL expects the architecture to implement
arch_cpuhp_init_parallel_bringup() to decide whether paralllel hotplug
is possible and to do the necessary architecture specific
initialization.

There are architectures which can enable it unconditionally and do not
require architecture specific initialization.

Provide a weak fallback for arch_cpuhp_init_parallel_bringup() so that
such architectures are not forced to implement empty stub functions.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 kernel/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index c89e0e91379a..16323610cd20 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1829,6 +1829,11 @@ static inline const struct cpumask *cpuhp_get_primary_thread_mask(void)
 }
 #endif
 
+bool __weak arch_cpuhp_init_parallel_bringup(void)
+{
+	return true;
+}
+
 /*
  * On architectures which have enabled parallel bringup this invokes all BP
  * prepare states for each of the to be onlined APs first. The last state

-- 
2.45.2


