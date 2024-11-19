Return-Path: <linux-kernel+bounces-414859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF3A9D2E85
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A6FBB2C6B3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140A41D0F68;
	Tue, 19 Nov 2024 18:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dr8Sq2g4"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC4D40BE0;
	Tue, 19 Nov 2024 18:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732042543; cv=none; b=TFXOvR80WlvNTAICUHrMbnbuGblE51kYRxT+3YCWZYgvbsDe5EH4lnZ39O/RzO5f08fySfRFA0D+C31M7AtLybsmGsCwDRnAZvMbtMtDz5rmKKN0jn+1OAzSzhdmRnleLGdzPUvNED6nzvotrAKowjiO7mIY/zNM8QFEWu/9Muo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732042543; c=relaxed/simple;
	bh=egRJ37m21tAWJ3fTxQb6pUKLR9jZKUZpLBaPCH7yYFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lXeg3Wb0nx6bSwjs6ZlJJjHoi6c+Aq/D07Ce89AdXcDgpIUzJ95zeQL8sJYwcMcZ0PTRKTvxkCtvC0/SVkSrv5YcmMstlJPaQQ84mwinGTrqfwkkprAnPJkVAF6DPbZY48wjl7saJdQPA21O7ZzJtITe5JaGF2ioZiOjvZK1YCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dr8Sq2g4; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso52164841fa.2;
        Tue, 19 Nov 2024 10:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732042540; x=1732647340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egRJ37m21tAWJ3fTxQb6pUKLR9jZKUZpLBaPCH7yYFY=;
        b=dr8Sq2g4hZHrX3dIn974sKUrCboh5SsItZAfTSjdDY8TXOYtnIijr9KKlKFf/99TmC
         X2AKfbuj80ZL2t2XNbmtgXaK0Zkgx55cpSQS9aE+HJ8mR/x5As0KZZCN95GFIrRt6hKD
         32qpJKf2wT0HgvNnv+pTwBwZWS6a+DoNczxum//9YIpycf2EExG3T5z31geXniQlXzNY
         DSA9/reXOuEUZtLQnkVPIo0U4Kglo6+why02SmjP7LTfb318bgLmUI9g6i3IcAqpPGdP
         8VRHNjDE3mvMutyuOUskGzwxLWcaeDmX6gap/mdcAHVj4KLCgfPyyRE+aJ6dxXwpQT24
         uuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732042540; x=1732647340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egRJ37m21tAWJ3fTxQb6pUKLR9jZKUZpLBaPCH7yYFY=;
        b=DyfQE1RoMHdyux5q0BLFZ7HuLsgc/MxkD6Qm9kUpVD/0BY6qBZhZlliQqr7jbZgJ9b
         pvKBKR4QkbUKtOZ3fvyvMW6u7etS+OBF/paftq2Ktkr8CAdmBeoOPjyMIqbxhk/20p3V
         A37OWkUW8/6Uhq0+Jpss9H612FpucIjZErUQMKTMP9eCXOY+fJeS0azyBdQ6cHx7y0JU
         W15Pe8zzYFK2w7Z5RkJE3F2VugfOe3Qu6Lq0FJuKHGFWCPyWLoHUG5v1Y5S0nPxz7FsF
         s7sLZABOQmNCWGlH2ReyTAMYomUEt7UexDZ9AddGZkAPW0+eY1CZvjyuvHF0kO0KS/RM
         XHuA==
X-Forwarded-Encrypted: i=1; AJvYcCUaVSkHlWz6E4mkkkO46BAQ4BWFhOIjeBPN3JnkpNO5N5qF1Lq4Z9hvA3auA1F8QbZF8mZsOolE+up/zy0=@vger.kernel.org, AJvYcCX1DnF/a+UxBwOx4vteYEk/26ij84+YoOzCJe+uP6DU8CUvBpbl5+b9Kcj7BWBo29eAr+0QIHZvVT1mzP4eVG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuxitS9Vnzg0oVOw2wD+A9NH9w6KLZAx2gFFNeDa0CICZHWNZo
	wUMwX0M2T5MGKG0HsPwuxOkSiWM5nakZKw7P55S1nHtLHuIYLxPQjxVPnsOXsipFDjMKRU+zIn2
	Gz6BHbrUqOJLP0Iu7Q6ZLDeo3kRc=
X-Google-Smtp-Source: AGHT+IEtBZreR1yGzfr3krCkB56BOKyQAGiX/N8Wh2wU10A5R7PwOl6GeoSujRddyoMc7X9OpYLpGzQK7wEvI7XVz0M=
X-Received: by 2002:a05:651c:504:b0:2fb:3df8:6a8c with SMTP id
 38308e7fff4ca-2ff8dba1635mr1165601fa.23.1732042539975; Tue, 19 Nov 2024
 10:55:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118-rust-xarray-bindings-v9-0-3219cdb53685@gmail.com>
 <20241118-rust-xarray-bindings-v9-2-3219cdb53685@gmail.com>
 <Zzu9SzkDoq_1YQnJ@tardis.local> <CAJ-ks9mKArX37VzhcyymDoE-MsNxNcO8VvP4n3Xu1mdfOKiuag@mail.gmail.com>
 <CAH5fLggL7MTLVv2ym_tCCKH9hQtL=GpTwXjDUQzKQX9UdT7SkA@mail.gmail.com>
 <CAJ-ks9k4upcSfa2HXaMrtDJ37eTNc-ZiKZdcLuEYSnWHL5Bigw@mail.gmail.com>
 <CAH5fLggBZsarrRkZ1Mf5ND9-A6kCc65QRwhUW5X9nQxRJUOXrQ@mail.gmail.com>
 <CAJ-ks9=ZDRdh1UzBpV-ck2v5t4a3-81vD07Ndfmow4ABmQvJmQ@mail.gmail.com>
 <CANiq72=MeVViwfFGaj7MFev0ZOodVo2dJqOeHiPodHjN-xh9TA@mail.gmail.com>
 <CAJ-ks9kgaVGow2o1S+YAUpYF6pVFReEb2mf+OFMvULt2pykH7g@mail.gmail.com> <CANiq72mGzd-Y7b2DVczagfpNR7Uky6iNx+8dUU4g27e3O+GJjg@mail.gmail.com>
In-Reply-To: <CANiq72mGzd-Y7b2DVczagfpNR7Uky6iNx+8dUU4g27e3O+GJjg@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 19 Nov 2024 13:55:03 -0500
Message-ID: <CAJ-ks9=3SbKPROmAQxpfq8-R5xi1jWcjoP_3nt7rNUA9v_oS3A@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] rust: xarray: Add an abstraction for XArray
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 1:40=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Nov 19, 2024 at 7:22=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > Looks like there are merge conflicts between v6.13 and rust-next.
> > What's the usual process for resolution?
>
> You can take a look, for instance, at how it was done in linux-next.
>
> (Nit: mainline is not yet v6.13)

I guess I can just set base-commit to linux-next.

