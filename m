Return-Path: <linux-kernel+bounces-379685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D79A49AE247
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943A528233F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9856E1C07DF;
	Thu, 24 Oct 2024 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMdYmCEz"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23761AF0DB;
	Thu, 24 Oct 2024 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729764968; cv=none; b=HEEQ7NWyOUUcZZ50q4dwFq1CrzYkrOacpXMosJBxcs3kN14Yj80xdSYOK9TfAkEaA0vSKeZnAMMJ69P72wDWifDwqLNA/gMfacMp5wtwp9VWC+pVCekqopBuQ6YCB9E1ulaV/eYVEvSK8ayJl+CZFiLaSxgx+ubYEt5tbq1dg3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729764968; c=relaxed/simple;
	bh=2MzyND+IhhZA+p9NtU/Wh851iTJxmQMd2PZHEYNX8/k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=euumntpQYcBx3YyRbwaNri7aNGGWm3Vk3ftEvjdrXy50t+Vtn1rYv1cX1lkOfz/YfKZlN+6kB+tCYX02SsyOKCiQqBV32sIF4v+Goif1KotT7uehS3oWNbOjdvfMhp0ARbErL396NSkSDlgOGb2KyeU9jgGXDNXr142W8WMmp14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMdYmCEz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c70abba48so5671235ad.0;
        Thu, 24 Oct 2024 03:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729764962; x=1730369762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s5UbkCFXNfDprHiL8l7WBWJWCT0SfPjRIJ0VzB0Duj4=;
        b=gMdYmCEzd/6MfjO85sgNZ+XIpkLDRMVRW+ubANfAjON7GKVE+BzG4UneGIm6D4oavZ
         EibM7/crjQsB/GyyFI8oiDiJJk+Vsyd3tKsYtphDYy4FljNVXnGH5WOImlUpd8Ss4FJ5
         jFUS8kvHJv3YFiTJwBLJiRUcxKd1F21S7/eHVHFie0D3IWmrGKF+pKg0Zb9dge6jDdlm
         BJns83SUUQVNUit6IOtkW37iDe6BKXv+DG89IQaumgcvd7lOdk5X3dCXBjMRVlQEXkjT
         IN1LJZeETi/ivExvKHu3Got8qRrUpe0c1Cqi+19vJzLDYy+kQ/D3obKoXxkPKvL0srQL
         WRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729764962; x=1730369762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s5UbkCFXNfDprHiL8l7WBWJWCT0SfPjRIJ0VzB0Duj4=;
        b=e3Z8mjKx6GncDUuLY2rxBpL9RJGP3mgPNAr6gdajLJirwh1VFtOmfIgAr/b1UwdENg
         Cl3T3bQj+haCzN8YZ5bocoMWhSyyAh+CAwRENW5GqyDumr0ghGjRzbX84whBqrY++PoW
         VVGzf95RrPPs+VgnziQwsvfIhdH7ARokVRmGwyCLDCMB+AZY/F/NgBXx2tEVREacOimc
         KCGbCslVvEvTGVzRaJDg5kDPU8HMHyvUH0owXM1y1I3lg7bFXfP7oM9usxZU3NiR3CJ4
         WCp5tVgdUZsD45YyEuIRnfFv7f9rpwjUInsqO0RBK4nmTig410eEq4PRTWXXBG+PlUsu
         3A8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnQsQXOv7jzt+Ww6M9iT1MPYzADPcnWXHlVOxvS9IRTL+blVsyAX2nFce8Q/CUHnUAetzso+KDotSa@vger.kernel.org, AJvYcCXDuu1UiqFKtQujgfYaF6X3KMKfn1s9QR8psxBXLt7N19yCI4vWe33Q76x3F/Y9ekbf2IPqLBW75YPp06M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVdmcwJVR3N0nY/olI66WdvehMG0u7hDn5n3SRpCxbB5oy8NVm
	ogryCSFXZ/VsJCS07wPwuXpUVEn7mbJPS+k8wasxMVHBsczczl67
X-Google-Smtp-Source: AGHT+IG/RJibkFWIb4eXte5nF9nmK0JSN3qVgPfzWqVAAW5bAh6p/5/rDjtjCIUFOp/+Q0R4Gqa1Vg==
X-Received: by 2002:a17:902:cec4:b0:20c:771c:b5fd with SMTP id d9443c01a7336-20fab324842mr55671775ad.60.1729764961753;
        Thu, 24 Oct 2024 03:16:01 -0700 (PDT)
Received: from asix-MS-7816.. ([2403:c300:5606:d914:fec1:9dc9:d21d:9b02])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bd376sm69782065ad.132.2024.10.24.03.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 03:16:01 -0700 (PDT)
From: Tony Chung <tony467913@gmail.com>
To: gregkh@linuxfoundation.org
Cc: johan@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Tony Chung <tony467913@gmail.com>
Subject: [PATCH 0/3] drivers: usb: serial: mos7840: Improved baud rate support
Date: Thu, 24 Oct 2024 18:08:59 +0800
Message-Id: <20241024100901.69883-1-tony467913@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set has made some improvements for baud rate setup:
1. Optimized register configurations for common baud rates.
2. Added clock select registers to choose between 96M, 30M, or external clock sources,
   allowing baud rate setup to 6M, matching the hardware's maximum data rate.

Tony Chung (3):
  drivers: usb: serial: mos7840: Add defines for clock select register
    offset
  drivers: usb: serial: mos7840: added optimized register setups for
    common baudrates.
  driver: usb: serial: mos7840: add more baudrate options

 drivers/usb/serial/mos7840.c | 273 ++++++++++++++++++++++++++++++++++-
 1 file changed, 269 insertions(+), 4 deletions(-)

-- 
2.34.1


