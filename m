Return-Path: <linux-kernel+bounces-280050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E6E94C511
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62CE1F27AF6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE4E1552E0;
	Thu,  8 Aug 2024 19:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XRAqXoow"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EF514D6EB
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 19:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723143914; cv=none; b=bbpVkMVdSn2QBZWXpmHHjV881VayEhOwko4uHjiZKVwcQ5LK1f7H++4uGFewuNeUVQDDA0SBu8DjkrruF51Amguh0aCI4jbA5M5SvvTNP+il19ADlVcI9IWq29nGWJWKvBuCquIzj4pyA5jNdPVc3ces1AaVGyAUp2acW3ZNrGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723143914; c=relaxed/simple;
	bh=2JvB8KiY+PuqAF0GhkTY8OddkOOK+xHWu3DUoPWQw7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=klwSkX8OG2nH/ko/qExBXnqhzEIYywi/rYK4k1E9O8eU+w2JaHWlV5QZ1WXCPyTKIGQSc4DPH8dzzlnuNTdcUW8YJBfuQPax3Ge995c6ln3aykLmVBPSatKAVn/xgiCeEj6RXJDEi3m/r3zwQpkH5FyPeP8DJwARYJYuwGdjGXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XRAqXoow; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4518d9fa2f4so26231cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 12:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723143912; x=1723748712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JvB8KiY+PuqAF0GhkTY8OddkOOK+xHWu3DUoPWQw7k=;
        b=XRAqXoowBsE2LCCY5DWtw8eJ/mutgjZhFUUnePPPTKrMlAP1iY2mRGBhryxbjnVZsj
         fAjqpjOdGg8P+8k0QjNPyh6SQxcJWguzjFvQxaRm95Q5gbjdn4WxjPmZI1Pov7tupJIF
         VGkTg17xNlY8PRfjkRqjxY/5WpFOZzHMJlr0W0LBBxLQHPFzDfxJb2QJ04+c7hgqveyT
         Ni2AU71nX57tnjta77RPXYqs7UV9SpxbhoQfhkzEJIxLEi+P+N8e8soqZdccEE+GaSu1
         e5+UXb09sXKmaI7eNzMXkdLJc02izd5rb+zXalz5BK7mdK3qBlj7e2Z+FaPU7zSZ0jsv
         aLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723143912; x=1723748712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2JvB8KiY+PuqAF0GhkTY8OddkOOK+xHWu3DUoPWQw7k=;
        b=cmamtWYFiL7APC6mXNyoTOHgMjso5IXjZ9eT5GwSerOh2dVKHD8ZnNkRIy99nhaHYP
         efdljj8RIrzzp1a1Olqr9EJX2Q/1s0HbYhFe9J1gPiufZq0y9cA334CmZ/0xCqt+ri0c
         ArM95ednzt+Plg/XPy+NthyOp7RsU5EaGsbjVCoZ7kOB5SwWk5yLZqLqRJEkMrpU4C7D
         U0hHicg8itE5hjKysxIT2+t9F2DAPnvA0qoPRh8hBeE3AyVgp7MZC1ee2pu0fbEJalck
         RDPmN2zLrIgvvajjQpyNdaDtNxn0FJwc6NZDhNvYlQUUfsRTsujX4Y1AY1BHct3wcOWS
         g48A==
X-Forwarded-Encrypted: i=1; AJvYcCXETOfdXhHDX5raVsBUSp0PCzs/7FjStkYy6pEu38m16laticUwsmc34YyqMzcLvox+o6MRISmbFrjmbNIi6QWs774V5mHn8cg2opFT
X-Gm-Message-State: AOJu0YzFU9GpWuKY9K6QczvMylje0SqudjCl1jaIrN+zxJ3i3Sa6qwlL
	OipXz46Davo0Njz51Kd+sds47HIF8pI2M5cOYmcZoOeqhzwMe0RkQkWsW6lEStm4JPiiDvJVgxb
	Yp6t1doL+4gfznF4ciyzKNU5T/HabaT2hOt0VSNpwYj9CY00CEw==
X-Google-Smtp-Source: AGHT+IFIlgJQdU3HoiHXPbkIB4GKly6SE8zVkLmKYy0KXL7tnF5o/COzyvy6qpBzkurJ0OWbYZqnlwn3gVNXK6B4bgA=
X-Received: by 2002:a05:622a:1786:b0:44b:74aa:1838 with SMTP id
 d75a77b69052e-4530de641aamr415531cf.5.1723143911952; Thu, 08 Aug 2024
 12:05:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801224349.25325-1-seanjc@google.com> <CADrL8HXVNcbcuu9qF3wtkccpW6_QEnXQ1ViWEceeS9QGdQUTiw@mail.gmail.com>
 <DS0PR11MB63733F7AEC9B2E80A52C33D4DCB92@DS0PR11MB6373.namprd11.prod.outlook.com>
In-Reply-To: <DS0PR11MB63733F7AEC9B2E80A52C33D4DCB92@DS0PR11MB6373.namprd11.prod.outlook.com>
From: James Houghton <jthoughton@google.com>
Date: Thu, 8 Aug 2024 12:04:35 -0700
Message-ID: <CADrL8HWH3d2r12xWv+fYM5mfUnnavLBhHDhof0MwGKeroJHWHA@mail.gmail.com>
Subject: Re: [ANNOUNCE] PUCK Agenda - 2024.08.07 - KVM userfault
 (guest_memfd/HugeTLB postcopy)
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Xu <peterx@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Axel Rasmussen <axelrasmussen@google.com>, David Matlack <dmatlack@google.com>, 
	Anish Moorthy <amoorthy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 5:15=E2=80=AFAM Wang, Wei W <wei.w.wang@intel.com> w=
rote:
>
> On Thursday, August 8, 2024 1:22 AM, James Houghton wrote:
> > 1. For guest_memfd, stage 2 mapping installation will never go through =
GUP /
> > virtual addresses to do the GFN --> PFN translation, including when it =
supports
> > non-private memory.
> > 2. Something like KVM Userfault is indeed necessary to handle post-copy=
 for
> > guest_memfd VMs, especially when guest_memfd supports non-private
> > memory.
> > 3. We should not hook into the overall GFN --> HVA translation, we shou=
ld
> > only be hooking the GFN --> PFN translation steps to figure out how to =
create
> > stage 2 mappings. That is, KVM's own accesses to guest memory should ju=
st go
> > through mm/userfaultfd.
>
> Sorry.. still a bit confused about this one: will gmem finally support GU=
P and VMA?
> For 1. above, seems no, but for 3. here, KVM's own accesses to gmem will =
go
> through userfaultfd via GUP?
> Also, how would vhost's access to gmem get faulted to userspace?

Hi Wei,

From what we discussed in the meeting, guest_memfd will be mappable
into userspace (so VMAs can be created for it), and so GUP will be
able to work on it. However, KVM will *not* use GUP for doing gfn ->
pfn translations for installing stage 2 mappings. (For guest-private
memory, GUP cannot be used, but the claim is that GUP will never be
used, no matter if it's guest-private or guest-shared.)

KVM's own accesses to guest memory (i.e., places where it does
copy_to/from_user) will go through GUP. By default, that's just how it
would work. What I'm saying is that we aren't going to add anything
extra to have "KVM Userfault" prevent KVM from doing a
copy_to/from_user (like how I had it in the RFC, where KVM Userfault
can block the translation of gfn -> hva).

vhost's accesses to guest memory will be the same as KVM's: it will go
through copy_to/from_user.

Hopefully that's a little clearer. :)

