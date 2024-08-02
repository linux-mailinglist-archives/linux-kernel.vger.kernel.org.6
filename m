Return-Path: <linux-kernel+bounces-273194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C451E946592
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B09B1C2029C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A09D13BC26;
	Fri,  2 Aug 2024 21:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MMAXPefh"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572A178C88
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 21:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722635367; cv=none; b=JAjUPOEZNitm6uwGK58wYO6fa8LJ9B8MR4SyMuSNz5OK+v3ZV3MszkvJC9u18p1xKkHIEc0u2SpnY4aCJAjtup2KXCffwLAL5pJTd97tGmrWwXY3mZmt/M3I7LvzgC04qCE2EdtK8bYN7qrZ7cJdPYLAJs0NhN4cbPy5puehysM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722635367; c=relaxed/simple;
	bh=R6Zb/F6ag2O9vZ0Pie9haG8wBF096YdqUXtCoy88kzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIKGGqtNoVADgU8gpyIn8GYnpVBNlP4a8DKk/mj7lYySE9Edp6OtV5/tpAjc0DNgAhnlSqDSESdXCDZmmQW9ci802BMNowflxlVM0T7td2AjHU2/NY++uIcj4WPGAGOe1fTFE1MBtsZztWqPPUwo7AW0GkHRuMeMPJT6or9ulbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MMAXPefh; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d23caf8ddso7445140b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 14:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722635366; x=1723240166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3xun6ZAo9oUFbxVpXf94TJW8gwMbVmF/wsipE1ixAQ=;
        b=MMAXPefhQ7IMOrgPPXIVv0/B1WUHN//X1UtOiGwxOhvBG9+uFUX2tngB3UNjAoRJyr
         J17snpyYCr6QpDL7/j+gkxnXGkXOztFU+j1L9+YdFNV0mBdwpIMYAJ7oJLunFnbY8SmZ
         6YpCSr7S1ObOQKEe2eAlLke1X2MedZDkqVfh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722635366; x=1723240166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M3xun6ZAo9oUFbxVpXf94TJW8gwMbVmF/wsipE1ixAQ=;
        b=G+PeZEfznfMwAhygUGyGy9Wn3+1GJiKQ1LfdKYtoZ1wGwUtobq87FoE+EpUioReEir
         fcD7g/UsClQym9S14bsS1GQp3SdxR/X6cnhf2QizNfREG8/QryvaZZw/Y+25rJhFkMId
         A+DWR5HMRlX5G3l3CsP5inExCxXzjd6WC+8VhIxW+dQ2H4PMOUH2s/tnLmybwS6rw3jR
         s/ZJQs6inUg5WVgWy9Bxq2carq7IBBFMJi80lJHUrvKGyh7fmor3O6DwGIzxcmAdwvWa
         XB/q+nIIPSxneoyvJBn/Kf3aV/QXpEkzVCSf4BQSJtlkZYFJehy7iDclIhYUIrxHa9VI
         /K1A==
X-Forwarded-Encrypted: i=1; AJvYcCXQNNVLlKak47yXhqYUS8SX+HMAQKh3EulTJ9bkE31kG4bbEP/NWCnEhrQmITMrc11YzwpdSZ0SoXi07ocTM1Z9xxFXwkLr0P+iowdJ
X-Gm-Message-State: AOJu0YyFU5pvfrPs+hQiqLTX/pvVnxiEyKUEiUOAGMlgBgO9uL6Bc/uO
	8Tiszepsd3bhEl+uY/Q6Y2XlbeiodRfuSVGS+WalUMHLLbz7i32M/cdg/MSGIpWHWuGoiezC6NV
	H+l4I5NzbcZ49zU2Mc+qfRA7ji7WxPeTC+l7g
X-Google-Smtp-Source: AGHT+IHEdcupwcgV7ddSI8MH7LC3yQiJWlc6iHg4NY7jwa0Xdj7aQ/eTSphT4Nip4j1IqjjX/NtSYYnTEN8JBwS7BjQ=
X-Received: by 2002:a05:6a00:9187:b0:70e:9383:e166 with SMTP id
 d2e1a72fcca58-7106d047460mr5185025b3a.29.1722635365498; Fri, 02 Aug 2024
 14:49:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>
 <20240802031822.1862030-3-jitendra.vegiraju@broadcom.com> <ZqyXfonFv1GNlbvK@shell.armlinux.org.uk>
In-Reply-To: <ZqyXfonFv1GNlbvK@shell.armlinux.org.uk>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Fri, 2 Aug 2024 14:49:14 -0700
Message-ID: <CAMdnO-+51MVQjdJAs5XXqcOzjK7=JZJ5KhELKcws8h3JgM7FOw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] net: stmmac: Integrate dwxgmac4 into
 stmmac hwif handling
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, andrew@lunn.ch, 
	horms@kernel.org, florian.fainelli@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 1:23=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Aug 01, 2024 at 08:18:21PM -0700, jitendra.vegiraju@broadcom.com =
wrote:
> > +static u32 stmmac_get_user_version(struct stmmac_priv *priv, u32 id_re=
g)
> > +{
> > +     u32 reg =3D readl(priv->ioaddr + id_reg);
> > +
> > +     if (!reg) {
> > +             dev_info(priv->device, "User Version not available\n");
> > +             return 0x0;
> > +     }
> > +
> > +     return (reg & GENMASK(23, 16)) >> 16;
>
>         return FIELD_GET(GENMASK(23, 16), reg);
>
> For even more bonus points, use a #define for the field mask.
Thanks, I will make the change.
>
> Thanks.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

