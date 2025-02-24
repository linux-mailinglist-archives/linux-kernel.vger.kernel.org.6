Return-Path: <linux-kernel+bounces-528185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5DDA414A0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 06:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692961892056
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 05:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E021C7016;
	Mon, 24 Feb 2025 05:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XefuTDvg"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E0B1A5B81
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740374049; cv=none; b=uct4Q1dpowdpB6G1ZjpqRioBnAhvJ7mEkg2qeOc1tqkV+mdBcmLssCEziUB7sCqZmeaMAhM8DrdXak9y8lhmCoqOvikmiK+Lap7nOqgATxADolMExMwVi+M0+GOHTsAp5B5578bhwTnSbDRjAQ6Iv0qeQxh6N7Esz846wfLLpZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740374049; c=relaxed/simple;
	bh=cxSQuQQtbQOCfR6+umVvSr7i7TkqT67zGAdQTxDz4gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSue8x24hOmxrsZZjI5+ozAjG3/CSfm3wScR/boBcYIhHMaF41tAG02w157EGDgIkAIIKasC9sxTDZi30+XL0iIMDgwsnrG+C/YmL8fiQwdOkmL84vhsUYmbdUxQTvrF5He7Ig8+NBV1uJDq8UmDRjYAbQnOgO1qOlpucmoXoSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XefuTDvg; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fc1c80cdc8so6126347a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 21:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740374047; x=1740978847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+joD/tYf7d881SCRKiox9DoLZN0Dh3msjbOhq+t3e2c=;
        b=XefuTDvgkxfT5r/jEba2bPNa9ZbIBvu8r27O/lGhKRM4cbc6Zrs1/RnhnIkIp5//8b
         Ft9n38+xgCzKVuAT871Xgj3drLI49JRJAyYyLbzm9XVSHeo5pGGK1lacSaJY1G6cnqZe
         vCDOS3e2j5f8AV9pbr8fVLdth7+vlFVtPjLpd3TOAi6161TBL4YhR4Li/z8cBqtYot7s
         dgtRMeEIzXTML0LnZp9ugyxmPiBCN+EVeaKjqx8kvGrnI2KPN8m/LFK8idb4DeaphcDM
         uuflKyGkRaTZVtdLGxj8w3Rbh5h8QOebtmgJc2rC9uF1IJ8eEtrhMhqVEjINNs8sE2dp
         JnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740374047; x=1740978847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+joD/tYf7d881SCRKiox9DoLZN0Dh3msjbOhq+t3e2c=;
        b=QZpCi01lyNo6V64BTBGXsug44N5ai7dFhgoF8ir0nX9GrjaCY5o9INS+f3opn/IWQi
         Q527t+7SvWrhmtdIpwKK03CZQ6djuXDUqoZp5xrme4UKXIgrYRmWkpqinPX8AxLXre11
         jbxfQjvI9OPhAq6wVSiU4LcRrM9RsaA+T3UIY+8YBAhT1VYhHYX9Uo6ELzVZUIMr5Ipc
         C32P5CdOdTF/f0aimh9oKvvp3LgAJ/otc4rmSRYOKNTOr42uyikn5w3RT5t+PG+ay90o
         vNtlGgLPSPTJ8pu+sTC4kFvoapSNz0HRUnl2my43Bzmtld8uHHHLQBw/zS9LQb3O9hrA
         JD7A==
X-Forwarded-Encrypted: i=1; AJvYcCVR6N2s/ZyYgGDjIkaq6+riyDQq8BNO0/FPnBONkUR3rATzN9UHOCFRy5uyY/rSeeKEjcZfJLF/3+ckbyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhu/V5M3qwgT7XUNM7aQvLO9CsJ+8WwnpniIlMGgAJDhn0OyYh
	pjEpe/FbXR4LjaT8NxxU3Cuo71ZDcIzsSBoLIl+faw4os/6fXS8I3G0K3+5ZGjk=
X-Gm-Gg: ASbGncvWp1aECUNRmofwxU1DIxk6z1HN09SuXZ9keoE+w3W+ZyfkYiK+2BwI1O8M41o
	IWD1UUaSPjMPxgPv5nb/nDpsy0r/Mmycg1XkrYFjhrz1vbqzegjdWofySoDDcDeQNNZMW8Gfzhi
	5CBKD7km8lDvKvyplkqjg/YW4tNxAE0OiAbI4IgfXp9/tra6g6xwE6PXJoTMsP6qe79urK0QE+o
	x10wrk5SB8G3crm7SCuCnAZeK1F22627tLd1A6RM+iZ7empfZC5sr0KwdnPiFcxnzD7Vh1KAgi8
	qvqyYcz7yxyC3PpwZqFsabisI/A=
X-Google-Smtp-Source: AGHT+IG0b6emkD0CmhSV1QNXb4HVeu5MkvIkiNO02AEPBxGCijtAK2X6heTwZs19Vt7813cTnGENng==
X-Received: by 2002:a05:6a20:6a0b:b0:1e1:ad39:cc5c with SMTP id adf61e73a8af0-1eef3c7718dmr22515662637.14.1740374046890;
        Sun, 23 Feb 2025 21:14:06 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb57c5dee4sm18114799a12.14.2025.02.23.21.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 21:14:06 -0800 (PST)
Date: Mon, 24 Feb 2025 10:44:03 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] MAINTAINERS: add rust bindings entry for bitmap API
Message-ID: <20250224051403.k2x6deccboytjcjw@vireshk-i7>
References: <20250221205649.141305-1-yury.norov@gmail.com>
 <20250221205649.141305-3-yury.norov@gmail.com>
 <CANiq72=ctKoDz+Kf7UFBTD-oF17cTHBcrkNN_5cqxQeK609OVA@mail.gmail.com>
 <Z7pfBoXDoH5x-MEq@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7pfBoXDoH5x-MEq@thinkpad>

On 22-02-25, 18:34, Yury Norov wrote:
> I think rust developers need similar guarantees form rust maintainers:
> there will be a rust engineer who will keep the bindings on rust side in
> a good shape. Viresh, as per my understanding, has committed on that.

Yes.

-- 
viresh

