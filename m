Return-Path: <linux-kernel+bounces-241271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0380C927941
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05CA5284668
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3A01B11EF;
	Thu,  4 Jul 2024 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J12EmzOu"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C1D1AED4D;
	Thu,  4 Jul 2024 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720104581; cv=none; b=klbAiE2QvsGrd4Zk0hQFGvLKfKnaQYAI0LSSNtqWmtsoEp75pkrV21LhoMdeNA6E8Nx41+BPvz/aPtgSkv5fT8ukw8B7mxX775W02HkvNms4+MXBMlIHHxI8NC2h88IhBKJjdHvCz/9JPP9T/utyziG6TlvnbhtqwB18AnO7iEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720104581; c=relaxed/simple;
	bh=HCvzRU2gmTS43NcPlyVLIG4vzhdNbCCX02+kykA663Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lzcn1UlY7c8HqXxDk+sofsf7T6EdY0vY76CVtv5BpZ5EXCEadrUyynnfulIXjX/OAN4gRu02VNMaIrz/3PVTplMrAdlmZXqyqr4892unt3wtbvf1xB3pr9IN1J3ovh2zqlPQU5MfojaRnAga265M3qadEEt3Xcjt4/a/5l6nuBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J12EmzOu; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7ebde93bf79so31802839f.1;
        Thu, 04 Jul 2024 07:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720104579; x=1720709379; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5/x9BIXdamN8j2ST+bFmCo6TlWHOZ2pjyOOGU4DZFc=;
        b=J12EmzOuqpfcpn91GDWGhpv9YX5EKG3GhtD+l0+ZEnHuxP/hU9bv7mjTvkDoBLc98c
         P/tof5vg70AGxDQIsBGTAjED99KwXZmITAR7qs2xKNcrf/TN2MMuWBE5UCDvLzA2UoBT
         CievPAlhUkD8aGerCNNmo0hbkZpoiEUcR4sX/lUuhnEpCN2Gg702TESIt8yL91Co/HHx
         1rra01Q9CK0K/0LOr4qrcVg+QxynBEIXOKYukpndsxt+N2CAMcTM4p/+BV149/fMitYC
         Bl3Qp/+5qsQWcFp6zv/bHz5RTnNNokXVdmZMo3JzydQn0JiR0WT9Y+EbcbOGy8x3Wpm+
         2DFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720104579; x=1720709379;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m5/x9BIXdamN8j2ST+bFmCo6TlWHOZ2pjyOOGU4DZFc=;
        b=WHm/s2z2BT2CVA+YgFta0+EbodHPJzEM7Pg1Rji9bpItDTQWeiJSLtlr3AHOy2j6xE
         gjjlXSBxrN/OoYjCf+KAhig8cG3jnm2UIdcFJB2V6BUyp+tJmeWsl3fEV5tQte0CYLca
         dDw7bc4vsvNwykFcaKiKj/c3hbB1JbeQ0Z/RWa0fKo832+YrJfL4eI4cZQmtjf2rhuCn
         /T9PbFhxDgCW5D9YEtCgSdjCwSC5X6vfEAe5fwMjzqQNOVXbvJ9a4mrsWi/A5qOORpn1
         3c+vBlBc4H8J9dv02Y/VPRBX45AUSgMEB+T+69MqHIc2onXl10KX6Ow4yBrBVbx0uFW1
         7Drg==
X-Forwarded-Encrypted: i=1; AJvYcCUyzgq7+WA4vy6tiSFrtaCP2uz6ubkcNHL8zXpP+IOMAJcC1XXHmRz6jGdAexx1FvN1HdaDX2k2TVeAY4JUAQmMa5EhafRfYcQRxE/7bccKR40822ziwDsVOB5EpBt1inQaBD2AuDuFr2X4lHE=
X-Gm-Message-State: AOJu0YyMbbDUfX5hY+6eywpolrDVSR/sbMb82Gb6dEeFW8VtDt8OJ/+r
	B3oJzpd53dFz3QgbrRr1uL+Fn977gFOkVqBtFWZFOuBOBWCDfxBz
X-Google-Smtp-Source: AGHT+IE2UB4OSVUHRO+wwA9S84I5E6eB5EQe/fFnclT/F6F9xsbwkVTzoGFxppYoateZ+4lcF/gbvQ==
X-Received: by 2002:a5d:87c1:0:b0:7f6:4eec:cade with SMTP id ca18e2360f4ac-7f66deafb2cmr214652439f.8.1720104578815;
        Thu, 04 Jul 2024 07:49:38 -0700 (PDT)
Received: from localhost (h135-131-130-199.ashwwi.broadband.dynamic.tds.net. [135.131.130.199])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb742bc2d8sm3989898173.144.2024.07.04.07.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 07:49:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 09:49:37 -0500
Message-Id: <D2GU6M1F3QN4.31TYYGTCNHJ9F@gmail.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Wedson Almeida Filho" <wedsonaf@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <benno.lossin@proton.me>, "Andreas Hindborg" <a.hindborg@samsung.com>,
 "Martin Rodriguez Reboredo" <yakoyoku@gmail.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Aswin Unnikrishnan" <aswinunni01@gmail.com>, "open
 list:RUST" <rust-for-linux@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] rust: macros: Enable the rest of the tests
From: "Ethan D. Twardy" <ethan.twardy@gmail.com>
To: "Alice Ryhl" <aliceryhl@google.com>
X-Mailer: aerc 9999
References: <20240701112448.28638-1-ethan.twardy@gmail.com>
 <20240701112448.28638-5-ethan.twardy@gmail.com>
 <CAH5fLgi5HdoPzJHZUrS7r3wdQ6GheJDbzGRGKZpk9oC=U6SdHA@mail.gmail.com>
In-Reply-To: <CAH5fLgi5HdoPzJHZUrS7r3wdQ6GheJDbzGRGKZpk9oC=U6SdHA@mail.gmail.com>

On Thu Jul 4, 2024 at 4:43 AM CDT, Alice Ryhl wrote:
> On Mon, Jul 1, 2024 at 1:28=E2=80=AFPM Ethan D. Twardy <ethan.twardy@gmai=
l.com> wrote:
> >
> > Now that the rusttest target for the macros crate is compiled with the
> > kernel crate as a dependency, the rest of the rustdoc tests can be
> > enabled.
> >
> > Signed-off-by: Ethan D. Twardy <ethan.twardy@gmail.com>
>
> I would drop the newline before `fn main()` here:
>
> > @@ -221,6 +248,8 @@ pub fn concat_idents(ts: TokenStream) -> TokenStrea=
m {
> >  ///         unsafe { bindings::destroy_info(self.raw_info) };
> >  ///     }
> >  /// }
> > +///
> > +/// # fn main() {}
> >  /// ```

So close! v3 incoming :). Thank you for your review!

