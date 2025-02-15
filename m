Return-Path: <linux-kernel+bounces-515806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C89A3694B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988E53B172C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9B31B7F4;
	Sat, 15 Feb 2025 00:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkPyDyvD"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2179411185;
	Sat, 15 Feb 2025 00:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577792; cv=none; b=QYTMuNDRvMR42mopJhU/0yAmdRWs1VG5593MGqHzK1VFYo8a950pHVUkAJ6MS70GZOTWwpciF+UqD01b1Xl10tXHRTDbGtxTwl88w4fYeLVffcvVamIuVanlJtetzY31LW2gHuDGbeE9m3z9sgz90YqPWlfE+SWBfDxMp/Tlj70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577792; c=relaxed/simple;
	bh=7PW9ECbTvbxLratiQ5RGwLyR8ihQ/4Nt9a7Gx+Sn52E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NO/QTvoeCRGZ9C+dIiES5+Q8bpTxGP5igxg+JvxC2K+oJlKyirVjyole9putfr98OKd8Whu+9yX5GEeHlvjDiNo2tTNhyExAk4Krbf+kr4hNj7KNYV9dfuKDEOMlkSifK3GdyOp8xwX62396ojrDc5XqopB9Eci2GNmcvE5RGR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkPyDyvD; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6f754678c29so25456317b3.0;
        Fri, 14 Feb 2025 16:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739577790; x=1740182590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oNvPfToKnR/rR/b+ekcS3fLQgOP+3Z1umibcOsqYhhE=;
        b=VkPyDyvDM+Qj6HXa7Zjc+MiaQcDal7izD5hW/euaS06MVE1bdp4+aWTDWRXMLiUNv/
         vxrefnmEXXhQZ1rQlkKaxkagb7mN4Z184SsTt3oFznQsi+LjqoByqMEk2TnLJWAdZf4A
         Ro1WCgnz25uoCR8fFk2Z26BM3NSJ6fqIDXDfamqhdl4rlvnIqND2A9PhB8ubhvShPIYR
         fQJD6Xt+QlQ4p0kUC+QfO4ATG3/vwB6Zq91++2De5oejmVMsgZZRhJdLNMIulq8DXei9
         Dt8TTURf5QBxgFvWG5drVWzLxya7VCXxQ3TxhBB0w97T9yjXZmgeliqkI+HvTUqtBwSf
         18iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577790; x=1740182590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oNvPfToKnR/rR/b+ekcS3fLQgOP+3Z1umibcOsqYhhE=;
        b=A1cMSy0FzygxLnTb6V60eOsdE4Qw4ofIBiIqVp9Nmpa6XWBKGVQVmTKYpiuaszGNH4
         axcTk3MEOs3Q7/wQQWM6vu8AXr+baKg8nQU6bH7XRingJbDs7C4pK/ES1+lmlqVyzQ8H
         RcHhxI2IJ/91aWxdfG7N5i7zdFHls0aJLqUDZ6Gcq8p/sITI+GRLD97s4w9DsGgpXtLL
         TbnLyiP6rUHYhIpNDjubGG3LExAPVs8gGWqIIhi1e0X9SszXcyJ7I2zlsutAnefTbs8v
         sH+4phINPlbHngH5BFcqI5wULkE+yRBN9bPFRudlg6E9tSSPuHsob2I0gEFNsuyGy7Sb
         9txw==
X-Forwarded-Encrypted: i=1; AJvYcCUMpsweSCBDHRx8++lbrBN2FBZv8O7IU5E3rjOy63zLhLPiHaIU2n2Qf6V0XTG2LlXIWxVGmC70UD9ibbpOqanN5EfQmg==@vger.kernel.org, AJvYcCUPcO7KQbyr2w0NDfKjmafODRpy9Tmb3wSH7QYQcVaFthXdf6grXEOoL7mvPpxH2OJeNOvngwhINkD6+qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuil3nYMrmdqEQZnMeX9fQ/vsEFdllmisi33JF7VX3Rm+yVvkX
	qdWm84EoGDwdw+SNw0jjCldHjXvZu/9RGOFsdObOifV7hPJ6GuS7
X-Gm-Gg: ASbGncu3+ODEa/wTWqoH+rq7RaqN9vMJTGobwF6UgdMGOq1SZQ2s6wDnmJUNnB8Y3CZ
	/+Qid3oHmBsT9/5Hw/Rs8DNZAoZ/x03hdtkifXgGJF+IaFH+sG5oEH1OviPP9sVAHh6JQBFoLIP
	jvaQNMa+9Aa4K6reu+jBii8iigKG92sj6NeAwp0e1NOwF1YicZLhRJkiVFNs5ajq4w8x+sK3Btk
	d55+PObyegENMbz+ipPfIEm4hmAsCMuLIBriFEofP6k4yyd7nCiZU8vw/o47eBIfEv/2ReBmgOP
	gPPQvP05ljvmXsZ4cUMKb5o=
X-Google-Smtp-Source: AGHT+IFzWDzEi24i/nz1De+3xJ3ckkugm3ihnELKtJEzL0femZ/Le90PGY4M2oc8iPbhpg6LLOokug==
X-Received: by 2002:a05:690c:498a:b0:6f6:7b3f:2a68 with SMTP id 00721157ae682-6fb5837e82dmr17829787b3.31.1739577789988;
        Fri, 14 Feb 2025 16:03:09 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb35d586e5sm9844207b3.17.2025.02.14.16.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:03:09 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: "Hans de Goede" <hdegoede@redhat.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH 0/2] platform/x86: thinkpad_acpi: Enable devres for subdriver .init callbacks
Date: Fri, 14 Feb 2025 19:03:00 -0500
Message-ID: <20250215000302.19753-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

It was reported by Mark [1] that if subdrivers used devres, the
tpacpi_pdev wouldn't bind successfully to the device, thus failing to
create the various sysfs attributes that this driver exposes.

The original problem is already fixed, however a complete solution was
due.

The approach I took is to let the driver core manage the lifetimes of
the subdrivers (details in Patch [1/2]). This enables devres for
subdrivers and IMO makes the code more maintainable (because of the
lifetime gurantees).

This was compile tested only, because (unfortunately) I don't own a
thinkpad so some testing is absolutely required, as this is an extremely
intricate driver.

Based on top of the for-next branch.

~ Kurt
---
[1] https://lore.kernel.org/platform-driver-x86/20250208091438.5972-1-mpearson-lenovo@squebb.ca/#t

Kurt Borja (2):
  platform/x86: thinkpad_acpi: Move subdriver initialization to
    tpacpi_pdriver's probe.
  platform/x86: thinkpad_acpi: Move HWMON initialization to
    tpacpi_hwmon_pdriver's probe

 drivers/platform/x86/thinkpad_acpi.c | 176 ++++++++++++---------------
 1 file changed, 77 insertions(+), 99 deletions(-)


base-commit: d497c47481f8e8f13e3191c9a707ed942d3bb3d7
-- 
2.48.1


