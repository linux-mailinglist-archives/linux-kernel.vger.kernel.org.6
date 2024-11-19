Return-Path: <linux-kernel+bounces-413744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B79C29D1E26
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 03:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51E24B22DEA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB7014D70F;
	Tue, 19 Nov 2024 02:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gW7f1QbD"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892C219AD86
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 02:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731983004; cv=none; b=Cj5yO66DCpLry9lGa/rM+saOB9S5XK35/lDRMTlSAyb1ugACiDMaUbFU3bF9Mc4X8gZAQcKtNQOxuuhSmeK2F39TLD8/ZsbKnLD714mRU7lx85dQEFb+uTJOR96DQQTvqzlaXAM5zkhxlXySKeLx1tu0ByDR7mbdPps7sx/RMjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731983004; c=relaxed/simple;
	bh=4MusnTHOvGCXbl0nkaIvWiNeJ03CAQCB33OcASeipXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6gqZwTkcaDKfa/tin29PqKW8lXHvlxDKSEGRKAU5VjselY/7tZ5jiDRH/JuQAtgjXu8cVQsT3zr+pYRXsmQfVUKiMBuD2kHtPInJ10M0rT2S8N5xD8ZWAihsKdJ/wabF4QdZZfYImuvtlumiYEgIMPeT5AqK3XQPTZyfNquoG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gW7f1QbD; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-720c2db824eso439911b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 18:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731983002; x=1732587802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jHJ+VpcRmwxKu5/WPIGwQSIP5WqAzHzgd6c/ZcREfjA=;
        b=gW7f1QbDNBVj8uK5uS/fvPFSeRsnNcGGxk2JOultApHRCxnaVbZcFruphB6GAZwwqY
         PuUg4L+xhP1kBcV1wpd/MBO2NhwWGimzF5U2EbkB2E5szJ5GBTbdLNTg+v84jJqw4cns
         0AYuVEqoLp3jMEw+2UaiEQG+W7cWnSCkaZ1KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731983002; x=1732587802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHJ+VpcRmwxKu5/WPIGwQSIP5WqAzHzgd6c/ZcREfjA=;
        b=reaq6PmyL2nfgKe+DJ2IqFjyKjsK3d5JuGv9fbPYCJDj3TZ2vLHZtnAI22o0Zb3Csd
         CI7ZrqGiNwW2icWjqYMzsu+eQKnRsfW+Hi3SfcQe3mmJNIF7cGWojP3SwAxrw1f9EBfs
         lOJ8w3WRDxMi9re8ZCdRKMAvzZkBcXCZEctpA/YSyggSJZ5qRZHz3goHLSoZrhLONS8X
         qzHVeHxIrDr88qc6Wb1Y+qpGOZF7vB8+XSpK7ZPhJuLejHlrebolqKB+HLDAVZJVry0f
         q3cFw3Mt/xAwWsw3mkCe4dF34RL6zLTxgjonG3CiMeQvZwRCaOLfykM1IL7Wgigi4LD7
         Uf3g==
X-Forwarded-Encrypted: i=1; AJvYcCUhxr9VFRDjySsPrEE0f4UZdAGvGyqohQkSGp5gVutgfQKk5njop+kFD9b3QoErKos1AsHj1iHUyxVdUAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8aJ4hGWYFMyOsLu3COGceFGkladdzJlr3RPAYGT10AI7aouYP
	eriqVx2RvTgZVTWx0HjOXqwhVxfRfgfxXsKoH3/jkF9XYao1OWtcLSqXECSknw==
X-Google-Smtp-Source: AGHT+IE78YUZbFTKrDWhSwPmB097Wk4a1j0g9tpeUAlr5hwezpZ0+bopaS9Y3Pj44h7ylBGk5x8F3A==
X-Received: by 2002:aa7:88cf:0:b0:71e:5150:61d6 with SMTP id d2e1a72fcca58-72476d58a6dmr19963818b3a.21.1731983001735;
        Mon, 18 Nov 2024 18:23:21 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:e40d:fa29:75db:2caa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771e1a69sm7123889b3a.141.2024.11.18.18.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 18:23:21 -0800 (PST)
Date: Tue, 19 Nov 2024 10:23:18 +0800
From: "Sung-Chi, Li" <lschyi@chromium.org>
To: Rob Herring <robh@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: chrome: add new binding
 google,cros-ec-chrage-state
Message-ID: <Zzv2ltfXqaW-2ALm@google.com>
References: <20241118-add_charger_state-v1-0-94997079f35a@chromium.org>
 <20241118-add_charger_state-v1-2-94997079f35a@chromium.org>
 <20241118202520.GA3273373-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118202520.GA3273373-robh@kernel.org>

On Mon, Nov 18, 2024 at 02:25:20PM -0600, Rob Herring wrote:
> > +properties:
> > +  compatible:
> > +    const: google,cros-ec-charge-state
> > +
> > +  min-milliamp:
> > +    description: min current in milliamp.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  max-milliamp:
> > +    description: max current in milliamp.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> Use standard units defined in property-units.yaml.
> 
> No constraints? 4000000 amps is okay?
> 

Hi, I cannot find a good value as the max value, the will depend on what charge
chip is used on that device. This is like a upper bound set from the kernel
side, so setting it to the max uint32 value is acceptable (from the driver side
when loading this config), not the desired current value. It is equivalent to
kernel side do not specify any constraint. Surely, if kernel set a value that is
larger than the max value, the EC will reject that request, either. The real
current is bounded by the EC and the charge chip, so it will not damage any
hardware.
If we can find a meaningful constraint value to document it here, that would be
great.

Would it be sufficient that I add the explanation to the description?

> > +
> > +  type:
> 
> Too generic. Property types are global. You need a vendor prefix for 
> starters.
> 

Thank you, I will use a more specific name in the following patches.

> > +    description: current limit type.
> > +    enum:
> > +      - charge
> > +      - input
> 
> What if you need to describe both?
> 

We need to declare different DTS nods for each. This node is representing the
constraint, not the charge chip itself.
The voltage, min and max milliamp on each current type are different on a single
charge chip. For example, I have a device that uses the charge chip rt9490, and
it has the following set up:

- Input current
  - min-milliamp: 100
  - max-milliamp: 3300
- Charge current
  - min-milliamp: 150
  - max-milliamp: 5000

I cannot find a clean way to merge different current type, max, and min milliamp
just in a single DTS node.
Also, we need to split different constraints into its own DTS node. It is
because the a cooling device in the thermal framework need its own DTS node, so
we can use it in the trip section.

