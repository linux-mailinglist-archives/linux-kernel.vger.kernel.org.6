Return-Path: <linux-kernel+bounces-567626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A60FA68875
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD039883180
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE7A25DD13;
	Wed, 19 Mar 2025 09:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JW9gl02k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099CA25DD0E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376794; cv=none; b=P1PTDvy1LhqYbKAi+gzAMLgM7tX6YJsWFUe7nQLOP1FWreZ4NdAb8uaN9dbdGosn05/QazpKEM3XHTGfo+ayEXzS6qxPIxtpw3bUzLFDRHge6GlU56ygOZ15ULTKogoOcR4dzAPmin2rcFL9ptJFbA9JCCAYwcRNDtIVIhjANZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376794; c=relaxed/simple;
	bh=htDMV7TYLCAj/vnYViCX+n5jugajp6cyWOawasKX8k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/TX8NUWoiZi7VA6rvRMTkyvQAvC+iXkF0EYk8k/ilFDJym8uIWZpIkeMP1ZdScvFv4lINuWu/b+mccWCAblZl7SZHyWI/Wgxh4yoSFjvDD1qwqvmQO8HqDzkwscTQqZcv/pbCXUfUQ9p77cB6cHtLY3sdLEo5TzPLXdRJac/8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JW9gl02k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D544CC4CEE9;
	Wed, 19 Mar 2025 09:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376793;
	bh=htDMV7TYLCAj/vnYViCX+n5jugajp6cyWOawasKX8k4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JW9gl02kOpKlSWcY+Yal6et59UGDSFQ4HY5+rNSCFiejY+WDFtkmJ0lLJb65BCRHj
	 4x5DkJU6fX1kTDxC4NMjQWX1CbQGCT1nvQZPfMei5zCjHYkfYXxYlA6SE2KcEyWiZZ
	 rTyJeIfkFh7BWeH+/J+xhXAjXecKg1dH7Lxy2cwFeUziT97wmW5X8p8URDYdzxUsyi
	 g7TA1w4W5jQZulUF+E40FMgu91DqtHq1x60/XF4sTTkR2azTO10aKS7rq4nE2GKFHE
	 I6y76x0VaMxVuTwBoq0ih3UOpgp8QSo9lcCdq/waDOT6lx5CAaZhFn0/VXr+TIULfH
	 yfCD+IVNwf0OQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 50/57] irqdomain: Use irq_domain_instantiate() retvals as initializers
Date: Wed, 19 Mar 2025 10:29:43 +0100
Message-ID: <20250319092951.37667-51-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319092951.37667-1-jirislaby@kernel.org>
References: <20250319092951.37667-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I was thinking whether add a \n before the 'return' or this. And this
looks both more compact and more readable.

Note irq_domain_create_hierarchy()'s handling of size is now part of
info's initializer (using the ternary operator). That makes more sense
while reading it.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 include/linux/irqdomain.h | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index d5c9e32ff0a2..bf52a08f3255 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -403,9 +403,8 @@ static inline struct irq_domain *irq_domain_create_nomap(struct fwnode_handle *f
 		.ops		= ops,
 		.host_data	= host_data,
 	};
-	struct irq_domain *d;
+	struct irq_domain *d = irq_domain_instantiate(&info);
 
-	d = irq_domain_instantiate(&info);
 	return IS_ERR(d) ? NULL : d;
 }
 
@@ -424,9 +423,8 @@ static inline struct irq_domain *irq_domain_create_linear(struct fwnode_handle *
 		.ops		= ops,
 		.host_data	= host_data,
 	};
-	struct irq_domain *d;
+	struct irq_domain *d = irq_domain_instantiate(&info);
 
-	d = irq_domain_instantiate(&info);
 	return IS_ERR(d) ? NULL : d;
 }
 
@@ -440,9 +438,8 @@ static inline struct irq_domain *irq_domain_create_tree(struct fwnode_handle *fw
 		.ops		= ops,
 		.host_data	= host_data,
 	};
-	struct irq_domain *d;
+	struct irq_domain *d = irq_domain_instantiate(&info);
 
-	d = irq_domain_instantiate(&info);
 	return IS_ERR(d) ? NULL : d;
 }
 
@@ -554,18 +551,14 @@ static inline struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *
 	struct irq_domain_info info = {
 		.fwnode		= fwnode,
 		.size		= size,
-		.hwirq_max	= size,
+		.hwirq_max	= size ? : ~0U,
 		.ops		= ops,
 		.host_data	= host_data,
 		.domain_flags	= flags,
 		.parent		= parent,
 	};
-	struct irq_domain *d;
-
-	if (!info.size)
-		info.hwirq_max = ~0U;
+	struct irq_domain *d = irq_domain_instantiate(&info);
 
-	d = irq_domain_instantiate(&info);
 	return IS_ERR(d) ? NULL : d;
 }
 
-- 
2.49.0


