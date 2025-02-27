Return-Path: <linux-kernel+bounces-535766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C70CA476E1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96C1188A8FA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B504922370F;
	Thu, 27 Feb 2025 07:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SXOLHzql"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A13213E71
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740642781; cv=none; b=oxgOtmgTpuusu1YSIjIdKpV3A4lml9OH7XwzUhGRZs8TmTM/JwKL7EZIH0qqjGbk2nmpt6na2MWAbkYDNkm7DamFr7zCB062/68gwvbbUXELs38nyIxKjACAp2xTz8Tg6ZRcNveuNln/ZwfYoh5+4oqDQYiztL5OJlp1bGeq5z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740642781; c=relaxed/simple;
	bh=WAve0K61aiBm2H/kJcL9Z33ely0mkl7umME78jtqWNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecvsZTwylBtUMP9GGR3bZK3sHicrHf0VyfmjeQUJWNqYti6XtJdy5gChgsq1nLeepgjscYxue/yDsDk0ozFWv67w2kD7BVS1dv/WjExsI0yBF7hxpnwIeRo90gvCI/GvwaowvpE9KWDexgp6e0wn3knyIshYQNtDUdJQY0D1M3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SXOLHzql; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38f2f391864so272240f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 23:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740642778; x=1741247578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAve0K61aiBm2H/kJcL9Z33ely0mkl7umME78jtqWNk=;
        b=SXOLHzqlXhxb4jvoRIJJaRW67+Z98sGduAmYGrPWU3Nv3sqgsuWk5SGGYZOIJNweKv
         jZyVHAFgoG7SwGXnIhbPxSLO8GoxDQzEEEUp4EJJCnyj/xFWCRAA8DnqbvoKrFk1pEjY
         i+M5RNocw+yifwWy7D0XS6xCsYcA/p0TN5Jt0k0rhB1vGZyjwFHeyt7waolqBXl7wROH
         upGc4/G4Wyp/ObOZy54Hjwy5BSCKBUIbowxvSSQkUnxMnLOHEFp+604fLOCZouQxcnLf
         6nDfRxTb0sUkhHTbgpIBYFGd+tfACLBqmaZW8sM9rUe03FevcsAYOcAtVJeaOAmqUfcm
         u7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740642778; x=1741247578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAve0K61aiBm2H/kJcL9Z33ely0mkl7umME78jtqWNk=;
        b=TCPipa90qdRyu4XBV9kDXFrnoHiKd02/+ge3hHBN/WS4gEKq/QBOSlrDxp9w0nkqIo
         sFiZ8J1uHwMRpDJ+9D9SZCCoSMl6eegmfFYDHUaKnu1QfB9+7DMJQCt8bmhdTV42e/Eb
         YxjS3p42Gp3gz09xKDNUsyXUXdVtT4s89dhoY2L/YtztRjEE6OBPbScuqr8t4BWUwMl4
         Y0BIZ2viioNxR9BCX8ujr3S7JXiC+xWrjXgXsF6DCmxHGOLc40W5ibYrrCiE3aQ1jaIw
         BHGutXn7HjJC3HlIHhY5PJjGZLeaJ3ARoJGsdzGf5nGGKGBPheNlHQXjZbzKE2Y2hBNP
         /5rg==
X-Forwarded-Encrypted: i=1; AJvYcCXl5CD5gud3NqIK8gafBMxuWTgBqnqVqTO4XQGXZDmRsT/nTPh/i171GjoB9WXM9Dc8nJrJ66rOOP1U380=@vger.kernel.org
X-Gm-Message-State: AOJu0YylADK8wod5WWQdb7MeQ6Px9j88ZQ6LCGLxwFcCTSU/bAciwWlN
	+oipGZdQVCcGPWZdGpK/ppDINlHy2NGmja7o4f9Xpk262RphvOhns3VKyY18sweHPjXf0i/DjKw
	KHCzCihziNoIJD0KQXOhacY/iGvnzhJd+Cid4
X-Gm-Gg: ASbGncvkuTLD/Qd0ft67hV2SuF9F9R1ckYKOOiDwuO7OVlttdgQIllItfBMfUz0Bxak
	MQhk80q8wpbDEcsRTyiT4jy/X0CBbbErhrtnqvNJtXg3E5IgMm7HXXl+jcFI8/W88dGyW5gWKaq
	Qr7Gq3knfx
X-Google-Smtp-Source: AGHT+IHq/W1ckseU42DFdamVj9VolCNCEVXVrOQeYw+6Bv1YqodQtI+E8O2KwTAXHPbfpoMMUid6060aOourekauJZE=
X-Received: by 2002:a5d:6d87:0:b0:38f:4251:5971 with SMTP id
 ffacd0b85a97d-390d4f367a0mr4807927f8f.6.1740642777735; Wed, 26 Feb 2025
 23:52:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227030952.2319050-1-alistair@alistair23.me> <20250227030952.2319050-20-alistair@alistair23.me>
In-Reply-To: <20250227030952.2319050-20-alistair@alistair23.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 27 Feb 2025 08:52:45 +0100
X-Gm-Features: AQ5f1Jqr2f3px356CRZa1JK9YL4d2jGf-uxwiU32ka-YgAtLTMIEvy1EGdGheLc
Message-ID: <CAH5fLgjFvm-+jVpBsgU-sgOOzHic9DvcUMMg_z0G+37z5DWbPg@mail.gmail.com>
Subject: Re: [RFC v2 19/20] rust: allow extracting the buffer from a CString
To: Alistair Francis <alistair@alistair23.me>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, lukas@wunner.de, 
	linux-pci@vger.kernel.org, bhelgaas@google.com, Jonathan.Cameron@huawei.com, 
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org, 
	boqun.feng@gmail.com, bjorn3_gh@protonmail.com, wilfred.mallawa@wdc.com, 
	ojeda@kernel.org, alistair23@gmail.com, a.hindborg@kernel.org, 
	tmgross@umich.edu, gary@garyguo.net, alex.gaynor@gmail.com, 
	benno.lossin@proton.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 4:12=E2=80=AFAM Alistair Francis <alistair@alistair=
23.me> wrote:
>
> The kernel CString is a wrapper aroud a KVec. This patch allows
> retrieving the underlying buffer and consuming the CString. This allows
> users to create a CString from a string and then retrieve the underlying
> buffer.
>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

I believe the idiomatic naming for a method like this is `into_vec`.

Alice

