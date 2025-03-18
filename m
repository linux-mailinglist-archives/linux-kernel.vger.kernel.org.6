Return-Path: <linux-kernel+bounces-566644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A90A67AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7233E189E866
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BA2212B38;
	Tue, 18 Mar 2025 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="VVhGVa9Q"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80B0211A2A;
	Tue, 18 Mar 2025 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318490; cv=pass; b=l6C6jUadNPeKMbwzLJOAvtexm4cUkgvBDeV7wPWdyDkv+WOQs5gOVJph9QXce9n9aCZEPa8BSdQJYkp4KfDYWhAVEZOG1h/atk/is6RvCJhviOnYwuX1wQPT/DdAh1fKdkers63ENd5rn+eoxbR0ThV3nJiU4IMt8UkXZu5AdTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318490; c=relaxed/simple;
	bh=cwnOI3uzw3/dNX8tZA0B0rH4hXui9GFBU3MEeh5yufc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lKd0AAenNFb5E2s+sUYNLFiu4FrOA1F2WRHHSuISPIjnuO5DKQfEQvUaQ0V40t8YT8G+LT8Np1HxDBOj5+UA52Vm94PmqBT6eMeh6BICM1NPooCWE576n7ZCvLJ54YgLxvsledVvlskGlUBI4nOxcYjwBzPRlMNizcfeeHmPzzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=VVhGVa9Q; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742318456; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BW5QI17sO6qmT/LEfGvqPc9ArIPdqOMHlfCjTyLLXIFKmJpdZ7A1ptJ98GEPyDnhNLGF18oEAVRIcPrkkjbg3tSxwlow1yFMZIKXl4c582J1Dbz+FpxdEQjUE8nCSxZFl7a8zQek49PJge5N/j5VKnTZ+vzmVQWfLp0+DCb4BwQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742318456; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WbcdAXb2dZa6GbzzznH6XbOUmO6yBGCqDRBtaNTkRaQ=; 
	b=f01DXCJsPpkNeiIbmEY30NpPbWMm+NgTNzoDC7H9a665gt7ntjjOeKFPGaSXO+8wxMj9d3MJbVR0YJQzsbua+CBJxFiGSt95Kc7t40gk7eNTXypf8j5sGKw7jaAoYhpCyFzD6CrLgMT+4ReC8gcQLGCwv9u/TJzPOP8/9eNTFQ0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742318456;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=WbcdAXb2dZa6GbzzznH6XbOUmO6yBGCqDRBtaNTkRaQ=;
	b=VVhGVa9Q3iWFwjy1+foTFln9Hp3RNjcW/DawRrS5+JaMFntRg9QbarYQvlAhtIUw
	YkJimwUjLJfN1gCWzfkvf7kJYJWbLTz7qSUbna3aCBp9tN8vQGnwEs54QCGrUZYLUgo
	fnmTte1hjVPp7dPqQUJulZbIC7iqhcN1+QE0Jiv0=
Received: by mx.zohomail.com with SMTPS id 1742318455257622.0370548820867;
	Tue, 18 Mar 2025 10:20:55 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH v7 0/3] rust: platform: add Io support
Date: Tue, 18 Mar 2025 14:20:40 -0300
Message-Id: <20250318-topics-tyr-platform_iomem-v7-0-7438691d9ef7@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGir2WcC/0XMQQrCMBBA0auUrE1JUtq0rryHiIzNxA4kTZkEU
 UrvbnDj8i3+30VGJszi3OyC8UWZ0lphT42YF1ifKMlVC6NMrzo9ypI2mrMsH5ZbgOITxzuliFF
 qqxVoa1E7L2q/MXp6/97XW7XnFGVZGOF/1J0yRvVmaoehH6dBaulgJQwthIjk4DKnEOCRGNo5R
 XEcX+f/b5+yAAAA
X-Change-ID: 20250318-topics-tyr-platform_iomem-1710a177e1df
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Fiona Behrens <me@kloenk.dev>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2
X-ZohoMailClient: External

Changes in v7:

- Rebased on top of rust-next
- Fixed a few Clippy lints
- Fixed typos (Thanks Daniel!)
- "struct Flags" now contains a usize (thanks Daniel)
- Fixed "Doc list without indentation" warning (thanks, Guangbo)

Thanks, Fiona {
- Removed RequestFn, as all functions simply used request_region and RequestFn
  had issues. Only request_region() is exposed now.
- Gated iomem_resource on CONFIG_HAS_IOMEM
- Require that the name argument be 'static
}

- Correctly check for IORESOURCE_MEM_NONPOSTED. We now call ioremap_np if that
  is set (thanks, Lina!)
- Remove #[dead_code] attribute from ExclusiveIoMem::region.

Changes in v6:

- Added Fiona as co-developer in the first patch, as I merged part of her code
from the LED driver series (thanks, Fiona)

