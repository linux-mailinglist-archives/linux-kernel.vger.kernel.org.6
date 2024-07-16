Return-Path: <linux-kernel+bounces-253226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B0C931E59
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B84521C2212B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 01:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CE14A24;
	Tue, 16 Jul 2024 01:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QmgKPpMI"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CF98473
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 01:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721092550; cv=none; b=NrXvPvMOoGHZMu6upYzXTSaHfn737Y1veEebiDSrfqQnGCVFNKD1yha2jv/GOrYvEqnL2P0DxSQiFCT6vdtOve37K+JhnYhFusSakHQpwSCjcLPoKWUl66CDzHSCBCfpt/TugV5aqeKCsoEtls4AxSBhtIFVxOyHfl8lHzivOwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721092550; c=relaxed/simple;
	bh=ma8kZGG5/fhb50KYEBsy4JDGgA08nXExnvqK2TFGBLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1APzUZwavtqNKTo7OKBIMvnBc92kr5jgV/4JmpXOyjBdnouyO38pUMCgj6mLJkcm4opPZ1uRjH1F7FOV6H7qs2Z9cY/8Lx7Sn9+vIunvsxa9r0Unwdw8ENWmDwh3LBIYdy1rSoO16RvJN5BZrmnR4UfyYKGdqm8gQgrVehe02g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QmgKPpMI; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ee9b098bd5so68166701fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 18:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721092546; x=1721697346; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mPuR+C1GHhZX3EMRiw+geFqgtI+NpwUvUaTylEX4swQ=;
        b=QmgKPpMInqqtCDBXkTXLJ2shTWTLOSmFKAsTPAwCr4PaUljWZXM11+JXsG5HyWsbWX
         J+ahm0ohdbyQgSWOCRiVBZGbPR4zirBP7JLO6fBxVtNDbMb93h0LoGAWwfV0zyx1Bws1
         EtmshLVEFIiRs2ps5YY4pHbX/kzD13Yf/BBQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721092546; x=1721697346;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mPuR+C1GHhZX3EMRiw+geFqgtI+NpwUvUaTylEX4swQ=;
        b=sgSLAPSII/0gxCNiHuVn22DDfR1QthP8VCctdr84TOxXMl40cBA79J6kw1x6sS3/Ll
         ZT2/M7+3ZVxWCN3vnxs2uUjDCpplFipWWTU/OYvMZutEtX1VQjmb8jnGDdCugYDh+3vw
         m3wt8h4QychXeeZNwEVofJDBfmbuZOmVhRrDI3LtJv+/iowH2Fomh0jDkxM2IAv0am5q
         oxQ9C3QwZRB5tFxCpgzUKfZkky4tp7iczgOdbLND3H4U2eU46yvW7xAIN+nBHriydicm
         /UugOm2TH9MHVPr6QH2xYrE7SXneH3b7Ee60RBdK5LM5eEwqNJRIrf30vEM3eInCKRQR
         pgug==
X-Forwarded-Encrypted: i=1; AJvYcCU11vPFLFU0KYM8mpWaUgSxDqmvyKpCx6XxkyvwwEmyU7dbr+nG2yFysgcYibzRrlkMBOxGJmf3QY8JL3Hu2bUzV+JZEPtREfrAL30h
X-Gm-Message-State: AOJu0Yy3yWGfvwk1IXSxL7OJADK6z++B/wOsjMfFwIxDxiSL6oHhEDQd
	EexFWv4aX1FV9R3rRSP7YAqxBRC02a/gxD4qvCSr4d3OnvdIpoW7WlghxnfhJ49BrTyiWOfBkwV
	D8B9GFg==
X-Google-Smtp-Source: AGHT+IGn6J7aSdIY1qyxhUoXMc5e2TO1QuLtP4WdeP2i8Pv4u8K+u4jDXxS2HHgGcjdj4IP5jVEoQw==
X-Received: by 2002:a2e:900f:0:b0:2ee:d5c2:2ad7 with SMTP id 38308e7fff4ca-2eef41841b2mr4441781fa.21.1721092545720;
        Mon, 15 Jul 2024 18:15:45 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2eee17b1c20sm10736441fa.51.2024.07.15.18.15.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 18:15:44 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52e9fe05354so6771214e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 18:15:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDL4oSXERgnbUNFToxvErj0Hr1x6Yoccc0STHdMlp16EaDODWGL14qc3xlN5bLYXiP8IY47Vms8HgFRvDO9YiFsOw6k4PQBh8+BPZO
X-Received: by 2002:a05:6512:1095:b0:52c:df4e:3343 with SMTP id
 2adb3069b0e04-52edef1e238mr344579e87.16.1721092544195; Mon, 15 Jul 2024
 18:15:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3ada1d9c3010145c1dcfd5c65f12a3fd.broonie@kernel.org>
In-Reply-To: <3ada1d9c3010145c1dcfd5c65f12a3fd.broonie@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 15 Jul 2024 18:15:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg03gdyDBv8ep-UmL=QdNr3278Oa21o93Eiysy8gDoJNw@mail.gmail.com>
Message-ID: <CAHk-=wg03gdyDBv8ep-UmL=QdNr3278Oa21o93Eiysy8gDoJNw@mail.gmail.com>
Subject: Re: [GIT PULL] regulator updates for v6.11
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jul 2024 at 07:15, Mark Brown <broonie@kernel.org> wrote:
>
>  - Support for Mediaktek MT6312, Qualcomm QCA6390 and WCN7850, Renesas
>    RZ/G2L USB VBUS regulator and ST Microelectronics STM32MP13.

Grr. My arm64 testing shows that this is

    default ARCH_RZG2L

and turns on automatically, which might make sense if ARCH_RZG2L was
some kind of "I'm building for this platform".

But it's a pretty generic thing that turns on very easily by a lot of
random things, and ARCH_RZG2L a 'bool' anyway, so this thing that is a
tristate now effectively defaults to be built-in.

Please - new support should NOT DEFAULT TO ON. Not even when you think
"it makes sense". Not unless it's something that was on previously,
and was split out, and is now available under a separate config option
name.

IOW - if things worked without it before, it should damn well not
magically turn on just because somebody did a "make oldconfig".

               Linus

