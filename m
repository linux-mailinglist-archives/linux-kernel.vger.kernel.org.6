Return-Path: <linux-kernel+bounces-313192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E497896A1B5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A5711F2242B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC11187FFA;
	Tue,  3 Sep 2024 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HqLTVqY5"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA0816F8EF
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 15:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376183; cv=none; b=PIadzAuIDwHBYjvIJn7/rAYeQBX+l8q9IM/ehMOqYWF41VwpTWtgURuLwl3UFukDgGMTg9ZnmuBcIuDbmL5AkPWy8V4S9JEZGeFVwJlM7pTFE+qkA0OtJpGKcx/xK0O267XHaJ0we+uUeJ75K7EMa5Or842DzGh++yfxgOqTAU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376183; c=relaxed/simple;
	bh=hkihc/6WA9/QhPK1a/f1doLwTM/grTsynAcwgS7nw/8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CLRRio2kN7rTlnqtJeA5/io0suHJZXD2hv16KDHPZKB4yhhju2PyShKLALV5rPS75DrMD3bbNMfSwzGEI5heL4aUkZ8l6bHUmENMMI/J0DMSjslYW69pNxVP4oc9Vd5iEF3IAwNGY10hQ0xUjnsIsMLVt5CTMp0Bx7dLbngMkws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HqLTVqY5; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-20537e42b7aso43701925ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 08:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725376182; x=1725980982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gfCufivpzBm6oAcRdCpegQIb7KEtzf8TXvjWVp3MAlg=;
        b=HqLTVqY52kE7mUwfcS4lD5rF99E2nbBFwyQ606yEaNijZMen8Jx0SEO/4T5tKFytt8
         PRqBpgZIytsma9yk6qZ96PROhA+q/B+R2yN8Q+7qpXtXHaLKgh4ykV30LXJa6JoMtUhf
         3NJWh6bbQxVeE7gJBJqyvXPv2sxyAk3wJwzZK/HUxKqRdGgPaa8+1dtbZLug3Ano/iVT
         69bMyuFvISKsqSpCnmv8CyJVFUBkm++R8xXaSwyJTnoEbxE9Dv/PGFxhe9W6MbYUS3iB
         VHEl6CBrpHqRuRQiC7yLfWiq10zdva7b1Pk/rZ0wz1NGox7BShyL2aL/IPs/vkpLR3sM
         Wk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376182; x=1725980982;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gfCufivpzBm6oAcRdCpegQIb7KEtzf8TXvjWVp3MAlg=;
        b=eqXWGv7oBS8SarY2ByQFiRBnT7hwHTeeJ+e6xcUzKdetTbAVIilvlNUXShO4aCq7nL
         Ak5MMXgwcxq7UdxN2vMEqQaFtkuy1YnSxKAHav4AJGmHYUBmDA0MwOSxtGuEiCO/mqsL
         NgaIm/Ca46iyAzanp5gyzJgV1IxS2KdcctcXjP+G7WiJNWn6LfpNriu9x8KebGE5uv6j
         I8N/5oaeRayGQO5BsMISJGVeaupxI7JkyUX0m51H+8BgKVH0m+fJtAgnqKKtSuJAqQTn
         wfDoweqcZ82zSFrvBsX012AIKaeXJdwhqiCbxahLPTSv8voGH4txUwnr3c5gamQsRM7T
         jfpA==
X-Forwarded-Encrypted: i=1; AJvYcCXl6EpQD3C9g7wQcGkL9wkpe7ymRpgrVLsJ2HLjvfy8v11CmPvYj1NQolmFMRnD9lIOPvQzwSjezq5cs80=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzBC7CegEJeCZt/h1R96ZXYg11WvCSZIaVYRaHbC82wTJcMwTF
	vOMVYCTmNJAef8uFz6Azin36zybypPCIrW72QSzZ0rTLXnhBMFWCh6JV+pyUML5adQcuEqiwJV6
	Diw==
X-Google-Smtp-Source: AGHT+IGFfMtNWVn2Os9mP28kanvnTDWaSYvo+LMgHGVIxjM+2irTaxwzoo4qnseusX5LrbYip8qiQXwrCMg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:183:b0:206:8a7c:9197 with SMTP id
 d9443c01a7336-2068a7c9354mr3683845ad.1.1725376181611; Tue, 03 Sep 2024
 08:09:41 -0700 (PDT)
Date: Tue, 3 Sep 2024 08:09:40 -0700
In-Reply-To: <CABgObfYT_X3-Qjb_ouNAGX1OOL2ULT2aEA6SDKessSbJxGZEOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802195120.325560-1-seanjc@google.com> <20240802195120.325560-2-seanjc@google.com>
 <CABgObfYT_X3-Qjb_ouNAGX1OOL2ULT2aEA6SDKessSbJxGZEOQ@mail.gmail.com>
Message-ID: <ZtcmtFlX83g7C8Vd@google.com>
Subject: Re: [PATCH 1/5] KVM: x86: Re-enter guest if WRMSR(X2APIC_ICR)
 fastpath is successful
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 02, 2024, Paolo Bonzini wrote:
> On Fri, Aug 2, 2024 at 9:51=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> > Re-enter the guest in the fastpath if WRMSR emulation for x2APIC's ICR =
is
> > successful, as no additional work is needed, i.e. there is no code uniq=
ue
> > for WRMSR exits between the fastpath and the "!=3D EXIT_FASTPATH_NONE" =
check
> > in __vmx_handle_exit().
>=20
> What about if you send an IPI to yourself?  Doesn't that return true
> for kvm_vcpu_exit_request() if posted interrupts are disabled?

Yes, but that doesn't have anything to do with WRMSR itself, as KVM needs t=
o morph
EXIT_FASTPATH_EXIT_HANDLED =3D> EXIT_FASTPATH_REENTER_GUEST if there's a pe=
nding
event that needs requires injection.

Given that kvm_x86_ops.sync_pir_to_irr is likely NULL if virtual interrupt =
delivery
is enabled, the overhead of the trying to re-enter the guest it essentially=
 a few
cycles, e.g. check vcpu->mode and kvm_request_pending().

