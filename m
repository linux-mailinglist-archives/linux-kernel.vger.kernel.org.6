Return-Path: <linux-kernel+bounces-551171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638FAA568F2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 047B43A6E69
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314C6219E99;
	Fri,  7 Mar 2025 13:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ikoIT6YU"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E648A21A443
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741354138; cv=none; b=h1JlB0xEBzw0L/y81yGUBa16f1q7/2L8N/uv6O/QegL8ORouq4jtKW9V9c3cDaJXIQ1rqshYPh8UtqINZqKLwVC7BWo0XcJ/ik9y5/zxC0FkkxHgVBzK90bS6G44Ta3rJcT6O+p9kDe7fGaDQf8jpdbaa3Oqffc6QfrfMEiBkvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741354138; c=relaxed/simple;
	bh=YxCQ6kdR5adGsv15vzWEQPTTfgV97hpbZ9PIyFx+sRM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JF1iLEmLehh+cmA1Z50pd2Dn6DatfPbJgptIcZqBhpJSn2SR5Q9whi7PeF/mITC3GYw+2IJfgKq2r9HpT7+DElYYQM/UY8QA6KxgQ9TeKmN8nLqbJ18uYrTQ10ZkKBBJf4oUqKWtvt+7SZwSRQot8bCda/rcBqAq0CXEwQnBNHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ikoIT6YU; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43bcddbe698so7607065e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 05:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741354135; x=1741958935; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DaSUYCv28u5kM27Jf2rZMXFL3A073ykDib5L3uUcYRk=;
        b=ikoIT6YUPFfyybGFctagFbVhR7xT96eGjw+jSgkqkW2piPgZWXwdNZxSTaj8sHpz/s
         pklU/QZTOCeV7pUgmu8Q7cE8rckQ1Wpoc1mJD5HPo/d4gXPhFB5SKDJNcWtcHd/RZLzv
         AtaIHI6Ns86AQLXMGqk02vSv89NjZqQ6mUkkKbrg/43WBekv/MeKKeWKREwE2v4ZbTT5
         Edq4cSrQb8qsqMo3u+/DGAbThJvu/qRxk/X7SLcBT80/tXkC2fD7of0w/N3h7bn6z8PU
         3vpp0SPXdcf6DqxYMDTsb159zLQnkY+dMzWuX3yN2eh10jpGpFFfSUh4uhM6DnZcNRlY
         vbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741354135; x=1741958935;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DaSUYCv28u5kM27Jf2rZMXFL3A073ykDib5L3uUcYRk=;
        b=gnErc29YpDN/9KSpEiS+g3PW3o5U1PGfKDCG+XhSUtccyOPD/EadaFaBF6Y+uvb9MP
         l6pkMH5WuUCr1+taN1wc1nN1//G8o3YKZibYPlJ+k9FhGLqEW1EKijxm3kBKIY6wKFvG
         VT8nkU9Q3vdz4p21MRqvFVbhQv6C5dMo/lZ7k8JRfbr9pQ4VD/OAKzavxrfgVJoAcrLh
         ER2ZvjjCN9PNN8RWsEbMifPV2GU7S0NlUjOZTdoByUp6+GIQNvc1BY11SEPGpyzvQzFe
         PIEfAgt5kp35l7+nTHD87d4o1joT9x6Si+H+tR3uJFHXePd423W4JfEmIR3FHIsqqShM
         B+hQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFnEJsbAFp6oIrRQt/x6TdYBoMQIBjDDhFfe/4pW7u06TMRGLHM/LZTvh+RuLr7XkRmMWOUIicCU8fjZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNbOwS/8eH7jk74aPOwYP/yBP2CYMiY09rNRvqXQ5iqiou9hn/
	N+SnaYCSX1+p/Yjd36h69xb32zLKPfQIcr8+wkByNcmbZNsJyZWW9KUGdRpDhnlY4/tgAGbZ0iK
	6jxXUWSBpY1E94g==
X-Google-Smtp-Source: AGHT+IG4ECHvdmwgPyIQSaZ5+HPi/7aWLq7hvACfAUu4RqLYTA8eHahYvXtXtAibsfCtBioGyCBfjrr/9J4MUYw=
X-Received: from wmsp16.prod.google.com ([2002:a05:600c:1d90:b0:43b:c59f:5eb4])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:198f:b0:434:f131:1e64 with SMTP id 5b1f17b1804b1-43c5a6009a6mr21557375e9.9.1741354135323;
 Fri, 07 Mar 2025 05:28:55 -0800 (PST)
Date: Fri, 7 Mar 2025 13:28:53 +0000
In-Reply-To: <CANiq72mYfhuRWkjomb1vOMMPOaxvdS6qjfVLAwxUw6ecdqyh2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250307-unique-ref-v5-0-bffeb633277e@pm.me> <20250307-unique-ref-v5-4-bffeb633277e@pm.me>
 <CANiq72mYfhuRWkjomb1vOMMPOaxvdS6qjfVLAwxUw6ecdqyh2A@mail.gmail.com>
Message-ID: <Z8r0lVu1iwc9GG2t@google.com>
Subject: Re: [PATCH v5 4/4] rust: adding OwnableRefCounted and SimpleOwnableRefCounted
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Oliver Mangold <oliver.mangold@pm.me>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Mar 07, 2025 at 02:16:32PM +0100, Miguel Ojeda wrote:
> > +// TODO: enable this when compiler supports it (>=1.85)
> > +// #[diagnostic::do_not_recommend]
> 
> I think (untested) we could conditionally enable this already and
> remove the `TODO` with something like:
> 
>     config RUSTC_HAS_DO_NOT_RECOMMEND
>         def_bool RUSTC_VERSION >= 108500
> 
>     #[cfg_attr(CONFIG_RUSTC_HAS_DO_NOT_RECOMMEND, diagnostic::do_not_recommend)]

It's only a warning on older compilers. We could just add this in
lib.rs:

#![allow(unknown_or_malformed_diagnostic_attributes)]

Alice

