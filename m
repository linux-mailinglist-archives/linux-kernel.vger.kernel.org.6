Return-Path: <linux-kernel+bounces-570783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FA3A6B473
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A193B94FD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948181EA7CB;
	Fri, 21 Mar 2025 06:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f1HcnKyP"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736631EA7C8
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742538841; cv=none; b=Io+0WdRj2t6GJmxwoeYAaR4Kkp16521j456N4qwWAGps5Tv9E+MWtgSBGlKOof6DI8sb31l7AA+a68TSbPL+C6gSCLUxc1/uLbkDr7bHU9ivt4xjlh4a9Hr7oHsYDqNrQsxyluyPuv3z1FndL6kbEo8GpqE5KGQgdrL6IyCPhiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742538841; c=relaxed/simple;
	bh=p+BeBYr/HsChaQPBxFfb4II6h0aToEIbjR66q03/zjY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LN+j4g4os8Bo5oBkAOi5Hgv3fuXxxbYFWyvW3+WvaUNHK/7tyCpRucwbI8x88x7NldApYi2vd5IvuSkb+HyN3PpF4cS51Febo6veDxuk+klqtjBYXwNPbEDX0ypJpwaXEoHZcIzrzf6yL/CcrRdye/S+46X+eqsJz6Spmb0jXQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f1HcnKyP; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff5296726fso4549354a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742538839; x=1743143639; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2vXAyj+GHzS7wqAccTE1NbTCMIzG8yR1/7SBWPdH7m8=;
        b=f1HcnKyPwhB6MkZnuwVpEnjplSRSd0rLe3xdI5CXl0JaHyK3RTNmnIuue6bF0CGcIn
         lTN6RSgUfDmGf9eFeKy+FjahHDA/+YdDoQlqj29PYHKYIi38F6P2u27JAikxASye1oJF
         9f8RbdobPNslzwxlOarPTDH2xLytW7/8HgxghD9CKp98sZXGdoUHpwMDWrVM+E7iPbJT
         H/4pDYkmiekiEc8Oz0pQtoxaYgbBfmh0SVZIYPaLn2eG86nxdFsFRLH0yweak/t2Qynt
         Paay/8djMxAmua+wj5sx9S9Dym4n2lZqeRxzlCyeFXmexIWdTsLMLXja8rokU3z8w2O/
         HUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742538839; x=1743143639;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2vXAyj+GHzS7wqAccTE1NbTCMIzG8yR1/7SBWPdH7m8=;
        b=LKqfqk9DnCqFweM//oYOXEV5X0kl6yyPABAF9NX/RJ5WxR/6n4377B85g9PgS2HPUo
         ztLEeVxkShaGBBYq5Mk15ayuQfm9JgGnqlUrQxwJ14Ux31nCrtzV++gymc+FhHuHe4CN
         AyNgDdhNAlyUGG2LRwGsAsHbgizzzW7H6y6A5KwanD4UlezFxPz5HlmcATDSo3DFUQcf
         IdxeQRbO6THogWIv//INaRozxmoJ3vgBAlQA0w6oLhuTaOBz5YLAgeGJRdAkc0WL4UlG
         vtXJTozhmGffUmxm789ZaIzhMGOcUcJSbRChSY+eYT+aslKRSllgL52phReyguA2/Y8O
         xaSA==
X-Forwarded-Encrypted: i=1; AJvYcCVl5GqldwiZgTkzbBJvK+IqNSqAE296I2XweUfTQzHNhI291AFvZdRR2ec/9GKDeNjBjRdu/iG/ZzI6PDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhTPfUsgxkGDz8AgNI9N8fGw4t3g/ms8QOifrE7K0WzG8PF8un
	qfAayUl5xLnFbaKu0s6p6N20fiGXFqkrtc06BSdkIJ8iVSU2MH6156pSGfMuskgPNPQPW8RRdM9
	iahyduSbHKfF4Syos3A==
X-Google-Smtp-Source: AGHT+IHzfqXaz88vnwbh1bU3QQ0eg9cO7MjTqz+i1yp3jt6YPQs5uqsY4Klq/6OgfyRjy5OLLCoj7DrCd0HOjDbw
X-Received: from pjbsk8.prod.google.com ([2002:a17:90b:2dc8:b0:2fc:2ee0:d38a])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1848:b0:2ea:bf1c:1e3a with SMTP id 98e67ed59e1d1-3030fe9e646mr4063011a91.12.1742538838726;
 Thu, 20 Mar 2025 23:33:58 -0700 (PDT)
Date: Thu, 20 Mar 2025 23:33:56 -0700
In-Reply-To: <87wmcj69sg.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <87wmcj69sg.fsf@trenco.lwn.net>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321063356.381646-1-changyuanl@google.com>
Subject: Re: [PATCH v5 16/16] Documentation: add documentation for KHO
From: Changyuan Lyu <changyuanl@google.com>
To: corbet@lwn.net
Cc: akpm@linux-foundation.org, anthony.yznaga@oracle.com, arnd@arndb.de, 
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, changyuanl@google.com, dave.hansen@linux.intel.com, 
	devicetree@vger.kernel.org, dwmw2@infradead.org, ebiederm@xmission.com, 
	graf@amazon.com, hpa@zytor.com, jgowans@amazon.com, kexec@lists.infradead.org, 
	krzk@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	pasha.tatashin@soleen.com, pbonzini@redhat.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org, rostedt@goodmis.org, 
	rppt@kernel.org, saravanak@google.com, skinsburskii@linux.microsoft.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan,

On Thu, Mar 20, 2025 at 08:45:03 -0600, Jonathan Corbet <corbet@lwn.net> wrote:
> Changyuan Lyu <changyuanl@google.com> writes:
>
> > From: Alexander Graf <graf@amazon.com>
> >
> > With KHO in place, let's add documentation that describes what it is and
> > how to use it.
> >
> > Signed-off-by: Alexander Graf <graf@amazon.com>
> > Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Co-developed-by: Changyuan Lyu <changyuanl@google.com>
> > Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> > ---
> >  .../admin-guide/kernel-parameters.txt         |  25 ++++
> >  Documentation/kho/concepts.rst                |  70 +++++++++++
> >  Documentation/kho/fdt.rst                     |  62 +++++++++
> >  Documentation/kho/index.rst                   |  14 +++
> >  Documentation/kho/usage.rst                   | 118 ++++++++++++++++++
> >  Documentation/subsystem-apis.rst              |   1 +
> >  MAINTAINERS                                   |   1 +
> >  7 files changed, 291 insertions(+)
> >  create mode 100644 Documentation/kho/concepts.rst
> >  create mode 100644 Documentation/kho/fdt.rst
> >  create mode 100644 Documentation/kho/index.rst
> >  create mode 100644 Documentation/kho/usage.rst
>
> I will ask again: please let's not create another top-level docs
> directory for this...?  It looks like it belongs in the admin guide to
> me.

Thanks for review the patch! Sure I will move usage.rst to
Documentation/admin-guide in the next version.

However, I think concepts.rst and fdt.rst are not not end-user oriented,
but for kernel developers of other subsystems to use KHO API (I also plan
to include the kernel-doc generated from kernel/kexec_handover.c and
include/linux/kexec_handover.h here in the next version).
Should Documentation/core-api be a better choice?

Best,
Changyuan

