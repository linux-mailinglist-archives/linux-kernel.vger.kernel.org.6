Return-Path: <linux-kernel+bounces-441835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B9D9ED4B5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC680188AB63
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8C62040A0;
	Wed, 11 Dec 2024 18:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkyQ1Hh3"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56613202F9D;
	Wed, 11 Dec 2024 18:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733941716; cv=none; b=n2TTVV36/wp8GUiqKP/yuMQZyo2MXbG3LI5WKNk3pywa7JOXyqfJme9VGgoRHzJSCPBUvDdfJyft+oJ4v8F8G+/Hf0V+Po4giIAPAl79UEiImkOq6ru7PASqRXtQjkpEfjzXTN7sayonFI+KD51CJoz23jjEo8heDaoTTU+RmY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733941716; c=relaxed/simple;
	bh=R1w76iXvEh8RjSnDIzsROlPp+t/AX6qtZWx1Ex3EUlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gb6bwSjNl/zt+7aCEvhwS5ws4tLuG5FQLN+s8jlrDo1JtciDEvJ38wcxQx7zc6vjBbfNgRoc5CAY/md30kKOjUpshvSsSbhViH9MQ8oW5S+gBxcCyF/lH39jab4Cz7cM1IE7yCMBHHni7ZJ1fcBQ2kRekH+bLJlk7x0hOEpoGd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkyQ1Hh3; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ee9b1a2116so799793a91.3;
        Wed, 11 Dec 2024 10:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733941714; x=1734546514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhNDvbH/jJh7gKYq6lUH62SQyHaya50vnTSn0IAQDPM=;
        b=RkyQ1Hh3Wev61ogen6AxpEaurqTqm/QHgjW0pSn8NtRCyfEK2iRgHBF2HlxRRqd5xV
         kaeA09wUAfx4xhoZrKZTX3Gy+S7546SIu7QzCcf/gUrYDVbP/5TpxbiCt+1ukM4H4H6P
         NScC19As4BFaCKhMPb2M7CUsK5E0Pka41yme4zNtNpsmBPgvJcdpSHjcbR1GAujsj09V
         VqzirerV7DAACEEV1EUvxw9fbNQ7sslshGtWlgAGeAI4JRVCo+E6rSNJi7ZALIUgzrLo
         XSZUCg66cvfEDB3ikLhqrI6SKo6WkW5/ApHU2tVp2xyOmWuZ72M6KC43eqrL3PkelCkY
         TIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733941714; x=1734546514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhNDvbH/jJh7gKYq6lUH62SQyHaya50vnTSn0IAQDPM=;
        b=Kj82rziF013KHQv4M+27Fyx3u83LMey1pptETGAuAs/00r7DGJi9Nj8JDsDhQKlojh
         eni56lazkw9JTkPfvzMuIochT1fFMRHQYIAD8NDpXkOvR7NNgtWDVUZ0602IoEPFoiR+
         w2xQG59woMMuxfzpxbFX6iAAyDeHVe35RWSVKeqWggOlAGP7rP9tRFFsTFWX3IYH0qwG
         zNk/ELEbnyCUjwIhwVGJsTlysO5lH2TkC/ziGkHRpaF4KihInfVxM0aK2uvPIJwI3KQH
         ZkZisTp58zBuVNtW4PUvqSM3jdnaYDjjmLCA4K0SAuhK7uudXLzLvr8V0MItMq06XB6K
         8lRg==
X-Forwarded-Encrypted: i=1; AJvYcCWNDJGnI8/arKUW/wDxITBOKFOmNQC73BpIamwo6mwKCCP5wt/eMVXYn7jgOPdZw7GY+expCRY6VPD0tWXZAp4=@vger.kernel.org, AJvYcCWZc+sefcPkQ+tMqO6+YI66/UbqdGVhlmKETWx5+Cw5hNM2IE483MzfeOIHS0yfsJKwUYNUA2FWZqc94F0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Kkwsd0NkwXt4yU3cZPPMb43sf29gQgvkLQjE+eb+rSEerqVW
	pt1kdQ1anZWCH8ORGOdMXPurodH1Wn6hGFHObgnt/K2kvU5+ZTU2aS9JHzor0mthwM7LULhi9VD
	rqnSgVf9QnoP0Tpc3OHRli3Lwobk=
X-Gm-Gg: ASbGncuiTOAkOUdY+Yepp7Qvzg7xqDSrZZ1eL/aAm2JBQpMkchu/jKW6YxDI7GAOe0y
	eFv9uXVXt+IdolG9nKSjQPWh5BQEAU3W6Wg0=
X-Google-Smtp-Source: AGHT+IHR9vYiMHmJxEf1G8508se5jLW5vkJSOH+3hAASak59a4r5x9U8VB6HtbLTpTTJDoCFJX+qXu2rWcygXHD8eQ8=
X-Received: by 2002:a17:90b:1b0f:b0:2ea:5e0c:2844 with SMTP id
 98e67ed59e1d1-2f12802cf2emr2244193a91.5.1733941714559; Wed, 11 Dec 2024
 10:28:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211181639.19848-1-eisantosh95@gmail.com>
In-Reply-To: <20241211181639.19848-1-eisantosh95@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 11 Dec 2024 19:28:22 +0100
Message-ID: <CANiq72kYsb0AwDC-AEKUGpFK4gzj1nd9jukrM+gesssjF6hveA@mail.gmail.com>
Subject: Re: [PATCH] rust: Fix EXPORT_SYMBOL_RUST_GPL macro to follow guidelines
To: eisantosh95@gmail.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 7:16=E2=80=AFPM <eisantosh95@gmail.com> wrote:
>
> From: Santosh Mahto <eisantosh95@gmail.com>
>
> Warning found by checkpatch.pl script.

Thanks for the patch!

Which warning? I guess you mean:

    WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/var=
iable

But this is not a normal use of `EXPORT_SYMBOL*()`, and anyway the
patch would break the build since the name is not declared otherwise.

Did you try to build the kernel after the patch with Rust enabled?

Cheers,
Miguel

