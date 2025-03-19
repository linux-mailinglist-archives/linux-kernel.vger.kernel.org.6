Return-Path: <linux-kernel+bounces-568766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFFDA69A3C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B185C1B6203D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117632165E2;
	Wed, 19 Mar 2025 20:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaWeIQj3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E65F1EC013;
	Wed, 19 Mar 2025 20:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742416508; cv=none; b=hIOJHC4mt7GSGcOHt/u10YztXA2BimxjiIfE3gIc1AspRVZKW3yWlyJD8cRs6ryMu8y+30cRZE58NuvKEMVEKkwDdRXMT0o9zuY51IScsGzOICzqDKnblWdt6z6SgahP8XaPtq2x277m2BXxv8uf+OJsHhcOrrTuxK6rqvmlpzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742416508; c=relaxed/simple;
	bh=E96WYj6OXwZvjyqYORmOiFImfPx6kL3Y08R1UPDGqt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6yp4XIV7GpuO9SrFssgsh8TB8ZHWiu0iJjH4FYEVtUTVqa1ePo+l6RvnarC8ywbLVU/VjtBSXWXQSzQW3rvgD2rd9rD/fA1v7da71aeS+Io2E/fgkYRtAVjywLEZeTuKk3vv5Mpdv6nAgp+kj8uW5hWx+X/Mx4A0LsBwi2/VDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaWeIQj3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D220C4CEE4;
	Wed, 19 Mar 2025 20:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742416508;
	bh=E96WYj6OXwZvjyqYORmOiFImfPx6kL3Y08R1UPDGqt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LaWeIQj3AeL5SM8wu56XFOjEqUMOUmsJSS1mysMKNTEA2mvY9AYOnWY+ofWN3tVIC
	 cc14bhtC5iQeqfQZsB8usWy21qyBgJKkB1EBZ7mLvbnCJGqmeorz4ZRz1Cd4URcI7O
	 SBX/o3mESJG5DWvvaoWwQUyr2ljFr3KoY4/o5RhTR69xQ0mihSpMM95d54ULanay3W
	 lgCE1okM3VngqlcijMe2lheiGyCkzCabB52WSQvv0MXs0JxIo2wNUHWl3AU+fKXtLk
	 SrJd9i+LZSRxLJ11Jx28jJgKEin0fAwL3RnG0JEoWu+ecqAF7vvyIlmnDK+q8jvbyw
	 5xX4jUNrl/zzg==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	airlied@gmail.com,
	acourbot@nvidia.com,
	jhubbard@nvidia.com
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 2/5] driver: core: auxiliary: export auxiliary_bus_type
Date: Wed, 19 Mar 2025 21:33:54 +0100
Message-ID: <20250319203455.132539-3-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319203455.132539-1-dakr@kernel.org>
References: <20250319203455.132539-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In Rust we can safely derive a struct auxiliary_device pointer from a
generic struct device pointer by checking

	dev->bus == auxiliary_bus_type

hence, export auxiliary_bus_type.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/base/auxiliary.c      | 3 ++-
 include/linux/auxiliary_bus.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index afa4df4c5a3f..213e26c2747d 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -244,7 +244,7 @@ static void auxiliary_bus_shutdown(struct device *dev)
 		auxdrv->shutdown(auxdev);
 }
 
-static const struct bus_type auxiliary_bus_type = {
+const struct bus_type auxiliary_bus_type = {
 	.name = "auxiliary",
 	.probe = auxiliary_bus_probe,
 	.remove = auxiliary_bus_remove,
@@ -253,6 +253,7 @@ static const struct bus_type auxiliary_bus_type = {
 	.uevent = auxiliary_uevent,
 	.pm = &auxiliary_dev_pm_ops,
 };
+EXPORT_SYMBOL_GPL(auxiliary_bus_type);
 
 /**
  * auxiliary_device_init - check auxiliary_device and initialize
diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
index 65dd7f154374..d4ad9233bfd0 100644
--- a/include/linux/auxiliary_bus.h
+++ b/include/linux/auxiliary_bus.h
@@ -197,6 +197,8 @@ struct auxiliary_driver {
 	const struct auxiliary_device_id *id_table;
 };
 
+extern const struct bus_type auxiliary_bus_type;
+
 static inline void *auxiliary_get_drvdata(struct auxiliary_device *auxdev)
 {
 	return dev_get_drvdata(&auxdev->dev);
-- 
2.48.1


