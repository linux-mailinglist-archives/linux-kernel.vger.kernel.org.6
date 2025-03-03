Return-Path: <linux-kernel+bounces-544657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF31A4E3CA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A4E1885B43
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186B5296153;
	Tue,  4 Mar 2025 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eay5GK+5"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EC029614A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101628; cv=fail; b=oDo18N0wn31ADnNwFgrDrYu8MZSjpcApfpDf5KtgN/8uLPTETPUZEAvlQnTa6TVDU8mccSt+EtFWU6mcHOTVHOLMQHRyspRLURiKfleveq0Z38K4q+y817pT0ayGyZ+/Kz2NZviZMtRjGLsRkUOh/trrpgNrdvDTkWEqKHsPS2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101628; c=relaxed/simple;
	bh=uqlIRAXGGiKj2AbHFGP8tvZLmsWnye4Ba9/5Gkos0uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfIRCkgsYX5wUZyzqLTord+zeAPTCOBilmQC6brdyW7XAXfnYMuGara9C7IAv/CgxmdGhuH0aJETuXiIMdOMFEO1xEWn1WwqvM25TIDPoXCMdnjgI3/ZEt6N+6kX9hBwFYNvNp161l1b6sLGJgLVfBONpA3tz+Ug9gYt9UeqNkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eay5GK+5 reason="signature verification failed"; arc=none smtp.client-ip=209.85.214.173; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 6687140CEC84
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:20:24 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eay5GK+5
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fQj3lQzzFyxy
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:16:13 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 8AF3F42743; Tue,  4 Mar 2025 18:16:07 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eay5GK+5
X-Envelope-From: <linux-kernel+bounces-541612-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eay5GK+5
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 618F9422A7
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:48:23 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id F26BD3064C08
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:48:22 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4EE03A9F08
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DDC202F9E;
	Mon,  3 Mar 2025 11:44:13 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA381FC7D7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002250; cv=none; b=YERTe57MwP00FrZdFDKHKf58WnpeeBvIrrNFZs7BlKaqReAPcw1BIMjUmCfeeQTVdOGOwyA9gF1zVN7Z6CEfraLUIEjGPSrbmwFK+4MTrKKLHrhW0jhGdEgqbJpIjymqG6tAlaPwz5EVzRvxpRGUMU+nQEbeGSFFs2KTa5Bk/zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002250; c=relaxed/simple;
	bh=luQaXlapm+5N3MbCSgVBhzGQTHPZ+V+taACIos9pA2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xky6AKpSTYdoO0hLHxtUmjM/tLF5OLuXX+rtjtxh4GXgedAJC/PU6HxkobHp9Wd2ux8b2pwGGjScWtBTdzsexfpsvbR5xwkFhyNSt7eNomNAyJNYI48jtU4cufeRTgse4seDacW3vsi+zomItjfjgFnyk7Eg6YBngV2fnA3mI9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eay5GK+5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2234daaf269so48225905ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 03:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741002248; x=1741607048; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/iVipZdD4W/u6xESxWCd4AYGgSc83dG/Ajr1AHkUSjs=;
        b=eay5GK+5IUg2nQIEuL+HcdQXt6aY/71W1U7bdgeTTbeWlfeOvmrbJ69qEkHxL/V2S2
         GOleLwYYUi40hcbZQ+Hk0bhdgJhrOhMStUUlC//QByBxlvAWK0KEJZPKd5oAixkFryfy
         yek/Iyfe+vlMxJsPZBWVCNWDIInLhYTyx1XKF9HUPWKDnlLoFLbaCM7vzcXgldneFKSQ
         kNNVEqBZdxOsG9Gk/dKC5P9W6uesN59f4qZ6P3aDGJ7P8XlmkMvg5/+7bfZ0qYseXWra
         PCL9yXbel5L7q7qOApt5I3GLZD0KPBWneMTrq4rqRbZaS2uv3XpJTgLZlLwDXJ0ZvWbE
         sVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002248; x=1741607048;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/iVipZdD4W/u6xESxWCd4AYGgSc83dG/Ajr1AHkUSjs=;
        b=uRXditsEarhsLEBcRJdOOvLwTd83Fh4FsH/ii8dfEutiNqNbk9qlCt8IMoXOccIJ/i
         7G/t95cqX6Kl5jyjFrzWKDzdYiGJmFmNMud4CjczfcWeNg3qLkTCV65P4p6u2Iig0E08
         wic/kauhAenItxHwBBlwxzXaxVwx8P9VtUezZ/SVZV7u3Jrj1yIsQreP1WaFz+OnW4Bv
         IKMbMwueYCxXykUvAYlV/hMXRAAW1BCiGvgr17jutYjnPy+tWv5W5nPi09ZDqsVIt0LD
         1OmOk69tUfZTaR+6TQt1K5IbppJQ785ysHgK8xQQ7f4Sa2A78ZHnGYHc//lDAE55Ge1a
         6xLg==
