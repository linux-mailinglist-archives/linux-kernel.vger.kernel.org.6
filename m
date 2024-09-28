Return-Path: <linux-kernel+bounces-342598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3509890BE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 19:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA14C1C21431
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 17:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328331474D8;
	Sat, 28 Sep 2024 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rfrbyb6R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD46225D4
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 17:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727543964; cv=none; b=QlY9/hia+kNfrXyWG5ht0h+/cdulbqkT5sn2FFM51NgyR0kw6ntIf+OxItcBCZlLY+VRI0bdmk/MEZiYVqrsTLFSJ2kw2QSR1HtVNlZqc9BNfW8Pgsl8OBDy1sfLaD3OlXSSRP3tOdar2FhfHnVAuF1dDuse2UA1ZGrWoCfIjb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727543964; c=relaxed/simple;
	bh=2TSB1CPY2sIhuCjx+9pYYSA8GwKR8/H0q6sqmvxWdoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQZTgiN1SSOFldyhRchnMbh21SL4lvGs0L7zQ9XDGMCgyUtPQejdjj0mhN8IfuGaM0lz1KhiY0tyL00oPOj/adaq8+/RTOhlME0itsBuVRrLVO2DbtINtvQkkaVUSuwnNZ4NQ6gw1jAHXCOfpSqtbuH5dq2AdkEfitReE1jifxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rfrbyb6R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727543961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=82LCD7KxVzIhvra31h0O1CH7Wj+PV6MsNIzA9TzZVcg=;
	b=Rfrbyb6RPxkqe4GEKqQgD20bm7IUzeiQ4DhXFBDTN0mjGaG0pOsliUc9f3mIP4B0idVIaZ
	CAjjDg14SRxI1oMJj05tZM6GUKEODasAEsoqY/Jhxcx7sQeGlFjf6Yft/OMB98pMHWf7cJ
	dMvDrT5oWUHwR//8xZyCqT1LuRnxWmA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403--HWFJQwfPKGFp3GYgkKLKg-1; Sat, 28 Sep 2024 13:19:20 -0400
X-MC-Unique: -HWFJQwfPKGFp3GYgkKLKg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42caf073db8so25855885e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 10:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727543958; x=1728148758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82LCD7KxVzIhvra31h0O1CH7Wj+PV6MsNIzA9TzZVcg=;
        b=OjghaESy49Y5LnamqOP8/MpUd3hKv2A+FJBIAEcNqnm3WEvv0MJ/NKt1lkaU+lDa9/
         cKVK91a14FB8LKIQjYycil2v8422/7wVopySqc9/+JgsoDNQpFvIjWDHTANeCM6+5R+4
         e8uA3zC43Vh7sDLLI56uKDJqmDsCA/K3+C7BJW0WQi5lJlbthwmndfiz2NpQg7/XKYlM
         8GXlGleW/ytVFDkl0R/l1YUFK9H6TswqJAyOIdTDHEsQLJKmgLJmkH/X38f1j6VAUCl9
         xnATu2DfFcYpRRXhZd+ZS0mBXyUiqDObZ/qYFWVVkCe09JvV55/11Vts8hqPS8l5HSty
         LTfg==
X-Gm-Message-State: AOJu0Yzfe4aP/WIRF1hxxcSKLBBOr12tTgeVuEzaNz0jCOcNK02aEG/4
	sbjlekwZduVlSigGJyURq6UaAypB7k9iHGtJOn5OlwTBe/sra1KxT5VyBcxwRJbQdiQ/3x2tbnO
	HQ6R/TcpRc2fQQnxWw1P8REgkm81WP9MueLww8sKvULcLSf1tOB/WD7iXmxperJuS1BB6kRARpg
	hU80qHsCfsXEFZCdqqDexdMHiy7jVS7cYaFXFsnwmfCjDjW57pWw==
X-Received: by 2002:a05:600c:1d19:b0:42c:acb0:ddb6 with SMTP id 5b1f17b1804b1-42f58430051mr49407465e9.9.1727543958561;
        Sat, 28 Sep 2024 10:19:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9HUcwpOxxBXh/4z2BJD08nMqibH2v6t8lXePAPcnSjNTnD4IXLSHYp9/jdSHhY8vNP5MargL/Up1r88fl8IE=
X-Received: by 2002:a05:600c:1d19:b0:42c:acb0:ddb6 with SMTP id
 5b1f17b1804b1-42f58430051mr49407345e9.9.1727543958186; Sat, 28 Sep 2024
 10:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240928153302.92406-1-pbonzini@redhat.com> <CAHk-=wiT0xehDuhtcut3PFeYnQW2H6Hx9O+1vkkFJHLKWT57Fw@mail.gmail.com>
In-Reply-To: <CAHk-=wiT0xehDuhtcut3PFeYnQW2H6Hx9O+1vkkFJHLKWT57Fw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 28 Sep 2024 19:19:05 +0200
Message-ID: <CABgObfYCBOjDwFfi3-k1ddRLKQ691DP-pnKMBzDGE3Dt9YFwNQ@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/x86 changes for Linux 6.12
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 28, 2024 at 6:30=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, 28 Sept 2024 at 08:33, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > Apologize for the late pull request; all the traveling made things a
> > bit messy.  Also, we have a known regression here on ancient processors
> > and will fix it next week.
>
> Gaah. Don't leave it hanging like that. When somebody reports a
> problem, I need to know if it's this known one.
> I've pulled it, but you really need to add a pointer to "look, this is
> the known one, we have a fix in the works"

If that's what you mean, it was not reported by users (and it's very
unlikely that it will, unless they run selftests on pre-2008
processors or with non-standard module parameters). It's a NULL
pointer dereference on VM shutdown, caused by the selftests added by
commit b4ed2c67d275 ("KVM: selftests: Test slot move/delete with slot
zap quirk enabled/disabled").

It's also not reproducible yet outside selftests since the bug is in a
new API; which is also why we didn't revert with prejudice and didn't
go too much into detail above.

Paolo


