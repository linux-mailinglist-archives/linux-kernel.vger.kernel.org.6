Return-Path: <linux-kernel+bounces-568372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F19ABA6947C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF955886BBD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2F21DED4C;
	Wed, 19 Mar 2025 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TtlZYiMR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA6F1DDC2D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400749; cv=none; b=RZmT2Rb57m6Kr6oISlpk2BKu8l44cCqHCbsF4I/4ZiVJhm0K3Oqk2y6H/xYQw+jA25Jk0eS0OfGKNISZf9o8UaaC7yk/rx5AqeM52Fsip0BIF0tg8hNl4oo0xOM7H8uKXUHczj8VDfPxsrQZeQbWVeNxNEQ0gAxavDf6gO9IdgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400749; c=relaxed/simple;
	bh=PG/ykUDLaI2Te/PUXNUib8gEqq0gbSuIhVaZybRkKz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NbEnogTnarOORlUWUbKxOhcpltXaAvWZyD8C5hz0D7LR5+tYqSw3o2vhr0mQSXm8L6z3M1Iewoz95TX2AozLDxTWLTqiLFUr0YvhT4bCrRJFjEwTvClXg+ji810UvKKa1hMOfkOAGc6YYpQJVEt2tlwpSBYJcNmPfzZz8h+/sTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TtlZYiMR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742400746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eNimczHLcCjGmucQCqyMg5TJoh714nZsj3E+z5Eo9vI=;
	b=TtlZYiMRo7PYVxXafne6R0sY+8hy1NvUWZnHgpW42HUfP6MeoeKBLE6yf66LGDeMiSftIs
	RfHNZ06Q7foyCoP+N1XEiimHrGmVNfElY/K7Jomk68+I4BH/fpHYifh14jI2juxoRt1C+X
	fHneQleXTMcOqPbjw83GBUxhVVFHPwU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-QBsGW0kQMpy5o-EdfZnVgA-1; Wed,
 19 Mar 2025 12:12:23 -0400
X-MC-Unique: QBsGW0kQMpy5o-EdfZnVgA-1
X-Mimecast-MFC-AGG-ID: QBsGW0kQMpy5o-EdfZnVgA_1742400742
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 440A31955DCF;
	Wed, 19 Mar 2025 16:12:22 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.81.98])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 19DB21828A80;
	Wed, 19 Mar 2025 16:12:20 +0000 (UTC)
From: Joel Savitz <jsavitz@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Joel Savitz <jsavitz@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	trivial@kernel.org
Subject: [PATCH] cpumask: align text in comment
Date: Wed, 19 Mar 2025 12:12:18 -0400
Message-ID: <20250319161218.24430-1-jsavitz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Since commit 4e1a7df45480 ("cpumask: Add enabled cpumask
for present CPUs that can be brought online") introduced
cpu_enabled_mask, the comment line describing the mask
has been slightly out of alignment with the adjacent
lines.

Fix this by removing a single space character.

Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 include/linux/cpumask.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 36a890d0dd57..c281990c000f 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -81,7 +81,7 @@ static __always_inline void set_nr_cpu_ids(unsigned int nr)
  *
  *     cpu_possible_mask- has bit 'cpu' set iff cpu is populatable
  *     cpu_present_mask - has bit 'cpu' set iff cpu is populated
- *     cpu_enabled_mask  - has bit 'cpu' set iff cpu can be brought online
+ *     cpu_enabled_mask - has bit 'cpu' set iff cpu can be brought online
  *     cpu_online_mask  - has bit 'cpu' set iff cpu available to scheduler
  *     cpu_active_mask  - has bit 'cpu' set iff cpu available to migration
  *
-- 
2.45.2


