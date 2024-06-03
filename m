Return-Path: <linux-kernel+bounces-199631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C20788D89CE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D28228A978
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8816513D254;
	Mon,  3 Jun 2024 19:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="u9IrdIrV"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0241D13CAA5
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 19:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717442115; cv=none; b=QEz5aQZa8AdYk3p9aFEy3d56YNClTLB0BLoXUVFTkmym0EoxoMNhBLoNVJuihJzXzVtCpjZh4QBBpG++TqTCe+0g7aPyc0F7sqrClFjmUFF7hR22Cm9Npgu2ZUMMcpCnh92nCKm0wgTP1BgAWHoIiX99Xt6kpAyLqY56LM8ROgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717442115; c=relaxed/simple;
	bh=juRogTLPO2qs3UM+cO6uXQ3Ufimi9V6rXzS1gdbXpLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egNdsBAQrBWkQAYUsGcFb/i2PR3dmvkAtHWti5VLZ9K53o1boLZlxC2yI+njcUeQAs3KCLYh22fd6ugsqDBcTzYHD+BWmnpRZInyGBifLaPJWivTzb841rYSuUacLnImr7H7Ers/uWhWPefB/sR4V5TfjKeUJQkLqHOf+h8rsLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=u9IrdIrV; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57a44c2ce80so2711740a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 12:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1717442111; x=1718046911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDSrS2M7i0BNRPCtONpXbPIlnKGYcwSP27wPNDFPtFI=;
        b=u9IrdIrV7smepPLqH8l303XnRV9EvSo3sNSt+9cNOVkSAnLD8IJxfz05mf1Juui6ju
         PAF2fNkuz4CXndWza9BpIwUINbMfANbsqRWidBgD6XTYbyJuAE4745WKgeVKa+QYiEOB
         4IxcAS2Tpq/7tAT/omX9uo4O2zh9CZaYRodXPJEVF+CeMH2jL1O8XZO0RGWdkPXkZIqt
         T6YaA098KHEgzR22bxw4o8jd7ibP8DByAPajhjyKN9XrZ8pHP9N5v+I9cNxg/Md5rqbN
         WieuaInmqpdRU9U16lGEImeAatGc5Ao0+sAmoswLbKzld61My3BN/rLYdC2GMhzusihV
         pAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717442111; x=1718046911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDSrS2M7i0BNRPCtONpXbPIlnKGYcwSP27wPNDFPtFI=;
        b=F2Y6S0IC3LU0jIIbnJ2bv1i5Q3TfcDhW/K/TnILbsBIe9UfJi0PLShTyxwCuzxnVab
         QdiU1wkICM34eyykYFHFfGNsimKHkQ80XMeIzqJcRofad40BerBnZ+nLWYK0l3sQkNYT
         xr7C4AX9KpvLuE9wn/QjOBaqbniV7buFDIqiT5fHzijmwsRYc73NP/+bqa94DOi7knzY
         SeEmnz6QAWW6PXwifrdCvyHsLzUzhAKdkglsTwwlmfpdV2z71YXCEjRFnTjLJp6Cplag
         d+0sMz3fZdUyYNBrwzADcTyrXhhQ0wS+URrDLGotkljzZYtfXtGEE3O2ZPLIo5eYh/Vs
         v28g==
X-Forwarded-Encrypted: i=1; AJvYcCVMsgfDtS+v0mc2J2TicvtA5i/5utosbK8CP2NAG3ekkyTHsw5WoVou5us8mgzrndbGfwIflRkLFZ3LZgz00E2/kbA/3s467POCvvTK
X-Gm-Message-State: AOJu0YyQb2OIwbxrZJ98LNvMWMFCND+BV/5d/ssYkJHhuxzGnE8CoV/I
	hSBW/iB5sKGoBocnyuL4jInGQ/haxB26+8Gs7AxAWwWWOLgApGihpObvreC0mbo=
X-Google-Smtp-Source: AGHT+IEIe0DVsYmJPScMiomtpDfWdZZhVOCyF8cqTfzaZhruhdjXi0NCVul3W26F1naNI0AuycktXw==
X-Received: by 2002:a50:d7dc:0:b0:57a:2158:bbef with SMTP id 4fb4d7f45d1cf-57a3635558cmr6349251a12.8.1717442111367;
        Mon, 03 Jun 2024 12:15:11 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31b9943asm5809571a12.14.2024.06.03.12.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 12:15:11 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Andreas Hindborg <a.hindborg@samsung.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yexuan Yang <1182282462@bupt.edu.cn>,
	=?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>,
	Joel Granados <j.granados@samsung.com>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Niklas Cassel <Niklas.Cassel@wdc.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Conor Dooley <conor@kernel.org>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	=?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>,
	open list <linux-kernel@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: [PATCH v5 3/3] MAINTAINERS: add entry for Rust block device driver API
Date: Mon,  3 Jun 2024 21:14:55 +0200
Message-ID: <20240603191455.968301-4-nmi@metaspace.dk>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603191455.968301-1-nmi@metaspace.dk>
References: <20240603191455.968301-1-nmi@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andreas Hindborg <a.hindborg@samsung.com>

Add an entry for the Rust block device driver abstractions.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6c90161c7bf..698515b0b0b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3782,6 +3782,20 @@ F:	include/linux/blk*
 F:	kernel/trace/blktrace.c
 F:	lib/sbitmap.c
 
+BLOCK LAYER DEVICE DRIVER API [RUST]
+M:	Andreas Hindborg <a.hindborg@samsung.com>
+R:	Boqun Feng <boqun.feng@gmail.com>
+L:	linux-block@vger.kernel.org
+L:	rust-for-linux@vger.kernel.org
+S:	Supported
+W:	https://rust-for-linux.com
+B:	https://github.com/Rust-for-Linux/linux/issues
+C:	https://rust-for-linux.zulipchat.com/#narrow/stream/Block
+T:	git https://github.com/Rust-for-Linux/linux.git rust-block-next
+F:	drivers/block/rnull.rs
+F:	rust/kernel/block.rs
+F:	rust/kernel/block/
+
 BLOCK2MTD DRIVER
 M:	Joern Engel <joern@lazybastard.org>
 L:	linux-mtd@lists.infradead.org
-- 
2.45.1


