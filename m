Return-Path: <linux-kernel+bounces-572432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65091A6CA48
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 14:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D66481B668A8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793E322B8C8;
	Sat, 22 Mar 2025 13:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxoTFMbf"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3A422540B;
	Sat, 22 Mar 2025 13:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742649833; cv=none; b=i8oJ3UtsO0AHSOD8JJ91/tsOB3X0LGEFE7YhqiRMOiKKjHOwZTnnDscJGTlVhnEyxUxRC6xuRhZLmjfwDk4aLUnTfEeXedRSU9eF4JG9Vri8+rXe5gWbbmI3SJ2lRygiWjWMprreOpOen615jKUIgd9hgFuLOThTmiEQJjMpY88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742649833; c=relaxed/simple;
	bh=dk7KtJtdwq5rZi7r+9Pb0NMmgsZabVAVOwLSoSxDi30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r6v/WvYGxPzn/F4sFiwZ6VVpuQLwY2iQE2b/NanluulatfFoUeztxCwdnec3HhgwjjO0SjMFow7ijy7Mz/cVqaGJOKlgVcaWP39qgpsLnxYNWeFljrtjOk7RO9yVf9H+Nf/6G8yHyLTIjc6szPUKK007Y8vRaEU2yRu+ratsEos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxoTFMbf; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e8fb83e137so23369176d6.0;
        Sat, 22 Mar 2025 06:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742649831; x=1743254631; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=19Gdfw+4D4XqpAXnlFcAX1akfkMiVtAPuON1TfNX38c=;
        b=IxoTFMbfcuGtHNMOu4dDscCd+F7SpkRs15fInWjb2LDNKfuwcxJcSPThjUIU//FlR0
         CQKuV6KW5pqDQk7ocHPW+V51mpmRbfBonvmlQZZyZ//VbqGqD8IYgI2sQpV5lg8wZNkx
         PVicdV6w44cgSE12wkoteQYrUVGNNrPHO+MkvhusIch50fs6HNT0MLjGyCOzv1mmwvVJ
         rJIpgm6/Hxkm1MYOfVrdY0kMCgGJ7FpogdFlalQWcr2ODkKhPfMbAGClhkxKE1o4Etta
         PdxT+Ni4vNSTrb1JKCIey7BqdwgdZS44f4zPeIDRvs7AZ+810Wr8vHIpxUeGOIdNt6db
         mGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742649831; x=1743254631;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19Gdfw+4D4XqpAXnlFcAX1akfkMiVtAPuON1TfNX38c=;
        b=cPa+0Ad+ksp77TFd6pBsAhI1icKPoNdV02VaOPlqTqpENgBu56BUTwNdf63b7WHZqn
         UXmjR4Ss61DBaNdHSlgtzV31c9KUJVP7abRnYyPLVGuhmmFmq5RtY7kgnEoUn2e2mLLM
         1ON2g/UG1G7h9l2BOajOpTTJYWzdyyyjvh180pr7h5gNZb4gvdhyxwmPTJBBpUrPNJGc
         fank1ykOeU7rJyccy3oBH+dbO+KKjtBXDjlPuAwN5hcYsDteY3F9CEST2Q7wSU+tZk1F
         zjWiLzNXOCHjhWEugTf6HSJi3lx1YDknnEFNbB0aLEyZFoeJTW5/LOI2/cnT6To/dp2P
         8iig==
X-Forwarded-Encrypted: i=1; AJvYcCU5iz0eZuzhTD8pgeelJMQusAWM3SWB66Bv6R8Jza0LvoVT6UWmKG4qx9E9G2BK4AGk5eDS4RZd0wqHZds=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmMQObMBe8ur5m482CJ35ePRKG1M7MWnCH8wZa6PBXCQGK4EFT
	qrA9iNBhDAvKdQPdKXvv9X+93SeS9B7ICYoYCSd22Gtkw5ElNSvX
X-Gm-Gg: ASbGnctQjHK4Bthes/YuxecIR1NytwX3/5EYTnSkvf2Sh/jOkNUC8pwdnrLBzCx3dHw
	2i2lgVEunKpEtON6UfXoPIeTHQS2JmfTphI8Z7Butd4coNg5gnEmOSlWm5icauTdt5MHKOm5B73
	QV2fXtW5b7yz8GDzNb2zVmE6rDQeEdiXvRMtLpCf1lehTLA1TOu1+fS456yQInQ35L8StS2tNP9
	lRhD1sJr1THpXdAIl3wQLuWbrGIxIrNoWwYxUGtSBeeZL6drM6i+4vULr9WWm/4xCmGdeQTF8fB
	tEQxZL9EvxQvFAMzQCf+ArR+DoC89S5ZPf5C/L17eGHjxggHH9HAPrTSikcEtIi5ghRXX76Z4k5
	xgDIjdeaTxXLb1iA4PX7VYPRmK5vdLRFsegRKPz2iMXx0X3U0NYmsYqprXsAic7AeNUuQUSU=
X-Google-Smtp-Source: AGHT+IFEb41MWOnMlV0d/xeen4yIjEqP3XPCLNQi0ntOgpca7/83Jth3+hbdEP6qNmVSaogj66w+Ww==
X-Received: by 2002:a05:6214:cc4:b0:6e6:61a5:aa54 with SMTP id 6a1803df08f44-6eb3f3ba7ecmr108109746d6.44.1742649831041;
        Sat, 22 Mar 2025 06:23:51 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5be7:7c00:5ff:9758:a8dd:1917])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efda6f2sm21944596d6.116.2025.03.22.06.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 06:23:50 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 22 Mar 2025 09:23:37 -0400
Subject: [PATCH v4 02/11] scripts: generate_rust_analyzer.py: use double
 quotes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-rust-analyzer-host-v4-2-1f51f9c907eb@gmail.com>
References: <20250322-rust-analyzer-host-v4-0-1f51f9c907eb@gmail.com>
In-Reply-To: <20250322-rust-analyzer-host-v4-0-1f51f9c907eb@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Boris-Chengbiao Zhou <bobo1239@web.de>, Kees Cook <kees@kernel.org>, 
 Fiona Behrens <me@kloenk.dev>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lukas Wirth <lukas.wirth@ferrous-systems.com>, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Replace inconsistent use of single quotes with double quotes.

This change was made by a code formatting tool.

Reviewed-by: Fiona Behrens <me@kloenk.dev>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index fc1788764b31..e2bc4a717f87 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -169,8 +169,8 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
 
 def main():
     parser = argparse.ArgumentParser()
-    parser.add_argument('--verbose', '-v', action='store_true')
-    parser.add_argument('--cfgs', action='append', default=[])
+    parser.add_argument("--verbose", "-v", action="store_true")
+    parser.add_argument("--cfgs", action="append", default=[])
     parser.add_argument("srctree", type=pathlib.Path)
     parser.add_argument("objtree", type=pathlib.Path)
     parser.add_argument("sysroot", type=pathlib.Path)

-- 
2.48.1


