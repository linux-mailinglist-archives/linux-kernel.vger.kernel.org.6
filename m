Return-Path: <linux-kernel+bounces-377183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B30A9ABAFA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 03:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CDB4283B82
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 01:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF77327452;
	Wed, 23 Oct 2024 01:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P586qSRp"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E243D1CA81
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 01:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729646700; cv=none; b=SCwGnwJsRDlVK/06vIgyV/Te1kf9NJ5IKxbjec0Z4qh1vKVgyzyeer9KaZY+k7EDlemKn4iUfYeVLFXqN/HCYCNKI1sUFc4mSkEzcdSD+JjYQAgexrzBQrdzpaOlF1Du6opSI4Kl6ASD4GiTdMbk3L0+icGTS5uhf/h/5E4qDYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729646700; c=relaxed/simple;
	bh=hPWs2qQh8r49+Ow5gsWflRrQ0jnnYKu5fAj6FvRi9Cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aH2RRfPnGjDIfzNgcmwnVKyppsxr9PRQERwAdDCXnvsMM7EiHK9O1cRbUJaHCICwLb1szY4k/ZGmN3QqMB+W3iGv0XptgbmuiGY3l2GhsW8VWTXclIcw8CU8Wv8JvqwHJsPDiu3FQGEHEC1+RoR+JbgWi0PEwzQ17kY207IWBP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P586qSRp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20ca03687fdso99285ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 18:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729646698; x=1730251498; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hPWs2qQh8r49+Ow5gsWflRrQ0jnnYKu5fAj6FvRi9Cg=;
        b=P586qSRpw7BnARK5IckGTLrmJ+bDPMBDEKIxwFTqF7gQY9pjkw2GVTloJU1eXFlH2I
         iihW3jEqBCKYRY8Buc9rrWci/8HKrX1As0AIM9OG/3/mb92DBm32grP2b5LJ+YleHkYg
         WB/cNxzdPvWIPvCLJ7MM6JUSlF5ny2nJDKtxCHB7ZLmazu75FaTYP90kr0/mPT+iYX+F
         lFY16Hh65YzDm9+YH5XMmk6t6A4A+84eQ+R4yp11/9JWH7NyGhXHAPzmKyvcTtnq9NF0
         qnN6j60t9kAM3qWdo2zJA/jvGXvkxKbSXeGFhSFyubMQbwWWC9oUjEsGxnpS2GZz9fA3
         q3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729646698; x=1730251498;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPWs2qQh8r49+Ow5gsWflRrQ0jnnYKu5fAj6FvRi9Cg=;
        b=R+BAMqRQHXvbyH2o2Yfn8ioviUN0SYvp69UelpVmxion+Z3xyXYjy73osByr8PQWOW
         Qb4SIov9O5IxUtatA5m7lP+OZucPc6C5grcmBIlhx3EKVVGH/otO5T2rpnQLpEDIGjkA
         OXEy+rGpBEmypFVACeAe5rGZvwbI5jAOzD+YTFwI2OqCsCeDQCRl/QpKOg32Sw8JH0/S
         7QmLqyAWASG4EfbeJxVYS0s4NyKNg18J+4qNL70pqhMZV2tQ+e9DB9Q7AsVU8du267a7
         Bz6tcYeS6hP9rz6gR8g/wcklS2UbgugvdP9kXd5vJRMM3Bhv5qAVy3XTX2CYdoht0EIu
         NwSw==
X-Forwarded-Encrypted: i=1; AJvYcCWOlb1iR/i5DbtW6s6dnb4ThNFZ0N3nSk+Zr66/twSrD4aHDhfNauLsGi1DvWdMlemL8TtEjICU9gGkhxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGUck5QOet285f8piZlOtUPn8+X+stVwCkqQYzxhrIAYvQnrxx
	8IRnSK59/1NFAv/OG4KxU5CGm+hQyWE/kwsOYj4PpC8qPZs/6xWWHWyWdBAlHzlxcta0AR9hWNH
	LUKWNd27q4q2I+8f8L5WKHaM0yPiivPLRZbX5
X-Google-Smtp-Source: AGHT+IHtySnFJ/wtMH4cToWtpISPBhwLBbeMZltDNENstDI3IcoaCBw3MqxqjBlZ4ARzkwwBl3+JFt43iAl+k0Nhiug=
X-Received: by 2002:a17:902:f54d:b0:20b:13a8:9f86 with SMTP id
 d9443c01a7336-20f92f581dfmr1420365ad.28.1729646697873; Tue, 22 Oct 2024
 18:24:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022151804.284424-1-mathieu.desnoyers@efficios.com>
 <CADKFtnSGoSXm-r0cykucj4RyO5U7-HHBPx7LFkC6QDHtyPbMfQ@mail.gmail.com>
 <3362d414-4d6f-43a7-80af-1c72c5e66d70@efficios.com> <CAEf4BzYBR95uBY58Wk2R-h__m5-gV0FmbrxtDgfgxbA1=+u0BQ@mail.gmail.com>
 <1ab8fe0d-de92-49be-b10b-ebb5c7f5573a@efficios.com> <20241022202034.2f0b5d76@rorschach.local.home>
 <134aa32a-f498-4111-940a-2f79af70878f@efficios.com>
In-Reply-To: <134aa32a-f498-4111-940a-2f79af70878f@efficios.com>
From: Jordan Rife <jrife@google.com>
Date: Tue, 22 Oct 2024 18:24:45 -0700
Message-ID: <CADKFtnTdWX9prHYMe62oNraaNm=Q3WC9wTfdDD35a=CYxaX2Gw@mail.gmail.com>
Subject: Re: [RFC PATCH] tracing: Fix syscall tracepoint use-after-free
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	linux-kernel@vger.kernel.org, 
	syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com, 
	Michael Jeanson <mjeanson@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"

> so we should at least get a Tested-by

I could apply this and run the syz repro script on my end if that
helps, since I already have everything set up.

