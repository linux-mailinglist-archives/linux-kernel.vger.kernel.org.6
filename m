Return-Path: <linux-kernel+bounces-513605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3E0A34C52
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA92C188B271
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D683423F400;
	Thu, 13 Feb 2025 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4ia6jR0"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F6923A9B6;
	Thu, 13 Feb 2025 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739468780; cv=none; b=DLYvlDA2CuqT/O5XBcO6E+UjSZdXcA6n369v4dMjH6KNGasFitlMiOCMvsty+GkODag1zs7AQl490lkpFYNF/uqU1f060beL14zD7RuoH0oyJMcLST6tZv5rDuau3SWGd+/EzAYfpG0kId5VhbuDn0Zxr0FsX+WyfXym4XhBo90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739468780; c=relaxed/simple;
	bh=QxRPxCT2SXIKeS7AM9F4ZzqBqhBtj2+FvXdMZ+XT7m4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eo8Zsm/4ywthGGVJpr5IavlxI2bpdi9IfWC05XNAcVPcbX4p2BQIMLM4MqWaKFcC4+X9LUlH41lofZ0+wyNAT9nJ/R8EcqhSaZFasDhxwyp3PIitaXX0Snt8fRwiXINo8dGA7oeIAxdorwj4HhEgyHA+HV2MGoJEvu0/G0IpnE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4ia6jR0; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2b1a9cbfc8dso402085fac.2;
        Thu, 13 Feb 2025 09:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739468778; x=1740073578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxRPxCT2SXIKeS7AM9F4ZzqBqhBtj2+FvXdMZ+XT7m4=;
        b=b4ia6jR0MDz+dOojHlMRoe697P5qD5M2VIokyRc0Fxrxt4zY5sgO43DjwGtrV6AWN1
         kL3Z0K3TeXqM7xsm7RoZvP1x6G/TmBe2x5h2AYX0NU68y4UaExU+Xz3z6QUXF0YiE6OD
         GPi92lhqqLJjtinX9o0yX8dIfbCF6SoOtWDf/M/vP+XrwD/qV6Xct9M853iik2SyKTmR
         3D2s9FeSb/mLdJ94mP0Sym4ZxkfnZStLLnWt9w+cyPHza6HjhQ1GmscX1AaLInVi8esh
         EeKWM3GniNU/r7HLt1tAWzhuQuhoMyBYIBCZdop2XA3LVT9FeG60++6QlgebOl+pij2S
         9taw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739468778; x=1740073578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QxRPxCT2SXIKeS7AM9F4ZzqBqhBtj2+FvXdMZ+XT7m4=;
        b=eSU/4K/tSY2rPJhNSo1jkUHzbv5U+hFFA+/BjDAZ7owv3s93UjD8OW1jRtMBy+I76N
         /h8rcDfcGi0EngYbfWANXtz3EwmL/45l7MJHQCjPP+tkupekF94cvNi+YxareqDQWfUX
         9Wf4sjrBNy4f16lOOXIngsxzYk7QgezBqz15JiD/+kM1OlY6RUlAdHk1GwEfpgGRSkt7
         lkd9WnMurksFHQjyvPdEwPg2ds4rfMBW6Gqwc93J4+sLiDzwWQTLNU+48/OFCTrB00Az
         e5HD5pRJ9QNzXuVfxsTZrpAfyMNxQghIA40vzlFCp2lChdponYjIQrjZk2ejDUYPPXb5
         YUOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV42qRBdwDHb31K5LWU5eewtcM8Q9ajEeNQGAm+OjaoylC3XmIzAGj4z9jIt+GTOLbt9UIL1GEAlNVdDRg=@vger.kernel.org, AJvYcCX65pqDgVx9CAN6uM2qdxtrWbenwJylqc7xAYODIt/nfhmXX5ucYKk/vFJQfrnNHPBZsSenyPTnIJhBGRSao2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyObzGhTAzpgldd2jxUNlc8gVxy1NgpAKeyAgdWB/tlbgNF671t
	qt4XJhbWMgQHHGeaq8yvQUisRbH9uBLi9fWgXESRgx3bUwJiP1gg
X-Gm-Gg: ASbGncsAckurk5ybVLFt2KnAmin5OG2oZKZAEl4n83HvrKgyWWZyzXAkyTsDxB4k3zB
	KT+Tu7J/GRP3q/ReudE3EyRR13bKd3Au1xqa+Bzuq6LRfjmr8KPtImDtTpLb7mBQQYK8Cf+njOe
	ZR/zC3zArG8os8elU3XkfeF7mFXo7PF1uoikuTO6apBG4aeSER0VHNeJwG5szKBTDwlMUipNpMx
	ggigvwBhy6z+b9g1SjluLk7DG9XKZtn8s77Ys1Q5aeM/ROGcou8f9B0NiXI0PC3iWPZp41/JODF
	xPafEKPBKjTHYvVGNEYvXrsW
X-Google-Smtp-Source: AGHT+IEkWpokV/xb/L2HYxC4TV6Sj5owcZa61zP8F6TSfHL3AFADa8AyZCWgBZtHtKcYwmzKDxO/Hg==
X-Received: by 2002:a05:6870:89a3:b0:296:df26:8a6e with SMTP id 586e51a60fabf-2b8d68cbca2mr5198257fac.35.1739468777740;
        Thu, 13 Feb 2025 09:46:17 -0800 (PST)
Received: from linuxsimoes.. ([187.120.154.251])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b9548e762csm901537fac.28.2025.02.13.09.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 09:46:17 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: gary@garyguo.net
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	apw@canonical.com,
	arnd@arndb.de,
	aswinunni01@gmail.com,
	axboe@kernel.dk,
	benno.lossin@proton.me,
	bhelgaas@google.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	dakr@kernel.org,
	dwaipayanray1@gmail.com,
	ethan.twardy@gmail.com,
	fujita.tomonori@gmail.com,
	gregkh@linuxfoundation.org,
	joe@perches.com,
	linux-kernel@vger.kernel.org,
	lukas.bulwahn@gmail.com,
	ojeda@kernel.org,
	pbonzini@redhat.com,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu,
	trintaeoitogc@gmail.com,
	walmeida@microsoft.com
Subject: Re: [PATCH 2/3] rust: macros: change author field to array
Date: Thu, 13 Feb 2025 14:46:02 -0300
Message-Id: <20250213174602.200524-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213113420.5d2b7d97@eugeo>
References: <20250213113420.5d2b7d97@eugeo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gary Guo <gary@garyguo.net> wrotes:
> Spelling out commit SHA doesn't work for patches because it will change
> when applied.
Hmm, I was think that they would stayed the same

> Also, this patch needs to be the same commit as the one changing
> macros, otherwise the tree won't compile when bisecting.
This really make sense, I will send a v2

Thanks,
Guilherme

