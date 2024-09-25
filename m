Return-Path: <linux-kernel+bounces-339322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB0B98634C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E1D28A8C6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B5E156CF;
	Wed, 25 Sep 2024 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bcq5OVh2"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F332941C71
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 15:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276666; cv=none; b=LzoL2ZlDO42lPNQlh/7sHbTc7yMs7FCsQZyD55ZMfYUsgK+0pRDvl+Ln7ppsnZM7zJKqCNXXnoPdzESiv+nILA9uWSZxi5pteSd31Gr/jrkFzDk2WP0u9JhDW8RlvUFoXEnZjx8HcnPUBRJRZJVeqmlScNUwjzPdgJ2tVZNjB8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276666; c=relaxed/simple;
	bh=BZVIfssE/HlkKbYUh4j2gsPekqVebeV1vDele5otCJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+Udxbu4blJDCxo4krNiVZgdGnth0k/VKKygH2ocBBVo4K14+Y+B/sgJV9qGdLNRob4E25jtxLfXk797EfF6Tc5enCiGn34+WYx/c9aBrzzmibfFiXLFP2xFy2efe3IyxJXUcJHmYJS9ba5eRzNVzEUBC4rZufVXUtxvkX3+644=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bcq5OVh2; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d2daa2262so874869766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727276663; x=1727881463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fcm1dYWoLf3Wc6bRnTyM3HuYA6slsWvg941YHjTJgDI=;
        b=bcq5OVh2fgjz6Xm3EKIQSxI4LoNnLWbFAC6on2mCOLs7ETqNEfleDfdX/apt/5W3L3
         X9eQy6bG1UVlS5yQiwp2ClH9//yvSRrL3NQ4SIgYyBdlU9vMsqk5stupQBQNIdb74j4b
         PMWwT2whFhFjvUHaIF10b5tHmdiDbVN8HRBoglIRfVLVMGoudsuuTVMlZo+XM76sNCkc
         DWH2L6FsL41u/bkqVepz5ghDACfmwWEFAn+OkciR64mG5O2n7AlX9z6QulDz3FpyS5lH
         Xwkfy696190q2WYZc4Pphw08fm1YNrYNsSsOBYj49W5+HXnKVBJn6y1lr8ucHhjxE31P
         lekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276663; x=1727881463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fcm1dYWoLf3Wc6bRnTyM3HuYA6slsWvg941YHjTJgDI=;
        b=OeveBx4HEZldVVpKVE7Lm3TgubvsDRjQIcUEswvz9RhLC9p6M7TtDwDw2uV3zxiV92
         TRVJ25VvY+a0sCzupWjqJh+p1sS189mw1BuJoTel7sWoCD6FS6eGfI3i1KWhu2V9N4hR
         kETIW1Mo3mubY4fto7OSzFeUwbKVrS4PXJVFzoQ0YO1xLAKyxbHwTwyKjnlKj5YN2oOi
         oqPgm2VXwbqm4ZY+VVowIG4kxWFH8invSHVYzFpIVLhpZEFMbE3kGvwVxPB3kkxloRVI
         sG+EDIOd4uECE31uGJZdwe3tI9mfDjMvHdQX6ghUdpFK2EdrsF8y58++p08tyqzMahqk
         yvfA==
X-Forwarded-Encrypted: i=1; AJvYcCUPlHK/NfCub8SbH7WJ8zHSUgigdb712nwQTObxupTWW8geKdr/+HtOIeFZqMf5+YffFIXUdE6D9nix/RE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywix5g5fEqXy4W5bjSq37R894STiKraiRYAgD+ng1DXEyrtSbcu
	jgfqUHuOhLzFv4JoIgVzHkzW2rp7hb9BN1cWmxMGZaLA9t+1ImUvb1aLvQFE/Wsbw4xIcFW3m8Y
	jH0cYz3ND/8jF4+cDPA1aC/WFYVRjqfDHQjBMsg==
X-Google-Smtp-Source: AGHT+IEKBETEBbA8oFDZdNCsj+RIgKMhlQG/S1lkwH92vhMzI5tt0OxPYPqW1BlbMTlymXavydaePF4Y5PU6xJJfy1c=
X-Received: by 2002:a17:907:e213:b0:a86:7b71:7b77 with SMTP id
 a640c23a62f3a-a93a05de319mr274196366b.44.1727276661650; Wed, 25 Sep 2024
 08:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925131547.42396-1-luxu.kernel@bytedance.com>
 <20240925131547.42396-2-luxu.kernel@bytedance.com> <20240925-2acd8d9743cf40b999172b40@orel>
 <mvmbk0b7rjz.fsf@suse.de>
In-Reply-To: <mvmbk0b7rjz.fsf@suse.de>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Wed, 25 Sep 2024 23:04:09 +0800
Message-ID: <CAPYmKFs7s4fHBEZCuE92hwVPCTwvUX3864tR5OmgBKkMY57BKg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 1/2] riscv: process: Introduce idle
 thread using Zawrs extension
To: Andreas Schwab <schwab@suse.de>
Cc: Andrew Jones <ajones@ventanamicro.com>, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, andy.chiu@sifive.com, guoren@kernel.org, 
	christoph.muellner@vrull.eu, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, lihangjing@bytedance.com, 
	dengliang.1214@bytedance.com, xieyongji@bytedance.com, 
	chaiwen.cc@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

Thanks a lot for your reply.

On Wed, Sep 25, 2024 at 10:10=E2=80=AFPM Andreas Schwab <schwab@suse.de> wr=
ote:
>
> On Sep 25 2024, Andrew Jones wrote:
>
> > On Wed, Sep 25, 2024 at 09:15:46PM GMT, Xu Lu wrote:
> >> @@ -148,6 +149,21 @@ static inline void wait_for_interrupt(void)
> >>      __asm__ __volatile__ ("wfi");
> >>  }
> >>
> >> +static inline void wrs_nto(unsigned long *addr)
> >> +{
> >> +    int val;
> >> +
> >> +    __asm__ __volatile__(
> >> +#ifdef CONFIG_64BIT
> >> +                    "lr.d %[p], %[v]\n\t"
> >> +#else
> >> +                    "lr.w %[p], %[v]\n\t"
> >> +#endif
> >
> > val is always 32-bit since it's an int. We should always use lr.w.
>
> Shouldn't val be unsigned long like the pointer that is being read?

Yes. As I replied Andrew, the 'int val' is a mistake here. The val can
be an unsigned long (thread_info->flags) when CONFIG_SMP is disabled.
I will update the declaration of val from 'int' to 'unsigned long'.

>
> --
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint =3D 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D=
7
> "And now for something completely different."

Thanks,

Xu Lu.

