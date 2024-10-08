Return-Path: <linux-kernel+bounces-354473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4618993DDD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 06:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835E2286730
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 04:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBE242ABE;
	Tue,  8 Oct 2024 04:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="alyBN47R"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5497B41C72
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 04:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728361090; cv=none; b=YZKcKxXgPlOSC+JyNP0mQv01xOpRE3PDTQaDvjAey8ZCJ0ZyH28l2VQ7qjgVBCMbnoeG59GSFcKoCo8GVQdin1oviEVuYjplLbvo3M/QpaLCJbtGyCG7yUjyWH/6puYvBmJrWOmqTqhxTxe0f+VlsJGOUqM3ZESXVZdxbnFlEuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728361090; c=relaxed/simple;
	bh=VSZhSzhnbdu2NNszsJIrOuSYNRWmYaP3/73tTqZqx84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xt4GSRKSPfSvJk5M8z6AWm7I0RQn5RwfNS40Uc8cujMt/Hh3MLE5uSKzK7wBl3icPSrLD6g7XsFIGd5AhhBXE3eilnFlj4QNYtDZL+vNMTXCGrKZ4cHU2ZcBN284sRSy0SIKswRXy+Sgd4hks0MPExaWbC7bjGH7HmFlc8mNAAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=alyBN47R; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e0b467da03so638680a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 21:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728361088; x=1728965888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vVQPrureiyHbwYAfJliFzmOeqMNDULWaSzE3MpLwxE=;
        b=alyBN47RBaxB6GiJTR5sc5kqoidS0N9tcrk4Ypz1OsaKm9Q7FrBefq15hwVkzVNEiE
         LCdv8E4LhZbmIxKsnnWpGEzN2noH/SZtKzArHx/givDt6VEfcbK9fFRa18IFOXwndHVY
         /uP0XoEySMfjDnfkFmwT096TNhbJazNQCDMSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728361088; x=1728965888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vVQPrureiyHbwYAfJliFzmOeqMNDULWaSzE3MpLwxE=;
        b=QaOn4ku5LkSNbvUsQwv7B5sU/Zq5EOYRNkx6I3nZ+bCax4ZL+ABxssZRY3JmNTSLtR
         qdy2oAVPzOdaBEcPti9tEGNKOeCf25scA+IzxREsBXl4vkPLTcV36aL90hXSMvhyj/Lc
         yZM0fMmKZ0Pb5Ee1pP3BRKswYCLIVuDrfxJpVjnkCs7shd26c59OlW/MgAh10BWrsxAd
         lFeSTRWwPkvsb6aOpgZgURzcNWJ27V54oT4Kwp4ZXvdnuupC/HGe06+gaN03/IMgwS0/
         4XMCJncyyrgrLgm9Y8UErNwLpwixO1hXI4xwzFOc66pK+PohSo3NLmPqILN6pm+sTHSx
         HIWA==
X-Forwarded-Encrypted: i=1; AJvYcCX7XOs6JpyPd434T80gafp3NsQ2Hyd2S5D/cJccmZsuaO8kxpnOejtKwl8v0GEN/gi4+I1JsyHaa8bttf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl7CVNfQ55L5h6ipBVtEZaF0S9cmYMDUHWcoCqMZpb/IPRMlpS
	EBvZStxmX6wjqriwi8I5JassmNyeVo8MYDYE9DLnhm3ZRi79rxiBx2BM0+cQHg==
X-Google-Smtp-Source: AGHT+IETmZkdIfaU3KgL1a0e2OY78XhZ0gDO7l0Fn6ylun8F9SxSWEg+1I1jGGXk76KQfXMjITSOzA==
X-Received: by 2002:a17:903:2345:b0:20b:99cd:c27e with SMTP id d9443c01a7336-20bfe02ba29mr86787295ad.3.1728361088521;
        Mon, 07 Oct 2024 21:18:08 -0700 (PDT)
Received: from localhost (56.4.82.34.bc.googleusercontent.com. [34.82.4.56])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2e1e85da3f0sm8049197a91.30.2024.10.07.21.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 21:18:08 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	corbet@lwn.net
Cc: jorgelo@chromium.org,
	groeck@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	jannh@google.com,
	sroettger@google.com,
	pedro.falcato@gmail.com,
	linux-hardening@vger.kernel.org,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	deraadt@openbsd.org,
	usama.anjum@collabora.com,
	surenb@google.com,
	merimus@google.com,
	rdunlap@infradead.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	enh@google.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH] mseal.rst additional fix
Date: Tue,  8 Oct 2024 04:18:04 +0000
Message-ID: <20241008041804.1481453-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
In-Reply-To: <20241008040942.1478931-2-jeffxu@chromium.org>
References: <20241008040942.1478931-2-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Change "overwrite" to overwrites"

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 Documentation/userspace-api/mseal.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
index 41102f74c5e2..54bbcce330ec 100644
--- a/Documentation/userspace-api/mseal.rst
+++ b/Documentation/userspace-api/mseal.rst
@@ -97,7 +97,7 @@ Blocked mm syscall for sealed mapping
    The first set of syscalls to block is munmap, mremap, mmap. They can
    either leave an empty space in the address space, therefore allowing
    replacement with a new mapping with new set of attributes, or can
-   overwrite the existing mapping with another mapping.
+   overwrites the existing mapping with another mapping.
 
    mprotect and pkey_mprotect are blocked because they changes the
    protection bits (RWX) of the mapping.
-- 
2.47.0.rc0.187.ge670bccf7e-goog


