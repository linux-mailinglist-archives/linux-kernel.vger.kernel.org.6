Return-Path: <linux-kernel+bounces-250798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4C992FCF0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50E7A1C22EF2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9223172BB1;
	Fri, 12 Jul 2024 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3knj9zw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8AA16F83D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720796033; cv=none; b=h5LtRuAc/sARjpZ+FLO+6R3zpB+jWETGXFQdZoOzDiRKBdIyisAaFS7G3yZhq7V6FRTNX6ee26eiOxPU+jPTEkV4XfY/j/csXozwAKHpA9GzSclpKPXwNfU5JaJwcm7W77Y8RQQn46iOpGTd9mOqEPdtj0MHt2kYxys/Z28oSwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720796033; c=relaxed/simple;
	bh=S19hFP5H0m8SmZvLLDNz6EKsg9QbZl78HGkcE4LnDdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elSK629lv53+dW4qTa9cfbWAt/2Q7QQlXv46H+N9lPVPyIywppVCqk4GUxOTQsiBS3uo9GHgnDBaqsLXF7tE8yngwl3KQftrvC2ZalXezp3XvfMgg7A2GHz6IwwEE37zT97GboJV6OJWO4LABTJKdg3zngX1jig/1mE+M+cndJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e3knj9zw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720796030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H03nXr4hza2PKemh9fjDZhk1nYAQUKJ0uHQmzsJryOY=;
	b=e3knj9zweYzkyqag16b+dtMkfb4CeQzdiIV9W5sQ01q4TgPTodcT/PeMh1T29hwTnxhwEK
	zt3/Qdd4n2GPh2r6DAc3MFvRtfZU3UM3u8xYUN/P9+KXc3auNPbeke1l8E8j710ek+vGYu
	+yVlQgTu+I2OKevlRYDZ9OPqJ81ALCw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-MOi5eV2DOGizL8JxU-bLRw-1; Fri, 12 Jul 2024 10:53:49 -0400
X-MC-Unique: MOi5eV2DOGizL8JxU-bLRw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-367991a0a64so1144575f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:53:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720796028; x=1721400828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H03nXr4hza2PKemh9fjDZhk1nYAQUKJ0uHQmzsJryOY=;
        b=J1wNu1GXjHc8Ki6GmeAIiByWk/VcmzpUkVaTvX4l9GMqGFdaVFoK+pl7yVNYEI+RgS
         bffqJj3xnvJUOpcGFrLdeXzlmMDrVr7zJM/hGU2+dP3TCHiiHLn6uKDVl+AjjeyB/MEk
         QDLGZaU/apewfyoz/DdAAIPaRiz0V3c8NImXXeLDPMpyRlOP88kdcO2E8SYW4ywwGN2K
         5YG6fuhxn7OesILv1nUAy90ihUsAott7vfz55gMgJ4FyyEMIVh+Zu1N7Y0OCEqDZUg4Q
         8bxTECyJ4aqzECHF8SAXXiEM87entgjqZCYKBIBSQxQjGXAtwh172+Brri4JrPwKtmKu
         LFtA==
X-Forwarded-Encrypted: i=1; AJvYcCXm0AdHOk3FxmYtt96jEvLUPIBYixrJHAnk1fPClwg/uLt9O2cDGGWhL57Y8sB/w+DjGIOrFeTzZzvh7N5lrTmKGU2GtJTgcxeMbsz2
X-Gm-Message-State: AOJu0Yx+xugu/zBVmkSC8/WUhtcj/EyAGmwFDoz22iYQEOsrYjhzEYYh
	S+rtKyBfaCKFErF9g/w3/N8+gkBzxWmggyVM5LGix+cDN1GMeyTZpt8OK49r2mmzWcKK4na1BfS
	y+cZ1IzdYfxmwUGF6SebKRUmTcaoxG49i6EkCqUQe00nodiSewRAPp1xyjAfljg==
X-Received: by 2002:a05:6000:d82:b0:367:96c5:ae70 with SMTP id ffacd0b85a97d-367cea91ff7mr7290417f8f.31.1720796028047;
        Fri, 12 Jul 2024 07:53:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiO0uAs6JxUgrGSU2IZ4WL5eybEQVI96YsUpsBbrQEUNfgqnCbo/oj/8KRpKxRv5+wT8B4bQ==
X-Received: by 2002:a05:6000:d82:b0:367:96c5:ae70 with SMTP id ffacd0b85a97d-367cea91ff7mr7290404f8f.31.1720796027710;
        Fri, 12 Jul 2024 07:53:47 -0700 (PDT)
Received: from cassiopeiae ([2a02:810d:4b3f:ee94:a4d3:4896:56d4:f050])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7df48sm10448458f8f.1.2024.07.12.07.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:53:47 -0700 (PDT)
Date: Fri, 12 Jul 2024 16:53:45 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Steven Price <steven.price@arm.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>, ojeda@kernel.org,
	lyude@redhat.com, robh@kernel.org, lina@asahilina.net,
	mcanal@igalia.com, airlied@gmail.com,
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] drm: panthor: add dev_coredumpv support
Message-ID: <ZpFDeajsuVONbSYJ@cassiopeiae>
References: <20240710225011.275153-1-daniel.almeida@collabora.com>
 <fe84a028-01a8-4987-b1b7-141fb76d263c@arm.com>
 <4344B22F-D859-4C64-A351-69FFB5208362@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4344B22F-D859-4C64-A351-69FFB5208362@collabora.com>

On Fri, Jul 12, 2024 at 11:35:25AM -0300, Daniel Almeida wrote:
> Hi Steven, thanks for the review!
> 
> > 
> > This is defining the ABI to userspace and as such we'd need a way of
> > exporting this for userspace tools to use. The C approach is a header in
> > include/uabi. I'd also suggest making it obvious this enum can't be
> > rearranged (e.g. a comment, or assigning specific numbers). There's also
> > some ABI below which needs exporting in some way, along with some
> > documentation (comments may be sufficient) explaining how e.g.
> > header_size works.
> > 
> 
> I will defer this topic to others in the Rust for Linux community. I think this is the first time this scenario comes up in Rust code?
> 
> FYI I am working on a tool in Mesa to decode the dump [0]. Since the tool is also written in Rust, and given the RFC nature of this patch, I just copied and pasted things for now, including panthor_regs.rs.
> 
> IMHO, the solution here is to use cbindgen to automatically generate a C header to place in include/uapi. This will ensure that the header is in sync with the Rust code. I will do that in v2.

You could also just define those structures in a C header directly and use it
from Rust, can't you?


