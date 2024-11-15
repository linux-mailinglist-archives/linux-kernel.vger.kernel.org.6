Return-Path: <linux-kernel+bounces-411346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C66129CF687
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 22:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AC1BB2B9C4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 21:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1C118DF7C;
	Fri, 15 Nov 2024 21:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+eh6d5J"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CA0187876
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 21:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731704555; cv=none; b=sJxaEJqi0tVwvZoxdB9i5yBt539ck2DyT59hx6yod2bNoM7Zv1Xu2SnVG/YebiBK+TXqL5DRSB6ey8baVHTyOpNbwhjcFNas01Z6KmLmyIMiD9maAtWuy1hgrzWKpK3mt3QH5uYo4fHg1cq7CtxGECzwwkGRZrioQtqWJKX5RuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731704555; c=relaxed/simple;
	bh=hNHMQs9ow68HPWHLd2pAa3VU9M+ilyIItmmCsn6c/XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Stxeibr3gKMbsXxiSYwKAiXZ2nyjF/+RL4FWibWifXbtFVhdKEeRXdoT3ph2B3G1A0uckdDt1oJCLJXLPQ0EjRYT8MMPegd65EN7LL4c9mexQsCZH278oZkfjFhj8+x3HqUjPOp5YcOV0KZoAK83kywd5Qb0i/PXhC3yGzw5syo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+eh6d5J; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ede82dbb63so41708a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 13:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731704553; x=1732309353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y3nmcDybv1iDK+XRgIQNqXoAP01L04JMwHupW9XQYb0=;
        b=d+eh6d5JJQoa4F5ew7kx2gN+/IFPV/IntlapWtzfZswFsZSyGFTvoAHxPj3gBPdRsa
         TRS/cgHlvFZ3kCD8u79zSKdSRDur8KoGlILLayWUwhIKC4Vz6md0uqtceKDJ0lILIvV4
         kLTtpIYmoqdZMiQz+nBECAI5Lh2uA17C6Y1gNSxkQ+onGIXB7ohngPEVTqnyEPJ3/ItQ
         rwIHvQz7+hi6gmbmN3qWbmGQlviAMYHEkGdwjP7IMqfntYrGjuKxSQKUK2tk6Jew6V7v
         GuVgtgQOIIapvmFhHX1m66qOSN1PQu9QmWQM9G+8SiJaOVdpfh+vcBGode+NohKlFdha
         Waog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731704553; x=1732309353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3nmcDybv1iDK+XRgIQNqXoAP01L04JMwHupW9XQYb0=;
        b=EJd8txyf5EQVKa6xtuPrZzfh0NI3p9N7o9PsIwBlbCMM7lAJoG+1uB2RMb+ZSd3zE7
         4uEtQ53ZXLqLGOkPZsflEvQ26zWnD1mb1myZ70hUWdUxvFPz7aCj3TqFk7jF6x2Mf8XB
         KkpQzMALGN4WnNQCgF7ajfrs2oQTaJjU78q75TLQWqRyuylAnAm3Er2/0BoDia25Ek1X
         eirUa184HwRvKnJLhAuEEcTW1vhklbG9IDBXQNKTYdZ/oKKekodT2EN8ktouuKQifhOU
         +th+mh+RCT9QrxqVIWKL4SJEzrAqAgjRqCG9YPICKiVGKdyx3IrfDWutwbCv6LPlUfgM
         Wj9w==
X-Forwarded-Encrypted: i=1; AJvYcCW11OTvn40iQRZtTXP6Deh5iXTnaGKp4Zi/aYHxGEnHzcWrVoYgsui5RLoPsyN4JTAYFZs24Q7HacT7l0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSRRl3aOxn2kgOrKLctrRyclmTgx6spGCkec03MbH8hIGppEgB
	s/bmlmRF8RzpqRw+y2vgKCdzkaOM8yn4bhlNW8bW3MWFV5RVE3BL
X-Google-Smtp-Source: AGHT+IGJqVGCRTuFW1P0i+q46RJnr42tgVRfolV2Vlrc6rBapb4P15XQdTD1CKpZh3ms6e6qK4lRmQ==
X-Received: by 2002:a05:6a20:2444:b0:1db:e536:158e with SMTP id adf61e73a8af0-1dc90b47e50mr5884745637.22.1731704552903;
        Fri, 15 Nov 2024 13:02:32 -0800 (PST)
Received: from desktop ([38.141.211.103])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1c176b0sm1757295a12.2.2024.11.15.13.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 13:02:32 -0800 (PST)
Date: Fri, 15 Nov 2024 13:02:28 -0800
From: "Ragavendra B.N." <ragavendra.bn@gmail.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ingo Molnar <mingo@kernel.org>, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	ardb@kernel.org, ashish.kalra@amd.com, tzimmermann@suse.de,
	bhelgaas@google.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch:x86:coco:sev: Initialize ctxt variable
Message-ID: <Zze25GF2nJbM70ZF@desktop>
References: <20241115003505.9492-2-ragavendra.bn@gmail.com>
 <Zzcp75p3KTFRfW5O@gmail.com>
 <ZzeU_OXCAzMSOU1G@desktop>
 <b243110f-d233-0b62-864e-2b6181663d29@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b243110f-d233-0b62-864e-2b6181663d29@amd.com>

On Fri, Nov 15, 2024 at 01:20:15PM -0600, Tom Lendacky wrote:
> On 11/15/24 12:37, Ragavendra B.N. wrote:
> > On Fri, Nov 15, 2024 at 12:01:03PM +0100, Ingo Molnar wrote:
> >>
> >> * Ragavendra <ragavendra.bn@gmail.com> wrote:
> >>
> >>> Updating the ctxt value to NULL in the svsm_perform_ghcb_protocol as
> >>> it was not initialized.
> >>>
> >>> Fixes: 2e1b3cc9d7f7 (grafted) Merge tag 'arm-fixes-6.12-2' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> >>
> >> This 'Fixes' tag looks bogus.
> >>
> >> Thanks,
> >>
> >> 	Ingo
> > Please feel free to suggest the valid tag as the file was renamed and I am not able to fetch the correct commit id.
> > git log --oneline arch/x86/coco/sev/shared.c
> > f50cd034d24d (HEAD -> 1594023) arch:x86:coco:sev: Initialize ctxt variable
> > 2e1b3cc9d7f7 (grafted) Merge tag 'arm-fixes-6.12-2' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> 
> A quick git annotate arch/x86/coco/sev/shared.c shows that function was
> created with:
> 
> 34ff65901735 ("x86/sev: Use kernel provided SVSM Calling Areas")
> 
> Thanks,
> Tom
> 
> > 
> > --
> > Thanks,
> > Ragavendra
Thanks a lot Tom.

I figured why I ran into it in the first place. When I cloned, I cloned with --depth 1 as I had less free space in that partition. The annotate flag certainly helped to retrieve the exact commit id.

--
Regards,
Ragavendra N
,

