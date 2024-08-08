Return-Path: <linux-kernel+bounces-279508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C22794BE33
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052B61F22FA3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B773D18CC05;
	Thu,  8 Aug 2024 13:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRxp+mZO"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF75718CBF7;
	Thu,  8 Aug 2024 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122518; cv=none; b=WvoMuMFWRV5mporTZXwtPtR8+vLO4F4ZDc99cUgZRnh+j2dCBhnRn789oBUfzr3b7IYeGb4b82oGVdc8tafhS4NOh7Bo4LEqsRIhyVUCNT7zmwwPlAc9gEkGuBZmbJmxCM49+68wv5KK4Dty+DneZO6DA24MRvzs4W0EQr9Sp2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122518; c=relaxed/simple;
	bh=L/M0l0Y7vAGTAav8a1ztyDeeEzsRFpVwzNDMa42BSoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ogn3ldA7I1t1FfsdI8o0fX5R9QDFx14kSGryKKpmozyWASQeRlha25YYdJ4wMaHVEFCtI5DJsZQnCh9UzPhDsWfYYeBUb+huZaUcjgxBvLKNGBNj7EvJkeFfDZ3Cxq5aUtZsIKQwI7h36FGtmZUli7pOFjw4y1sOctFD70/PRzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRxp+mZO; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2cb4c584029so776178a91.3;
        Thu, 08 Aug 2024 06:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723122516; x=1723727316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/M0l0Y7vAGTAav8a1ztyDeeEzsRFpVwzNDMa42BSoE=;
        b=CRxp+mZO4dvhqCz9sjcBJwelw1aAMmh9vxqCaB4Ug1F+eP6hd+cqDnes/b4pR5p8Nt
         1rIC8dDExwgZz+FgZU4RR3P9Cixr1U9AJIs7sUDD/+kIowFIrkmfahDMd05nAhSCuk5Z
         DtmcxvrzKYHgfs2OkkewHevAKfvhOK0WNzz8h8/1eNqWuStzyaLtlQF9nBTFQsj1XAbi
         wiiPWMjx/Hr3yFNt2NqvPF82e9Xe8NWDZ3PbPdu6ZimRRE/2N+JKFO/mXbajprxLQAok
         iLpMPCLRxbzFQsQeITEJt07BsyudbxpKFuc1xZW25o6M2eTy/NAOX5NlYEn3KfopeY4a
         HbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723122516; x=1723727316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/M0l0Y7vAGTAav8a1ztyDeeEzsRFpVwzNDMa42BSoE=;
        b=IRAd9pChoROcW4khgtIgiAz6rhl6Yyb0RHBdWVZtmHph48kiSQLbiEQfVPgHUbNv6T
         azfuTQIO+Hq3H2VJGBekzPEVhc2kbxv5bftSz86iwRBoAtM5OkbNfjeTwtS/rYb7xtg0
         nWVSSmT9qJ5yCpuCKQIW9nuKKnZOMpdc7qdk3Abv53nFNaSy0KkTrlgRotpq08qEGKU8
         8OmhxloiZgt1wephCS9Fr/tlYyKLADxSG4tCn/x8m5J/ZnuK9afx+OqgC0VxxqZS4zCh
         dWcoxdQpoBrzbktO4x4nxQvkN2ugZc4wjUTTUGlhbWECYJPyp/yKiEA5YA5dhsX7qsTi
         1STA==
X-Forwarded-Encrypted: i=1; AJvYcCVtyjPItDYHkxltzMiPOy9pIthJLsq/92uGWoIy/g0UAD90idK+Ca5rwvUd40KRvihbNrmoJSCcIV98UZansJFfn1K9i610BDIEPrspr3iVZAdC9rzasW6AkzEmRDOP4o6nAn9RFB5hMyY+J4+C/8AoJJOJVWsUg/pja5s0X0Tq+O/dd7JTtrU=
X-Gm-Message-State: AOJu0YyCkqK24eZlp4cFhxtnVI5445lCu1FjqmEPYm1LQhLRJXCNKcxv
	uIBLQpHYKVRJPpu2RGapErNbReRHCZU2ILlGLV09Ewv+nv2uKNODFW30xOHQSikBMhUP3LNovHX
	rQHk9V7+VNMS2i+JAZN4mFqP3zhU=
X-Google-Smtp-Source: AGHT+IGfFzPyUK5IICdqCExsjWYelZFtELj+WkhmSpJAGFTU1g/ePQyocRfSmcepEbd9z7Q5GNtoCoirfky7VCO0w/w=
X-Received: by 2002:a17:90b:224d:b0:2c9:77d8:bb60 with SMTP id
 98e67ed59e1d1-2d1c346b248mr2272576a91.35.1723122515900; Thu, 08 Aug 2024
 06:08:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717221133.459589-1-benno.lossin@proton.me>
 <20240717221133.459589-2-benno.lossin@proton.me> <99DF6A0F-BAE9-4341-8B42-6C1F1C69E2C6@collabora.com>
 <a5afc0ed-2193-42f2-a7ef-50fba68980a6@proton.me> <AEA74965-3ABB-42A4-AF0D-DC5D9E6CE7D3@collabora.com>
In-Reply-To: <AEA74965-3ABB-42A4-AF0D-DC5D9E6CE7D3@collabora.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 8 Aug 2024 15:08:23 +0200
Message-ID: <CANiq72=mML_kW4zdcK127Te+N=MKT_hfU+7t3EsTpPd54o=5+A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] doc: rust: create safety standard
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Jonathan Corbet <corbet@lwn.net>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 3:02=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> Yeah, I wasn=E2=80=99t referring to formal verification, just a lint that=
 will complain when
> it finds an unsafe block that has no safety comments at all. The clippy l=
ints you
> listed should work fine and, IIUC, Miguel already has a patch to enable (=
some of) them,
> so I don=E2=80=99t think any further action is needed.

+1, sending a series about that soon.

Cheers,
Miguel

