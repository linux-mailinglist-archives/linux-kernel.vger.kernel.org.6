Return-Path: <linux-kernel+bounces-418667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176E69D640F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 19:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 909E5B25495
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9A91DF75B;
	Fri, 22 Nov 2024 18:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QK/jj23S"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFFB5FDA7
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732299440; cv=none; b=eYdPTde6ScE+2zY7FjKiOAru3GYqYkF4DfOCpdIf9pUfST5Mtb62xLAa2REma8PWQHO4TC/NQb33VhKE+kiTb4NxFt3SP8CqKlF0yMfqvh61FQF93vZ8BnTnl1eWlAgzEcGFGy2VXEIlYUtH+wsiG86wPzpRcDt/0nVxaCGTwf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732299440; c=relaxed/simple;
	bh=ouQWzbvy4efYb9b4JGMfDHRRXi5lPM/KriKXH79wIPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hY80B4wqlA3B58P/WEb0ENKEorDeto0amjkhle1G3zoVV2CAvwB03jyL0ictZCZ8yeMz11ABkDb+BzUOWVx1SP3kuKaliYGiv0/m2yxMkn/Sx/zAV1WBUlohwa8l26HjlZH4gDVOGMx0Y1H9xV0af3rtxv0t+LjIMcoolpj68NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QK/jj23S; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ff64e5d31bso25797581fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 10:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732299436; x=1732904236; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JgWJuWzzZdWVc2fPTgYPRbiswOFfHlPecfqZMgXkDDM=;
        b=QK/jj23SpmG8l+64F+O5SAnf7YvwUyadFeSetd3nqCYx8j55zsO4bHdEBQmwNfel14
         haXzuN6ieLMJR9Z4znNn/6PzcMGBAVQkAVhkdAJnE+rqIt5b/5z77sXFLYzGi7SGx5ap
         A4vIkRqngHMdNaW1d0cu09DS2olPXpnCKVV4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732299436; x=1732904236;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JgWJuWzzZdWVc2fPTgYPRbiswOFfHlPecfqZMgXkDDM=;
        b=ssngRwqatMwYBSGxCUCR3ej18oVjpvBdF3Fc0Ajl42LK4KtbDGmCfwWoMM9IvXMfuu
         I9hRHkJtDmJDXvoADDVBys6Lj0q29OPzSteJjzeqbx8CBr06Nge5Zii7Ttaz6B42flLm
         VS2TIjURQcFPcAPZzXq275g8xJP63ulUgGnErQEXYtTF0NK+XKIXwnfDADBqSmBS6JQF
         SoFZo0LX0V/9qQT36jAxBhBckuK41jX2xByXHp5kVrNc+ZnW3tbxCmtVRxR7Hz5foyjZ
         ndXEu8kdO05dRM4tgP+aGYItc89ngS0hscib74G+tjyhRwxSlVqzd5YcE1NFdsFoBQ+2
         BRGw==
X-Forwarded-Encrypted: i=1; AJvYcCV7cnQTVBF+U3o2GFc4BfnS6ExMrxNGm6sxB+Zspc6CROpsbHu0i6TJDRXLetYhGM2Dei5Qoe1xtQ043Mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPgmPdqkjWYR+F7uTyiFwx9r2ThuKxsPRw935MpLvhF9A7uM0n
	5q7Fnv0k4QFxrjM96n7OXTrMtQcIl9PrC9KKQcmd9KhKKfIScYvzaKkBUk7gPxVNfhYW2CjZyHb
	D0mROgw==
X-Gm-Gg: ASbGncv1DrvfikRcMHgLGFNnu9AIYhDEtPv446rzkAyQgKOHbEeMJt56enyb7+yrscH
	kqcTDkbse6Tz4zSSFDgpa7L7gx3KLz6Onz+85QpexZrFqeEXzoYOEGXfPWtZHTajt0D70iFGd0k
	3NzbdJlYwtfrPanMkvYiA3/HzPd7WVilNu9NIAs+5WRTQB7pKzw9KmWvfug2kSo4aQnLsgfP3P1
	4stMPs4Kt8qlOlMBvVNfjveWgZpEdPGC+ech/hw3oJzoOdTye7vN//O9WTV9XdRhzLeQZMfy2Y7
	j6FR1JxleKScVppqYOjIdSTS
X-Google-Smtp-Source: AGHT+IFvZyz41fRLqSI+9P8WfI4MmYh7jmsAfD1T+jdjWKlmZ1j0yGD/0+NrqApT9nbRge5e853irg==
X-Received: by 2002:a05:651c:1145:b0:2fb:5014:c963 with SMTP id 38308e7fff4ca-2ffa7123f4fmr23598821fa.20.1732299435977;
        Fri, 22 Nov 2024 10:17:15 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffa538f922sm4308061fa.114.2024.11.22.10.17.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 10:17:14 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53da24e9673so2666838e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 10:17:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXDu4IoJWEoMInpimsBTruLvue9f+bTrnNBqGfsuPkuBuOJMkFdg8BRZIxB5cuVgIM6Ggv58DDMLY+mY7Y=@vger.kernel.org
X-Received: by 2002:a05:6512:12c2:b0:53d:d589:a8b7 with SMTP id
 2adb3069b0e04-53dd589a95dmr2151598e87.54.1732299434382; Fri, 22 Nov 2024
 10:17:14 -0800 (PST)
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
 <ab5cdb9b-227b-473b-ae39-6b4969506a5e@csgroup.eu>
In-Reply-To: <ab5cdb9b-227b-473b-ae39-6b4969506a5e@csgroup.eu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Nov 2024 10:16:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh0tnmhigqc=2wN-0OtdLhJU-9eYXgpFgbOR6eKrsh75A@mail.gmail.com>
Message-ID: <CAHk-=wh0tnmhigqc=2wN-0OtdLhJU-9eYXgpFgbOR6eKrsh75A@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] x86/uaccess: Avoid barrier_nospec() in 64-bit __get_user()
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, David Laight <David.Laight@aculab.com>, 
	"x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Waiman Long <longman@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Mark Rutland <mark.rutland@arm.com>, "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Nov 2024 at 01:20, Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> On powerpc for this kind of stuff I have been using do { } while (0);
> with a break; in the middle, see for instance __put_user() or
> __get_user_size_allowed() in arch/powerpc/include/asm/uaccess.h

Oh, that's indeed a nicer syntax. I'll try to keep that in mind for
next time I come up with disgusting macros (although as mentioned, in
this case I think we're better off not playing that particular game at
all).

                Linus

