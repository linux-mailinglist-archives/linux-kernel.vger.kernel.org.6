Return-Path: <linux-kernel+bounces-435944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D379E7F01
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 09:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8B218833A9
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 08:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A4B126C02;
	Sat,  7 Dec 2024 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J69FVtc0"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073942E406
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 08:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733560185; cv=none; b=qPFQbJMoFItwDBdYDl0nEujtKGhd/nHRPYnJv4b9t9NL27SKhYo8Gep53z6gdBU3DibgQjyxM0Uv2zgbD0L+VyM/bCwX6fzX3u4gJe+67xJgb5QstUyod5Vt7xmB+5dR/ppx4khjVakJtp+6p7Hpk7nax3svKC1Fk4NmVSRWMT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733560185; c=relaxed/simple;
	bh=SE4q5CPZBs5Ld/6dal0Xy4JuKX+V8rPYo3V2xQehpr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RcKf5OwCOE46gmLOTZXGEqv1jxvwXj+EjJ7TFv3r5/bMOjMNpMh09HB0aUszykTchnhsj7vJL4eB83Xd+XWgFv/s+zRwI0SGd0XkRwnOyHUqLaeE5h/wsOECtysgylDnCZUZp+9lnQmvYxl4hJ1pL9vSfBTVBw89I1ptwpLq1vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J69FVtc0; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa6332dde13so176361366b.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 00:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733560182; x=1734164982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UHRpLCsjp7NA8B9f3U/OeguW63g2isrOeZ3w47qo3nE=;
        b=J69FVtc0Uc8tlTDr+5ZzZeJEuuXlaNvy2Te1v4gTPx8J3YCfZ/1XBdsW4ZHZXFpzjM
         0JQ3MFpF2x1YzKCPm3aXvq/pK3vUEl4H39Dq6RoOI8jADQ08a38bgPNe+bM5fskB9oSL
         j2UjT/XnzN0cQIkU+DgLyUnOLXfGoTTA3zSZjKF0AmuFTHXWer9tvL0qm9yoMPBn/Cg1
         HdzFk8A1k6Xq7aprmCkP9B6OTXSt6doekkMQlvFo6+cRfPyomqENunoDVaqW8jqtwMXs
         ov6YzHOkX3mrxp87ifuOd4aiyh1an2k/C+qBAerwhaaRDvvzZUqwbdBDIFI/dTjBivBG
         E8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733560182; x=1734164982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UHRpLCsjp7NA8B9f3U/OeguW63g2isrOeZ3w47qo3nE=;
        b=bC8DdbirXulEciw1XxLusOH68KN+7fgVDeyBhzhOMJu7ojXzvFRw462XXExqGgoa9E
         evm6IhYMevH2iRSKdE8C/clB0sVNnneNuIbhRtFlvoFNQX77feUvQZGdZMm7QnKn0tqP
         1T32oD3MS0SsqjskIU+aQGICpEI+BHK7B4cDRbT/y7wbjBzBRluX5bJDSlDZMbCL+lcv
         hJLHNNrTqxwoeUx0V+n96Wek83pT1xehjdhcBtOkbUPurX6lbpFYrxnx5UUUOESf3jsb
         Gjg/R7dI4+U/nD63DL/UzgaqzbZdXXYLFySGZ80no+0DJKGuonirIkh4cUuBMEau/BMa
         Ileg==
X-Forwarded-Encrypted: i=1; AJvYcCUjO2ofBtSMMTG5PJqkBpAiryXrxnXnfN108FJnsWCUGyZLkuBYW9w+yHUR+2lSVc8v2gD0J9OmP4cmM8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH3pWh6VLQFfBAdQLPkRQtO4QWtchnHY5IfQQgOjp0+/uF55ce
	IB2IaqvYcIng+kY4SUYLVu0LSpdPVA0G8yRDq5LvfbWq2/1iAsA0F5JBBg==
X-Gm-Gg: ASbGncuuGvw3PMScGPK6/wj3pYDvsfNTXxTc5Jnv1wSDs5QKLOICR0JfWOIklpU38gS
	x/UTdXQisUpvkUs8rexXwqruHFy5iqyw0lEb5ZbirN0nf7T7MXRiPLXwaSR1CEre6IXqz/ALrp+
	ehtQ2sBJOVaL1D6SXduYw/LGyiL0DTFCvZiWJuIpQBT82xad+/n6qD/8x9W2PpjB3xlqVv/CiXD
	0Q6Qef2Lb3mGbDlJM023ozn3L976wtoH8OTNJFTrRZHlxHCgEPtFa436NKozUC3wQ==
X-Google-Smtp-Source: AGHT+IHHbCeDcdHrgL4CiKBpE8mvUaNfoWyY4qgAovF0EVGhfx93UBqzothSVAYiF0RUjOjLwebxYA==
X-Received: by 2002:a17:906:4c2:b0:aa6:538e:a314 with SMTP id a640c23a62f3a-aa6538ea56cmr68764766b.37.1733560181988;
        Sat, 07 Dec 2024 00:29:41 -0800 (PST)
Received: from f.. (cst-prg-17-59.cust.vodafone.cz. [46.135.17.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6590f5457sm37579766b.195.2024.12.07.00.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 00:29:40 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: yuzhao@google.com
Cc: akpm@linux-foundation.org,
	willy@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] mm: remove an avoidable load of page refcount in page_ref_add_unless
Date: Sat,  7 Dec 2024 09:29:31 +0100
Message-ID: <20241207082931.1707465-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Explicitly pre-checking the count adds nothing as atomic_add_unless
starts with doing the same thing. iow no functional changes.

disasm of stock filemap_get_read_batch from perf top while running
readseek2_processes -t 24:

  0.04 │ cb:   mov    0x34(%rbx),%eax           # first load
 73.11 │       test   %eax,%eax
       │     ↓ je     1bd
  0.09 │       mov    0x34(%rbx),%eax           # second load
  1.01 │ d9:   test   %eax,%eax
       │     ↓ je     1bd
  0.06 │       lea    0x1(%rax),%edx
  0.00 │       lea    0x34(%rbx),%r14
  0.00 │       lock   cmpxchg %edx,0x34(%rbx)
 14.06 │     ↑ jne    d9

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

I did not bother benchmarking, I don't think there is anything
warranting it for this one. fwiw it plausibly is worth few % in a
microbenchmark at higher core count.

 include/linux/page_ref.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index 8c236c651d1d..fa203894876f 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -234,7 +234,7 @@ static inline bool page_ref_add_unless(struct page *page, int nr, int u)
 
 	rcu_read_lock();
 	/* avoid writing to the vmemmap area being remapped */
-	if (!page_is_fake_head(page) && page_ref_count(page) != u)
+	if (!page_is_fake_head(page))
 		ret = atomic_add_unless(&page->_refcount, nr, u);
 	rcu_read_unlock();
 
-- 
2.43.0


