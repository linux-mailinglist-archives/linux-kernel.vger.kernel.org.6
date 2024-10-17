Return-Path: <linux-kernel+bounces-370512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AF29A2DD8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4534D1F24F11
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01C4219CB3;
	Thu, 17 Oct 2024 19:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M6PF+v+d"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA4D1C1AD3
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 19:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729193517; cv=none; b=IqY0fnWQNlRXiBK2CdKktjIBBNCLt5562RXjyCrYbSjv+EGNRRsNFXRvTbKq6yhlnkga2BHn9sXsxIBl21cRbeuKS3o14OiZP4YXfSX7nqrYxtsRy/XfoWSaVPaybhCEZmqk80SEXk59gqTqW/wwMRvtNqotUXPa56PjbSN8JGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729193517; c=relaxed/simple;
	bh=dAkeaamY7o1370cUdKQG7yxKGStXqWiEAMiubdm6br8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GjObIStMlHuVtXArV8jvZ/5Zu5gZNg60X5dv5CYmcedLeXGnoofyK4SsKGbPJ1d8lOHu2auDka1Hd0ZCcNRO3D7YoyAGIy/lwZqu24vfsN+WtLJ1lkRM3UpMcYrJ3JIl2hx+7gWzQ0OhBMRWWT7l5axdtzgT2V29U5p5tusZKQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M6PF+v+d; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a68480164so6261566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 12:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729193510; x=1729798310; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+PI6B1iY+JP2eo71Lss2ueaqQvzi03LBy+TDhNeB/Zc=;
        b=M6PF+v+d9fcEMOCsw5XOt4VzTOpjY9o+uyqpThUW34bL7cYJ6fayc/IvN03gd2FwaT
         xYdC4AHZ3fkwOZPqZ4YFuD9sIljaHKYWo0wgJf4nPxIzVqGpRTaEZCeHJ30dmfHLjVzn
         cRvlP52U20kua5gecnh5TH2XFAlPWARw9bhoHZl5DaiYRnc2dnogbHdVZIVmbWj4kzz1
         f517Vxarwy9U94CPhVW3RKYkfhkR036vAf7Bc+yrca45DWYVyAUUX8ndcgvLmRJRoFeD
         tIBfHs/rH8MGLtQhfelgQdPJpkJoTP4vYS978tkDvmZ2QPntrSs3WUG9E1pvmYqorV34
         D3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729193510; x=1729798310;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PI6B1iY+JP2eo71Lss2ueaqQvzi03LBy+TDhNeB/Zc=;
        b=v6e370/F+wgIftp2Y8Wl8RVEyplwCQZdhC04UnHS4KfaAZz/mMfxqL/PYPCpPJCGUX
         NY59XGUe42FMavTbGk5eDQVwifiA/ASfyDGDxXFBqHMD5Y2NEbh3w4AhQrAtrFW9tyfY
         HclOmEr83Seg6bJ9nh7Jtt0nGMChoRzsW/OHESce/oe4NMqaa9CKCZaqA0XdDTF1kyWD
         CxTBtYk9En6XZTpx1TP1FeBX7cOj6DGnajSgJW6yH99RVYaHKoEos0/QxuqwjbLbueTw
         QsM02na2ByiHmziA2Vp3AoFEIkTR28TG4w6gWjcEnffo3Lg3KBVVA1blFjc8zQpYqFiU
         yZ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyCVKSSpcNpefqI+1Ji/VIGCs5KJUZi7FK08VSPSL0sbvZVsYxxCReHOshaz4Zq8feX7LygChcQWPnYAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqyVkiWzoEjVQ5pN6QBd5KizWys7VXtIziCzRdrvCTeRfkKQr+
	7YL920+SZjF6Fdy8TK8YZEmkEG9CXS1+kQFOu0NOQb+KGDOCVVg7dlUAu+/M3CU=
X-Google-Smtp-Source: AGHT+IGJon+b9dsLW9OFTm+VNv4AExNUwMLbQMOv3biKDHICy+rUsUPzF2VOZMg3pm/HFx79t1+13g==
X-Received: by 2002:a17:907:f709:b0:a9a:b4e:b9eb with SMTP id a640c23a62f3a-a9a34ec99e7mr838913366b.46.1729193510331;
        Thu, 17 Oct 2024 12:31:50 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68c29b73sm2298166b.202.2024.10.17.12.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 12:31:49 -0700 (PDT)
Date: Thu, 17 Oct 2024 22:31:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dave Penkler <dpenkler@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] staging: gpib: fix uninitialized variable in
 usb_gpib_command()
Message-ID: <a7fed100-ea4d-4dd8-97c6-3fbd2c15f795@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The number of bytes written is supposed to be zero at the start of this
function but only one caller, ibcmd(), initializes it to zero.  For the
other three callers, setup_serial_poll(), read_serial_poll_byte() and
cleanup_serial_poll(), it's an uninitialized variable.

Fixes: fce79512a96a ("staging: gpib: Add LPVO DIY USB GPIB driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
index aa7af352e709..4bcbaee65aa9 100644
--- a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
+++ b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
@@ -596,6 +596,7 @@ static int usb_gpib_command(gpib_board_t *board,
 
 	set_timeout(board);
 
+	*bytes_written = 0;
 	for (i = 0 ; i < length ; i++) {
 		command[3] = buffer[i];
 		retval = send_command(board, command, 5);
-- 
2.45.2


