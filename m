Return-Path: <linux-kernel+bounces-407758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D99C9C7347
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29271F214D0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9811E1EE025;
	Wed, 13 Nov 2024 14:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rBZnOZl6"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF647DA6C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507357; cv=none; b=cNfft2jqLp1pAsp6DlcbFnM+d/1BFRfw5Rzr73aW8/YW+l6e3Q+GnAnYamjROdI1shJHK7lVjAQgw7tMamRSm7XqVbZa8wf6YmVNRD7fjTrCGf6RWAzjwHYBgQRZlDZFo14PZxCJuvHwhblVZSWt3XYNpu9Fx4vnKOsTo5q6fHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507357; c=relaxed/simple;
	bh=BLCwlsdqGcj8Y755Wycts3XSrM0wxW/XT4sNCQyNlak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CfrmXdcNTMTmXfxqZgBgkOUqoxc7Vp5uxqx//1fOThqvd31/nK2YsumlumS3PsYcVoW6nJw2scebFqhKupbXJJ+CU1SjQ7Gl9NrJNAwDqsHdr45XftWyPC0mhZgcyNUZfmewjoYasVpnULPdR6jbo6G8Q3mNjBFRUt90J6j7lCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rBZnOZl6; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-460969c49f2so274101cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 06:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731507355; x=1732112155; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5T8Kawbxw2in6ThAnOTi765m6pW6cPCiOT7EoL8So8I=;
        b=rBZnOZl6rFgX6yiq/Wodrh5JN6Tk9xO9rUCKbPYt9aZ484tuQEkDg0LxxtnPhlW5+q
         dEc0avNofKy5RXC0Hg+RKZiVbQNqnZPSOrRRGzyGNpD4+2/bVRDql9uPnZRahNHA6EtS
         UH7RHh54JoFDt76D56ez/d9Umx6k92a3ER4bJkBQO6J04b3MOq8WopY+xa3E0q9i+txv
         Bodvk2mteB7Rd/s3eP4Z2IiyJc+yg83kKoySJPZORo+CHtYk03f27ENxJJfp9JWMdodV
         +mVa+AeVuytXqjxqZelAT8Q1G/xkSm1zpuxvJd9kDXzZKKgnJROKojog8UN0pHs6iHwE
         7RDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731507355; x=1732112155;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5T8Kawbxw2in6ThAnOTi765m6pW6cPCiOT7EoL8So8I=;
        b=cDoV13ynJhER7gn6YsCnWR0VvkauEVv0DYgKgzL/POslXlO5zhYUZOAxUYpnED7VuG
         +4vQOz3A/HrvR/Yo2LagaHkTvVi7FvFqW1KHyAcydqfx+NCoYjpdrH11qIUGgYQIOfQ7
         WMfBeBp++FoEkTKy5vc4Di0REv7sLX7BYC6sCuhazwfSimFixygXd1ZVAMVYfTtaw7Mp
         7TlAZRdj4zIgy3UfM2ZcCdBsCh5QKu7Wn3J9FqZ2vvB5pfiCkWoU7lfRtZ6lcmE64rns
         8iLQwTR9tj63tBrMH8FI/mB7AoypQWG8HucFJ+e/q86T5XXY7n/hDTXRNjUyDN4IWG9E
         IGVw==
X-Forwarded-Encrypted: i=1; AJvYcCX+2RjpdpFky+LGiPgKWiTFMNfUNxVJOXztqnhzPQ7M8DBeAlGAjMK127gaw1TVK4cRJCESQXg5R6s97nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhSlyXAI8EtTfYxDZg+qYUKwsQ055tkWQTTx40UZK5lnXNiJUS
	5/nr4U9otD0Mzk1otUDtD0ZpJ/Syv1I1NWiIgt25ZV4uiiE4ebdPMiJ83ERVxr8Pw+SPNKLFqx7
	LHxTNqLD7XT3ENafZ9wTAUs9DszHNO/bCNngB
X-Gm-Gg: ASbGncsvWd6JIIHAUHDna7ubjY02yfKHW9aLyhoCDPMOylG8vrXfvsBzXl7y+NaGXBp
	35TUzIbN4Y53+URBc3LbjXyHg5+HwpBxKMQUq/HUOkjNOdLz7ummPzqTvgnEmP3No
X-Google-Smtp-Source: AGHT+IHuOditDmp5tKtdUc1O8C17mNbkbkrKZi2qDLWCZb5l+dy8BjzLUhRcC3176dfRYWG0F22tkNDuEg3qPngKTPo=
X-Received: by 2002:a05:622a:144b:b0:462:b6c6:8246 with SMTP id
 d75a77b69052e-4634bc104c6mr3749031cf.14.1731507354816; Wed, 13 Nov 2024
 06:15:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105215455.359471-1-david.kaplan@amd.com> <20241105215455.359471-20-david.kaplan@amd.com>
