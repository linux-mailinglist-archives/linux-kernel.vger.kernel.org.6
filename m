Return-Path: <linux-kernel+bounces-573110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E43A6D320
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 03:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD67E3ACB84
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 02:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED2313BC02;
	Mon, 24 Mar 2025 02:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blcBY8zg"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30472E3372;
	Mon, 24 Mar 2025 02:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742784110; cv=none; b=aClkcwKO1iTKTk+v4LvQI8YSqfOMvmrcoXdGy2kQ8sPetOYcE1vpxWjR2EvVko8cqo3jOzGR9LFKOS9ipDVCTKoY45IenQXT/bPvf97TcldR7UIJqgluAjyr++IdweUs56zrHMyfqsXcluvZ9gcK9FQf/PkvcCyZAND3nZbC9ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742784110; c=relaxed/simple;
	bh=EjJ7ZoqoCXF+IHKAsM06PA40JXDnAcXWZjnS+Bj2PWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YdAUoNlaGkPBmlce3hQq0oBCTpi8SA0e50jSMVpIjbmPToO2O4VBYuhgbf8eHr/3pr4ZrFLjvD7ZXuISlVIucXYC3jjvaQmseYzsBFrli20gEgGEal0d2OQ8fHgEH/u2uNymuzWocHVhFR75sR+WX462oup0G0QvqBai9rQWWUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blcBY8zg; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-523f58d7322so258950e0c.1;
        Sun, 23 Mar 2025 19:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742784108; x=1743388908; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EjJ7ZoqoCXF+IHKAsM06PA40JXDnAcXWZjnS+Bj2PWE=;
        b=blcBY8zgawa1gKqJEYYIT7w9YGirWjbO/5Rbe4R6BdhybpxlX/nVD5yGNC++6VZWaL
         f4Ks4U2c/gV7YHMuj6goTRSmi4W9utA8ulLXGV1cybnlFMJwMVQ2DmzPwXrfzEuRB7tu
         7z1GVPS0jWg/BVOCeJruHXl9SJtqfMBmd+5FeTmo09txDOjP2xl2UgB9dnNBhIV+wKIW
         xMd0RmNEnCwpmJMOZv7aqxor1V2s4K+HT3TX2AFAu6rlWMimvNDMPd5tPK8bnmDuOZlX
         FpUZvK+k1uKEcY0fFV2o0Gj+mLsgcoMRIYYLZ8iM21mo1Ulv0vGiDnhWUmrrudlOY9fi
         rBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742784108; x=1743388908;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EjJ7ZoqoCXF+IHKAsM06PA40JXDnAcXWZjnS+Bj2PWE=;
        b=A+za91cupTeQcUtsllWZuUxDRuUMclDgp2bbX4ng9TPT5lcS/BugNKbSjdkqNrWQXD
         o9lpUPpPpClYzWT26ZLtl07+6PXHQQKdwZZ+yuPIpRSpRl0389+o+lZLQwVp2eL+jIRX
         EWmX1ZrFGBRTEojnQ+MgVJ8txUqP3O/WCnsugSIsQCezjeYP9THtVTr1YtDJ+RCYPnuK
         KdUjR4Nusyd+gGu/K5mEBruq17EDaqfBa7CEPdPjOxD5Q6tvSrfZAGc4DdlnOuTyPzOh
         WAmfiUkWYVDs6XX0Idx6rOd058qoM9sMERCF+dWzOwUzz0Px4U1wUW12/wEEW1vPvZfN
         K28Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGtiEYNzzzD/BljO6pXLErPW/UiS9JtUtd83XhZEBZARiXD3fqJP04mAuDhGDHRWRelemhKRxKKjOk39s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBADUxNTXSbwSZh8LUVUK9MS73MbmXlzEjTBF/yvOaQCoGNwX6
	qQ1aEhBpsCbSg9ZUKT0osWQKw/s26k36GK/zbi8bRDcXPGdDqpm0fbQ3fmOwYarH+bTeeLWv90X
	MnsyhlBx8K+1Xcrg2me+4PssMozQ=
X-Gm-Gg: ASbGncsDvQ/6kDx/cxhI9nrh7tEmV9K16wvf2lHjCIk8+EMqoP8zNW1XPO5XA8hL23Z
	cjmBWcw85D9MxbvnX22ZmYL/hZ/Kc2qrDQrg+GBv/S7b1Mf1zcQDN/W15CjntvNHNB64Z1Uj7sC
	iMHu4KZv+KFo1aEd1iD0pB2Y3Rjuw=
X-Google-Smtp-Source: AGHT+IHkJKkixjf3Gjn5jOo3ET+3aMRPH4VnanA+jvLRph2Vur2KZqLHHbWw+UYo0q/3CkmsIR9Ic7oZ4aDDTa4lubY=
X-Received: by 2002:a05:6102:38c6:b0:4c1:7646:7145 with SMTP id
 ada2fe7eead31-4c50d607690mr2255273137.4.1742784107652; Sun, 23 Mar 2025
 19:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320014041.101470-1-christiansantoslima21@gmail.com> <D8L494ONWVO6.1V6NNJIPG7UU9@proton.me>
In-Reply-To: <D8L494ONWVO6.1V6NNJIPG7UU9@proton.me>
From: Christian <christiansantoslima21@gmail.com>
Date: Sun, 23 Mar 2025 23:41:36 -0300
X-Gm-Features: AQ5f1JrOo72x4bym199W0k5Xlke4XuRcWzWghyZXsn80C-dwsyMWujXRs4k74jc
Message-ID: <CABm2a9crNdCLnHLZ3pHQ--roaAKtM0FGL-tskyvR6rH97exqwg@mail.gmail.com>
Subject: Re: [PATCH v5] rust: transmute: Add methods for FromBytes trait
To: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, ~lkcamp/patches@lists.sr.ht, 
	richard120310@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi, Benno.

> Why is this commit message wrapped like this?

Probably my text editor.

> What changed in version 5? Or does "Changes in v4" mean "Changes done to
> v4"?

Changes done to v4. I misinterpreted it? If that's the case, I'll
change in the next patch.

> AFAIU this relies on the endianess of the architecture, I would check
> the endianess in the test and then change the assertion based on that.

I see, good catch!

Thanks,
Christian

