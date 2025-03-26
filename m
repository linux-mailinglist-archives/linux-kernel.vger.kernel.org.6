Return-Path: <linux-kernel+bounces-576368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D882A70E5C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 02:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1509B3BE11F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 01:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63C8219E8;
	Wed, 26 Mar 2025 01:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OlO6/1uD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3D033F9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 01:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742951822; cv=none; b=Z/UNG0h8qgIGfwIMbXZuzA2n9n5F29ulu81poegV5A+blhrzBnvWD6tsN2dvCa4bsZSYAx9CHSWZA6AAUrBJastusf6vkfk0Re83zG258SDDOw7yzL+Ooo8ekx6EbamYxYIQH4Om5QYQbotfez3ybdguxyt+HNW2kCTqCjHZhJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742951822; c=relaxed/simple;
	bh=I347xExCknbwK1WwqfjpybWj/SDT8xZUML+3r1GY8xw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oH1IGrSFlPxf8WEvqtlCLrBY4pw7A4P3sjjKG2WD6gn383Mg5zRbpdpf3M2Bgj3I1FRZaFla8OvJ6XHywLwbZQqLcpW51JNGlpBoaRK2hp0+8Onvp9Lkr9IgRJP/yslibnjH7nRGLR/4Jksr5hDHIxgLAj3FMIBIL2JGY9BMtTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OlO6/1uD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742951819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VtsoN8EDTTOJU5HgLXs5HycSeqen7K6iRMRpAvz6dyU=;
	b=OlO6/1uD/aWZ3Mo0BGOAg+CfUZbQ1PscZQ/HT1qaXVMnNhvo5cNzuaOP+PI25buiSv9Sk4
	ZA2fdRuWUM7+vldDgu0/+zGFAlpFCTZ/nr9RyqVbz9oBELSlELoHHy8l3C0aTQXDwI7/Wm
	NLBLCMrTBzFglyMeYJdPsNjMByiJQvk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-pVcmRWVgPECkP6tSzhafpw-1; Tue, 25 Mar 2025 21:16:57 -0400
X-MC-Unique: pVcmRWVgPECkP6tSzhafpw-1
X-Mimecast-MFC-AGG-ID: pVcmRWVgPECkP6tSzhafpw_1742951817
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e8f99a9524so183290906d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 18:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742951817; x=1743556617;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VtsoN8EDTTOJU5HgLXs5HycSeqen7K6iRMRpAvz6dyU=;
        b=o9QYow4a1/g4IkD41VUQjctBbvOrnlOAmBgma+B6HmCbJl3AoxnrBtHSnV+FMRnFnR
         TJspL+cjGyduvSJFLorb03ePTm74qL/YLyA7SVmnO5buFaKBXLsNZxQhU6rXEkswBukE
         aAopVxWxV7XOL9sinnLDL48xkLNu4zRq2+Za4eIY0D73RSYleVvEKgUtuteJGug4P7+1
         RvpxZXBBKetX0UocuEiwqcpRNwYvYuRhsnQ5lpVluoMxZaBlZigLYUN1jy5Tw7xxbjsy
         FtbsxqcJ0lFB2wZBSu0TDwH9Ur5cvfr54CM+/m1IlQiFg4pec5G+DBtyvIAIaVV5TPCO
         Lh+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVafGCjAKYcu2n3KWoEvb1xOZNT7IKeyXPpN/l6IBd+jEfLjzXruVNCL2S6bcBenohiTopQUitmcqwdflU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0oymXdZRMwJe0Nyjw+RthzSYOZvO7lq91hkpd0V9Z9ByVd059
	3G3WxmRpDjCp2SQig+ZhKoDK5AeiDjROljsI2ro5hoRsDdyekV7PQJ2kqiHmqzUav3/vEdXW/Hz
	Nagu6vA5ToguXs0JAHHnFycGD0lNxctYPVfgKkzpg8ZsM1R3Gj88hmEx2ZEGg
X-Gm-Gg: ASbGncuGwUsJIeNS5oSJt4WS32+e1AGPFvhe54SkLCBoMHVzNnvyWKL7i4GCRPF8zNZ
	QOkfP4QpwKSqPouoiqDspc1cPOUfqrM8w82QCJ6DJwSTaL8rTWTuztkdQkkj22PbSKKjlZTtDIR
	txSs9cd33YvEJxuL5HWIsBls8TyxHhmqg/tCvEauIRBzvK0V4aFgfW5iGnlT51Vn03q3N98Llj9
	FoV4gCdVljiY1TaV0pQ9aq3uJO69YrVfu26IlyVfNK4c5YfwITsOTwTOXTpw6h8G5JP+xwV05JL
	p2fQycgXAu6gCDW4yw5yMjHrVn2HMAYXPUf2
