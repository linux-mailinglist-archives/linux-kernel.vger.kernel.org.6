Return-Path: <linux-kernel+bounces-275510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5547A9486A5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0AED1F23309
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 00:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631A46FD5;
	Tue,  6 Aug 2024 00:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MMaCtAK8"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C288F6C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 00:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722904603; cv=none; b=qWY7qDdjz6kvkuEZrMRUyrZo3wFU8UM+IDeEXIuzsvbYayvs4Q42i6olzHV1rvYjZUIXrlhlKKMI/DjH/4x3yPyavZT5j38eNDbl5xFqCB6G143rA9+zwm+iaW3jUupjuuw5YK/snyeIralVcJjE1cjS2JJvULf05ZXf43Lb5CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722904603; c=relaxed/simple;
	bh=7nXzsm5lZsyoe2KYHR7mAFN5Di2jrUPt9eEDIzEOn2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qGq68QafP51GkzKh3XoUbxiIuzLUWSvBUaf5LJ/M02ZobMHwaHoyueCjky0kJbS1uzBc3eqTm6CeXVtM5b7c99F9MjPbQjJxm81JMBi8wqAi9/eh3CBKHs5ZSqW5nFya4RKBL+SB34ifw0J5vf2j9OpSMxP7QKFG/aLF109syJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MMaCtAK8; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2cb55418470so36658a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 17:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722904602; x=1723509402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pplKHmr8EQUNWlMcxLWDiYQCbu1qDuf1WOvlJRSkiA=;
        b=MMaCtAK8q57Ma7YRldYy3uVY3Fr9DqeSpUx3n7E2+vQJlD9m2yOQum+p2Fo6bU6ITd
         H54CeLH+0uMzkH7yghHL/lC6jAr+Yln6N2WY0u79Ucx9IhJzzccLxvN7ztadbcAr8w9j
         wsynwBuCQK/FwTB8M3GLK2oTwM/qzlLFEtR2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722904602; x=1723509402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pplKHmr8EQUNWlMcxLWDiYQCbu1qDuf1WOvlJRSkiA=;
        b=Zuqx8VQNrJJhlEIVq05moYRljfoSXGsg8oVtqVFnLE6EaLLFZv/g/jAiAhPfexaJ65
         FEnyOIDlYvSs36PcAi94v1DeCiIHIo7PGRaj6R08CU8WBdWX9HMNlVzwajxwULvx/gSU
         E45cQFiGYyOw1NDyWHBxq5Da9sRPJDxssXk8caskeurawjHdBKd9xu2egDzCZxRIAIPb
         MMBIhlbkh+wCkgNzO/W/J7/AZlv/QrKmyKOFP5wfzaC4VwvqISBqQaAfi9wP77UAKNlU
         EGS9mFFHA/ylI/Ij+3ZKgzZPvPdDVWgvAWrSDbj4DzkSldF65Gpds1JoPOd3fmAAKoBk
         ZZyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMICDIT/2kE1XgF2PCBgfm+uA67iwnumVoY5Mtvy71M1SJqXtsBmoT6jR3jBpaD+3wV+XoK6b9waRRXpkwWKlr7p2vy3rIDmns+HU5
X-Gm-Message-State: AOJu0Yyrb7BnXoNMjXf3QwFISicfoOgUyiEDlaYva/l9s64Qr6KXtb2w
	y6Ih1dupv5GVhfVky139ruQEeIUd2OE9cOnqzoCKnMVJA0QIc/yOmzKa1TP2PA8tLUw5zYcPzzB
	WIfgB92LRE/mUcIrZdvkkRe+Cke4od05Q112m
X-Google-Smtp-Source: AGHT+IHB9BEhSWGe9GLNuS6Dm7ZTZZe2UpxioIrIh4RcepSEQAn5YPOgfkAxaCARqqd+KnKQ1tppT5pDOwojFV3vL6o=
X-Received: by 2002:a17:90b:3643:b0:2cf:ce3a:4fef with SMTP id
 98e67ed59e1d1-2cff9445836mr12346878a91.19.1722904601682; Mon, 05 Aug 2024
 17:36:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>
 <20240802031822.1862030-3-jitendra.vegiraju@broadcom.com> <1e6e6eaa-3fd3-4820-bc1d-b1c722610e2f@lunn.ch>
In-Reply-To: <1e6e6eaa-3fd3-4820-bc1d-b1c722610e2f@lunn.ch>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Mon, 5 Aug 2024 17:36:30 -0700
Message-ID: <CAMdnO-J-G2mUw=RySEMSUj8QmY7CyFe=Si1-Ez9PAuF+knygWQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] net: stmmac: Integrate dwxgmac4 into
 stmmac hwif handling
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	linux@armlinux.org.uk, horms@kernel.org, florian.fainelli@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,
On Fri, Aug 2, 2024 at 3:59=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +     user_ver =3D stmmac_get_user_version(priv, GMAC4_VERSION);
> > +     if (priv->synopsys_id =3D=3D DWXGMAC_CORE_4_00 &&
> > +         user_ver =3D=3D DWXGMAC_USER_VER_X22)
> > +             mac->dma =3D &dwxgmac400_dma_ops;
>
> I know nothing about this hardware....
>
> Does priv->synopsys_id =3D=3D DWXGMAC_CORE_4_0 not imply
> dwxgmac400_dma_ops?
>
> Could a user synthesise DWXGMAC_CORE_4_00 without using
> dwxgmac400_dma_ops? Could dwxgmac500_dma_ops or dwxgmac100_dma_ops be
> used?
Yes, the user can choose between Enhanced DMA , Hyper DMA , Normal DMA.
This SoC support has chosen Hyper DMA for future expandability.

>
>         Andrew