In-Reply-To: <20241105215455.359471-20-david.kaplan@amd.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Wed, 13 Nov 2024 15:15:43 +0100
Message-ID: <CA+i-1C38hxnCGC=Zr=hNFzJBceYoOHfixhpL3xiXEg3hcdgWUg@mail.gmail.com>
Subject: Re: [PATCH v2 19/35] Documentation/x86: Document the new attack
 vector controls
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi David,

I'll respond separately to the more interesting thread of discussion
w/ Boris & Derek but here are some more specific comments:

On Tue, 5 Nov 2024 at 23:00, David Kaplan <david.kaplan@amd.com> wrote:
> +User-to-User
Sorry for the annoying bikeshedding, but this naming could be
misconstrued by a hasty reader as being concerned with the boundary
between Unix users. I wonder if we should say "userspace-to-userspace"
or "process-to-process" or something? The latter would be confusing
because it doesn't imply any exclusion of KVM guests though.

At first I thought "don't be so pedantic, users really need to RTFM
here regardless,
at most we just need a 'note this has nothing to do with Unix users'"

But... actually isn't it conceivable that one day we could want
"mitigate attacks between userspace processes, unless they have the
same effective UID" or something? So then the naming would be really
confusing.

On the other hand, your response to my "but my trust domains are way
more complex than that" comment at LPC was "Google aren't the target
audience for this mechanism". Maybe anyone who knows that their unix
users are meaningful trust domains (probably: someone building a
specialised distro (Android?)) is similarly outside the target
audience here.

> +The user-to-user attack vector involves a malicious userspace program attempting
> +to influence the behavior of another unsuspecting userspace program in order to
> +exfiltrate data.  The vulnerability of a userspace program is based on the
> +program itself and the interfaces it provides.

I find this confusing. "Influence the behaviour" sounds like it's
talking specifically about attacks that drive mis-speculation
(Spectre-type), but shouldn't this also include stuff more in the vein
of L1TF and MDS? I also don't really understand "the interface it
provides".

To be concrete, imagine there's a system where process A just sits in
a loop reading a secret, and on a system with mitigations=off there's
a vuln if a userspace attacker can preempt process A, it can leak the
secret from some uarch buffer it had naturally got into. I expect
mitigate_user_user=on to prevent that, but this wording doesn't really
sound like it does. I guess the vulnerability is "based on the program
itself" in that it took advantage of the fact it read the data into
the buffer, but there's no "interface" and no "influenced the
behaviour".

I think the best I can come up with to describe what I expect this
flag to mitigate is: "a malicious userspace program attempting to leak
data directly from the address space of the victim program". It's a
bit unfortunate that "directly from the address space" implies there's
some other avenue to leak that data, which might not always be the
case and kinda gets back to the other thread about the
user-to-user/user-to-kernel split. Maybe this is a point against that
split.

> +The guest-to-guest attack vector involves a malicious VM [...]
(Ditto of course)

> +Summary of attack-vector mitigations
> +------------------------------------
> +
> +When a vulnerability is mitigated due to an attack-vector control, the default
> +mitigation option for that particular vulnerability is used.  To use a different
> +mitigation, please use the vulnerability-specific command line option.
> +
> +The table below summarizes which vulnerabilities are mitigated when different
> +attack vectors are enabled and assuming the CPU is vulnerable.
> +
> +=============== ============== ============ ============= ============== ============
> +Vulnerability   User-to-Kernel User-to-User Guest-to-Host Guest-to-Guest Cross-Thread
> +=============== ============== ============ ============= ============== ============
> +BHI                   X                           X
> +GDS                   X              X            X              X            X
> +L1TF                                              X                       (Note 1)
> +MDS                   X              X            X              X        (Note 1)
> +MMIO                  X              X            X              X        (Note 1)
> +Meltdown              X
> +Retbleed              X                           X                       (Note 2)
> +RFDS                  X              X            X              X
> +Spectre_v1            X
> +Spectre_v2            X                           X
> +Spectre_v2_user                      X                           X
> +SRBDS                 X              X            X              X
> +SRSO                  X                           X
> +SSB (Note 3)
> +TAA                   X              X            X              X        (Note 1)
> +=============== ============== ============ ============= ============== ============

Hmm, I'm also confused by this. This mechanism is supposed to be about
mitigating attack vectors, but now suddenly we've gone back to talking
about vulnerabilities. Vulns and vectors are obviously not totally
orthogonal but there isn't a 1:1 mapping.

To be concrete again: this seems to say if mitigate_guest_host=off
there's no L1TF mitigation? (I think in fact it's mitigated by PTE
inversion).

And I don't understand why Retbleed doesn't require user_user or
guest_guest mitigation. I assume I can figure this out by reading
about the details of Retbleed exploitation or looking in bugs.c. But
given this is about making things easier I think we should probably
assume the reader is as ignorant about that as I am.

I dunno exactly what to suggest here, but maybe instead of "we
do/don't mitigate these vulns" this would be more helpful as "we
do/don't enable this specific mitigation action". So instead of a row
for L1TF, there would be a row for the flush that l1tf=flush gives you
(basically, like this kinda already has for spectre_v2_user). Maybe
again I'm just being pedantic and making life difficult here though.

