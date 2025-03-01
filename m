Return-Path: <linux-kernel+bounces-539741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83CBA4A809
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 03:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AB347A8567
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20760195811;
	Sat,  1 Mar 2025 02:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VErMNgxL"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB623C0C
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 02:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740795819; cv=none; b=VRFiiXBsf/vE5MS0eWw+TE+mG/I4YkVDQEdtaJbtPW+XwuZb2O958Jo0MbtX/CVN1dfqlIts4+686GfLZ1WWbW9UDM+I+mxfDRwU+4moKjT5dze+LGoSJVmxFG1kOUJhypghyOuc96GOa+Q7+Q0abehBXOKiFoaHfVwbVXXirRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740795819; c=relaxed/simple;
	bh=/iJC7ZZ0UAHcIY+EsbFLVy5vOdJXxBEZ75070krP+2o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OCrHmesaSheSWSRjwoOP0LRQiXA2APMirv4iQBTye7dX6+kBORWt0uFCP29Wro5ZpxtVOOYF7R40B+1+7uswz61DOVYO4cNdScUuUVgs6G+8mANTl8GbRDjHo9K+VtFq/6nhFYaNgE3wOOJIKPib3Flo0LznYcJJ/NJnpyaU4r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VErMNgxL; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6f74b78df93so25969597b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740795817; x=1741400617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgnPYGo1br/XdlJIX/NQbWvegLuBLl+0tDsfBISzu2k=;
        b=VErMNgxLoo/5FDaHbMyEn8MQsMd89qlbYmhn2p0AE1XgCegJyv+WVMGCSoYVbotLt7
         SnYZ+bEETITgkxw5FLmISj+74iGBQzp9PNjjbeFXM7kMqsxEgtmLuGRQO4QBxkI9pGau
         kWY6K7vPajR/KlUT05LozxQsRAk8BlVTpfwDMrvsrOBCAimRVDBcXYGCYEKwYhrQY1sc
         smWGcClkP6nv/oZ5z2psJ5Rh3a9TwVRtwzpmAczADpi6iFpTSoBbavhBLAsgRoQUiDP4
         oOyl+zqI4gCZD6mJzRzQekiUWW427UBp/8uUn/QIHea6+1YDEtG+ViQxtVm8cCUiemcv
         5g4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740795817; x=1741400617;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgnPYGo1br/XdlJIX/NQbWvegLuBLl+0tDsfBISzu2k=;
        b=p5dxylasAn5kjJAbxXnmFgmlMEgvIfzwf8dhJE8h2UxD0wxAq9Gr2FOj4DnUlblhPy
         MNyaEaFkmpkRxXt5DYp9ZPG/K5TP2TZhqRxGRB5n/MwHmHsRUnBJVacE3yerkPQ+4J/u
         JDQOVcbGw4buWGyh4ECx7Ux730Cn2hItdfeYuNX+jyoE/dl6PWIf/pn0HZ6JNxaddkz1
         mbSCnwfQDYgHQMQ7l797G9HpNNQjBg3Y/s5uXPkwkuUxd5mNfSQLmGNF5+78wK5Mdh/B
         jvF9JDOIOdV84lJrdmktydoqvi75nHjfoCyGtmRD7DUInlbgwbW5yarh07c64D6EWRtZ
         CRlg==
X-Forwarded-Encrypted: i=1; AJvYcCWJxMMjapaYcnhincxe6rjJ5dX11CJN3gfSsLndLmbjXn4gAOBMAcPaWn00ApuON+5r6d6yUj8WZwQkhH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4gjqeNH+NAsxVaFabvdURFBlKTqBt+z1LuTpWAUWxf1H7H9/L
	aTlHiJcNGUlWGpBZ3sy8JfX2RalcuqMKIzhrhO03Bn6L4zRcLfOaXG4+Alclids=
X-Gm-Gg: ASbGncuYpQOAGqJ2kyHgZ/7g6xqESGe9ii2H1dhTfBTViiFN9QmWCeiGvrUBmo15QdH
	60JfR9csTUJs+cribQKOkVpnr/M3xBQOcBX6vhXtW2lwyhJ4v3aOlG34Nx/ns8YVD9ReuzAQAjk
	kwnQipqYyWOwxV6k6PSugCrHBYuhXJ++jUTQaUfLFDXvPnfAWNGXbO3kcebRbCqeqhFe8iddcdm
	3XmXr6JCARvTZqeDVNyzkAbncIaNYdfnNdpOWNzmpUUNubZYWVXzFUlFFRVq4xk7tNXkP0dwAyW
	0mJ4dvyYfTlIYHXkzDnn/iqNgJ52L6XqEGWyFuk=
X-Google-Smtp-Source: AGHT+IFpVfF8vlZh4plPINDaxBlipPQen/O0lp4jkw9BN8vWuc+gldnvPAzkxEjPwH4u0FHGAxtxSA==
X-Received: by 2002:a05:690c:3001:b0:6fd:44a5:5b68 with SMTP id 00721157ae682-6fd4a100420mr83481277b3.35.1740795816982;
        Fri, 28 Feb 2025 18:23:36 -0800 (PST)
Received: from [127.0.0.1] ([207.222.175.10])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fd3cb7e02dsm10175307b3.84.2025.02.28.18.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 18:23:36 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Pavel Begunkov <asml.silence@gmail.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250228223057.615284-1-csander@purestorage.com>
References: <20250228223057.615284-1-csander@purestorage.com>
Subject: Re: [PATCH] io_uring/rsrc: use rq_data_dir() to compute bvec dir
Message-Id: <174079581576.2596794.17941051100907210365.b4-ty@kernel.dk>
Date: Fri, 28 Feb 2025 19:23:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79


On Fri, 28 Feb 2025 15:30:56 -0700, Caleb Sander Mateos wrote:
> The macro rq_data_dir() already computes a request's data direction.
> Use it in place of the if-else to set imu->dir.
> 
> 

Applied, thanks!

[1/1] io_uring/rsrc: use rq_data_dir() to compute bvec dir
      commit: 2fced37638a897be4e0ac724d93a23a4e38633a6

Best regards,
-- 
Jens Axboe




