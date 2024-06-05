Return-Path: <linux-kernel+bounces-203193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FFD8FD7BB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20DE61C2337C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B4315F336;
	Wed,  5 Jun 2024 20:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D6nF7eOU"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D892115EFD0
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 20:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717620152; cv=none; b=OVlL2SsyMZZKdIlXFy+SVC0oasd9Tc6LJskziVIreSmr8LcaVUrxB/UPSgc4rmgLnhOgvDEnzYUGb8E20kxB4ezgv7JKguu4tHr0/11e+X0Q/bHW9iyaSZF7sptVKIQeqXJvhdztbTLkmUNB0ZRaErHTgm8PVHDqjtpi9Czb868=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717620152; c=relaxed/simple;
	bh=mrcPVHvvCNX9pKlb1e9kvFdVYrO4YyHw/Sk2tS356ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRKYUTYNHSzWg1+b7Vw7EuoaOtk8xQ39BvsIDsWEExINiIjlENykJXiNMadoi4ODAkcz0WdftE/HTJ6+WRDvbtZ2FRvJnNxF+dXGCaTgEkEFGqMqQYzR2ugcO/NZT3cZbXwufAPLsAh5jGdcDDLrZR+/VstY0VNizVdKdNp6MSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D6nF7eOU; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52b912198a6so349645e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 13:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717620148; x=1718224948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrcPVHvvCNX9pKlb1e9kvFdVYrO4YyHw/Sk2tS356ok=;
        b=D6nF7eOUd+P3MFAcTNFjBZ9XEspzyHLGN33kZ1plO9v/AWX4dD2BKINpOEghOPiSUN
         ch1rVIhXTkIZMuFk1QZzWJW5kcCOm4xRn1TTmKgaPwE1Obp+XoUtrhBFdXcvpAyot6ND
         Hl+bjFw7Hi70VFS0PJHVbmId9dxCASWFnrrXjI0EUuztwKfP2wWkHnh6xFfYFkYn2he8
         zpsxMLU1NoBqOiCAwIcB6HelXdPKVTs44db/L/78ZnPqKfMHDgeLjYQ+OZbFfjDvZwLE
         z5/tAuOLdb+H258ijN++wQxx5sRydmZxEf43WSLpfbXQhNUwxBakPecNmvVgyImACRt1
         kQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717620148; x=1718224948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrcPVHvvCNX9pKlb1e9kvFdVYrO4YyHw/Sk2tS356ok=;
        b=T5UGFMxSlOjoJPYjyCgCNJR2mWQJHfTLDZwSZem2idFONI47gnYR0CuymXcvoNew6X
         IK+3yQhEl3EGJyE2YDHYQ7EFqWxtA+rGFirOYSbVMBpz3CZcECt/TF9R83CXM08b5Bed
         OLmOnMyVcL4ws1+Q8GgKuzER7xXvVyHreU7HkdCQSjh1vpi7awauyFa3VgFJLwrKUZpt
         gmitL0+WSEnhT17b1/r30cGpdAbx2pG+EyjYZo6V+kBDmWvhG4IwAIgpr3MhQBqp7PI2
         0CS+EcHimmo/QkaKVCP2/fcvXBuIv8uKzfupnxd3A1ObrbqiENmqJYDN6ierDTBb7I1W
         GznA==
X-Forwarded-Encrypted: i=1; AJvYcCVO90SU8hm4fWH7SG0T1jCvkamomSC/9tMJ3pD21pKnBDoJ/HMBwqu7rJ81N6y+eyGiCc00LlKW1hDtFInYGr3zwuHETrqzTexsear/
X-Gm-Message-State: AOJu0Yy2SmF9Cwa5RWpcLCRg9UhxmqAGc/F/0MzMYS3XA8d4QK4MkSJ3
	MzRlvoZJPc7KuhXN5DFLUhpisbSGi2E+8AgaONk+64t28p4uFXPozAnDhda+rI8UN705k2lX+e0
	WdDeMuUqnd+idlm8bohut2uce+KhCVjGUcXdr
X-Google-Smtp-Source: AGHT+IGmCpgKWs9HzI7BHjD0N+cxvlO675UiwlocG7NwR6PK+YVSsXxsmetDw/kfR1C4ad6r/GOAH4AIlHrJieXNb3c=
X-Received: by 2002:a19:ca59:0:b0:523:8723:32de with SMTP id
 2adb3069b0e04-52bab5078f6mr2278150e87.53.1717620147678; Wed, 05 Jun 2024
 13:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com> <ce967287157e830303fdd3d4a37e7d62a1698747.camel@intel.com>
 <CAAhR5DFmT0n9KWRMtO=FkWbm9_tXy1gP-mpbyF05mmLUph2dPA@mail.gmail.com>
 <59652393edbf94a8ac7bf8d069d15ecb826867e1.camel@intel.com> <7c3abac8c28310916651a25c30277fc1efbad56f.camel@intel.com>
