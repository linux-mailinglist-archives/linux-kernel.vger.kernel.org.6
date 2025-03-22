Return-Path: <linux-kernel+bounces-572433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C054A6CA4A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 14:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37884483887
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1E722E00A;
	Sat, 22 Mar 2025 13:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsiWwEns"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4282122B8C3;
	Sat, 22 Mar 2025 13:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742649835; cv=none; b=XFkwGlbVN0UVvVvIJl4vufTH7LdJcRE3BHelsJWfGd1ctjKvxipOo9+sVwSDL5UdUwcc47r6qF13dgba6PyHE87CG5Tm8+x0csNtLk6y2cZazGNaeFgC20PtL3L4RsTW9Cd9kp2Ya6Kfr6tpOXl1lgCmu5Ud5XV61HCXwyAw66o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742649835; c=relaxed/simple;
	bh=+gfaBr0cvuia1lqZHH3v6pzlDrS6h4TAK+d5tJ7V8Kk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MZNY5tARLqlZnUrKkeaOVG86dKsAIfKxptWJqUnixAgQHC77Isr+NCBMm3Hupr4SJW9IRv+5lzAJaZsIOjeqMSSLWo/Mg2Nqzl43fD3idyLE9HYm6YxQm9khlOjN60u93AxRdUsoxTv7XwdViN3cbE0c4Q4zpPYLmavfBrAw7Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsiWwEns; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8f254b875so26152976d6.1;
        Sat, 22 Mar 2025 06:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742649833; x=1743254633; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zlyTaHIAWGAAzL1/7e7BfZlkyKveDUKQV/GQUWtfP5g=;
        b=JsiWwEnsqSHm8E477blMzV6Ep5MqSMywcB/Zot5MQYVCyP842hqpkFfuTGITBsmK1Q
         vUN6nDWx2Z7Ly32NgrwnQYJEUSLF9dH9+q8pWbUHv0hsB8VSi+OZ6QV2obcGkrTi/2kR
         PXV1B+n0sc0lcSKLK1V+n1S6aHhNDYCKuZvh1llFHESZHCzT6frVRZLVfDLVJLo2yF5a
         ZbKgzzSYbGGB7lD3igWWTbINwQPvzmNf1iSsN9NXjLCSkHiy9hXUa/sdJveekRC0649R
         1d8EsAtNQtVeHvKQWNe0+4GNNdQxjH4BxAm/D8dyOq/qmDp4Q/rxoEHl3UNMoPpkt2gO
         YECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742649833; x=1743254633;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlyTaHIAWGAAzL1/7e7BfZlkyKveDUKQV/GQUWtfP5g=;
        b=MhC2RZq0rgE9NlIJgxsnCRbUL5O/3Y8SgZmp+VK++tpEeGp5JtxAHZFfEnzmdOe1qz
         A7GLUhIz3Mx5TAYTMRrpUCKixBfNpQSMi2t0BLllFReF1i/+zuEQP9TwSbWh6Yny1Fsf
         uZR+PzTBkihzWWAAxuxRPTqBe80A40dSo+LoVUfcmgCILyPaTvvSfpf8abVxbmLLVbX2
         8kdtXLOyuOSms86632uYFE02HcXy8DoVB2QzrN+2z1sWqloDeTt5Pu1l4C+tBDDo9dQP
         D4CoTsjEy3pnvwtx304JT36XmmCGK7WMJ0iaZOwnsjZ/IB5pFBYFaz4JGI7Cv03Uqy9B
         swhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC7z6Ar6iPLNRIuFWjc+wMCasGwpMBeRfcNjv2Q4mO1gJ3m6M4WDHPwCVkZitDkyuhrM58b6a+Q7rb9xc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ESiboRKM1D9jUqHAsPQVgQCxnBIykNGjDvcR76e0QoD6zt8Z
	ihDUPjbJCPH/CcUxW+SuBDRx63B9xsnynhnPr6sS3ilr5CC4tNcs
X-Gm-Gg: ASbGncvsIjraZorWjn3KD/82KqaOKMA3dYK0hHlkWwiZA9LaP23B08ZUJryo+OCXdnp
	tf+gPhec74Zuqvw+Oh+8T21Wolac1uCKAkXAMIEpX1PYs2pk7MCK2PeCcpXksP0dfJbuKWYVl3U
	dPrAZuEPwGqUmWxsnu7SyPtjBDKToCa0GJS/MU1iutuVHeG4iniOzTAAZ37eu/3jZw3FQlw+FgF
	ydfldLwBcUMI20yaY6AQ9iAPFQJ08ELUiGkUG1X+ZlFXZSFmJozElgFurnk7Ac64p7Ct6tGen+6
	4SspHCNVrEcOlCcz6JEhgNn4hGw0jDi3x2THKrp2bnF/Y/AIifzxASCgmSJdCdfsnQ1vADeEUcz
	ePpB/NP9OZ9mhVAKF9GL4RCXJKw5lsqSmnRS+2PnSBAIBugQgoCokPqz1fbw5/TRUZkd02v4=
X-Google-Smtp-Source: AGHT+IEV2W/KjMbh/yJVeWDt5BjZjj7cYTvbmupLb1fv0gWd0UyOB0Auc/Dfroz/q/PQ0jRzqrmveQ==
X-Received: by 2002:ad4:5aa2:0:b0:6ea:d361:a4ca with SMTP id 6a1803df08f44-6eb3f32a616mr104382296d6.32.1742649832991;
        Sat, 22 Mar 2025 06:23:52 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5be7:7c00:5ff:9758:a8dd:1917])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efda6f2sm21944596d6.116.2025.03.22.06.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 06:23:51 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 22 Mar 2025 09:23:38 -0400
Subject: [PATCH v4 03/11] scripts: generate_rust_analyzer.py: add trailing
 comma
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-rust-analyzer-host-v4-3-1f51f9c907eb@gmail.com>
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

Add missing trailing comma on multi-line function call as suggested by
PEP-8:

> The pattern is to put each value (etc.) on a line by itself, always
> adding a trailing comma, and add the close parenthesis/bracket/brace
> on the next line.

This change was made by a code formatting tool.

Reviewed-by: Fiona Behrens <me@kloenk.dev>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index e2bc4a717f87..e997d923268d 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -180,7 +180,7 @@ def main():
 
     logging.basicConfig(
         format="[%(asctime)s] [%(levelname)s] %(message)s",
-        level=logging.INFO if args.verbose else logging.WARNING
+        level=logging.INFO if args.verbose else logging.WARNING,
     )
 
     # Making sure that the `sysroot` and `sysroot_src` belong to the same toolchain.

-- 
2.48.1


