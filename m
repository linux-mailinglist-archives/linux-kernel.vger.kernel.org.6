Return-Path: <linux-kernel+bounces-353752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB136993218
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2749A280C08
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDB11DA60F;
	Mon,  7 Oct 2024 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=timo.grautstueck@web.de header.b="YuLSiBzB"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82EC1D14E3;
	Mon,  7 Oct 2024 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316508; cv=none; b=IPzMb4f3/xgXG8bn029dA3KMaBH46ZuufNU2mmRcZSSYGNmqVikfcjUfTfrTI2PNVSUOUdK3xxSnOrTE48SSOnLxajLUvLScsFPH3V+Ij2L0SvROizD5dgbjA17l2STlkpQIzscf18J/KDMrh2bkicbvdmJ9n3DYSUvnSfu2Z34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316508; c=relaxed/simple;
	bh=01cY3E7WMjbmgRpn35G0Wsg5xsXMcmTXUoC9DpxF3DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZ2STT3Y8V9Pnqev/gbModjdOFNF2CQIcusQJXSNc93UVvPqRa8wH1UCUrKTbKRaGMhA9qNX8Vqwstm+0KQKANrL40XvfXKeyR6AcCMEyNnWMXyoFQISESvx0LmgH3aks23TokEzfoN6GDc33N0mF/P7E2vzu2PvGZJhMaMhToU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=timo.grautstueck@web.de header.b=YuLSiBzB; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728316496; x=1728921296; i=timo.grautstueck@web.de;
	bh=tZyMhH5kp7QMFFRMcSTA1VhW+Z5ZM7Gk0Y6yV2wQRWY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YuLSiBzBM2oFmPTScD5Okvbju+TUytW4UMTeu5VGyxjkgzzDY7kno38LQhh4S/jY
	 +JpKXU0ZT+J062EkbRE+A70LEkeUGeT+OP5eUt6PbbcpaDCtHZRAdt/bIim7HwOxT
	 6cWq8Ks2AjwbnaqeQJrD/coXTS2/dKJv1tdCwoPDB/vfLc6MZfpuu2N8X1dqa4QM7
	 Yg2sr4UQVBhza5a1oTh0nd/W6NfRQ5KYIBUOFBq8WDLj1rmBhhs4p+XbnSJlA5O2K
	 ATsd5tn/1vi6jr1xL95W2cP0NFfxfHDTPximSYmH/suVlFlSvWWgMZBtMGhyolF2T
	 I8eaewXyfkuu7fq/rQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from fedora ([95.223.78.106]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MzkST-1ttXE10Oxd-00xIwa; Mon, 07
 Oct 2024 17:54:56 +0200
From: Timo Grautstueck <timo.grautstueck@web.de>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: miguel.ojeda.sandonis@gmail.com,
	Timo Grautstueck <timo.grautstueck@web.de>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH] rust: types: 'real-life' example for Either
