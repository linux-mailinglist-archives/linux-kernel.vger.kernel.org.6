Return-Path: <linux-kernel+bounces-316588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324E696D196
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645A01C22241
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93952198E99;
	Thu,  5 Sep 2024 08:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R268Oi1m"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84099198E63
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523825; cv=none; b=Kijj9hJ7lBauEfzSXN4AkqVUl7l4szD0jbf1to/mW4RyKR4pvDID4i+2ZNM3pbDKhMejMLgXarwZlR67RDga5+FhmRIXDi9pqVXnXgzpprAn9gGLUQTT45AxESKH+DyTK+bgKBZpKVF6uBoUHz1RUM5ZzVOAxoka1D21QnygjV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523825; c=relaxed/simple;
	bh=JB5nCSkw0VLqFnfOIc9MMDc29SMicRFbGInFV1poK6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOdVoi1hW13H3xcaAh04y0lreMHnff2Kwk7N7U1SXKNwc90H+FuzeaV99OOQFxCT3qbsNwXZ5++Vf6saRZKvrmNDvYL2/ir0e1l4cXZJKO9m5yEnHAN4NTNrixxOiO84yZ7zVNt+Anw9xYHBeKMfwLC3UuBtM4v7O6uNoE1mFl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R268Oi1m; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-374c8cef906so244167f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 01:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725523822; x=1726128622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JB5nCSkw0VLqFnfOIc9MMDc29SMicRFbGInFV1poK6A=;
        b=R268Oi1mQmcsUOSiLvPPt8K5OMqRz2wQHQts4ZyYZOuROs6PS7h9cuy1rjgXqsh2h8
         7M243H+W208I8Ki6goLDIKKfH7Bc5grbB7z/6M/NgVB6chGwnkSe5A6sKsJ9AfEMTsHm
         cbMJrIMO1jfh76JHxLhZj2U487LPy881vN2tonLhQrreBhZ6Tf9ZYyWDPznVULkXqwNc
         75k7cHwmKa64QzoThAJ8DzIBz36Sq13MbK3kmWLjA0UE6gd3G6Rtdc4YuSdwlEUU10IJ
         8EMuVdoSDMHAtkTCEZRGjG8ZczhyQyug9Jo7i0XVGxK4ThB6+dXV5x4PTxuhoc7pQ02+
         rNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725523822; x=1726128622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JB5nCSkw0VLqFnfOIc9MMDc29SMicRFbGInFV1poK6A=;
        b=TfuA3jkwTJitp/Qn7kfx3ri/nUrOBU7V3CBiQAItv29QK9sNMkSQSGIvkxbTEBMPSW
         CXDMgiaMZuCxblIO5ExVaK2NZLdcIEh5rnj7ehvCtECdsLtFIaa+MZfTokiT73feV1ut
         XJn0N6ruANRYhdL0Wt5UvMFzfoXdOfTYYimieQS8DPKhMbMQem14Egi2x9VdfTDAIjzm
         XGqmW3mF424psAIDmckdI4KE1XptLjf1ps/y6hIP+GSis9hhP8ZjrQBEI1fMlS/ML2y1
         33jgRjn3R7/zRpl3dBOhOfhwJKq8XkrSiIQYwUQL+9RdbUlGCLkp+o2DCDKex/TZobvw
         dFcw==
X-Forwarded-Encrypted: i=1; AJvYcCX8AeiRBQps9W5muQs9FxAOmydQlLEMdIA+DDQZdz1Zx7/5t40NtVYsGfVVuTCDuBdQ7I0Xo4QMJ07d6yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSH/LbNvG2LB7/UxDg91/3eFveJAmbPQOEyTj0Sui5SWXErTyW
	2OTet4v6JIcWWMhzNELoxgINEJ8dgoA3CXX/rV+pEPYEHWrBE41aK2X0o5z3WGuknML/M1sXzuw
	NVUucf3SefH0DU0j5K6eUUNp3gP+Z5FVhTSFO
X-Google-Smtp-Source: AGHT+IG5SvREPeks+5Y7psAEInexv/HWsATpKYx1bJ7JKzDl7CMR7KRa4EjS5aLBH9sf9IJsCJ9dojHZYM4rrKw+PIo=
X-Received: by 2002:a5d:5269:0:b0:368:420e:b790 with SMTP id
 ffacd0b85a97d-376dd15a8cemr4182916f8f.14.1725523821561; Thu, 05 Sep 2024
 01:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-10-ojeda@kernel.org>
In-Reply-To: <20240904204347.168520-10-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 5 Sep 2024 10:10:09 +0200
Message-ID: <CAH5fLgi4rVuS-uYdV9hqV7u17qgFVtaAXa0YkW=uhbca5Dwxeg@mail.gmail.com>
Subject: Re: [PATCH 09/19] rust: init: remove unneeded `#[allow(clippy::disallowed_names)]`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:45=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> These few cases, unlike others in the same file, did not need the `allow`=
.
>
> Thus clean them up.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