X-Received: by 2002:a05:6214:e8f:b0:6d4:25c4:e775 with SMTP id 6a1803df08f44-6eb3f2e6b0fmr349284776d6.15.1742951816766;
        Tue, 25 Mar 2025 18:16:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvsfn2r1AiZMX09SfJrKIqy2FC/7pO0yvZpolQSNnvLEQAd2meDrR5S3GfrYKTB4/t/HC/iw==
X-Received: by 2002:a05:6214:e8f:b0:6d4:25c4:e775 with SMTP id 6a1803df08f44-6eb3f2e6b0fmr349284406d6.15.1742951816285;
        Tue, 25 Mar 2025 18:16:56 -0700 (PDT)
Received: from omnibook.happyassassin.net ([2001:569:7cd5:ea00:c6fc:c4e9:3726:7db0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef0ed51sm62108886d6.6.2025.03.25.18.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 18:16:55 -0700 (PDT)
Message-ID: <89748fc85c6ca477f64e1a5cc1852e74c68b493c.camel@redhat.com>
Subject: Re: [PATCH] powerpc64/ftrace: fix module loading without patchable
 function entries
From: Adam Williamson <awilliam@redhat.com>
To: Naveen N Rao <naveen@kernel.org>, Anthony Iliopoulos <ailiop@suse.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	jforbes@redhat.com, kevin@scrye.com
Date: Tue, 25 Mar 2025 18:16:53 -0700
In-Reply-To: <wlscshbqan2svtqkz5xc6v47tzndfnsvge7h4lbfn67zoplekl@elt2oxwhrp6f>
References: <20250204231821.39140-1-ailiop@suse.com>
	 <wlscshbqan2svtqkz5xc6v47tzndfnsvge7h4lbfn67zoplekl@elt2oxwhrp6f>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41app1) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-13 at 22:29 +0530, Naveen N Rao wrote:
> On Wed, Feb 05, 2025 at 12:18:21AM +0100, Anthony Iliopoulos wrote:
> > get_stubs_size assumes that there must always be at least one patchable
> > function entry, which is not always the case (modules that export data
> > but no code), otherwise it returns -ENOEXEC and thus the section header
> > sh_size is set to that value. During module_memory_alloc() the size is
> > passed to execmem_alloc() after being page-aligned and thus set to zero
> > which will cause it to fail the allocation (and thus module loading) as
> > __vmalloc_node_range() checks for zero-sized allocs and returns null:
> >=20
> > [  115.466896] module_64: cast_common: doesn't contain __patchable_func=
tion_entries.
> > [  115.469189] ------------[ cut here ]------------
> > [  115.469496] WARNING: CPU: 0 PID: 274 at mm/vmalloc.c:3778 __vmalloc_=
node_range_noprof+0x8b4/0x8f0
> > ...
> > [  115.478574] ---[ end trace 0000000000000000 ]---
> > [  115.479545] execmem: unable to allocate memory
>=20
> Ugh, that's nasty.
>=20
> >=20
> > Fix this by removing the check completely, since it is anyway not
> > helpful to propagate this as an error upwards.
> >=20
> > Fixes: eec37961a56a ("powerpc64/ftrace: Move ftrace sequence out of lin=
e")
> > Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> > ---
> >  arch/powerpc/kernel/module_64.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >=20
>=20
> Thanks for fixing this. It might also be good to add a check in=20
> setup_ftrace_ool_stubs(). Something like this:
>=20
> diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module=
_64.c
> index 34a5aec4908f..c10a9c66cfe3 100644
> --- a/arch/powerpc/kernel/module_64.c
> +++ b/arch/powerpc/kernel/module_64.c
> @@ -1125,6 +1125,10 @@ static int setup_ftrace_ool_stubs(const Elf64_Shdr=
 *sechdrs, unsigned long addr,
>         unsigned int i, total_stubs, num_stubs;
>         struct ppc64_stub_entry *stub;
> =20
> +       /* Bail out early if no traceable functions */
> +       if (!me->arch.ool_stub_count)
> +               return 0;
> +
>         total_stubs =3D sechdrs[me->arch.stubs_section].sh_size / sizeof(=
*stub);
>         num_stubs =3D roundup(me->arch.ool_stub_count * sizeof(struct ftr=
ace_ool_stub),
>                             sizeof(struct ppc64_stub_entry)) / sizeof(str=
uct ppc64_stub_entry);
>=20
>=20
> Regardless of that, for this patch:
> Acked-by: Naveen N Rao (AMD) <naveen@kernel.org>
>=20
>=20
> - Naveen
>=20
Is there anything that can be done to get this bumped along? It
completely breaks networking on Fedora's power9 boxes, as it affects
the i40e module which they use.

Thanks!
--=20
Adam Williamson (he/him/his)
Fedora QA
Fedora Chat: @adamwill:fedora.im | Mastodon: @adamw@fosstodon.org
https://www.happyassassin.net





