Return-Path: <linux-kernel+bounces-516801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE03DA3778C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 21:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 841071890FEC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 20:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2891A314D;
	Sun, 16 Feb 2025 20:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nI7mxsWz"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0B419D09C
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 20:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739739128; cv=none; b=S2mFipU8eMeYEc3XeTipG0awGhpD3OPyxKcBv+VdLVM6aeoIffr5sZSS8negFpHyeppc2CrzNze8fdc540sNnMEFpPz7EPx3ZFpUH3enL0JoagT4nlS7Wl9TN+5owXLhF7sj3ZuJ3jRBARZF/y+oB+7kKt567UfLRRfvuACwURg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739739128; c=relaxed/simple;
	bh=NtGbrjrmznu2NSRW7WDGTNFMx2/QQx6TquE+W2bapjE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SgbqHEevp+PnDSPxnDnhP67neRmM/Mm6RxFU7ys4xlT/iEjIsXF8VawsBU5kHXz8aJ+N6WytlMXqz8SpmAXNzgRxrMsaNSm5/MmBlet/t9Ks7FNtFtlgUZLIx35RHFV/QSJDdfVhdo6ri2lZcwXJSoAe1Nq4i60ndcNZFqwkeB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nI7mxsWz; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abb8d63b447so71368466b.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 12:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739739125; x=1740343925; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uwcNQNpK2HNYBvKAgWSMSPgBYr8v+ovYWYrUWEbnsrM=;
        b=nI7mxsWzPGhiccb5Cd/0VY8Datq0NhxNpLZ3//qyI+JIreWmibNQZQaBNbEkOB8sM7
         Jx6PBRZXAoRKL/rNHBZmnQBZMlXeruF66ANQu02F7LNSVzCzV4lz8MbTISordRSUYMgq
         6QhNiccQ5lwm9l1X2vZr2rnlw4w8gCa9GGkl02ok85PzubceBNQzwl1xoJHrZFkHJQJw
         +d5Bfx9T1/yctv0ohQnjXWbedCGJF/SJTexbdwoR0me5RsZk5SlgKmWw8GAFLns0l5uM
         iMijDDys465KmiUOhU4DaAth6wLnnGH20emi9sK/Xz+VhYDWbyUmclEJRNxPgRzXCAnI
         Uzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739739125; x=1740343925;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uwcNQNpK2HNYBvKAgWSMSPgBYr8v+ovYWYrUWEbnsrM=;
        b=bYFDPBnbPoQSbTRWJM/J52UKdQiF4PoEl5nznr61uCgZcfFMiKQJWEVipRdBJ4Zpj8
         atKtnqDvb9HdZY3VS6tN2nPDJUS/LVGKKsr1r1/EPtlLia4Dks89sICSzLezj+R7vz20
         29NuPS1kR/4QBmj3Xgi8HeRbmfo2kpxIdL8amV41NJlmpZzWjSqBM4msfGOXXQdkioqH
         1gq5fRlkLjDsB/vkthsFxR1Yy5sySYn0/cqD1igbEWDtfGTa1CAcj/B2bqEehXP001Gl
         UnPU6yqSANDgBLsJVXQl1mG/2aBO9QjRw8w6Wf2vOWfw8PsiN+PZ0DLb5WsNgWUauCK5
         a4wg==
X-Forwarded-Encrypted: i=1; AJvYcCWyACps9+wfYqup9wZAwDNbnwj2/PJjqVzJADzZ89uhDon5nQqRGf6p3No44hUU0YhbIeEjo61NwT9UtJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKLiyybBsxVJEX6iUSOkxQrlRsNyUYEkTGliNYBeiuI+ECLqnm
	+QrJPSWbFIpizy6RemUQXXfDQmbmEpUYzezJdRXRYw2cURtZvlWMWgaKJgTi8g4=
X-Gm-Gg: ASbGncsuSDDvnDgpuFZR1bU2YgXs0B8Fkp0+PG9byJLHP7XLMGWXeTbZSniDKoD4e46
	i8psH6dpI+Thwf5dnAzZlOb2lxskroroC9j+lNA4gzjHHGy/jf+W9Ws9qwwn/j3vi1U5/qzbsvv
	FkY4CVSgqlj0iqje50JzCkAQJu5xkQAwq53F1TB8PKtEsyIGmYwTKTzOYqycMoklfm44hsSKUvh
	OGYaiR5bxnq9Zb8EwwTcWi6u83wBvR86vQPf/t56mZsABV1s8JWyB+KpD2ZskhTot76+tZPDCGx
	WX1zAUYaBgTmo2WZp3WU
X-Google-Smtp-Source: AGHT+IHgwYPj3iqat9vbldQSlkyDo1u1ykz7UQvzC8QUVDQndEh7Kshy5EEfZbLcYAkxQywWbeqVOA==
X-Received: by 2002:a17:907:1b0b:b0:ab7:ee47:9938 with SMTP id a640c23a62f3a-abb70dd9024mr765292366b.39.1739739124793;
        Sun, 16 Feb 2025 12:52:04 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abb9b81aacdsm75610966b.104.2025.02.16.12.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 12:52:04 -0800 (PST)
Date: Sun, 16 Feb 2025 23:52:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] fs/ntfs3: Fix a couple integer overflows on 32bit systems
Message-ID: <3e34cf5a-e70c-4096-b516-661c2a836001@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

On 32bit systems the "off + sizeof(struct NTFS_DE)" addition can
have an integer wrapping issue.  Fix it by using size_add().

Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/ntfs3/index.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 7eb9fae22f8d..78d20e4baa2c 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -618,7 +618,7 @@ static bool index_hdr_check(const struct INDEX_HDR *hdr, u32 bytes)
 	u32 off = le32_to_cpu(hdr->de_off);
 
 	if (!IS_ALIGNED(off, 8) || tot > bytes || end > tot ||
-	    off + sizeof(struct NTFS_DE) > end) {
+	    size_add(off, sizeof(struct NTFS_DE)) > end) {
 		/* incorrect index buffer. */
 		return false;
 	}
@@ -736,7 +736,7 @@ static struct NTFS_DE *hdr_find_e(const struct ntfs_index *indx,
 	if (end > total)
 		return NULL;
 
-	if (off + sizeof(struct NTFS_DE) > end)
+	if (size_add(off, sizeof(struct NTFS_DE)) > end)
 		return NULL;
 
 	e = Add2Ptr(hdr, off);
-- 
2.47.2


