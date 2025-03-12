Return-Path: <linux-kernel+bounces-557124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FA1A5D3F0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 02:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE7D3B92E8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 01:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EC11487D1;
	Wed, 12 Mar 2025 01:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tf0hqtIr"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4A378F44;
	Wed, 12 Mar 2025 01:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741742267; cv=none; b=Xn10GNfcTvG+fVj86SRO8OAuL33IgqwTukODbAyyvKzlU8b70jzlsFFfgSGoBORcTCmmTO82bC/mJynk1mlAKxALV+mDHQfPbpe9jWPmv58usXHFACkPZBLtTnfyGwbw6iUNtBFt+mj9CA/QzQRn8ul+rOmm7079FwfiB/TTtec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741742267; c=relaxed/simple;
	bh=7JsCd3EOBXCQwCMcOkbL4ce9rxRBvKLTXnVJe2yA+YU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hQ0tpKLqRhTj/kEtzVw4Ea4icqDWl09N4Q8f/hprz6cI30LYOtSpX6vOcu5jn0lpuW96CKbkisOeNIDZ3stfezzX678drPNTS/PGntdvPtIyDYP+55x4W94BfNjHetBK8G/crsu95DnS9uuBxqAGyDG1jaC5NY5av3F8Lk7H/Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tf0hqtIr; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-475a77bbd8cso59639861cf.3;
        Tue, 11 Mar 2025 18:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741742264; x=1742347064; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5Rh0FzO9cRqB5f6DNBFASVAyk0HPfSHAFbCNAH2RxU=;
        b=Tf0hqtIrOgGs+niA/umr8WaiZo6lhSHzXcFzeeDvbRWML4gBjfbKd1BP0rPov3j7Ly
         NwHXQ+xGrwGZWVOhoHv1WUE6lWQvQh6j+0W4fzyiw0NTnIldHwH7bn9y3LeD66N4jXs8
         26E3g53lZfoEsmULdduW9H8pB5rjovu5JMmMEAXG2H34XTKwLwt/+Kpbi9HZWy19/ZWX
         XplbjK37Gp1DZFRWO8l944GMohDSSPvxdgh8GCfzXFlrricRbW1LZLAswOUDcIaG5DiN
         /EgEvzq1NQPIrOY/jIVu3QnwGuARCNMcGkZyEIWXtxDCIXhtKol8xBPg1+4HT3p4/vz6
         l03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741742264; x=1742347064;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5Rh0FzO9cRqB5f6DNBFASVAyk0HPfSHAFbCNAH2RxU=;
        b=jVrvBw1RIRR3Nr8N+ZAMJIq97Ow4Zl1WGAUeJ5Gh1NhZf3PcADhdia7IXHsLrHScZB
         gzQFzazorqU2pKl/+tzCHGyxDlFbf1h2nrZTTLattxkokUlKfzlvAfkr6uHPVBabuUd9
         g7dsGkFg5MLbiGZUzyhPRrhPVcOfHfeSG2fuVqakAegpHgowm/4IXf7rW25hlVZTwb1x
         1qH/Ing1kkOjGD8VJqhrqVx2CcQSWPsoYa/pmwUkmqxhrVX6BOj3gxWDANihQMWUzhAY
         mXXuRoU4b1MhEbnQxbrF238lGGRxJ2FOBj5Aq7cc8uQgeB3xpYgStZu5kD66EPtG73ca
         69pg==
X-Forwarded-Encrypted: i=1; AJvYcCVL8ih0F/JqWiUfTc+rd44L9zkVQ6fZHGIfw18Ni0iefvMkBbvJz0XpWl9fu5daAReEbYIYMWJ/csGtQ/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzwfdoDD/XqnvflYSbrJPZD/vySdCwbhrzyeQ/CH3ipVEp7aIQ
	rWYtcdRQzcAKJnIKQfZSyMbGS4aaPmSM2MfXeeuD7oSAAdH1oguU
X-Gm-Gg: ASbGnct3agjIV9CULbnP4ArvytU8qJuURjLIF1citGkTS3mVBYTJnI/6Q2m9ixekONj
	ATjgaUWOZfoLrLosHMMgPFNrHxmoeInNfyl7NENIVZsc49zHXuhqLJ0ZNpHAGgJ9rn90gXrs/Q0
	OnIHLEp6Zp/V0BABREd1yq0E1d+iplgmohMthtAVZwNQA/eViGzyQMmOUTM7cmm+crdehW6v2oF
	mAladGua95Act6h5tnrGSsgSU0FhEZ37qQStjNfJlEIkeNBg3upe5C7X2eBAPUE8GP2lOsFazCB
	T/oGTeDR0ky9YH+rHbsTBatIQh8xB5LPvSn0Q2iVHXrinKpAXS7OfRa8nKR8EZ0ArHWf
X-Google-Smtp-Source: AGHT+IHWYnvrpKGUXD//62os29Qg48MfBZgnjZLZluSfIaQ6e/1FlaBNu9MsF6Sj8CWwqQJ/sps7iQ==
X-Received: by 2002:a05:6214:d6d:b0:6e6:6a6e:7596 with SMTP id 6a1803df08f44-6e900694192mr289407166d6.39.1741742264121;
        Tue, 11 Mar 2025 18:17:44 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:2017:ee95:21ab:177f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f70915ebsm78599976d6.49.2025.03.11.18.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 18:17:43 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 11 Mar 2025 21:17:22 -0400
Subject: [PATCH v2 1/7] scripts: generate_rust_analyzer.py: add missing
 whitespace
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-rust-analyzer-host-v2-1-30220e116511@gmail.com>
References: <20250311-rust-analyzer-host-v2-0-30220e116511@gmail.com>
In-Reply-To: <20250311-rust-analyzer-host-v2-0-30220e116511@gmail.com>
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

Add a space before the `/` operator for consistency with surrounding
code and code formatting tools. Add a second newline between top-level
items in accordance with PEP 8[1]:

> Surround top-level function and class definitions with two blank
lines.

This change was made by a code formatting tool.

Link: https://peps.python.org/pep-0008/ [1]
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index adae71544cbd..15a690ae2edb 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -103,7 +103,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
     ):
         append_crate(
             display_name,
-            srctree / "rust"/ display_name / "lib.rs",
+            srctree / "rust" / display_name / "lib.rs",
             deps,
             cfg=cfg,
         )
@@ -178,5 +178,6 @@ def main():
 
     json.dump(rust_project, sys.stdout, sort_keys=True, indent=4)
 
+
 if __name__ == "__main__":
     main()

-- 
2.48.1


