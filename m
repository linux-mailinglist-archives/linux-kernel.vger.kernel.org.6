Return-Path: <linux-kernel+bounces-414821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A79A39D2DD5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D76E283BE0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236E61D2B14;
	Tue, 19 Nov 2024 18:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOGV6P9R"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39AF1CFEAE;
	Tue, 19 Nov 2024 18:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732040579; cv=none; b=q0NagAOhTk+guXtwiRd/9aQhmmmySEy0eo6LWOVEISaXtQSLS0xfyl9A6kMU2+6uzhZho/e5/TPGHGlOdHIkDTbPIBcbRtKReRj5FwfbLnxk1BVr77jwnK6jT/hLuHCXLzvie48n/0LmslQ71rybVFxIJIfyLCbj8GzKZc/lVGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732040579; c=relaxed/simple;
	bh=QpdUyGphCcO8i+isa5wrCAK52iaWLosqqXCg2gSyioo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GvjOeqq5XnhZKgmcjcz8+5IhNhtX2LziDD069wX47eF0hbZMTz/+0e5ky+1LNdvllE86/OncmLothemB1Bxvkx81Gm3mUbizWOVXa0qQWsMcp/LTNdIvmeukJYGx31THjdijfDzLo2sXgqT/e33Dk8BPpEO3dDouIh+Vczr8cpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOGV6P9R; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53da4fd084dso70004e87.0;
        Tue, 19 Nov 2024 10:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732040576; x=1732645376; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QpdUyGphCcO8i+isa5wrCAK52iaWLosqqXCg2gSyioo=;
        b=KOGV6P9R7XyRxschIhc+x2a6BCo4l1OufO7NIacG8/wA7RFRLc4lX2sXu/ctVQ2rz7
         bDBJqdJ2yL/0QIffCcr6EfdzDr+IoM67ugLH+nTNWQKqf8bhzNOF6Ls4ircZlxTeuHK+
         1/M+fO/IHLxWhuaxkOyMNDQmDO1/uBzccMKNwPUMXI6/GxAEzsQ1N1zx9asSupyZ11iz
         +IJmfUel0k7ENh7LR0skLTU1/IGPxNxTnplu7mk04ILiYQZ7EkKfl3D0ySqr0ge1AUkQ
         ftQVKC/+4x+j6Bp1rJdYNA2524jEuAxGXZL8plPo+UkujefGIfbj1jI8kT2u33TqPZUa
         +GNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732040576; x=1732645376;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QpdUyGphCcO8i+isa5wrCAK52iaWLosqqXCg2gSyioo=;
        b=ngjvGzhbplasVD94UjwsdUs81pErPUrjBBnC6voNSpNNNZBCMkS9qm1Mo9kLhhcOg4
         SW2Rtka0uWBCiVTt3zVAn9Km5i9f1nqV7Olvgfyl4L6GlLU3g1Sy9rrFAycVz2XzheBa
         D73yhEJylasQXWluTwOrdbSytU4WBOYk+UZZ7EfA/3BgNywfsgmUVzttA0wMArS9mZa8
         RNIdQSjPKaw+YBRHmcdte/lKNLv/uSpjl4VYqQytik9Zfweaqo1zu9ivYIoeBJ/xFsXf
         SzrpmNWFooeqLKLwMYjNEmSnK8B025js8ddzUpATUwUxz+9Ck400Xu808uybX75+JgJz
         HXuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5tDpSP+JNcMdRXgNl8HqNbdUopN3bducCgwFg0+J4CefzZNCMPTLj6x0O+UphP/d2qrvP97vi2G7o2GcG5os=@vger.kernel.org, AJvYcCV8i++pmHrnrSjzvLtbV6LgPmpSe3nTBcG8W/gjREEFQsaB1d1a6eD+27r3h0b7piSmp41ZpW6rTONgmTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHQPpHCdrDBTZ4dwJrdC+91gdDiIcQ+vUIXsFajg7ZMhKjW9gy
	KCs6DHsCshycnx/na/9tJHE78rF1DobYe8FJpv+R5MwSX5eJrrUnt+rwfpFMqZjYgegY3S6U8Rz
	75AlaFL+9gom+tCA7yQkpaD9Gq3I=
X-Google-Smtp-Source: AGHT+IG+nPww2yCL2O9p4MBIvUXFufmFRKRXHSyUOsvlZB198PhWRnlRi9MoAamjhgY2xiEjdlKFU7NfuPzY+3AOMng=
X-Received: by 2002:a2e:be2b:0:b0:2ff:5b2c:3cc9 with SMTP id
 38308e7fff4ca-2ff8db8645emr134531fa.9.1732040575704; Tue, 19 Nov 2024
 10:22:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118-rust-xarray-bindings-v9-0-3219cdb53685@gmail.com>
 <20241118-rust-xarray-bindings-v9-2-3219cdb53685@gmail.com>
 <Zzu9SzkDoq_1YQnJ@tardis.local> <CAJ-ks9mKArX37VzhcyymDoE-MsNxNcO8VvP4n3Xu1mdfOKiuag@mail.gmail.com>
 <CAH5fLggL7MTLVv2ym_tCCKH9hQtL=GpTwXjDUQzKQX9UdT7SkA@mail.gmail.com>
 <CAJ-ks9k4upcSfa2HXaMrtDJ37eTNc-ZiKZdcLuEYSnWHL5Bigw@mail.gmail.com>
 <CAH5fLggBZsarrRkZ1Mf5ND9-A6kCc65QRwhUW5X9nQxRJUOXrQ@mail.gmail.com>
 <CAJ-ks9=ZDRdh1UzBpV-ck2v5t4a3-81vD07Ndfmow4ABmQvJmQ@mail.gmail.com> <CANiq72=MeVViwfFGaj7MFev0ZOodVo2dJqOeHiPodHjN-xh9TA@mail.gmail.com>
In-Reply-To: <CANiq72=MeVViwfFGaj7MFev0ZOodVo2dJqOeHiPodHjN-xh9TA@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 19 Nov 2024 13:22:19 -0500
Message-ID: <CAJ-ks9kgaVGow2o1S+YAUpYF6pVFReEb2mf+OFMvULt2pykH7g@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] rust: xarray: Add an abstraction for XArray
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Looks like there are merge conflicts between v6.13 and rust-next.
What's the usual process for resolution?

