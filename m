Return-Path: <linux-kernel+bounces-388937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8069B6666
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B09C1F21B9A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC521F4714;
	Wed, 30 Oct 2024 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aV2PaoP7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C391F131B
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730299722; cv=none; b=cVPLYLuX3cWLFE35LDr4LPJ4ShACsvoRO4SddLQCA/pPLXbOVjEF2Y/U9ohSKMo9jRnpVpwo7vy2TD2WSB6BofTcNQ3DQrCmnto3E99URxk9Pvu/da3l2B38WjXF09GKXPAxCxMPTgYYVgQ7EXj6TkFyB5F2EMyofvODWOuLjLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730299722; c=relaxed/simple;
	bh=LpMMu2tW+v0eK2jTek+FUNY5ghd010WyUddw61A5pxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3IxezfkfcrSDn/bbyFQkUzujWrEmiUd8o2cQtiM1oLJSzOzApWQLLcCqh2MYwU1k4rOP04cTdVD32fza/Jv/dHAwuttFTOWI23Kzgnj9jejDMHRCKAuURuSBj2/fOBxE6O9/05EOuug0APDlX5nfb8+we33DPfx0nEQlu4i4Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aV2PaoP7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730299718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vIiqNGj0/lEgFzl4Mf1L3cqOhzMe2y2T4h2UU2CLbw4=;
	b=aV2PaoP7nX5Sl0zKpbD8GrxcnF0Dv+mHkXdmaKMhoYZRxNux9bo0tnDEvwlXOx9c8j2QNx
	w9dGl/ZoZT7x9MTRUBphsOwue6VqDKShxsgBUilIqrOVGkHnEoBeszqCDl+dC7igAkPq4P
	pAkYv3NLEEr9jly0jLdGPVr51XPZDWk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-rntquG6BPhiSzVr_xjBCew-1; Wed, 30 Oct 2024 10:48:21 -0400
X-MC-Unique: rntquG6BPhiSzVr_xjBCew-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d533a484aso553642f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 07:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730299700; x=1730904500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIiqNGj0/lEgFzl4Mf1L3cqOhzMe2y2T4h2UU2CLbw4=;
        b=RmJI1xPrCO75m35EzEzhSwypADcDMtj+GneYKLmsV8QlvQxmt12DO/35Q3I+xoz6oE
         rxOSbEyfx33Hpx3+j3Onxj6kH+slE2P7fIkgf6WAx8677Ip8Z82gx0HB0DO3xdVUdu80
         gioK2cl/2AZWoF214hMmMBq4iPvMw+w5IFBbf39WK2qEK0amVXnwb2QD1lmh5uJTPvWn
         eacdKNLgW1+w4wupAjX9T0sEGRhO7kbwd1AvidSrZ6nVdX8UW7Q/2N5jjVGTOl/PTWr3
         qSlj2ifGYdL4mjg2tcT5dStLbGHmPAiQRovOwCE9aUtiD9xBjYHeQQHa5VNrYHUNxdqt
         kKdw==
X-Forwarded-Encrypted: i=1; AJvYcCX7XNw+AKt4bOq4SOOASshehwrJZEnGRB39D50R8SgHEowvHuSlNfj5k8WEWxS98VdxnhLMb+i9v2/6fZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDcccgGZqhojp9nnjIP9b3aPw5emQnEILkOs3dC750+Qe+EsHa
	ML4EdDdY9cbDe4UMz4qPuJDT2tNWonu/LAiBZNxcXekhbT3cKedfckICtRiFWAI4UangpCFuv3o
	Aw9Bh6BSPtp+DLO1kikSQ5d5xyA0YF9jc/c+fb4fbL5NtQhRiZ6mVP8kHnfiXCnUyJXh8C10XG1
	FTeITmGxYygVn+DTzub0GZj3Xw7fHd0eawMOrj
X-Received: by 2002:adf:ec92:0:b0:374:c21a:9dd4 with SMTP id ffacd0b85a97d-3817d636ca4mr5614291f8f.20.1730299700594;
        Wed, 30 Oct 2024 07:48:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMIDA8EBgIVSRmKzeTJu8F00z1MEyGrcfLHRjfhN6WRVRP4EeuJk9Z2vLE/2TS04vqzHZtnvBUPW0FcKjQimY=
X-Received: by 2002:adf:ec92:0:b0:374:c21a:9dd4 with SMTP id
 ffacd0b85a97d-3817d636ca4mr5614274f8f.20.1730299700297; Wed, 30 Oct 2024
 07:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730118186.git.kai.huang@intel.com> <0b1f3c07-a1e9-4008-8de5-52b1fea7ad7b@redhat.com>
 <08c6bb42-c068-4dc1-8b97-0c53fb896a58@intel.com> <6c8bff1a-876f-47b7-a80c-3f3a825ddbc0@intel.com>
In-Reply-To: <6c8bff1a-876f-47b7-a80c-3f3a825ddbc0@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 30 Oct 2024 15:48:08 +0100
Message-ID: <CABgObfZWjGc0FT2My_oEd6V8ZxYHD-RejndbU_FipuADgJkFbw@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] TDX host: metadata reading tweaks, bug fix and
 info dump
To: "Huang, Kai" <kai.huang@intel.com>
Cc: dave.hansen@intel.com, kirill.shutemov@linux.intel.com, tglx@linutronix.de, 
	bp@alien8.de, peterz@infradead.org, mingo@redhat.com, hpa@zytor.com, 
	dan.j.williams@intel.com, seanjc@google.com, x86@kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, rick.p.edgecombe@intel.com, 
	isaku.yamahata@intel.com, adrian.hunter@intel.com, nik.borisov@suse.com, 
	Klaus Kiwi <kkiwi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 1:24=E2=80=AFAM Huang, Kai <kai.huang@intel.com> wr=
ote:
> >> Are you able to send quickly a v7 that includes these fields, and that
> >> also checks in the script that generates the files?
> >
> > Yeah I can do.  But for KVM to use those fields, we will also need
> > export those metadata.  Do you want me to just include all the 3 patche=
s
> > that are mentioned in the above item 3) to v7?
>
> for kvm-coco-queue purpose as mentioned in the previous reply I have
> rebased those patches and pushed to github.  So perhaps we can leave
> them to the future patchset for the sake of keeping this series simple?

Yes, I have now pushed a new kvm-coco-queue.

> Adding the patch which adds the script to this series is another topic.
> I can certainly do if Dave is fine.

It's better since future patches will almost certainly regenerate the file.

Can you post a followup patch to this thread,, like "9/8", that adds
the script? Then maintainers can decide whether to pick it.

Thanks,

Paolo


