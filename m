Return-Path: <linux-kernel+bounces-416411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6F39D4464
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC241F21C72
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AACA1BD9D7;
	Wed, 20 Nov 2024 23:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="J7ywevvu"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73791A0AF5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 23:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732144749; cv=none; b=s43FuBv2syYFRB+QS3NT5Y5ftMReMRPioDnqquHLRPMJUsV1N8vo29FCP0P5IsywZqZ6QHxKfO5dnYwPflwE9/GfZTiZ6KFYcfOQmo2ZJLibh6JcQrRT7LsbhwamSm1z/8Dy9MtS1eXUro5T0XHt6w9SyUPRDSeK5nKV7wPVbPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732144749; c=relaxed/simple;
	bh=OtDVQGltJXFsQr4TPz8WFmlB5hbU4Tq+iEJR2Zd+E8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=He22Fm5sFletgtxQmSf2Sg351AWJBJUTDHX7z5NaKyH1FX+XEhM+IVUGha2l+4EY1Flgm9Hx6trN8hqulEZtob6CP8bt9a6E+VFnFfAFG747zrKIAILbQQRRBtbJq7QSH0StJ+AjMPh0CvuRukf8Hg+lVvje4oe0cvO0JlynXTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=J7ywevvu; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a68480164so41727666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 15:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732144746; x=1732749546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xs+SrsC9IUbgaKcIlQpBc93FEGDcRI3usKuzpnz5nwQ=;
        b=J7ywevvuyk+d0buzTZ42zjxbLkbokDD1Redi8l0wL2y5mxNnZHKcPPiLegPImVPA6i
         gLmLKoLdRcbib9QLR3icYE2+LiW6ivty/3u2d9enulvGw/9UGz+eMyH/8yxqbfqP+958
         Hh4Nnu6qRgqitXNikKnG3YvQZUeI7SvDOc+3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732144746; x=1732749546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xs+SrsC9IUbgaKcIlQpBc93FEGDcRI3usKuzpnz5nwQ=;
        b=j9edXyRtErEGh6J1GUqDRyeYPpXlnAO1mzs4oEkzymopSNjcHAxrd0//9WWTjnmo7L
         /rCp6yS9ozt9fXQR+aa5/kPGxOSXN1muc3qJ14mZL+rp8eTEB49cfKaC9+zVwTPai14Z
         yHR8I3g9mgzT6XT2skxf1lnZZyeg5n7SX+pscddUf2PtJubLGAHq1gdRrHyaC9GQOol/
         /xl2JG/05PWjEo5NRJuCChpH//UTm9hIluZGXw8GBfSNCSV2g0nmWMVTG5xVk2nso1Di
         99Kk5la5zQGurifUageillWj8mb6rsCRFJPxlr7kgOx1NPrWpaMb2vHw+c3CkpE8JPu8
         9eDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZShpkASzxeF9UdIubw59ci3nQWFg7DTLpoomiwn94NolXxD/QRShkVo3TyhhOiN6tDa4NiZ4VtsWyyCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr+i7QIFndbhjH17KFaD+ZTLOvrVkWI2VWviHkBSF3c//cu58O
	2T8rRTaT3q3SH57Z0QReyp2CEvFfGacbLtZY/TJZKLIr40AR1/8LGcBFeDOjOEOaJ1zjTZpzuQ1
	nCFB7DQ==
X-Gm-Gg: ASbGncsKqhHUosmByrTD3gn9qLipEMsilpOVH5J2xtVUW9noPE79fYYBfAgu0hjvCS6
	AbBLGXSwpcmAorinUpubdgas4lgCayP6WFweZgCNrIkXoTiMpxTrczCj5VtOF2QXPBbXHNZCJ6D
	aUBbcBi76EhyjwEV+gs7fQYao2hzmwCdSVlWwxO6w69dhf4fP7CREUYTJbsBfqi1Pr4GfVBOts6
	3aChky/wNIauDDdPAZC/ta56CBdX3jtcyqbtCMRWtvaZs6mNsuuLyhoDui59wnNoMEhwwY+KsUA
	0S9J3kFAjmBWdRbB3xgbybmL
X-Google-Smtp-Source: AGHT+IHT5HnuLyydN6fVroYoYQtXbSY8y3Qcir0zUrtJqEiHciwmlvvsETShn1SGGS5KiTd0yfjFUg==
X-Received: by 2002:a17:906:4793:b0:a99:f8e2:edec with SMTP id a640c23a62f3a-aa4dd5522a7mr393406166b.21.1732144745825;
        Wed, 20 Nov 2024 15:19:05 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f415342csm11138666b.16.2024.11.20.15.19.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 15:19:05 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a68480164so41721166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 15:19:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXvYnH5YvkrfFJ1DYX9Zg/ZlWXoWZI8pLReUMDaCGSrmeoSBrI06fQPyQL+mgZDxtYXiWSErPlnZXKiD+c=@vger.kernel.org
X-Received: by 2002:a17:907:2d08:b0:a99:ecaf:4543 with SMTP id
 a640c23a62f3a-aa4dd57a0c5mr426803466b.25.1732144744981; Wed, 20 Nov 2024
 15:19:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d58cbbc9-e5b0-49c3-8cf7-d0726e796e92@app.fastmail.com>
In-Reply-To: <d58cbbc9-e5b0-49c3-8cf7-d0726e796e92@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 20 Nov 2024 15:18:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi=GZ7766ZBoT11aAp=Nqw6Uf8eVvuyQAycXJ1TR=5e2Q@mail.gmail.com>
Message-ID: <CAHk-=wi=GZ7766ZBoT11aAp=Nqw6Uf8eVvuyQAycXJ1TR=5e2Q@mail.gmail.com>
Subject: Re: [GIT PULL 0/4] soc updates for 6.13
To: Arnd Bergmann <arnd@arndb.de>
Cc: soc@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Nov 2024 at 14:58, Arnd Bergmann <arnd@arndb.de> wrote:
>
>      12 Jo=EF=BF=BD=EF=BF=BDo Paulo Gon=EF=BF=BD=EF=BF=BDalves

The name "Jo=C3=A3o Paulo Gon=C3=A7alves" seems to be correct in your actua=
l
pull requests and in the git tree, but you have something seriously
wrong with your summary generation locale.

              Linus

