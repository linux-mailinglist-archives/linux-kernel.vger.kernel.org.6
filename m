Return-Path: <linux-kernel+bounces-429902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C60249E2880
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7F37167BEC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948D81F943E;
	Tue,  3 Dec 2024 17:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPQH20kD"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB6D18BC1D;
	Tue,  3 Dec 2024 17:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733245308; cv=none; b=qMYLjjwszrkuMeQfRdSbwTTwfSUW1TuB76LRXb60sPiWGfn/BF4SmtK5/LGAmpLVr1SL3yfO/7eYe46qg6eJpLVV/3iECh3V4B2LcFVK1Mdd5Gx1ZYTG5hWGCz85QF2p94h+I03WufA6mAwVJU7kE7t3C9yhMI6WSycw4VZnG48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733245308; c=relaxed/simple;
	bh=tciBhcrX1ruKJc73aKSBsfX26VebwBJvCoK5G12S92M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWjNTqlNU6UXFbfWINpa1ln3HKvAXuzQmhZJ6iKrLgJP6dnegYU0xVgGc7JcZ5EnBfiIeZnMGC8iKwDw0M8JIkxhNzX4RoeN+Z2QCJpkJrqRy2jrMNSR8erGJ+Evx9HsrZyKVa7Gu9m2sbmKPaQ4HCFx0hh6aLffzBDxJx/BvV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPQH20kD; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ffa49f623cso73572061fa.1;
        Tue, 03 Dec 2024 09:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733245304; x=1733850104; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tciBhcrX1ruKJc73aKSBsfX26VebwBJvCoK5G12S92M=;
        b=JPQH20kDwCopiBuWAjtzJim+n9zGiwSasv3n6FMJoADJn0TXWARSTPwVz9go6NFNpZ
         etrNYKXyNGLSk0XChdJwswJhEI/meey9eiG90Ogp0c9Uc4KkCEOtoSyk1UE7EEoQlE3W
         mDMkvYSqQPtjGMDzzuhQ741Eq5EYFxr6g2dgGVqZ2EQw33BziAu1W+/is8mp56gyeG0m
         dxp7lz0fFT5ho+i5GFJ26ye6cmEd+4vhetC9t1+LVTyf57lznFTTkR8YTNvNh9BUuHbg
         F1o7FZIbH1GiEAcQsvsxpFH/tLC333MIMyO92sFudwdsgYPTIp6r5GKdukDc/b9ziE+a
         zyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733245304; x=1733850104;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tciBhcrX1ruKJc73aKSBsfX26VebwBJvCoK5G12S92M=;
        b=HvksHsr91W3pJoSRf6WU+vXiTjr9Olsich00sHfL/7Il5cf5vhK7SkA0IEb9FMEBs3
         xkVhO51IGplDeGga3VEiZDpqDb2i2dnyU/p/z/afUtsK+Vd5D4Gi+slY0o2KERdTHY4/
         fdx4rY96Qz0D1FXDlYstVrOctVA6ZORteapy+K2fcPiN2ar0mZbsQ6xuxlSTSEiXo/Iv
         QYoE8ew2vOKjXcfB+FYqgWu7Db/yu0xuIZN1iqttx9xzhap+VlsmWdZSLJoxv329d2E5
         /zhynU39zAPD5yJqeLF8tk7vQ+MuZ+M3W1G9WhyNGyfZm/4mIOzQh2TWAE+ezPv43ZLk
         Y40Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUf7Tmo7B0NWE8JO+Q8EXUaGdGCB7Dwo9zfP74THNNa/8TaSzs7k5qenzWG7V/yIB5Z/Ac/UZ0SPxhBC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpZrBcWUbl906ZhvTxZf2cVK/AEB00ksPE0+cTwcsqMhx4N2Vp
	8KNqJBm/e8wZ/cdbQA8pTZAAg3Wq58AE3Yu2XzgeeaGmUlDGw24S6NmLkZlC7kkicIMIdpwsW9b
	phnREPPW5Q8X66ZOXQI0jeS7J7A0=
X-Gm-Gg: ASbGncuJaImvMXJTo2RaRcFIaQ8+mW3v7gXN1fGs4Utr6IKqdjkR8AB8bVi/jUPrQVL
	ImA/5PubuNeDEaYKRVepD3uaN0lHlObI/VM+yM73E7jzbt6M=
X-Google-Smtp-Source: AGHT+IGeSCqGcGYJdeWFpZ1JHdYudmw5n3jjjn46dIsoSyTlABD8yNwmRuyLgkM0MntY2kMS3gzXM22Uok8RoOxDrhQ=
X-Received: by 2002:a2e:a542:0:b0:2fb:2f7c:28e0 with SMTP id
 38308e7fff4ca-30009c52b4cmr24214391fa.18.1733245304127; Tue, 03 Dec 2024
 09:01:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107-simplify-arc-v2-1-7256e638aac1@gmail.com>
In-Reply-To: <20241107-simplify-arc-v2-1-7256e638aac1@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 3 Dec 2024 12:01:08 -0500
Message-ID: <CAJ-ks9mr2edW7LLna05XcUcVbO-m5TBvn0oYrSXQMAsfCtCsnQ@mail.gmail.com>
Subject: Re: [PATCH v2] rust: sync: document `PhantomData` in `Arc`
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Gentle bump.

