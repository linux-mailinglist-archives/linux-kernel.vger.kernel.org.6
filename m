Return-Path: <linux-kernel+bounces-570124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 917EEA6AC7F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D36897A96CB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E005B225785;
	Thu, 20 Mar 2025 17:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZpLxPUGQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD2F1E3772
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 17:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493106; cv=none; b=obEz1E/vd4TH+yzXsrS4KO559ivQLY/wsrTNkZPwsnOCGsvouOmHE4P1xZUOyAyu7anBGxbjjot52QfRowiFhdRLSJPhbqXdJnLB2YLaZPozF6V61L2KExMVY9DsuVU2fhKPPL+OitMTnduBYXQv8GpkzWHejvgjtSDzdLcirkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493106; c=relaxed/simple;
	bh=o3IlYx76HOgpmwJ7LeWs1lixNyawhNbK5voIxjk1x+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hW6bIXKeY/fiEM09wc/gbYt9Bdqcg+JpaBr0wfgQ/Apx0T987H5cy1tFQo3ZlFs1tQGqxHw+137JDjPE0rODzOSz9Y/nKSFrBlNW2YyaFoMB+0ZeCZSIBdSSrUByVwBa4ywbkKbHV8AsEAbJwMIXpYTu0oQHnDoTfbnOOBCZjEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZpLxPUGQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742493103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uXWecX/ChUMrHEl0iHMIjPpjyDBN/50l9D648Ab1UDM=;
	b=ZpLxPUGQMjwCQol9XP2FndtsZTR0hRXccuGHPC3CUTfIe4rtrClDitx1kz749qCIXR9b20
	36QzvnfsRzWxVZ6O1nRPUYO8iVzKN8KWDwfDNHIFmVnvDaTc91yuVmAvCLYGCek9Ul4ZPM
	Uxj8JS2+AYGcQghg9v476yYXPKWwwwI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-5mH7QcJjPdmnTf74Mzl8Pw-1; Thu, 20 Mar 2025 13:51:42 -0400
X-MC-Unique: 5mH7QcJjPdmnTf74Mzl8Pw-1
X-Mimecast-MFC-AGG-ID: 5mH7QcJjPdmnTf74Mzl8Pw_1742493101
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-30c4168ffd8so5363151fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742493100; x=1743097900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXWecX/ChUMrHEl0iHMIjPpjyDBN/50l9D648Ab1UDM=;
        b=GYCvja+6hNAseiqZlievX/9kJfbVsMZCXJ9LZhajgk9V9rGfjFP/F/ebg6s66J9pvs
         Bh8J3EPFUkDoOiB8sWbk/z+G7waFwxCokOk3JpcnxOvRC2KoajC/A3XIEoMyhUKcwTqf
         0hEPsK2xYClM00xr0pSbRQoWPPBfQ0fpe/oRFpkoxN5rvfYOJi+g1as/uaDorIexp/AG
         Y/wR0PXZBgDf44pN9NCjIjwaD1dUkndFNPLf3+Ly1ZNjOPJgYCuEgXhTQTCREQDfTTUx
         Gcwioamy9uCCjTXzxQPoma24IqC8qGpkttq6cGYjRH9AKnyYy42coO0W4uh4zQRD8Vi1
         C4aw==
X-Forwarded-Encrypted: i=1; AJvYcCXDYDBe9G2FZDME2chWd6HWyfnXRIOaFdmTFk4mQSotQK1WyanOsHjL7lHVUnxy1Y1FDLfltpm8pOMBbTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+vlFekxWGTy+Nv0+RLknU+OlA9Wl4l9zzjAeAXrXwp/F1kLCC
	Eg6orLEo5oaNoOOtun19vmfXgp3+k/08RNfe3jUPsYS6Eo8KJ6YqFTVzXPGfWp4TSE4+YP5Ww5U
	tf+ogf343ycfWNPxnDzE1iNz71uWRKxVbGgB6RZG46/BbosRUzSCcHRWRh1mBVN8xVsE4O+En+P
	JQvebniw1YMbDv1raH5ANEkgEjyya0AouqPx5E
X-Gm-Gg: ASbGncvqtWCyueHx+j0htyW+mQYQgH35qMG6Nwp6TZ1Oii5BRB/Sgu6cgJHgMAB85do
	3uHpyR1YvbRGGOxKkbX2xz6JubYXjMCP79BCOhaC2xuH9ZdQ4HmT3VwAT2JQXFl7nKmo09b/Vcf
	88hYCLlIE2CYCpHHnvxR7SwuJdMB55+w==
