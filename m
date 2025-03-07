Return-Path: <linux-kernel+bounces-551148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3486A568A9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0F2178CDE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A21C218592;
	Fri,  7 Mar 2025 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSRDPPrI"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E6A1E868;
	Fri,  7 Mar 2025 13:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741353462; cv=none; b=gZi7zybBYZRyrRSHxQ8ktEiUWEy/6SArgBBsXMTB4WiiTZOpF7hsSegPhVCwR6eFNzIjkkgdc554eMuVYLmXoZw9u4Fzi/8I7L0/MoK9zBJ0RaIf9IDjP+1l9OFA45PcRSliqOPF2T9Lpov5n/ZsltU929WNMiwLVgwpTQMOqmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741353462; c=relaxed/simple;
	bh=8lBRiRcY2T2EJ7Pq1K3xNSqS3zNMKLcLcwBGpxP47Hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ch3U/lWj8JuduAdIxDznbK4g0v9O3Ry1v5p2bXcdeTDup9HIMqJChFvEE75DT1Fq12m68ohF5P+zltXcN1AzlvslgvWISL5KfmS6fdutcRhPelspZ3knNOMYbupfAxbZjJSZRQXfCwdKSxQxSzTEVZ+Ows5TBCVim/ijy8a0sIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSRDPPrI; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ff5544af03so471592a91.1;
        Fri, 07 Mar 2025 05:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741353460; x=1741958260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lBRiRcY2T2EJ7Pq1K3xNSqS3zNMKLcLcwBGpxP47Hk=;
        b=aSRDPPrI6bkl7UjVNHeoAnlOdEJ7CmdUniUp9iPZ9Niabg/TLYsouxlEnzBw0BkJCZ
         REoG9i3v/UNuB+alrT7/0tAsHqN/oZviXYr0A+zc8br8/czw8RH15btihtPsHnJnS4N4
         zWtxHFBeaaLs/SR6g+1MiV64aYClXyEJU9/N3BY8hSgzICXfQ8ZjOMsLC1QHVUdTGczX
         40D+kBTx/iFcnIq8J4wpVXlY5eDzhqmfuOJnJfvtM/9ntYV3WYtREh0JTE9qs+8uk/xJ
         Wk5c6t6IY9u3dY5MlWxhSSbb1LmYzLjUtdWJOhwWPAf56CBpThxoA9H5HDLuPwb/0uT1
         ExWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741353460; x=1741958260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8lBRiRcY2T2EJ7Pq1K3xNSqS3zNMKLcLcwBGpxP47Hk=;
        b=ArWRUS9W9r80T4w+T4VsBH5ShwLtkulB18JB9LM+klPZ9j8W8KtybnfG3nFWy1j20j
         k6XdFIvxmLkKamcWjUIzc4RV+L0ow9uUm2/osJXKrDY0JWmZj9v5HzRktbGbS/OeUpP2
         lyzxzfjy5mBVhbgpc8VL6Z4ovhZ4/tQ/Dm8k6x60rlPipM8USk1YGYmFuIjaK4hEJOr+
         reCq+/q/icEoNyH7ljTSsYZF4CwhgPdlxF5ClV/WbM/+kt6Epxid3Pa20ZMGMCrGcl/k
         viPgBDcv7/mOHkyk2r06+EkzkEAT8tTfSax5qh5fw1vSLznub1gsIn9wCcUe1/T7CeJm
         xaiA==
X-Forwarded-Encrypted: i=1; AJvYcCUj1nEXQJE7Z5m/HSxtcNhq5tjcJTngoR6n6rC0jrNDnVl1U2bIzPZVkD6AJY5rABnY63mlHywWE9XMywQ=@vger.kernel.org, AJvYcCX0BAmCrLaYS06Hi0Y+evJkxCZU3Mnp9lXMzwtVJFrMET3T3H86BECXWRxaS9Prxb3Km7WZJwdPyUQtg6W4QuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGAO/JHeA/H0NMbgGRPPcRTMGsbX/xE+ahvTUX0oT6dlpxZh0B
	5jiNSKbEf+hp5UnW6XWUfKHS05/mXh8eePJmJqAoX5NjOtRsybA6mmCsH8gIzSasedWGc5iY2ou
	vBoxYI7cCiOJEnRL4b2CV9swR7/k=
X-Gm-Gg: ASbGnct59PJ6K78Wyn06zQmquRfyAK+xCnzZHFaTdc1dUzPuaW3VdFctnhjMr9aaryM
	l8Gif6Vt7gYFzmPlwuHa21uOsOG3OOl+O0iFVZOgRG+ymsXS1SpKgZlRcbYPZ9Z77Vc6g58xU3/
	hRMQqrmql3sRfA5KDEfCywK6n1BA==
X-Google-Smtp-Source: AGHT+IGSjFrWgiB4YvkwiZfA2vF6T2SoSabJwFE3TzxsVCdgXC5wkmw1H3IgX8WXOPMVNQX1Ff1yTt/Nm11IdSXYP0E=
X-Received: by 2002:a17:90b:4d8f:b0:2ff:6666:529d with SMTP id
 98e67ed59e1d1-2ff7cf2a54cmr1991189a91.6.1741353460434; Fri, 07 Mar 2025
 05:17:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-unique-ref-v5-0-bffeb633277e@pm.me> <20250307-unique-ref-v5-2-bffeb633277e@pm.me>
In-Reply-To: <20250307-unique-ref-v5-2-bffeb633277e@pm.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 7 Mar 2025 14:17:13 +0100
X-Gm-Features: AQ5f1Jp2tr9kmC9qAX_MMzKruqw11R_ZY7BJbKGo66aXzsMK2fwley14_MdW2Tc
Message-ID: <CANiq72mkwvhKGGU242NBwAE58ObtLV7KGoTZSSkmqi0gBHDh8g@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] rust: make Owned::into_raw() and Owned::from_raw() public
To: Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 11:04=E2=80=AFAM Oliver Mangold <oliver.mangold@pm.m=
e> wrote:
>
> It might be necessary to be used from some drivers

Which ones? i.e. could we be a bit more explicit?

Thanks!

Cheers,
Miguel

