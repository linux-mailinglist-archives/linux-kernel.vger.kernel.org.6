Return-Path: <linux-kernel+bounces-526129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B09A3FA99
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43169863D8C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD251EF0B4;
	Fri, 21 Feb 2025 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UriqCZ5G"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686321DA612;
	Fri, 21 Feb 2025 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153640; cv=none; b=FIcPQgjFjUAKr4xtPZdvHDR7d25QP6Fu9uiLX/pLj7EJOQ+dgj3SzkvMipDWpQqVZbqJyrhK/aQMXWot6grCT16ldydLYtWZzjvxTrdX00j7aDKJxmqKP1COVc8EVoSiBEgvl/qdAah7di+B+UXcLyV4Dm6ZTjMaReCMnUEKJTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153640; c=relaxed/simple;
	bh=UOzbfv//WrAJMBDKRvRCXiRCHe07KyFnDUcweAG37Ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qf+JycAi97JMs/Md7wK2ig0rGXmew5EmZUZl0o7BFGi4doGJhnBUpJdDT1bKO1YAdVSJtISlJ4NRQCAh4HoRNztQ7aGTMOXO++yS6zWo+C4Ir8bDPSIAitmR6zS4Y/h+xxPOJKQt7EK4oXUR/qM7/drbWzyRlR+NoSfehRVF7X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UriqCZ5G; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30a2dfcfd83so22047391fa.1;
        Fri, 21 Feb 2025 08:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740153636; x=1740758436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOzbfv//WrAJMBDKRvRCXiRCHe07KyFnDUcweAG37Ko=;
        b=UriqCZ5GVMKEDhGmwGMc2xnLVv8tt4ruUbbnNg6jh6tt83Ihkftz6Zvg/hPi/o2qYG
         uJ3KH6AOtBCV2ypPx2qUWeNhAMnTivxK/k20cjc4G+Y3SJ0lqu8Dq7FnITKD2vaAHYVJ
         +aIDFn4PrsdPchPuyXuizbAcrfM0SJots1YUE7F+vaZLgiOEtxKMbrjNc7l22HKFchrG
         vVFOAtdSued0o4yo5fMoqQ8tsMvMx43jIhROrLeDTMunuWXM3Q6QkbvQLmnFad0cVJq6
         QW8vwt1xvOV236kL5KBpZ9xYzgt2yjy7UQXArdACwQAjNNwNFUBjZmr7Wa4P/ZxYQv0B
         cgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740153636; x=1740758436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOzbfv//WrAJMBDKRvRCXiRCHe07KyFnDUcweAG37Ko=;
        b=cf6YYqnisqfA6OOX+tSlQW6zSWKe7GCqMK0WhS3X+SWmB7R/eOOG7BF9qoPyiv7Uk/
         gTAp4hRvL1uET/hYswg7XTb9Unh13KjKYP29JeU2nBr0CAMXAu01a8almyj9ZWFjvxdd
         ho1ETfmFFJ2iV5AQxsYLJJLHBpSCqr7WMO6uv2Ahc+nDH8uNb2W9ysHipqTHDVPTe1CF
         ZCnG3A7+E3bSWjD45BQwhDGGUvIcfA5QLrsolae7RWtRmJdcprs3gkYoVYaZmR5BKDE9
         VKxHLhqJ5eQ8ryUqIfNIR+wpAGgf3f3Qm/8NeT3OFR82+k0PUcAGe86Urd12fnMYO97K
         3BlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNPjM+3su/izmNF8Fqk+93RkSR4OG4oUrCbAuJo4xKDYHYBBQS8it9YXj/AewSCASZi+DrSA7MSlR5TDZtgkQ=@vger.kernel.org, AJvYcCVCLFDXswaGbqO5uVNhx0tCpWZZPXFayIkTjq6vkN5R7papnJ4u+C8EjD4TlpbzIvySJEhL+k5ixFIEstg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfCHtZef8AjA5izKTf6apmm9yLPa3u6CAiS/MVJ0h9pB4pxFVT
	NRviw7qLe3tvcSKd4hyszNpqwXqh+ieONNPCX/H8MkKDiKHuvc32l55zjQMSK0KbfZ4Z/JrKOnQ
	RPD4cMsybe3ey/RZTzuBk2A8BsR4=
X-Gm-Gg: ASbGncvCxq7z312q4VTI8PoxeZiP/vu8LqxomSlk4AUTyBNeTN+/8jgSFeLdd1Nz9o/
	fxG5bXXIC3ryIrzEt6bRdsKOKuD/5MDNXJ3XXw+kP72ZdFdSYpNrPecSKVDKgUIYhRXGQuXvgSV
	5ehcpuoi7rmsUpFPCE6DLQ7D16aO39iaXUH40RVc0G
X-Google-Smtp-Source: AGHT+IEhXitaBMzKmyONJUbTnv7Qi2XAWkPUvY2EaWJNsyyAYGg4s36fkAcfVm5uHCE+MGObs7wmrJbTxyI0+Kq+1Y0=
X-Received: by 2002:a2e:90d4:0:b0:309:1b26:aecd with SMTP id
 38308e7fff4ca-30a5989820dmr11359901fa.10.1740153636063; Fri, 21 Feb 2025
 08:00:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203-cstr-core-v8-0-cb3f26e78686@gmail.com>
 <CAJ-ks9kyozt45VeXG7GBTN-ejy_HGMOekFYFMmzS8AbEusZMWQ@mail.gmail.com>
 <CAH5fLgjUuCo5Ayx4WCfnrVAC1prvUbY-pvZdinkAb+KcSOWvpA@mail.gmail.com> <20250221142816.0c015e9f@eugeo>
In-Reply-To: <20250221142816.0c015e9f@eugeo>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 21 Feb 2025 10:59:59 -0500
X-Gm-Features: AWEUYZkUpM-4WrUptyj1BTTOWrZnuYpPYvTy3-TR6nNOU7iNgzocxstRXfqToqo
Message-ID: <CAJ-ks9=9OozDw7XotP_0Hpb4-p4VmPMSwmEdnnCpk1gCEJyZiA@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] rust: replace kernel::str::CStr w/ core::ffi::CStr
To: Gary Guo <gary@garyguo.net>
Cc: Alice Ryhl <aliceryhl@google.com>, Michal Rostecki <vadorovsky@protonmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 9:28=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> I'd want to add that we currently also have our own `BStr` and then we
> have the `CStr` -> `BStr` -> `[u8]` deref chain which is quite often
> useful. If we move to the `core::ffi::CStr` then we would lose ability
> to do so.

True. The best we could do is `impl AsRef<BStr> for CStr`, I think.

