Return-Path: <linux-kernel+bounces-331218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4A297A9DC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 02:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35EBF1F2711F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 00:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1822595;
	Tue, 17 Sep 2024 00:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CAy8Ja/X"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C00137B
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 00:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726531867; cv=none; b=iodZQEePNA0JK0jTLnjyv77t0DqiG4nVZpeTIKvL7nwYgZuQErBmtcAR6AJRIYxypeX/yrYAhOL3HXY++Pc5fMaqlEhhgS5AAWS4hpAPZiRX5nnsM8ywk9oBWDylKUcuzSJV8MVW+f38e4UfZj5aywzNuQpMiP4TAK5ptfgHhW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726531867; c=relaxed/simple;
	bh=hU5iLxSH47Q+dO7j9wFD3aK57rS6msnzhfZQwB1PLck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hJBi5MmRnvcnkTSuFSzMLAqPWdwciGhGMn0iKZv38w4c9KYSJjA10va2tCF9gj5Uxe1SZvJdc1wS9KxYmilHLJjTUTSVGjGWJ2U3yIH8J7W4l4942NVVdtk4J9C+sEF65Z74X4Z5pqw7SmEvjWH7Cx0uH3EyUBFP5iON/CMxmSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CAy8Ja/X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726531863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Tmm8QBHX9hBz4OCA1JEiQcNTP6WIrwV8Na168B9eMdQ=;
	b=CAy8Ja/XhITSS9CdopBZ5HCQv8+jgKWPOq6xt3t0jmgyZnIFQnqArbGEv5VNrtKw+yIhVG
	9kyONXTQBOtFly8CAkmf3jFWZ6tKHtgX6QG/5rMNbNmpWqci8QR18yh8Y1V6Ea6fKw2TM8
	6emqSBu9BEQdqeQBZH40gzZyrO/qbmM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-hWgEn81ZPEG39J6LVYsXvA-1; Mon, 16 Sep 2024 20:11:02 -0400
X-MC-Unique: hWgEn81ZPEG39J6LVYsXvA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-45856a29545so98554111cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 17:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726531862; x=1727136662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tmm8QBHX9hBz4OCA1JEiQcNTP6WIrwV8Na168B9eMdQ=;
        b=Ag+9QntYmQk0SvgMzo2mtdaWEKald//xn8bUQlYiIJjxqko1DEjKtvtQ92uv52Kxj2
         3qaKR/AU0Hn1v5xjcxaSgCItDhoq7nWTG+UBYRexIR7EHxyKblyiO88Alrw8SJF4pSZ/
         fryAvoV4E5Cvq86gQU3ewcCBC8Pq1wYuhPXW9M284T6XPDbLRjh8Iwfwobia/1orisbQ
         /9hSDQ7NCAO211SI5CPJetZTjPuwfTE/2DooX0PGtmr9FQ2cpDxqSeacJZATCKa/gxfF
         0l/wuQ+xmpersN4qMHxDpke//6n+UeAXAjc7lM3fdq/Bo4tc8wdoXc8Z8ZuV/Ur4YNCR
         XsGg==
X-Forwarded-Encrypted: i=1; AJvYcCUfBDuFINDAQZLG974VkGZ2rRSJ2+E3aRlOh098EtlUNCFKMIEE0iQkO+viOWOTjKx1whicJWvgU5hBD/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY27rnWR7YIpdseozomJlVKuEI3Bhen68JcXGl04ocQBvsk/R3
	xTadp64NKsRnD/MUPDPWLZcSEr/eXwTTfP0j6/T9FApJSWgMU7qcHSkL2vLX3MkHFwMwSx0DHEP
	rqRDxJ4zfNKG3gyEkiqG9SNwSFxD1xSMtdHi+NrzbUQoLAT+NKnyGSaEU5XmyLw==
X-Received: by 2002:a05:622a:53cf:b0:458:42aa:9853 with SMTP id d75a77b69052e-4599d2393f1mr205215041cf.23.1726531862048;
        Mon, 16 Sep 2024 17:11:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPpDTLWSZw+zeRZnpq/bYJ/50ETGEyIM5xiGEn5/ULUALhOfBRgLa1LxUZ/Zwgxif9zNnwBA==
X-Received: by 2002:a05:622a:53cf:b0:458:42aa:9853 with SMTP id d75a77b69052e-4599d2393f1mr205214611cf.23.1726531861627;
        Mon, 16 Sep 2024 17:11:01 -0700 (PDT)
Received: from towerofpower.montleon.net (syn-066-026-073-226.res.spectrum.com. [66.26.73.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c58c62633bsm29221956d6.25.2024.09.16.17.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 17:11:01 -0700 (PDT)
From: Jason Montleon <jmontleo@redhat.com>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev,
	Jason Montleon <jmontleo@redhat.com>
Subject: [PATCH 0/1] RISC-V: Fix building rust when using GCC toolchain 
Date: Mon, 16 Sep 2024 20:08:47 -0400
Message-ID: <20240917000848.720765-1-jmontleo@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following patch resolves errors encountered while building on RISC-V
using the gcc toolchain with RUST_CONFIG=y

Jason Montleon (1):
  RISC-V: Fix building rust when using GCC toolchain

 rust/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


base-commit: ad060dbbcfcfcba624ef1a75e1d71365a98b86d8
-- 
2.46.0


