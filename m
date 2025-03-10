Return-Path: <linux-kernel+bounces-554596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2330DA59A51
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D31123A857F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701B522DFA3;
	Mon, 10 Mar 2025 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHwSknM8"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A4D1B3934
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621693; cv=none; b=nOvl+YOpdoMdYqn60y7WaBYMYqFa0soGjdjEAdOUPpNFRs9wwNuNyWeGOPB7a3p+iRFslObQhOZ7VI0stCp+IqszC0j13F6aQl8TpVY7sx6pBxxGPdhBPnGaRdYBc6XmbuvJXuElFOdRVPJu8SrBG4HtR8M7DJPaHWX9PqTHDUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621693; c=relaxed/simple;
	bh=Woyd6cwlYnVSa+FqrjshUFyqUsRjd+mixdqKOPmf9/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=efqSBWfr6FlHybBUTQlJYEOlvvLhOfLLQt6S6y+rBL0Jfl3AXu8B7ChNObYMB2Nns5UaPGZ+qaHrgvuy1wzF+WgMlPz1ZVBQNLdnsoSrn5SDxe/DNWrmqRBN1flGIw9ScG+X7tn/f3cWno4ZzP5OgxV0uyofYh7fHA2D9bEgD/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHwSknM8; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e6194e9d2cso4202929a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741621690; x=1742226490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gb9YTtOFAm/FqpNdq7Y8O46PSoOJEuyHCxcs4+ZGf0A=;
        b=UHwSknM8i6Oh0eHPYebydEJNCXPpC8In1fqlpJjJqgUfZx43KUgkh7GTeoD8AXFWUb
         oyIaWBeVOq3Tgz/FHoBGnB3/GRl3c7ieA0Sxw7c4LPqhDKVo/G9q3gWv9+rCFFSP9csF
         V/qzFc0+orfEH+YaubAaWoTUZZqoblLIBNuENNqLYI8rYjdL39pJ5GA9p4/PnhW1M820
         bvLw/+DgX9YzLfJC7tGOftmBECoMc7/1XS1U92CFJFG1ydHcP3PS1Epz5HC7SETRYkg5
         R489qruVd0nG0yY9o94dacZKGjB74vT4Q0jKbU+wBHbyclOfpC/hSCsNBen+EqHq6xKx
         H9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741621690; x=1742226490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gb9YTtOFAm/FqpNdq7Y8O46PSoOJEuyHCxcs4+ZGf0A=;
        b=FlEuOdfX56flK82dTIKA6kp4R6OquKtdCKhduYAOJvpdCU8Dx1VUYqsEOBDEeyOPo9
         2w/mlLfAKCVlNUhcMnmkGcLrTts+tXFYLn2BV+LEbgJ0/jNvjlq32wG6//vNwuOAtOCN
         Wskh0ojnJTPyFAdE1Fi4Yo+/lGPowUs1ttsnTYEmsk36tsuXb172GaIV33sxKvNqVwXX
         OWGhYWYqX1DtobRC4fySns57Wgyt/35x+L/v3VzKJjQddajQCcSwsu6zr5dNvW1bture
         2y7ThGixnXcDMGK6xI6TvAy+4TPsgM9Vo10Jx+pL1f/IrTgsEq1MiT+OvEdtWS3d/04V
         xWkg==
X-Forwarded-Encrypted: i=1; AJvYcCWNbeI39D3NZ1xIT8Suxha+a1+d3DmOBk+MtFpkWenffUIcKrgPEKs1bkUuhiKvznqcXZB/pTexClDDIG8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn9wifpMyGN19uq9DyoniBqT29lZlEj71CcILkA+sT2PlFz31V
	SZWXHoBaStviHV1FqLpI5WH2X9bXS40MztxUXOotReYmmfBa7LlrQ97I1YL3
X-Gm-Gg: ASbGnct64kp026Crz9p2kzTZfW/XIweM4MWUDJvu7vFFXEVZUCK8XizQh+iWP71n6xh
	K2jdDfKCGDGDAiBmNRa3o+36xR/WlKCVSnDh2XebsNtmA5tlT2KRJoTPGhkhY4Ao05MCHgPJcdX
	R8zsqbRA6tEG75sDj3zQcqsPjuJUfQ3KglYAQHAxljBNj4kGas8stnghKUzJ3X4cgtYAqDE5omB
	4DM13Xe4vGgusmO1CsSKUqsbrfZsIYjB6YHr2VOc9hnwLaVQf8cSgY9rPPPt6qEQpAf6n7GPjC/
	IGe0jihTKto3uoxXqhzoA2CqXk6qUV9OLYsv0YyyTRL61uSU
X-Google-Smtp-Source: AGHT+IGyw6AQGkjc2jebHM4lByuGKDkkEVQDtRJGde5IyYGTscEm2nVhMxWrSHqh9lOui6VXO4XqfQ==
X-Received: by 2002:a05:6402:42c4:b0:5e4:9348:72d4 with SMTP id 4fb4d7f45d1cf-5e5e24dd5b5mr16873389a12.24.1741621690284;
        Mon, 10 Mar 2025 08:48:10 -0700 (PDT)
Received: from wslxew242.. ([188.193.103.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c766d0e0sm7252732a12.64.2025.03.10.08.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:48:09 -0700 (PDT)
From: =?UTF-8?q?Goran=20Ra=C4=91enovi=C4=87?= <goran.radni@gmail.com>
To: 
Cc: =?UTF-8?q?Goran=20Ra=C4=91enovi=C4=87?= <gradenovic@ultratronik.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] MAINTAINERS: Add maintainers for Ultratronik SoC Boards
Date: Mon, 10 Mar 2025 16:47:59 +0100
Message-ID: <20250310154804.326943-3-goran.radni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250310154804.326943-1-goran.radni@gmail.com>
References: <20250310154804.326943-1-goran.radni@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Goran Rađenović <gradenovic@ultratronik.de>

Add maintainers for Ultratronik SBC STM32MP1 board.

Signed-off-by: Goran Rađenović <gradenovic@ultratronik.de>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ca11a553d412..0a16b9e03e30 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24312,6 +24312,12 @@ S:	Maintained
 F:	drivers/usb/common/ulpi.c
 F:	include/linux/ulpi/
 
+ULTRATRONIK BOARD SUPPORT
+M:	Goran Rađenović <gradenovic@ultratronik.de>
+M:	Börge Strümpfel <bstruempfel@ultratronik.de>
+S:	Maintained
+F:	arch/arm/boot/dts/st/stm32mp157c-ultra-fly-sbc.dts
+
 UNICODE SUBSYSTEM
 M:	Gabriel Krisman Bertazi <krisman@kernel.org>
 L:	linux-fsdevel@vger.kernel.org
-- 
2.43.0


