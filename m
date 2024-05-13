Return-Path: <linux-kernel+bounces-178118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1916F8C48FE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 23:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B58A1C21858
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B0784A33;
	Mon, 13 May 2024 21:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ci05iyCE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99A483CD7
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 21:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715636852; cv=none; b=RcLxWfc6WWI2l6rVTHjbpk3F0iYU7yAyl8dUXpB4OaHi95t0BiU6V+mAabZx00QJPzN0B7LNN55aCmPIhOu1gsRzPRHacXLq+HAZyGhbgGu6HMxHUMwp88DEjUSbxCPHP795RedbWdr8C3gDIWgBh4X6IJGXJdaIWQXopKMBHG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715636852; c=relaxed/simple;
	bh=GsvEB0jrgKOQaYhaQDNrmbyGu9pT3dQg3hSPhGvs95A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GYW9PREVSyhVAiygc5f8xJrbAlAJZVXKTNZ8XKhngeh0jKJ6SL81fipFkJJczwIt7TIcK1on1H9qBzGyfABXtC1aO8+PnmJ9tyu6DuuUCHWx1URcJtrbZ060f/antc4B0tZXxR2/glWxeIOXb9/3KRd0xQBfewYbdDVArhKTblU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ci05iyCE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715636849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zezx3lgmnnnDtiiLnluAFlp/ntQq1a9r2G/1DoFg4n0=;
	b=Ci05iyCENLcuSonONEWaz0bcrw9ZlnrpFxer2KrtpmIBFPfm3vLuIaUcqIma3Nw1XucvUq
	ZwpB2D2E1kaOtGwPlh522IMSKrbMMC0K5+HucSGa74oA14nWP2/GI5U0hhEtUy3G5M6GcB
	PQ6D5WWbGVbL45mMLRMy6PNb6RzOqzU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-YTWUQKQAOumbqk80camJoQ-1; Mon, 13 May 2024 17:47:26 -0400
X-MC-Unique: YTWUQKQAOumbqk80camJoQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-43e1c1c333bso14551731cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 14:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715636845; x=1716241645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zezx3lgmnnnDtiiLnluAFlp/ntQq1a9r2G/1DoFg4n0=;
        b=d9x/QvdlEjIo3XPJeGLDoyL78wsfvw1cnD6aTp7aqCMN8ohSKSFsT2fiOQYbUwd0i9
         1qMZeSzrNZPP0capSyhk4tP3Z9i3HTCqP/ujmYp67DrSQcbOksIoGNz4r8Serocg/SqE
         mvJttMVxWdfypJ0ylN+XR/3douP5sfORLMe6jaSraNJdx/3zjnHyyFAy1LQaqloGZYtH
         SBIghsIKYFsCNISqItabCpShWry4Uy1L4iTXDJgPqLM/FZCxJB9qVaJC/DfN/klwXO8P
         kPfNHXByT2gPDFaAscBfa6WnglhVh3WuPpMB92ymdRPl49vp5LAG/AsbWxCfl2BdKo7p
         ePYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhy1OHn5StXaEAc72BZzIkR3LUDJuQ7RzdpCt324wYf7tJdUx1UMbrcEikXeQQZkZ4XLMHlapwMgWprX2k1++d2pNG7XlVxxqf/Qxd
X-Gm-Message-State: AOJu0Yzo+D7Qag3+RkoQmJ49BZfaHF8dg2/e0NpKftujgDcTPVj7gIcW
	OdolBR+RKkDZGTkqv8Bp9CEz2E2piDMucm4Dnf1UZSb7q4Luclnx2uGebiYKtxwE2B9aInPl2ZZ
	mMh+I9yXOPZs+611Ukia3DmDPwcY1mmYNJNKrMeHuzinXpPJeWVrfOrIK3m7D/L4E68/3PQp5Ur
	bctK/G07/4GKjwR2K6VEORe6i70ZGk+SK30BVJ
