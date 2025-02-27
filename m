Return-Path: <linux-kernel+bounces-536829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AE9A484AF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C89F33A342F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E702F1A8403;
	Thu, 27 Feb 2025 16:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hcB6pXpr"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC65C8F40
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672961; cv=none; b=pohTyjVvG2cLSkZ4o0F+xsRh1M9tMW6Yu8aVBRX0vBPlfy+DGbOIP4HEyoAVITrHm6eZYLrMwd/R3py6WVaV+UbmIulGiWzCmBC+FPcRrQRYfcbFEnRA57TDQjJVkDHsxLa6LZdf7Hd2SRcoXWfZZB9H4w5fi5WevW8QCUdiAdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672961; c=relaxed/simple;
	bh=vb6oauAPFR1jvtUfCJU0bs6uRvo4fUFE+QGPZFA+qOQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gW8ZzggwEjsUnqKfgwOntQyU1t86PEIGqzXFg7Q5uZpVccCrzfezAye4TIgMty2YBc0F4PwEUbJh61zsltQJ+q7OtWWGhtNEAn8bj42ssRttSmh6nKJQZsUh3564+VzqmukpssFWVEQwVf3V3PneXG7ZfZtQPGdwATXuT9+v4A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hcB6pXpr; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43943bd1409so8742185e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740672958; x=1741277758; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MaiQolnIhzIdYGrP+r2nY0DLMqxJH+cxRavbC/YLHu4=;
        b=hcB6pXprXYI8mvH6lEm44DoZ3EtsbsRy5TPHxtPU0xyD3frXP0uiSW058e4Zkwm9N6
         2evR4aj7duHnIuAKDczwWjimogPSTcs9+kxuJxR5T4w1ZfIuNbPUfXwmpVPKaDD48RH0
         ux5piSOTf1aoemr9KsXELd+dOMaBguTl9B2YjGgHDcduc8umGZW60MkZ7QUP48tdK5Gf
         mT0u7256jHUrt4DHC7JeFji0yGtH6JKAcrB6S7CUEySi4JvNPQoeuvTnqsFE66cizrJL
         grZK9iTe2gbs5OkIQqWL4gyEfDY5f/SHy4k7opSMPz02DZvq6r1U8ATsWvZU1cYqtpQf
         v9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740672958; x=1741277758;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MaiQolnIhzIdYGrP+r2nY0DLMqxJH+cxRavbC/YLHu4=;
        b=VJOpS9A+d7Au4gmotqNOZ9rWidYrUwuHNXRk5M8wqw9Fa11h6/wils+KrBA/AxbXIc
         jS+lStDqDMCZ4jf8ftCvUMYNklkvso0amdsSlgk1o+W3vNER4h0IaqCWVMAf1McnsRYK
         tYtfIU0C9D8CykfMqAC6ewMauYljjP3vWx5nlWvKxJLXgmc9+zTtUqUoERNJb7OlpXEK
         AqTT2/Th/JilyaMXuqbaF6ccxA1gR6+IrtB4yYwcWxxnBKCyHXWRC1N9fErD5JLzMqsQ
         g60hEpqwtlVe0KaTKrWKzgt9EZPYAiDunp1nnypSEHwrh7Xlk4z/PpM+u2N0Xa/jNOOH
         lSwA==
X-Forwarded-Encrypted: i=1; AJvYcCV1KtoZOnVL9WPT2SHFVFtTur2h+NUDx9XodiAtwTk65Yc0pDboRYg35bVIVGWezbO0QSNE/tWjejFhu+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywx3MHgS2Z+OU9J33S16IjZRGRQFWvCCJTsxIAfwAZgYSkewkx
	dkT3faEMbhs0UCnvUFk/fu6iIxTJOPdbvDNNcFXO6llNUNr5BZ7tMv/DWaJYoUU6qsiRd8HZXmR
	NK7dptMiRdQ==
X-Google-Smtp-Source: AGHT+IFfqfTnU98nxmYvYAv8ZtoyJ/ggUHxiokwzYXTkxVRD8aU17EmvAGe7M91QxKO1FwnnMg2UK0rzwFjxMA==
X-Received: from wmbg21.prod.google.com ([2002:a05:600c:a415:b0:439:95b9:9200])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d0e:b0:439:8e3d:fb58 with SMTP id 5b1f17b1804b1-43ab8fd8f1amr77195005e9.11.1740672958027;
 Thu, 27 Feb 2025 08:15:58 -0800 (PST)
Date: Thu, 27 Feb 2025 16:15:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALKPwGcC/x2MQQqAIBAAvxJ7TrCl0vpKdDDdbClKFCKI/p51G
 ZjDzA2JIlOCvrgh0smJjz1LVRZgF7N7EuyyA0psJKISwXiatsOu4oOjILoWta21UyQ15C5Emvn 6n8P4PC/SS7IaYwAAAA==
X-Change-Id: 20250227-pageblock-lockdep-9628c48d7e08
X-Mailer: b4 0.15-dev
Message-ID: <20250227-pageblock-lockdep-v1-1-3701efb331bb@google.com>
Subject: [PATCH] mm/page_alloc: Add lockdep assertion for pageblock type change
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Oscar Salvador <osalvador@suse.de>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

Since the migratetype hygiene patches [0], the locking here is
a bit more formalised, so write it down with an assert.

[0] https://lore.kernel.org/lkml/20240320180429.678181-3-hannes@cmpxchg.org/T/

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 include/linux/memory_hotplug.h | 1 +
 mm/memory_hotplug.c            | 5 +++++
 mm/page_alloc.c                | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index eaac5ae8c05c8ee2f2868d5bc1b04d1f68235b3f..ff9511d9b9e6f775feeb4f897754878ac4c8cdb0 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -175,6 +175,7 @@ void put_online_mems(void);
 
 void mem_hotplug_begin(void);
 void mem_hotplug_done(void);
+bool in_mem_hotplug(void);
 
 /* See kswapd_is_running() */
 static inline void pgdat_kswapd_lock(pg_data_t *pgdat)
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 16cf9e17077e359b98a69dc4bca48f4575b9a28c..2b9d1a6267c0872c433fafe8684dd4e2aa821f5f 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -267,6 +267,11 @@ void mem_hotplug_done(void)
 	cpus_read_unlock();
 }
 
+bool in_mem_hotplug(void)
+{
+	return percpu_is_write_locked(&mem_hotplug_lock);
+}
+
 u64 max_mem_size = U64_MAX;
 
 /* add this memory to iomem resource */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 299c9f10bbcd2aa1d35ac6eb5131a2471da825d5..e0516d70835e20e54ff8e43f3aa884c7e36d929a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -417,6 +417,10 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
 
 void set_pageblock_migratetype(struct page *page, int migratetype)
 {
+	lockdep_assert_once(system_state == SYSTEM_BOOTING ||
+		in_mem_hotplug() ||
+		lockdep_is_held(&page_zone(page)->lock));
+
 	if (unlikely(page_group_by_mobility_disabled &&
 		     migratetype < MIGRATE_PCPTYPES))
 		migratetype = MIGRATE_UNMOVABLE;

---
base-commit: d58172d128acbafa2295aa17cc96e28260da9a86
change-id: 20250227-pageblock-lockdep-9628c48d7e08

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


