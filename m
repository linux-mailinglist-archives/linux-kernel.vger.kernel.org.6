Return-Path: <linux-kernel+bounces-205839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A93C90010F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9F41F25612
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E220315EFAF;
	Fri,  7 Jun 2024 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tnaCFC+S"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B9115D5D6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 10:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717756689; cv=none; b=muOKsRp38Kep/teieDppAYIz0Ffssbj7MPQ27alSeOT0qp1qZ1LbAStGEZdPkk3mumpoDUHCpDfk9Rgm8N1XnzolOCkSJPw6Z4RiXSwh3rYc1ikEbB1UpINAKHIRQSOoZ2RipnDlDLlH0MPD/r7ZVrxTJnLCTMSuYOVH8dgnOSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717756689; c=relaxed/simple;
	bh=Dfhm+Ao2OctkWzCPUlbZo2WPxOBCaMO/F20ozOPjqus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=RwB0JubgeDP2i9Z2uvLRk/3ji5MYoFJEA77bQa+Zz6yco+EzD298CPGLbbJUdFEDKyLcEtoNKXa18lIGnbUIsQGjy1U0shWHYKNGf1yHlvALzOfB+G3vaqRIyT+pGFqe2LR+Xqo8LSpwZhEP+nM3X3OVkzB9JGynGS6Gt16nFA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tnaCFC+S; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-35dc0472b7eso1800538f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 03:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717756686; x=1718361486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dfhm+Ao2OctkWzCPUlbZo2WPxOBCaMO/F20ozOPjqus=;
        b=tnaCFC+SfWcqaMHB00quB4nInAKRiCZ3/LOVjc287R7qxnZjZpN5e3BPN+ZzlW3moj
         ggk+LgOorn0Q5iL2g/rIOfCT1w16yAeXwxMkozo0R4e/n0J6mkoIanKKU8LSUONCzPdM
         qQzreCyjRcpQhrPlIkhEPo0yzRe8WX2VF4QMHPVmTQa752KibDwCyHufFR8U0j7HDniI
         HSqKGj4GZNiN4/K3d0BTnbzGsyxEZo0K/xEnIMd/gjtqK9Q+RJB3j/2GC+fTuKX5ltsR
         xPytFClmybpR9z/J6wygzscxN6n8s5WuUuL0xUX22m+cfpfTnzwHIz6lesjdetA6VXKI
         MIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717756686; x=1718361486;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :references:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dfhm+Ao2OctkWzCPUlbZo2WPxOBCaMO/F20ozOPjqus=;
        b=F0/yvju41jg3Lsgrs5TAfkZu8ntUg0vvH6H8dJqVRMpCK1sliAwM/8TCX5dB2LAqel
         b9So5bdbdnPO1nLlaRfQPe81leuM0xenAmZ9mFk3dd5RzeYegn3QT7m/g2MB0E8ORb5T
         tjNzmDCUZpb/TBkt5uhoRJ79g8gSdHMUP9iw0AvdWJ1MwRIMTS/WDJ/jIO/UPVkOQHCL
         nEftBM4RjGxumY44HhoF+9gtk0ZnM9UJ0APj7UXNwmkm9UUv0Y+UipveNW8R5bb7Jdwo
         JYLN46WzTP8XEJacACr23+kZpZwy46JcytlwAiIH/GVH7ecFnr7S2n+FhUJ6uzYJWeKL
         jgOg==
X-Forwarded-Encrypted: i=1; AJvYcCW27vey5Rx118b7+rX1WGg/j/+xcBhXc9Ke+sVEijwNtA9o+PAP6LeNVhgKR6j9d82oAjnYeVOVi/PimnOkV7WlNhghftf4CdR19owp
X-Gm-Message-State: AOJu0YytCLcPIU5H/0b29kmCSPMPqkDAO+Hz3b2l6ZBRPKezh0OAOPwh
	uIRLSgrAYAFvkExS+SSwzUQUXs/aJqubdbmnTEKDQPMoyjGuZ/MNlg+McAuVdeY=
X-Google-Smtp-Source: AGHT+IEalbWRcpQcRyHzFdufx8s7rTDBgqplrK6U7baTcerM2u8XIM+miaw2LC/2FNTBgh129sR4nQ==
X-Received: by 2002:a05:6000:1755:b0:34b:1a4f:23fc with SMTP id ffacd0b85a97d-35efed1cfeemr1613166f8f.1.1717756686002;
        Fri, 07 Jun 2024 03:38:06 -0700 (PDT)
Received: from meli-email.org (adsl-105.37.6.1.tellas.gr. [37.6.1.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5e96d7dsm3675615f8f.67.2024.06.07.03.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 03:38:05 -0700 (PDT)
Date: Fri, 07 Jun 2024 13:32:22 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, Bj=?UTF-8?B?w7Y=?= rn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Erik Schilling <erik.schilling@linaro.org>, Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>, Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V2 1/8] rust: Add initial bindings for OPP framework
User-Agent: meli 0.8.5
References: <cover.1717750631.git.viresh.kumar@linaro.org> <e74e3a14e6da3f920cee90d32a023ba4805328a0.1717750631.git.viresh.kumar@linaro.org>
In-Reply-To: <e74e3a14e6da3f920cee90d32a023ba4805328a0.1717750631.git.viresh.kumar@linaro.org>
Message-ID: <ephjf.9236xxczfzy@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed

On Fri, 07 Jun 2024 12:12, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>This commit adds initial Rust bindings for the Operating performance
>points (OPP) core. This adds bindings for `struct dev_pm_opp` and
>`struct dev_pm_opp_data` to begin with.
>
>Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>---

On the Rust side of things,

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

