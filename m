Return-Path: <linux-kernel+bounces-530930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39190A43A3C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56FD21898F76
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B002673A0;
	Tue, 25 Feb 2025 09:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J6+QNen+"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCF6266F1C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476851; cv=none; b=FmD6MUCpOjpP2UDUb4bBITIrDqK1PCXhYeyyJpl6dtJSNfMc6QIKAlKQaBvSXH6sN2S6kSRlLvAKDiGwCra7xra6yPOVJVh1tQc6C28F6Oq9EidJKxswSj9JlwH87h7iP3vK/wWEV+Ky317JyLrZvrWoAwX/iXfYuJajnYTHvio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476851; c=relaxed/simple;
	bh=0ejApvusm+PXgcgqxCm24+gSHcjnJ6Jl3ndWCY+M5ik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aKs5rimfMgB/qoRDkwZAF6nPw+lMmVXoxh2UDcSan1PzawsHNWpSIVOqin/l0DEmNbzhYbpbszIzruGI9ZaL/wClKpD9urJECLMgwQ1poNsaCtMosEZ/P2qRTiaN6DR2oBeTS2WhocOLfXYBGCBK6fu3zFYO6KSqId48PEkZqQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J6+QNen+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220d398bea9so84800595ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740476849; x=1741081649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Y0W7UheN6mSPqJhQH55oXPueVCUP+Q3dgB84Hlr1jE=;
        b=J6+QNen+iqUN141k5GjIzbtpj86UAoKC0mzwtvywEjjnFQWHGJ8CNJrV1B3HGr7Ypr
         3Ug9NqRPHERULM3NGv/mWyK1xkFsUb16E4n8tiuICzaSS/8IBgg7hc9OKaJfAhaOS0aS
         x56gPNurmTJYduKvJVb6qX7yWhW7v8+SaGX3NvekhuhUcJUC/eWnVe5xsjB2qBLXDkks
         tUHa8nuavyLsEbt6imQMeZME9wSI5yDJ6pejs3lkxzGSK37y/LEdIZrv85ZCOSxxqR0o
         ZCYDp2mq8T0EaUF2g2a8KjNEUyiOGtm9rFn/YCaayy5Bw8OQyx8ydw8SQ/zQFtzyrb28
         ldpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740476849; x=1741081649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Y0W7UheN6mSPqJhQH55oXPueVCUP+Q3dgB84Hlr1jE=;
        b=vPlZEHdNjnfGO5qJhWkxt6PhjD420TLlBhivvgG3F7ukyauJtoa9gPQtxycvfnSjmu
         ujdWlW2wkoBkO67KzUuhtcK1QS2FDzbc4LUqo5NL7Rim1yiaGadj8kTqe/hhR8HJN1x3
         Telq9l2m8RnO+r0DtFB5l/++lo9L9vQAw3rAHK4U6YFVFxh1zjy3KlrCIz1o+tQT/aE1
         8NeHRA44A6yR9GcljlbEmNMiPVA2dpZ+ihMIPLPpvmRzKfy0BlFUfMUvYevay07lggEV
         5HzbAedfgASPmkxaE6rQvT4xuY4U25AjWSiyhzi7Z+GfkKoNBcNb4rRTUaRcib0/TDG0
         3oOA==
X-Forwarded-Encrypted: i=1; AJvYcCUT1oBNhwD7Y4RBJxMHNOZw6HjBVDNF0jEDemHeLp9gHuztvdtWppVZ37Yg6gArwer+qqJx6bCx4OUUKjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwVmqqwEDi1tjfKWNKEXE+O/HTbvIMBVuBS5dXxEBvOFyfL3Ly
	Gao0OfS0Sde4wSbCwUgeGeCH2H828qxQn33xeZQB0ChirJ9K5/Qt7610MWGqTTc=
X-Gm-Gg: ASbGncuBanOaqYH2a9xBMRngFm+Z2RdjXu50OHxJMZJV9HFFNLPccID9GOB+s7OfKF0
	w0BTiPLCR8Y0dFUYUTidXJ2UrWDbBVHEbqNgpQiMxxwiPx7ZCRhIXp7dPV/aV/LGXVzTb1er6cl
	payS9L6kqA/0lZUizOM0byUpWuHWCkUYgWMuEugtlSqExSpr3k026x/JMc0ZLE/aag73nWsOAhQ
	/eA+fFRYfBS4IqaigZh7HczrIt6ifjuiFZXS/LrJMDXorHqzM1JP2F+XhYvICR1GDMaM3MaV8Mf
	BpL/1vgIfatmq5r7O8qB6PAXajA=
X-Google-Smtp-Source: AGHT+IFMG/soZLRcXoKfyCP0+FxL3eEOXtCUItNCtSz47RVliZKe7vtNrSUTsGyoRvocVgft4WRZSg==
X-Received: by 2002:a05:6a00:2192:b0:730:75b1:721b with SMTP id d2e1a72fcca58-73426d7273bmr26247209b3a.18.1740476848937;
        Tue, 25 Feb 2025 01:47:28 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6f8f24sm1094883b3a.60.2025.02.25.01.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:47:28 -0800 (PST)
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
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/2] MAINTAINERS: Add entry for Rust bitmap API
Date: Tue, 25 Feb 2025 15:17:15 +0530
Message-Id: <8c6249c6631f47565541d584fbec78cd2fbe60c1.1740475625.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1740475625.git.viresh.kumar@linaro.org>
References: <cover.1740475625.git.viresh.kumar@linaro.org>
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
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ec2428b82103..17e98d757b9b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4034,6 +4034,12 @@ M:	Yury Norov <yury.norov@gmail.com>
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


