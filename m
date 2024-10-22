Return-Path: <linux-kernel+bounces-376771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30EB9AB5B7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A661C23119
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFDC1C9B86;
	Tue, 22 Oct 2024 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XWUDTHoD"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927ED1BDA84
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 18:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729620368; cv=none; b=N4EOdXsKrtm9I9mAQoOergglBRTB21vpyRJ+LyHrq+Syg7oFXcIh5WYjm7//Foy3MN4WUG4n3p1/0XG3BeMoX+2QpWBYUApY8ell2S3S2spRhftxNozsvjLr1CMJZZ67786T/0Dh+1JuuTVFzlXGmzuNmcPO1HBIKf/lE4uqiRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729620368; c=relaxed/simple;
	bh=YF9SAvtg72qz5VeDGp1dSDVf83WUSfxDx46MjbAP9vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ha395k3RarQTDhWROWVoBOPzHVIXoXWi6ouPJ13SAZnPrzsPgij1quRrEn1/VhtABzlHrFlH8h5WRBpF/5oyKHjnDRIBmCDLWjPIMxHh+rhZfVlce2M4XsaqST1Fm3Ab8M3AOaSbWfCxERGnskJ0a3e3+H5x6JcDO8ttDlEhmVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XWUDTHoD; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb5a9c7420so60648391fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 11:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729620365; x=1730225165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YF9SAvtg72qz5VeDGp1dSDVf83WUSfxDx46MjbAP9vg=;
        b=XWUDTHoDFdoyUKU5i418X40Moc+15WIlsctof0GW2un5JuCbQNh8HG4ULMaHajsOWK
         ca2m0tckqGnP6ZXK/5qtQCEZyUdl/HG4rGYjWVPO9id6hpSg9ew9oaB1WuvUAvTJU9kv
         nlhFv4TM/9HVf/mQTegW2LRmaWMNC47/Eoxpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729620365; x=1730225165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YF9SAvtg72qz5VeDGp1dSDVf83WUSfxDx46MjbAP9vg=;
        b=mSqOCTrRMGMtgUM0VZ7UuoJrozacT0wT7nzkPyYOXmtQvRlvvRUVQz6ZMMCReojydM
         lQjRdiniUQ6TqThpaj40RsZsYLkPq/mmbpjBlWXR5y/An36RMZNrYuMaXIGHV4PxiFGF
         GcInyaO3k3OCIqXSWMM7PVRUJq1e5BN0XvfxZVlcUN9X1GQ8qK8m9H2iuPVV7CpYr7ev
         51fzh7XgQW8tL55tDQkvRGrRhOl4AT7yXsKinqOKICBJjNaN5sXHW5Z6GMP3jF2WsLH2
         2KU2GrqpkjkQc9lbTjMvoSlQis4pmPeCz7+sPzf9OsxODbVnZ42663kBDLQ6mZlCANYP
         5FGA==
X-Forwarded-Encrypted: i=1; AJvYcCUsYFlOn3SLnu8/oTZZ9NtbtxUn7jr7ETGyypuqjM8nlODCWuVvpK/9k5CvM+fwPd2KdWO91volThEKYyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc69xmk93yhJIGLLdKRzPwjcj86lXitJ9bdQpYK/Sdu0/YPBtX
	aA8FsF0gjuxoStBsNC0QWj6ESaP95ZlRqbPX71A3/uRqo8EqplddxI/5/E3JadUpPjXA4CEQpRX
	r8qg2qIFCbjUA4BrqBo0uXy00rRTz8hLU0d/XF9w+JbzH3EU=
X-Google-Smtp-Source: AGHT+IGD767gQQeV0tE11uRaEsrIc2mwmO00WhEo/Zz1UezZblPCSEvXaOlL6Ubx/nHPqBiL9e86v5ATJdjlx5EznPw=
X-Received: by 2002:a05:651c:2211:b0:2fa:d534:3ee7 with SMTP id
 38308e7fff4ca-2fc9bc35e2fmr2513681fa.35.1729620364754; Tue, 22 Oct 2024
 11:06:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021191233.1334897-1-dualli@chromium.org> <20241021191233.1334897-2-dualli@chromium.org>
 <ZxcFxFfQM8gc5EEz@archie.me>
In-Reply-To: <ZxcFxFfQM8gc5EEz@archie.me>
From: Li Li <dualli@chromium.org>
Date: Tue, 22 Oct 2024 11:05:53 -0700
Message-ID: <CANBPYPgz4z-0gteo9YmQ+5g6tE3m3d3qc_siCvQqFo-ty5KvZQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] binder: report txn errors via generic netlink (genl)
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	donald.hunter@gmail.com, gregkh@linuxfoundation.org, arve@android.com, 
	tkjos@android.com, maco@android.com, joel@joelfernandes.org, 
	brauner@kernel.org, cmllamas@google.com, surenb@google.com, arnd@arndb.de, 
	masahiroy@kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, hridya@google.com, smoreland@google.com, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 6:54=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> On Mon, Oct 21, 2024 at 12:12:33PM -0700, Li Li wrote:

> > +NOTE: if the user applications that talks to the Binder Genl driver ex=
its,
> "Note that if ..." or .. note:: block? I lean towards the latter, though.
> > +the kernel driver will automatically reset the configuration to the de=
fault
> > +and stop sending more reports to prevent leaking memory.

Thank you for reviewing it! I'll incorporate your fix in the next revision.

