Return-Path: <linux-kernel+bounces-439362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB079EAE1A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0E651883251
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296E717580;
	Tue, 10 Dec 2024 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="f0hved4C"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09FF35942
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733826994; cv=none; b=JiU+c2A96h3U7S9nvA+xA+3ogk2zEbqphPQas4LovRAmsMkR+//LUfOFdW8CFsSFaoRullkt8Wfw6j/usq0gtZCAJkibFFBJn1TOSB6qmajPMjDd9JYp9XubPEj0u4t1XOzzgxPNB1QHxVb4H6QiFnj8v3xweZzWqEVa0xIguOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733826994; c=relaxed/simple;
	bh=3jnRyQ7rzt93uh2WnUgyckAZtkPU9OY8jK+ghXc7XcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ag0/jx7SO1Y9J5cLnuCyJCj0R+0yxysMRNHO2bOlblIxfP31hxZ1dESdUwTp0vLuOelHIGfgwrGvIEhIyAJfNDlg4W06Bm11P05XZRcVaSPKk0d5xLtc4n5Kqlif7EnM8Ri0HVbCfT+mQwU5lbjq95rGbHU4QyWFoAeWbxmqFHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=f0hved4C; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434a044dce2so59040735e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 02:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1733826991; x=1734431791; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sen+IiZX0S+/F0Se18eMG9OtCzCvDpM+sc9hXCEuRWM=;
        b=f0hved4CHGTP4kmr/E3a5zgW7SUCwrvs8oKDXiRRejvxRFy5emMIj7zqelS8XBAskv
         FD8oTJkW6+23Ap+jB6zmgozrPDj8naQdjruuSYth0KqdvgQkmMlTP9qggmNqgHK5mMBQ
         sD7iL80MwMyJiQTHKJayltbgdnC7gNtqcoJNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733826991; x=1734431791;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sen+IiZX0S+/F0Se18eMG9OtCzCvDpM+sc9hXCEuRWM=;
        b=AVE7ruUJmVW91Qbe/8Y4Ou9am0zanWMz+QBrXj/xC5/m7WhUd3rDKKHOGEFv28HsEI
         CF+Yzy5BdrwdJVWURrA4ENO+cg4NdIbrThiErU5e+VnAsnYnpVeAlaiK+kwBWD+ah5qB
         zL9WlFmwFfscDktYb/tGMB9FDu9NUNPZmX296kAili+GViiAszGNuYGfFcQgOgHOdsrG
         BeGjELZKDc8tTwywXWIwrL1zzp1PXTckVVTrjFUJ4cN5PnerfTZahaHTWtqc2ivlUBSO
         KAZUw4DHETy7vcY6eAJGVcEMhjHccEbWnsEQQMj7wfzn0fQ/p7YxJRakvYc6jOQ2EfN7
         Ui1g==
X-Forwarded-Encrypted: i=1; AJvYcCXveXgxJOouxm4IJemavN8NuJP7GdtIJAfkrynDydw01ihaz3gYER1+rq5O+8rCbpsi/hTuEtgZrGngsjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj6UlcUUtOebelzalB8S0Z3RI3Ibz/rxHzLx5eSrrps386PxU3
	2su7gOcqNWPEQ+gCwk3mcJ1h3gAAktSUmUj8oOwTX1zHRl6M8LhkJQmzKmTRebA=
X-Gm-Gg: ASbGncvoyKeObbEOnajvPvSuIyM0ENwHdcDgeIhcG2js7feEzJqQ8af0KSmebjI+fk5
	lmJKY60hQYuh8yA7S7bopbMsx74rMwhn1z4oEsk8yI4KjEh3pdu0oJrY23JR1DyMNW4hYZ6fklu
	bFIBxtyNpDWwMZGX8oMTEuCFbXreTlPfu2Ms3TzhDhmaHC41J9NNAehtcQVSMUUVszF8gelPdR4
	vI/su24cY953vYmmG7pNDUM4csDjahPvSKJyR+0Awky076DIewU2S0n6sjsNWAv9A==
X-Google-Smtp-Source: AGHT+IEV+bbBMZpk2sUNI7COIVamkfzNEBliCeF2KWN5595ZWc//07H+LLjAmbUId5CayTY1JHx5Ag==
X-Received: by 2002:a05:600c:3b99:b0:434:a781:f5d9 with SMTP id 5b1f17b1804b1-434fff41467mr37221575e9.11.1733826990767;
        Tue, 10 Dec 2024 02:36:30 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621fbbc08sm15782423f8f.86.2024.12.10.02.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 02:36:30 -0800 (PST)
Date: Tue, 10 Dec 2024 11:36:28 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/panic: remove spurious empty line to clean warning
Message-ID: <Z1gZrEbqzbf01WhE@phenom.ffwll.local>
Mail-Followup-To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	stable@vger.kernel.org
References: <20241125233332.697497-1-ojeda@kernel.org>
 <fe2a253c-4b2f-4cb3-b58d-66192044555f@redhat.com>
 <CANiq72=PB=r5UV_ekNGV+yewa7tHic8Gs9RTQo=YcB-Lu_nzNQ@mail.gmail.com>
 <e544c1c7-8b00-46d4-8d13-1303fd88dca3@redhat.com>
 <CANiq72m_b4y6bJJ6sB5gUe+rpa51FXtwpwENQy3zGGMtuFJ3Xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72m_b4y6bJJ6sB5gUe+rpa51FXtwpwENQy3zGGMtuFJ3Xg@mail.gmail.com>
X-Operating-System: Linux phenom 6.11.6-amd64 

On Tue, Dec 10, 2024 at 12:10:31AM +0100, Miguel Ojeda wrote:
> On Tue, Dec 10, 2024 at 12:05 AM Jocelyn Falempe <jfalempe@redhat.com> wrote:
> >
> > You can merge it through rust-fixes. I have another patch [1] under
> > review that touches this file, but it shouldn't conflict, as the changes
> > are far from this line.
> 
> Sounds good, thanks! (But of course please feel free to merge fixes through DRM)

Yeah I think once rust lands in drm the patches should land through drm
trees, or we'll have a bit of a mess. Of course with rust expert
reviews/acks where needed.
-Sima

> > How do you test clippy, so I can check I won't introduce another warning
> > with this series?
> 
> With `CLIPPY=1`, please see:
> 
>     https://docs.kernel.org/rust/general-information.html#extra-lints
> 
> Cheers,
> Miguel

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

