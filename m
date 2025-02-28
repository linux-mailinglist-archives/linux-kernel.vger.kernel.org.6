Return-Path: <linux-kernel+bounces-537927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 459DBA4928C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203CB3A480C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADDE1DB55D;
	Fri, 28 Feb 2025 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N9SIgvPH"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B121D8DFE
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729426; cv=none; b=MDnJI4qOZ5jVrZCpmTbiaaJnZ9kaq0T1M1fzbPzCs0pd7gIBTGcQTAKwT5Z6J4jOJ8njva4eHOOIwz0pNiG2dzt4C3QkdgTB7SxhN2Fsv1sxPj1zAnfo536ygrqaPrGjsH9uDNsPwEDsVGcxV5PcuMxqlKYlpzxN3UmB0It/t/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729426; c=relaxed/simple;
	bh=gmMH+aUJE9Rk1973vUz9hXnl1+2zE7SmywBWSF30UzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nJiuKgfhv4C7CtnOYuTQ9krhRSUoiwFaxtF3dn22npW6194gzVW8nP7zTPX5WZ2pHn4/MQMYbaG5Z+4sZMal+XqDbenWQSCTdDw/s2eWn9gW3p2OVxsnoiM3ddMGY4Xwd4JEavdCpMfrgc/qYTtoe/tcGdxwLl1+84nU8D1emWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N9SIgvPH; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-222e8d07dc6so33609395ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 23:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740729424; x=1741334224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WUki+CTmoGzsbV4r0P+sToWHb5wtaj3zroxo9tMJJk=;
        b=N9SIgvPHmHba9/V2cdP4U9JI0Vjr+LutIPQzhKI9Qzx4hBs8fWz1plnND7d7wVcpiN
         TlYOc3FAr//KC5HQH+Avm37rGHVPWRuauv3AkRnIzKMYKavs+N4fF8iP9hRPEjnbPe/4
         isBL+jOtFgd11pHK6pfnDFt6/8TZoEi0tQEYxeROjsS4TX5ABCQFK2GeQLF+9r9cl6Ca
         neGutvNt7BnHGlV51RG9QhW+ybkqxYL05wUTxlTa37waDvtAOW8K8nlvOxK8gVxtCxYf
         HTojvLm9YMiUNLZL8oYPaU7hQRicpBz/hFBlsOLSF8bcO0zqx0NjZbk0KQEZ9stsl3h1
         PXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740729424; x=1741334224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WUki+CTmoGzsbV4r0P+sToWHb5wtaj3zroxo9tMJJk=;
        b=nDYfttkwOAZ4sbgY5UR02SRBFJ5mUBZFKbRZyKzpk82rNYAnDC4mQ1B4V8DQvdF6eR
         dwtsw/HnZ6mIDDPwezZXuA4gYs5WQisOJc3UI6WomDZHSOu2L2Pi//poHbgtkbXXIntc
         nimAAQ8NpRN+9R7sJnYsHKobfaJwkFamdeUXDYDTAKaeIzH42YKkfL6O0r2FLk6FVrY5
         W7T+6/Qw59j7IdyLqTu9KTtbdSbrCRmSQaxS/cHyfv+25Z1FTxfnufEz1yMstX3gPjkz
         VIh8K9AS621tq+z/8QO0PbaMxkRuzjDF55SzPAjvvKOQ2rndbgYarjYw6k6IE1F6VNLO
         jjVg==
X-Forwarded-Encrypted: i=1; AJvYcCUkgC5VtKWw48Y4AYJqWmZmmnvMuMgaC8AxQw1awyrxLMfXuMIGRSw3JK+cd+6P2gkeFRz483fE8VLWMhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH14zXGXygzZeSupYXMUImQjXZ6IepvTXIvsv5G//TBh+BpDun
	OExxxnIcAgq87gvHACzDFgPW/97r0+LuHtaoXX4aPYUSOnTfEeq1XZLH7AFDlMU=
X-Gm-Gg: ASbGncuEAlORygUASiaWpwr4uw+El0R3AQgagS5Ku23bjkGa+bu3+WvZEWMkGVPWmk3
	dUk0uwmw39YN75DmCXaL07lRvWACNFFn23m+0ra5Ng8fLUzvTGpKFBzvYROZpKw2TFgdHkeGAoo
	T1XT7ZI1/fgyuWk+KU6ogtDF8oRXLqScMR2v4mvWIcOUd009eOLhbDPHUl5HexMO4HNkHR/czNe
	DTpnP7IUYma9BXadNZVr35Bu9a8nHYOWxF4Wc67zuXA40d1IxLz7NrPb3YdvFIKT3rMEGkr6vMG
	wqTu37vl+q6ZYEgoLKOnMyhy18s=
X-Google-Smtp-Source: AGHT+IHF0XzUBOQzA4xQaAevOhP/XOeIAlJ08hdOp5noD+m/4qmyWqGwO+BqRhM4PXdmUbApIBe8gQ==
X-Received: by 2002:a17:903:1c9:b0:215:b1e3:c051 with SMTP id d9443c01a7336-2236745595emr42790705ad.11.1740729424024;
        Thu, 27 Feb 2025 23:57:04 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22350537b47sm27618385ad.251.2025.02.27.23.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 23:57:03 -0800 (PST)
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
Subject: [PATCH V2 2/2] MAINTAINERS: Add entry for Rust bitmap API
Date: Fri, 28 Feb 2025 13:26:47 +0530
Message-Id: <e93666104fa1e4616d88c31e89bacc4415db24af.1740726226.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1740726226.git.viresh.kumar@linaro.org>
References: <cover.1740726226.git.viresh.kumar@linaro.org>
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