X-Received: by 2002:a05:622a:148a:b0:43a:dc29:a219 with SMTP id d75a77b69052e-43dfda8e639mr142376891cf.2.1715636845447;
        Mon, 13 May 2024 14:47:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl8mtvZ1AqP2eTCQHLv7194Xa2gyO4esR0o+IYBTEGNUDz7XONxYrIUGwyTPc05Dwa+aFhe3D+YU3/19Zu628=
X-Received: by 2002:a05:622a:148a:b0:43a:dc29:a219 with SMTP id
 d75a77b69052e-43dfda8e639mr142376681cf.2.1715636845074; Mon, 13 May 2024
 14:47:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240511020557.1198200-1-leobras@redhat.com> <ZkJsvTH3Nye-TGVa@google.com>
In-Reply-To: <ZkJsvTH3Nye-TGVa@google.com>
From: Leonardo Bras Soares Passos <leobras@redhat.com>
Date: Mon, 13 May 2024 18:47:13 -0300
Message-ID: <CAJ6HWG7pgMu7sAUPykFPtsDfq5Kfh1WecRcgN5wpKQj_EyrbJA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] kvm: Note an RCU quiescent state on guest exit
To: Sean Christopherson <seanjc@google.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 4:40=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, May 10, 2024, Leonardo Bras wrote:
> > As of today, KVM notes a quiescent state only in guest entry, which is =
good
> > as it avoids the guest being interrupted for current RCU operations.
> >
> > While the guest vcpu runs, it can be interrupted by a timer IRQ that wi=
ll
> > check for any RCU operations waiting for this CPU. In case there are an=
y of
> > such, it invokes rcu_core() in order to sched-out the current thread an=
d
> > note a quiescent state.
> >
> > This occasional schedule work will introduce tens of microsseconds of
> > latency, which is really bad for vcpus running latency-sensitive
> > applications, such as real-time workloads.
> >
> > So, note a quiescent state in guest exit, so the interrupted guests is =
able
> > to deal with any pending RCU operations before being required to invoke
> > rcu_core(), and thus avoid the overhead of related scheduler work.
>
> Are there any downsides to this?  E.g. extra latency or anything?  KVM wi=
ll note
> a context switch on the next VM-Enter, so even if there is extra latency =
or
> something, KVM will eventually take the hit in the common case no matter =
what.
> But I know some setups are sensitive to handling select VM-Exits as soon =
as possible.
>
> I ask mainly because it seems like a no brainer to me to have both VM-Ent=
ry and
> VM-Exit note the context switch, which begs the question of why KVM isn't=
 already
> doing that.  I assume it was just oversight when commit 126a6a542446 ("kv=
m,rcu,nohz:
> use RCU extended quiescent state when running KVM guest") handled the VM-=
Entry
> case?

I don't know, by the lore I see it happening in guest entry since the
first time it was introduced at
https://lore.kernel.org/all/1423167832-17609-5-git-send-email-riel@redhat.c=
om/

Noting a quiescent state is cheap, but it may cost a few accesses to
possibly non-local cachelines. (Not an expert in this, Paul please let
me know if I got it wrong).

I don't have a historic context on why it was just implemented on
guest_entry, but it would make sense when we don't worry about latency
to take the entry-only approach:
- It saves the overhead of calling rcu_virt_note_context_switch()
twice per guest entry in the loop
- KVM will probably run guest entry soon after guest exit (in loop),
so there is no need to run it twice
- Eventually running rcu_core() may be cheaper than noting quiescent
state every guest entry/exit cycle

Upsides of the new strategy:
- Noting a quiescent state in guest exit avoids calling rcu_core() if
there was a grace period request while guest was running, and timer
interrupt hits the cpu.
- If the loop re-enter quickly there is a high chance that guest
entry's rcu_virt_note_context_switch() will be fast (local cacheline)
as there is low probability of a grace period request happening
between exit & re-entry.
- It allows us to use the rcu patience strategy to avoid rcu_core()
running if any grace period request happens between guest exit and
guest re-entry, which is very important for low latency workloads
running on guests as it reduces maximum latency in long runs.

What do you think?

Thanks!
Leo


