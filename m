Return-Path: <linux-kernel+bounces-352500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578EE99200F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 19:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 173D3282437
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 17:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2CF189F57;
	Sun,  6 Oct 2024 17:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="dI1KmE5g"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE50189B84
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 17:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728236605; cv=none; b=LHVYRJqOady6oYziNaMa9HGI7cWFaQkuZNJVqNJxLlBYAkYUwxWNlp3Wor35X9DoDPgMwJG11fX5J6jDiKm31Jr1AzWKh3xd+xAQ8BB2pFMB+OTdLGgl1Ou8j7A6K+AHLaydD3WBhNMdK3gJU8rIku5EBVX2FYq9bv5fKNN33Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728236605; c=relaxed/simple;
	bh=iF5IaUjbFHWZvRREAbEepoAFURE11s/pMqmogjiDuvM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TkzKRH94MwMLRKz1+/Z6o52N0jrPuUmukHG1XgJsPfUfbwCL1bHwLQ8pei31mJ8M/gdy/MLHLvNaHUjqhy2Rs19GfhTHppi7P8zJPfN1tNO+KgO5dGOmSBd0+UsIj+Lw0quTfCW4FkpxHkoDuBH2767deXzjGR8YetnqMFSJEdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=dI1KmE5g; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e029efecdso267363b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 10:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1728236603; x=1728841403; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=spALRDUsYOwVLjrj+itG5SK1W6mJ4BemNUJT/dXw+2w=;
        b=dI1KmE5guor3Dabk6JaNuXA0zx+FQaoplEbg2OMK6bMbxvPU+f59KMCUkUmyYHNNJ8
         pzYOxIXr5zj/g7paCV17g+0bWGrRf4AZBqcQVUAhdByD+UQkhp+KsfKk7I1NjUGrUkVY
         tb1IVEdl5nxx+V/hhr1aMAULWXR0s0fk9jbLmWvHsIW9J3khvba0jvtRmJTPVwxkccrQ
         WWOp+PqGx+wft07pjHfUtLC4T3ff4lwwHFekn0bmopoY9fBywR0Nlrlz23BFcxj/icG5
         h7z6FmRcmalp2oCdgmLrjey/bPDZ5VYeMH47hnArLEWxsTvxjd5jfbo3r0ucADBnqK3V
         Qk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728236603; x=1728841403;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=spALRDUsYOwVLjrj+itG5SK1W6mJ4BemNUJT/dXw+2w=;
        b=UgNJXxNV/QRBPN1FySBevOB5JB3msfaOsN7DsXgnzSITGEPefDPKNadem13gS9zLlH
         qfGeP4avxHbngXSCUTQlQQjxGSfFUDznE8FugEMmei9IBjkUZw/yYbZW3jnZHXM8PO5B
         X0xU7y+s7npDPmJ1ofMA5mmWBgC3tDlmAo4zUgYIkDRy5J4kgY7e697I1HHu8UqCmyLw
         zRObgto8cNAQaQ9eYxJGNdN9/00uaZpuw1wAc2KN/C8tMYMweybEBPDPdeE5dhnjaZhy
         fKrAHW4BuyxnhXbCmfYnpjOWQwPiSeNlMEKePUdU74krS0cRQ6XRgHls0cXnTgkLipN/
         +A1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4l4LhjfhcZjILXHIDPDVoOR5q+d8F3w3O13ZLF27TkWayBx0e3/oLTgAxCB2IXmwj+99CjK5UD1TXkB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt6+kH28mgC5cjNwPwLHMfB0mQJ44GWzNyXGgKqf6OzCV1C52s
	Fb9c3adb39627gQWgNahMTAK/TOC2cSKPS/cO8HNfQhCEJx7mGnDARj0b3RCYYH+agFGjoBW2CY
	2
X-Google-Smtp-Source: AGHT+IGMq3wabIJdCjVaKWXN4FS9fMNNTljNtGBedaNmcPo1nYMUBIfKrJpWTH3HdQf2za7dBdMOLQ==
X-Received: by 2002:a05:6a20:6f91:b0:1d2:f00e:47bb with SMTP id adf61e73a8af0-1d6dfa417a1mr13006921637.21.1728236602914;
        Sun, 06 Oct 2024 10:43:22 -0700 (PDT)
Received: from [127.0.1.1] (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d6526bsm2999591b3a.159.2024.10.06.10.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 10:43:22 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Subject: [PATCH v2 0/3] pinctrl: th1520: Improve code quality
Date: Sun, 06 Oct 2024 10:43:20 -0700
Message-Id: <20241006-th1520-pinctrl-fixes-v2-0-b1822ae3a6d7@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADjMAmcC/4WNQQrCMBBFr1Jm7cgkmlhceQ/poiYTO6BpSUJRS
 u9u2gu4fP/z/l8gcxLOcG0WSDxLljFW0IcG3NDHJ6P4yqBJnxWRwTIoowknia6kFwb5cEavyT9
 se2ovbKGqU+K9qOa9qzxILmP67i+z2tI/g7NCQuOs8SH05IluheO2kTiWoxvf0K3r+gPvOrexv
 gAAAA==
To: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Drew Fustini <dfustini@tenstorrent.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: b4 0.14.1

This series contains code quality improvements for the new TH1520
pinctrl driver [1]:

 - Fix smatch warning that the return value is not correctly set when an
   unknown pin error occurs
 - Linus suggested using guarded mutexs so I've converted the thp->mutex
   lock to that usage.
 - Linus also suggested using a scoped iterator for the DT for-each
   child node loop: for_each_available_child_of_node_scoped.

The series is based on the linusw devel branch [2].

[1] https://lore.kernel.org/lkml/CACRpkdavPAv2sPRREQhx_A7EtOj6Ld_n+NcO+vH0QCnfVedXKw@mail.gmail.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=devel

Changes since v1:
- Move the scoped iterator conversion to a separate patch and remove the
  child put operations as they are no longer needed
- Link: https://lore.kernel.org/lkml/20241005-th1520-pinctrl-fixes-v1-0-5c65dffa0d00@tenstorrent.com/

Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
Drew Fustini (3):
      pinctrl: th1520: Fix return value for unknown pin error
      pinctrl: th1520: Convert thp->mutex to guarded mutex
      pinctrl: th1520: Convert dt child node loop to scoped iterator

 drivers/pinctrl/pinctrl-th1520.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)
---
base-commit: 2694868880705e8f6bb61b24b1b25adc42a4a217
change-id: 20241005-th1520-pinctrl-fixes-d20db68387e6

Best regards,
-- 
Drew Fustini <dfustini@tenstorrent.com>


