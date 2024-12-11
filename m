Return-Path: <linux-kernel+bounces-441680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576619ED258
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F6E9288983
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5BF1DDC09;
	Wed, 11 Dec 2024 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqUs+YKz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414AF748A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935342; cv=none; b=DTPqkRG3khHhHsxoObNwTQlE/a9XTW/mm4Knii8t+iTLtFtyVTXVcKXy5NwTtFfNbq1OGUlTSmvN4PY3kCx9VaPyZwzq8ZLLScdvOjoinfR8TQRzL2klVLw8C4T/oOgaYwa2eOZzp41d8Gl8cyDKatV0JFotuVma9+wQagdQl3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935342; c=relaxed/simple;
	bh=ZWKFASmhjwAGqbYokVzWZLsYyd33PT09aF7jLzAdQVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyA9rJe+YVOV6Awz3X/INeTUc/28L/Jl3c4fQE2mhHtdd5tPOBSGJXWCu3zAYr5gPV2wcJQfXRzKK4Xrzr54DHhCMgnPt9r22G26U8LMqWYzI9at4k2BW+1m0MZYlrcpNZHKjuB09sk8n1r7aYz6rzBPYYkGqaGmOZHpadV4vbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eqUs+YKz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733935339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZWKFASmhjwAGqbYokVzWZLsYyd33PT09aF7jLzAdQVw=;
	b=eqUs+YKzugOg9Art7UNlFbjc2yaWzf7pX3Px9ks5qlw8luWitsYOt/OmPtnPIWt/uAdETK
	WRmf9lRvPWYgKq204PCO9wmMfStMDM1WNIUokHKzMFGuOo3GhvvOPwYGf9u41k3OjrL70A
	iZXaXFPYO/N0HvpeU1sqgGkBuA3RTtY=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-4ipGHCFTPemtSDAHWqhg3A-1; Wed, 11 Dec 2024 11:42:17 -0500
X-MC-Unique: 4ipGHCFTPemtSDAHWqhg3A-1
X-Mimecast-MFC-AGG-ID: 4ipGHCFTPemtSDAHWqhg3A
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6efed4768cdso44045417b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:42:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733935337; x=1734540137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWKFASmhjwAGqbYokVzWZLsYyd33PT09aF7jLzAdQVw=;
        b=Jx4S//u5KOg0JG1B+jrNttpFTVIwV+IrPCIhmyWQzXDwiWBi5ezhtzA2BIsI2vf/UN
         /Ahn4A1KbdiMVXezmN+yKIoPpJshx8zehE/4MiFETwUD1KA1qLsE8nCD8yDeFjWGpLfE
         43enEPdXLyj9f7vhZjWGj/ApSeMw9dxcpL0QVJYThklGRMvDta20ChIINjQEt/ZXSBAF
         UUMHTpCGCqLu6yg3fD6G6bw2BRKbZLlZNrzNoHq6bPttcfcLnYFvVb5yzYbUJTMfrryq
         goCEqdvad051wRJVOTvO4UAEDSnRibE1lP/kqJ8h6LVZwlMnHQ3roPs0FnQqS6pLgBNI
         L2Rg==
X-Forwarded-Encrypted: i=1; AJvYcCV/g1CCUiMfiP6B3YRAdhkq5EaeKpg8342zq+3DqKbRcdT6Ee+SPIGLMCBXrJvn4ADDdW/c0D6Sf5wk0Zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeawXukkvkMXCRl3JTcSTko+piMxJ50jDeJ5NfQFaqUt0fKGEh
	hOJZmwLfpMMpNgfXzpE4+v+8Ue0DTtM6NgXFvZ9e3/9FWeDC1wGhV9Pf22JKSOi4oN87IAMzkWa
	4MYvXPmc81InVx/+MgQg00awiHT7+VWMs6eFZHfzhk0AJb01UheUnSSu/gu3DDqQvHyV6f4eQcw
	AromQqwv+a+KGqbKnlpupQb2kkl67Cjfq1LaxL
X-Gm-Gg: ASbGncvGLVrPVJFo1SWAimYu14MbAHjYTctJ7hMm5xIj0p/iQR2UAtColLVDpgw4FPf
	VARNx9DMa8Utu568YWR8OFJl7Xcm2Bgfgjg==
X-Received: by 2002:a05:690c:7209:b0:6ef:4696:f1cc with SMTP id 00721157ae682-6f19e507948mr1535057b3.22.1733935337420;
        Wed, 11 Dec 2024 08:42:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/XJy9SvqHMi5QS9auWTLUBW5pkqCymbkP9cFTfBTmSyV+DzOhB5ok1fIsYYsnyOBoX0jGlj/OTH7H/+3usaY=
X-Received: by 2002:a05:690c:7209:b0:6ef:4696:f1cc with SMTP id
 00721157ae682-6f19e507948mr1533757b3.22.1733935335549; Wed, 11 Dec 2024
 08:42:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210143423.101774-1-sgarzare@redhat.com> <20241210143423.101774-4-sgarzare@redhat.com>
 <20241210144025.GG1888283@ziepe.ca> <50a2e1d29b065498146f459035e447851a518d1a.camel@HansenPartnership.com>
 <20241210150413.GI1888283@ziepe.ca> <CAGxU2F6yzqb0o_pQDakBbCj3RdKy_XfZfzGsiywnYL65g6WeGg@mail.gmail.com>
 <20241211150048.GJ1888283@ziepe.ca> <CAGxU2F5NSqMbA1Lep3+16GoZXR23q0OP8dFVVRJ6DG5sF20R3Q@mail.gmail.com>
 <20241211155358.GK1888283@ziepe.ca>
In-Reply-To: <20241211155358.GK1888283@ziepe.ca>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 11 Dec 2024 17:42:03 +0100
Message-ID: <CAGxU2F51EoqDqi6By6eBa7qT+VT006DJ9+V-PANQ6GQrwVWt_Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/sev: add a SVSM vTPM platform device
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, linux-coco@lists.linux.dev, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Peter Huewe <peterhuewe@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-integrity@vger.kernel.org, 
	x86@kernel.org, Joerg Roedel <jroedel@suse.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Claudio Carvalho <cclaudio@linux.ibm.com>, 
	Dov Murik <dovmurik@linux.ibm.com>, Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 4:54=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Wed, Dec 11, 2024 at 04:38:29PM +0100, Stefano Garzarella wrote:
>
> > Except for the call to pops->sendrcv(buffer) the rest depends on how
> > the TCG TPM reference implementation [1] expects the request/response
> > to be formatted (we refer to this protocol with MSSIM).
>
> Make a small inline helper to do the reformatting? Much better than a
> layered driver.
>
> > That is why I was saying to create a header with helpers that create
> > the request/parse the response as TCG TPM expects.
>
> Yes helpers sound better

Ack, I'll do in v2 (together with send_recv op) if there are no
objections or other ideas.

Thanks,
Stefano


