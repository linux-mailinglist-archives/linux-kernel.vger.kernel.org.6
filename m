Return-Path: <linux-kernel+bounces-424784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E532B9DB95A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F58CB20EA9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C36A1AC43E;
	Thu, 28 Nov 2024 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZEZiX3RB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2EE145A0F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732803211; cv=none; b=YxuGDQROhSnjDWyzrwh8JvM4PAuqg/Vl9Y8sbgSJ+MblLMfMSiJBJJbl+9tXFFtu1/SkF1SHKU+sSsX16N/LVL/31qbD1Xog1BXgOOLAZSpBKYvPzxTqwwakQPggi7Pfd9VLSlSXsvQ5bXioJNRgojgfAkYqxoFgJx3kzCYy6mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732803211; c=relaxed/simple;
	bh=yD5Q5wZvheIwUXY/KFJ7wxZT9LtULBr2qSQmR67OXCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EgjZ6oFeycM6MS8dJMW7PdSxQWT9SQT8gO76Rqv6aBkShL6cF7CAwhj89daTSvmiuer1gO8kS7cvc40fFAYCN/W44lxOKZD21kMmJ3TCledQXHjsvZM27g6iniEm25hGXTi6S+SeZtVvcvd6dcr2I6WRdvVuAA23u37ofs1AV9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZEZiX3RB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732803208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eFsBZoz/kN/9IvyG8zSeZd+VHQ5VYtjhxgkca3XVrWM=;
	b=ZEZiX3RBKdgNbgOHVIg6Zl2PaAD0mupSjOGk215HgOaMaDG0UP/1hXEv9/hy8EERStUnvd
	yGfuhMT8UUL9A7oxDsi7tjWYCiGq3EsyehQaG9qB8meICon7huUn2L9yGJHszsFSZN3CwM
	ZASbyTE0Tg9PMWoxssLt8o7hrs/qVGY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-177DPWo5OEqna7x6wrUcZA-1; Thu, 28 Nov 2024 09:13:27 -0500
X-MC-Unique: 177DPWo5OEqna7x6wrUcZA-1
X-Mimecast-MFC-AGG-ID: 177DPWo5OEqna7x6wrUcZA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43498af7937so7038175e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 06:13:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732803206; x=1733408006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFsBZoz/kN/9IvyG8zSeZd+VHQ5VYtjhxgkca3XVrWM=;
        b=FbRpZ96XF4xDboXUwxg9rXaLqJKcGQjZ6CTBcxhiRGo4FfkknHY7iU/hp8xoGSK/tY
         Po1LT+Thckeml4BGxJP2ic88mNM7vZelpuOS1vlkFS1F0NNSsMdlu7AJo+WNchP0tJOw
         2lp7y/eIBW+mEDW1GKHdfCLw6DEnXoIXrpuMKfFP2ASd2aK/zRrzTuRp+J2Eh7QuPcv2
         zKuwnoi1Gz7Z7yDdMJkiA4uW1/aWVr9gpANC+H0g9tVpUXFe20LLhJlqeXHbu72SgJur
         96QdyAnImSU7fAncpPfiBX4LFiycs0Gk+wlyIrLE6EzvJt+woHlkppsFk5NYpGyUQa9u
         qIPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWp8cFIbAjkZIiXtsP2ZevBzu9L9t8/tENhRR6WVsp7mihG/4B5pJrRPGxDgY62UcQ4IR0MQ3r2ye5MLKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDZDmZ3wGE0FQ7ZAet5wYv7r6kcR7aF4HdNhfKNk41KhIS77G2
	MAT0QQD7XzU+5mE+0kb0vS5I149DiF72wI9mLdPX7Mv2A9Aoc6Qdunfdo4shEPxwMsXT3CkROfc
	YkOjGTdr+0r2qgcS0h8K0rPy3TV+QLf7petPbVR+MyHVi3tEhEx2O1vL2iE8Kog==
X-Gm-Gg: ASbGncujbxi3urVpOk+/U2f2/F0WqUPdLbOeFOiqv0/aeI+1wyqgn+lOr+S3RRXLaSb
	1c/U/NG/dJtrT/q/WiUrcsnuOlFqS6kCUO/lHRABpOTB04HyOMQVgO0nbih9z9wz2BC0DrSDkgR
	BBTapn1Z1EOCvF9oCatglZYIvmdQpuJ+JA0xxh3kvSllAbJe3oj4eDHURCzOVU6T+SEDLZuIGsb
	KdhgXvdDUj9ioZlIZjTT9Gz6gHis2j35ryatYvNIdLmuwc/Wjn2Sg==
X-Received: by 2002:a05:600c:4f8f:b0:434:9fb5:fe04 with SMTP id 5b1f17b1804b1-434a9df0803mr54354385e9.28.1732803206052;
        Thu, 28 Nov 2024 06:13:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqoUgC0B/BsNzaSIUqS8QJOqlXUm+jN1vmS7PC6QL4Ag9ticcO21txukzG7GnLpKYtYr5A6g==
X-Received: by 2002:a05:600c:4f8f:b0:434:9fb5:fe04 with SMTP id 5b1f17b1804b1-434a9df0803mr54354165e9.28.1732803205704;
        Thu, 28 Nov 2024 06:13:25 -0800 (PST)
Received: from [192.168.10.3] ([151.49.236.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bc11sm23790635e9.4.2024.11.28.06.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 06:13:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: boqun.feng@gmail.com,
	ojeda@kernel.org,
	benno.lossin@proton.me,
	axboe@kernel.dk,
	tmgross@umich.edu,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	gary@garyguo.net,
	alex.gaynor@gmail.com,
	a.hindborg@kernel.org
Subject: [RFC PATCH 0/2] rust: Zeroable: allow struct update syntax outside init macros
Date: Thu, 28 Nov 2024 15:13:21 +0100
Message-ID: <20241128141323.481033-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Zeroable trait is a marker trait, even though the various init macros
use a "fake" struct update syntax.  Sometimes, such a struct update
syntax can be useful even outside the init macros; therefore, this series
adds an associated const that returns an all-zero instance of a Zeroable type.

I'm sending this as RFC mostly because the diffstat is not too favorable.
This is mostly because patch 2 has to keep safety comments above the
"unsafe trait Zeroable" declarations.  It would be better if the trait
could be derived automatically, for example via "div rustbindgen" comments
(not my favorite syntax, and grossly underdocumented; but still).  That
would also remove "unsafe" altogether.

Nevertheless, it seems to me that this is a small improvement in
readability of the code that *uses* the structs, and it may be worth
considering it.

Another request for comments is whether the "..Zeroable::zeroed()" fake
struct update syntax used by the init macros should be changed to use
"..Zeroable::ZERO".  The trait does not reuse the init macro syntax,
because traits do not support const functions and it can be useful
to use Zeroable::ZERO in const context.

Personally I think it's not a problem, and decided to keep the two
spellings separate: "zeroed()" when working with the Init and PinInit
traits, and "ZERO" when working with the actual struct.  As far as I can
see, "..Zeroable::zeroed()" is unused in rust-dev, which makes it trivial
to switch.

Paolo


Paolo Bonzini (2):
  rust: Zeroable: allow struct update syntax outside init macros
  rust: block/mq: replace mem::zeroed() with Zeroable trait

 rust/kernel/block/mq/gen_disk.rs |  8 +++++---
 rust/kernel/block/mq/tag_set.rs  | 10 ++++++----
 rust/kernel/init.rs              |  7 ++++++-
 3 files changed, 18 insertions(+), 9 deletions(-)

-- 
2.47.0


