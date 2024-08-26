Return-Path: <linux-kernel+bounces-302115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD57795F9FD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F9A51F23A43
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3772B19939E;
	Mon, 26 Aug 2024 19:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QrUB/67R"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180AE1990C9
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 19:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724701871; cv=none; b=MQKdGhtHQI8JWdSN/GlEYGdKRiucLGAjmymUcsDu+yE3LIoBDUtP9gLK438kDRDWk/g6OYStNP6mf424Cqei1vBKw+bmkFe8sAiK+DgE53maGIvFzkiTyaHo2pD7VLlj8SepT7XkT2CkfV+lDXL1CzqPvdQQYcNqbuOyRIN05o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724701871; c=relaxed/simple;
	bh=1lrnyRzbtxYYhUwK4ba/ZKRhDHGQiFQ8Z1LYImaqbX8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kYvhVek9AQCtL391xOfZHbSwejedAolduyJyLezCC/gMA9HEFYxlC04YNGVEnvhEAtURWfu3kQNY6p+T1S1kODr9TrTUItZXiRD0ZYXO7gu+2T8QA3hbrjBoW101ySYtKH0u8e9mqjaBYZ2xtz1IHG2yBAJsAAan+HB2Tk0nlz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QrUB/67R; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6af8f7a30dbso102429067b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 12:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724701869; x=1725306669; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WGrnUp8Xwg0REn6d4LZhZQlXIkH16FDlkRqK3bPfpi8=;
        b=QrUB/67RkCHCfSKlls7gNk8HF0rKAVU0lBXZZI/WoixIABrbX8z5MuSPxFWoMSTcCT
         Lotd41kfaqO/MEcVWpdBV13afr0wg9OKnuunzPl2LerGPGQSft3aE/zZUj00PIZEnvU2
         3SE8G4f4wpFWekfqLjTnU46Q37hXMVeuNuG3kZ18VHW0MWme1W1RT6WR9m3UKFGlGTs9
         pDMPL1ZBQ29To0vtzp+dr7Xk/viRITzRkYwhS5xvfhDu7wSy4ZG/kNfU0auLcUdQFboq
         RB7aBwcB+tiZOkYp8REiCVZS3aOnS3OBMrPHv9Ohde+5Ude7qhlJEYWZ1l5sszKK5A1Y
         6Lxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724701869; x=1725306669;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WGrnUp8Xwg0REn6d4LZhZQlXIkH16FDlkRqK3bPfpi8=;
        b=QWr1gxidwapBXFzycA9RbMPfjvYbjoyQ+RJzbcrggYMZ+sVyHWEecHF/0OBARIke9Y
         UsPvf2OZzbfRKKDAY4x7+JOb/+66VjB6W5DBOSZSawUO6AR1lwOCyXkiP9JeWtUUpplZ
         f4q9FR+HN7qyykRgH5Voonc3aVcjs19xEGPnmV6ZiE0n+TKssJcAbyxYEflmgI2u9jas
         zySS0u6dl30ZATAtnN+WboKW4m+IqECUvxNxdpNUPkAOskp1KsmZ8WdRZIYfM5/uNw2K
         qVIc9W3mOsX3KVwOA3SDQmyAM9AGcKpQslkJn9KSdOEh1yfL/upcMVOnv9XEWy7+CW6e
         zu8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmJGjWBDpLjMpxnoGWLG4wILO+JzRNLWaJSLUDzxXvUFZ+sqJsrYdo5JzKlw0Tr4pZNNW/khPn2N7uv7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8OZULhiaHz2sddtoVMnCiomwcuRFjyFU5aVBhqUFr+id0HgZD
	ryDXvt5hbgpmL5rLOwHE3BMFfq/LrrO5jJf81khouS6+IdxBaEOK6OKsc1h9xWl4uYF+W2V3DvB
	isQ==
X-Google-Smtp-Source: AGHT+IH/Zuqw1ujrR/jPyT0El2M0tj5hlr7qZxJnmCW/OfD5Gh4Y1liekhruzHNR5+NRxWBVcI/buxohyNM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:ad28:0:b0:6ad:6e98:9ada with SMTP id
 00721157ae682-6c61e905000mr1441117b3.0.1724701869024; Mon, 26 Aug 2024
 12:51:09 -0700 (PDT)
Date: Mon, 26 Aug 2024 12:51:07 -0700
In-Reply-To: <20240826192410.GA2182008.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812171341.1763297-1-vipinsh@google.com> <20240812171341.1763297-3-vipinsh@google.com>
 <Zr_i3caXmIZgQL0t@google.com> <20240819173453.GB2210585.vipinsh@google.com>
 <ZsPDWqOiv_g7Wh_H@google.com> <20240823223800.GB678289.vipinsh@google.com>
 <ZsySe8tpDyZAvb6l@google.com> <20240826192410.GA2182008.vipinsh@google.com>
Message-ID: <Zszcq2Bzt-mEnAbQ@google.com>
Subject: Re: [PATCH 2/2] KVM: x86/mmu: Recover NX Huge pages belonging to TDP
 MMU under MMU read lock
From: Sean Christopherson <seanjc@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: pbonzini@redhat.com, dmatlack@google.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 26, 2024, Vipin Sharma wrote:
> On 2024-08-26 07:34:35, Sean Christopherson wrote:
> > > 	} else {
> > > 		/*
> > > 		 * Try again in future if the page is still in the
> > > 		 * list
> > > 		 */
> > > 		spin_lock(&kvm->arch.tdp_mmu_pages_lock);
> > > 		if (!list_empty(&sp->possible_nx_huge_page_link))
> > > 			list_move_tail(&sp->possible_nx_huge_page_link,
> > > 			kvm-> &kvm->arch.possible_nx_huge_pages);
> > 
> > This is unsafe.  The only thing that prevents a use-after-free of "sp" is the fact
> > that this task holds rcu_read_lock().  The sp could already been queued for freeing
> > via call_rcu().
> 
> Before call_rcu() happens, that page will be removed from
> kvm->arch.possible_nx_huge_pages list in handle_remove_pt() via
> tdp_mmu_unlink_sp() using kvm->arch.tdp_mmu_pages_lock.

Gah, my bad, I inverted the list_empty() check when reading.

> Here, we are using the same lock and checking if page is in the list or not.
> If it is in the list move to end and if it is not then don't do anything.
> 
> Am I missing something else? Otherwise, this logic seems correct to me.

Nope, poor code reading on my part, especially since the _move_ action should have
made it obvious the SP is still live.

> Overall, I will be using your example code, so you won't see this code
> in next version but just want to understand the concern with this else
> part.

