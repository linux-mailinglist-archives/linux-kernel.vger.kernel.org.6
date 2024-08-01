Return-Path: <linux-kernel+bounces-270885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 224299446A1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B192EB23404
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9868616E88C;
	Thu,  1 Aug 2024 08:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="owbB2t/g"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABCE1396
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722501083; cv=none; b=Ej+e5qi6SzGXsmh1NYl19fpY9rnVZLTBYqARA8O6WrvW8JkjZwnwB1o5MoLrrJeQ7BwwtgSAPj7dzyA6izZbMwUT8lM0eg5Qu7fRsRoudhUecj6nRx05v30lw9ZocE+7/9QLJBOeosi+d8XPqEdKZIYsPlr5kP2n6xpZakTKqe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722501083; c=relaxed/simple;
	bh=j35qK7hgEdLDisIrenEFMd9EiCzNO2JfnVmaHQ9kMZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyIu4ksimnJLQaqCScldhDamCSKbiDhB0Cmw5gS0BYHMxDAjkfderwHDoNX5KiQ5P/DFjaFjx0NlqckXdWuDC0+H98MOWxYe5vEcpeJWsx4g10dcs7wleIcMZjfjOHuqCWYf1eoStp6rtiaBAoIszK2uk7CR3QSLFz4143/sSM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=owbB2t/g; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc6a017abdso44281895ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 01:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722501082; x=1723105882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T6DIqP6SgLThiqKeTL1B0jqC1r/AlJW+EfZyuiDXv98=;
        b=owbB2t/glVjqOjT80UWdn7BCkEPQhsD4j+QhoASp+8XZ4JQsPwTDBXgq1H1Tj8gHN0
         i1F1KQL/9qbEwuRT6kKbpLORO5YstPxaDszLSDvtEW93fL5idhq7dLwGHdf3AtOaL5G4
         NwAR5XeZe+7srAcbTKr+PKd5AIBT4FvZWx/jKnxu3JyVlSvM6zyDNQfS7uIjBcMX5NGN
         lZ2Oqkcq5+t+XEBI8Fz8sJRY5+AazQvBMZzrYj8nHUa6mfX+TCZ3ABANG8v2gbNgC1th
         lsXM5mqdJG6LmhvhVu1RernN7e0bseS9SC9Yyb1ftAkYX226V/ZQnXG8eKmRluOgCbfy
         zAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722501082; x=1723105882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6DIqP6SgLThiqKeTL1B0jqC1r/AlJW+EfZyuiDXv98=;
        b=gbTsWpnuoLMfvrjm8XP0FkhqkmHCWEZG8jZAIwPYcT/KCPMGjadsQdhtuxLLatmyje
         02w/mmKj3KZ4RGt7Vxz8eFSsiFDtxKG560FmQmdoMuM9gIXZE4cqj+cEqCTF8wURI5tN
         mXGzal72iA0LrnhQOSp3BNOtX7+iLtAzjJEev3R0A+Km/Qq+0Kq3vh/nqmBrOp2C4QhG
         GZJ+zhcSzHdzwGIQ804p6i3lhmBbjB/ZJ29cCe5GmJAr9H1BU/JwEVd5szeJWLkD1cNM
         Tki3rp3BbkW2PVu9DF1ItbqVOWNbY8dODm1MC2/86k9VpkN9YDckPlK3rxDH2pNrZfze
         cJUg==
X-Forwarded-Encrypted: i=1; AJvYcCVAzHoD8B0HRHuzjVznVxuxH5XZDF47fmtpaeqzOs2vfpd50Yj63ulhc2siC51nBmbVv6FYO0iO2za2zim+w0LkduoMadxd4+jE7n26
X-Gm-Message-State: AOJu0Yx4khA6eC7QozPApSekQJyaUZ4kcLYnD9tD9nzs/UqcZpaaZOAr
	Ewo9xvuohnMOnVLsrhwdXk84gCE0PfSxJUwPvrbQXFfncyP7j5Szp6+l8t6rdu0=
X-Google-Smtp-Source: AGHT+IEFbcz8UfvSIGynalkuH6rlmXwWqz3KVvNjKxzROzhzmV0ozLRqPOZ3mGMQ5a9sLQ4urpd9tw==
X-Received: by 2002:a17:902:da8f:b0:1fd:6b87:2147 with SMTP id d9443c01a7336-1ff4ce57f02mr20721685ad.6.1722501081886;
        Thu, 01 Aug 2024 01:31:21 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee1482sm133790605ad.155.2024.08.01.01.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 01:31:21 -0700 (PDT)
Date: Thu, 1 Aug 2024 14:01:19 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 8/8] cpufreq: Add Rust based cpufreq-dt driver
Message-ID: <20240801083119.bwd6k6vimwyhv6cl@vireshk-i7>
References: <cover.1722334569.git.viresh.kumar@linaro.org>
 <e0df2db1caa49f15628aa18779b94899dcf37880.1722334569.git.viresh.kumar@linaro.org>
 <CAL_Jsq+SxdPyb3qQyce7u8Ur=WCd1p+pQxJ+yJrTyS2xk3BF0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+SxdPyb3qQyce7u8Ur=WCd1p+pQxJ+yJrTyS2xk3BF0w@mail.gmail.com>

On 31-07-24, 15:14, Rob Herring wrote:
> We don't want anything in Rust based on of_find_property() which this
> is. That function assumes a device node and its properties are never
> freed which is no longer a valid assumption (since OF_DYNAMIC and then
> overlays). There's some work starting to address that, and my plan is
> using of_find_property() on dynamic nodes will start warning. The
> of_property_* API mostly avoids that issue (string types are an issue)

Okay. Migrated to of_property_present() now. Thanks.

> Also, it's probably the device property API we want to build Rust
> bindings on top of rather than DT and ACPI. OTOH, the device property
> API may be missing some features needed with OPP bindings.

I am not sure which device properties are you talking about. Are there
any OF related examples available there ?

-- 
viresh

