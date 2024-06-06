Return-Path: <linux-kernel+bounces-204380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1418FE7F8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B48C286723
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4877D195FDA;
	Thu,  6 Jun 2024 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ZPew/BYw"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32172195FD9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680963; cv=none; b=m9ZifonHC4BKNVhBjgv6W2z6ml1SmOIJN7HW4B+xQGHHnuWTFUD9UoRDK7KJEtj7O+1izlcdLgjBshSmTEKZ/Ioqdu5mvJxaZvPH9DKnuh7NuIfB4xZhZw4IfI+5Z83GipvLySQh+S7oOTvs3of8LAywqXrXkOfZKyzAeGmbaB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680963; c=relaxed/simple;
	bh=Dn+68IYvXFRM/ZJNZhnDd4YDu9/8K+l2gjrIK8I9Atw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BncpjmZzLT5hfXbOYwkeT5Dcmo2wDoF0vH12n3MM8GCyAemUZKzX2ZRQTPUzFZOMqT6ExmV/cs95LLhnQn0klSumSrq0Nu+/yQ5tRAye2ES3IBE1ZH5muMmNfW/Hv+kkQCQ/fBByUURBfMzlhqi9jHRuzIKflz1pukZ00HjNfgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ZPew/BYw; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eaa5cd9f0bso20257521fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1717680959; x=1718285759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcE4lbv2vNyPF1qxio9ZhgpB3UHvF6AORt7V6CDt54g=;
        b=ZPew/BYwIKEy0uQJtRGU5tOLUXyRlErHL96FWn6X8IqfA5LiltkPUv5gsc2WKBMwg4
         Q/MDVNkMkvwPBr+PvTRA5ayfnA1PgwF1o1WRHSDjxxqjDjL13o0zsETXfL05QKrbNA3f
         /WHZyYbwSd2laAe96gYtl77a36Q4HJ2Qwe87hkrZ+s8cIuOfPZljE1ZvrxZHLEw+2K9G
         urGmDGyTde7eMN1TfK5eyL4w4h3vHy92Kg8/unhJ/13G1wdbGjM9Ku0urSYqCDeWTwhN
         W+JR4Juf/JLrM1tLq8WRvVu0ItVD0EvOa8nJN4TKsHqxOqNHDpgOtBWseR7ohsLW/Cne
         P7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717680959; x=1718285759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcE4lbv2vNyPF1qxio9ZhgpB3UHvF6AORt7V6CDt54g=;
        b=bWhwi44jLkS/nHt/1GIHLIeyliklsgCxFKQjktxa6wh+TJvPCnlk1lVUdLHkcIL42e
         RneA+7f9oJ5W8c50bEWeVoWtZpa8FPel/pGd8erSjBAkeRJ8UVhZjmhljl4SOs6EkRnW
         Qemwz1WLQXPBGIGpndXBCCQevkxEWgL0PYs0j5EsxQ3PfOHd7zXbTbvCn1jzcNYvEo6N
         ZF5z68v99iDVqBIcZLkvjnXxt4nAunV3M7dZ+OysV7G1xK+DUuRVjdUnVYjUegV07V7M
         E60zjt9dnFbtb6P5j/VpacExttYoqIPl3DFXRWzcB2EGUgBqapEee9lMMjeMIMtxbKf3
         Am8w==
X-Forwarded-Encrypted: i=1; AJvYcCW0yL5HP5nz5ZzZiwBsY9jts8Hm90vaZgBv8LXzUW36uDoq736UAkdSAxmi4mB32HigAjtQkTuMBd/kS1rWHbFO8pxM7p0i8wCHdun6
X-Gm-Message-State: AOJu0YxmxldWNewJr4CcRULmNiE6qJdqWfAsAEB4bGLMH6ZLtHiU+2fK
	4mBGsVeOyKMU8nz+4EtXz3JqwFgALptdcu+mrwPcKl+NduraoHiXMtaO3ujdlJRAkotaEIyBl3o
	K0Jo0SUoSeXhjuyciG8b5fIs5OJsdLHTaETfJhA==
X-Google-Smtp-Source: AGHT+IFBM66nYsYkj5n/LotNPGso9ssGRfTDwE6YFuYv71IJpcC35zwc+EVz+BTh4BzurMJ5gBpZ2OPmZZ2xaKfaFt0=
X-Received: by 2002:a2e:9e99:0:b0:2ea:c518:7c6f with SMTP id
 38308e7fff4ca-2eacff98b6bmr8848171fa.1.1717680959188; Thu, 06 Jun 2024
 06:35:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605122106.23818-1-brgl@bgdev.pl> <20240605122106.23818-2-brgl@bgdev.pl>
 <87h6e6qjuh.fsf@kernel.org>
In-Reply-To: <87h6e6qjuh.fsf@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 6 Jun 2024 15:35:47 +0200
Message-ID: <CAMRc=MdiKxtnN+g92RUTXdOydaPV5M2u5iUdKyE2SNvDkdXAjg@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] dt-bindings: net: wireless: qcom,ath11k: describe
 the ath11k on QCA6390
To: Kalle Valo <kvalo@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ath12k@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 3:30=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrote:
>
> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Add a PCI compatible for the ATH11K module on QCA6390 and describe the
> > power inputs from the PMU that it consumes.
> >
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> [...]
>
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: pci17cb,1101
> > +    then:
> > +      required:
> > +        - vddrfacmn-supply
> > +        - vddaon-supply
> > +        - vddwlcx-supply
> > +        - vddwlmx-supply
> > +        - vddrfa0p8-supply
> > +        - vddrfa1p2-supply
> > +        - vddrfa1p7-supply
> > +        - vddpcie0p9-supply
> > +        - vddpcie1p8-supply
>
> Not sure if we discussed this before, but based on this I understand
> that there can't be an DT entry for device pci17cb,1101 without all the
> supply properties? But there are QCA6390 devices with PCI id 17cb:1101
> which do not need these supplies and already work. For example, my Dell
> XPS 13 x86 laptop is one. Or anyone who manually installs QCA6390 board
> to their PCI slot and some of them might want to use DT, for example
> setting qcom,ath11k-calibration-variant.
>
> This is not a blocker for me, just making sure that we are not breaking
> any existing setups.
>

If they are already powered up without the need for the PCI pwrctl
driver to do it, then they will work alright. Bindings don't affect
functionality. But if you have a QCA6390 then you have its PMU too and
the bindings model the real-world hardware.

IOW: your laptop should be alright but the supplies are really there
which warrants adding them to the bindings.

Bart

> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