X-Forwarded-Encrypted: i=1; AJvYcCXhwYdIb90EBduVvZKYrbUuO9faGPW20uxvy2X7XdDJCKtct5fgvN5t7Z+ehsuKCP2M/ltvLa/uqYWcfv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0E08IAQ6wzGAQQSNYWGyyVep55f8UDvmr7Cf9buL4MlhWieSq
	f6Oyimh9D/zcCWHrxMpQqv/7U5cERKFBR+81HshvLxhLTHk7gFZHGofier5SBrM=
X-Gm-Gg: ASbGncv1ruIepnP0WOmQTqD4+UCNqw1oCz3e8kE+H5PjQFq33O2F1sFc/yLNRpAzroS
	WxiCx4kkk6p46iUXCphhsa8I9VcDpDZcKgCjEa8zEbjx0gKlxWetrpPg9LEsifvWtAzOaUYhVRB
	TOb2sgQWA+PfgZn3lt5B6LlK3/ez4zsxA8u6s7PPD5QIDQ15R+CbDSg1LFtRU3Cyvz0OjmPDnnR
	9sdZiR6CPU4zzAuOS86nClXRaPou/OnHwJEAgaVnks1AzmDlL9ErhjqYV2F/4eBgpfIpkgkrPbg
	qAcpkTrrE3e0gJI2Z9/eqPfA/90iFSlpTTHmcE7FlcPnUg==
X-Google-Smtp-Source: AGHT+IHK6Lers8i6supYJLggNOwZjS+MBopT5CAeMJGX3443/hyOyrprvywUIlovcrK7G39ADGHiQA==
X-Received: by 2002:a17:903:1d0:b0:220:bd61:a337 with SMTP id d9443c01a7336-223690ddef3mr188436085ad.23.1741002248534;
        Mon, 03 Mar 2025 03:44:08 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235050d7ccsm75787615ad.202.2025.03.03.03.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:44:08 -0800 (PST)
Date: Mon, 3 Mar 2025 17:14:06 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Almeida <daniel.almeida@collabora.com>
Subject: Re: [PATCH V3 2/2] rust: Add initial clk abstractions
Message-ID: <20250303114406.xbfzhw7nvxdildb2@vireshk-i7>
References: <cover.1740995194.git.viresh.kumar@linaro.org>
 <023e3061cc164087b9079a9f6cb7e9fbf286794e.1740995194.git.viresh.kumar@linaro.org>
 <CANiq72kdWzFOZ39EoFNxEAbk4KYgzLi1OAEc1zn8BM07VpXy3g@mail.gmail.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiq72kdWzFOZ39EoFNxEAbk4KYgzLi1OAEc1zn8BM07VpXy3g@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fQj3lQzzFyxy
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741706342.01402@YKC1Is0/uPwcdNN5SJPkhg
X-ITU-MailScanner-SpamCheck: not spam

On 03-03-25, 11:16, Miguel Ojeda wrote:
> On Mon, Mar 3, 2025 at 11:00=E2=80=AFAM Viresh Kumar <viresh.kumar@lina=
ro.org> wrote:
> >
> > +/// Frequency unit.
> > +pub type Hertz =3D crate::ffi::c_ulong;
>=20
> Do we want this to be an alias or would it make sense to take the
> chance to make this a newtype?

Actually Daneil did suggest to make this "Struct Hertz(c_ulong)", but the=
n I
looked at rust/kernel/time.rs:

pub type Jiffies =3D crate::ffi::c_ulong;

And I thought this is probably what everyone would have agreed to and did=
 it
this way.

> > +    /// Clock enable.
>=20
> Should these be e.g. "Enable the clock." or similar?
>=20
> Moreover, I see quite a lot of documentation about some of these
> functions in the C side. I think we should not regress on that. Should
> we link to the C docs, too?

Something like this (from print.rs) ?

/// [`pr_debug`]: https://docs.kernel.org/core-api/printk-basics.html#c.p=
r_debug

> > +pub mod clk;
>=20
> Just to double check, do we need any `cfg`? I see some functions exist
> even without e.g. `CONFIG_COMMON_CLK`, but I wanted to ask if you
> tried to build it without it enabled.

Yes, I was using this under `cfg` earlier, but removed that recently afte=
r
testing this without CONFIG_HAVE_CLK. clk.h provides wrappers for cases w=
here
the config option isn't available.

--=20
viresh


