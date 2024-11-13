Return-Path: <linux-kernel+bounces-407759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CF69C734A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2906028383B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793111FF610;
	Wed, 13 Nov 2024 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pqIg5PW5"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A03A42AA6
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507369; cv=none; b=efJUfJY1ACC3II82sZjmJ+QRk2pBKm3ppGL948kEijzWiG0r/ll8yFpKvxlEDQVpItqztePrKWWJNgTnJDfTNm4Ip8s84l5gJkCznUZY+ipG1xQ7i/T9doHd8FWsl3iqu4elbGRZSZ/79svw7eXo6Fgd/ia+FCtMZLrFoYh+rV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507369; c=relaxed/simple;
	bh=h1p+RM3SP1E+VI4k4N2fmIe3tAbEk6nbq9ofh7XH1Jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1lzXqdsHLiLRat/G2XMdVQY8yHOeeZczJPKTpi1dIFRbHgYFk7R5Q4VP9FsaNezWPtQO1+NCBuqmpYvWm6qy+S5zZDMdd3ReYQW79VPrDW8VaLn6adiMq5jd5MxxLEsKM+TCCDUr3qjmdFJCy3CknZN1n5MBm3+v+9bo2pQbTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pqIg5PW5; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-460a8d1a9b7so231471cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 06:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731507367; x=1732112167; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zgiz6C5yZ9mnghdgDe/8YS2/TCoL+eiQ+f+7PRO+xiY=;
        b=pqIg5PW5I1JIm9GZO0fdMzsRcwBBX2LgHn2Sk51QWxl5tkFOgAkKEnercO5J53uLw5
         +Mh/yGFu3KAcy0OTHxbVN4Ch+tx4I+R8p0wgoAs6TfWRy4ILgs6Nhanv1E9jjO25ws6b
         k8k3pMHED7GE6hRHEsvVfnD4WmQYwmU0eDct7G7W6aurBuWe+Qsa3P3CcWjsubvTuYa2
         PbpGDU0Tjl6R2kjByIa64R9iJVhvOoPjAq4SnOWrfrrzYkImrIFDbyWul9o2At8n2SSL
         O7Ti4Wcjm6hLta+/eMgjaYufF5G/QR03ZWCyu0+0yLzBnFfCah2Tpi4+WMyqYDji2DRt
         H6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731507367; x=1732112167;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zgiz6C5yZ9mnghdgDe/8YS2/TCoL+eiQ+f+7PRO+xiY=;
        b=FRNxJB73K8h58MimU3BrUzm5j7N2m3Iu+n5eJqUGIdkv2yOPC8HALBQ5XI4A2WgCuX
         dWr1ewU1KxniRW6iCX4AG7u+xfCzvhnTOOU60RtDtPGd8ylPYyXDVRX/2QM0DCAkARyV
         jfJ+YCuvec26aT4PMUk3AdXrt3BB8yAqwtxnUOUeNp3xFxo3z8LoSMIp/0L8wlx/tuu1
         SIPmeAL8x61cs0+KWtqGkZYUMWoi1ewwJD5lI9Aibu4aFE/Cf9VYVjOTBC4UxJNfwFJK
         G5M3ql2Azla7pX4bxrxHrw5MYi4vN/pC+rzpe53OSPbAb3XapaFRq5CyR10ROb6IwzCY
         5DOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXizstLKO8JWwEK2DOCogsAJLWBp4YnEQli/Uwjqs+KunNgWTqih7wCDz41iUGoXaJBYmwdN6N6aCmOlWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBhN5gUiZSc1z4/swsHR38NWcP5D6pMlYz03jxghTYMIREyvK/
	U8187xkiGbUuB6uGJkvDDqWXgh0AeJZkJYNWU/R2X/BVWDZANnLjuYaovAXx7bXfEQWjO3X+oPl
	AhVh5+Q2mi9RXeFDP4TPAveL9wHGOjWSY0qp/
X-Gm-Gg: ASbGncvcEyBw9ME8sBWMqkr9P0VocqdWM1+Q0+XWueu06ajcs12x/C7wTTEFVcMovPa
	w0+ilVvJDCGvuHu1DHJbZTRzY6Opl1m8bdj8wGYpfFROPzuYPMfC0oIRH937QGuZ+
