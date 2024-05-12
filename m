Return-Path: <linux-kernel+bounces-176972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 897298C3802
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 20:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB3731C20C2C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 18:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDD0524DF;
	Sun, 12 May 2024 18:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="g4BXX3PX"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BD24436B
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 18:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715539129; cv=none; b=P2SYJ4ti0WQ6kDY242/I7Jy58cJDlN3CYOq6yIz+Aui09HV+VkmtvrwL+7V+WMrBt4P4iiwpic4Xffx7EmO0xooeorH5SlrDQEA9kd7N6XKlaaiCV+AYtHspcVQNkEGNsj9jfmDWSZcjLZpwSruFLIbJg5f9jXuHO72jqEn3rnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715539129; c=relaxed/simple;
	bh=X8aQjTXaTz7wY1WVgxn6ivryyj3AJO/0J1TeXIhDaVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U49kdra9btwvT6+4vUULFV2tZpnrEC65VUV+hvhhpdgzBlviGr3lYYQohITTxM+46sLvZ+aiwryiws4N68pWOF8XbS9KXjzQw0BNmlad/xLb2JlRYOJ40fr7SCLh9DAlM5qvuw03FANLf0plzB6SCpgZWNta7+UHdy95uKivcrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=g4BXX3PX; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-6001399f22bso2427525a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 11:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1715539127; x=1716143927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WquW2eXLvuryeDWwo3x+NpX21TqfTU55S+tN12tCkFw=;
        b=g4BXX3PXyyECLds67bS2H6WXeR/UfrNFHW/SSPh1WHPhmEPD3qKbfqx1Ynhme/N72E
         pQ0Qh02btSKKdDCnpbdJ9gR0N6LjqobQWe7OBBEGS2bsKlH5YN3lznuXtk8RBgWzOqci
         SMzfvP4jXW0dKuJ1zFxT6ZP633oH6wi7Z7YZm5ULO9JOk0qhWiV0XWC3qNN1PVejrATs
         VLwdbHN+ejVh/oXBMnixyP50w5M8hIKWPKAgOfhGVhn60LSadL0RkLVWeZTIOT3P6lID
         qi45dPtVJykNqzGFk/W1O4XIoGm1A1vh5FQcqcEBXuNuZuCiyQJ/RWyEY1dSIfaU1zIL
         2Zdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715539127; x=1716143927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WquW2eXLvuryeDWwo3x+NpX21TqfTU55S+tN12tCkFw=;
        b=gGVwHHKVf9MNb8ovLyZ4o+XDiKHX8ozBH0R8UL4lqNLhBqY5FBbW66M6ZNwafV2a/f
         sVUyUnqkTMlUy/G6Hy9Bt7gJqXZ5rw9l/lSczOaV+FnuotHPFggzD4/7a6dpGXzut9i5
         qqP4+u52+fcAtKQpwFrwYUxRIKE4aBoEVbewKUPaCIJoVdSZAni/FdlQ2oMS/gIOZoeB
         zW2gIgRNr79Er/DK/DhgL0Zl89tpOYCwZtwYDc6Nr6mOdASNSlSLJRReMc03j6WAPnuZ
         3rBG/rRjyU1Saz5tMhWSnJXQ4DKMesKkE6VCbieQb3MnEi3e3wl0dME8KLv6poQhSySq
         tfYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZgOBKShLfoqo2MpX7E8wDmRbL3cdsXUaa8ISz4fP7WfQhcNc4+qMxOBD3VHjJdMR6mT8h2E5tuJJUJkU7a+BHtspX9TqP9dfk0Xt8
X-Gm-Message-State: AOJu0YxX6plRVFLphLVSnrTTNaXiBgOriCb2XFTVt5PP6cksZEe2reb1
	B1f4g1xwdZd//oNQF9clDAamn01wGMdGrnJZCbDVHQE0Mt0zqID50fKXJ6s//es=
X-Google-Smtp-Source: AGHT+IH/CCntDThEMQQPIkw803QnM6CB5WijcOgjbfKOhlQqjrhZ/zTwXG5H6FepkU1HrUZVWQLPDQ==
X-Received: by 2002:a17:902:7287:b0:1e4:c959:2b65 with SMTP id d9443c01a7336-1ef43e28484mr75605185ad.41.1715539126701;
        Sun, 12 May 2024 11:38:46 -0700 (PDT)
Received: from localhost ([50.204.89.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d1807sm64897775ad.59.2024.05.12.11.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 11:38:46 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
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
Subject: [PATCH 3/3] MAINTAINERS: add entry for Rust block device driver API
Date: Sun, 12 May 2024 12:39:48 -0600
Message-ID: <20240512183950.1982353-4-nmi@metaspace.dk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240512183950.1982353-1-nmi@metaspace.dk>
References: <20240512183950.1982353-1-nmi@metaspace.dk>
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
index aea47e04c3a5..eec752f09d43 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3657,6 +3657,20 @@ F:	include/linux/blk*
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
2.44.0