- (Fiona) added the ResourceSize type, thereby fixing the u32 vs u64 issues
  pointed out by Christian

- Moved the request_region, release_region and friends to resource.rs

- Added the Region type. This type represents a resource returned by
  `request_region` and friends. It is also owned, representing the fact
  that the region remains marked as busy until release_region is called on
  drop. (Thanks Alice, for pointing out this pattern)

- Rewrote the IoMem abstraction to implement a separate type for exclusive
  access to an underlying region. I really disliked the `EXCLUSIVE` const
  generic, as it was definitely not ergonomic, i.e.:

  `IoMem<0, false>`

  ...doesn't really say much. In fact, I believe that boolean parameters
  hurt readability in general.

  This new approach lets users build either regular IoMem's, which basically
  call ioremap under the covers, and ExclusiveIoMem's , which also call request_region
  via the Region type.

- Added access to the ioresource_port and ioresource_mem globals.

Link to v5: https://lore.kernel.org/rust-for-linux/20250116125632.65017-1-daniel.almeida@collabora.com/

Changes in v5:

- resend v5, as the r4l list was not cc'd
- use srctree where applicable in the docs (Alice)
- Remove 'mut' in Resource::from_ptr() (Alice)
- Add 'invariants' section for Resource (Alice)
- Fix typos in mem.rs (Alice)
- Turn 'exclusive' into a const generic (Alice)
- Fix example in platform.rs (Alice)
- Rework the resource.is_null() check (Alice)
- Refactor IoMem::new() to return DevRes<IoMem> directly (Danilo)

link to v4: https://lore.kernel.org/rust-for-linux/20250109133057.243751-1-daniel.almeida@collabora.com/

Changes in v4:

- Rebased on top of driver-core-next
- Split series in multiple patches (Danilo)
- Move IoMem and Resource into its own files (Danilo)
- Fix a missing "if exclusive {...}" check (Danilo)
- Fixed the example, since it was using the old API (Danilo)
- Use Opaque in `Resource`, instead of NonNull and PhantomData (Boqun)
- Highlight that non-exclusive access to the iomem might be required in some cases
- Fixed the safety comment in IoMem::deref()

Link to v3: https://lore.kernel.org/rust-for-linux/20241211-topic-panthor-rs-platform_io_support-v3-1-08ba707e5e3b@collabora.com/

Changes in v3:
- Rebased on top of v5 for the PCI/Platform abstractions
- platform_get_resource is now called only once when calling ioremap
- Introduced a platform::Resource type, which is bound to the lifetime of the
 platform Device
- Allow retrieving resources from the platform device either by index or
 name
- Make request_mem_region() optional
- Use resource.name() in request_mem_region
- Reword the example to remove an unaligned, out-of-bounds offset
- Update the safety requirements of platform::IoMem

Changes in v2:
- reworked the commit message
- added missing request_mem_region call (Thanks Alice, Danilo)
- IoMem::new() now takes the platform::Device, the resource number and
 the name, instead of an address and a size (thanks, Danilo)
- Added a new example for both sized and unsized versions of IoMem.
- Compiled the examples using kunit.py (thanks for the tip, Alice!)
- Removed instances of `foo as _`. All `as` casts now spell out the actual
 type.
- Now compiling with CLIPPY=1 (I realized I had forgotten, sorry)
- Rebased on top of rust-next to check for any warnings given the new
 unsafe lints.

Daniel Almeida (3):
  rust: io: add resource abstraction
  rust: io: mem: add a generic iomem abstraction
  rust: platform: allow ioremap of platform resources

 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/io.c               |  36 +++++
 rust/kernel/io.rs               |   3 +
 rust/kernel/io/mem.rs           | 125 ++++++++++++++++
 rust/kernel/io/resource.rs      | 252 ++++++++++++++++++++++++++++++++
 rust/kernel/platform.rs         | 123 +++++++++++++++-
 6 files changed, 539 insertions(+), 1 deletion(-)
 create mode 100644 rust/kernel/io/mem.rs
 create mode 100644 rust/kernel/io/resource.rs

--
2.48.0

---
Daniel Almeida (3):
      rust: io: add resource abstraction
      rust: io: mem: add a generic iomem abstraction
      rust: platform: allow ioremap of platform resources

 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/io.c               |  41 ++++++++
 rust/kernel/io.rs               |   3 +
 rust/kernel/io/mem.rs           | 141 +++++++++++++++++++++++++
 rust/kernel/io/resource.rs      | 222 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/platform.rs         | 123 +++++++++++++++++++++-
 6 files changed, 530 insertions(+), 1 deletion(-)
---
base-commit: cf25bc61f8aecad9b0c45fe32697e35ea4b13378
change-id: 20250318-topics-tyr-platform_iomem-1710a177e1df

Best regards,
-- 
Daniel Almeida <daniel.almeida@collabora.com>


