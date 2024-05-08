Return-Path: <linux-kernel+bounces-173379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDA68BFFAC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B5BEB27325
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3C08528F;
	Wed,  8 May 2024 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K9z3sYqm"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089A084DE9
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 14:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715176893; cv=none; b=pjpc9lEZ/FgZK+QI2aJ54shg4dHbrNkKFCBavESol6W2MgPEn7ePg7oo89AIruk+LWSdcjtqYGZrw5oV+Wh7/Sl2xusM2OY/Nxu9teLTRR+eaqQ1jKzbeZHsv1e9qbAl81e1NdwOt/wn3QZBYsxLWcCsqH8YZRRbg84wg1HcIuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715176893; c=relaxed/simple;
	bh=fKHtQmZwtVbaMapGWWdAwFR8INwOLeokQNWFm78CXHo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kcgMpbpf1oOocEXq4S7AmlItUqxunbH9yqruBzNG0XKIGYDzdy3ZVacHzALFOqhzpKyuswhq9tQhoEEI+oVPSa0AePTXO6CHSs96s2nXyz9jYYQ5w7rv7k52ORyomwz8ArXsLGI5Y2B9RSI021UcEI4GuUhxSb4CesuMtVVTvtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K9z3sYqm; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de604d35ec0so8145834276.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 07:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715176891; x=1715781691; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GRuBCygsQV/Xuf9mbwBl3CtdhKC/i9RdJrSQbVnsUa8=;
        b=K9z3sYqmIAcHmmqwZ8w2pCGQNSHewbBZJPfo57Brqx64hGrDQTetoK56WpzAqxuDXT
         ICNgkMVGre1i31bqMBcdbeEM+iIyUJ4BUAC31Vmv9MYR28qCUBJJV7QnSUWminXbjdCP
         VpJ/Yhm9F8BVIbT4JpQj4WYeF2E7gHft+8lRSPOLf8dzN1QJJVEOIN5uMTYKiVuWze7J
         xrptcS4kS8SDK96VpenkBl3M+2nP1ARUdc9r7BJOlWdXTG9nI1qftm4fwOF5bvKxGox7
         e9q+QITdjKs8AIKVG6h1uBRiBQwOfUfvuvhOTQYOZfJVNwEueFMDr+ydQ5cNrZBVuYad
         mBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715176891; x=1715781691;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GRuBCygsQV/Xuf9mbwBl3CtdhKC/i9RdJrSQbVnsUa8=;
        b=rMXU+PKFNRporcwb+S0I5RaIUOsyBx9jbzAwgui7cr6rmogHhvNpdYdC57aVtWneyk
         dtqOGk337kGnUTtX7bhCvL16ULMx1FJxVeDig7mYaIGer7ILk7ucHdbOlq6kADoIlPfY
         AugWkZWCcB22tZNxCxwPSASD0Q75XzbB5cnxYMK0RcvrlE9HZ/5j7faAZIxbiMA1gRwh
         u1Xr3GlMj5NF1rFKowJwfK2GS3Qay1t13Ej1X2bVuBOf9FJNgogn0d/bdZI0S+kdBEUt
         /TiV0qGGC3AK5/u1etbYUpOEzW3syglK8CFNMHfzHvX+vVwZ2dAhS8w/T5uAaly/jLS0
         cqPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOy4PZcztW/zP5lZvGGoInJW3C9lHfLWgzZvGw/U6h/kxUX0hcQh3kNOwOhzYmrpz0M7/mSg+GTsD4EbnIa6KPvhZM5T7YKOMnuMAG
X-Gm-Message-State: AOJu0Yw9mWZcQzJ9bEQGUdxF8X2hWt+Htanar6w8wzHwraasQF1CebpF
	45vxgV0ljvZH/tUwfapoUheDH4ENTQ7affPgoL6q9un0NuwbG7JuvVQ4oX4zb4+DLrjXklH0tEF
	QMg==
X-Google-Smtp-Source: AGHT+IEotoxzTcL61fPNPOF1oe83dNOozsClwiQuDb983+6Yt1pcsrrUNKpJf1CMRJIa/y7GeGGj8edECOo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1109:b0:dcd:875:4c40 with SMTP id
 3f1490d57ef6-debb9e3dc10mr825460276.10.1715176891034; Wed, 08 May 2024
 07:01:31 -0700 (PDT)
Date: Wed, 8 May 2024 07:01:29 -0700
In-Reply-To: <ZjsZVUdmDXZOn10l@LeoBras>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <3b2c222b-9ef7-43e2-8ab3-653a5ee824d4@paulmck-laptop>
 <ZjprKm5jG3JYsgGB@google.com> <663a659d-3a6f-4bec-a84b-4dd5fd16c3c1@paulmck-laptop>
 <ZjqWXPFuoYWWcxP3@google.com> <0e239143-65ed-445a-9782-e905527ea572@paulmck-laptop>
 <Zjq9okodmvkywz82@google.com> <ZjrClk4Lqw_cLO5A@google.com>
 <Zjroo8OsYcVJLsYO@LeoBras> <b44962dd-7b8a-4201-90b7-4c39ba20e28d@paulmck-laptop>
 <ZjsZVUdmDXZOn10l@LeoBras>
Message-ID: <ZjuFuZHKUy7n6-sG@google.com>
Subject: Re: [RFC PATCH v1 0/2] Avoid rcu_core() if CPU just left guest vcpu
From: Sean Christopherson <seanjc@google.com>
To: Leonardo Bras <leobras@redhat.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, May 08, 2024, Leonardo Bras wrote:
> Something just hit me, and maybe I need to propose something more generic.

Yes.  This is what I was trying to get across with my complaints about keying off
of the last VM-Exit time.  It's effectively a broad stroke "this task will likely
be quiescent soon" and so the core concept/functionality belongs in common code,
not KVM.

