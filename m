Return-Path: <linux-kernel+bounces-213284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5950907372
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4BB51C2256E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8764143C79;
	Thu, 13 Jun 2024 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeLm1vd8"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B38D1E49B;
	Thu, 13 Jun 2024 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284794; cv=none; b=oks6EqHHKZeAq9vBCzefBPPJs1HE/5sM04h2GR5LZgzmuAFCbxOb4FH4a6iIGxD5I7OdFE6MLVE2Ah/K3eHv+O4mmPtH5jNqoaDXYHWV52c3yRMpJBAPq6Bl0vKisVIw53Tw9wnNMR3OXYyFCQbuA6E8pJF0VHeaUN7wbOY7YAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284794; c=relaxed/simple;
	bh=Xj0fTEOHNx3Q4YEflBUls+3/aqrcnAVI5yTl1SkqXik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NizGwUPQpgD1w8BGAD/FHbjRJuOnvK7GqJBe448UucEv/JWGIIG5uQnVGQCFqzdsNeD4IpsjN4fuWw8rCT2ZU0HJ/+er3Li53oMOlIBiQ3azuYG1au+ptOXlO/JU9G1o8cMOVNFMJhKdjJ95porVNYhuhS7Krj0ihDMjOsvgq2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eeLm1vd8; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6f253a06caso130737866b.1;
        Thu, 13 Jun 2024 06:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718284791; x=1718889591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJivB3lAqZdSHKd3laSLZTvON3gpyYSN3zAVDG77JhA=;
        b=eeLm1vd8k0SeBOlaSv9mKdPv5axnUz00OV0pNrl1qthhwCuWWJGxgbERNqd/tPnBFv
         ck/zIzq+L8BSmLGXf5ttCtoLPPhqBz8PyTuwKReAThVGmhG6sLtVGlezVcSAmZHE+Snl
         LrwJFGP36Xv04EIsrNtpXzwtaaduoKA7rln7dQfVHTcTz16REQArAwM1EKFmcRCw6TeR
         +P349n0HzhFRnkPajKETs9YZN8rGjneqTuyxAa+r8OCknJUZU7cOcDISzWQM1k0Ou76v
         5uLrfk/wqzPkVm2IE0lIzLXzko2oODqQMcdhdjAE+kZcmVV6A6LmzfYAxr/cf2vScWp7
         WW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718284791; x=1718889591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJivB3lAqZdSHKd3laSLZTvON3gpyYSN3zAVDG77JhA=;
        b=fCWgrA+Xchvq6Q7OW1jAxuXgy6ru9wuKmMTKt3b8fvegf1iekozutO8q3LUbb5PhU+
         ZrQoYOelAdyMwCZCYyNRwl9Hs7Iou3R29On4D1VV/kvamlj1e9BiSmR3d3QP24UBW7t3
         Iw/XSuirWb4SsCBwX9kpVhDi+LZzt3Llp1yRfxYv9S8Hulp2EYmH6BarbBVUlmsxxxig
         pS6h8c9rz/Z07q9EMkN3CbOjyAgjoVbXw/yBYhAvSRlq2WcKRyBanlxH92LftJHrZa+Q
         7TFkS2Z33dryKhqLgoOh9l0kNO6dKKeBi0piBRhCnqAh9mR1mv8kkvJOdkxFHRnOGgju
         ajlQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6soOBFtLWTrcq8Mkw0+KHlk4OrzGzNzBFWxZnhgJWtrE2PGzHZzQ0w296pqO7HXS6eltgGwwa5rwC7qsJW1qiRLJ5owuQFjGOXcv0gQw4w5PatX+ECJLkreViE+2x1edtvrpAcd78p6nwXO4qSzh2FiLuv5zqdoXVZLpqhbN5h4EElA==
X-Gm-Message-State: AOJu0YxBp7WdKgWWQu7F5IUcQjNPkF+heAxOFpb/emls3SQ9sf5qeOA9
	MkLW1XXMxa+h2/wilQrzX34FvQnZ5sILOhlwFxCdeX/3VKD3yeqeerdFaJs3drQhSYktcLDBmYl
	LSarfw+/DDCqpJW+zm/bQ5smMhu4=
X-Google-Smtp-Source: AGHT+IF9xJixqueLEsoJYNUdnYefU0/4ugzxbAQahO7t/3irWc+vxn0SjcTMwk0X/V/5gZgDrKFwFa5kckGo8IZxiPg=
X-Received: by 2002:a17:906:1354:b0:a68:b73d:30d0 with SMTP id
 a640c23a62f3a-a6f47d4eceamr366263966b.6.1718284790528; Thu, 13 Jun 2024
 06:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601092646.52139-1-joswang1221@gmail.com> <20240612152347.3192-1-joswang1221@gmail.com>
 <21cfeb4c-4ce2-487a-bdd5-45c3ed71bf6f@kernel.org>
In-Reply-To: <21cfeb4c-4ce2-487a-bdd5-45c3ed71bf6f@kernel.org>
From: joswang <joswang1221@gmail.com>
Date: Thu, 13 Jun 2024 21:19:40 +0800
Message-ID: <CAMtoTm1ORiZHhMZRZ9NCq4qD7RB-ZCzAnusdN3PvRUff5zSh3A@mail.gmail.com>
Subject: Re: [PATCH v4, 1/3] dt-bindings: usb: dwc3: Add snps,p2p3tranok quirk
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, balbi@kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jos Wang <joswang@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 2:17=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 12/06/2024 17:23, joswang wrote:
> >
> > +  snps,p2p3tranok-quirk:
> > +    description:
> > +      When set, the controller transitions directly from phy power sta=
te
> > +      P2 to P3 or from state P3 to P2. Note that this can only be set
> > +      if the USB3 PHY supports direct p3 to p2 or p2 to p3 conversion.
> > +    type: boolean
>
> Hm? You respond to feedback and, without waiting for my answer,
> immediately send new version?
>
> No. Read feedback on your previous version. Drop the quirk.
>
> Best regards,
> Krzysztof
>

Thank you for your help in reviewing the code.
Sorry, I submitted three patches in total. Patch1 (the current patch)
and patch2 solve one case, and patch3 solves another case. Because
patch3 needs to submit a new version, I resubmitted v3 and v4
versions.
Patch2 is under review, and there is no clear conclusion. For now,
patch1 does not need to be paid attention to. I will notify you when
patch2 has a clear conclusion.

Thanks,

Jos Wang

