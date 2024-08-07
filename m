Return-Path: <linux-kernel+bounces-277907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 501DE94A7F7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D19442838DF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759491E673B;
	Wed,  7 Aug 2024 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cKhi8PO4"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3480F1E6725
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 12:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723034591; cv=none; b=LR5eMJ/Mzn15U4uay+8P0oQnmjMIsPhYRth6TfcaetVt2ImLwGOlmDOUoinU0gE6VRCJQJZD/RxxXDr6PHIP3GAhGpLMYXRqYcwKDqaJ2UJ/7RNkeyJl0gjQndCTpCkHQSo0pYJKrhBOhUJessHkZmp6GPqO3iKG/F/WcLzreJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723034591; c=relaxed/simple;
	bh=9TByiAsR7rqHzw0m3GnEqxlrlWwWHyVDWtIiOmBiOok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nzbplDXNsoswvB3bKCKSBXHjThgI/rv2NIIPAHwKIetJVQPg8XMm8bQA0rHBKEE2bankxR7B37N3IXdN76dKIgK0ykLFzrGlm/S4/sMFQQTC5PtEsABZ0nvpq5pGAU6NRBWAPQhS+Lh8+tQlIrvRFxLMO4cf/MCWePTkU06knSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cKhi8PO4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so11699775e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 05:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723034588; x=1723639388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TByiAsR7rqHzw0m3GnEqxlrlWwWHyVDWtIiOmBiOok=;
        b=cKhi8PO4+CwK3LtDQiigZiMio4BUyj87VW9SfObsTDqEBHFhPMuWb95tM3b8avxWNH
         qr87Y7PggYnFhV+K9CVzfMMnSYJvPF+K96zQbXVAWh/fl8r5jWsSKYR6fc6N7WfEYEFa
         if5Cb5qDSkgmJQJhHo57pwS59VoI0RrzNM5J19+ra3ObkO5kJUUXI1F1Bq5V9BlPYrEF
         LZ6fLlsRpn+CR2cF73nnNwEpJhSzXJ8mKjUvMxbJlADiA5vnV6QXaykIl8W30/64NIaI
         fgiB01/Po6Nx3OqTGJ5pOQ8x9oJp88lLrNe24p1WCc0IjoCGP+/RgfUwuTGqVh+2TEWY
         ebxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723034588; x=1723639388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9TByiAsR7rqHzw0m3GnEqxlrlWwWHyVDWtIiOmBiOok=;
        b=KQMyZWA6od+6N5YCn5PD/HbW8W8JGr5kZo9hysIYR5vy52XVqQ1u234hZ4pCH9o+8T
         KK68WNBaN6/sQPX+iV7NFk2AAX1LzBcr3tHiVYwa4iCTHbN2MwEibVfBCim8C8swrqgZ
         SGNV2lu2a+scwX0Z/LdUFWxu0KO1yM/lRVxXAk4J6Ri/MwpRMZQOU7E8HfAK7i8f36WK
         AC2DRgl6UypdfDwZ178+cNcC9/Poc+b9ibM6vj0ttX6KLBsyUPVn2PdzBwxW4T35IOJT
         JuC9Q2S8oATdv07NH3Y9mVPak+HLmFd1Q40//K+4/G5vb0f8o8enlqKEG1AWDAz4/m91
         eCMg==
X-Forwarded-Encrypted: i=1; AJvYcCXRSQZqLu+2T3FCA4T5wHarYNtNkwmfBW+V1Tn5VG+n8I9+xDAVdccTmNfg2IavgQMtOmr/TMGvMfDyU6Vg3MLVx0neQjcfFhQyq//0
X-Gm-Message-State: AOJu0Yx4lIfSPF+nP0fuOLjYHuYLMZ6MYNxOS3d/tBwmih3ggGEfiDhm
	pMLELDJ4czsbSoB6CcflW/0cfADL6tBdWA5oBVIbgPsDABVpMThP4CPN+dmtyralA5aiRL9owBD
	GteZ86+tN9+8ngFgusfGW8jU+MLH341+NY2Lb
X-Google-Smtp-Source: AGHT+IGjfaSyLjwrx4jEwLsF47E1kJuxSp9c65dbrjL2s5oRCzn+kjQm+YNz2CjC070fex44kCMZ2IktnmSjrL7vXZw=
X-Received: by 2002:a05:6000:1c6:b0:35f:cd7:5ba1 with SMTP id
 ffacd0b85a97d-36bbc1c2390mr12330956f8f.60.1723034588294; Wed, 07 Aug 2024
 05:43:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-20-dakr@kernel.org>
In-Reply-To: <20240805152004.5039-20-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 7 Aug 2024 14:42:55 +0200
Message-ID: <CAH5fLgiBhHVW83zh6wB6916dHdDt5cKsDS8eHS9sre+UkNUuqw@mail.gmail.com>
Subject: Re: [PATCH v4 19/28] rust: alloc: remove `VecExt` extension
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, akpm@linux-foundation.org, 
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com, 
	boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, 
	zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, 
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 5:22=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> Now that all existing `Vec` users were moved to the kernel `Vec` type,
> remove the `VecExt` extension.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

