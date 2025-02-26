Return-Path: <linux-kernel+bounces-534803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7BBA46B5B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA8733A86A3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B111F2566D9;
	Wed, 26 Feb 2025 19:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JbJ9Wjw7"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020E621CC66
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 19:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740599217; cv=none; b=dlmT6FWMrHwjxUeTbipYnAUQLZ/PkIms2kjVFQ4JphwMiuvow1aa3aV7ylbSym53lj5qgs/LQHl76aUhB3ioCcTgMc0ifLuHx0PTQlfotYuDYm0DSPcRaU3HLeS+UAg/uzeDoA3gHtL0Vdj4yyEIZ5OPOW2dSvxFz5vtfReyX+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740599217; c=relaxed/simple;
	bh=kmXsm0tu1kCQ1GFE0RiAQ4Mdk6NvP8QTIiy8MYMTOJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eztVJOjtsPwFuw65udLeJyo6cpZkqheMOt8aQTRikSiTWqEYriNVfb2KCtCKvpGJVEsc4u0qD3pDilQr8jmkkikCyr00MCvuCSv0dqBrBTjCtV0Ke4NwqhHxWp/7/uWMjglGS3+bvz7N9Anw71sqCTTbX9e3ggrzZHP5bADIlRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JbJ9Wjw7; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abb86beea8cso23940266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 11:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740599213; x=1741204013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aDq2bqWbHjLfc7ZX5wzS8caIXUgF6MrSjsLg41kQmUQ=;
        b=JbJ9Wjw7nZz9GkiBVUTvNWjiGIaAZot1Wb97jWoS31zp14taon+k28j3Z4hVbAIMW1
         1Aw+yren7/eUSko9AyT7QMjzN05XQkr8ZkXfCdE2mvt93fpWQna1Vk8waO1XVgJEAEHJ
         ML+R3zSIfrpavRWwzxYRz42e7L58ChP3LipCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740599213; x=1741204013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDq2bqWbHjLfc7ZX5wzS8caIXUgF6MrSjsLg41kQmUQ=;
        b=Phi74LB9FjTi/zygcBI8/suLk80m867tKc7qDfJboixTcpLkYBAJHs0av3bdBTWSFg
         CqBq5Kr2ByUXBc9ReO12TYnCzmJwLknkJXJYVrOc0RRnOIgRm9C72nf59vmX7/oDFzK8
         Lg+IgE3ztzWLybLGwW2DZDE7xh6X6EBUbhIvr6LDKKEUpcOKjWJB7P8YAjZTMyTyOggN
         x5gpa5tRiD343xWfJYngNRmbUcDuMrtbrBf6mCwfdHz0JmG9s8xTYwfl1MB6jjgJV0za
         eujfnlX/ceRwVf4hRsZgX/mhFFwyshPbPzGwXkGnQRBN4VKR2yOQq9DX6mKbmPvMonaX
         toVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaXR0SVWpggEUbWKTpK4u2vDb5J1YYcVn/95XeyqVBA2N4BfoRxC9REiNokDRClVJforNwU9f4L+YUP5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA7AQec/cwE3sK/N7DW8/Bax4dmTm7ElY7yB/wu0FlUTeLMNvz
	30FCKVDOWU+o/4JjPAkXYT2rcIWe0tCAoS9U9A+CNuiFNm7x3/P2eZ4yE259UvA65JnX9XqG59h
	Bgk8nng==
X-Gm-Gg: ASbGncvrwe4VoWF2F20x7k8a+lhpDMPR3IKWQlz6CWz7VZKbb9KYF9McCk/beYABcLn
	U8QG0jZ0TpPdjiETCyvmYTBZmZjz+otgZt7B/Ws7eV/wam3Xq7sfQt5SFgmUarCarV33BBokR/U
	88ddPV7c6SJTk594wMGfvFyd7DTMdTICHnuva4Byux/iulX7Jf0gr7ra1FcRiUKiyHJitaIVY9i
	dH53DE2sZkWwNOBO6X6iTWcqz84SmUtHi0PReX6goeypMFPx9z8sxJuTJMtZYTpzcH+B6jcR2Xq
	UsGLU5ykjLekO1fWeNq3skfeCOuYNCz0mk89lU+4FqbyZLiZzrEyqMFX5D59Ze4qJQFcrSdsqsU
	5
X-Google-Smtp-Source: AGHT+IEo/d0sT2+GuVfJTjb22M3EebSa2FujU4u19dUKVQ6MbBEieg/d2PMPjQP3E4wE3WVizUIQfQ==
X-Received: by 2002:a17:907:9712:b0:ab7:ea47:dee1 with SMTP id a640c23a62f3a-abeeef7508amr565657266b.48.1740599212904;
        Wed, 26 Feb 2025 11:46:52 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2054d58sm384117866b.148.2025.02.26.11.46.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 11:46:52 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abec925a135so22809866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 11:46:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWLPll5HMHDhJBRtvamu6ikjEl6h+ckVp2QAKdMMkarb2MLFSNimSFVwurgDTYn38UjOUC8UqwkwEuQYsU=@vger.kernel.org
X-Received: by 2002:a17:907:c407:b0:ab7:c893:fc80 with SMTP id
 a640c23a62f3a-abeeedd7806mr626760566b.24.1740599211884; Wed, 26 Feb 2025
 11:46:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174051422675.10177.13226545170101706336.tip-bot2@tip-bot2>
 <CAHk-=whfkWMkQOVMCxqcJ6+GWdSZTLcyDUmSRCVHV4BtbwDrHA@mail.gmail.com>
 <Z76APkysrjgHjgR2@casper.infradead.org> <CAHk-=wj+VBV5kBMfXYNOb+aLt3WJqMKFT0wU=KaV3R12NvN5TA@mail.gmail.com>
 <Z76R6ESSwiYipQVn@casper.infradead.org> <CAHk-=whS1uq_4hEgkZJogv_HMhe_PJ-RyMs6E303_Pa+W0zx0A@mail.gmail.com>
 <Z77zNK7mRdjwILL7@gmail.com>
In-Reply-To: <Z77zNK7mRdjwILL7@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Feb 2025 11:46:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9D2AK01nqOTkgOmHX16RmJBAwixuauaG7vKfhEH7HKA@mail.gmail.com>
X-Gm-Features: AQ5f1Jrk6XsYr3MaK4Awbj7yu4VkLzSx6BA6s2x3ZGWN9f_Hpcj1UKc3WhiiBro
Message-ID: <CAHk-=wj9D2AK01nqOTkgOmHX16RmJBAwixuauaG7vKfhEH7HKA@mail.gmail.com>
Subject: Re: [tip: x86/mm] x86/mm: Clear _PAGE_DIRTY when we clear _PAGE_RW
To: Ingo Molnar <mingo@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, kernel test robot <oliver.sang@intel.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Feb 2025 at 02:56, Ingo Molnar <mingo@kernel.org> wrote:
>
> Is this explanation better?

Ack. Just making it clear that it's always kernel pages, never a user
address range makes it fine in my book,

       Linus

