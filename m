Return-Path: <linux-kernel+bounces-261536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7F193B86D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 23:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 937A8B231C4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CAF13B2B0;
	Wed, 24 Jul 2024 21:11:52 +0000 (UTC)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363E013AD1C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 21:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721855511; cv=none; b=Why+bFpC6C96DtpEMpOMfEvmwOR1HCUZJdx5McFlhnJ1srAA4e4GsQA1C1C25W0+WASjxSyeHYJu4a+Oeopqj61CLp/0zn1YPIUVbe17c3NXPjEZzbhOmSZ1bBHYB+2MK34wpiCATpnL8oOM3UszvZPnmR1Ql7vsjehOtiowrdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721855511; c=relaxed/simple;
	bh=0fxAcx9n8E//SdDndveDyp97As6JZ7ETl582+HEdzKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ERoHWxcOs5EU61kpa9voPXg8t81JbugsP3uBKXDGt8skdkzPVdQrnyQIK+rEMuaxz2lOHRd+hknF0o90WT7ypQdrsCOr2XWCD79PbAspbTPXXe4ZvGU2tQIABfEcRTPofPiHxUtH4KSIwiUozQ7QNf2xOJR8SoSKRl4fKpgjFFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4f51551695cso97843e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721855509; x=1722460309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wo9rBukdP/tuDMxJMB/GnqO9t6TTdQNeP2BoCKCEW1c=;
        b=FHcdPp6MLY43G8CJqWiEzOgAk2bGOCS+52S4pBZ5xv+5V/wrcnm62+n45hC9v1KGAu
         +CNDHEhjBPhc3Ny2alN9ntJy6fFdsLyGrEN+8ue4CxStFcOsSHBVtKB0QKtmxTsNNaiC
         kY6j40WBMowmcZ3RtptiFfYkMFrjcbd+/TKtRYqaFvgks2ncdC3Sj1tFZnaBJLn0aCpH
         NOgFC5XwtkraA7H3+IehAVKkYajqCR9pcazGC1fsvlyZD3rMyPkXBON50G8kmDa5wAuf
         lkEZb4wK7pVl8bEdjU9DQhCtpBEzS9zYetdjw/1nP76W+zPe2indc+cH8bUW/VAcN6Nb
         StwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMQl2RD0PaLrA8JhKaNN3hJWJyEYu4IykosPQjgQ4CsLspJ2zmt4lFGd+Ut6ouQcG/PDVsIYb72KL+Mzjs3wm/ooapzfTYqkjsOGSp
X-Gm-Message-State: AOJu0Yz88dtVlkrdQh6/LIZIMTvRqmNTxcb2J1UYNK7/fZBaFCEqsowG
	B1afssDOQYIP/GsqMYTqkUMdSqDi32ivNkn962pWf57bKcinINnPT4XdXqjnVFGClArmCeTZ/G1
	P6QA3zbOTzVzflN2gND/h4ZYETDw=
X-Google-Smtp-Source: AGHT+IE8c7oNYl/FchtBsRDZ6U8Utwg4wDCxMCwmVoVnrmcThNf9/d3IXeAEzQ93JwroZ73uxMNAhH/mMMbKgionSns=
X-Received: by 2002:a05:6122:4129:b0:4f2:f1f1:a9f2 with SMTP id
 71dfb90a1353d-4f6c5b6a2camr1642813e0c.4.1721855509106; Wed, 24 Jul 2024
 14:11:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710083641.546-1-justinjiang@vivo.com> <20240724125515.6cc3bd8479ea8bcdedaa7eff@linux-foundation.org>
In-Reply-To: <20240724125515.6cc3bd8479ea8bcdedaa7eff@linux-foundation.org>
From: Barry Song <baohua@kernel.org>
Date: Thu, 25 Jul 2024 09:11:37 +1200
Message-ID: <CAGsJ_4zh1RLX+hVdYmYQ+ozKT1Nd0KbWxDw4TGiDSoCaeMfSiw@mail.gmail.com>
Subject: Re: [PATCH v10] mm: shrink skip folio mapped by an exiting process
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Zhiguo Jiang <justinjiang@vivo.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 7:55=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 10 Jul 2024 16:36:41 +0800 Zhiguo Jiang <justinjiang@vivo.com> wr=
ote:
>
> > The releasing process of the non-shared anonymous folio mapped solely b=
y
> > an exiting process may go through two flows: 1) the anonymous folio is
> > firstly is swaped-out into swapspace and transformed into a swp_entry
> > in shrink_folio_list; 2) then the swp_entry is released in the process
> > exiting flow. This will result in the high cpu load of releasing a
> > non-shared anonymous folio mapped solely by an exiting process.
> >
> > When the low system memory and the exiting process exist at the same
> > time, it will be likely to happen, because the non-shared anonymous
> > folio mapped solely by an exiting process may be reclaimed by
> > shrink_folio_list.
> >
> > This patch is that shrink skips the non-shared anonymous folio solely
> > mapped by an exting process and this folio is only released directly in
> > the process exiting flow, which will save swap-out time and alleviate
> > the load of the process exiting.
>
> Has any testing been performed to demonstrate any benefit?  If so, what
> were the results?

I think I shared my demonstration in version 7:

https://lore.kernel.org/linux-mm/20240710033212.36497-1-21cnbao@gmail.com/

I noticed a significant improvement with my small test program.

I observed that this patch effectively skipped 6114 folios (either 4KB or 6=
4KB
mTHP), potentially reducing the swap-out by up to 92MB (97,300,480 bytes) d=
uring
the process exit. The working set size is 256MB.

If Zhiguo can add more test data from different (real) workloads, it
would be greatly
appreciated.

Thanks
Barry

