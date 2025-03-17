Return-Path: <linux-kernel+bounces-564036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC92A64C7C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E83987A98C0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EF8237A4F;
	Mon, 17 Mar 2025 11:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsa9gVRf"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA53121A436;
	Mon, 17 Mar 2025 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742210771; cv=none; b=XwWrARUMy5XmnGXQWMYvYuqNVPSx7s+/H3EAC+XypdVG50z12/leGMaivIYW1jOBASJFMgBmjq9ye7kCZLEeznUB75kmdgPFH4/zKpy+ZKnDIUxzsFBLGfHmN8+/dNBhb1/ld7OZpdspwLn2zTaYca+YfILcS9y46GV6mw8futM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742210771; c=relaxed/simple;
	bh=WyIfbnYVHdJVKac210obvU5b58VHVpKy3VWeo4MaCjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=teysmxDlO69z7JTNZW5pvn6FfRuseYGGjOH3hszj9HAXqidop7HiJ7yCNCYGPcnqm6rYjRBcLmoxFk+4NibKKdq+tY4IMW7oaXNNwmNQA/SSgsxjBTfCcy/+5TQOklhv/Mrfhk+veMusl4LwZaqBYLtpuRhrJuf7M/fH6ymFzZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsa9gVRf; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3061513d353so53237331fa.2;
        Mon, 17 Mar 2025 04:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742210768; x=1742815568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyIfbnYVHdJVKac210obvU5b58VHVpKy3VWeo4MaCjE=;
        b=jsa9gVRfbcdT/5ofqc1qA4a6DX57Vu0g2OIkNXPgjBvQdpFacxfWuIAqJjH1YPwEpK
         NvV/itQV3lZcCAjC6nS1iXJOwh0B5YnzuENlfM84FJh6sIf/u7wAJJH784UxfKMPqbJs
         SbjZ+NHLOpYIoJmnNreFAlk7nJ62+62bmziNHBZxmtg+ujHUPwZjJt9k+AM1sLPMSb+R
         qPiK4Nu9qqqmcFwLqiz59vkBICUPfj+hgU2nfEQDO41WZ/mTG9GJFfXj7wZ6+1BcZqiA
         WWoeMsn7hW3KvdJXyzVN8qJQQu+WrtJrX6XuwPkzE053yJCZnWLRxiZB+Jdm7Ys9pSJn
         TLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742210768; x=1742815568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WyIfbnYVHdJVKac210obvU5b58VHVpKy3VWeo4MaCjE=;
        b=etgNXzXeiqBkzSMLSSYll9jV4xmBOAWsk/kKe+T4MFUhlIcEjb4uk1gHjA8KGhZmN8
         xuF4kb0GJOu7kgBD28cAumye//efl7BU5tow7sutV9nfk3epFmJOIn9NhC1YlJT/EDqU
         p2vN8nv9sNz2R5PoOosz9W+aVGdRqx3Lco0pGuWkOJOJaummARubaCU7i07zW12A+oPZ
         RWqXlVWF4cJ70sI/ImPpbRiYCuiXl8Xmzju0b94GjkDLjrFHP48WYRYDyJzNqobTQbrw
         X5gfEDQFJvhQ5mg4/YgztpMrRUYJ/PFADJ76430iXouATcwGrprZOPE0Qf2Pjpiq2XQa
         VqrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM7EjAEbloOOWxT/tSs5gArwdmqLCddlGtv5bCrDvZxKh/QPg0aXtSGzwA5FJjfnfQpeclHmI7T0VNj1ptZsQ=@vger.kernel.org, AJvYcCX/pwzdI4ZUgu8HMDj/IaVtmEknGaHaCaeSnyHZOgMdIvpTOdWJ145xphB0DLhaOOCxhF56S/VK/kIwCUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr8U7/SB4fTvsSsDfFlpClDJSr+O9V8vYTOGfWD70dtrWPVGgt
	yA4adcMdkW1AtiI2a0z4/8ByLDxMpD39lk+q7B133rPeG7pCuoZ9Dw9LLy2DaQj/N31puRHpNlc
	QJraK6UvWPlWBAgJ1g7SF981NbTg=
X-Gm-Gg: ASbGncvxHIe0dYs6BfypuyKKDFFes1atfWfYTgK6Ibtqwo5raggXhlc5uftoW6C+UAA
	0rMUezg//sYQ+fQDv5fkkXguqaOumV/hWlX2BSr3/orP/FAKoQHHP4y022g5ui+vChaV/1CJ7DV
	4OpAtHwQb6Iq4itSMRd1wH5PUlV7fol6FYJ+i3c2+oBdraWMQXnjVqETYouFzz
X-Google-Smtp-Source: AGHT+IEkwyX6tRMaDZQeG2oFhOjkkW6xxTC0hfivipXStQsQ5qqMe+i7lNECis1Ee/TQoOAmBWbclm5GvRUWZ2APsEM=
X-Received: by 2002:a05:651c:19a5:b0:30b:d4a9:947c with SMTP id
 38308e7fff4ca-30c4a8c60d4mr73485591fa.24.1742210767898; Mon, 17 Mar 2025
 04:26:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com>
 <20250316-vec-set-len-v1-1-60f98a28723f@gmail.com> <Z9f-Z15bSh8MA1wJ@google.com>
In-Reply-To: <Z9f-Z15bSh8MA1wJ@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 07:25:31 -0400
X-Gm-Features: AQ5f1JpIb8xreZJwei6vgQJXTjiatPvnC8xVA4NX4ptIamT0zy96mHtehFOXCxE
Message-ID: <CAJ-ks9mxh6nsLija2si9urKqC7CVBbLWw_NbOni_T1QeNjh9fQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: alloc: replace `Vec::set_len` with `inc_len`
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Andrew Ballance <andrewjballance@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 6:50=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Sun, Mar 16, 2025 at 06:32:00PM -0400, Tamir Duberstein wrote:
> > Rename `set_len` to `inc_len` and simplify its safety contract.
>
> You're missing a Signed-off-by tag.

Thanks, added.