In-Reply-To: <7c3abac8c28310916651a25c30277fc1efbad56f.camel@intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Wed, 5 Jun 2024 15:42:16 -0500
Message-ID: <CAAhR5DH79H2+riwtu_+cw-OpdRm02ELdbVt6T_5TQG3t4qAs2Q@mail.gmail.com>
Subject: Re: [RFC PATCH v5 00/29] TDX KVM selftests
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc: "vipinsh@google.com" <vipinsh@google.com>, "Aktas, Erdem" <erdemaktas@google.com>, 
	"shuah@kernel.org" <shuah@kernel.org>, "Xu, Haibo1" <haibo1.xu@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Afranji, Ryan" <afranji@google.com>, 
	"dmatlack@google.com" <dmatlack@google.com>, "seanjc@google.com" <seanjc@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "jmattson@google.com" <jmattson@google.com>, 
	"Annapurve, Vishal" <vannapurve@google.com>, "runanwang@google.com" <runanwang@google.com>, 
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>, "pgonda@google.com" <pgonda@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 3:18=E2=80=AFPM Verma, Vishal L <vishal.l.verma@inte=
l.com> wrote:
>
> On Wed, 2024-06-05 at 20:15 +0000, Verma, Vishal L wrote:
> > On Wed, 2024-06-05 at 15:10 -0500, Sagi Shahar wrote:
> > > On Wed, Jun 5, 2024 at 1:38=E2=80=AFPM Verma, Vishal L <vishal.l.verm=
a@intel.com> wrote:
> > > >
> > > > On Tue, 2023-12-12 at 12:46 -0800, Sagi Shahar wrote:
> > > > > Hello,
> > > > >
> > > > > This is v4 of the patch series for TDX selftests.
> > > > >
> > > > > It has been updated for Intel=E2=80=99s v17 of the TDX host patch=
es which was
> > > > > proposed here:
> > > > > https://lore.kernel.org/all/cover.1699368322.git.isaku.yamahata@i=
ntel.com/
> > > > >
> > > > > The tree can be found at:
> > > > > https://github.com/googleprodkernel/linux-cc/tree/tdx-selftests-r=
fc-v5
> > > >
> > > > Hello,
> > > >
> > > > I wanted to check if there were any plans from Google to refresh th=
is
> > > > series for the current TDX patches and the kvm-coco-queue baseline?
> > > >
> > > I'm going to work on it soon and was planning on using Isaku's V19 of
> > > the TDX host patches
> >
> > That's great, thank you!
> >
> > >
> > > > I'm setting up a CI system that the team is using to test updates t=
o
> > > > the different TDX patch series, and it currently runs the KVM Unit
> > > > tests, and kvm selftests, and we'd like to be able to add these thr=
ee
> > > > new TDX tests to that as well.
> > > >
> > > > I tried to take a quick shot at rebasing it, but ran into several
> > > > conflicts since kvm-coco-queue has in the meantime made changes e.g=
. in
> > > > tools/testing/selftests/kvm/lib/x86_64/processor.c vcpu_setup().
> > > >
> > > > If you can help rebase this, Rick's MMU prep series might be a good
> > > > baseline to use:
> > > > https://lore.kernel.org/all/20240530210714.364118-1-rick.p.edgecomb=
e@intel.com/
> > >
> > > This patch series only includes the basic TDX MMU changes and is
> > > missing a lot of the TDX support. Not sure how this can be used as a
> > > baseline without the rest of the TDX patches. Are there other patch
> > > series that were posted based on this series which provides the rest
> > > of the TDX support?
> >
> > Hm you're right, I was looking more narrowly because of the kvm-coco-
> > queue conflicts, for some of which even v19 might be too old. The MMU
> > prep series uses a much more recent kvm-coco-queue baseline.
> >
> > Rick, can we post a branch with /everything/ on this MMU prep baseline
> > for this selftest refresh?
>
> Actually I see the branch below does contain everything, not just the
> MMU prep patches. Sagi, is this fine for a baseline?
>
Maybe for internal development but I don't think I can post an
upstream patchset based on an internal Intel development branch.
Do you know if there's a plan to post a patch series based on that branch s=
oon?
> >
> > > >
> > > > This is also available in a tree at:
> > > > https://github.com/intel/tdx/tree/tdx_kvm_dev-2024-05-30
> > > >
> > > > >

