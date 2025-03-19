Return-Path: <linux-kernel+bounces-567625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490ADA6886C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7E7C425B3A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F5E25DD09;
	Wed, 19 Mar 2025 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PS7hYZmg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D9925DCFB;
	Wed, 19 Mar 2025 09:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376792; cv=none; b=iXBa5mxG1bbXNakWyG0AD3mpH9ItvcNOgklffeN8pyUsqDnzrxmAWvuyUkHLBUUPzwIyX1iiQQWUN+nLBD9bMdSz6RPU6MvoEoBeUqPZ0V6/Gl48tLq5CSFePZwr3n1PTj2JDKtdLDsB3aoGJ6/QaLZ6XgLUi5WeHCyeDlogo/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376792; c=relaxed/simple;
	bh=eNseFhzSVipLNwxZ21Z4rZLqkjUU3kwov7Sl4p2zSuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uyTr80gSwDrRXtFkLBw/SO00aXnINKUdtmPRixHgS/1L0zIHqiMY5opZ7lx3cDlr6l4iXtDihe8DeWwEtmZhqyrZfwuvEeKia/5Mn526caTlIIWLAUGVRcCvsqQGBZS0LPDNSrZ30TnxZEENmfVQubrpHjgpLNxzvVu4hd2UWSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PS7hYZmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFF2C4CEEA;
	Wed, 19 Mar 2025 09:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376792;
	bh=eNseFhzSVipLNwxZ21Z4rZLqkjUU3kwov7Sl4p2zSuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PS7hYZmgW9/Pcfpu8MAoRyBArlwzkzGxBIGzzUzwPnrcaQDtEOYNDnkU1rhabkOcC
	 UqTMB/tSvMCvY37A96RSxDqiLymb4mFg5ZGmk9yWIKGeEopLz/dpmRA4wC0SNBf06K
	 KotaIajxoQUR4f2jLWKHd4FUXjMxm6EN3ybJ8XeBD8d3jAHSxivsRqVTrsu9HfBW3I
	 oG7V64Gio28wTkm1uJGgCmzgu/9H7HnmvAQSqz0cxGCmWBO43aMj5dkRbwmefcimE3
	 xBC3AcHZfpSd3L7DJOZAmHo4i0R09DZ7cHXV6QEG/hb1RxpT86IMa4PFjb44fOokG5
	 ZakGQdT7lbyVw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 49/57] irqdomain: Drop irq_linear_revmap()
Date: Wed, 19 Mar 2025 10:29:42 +0100
Message-ID: <20250319092951.37667-50-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319092951.37667-1-jirislaby@kernel.org>
References: <20250319092951.37667-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

irq_linear_revmap() is deprecated and unused now. So remove it.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Alex Shi <alexs@kernel.org>
Cc: Yanteng Si <si.yanteng@linux.dev>
Cc: Dongliang Mu <dzm91@hust.edu.cn>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/core-api/irq/irq-domain.rst                   | 2 --
 .../translations/zh_CN/core-api/irq/irq-domain.rst          | 2 --
 include/linux/irqdomain.h                                   | 6 ------
 3 files changed, 10 deletions(-)

diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-api/irq/irq-domain.rst
index e26ed303819d..775dd43b3340 100644
--- a/Documentation/core-api/irq/irq-domain.rst
+++ b/Documentation/core-api/irq/irq-domain.rst
@@ -63,8 +63,6 @@ variety of methods:
   mapping.
 - irq_find_mapping() returns a Linux IRQ number for a given domain and
   hwirq number, and 0 if there was no mapping
-- irq_linear_revmap() is now identical to irq_find_mapping(), and is
-  deprecated
 - generic_handle_domain_irq() handles an interrupt described by a
   domain and a hwirq number
 
diff --git a/Documentation/translations/zh_CN/core-api/irq/irq-domain.rst b/Documentation/translations/zh_CN/core-api/irq/irq-domain.rst
index 913c3eda3f74..4a2d3b27aa4d 100644
--- a/Documentation/translations/zh_CN/core-api/irq/irq-domain.rst
+++ b/Documentation/translations/zh_CN/core-api/irq/irq-domain.rst
@@ -60,8 +60,6 @@ irq_domain和一个hwirq号作为参数。 如果hwirq的映射还不存在，
 
 - irq_find_mapping()返回给定域和hwirq的Linux IRQ号，如果没有映射则返回0。
 
-- irq_linear_revmap()现与irq_find_mapping()相同，已被废弃。
-
 - generic_handle_domain_irq()处理一个由域和hwirq号描述的中断。
 
 请注意，irq域的查找必须发生在与RCU读临界区兼容的上下文中。
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index bd02550df6e6..d5c9e32ff0a2 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -492,12 +492,6 @@ static inline unsigned int irq_find_mapping(struct irq_domain *domain,
 	return 0;
 }
 
-static inline unsigned int irq_linear_revmap(struct irq_domain *domain,
-					     irq_hw_number_t hwirq)
-{
-	return irq_find_mapping(domain, hwirq);
-}
-
 extern const struct irq_domain_ops irq_domain_simple_ops;
 
 /* stock xlate functions */
-- 
2.49.0


