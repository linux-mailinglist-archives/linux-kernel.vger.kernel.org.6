Return-Path: <linux-kernel+bounces-545576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FB8A4EEC7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D305174FE4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178BF261578;
	Tue,  4 Mar 2025 20:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmLENvnF"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B459156C76;
	Tue,  4 Mar 2025 20:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741121469; cv=none; b=GVEOJEC8V8DvhviqgqHOaz28QD2yRMv5qSqnggadeWUdOyV+7H/2NrIdDXDegfQh77BIwryeIBTH3v2Bz5xFaoIp33VCl449ygs7cAcDOTbWR8Km0hl99IhJCA//v8p3sjZXmcisU39yrLdOszu2OrHTF/knmbMCkD4oKhDcqms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741121469; c=relaxed/simple;
	bh=qwR0WM2Lj1dp8M7aE9SPNE8YyQfH/b4OowZFRPmK1Ls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZkGoCBa8kf0fJ7fSucLvvN8QmwetfngPF345nZ5RtPwlFwsykWwGUcZ3TiT1zzxA5spSbZg5cYvTGnaQ+YccHDwUhB2cDssZ2EiEOqHkc/ZSGt09+3nfqzCT4Q+HVDSy9WgBPPpPgIkrWLxBvT7c71Jg1ZuC3icVgo4FrVeZByA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmLENvnF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-219f8263ae0so114271675ad.0;
        Tue, 04 Mar 2025 12:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741121467; x=1741726267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkB0vjNaxNWgx7N1eyQZ6caM4Aq/OnMYxZsyx2vyzm8=;
        b=YmLENvnF7Mq1hMvjb78ZFQDxKA9ZaNIWdIe8jdJwYbj/56du5Mn/9HT36fItxN21AT
         ZBBjzQYm/Xqb2IyzBDR2asnWVsDgJzgQEcdP7p06Ag0fjQ4oDIdqRU+OxeGJiuITO8vg
         7q08tVyJ9eIe7IszEupAZ0sF2oCL3lEoX+aw3wDKTlgBQ7p4IPIeAMB/nZH8T2uAGEYP
         ub2ictYa/7pnYR18pVC1HN3gMiRGB9jXNvRX6OqlJYmSXYnBuUhnonA/iFQbf116aeL+
         E8ozEhLirRpu3VdI5fX8m+PqM0nPmo4U5L9j/HWxH3wjq5PibAnqhh1jz+eQb+rN+cq1
         KzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741121467; x=1741726267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkB0vjNaxNWgx7N1eyQZ6caM4Aq/OnMYxZsyx2vyzm8=;
        b=F4ZKk+HaUpXsiMnyDAD+prBYqebHLx+IhraC4fcBqAAc0IVIY/QaUyOzhOgGcz/V0n
         GgFb/jbJkAGT1q9j37WKMQa49fcJVo9t8qRv7QjNQXb5Hkb374M5A7Gu9RXSIC2HMPh8
         gpcw9IhGN1ltUkle4JidTGJJfgE3fKnkBMjLlPSRU2bpPzp/GQsMiV9fQKYEkmTI/H/R
         qNHyvK58NrGAHtfrUPHL2XLnZnFlwrlntsC/SuyT6qMgF56mqP5LUHzNa26j9moihJ6v
         IU/G3IYMx/rRx4KVjGrKNoSDL288h86rW3NdfCAMhZrDIUaM52lAHOxzrM9n14hUaOz9
         QLww==
X-Forwarded-Encrypted: i=1; AJvYcCVM/E7CC1QSqxuXPWPLPIlAbG3SfJsnw8PC03xyia41j0/pMrOIcsX7TTlycW36w+QW1cnURAaq9vlly3o71v0=@vger.kernel.org, AJvYcCXwALfaNiSAFXAWUsUE1iTGqOSSdKk9+aTB9YqT2/gav9enMBI4CiEo9WnaCzi68al5fjQiIfqSo2JlZc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPlMePHkB64hf4NoU1rH3w7e/dnbU3Z3CPIyjJcx17z8398NWf
	bImKg3h96Yv2PKkPSvCJlhOw8SJaoV+xfDbaPNe3CWXbAYJzg8XX
X-Gm-Gg: ASbGncsLIWdyGC48klUkhhb/tSHHzsfSt1hVJZ0gCnqxvrPh49aJdy+O0zN2/C0uqQQ
	28T2qzQUFtU06m1W+h1O6p5LxkX9fLVqmKNyDf2OEb9xUlLPJMPzR36IMQxKXitIy83D6TOAElw
	lIOu6kmO9SgiQYFEA0qy9+M/ghiUhJ/+F0sfvi0ewWwmq6VVbemE+1ttTuWUFVS+B3PkfQ7QK9J
	81abwDRPfwLQs6fduVlaPp+wRuWhDeTWAY+uJN0DigpfM3Rfbb6GWIbTtL8mtlz6tWgSHPPR5Lm
	TfvRaYCFFzZOkY70HRzJ2m/mzYoWmchoKB8TM7XvO0f15U+ky/Vx
X-Google-Smtp-Source: AGHT+IFonFrcymViMosV0MVEu55WkaauxYs/oFVtTq2FLSiz1UNg0h2tfsPDvqw/CD+97zFlzHPOCw==
X-Received: by 2002:a05:6a00:170c:b0:736:3184:7fe8 with SMTP id d2e1a72fcca58-73682b54a53mr500511b3a.2.1741121467243;
        Tue, 04 Mar 2025 12:51:07 -0800 (PST)
Received: from linuxsimoes.. ([187.120.156.44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de1f7a6sm10474886a12.30.2025.03.04.12.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 12:51:06 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: a.hindborg@kernel.org
Cc: alex.gaynor@gmail.com,
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
	gary@garyguo.net,
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
Subject: Re: [PATCH V6 2/2] checkpatch: check format of Vec<String> in modules
Date: Tue,  4 Mar 2025 17:50:54 -0300
Message-Id: <20250304205054.207285-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87tt89gfe4.fsf@kernel.org>
References: <87tt89gfe4.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Andreas Hindborg <a.hindborg@kernel.org> wrote:
> Does what it says on the label. However, indentation is not checked and
> the following is passing:
> 
>     authors: [
>         "John Doe",
>               "Foo Bar"
>     ],
> 
You is right, maybe is good doing this?

> Another thing: I'm wondering if we could have a rust hostprog to do
> this check, rather than a perl script?
hostprog like rustfmt?
About this, Daniel Sedlak say:
"I think we could fight with the code formatting, because when it comes 
to the rust macros, rustfmt is often very confused and we could end up 
with variations like:

	authors: ["author1", "author2",
			"author3"]

or

	authors: [
		   "author1",
		   "author2",
		  ]
"

Thanks,
Guilherme

