Return-Path: <linux-kernel+bounces-281441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8909C94D6FB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F97B1F23260
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654F2167D83;
	Fri,  9 Aug 2024 19:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CFhY4uBj"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6173214D29B
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230277; cv=none; b=IbXA1PRlj9Elw/JrgSDwj2ly1Q3cux/9uxM6mwWXTaDnw5y/+lOwOjQixrugKf7bRcrPyDc0v7teLNC36dXCx2nMo+KOXRQSKMw+CFUMI4GpCYP+AZqcWFiSC4oKboUzLGSJ4rOCDmaMaPUNqlTJsTNaLVbb2gdooDVxBxBa3I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230277; c=relaxed/simple;
	bh=SBsyicGTG9gfAjD0K++NNapLlsd6aU+7cGu4LmewABI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RglsImruFH31ML/1qFVDpgFbCHFopQ5b/mP+uaYmnWSfgv1McjZKJqeBxKeR0K2hXrpH/BHeDJkdHuEPS+e1wb3AKul6B5yaH00BFTVLVd8IQ32uIGpHBCERa+3Fz82v4AfgONEsDIFIWqAzEZcaIuwX9XSRiSKpFtw2ixII4sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CFhY4uBj; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2cb685d5987so3028226a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 12:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723230276; x=1723835076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1OP2TrkQAg4l9VmYgH+ppUrAs3PZd5BTHpl5JP294L8=;
        b=CFhY4uBjLHNhZcHYRHzsb0OKRfXdxFvToX0xcnKc0h0k10Y5bDULBkxyTeVv2hfNbD
         uPu+A0zytU3hQIdhVENJvLIHTygKzjRRNo6PdxQBy0coNqD0vIB89pNssdfAqT4/8BSO
         EvBsv38o6WG7fSE5CWn1UK6zGNtsnpfQc9kXL0uXNd2cqY/ousHFYgeLgrVCu9VL9WmX
         yBxz+/O4FAtxVKNsu5tqH+aiPlf9f6IpwloBx0XAi303d++yf6Pj3kxFn/H8RYWfSR2Z
         3/282atP5Em3Wjj+nzcH6O4Qv3gAhNeW674C0t81DmX5lP+fZzmRnEYFEN3SzCONPDaz
         +HBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723230276; x=1723835076;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1OP2TrkQAg4l9VmYgH+ppUrAs3PZd5BTHpl5JP294L8=;
        b=OioqB8tlq+isoeC3wgv4QEFPez/n+Q2tPFQLCxPpi4CxzftDyT6vgfThl6fHWMPqTQ
         TyIlM1fWeEd0sq62dw3NrqvagIPrXmmIHZ1erEAJaCjA7P4mutGHahNDNzpAd8eN73J7
         oq/T2rwjLcURpHhNAqU8mXuJMczd65ETt2FFscEGJm6v5fc9KJbWghZZ1udbsJilHI6c
         tsMhfk6/9fKptzwVKdVq9mi+N+PlcUHme7SobGwkwqyKmj7vaoz5eidmVPZ8qjS+LDE8
         uOcjJl1VspjORlZ0oicpAJgMukqANxtqOP9+qO5F2sCDZP+DWu1RUL9w/Tx1xtPGILk6
         LYRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXm19TffFtgdszf52XCWuc5e3DWT4f+RMzPihaBVse2Q0ggsK+TFu3xztar5XwPj8o9bX40Pm+UMmEEX0TcxdGRz/EkpttVM28MuBG
X-Gm-Message-State: AOJu0YwCFTQRb3h5SuUfFisu1Z4szQ7hbhKozJrGrI/OTIrbhZ5RbD4G
	GnXpCwmJMy0DYzZ1CzjMVXSJUeQPOl7/nzctk78PbqR/monolgwLr9W8wNDibLppjJLAOav4k28
	P1w==
X-Google-Smtp-Source: AGHT+IHhyrWGwABBPnK3P+PXk3XqbI8YZLVeMIPiph5Olb+oYKw7B2dpfLQyExK13fUsFXUwAeZdgkDC2W8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:60b:b0:2cd:57fc:1db6 with SMTP id
 98e67ed59e1d1-2d1e7c5e18dmr25038a91.0.1723230275593; Fri, 09 Aug 2024
 12:04:35 -0700 (PDT)
Date: Fri, 9 Aug 2024 12:04:33 -0700
In-Reply-To: <DS0PR11MB6373A1908092810E99F387F7DCBA2@DS0PR11MB6373.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801224349.25325-1-seanjc@google.com> <CADrL8HXVNcbcuu9qF3wtkccpW6_QEnXQ1ViWEceeS9QGdQUTiw@mail.gmail.com>
 <DS0PR11MB63733F7AEC9B2E80A52C33D4DCB92@DS0PR11MB6373.namprd11.prod.outlook.com>
 <CADrL8HWH3d2r12xWv+fYM5mfUnnavLBhHDhof0MwGKeroJHWHA@mail.gmail.com> <DS0PR11MB6373A1908092810E99F387F7DCBA2@DS0PR11MB6373.namprd11.prod.outlook.com>
Message-ID: <ZrZoQZEfTffvVT75@google.com>
Subject: Re: [ANNOUNCE] PUCK Agenda - 2024.08.07 - KVM userfault
 (guest_memfd/HugeTLB postcopy)
From: Sean Christopherson <seanjc@google.com>
To: Wei W Wang <wei.w.wang@intel.com>
Cc: James Houghton <jthoughton@google.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Xu <peterx@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Axel Rasmussen <axelrasmussen@google.com>, David Matlack <dmatlack@google.com>, 
	Anish Moorthy <amoorthy@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2024, Wei W Wang wrote:
> On Friday, August 9, 2024 3:05 AM, James Houghton wrote:
> > On Thu, Aug 8, 2024 at 5:15=E2=80=AFAM Wang, Wei W <wei.w.wang@intel.co=
m> wrote:
> There also seems to be a race condition between KVM userfault and userfau=
ltfd.
> For example, guest access to a guest-shared page triggers KVM userfault t=
o
> userspace while vhost (or KVM) could access to the same page during the w=
indow
> that KVM userfault is handling the page, then there will be two simultane=
ous faults
> on the same page.
> I'm thinking how would this case be handled? (leaving it to userspace to =
detect and
> handle such cases would be an complex)

Userspace is going to have to handle racing "faults" no matter what, e.g. i=
f
multiple vCPUs hit the same fault and exit at the same time.  I don't think=
 it'll
be too complex to detect spurious/fixed faults and retry.

