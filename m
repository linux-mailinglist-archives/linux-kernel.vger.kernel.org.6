Return-Path: <linux-kernel+bounces-277837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 474AB94A72F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E0D282D49
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2C91E4879;
	Wed,  7 Aug 2024 11:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FEKNIGEl"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730171E2880
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 11:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723031386; cv=none; b=Hfqbimn2AYgs07TbyMtdW4LnYFvLW81CvPIWxeLKHY+XoxIFjbzDJTAY8hGolhU7SmKtzVvB4ZbOnh5ya3pJZm1o94MuJr1bkHBSSQoU8eDokSF6zwDpjKQyGozreCKKeESA4zwUbpZSkdeVpxgqitVILQFRc0jovkKbc3O80VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723031386; c=relaxed/simple;
	bh=a/dC9WYEQPdmFDxHth1Lwu8KV1JB3jsWpTUlohgSUHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JjKMWwDi/9//45ryCGABeozFHmBIIvieMCOscRANsFdcQ/gKPNYGO90iIiYQcDJrvwPgHEor1gmNI2v8IoFHZE9OOKacj+0yaA3+aJGZ+WFoYfGeUJq6yqYi8UfKmnLQGgXGco/I9opRMO5+L1UJh6EXqHqgf5jFlOJAq+ktPgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FEKNIGEl; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3683329f787so916470f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 04:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723031384; x=1723636184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/dC9WYEQPdmFDxHth1Lwu8KV1JB3jsWpTUlohgSUHI=;
        b=FEKNIGEle8UdU0r3AgKUFk14fuW4eAyW8P7UHRBDH6vwOeOpIDJyJoOTymY68HUtsD
         qwOHqR6s0z/B1vCivnH4DwOiRVBeZQSIUdTstjvvvPbhDdAlzWH3WhYcZbcI4O6CicF4
         0GZMpqDusJS2Y8bG1z0AthK5OyRpFE6MSrpXeZIyjibRqch9O7AikNPcT7ZTqP/+vRax
         94kTufczu0/XqsxqzSL6p2knT5+lrTDhMwd1B8EhNKkY0LHI1CGpCpomEfio6bCL54IW
         AxmW+SToRYa+fSGrLL4uNlfL3QVAR0x3r6A3gg7P4g3tfcrxH69/xtfRao7GmOVm2Qs9
         VE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723031384; x=1723636184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/dC9WYEQPdmFDxHth1Lwu8KV1JB3jsWpTUlohgSUHI=;
        b=WRYELVU0QdwfNSu6U3C3qT6JObqFzX1bhZFnItuidbPtevwGltLYA7Gb/ASJHMTO1s
         pQB6+gg683HSMcyg/2U26OOa8rpxboRzC30zptr8Vqh2bPslZyIA08Me22w95mzm6axw
         +jFHYmhom78WmY383bTcOXS2GpXCzfc22tmzLGoHOhiWCGVacHEh4QOhpaIMp4TqdusP
         XVTLxBOHMiYgfk494dLeyGnMN+5E/AhEVV3prFAUuz7584YCRvV3xvBqtrUPssNaPwof
         tpwXIkH6vOWs0o/eHnfTSrCInmAsoEDTBU8M4Z1DsQeX4MUEn0w98K0GBlKnv1HLdmyE
         02/A==
X-Forwarded-Encrypted: i=1; AJvYcCV5fSv2gwjA4B9/NCOsUqwYXZ5hbhd0CgheQ6J/WB9n6GgXRtUu3i1h3PMy8kIOHM9GqqinTmGkAlwkW9XYUZuaVV+ggYLAwC1ABXbQ
X-Gm-Message-State: AOJu0YzNlnPFVk1vwCdIiQI4pT87n9aq3aWzEcXnfZToJ8PPC4ia2TQT
	8GSVGWhYJ/IXCv8HThSECmVcSI7vq5Orgvp/P2zE9O1QfyqHbluH/doAQS73S+F2r+3OBVVNBrM
	9AlZz6B6xQd65tabakBoywYokLmNgLDQ8u0sk
X-Google-Smtp-Source: AGHT+IEtTOVqbzU4EcqZnKqzn7ZHQ6dJC1In4BJyyOOt1USL9W8GtpPF1PcUdjk686l2fHYBMyX04R1GUZOIR9Bydzc=
X-Received: by 2002:a05:6000:bc2:b0:368:6ab:ba69 with SMTP id
 ffacd0b85a97d-36bbc1005bemr12210634f8f.28.1723031383491; Wed, 07 Aug 2024
 04:49:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806233559.246705-1-ojeda@kernel.org>
In-Reply-To: <20240806233559.246705-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 7 Aug 2024 13:49:31 +0200
Message-ID: <CAH5fLgiVwsxrY-PmwCntsx2=9u24TfFkNuJCJ4aioGD6V6ddHQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rust-analyzer: mark `rust_is_available.sh`
 invocation as recursive
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 1:36=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> When calling the `rust_is_available.sh` script, we need to make the
> jobserver available to it, as commit ecab4115c44c ("kbuild: mark `rustc`
> (and others) invocations as recursive") explains and did for the others.
>
> Otherwise, we get a warning from `rustc`. Thus fix it.
>
> Fixes: 6dc9d9ca9a72 ("kbuild: rust-analyzer: better error handling")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

