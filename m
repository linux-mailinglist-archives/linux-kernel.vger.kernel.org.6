Return-Path: <linux-kernel+bounces-277951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B24A94A896
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 511872839AD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6EC1E7A52;
	Wed,  7 Aug 2024 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jf3EDoVB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBDA1BDAB0
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723037310; cv=none; b=DBikuuERD6BdPJl56VWTIlUTrRK5RST0/Ngnh9jFJbKl2oX1z/0bNpp1wJMiygrSAjUpb8hJGaskiHstggUklSa+C3vL/UqQswe6jtIv7w8XqUpE+YU84mO7ZM7PFbadV460ZErCtb7bM25OPr3ZwGp4lyIklK+DX1JLA37TVoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723037310; c=relaxed/simple;
	bh=be69jar03oAVtU7rLyExntQNTbhDVGnDhTStt5HYacU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gzadjakkswPtcC94UVBLo4HHIlL4UNkXY5CSyifG1MxVC3gYViFH2LmwZAIU0BK/bzL/LMl4xRQ2zpxLefZVm7niO73+a6VrBK2oqe4qHT3pcV1edITa5BHXZukAL4tWEimpeA9QXO6w4YvGH9NTis6X9f/J/c8Kjz+QArAFNfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jf3EDoVB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723037307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MuOMS6Luo6DRqz2cR8tGU25H7DLY1HtTPW8DCbYrHtY=;
	b=Jf3EDoVBXs1X8wuIo9l6vZJ7I51v8AjNd+y6Fwu7P26gt3Tg5JH+NmT/UuXGbljb9waUBh
	9Bz/soeelKktdSirPwRrf7axDC07eIs4Avbk2W3rrdiBj0Werewq3RcpH6REmwZRJd7lEs
	dEpevh2k5lNTZPQs622+t4H8wTNVIfs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-VEaEegpZMFKK3ZJRv495ng-1; Wed, 07 Aug 2024 09:28:26 -0400
X-MC-Unique: VEaEegpZMFKK3ZJRv495ng-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42817980766so12548555e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 06:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723037305; x=1723642105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MuOMS6Luo6DRqz2cR8tGU25H7DLY1HtTPW8DCbYrHtY=;
        b=WScB5ne5muancC3yb7djwiUp8+nu6b6fr28Ek2VBWTYovq15QzYEOdGTl8SGtNnyOF
         Gej9O7m48d0HFzIJoOsEK3ls80MHAOk1x9a2hTFKJTIuzXAkWlQvnIGB2h8O0hinzxsa
         zEcdvOQnFxgq/eEf03uEXN7OGMlE3eKu37LKYoGlLCaqeh3dIRB9FoEW1+MIzBpBYmZs
         /M1KLQ0AVe8YkAylUrwyZQ5OL5f1TcC4/gnPbaRVtP85uGoJGYLL6i9pHREy6MxPZ0By
         Rky2PpIaRrHbOV8EyUPVyJiSMTZLC4lLYF8Jes0KniK4EdylwAVWrz/iIuflRRcvGxYN
         uI3g==
X-Forwarded-Encrypted: i=1; AJvYcCX8alr8+Jp77DfETZKpwgeUcRjSLSdzCPrfvdKSMEoULCtCrruyXr3jx8CYNbIu0GLMToSnSF6bc7klbnCJXNpr6veKpIAqEydiM6P9
X-Gm-Message-State: AOJu0YzMgux45tYshq79ZoL8M/+zZLSqsNWZIH+TgeAAwb05kPqpDyFH
	fpmPtmjcoK4YDXyUxnCzH5vD6gk/4sKP0Ce5w9hKxn6kWd5xWrlQvGynsVbyNh8PzGY3R8Bfe5m
	CTxSHTxcZYaab+4WV+TgN4+0Iq8NcJ0VqO+0bXgnfr8uBsgsYDifFIJnDQS5ZTQ==
X-Received: by 2002:a05:600c:458c:b0:426:62c6:4341 with SMTP id 5b1f17b1804b1-428e6b30e41mr133299765e9.20.1723037305386;
        Wed, 07 Aug 2024 06:28:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLj+isQ7nmBF9hW30nn+vT8bfESNT5x6lh77Gwp7uo/AL4KwM+k2TyKmw7SZMV+5PNlKfGIg==
X-Received: by 2002:a05:600c:458c:b0:426:62c6:4341 with SMTP id 5b1f17b1804b1-428e6b30e41mr133299525e9.20.1723037304859;
        Wed, 07 Aug 2024 06:28:24 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42905801c42sm30509085e9.34.2024.08.07.06.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 06:28:24 -0700 (PDT)
Date: Wed, 7 Aug 2024 15:28:23 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 <linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 6/7] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240807152823.0d9117bc@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240807103436.000013fc@Huawei.com>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
	<20c491e357340e0062b6ff09867c1661ed4d2479.1722634602.git.mchehab+huawei@kernel.org>
	<20240806163113.3bdc260a@imammedo.users.ipa.redhat.com>
	<20240807094750.6414fb2f@foz.lan>
	<20240807103436.000013fc@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Aug 2024 10:34:36 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Wed, 7 Aug 2024 09:47:50 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Em Tue, 6 Aug 2024 16:31:13 +0200
> > Igor Mammedov <imammedo@redhat.com> escreveu:
> >   
> > > PS:
> > > looking at the code, ACPI_GHES_MAX_RAW_DATA_LENGTH is 1K
> > > and it is the total size of a error block for a error source.
> > > 
> > > However acpi_hest_ghes.rst (3) says it should be 4K,
> > > am I mistaken?    
> > 
> > Maybe Jonathan knows better, but I guess the 1K was just some
> > arbitrary limit to prevent a too big CPER. The 4K limit described
> > at acpi_hest_ghes.rst could be just some limit to cope with
> > the current bios implementation, but I didn't check myself how
> > this is implemented there. 
> > 
> > I was unable to find any limit at the specs. Yet, if you look at:
> > 
> > https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-section  
> 
> I think both limits are just made up.  You can in theory log huge
> error records.  Just not one does.

What I care about is what we actually allocate vs what we promised
in docs. Given that it's harder to change actual size (we would need
a compat handling here not to break old machine types), I  would vote
for syncing docs to match code.

A separate stand-alone patch for fixing it would do,
or it could be a part of series.

Also I'd like another pair of eyes to look at it to confirm actual
size we allocate, in case I'm not seeing it right.

> > The processor Error Information Structure, starting at offset
> > 40, can go up to 255*32, meaning an offset of 8200, which is
> > bigger than 4K.
> > 
> > Going further, processor context can have up to 65535 (spec
> > actually says 65536, but that sounds a typo, as the size is
> > stored on an uint16_t), containing multiple register values
> > there (the spec calls its length as "P").
> > 
> > So, the CPER record could, in theory, have:
> > 	8200 + (65535 * P) + sizeof(vendor-specicific-info)
> > 
> > The CPER length is stored in Section Length record, which is
> > uint32_t.
> > 
> > So, I'd say that the GHES record can theoretically be a lot
> > bigger than 4K.	  
> Agreed - but I don't think we care for testing as long as it's
> big enough for plausible records.   Unless you really want
> to fuzz the limits?
> 
> Jonathan
> 
> > 
> > Thanks,
> > Mauro  
> 


