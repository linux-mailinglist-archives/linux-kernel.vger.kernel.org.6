Return-Path: <linux-kernel+bounces-211341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B2190504D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31CC42829DB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270D616E89B;
	Wed, 12 Jun 2024 10:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="edRdgc+W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5A016E888
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718187600; cv=none; b=HE5yTipXhWdIb/V0wY/1uwQLlPsMrXJxuOgg78axqx/pm5ZkF1ruH0xJdlK9triILantjkerJX1oN/tSyo0pFAe7+i8RjWKcd6rhkSS1HdjXJNVqfgxPstTMm96PCg3c0IP9jDS58Cn1jkki5yNuXu8zctcq4WAJNivuk9BCdSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718187600; c=relaxed/simple;
	bh=DX/O7qdeD+FQnP5bOkwHHDCOlfBR2tLube9EHjIQaGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOh1DJTlz3cPFO8xFsQVdEWLsgzSWAZcYddASYJKNwP88NOAqNZWZydfnCJMQN8JDkmELJdu0cu3olCTYNIE4GabH/+P1cFSESkniDQYUj4ln25NcOU2hy3A4TGrKw1X4irdtDKgO5lKtmV+SpKU/oWH8wDE7tWrPZb1ZSNbzRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=edRdgc+W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718187597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rlCA4Ke/T+ZDAWf9BXbMMIWFjo2hQeBwjaAKfsSA+oo=;
	b=edRdgc+WbcCi1lEtNzXr+1Sf/noEvYTT0J9FE2KshFSkxODQPeygeCUcYQNGkjPeVl0Lxo
	bb1xA0PKAt/oohwc9IhiiWvOsL16sH/UQOhuwKdlQCaccqAp44sM325C8X2veQ4mb7Hy2F
	aUaMZ3Pu/P+4Nt6R85TygcACDsG0eLI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-DAfWww87PSGBgZDpzE4q0Q-1; Wed, 12 Jun 2024 06:19:56 -0400
X-MC-Unique: DAfWww87PSGBgZDpzE4q0Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3605cad23e0so226960f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:19:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718187594; x=1718792394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rlCA4Ke/T+ZDAWf9BXbMMIWFjo2hQeBwjaAKfsSA+oo=;
        b=dq1s8JmmjqudlF9ZvIt1LEk3aRkIvt0Syq2j4IkgpuzBXtrcEQemrO6BTqC0AJ/GYz
         HNYjCxj5C6Omvx2LW2zsP/yDEv6HdDykShzQmGaOxISk/JHOgGKwuCV6W50NGF6rrmwt
         JR75QAnSdHUVQCwL2Xtc8DQyKJtuaDTDAbdTmYa3R0gEg3tepDwJ4UUSuQJOzcrw5PiX
         pr1O6TgWU7FyW4nvmZ+1d0FJ4xSROfU0FYLEJ1bO4/GjkOWq0vhB/olhAJLdD/ZLWZul
         DAhOPouVgy86BzjYHAsK+MFl6OirqMxtPPOF90BEs4ctZw/UoiwbRRjhBzKEwmQhjFO+
         Bziw==
X-Forwarded-Encrypted: i=1; AJvYcCVi+p+0rMTxSEtE9zJPGH1WeFP0dvoNQuRfYhm+QjTn7EEOUQlBhMf0u4eKYKLMLdHC9r75SlvtCXrpggIoKUVTLnJ5rZWZ7pxEZbaf
X-Gm-Message-State: AOJu0Yz5lwGe6ELdnG+psxUEGtN14VoadnHd6gwcSaM6fQsZ9AnOGv1/
	qc2CcAOfC5kzT6uFTWCj0zhQAFphcLafVGahGNef01KClIY5gqrK+lMwIjFJIKnQCpq0P16xtwn
	HbndOxvZRDBE0rSGxF4Kr1YT43xP9UN2ntx3KdUJKJhA7MSALcCWoCbqS+9Izz0A2qcqG5Xy6TM
	7qhJYuX+5Ssy4Z0TboNAQPDImSUvxuVp281eIsAzxarIZZ
X-Received: by 2002:a05:6000:e88:b0:35f:2a56:5b79 with SMTP id ffacd0b85a97d-35f2b273b4amr4502037f8f.7.1718187594639;
        Wed, 12 Jun 2024 03:19:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZpg528uDd1HmlAAgn89ZTKSCBFChZd9Ec0DZSO29p+hI7l0SubcoOJXePMPSepx3Lew2dyQ/uR3zLtRgWLJM=
X-Received: by 2002:a05:6000:e88:b0:35f:2a56:5b79 with SMTP id
 ffacd0b85a97d-35f2b273b4amr4502019f8f.7.1718187594339; Wed, 12 Jun 2024
 03:19:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507133103.15052-1-wei.w.wang@intel.com> <171805499012.3417292.16148545321570928307.b4-ty@google.com>
In-Reply-To: <171805499012.3417292.16148545321570928307.b4-ty@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Jun 2024 12:19:43 +0200
Message-ID: <CABgObfZCNN4AdzGavqzFANCLq4E5pi+h2+mr9-cysZrFk6bUzw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] KVM/x86: Enhancements to static calls
To: Sean Christopherson <seanjc@google.com>
Cc: Wei Wang <wei.w.wang@intel.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 3:23=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, 07 May 2024 21:31:00 +0800, Wei Wang wrote:
> > This patchset introduces the kvm_x86_call() and kvm_pmu_call() macros t=
o
> > streamline the usage of static calls of kvm_x86_ops and kvm_pmu_ops. Th=
e
> > current static_call() usage is a bit verbose and can lead to code
> > alignment challenges, and the addition of kvm_x86_ prefix to hooks at t=
he
> > static_call() sites hinders code readability and navigation. The use of
> > static_call_cond() is essentially the same as static_call() on x86, so =
it
> > is replaced by static_call() to simplify the code. The changes have gon=
e
> > through my tests (guest launch, a few vPMU tests, live migration tests)
> > without an issue.
> >
> > [...]
>
> Applied to kvm-x86 static_calls.  I may or may not rebase these commits
> depending on what all gets queued for 6.10.  There are already three conf=
licts
> that I know of, but they aren't _that_ annoying.  Yet.  :-)

I think it's best if we apply them directly (i.e. not through a pull
request), on top of everything else in 6.11.

Paolo


