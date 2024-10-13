Return-Path: <linux-kernel+bounces-362706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5BF99B84A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 07:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82E031F21E94
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 05:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7DF18E20;
	Sun, 13 Oct 2024 05:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="RW4owqNQ"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B6313698B
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 05:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728796606; cv=none; b=cLSuv9eKl6Mz9g3DXutWnxVYbC4o0vdiHi1WJAEtNqlkFl/6zy7v1aNckMLYaWzWytWd3aWF1AHLe/1QdIT65gMPLiBwZYZpTD4t2hHoCTL3SZLSMODI+3egyAexnXsX+XpUSdQLV2vUNgh76vNsS5X+1r6b7pf1ldzzFsKUvlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728796606; c=relaxed/simple;
	bh=sRtVbwNxdfVu2vbZgaqrwb50MI2xFXkt8+JflgP2Ng4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HIAbxmxoPO5lpxXCRBd69uXddiZhK39HoG13/NhjCyYYy6BxCjQphYTESeWaR9TbJID0ynD9EFsd3gzTm3GB9SoM517nsk0qbxKr0XCK7mWXl31AhAJaJb/jVtjmY041N1FowNnCY+DjbHO2XBVDEzAbFPLhAo80ENeW72H2JoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=RW4owqNQ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46045199e4dso34975381cf.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 22:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728796603; x=1729401403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsemdzDcD3ScL7UtYb4qSNAEzD93a7YTEXoVruVLDeo=;
        b=RW4owqNQM8VT51X8ZyiQs+6hMruDBp5Ybm88tYEaoXz8aZtIlhTpWkDNUBhTBLZvnr
         s/BH4w9G0GFD+7PNQsjCTk8nBCOiCw4IqOAD8r+ND06mXuGbdN5v/TCFVORsiD4xAKml
         cPWBNqi+U/4zme24QZNHEKar4mtY6VsO6iiqML3ZRhWBVXlcSERPIYYFMXf4xZ/BXwIO
         Yx7WbhZJ66hbVZQkODG+b3WFJWNXJ3noL2TnegCKCJtHsg8QrUDiEl6ukqodJSgUb1zI
         e4TNEdWJgpodW13sbxv077tZyw+Hgzcc7cDHVXOfXvqQvDzyALxbeaF/nWt4lVQLB3LN
         SNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728796603; x=1729401403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsemdzDcD3ScL7UtYb4qSNAEzD93a7YTEXoVruVLDeo=;
        b=ScpHgJQK83yS/GUekfeCfb9u25tBHmwwn10PPMBqUDXSneo1HKRfb5GpSn/kW0ycJ5
         JvhaNxEWEaD+U4UiQG41JVCfBXApMofWxpcdRUPbtKJRxNeEX46+GgnrnI0OrssKuTui
         Nv3iO9L735YMbkYex3hz4Qq5XwECGOe4JButevDmFUa3pnfDjs+SEauo3EL4Lz880626
         4bYJjivDuQMIHrwA7yn2uQsTUO01hcI8TJLICczFtBxYJuo+6mEKBRhwHBdemE3MHnLJ
         uxnP1voNjeu5KLRSk2goHdbnuEw0dNzU6m1FDJcw4IZiLQco4cLkaR2kOaUwyrPvrqPN
         TQXw==
X-Forwarded-Encrypted: i=1; AJvYcCWWl1YGddazvn9puG4Il9BLeFQXlIQTOp4r2ifRxlytEDhXvruOPp0z+UbOTbh2fkaW73funkCgV8Zz8u8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWWSvHYjKaZqrx0xAn/qSDX6K6YcZ6NIAzIB8WSWk/LdUwHoAs
	wBBrrBUGvTtaU7YO5BQwDH5JOPfutpx8h7fg5A6O5UCPwppfsIpYOaXPn2bmp/ntu8eUmjIsYBi
	SwWk=
X-Google-Smtp-Source: AGHT+IEJcVxGqbdsBJXR94Q+RFwE89gyLs20hW2lUTpW+OZmmGTlP++w1tn9M0e5g55xMNBBUkWP1A==
X-Received: by 2002:a05:622a:1a1b:b0:458:5e19:b3a4 with SMTP id d75a77b69052e-460584b4f3bmr83882861cf.38.1728796603424;
        Sat, 12 Oct 2024 22:16:43 -0700 (PDT)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460427dafc0sm31457681cf.35.2024.10.12.22.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 22:16:43 -0700 (PDT)
From: Jonathan Marek <jonathan@marek.ca>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] efi/libstub: fix efi_parse_options() ignoring the default command line
Date: Sun, 13 Oct 2024 01:11:56 -0400
Message-ID: <20241013051239.22564-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241013051239.22564-1-jonathan@marek.ca>
References: <20241013051239.22564-1-jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

efi_convert_cmdline() always returns a size of at least 1 because it counts
the NUL terminator, so the "cmdline_size == 0" condition is not possible.

Change it to check if the string starts with a NUL character to get the
intended behavior: to use CONFIG_CMDLINE when load_options_size is 0.

Fixes: 60f38de7a8d4 ("efi/libstub: Unify command line param parsing")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/firmware/efi/libstub/efi-stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 958a680e0660d..2a1b43f9e0fa2 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -129,7 +129,7 @@ efi_status_t efi_handle_cmdline(efi_loaded_image_t *image, char **cmdline_ptr)
 
 	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) ||
 	    IS_ENABLED(CONFIG_CMDLINE_FORCE) ||
-	    cmdline_size == 0) {
+	    cmdline[0] == 0) {
 		status = efi_parse_options(CONFIG_CMDLINE);
 		if (status != EFI_SUCCESS) {
 			efi_err("Failed to parse options\n");
-- 
2.45.1


