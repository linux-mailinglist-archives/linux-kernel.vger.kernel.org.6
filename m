Return-Path: <linux-kernel+bounces-401561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CEB9C1C47
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4BEF1C22634
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D681B1E47BE;
	Fri,  8 Nov 2024 11:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WJY0MKQB"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7D11E378D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 11:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731065970; cv=none; b=J70O6UteRh4ehjaURtegEdkqGGFaQ5Q/WHkH42UTgWPFn21xnoP6yL/V078+V/4R7fvoTnTDIvwKwJY7s4A60AbX2NDceulGRykcXENszf3cusv2TOp3JVuWztZvUoIGQH01WaiticKUsCHfu28eh1GTPNKWyuaaGTsAWNuGIpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731065970; c=relaxed/simple;
	bh=Mx8IX/Oejjgsq+PXa5DoK6tONKLcry4AmnXKYd55j60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nK27s53MbxBbWWgQVBqpqg1fgzslLVCIwYHphxZIQO4q7eEwUcrHdSbNub35tDI0Mv6aaYiwBAdUQGwZsAYhywiztAEUjSss+oxlhlxvJ6+NTZs5jEBaw2LCXRzT4VFdYKzFJvILcQg7FDg7W3mR0k4AZcTuXF3FqmWgf0GK+6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WJY0MKQB; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d447de11dso1400499f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 03:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731065966; x=1731670766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mx8IX/Oejjgsq+PXa5DoK6tONKLcry4AmnXKYd55j60=;
        b=WJY0MKQBYmZ9Kka5vyerqH4xmqaC8SiVReyF5uOzP77WyUSS4/yPYdmJ2g6uMt8ASC
         vVFbwmalBjretQhsEU+3Om4R8KJdU420zJZEWjoQcAuCWA6yjrsAnhlYR+dsEmYXT+UY
         z4QNNBmf/pvmAPPNZRg58p5zoxi5vgr77oLmxX7BFfBPci31n1dotBsEzs3wlOArUgJ3
         46A3AJUNAUkQNGtaduevtfNf7f4OXBqVqoClC1xYSK+sTP+t/etNTqKrhLXEBC6I54kp
         m8cx6MAkui528Rdxm6Bs0FT/p+utPlmEHaC5rHcNLAFjJwhxl8t+IHPszEB6b46qMSma
         oNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731065966; x=1731670766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mx8IX/Oejjgsq+PXa5DoK6tONKLcry4AmnXKYd55j60=;
        b=PURNPTWDYyE6ByvJqkq5flBpCxi6sFceMLH8FDCUqUN3CE4bR2zNAUzJABsknECUYZ
         xzmdL7IV9Z7vvhZLcd/4Tl1ZSkss3/PJL1+5FKcwTp6pyWo14gX6742KJuK/8tQUMfB9
         6eOvrP5wOCktK97TkfPqaJs443ddQncUvtbfRLEJmirniEiuagzAmO0Bs73/XAlZzocg
         gTCjhfXxy1uJmg+0gNpN9FUM/dcY/nT4XiUB8bpHMyiI3vQ9fFJeHTjLT8V+9kNe36Lc
         DU4a4JiiDvteWGkIuWUwVJCrdt7F6EpMLpqG9tvoKDnk1rLWmD941P/QZCplQIw9rwPm
         W6Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVdIh0AHpvbyD7imAOF+mCEsPjZ9fGcjnonj75Xer4ACAO8gKoJ3YC4EqllQNZFz1Prec1SLy6ztoyOxwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqRQBEmdsihqsbnKGdvsl9t8uwVCdF/PVV/bEv0oK2s2zN8Y/j
	3eb7Wzzw59jRFyx913Ie0dXgxt4685s6+lSiRYuIbvRWy5bjSTMvOSe+Kd5X2ZFrf9TofdjcXen
	1lyiwGrFLE808iF+xAD+EH8PF6hPsKBySG+zi
X-Google-Smtp-Source: AGHT+IFI7OOZ3/irToKMB1BSRu8XHd/lQMXK27V4DpjXJ4YB6jGF4yGw5i1K875+vv0vEWzSnGIKcWpJ7i56cMMkgr0=
X-Received: by 2002:a5d:5c08:0:b0:37d:324f:d3a9 with SMTP id
 ffacd0b85a97d-381f171cc5cmr2218340f8f.9.1731065965965; Fri, 08 Nov 2024
 03:39:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104-borrow-mut-v2-0-de650678648d@gmail.com> <20241104-borrow-mut-v2-4-de650678648d@gmail.com>
In-Reply-To: <20241104-borrow-mut-v2-4-de650678648d@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 8 Nov 2024 12:39:14 +0100
Message-ID: <CAH5fLgjmVaGiHGkZa+hUmLfEJVQs7irNPamXJGu3Q-x8oPw2QQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] rust: change `ForeignOwnable` pointer to mut
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 10:20=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> It is slightly more convenient to operate on mut pointers, and this also
> properly conveys the desired ownership semantics of the trait.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Normally you would put your SoB after RB tags.

Alice

