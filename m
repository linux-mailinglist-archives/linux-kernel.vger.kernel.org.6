Return-Path: <linux-kernel+bounces-418713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C309D64A1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 20:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0F05B22F74
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 19:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111CE1DF26F;
	Fri, 22 Nov 2024 19:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aP/TVxHJ"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C0A42056
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 19:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732304137; cv=none; b=lea8Ci36tc4r9VwnXPAi1RwKLupTidE3dpTSH7ZZ114hrWDhI43UuRv9lgM4oaS/2SSflh9PdN9L/4M/S7xDhQHLuTO7WFtMusZeRyQAM/l3qAt+gZw0TFBcX4sqgzdHEq9jVXx6o8VXUyNoFjCtSpVENe8wMXghgzsN04WQWAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732304137; c=relaxed/simple;
	bh=aNEfXdOynvBqg4GC/o7iixGePkGB14enqJPLITepxz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/plXzP3QiaLEPwvvatKp5vvb3gDCyMqfiCfp4g9odWtnc7hj91ZJhDW4mlARmzsbFB4VCUtM0PoPmqHjxXudyxaFewDJCesRC+JQrA6L+V8puRtjtb1QqeAhnwyeqW5qLUd9bJIYESE0yHJq/Fg9l7HCms5p5SguvVC7fgQ8AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aP/TVxHJ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9e8522c10bso410056566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732304133; x=1732908933; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CcjD4yZx4glck5lWdZ00sfDwzVjZ7spLStaLiCSqhPQ=;
        b=aP/TVxHJZaK9+sb6wjdeVtV9oO3OgoQH/2lQG8RBMBJ06yj39wuYZATYP+4bg5M55L
         AggxfErJbozW0DFi7eHRfLifLpQVLAkJkF6j/EUr2CQmJInIMpFXgy+r8NMWArYaBA8I
         HbvVKV4kj0bWk1brv9JvDH2SteKrDF3kln/UU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732304133; x=1732908933;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CcjD4yZx4glck5lWdZ00sfDwzVjZ7spLStaLiCSqhPQ=;
        b=o3fvFFoi9s4Z924nG8OaGewv4FxdwZAz6JBUz1mA9JcIAcrapkhwZF3/doK4NdOM0v
         pmnsAyw5kaQgfvWk2d9OClIahJnxH+luP5GBgs3/z5Tv6fkPfXJZTQJfkraLDHK/yA61
         dR5elPV7H/f8Ve+2Gn61Rn7g1HESBxpl/tquNy/Y/7nKHkTBGYPyH/9X7f0NDjzB8d5d
         gfIL7qr2lvhf+82aNUYNcpf6Gho9Jl7Dgi5HkmFzFhBSp0utCWgGzrL8pVBh3pujKL3x
         vYVxssg2ITBVDx6ReYz5lori0JBMTD0L1GPa54Wrq9nma5yOtWlIiRo02m8ZTsGJcrYC
         UGbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW67PFleHDnhUh+fLTxDrdDahFFA37CzwuCA+6UR1sPGE6fSGCjqb/vwUq3OxoFiRSMWP3CgxAzBu/zbQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnga9+16g0Utf7XHzUXDW8/d9DSr9N/ru3uTgWj0Gew+VWZRq3
	L+iljt5lZ8XRN5G92FSql5FiZcrmGDocjxMUi19VOPu56hXW+e2q0FPN7wNbLm6HA66vqImzt+p
	WOH4fEQ==
X-Gm-Gg: ASbGncutp5TTwjA2zaVrGAXo/RUvTJc5XD4VNJYtRuolUKter7CM3Eg/aikmVFxrffz
	NFw4ygVsdt6sW+/GKXQ9lu2BCR2YqXLSejUMsYiSEYEOCZO3idGCUvTQjrNdjeOa2lBUXaY2O1e
	gE+7aJYJh0VPIR+DC5lL0aIT+K0XGzQx7dwFEBo0KW1vzwC0GGwJuDymmZEDg8t3FcLv6cX3qgV
	coB810zQ5u5/52Se2+57FHjy+TPW3gB5S55xx/pV1zhliJM9jHVXFXjhx+rDigRoXQiXTyWLwZZ
	qw0EYqJuO2aj9GVHIUistG+s
X-Google-Smtp-Source: AGHT+IE8yQCff7YRbtkXShaykCBShEqzubWBQMMjpROs1Y2oR4SxMNgApaqAcyxmvP7ssPvToxJ4+Q==
X-Received: by 2002:a17:906:3293:b0:aa5:c1b:2204 with SMTP id a640c23a62f3a-aa50c1b22b5mr437220766b.8.1732304133603;
        Fri, 22 Nov 2024 11:35:33 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b57bda2sm133242066b.146.2024.11.22.11.35.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 11:35:32 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa4d257eb68so468092766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:35:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUBVcpIzfvHXCiryBxjdPnVgLInxyz8B68t7YcpAy2EnigDcRrZmkB4mB8cUwiaBhynFH1mm795o6g1/kc=@vger.kernel.org
X-Received: by 2002:a17:906:314f:b0:a9e:85f8:2a3a with SMTP id
 a640c23a62f3a-aa509984a5dmr479858666b.2.1732304131589; Fri, 22 Nov 2024
 11:35:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730166635.git.jpoimboe@kernel.org> <82cbb9983fef5ecf6f1cb33661e977172d40a7e6.1730166635.git.jpoimboe@kernel.org>
 <20241029032735.pw3bg64bpneqnfhk@treble.attlocal.net> <76bb85ceeb854e3ab68d87f846515306@AcuMS.aculab.com>
 <20241115230653.hfvzyf3aqqntgp63@jpoimboe> <CAHk-=wgLCzEwa=S4hZFGeOPjix-1_fDrsqR-QLaBcDM-fgkvhw@mail.gmail.com>
 <20241121214011.iiup2fdwsys7hhts@jpoimboe> <CAHk-=wigHm2J4LkUL1=y_H8zGwM0JsK2CrWyLNbz9fvXfbaBQA@mail.gmail.com>
 <20241122001223.t4uywacusrplpefq@jpoimboe> <CAHk-=whm4fEYrzrrRrqEhELLFz2xNCMT9be+J0uiR_EwXwa0DA@mail.gmail.com>
 <20241122031115.5aasuktqrp2sidfj@jpoimboe> <CAHk-=wjJt49tgtmYv42bXU3h0Txb+mQZEOHseahA4EcK6s=BxA@mail.gmail.com>
 <CAHk-=wiL0TepguMNaR65ZdkkiBEoi4hTE7PwG3bBO1c5SOXmWw@mail.gmail.com>
In-Reply-To: <CAHk-=wiL0TepguMNaR65ZdkkiBEoi4hTE7PwG3bBO1c5SOXmWw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Nov 2024 11:35:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj4LHCiD8f75q-jf7mu7Jyn-wHgGoni6WSQtdh7+HtGNw@mail.gmail.com>
Message-ID: <CAHk-=wj4LHCiD8f75q-jf7mu7Jyn-wHgGoni6WSQtdh7+HtGNw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] x86/uaccess: Avoid barrier_nospec() in 64-bit __get_user()
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: David Laight <David.Laight@aculab.com>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Waiman Long <longman@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Mark Rutland <mark.rutland@arm.com>, "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Nov 2024 at 11:13, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I've only compiled it so far, about to actually boot into it.

Looks fine. Sent out a proper patch with commit message etc at

   https://lore.kernel.org/all/20241122193305.7316-1-torvalds@linux-foundation.org/

because it looks good to me. Comments?

                 Linus

