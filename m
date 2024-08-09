Return-Path: <linux-kernel+bounces-280929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9392394D117
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6C831C21B1F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C906195803;
	Fri,  9 Aug 2024 13:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PyQkc1T2"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C599193070
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209573; cv=none; b=tzHK2U7Zo7HmgcnUZrZeQ30EuKcPaQEPQt6Re+OqpXgBAnBlFR/i9I++olqyrp3Wgn48E5f89OaFQkrXj720FUIq5/AL7r11uBW+JcI+mCVInThPgjNfRGtepnZVXBQ9B2KE3AS/VqRtY0Iz+F5hslQKYLxV5VgNpalGq7eHRf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209573; c=relaxed/simple;
	bh=hX4prB1rS1ph3HqURVsdgX5nADQOV9sRydK/J8HxadM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6Z/QLnm+JYt+F6EjBBfCFV3AGUQ4Z0HNzcwZQwRMoyvZUuHN7mSVBFHjnm20lt2QjvNBcqrGY49tPoDQYsaYDG7CsHEnF86Tzx/lAvQPoi6mjujzt9VFW572FmiwL/1ttlfgx32XFfsvNsV3yoQYmi/5VWYJj2JF0ZJ3Exw9jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PyQkc1T2; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-368526b1333so1868634f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 06:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723209570; x=1723814370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hX4prB1rS1ph3HqURVsdgX5nADQOV9sRydK/J8HxadM=;
        b=PyQkc1T27w9PziA7tP/pA51KoiOWraBSWzLTAb5pRiz69+Bwd0Az07CBpn0yBpHnCf
         t3WSJ30+BAbYFZNsap83H9nk7qRhLaAgjaBXbNrl/iuyX5IxH/zVROS9+i8YXzTsJ4oJ
         Bb4wxxQXHFzNWJZNh1qGBlYsl4VEA35O/ChT4y4pbe8+3A6cO1OFNlev525sThMsy0Lk
         cFQFo92cQ7m1gmJLGHBev+P7MMFJghIbDi9a7+SGF2qRAlqaNlCPh3snt1Pfkc6cTCU1
         Tc7hQZJhSfZGgOKSre3LzxU3T+nUV99fr2wpyvJ58ZxoGB7qWFXWX6ZahQODwZGJrFvb
         BxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723209570; x=1723814370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hX4prB1rS1ph3HqURVsdgX5nADQOV9sRydK/J8HxadM=;
        b=XLR2hwn+6c5VCWvbdYFHMAkZ9tC28J5EI1xdM3H9NZrKDvW+E5vxVG9F9a8e6seoGR
         lmbV9KlkTGUQvWAWpu7CYz7O8P5JqQMeSpAWsrsY24nF728HVshNppdFioJkE96swW3z
         l00Q3vxU7HfIdlRpRlwmyhel1mlNW/CBRByP26i5KQlkv3gK0X647pTE9HXl71hYLdfC
         bzDfhb7STG0C9A5GS+mJXebvtWdBMhRWCeGji2bpUErcdQnSb5Gyyv6b7mUX53vPXYxl
         sz65Dydf/4/y44NvGgOSmBrLbyCu1IqKRcSo02c538XdRRWuXxKYYKWNHL09d+naA3zK
         G8Vg==
X-Forwarded-Encrypted: i=1; AJvYcCU18BXWD7IEB77xSDM6cvPDETZRuUwU2H9SuIEDMUih4v9Ycd+bMYCAWU0myi0s3KlpyHq4B2jCsTuqn1KzaaTI8u+WKEADfEuaD81i
X-Gm-Message-State: AOJu0YwujL2YLgkfjQArieZjgqdlwdA8J7+ixdIIPzcmcv9ulkI2ZXDH
	88S5jyVVh5zzvgGBCj84NdZRjWGiJ5cuZNpzfT6HdMgeS9WMOLdBDSXsGXdmUTW30KlAsxb0/D6
	OXFTiphu/1z8S/dN7OtGIIG0khXMvuT/FHetk
X-Google-Smtp-Source: AGHT+IGNzIaEFkMjqIqsgcveX2voN9uSFLP9w8tPwHgiFhpGT/YS3dCloVdYIRTwq0c/M+SghUXleXsSnC1QOnNSZjg=
X-Received: by 2002:a5d:66d1:0:b0:367:8fee:4434 with SMTP id
 ffacd0b85a97d-36d68d9de50mr1201834f8f.16.1723209570197; Fri, 09 Aug 2024
 06:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809064222.3527881-1-aliceryhl@google.com> <7f38151b-9c9a-42d0-98b8-345c4513a8d1@kernel.org>
In-Reply-To: <7f38151b-9c9a-42d0-98b8-345c4513a8d1@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 9 Aug 2024 15:19:18 +0200
Message-ID: <CAH5fLgiPzm=K5FWdLWdTW159OBedLX8-FU=S_u4Rt1HsU_xDqg@mail.gmail.com>
Subject: Re: [PATCH] rust: sort includes in bindings_helper.h
To: Danilo Krummrich <dakr@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, 
	Andreas Hindborg <a.hindborg@samsung.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 3:01=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> On 8/9/24 8:42 AM, Alice Ryhl wrote:
> > Dash has ascii value 45 and underscore has ascii value 95, so to
> > correctly sort the includes, the underscore should be last.
> >
> > Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module=
")
>
> I don't think this patch needs a "Fixes" tag, it's usually for bugs only.
>
> But it still makes sense to mention the commit that introduced the includ=
e
> in the commit message.

Ok. I can make this change.

Alice

