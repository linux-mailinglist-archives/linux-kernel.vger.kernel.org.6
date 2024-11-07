Return-Path: <linux-kernel+bounces-399824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B919C04D2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C341B1F24B1A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47ADF20E315;
	Thu,  7 Nov 2024 11:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gul/TKvd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2171F20B203
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980134; cv=none; b=StZwSu/Ytc+yK2l4rXhmMTKPr56PARED2lpef8fTPdOaePiE+H6qvLsdQH+BZJSWqdLHrCBYO39yDHhoFevxbGRPoQZSiv7thmnH4Xk1Od1jF84c61mlMn0AaPK+DJuar1RFB/H+YwtNqkMI/rFfYme1M06Cu4tdjV9jhsnv54Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980134; c=relaxed/simple;
	bh=QOvRcaa9ClCUbKw2iregEOY7x2b74a6qHIqj/U+U+m0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QmTZ/GZvZaYq2yQbpwM9/J6oWgr97yaJyGuClUEwSHq+N8Pvu3yxI4UPtQZ+DAitA0ypWaKAx8F4i1cvHRN9WpbBwk15Qs6ojV3Y+ZYBYc99YQLAOPtmH+EMAdvADTtX+1cBoU6JmF4nc6BDuvQ2F4cvakvzN5xpFoMyKwQu0VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gul/TKvd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730980132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/L/1DDby9dldKVZdC6uWjrN54X6CTuprfUA1WAiNmRU=;
	b=Gul/TKvdDEEd0Z2WpjXwnVOmYQFVeJKt8RgHNQivRMh8Uf4JQGCQRSXberNrJ/4zEJ+R1g
	iuQQrLsDkdDUJQ0fZ/ePxKfE6QQ5Wbp+JdO4lTe2JbMF9gBaaKfGWIhcTYm/zxBuAzo0d2
	GHKz5eLrm2CTjG674Rwley8rBsT4RWc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-lL34H1c0OqS13tdZtq6cYQ-1; Thu, 07 Nov 2024 06:48:50 -0500
X-MC-Unique: lL34H1c0OqS13tdZtq6cYQ-1
X-Mimecast-MFC-AGG-ID: lL34H1c0OqS13tdZtq6cYQ
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e95713327eso1049802a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 03:48:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730980130; x=1731584930;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/L/1DDby9dldKVZdC6uWjrN54X6CTuprfUA1WAiNmRU=;
        b=Q7h9oYRJ6UKfkMeeHFIuVvD7SiqJpYZRyJgxUkY/IOv67FSe/jNL9SSZTWGAMVufBs
         TtJLq4E+iUY6sFyIY0ArbJw++RrhKZgNieCkuLr1ehEMew42xWCSJsaxMt7NSfgGzAyG
         791ZuUSvmMtak+ERzRADKCXRLzAcUJ11eZuT64DfpwtMrRykkcccXUdZufIdbd5FdESl
         /GE6T5avZ9vsWzbVsFdyclI5AarRhIiJqe2dA4n/Byabn6effpmQJfbM4yEbNK2sPMHF
         TOOr8hT6rSQUA+hQQgkzjM0NuwVXM46KqJ4RwmSAH1ka8Yl5jGq1P3liPh1ljNI/RfuY
         HOVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4Rx7wGwLrYuzyELUQQKc2SoxKW/lb7SFevu8rqVPu+MzI/Cind0MfMc1ieLXCPfd6ikWrlpH92U/jJ08=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRPUjFnrSfMB0IxbD9aNvn3xZolnlR8QSgIW0s76vkCmE4ZkcL
	ft46GuaZNLjabk6Cbhi0tEZDM/7GpxmyQQT4NMh6tSN7JIQXqUZ5sYy3h9IXFzIsLIr5+5eWyIW
	5eddm6aVV/tL8faDjQypGzidNZoPE+68RXQ8J8E/qr/nlTTFPWVuznzj4Ul2GfjxmwEF1mC1h2u
	PDmZ4jn3ja1sSddVqHWk3c79aDCZdz9Zts93gk
X-Received: by 2002:a17:90b:1c85:b0:2e2:9e64:c481 with SMTP id 98e67ed59e1d1-2e94c2e2caamr33234829a91.22.1730980129953;
        Thu, 07 Nov 2024 03:48:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRZJ1bbLeJ/YMxkBDXvyJF0NxUiIHH8QEAOU7ZOunHR8MuquVbkEIP6Em0CoCefvLdX/NtA/ExyCwLPMRI2vc=
X-Received: by 2002:a17:90b:1c85:b0:2e2:9e64:c481 with SMTP id
 98e67ed59e1d1-2e94c2e2caamr33234810a91.22.1730980129649; Thu, 07 Nov 2024
 03:48:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <MW5PR13MB563287E9DCEF5F43C0B2BB0AFD5C2@MW5PR13MB5632.namprd13.prod.outlook.com>
In-Reply-To: <MW5PR13MB563287E9DCEF5F43C0B2BB0AFD5C2@MW5PR13MB5632.namprd13.prod.outlook.com>
From: Eric Curtin <ecurtin@redhat.com>
Date: Thu, 7 Nov 2024 11:48:13 +0000
Message-ID: <CAOgh=FyUkG8UZ9n8rme17ksRu2fhHcZnA3sCfcne3+j9zGW-kA@mail.gmail.com>
Subject: Re: [boot-time] Please check this wiki page about RCU expedited mode
To: "Bird, Tim" <Tim.Bird@sony.com>
Cc: "linux-embedded@vger.kernel.org" <linux-embedded@vger.kernel.org>, 
	"edchong@redhat.com" <edchong@redhat.com>, Brian Masney <bmasney@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

It looks great to me, it's probably kinda self-explanatory but we
could put that it's only relevant to RT-kernels here:

Kernel Version put kernel version here
Configuration list relevant kernel config options here

Is mise le meas/Regards,

Eric Curtin

On Thu, 7 Nov 2024 at 01:50, Bird, Tim <Tim.Bird@sony.com> wrote:
>
> Ed, Brian or Eric,
>
> Can you please take a look at this wiki page, and correct
> mistakes or add any material you think would be valuable.
>
> https://elinux.org/RCU_expedited_mode
>
> If you have a specific example of a boot time reduction
> from using this technique, can you add it to the case
> study listed at the bottom of the page.
>
> I copied some material from your devconf.us presentation.
>
> If you don't have elinux wiki accounts, you can just reply
> to this email with suggestions, and I'll change or add the material myself.
> One specific question I have is whether  this technique only applies
> to an RT kernel or not.
>
> IMHO we can collect information on various techniques on the wiki
> (including data about their savings on different systems and in
> different scenarios), and then migrate the material to an upstream
> kernel tuning guide when we've establish the general utility
> of the material.
>
> As an aside question - if it would be easier to just review the material
> on-list, let me know and I'll send the raw page (in mediawiki markup)
> to the list for email-style review.
>
> Thanks
>  -- Tim
>


