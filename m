Return-Path: <linux-kernel+bounces-384345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D23089B293D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63088B21E1C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027122010F8;
	Mon, 28 Oct 2024 07:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DuW9KUai"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE1D1F427C
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100944; cv=none; b=T7VRMgqhEOcq39mG5ZzVIIyMSix/C5QfzXnpJiN7FCC69YXvSLiqV7bWNhfOQ45dZLpesREDPkyW2DTwrGDtmXeswi7QaKGx3eGDs2Kcg9/L0oYw5IUmL5j0F0ZafDhu7EJZnCl3Lnj7GFMYHYtd1+NakZx+aRUu5YDk8X96viY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100944; c=relaxed/simple;
	bh=Wv3yF4Ar9Pz3+Z4fWrJB94mZZwrOQZT58pweKP29aHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vAOiYvfKP9ETcUGswqRfVvSgbkx4sJLpBYgUJuA6K1niS099HSNAm6G94Z9LaVPs2NOmnax/wpK2wO95C5YIdJksQzyxcKbFFES+xc/vrc+XgCw/O6pG7drj5JY/vgRAjrr9RX8SiNo+iCs7PN+ouD9Ve4mId6vfZj0s4LXseqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DuW9KUai; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e681bc315so2681278b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 00:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730100940; x=1730705740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Imb3YZxrrE+5d5dvAE7g7R4yaDBgRwcYFIZJYRNaots=;
        b=DuW9KUaigESK6K1IUIsH3+huo2kKZEtvBOmexMFUa0pFgOXUK6LDKaxi1chXNbIwsV
         /xRT4ZfTOXGURXoT8PLFfP0HWp6wI3NMI0CWk7fCvtAf1Lgnz+5pRF3LS/1dayNOLQi7
         zYva4WLaeXFDrYEcvrZr5m1ql6uPY/6TKXiUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730100940; x=1730705740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Imb3YZxrrE+5d5dvAE7g7R4yaDBgRwcYFIZJYRNaots=;
        b=VH9lm18yIDw18EySUItTSeLlrIJ3mFLvFfH3gveZyp+tTfe4pLlNfAuewsmkmFc0iI
         6JRa/eIleJYwWsJLVhIlP5ELQUCWlq8DL8TRsF9pGTSk2ijNsCZUqlg8AUgI1xQNWRpn
         sNRSwU3Q8+nWwFxWvl8Fw60A9b8LJkEqP7FrgZ4j1/EG58Jt+6PO0cMi7t3rRoXZ1hIg
         GBV8qyp4k9+yYLshbSdup0r2+kgmKmA7lrNYeRrX4uMlxJAkIArozav138tfHyAaq5wX
         hoyWC2d9Fisj91CaeDX1+bRcXbcSr7v+Ui6DDHEYXl+kEBz/VkWlQPXgA1uliv+QG9aq
         AIYg==
X-Forwarded-Encrypted: i=1; AJvYcCX98p5m/NW6SCBkbqLV+RAGKrGTCpWae06TDvL4QHzYk8DBULIc8bv9s0BZ0J36YjD6nQwAK3rSkjbDnnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YybDEXu0mwg7kuGquY40t/5UPBDHNXoVl5vHDFhco8VpaAcm4Hd
	zF4GCbTrUD25NC4EpDJyYji+ilMh24oyD68UC56j8BsOnknIiiTc2QrU3er1DZEXcRKu1LGjifc
	=
X-Google-Smtp-Source: AGHT+IHwsc3efwP7M/xqL8OXEAqdldWcrBCqHgefKT33dMhQ7sTYUY/HCt7Jqkx6Wte3ZFNOvJJnFg==
X-Received: by 2002:a05:6a00:3d51:b0:71e:6a57:7288 with SMTP id d2e1a72fcca58-72062f7132amr10960362b3a.5.1730100940528;
        Mon, 28 Oct 2024 00:35:40 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:f1f8:97e1:9c5b:d66f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720579360f5sm5131189b3a.88.2024.10.28.00.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 00:35:40 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 0/2] zram: IDLE flag handling fixes
Date: Mon, 28 Oct 2024 16:34:56 +0900
Message-ID: <20241028073529.1383980-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zram can wrongly preserve ZRAM_IDLE flag on its entries
which can result in premature post-processing (writeback
and recompression) of such entries.

Sergey Senozhatsky (2):
  zram: clear IDLE flag after recompression
  zram: clear IDLE flag in mark_idle()

 drivers/block/zram/zram_drv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
2.47.0.163.g1226f6d8fa-goog


