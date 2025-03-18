Return-Path: <linux-kernel+bounces-566956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B6FA67EF6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76742421D49
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1302063FE;
	Tue, 18 Mar 2025 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4frTxwpf"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECA3205E36
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742334094; cv=none; b=PzhKcCTdwo83IcYZnIA08Dw65mF7tyG3kj4wG0WRK2tAR31ECY8+/dUz+KBSXsjW5DwGT+qs23OuJh4ofnChjb0sFs5aC6aKVQ/V/MY9S0IipOG1x96CjY1ihLT3pA2JWXl41HaFZSw2HMM2ON32fld1lWYK2WnomGpZ7GtWtBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742334094; c=relaxed/simple;
	bh=ikVSyIcDjEAbw/xIoxMzWfbS6Uydb28wDt5nD4ZIUd4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sIpRTmYm5s+CvGKdesiNjtu5bvWDddL3hkVsUXZCxWW5jLo7oN/HrMdfwe0sVooH+jrOyoKtQDsvOiJEJlCTPBy1oXl11eO3BZkhjkgCk+gNZXVCbYUbgWgvBjGMtfAm6lzHl4ItJ2gr0yfZXzHs2IdZsa2HOOhbIZQAKBXdu5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4frTxwpf; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff6167e9ccso9042725a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742334091; x=1742938891; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UnIVkMBpPNHpHkzRiOFkBTXk7lARMRWDLlaFgNuX0xs=;
        b=4frTxwpfBkUdDd66o6UISQEQ7LC0N+ECOF8tYiqW7ZhsJmJdRuyBePeLQfGa8IUNPe
         d3GUlCExrNbMOXV7UR5uOlDsp8HZdNAxm6AWJhMwBJuem50E2dZNjDV8mGEzjNkncsLV
         xULCUjBmysEA/zNPz4jWLePtZHURg4Z5I3GrYiQeQdoFDXVhVe9B7O4JvqIFqQ3ZU0RW
         7Ac/pjVEypZT3M9NHfQXg8qh4HisZxYlxCElSexetCwNaNEufiomoKPXh/zWTg/l/4SY
         h2nSjeNdcy7q1Gm5SGtbtjKMTgDbqWsKALObr3NeGY/klWbq8JjNiXG47Hege4oHBuUC
         0Xuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742334091; x=1742938891;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UnIVkMBpPNHpHkzRiOFkBTXk7lARMRWDLlaFgNuX0xs=;
        b=HwyCGM0/n5MiEsAq++0Rrg0FrLH/cHgiS/fAx9XUp9T9Y1gqukD2W3H0enn8t7jev8
         1nZXF4R/kgwwz5ayt14sPqHwIKyh8CAHuIjXA/OKj08qGkSMWM5i3yrWSVyvRhbvb4qe
         U87jZpzXNFD+VBDmRF3w0vbUP7se3Jg7vEk/DNOCKeQqBiFah/jUb3WtY6VsDtt6Tr98
         eW1S9I476mI258ZDFNPbnex89bmtmK/NhkpDrv8DPbzzBUvr0c4274HHVX8toBEs5pfz
         Ve1khlZvSy5qPqoqvbndsElZ4GoLs5SlKCifEJvSIyL/ZynJrt0wna7GBXSZ6JGPDWF0
         gnOg==
X-Forwarded-Encrypted: i=1; AJvYcCXObb9vXsdbNj3c19qubgl9cQECRCeWzpLVU7tG90dRaIDIzTteScQhWifLOi/j3msAW2Z/hrEj5rV1+fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwZp2ZJF/3F52mxiEcE8EH2KF8XG3mB7KOb2cUQp4Ozxh6sviO
	8EDkrp9WCnJlBKjHFmDIVa8lShGmmsTXQ8q4+WHX2MVuR0YlVG79SrrSQD81FQsgcw==
X-Google-Smtp-Source: AGHT+IH5g0RwWRqxELrdXfaTvTVYsLQLg1QItq6jladHXzNeggEyGQsVp5rE0/DCSbV4ptgpJfGrPOk=
X-Received: from pjbsc2.prod.google.com ([2002:a17:90b:5102:b0:2ff:611c:bae8])
 (user=pcc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b4b:b0:2f6:be57:49d2
 with SMTP id 98e67ed59e1d1-301bdf714e4mr366009a91.17.1742334091291; Tue, 18
 Mar 2025 14:41:31 -0700 (PDT)
Date: Tue, 18 Mar 2025 14:40:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250318214035.481950-1-pcc@google.com>
Subject: [PATCH v2 0/2] string: Add load_unaligned_zeropad() code path to sized_strscpy()
From: Peter Collingbourne <pcc@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Peter Collingbourne <pcc@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

This series fixes an issue where strscpy() would sometimes trigger
a false positive KASAN report with MTE.

Peter Collingbourne (1):
  string: Add load_unaligned_zeropad() code path to sized_strscpy()

Vincenzo Frascino (1):
  kasan: Add strscpy() test to trigger tag fault on arm64

 lib/string.c            | 13 ++++++++++---
 mm/kasan/kasan_test_c.c | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 4 deletions(-)

-- 
2.49.0.395.g12beb8f557-goog


