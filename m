Return-Path: <linux-kernel+bounces-362704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4E999B845
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 07:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D06F2828AB
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 05:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBE012E1C2;
	Sun, 13 Oct 2024 05:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="AG+6D1mS"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECD218E20
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 05:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728796603; cv=none; b=rY0VSHugjrRrE0Y9lmRcih4lpjUaDIwqKoeLUjPLN0MO81V8SMzc5mgrCkuPqsS3XO4wMvJnLbTMj1K5k+PUwOt6rtWdbD8UltzfAq/LwaZ9wyJZvpLuqgmN00SwggEb9u1BOhmU3BaRpFeBzceW4aXRs2cyk8usdKh5/qShjbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728796603; c=relaxed/simple;
	bh=HU69t/U2R87EH0IIXRZwqe3pK8N1gmRLZwkGN9lyVKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fM3Nt5MdA8ytS7oP2uooh1LISMqz70pTS3LiBqQ3ttEXJSk3RFRDlBby8Ruf/YGJaNJj3A6zrhnWm0OwwodEZScxGhoX3cD4ZsyiqA3MZ3Q6HxpZwibJ/EshblEeVcLCgmabrQdyn6npANxWRPing9FWD4YrDSYZ8WhkBq4tZdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=AG+6D1mS; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7afc5925679so219898585a.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 22:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728796600; x=1729401400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/v6ZIW1ohWKzbazrFBWrOZgEehfeMTcOHMOxiyDbSBc=;
        b=AG+6D1mSYjKvrje/5Vg+bBJ1QinMk51ZI1T47dDRdiaIDyJsUGAjhTjymknIOcVmWm
         gOTXgeL/jZaukIlQ6/VOFYKxtTHCvUA9a6Q0oXScaWu1GbBIvVs17UjY8EB2Q4JUV2gs
         eAgYwcyeZpfbfgOSlzez16XhpNSOp90nYtTp0ss6LqmX2azc0QWbEpqVnFm0OHQXNZ3t
         vXx1gCfidMr3OEHySBuW7jFSR5sLn9phApQHBweIT6M7cPjk2wLrbrjKpXdt14N5lT49
         VczjJpvddTLn5zOT5IylztDiEMQA3wYG9cZpx+rgbgO09Tj4Carcqna8iVTiCY7x/gQw
         wgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728796600; x=1729401400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/v6ZIW1ohWKzbazrFBWrOZgEehfeMTcOHMOxiyDbSBc=;
        b=daJWtI4nsJ0NdQ+bPGpsBuwYgBUQjI8LGB6q7PKUZ92RVUvdUeAr8Z0rnAHvw+pfnV
         yGZrdxX/XNsLDW26D0b/rAUbgzF5zGNCKMEdlDSV+plvm7zFUjVcXQmZ3PZApRQAtTKq
         EubLrW6OXy9V/kE4ry4djWv6gwijfzWxUPZWqeNjDEW1tOZbwxgFODQgY0Wvg/5wmQzW
         wUr+kL8OwNM3TubNBHbcSW2+JxgcKDLq8D7xEdqtzI2gZt3yXgzXKJQQsr1BYtwdkhDI
         fdRF9NRKJ3FnDdKCJj6yZKseHPFGZ6Ls47s6UqePChmLI3tcOzJN1CfNevO2mT+ZjC4l
         p/Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUyPhh6PIfDPDKkIRuQuY/EC2951iZiYaBxSv/pN82AM4JVS+SX/c+UL7ZH8fTdo4oXxir+OalWYyk+LtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA2CsiBsj47JJblOAZg8MPrprWcmKAd9+EGDlraMO5AjPKdsXN
	IQy4YPo3CUIBdwgn1PeFt+UgRf49VLzwQkRXMwn8H0fe0ZcVZ1rkbL1xVyyHVMY=
X-Google-Smtp-Source: AGHT+IHyd20bRK+z5lKhwyfqeRnEsniX4BsP2zlFFtf4KsKYxpCxEu7uhRRSQTHmEz7r3exf85tZAA==
X-Received: by 2002:a05:620a:470d:b0:7a9:a1f4:d4e1 with SMTP id af79cd13be357-7b120fcfe30mr710015285a.39.1728796600055;
        Sat, 12 Oct 2024 22:16:40 -0700 (PDT)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460427dafc0sm31457681cf.35.2024.10.12.22.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 22:16:39 -0700 (PDT)
From: Jonathan Marek <jonathan@marek.ca>
To: linux-efi@vger.kernel.org
Cc: Aditya Garg <gargaditya08@live.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-kernel@vger.kernel.org (open list),
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v2 0/2] efi/libstub: fix efi_parse_options() ignoring the default command line
Date: Sun, 13 Oct 2024 01:11:55 -0400
Message-ID: <20241013051239.22564-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
 - changed to check for NUL character instead of size==1
 - reworked cleanup patch to remove cmd_line_len
 - moved 3rd commit out of this series

Jonathan Marek (2):
  efi/libstub: fix efi_parse_options() ignoring the default command line
  efi/libstub: remove unnecessary cmd_line_len from
    efi_convert_cmdline()

 drivers/firmware/efi/libstub/efi-stub-helper.c | 3 +--
 drivers/firmware/efi/libstub/efi-stub.c        | 7 +++----
 drivers/firmware/efi/libstub/efistub.h         | 2 +-
 drivers/firmware/efi/libstub/x86-stub.c        | 3 +--
 4 files changed, 6 insertions(+), 9 deletions(-)

-- 
2.45.1


