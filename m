Return-Path: <linux-kernel+bounces-556726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F98A5CDFB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4B591773F3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F602263C72;
	Tue, 11 Mar 2025 18:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b52VM4lN"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6A11DE3CE;
	Tue, 11 Mar 2025 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718163; cv=none; b=rB4E4iTj8PfZkC7IUKvoWOPLU7Y4JFVAALnbZLhWlMNxvF9MUNeMgZg3uNinKn4Gg83Qm4aM8x674GjqED3/hIm2Pm6esSNe+Kgwvhw5nTEsIeUUHkYKGFzYuG/LM1hgDTwXHtRZuShuDjnnO7jyDHuqMc34yd0YRtHpLkcFRFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718163; c=relaxed/simple;
	bh=mbgW0kUEsZezmUj5Gi6W94Hy08T0mYNvtx4ZiLvWeKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fB4w14iO1vhtw38x4e/R35HQpmXhQi0aYL7JVQzkB7hIAtQSy/TaBIeljl2hg1+U1cI+Br3HyLREVOjQ+SaVpiEt5Eu9gtynQLwvt2V5keZ5+3Yie3fOX9A9SR0EP6xOXbq8q1W8g26MtPKY8VJ0DrMe4N5DeHNM2xq6jrsdnHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b52VM4lN; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f74e6c6cbcso1524510a91.2;
        Tue, 11 Mar 2025 11:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741718161; x=1742322961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbgW0kUEsZezmUj5Gi6W94Hy08T0mYNvtx4ZiLvWeKc=;
        b=b52VM4lNvo3IwcuSCyd2QkG6cPa/wgW8eIacQ65XrWec36+DESRBtqTbv8UMJ973i6
         6cUYXZ2JSXk/9QdO+LqMJwDHvH/qT1Sov9LsEGITZemxp3+mFeTRudI8psIw/jBbZaTB
         Vrh2THKK0PG224L7CoBN8hEqcbNlX1gPey4ylYCj3POhNffJLBRcOxljiSWO2rvjwlHE
         8MrwGum3gCzsT6u8VXWpiOvDtGezfBWzV1ljxVt6jkbMzfm+mrlZe5K7grlOooZSttaR
         TSapj4KND7l6jIoznjXxHGjyZDf8vSpN7MCZIzmYYqlNNQxrEI4ckjaQ+SpWlHWFT8ei
         /0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741718161; x=1742322961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbgW0kUEsZezmUj5Gi6W94Hy08T0mYNvtx4ZiLvWeKc=;
        b=OU4xXiJ7Nv75JQA5l727u2Zqvzu1f8leyJWvpyTuM5tqmzCM5wwFlgynY1hSCycZpa
         /Ug0m2rzKHaLuovldMvKWRlv3RtuVN9NVG1dAHymyB7pnJ849126siMk+5m2GnhXKMUy
         WhlKWfxF1NF2Yhc5TkPh9qGLlbnyiLzCaT2HUuTFm5D2AnfJVmpD/wzxpoTnLNNF6yHl
         QFc2uk+qsgPfU8FfHeniZINNw93HTMXwFeuNJZ56ok/h5xrEVWlrnjeehnAOnmYj5G+C
         SB8hSNaPfqJJ1+vw2hCZwgcTD+E7HLy2oxWfl3GYKbJczpvRsXjKZWSagmBkCfyojA0B
         qm8A==
X-Forwarded-Encrypted: i=1; AJvYcCVKXzGuV/h5e9AMqG0NrZOoQYRnIYTGyoKN0Sa/smX3h3TeWwlinBTDB9PEfezElzi/tnGsp/X0rVlfTgs=@vger.kernel.org, AJvYcCW982lSqiXfcDHPjedoziTcE6RqQfFLl5nwfLhADWSi6SQ+bfuDSyEX/FEq3EXewmkxd1UoiqLeYnm8S4Q2VoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhBt2/QYPynAaD+Kgrqc1Jr/IhrOMpnyVcppkjvNBt1IFE9gA/
	PiVtp29MzS/TWJNWXTciYyLLrLKk2ZZ8hLxSFBRMOpcWfYfCm6KWwIsql2cmEb3hQHDbtIOWIOV
	hEl6IjfEYe7kMkiKXUarD9Q0QjhQCXB8Zew8=
X-Gm-Gg: ASbGncvXUYTRtV4E5XASoSY6EUqeeb61Grm/rezZGLnritN9K+7tcZ9vSl6ioajvfMR
	fJz0SNUKIzpS+yPzYE/4JxK01zP0UeuWr7gXF5chxWMvUCXauvhPT2VErplkiSAJh31BnlQ5ein
	WwEStc8FdSqn4RFu/AaBxtdq8tLQ==
X-Google-Smtp-Source: AGHT+IH2cmOQn/pJuzKnwPkPIwdfjpLEtIQAgPQbajD24xzlPRIR8bojQrzEWciYOytCML/zIjTHthACjDXzOuP0bg4=
X-Received: by 2002:a17:90b:224d:b0:2ff:4e90:3c47 with SMTP id
 98e67ed59e1d1-300ff897fd9mr2311534a91.4.1741718160973; Tue, 11 Mar 2025
 11:36:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
 <nxaaNW1XIbhf7dSf8aRLVF5Se-0maF6BhX8GaUXlsOL-QOste8OMQxtmhYe_BYI6FYFEMeHEzy1s4OEy7PdGKw==@protonmail.internalid>
 <20250307110821.1703422-5-abdiel.janulgue@gmail.com> <877c5038i1.fsf@kernel.org>
 <902d6f21-a6c9-4776-9e55-26f089acd0da@gmail.com>
In-Reply-To: <902d6f21-a6c9-4776-9e55-26f089acd0da@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 11 Mar 2025 19:35:48 +0100
X-Gm-Features: AQ5f1Jr5sFbT-pH3JLPyk4NOyAg6b8WWNgBaCLmj8KNaO5CgUCk4fq4OzPnifXc
Message-ID: <CANiq72njoQbMrBioohDQaUHixLa4u+1PKpQCoDPWTw0X5EhmAw@mail.gmail.com>
Subject: Re: [PATCH v13 4/7] rust: device: add dma addressing capabilities
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, rust-for-linux@vger.kernel.org, 
	daniel.almeida@collabora.com, dakr@kernel.org, robin.murphy@arm.com, 
	aliceryhl@google.com, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>, 
	Valentin Obst <kernel@valentinobst.de>, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 6:45=E2=80=AFPM Abdiel Janulgue
<abdiel.janulgue@gmail.com> wrote:
>
> This already uses `Error::from_errno`?

Maybe Andreas meant `to_result`?

Cheers,
Miguel

