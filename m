Return-Path: <linux-kernel+bounces-274979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1EB947F0C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83DA41C21F54
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B7915B102;
	Mon,  5 Aug 2024 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jMzs07tI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6560376F5
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 16:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722874569; cv=none; b=EuAVHE8OtN59tcCFqRSUud41dzHOFml3Js0McTOZ6sFH82MIKYrDKT2yWJPtD6heb8SOPEErA58kce5PrVc+Da/dU/Y2s68VNgD6gunLJY0mh9aTP3KKVfD8pQrNQ+ybD/Cbmhl4IfRqLvmSjSR3kWkdgHwRuWIR0zV6J/yHyi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722874569; c=relaxed/simple;
	bh=r5pIys42IhQJQx8lEuqa51IL1PswrZiBgK+zrZ994p8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KXpsBtBIKj2P8PpCdeYmMvulJ7NftfkJ/awdUOThUnD/+AcQAMxMwvKPprrUb4x0Rc5mOP6jxd5r1kNy5cGleVtGmYfwV8H1uadtou9ObLvoj0iPZdg6wYG15Nu4ZvJe0yu0HG/9X62/JwMYX5JgZ+yOOTOpzrMuDIX+RP5ViZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jMzs07tI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722874566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r5pIys42IhQJQx8lEuqa51IL1PswrZiBgK+zrZ994p8=;
	b=jMzs07tItwYw2xM/vT7+ULLrguTToy+0mENvEsHxoBzrCo0QCJcUlYHGXxMuLumFChwEe8
	v63u84awnLoramMkqvX7XVGzeiYtkr3D5Wmn+Lkc8tCqXYockCs01sW8pzFqto06wetMJb
	AOQTfihp4NiaQd8iPiYqO7gWajv5ZvY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-QhlsaCv9PeyFLocB2lk9aw-1; Mon, 05 Aug 2024 12:16:05 -0400
X-MC-Unique: QhlsaCv9PeyFLocB2lk9aw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-369bf135b49so3245610f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 09:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722874564; x=1723479364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5pIys42IhQJQx8lEuqa51IL1PswrZiBgK+zrZ994p8=;
        b=xQ19vm3GC0RJoPQyb6mGLCKG/BVvuF5jigggiqC1mMpXtboiy09ihlkNBE7xQVAggS
         0VV/QLAcw07eUPBG8GDsHYUyIQgYFDq6j332bhMzDvGFZeftiXI1XdatOUz5MHRe+Weu
         v1DPnrnk+8RsCRXOWRAUefuFnTc7ZUt4bSkqgERqbyFTEHsoG/oTL9ieXdgT+vAw+dHh
         v8RwhPU17jwwiy1HluJaERibs4+FTMBxCS1eM06Q6QZhjiSReaWbdA3M05DZVE26EJwA
         c3Lgb3U2EZEegIM3fvRIqJIb2IHRbfboRjDY+FIKI1j0jxAxTe4C/mDXBLGZsyDPueqF
         Ywzw==
X-Gm-Message-State: AOJu0Yw/7MCcqX67Fp6n0uEjGF16q1HPF/nR7YOwHKCOgF+ow+BNFifF
	3ezdwHYMDd5NeEB+PeCHRp37u0WFFeNV3azKsC70pcJ9+Q5IZssSVhMcZbkRUDpcc9MSEvvRRrE
	P/7g+CzJswppzbWfrAyfLxU4MwPmjof4WBafWKCiuWghGtsb99vIkQOcX2mhHLehrpxJk+Gc0LD
	gaQuzvme50vilXrdmy70FDcbihtHUD/qhuwune
X-Received: by 2002:a5d:6509:0:b0:362:4679:b5a with SMTP id ffacd0b85a97d-36bb35c1044mr10943098f8f.16.1722874564194;
        Mon, 05 Aug 2024 09:16:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGoDUslpHNhBcD4mtah+s+5GapLBs0+T4OFuy93L7cRZBRdKVT+DOqnAwk1xDGdCxC5wkRLOcdJ+TnY7mRCas=
X-Received: by 2002:a5d:6509:0:b0:362:4679:b5a with SMTP id
 ffacd0b85a97d-36bb35c1044mr10943075f8f.16.1722874563692; Mon, 05 Aug 2024
 09:16:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801235333.357075-1-pbonzini@redhat.com> <20240802203608.3sds2wauu37cgebw@amd.com>
 <CABgObfbhB9AaoEONr+zPuG4YBZr2nd-BDA4Sqou-NKe-Y2Ch+Q@mail.gmail.com> <20240805153927.fxqyxoritwguquyd@amd.com>
In-Reply-To: <20240805153927.fxqyxoritwguquyd@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 5 Aug 2024 18:15:51 +0200
Message-ID: <CABgObfY0zt3NttX=bb2-1kThEAt_OhEn9pMdGZBSpH+aiibGig@mail.gmail.com>
Subject: Re: [PATCH] KVM: SEV: allow KVM_SEV_GET_ATTESTATION_REPORT for SNP guests
To: Michael Roth <michael.roth@amd.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 5:39=E2=80=AFPM Michael Roth <michael.roth@amd.com> =
wrote:
> > (And is there any user of query-sev-attestation-report for
> > non-SNP?)
>
> No, this would have always returned error, either via KVM, or via
> firmware failure.

I mean for *non-SNP*. If no one ever used it, we can deprecate the command.

Paolo


