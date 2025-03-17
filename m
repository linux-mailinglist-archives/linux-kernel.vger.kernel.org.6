Return-Path: <linux-kernel+bounces-564941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73CDA65D56
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089933AB094
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901681E1E03;
	Mon, 17 Mar 2025 18:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjASMqQ6"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56398200B9B;
	Mon, 17 Mar 2025 18:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237663; cv=none; b=TGWIkzKKYp2jvYBym281PpvFAwWONDSER2AK94UumoEJx48Jk1S3mzbqUzTW6NJilOt5s32WVHUErA1NncnIpuroHRmfK2z0CuXonQS4Ui0STly4h2InT/jiKz/aq/DO8BNjypbR8rUZq7M/Mv6Hc3ak2r92bPmXvx61M42uQ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237663; c=relaxed/simple;
	bh=DhrwcCKAPl4wQYbKHYYSepNVPu31+4xtNNYqjdxy+Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBa7DsiKzTRks/1VALoRV9yHHe59zUB2xjfG8V3Ndzkf57REfMbgUqRV+zL+5SnbJlVvqJyjDbd8YRtpKCte3zPOwhaG4c3aUvwXGfVAjilhq9zkXjiC7P9Gd8Y8paSyOShTXDBwpGofaSeWaEzVOrQQalH9HWVjQ6LWT2+wSPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjASMqQ6; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-549b116321aso5300742e87.3;
        Mon, 17 Mar 2025 11:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742237659; x=1742842459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bITllDD7zuDX+leMoEvJ9eOhvzTi6bzqiRqTzF92s50=;
        b=jjASMqQ6HhzJOnIu6h5dPYVXvA2db9ezNIZo4YCLIUyt1eMF68gBHvahj4BDW7iTeC
         Yu2D3VDIjZ+pq6tB2soLOkg3U8Wl3wVX8P/oHFAGs9Mv8/8LSI6YtdXQ76RKI/fud7he
         xCpyVNHP7s9OiGjuzO9HnZ0KeqQmOWuIKHRC/ru4Ke06z/qUVanVC0C05X5+/OelN/6H
         4Fpv2W6/XGc/WY1LfGp9VG+6l9syYTkgCeg1/BwuJjoN+qrtYSu5N/peaH7TyNCc7KNc
         f+cNOnJFnqEjND7ANzLAcCEgQLRPzqzjTLOsBxRrzluOplyx1rmataZyksZGaTsj4fl3
         nz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742237659; x=1742842459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bITllDD7zuDX+leMoEvJ9eOhvzTi6bzqiRqTzF92s50=;
        b=U+VuCH4cyalEQbMVqt1fD7nf4h0OkbmpZdqsFE6eC4tZi6jIeZQ5wIbfV5se3caClM
         EpHcgexeP+mC7GFz+ZLXk3dzmoUNnXiNOMVU0WbdFDVnC0Nyq64Ta92FtwlxGqG3I+hQ
         x7gvUuhb/rSFxW/VAtAQJz9xjYxf1+eeHe0MWnzMIx3EXGS68eQ9tDPAE+Yvqpm8pFxi
         7EUq0v0FR1knv1UbNMKQ5aLE3HolWV2gxLvv6fm4u/aKGKUID/sw7Z/dGaZkmG0z/rcK
         7/vSMmi8xxzPMJ8FNNNMFsrTGtOt7re9nWZGBCXK2ydhUx86stZougVgqFIutIuTFAGZ
         u+vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhCJI56wvhD5QL6ZtK3I8dJV1FD1zhjBuEbltoN0KvxfRBHFDL2jm3i+i3lFxxuofrskxafocamEaD1b4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwqQPxUNV0F939gxNu6A4u5jV1I9rf1+e1l8ffDW3fD8tllekD
	h6bncnL6KkjEob7V6JediK1wpnCzusqjGS215+UePqoWTpu/WGPkg9LV5A==
X-Gm-Gg: ASbGncsOZoayCSb3dnfzziMV6wSaJy1Lonq/YB0vvFWk624w0Ae6D3RlHGJ1utgz0My
	zmLi5VIfh0+2VgEo1RcOKdFSpq/8hqjWFPq5bKKBKo0K+8BL8n8ZGNmmkjhLizgIm320OnViJfe
	FZfgzBxfYkj1e9HlKYtVqIEPsWsxkOLoMDceAq9yU8mqaqb/XcgjRqIBlY8R7VkeVfXinMw9TTB
	PPgw89zLDU03ua1d3jeVLcwkV2HQQ4L38G3xQd3HsEbhx+0b+Pzlhi/C0Bc3Xn2fmXoj/eL9cxQ
	hHRVdkKZ9eFtzxuDgKzLFyz01WfGZ7lKTegX5NpiRWKbnVbIPmBx52k7HuZC4uUewsVxo53PBD3
	A+YA0/aaym1xwT51Zjll+Pg==
X-Google-Smtp-Source: AGHT+IFbyIHdySxokOsAc7slyf+TNhJ4gkPo4Mto9tNnD3n0AVBHi4ObetvBIzaq8zw+2DhtUo3BVA==
X-Received: by 2002:a05:6512:1247:b0:545:ae6:d73f with SMTP id 2adb3069b0e04-549c394fb49mr7047143e87.46.1742237659278;
        Mon, 17 Mar 2025 11:54:19 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba865024sm1387506e87.123.2025.03.17.11.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:54:18 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org,
	daniel.almeida@collabora.com,
	dakr@kernel.org,
	robin.murphy@arm.com,
	aliceryhl@google.com
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v15 08/11] rust: platform: implement the `dma::Device` trait
Date: Mon, 17 Mar 2025 20:52:15 +0200
Message-ID: <20250317185345.2608976-9-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
References: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Danilo Krummrich <dakr@kernel.org>

The platform bus is potentially capable of performing DMA, hence implement
the `dma:Device` trait for `platform::Device`.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/platform.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 1297f5292ba9..a7bf3525313e 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -198,3 +198,5 @@ fn as_ref(&self) -> &device::Device {
         &self.0
     }
 }
+
+impl crate::dma::Device for Device {}
-- 
2.43.0


