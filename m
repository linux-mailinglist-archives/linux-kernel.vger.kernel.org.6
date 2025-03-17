Return-Path: <linux-kernel+bounces-564296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 708F7A65229
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D0877A9A71
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEF92459F8;
	Mon, 17 Mar 2025 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="CpzDdST4"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C032459D7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 13:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219889; cv=none; b=DPiXVpX4CguqT6aRalY+2fvP8KNZTNzbHJVBkT2VM7VG3l/ZOLcyrfRSgd/yoNoLt9lO9VN0OaWof2Hqok5EZQa/XRXWLkEDT5mPW0Mf/pAFrp2GamBoq/P0xX5wLoNmj3IsFyTqL9PBqgOYEyWpjxdFnEsrb8jecqiJ+NbtJJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219889; c=relaxed/simple;
	bh=jX0ueY9211gETMFC7G0MuImPr6rWSlX9oFF0HSj0qeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nu8rnplZfV5yIQdh2F7nfbV75czI9+UAkJPgGT3ZO43Q7/2cqK+njrLSuNvhx1r+jxB3FYnIWW0e5Biybgn6CBw3TmSHg7OtNFr/IVCEhKbuBRmd3giAc3o1LTGJA5S2Sc3tHVP0HEp6DFjgYF477iDyE87fJLgZKnQ0AdUlec4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=CpzDdST4; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3014678689aso2394020a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 06:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1742219887; x=1742824687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCFknnsao+MA3rkiA5nb/VuBAcmMICvzxTPutU19C0o=;
        b=CpzDdST4SUHXX63D528pN/pT8+g3o8kiuU3UkTTWcwsbL19Pid2fyrglxdER4bkTwU
         3HJ9pwi5C+5+vF44ZCrnyyXwtjNagIZFva25cI+tWpf/W59w6G6jzJLvS2+79yTTWP0M
         2em89jC/qYQZRpfpGGyl9pvWnfvV+xrTuCiVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742219887; x=1742824687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCFknnsao+MA3rkiA5nb/VuBAcmMICvzxTPutU19C0o=;
        b=sMF2ezBwNZv63t9Z/CH2PYQJLKcctn8BgXlm9XX0zQmwIV27sw4N+cBch6SxMf3f9a
         IkBsMC1IAz8DWko5JZ/ffeu7gkeKz4eLash5GbEfU0KAJtYVcriOY+KUvDYk7v8uI/5W
         i0+IABm/T3pWGGJNTYoY6Jjm/Wa8qe6wuTdfLs6cf4n06kVZ8dVEn0mBNBgjRw836Vx4
         /OreIhFyGgiK19JmKwtANjAH13wAtKAHrIzHNswEdiKk7v/FI9JpDCo676I+kblcy6oD
         J0un7KybKlFIQfbyADhKJjg0eTt/Ht9zvm3wsYOfcsjeoFJn11e1Q0Cbwd+PaeqBbglD
         lYxg==
X-Forwarded-Encrypted: i=1; AJvYcCWXrqYktB/tr5gmIfiA2IMZp0qsM3iF72W82UgnKqUslx8558lOTpetUGUPHJuPqYw0DI4HW3AKyLQr2eA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxu2fbmJq+xBEDcXXsFX+/dsbRYCxUdPh2x3bLRernB4tS04ge
	x9NOhbnCN7mbsG4TlHZTmiY4sslNQVzPiZJ2pBqYlDHtd3DezsWiQDJjxZ0laDA=
X-Gm-Gg: ASbGnct2OUoA5nbFK0KGbwEZsjsaanICl7sTuQNwCFci8k7cvw4EAxaHYLg/Rrio9Lk
	p4dBkeCwCN1Er2V6+JPLtXjn2j85Q2eiCeAhhEf8uVRwpcyVgjfccMzYDHMjIqoB3TId7BZL9Xy
	fnVrTgfwAfZHg7KlFqkGnovppEtIl7/CXJouKHNInTv8KQr1pFalNdl0snPOg3YNiWeY65rVHHf
	3XA+v6K8Avq6DlXyCoV+6r2O/brs7p6Z3hBfnyucSej/UE1rqEQ8jUu2Rh6UROEi+5zTUJLy5qe
	1IkwPOeEBShnSiSVeuYZxIqwg3b8IlJdM5ZceQRrwLCs6WW2ZfrrQxVtWbbFLaVl3X2C5wjbD3A
	LS7aK
X-Google-Smtp-Source: AGHT+IELSRI9QIZeeFAktb+zISbFeOiwkhBMlafTPTduJwqWCwWpj5FYPH9pfrHw+RSrrQDy4i+60Q==
X-Received: by 2002:a17:90a:fc4f:b0:2fa:15ab:4de7 with SMTP id 98e67ed59e1d1-30151ce15a6mr18431695a91.12.1742219887603;
        Mon, 17 Mar 2025 06:58:07 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30153b99508sm5993742a91.39.2025.03.17.06.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 06:58:07 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [RFC PATCH v4 5/5] btrfs: ioctl: don't free iov when -EAGAIN in uring encoded read
Date: Mon, 17 Mar 2025 13:57:42 +0000
Message-ID: <20250317135742.4331-6-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250317135742.4331-1-sidong.yang@furiosa.ai>
References: <20250317135742.4331-1-sidong.yang@furiosa.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes a bug on encoded_read. In btrfs_uring_encoded_read(),
btrfs_encoded_read could return -EAGAIN when receiving requests concurrently.
And data->iov goes to out_free and it freed and return -EAGAIN. io-uring
subsystem would call it again and it doesn't reset data. And data->iov
freed and iov_iter reference it. iov_iter would be used in
btrfs_uring_read_finished() and could be raise memory bug.

Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 fs/btrfs/ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a7b52fd99059..02fa8dd1a3ce 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4922,6 +4922,9 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
 
 	ret = btrfs_encoded_read(&kiocb, &data->iter, &data->args, &cached_state,
 				 &disk_bytenr, &disk_io_size);
+
+	if (ret == -EAGAIN)
+		goto out_acct;
 	if (ret < 0 && ret != -EIOCBQUEUED)
 		goto out_free;
 
-- 
2.43.0


