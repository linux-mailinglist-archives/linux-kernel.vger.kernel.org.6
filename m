Return-Path: <linux-kernel+bounces-352154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6292B991ABE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 22:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D311F227BB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A368515AAD7;
	Sat,  5 Oct 2024 20:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQKHv9AC"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FD5BE6C;
	Sat,  5 Oct 2024 20:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728161752; cv=none; b=nqBPI3A5reF78Tks15QSqlLvqB/jIaBX0oPVtfdUxrpXDW4bf2U1Kw5Y+Mc3aZS/sEKqkU99AacIK+CkQqnEYvsQYSRb4zetlkKolf8hCk6gsGRMSx6L+spCj+eVs0OZmaVaHevspp9MVWhArd89XcTCem+qk8AWssa+4jl7nb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728161752; c=relaxed/simple;
	bh=6utrY484jT1HhShNDfxzcXFHvPJWtb4/PzSV8XDLo58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e9ZNHwD+xaUjLGWvGfQGUnQhDR7q6B9akBuE5NMWXfyv4fGFPGCvto8WVey224FTIe3Kvw2dK5QH+vLUCOExtsbHYm0ptc6+l/RFh24ogiCt9bpPACzTguJSGzlg0KmH8/6wnRbuwEn1oi/SQNqiGqX/K7CgMOAOb3TCOJ2JEQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQKHv9AC; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4581e7f31eeso28131761cf.0;
        Sat, 05 Oct 2024 13:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728161749; x=1728766549; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6utrY484jT1HhShNDfxzcXFHvPJWtb4/PzSV8XDLo58=;
        b=NQKHv9ACuc5X6JHhhrKPEktgRgz6oob3jLG91qFHxqpiGFo0xjh8IK/ZxYGRwik+f6
         OnHHACRSEVPeo9ZL//U08pGYZIjJRTcMydDvkr5/APc6XGomEFz/fY9UG+BeFmEoZ/tE
         lxpdoLhR2jFg4rmZJ26/O7XDg78ltNIWUUO/0jnuLXxY/BJCuPKNf/ApYoqpp1JBYUeg
         HvkwwSaSBAEeH2/dvmRcVkWllHjHAFHPwQ1IA36r4BOyL6nPAwL5ykTf1Sv7fhbcspTZ
         V3cWMO116UvO2cxGj6GHUWDd+9/yGGM7HDqe2W+w1bo3apcpxnmCUdKMIZ7IMDLe4XEp
         +exg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728161749; x=1728766549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6utrY484jT1HhShNDfxzcXFHvPJWtb4/PzSV8XDLo58=;
        b=ungnevvdk7nPUbvC+06t+HBJ80Ul1l4eynASAFxzArxDaKUN1dYt9ErI45SDgnpVxi
         9pFahIHwtdmzBjVrZ7K32NmYfPlPySZFNgO2NxRlc6Bl609MHadp/3QZk6ZBObV8FOML
         f4xBcnB91ZmK+wEFuhZsRxArERSUAlnGISjcH2/99aAdZQpyZjGPwv4oOPWw80SBDrCh
         wkOmuWEZ2Vyjyqa0buVqpPQQ60H0phT7oCL5Vu8VGGl/u4FY/IY2d2YRIevrmIEi/TsJ
         rJA0lfSEMTuF7/cOPS4eQoi6DfY2xzw/FiNw/5CtP8/2Sc4uHKEoxuZuL3rzCWtvVGDR
         SXOA==
X-Forwarded-Encrypted: i=1; AJvYcCVim43vJXtvgJy7XDfMQzOD3GrAeMC0a0xVBy7/ZeI/R/u25sxaQpgxbb9NXvvN/ks+5nximpcIp+kzsdU=@vger.kernel.org, AJvYcCVqzxqDtttwE4wa/EOsg/prbnk7Dp89gO5vOZjbWbIkYybDWIiZu4mU+RozviksJKBw+hN51ZsgwzJQCpdNUrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Zc7HaziiB+cUXbiGjdUPupzbtsVm7aQXkhj8HI2CftcFsMwE
	hNakQx0SVWIXn5eKIEaQMV8KjAe7huSKktNjGXHh3+pxJz0BkOrhiZKI8BRQIv4i1BMjYTeiKr7
	84eEdo5ISzbik7VyKoaGDtIhR2Y8=
X-Google-Smtp-Source: AGHT+IFppASNq9uAL37Hg45IO1IoBp2bGpQ9b+s8exinmJh/RwintKAcBXYaOinlWnO/zOtLc9CLiuuxf6J3gXy5XmY=
X-Received: by 2002:ac8:5991:0:b0:458:4d83:6e87 with SMTP id
 d75a77b69052e-45d9ba82bfcmr101258791cf.26.1728161749449; Sat, 05 Oct 2024
 13:55:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003221536.34826-1-iapain@gmail.com> <CANiq72k0c+QxWkxfZ5f2VvzYmaX4z9hQoYvbPtKfF3pwLq-E8Q@mail.gmail.com>
 <CACD3TDPbBnZuvr0jJVtrgs_4AXXk1+HGZEH_uPp2iQVf+4Ff6A@mail.gmail.com> <CANiq72m-0or7w5Qdw5Ek9vf-w_ng5QOmeSW4u9HSMqj1iei-CA@mail.gmail.com>
In-Reply-To: <CANiq72m-0or7w5Qdw5Ek9vf-w_ng5QOmeSW4u9HSMqj1iei-CA@mail.gmail.com>
From: Deepak <iapain@gmail.com>
Date: Sat, 5 Oct 2024 22:55:38 +0200
Message-ID: <CACD3TDM7FS9_FXhajOBr7=dt0J9D=2Ejd9DEa_6TH=yYevAHCQ@mail.gmail.com>
Subject: Re: [PATCH] rust: update dbg macro outputs in docs
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Nell Shamrell-Harrington <nells@linux.microsoft.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> No need to apologize -- it is all good. v2 looks fine :)

Thanks! Very kind of you :)

Cheers,
Deepak

