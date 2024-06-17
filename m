Return-Path: <linux-kernel+bounces-218292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB2090BC2C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589A91C22EB6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB741198843;
	Mon, 17 Jun 2024 20:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dr2KHPuW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBC3196DA4
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 20:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718656227; cv=none; b=oG1WLvZSz1Va4OAmHyGnSoUWOByHXfBI3UG2+M36Ho+nVOkgq0LMKiR5/0E7D900bBsKZ+tmORw6jJ9OQbajSPro1jJfeoJwxLK0ZuVy6NCA/0piLz6u7c+yZ+6+vP5AXshj9rWzwblkc+UNWuAm5C44cw4+1PyfUy3XCCz6Un0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718656227; c=relaxed/simple;
	bh=DmPO2Vwro1FlOglAhnrcQSsrrh8TKk7BJlzwsizxTOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=meNOixKJyIAai7moaga7zqGkzKFxjT1Mk46EMwJXduJydtRS6CEnZK8TOxTgFYiOM4k3cz5tTGfw0+Bmx/s0hhqzrjrAxrZCNONPOB0lm55opDhp2XQBlCvUXw4Gegw0F3RHvfmSgyftZwPDPxzVuk8RiW4wl60gHz8cESxU5nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dr2KHPuW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718656224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ea6sZXa/7DWxE8pxpCUuitKCovL7tQYbV++N23/HTmU=;
	b=dr2KHPuW6986gIH76S0hUP4nHYP/PvHHbHluc2nDCSWSs5YEArsFarXTS0bAfaFMdeg/5i
	hbiipI+N0sM0NTk1LQud//SFH5/0pUA4Na7LKAFqI7/4e14QUrwqbpgQd1xaerSV4Qva4k
	J4ICy/xERsg4g+y+Ry1VkKVb7Oirals=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-NtIxsTtSNquxwiCcYCIh8g-1; Mon, 17 Jun 2024 16:30:23 -0400
X-MC-Unique: NtIxsTtSNquxwiCcYCIh8g-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-35f123fb9deso3187751f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718656217; x=1719261017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ea6sZXa/7DWxE8pxpCUuitKCovL7tQYbV++N23/HTmU=;
        b=Fl9zSyuraKO2KWxGn5kB3C3Z7txZghQd72nXbJHaJQTx01Y/0UHJYu1BJgwOa+r0li
         9eyZxgrwgzMvFglqYP7SMteg0BdXam6F0JW07n0SwpzRDVmW4jJwZ78ZTlpseoe40b0m
         VUf1oTHLSIsuCcNASZpRxzp1/66luy5SGiAOd3ui0g7USj5B45AaBbHbbidgzc2YAPK2
         GBhzE5l3Ynr0QybsCbdeerMb6g//q0nOIGDnJFVL/0fABt7fzpsuPpxccZHBR5X8nYOr
         uIWim3RG+jApVzHW2mm7U3fdLDqCiJcWvjhuRaBjDJZfETCLee5L7tkhtM0tq+5B0v2e
         Qu+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQ+J7BEMfKOsPlwPpsjvKYChhiQ9sgjJaBwCbmFOTseMCzqNJdj5Hb3bF9OKFOPXTnLLNQtbKkettb8dUHHIjAzShYC4JhoYE5ttXB
X-Gm-Message-State: AOJu0YyJUow8QSPJq1m7XdITOUidxWt3EXoyyv4oWVAAKuUdJ65z8IMm
	ln46T8e8MoZPg706EPgg7fcsT2oKXWyANd9EeErKq9VtRkCJ4tyfW5EYOt3iiSSxc9c+55KSMAP
	5MggnPYP8BSWcIOdyfXGhoaPQChPpTWSesXa+VWx2U55suWInyhr1FXMBXmqQvw==
X-Received: by 2002:a5d:6887:0:b0:35d:bfe3:1817 with SMTP id ffacd0b85a97d-3607a7b6608mr6691266f8f.21.1718656217492;
        Mon, 17 Jun 2024 13:30:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHspzgic05YmLERp6FfxQzV5TfzVs0ataIlRRzarVIChjHH0Fd5oleVnDT/bv/Wg6ypp5SeWQ==
X-Received: by 2002:a5d:6887:0:b0:35d:bfe3:1817 with SMTP id ffacd0b85a97d-3607a7b6608mr6691247f8f.21.1718656217131;
        Mon, 17 Jun 2024 13:30:17 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075093a4asm12594425f8f.21.2024.06.17.13.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 13:30:16 -0700 (PDT)
From: Danilo Krummrich <dakr@redhat.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	mcgrof@kernel.org,
	russ.weight@linux.dev,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	airlied@gmail.com,
	fujita.tomonori@gmail.com,
	pstanner@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH v3 0/2] Rust abstractions for Device & Firmware
Date: Mon, 17 Jun 2024 22:29:39 +0200
Message-ID: <20240617203010.101452-1-dakr@redhat.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

as agreed in [1] this is the separate series for the device and firmware
abstractions to unblock the inclusion of Fujita's PHY driver.

Originally, those patches were part of the patch series [2][3].

Changes in v3
=============
- fix safety comments for `Send` and `Sync` for `Device` (Boqun)
- add corresponding invariant and safety requirement for `Device::from_raw`
  (Boqun)
- drop `Firmware::request_platform` and `Firmware::request_direct` (Greg)
- fix missing Kconfig entry for `Firmware` (Greg)
- fix doctest compilation for `Firmware`

Changes in v2
=============
- use the 'srctree/' notation
- expand the existing documentation and make it more unambiguous
- use `NonNull` in `Firmware`
- generalize the `Firmware` request functions
- add missing safety comments to `Firmware`

[1] https://lore.kernel.org/rust-for-linux/2024060745-palatable-dragging-32d1@gregkh/
[2] https://lore.kernel.org/rust-for-linux/20240520172554.182094-1-dakr@redhat.com/
[3] https://lore.kernel.org/rust-for-linux/20240520172059.181256-1-dakr@redhat.com/

Danilo Krummrich (2):
  rust: add abstraction for struct device
  rust: add firmware abstractions

 drivers/base/firmware_loader/Kconfig |   7 ++
 rust/bindings/bindings_helper.h      |   1 +
 rust/helpers.c                       |   1 +
 rust/kernel/device.rs                | 102 +++++++++++++++++++++++++++
 rust/kernel/firmware.rs              |  98 +++++++++++++++++++++++++
 rust/kernel/lib.rs                   |   3 +
 6 files changed, 212 insertions(+)
 create mode 100644 rust/kernel/device.rs
 create mode 100644 rust/kernel/firmware.rs


base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
-- 
2.45.1