Date: Mon,  7 Oct 2024 17:53:15 +0200
Message-ID: <20241007155315.1145503-1-timo.grautstueck@web.de>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <CANiq72n25iBCJtDV=XD2q5AEg4Awh9hyeKM0YwbeE0pv0H2hLA@mail.gmail.com>
References: <CANiq72n25iBCJtDV=XD2q5AEg4Awh9hyeKM0YwbeE0pv0H2hLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XM1gdjh2IJlIEGEMQVk7SqSl570Wb1a/u96g4D37eLnYEYkzgD4
 +S64nV7TQGlAP7jm25p4Oy8DHERs3Yu7H27ArkEXCh1wjgRTmt1mSiQsNNwFzaQYS+Fo4AK
 uW0Tq6TKPXEkbe/MemnUj8AqupzptKAcZLNEWD6wXnVNgrUGX57KzsCASj7BfddxYjBSFGr
 JABtgnBJIfmUsgVy2sNsA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3b2WYKAoh+E=;QzZEVu1dRtxxy9qCU+6Z7BjSweg
 CBl0r0QbZuXv6nfalKgCsuDt7iLjQzGMt8q0b9bEH/HwW3eQqth2bKnuXtx1t1Wer7iIkwXaj
 3kENZPh9i0ia6Z9931Dv7LX3LnYVjcCs00PQyP49/5Gbu3RamJVyNOdnEFVy2PmHnm4xHaT2l
 lMo/shT7gOOXT3q+35jRb0cfCfQMbyJFEATd0nLTeNWuOMKqcOmqEOjorSHVJ8Xcfi8leJJxl
 JY2+iC5R1yFdt0KcjGPbcVQPyYQYBT2ad3j1tMi7oVXdiFY2lJ9RXVYJG8XMkmrVt7V+6mjyO
 VqmsiihwMk2YBw1diDOiKO2wngBDb3DlSGoWCnTn+3gqc3dfMAHdyQsbxunQTt5cCEefZZf3z
 C4uX6SAHS9T0rV5F2IIhhprehRGJdaO7XfaMSEkH44N2Me85rHPfz9FCNIhHUxzl0mjGMWP3d
 F3c+/MKRXdMsAwarXGLD25qHtPoUGYsm4jDqDYiP4dKcCQ+QPXcNXLzPFj1c4f0siRoyqO0WY
 70v0PcT4O9M3eMQoeFNlGspSfRU2lqFJ7xy/retE2Hg+LrrSmE6wsMsQzZHvZpULTsyhsDh5r
 rm4VY9cM0HebuGNGKcGNw5y0jeiKo8KBKfQ1s2U5fV0Qn36d/EMnfZFTE89qPt+kFDxkrcaHM
 zPkqCA0Zaug2gBuSyVU5JRTI4yKAAJ8I/xkIo8ZC5WLPADLcAOJauoq+q9NTHmPFntzI2PgJc
 ceZ4Du2YY6By55txsBSL8FVGki2AgomKehHslJDtZ7FxiImRch9LmWffPYsEr+g7iz4WNqCi+
 ImKO4ahgDEgl8/hPrmXySDlg==

Added a 'real-life' example for the type `Either`. This example
uses a work queue and extends the first example in `workqueue.rs`
(commit ID: 15b286d) to demonstrate how to hold and distinguish
between two different data types.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1122
Signed-off-by: Timo Grautstueck <timo.grautstueck@web.de>
=2D--
 rust/kernel/types.rs | 54 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 5ea9126c8c93..a56192141a0c 100644
=2D-- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -322,6 +322,60 @@ pub const fn raw_get(this: *const Self) -> *mut T {
 /// let left_value: Either<i32, &str> =3D Either::Left(7);
 /// let right_value: Either<i32, &str> =3D Either::Right("right value");
 /// ```
+///
+/// The following example demonstrates how we can create a struct
+/// that uses `Either` to hold either an integer or a string.
+/// This struct will be scheduled on the workqueue, and when executed,
+/// we will perform different actions depending on whether it holds
+/// a `Left` value (integer) or a `Right` value (string).
+///
+/// ```
+/// use kernel::prelude::*;
+/// use kernel::sync::Arc;
+/// use kernel::types::Either;
+/// use kernel::workqueue::{self, new_work, Work, WorkItem};
+///
+/// #[pin_data]
+/// struct WorkStruct {
+///     value: Either<i32, &'static str>,
+///     #[pin]
+///     work: Work<WorkStruct>,
+/// }
+///
+/// impl_has_work! {
+///     impl HasWork<Self> for WorkStruct { self.work }
+/// }
+///
+/// impl WorkStruct {
+///     fn new(value: Either<i32, &'static str>) -> Result<Arc<Self>> {
+///         Arc::pin_init(pin_init!(WorkStruct {
+///             value,
+///             work <- new_work!("WorkStruct::work"),
+///         }), GFP_KERNEL)
+///     }
+/// }
+///
+/// impl WorkItem for WorkStruct {
+///     type Pointer =3D Arc<WorkStruct>;
+///
+///     fn run(this: Arc<WorkStruct>) {
+///         match &this.value {
+///             Either::Left(left_value) =3D> {
+///                 pr_info!("Left value: {}", left_value);
+///                 pr_info!("Left value times two: {}", left_value << 1)=
;
+///             }
+///             Either::Right(right_value) =3D> {
+///                 pr_info!("Right value: {}", right_value);
+///                 pr_info!("Length of right value: {}", right_value.len=
());
+///             }
+///         }
+///     }
+/// }
+///
+/// fn enqueue_work(work_item: Arc<WorkStruct>) {
+///     let _ =3D workqueue::system().enqueue(work_item);
+/// }
+/// ```
 pub enum Either<L, R> {
     /// Constructs an instance of [`Either`] containing a value of type `=
L`.
     Left(L),
=2D-
2.46.2


