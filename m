Return-Path: <linux-kernel+bounces-313394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 242D396A4ED
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 18:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48A1284D22
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26CD18BC3B;
	Tue,  3 Sep 2024 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wx3Hkj7I"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F182518BC08
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725382737; cv=none; b=rJFYjeUqeqYK1/Nus7sVW89CXPQhpZq3DZrH62yGuuSlOLVHBxI0+o6KTZCtWRJB2wBICVYYtLXsA58ftJzlIVBbsz9RfsIoCvjfWfytlupSf/7TuCXs9FogxEOE5jxgaXVjcooymBWXG2B5iwbNW43DpimaABoFaW+vIWtsrqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725382737; c=relaxed/simple;
	bh=/h71E0+TGNETVrl0pI2x9OOqmmoyh7X1tH6TlJXAiYI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vows+0pREZ8/tggAeecYtuTCmsVwpqvfZMld7vBoTagtcyPZP7GGVHOojyH6CP3+hZAz445biBe2Lgo9AFhk/Esua5H8fidleEc9NoxxDOVO64S2xDQl7VngiT86wfGcgza/9y5smChNwjT6er7/bJE9IHzWUyHRlvaMTb+TD78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wx3Hkj7I; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7cf546bbcffso4942916a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 09:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725382735; x=1725987535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Suzxbbh0yjpO2DqbOe8P+V0GmguDrd3Vlgw/oPbRqc=;
        b=Wx3Hkj7IlXjX/ZMeqOCBV5VR45rHYSJvIAvpfwlS/+cvn1t/o0XQpNPZ1Cg7FDXhgH
         m8/cbg6IzY1pztuqRIDp5Ve0I3Ek6syikbvkzhvQVWNmlKJCAsQBW/DP8R4bl5XDeKmb
         H+YC658IiogJcYJf3yLr18Atf+3QefnD8OWcbMnZtybEj8OxSYegtN9iXgO7r9xmQBcQ
         LG088XReMEYJ6oyt6714iY50oSPfMQTSJnmzPSaUebHnOatM7jlS0C2jEqmXyQssgySD
         pC9S5g74QDCP8LxSdLUab/dbt+MMQ9UVL0XtfZl+mGwdMN5v0qvFSKKwuXOh6gJ2Occl
         OO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725382735; x=1725987535;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8Suzxbbh0yjpO2DqbOe8P+V0GmguDrd3Vlgw/oPbRqc=;
        b=HrejYRcDmtCI384TDHS3Sze+5VhPdQ4FgIgvzb+eQqgALs/9F/5ppHCr9s2x6Q37PZ
         TnUlaye5lYesLq8tXURivi8eYpezp5kG7iIbsocB3SntZxM5th6YIqrEaIAkA1lWoQyn
         K3qvesOBY7PVJOCrNzJeNLCAaQ5encCsf+sG2dSvGQsdgfkaXjlT14YI0hmtoWv/ZMic
         7KjX3An8qbwYboqpb/fpGzVtLCr1SVHqa0KRwUQ3zAI+Lf+FCWxEVXOE2oOqp50VBiUY
         sxQr6UsozCc6N2LWt2m3YDQ928GKKuiylpazteXciekZep2QFWv4KHSrFW7q4aW8upLC
         UObg==
X-Forwarded-Encrypted: i=1; AJvYcCX+e6z70SX7f1Q63qiu32/jF25UKDdY/6OOt0kbrwQ1mvSXJGb2ntKXhhHsmeDpkjKQH2WJEfLiELnmV1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwprO9vtj14tO2eutPNwulpdfvahyylNqDBVX3MOc9by/Yh39LX
	KPsZSqVHUCIScCZ8Lhlne49yRQ07oxyNXHWoTGW0VZ3/2z6wWziXpCpZ4SMKYVuDwKfi50S9JUp
	yCA==
X-Google-Smtp-Source: AGHT+IGhD298IRUsLbG9Vvh3RdM0kkLkILPxgLrIWMIoqbOrQ1gdjDJKJGI8q2+JSljRFS1PTXtfwLhkpEg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:da87:b0:206:a1aa:2673 with SMTP id
 d9443c01a7336-206a1aa2ademr990845ad.1.1725382735076; Tue, 03 Sep 2024
 09:58:55 -0700 (PDT)
Date: Tue, 3 Sep 2024 09:58:53 -0700
In-Reply-To: <CABgObfbwFPDiRbmVMtQZ9HipiT=4zXRqrE1fd7d44EeHt8b7=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802195120.325560-1-seanjc@google.com> <20240802195120.325560-2-seanjc@google.com>
 <CABgObfYT_X3-Qjb_ouNAGX1OOL2ULT2aEA6SDKessSbJxGZEOQ@mail.gmail.com>
 <ZtcmtFlX83g7C8Vd@google.com> <CABgObfbwFPDiRbmVMtQZ9HipiT=4zXRqrE1fd7d44EeHt8b7=A@mail.gmail.com>
Message-ID: <ZtdATR4DY1A9K5ad@google.com>
Subject: Re: [PATCH 1/5] KVM: x86: Re-enter guest if WRMSR(X2APIC_ICR)
 fastpath is successful
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 03, 2024, Paolo Bonzini wrote:
> On Tue, Sep 3, 2024 at 5:09=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> > On Mon, Sep 02, 2024, Paolo Bonzini wrote:
> > > On Fri, Aug 2, 2024 at 9:51=E2=80=AFPM Sean Christopherson <seanjc@go=
ogle.com> wrote:
> > > > Re-enter the guest in the fastpath if WRMSR emulation for x2APIC's =
ICR is
> > > > successful, as no additional work is needed, i.e. there is no code =
unique
> > > > for WRMSR exits between the fastpath and the "!=3D EXIT_FASTPATH_NO=
NE" check
> > > > in __vmx_handle_exit().
> > >
> > > What about if you send an IPI to yourself?  Doesn't that return true
> > > for kvm_vcpu_exit_request() if posted interrupts are disabled?
> >
> > Yes, but that doesn't have anything to do with WRMSR itself, as KVM nee=
ds to morph
> > EXIT_FASTPATH_EXIT_HANDLED =3D> EXIT_FASTPATH_REENTER_GUEST if there's =
a pending
> > event that needs requires injection.
>=20
> The other way round? i.e. treat EXIT_FASTPATH_REENTER_GUEST as
> EXIT_FASTPATH_EXIT_HANDLED to go through event injection.

Doh, yes.

