Return-Path: <linux-kernel+bounces-411262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3921F9CF54C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDDB81F2AC1E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263261D9346;
	Fri, 15 Nov 2024 19:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQwBz5P6"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA421D63D9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 19:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731700421; cv=none; b=fZ1nuLps2WV7K8NRQxAPGwtOTit8P1QPtHi340fFIgv+uiUsPbdn5vsGjDXJODl95gE080Cm6xV6oZLm19gRYg5d8X8RBNdweXG0UOEdBdyUft6gVo+WHoPcZSYCzMNgTCpVFMBw4zI7an6y7GllyGDzJiBOnK5XCFtmaAQrjS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731700421; c=relaxed/simple;
	bh=qymRDC5+ymqeeuGdqNhD6PpAnw7g64OhDXziwKfEuI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/fEGHN2AoJn5IzaSHI72akdK0e58TNGsZGckj9ZzADmPo1iuofkHczj7Hsd4V3NUOseT4ncbWN7p8Mc+2btgpWfUp9GzQIFkR4sEZPS7sSpd3Y5A6f54iEFCKHxNO9aSCnUZhHzsF886s2/Pin568rslsAmtQ+IvUpAcB6c9ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQwBz5P6; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20cb7139d9dso23851935ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 11:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731700419; x=1732305219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g2KY7Q+Eizs/rQyfl+pd8J+/bDe/OKiMzfmlO9agojg=;
        b=TQwBz5P6+HvuFgS4wyzgU32mGy71cJggK/iRL7rwMkP/wWCwZdfNAE5kYjupL3VH8x
         puVirClUgfgCSvFyquxQ6UDTdFy35LuQvVqeqES51ATs64IjxZAlP4OH2ArYTBNaxMtp
         iDXUnnX5LIQ3cjuSrGyuF4WaT74pinTbWqfqVuSHehDPlJ2q46bN+cUh8GYvixfFlx/d
         qcwjntKdg5W22DtfrUnYuLpCWK//PZyiH8q4yRHk0+xc4oP5as5FLmpj2dyLQ66KyC1k
         uEwNr5/BDiSKNSruOcokktqMWPnQK7FlBCL/VNBOKNm1g52BvBV8VfJOQTmGqegkCU+t
         HeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731700419; x=1732305219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2KY7Q+Eizs/rQyfl+pd8J+/bDe/OKiMzfmlO9agojg=;
        b=eh+U26kVae/WpzYNEiSqeflrS/RTjdFwBxOErMOJ27p663p8HceJkw70UXsLBfmRha
         8Z+Un8LfuuCcg1yfCtlIH7TGvguuDAtFfyo9qtfrEEgU954+/m23zS5+JFYDd4KrVpyu
         A0wL+DptUNPjN+RHKymb2df+ayvFUFtHSJWHnf+OgVLcDfTOM7QLrnrSk4bGnWNEoO3X
         Lq/0N2k5D20IAGQHJ5c42MK4xRs66nM3vu2PPPkCqhcCrdaERWD1sGdjPjL8ld5NXbSq
         76fmttnXK6rVx92j4O+PyFxiPirIK0kATiWpmUDcy5SX/ICX+w7dgPfz2Rg9oY89W+zR
         0vXg==
X-Forwarded-Encrypted: i=1; AJvYcCV0M6Q7fCUV8/18uWF6OaSTKkG55kpJQDvXrh+UUkb61h9dP75Nx861Fv2GE6JykFZV/P66LYrsVTNj0bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbqNo8FnW4SaTTRUTe6LoDFg7ySdQQ74pugdqO91Levekohgpa
	VXPpIRU59A2C+EEdbiTB59v6WfsUGQSZtvtUtjK/dPtP/k1KoYX3
X-Google-Smtp-Source: AGHT+IGaRy+4/NbRcBbr6CvxXe0Q7df7w9zcbb7gOU0/LXhU6Jq2XISzSHo3eiqDOZAvAaNC88Iypg==
X-Received: by 2002:a17:902:f683:b0:20c:b517:d715 with SMTP id d9443c01a7336-211d0d83b50mr54888835ad.25.1731700419446;
        Fri, 15 Nov 2024 11:53:39 -0800 (PST)
Received: from desktop ([38.141.211.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0ec7dadsm16177025ad.71.2024.11.15.11.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 11:53:38 -0800 (PST)
Date: Fri, 15 Nov 2024 11:53:36 -0800
From: "Ragavendra B.N." <ragavendra.bn@gmail.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	thomas.lendacky@amd.com, ashish.kalra@amd.com, tzimmermann@suse.de,
	bhelgaas@google.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch:x86:coco:sev: Initialize ctxt variable
Message-ID: <ZzemwFBfEIgFhrD-@desktop>
References: <20241115003505.9492-2-ragavendra.bn@gmail.com>
 <Zzcp75p3KTFRfW5O@gmail.com>
 <CAMj1kXHK4NxgWCieaQY7tT6BquSBv6Db10K8-V_8qFeZKv=BZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHK4NxgWCieaQY7tT6BquSBv6Db10K8-V_8qFeZKv=BZA@mail.gmail.com>

On Fri, Nov 15, 2024 at 12:02:27PM +0100, Ard Biesheuvel wrote:
> On Fri, 15 Nov 2024 at 12:01, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Ragavendra <ragavendra.bn@gmail.com> wrote:
> >
> > > Updating the ctxt value to NULL in the svsm_perform_ghcb_protocol as
> > > it was not initialized.
> > >
> > > Fixes: 2e1b3cc9d7f7 (grafted) Merge tag 'arm-fixes-6.12-2' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> >
> > This 'Fixes' tag looks bogus.
> >
> 
> So does the patch itself - 'struct es_em_ctxt ctxt' is not a pointer.
Thank you very much for your response. I am relatively new to kernel development.

I know we can use kmalloc for memory allocation. Please advice.

struct es_em_ctxt ctxt = kmalloc(sizeof(struct es_em_ctxt), GFP_KERNEL);

I am thinking to update like above, but like you mentioned, ctxt is not a pointer. I can update this to be a pointer if needed.

--
Thanks,
Ragavendra

