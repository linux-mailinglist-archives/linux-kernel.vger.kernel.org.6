Return-Path: <linux-kernel+bounces-527413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C54A40B03
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 19:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 864B617C15F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 18:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E9020E337;
	Sat, 22 Feb 2025 18:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dByl97FV"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C34313A258;
	Sat, 22 Feb 2025 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740249719; cv=none; b=ItvNK3UGQnWfoRqHfTkyoaNwquLtHRxnAiUKc2OMtf4crTJxAYGOvvLOjk1tDxBZ5Ugb9+ULH5NxLkcfeS9PBaIXwXBG+KbK19XAuTExwU2gDg4wEj0Pgakx64rcLdQFY8qN0kY8Cyj7MCxHaw3EDBMP/VGEm0mtst8UpJvgQ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740249719; c=relaxed/simple;
	bh=VbZenRtC9+TPSWzasEoBLJvdHm80P9uUGlx167Tp4M0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFtQic68WpPjYaumCmiE3YtNXbekcd6zSvRpo5djo7QKVI1VRK/I7/NFLEFMUZyfG8Ki+xofLe8+nShzBDhDxSzVo1hMYK5Xphs/DT/k0e2qomOyzbAAYiBv5uMnv+tu5tS7AqfimH2D9G2/s5l80pDLLS8G5SNcpUyAtyo30e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dByl97FV; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-547bcef2f96so2857522e87.1;
        Sat, 22 Feb 2025 10:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740249716; x=1740854516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbZenRtC9+TPSWzasEoBLJvdHm80P9uUGlx167Tp4M0=;
        b=dByl97FV+O8j/PXR9V4byPUku+bvn+SpTP3B50gZKrl36St3RdcPR3idacDdGvTDOO
         LF6ddyhwV0+Gtb+beDIus9Ce+PZ6VVD1S08KrxOKrSU55MVVvcsMx3bAdhk2yCrR1+yI
         yl2gX6DRP+hHtNsuPb8FhRLthTbuw1ut49qWiI1QbMlK50jVt0hd2UhNbQPOaHEw2Ys3
         iwlV3kty7gFk0jSCvtA6J/0JI9nL/GfoW4ycjo9p2ENJgaOPVf4hEDLimw7sn78W/M7y
         WjQNMNGKXp6nwsZVwjXtZDFczwWx3jm9+86Y6ENx7ghj6sYHFehlo2WTeFqPHf1ectmf
         g7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740249716; x=1740854516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbZenRtC9+TPSWzasEoBLJvdHm80P9uUGlx167Tp4M0=;
        b=WrqAiHNPIZC9FeB71M/EnARzBy/BryL3uYi2ES8p1+x9WDalKlUFVQGnMwqqsSJ46V
         wsq8shJM1Vu4iKYhMfki48l+bCPZ3t+r9MY7DKEc7EyRFHzyuNN83k7J2CS4WfBNBZ09
         mAKzIdXb0mfgyokjhluRPJ7UEx8sxZEUsMtVT3M4HsYrQIvmLHcW68043gRrSLk1txpd
         OewA6q0IM2YdDhc+nuzp871kU01mvQwkcFsFlbSiRsa6PqelhOcSMRGBmpSwUGqYVdyV
         4GORDlQKrJv9sT3cZVESa2b6OtkYiVxZYYQCgTTfd0g/cv0pyi6nv8+wrNM6yNChQxWA
         z35A==
X-Forwarded-Encrypted: i=1; AJvYcCWJpJdXEjMy2ibb9h/+ZoChOAbcOBvIoNH3xbEKRmEoBwVbxqHxxMn2icjiSr+gIpSgHdazN0deRscuRjbtCYk=@vger.kernel.org, AJvYcCWj1s8O7Is5KYS257si/DpIN3Mgwf51fRW+NjUYOI0Lbhidu6hMEqhysejVlXwPkvAtWakCyVZlMoTw6Ks=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxkjECkf331i4Zy3QLdnke+Slu90VAzUGao5+Y5+NNWlSsdV+z
	KB285lsxlGvyHA/2REA5W4un1mXcfS9Zu8UP27yq+3UymEARej0DjhtXUtxoPrUfFOksHMDniyc
	gzpPpXipnbyoIilT8SYMaaCnj6Hg=
X-Gm-Gg: ASbGncsofMvOtkCPFyA7BK7HXxQmpFn3LqRa7WyedVDn5u3YBV8nPcJ/M7FpAN9Umr+
	AsOvjqzZHlMl5VH0WSyLNP/eC0YnSTIlXYkRrf/7JsKOG8agBjTESgP6jyjlrftCXEl5o8OVkEo
	ecjmH9Tklw2XAkWXx5AqhDJzjw42N4c/KTfyCqL3Hx
X-Google-Smtp-Source: AGHT+IHQaklvsVkmvQ8nOPbxCoc9+hpOZGmMrMyEM57qLIEKe0w2gFSBbXFBKNI8a/eesDFArSpMVABYo7VcHFeMdBA=
X-Received: by 2002:a05:6512:e99:b0:545:6fa:bf5f with SMTP id
 2adb3069b0e04-54838edd8b6mr2882221e87.2.1740249715992; Sat, 22 Feb 2025
 10:41:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
 <20250218-hrtimer-v3-v6-12-rc2-v8-2-48dedb015eb3@kernel.org>
 <KDmrJnQA2_Ojf67mD8WA_UafgVCACRRleB9t-D_1yl_bua8e1VWdGQAUvmMGHscqRHu1gzPJCKe_BfotutZm5Q==@protonmail.internalid>
 <CAJ-ks9ncOyGyQsDFOBxg-7wmXkrQYiZr6H6eEFWsFstk=p1uAA@mail.gmail.com>
 <87wmdkgvr0.fsf@kernel.org> <djAeSx8DNZwss2-UqXGmhVPqYm2z4LhKWC70jPHPisd1w70qmpmOfVbHfhqJErhoFwVFM8IpbTv4MKkk_BIpQw==@protonmail.internalid>
 <CAJ-ks9mNidHZvWkFJE1jExc2oVk_bbJpiO_DRMrWu5nYhTpKgg@mail.gmail.com>
 <87ldtzhexi.fsf@kernel.org> <87cyfbe89x.fsf@kernel.org> <SGJdAUqcAKv4KQX4f0wlLJtusvoK2zk7V_R6njD97VbfqqpS7ppRcIpCtSOtKbkDBNecXiJlQS9NcsuILxNCfA==@protonmail.internalid>
 <CAJ-ks9kLZ7LCTW+W4jhUqmF1ypJ7i56oSizdFV-1Ks5DiCoKsA@mail.gmail.com> <87bjutdefk.fsf@kernel.org>
In-Reply-To: <87bjutdefk.fsf@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 22 Feb 2025 13:41:19 -0500
X-Gm-Features: AWEUYZlERSP-c2xju5I6ReeWqhAU2EDd8C0bt4rp8SajIF_vjYuiNIUYMMRpdmQ
Message-ID: <CAJ-ks9nX+AAwmAMYX8iAG=BLWq-jx=NWEHVfn6TvB91jyZC1HA@mail.gmail.com>
Subject: Re: [PATCH v8 02/14] rust: hrtimer: introduce hrtimer support
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, 
	Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 1:26=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Right, that works. But if I pass in &self it's not really needed. You
> can see for yourself in next version.
>
> Hopefully I did not break any provenance rules.

Thank you for being willing to iterate!
Tamir

