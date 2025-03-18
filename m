Return-Path: <linux-kernel+bounces-566100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6D0A6732C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEF5617247E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C80220B7F2;
	Tue, 18 Mar 2025 11:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PO23g+F/"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7BD20B819
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742298724; cv=none; b=bZE1xz7S+kQHnN8nMX7jjQrwX1ZeXWTpyeoN4r+VmFhuaZJyRwT6TqnI4Y3YSTPcgufwX3i+ffzXHYRmaEsZ4LsOkIjlxfqc7TdQ7Rj+XJF3S6w1rY3oiHFwScJb1wPaTxdpdA/Hz9JRwioYo54226BhKWLhUn8AWnQe+FWguIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742298724; c=relaxed/simple;
	bh=LlFQ6OvYGbUt6MCGuSx23PZIigfDNBT0i4vyidNAkp0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZZlBxjHujRv0VBxqZaHbNXVXg6ifoBZlHgewVs51mEvBePGo7LQrRqOuHLYcKKu9fI8mX1M9aeubG9xJcsFBKNwt8n9HpWK2JUSsG3hLhkiyVxljfUQZTqcNODBnO/QjmRBA7oPco8ZP/qZVPHBiq01jUgs1KVlAnDmzfjeG1H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PO23g+F/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2239c066347so113816795ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 04:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742298723; x=1742903523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqQw43mLNdk4RGf4hzRLUcoMNPzaWJ7WBFpnNihOCEU=;
        b=PO23g+F/eZcQlAZ8txe7sqOTnjDJplkAwOzifiJZFW/iMH4cJ/kx2fr5rd4Bv1c1yk
         USbn3OG9++0Riys7UXMCZ3Enrzt/MuobDGOyl8hHYkIoRc0dfX5EAnCwI4ALNmcaPsSQ
         8Oz3W5n1drLJwXXe2kJ8NhDxV3wm7WvmpP6wwSC9OwUuAJNHdba1E4GLg7xwRtZMGSAx
         ogp63+0gg/9Hm+dHy84hE+OloMgi6lyIsk6+BDFbVJJpPiZcT3ChYnhPdYCLDOhM6Lta
         VnhwE02KhNlUaEmnZKEDOlMFJFVG1+RgGFJDnncC2C/k8eba6ayZB6Y6/rMLPe2CUTx6
         nx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742298723; x=1742903523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WqQw43mLNdk4RGf4hzRLUcoMNPzaWJ7WBFpnNihOCEU=;
        b=MXe8A3wdXkGFU9Kg0KuXRwLX4JmI73KgyGUbxg1zjQL66eTicJYUZ/O95OJfQIwfV7
         1xXAKtYQLSbjDgs1IbnjbPz+7Wvj9SrEz5UDbPoSJABXOcUB62Dph8nti03G0LrI02mD
         vz4NSQiAPUIMDjXJZlpzBydm6/ZmmCjnWVV3m0wvvxAS5LJfYCRURGCxfyc1IXwaqvZ7
         llM+enJx2rtLmwh9Uh+Nh0CxbO153Sj4qiT6dlQuW/IYWgkmW8oPdi8t/R3e1t6nhP8d
         lVaDMZ4vtVXWvHGf4ogqRN4qeawf4bNgfNf9ixuDb81QVr2i4U2wxAyI1kcY/dcABgCY
         YwCA==
X-Forwarded-Encrypted: i=1; AJvYcCVkqRzUMfKmGuD6FtbRcKhBYtDPopZ49HQS5PoXPvkveUvC43Z6CbvibV+SdHr3jARdM1+LEYmDuA6SKWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdl/OzAd+hQeVzRSLHNvkj0ogfvsATAbWPVAUhFH+fIkKAKObJ
	qqP21c/DqKIBOKMeD+zbD81wPb+fsK0QHmA62WG/SyI/c7SRHN7PfN2FDgDcWBE=
X-Gm-Gg: ASbGncsY4GFdfCv44qWaiEAIwIXToh/YQ2aH8x2sBQfXoKUFjDcOqliJkPAw0rsw/a3
	VwaCdycreNiPux+eONFK1/jHeXXLdLBAxCbyww4J9gPAyAK1WV1/xP2lSvt10qWi7Th79bc140y
	CWHRRB2neVRepXRZlbtBXtWJH1+CQfDo8A+dBnY8fQpyT8BATFBx8u0swCELEi56OI2SyB00HDg
	Afb60v0Dn02yR7g0zmJIQm1KKql3EKXLokAlqJGVQfTrUjkK3FRWhbAWPYsFPtBFMdKgyOgkvZK
	njdjAV22f47JNd4Y0CbeAONvWP1VHAe2o1csLgUvF/eJqw==
X-Google-Smtp-Source: AGHT+IHR3Ra9GbL7M0mpcaPU8xBsJRCbItcu9BQ6LIdVNRTHi2iS+SQD83bYoZBSaU1ohrQWzaWstw==
X-Received: by 2002:a05:6a20:d80f:b0:1ee:b8ec:7062 with SMTP id adf61e73a8af0-1f5c11e5dddmr23171575637.25.1742298722889;
        Tue, 18 Mar 2025 04:52:02 -0700 (PDT)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711557ee8sm9669695b3a.52.2025.03.18.04.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 04:52:02 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>,
	rust-for-linux@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Burak Emir <bqe@google.com>
Subject: [PATCH V3 2/2] MAINTAINERS: Add entry for Rust bitmap API
Date: Tue, 18 Mar 2025 17:21:50 +0530
Message-Id: <cddb90075c7f892e30f5039c3b3d14e6a239d915.1742296835.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1742296835.git.viresh.kumar@linaro.org>
References: <cover.1742296835.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the MAINTAINERS file to include the Rust abstractions for bitmap
API.

Yury has indicated that he does not wish to maintain the Rust code but
would like to be listed as a reviewer.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Yury Norov <yury.norov@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 315cff76df29..c55db52590cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4026,6 +4026,12 @@ M:	Yury Norov <yury.norov@gmail.com>
 S:	Maintained
 F:	rust/helpers/cpumask.c
 
+BITMAP API [RUST]
+M:	Viresh Kumar <viresh.kumar@linaro.org> (cpumask)
+R:	Yury Norov <yury.norov@gmail.com>
+S:	Maintained
+F:	rust/kernel/cpumask.rs
+
 BITOPS API
 M:	Yury Norov <yury.norov@gmail.com>
 R:	Rasmus Villemoes <linux@rasmusvillemoes.dk>
-- 
2.31.1.272.g89b43f80a514


