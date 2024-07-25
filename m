Return-Path: <linux-kernel+bounces-261864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A81893BD1E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459641F2186D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B5516B399;
	Thu, 25 Jul 2024 07:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="hTWKmzBk"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8D610A11
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721892717; cv=none; b=q9naE2CS/Sj3GsxAcggWif/FYmMELxKlM3QjcW5Yi0YPQ5OXHGkF9fjrqExprS2xCeo+hM19cegRMH/Eiv/skpIC1wXJp1hRoyiPdIT/uS/Vjtothp6sYq8120IWB9fndfPBjbcir9w2xQOc5nnYguOsDcTZH0LJy+nC9Wdpz6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721892717; c=relaxed/simple;
	bh=dCfrG0mMMDH90+ni8hVvERd1NUm+mjOtXT8a065O+0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iX6axaPyIZB4SpYayVbAj86PfuC8Lt9vbU8au04xFw1EgpQ8FRORd8GCsmQhGY/3EQB/QuegR5WsZcNU8qRs76+vOqxaJvi1emJvOgjezpDwYAA4QSfhPyCRXkvYMbpPRgBYQW9LP9hN9mX0Zjfqvw2xLR1Jjka7eD3aTmPqfQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=hTWKmzBk; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e05eccfcdb3so487862276.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 00:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1721892715; x=1722497515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VvZ4DTblxYxly9G9vL3gUkX/k/yzmXgKCMvFtxah1qs=;
        b=hTWKmzBkR8LIOntQGpB0H+9lHcZmONQazH7TMkzO6bAx4HSa0v/D6DJ8EtMZpJJ42V
         kEgy1ld1ZxZJSNz3Q4GDavPc6iAy0oeu1FMN/i3AUQGV80CWJQktL5Py//2XqxojwlCL
         Lk+bON3LN5sdpXc5c8XOc9ct4OJOYu/SG9MJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721892715; x=1722497515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VvZ4DTblxYxly9G9vL3gUkX/k/yzmXgKCMvFtxah1qs=;
        b=NOy5A7dC4+2siRHLSJuaKiGlAXL9aWCO0riyVx0Zppp0eN42YmhBIUGg+BAYtHvXX3
         0EXGhHSCChrFCQa2AfBu6/xakb82vA8XkMBxDAdgqsfEIVQf9lyKeosQZfMcyLZuCciD
         8+OBMWThT1RJbh8yU2sC2PSMfasg48wOWD/4TmKJ0qHyBZyEzda0IibHjnJQJ/DfaDOu
         EFOE3qVbeLFnFAhix9MAc+XCvjWUMVhYmPO2Qk4/h/codsTvopG4MAUiSPVMO3Qdu8Ud
         4KxiuPctWT83VC8KZO8MII/gJKVvofOHD4u58GpY9kX2rSATd1/cD3k2zPY679dmY41T
         vPXA==
X-Forwarded-Encrypted: i=1; AJvYcCVUZPJOjXM5a46wIdkkx6xj3hU9oCbSE5oVzjWsQRjb7nsII/CKK2PUXDa+6RO3t3qXE1fIpIEZ7JqwvBY803ABdz6csD1CGWn1fLAe
X-Gm-Message-State: AOJu0YzngEsDFa5nyLbu8czL60rGoKR0+03T2DqJT0x9ck3rOLOuTeg0
	bqcKTJF1lSr5UyQJ30Iz2BeWb00KEZuR90IF8u1GyBfTMchigHHfu4j2Ha3Q1dQ=
X-Google-Smtp-Source: AGHT+IEQ3ilVsGS4D0Yn0i3rrErdJYCa0VhU+F+tFJqk4zJ4GND8LiLWiZXrzfjIIg4gfIYZK7uezQ==
X-Received: by 2002:a05:6902:240f:b0:e02:b9ac:1486 with SMTP id 3f1490d57ef6-e0b2346ead8mr1859811276.57.1721892715002;
        Thu, 25 Jul 2024 00:31:55 -0700 (PDT)
Received: from localhost ([213.195.124.163])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fafa1aesm4291046d6.133.2024.07.25.00.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 00:31:54 -0700 (PDT)
From: Roger Pau Monne <roger.pau@citrix.com>
To: xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org
Cc: Roger Pau Monne <roger.pau@citrix.com>
Subject: [PATCH 0/2] x86/xen: fix memblock_reserve() usage on PVH
Date: Thu, 25 Jul 2024 09:31:13 +0200
Message-ID: <20240725073116.14626-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

First patch is just code movement, the second patch is the actual
bugfix.

Thanks, Roger.

Roger Pau Monne (2):
  x86/xen: move xen_reserve_extra_memory()
  x86/xen: fix memblock_reserve() usage on PVH

 arch/x86/include/asm/xen/hypervisor.h |   5 --
 arch/x86/platform/pvh/enlighten.c     |   3 -
 arch/x86/xen/enlighten_pvh.c          | 107 ++++++++++++++------------
 3 files changed, 58 insertions(+), 57 deletions(-)

-- 
2.45.2


