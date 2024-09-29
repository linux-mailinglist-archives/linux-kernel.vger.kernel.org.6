Return-Path: <linux-kernel+bounces-342999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6E19895B8
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 15:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE0B1C20BBC
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 13:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988C917BB07;
	Sun, 29 Sep 2024 13:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/M37Bsd"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916A2166F3D;
	Sun, 29 Sep 2024 13:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727617166; cv=none; b=Lt9LZiUtudmsGs1wCKfvhDeMIeXzWtMOcwGBDBuSGc6UnNHw3/Jnpq9YiB2Pi7+MY0ur1XAtLTYY2Q6533nQLjXJ3k69EibFW9EKJbszvqSQ/wvcctb2tHfEQ49WYUXeHnExWux1jKpyl5tkG7cypM4awvBkJG7kCjY3X7bqJKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727617166; c=relaxed/simple;
	bh=uaSO7ckDMtFc4pXP6YriPegXGMuWJMzvuEi5DJM/9xg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=oXXxfShH80zlK0ep5+cbkCPk1a4A58OF6WbmqY4z4EBG6w+hiLWSgnX8c6rq67gtRtTU8nVrAxvA8lOM6hMEoFO3qKAGWPtVpsrQicB0AJoF5nD2azyZ+DKRxwOOY2hCg57S0o6H+9kpC2x+6yzOwpqMNx/l5MXtTit1ebOVk1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/M37Bsd; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4585e25f42bso37578671cf.2;
        Sun, 29 Sep 2024 06:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727617163; x=1728221963; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p7++xq5p4wh9ASglxW3dSL3G5J/U3R+n79SJr6cjhqI=;
        b=Z/M37Bsd6ibclVD3R76fYsNlfpfjzCpXhWbxfnrsie0k4rcguN5qoRkXWXPFjJmrOv
         80USbvNWmpZYFeqMip8PyeWbkvHKH2mfVYuRCvfq+V/stspjTLjSnLnm84HiUN7Ahylz
         fQE3chu7lXaIQfm7aawlAImIjijGipwz7r+7XWbdjDuqsLmJhxNGtFNdCQhxB4kg9kmr
         QocSSufaB1v6gkH9IpRJftKboBUBLOix1Yn1+1Hva5RU5jcDXiwu0Qj9FoG71RXVSe83
         WITUPd2d8ily5IXbdwUuB90lkEjdIMrNYMPiERkwdVV3OHKPpWt3GKAUbnIzsoA/k/QI
         4+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727617163; x=1728221963;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p7++xq5p4wh9ASglxW3dSL3G5J/U3R+n79SJr6cjhqI=;
        b=d+xQP3b/2RDTUN9Iq3VeiPfDbJ74Jp8yDFGds2cdsRIDU/VhopXgZt0Zyk/+zS1ikA
         EgKzEzrdWn8oVInM/TCuAA5wjIYKfdwUGrOwgblufAxnxAEDrZEh2yNWuJL8/3h6xSC8
         h7/k5ENfhWM84rciNyEjnywBykyPYQWwUFgNYuY7/ZNRGugH+TZu7Wra3GM2qoMKwNdF
         VmQAoIMHlhhq6FnlEwPRQY/Hle0fDMrcWTYBUMXTYgSLAeN6kCu3hJSfakqyZ67qRl6i
         cGCtSDlhjjFrRcLwZ+32Wn/mjGKynP5XT0uZ6cpQgM5pDDJiyHNZ1KpG1d/nERb5rOAX
         tojQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqxs8a+5HvW8GiYEeim3B0iyXLOxMQpJ+Wadkk7Nc2J2KSOGrXifJK/m6wptY/jNoWwjM+8PcRVzQ2a5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkJk3sTxNjg5P6zIZDsAuOA8Mnwc8M1rH7xo2J517Bx+DkDx9X
	xyUdemZhy/w18TKfwRigWrQTVZidUdI07EFyznamE+msO8cUBlYWuR0p2eCU0WYRoEcZCinscgs
	/Mn7tfnQ+OJ+gYVCyzgGgYGGrHMU=
X-Google-Smtp-Source: AGHT+IFEfxKze9Slz0WhXyjFl1wqB05CgCt2uTtdWiRilZmu+NEwmt+rRZHtM1SON8q99zI0JxWQIjZBkhsWh8eiCao=
X-Received: by 2002:a05:622a:18a2:b0:458:2523:c060 with SMTP id
 d75a77b69052e-45c9f230216mr158254861cf.29.1727617163495; Sun, 29 Sep 2024
 06:39:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Guilherme_Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>
Date: Sun, 29 Sep 2024 10:38:47 -0300
Message-ID: <CAM_RzfbQK5fzqXQN89JCEzD1Bz5ZtQdAz3xD0yaYFx_GC7Pm0Q@mail.gmail.com>
Subject: [PATCH 2/2] device: rust: change the name function
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, aliceryhl@google.com, 
	mcgrof@kernel.org, russ.weight@linux.dev, dakr@redhat.com, 
	a.hindborg@kernel.org
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Guilherme_Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>
Content-Type: text/plain; charset="UTF-8"

This function increments the refcount by this command
"bindings::get_device(prt)"
This can be confused because the function Arc::from_raw() from
standard library, doesn't
increment the refcount.
Then, this function "Device::from_raw()" will be renamed for don't
make confusion
in the future.

Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
---
 rust/kernel/device.rs   | 2 +-
 rust/kernel/firmware.rs | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 851018eef885..ecffaff041e0 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -51,7 +51,7 @@ impl Device {
     ///
     /// It must also be ensured that `bindings::device::release` can
be called from any thread.
     /// While not officially documented, this should be the case for
any `struct device`.
-    pub unsafe fn from_raw(ptr: *mut bindings::device) -> ARef<Self> {
+    pub unsafe fn get_device(ptr: *mut bindings::device) -> ARef<Self> {
         // SAFETY: By the safety requirements, ptr is valid.
         // Initially increase the reference count by one to
compensate for the final decrement once
         // this newly created `ARef<Device>` instance is dropped.
diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index dee5b4b18aec..13a374a5cdb7 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -44,7 +44,7 @@ fn request_nowarn() -> Self {
 ///
 /// # fn no_run() -> Result<(), Error> {
 /// # // SAFETY: *NOT* safe, just for the example to get an
`ARef<Device>` instance
-/// # let dev = unsafe { Device::from_raw(core::ptr::null_mut()) };
+/// # let dev = unsafe { Device::get_device(core::ptr::null_mut()) };
 ///
 /// let fw = Firmware::request(c_str!("path/to/firmware.bin"), &dev)?;
 /// let blob = fw.data();
-- 
2.46.1

