Return-Path: <linux-kernel+bounces-317665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA0A96E1C8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D0B01C23AF8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2062E17C9B9;
	Thu,  5 Sep 2024 18:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="C8Bh7oqr"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045E415F3FB
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725560390; cv=none; b=Yh30bgu9vzJh28wgLOjE0KW+gN9jPgbn+BptyR9kinOjUuM4Yr8sWq5g+uj2kJm4OALZ8gAqZoexWsIAZbqLrKHFjUH9R18i3dFyoKUIbETzLdbvx3oImh/7EqZUoAfFyYcKgL02QbVrtcT/nxponhzacD0VzFu/Q8A5vshPjOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725560390; c=relaxed/simple;
	bh=DEcRTH4Ksx3HqcRZk39EA6SSP0yZhl3amYb4gGAKjSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iEBDjF609zWu82XQ9rtqPhSOQPUGH2ypB8ysiVZSRhriVQ+Q0WjLpZskx1ECQKiQFhmA3dtzppCTtPvtssjU0DvJiBeLIHP8MVMaI6vUEHoYs9hG6lT/xlFBxOf5JRNRn4YAVWWPGWT9WOJzrQ8XKirrDVg3OwiK8ydiG1xJpwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=C8Bh7oqr; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53346132348so1349515e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 11:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725560387; x=1726165187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtLGB7A2P30eTe38aKz83I8MagUAeBQdY4kLOW9iG00=;
        b=C8Bh7oqrWIgMZ2zoZq5olIW051cgItRHSx32mybhIXDB737qIPuJ3gyn/E2dVGN/TO
         AZNGhMxITOUkQLLlmPNm7FW/x9MrbNeY8vYOuAzXYQCCRyVScgfcAdlbl868erkDgmuD
         CCvfdsPh8KeJtwHqn25cP2NSqyjKyptCWZ2RRsN7QWDKyOLV74sr5cxw0sfc+WuSvRun
         fH0L8WRw8wLPOJNiN96vKq3PcgFEU1CkMIZSVScFiTnJlBzK0o9qqO/IIfCG6KBVUYgj
         Qp62S6meXhu/LQgcOFAJz5wWvWbbGN+/7KeSCKPoHCYOxATR4BsxiJcDAAMnivqZv0nm
         mmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725560387; x=1726165187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtLGB7A2P30eTe38aKz83I8MagUAeBQdY4kLOW9iG00=;
        b=qUBXTkn8AZQPRWimu+mvx2sTY3qPRMoXb5j/q77qxXXlD7/rkddl4/azxfr25zribi
         70nimEOrf1D21ee+S1v7M09l2weJ3BHzW1zpCXDuoWDyHl8d31CjjrBTQh2G59b50zff
         3ZwMf636bGmbyJLsgTt3Bp6NZZ+uSq+TPKvzX/FNCfRP7p3lon1MvVlJgQ8OUMHxikTc
         PYIN38sAgwZLYJ62Cfxr1bMmv1UKtFjUisB61gwd1d2OCKcR7zdKQffQiX0ZOhxNvVgG
         3VLK5bWOfNXyHhOdmRCYCElHvPoblnf43npujivhtlaNGXy/iXqzMnexfFOqsfrjsvn3
         Eetw==
X-Forwarded-Encrypted: i=1; AJvYcCXb7X//FhflUdaFJewk6E0uuXEftV6r9nfkqLNSOKry0ch/cgILzR54yW9AayTGsOjhuz+hV2OzBCerTvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWFaaIF8KFKJI1Ca84kQWCgIi7xSgtsZfHSrwyzUPh325nIIUN
	fAbs0GvZrQUlwKrz28FkPaeAR9ikA14QGUfJvr/++P4CEh1St0DsuTj+mOg4IlT+bChBtZkAtLR
	subqNXx8BNQnFFdaV+mnG4nsRwJHTETqvr69BVw==
X-Google-Smtp-Source: AGHT+IGO7FS+EJM8t1Z0R7LnnK3tpz34UapBrYrk0FGwJ34Y7Hp9Wg/QTQV1SbaJDUTpykBxZNv37DoXB5odh9EO2F4=
X-Received: by 2002:a05:6512:104f:b0:536:54d6:e6d6 with SMTP id
 2adb3069b0e04-53654d6e81bmr1544176e87.17.1725560386293; Thu, 05 Sep 2024
 11:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814082301.8091-1-brgl@bgdev.pl> <87a5hcyite.fsf@kernel.org>
 <CAMRc=Mcr7E0dxG09_gYPxg57gYAS4j2+-3x9GCS3wOcM46O=NQ@mail.gmail.com> <87y146ayrm.fsf@kernel.org>
In-Reply-To: <87y146ayrm.fsf@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 5 Sep 2024 20:19:34 +0200
Message-ID: <CAMRc=Mfes+=59WP8dcMsiUApqjsFrY9iVFEdKU6FbTKAFP1k_A@mail.gmail.com>
Subject: Re: [PATCH net-next v2] dt-bindings: net: ath11k: document the inputs
 of the ath11k on WCN6855
To: Kalle Valo <kvalo@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 5:47=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrote:
>
> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>
> >> > +  - if:
> >> > +      properties:
> >> > +        compatible:
> >> > +          contains:
> >> > +            const: pci17cb,1103
> >> > +    then:
> >> > +      required:
> >> > +        - vddrfacmn-supply
> >> > +        - vddaon-supply
> >> > +        - vddwlcx-supply
> >> > +        - vddwlmx-supply
> >> > +        - vddrfa0p8-supply
> >> > +        - vddrfa1p2-supply
> >> > +        - vddrfa1p8-supply
> >> > +        - vddpcie0p9-supply
> >> > +        - vddpcie1p8-supply
> >>
> >> Like we discussed before, shouldn't these supplies be optional as not
> >> all modules need them?
> >>
> >
> > The answer is still the same: the ATH11K inside a WCN6855 does - in
> > fact - always need them. The fact that the X13s doesn't define them is
> > bad representation of HW and I'm fixing it in a subsequent DTS patch.
>
> But, like we discussed earlier, M.2 boards don't need these so I think
> this should be optional.
>

If they are truly dynamic, plug-and-play M.2 boards then they
shouldn't need any description in device-tree. If they are M.2 sockets
that use custom, vendor-specific pins (like what is the case on
sc8280xp-crd and X13s) then the HW they carry needs to be described
correctly. We've discussed that before.

Bart

