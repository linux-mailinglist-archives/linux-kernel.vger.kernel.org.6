Return-Path: <linux-kernel+bounces-527723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A087A40E99
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 12:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75CCE3B6904
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 11:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422512063D4;
	Sun, 23 Feb 2025 11:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTNFSGyv"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED335205AA4;
	Sun, 23 Feb 2025 11:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740311493; cv=none; b=htiFEA8TlHgc0t4WSgcObfHEqQ5ePVr1TLuvejDs1+UVFKxBhPdnuALRq+6W6FwmrkV/q4fij73UHcZdJOkxqjUqeOiXHSdgnJL+oEK2W1ucJHRtPOayCuDhgZdAHCODOu9/kRPUKsy7Gid2U10oGLJ+Rbd2nsw+I9LSlOWLc/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740311493; c=relaxed/simple;
	bh=W3H3mJ4BSMRwPFaLMf5WUH4oDymvh3z0vUbhqVHwJxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xl4Grg+duZEEEoFsvkLqBW/rx2b4I16dacRnQzrQElPKHc9VT46Pu6WqgUcSLbVsZt/VQdFdGviIBcrdkmfbIbBqP0hcdlFTR1MucV82HegxSNnvK7ow9nDqrdN6+PPVOdaDTAieVzXK2gdWA6iQh7sz2sRWe1LzLbyImAB2qik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTNFSGyv; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38f2b7ce2e5so1996822f8f.2;
        Sun, 23 Feb 2025 03:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740311490; x=1740916290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26e9/1bCo2KzEw0XilO4IzJVWnnZzMcuU3z5EhtOBCM=;
        b=mTNFSGyvY0rQty8UQLXvvSsfLAsa1qZxfwqSR5AezPSbvZorM5KgZ3FpCTx36cGjhl
         eX/wsadZY6rLSvQZXPQ/75LipFcjdyoCe8f4tQEUzEwRw9ZWhe6NYNSfVLyVOufJngDS
         ympde8/3HyTMfdHfNPfIdka4FaET5cYiPER76SgUSPZylngMld18kk5w2ZBWsQvwgWeB
         RxnsMO1z/DIsfVlAgE1hI2SkcGWmaYVf1DYILfMjmHrgb8Byrf+qH8n/8+PL0kCiXX7a
         lbe4ikAVKM12QgegCAGkiHtZ+UoJo6FOJ9jaFKA7Lv6Mx0R+whm/zEdfMWLoGJe8I2kf
         Uybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740311490; x=1740916290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26e9/1bCo2KzEw0XilO4IzJVWnnZzMcuU3z5EhtOBCM=;
        b=mOgs6VxlGDNcnWxPwGu7UdskKCvVcSNBORLBr/Au/mlwUE1ZLOgBVoT6LEiPLmB7G6
         q4V96bYUCDBnDFmwBBuVpNpDRQyRwU80PmoQXm5EpC6orkqqbahxxM0dwH5z89N2/O3n
         meK+w5fLJq7Vr8BgieN2uclgAfj/ZhIbtMbgvHJzOSlcproR3MJURlt0vBkF1F9FAWAi
         ICFcU4eQ+Pm86u1dkZc2a6bi36RqIyw015MB7jqNukqBKv1URKyVYGCZBGuE6Xf2XSGK
         iy/zRFTkv6FdTtf2hkFFKXB+8HhrrvIPeopuRn3lezQbOC4l40qJKSWJUz6+aRCz6q5s
         AlUg==
X-Forwarded-Encrypted: i=1; AJvYcCUL5+sV0bVgqvKAhWRhSFiI9DtK+ZytQIUHmm6CayizU2PImXkytg8CZLuCcrsPvYgmEhzRJb6aQid/osHf@vger.kernel.org, AJvYcCXQDU1wjKSKeZ422bcYuZcM3u09o6RNv8CEvUgNZ2/2f/ME+IOZqYbt6kWT71wdiNs40WHffbSkeuAN@vger.kernel.org
X-Gm-Message-State: AOJu0YzdO7xQWu7mkapTFwcUgKCJEOttdLq8NvzzhbGlVDuZJz/L0Edy
	BK9y5O4L+PK42lLge+9NPkHtmjfamIKBHmkWwo+AgbQdrvp4vzCxN5EkBw/DNJ55NL4zTDhtari
	jNlyDmm/y4/IKVmB8d33q6FroiSc=
X-Gm-Gg: ASbGncst1IOFzTVFkLlP2t4hSF8nfn7UXUqahayJ+oeFkaHIS3yTar5BPe7d99ERQMv
	HVye0bXS6diMGxZ+KyoM/O+WBXF7pbOdUlF1kowOHtYuaTi3zxz92SsmuiA5BcZD8zdG8+hyzc9
	LD8r99DW/e
X-Google-Smtp-Source: AGHT+IFUY8WavUzMhVpce6VQO70NmZ5EwPPf00nrwZCquqsKG092y34G7GQYZ02Dtt3F/91ntC+z8Rrrq7/DZS9rVmY=
X-Received: by 2002:a5d:6d85:0:b0:38f:2726:bc0e with SMTP id
 ffacd0b85a97d-38f6f09750dmr8749537f8f.44.1740311490119; Sun, 23 Feb 2025
 03:51:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219083724.56945-1-clamor95@gmail.com> <20250219083724.56945-2-clamor95@gmail.com>
 <20250223-giga-moose-of-abundance-8e5b9f@krzk-bin>
In-Reply-To: <20250223-giga-moose-of-abundance-8e5b9f@krzk-bin>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 23 Feb 2025 13:51:19 +0200
X-Gm-Features: AWEUYZlBAVCQaqvLnRxWL6z86BtUQZGRjcPJQb2PVO12KuPqEZGDN-EI4locEUc
Message-ID: <CAPVz0n1v1BissCuD0DCmQHbr7O_Uymt-ZebXE=37jgjzj7wM0A@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: extcon: Document Maxim MAX14526 MUIC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 23 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 13:38 Krzy=
sztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Feb 19, 2025 at 10:37:23AM +0200, Svyatoslav Ryhel wrote:
> > Add bindings for Maxim MAX14526 MicroUSB Integrated Circuit.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../bindings/extcon/maxim,max14526.yaml       | 46 +++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/extcon/maxim,max1=
4526.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/extcon/maxim,max14526.ya=
ml b/Documentation/devicetree/bindings/extcon/maxim,max14526.yaml
> > new file mode 100644
> > index 000000000000..87cf7fd19ee9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/extcon/maxim,max14526.yaml
> > @@ -0,0 +1,46 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/extcon/maxim,max14526.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Maxim MAX14526 MicroUSB Integrated Circuit (MUIC)
> > +
> > +maintainers:
> > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: maxim,max14526-muic
>
> Is it something more than muic? Why different filename than compatible?
>

No it is only MUIC, nothing more. How to adjust it then?

> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
>
> This looks incomplete. Missing ports/connector.
>

It does not support OF graph model. I might look into adding this
though it is just a single port.

> Best regards,
> Krzysztof
>

