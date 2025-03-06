Return-Path: <linux-kernel+bounces-549449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B7CA552C2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 348293A8ED1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F2925A2AD;
	Thu,  6 Mar 2025 17:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxhP4wAY"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058CE1494B5;
	Thu,  6 Mar 2025 17:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281524; cv=none; b=f1nIpQxwdyxnHJa3j6wtIk3uVyk5KNlBb+GIm2Sa2W5/tHUmeVt2shKcZ7VtFj16cXSDr03CgGpjQigS28ntiSoXVYkqVSh9aW8MHVZAO6uSbhmkgGIrmt6pCVZHvZsUu98XQfsF0bRNJ87U/vENQW/WNSkdbr2/V228t7n2MRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281524; c=relaxed/simple;
	bh=395x5AyGRqSAYneg2mz2L9F5gpCGkhuEWJ48Cofvc3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qreTXVo51Pc+xjqdDXTS9DRGhEdT9N77qY1MknAEUqJCsF6b70w/SIdMqRC3uVLd37UoF8VijGd5lIE7iSbWfTczJh0ov65HJ3dyKURvEf8N5Ifar0jepR0AVnM/N2h53QxxHy8VN9W5DFT7G8Zy5H0lj+nc7/uK5kyZn2lZpCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxhP4wAY; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224171d6826so17042285ad.3;
        Thu, 06 Mar 2025 09:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741281521; x=1741886321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLcbW4YRLVL48lfvUUsSf+uXxoiWIb4cMrwCVJEXxyQ=;
        b=mxhP4wAYIxrxi8O+Ic5ZTTyVYG2dtY2YhtXpYvlQB5XobdXJh5rwzSeNjmfHqBlmjz
         jFmd6cWhu3MIT8dM5EcVUvyg4TyeHaO4cNpuILDJ4ynYJGEq2kd7nThVB0W20Z91ULDn
         2D07jJrI4XCYI5GzOhlYHLlPvJUH4fZteMqlcpL7Nsopa1mRos8LyoybcM0X35sOy4qr
         yrW7rHCuWZOlcNGnG/RTNqfsaItmziYh8v0qBh38nla2/ecgzfgj3dtsUIIWWbTOFiBP
         +0E89xqin1vpPEmd8p5JeGb7NPkQVywXqsqZBGpQiU8nZHQB1qEpF98ccivAUR5WoQxD
         Fg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741281521; x=1741886321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLcbW4YRLVL48lfvUUsSf+uXxoiWIb4cMrwCVJEXxyQ=;
        b=g0Q3K1eG87IW9A7umVn47SF/UgGquiXzQOPYXfxTNbgPNpcllP06n7LLWP6VySi5rK
         K5RKKlf33M7M2brnsuaBjg4V6DVw8ndiE7EqUk+DT4VM6kJ1C85+w5KjEC2+9rBFEBW/
         8wbmXlKFyUnb6eTzAp0PAgk8eitDh9Ahl6QpjaiCz5PCQ2jxbvxSYJM/hXb6wXZDd+s9
         jS96WDGf3hICGn3HVkIhTXuoaAwYCUET0+O+4Qu2anFUz3IiG5lfjwiXyRzYkWDqLGui
         Oz76y1KXRZEz7jXS27MPqLtFA3nTx6GI7L8agw1w2OIMhXkCn4U3Oss45er/5ZMQar4k
         Aq5w==
X-Forwarded-Encrypted: i=1; AJvYcCUCSUORmEtxsBg0+CrgKBava9CbDvj7BdehK9LW/EauRm3C2ENUFUEaHgp0khikaNFTmJGfegwvNJkT57m7Kxo=@vger.kernel.org, AJvYcCWXzBT17rXJdetZSardd+14xWS4AWPmJ/9kKEd4oXu2CsBYPCIbfSi0p22lMbJ1Omss8VeIVLn6fdvSp2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx86fvvxxUshlMWKJGDM/+geLjg6hgx8wQ4TktwCm6PkCNx6dqC
	z17MwR5V9WJAzuxXjZ/XKKXNhUQW4+EXWMIvtt05QhcTow7yyNvG
X-Gm-Gg: ASbGncsQToA9eofpOGxhNSy7Q5zRarQ3JeDp4/jmUWG47FMB2COx+T65lSaTL557bjP
	hpUA7yS/N/QvdacjcmeBEjbTZ/G+MBxl1pIneruEcraSPo/wgbR5+mijLdq3zdAm6vBq1iw5lOx
	hVhcpmM8yw56nGcMskAQHme7A2MkbgMFSxSqAaE5U9l+e7i/1DIdG8Akm3hWEOuVpFcw6DM2ZnF
	VEBFnseOltVvykbmPN3uxWQCI2j3Mspcq+qALPKT9svjIFS4z5LJ2FEwCCP2rzipuLKjYFQGVKC
	aD1wCGhbprxKelj+BGoKKDSDyrv9TztyOL0PrWSaEOV05+ZotXMc
X-Google-Smtp-Source: AGHT+IHeeys3QZu6VDhZ8s3MM6QrswxXbPxJHU7HlCS0a64b+dUVEPa6Zj1+IwyqEAlsMoigY4EzwA==
X-Received: by 2002:a17:903:22c8:b0:220:cb6c:2e30 with SMTP id d9443c01a7336-22428ad565bmr620925ad.49.1741281521131;
        Thu, 06 Mar 2025 09:18:41 -0800 (PST)
Received: from linuxsimoes.. ([187.120.156.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410ab45bfsm14914115ad.250.2025.03.06.09.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 09:18:40 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
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
Date: Thu,  6 Mar 2025 14:18:29 -0300
Message-Id: <20250306171829.365809-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANiq72nXzY_j38ytE7KwHpH3Cy4sDw85WU2MyUe5u74oB2UP+Q@mail.gmail.com>
References: <CANiq72nXzY_j38ytE7KwHpH3Cy4sDw85WU2MyUe5u74oB2UP+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
> So if I understand correctly, `rustfmt` will simply not do anything,
> i.e. it will always keep the array as it was -- that sounds good
> enough to me! Most people will write it correctly, and for those that
> don't, `checkpatch.pl` will likely catch the mistake -- that is all we
> need.
Ok, but, how is mentioned by Andreas Hindborg, this scenary is passing:
    authors: [
        "John Doe",
              "Foo Bar"
    ],

Is good make a check for this too and senda a v7

Thanks,
Guilherme

