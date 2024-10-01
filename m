Return-Path: <linux-kernel+bounces-346386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D2B98C42A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3041B284619
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8622A1CBE82;
	Tue,  1 Oct 2024 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bID9/bYx"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B788C18CC0B;
	Tue,  1 Oct 2024 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727802408; cv=none; b=h1bAwhqMz6o60mD1Pv66/9hLDTAEqf3peP6ERzzhu6yp5kVhQ9529Ah2pNHhGMU3CQNBv7bw6NWfPUHdjjRTZHUd9HgI4PYK0cu8kZHS1MSen0Fi3QAq9TD1NwUVla3IfVhUk0ADl65kFOZx0c+w9ri4xNBR6oBTODkX5vbw0s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727802408; c=relaxed/simple;
	bh=zqeyiKv76fN5fAHsmzCvDIBitSehZK6Hf9ZCqFVtUbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=llGu7qWH9JDvH72UIxBGEROeFnYY3jMdY1BPJ+OAKpb1I1mLPkyzFUvRftvkSjelTLCHfdiGd6BOy9jpUNTSHNv5NJWgUSE0WLxWPmf1bbv2E7NohWdM3dU0VND85ppJjUKBbOBOPmgr+YxIxG2qJmd5ViT6MgOUF+W0mbVOI2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bID9/bYx; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71790698b22so821760b3a.1;
        Tue, 01 Oct 2024 10:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727802406; x=1728407206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqeyiKv76fN5fAHsmzCvDIBitSehZK6Hf9ZCqFVtUbY=;
        b=bID9/bYxRqQa+KKOxLQ7d1z4nvsSGbGE9S8PTf7ptxpGyPs0p7Yi5HTMBaWdgS3lON
         zxe7vZvoLRXx9ORYYjDLuWPnDuPcZ888luMJzTtGkf8JrCGqYW5wYSbtZOYQ2d/oPA4W
         m1EzUKHSxX8Ry4JAk4Bm1ns+s56f7WuiR03owtgl8s5E5ChppiP/MylDmT+P67+WVVp9
         sKbYNg8t+GQMoqnpZ83GtrOUd+27L3oQw+ShobpW43rdMG4QXjeXbCEVxPfUCJSgRn2D
         tIIezMvV81qmHGqA6gI6Vycf9/9qUXb5nXigUfcpdyDINNeTvNGpHOsyC9f2lEq+vBfR
         mQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727802406; x=1728407206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqeyiKv76fN5fAHsmzCvDIBitSehZK6Hf9ZCqFVtUbY=;
        b=sM8LEMYhauPMUjRTsTp8FbXIB4Z3qtu91vHVALkukKuNK01i/ZpcLo31nMObs3OxV5
         Qu+hF/zwV1378tLk4Qub0HgKPjV7NPKH6MmqltoZAjxxY0VX55Fwe44KITr7B2tyGWO1
         CJCwbyxsA6xt6Dr3BKJBhbEkVeIxt373cjejw0bsoV7Tms24AB2jXJvIi0sqJtI1wz5P
         SGuy9mN1QudcjLLVchBvMPLzQU23NSsCXpo2T7bJNch0QJPbG3If+6B3nZ+CTH5251s6
         3XHZFdr/imLk9VnMrnCBVE5Gt+T7wFuB/NRcQWmsm902Lx9iZcVHDJZW7LAHe6OF2B3D
         v6OQ==
X-Forwarded-Encrypted: i=1; AJvYcCViosUDbDLs1JaqHA/V2a7xv+4moHEPTFI0DVk3pFei9K4QFND2N2UrBD72hLTLCk0W2YT/cnlxtJsyNGM=@vger.kernel.org, AJvYcCVuCoIGnPIxQSd4qwrGTH1vB58do0KPsOHpGwJHI2k6Ysp2GoEsviHSEURp4xvgPG6iHgTpouJ1TLCNB0P65eY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV+qgRlYEMMvjTeRLi+sI7r1lJ+KouyWhmPpvnS90yf4IM36Bv
	yzPcNOK3ePUPQmbFai2FWaj+5tRaR40HzRtvnfJ/4gfOl6N7KonJcLQfXpWFSbWVumjBULhdgVT
	6UWbLSX5i2RtgBfYjWAcPiTML/Ow=
X-Google-Smtp-Source: AGHT+IGIQVO+FQ85WAIm/sMvZM2EtsMOkx2GGMHghXqo7HRV8k3Gp4cFH3MOrJUwZYsm/vyxfCqxmYqmzuVhTF6sEvs=
X-Received: by 2002:a05:6a00:2d18:b0:718:e49f:246f with SMTP id
 d2e1a72fcca58-71dc5d6f9aamr237915b3a.7.1727802405996; Tue, 01 Oct 2024
 10:06:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-9-ojeda@kernel.org>
 <CALNs47uC43vixDMt935BB-fuDJEKFE-SPFmSQp4Nt3v+O9wfbQ@mail.gmail.com>
In-Reply-To: <CALNs47uC43vixDMt935BB-fuDJEKFE-SPFmSQp4Nt3v+O9wfbQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 1 Oct 2024 19:06:33 +0200
Message-ID: <CANiq72kiQnRS9YAehD8-0-ZVtZzdrGb+NJehhnAXQaJ2nU7skA@mail.gmail.com>
Subject: Re: [PATCH 08/19] rust: enable `rustdoc::unescaped_backticks` lint
To: Trevor Gross <tmgross@umich.edu>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 6:40=E2=80=AFAM Trevor Gross <tmgross@umich.edu> wr=
ote:
>
> Maybe we should use something like FIXME(msrv) so things like this are
> easy to find?

It would be nice to standardize on something. As long as the version
number is there, I think it is OK even without a standard notation,
since it will be easy to find while grepping for cleanups on the
version upgrade.

Relatedly, Benno even proposed failing the build [1].

[1] https://lore.kernel.org/rust-for-linux/CANiq72=3D-bV_=3DTUoH6gLnPwTcxRO=
BqyrCpOpbumki_S+po1TPhQ@mail.gmail.com/

Cheers,
Miguel

