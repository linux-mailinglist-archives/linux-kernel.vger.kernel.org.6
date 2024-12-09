Return-Path: <linux-kernel+bounces-438431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49F59EA147
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 22:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA91E162B6C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C341119CD0E;
	Mon,  9 Dec 2024 21:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNenawyu"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DF146B8;
	Mon,  9 Dec 2024 21:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733780080; cv=none; b=N4T/6gU5q3jaT12TwDG8KzaOLfr6S8tJQTX1vC7ncA8Z1iFepeq+cCeiyVjVQjvAgcsnvcKeT3RF5LLy7lIG72aHPDtSVkQ11SmvKrtAEFOe7iPGhUNQsTIVoS/7peMFFqPCw/S/IBWtjcID8sUyRaN/xPIEOObAi3Tn20m/dS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733780080; c=relaxed/simple;
	bh=OaYQyqSw0Hl4TdR7kpLFuBM+r+JH3hSzeR26/EtUU3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aGMQmTow4fI1d3+Si+oeT11offuImgmrTu/DIjbKoKD23uvm0yGcINUPPonYzTtkSnYWgKBMdRuhPzZb6StTKpbZxwF4xLB/EWG81gcep+1G2SdzOAsQO1lnKRSAuapsEzRyNukpnE9YR3A+8XGztMdRZe+NRqChlUuOE+FV98Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNenawyu; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ee6d0a57acso501144a91.1;
        Mon, 09 Dec 2024 13:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733780078; x=1734384878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OaYQyqSw0Hl4TdR7kpLFuBM+r+JH3hSzeR26/EtUU3I=;
        b=cNenawyujPIW1tDmx3q9mfecfhHIdvEb1rb86hj0y+zeuLpm9AJzlhI6WWIQnHWeQj
         mb+XGxQOVxbXxvelY7a0oPBFWBu9IN7jpudPoe/K6/WjfwBJCci6k8ikR1eO3b7PyvLL
         pm5N4vj5uOcXL1ffxzoy1Hrz1buKzA6T1OgICHtVNqD9bdnCw/bVKSjVeYeN8uFDliwM
         w56plvhZwZFcUXPzmr9vWJOSye2m73wCC8H8PxKcJ/Ko8meQuEl9AJdnhd1BnY0NbFOt
         uOBPcQlG0t8S1mgvD150rG2tsxEFWAKeUGzFb4sKNpTts6BcNpB8OdImkNyvvNB/T5Qg
         Mq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733780078; x=1734384878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OaYQyqSw0Hl4TdR7kpLFuBM+r+JH3hSzeR26/EtUU3I=;
        b=FF/Vc0uy8x+yYCz99poIomox4JxYQmG4Y84P6eXi+4cretNTb4pEq7AaRv9j9hyXDO
         X9ANUzBmTvMaR3dMicZ+7KCLSF2o0EupgTFcO+JJgTkkCKMbzEVlHcvkcXob6De1T3YV
         pa6qP6SoxSJutEGPms1yp035XfwtEHfdN6F0nfhnQH7svHgiOXpsZ0shX0FflJWbr8rf
         oRM3lk5J1Cl+tbC0333Dsi14wrrvGDvr61sQZgU2+EAkJMenJKW9N3tBri8zIkhnZD2s
         RrfuBn2H3qM+WiOQjiu+BurTqTB8fqxenIr1R9Kah03IGhBjkGBQOjA4dPbAnZL49DDa
         wfKg==
X-Forwarded-Encrypted: i=1; AJvYcCVCy4bdkzTDHiT01LWLq2bRYcWbr+X9cCkL9OjKENSJiz2kge5Gj2oM9MZ4MhCSNsV+IXD+nv9C7PFPoeZcWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxrL/Les1Rwkiuf2MVU2FvdaMtMZdYoZZUymYT848363LgGLPf
	NdxG3RJltdUQ/TVQRAoq57rBDcvL3ty2CgeFmcos4lO05mZ7Xnaq0BZkhQh95xiS6m8shQNovU+
	nO+PsTzggGe49QiE33BNAHgTqseU=
X-Gm-Gg: ASbGnct5mFARRO4+owkRMJqIgFX5Z0y720IFPMgR1yqLNaFl6rkIDxfCLszT7hhNYLr
	5BTQ3hVh1ENaEfd/FD95kX+0QKSlIyQsvTFg=
X-Google-Smtp-Source: AGHT+IFEaU5HiJqABSjJ+nt1HjHP8vFmJLaWaM25RE9Mv7RG0zgDuLJrlxJnTg2lSTjKdUeTBLDxdiS095LsBHvt7sA=
X-Received: by 2002:a17:90b:3a89:b0:2ea:5e0c:2844 with SMTP id
 98e67ed59e1d1-2efd4a12662mr605031a91.5.1733780078068; Mon, 09 Dec 2024
 13:34:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204174627.1151288-1-lee@kernel.org> <20241204174627.1151288-2-lee@kernel.org>
In-Reply-To: <20241204174627.1151288-2-lee@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 9 Dec 2024 22:34:25 +0100
Message-ID: <CANiq72mr=J8j+g4Sc9OQEKsxBHxBNaAAB62wvXwb-Aa5kTAUJA@mail.gmail.com>
Subject: Re: [PATCH 2/2] sample: rust_misc_device: Demonstrate additional
 get/set value functionality
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, rust-for-linux@vger.kernel.org, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 6:46=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> Here is a simple userspace program that fully exercises the sample
> driver's capabilities.

Before I forget: one idea would be nice to get this program into an
actual file so that people can easily give it a try. Or maybe as a
```c ...``` code block in the docs.

Thanks!

Cheers,
Miguel

