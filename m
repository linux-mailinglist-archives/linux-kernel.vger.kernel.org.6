Return-Path: <linux-kernel+bounces-574244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49218A6E280
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286D216D502
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2C6264F8B;
	Mon, 24 Mar 2025 18:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oj1/eodQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC70A86334
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 18:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742841389; cv=none; b=sBm1qn28MrJPa2ZFfKv0lgrwp64YUUs1Qp/EcMHakY/wdaDEx6SrBaZpbBNJDOLld0qZ7j819woJurDMbmY6y/h7n2z/W4EkX9xTNPoFT7fV39fpiJdzNhiBHOBSg7aQpZLCBgi8yOY1DKXk+F2jE9bOFy/zfGsxKXnEWCAL80I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742841389; c=relaxed/simple;
	bh=hXOiHIS3DvlLQB4GyNTDafew3mKtY+pMoL7kwsNiNTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qpauc9vV2PCh8n7CbjWpAdygRwe6cPD+t3WwaQXSscDz5SERd+7WfSWYG34rQamNIL2ymr7I+AC620EhLTH34KHer+fV55LstL5Sg2KXCaY0UBJ5HNycBUwvv8EKSLgsTmJX28rbzt6PemdMi8oBYZF1P1ZLGmYagafnFhvJRjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oj1/eodQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742841386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hXOiHIS3DvlLQB4GyNTDafew3mKtY+pMoL7kwsNiNTo=;
	b=Oj1/eodQrQpLF+8MzhyVHuGViZ3LpLiMef3/I77RTXyWI2MOec6hQwRu6Y2lOE9ez74tST
	su7A28Iu11Va0iFGVs6PkC/JfmN9X5ZUef4JOrXD5sBPzDGxkkKk3+n8QzTiqnIUl8zgwv
	Li40h8jhG4idMgV5u8E5f7gj1fAUH9o=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-sxzq2K_FOl-e0Iu72Gr-Bg-1; Mon, 24 Mar 2025 14:35:17 -0400
X-MC-Unique: sxzq2K_FOl-e0Iu72Gr-Bg-1
X-Mimecast-MFC-AGG-ID: sxzq2K_FOl-e0Iu72Gr-Bg_1742841317
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e691efc9bb0so109343276.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742841317; x=1743446117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXOiHIS3DvlLQB4GyNTDafew3mKtY+pMoL7kwsNiNTo=;
        b=u+bvn8T9KpYRWglLwPuSagN72y31+oN+6PIH9exthaBUrVfQBakIzARt0DlD/bG2yE
         HpKsiooDdSNQsc6Q4bKLsMubewP1s9r8KCpGq69yGcBZlN99jotTCaukF/fG+emWLWLF
         yR9xKtwbPLZriFJgYO3RpcOMjs4QoH7TlZLGlIcW5LTYcYPHVAasOx+Ntoh5IjfqFzgR
         oFTJDMqyqLg31Vs+N0dlugIhsnxwaBLhtuJDleA/5BQpfJWLN1qU96FQCebQx0MosqI4
         nhbji1c/tSUjyDP2luLBvfpql05bcJj4l+W9orPtK3IqvQSBy5evpiaCnjdKWhoEW9VL
         RPWg==
X-Forwarded-Encrypted: i=1; AJvYcCVev5+u0enhqWoM0l22CxFxsCXMbVbuen6H6GPginCKNPjASJ7nI4RAw9jfg4iOlbbeKHQgyETlEFipe8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7WjJBj/tOgCenOcvKe0BL511g/qMIpZyWp0xq0ZLqvv2DxqWD
	54JPWdpUXEGyvqlzpLpIIOvhCP8wB4ySr0xvhZZl/q9f+jQcWaLAEP12XoJWs3XKbGAwbLxHWWm
	9AObh+xWsEhYLhuVEz0cnY1LAcmEbqAN6bPRzDJl2KSJu4j19ETRo03YKu/aynzQOs4Mccumys8
	Puv2y46St++WDmhVNv3RMRN1n/MierVoMAW3vP
X-Gm-Gg: ASbGncsgyJHhxp5bdbraj91OYSEkdyPYdqIMSudoR2PtisZximdn9EJ2/nCn/5f616h
	EbiHh4eVyeVHgPNitUwwJn1T1fZFz47t3dshe1tWeJ/3vb4+TkYO+TvGWFwITp5yv+6YE2OEF01
	oEhDCMoMFVtfw=
X-Received: by 2002:a05:6902:2781:b0:e61:1b41:176e with SMTP id 3f1490d57ef6-e66a4fe37b9mr17409678276.47.1742841316738;
        Mon, 24 Mar 2025 11:35:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8lgkjkEycjgwwOag2CdHP7QKbLWSxA2ndMrht/bd5qNPOnsWKfFP2CDU3/jWiXt5YNAqbPiSXT2f4qcYi8mI=
X-Received: by 2002:a05:6902:2781:b0:e61:1b41:176e with SMTP id
 3f1490d57ef6-e66a4fe37b9mr17409613276.47.1742841316149; Mon, 24 Mar 2025
 11:35:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319230539.140869-1-npache@redhat.com> <CAA1CXcD2g=sRRwgLSudiOAqWXq3sCj+NPuE1ju7B2gFXXefjXA@mail.gmail.com>
 <d8fc1f66-f220-42fb-b58f-f5f9c7d30100@opensource.cirrus.com>
 <CAA1CXcA460xfy48JMNeX5rNTfUqsahER8SDF6tWu82V35ripLg@mail.gmail.com>
 <CAA1CXcD2RF6aXNH0ix=GN1+LTR9+dV7yRz-HGKZfUbSu+8ZM_w@mail.gmail.com> <4cc16ecf-d498-44a6-99b2-eee840cff63d@opensource.cirrus.com>
In-Reply-To: <4cc16ecf-d498-44a6-99b2-eee840cff63d@opensource.cirrus.com>
From: Nico Pache <npache@redhat.com>
Date: Mon, 24 Mar 2025 12:34:48 -0600
X-Gm-Features: AQ5f1Jr2LBKyY-vtXjhrKkI2mHegPoVMNKIPqwHoXVC90cmTjlCV0yTXpyR5wnE
Message-ID: <CAA1CXcCLXnsUjivG2HXWZfP=XLZRCV=Ws1y5_h+bdq3GbAYzRQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: cs_dsp: Depend on FW_CS_DSP rather then enabling it
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: broonie@kernel.org, patches@opensource.cirrus.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, simont@opensource.cirrus.com, 
	ckeepax@opensource.cirrus.com, brendan.higgins@linux.dev, davidgow@google.com, 
	rmoar@google.com, johannes.berg@intel.com, sj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 22, 2025 at 4:11=E2=80=AFAM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> On 20/3/25 17:35, Nico Pache wrote:
> > Sorry links got mangled
> >
> Thanks. I'm on vacation right now but I'll take a look through
> all those when I have time.
Ok thanks! no rush, enjoy your vacation!

If the links go stale (i'm not sure how long they are valid) just lmk,
I can get you new ones.

There is also this link if you want to track your upstream kunit test
on multiple arches.
https://datawarehouse.cki-project.org/kcidb/tests?tree_filter=3Dfedora-eln&=
test_filter=3DKUNIT&testresult_filter=3Dcs-dsp

>
> The unterminated string bugfix is this:
> https://lore.kernel.org/all/20250211-cs_dsp-kunit-strings-v1-1-d9bc2035d1=
54@linutronix.de/
>
> I got lucky on all the UM, X86 and ARM builds I tested.
>


