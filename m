Return-Path: <linux-kernel+bounces-440990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1810C9EC786
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76CEC188289E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED581DC99A;
	Wed, 11 Dec 2024 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Xf+mOKfP"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574DE8489
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733906597; cv=none; b=DeTlXehDpicEssBYnS2/d+BXgPZGdFXOiO7Cvt7OXPI8kgdekYliYcFRmtT/3QoK2UJl7BNBBmmW84ZfPDV+030G+caqBSsERf4RUmHBjXObzU9WBF2sq1nPydL7bU+0oOFzn/mnKlBKWX7ch/GdJj378nnzynY54Lfl5H1j4ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733906597; c=relaxed/simple;
	bh=E+6hicwdN2qZVg3hca/JtaXyTtyPi20GrborVG3YtZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syko8wj1AxZ3qKi1nW7i1xHj3DFx9jQ7lU5e9bpq+SjsWtlzc1hzerYSOqMMvFhns5i4DhbDzbbm6dOn+O5zxX2nOlY33uaBc2MAOnT6LhJ18JSleeKCLyAn+UtYGv1RHml34xRlopfWXIgTrwttjQ+DzjXQWIH6Me3Q8I4AZfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=Xf+mOKfP; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4361ecebc4dso1611015e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1733906594; x=1734511394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDl8Jb1frNHxOgKdgBmezzKCSNHw67jaTRZ7H3Dd+tA=;
        b=Xf+mOKfPvS5p0ZhSBByjp0EM6ub1vRfuR1lWlmnjA/SeSreleavtg4mgf5utPbce4z
         uTcdsZ43uWMbPGFp9eeq8uFMkg3c20RbeICPpzQYoV5AXQG2zMnmOOQyFs60efVtuFB5
         DP0qWBHkcEQ53jm91htLgkh2Y1tORpa097HNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733906594; x=1734511394;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eDl8Jb1frNHxOgKdgBmezzKCSNHw67jaTRZ7H3Dd+tA=;
        b=CSgZESe2Nr2Ylxz+CgK/BA2VZoKz7cKSSUfYYM3Ua/BmPgIvVK4exhW1q4SdVktQHC
         Xs6lRQjHVLpJU4feph2iPT7nAzqptKgXx271LweXvrMhVgusbSdZJzVoybZuKhnhDRcx
         mLnLHhf6vcxRvbXHQQlhefYyF1nt+z24UZLAaCRUL+Dt23HmD/9+/7qP+sqeSYjxHCMJ
         glYAdZ7Gy+GxUH/wSCnuMfqliqlrGXSWeZFCjxKqNrtCdH48ZQZE//mrI1Yj3qU7nh/n
         +CLmrkLV03msjjPEXvW/uBGtR/apMnPZmCmUUOptEDPMH0Qe9tNkU1z/gd5+JMRLPI4V
         uFJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9VGGJ6TW544Q57rVWqMiwcodcu+n8+dYSf7WJSoW96Fl7sSPpHc29JhQaGuv1zo/LTweoPmiKoT63LLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHV/kduVuFrEFpbpP2FBQdjweBe1Oz5BUyjbGSN0SA/HqfFwKV
	4Cxv5Zea5ya/rQPaQUf3+PrAcJ4xTroDRYMY/V8bpUZ5HyHzecEqEajL31KkVVk=
X-Gm-Gg: ASbGncvMCvpgJlioLZovAJ69aa9Dgd5zi+PoGFrnHcE3qFkyClqCwVK3jGnCoPWLmaZ
	+zcVWKQxadpk0f+QcYrliTlvQjvj8f3AJ50SEizYVuR1AMBaNJYWLaFmvWm4VPeSQzJW4T5MdBy
	AlxZyBvPhBRmE8og8hK3lXymjUyNCfvxX72gMGA6GvdbShPRpcjY7IwQ+yJ9fHyocegR+y0I9JS
	PSp54u47iGSPObwWBylrW4zFYNaTUE9iW8NIN6PpYPHD9MP1sbvA33ETXZfiMx/uQ==
X-Google-Smtp-Source: AGHT+IEC5s1ABwh+QmwDOLYC0yNnP/Duuq98w6DzbDd3sOm9WXsmU9pvk2PMVd0L51eFeLkr3RWVKw==
X-Received: by 2002:a05:600c:8718:b0:436:aaf:7eb9 with SMTP id 5b1f17b1804b1-4361c429eaamr11213005e9.20.1733906593293;
        Wed, 11 Dec 2024 00:43:13 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da119abbsm222094855e9.43.2024.12.11.00.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 00:43:12 -0800 (PST)
Date: Wed, 11 Dec 2024 09:43:10 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Lyude Paul <lyude@redhat.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
	Asahi Lina <lina@asahilina.net>, Danilo Krummrich <dakr@kernel.org>,
	mcanal@igalia.com, airlied@redhat.com, zhiw@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [WIP RFC v2 05/35] rust: drm/kms: Add bindings for drm_connector
Message-ID: <Z1lQnhKmH39C7Erl@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
	Asahi Lina <lina@asahilina.net>, Danilo Krummrich <dakr@kernel.org>,
	mcanal@igalia.com, airlied@redhat.com, zhiw@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	open list <linux-kernel@vger.kernel.org>
References: <20240930233257.1189730-1-lyude@redhat.com>
 <20240930233257.1189730-6-lyude@redhat.com>
 <02A84CFD-BE91-40E6-995C-4E81A8DAB92C@collabora.com>
 <7b57940a3987532963ce5fbd3a999665c17611ab.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b57940a3987532963ce5fbd3a999665c17611ab.camel@redhat.com>
X-Operating-System: Linux phenom 6.11.6-amd64 

On Tue, Dec 10, 2024 at 06:41:52PM -0500, Lyude Paul wrote:
> On Tue, 2024-11-26 at 18:25 -0300, Daniel Almeida wrote:
> > Hi Lyude,
> > 
> > > On 30 Sep 2024, at 20:09, Lyude Paul <lyude@redhat.com> wrote:
> > > 
> > > +
> > > +impl<T: DriverConnector> Connector<T> {
> > > +    /// Construct a new [`Connector`].
> > > +    ///
> > > +    /// A driver may use this to create new [`Connector`] objects.
> > > +    ///
> > > +    /// TODO: Add a way to handle creating connectors after device registration. Also, that's why we
> > > +    /// don't ask for a UnregisteredKms device here.
> > 
> > Can you elaborate? We can try to help if you describe this a bit better :)
> 
> oh - totally forgot to respond to this!
> 
> So: out of all of the mode objects, Connectors are a bit special. They can
> actually be created and destroyed after registration (hence why they have a
> refcount). This is not terribly difficult to handle before registration, the
> complication comes after registration - where we'll likely need to split
> Connector into two different types:
> 
> UnregisteredConnector
> 
> Connector
> 
> Where you have to sacrifice the UnregisteredConnector to get to the Connector
> object. I don't think this will actually be too difficult to implement, I just
> didn't get around to it yet because there were so many other open questions I
> had about the design here in general.

For connnnector lifetime fun please also see Imre's patches for fixing
some races around mst hotplug. At least on the C side I think we will
split connectors into dynamic and static ones, to be able to handle things
correctly. It's a bit a mess unfortuantely.
-Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

