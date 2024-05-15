Return-Path: <linux-kernel+bounces-179850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5398C666B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8912B2117D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 12:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6A2824A4;
	Wed, 15 May 2024 12:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTZwoTpW"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915E2200C3
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 12:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715776838; cv=none; b=eOTx1PceXn9JmNyxdyTdUAmx5yFttsX6lYT9krL06WE8JX3Ne7tlk6/ieZDfBtUglyvbtJCpXK7W5VHlDn6pc3Oyt1g22aQTOKJp8TnO1sRbkzCdVaXscH4FPjrBERoP8Xfu6vGEM8Sc1keHyNJgG5jzHzGZn8t0aoz35nc6bog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715776838; c=relaxed/simple;
	bh=CBeVeudKaMa64Hk0EQo8xz/HGk7N1bFC2eJIinxtmbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNdHdAbhClG+9ulB9FOEOVWb7PVz7r/nDo3VB5vGYq1XBkXzCJmHGnZUjPVBYtuYBRJhRF4o/OUfD0gYDjzggljt/efW3dhZ7AHhnurBV8pv6z6ATbpt40dwq1PXy5DMJ45N4C+CIh6KhJcAxwR9J1Qof3kJsK7X8tJh/7/8Qi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTZwoTpW; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c74b27179dso4626337b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 05:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715776834; x=1716381634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRzWc3KEc5QqTvXb/3YsxeGC6cz6347lvqioXf2gZ70=;
        b=fTZwoTpWhB4sqXhnyRPRCHJRwaqncczmJ1QQ0CUHyj5iy1CCNGBOdmHujyBhaQzyc2
         LISj5Dohh959u+q25EJjPm/D9hNQY5Qw3ftHhJS27vDg6MVOz4e08v/myjXY/Qeel5Gh
         xdqU1rMdTNJ4l23iPNsfvTFVWQuOMk6tcLk4TGwykOaaVQbAZD1GNhyozRR9+Pm4FVkh
         7Gjq2k4R3cxlRwkEGRzVSVFyTAevmsF4rsljv9ilC+gABP9O9IdWjBCbFP1yDVbsXLNv
         8cNjfuWzdDkciAy2RBig7JFa2+0E2vDFmzILv91k4/gD9HhKI1rqktndUdMPhyKyWk8a
         fWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715776834; x=1716381634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRzWc3KEc5QqTvXb/3YsxeGC6cz6347lvqioXf2gZ70=;
        b=IygCvR0WJzFIVScKcu0LN4+/TCef3D882atEYYR1eyv2SMQmvwRS+E0xJeAckfulNI
         LwriKjfFaO73jsfhGqkKkUeXT3SmUOCHVoYM1rs44Wsp8av9rAumvyQzz5qIb1dBZ60G
         f3532GGRf826QMqVFALoFfMYMVK4AZGed8eOQmiYDAcSesS5fLWz0KvCSK7Ra1XgtkzN
         jhHTXagLtUn98jzp8GGc6oohH6mGI3ba6qO9U+78olneYdj6jVMdiBu08UhzoLG8hLtN
         vFY4DsiXmkZ80+9DI70M5KbZbpT8ieBWDvvOCBiyb65aLtsj0W3LT2V1s4zzyPRN4THM
         +Mfg==
X-Forwarded-Encrypted: i=1; AJvYcCXp58O6KwFSTxZwQC9ZAq/YL5Vr3TF+suIaXNPQcgmIc+bKUFcBbQCGIefJdk4EjxqRg9nPOuf9ws0n6XU8Ae4ymuahrv5dWCseLoat
X-Gm-Message-State: AOJu0YwSkbHXVrgIRvzFEKjeaqQ/YFrBIcqHHzzLh30i3qSVoWHALK4b
	CNm+cMag7fhfmsNw0MWu+hi2Bam6MiXKGE0dEl7zG/HjNODgQmHu
X-Google-Smtp-Source: AGHT+IHCjGtL6PmYiYtUJfANxegVmFHGwjkB08YLirqldBcqADqviq7g4qu1BpAhmj2E7DyUT5ltJw==
X-Received: by 2002:a05:6870:364e:b0:22a:b358:268 with SMTP id 586e51a60fabf-24172aa925fmr19183260fac.25.1715776834525;
        Wed, 15 May 2024 05:40:34 -0700 (PDT)
Received: from my-computer.lan (c-98-39-64-40.hsd1.tx.comcast.net. [98.39.64.40])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2412a3d1fa7sm3014855fac.8.2024.05.15.05.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 05:40:34 -0700 (PDT)
From: Andrew Ballance <andrewjballance@gmail.com>
To: syzbot+39b2fb0f2638669008ec@syzkaller.appspotmail.com
Cc: almaz.alexandrovich@paragon-software.com,
	linux-kernel@vger.kernel.org,
	ntfs3@lists.linux.dev,
	syzkaller-bugs@googlegroups.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Andrew Ballance <andrewjballance@gmail.com>
Subject: [PATCH] ntfs3: check if more than chunk-size bytes are written
Date: Wed, 15 May 2024 07:38:33 -0500
Message-ID: <20240515123946.874688-1-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <00000000000077d29606186c5e99@google.com>
References: <00000000000077d29606186c5e99@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

a incorrectly formatted chunk may decompress into
more than LZNT_CHUNK_SIZE bytes and a index out of bounds
will occur in s_max_off.

Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
---
 fs/ntfs3/lznt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ntfs3/lznt.c b/fs/ntfs3/lznt.c
index 4aae598d6d88..fdc9b2ebf341 100644
--- a/fs/ntfs3/lznt.c
+++ b/fs/ntfs3/lznt.c
@@ -236,6 +236,9 @@ static inline ssize_t decompress_chunk(u8 *unc, u8 *unc_end, const u8 *cmpr,
 
 	/* Do decompression until pointers are inside range. */
 	while (up < unc_end && cmpr < cmpr_end) {
+		// return err if more than LZNT_CHUNK_SIZE bytes are written
+		if (up - unc > LZNT_CHUNK_SIZE)
+			return -EINVAL;
 		/* Correct index */
 		while (unc + s_max_off[index] < up)
 			index += 1;
-- 
2.45.0