X-Google-Smtp-Source: AGHT+IE6jN+rOYYtzDt928l9MTTLd/kCwTo6A+58XQAD0EPLKXhJwAUO/WmSS7UTZ8cIhbmiLZKmf6Hwtl7nkiM1Qxc=
X-Received: by 2002:a05:622a:5b96:b0:461:32e9:c5ee with SMTP id
 d75a77b69052e-4634bab8f7bmr3577881cf.0.1731507367001; Wed, 13 Nov 2024
 06:16:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <LV3PR12MB92658EA6CCF18F90DAAA168394532@LV3PR12MB9265.namprd12.prod.outlook.com>
 <f3ddabdc-39fa-45fa-97fd-d8508c2229c9@amazon.com>
In-Reply-To: <f3ddabdc-39fa-45fa-97fd-d8508c2229c9@amazon.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Wed, 13 Nov 2024 15:15:56 +0100
Message-ID: <CA+i-1C1zN_GcLagTRgfJqT6uFoZaMZj1NUfxkvP7eG=VGQ0GGQ@mail.gmail.com>
Subject: Re: [PATCH v2 19/35] Documentation/x86: Document the new attack
 vector controls
To: "Manwaring, Derek" <derekmn@amazon.com>
Cc: david.kaplan@amd.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	hpa@zytor.com, jpoimboe@kernel.org, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, pawan.kumar.gupta@linux.intel.com, peterz@infradead.org, 
	tglx@linutronix.de, x86@kernel.org, mlipp@amazon.at, canellac@amazon.at
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Nov 2024 at 04:58, Manwaring, Derek <derekmn@amazon.com> wrote:
> > I'm nervous about only doing the end-use controls and not the attack
> > vector controls because of the reasons outlined above.  For example, I'm
> > thinking about some proposed technologies such as KVM Address Space
> > Isolation which may go a long way to reducing the risk of guest->host
> > attacks but may not be fully secure yet (where the kernel would feel
> > comfortable disabling a bunch of guest->host protections automatically).
> > With attack vector-level controls, it would be easier to turn off
> > guest->host protection if the admin is comfortable with this technology,
> > but still leaving the (almost certainly needed) guest->guest protections
> > in place.
>
> Personally I wouldn't put too much weight on the possibility of
> disabling kernel mitigations with these future approaches. For what
> we're looking at with direct map removal, I would still keep kernel
> mitigations on unless we really needed one off. Brendan, I know you were
> looking at this differently though for ASI. What are your thoughts?

Yeah, personally my vision for ASI is more than it _is_ the
guest_host/guest_user mitigation and for the RFCv2 (long-awaited,
sorry) it will be the user_user/user_kernel mitigation too. If we
decide we wanna keep existing mitigations in place once ASI is at full
strength then ASI mostly failed. (Or perhaps to be more charitable to
ASI's strategic prospects, I'd feel OK if people said "I want ASI, but
I'll keep the old mitigations for defence-in-depth" as long as we
usually don't need to develop _new_ mitigations for those people).

So rather than saying "I have ASI, I can turn guest->host mitigation
off", you say "I have ASI, guest->host mitigation is very cheap, let's
have some champagne". In the utopian champagne future only very
advanced users will have any interest in more fine-grained questions
than "do I trust my KVM guests".

I guess another way to look at that is: the distinction in these pairs
of attack vectors is quite subtle. The fact that we are even
considering exposing users to that awkward subtle distinction
highlights a weakness of Linux's current mitigation posture and I
think ASI reduces that weakness. The weakness is: the cost of
mitigating attack vectors doesn't line up very well with the degree of
threat they present. We think it's kinda tricky in practice to steal
interesting data just by going into the kernel, but it's probably
possible, so we have to pay mitigation costs every time we go into the
kernel. Relatively low risk, relatively high cost. So we're having to
say to the user "do you wanna pay that high cost for this low risk? We
can't tell you how low it is though, we can only start rambling
incomprehensibly about something called the 'fizz map'".

At first I wanted to say the same thing about your work to remove
stuff from the direct map. Basically that's about architecting
ourselves towards a world where the "guest->kernel" attack vector just
isn't meaningful, right?

