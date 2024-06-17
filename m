Return-Path: <linux-kernel+bounces-216996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B46290A975
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8132D1C2467C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390301922D0;
	Mon, 17 Jun 2024 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QMmixxYJ"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF369191475
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 09:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718616187; cv=none; b=Tha9/dfa64TI2OSG5aNafpxwH/B3r7w3ww9KmKy+dTgXGwv+s/v01FV4LW2m5hA+TUcmloKLXpNdTeYBJRKH3Ce5BLKzvixvRZ3f7D7Ciou5zPeB5EKoHfNPmyOzBAqaYJu1Tsl4Oy5Hw8fqKsElX/v/ol1RFScU3iH+HOo24zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718616187; c=relaxed/simple;
	bh=PJorj6pZybZCRAmgMBh4ooMcrMxupHMGQPqA/q11VUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=qt12w4omfHM7kvqgTcm5Gl8qXB6mEXQiV6UxQtdRWbL/eVj0lbJb+1L5NdieBzzhRzGBLfSzE52TEnr0dHmIUYqifMbSXU0vB2PbO3d9t0Sw1apbxZ1KPtAQs1+zq/iJoC2fBP6lNJKbaaxBRRvjTFbZWr0vXm1VMaE76GHDj04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QMmixxYJ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42249a4f9e4so28840395e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 02:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718616184; x=1719220984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PJorj6pZybZCRAmgMBh4ooMcrMxupHMGQPqA/q11VUA=;
        b=QMmixxYJV02w5jGsjaYPK8uw8ATgnsghF9FuhA/pR5z6LSPx5Yp0VH+XA7Ectd+eWI
         MYKVqZSeQwyHb9Oi64Tzm/kpOOg4wtky1ErU0NQXazVuquhtDbjgh2H3JqTfrWci6yMM
         xCNYkvY4zV/kROI8cJ9fVSfB5Q08v0NaBPNH/ekl8hrHepZH8VxYw7qNhiOMRQ9MYIqP
         z2VmWnV8bR5t07hU0AGVC13eCgbSD+ZFWmgKzHOcecE1Waw1chVScOiZBsaHxfqE3L/y
         Nhib8sTqPx+K2SODDlpEtqjKO974pznUsspuKiixZLSZICSQWVBMKCG1SsUjt5mYXPVh
         skgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718616184; x=1719220984;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :references:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PJorj6pZybZCRAmgMBh4ooMcrMxupHMGQPqA/q11VUA=;
        b=R0lohwQWp/Pokcf9YWgMqAx1CvRyaINd/zXFd9SOPeJwOQYwisHm1lT9EZl1j4Nkzb
         j6At1UUEtVY+f1s4P9b186kFzLcauvYOoB2+Av1bf8ht2DFSenv5F95q3XbM4wHjHFqd
         Zw+eNNF3GjoU52AEUAHk8twb2LHqn+LL8yjJ4GpaMDbkqMumPKAIuT71XdRkQASLObjP
         cVgK9C/z0Z1JuAXs9cFevwttzNfwzONNWylyj0LdEVl8ZqiW42bXv2jWu5kuZQJ3WZEl
         UyvL7JOWUKIka+m9h6w9OtJSEpb8mqXt/AWJqO9tTe+DcIwTCfPknj1TT55dB1OkGiOD
         N74Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5g/a7NacfSesyUfOYHSkp66rV6IGS1zPiR3l0pd62In72R96RVmgE8WxAmeMxcrbhsjFevHhFiDISt8PVq6U+B3rL3IoAjY7zXjM2
X-Gm-Message-State: AOJu0Yz6e4FT+O2nKkqWUh2KoubC/NIO+b/dK5gvkme3EJ6dVDbWd1YE
	Vixjg7efwBM+J7rMJ1DIzGphPWZz4l9MnOrpccfiVgSph492Uo5N1Tna0HaYpgw=
X-Google-Smtp-Source: AGHT+IFfL3Bs1KrLYPlq1k0cwv3eyK8lsf0inS3DFHb4TVzuMMGvXRsZ3JYsj7XJdNFeaX26ROtE2A==
X-Received: by 2002:a05:600c:1d1b:b0:421:65a4:2936 with SMTP id 5b1f17b1804b1-423048240b6mr85210755e9.12.1718616184294;
        Mon, 17 Jun 2024 02:23:04 -0700 (PDT)
Received: from meli-email.org (adsl-33.109.242.225.tellas.gr. [109.242.225.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422869d4f2esm192148015e9.0.2024.06.17.02.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 02:23:04 -0700 (PDT)
Date: Mon, 17 Jun 2024 12:02:57 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Erik Schilling <erik.schilling@linaro.org>, Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>, Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, Bj=?UTF-8?B?w7Y=?= rn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [RFC PATCH V2 3/8] rust: Extend OPP bindings for the configuration options
User-Agent: meli 0.8.6
References: <cover.1717750631.git.viresh.kumar@linaro.org> <37bdd7ee7b74292830dd9977154b08ebcf08a138.1717750631.git.viresh.kumar@linaro.org>
In-Reply-To: <37bdd7ee7b74292830dd9977154b08ebcf08a138.1717750631.git.viresh.kumar@linaro.org>
Message-ID: <f7wqe.d5i9jcj6qgw@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed

On Fri, 07 Jun 2024 12:12, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>This extends OPP bindings with the bindings for the OPP core
>configuration options.
>
>Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>---
> rust/kernel/opp.rs | 305 ++++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 303 insertions(+), 2 deletions(-)
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