X-Received: by 2002:a2e:a497:0:b0:300:26bc:4311 with SMTP id 38308e7fff4ca-30d7e234f7bmr411891fa.18.1742493100556;
        Thu, 20 Mar 2025 10:51:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoehJsKrm/dYmfCqdPRI2fiZQshKjn2OS3nSgLkRrg4hCl9cZ0HsbWP8PEwLNvXMLrKhVVcm8w0Lg8vLShpEE=
X-Received: by 2002:a2e:a497:0:b0:300:26bc:4311 with SMTP id
 38308e7fff4ca-30d7e234f7bmr411861fa.18.1742493100135; Thu, 20 Mar 2025
 10:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320142213.2623518-1-herton@redhat.com> <CAGudoHGr6y-WQY9CZ7mppeX87cgN0dG07ivK+MaoUow3ymArDw@mail.gmail.com>
In-Reply-To: <CAGudoHGr6y-WQY9CZ7mppeX87cgN0dG07ivK+MaoUow3ymArDw@mail.gmail.com>
From: Herton Krzesinski <hkrzesin@redhat.com>
Date: Thu, 20 Mar 2025 14:51:28 -0300
X-Gm-Features: AQ5f1Jrvf8ECBnNSg5qz7YeGkKG--UNA8VGcL-rn56hHgHP1D06T1rEXRpt4njs
Message-ID: <CAJmZWFFyvqivwSMGA-T2HnOTr1GtYAvvWVZ8YuASC+cfSsB42w@mail.gmail.com>
Subject: Re: [PATCH] x86: write aligned to 8 bytes in copy_user_generic (when
 without FSRM/ERMS)
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, olichtne@redhat.com, atomasov@redhat.com, 
	aokuliar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 11:36=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
>
> On Thu, Mar 20, 2025 at 3:22=E2=80=AFPM Herton R. Krzesinski <herton@redh=
at.com> wrote:
> > diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
> > index fc9fb5d06174..b8f74d80f35c 100644
> > --- a/arch/x86/lib/copy_user_64.S
> > +++ b/arch/x86/lib/copy_user_64.S
> > @@ -74,6 +74,24 @@ SYM_FUNC_START(rep_movs_alternative)
> >         _ASM_EXTABLE_UA( 0b, 1b)
> >
> >  .Llarge_movsq:
> > +       /* Do the first possibly unaligned word */
> > +0:     movq (%rsi),%rax
> > +1:     movq %rax,(%rdi)
> > +
> > +       _ASM_EXTABLE_UA( 0b, .Lcopy_user_tail)
> > +       _ASM_EXTABLE_UA( 1b, .Lcopy_user_tail)
> > +
> > +       /* What would be the offset to the aligned destination? */
> > +       leaq 8(%rdi),%rax
> > +       andq $-8,%rax
> > +       subq %rdi,%rax
> > +
> > +       /* .. and update pointers and count to match */
> > +       addq %rax,%rdi
> > +       addq %rax,%rsi
> > +       subq %rax,%rcx
> > +
> > +       /* make %rcx contain the number of words, %rax the remainder */
> >         movq %rcx,%rax
> >         shrq $3,%rcx
> >         andl $7,%eax
>
> The patch looks fine to me, but there is more to do if you are up for it.
>
> It was quite some time since I last seriously played with the area and
> I don't remember all the details, on top of that realities of uarchs
> probably improved.
>
> That said, have you experimented with aligning the target to 16 bytes
> or more bytes?

Yes I tried to do 32-byte write aligned on an old Xeon (Sandy Bridge based)
and got no improvement at least in the specific benchmark I'm doing here.
Also after your question here I tried 16-byte/32-byte on the AMD cpu as
well and got no difference from the 8-byte alignment, same bench as well.
I tried to do 8-byte alignment for the ERMS case on Intel and got no
difference on the systems I tested. I'm not saying it may not improve in
some other case, just that in my specific testing I couldn't tell/measure
any improvement.

>
> Moreover, I have some recollection that there were uarchs with ERMS
> which also liked the target to be aligned -- as in perhaps this should
> be done regardless of FSRM?

Where I tested I didn't see improvements but may be there is some case,
but I didn't have any.

>
> And most importantly memset, memcpy and clear_user would all use a
> revamp and they are missing rep handling for bigger sizes (I verified
> they *do* show up). Not only that, but memcpy uses overlapping stores
> while memset just loops over stuff.
>
> I intended to sort it out long time ago and maybe will find some time
> now that I got reminded of it, but I would be deligthed if it got
> picked up.
>
> Hacking this up is just some screwing around, the real time consuming
> part is the benchmarking so I completely understand if you are not
> interested.

Yes, the most time you spend is on benchmarking. May be later I could
try to take a look but will not put any promises on it.

>
> --
> Mateusz Guzik <mjguzik gmail.com>
>


