Return-Path: <linux-kernel+bounces-239914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EEA9266C3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858CB1C224AB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7381849EC;
	Wed,  3 Jul 2024 17:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dlB0zq/W"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6020F170836
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 17:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026507; cv=none; b=oGDcZHg4PF3FuPJrXgiZln1A3HpV+PssLYAD//VBADSeUAOBVfyr5qlyf7ZRtAV2fFMz5uObMk1uS3HKk6Q5efarbOdnTcf34fAuuCln4xjNOSAOnXgRkNCSneSjBY65ojWKNLcsXmrkuwSahGVO3+wD/V3hMIIUpy3njLlkKWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026507; c=relaxed/simple;
	bh=CoZI3yUWx1BNO5TPImZmrW26/7Ny1EyDudyCG7fX2mc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CsuS0EOfSa3rjV4qz4mvNKoeui68jGfIR/DM8QZZ6iqRjNO0MmynSkakq7/Xkq0TO19fXGGzv7jtRhYZYhEqGO1N7lHvu6gKfMpSzHnZlAfo/kC4Q1j7WTOr0OcycEGL9En0ppZFtwHzHhgpdtGUxACYvh1LyQn9gnUaonqk3vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yutingtseng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dlB0zq/W; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yutingtseng.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-70ac9630e3aso3552940a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 10:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720026506; x=1720631306; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NZnnrx3QXyY7CztU9U1okaz2oEAprba0zaynWPbW44Y=;
        b=dlB0zq/WYGDllgHGASuPCuo048mk3+TO1GyLKj5dveMLhmfDbpbUss41Tfhz2wQiAH
         VckJOYzA3mfY3Zj+LDNSuTkdf8AtPLREi1BXj22eAjd2qTwR6xIvKcqHBwxeGkNRy0s4
         AS3Hf+cvZs/BXUz2SpEKPxf4LG4QgI49gTJyjMuVahOhKpnElc1A/H92D7Zco4YdQWXm
         0/MUcBTKI2+oBXZ/XpKyaGBKW3H7IGzr6EESOWp9cPoj0zHLpb6ZqqJG63Omyp9GbIYa
         O244CbEVi6/IJArs4sTq5sCRN2V+EAb2eHidwJJUteuxmr8QWrik5J3EppJbEDmyiHwo
         0Yew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720026506; x=1720631306;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NZnnrx3QXyY7CztU9U1okaz2oEAprba0zaynWPbW44Y=;
        b=HNf2CO9RCo2YEdaVijIRgSja2JiOdJNz/5/yoeCV0rheSmwl7n5oCKgC9XNbSx38jf
         dcM55mADe6m4+4aNBkCyV/H/0x1fPCG/XixlcLQsFg8fKWrD775e5sbT1NFXzBpxDFHQ
         WAUrcIAPDRJdCddxyLkLm4wSrsSACjwclR83eRThv9ukARvcTrqhQGPu67cIHqw1cBYS
         abjRuLw+HrUhbTh7mN2scG3Csix6mcPP1u8b5TUwt7ZIFxseZrX6dJQJk7ab5dXN+V4o
         1unqpCLXSQ9VdmK9lFKcFR+2/vzKdqWrlQdLH1PzDJHKYmpvaQRNhQR0hJPEbwOMSZ8D
         W4bA==
X-Forwarded-Encrypted: i=1; AJvYcCU+XsygEXrYY9Ni+MeXsAgmwF1BBAy8q84e8wCXkbMHXy7mbqmgkCkxqe+fJ81CqKolU8vnrfWHTM9eklBhMRBD05Z+TJ801nhBWO/Q
X-Gm-Message-State: AOJu0Yyv3kyUcESdbyHJWmTt7Gqb4tA6ahMZcmINckai+aIVJdUx2sds
	Bnlh/Bs3eHYGexMwfCMmhXoApcRiMU8yRsbeD4KN6BxE/gOlywjRvgI4UEaDqSx5NT6qyU8/RNl
	wwNhTeDRRVL4UohcM6EQJBQ==
X-Google-Smtp-Source: AGHT+IGfM2PgszcdmtwW0N9jN7401C7zNoHfrP2bp3s5srd7fA9RFdcM6VtjPJLHKlcdogsFElXkteLgy7dO6VKJ9Q==
X-Received: from yuting.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:317f])
 (user=yutingtseng job=sendgmr) by 2002:a05:6a02:522:b0:719:3562:2da3 with
 SMTP id 41be03b00d2f7-73cfca7548dmr27477a12.7.1720026505519; Wed, 03 Jul 2024
 10:08:25 -0700 (PDT)
Date: Wed,  3 Jul 2024 10:08:04 -0700
In-Reply-To: <CAN5Drs06fbditeSaVLc6i6wEY+A47HHzQmhCS1rzJgacNs1Tjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAN5Drs06fbditeSaVLc6i6wEY+A47HHzQmhCS1rzJgacNs1Tjw@mail.gmail.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240703170804.3621083-2-yutingtseng@google.com>
Subject: [PATCH v5] binder: frozen notification
From: Yu-Ting Tseng <yutingtseng@google.com>
To: cmllamas@google.com, tkjos@google.com, gregkh@linuxfoundation.org
Cc: arve@android.com, maco@android.com, joel@joelfernandes.org, 
	brauner@kernel.org, surenb@google.com, aliceryhl@google.com, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Yu-Ting Tseng <yutingtseng@google.com>
Content-Type: text/plain; charset="UTF-8"

> can you merge the branches into a single printk?
Done

> I believe you meant to use the 'is_frozen' here
Fixed

> I think you want to add a kfree(ref->freeze) to binder_free_ref().
Done

> Typo s/An/A/
Done

> The memset should have a blank line after the declarations. This should trigger a checkpatch issue I think.
Fixed. Reran checkpatch and there is no other issues flagged now.
(except for line-too-long which doesn't really have a fix)

Also merged the binder_features change into this patch as requested.


Yu-Ting Tseng (1):
  binder: frozen notification

 drivers/android/binder.c                      | 284 +++++++++++++++++-
 drivers/android/binder_internal.h             |  21 +-
 drivers/android/binderfs.c                    |   8 +
 include/uapi/linux/android/binder.h           |  36 +++
 .../filesystems/binderfs/binderfs_test.c      |   1 +
 5 files changed, 346 insertions(+), 4 deletions(-)


base-commit: 14d7c92f8df9c0964ae6f8b813c1b3ac38120825
-- 
2.45.2.803.g4e1b14247a-goog


