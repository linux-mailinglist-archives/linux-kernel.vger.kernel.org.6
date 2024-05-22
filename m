Return-Path: <linux-kernel+bounces-185696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E188CB8FA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 04:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A0C282676
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 02:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467CE43147;
	Wed, 22 May 2024 02:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dqVtVC50"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0EC322A
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 02:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716345095; cv=none; b=HEWx42afyW4/iGQKuW0lPtqmeyZm+cqJYiqcV+icQA5Nje08u5ww9yi34/MARlgdqGk1rOnr/emWRBMZD8OPOFzdv9qd5JcUw3aBrAgQcR0JZ2iRNuKVrLiP/752pKyKrq47/yB1L6CeAKilo8WRAFtLxhS4VWa+vhQXjH/MO/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716345095; c=relaxed/simple;
	bh=tak0JNHXgiWiJt06m1Iot07uFQvw2SbXkoQiZzW0bo0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WDkvFleUUYfUTeGvqI1+4WNcIU/MfuCvlGJ5s5064gxiYshq0RwTwxdjgWsJph0eKce0UV+bKttxUIhaUhwbClskIUSe+2bT0KLkLsW2DFRP832f1p4WX4Bh+elIWx2QtsUEsNYIOu6flvTRn0DKQO1sKKUJunLyaUfQSBKoCtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dqVtVC50; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61bea0c36bbso264545777b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 19:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716345093; x=1716949893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gOYDdieEO0SMEqqI4rHYaS0F69dZml7a9rO/mRwE3Yc=;
        b=dqVtVC50iSxq4VQELbM6nAHkP/Wh8cRQb2jyNF5baHhYXcyIol18qtJr7X8aYGHl7O
         VtsY3Fz72yDBUgukYlkgglcCPLa2DuwtWisjGZh7Cxbu+094x6Q0PCe+ar/V4A49RizW
         RpwpuHccV2+ly66d8lYDk1tL4jD2qQT5kplPwhdL/cR1aD01ibv7kbuUMAFe3+fmkkh+
         na7MwqH4PGi4F8kgvBMsUHoGdYkXXJONBLvYEOWjnICF33dBlfCjtskp3sWVZEawBpYb
         7ca3xx9JRt+SGrYBYOgoPWPoHe0R8pb8OFy9apmgI6umWH3pozocHkN60i2hzv3ailpu
         fnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716345093; x=1716949893;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gOYDdieEO0SMEqqI4rHYaS0F69dZml7a9rO/mRwE3Yc=;
        b=EvvUZdpl1Jcu7/9ZoHTRLYaM7TNV2PCUlxdSv11awcRCas0t311Z0pDaU3OqHqPOsP
         GnBvBFiQKujE6Ux/sCilmoZDYoI/JFqBnEOCHdkaahYmR0KhmTZ2Ix9sPSaVWIFok7tr
         OCvJkHZOH9Nglhul2OjMJPN7a3oAv4XwKbIgpzJmxwBlCAtNT3p/6E3N+XXPaMqKdUln
         nHI7TZ2RqSftOjpf3+0y7PEfwEnYaPYmaibgOE9OUl4WHY16+nehvFA7Y7fZg8S8BnJu
         LWbvGMDshagL3xU1I216GSabMaNS6mGO9ipHz21QTdmU09rzYEfvKb88u1baODLTJKsq
         ICYA==
X-Forwarded-Encrypted: i=1; AJvYcCX6gF7XzlQOFXIdt9XRxx/HF7pWWYtT8qgHBMASEip/Xc99Blym5uxYe0yPXCFX9OTPmsEHMduQLIwciy+6Q5WHt+M6QD/kiAirk/5z
X-Gm-Message-State: AOJu0Yw4GZUFuAaBLvpV1LOswLBe3NuYOhPZ687qekGck/H/r8uxDz97
	NEZy1VcZnuEWz3rBpCv2AI/gqI7SacJ0wsE3YidW5YxIgvmg97YuOegXHo1/AlE6jLInyubhdww
	FvA==
X-Google-Smtp-Source: AGHT+IGmJ0SvbLnKDHz/DAYY+qVuk91HRc2JW9lRvffWDQUBufCfe/OdwsfiVcHXEKW1MXdrv4UbappAeDQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:aad4:0:b0:de5:8427:d66e with SMTP id
 3f1490d57ef6-df4e0dbb481mr238843276.11.1716345093234; Tue, 21 May 2024
 19:31:33 -0700 (PDT)
Date: Tue, 21 May 2024 19:31:31 -0700
In-Reply-To: <Zk1KZDStu/+CR0i4@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <b89385e5c7f4c3e5bc97045ec909455c33652fb1.camel@intel.com>
 <ZkUIMKxhhYbrvS8I@google.com> <1257b7b43472fad6287b648ec96fc27a89766eb9.camel@intel.com>
 <ZkUVcjYhgVpVcGAV@google.com> <ac5cab4a25d3a1e022a6a1892e59e670e5fff560.camel@intel.com>
 <ZkU7dl3BDXpwYwza@google.com> <175989e7-2275-4775-9ad8-65c4134184dd@intel.com>
 <ZkVDIkgj3lWKymfR@google.com> <7df9032d-83e4-46a1-ab29-6c7973a2ab0b@redhat.com>
 <Zk1KZDStu/+CR0i4@yzhao56-desk.sh.intel.com>
Message-ID: <Zk1ZA-u9yYq0i15-@google.com>
Subject: Re: [PATCH 02/16] KVM: x86/mmu: Introduce a slot flag to zap only
 slot leafs on slot deletion
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kai Huang <kai.huang@intel.com>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, "dmatlack@google.com" <dmatlack@google.com>, 
	"sagis@google.com" <sagis@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Erdem Aktas <erdemaktas@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024, Yan Zhao wrote:
> On Fri, May 17, 2024 at 05:30:50PM +0200, Paolo Bonzini wrote:
> > On 5/16/24 01:20, Sean Christopherson wrote:
> > > Hmm, a quirk isn't a bad idea.  It suffers the same problems as a mem=
slot flag,
> > > i.e. who knows when it's safe to disable the quirk, but I would hope =
userspace
> > > would be much, much cautious about disabling a quirk that comes with =
a massive
> > > disclaimer.
> > >=20
> > > Though I suspect Paolo will shoot this down too =F0=9F=98=89
> >=20
> > Not really, it's probably the least bad option.  Not as safe as keying =
it
> > off the new machine types, but less ugly.
> A concern about the quirk is that before identifying the root cause of th=
e
> issue, we don't know which one is a quirk, fast zapping all TDPs or slow =
zapping
> within memslot range.

The quirk is specifically that KVM zaps SPTEs that aren't related to the me=
mslot
being deleted/moved.  E.g. the issue went away if KVM zapped a rather arbit=
rary
set of SPTEs.  IIRC, there was a specific gfn range that was "problematic",=
 but
we never figured out the correlation between the problematic range and the =
memslot
being deleted.

Disabling the quirk would allow KVM to choose between a slow/precise/partia=
l zap,
and full/fast zap.

