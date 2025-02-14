Return-Path: <linux-kernel+bounces-515591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 816A4A36686
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E3061883D8A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F531C84D1;
	Fri, 14 Feb 2025 19:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b="mYrDNnCb"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E041C84B3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 19:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562861; cv=none; b=EBWBnCNlWD86Kx/5u8/gf1Pomdq1kBEXK8CZw0otoUGgAgMhhOabbday1NfLAmS/PvbthWXkJOj61TCa/nAj85dNvr8E0sZkXDRcltu1oFk8aIY1IpWJ/q6FY4LZQGtTiK3IZS4clG7FKMSGuXntBrM8WO558ABvCQRTA+EXKDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562861; c=relaxed/simple;
	bh=F9JPbRGgy2KRFJMR0L9LpCN/bMbxo32cp8WwnNHfDxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n04u3UlrVhbgrvVexHP8FRtGOkbiK0EXmTt9R/anqmLOdYEn/A24FaBwTW41kCc2m6fTVtZVv2lR/qGpFUS3NfVQKh+KwFRlrUl8JqRlV7lC1zWaPqVo5dk1vsHvI2lxAiKBY6BY1jQHsGCfvZKXI9gMxDN6j5RwqFhO8wMfm6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b=mYrDNnCb; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab7b80326cdso463682866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=google; t=1739562858; x=1740167658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIYB11+GgLlT+s3GNd9t99ckB9tkO/E+VJIoU1xvL3g=;
        b=mYrDNnCbC4//N0/F9aV/N2tpkii/u9FETfVPXuuMkyoHt8hHOfpEfLu0pfqjMs0YD+
         rEuyALEfkm0CrO6pwQ4Ncn05pImmFtu8omkF2D5/uazd3oki/0vKwQhe1fbQR32ayXHv
         f4Ib8OXj57NZgFvb8jp7197JxHlW/Wa0JUQYexnXvKAhf2VxENjwBsglvK4r78PoNlPM
         5aC3xy1wMF2NsEAub+4fYuwOgPbrgxzAgM5+7veWhTxLjujQ02RacvqflTE+aamv1kjN
         sqG9W6wV5C9FxpVfyjlMyZSN8qQGRJB2RuM8sPVyfxNlKZGqGMpUYQ+jcLFaU6xNy86L
         EvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739562858; x=1740167658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIYB11+GgLlT+s3GNd9t99ckB9tkO/E+VJIoU1xvL3g=;
        b=KsHpyVyyvS1aG2xeKaNb1VLRVN1/Q8M2u7AHWBcAld2TmX77H7Ik2NLHrkhtjupxlN
         Uf25EHdlxUCSnxdMhd1opg0xzcmyrnZZ6OJ/osCZRtnEY21Vzk0rjlZXV4Si8kr/5VNy
         WGMd9dPaNOOCm8mv0zL3aiF0/YxCFnu1e8KxV66SF4US++HabAp4bJDMh2xFWjWOQ2H+
         v3fymX2Y/Km+g6YVul74/fiJviRn/zzUk4phhP60VxsAJLNmPMgRk1byCHR69Sw8CjkN
         rWjDc/4SDa+OsRLP/sQB4tEQQUyvXThkbzWf3I8jMuXMxeVtQMzRqD+TGS4G4EicgRuv
         sneQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRRmn2tPQ35YfxPpDuwPQ1RheWwqxaQ3QljBTBvczJyAP7lCofQkUXc4FK0rb4vtvoVtHlPqz7MITREZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRK51yuCmWwLyrcG0dYg7FSWDlTZgx2TE6krHN5FTRb5jOcwEK
	WsU4tcPGHctFOwjDq4KEQndLSaSZ/FhhX7U70ofCJCmPUCnntHdVZzziwpuA2of7zcjjyo1Lstf
	rfE5ESq6dbYIaF4zjBMV92gwA21HsJBq0uHh8fg==
X-Gm-Gg: ASbGnctzPxaOzclc7fEAooazy3FsxQ8M7BX3g+4bQVqlEbq43g4Vp9cYjauSg4gjEKs
	da3PpVQZwHJFtmBjolTKbabbmJXm1NMU6JwuxJV83J76kodrKJoIyrbgIrmAV2aM1o/Pe6ns=
X-Google-Smtp-Source: AGHT+IGQyheLGif/JTgffbl1Tim8k/BNZyiHL4jFBQkQNGvERc0kVB0mvtU+IAjUoObD3Z+Y+98YsIXAOuyjFKM8m44=
X-Received: by 2002:a17:907:c1f:b0:ab7:d87:50f2 with SMTP id
 a640c23a62f3a-abb70d9f296mr32132166b.44.1739562858174; Fri, 14 Feb 2025
 11:54:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214133842.964440150@linuxfoundation.org>
In-Reply-To: <20250214133842.964440150@linuxfoundation.org>
From: Slade Watkins <srw@sladewatkins.net>
Date: Fri, 14 Feb 2025 14:54:07 -0500
X-Gm-Features: AWEUYZlX87hyFmnKvOA0Y1WpH0vZar3xq21qN9aghuiiKzi-M2gyZl0dPxatvaw
Message-ID: <CA+pv=HO4D0-d+ir1Vb9xjUcsYd1Lz8j9OAzev+CWWak6dD56+A@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/443] 6.13.3-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 8:58=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.3 release.
> There are 443 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 16 Feb 2025 13:37:13 +0000.
> Anything received after that time might be too late.

Hi Greg,
No regressions or any sort of issues to speak of. Builds fine on my
x86_64 test machine.

Tested-by: Slade Watkins <srw@sladewatkins.net>

All the best,
Slade

