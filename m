Return-Path: <linux-kernel+bounces-548115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D879A54034
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 02:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D3CA16DEF9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB98818DB07;
	Thu,  6 Mar 2025 01:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4e7NjmB"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27B9BE46;
	Thu,  6 Mar 2025 01:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741226357; cv=none; b=Bklgn1QmUfYbF/YnePwnY7itAFqK0IrXTRPbl7ckaPYp/WFteGdbLUBTTk6jURX4Dc+V3fcyI2XsC+ZqCaCR1OazWbw2vyPzA+vNoxy5Ltt1OC4Fmy6st/VvCnQgVgeHLDJI8OaZ5oUjN9/pngM+riejmSVuoSCARI90+Uab2m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741226357; c=relaxed/simple;
	bh=ZYAGVBJMfEUjNiE4J8nxMlWEvkEwAdGZtJwHCRZ/iK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oWXuaOTX4pVuqDB9XzY2ikjN/uVAle98/xz1VceXDJZ1ZeH7XmGlFKQbXSecu0V8pn3SzrBYEXxB6tIaAUYXHI6H77cu+RDzio+DoFCIUK+ax51aWuIODrA3pCM4q/ct+mNkHzNrgUJb2u4Kwd6HGS2OlrVNoezEHCeaXSSckeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4e7NjmB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2235189adaeso2720725ad.0;
        Wed, 05 Mar 2025 17:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741226354; x=1741831154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYsJK23daKHgIm6j07dlmIybSXF/ZOZ0EpP1y1aEC/0=;
        b=d4e7NjmBYP95FsDAySQDAZbG69ms+N7RnhQO1ShTNs5rin2epvPAIQE0M3Qqw5QWWQ
         J59RbCBDoll7+VAA8yTU0sqXREVwxMbz2Jdvra5gosAQZ+daZucPX9wTizlByWFU0XDd
         Z0EWEgVOOM4443ERJPjNiNSi7Fjfsr3GzeJPGxvkUqK4oFb6Q1hNRTJdkMEfC1jQp+xT
         o15v2rmwbagsG+kUTxxIBhesfffrKj/oMKX3/FH7G93zHFwJ6gI1YS8gV8rt1e3aft3A
         om+pFNr2HcOGz8ZwZKbRhXQvSojRzLVBZg08yvS9/IeSVEv2CV//sAhlqO414hVpJ9ks
         /zIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741226354; x=1741831154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYsJK23daKHgIm6j07dlmIybSXF/ZOZ0EpP1y1aEC/0=;
        b=o2x/ixtpLxyVR3q4vjk4MHkxNmbknCy3xKw83XvRnX4G/XyGczwpzqoH+bK28B8htg
         xHVaYOR4hCOFIwmupScPE4BIoVFbu9vw2XhDdhv1v0lKp0uOJshmkPVRBaoW2oYf7Gyt
         KMBxw+fPTltFmtTG+Tez3/XyUpZuCTB2y4FIgWhpaL1n6r3v38dyZWP1INIzT3NSjzal
         jJ15Vi8vS4U8V3JG3SLe3iZaxAJlh9CAkm0T+8RI1gXj3EfiaqlJ7t6iYVSfhXn3qF3x
         nWKlnsLwI3yanbYmbd5K233HO4lPw+6tKDtR24xNYpqdflQxeQ6mn17o12N+nnHyUdJQ
         TjXw==
X-Forwarded-Encrypted: i=1; AJvYcCU7/sj9NHlx/0lMZFk7S0ixKDAXWp8OarkTvbvLsH/yeU4LlAwwXjxX1nlFXNft83jufjeycB8y9RPNXSw=@vger.kernel.org, AJvYcCU9OA3vHwtWdBaIV20KiUoe4c6f12Rja5s0ORUZtW39P93rtBeO/stOVN9Onw+OvcZKxPTshpIEWpOVRfi54sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YynRz+ONLNTjVALJ0pn6igF9TiIX2rRXMGFFoBTR4RwlKIr7Yod
	el3TL9EJ7xxieMe3j55ekhx3C1R25FZUKawFYwLMRgC9NYS+f7aL
X-Gm-Gg: ASbGncsv3xI+3A9okux6bTbi4OWOp3eI6SFynRDJUBdfcxM5OyjcfNaQSKLmmWT9zUY
	rbT+vbxRXNGgVl3uGFKLoyAiXEvh6Vv8VEHywmNTcHsfNk36FMsMtEM5T6J5Isjm0Oa708bdGDX
	5g2A+O1qOfP1VKTisCfUiqg9cLl/xbWTQkii7j0DJTB8V4BWOIn876c3l05/Cb1xoDAlSuEht9Z
	BDAOVdN2mLWXAayHGwSododyqzY6N2ebBCKHHmvX9WIedvYz9RoxbQJiVmuVSsc1DGrYVkV8DPL
	TSt2Hx39Qj3wx/kaXF9fhWBbbgD/Hb7vneq6olAE/HMUg5mqXqgn
X-Google-Smtp-Source: AGHT+IE+/gyM0vU9hETwsdOynHzppu/S/lzqiPffh2GwcPFmJVHns7NdvfByvMvDHRBCl8nLNqSulQ==
X-Received: by 2002:a17:902:e74c:b0:223:807f:7f92 with SMTP id d9443c01a7336-2240948d29dmr22486625ad.20.1741226353955;
        Wed, 05 Mar 2025 17:59:13 -0800 (PST)
Received: from linuxsimoes.. ([187.120.156.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e84desm1040095ad.70.2025.03.05.17.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 17:59:13 -0800 (PST)
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
Date: Wed,  5 Mar 2025 22:59:01 -0300
Message-Id: <20250306015901.241800-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANiq72koDba445gMYtC_VEcFk2+O-Xg2-2y6uMyp7onBy=7rcw@mail.gmail.com>
References: <CANiq72koDba445gMYtC_VEcFk2+O-Xg2-2y6uMyp7onBy=7rcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
> No, Andreas means a script written in Rust, rather than a binary that
> comes from the toolchain.
> 
> I think it could be a good idea (it would be lovely to write the
> checker in Rust -- I also had a checker bot in Python from the old
> days of the old `rust` branch in GitHub), but `checkpatch.pl` doesn't
> need a built kernel, so it would be a disadvantage or at least a
> difference w.r.t. the usual `checkpatch.pl`, and we may not be able to
> call it from `checkpatch.pl`.
I don't know if I really understand how this would is do.

> Did you check? i.e. is it something we noticed, or something that
> generally happens but maybe not in this case? Is there a way to
> workaround or disable that (e.g. a `rustfmt` config value)?
The rustfmt have a array_width parameter [1], but with this, all arrays in rust
code will have the formatting that we set. (In this case, is 1 per line).

If we set the max_width, for limit the width of line, it seens for me, that
arrays don't are affected.

[1] https://github.com/rust-lang/rustfmt/blob/master/Configurations.md#array_width

Thanks,
Guilherme

