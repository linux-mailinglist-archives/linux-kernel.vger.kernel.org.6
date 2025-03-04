Return-Path: <linux-kernel+bounces-543520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C9AA4D6B4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE3A116C450
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D69E1FBEB9;
	Tue,  4 Mar 2025 08:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lcMJYJWc"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B37E1DFD8B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077608; cv=none; b=bUWUFssmG/Qo8CiJQqwDclBBJ4LU8hTEbhdwYMVh8qLzCdvwkGFzz1S1EmFZ17v3DGpG8kYWplb0RuFxRTM4y9N22b94arTrNLp3d+1LagkM1uba9Dt1Nz+B2Gn8m2IEPzZV3QRH/zl8psbzaQC4gFp4GIvDkU7nGf4VWvmv2E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077608; c=relaxed/simple;
	bh=YK/v+HTjGEFPbEINjripCBl0YEaMvBdXG3vSD9bGu5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NfGkaSdmOoUVSEtzAind9mLjf5Zs+GDCcyfWyK8T08yfcMlcBdlN6sOZRgw+/H2mWDBOsL7fs7d6eCNKznDgyH30bjDnZLPFIazvV21C32CEXA0U3a3PlTn1j8Kyy9tdsRoWFmkv+fYHpGaAyHQYJSUnL43Tfacfiu+2pSrph80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lcMJYJWc; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6f4bc408e49so47904407b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 00:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741077605; x=1741682405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YK/v+HTjGEFPbEINjripCBl0YEaMvBdXG3vSD9bGu5w=;
        b=lcMJYJWcyFv/O1o3KqIUHZv9hFomU32mdKnoZULCveMCmgTXFYma84DF+muqVNQ8cb
         Ye8eGspmkhIBsgvhUtb3rpGFykGmTo3RQEeOTatfe9uumuD/gupiV4IVHZ1HlbqQY/NU
         +DOzgujaNkqonuHs2g8DxQnusiMHqFSu0NkTAukXEkrrgpibNQtoCW6Ehqnw1lPLILcE
         TrTSGDQ4vNZr3Jx/QBr/fBMFBVTH//OcnUAVj1md4uN92UFT1UFe4weaMSPVDZBXZJ8X
         KRySWc8JREgxXvUqx1eRtGf1TCl2Ud/xLIj4zi8XImHlK61TgywozZC0mKkmwpHCjDAJ
         0qLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741077605; x=1741682405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YK/v+HTjGEFPbEINjripCBl0YEaMvBdXG3vSD9bGu5w=;
        b=GL9sEWD5aNt4nEDFmu9VO3CDo/0LiOcC6+Hrb+KHzVcWylnBrnRmAnhNq5Y0u9CGwX
         X652QTGTcPXTD5z4o3U50T7xvBrxoHTXgRaF8tE7D9SL8l8bS5LVYglwvE6ec/wTYZxW
         eNRyE77gZI9Drqzd+hi4g3dIZHHk/2lV5vJj1iuOt7bCTJQOCzRZwFqJhCkMRE2IunD0
         3q9sNCJOlImJx4D+1Flonl4a73eY+SSp13PyTR65uS2bjzj4YBR1k+5pmHn8ucvQCwq/
         EbMFhfFRGME6Ba7tjQKGLGoGRWiL8jQlwrnc2ywxkFYi1edW/V19B8eoFTTbFwdlyE53
         2Krg==
X-Forwarded-Encrypted: i=1; AJvYcCVS6+4LhVhqkY4rXL3AHNj3h8Iybo/Ig1Gjgz19Wj4kN8Xp8FpwXg5R2ijGSNcmtZoeLu4DYFBhlbNsU7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQG+tf3GEja4hpJKIhxiyw0jSi6Aa1TgIex9LyoAjK9t4E2U0R
	lGBsa8uwAgBvjfdecY5MgmeoNkRzL/3mlEptbBr8n4lwltR6eYnkYyyfIWtPA2m3p2ZSIPAsdQa
	hjv1dZq4DZhxfsLSscjMnxymaIg9aFrWf/pCQOA==
X-Gm-Gg: ASbGncvqiVxC64OoivrcF85fZNNsv1CRJhae3p0LLiwzU9liCLqL2vwV2xxdB6dOAqM
	DnO3EjO6jV69pImilD8z3nKjUGOTpm5BS3T49a6bgZlrzxG7WYOhyRosoVyqr/gXzQM/QeXHnVr
	6dNkFfpeM5TI9HErZiY6AbvMGhIQ==
X-Google-Smtp-Source: AGHT+IHzjcSCOgliNPgzEIfJP4zRqA+GXbH1gcPHEqHVdjToORnVLP+q+n+ER/rA0dxnmWxFxju94KxpZdoxEUjQw0w=
X-Received: by 2002:a05:690c:3387:b0:6fd:4521:f9d7 with SMTP id
 00721157ae682-6fd4a1b5ad8mr221954587b3.24.1741077605393; Tue, 04 Mar 2025
 00:40:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303092826.318638-1-colin.i.king@gmail.com>
In-Reply-To: <20250303092826.318638-1-colin.i.king@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 4 Mar 2025 09:39:51 +0100
X-Gm-Features: AQ5f1Jq2rfvBPsQCyevIyKgnAdZxW9QavsIRuyb9v_d9Hj7plbiOg3wN5ZMKg3c
Message-ID: <CACRpkdZwjOWTJioAY92LwmEGmqZJHu3d6foKNbtVmNDN1h_cFw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: pinconf-generic: Fix spelling mistake "paramers"
 -> "parameters"
To: Colin Ian King <colin.i.king@gmail.com>
Cc: linux-gpio@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 10:29=E2=80=AFAM Colin Ian King <colin.i.king@gmail.=
com> wrote:

> There is a spelling mistake in a dev_err message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Patch applied!

Yours,
Linus Walleij

