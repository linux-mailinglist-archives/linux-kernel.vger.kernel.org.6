Return-Path: <linux-kernel+bounces-177891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF548C45E5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 186EAB20914
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E3E20DC4;
	Mon, 13 May 2024 17:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Px+H+TfI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A521CA89
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 17:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715620869; cv=none; b=b7hh4q5eUmfInyCG4xtp/EoKC+nmkC0sdz3lU+30qQ+keBdXLn2KJYlHEaFjP5IapqJAXK0otQHyL2L+3moihyl0ASnfq+OLO53q0Pkmve25jTNRx1pxFr5mXFtSftJ/rdK+OnCYXbUfbRZJW0cUBBi3xf4jmZ/jzZtQxIMK2/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715620869; c=relaxed/simple;
	bh=4cY9MtXU2I4telm66R69VUj9RASu9tfSf8B/kojAaNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M/UC90nLytgPeDRlOs6IjvJdoPeDz+kR/SlscuKC2QNf06sbHQXy9vNeimPGtKBigg3gMgLeIJnSWlVFmv1ZFfX1TWESFNQ4flHrVYHulBY0vPRBGKOme+7GwYjdqVD5LvxacQLKyijLzTIJ/2QNmBU1ax3g9KmpVYODFcG5OfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Px+H+TfI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715620866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lFetHttmrSPEk8iB/RIqp6UII+/zXMI6LYRqsBUqiFc=;
	b=Px+H+TfI7JfxYy49DEOWW+wlPuuZ/z3UurkwmjUA59rZgi4UpUx/AjucL+Sn1dp0QrAJx9
	H37k44ttod0onK8+Eq0Pr/a6ua9/wTj0TGdqa54qpcmeuXnMlMigYcSflA9PpKiZjm/tJc
	xv6jy5cs9H/0EMA4QnsFaGNjvWwacQg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-hycillBbMBaKK8yez8_kZA-1; Mon, 13 May 2024 13:21:04 -0400
X-MC-Unique: hycillBbMBaKK8yez8_kZA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41fe329e720so21947535e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 10:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715620863; x=1716225663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFetHttmrSPEk8iB/RIqp6UII+/zXMI6LYRqsBUqiFc=;
        b=HQQFVPLyyZ5u1k2mpLqRKyoz6B2Y3JyWrZrQP8/0ALTbJ4kqavqgowJWeSEKJzI3l3
         mvsFoo+pYfBtsIr/+D1v1MwTjQZoQguy6g0JuWdNzCCZ8tpveTFpK4Q48J6O+qVIj2eA
         NDGKg9RrqLYwJJ8Up1jvKvvAAw7dpFaBcjHQISF1HPDCYkYfBa902/MSw3siCHT6h5TA
         1izJA5yKiknkTgnmsX0XJGa0R8CaCoYG6/NqRhcmppG5pj7FtKHdC+U1q5gNhMq+D5aU
         4SjwNEktFj70yA2zI68+u1vFxtcft89+Rm1HSyG/j3s0frRiJ4RIZPiPr0+2FcAMAZXP
         vBxw==
X-Forwarded-Encrypted: i=1; AJvYcCUutapAca4rQSdynJPtJJsk+Hlv2193rBahM8fY2dlXtrr86ORUNFO9zr6WSFP73BuU1nhiORwNl3t9seGUmXrM/7R/UVuw5wuCvt/Q
X-Gm-Message-State: AOJu0Yyij4Wi8ditZoyLCvlr3XiJHMlKKBnbjvFpMlTO79pUj7I730wK
	4/ZNMmMDwslVm1V0u5s61+IBWqgbnXSrDPSQU/8E3br3FwRI6hMCEeg95dLOOsnn6d7jaoGZmEJ
	N7HkOBwaKt01s2EatN05whATh2OTF7ZFh26Bo1MqnXmOMM5ditc/QKYqkEgxr8l05MIMP5f2eT3
	Wo3kEauzKduAMEp36+PbbW1xoBSJsLnJEgJuoo
X-Received: by 2002:a05:600c:3582:b0:41b:143b:5c2d with SMTP id 5b1f17b1804b1-41feac55195mr86486935e9.28.1715620863689;
        Mon, 13 May 2024 10:21:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+7klRRXayuHxgQuN4xrnk2PibSO57rwQTkXNO9jJpJsh5eowNn5cZ4BTWrNPZBX2tLF3nvF6BA/OvQNnQl1w=
X-Received: by 2002:a05:600c:3582:b0:41b:143b:5c2d with SMTP id
 5b1f17b1804b1-41feac55195mr86486845e9.28.1715620863376; Mon, 13 May 2024
 10:21:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510211024.556136-1-michael.roth@amd.com> <20240510211024.556136-19-michael.roth@amd.com>
 <20240513151920.GA3061950@thelio-3990X> <0ceafce9-0e08-4d47-813d-6b3f52ac5fd6@redhat.com>
 <20240513170535.je74yhujxpogijga@amd.com>
In-Reply-To: <20240513170535.je74yhujxpogijga@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 13 May 2024 19:20:52 +0200
Message-ID: <CABgObfY0SEjdnNbXqeFyht4FWSf8joW8-zVS1qJ8HrxR5D5AGQ@mail.gmail.com>
Subject: Re: [PULL 18/19] KVM: SEV: Provide support for SNP_EXTENDED_GUEST_REQUEST
 NAE event
To: Michael Roth <michael.roth@amd.com>
Cc: Nathan Chancellor <nathan@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 7:11=E2=80=AFPM Michael Roth <michael.roth@amd.com>=
 wrote:
> Hi Paolo,
>
> Yes, I was just about to submit a patch that does just that:
>
>   https://github.com/mdroth/linux/commit/df55e9c5b97542fe037f5b5293c11a49=
f7c658ef

Go ahead then!

Paolo


