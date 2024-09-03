Return-Path: <linux-kernel+bounces-313270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C44096A2CE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4771C21F90
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA3718BB8E;
	Tue,  3 Sep 2024 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GVr/BqKm"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B80187550
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725377463; cv=none; b=n690desly5kzvcSN0Le/5I/g29qWNdqNATzZEy7l2GN7r8m9SEdKY2xEozKaUpH6u/AZOpjeJPk6u13s2/XAD81qTf91KxFUqFz7wimHoLiki+9wSQH4S2gdc+9K9C0nK5OkdYx6Bi6bfMaSZThgytyrhy5tsODNz9xP9hcS7A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725377463; c=relaxed/simple;
	bh=myZhSHZglPxRmX1LeF9hNvw0WBoOmbw90VRio1gUy/w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mDj1JCzsSo/g0gjnloYeMFn4+zJzqoFgueW2jY96ByfTIcF4U0sDtGwdi5fDx7JxSKTc98SvuusK0fWBToIVE/0gssBltQ/ojN7o2JjFadg3l6Ta1TqoNwjmJ3JZG6iiJUcb5V7jakiB3RpNBJqoF9rDAXqQR8AEydPc16AdN5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GVr/BqKm; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d52d811d1aso48053867b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 08:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725377461; x=1725982261; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ec7dmsuyq6MURvKN1Ek/X/vHghIhIMnPsF7++yal6w=;
        b=GVr/BqKmN+1FjYtqqdksxJxo8K3VG6iBCh5g+P7c1GolUYYGUE5mMN6lrLtOBO/tgn
         H3yBX30kH8cM+J5KUon5QiXNZ5NLcQSw6fdNPnPJiLGL5AobW27ieHK2s/86ngKQZ/e3
         HNTOTR40l2eAn/XVHuUg2YtvvcGKKDs6WwHOlhNJkRx9ACy/RfKypjhCgJOpRQVnOG5w
         KxmimPRoXgKx5L1iuQvGtBZWXE9KCNtKmZKq4n8fnNxyDLFYZUVF7BxSZIwjekgZ3BdL
         IDGnALM6fCMDHy7TBinurxpIMyPvGZ1L4MKWOAXzogvTZZNK2lQCkZG8rfg4xFwj81FN
         OXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725377461; x=1725982261;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ec7dmsuyq6MURvKN1Ek/X/vHghIhIMnPsF7++yal6w=;
        b=Aa0JkprRb+XD1lFlzxAdfSDZFC9exJNZuL9/gfYaPJ4dFYr/aza7cOJtlt2qOtvdVQ
         BZjP8XmLe8W4Ya/PhFJAvxCTz3eNK+ZIWKoTGM6z7KVw1bnLsdA9R9lFVJAsCznB4tJh
         7yF5iqxo67UO2yD13cO2T+yXJ3bhoQ1Njif5iBom1NX4W4PDCx3qui6IzYvmIz/Itbvq
         /y/abO918RmmfLrdWyv0+9zZwVLOmJwGOKn5qCGYB1wwXoiiJhLIu7KiD4VNHR6/gl7/
         +kFgBUK21SNxSvPkgkK/1mXBEv/FxqmXSJzBdAq1VYC5J+jDab/EXV27AbV9+3Vq/rQL
         EOUw==
X-Forwarded-Encrypted: i=1; AJvYcCWE86iX8VtYBwvybPxGvyxv+4p7iMshD/dddFvhJFetI8ptVI+Sz3rxAt1fM0UXqaHE/i5B3EEk/ZZrvBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt394fT8p8L4rupDO46L59hJceLzo+DxPkxRQPJg01wrFAVQki
	c3UMdLVqYsqMOE6bIi/F8C2xNVlqA57yXuKe9Hftu106uMXRcR8f7c32ygk/rJ55oBE3Ui3evba
	m7A==
X-Google-Smtp-Source: AGHT+IEh9ne8KzfgecVZ/RaL9A4Ue6g6HIetOniUqznNH1pR9H+ZBj1JoJsiAHWXhWwmsoKvuOIyhj4bnjg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:4d02:b0:6d9:d865:46c7 with SMTP id
 00721157ae682-6d9d86547dcmr1285427b3.2.1725377461550; Tue, 03 Sep 2024
 08:31:01 -0700 (PDT)
Date: Tue, 3 Sep 2024 08:30:59 -0700
In-Reply-To: <87jzfutmfc.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309010929.1403984-1-seanjc@google.com> <20240309010929.1403984-6-seanjc@google.com>
 <877cbyuzdn.fsf@redhat.com> <vuwlkftomgsnzsywjyxw6rcnycg3bve3o53svvxg3vd6xpok7o@k4ktmx5tqtmz>
 <871q26unq8.fsf@redhat.com> <ZtUYZE6t3COCwvg0@yzhao56-desk.sh.intel.com> <87jzfutmfc.fsf@redhat.com>
Message-ID: <Ztcrs2U8RrI3PCzM@google.com>
Subject: Re: [PATCH 5/5] KVM: VMX: Always honor guest PAT on CPUs that support self-snoop
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>, 
	Yiwei Zhang <zzyiwei@google.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 02, 2024, Vitaly Kuznetsov wrote:
> FWIW, I use QEMU-9.0 from the same C10S (qemu-kvm-9.0.0-7.el10.x86_64)
> but I don't think it matters in this case. My CPU is "Intel(R) Xeon(R)
> Silver 4410Y".

Has this been reproduced on any other hardware besides SPR?  I.e. did we stumble
on another hardware issue?

