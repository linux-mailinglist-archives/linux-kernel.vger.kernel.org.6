Return-Path: <linux-kernel+bounces-276934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D708A949A2F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80FBC1F260A8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC0F1741EF;
	Tue,  6 Aug 2024 21:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCTbrazH"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D153171079
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 21:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722979739; cv=none; b=nAnjQJK3j4GgVSiJSxODYitBWJeX0gXv4822LbnBba7G82XF3ysk85xNlPwwGI6rajNQRII5GjAmYRfdrstYd28liAoCB7ueiDoLkOBw7gasmN0oz+B7+7Uw2YR8bQGFItJHa1H/fRPwXnYw42PpZWX/Kfo4w076Ph5Oe+4n+O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722979739; c=relaxed/simple;
	bh=NbOvkFUQVBBahWt/DJiJRCzZdNMiMtEwOXOBbIuIPh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1YK1ScfZULdmH/v4cn07EIAiuu7hioKRwLopwqB/P/zd6AGvJyfvXL8k7g/b5rSPOQ9tPXRfUsKJ4GpGJTTmYT5ry6PS1Fe1CW9SjJ9ysr69UzvtLRe9Q/zpEYmAoavo3ei2rZDbtvsw12MJKLO1iuRjy/ZQP0rjDWH1viv9x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCTbrazH; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-368526b1333so156719f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 14:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722979737; x=1723584537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udsLDmPzjgpkWsx7RYjGnyjlum6MBZ044D+jLhSjl94=;
        b=nCTbrazHItJuHBhJL9tSCbcg2bZceaFhJaEKROnv0i+IwWVv8ZuK9Oy2zbV+ls5WEX
         QYkYgBAcfowHiAarqPuJcEeYSIE5vnjGaSINQYDU13aJxBWhuIyNqJL7YuCt+clalL8J
         N78lzeSuhwpQyQQRDfk+Xd9fJZUnOinzOowzfTgxfcEk05dQd0fCpmQxhcdw807TJsFT
         LbS6P1YbAt2KUOSVi8LgNwgyEIthssZ26fCA9ccWEJdW/yh7wxw9V0PfmBZubCFLQgVo
         NRRCrTTZSKdwRd2M3B/GwidshjQhKp6BkAgsyCkOsmG8M1TGvkJUMwH3eqVq9q4Nqj5p
         q/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722979737; x=1723584537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udsLDmPzjgpkWsx7RYjGnyjlum6MBZ044D+jLhSjl94=;
        b=TEYYpq7T6sOmtzCu3UMjd2KqquaCSsyKS5SnFx7Ycba/y73oMBy0bx+Qcp5b8cpVaN
         XLxeeMyH0Eyw4N+vN0cvl4deRbByxXbr11/5S9iCRsTTIyFv3N1vV609dxKYQXSd0ayz
         My2lyKBuJQeWiUeb+KW2tO1qbrvEfOIoFVr9oF6s1HLaU3TDA3k26lpMXL5RTpTWFP6G
         xp7GQUz1qwbWGMbEQsu7aCGIm+h4valarU8tGqOiQqFVbxzIcAKl3+JS4L0qHiqyu1Hm
         o/iDro/HnClzbRwq3jNNEf2p7GvjoWsPJnDDBMxcg7XK5ypjNEDJ4T4s/vo2ygikaMaK
         ZqqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgjAAiRCllI7a6uT6wkueO3OvkMxJVU9AU9JkKwKtgZfPHIE7yroYHCeNrsu+KiGWjtfUrZX/XeKZ1ZNRw+PaIaPNyvPVi3e2m+Q4O
X-Gm-Message-State: AOJu0Yy6mvSfnktcs5xxu1/Q1o5iiDcb/LxzF6bsfvuuGpvn6m8uo0RD
	COd21aJBW/Kpy4sYv4jCkgrFeVcdbS6qdfNhAd+EHoIFBf/BAnWM
X-Google-Smtp-Source: AGHT+IH55gHkDsQZoE6Cj0KH26OcQ4V5BoqgtaVjG59s6McB8ZiD52DbwBs2HllTYh2L9dYrKwKDHQ==
X-Received: by 2002:a05:6000:1785:b0:366:eadc:573f with SMTP id ffacd0b85a97d-36bf0f6dfeamr78734f8f.27.1722979736421;
        Tue, 06 Aug 2024 14:28:56 -0700 (PDT)
Received: from PC-PEDRO-ARCH.lan ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290501f0d5sm1858545e9.31.2024.08.06.14.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 14:28:56 -0700 (PDT)
From: Pedro Falcato <pedro.falcato@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	oliver.sang@intel.com,
	torvalds@linux-foundation.org,
	jeffxu@google.com,
	Michael Ellerman <mpe@ellerman.id.au>,
	Pedro Falcato <pedro.falcato@gmail.com>
Subject: [PATCH 5/7] mseal: Fix is_madv_discard()
Date: Tue,  6 Aug 2024 22:28:06 +0100
Message-ID: <20240806212808.1885309-6-pedro.falcato@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240806212808.1885309-1-pedro.falcato@gmail.com>
References: <20240806212808.1885309-1-pedro.falcato@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

is_madv_discard did its check wrong. MADV_ flags are not bitwise,
they're normal sequential numbers. So, for instance:
	behavior & (/* ... */ | MADV_REMOVE)

tagged both MADV_REMOVE and MADV_RANDOM (bit 0 set) as
discard operations. This is obviously incorrect, so use
a switch statement instead.

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 mm/mseal.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/mm/mseal.c b/mm/mseal.c
index 4591ae8d29c..2170e2139ca 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -23,9 +23,17 @@ static inline void set_vma_sealed(struct vm_area_struct *vma)
 
 static bool is_madv_discard(int behavior)
 {
-	return	behavior &
-		(MADV_FREE | MADV_DONTNEED | MADV_DONTNEED_LOCKED |
-		 MADV_REMOVE | MADV_DONTFORK | MADV_WIPEONFORK);
+	switch (behavior) {
+	case MADV_FREE:
+	case MADV_DONTNEED:
+	case MADV_DONTNEED_LOCKED:
+	case MADV_REMOVE:
+	case MADV_DONTFORK:
+	case MADV_WIPEONFORK:
+		return true;
+	}
+
+	return false;
 }
 
 static bool is_ro_anon(struct vm_area_struct *vma)
-- 
2.46.0


