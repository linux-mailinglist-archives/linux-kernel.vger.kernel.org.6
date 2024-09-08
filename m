Return-Path: <linux-kernel+bounces-320074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A2E9705DF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 10:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81FC71C20EA7
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 08:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76A813A243;
	Sun,  8 Sep 2024 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4iT++RS"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FB0481DB;
	Sun,  8 Sep 2024 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725785425; cv=none; b=WtVfvQHGtqAv/Hp25eDGLTngon36ObR0XI9x74GKbUF+vzhVcpI4er2ly2bp9P4pSVMVA4Y8qxS/ikndGqozs6X1glOMyat0XGSiq1ZNzW5UVcKgRm/Z3tvb9vT6tDvnNUvFzECXOa8fQKhxNX7zB3EZS7DnIX5IHuU27/3FZA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725785425; c=relaxed/simple;
	bh=IratKjSErCgP4bqKJwZyOcaZOPuZPbvpYf28ITxn7vc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=SLJ/nylz5k5Ncgzccq0oD0tuAxF1gDNUj203FHQIQThbiLwp14P7MCiC2FmRyva//4c38g4KFInYa7EkQnOcpDrLzd4p00+t46ZcH1/FRoz4505cRcEfUNri/HXlg5Kh8aDP1s4LcYPx0yUPWcySeIfGy11RcjbP3J+XfAUDoFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4iT++RS; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42ca573fd5aso17453195e9.3;
        Sun, 08 Sep 2024 01:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725785422; x=1726390222; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IratKjSErCgP4bqKJwZyOcaZOPuZPbvpYf28ITxn7vc=;
        b=J4iT++RSqIduSI2c14zQVB4EGPoNgztPE3NyG/p90QmP0mM9ApnbnQDVIMZbRaI5nw
         7d25gDdEgGN+m09+95G7ubqrhgKNpj/R27GBknDt/lFXgPJHcGOPxWTVoX/snztaOEK3
         4hGVbtdWsgXzWZ4mDpZ3HgxANzArTUpllu2U37JlaO2Z+j25SUW67IvyclKYJlQm1SjI
         dNFfKYfLg1ilnIktS1nFXi1M98ng5kisF5OyRU45eIYPcoipsPYWtP0Dod0reycAaSgS
         2l99b+lIDfhBgchiROca+VlgMqym1XnJNJXTawj4uypCsF2S6haA1MN+fbKgn38psV3p
         n7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725785422; x=1726390222;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IratKjSErCgP4bqKJwZyOcaZOPuZPbvpYf28ITxn7vc=;
        b=BRD7Zw41mVvEMSnQ/OkH6VEL0wuZK0pbrZxS6dllvDpBBHjKgfyqgCVAf4WH5v/24X
         HuFtrvEguTci+xEddL+ziyvHUJqNMk1DBwShwghfkEPvfKBUNbnAWoBN02m6UA7cjUQO
         YicyA6cj8JOqiKEaAPq0FRlDDKc+XwRggZVzy8Gk5fj4nJzB+yW1AOKWbA+AUTI7S5KV
         8rSe0+q7dc51pQrU7k9bg2tNcr7hF2o1mwxUjTDbYoX+P5DwBIGDU26arfxbnYHBBcEA
         MVWTqYsnJyZMcELKCRS2Oj/y5KHdbx/nnDa1d/JisodOVbJCtLT+RwW9z3FffJS1qOjG
         4/FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ6GD4Z8ieeyOmrNIWEr3pf09YGpz7be5MeVgNCAotiRjjR5hrMJDPRtOeUb4Ly1gUk6ZrF8NpragX05IXllg=@vger.kernel.org, AJvYcCVhIn2eoF/3/xBAtUKmsDz3AqeEbKVSTkbFcbKtKXkl54q94aMnjXbi+NfeogDDYEBuDoRIHiiE6SEp6PU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU8XmUcmaElYs64Sv121IK2Tq45TMGEJV5mfeWlnJMca/ZGjDg
	a+upwNq3NaIWXTH53uZ8OTHe1c1qcrPdUcL85Yr4XSpVdyFo5YR3
X-Google-Smtp-Source: AGHT+IFoZ1XBFN1TqW6neFNuQh1nG58pN2f5+yQJ4beQhi8+I8oR/Q1Ywr2WGGB/Rkv/6yFCkfse/Q==
X-Received: by 2002:a05:6000:a91:b0:368:37e3:dff7 with SMTP id ffacd0b85a97d-3788960fe95mr5265498f8f.34.1725785421928;
        Sun, 08 Sep 2024 01:50:21 -0700 (PDT)
Received: from localhost ([194.127.167.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb21b1bsm38396455e9.2.2024.09.08.01.50.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Sep 2024 01:50:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 08 Sep 2024 10:50:19 +0200
Message-Id: <D40RVGTQMNLV.1GL02UF7AWB5P@gmail.com>
From: "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Wedson Almeida Filho" <wedsonaf@gmail.com>
Cc: "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <benno.lossin@proton.me>, "Andreas Hindborg" <a.hindborg@samsung.com>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <patches@lists.linux.dev>
Subject: Re: [PATCH 19/19] rust: std_vendor: simplify `{ .. macro! .. }`
 with inner attributes
X-Mailer: aerc 0.15.2-211-g37d5fc691aff
References: <20240904204347.168520-1-ojeda@kernel.org>
 <20240904204347.168520-20-ojeda@kernel.org>
In-Reply-To: <20240904204347.168520-20-ojeda@kernel.org>

On Wed Sep 4, 2024 at 10:43 PM CEST, Miguel Ojeda wrote:
> It is cleaner to have a single inner attribute rather than needing
> several hidden lines to wrap the macro invocations.
>
> Thus simplify them.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---

Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>

