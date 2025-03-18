Return-Path: <linux-kernel+bounces-565809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3C8A66F95
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A621519A2C68
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A6120764E;
	Tue, 18 Mar 2025 09:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HjGlJnuV"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E452206F2C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742289785; cv=none; b=WqmugWmAo/dxgyIkZGceKgy+PPtDpTgZCO/QiaQtrdByMOXxRI5AlLcwZulVJZvoKLW0mFkFXt2D110vYLr0OAaoUnU83efradsonIgT9EcgTPwUUKqyWoK7qfu29qPemU0+dpVvhM0pJEhxTPkQSyqNuN+dx4WD4Lc/UhDIj9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742289785; c=relaxed/simple;
	bh=2+u3XFAq+HNGl3DBJY3s8alh1DCk6KVZIPBdA22WHZ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e+Jms+LwIWmXdLauxENm4zyj6BWk6RspFdumQ80bB5IR6EsNPra1yxB3fpKes40HcNl7ZnwyV/GuTusxRpAqTxsQrvuxlTpdGQVY5aAfZOZOt6TZFf4ZhxXtmNNQzykjREVhAXTTJkALtPG1DGLlPnXTxkCAKE00MuwyPMLfiMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HjGlJnuV; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43d08915f61so16478495e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 02:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742289782; x=1742894582; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PCfC0RAJNFEk2a2N1WlDQjbNqq6fpBI9L3zZ4i8ZQK4=;
        b=HjGlJnuVlAdFvqs4E/c3W4uAAgSzlbNWtlg0cVLd85xlUsWCeilgrsjxouvl9FhDyt
         4B3yX4W7X4xeu6A3oGOMB+/Q7w05v+6ZjmgrpQjZIltEjvf4IUOoGJoWGpof/tPt8e/H
         9S573zTnWv2XN6wrMrzbuQhrWamQQtHqCSd2blMQqPHLwWbqwB5ZktGLxu7l49oVmYyk
         GlFl6UNWxkhS2uu8OBNV0ZedF8HSvAtmA+BFR+EmXr1fOKKLp0QALctKlVHGToZ5QhFS
         ycncG3Xqj4e4Dq9XrIoo1FqPvyS0ylrTdMUUOrQrNOvSXt0E8GRDWyddCpZ9ZlekxcF9
         8hiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742289782; x=1742894582;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PCfC0RAJNFEk2a2N1WlDQjbNqq6fpBI9L3zZ4i8ZQK4=;
        b=lTXFk7rs2bNE5lj5NxT1DvkfUuOW+SKmRZH+w2Mw5PS8vFjUr0/roPV+EOFy6Xkxwj
         dN2F30VcA7ekf6ufvrylJ2g2P62BRIWS1iQXax10UOVzL1x2M7Wmw9BZZgL6znEPp8CK
         CVPogp6FEt4vvQIQTmuHLkBdNEKGJU1ITpNJ5VSLUF8wUIVInlmYeyQuyiwFZiU48IYc
         w7PbY83hu9HB4Y/Am4fN5xdH1KNQxcVB6UI/LvpUOezYgHjdTS3CD+0YAgeV/prmXndF
         jcy4PKB04RDJLx2VYL5lK/hfK6REDrFt6MxN7+RH+B2lQ84lZ4JefSObCpWjV1AXKktI
         VAMA==
X-Forwarded-Encrypted: i=1; AJvYcCW0XnWtQ5qebhxXL+c07ZT6PwE8xc6LLA/VONdmsszdf859tmocOmgsVRXnlESsl/W2QD32PeRqNbiOOOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpBX2FmikirRIyi+upUUoHDWxtWmZ7nXS5irPjGFSzrIX/4Q1I
	Awu7CVprEnxhvvmswplgYK63F8sNaj5kiYfF4Cc2YaHpdclm3/zqLSyeU9orhaei0OL2/5j0VSz
	NKKXdzQzVYeGo3Q==
X-Google-Smtp-Source: AGHT+IGDaUl0eiyBgeANVIDFXN9j+DuNssJhnHkyeFJipmKrSIp0Fec7Cw1iykbVuNIh3z7M3e3iHmbEpO1331s=
X-Received: from wmsp8.prod.google.com ([2002:a05:600c:1d88:b0:43d:1873:dbaf])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:138b:b0:43c:eea9:f45a with SMTP id 5b1f17b1804b1-43d3b94ffe9mr15418345e9.4.1742289781906;
 Tue, 18 Mar 2025 02:23:01 -0700 (PDT)
Date: Tue, 18 Mar 2025 09:22:59 +0000
In-Reply-To: <CAJ-ks9=xLLXovsaduKFBfxvkfzYgTaSPhhW_oRN5y1QOuKJFkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250317-vec-push-use-spare-v1-1-7e025ef4ae14@gmail.com>
 <D8IM66U67XBD.28KWYO1XSF8ZQ@proton.me> <CAJ-ks9kq1cQ2-ZNzG9P4SBvk-AjXxT+na-89K33imB4fsCvu4A@mail.gmail.com>
 <Z9hXMcFVdF8MMusU@cassiopeiae> <D8IPQUN25M12.2CIZR4QHJ201N@proton.me>
 <Z9hcT4KPwgtHmiTT@cassiopeiae> <D8IQ5BDTLCLZ.1UBNYUXLK12X0@proton.me> <CAJ-ks9=xLLXovsaduKFBfxvkfzYgTaSPhhW_oRN5y1QOuKJFkQ@mail.gmail.com>
Message-ID: <Z9k7cwE5UNOIyoXR@google.com>
Subject: Re: [PATCH] rust: alloc: use `spare_capacity_mut` to reduce unsafe
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Danilo Krummrich <dakr@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Mar 17, 2025 at 01:55:18PM -0400, Tamir Duberstein wrote:
> > >
> > >       fn dec_len(&mut self, count: usize) -> &mut [T] {
> > >           self.len = self.len.saturating_sub(count);
> > >
> > >           // Potentially broken, since maybe `count > self.len`, hence need an
> > >           // additional check.
> > >           unsafe { slice::from_raw_parts_mut(self.as_mut_ptr().add(self.len), count) }
> > >       }
> >
> > Ah sorry, in my mental model the function returned `()`. Do we need the
> > return value?
> 
> The return value is the whole genesis of `dec_len`, we want to return
> something to let the caller know they need to drop or copy the memory.

Hold on .. it returns &mut [T]. You're usually not allowed to take
ownership of or drop values behind a mutable reference.

Alice

