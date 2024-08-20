Return-Path: <linux-kernel+bounces-293441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB42957F58
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B288F1F22683
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 07:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE0716D33D;
	Tue, 20 Aug 2024 07:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPtxwSeD"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560AA132124
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 07:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724138630; cv=none; b=jHy6A4U1ofRo5YHnONSUw6QK/PmifEpgxo/oBF+3gIHQJrKnQJW8bH3/ZA08ozM50JwaIMzXBv0QNci73ZF7B0/aYangOySr33+rq3pc5BM9agFjCh/ph8Ep4y6z/68QIIW2uG3xQ4MRKGqYVhYXvW6wXu2pExOCPxmDlgUkgFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724138630; c=relaxed/simple;
	bh=X+G+k2FjHKqYrPFHCDIljxgekW4+FOLirVYSt+HzyeU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mMq1VQ92nFRzSIQ3f8G1BpcNREkvh7zZr1v4Hkv9+PqH89mZ5efluThuwyeBcCeoiLWPCSp29cOKLU4sW+/40mXDJrv10ASGEMLzCw0/OWSQ7CKtBLdHiReXiB0C1NlGYoJ33ydgAi9BSAO0PQGNgI8BbbyzUCeAeF41y+6hW+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPtxwSeD; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d3bc043e81so3955933a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 00:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724138628; x=1724743428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9yMYfrVlcn7jEB7Z1jZxpyoc07o2XSXiNqpAOfcl8Sc=;
        b=dPtxwSeDl7KMHMCwqZammlbcfR5MR1Qikq8NyTtIwz5ZZq6dK0q4iCfMv54j+HL+YU
         0lL17/o7lh2Ut/1Yucm26r3wbDZ71rEOtNTHZMCfq/uocMM1UwJ2Iq3f5cdayztD8XlW
         9RMsdFRVdaqtX+u2KAhvpsXDvDwwViyk3P0qpfwLiXEqReUDMRJ3uwdy3qnYPHILKe6y
         EyXNNZ9iEXWjQTRJUDLzfITyHq+HjtE2qQqj4mV0K9NpFhwJHvz9pgsWnoWHAYWrX0KT
         AHCV2aai1Zgj3zb1/HuvvGkGRhIZc4S+vXhOH4yI94ugbGkABZkwkmk5KhbAxdNYBsfB
         d/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724138628; x=1724743428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9yMYfrVlcn7jEB7Z1jZxpyoc07o2XSXiNqpAOfcl8Sc=;
        b=FCEno12umOLY8iSXePInKdKrNHfZJhkZkD0ODrESxQkm0nrmpG8H1CLrBPpFUDHyCa
         RK3dKu28K7PRF8DpMTpt6B8lMY4rpdT+DLJb7T/pONszDI3vecqTGr4D6ihJT1FycAtA
         blygla2rbGC8wFp44fKEs91fzJkHg/nigw+md/Z5kqRSEteO+qgBrqEhRmSjv3mPKUu2
         LMC6KZyG/SQzaqKvm9bQ2lxzmM9glxa34x/Z96FEdqyspmNoMoUIBeyJGpZEa67yxs7E
         fiUN+fEAaNyqZ9oH8/oyQtegZwGsxeA5oBYrzOFIOj2D39ThW3WnF1Zcew89i8GC2BSL
         Zkxg==
X-Gm-Message-State: AOJu0Yw/gXVbLL5ipBSwltbE/beP3sd9C+DHDkBu3frewrgXXai3Tlwo
	V4s62jkJNjGo2cC9xYk63fTXYbfeFsNUVK0JvlrUP4/ZqV+ywEDf
X-Google-Smtp-Source: AGHT+IGayFqVdieVlCfk10UBloXfcf6dg5HQoXUc4THbOUdWSglhS00Lg8CS4hMRNNdHRngetpjIAA==
X-Received: by 2002:a17:90b:705:b0:2ca:7636:2214 with SMTP id 98e67ed59e1d1-2d3dfc2a217mr14436814a91.4.1724138628557;
        Tue, 20 Aug 2024 00:23:48 -0700 (PDT)
Received: from dudes-co-ThinkPad-T460.. ([49.207.208.106])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2e6d16asm8642488a91.21.2024.08.20.00.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 00:23:48 -0700 (PDT)
From: Rajkumar Vadhyar <rajkumarvad@gmail.com>
To: jacek.anaszewski@gmail.com,
	rbmarliere@gmail.com,
	skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Rajkumar Vadhyar <rajkumarvad@gmail.com>
Subject: [PATCH 0/2] tools/leds: Adding '-h' and '--help' command line options to uledmon and led_hw_brightness_mon
Date: Tue, 20 Aug 2024 12:53:39 +0530
Message-Id: <20240820072341.41153-1-rajkumarvad@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,
     This is a cover letter for a 2 patch series(uledmon.c and led_hw_brightness.c) The 2 patches 
     include option for "-h" and "--help" for the given tools.

regards,
Rajkumar

