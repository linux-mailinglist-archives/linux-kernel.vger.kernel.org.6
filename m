Return-Path: <linux-kernel+bounces-438363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD879EA033
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED080282BDD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9879A198E76;
	Mon,  9 Dec 2024 20:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FAHnV8ix"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7178137930
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 20:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733775837; cv=none; b=S43EbqBS8ra6TMFiUOmCon/eCY/xzrNwr38LneVIpHe5ipVvQ5R9ii9Ka+q+jEgFl1bjhj5moF60hsgxpkPfIaO8kxSK0vboFMAXGbgcJEw2ZHpXG9TVfJ0HP9NJtGLt58xQzd7eGQAoc1Aykq4InaX6JKUFSbepxtqJxXFfffQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733775837; c=relaxed/simple;
	bh=+3HqsUrYnf/uwZLO/03HOPkHtcU7i8ZyiMoNBlr1fp4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h2OJaZLxHd9bemT15nui2eIORn2T2wrr44/muwoBOb6MCAAeQRqzAwNek6WaO/BHziYQJsuxF8DQzJzjhf8Z9NI+VTR0u8F0EojL8yW1XTf7bZiwOHbaltQhNRCAEL19cfRiN+czazi4yffq2HvtEPGBvKgEk1EwmAirdEcYYF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FAHnV8ix; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-725c36cdc5cso3034655b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 12:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733775835; x=1734380635; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IbUjcfcl5Sw/qlXenO8arheh/6FBPykIGwNZrR7rxTU=;
        b=FAHnV8ixGCPIu7oTz6Cr7Qv/q0H5nq6n3YxQnnXvzqjOlIlx3dewna2AQuVLdZ3/6U
         srJgyUAdy6RoNaZGYja2bONGlcGBO93Ir/DLQPNHjv2TQBOlAR20pivhM+826OWaWV04
         Kp9ci+HXO6XG2qcEORSFf7Xa6cKJFFGhDLiWZ1r2PMeTgG7h6N7gLTHVuKvCazgmo28h
         JrFmyUKtz5FrU69J6fDbRp9C2wqWuUpP6otBvxUmW2UlEbjC14dbNsMcWa5Ma4Hm8cHk
         z1xWWXSArSdItRi102Rwo7JOf9vQccRmBS31CSJpd1AMksVgV4GJpFyezqRlPNweejSy
         Qtbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733775835; x=1734380635;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IbUjcfcl5Sw/qlXenO8arheh/6FBPykIGwNZrR7rxTU=;
        b=MBihBLT46RpRecjTOMd9t4ozuo9XAMOvj9ot9cMIi+27w0OqT33hPMgj+33ZvFzpFk
         3nNVvVq93W1Nn0aVK4GaZAdElAGMXLnM4LttJDDOwPSLiY0UI/5VNUqA2oMFMDvlY8di
         v7wFv9ebfz1tl1j+9Pn5aligR2MjRaTvErOgPHo13LoljDCy0u3B/bBUBy7kO/5l5Fzo
         CQMSsvOz5w91UX7tWLr80Lwp3/BxcZWQALSncfNo3Una78ej6ubEod04OX5t8L3kfvWX
         Km5djeszS0c9Gc40+2vnhpGqyFV5nLFoiiKlPqS4iaDbdQB7Uem526x3YU1LfdggnSwY
         KUCw==
X-Forwarded-Encrypted: i=1; AJvYcCVp9WNhfuxBYjOJu35/RfIbPz8JM/ZUvJKmEYzzBCYrGpDThq2QGfvIZxSmJWquKPOH3AjbFIsK02J+mJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZpwSx1sDmlLKXYRkOoa3OqiV2OMIBdd0TUfzLYxcRwWUXysZO
	uPlz8Ju+6QI6nrCwfNP6jnsRnkvQDFpoAlb1gNF9AsPwO81TSKeq+ivux3ortJMJtpyH+Lop5F3
	aOA==
X-Google-Smtp-Source: AGHT+IF5m+ziDNsQQSXFfBR9mR8a/vO9tNOmX8vEVVQfPP5XfFsB89cHgLvtQ4pUzF+nDZ3S7m+T9YzlDAc=
X-Received: from pfbcw27.prod.google.com ([2002:a05:6a00:451b:b0:725:e76f:1445])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3282:b0:1e1:b1bb:87a0
 with SMTP id adf61e73a8af0-1e1b1bb8864mr2808812637.34.1733775834995; Mon, 09
 Dec 2024 12:23:54 -0800 (PST)
Date: Mon, 9 Dec 2024 12:23:53 -0800
In-Reply-To: <9624a1ba-bc0a-4aef-93e7-7faad87aca03@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241030213310.C4861EC0@davehans-spike.ostc.intel.com>
 <20241030213329.3253F5F3@davehans-spike.ostc.intel.com> <20241031101834.GGZyNZejzr5A9bNL8J@fat_crate.local>
 <4d606240-a8c8-40e5-80da-57c9b4d48179@intel.com> <20241129182747.GEZ0oHo1eR0l7sREJY@fat_crate.local>
 <d6680add-f4d2-4d65-a711-3f80bfd43f6d@intel.com> <Z1cajm9oqRZWDp_4@google.com>
 <9624a1ba-bc0a-4aef-93e7-7faad87aca03@intel.com>
Message-ID: <Z1dR2YbagsHknq1A@google.com>
Subject: Re: [PATCH 11/11] x86/cpu: Make all all CPUID leaf names consistent
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de, 
	rafael@kernel.org, lenb@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Dec 09, 2024, Dave Hansen wrote:
> On 12/9/24 08:27, Sean Christopherson wrote:
> > As for "cap_nr", IMO that is a net negative relative to "leaf".  For all CPUID
> > leaves that KVM cares about, the array entry is guaranteed to correspond to a
> > single CPUID leaf, albeit for only one output register.  KVM has definitely
> > bastardized "leaf", but I do think it helps convey that the "word" being modified
> > corresponds 1:1 with a specific CPUID leaf output.
> 
> I'm having a little trouble parsing this.

Gah, sorry, too much implied KVM knowledge.

> I think you're saying that, right now, if KVM cares about a CPUID leaf
> that it only cares about a single _word_, even if the core x86 code
> cares about multiple words. So the concept of a word is actually mostly
> changeable with a leaf ... for now.
> 
> Is that right?

No.  What I was trying to say is that KVM's CPUID code only ever manipulates
words that are hardware-defined, i.e. that aren't any of the CPUID_LNX_x words.

Because KVM doesn't care about the Linux-defined words, "leaf" can be used to
refer to a specific CPUID leaf+register without being too misleading, i.e. doesn't
incorrectly suggest that the Linux-defined words somehow correspond to CPUID
leaves.  KVM usage of "leaf" isn't perfectly aligned with the SDM's usage, but
I can't recall anyone ever complaining that KVM's usage of "leaf" is confusing.

On the plus side, "leaf" helps communicate to readers that the code is dealing
with the data, as opposed to referring to the function+index values themselves.
And IMO, "leaf" is much more self-documenting that "word" or "cap_nr".

