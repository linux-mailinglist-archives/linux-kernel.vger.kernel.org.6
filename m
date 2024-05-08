Return-Path: <linux-kernel+bounces-173823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AE08C05FF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4525DB22AEE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63F4131757;
	Wed,  8 May 2024 21:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHk8/VkC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813E0130AC1
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 21:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715202140; cv=none; b=f5vV84Dx8m3qiaLulAvszJHQmoV84P5Izv/WNy+jcACYYScyHwWnHkuRNpIm9+xOS6WIza6C+QMZuNyNqjgbaqGtR+GOHsUU+SV3GC2y4xri1x9G4DAR6RY2qNahJsUX9EHne2esxzpUb/nJfjOwiQbl4iE/B1zZBkaluyhLGew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715202140; c=relaxed/simple;
	bh=6wHGwPkQd/sjB3p8mhsAho/kp3oSLQUTGgVH9tIR0IU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E38olzgXxer4NkyoDLpGURAhgz0avEp+wc7domUnCW6qOR3UXQcp6Oq6+VpVwZzBkfBAgAPDgOgIFfA7Xwkm0fGmCAea5adwp7WOIejeMq3s6E+wKl15VSXirOsViZem7Xia1czkNzw8n58ut5MUEsu1Vpy/pTnp1/1QvPeTlE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PHk8/VkC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715202137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6wHGwPkQd/sjB3p8mhsAho/kp3oSLQUTGgVH9tIR0IU=;
	b=PHk8/VkCgMKuiaIVprulMhpwqrq97QLUJZzb2gTW60b/9XlhTygjx9ma+3DEHz15OzUu91
	oUE6ky/lKau8PX5lNNtT34RT9s5tx8vbpgg/elkscWwhEInmQdThmtishjNkq5irc6Tsgp
	GyKmCq5qZWIux/XuD0NK5lsNks+9vHA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-cxp9QrFSOdOZ6v6Zf18yrg-1; Wed, 08 May 2024 17:02:16 -0400
X-MC-Unique: cxp9QrFSOdOZ6v6Zf18yrg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-78ecda35c73so15833485a.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 14:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715202135; x=1715806935;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wHGwPkQd/sjB3p8mhsAho/kp3oSLQUTGgVH9tIR0IU=;
        b=mDU4YOtvwPf37bcSutl99vHfI4N/1jw6YdzTlS9T6xO+rUQwzRRP+uZ+25E9Iga3FL
         GrLiAZBbHY/7bW8pYkXj2T7f/GCxVZc+3yENv13SJsiyMFmjR8OM9/Xu/RoiOi4UDOey
         PROpGiJh2Ke1Ww34B7fBCcMt9eDOXBuuCflx97bxs2ZMfl7QGh1H7uhgUPr/yr3PISHA
         iP8SjFGLL6B71N3C0mmmryZ9qt4IKG1zjrpoIlP7g4wDceIiwlIfuzxsaI1LSTRHSiqq
         ucaUFyHKL3oe6+RzKO5idUzCILIo25YYXtFc97ZnLD2SSg8MG5GrEpPkYf2QzMvPhVgI
         b+YQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5tHjqqKjry9ZeGRfa0JOvHnc16TWmg4WcR0Sv8GBc32eEJLFaTtxbj7Kuf9m5CsHGhRLzyEjAAC1O7k7hiupSTzlI7dkIrHyFtIoR
X-Gm-Message-State: AOJu0Yw/Bcr2BRG8ZX/CUt6djRZw1l9rZRQgynncHvZAwyiRvVXldp67
	zJPaBI7iQKxj1gImm5Eyj5S8HzXns/HST0S1p3xlE7yGmntgbMgWPrZKsx2sOoCP6iI9jAfAyka
	BYXgQ7s7JaLL5WXwiBDg+CE2NaBBx863X83fce7s72poQ8vWGXyQwhcBJUR/SJA==
X-Received: by 2002:a05:622a:1897:b0:43a:c8ce:4405 with SMTP id d75a77b69052e-43dbf74dc8cmr41127711cf.59.1715202135692;
        Wed, 08 May 2024 14:02:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVCbj2mpjPWcjmm2vAmxtWot+9whE/qHsFWPc3ushMQYr4HJT4MXkm3rZDA5nZdLDi7Fq3wQ==
X-Received: by 2002:a05:622a:1897:b0:43a:c8ce:4405 with SMTP id d75a77b69052e-43dbf74dc8cmr41127471cf.59.1715202135303;
        Wed, 08 May 2024 14:02:15 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c6c:a300:ded4:e2aa:1dec:4d9? ([2600:4040:5c6c:a300:ded4:e2aa:1dec:4d9])
        by smtp.gmail.com with ESMTPSA id gc15-20020a05622a59cf00b00435163abba5sm4888456qtb.94.2024.05.08.14.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 14:02:14 -0700 (PDT)
Message-ID: <ea927dad269cc21de1d0baf3d6c9f66ee025b862.camel@redhat.com>
Subject: Re: Early boot regression from f0551af0213 ("x86/topology: Ignore
 non-present APIC IDs in a present package")
From: Lyude Paul <lyude@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>, "Linux regression tracking
 (Thorsten Leemhuis)" <regressions@leemhuis.info>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Mario Limonciello
	 <mario.limonciello@amd.com>, Borislav Petkov <bp@alien8.de>, Linux kernel
 regressions list <regressions@lists.linux.dev>
Date: Wed, 08 May 2024 17:02:01 -0400
In-Reply-To: <877cg4ppd5.ffs@tglx>
References: <3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com>
	 <20240418082703.GCZiDZVyra7qOQbyqn@fat_crate.local>
	 <fd040809d95b3e12b2fdc78a2409e187716bc66f.camel@redhat.com>
	 <87plumxz4x.ffs@tglx>
	 <abbb7d7ca781f6c664e4c5b1dffc19394ac79691.camel@redhat.com>
	 <87le59vw1y.ffs@tglx>
	 <3a0afe545747e5314a9cb6bbaa9ce90b259ddfac.camel@redhat.com>
	 <87edautcmz.ffs@tglx>
	 <3b1d16e357c1f9badeef405366492f05af26c085.camel@redhat.com>
	 <878r11t8zu.ffs@tglx> <016902d9-3858-4c65-b3ec-f7a5103af63c@amd.com>
	 <51d0dff8-2888-463c-95ab-71b491f12a8f@leemhuis.info> <877cg4ppd5.ffs@tglx>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Yes sorry - I was out of work for a bit but I'm back now and can get
you the info today - thanks for the patience =E2=99=A5

On Wed, 2024-05-08 at 12:30 +0200, Thomas Gleixner wrote:
> On Wed, May 08 2024 at 10:38, Linux regression tracking (Thorsten
> Leemhuis) wrote:
> > H! Lyude, Thomas, what's the status here? From here it looks like
> > we
> > were close to a fix, but then it turned out to be a bad fix -- and
> > afterwards nothing much seems to have happened. Did it fall through
> > the
> > cracks, or was this already fixed and I just missed that?
>=20
> I'm waiting for more data still.
>=20
> Thanks,
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tglx
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat


