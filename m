Return-Path: <linux-kernel+bounces-388044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 127F99B59BA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 03:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89E05B228D3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 02:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C699B14E2E2;
	Wed, 30 Oct 2024 02:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eNqLFD89"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C84DD531
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 02:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730253836; cv=none; b=oQs3cvE63NZ4vHIRsWJCCvemAiOQeFU/2La+2cBCs1hFfzJy0/HOiTX5PtOxV4nsTG/cwCFvUhMCE7calN8UpKBS4X4NSPJN2A2Hri5wEYMb2xKVlNkkZ4TM+wHdJLcVv9Pd9OJ8MQtoyW3NwUNwuzNd+Dh2SEq/mub4b6mG2PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730253836; c=relaxed/simple;
	bh=xkjLvn17Z87D+syRsH5nw5KTPUgG4hGPVNJvWUGUz3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VYs3pA3Z8grQZdxY0n3Rnc55QqOSzJSnwjK6BhV/DJaAL3uLV1t4hniJhqfI+O46SFfWRvhXScAhL7ZP3eetnOGlUYtip20+aOqDuIdCIBG5WkHzCH1k67qwEFwiR2NSXp+59ZuxrKTz9PFk+LulJOTzisYumxqc9tGnPZ4HDjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eNqLFD89; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso93874191fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 19:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1730253831; x=1730858631; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JuPyDPbc2gk5S8Wqk+8pKf2mgSYZmu8HyR2K7BYNpbE=;
        b=eNqLFD89B3lJjfTfony7gMgDQpSUQvcopk9FzwJPbDlZ5VF8Y6n4LYaE1bMsjl+TSR
         01lNK5SZRd0OaDsUaJ8NSYB/Z3pxdcM4+WbJNd1Kdj9587HElsCDtZDM6IuqgGpKgHsJ
         VWDHrdUZvyPrslT+feRz/b1+fcTqHNsdPr31I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730253831; x=1730858631;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JuPyDPbc2gk5S8Wqk+8pKf2mgSYZmu8HyR2K7BYNpbE=;
        b=it2d/mcc7WgVikWMlV56EN+z/vmPuGrE8Urw9LkfrdLyQlc9Gb8msQezd5iaNbHIfA
         rU2ENzYLxto245ekDw4j1qSCamDVGpVfaEzvSm+zSg70dXpzQcYjGlw5tNczad4efkSf
         rBUU5q60CLV3cOCJiZLCn6YVImwXbXer/GO7/MeeO1prgbf+abWBQdnnk2OzpuhjOAJj
         34QLR+erk3LyRaqgaVWj02YAPKKz+rH5kQmKWPSm377rFIKdULSRHApcb+V5YjTKxw31
         uF1DUhpTArYvaOcrtkfGWvZcid5g1vZdOeUqUc0GUhqmZB4I8YuKOuxhWtqOL7pKUCHN
         p1og==
X-Forwarded-Encrypted: i=1; AJvYcCWpLAv09+sDGdP9YvwgxWQjGR7HUeeko1YGL1atTmh83W4solneG0LD0nnKa/KupDwtMBqfWy1Mpr0OWVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWq4DOKHpaXsUrdtRpkh23kct04in+rjI/8Gg30LqigBQFS9zB
	tyqlMPxX35vGeIqkgBoJHkzG5xUhLdzOjX9re0NJz2o5/7sS4L+g4BIqHH6CM3khJyP0rpt2T7k
	530U=
X-Google-Smtp-Source: AGHT+IH7i1azY0qHIJWbXWpJULWZrZsus16ITPYsT63XZh2KUwNiGUicjgKpI+9ZMOJTHMQS3kI2Bw==
X-Received: by 2002:a05:651c:2220:b0:2fb:6110:c5df with SMTP id 38308e7fff4ca-2fcbe063fe2mr114682861fa.31.1730253831171;
        Tue, 29 Oct 2024 19:03:51 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fd4ae6e443sm1124941fa.21.2024.10.29.19.03.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 19:03:49 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53b13ea6b78so9494197e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 19:03:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVIJDh2x/4yvOcZQmcoAugFr09spxwPWXCvu93flACwXuI1UXd0nGap/Jxo5nW7Ce9iVJp6w50OVZ8bKTQ=@vger.kernel.org
X-Received: by 2002:a05:6512:1189:b0:53b:163a:f279 with SMTP id
 2adb3069b0e04-53b34a345f7mr11433327e87.53.1730253828812; Tue, 29 Oct 2024
 19:03:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730166635.git.jpoimboe@kernel.org> <5b887fe4c580214900e21f6c61095adf9a142735.1730166635.git.jpoimboe@kernel.org>
In-Reply-To: <5b887fe4c580214900e21f6c61095adf9a142735.1730166635.git.jpoimboe@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 29 Oct 2024 16:03:31 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgaPk0tB-RtVAK4b6dTrtTAC3WkL1LmGO==ATrDLL-DRA@mail.gmail.com>
Message-ID: <CAHk-=wgaPk0tB-RtVAK4b6dTrtTAC3WkL1LmGO==ATrDLL-DRA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] x86/uaccess: Avoid barrier_nospec() in 64-bit copy_from_user()
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Waiman Long <longman@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Andrew Cooper <andrew.cooper3@citrix.com>, Mark Rutland <mark.rutland@arm.com>, 
	"Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: multipart/mixed; boundary="000000000000d758120625a81cd4"

--000000000000d758120625a81cd4
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Oct 2024 at 15:56, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> The barrier_nospec() in 64-bit copy_from_user() is slow.  Instead use
> pointer masking to force the user pointer to all 1's if the access_ok()
> mispredicted true for an invalid address.
>
> The kernel test robot reports a 2.6% improvement in the per_thread_ops
> benchmark (see link below).

Hmm. So it strikes me that this still does the "access_ok()", but
that's pointless for the actual pointer masking case. One of the whole
points of the pointer masking is that we can just do this without
actually checking the address (or length) at all.

That's why the strncpy_from_user() has the pattern of

        if (can_do_masked_user_access()) {
                ... don't worry about the size of the address space ..

and I think this code should do that too.

IOW, I think we can do even better than your patch with something
(UNTESTED!) like the attached.

That will also mean that any other architecture that starts doing the
user address masking trick will pick up on this automatically.

Hmm?

                Linus

--000000000000d758120625a81cd4
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_m2v8eji00>
X-Attachment-Id: f_m2v8eji00

IGluY2x1ZGUvbGludXgvdWFjY2Vzcy5oIHwgMjEgKysrKysrKysrKysrKysrLS0tLS0tCiAxIGZp
bGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9pbmNsdWRlL2xpbnV4L3VhY2Nlc3MuaCBiL2luY2x1ZGUvbGludXgvdWFjY2Vzcy5oCmluZGV4
IDM5YzdjZjgyYjBjMi4uNDM4NDQ1MTBkNWQwIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L3Vh
Y2Nlc3MuaAorKysgYi9pbmNsdWRlL2xpbnV4L3VhY2Nlc3MuaApAQCAtMzgsNiArMzgsNyBAQAog
I2Vsc2UKICAjZGVmaW5lIGNhbl9kb19tYXNrZWRfdXNlcl9hY2Nlc3MoKSAwCiAgI2RlZmluZSBt
YXNrZWRfdXNlcl9hY2Nlc3NfYmVnaW4oc3JjKSBOVUxMCisgI2RlZmluZSBtYXNrX3VzZXJfYWRk
cmVzcyhzcmMpIChzcmMpCiAjZW5kaWYKIAogLyoKQEAgLTE1OSwxOSArMTYwLDI3IEBAIF9pbmxp
bmVfY29weV9mcm9tX3VzZXIodm9pZCAqdG8sIGNvbnN0IHZvaWQgX191c2VyICpmcm9tLCB1bnNp
Z25lZCBsb25nIG4pCiB7CiAJdW5zaWduZWQgbG9uZyByZXMgPSBuOwogCW1pZ2h0X2ZhdWx0KCk7
Ci0JaWYgKCFzaG91bGRfZmFpbF91c2VyY29weSgpICYmIGxpa2VseShhY2Nlc3Nfb2soZnJvbSwg
bikpKSB7CisJaWYgKHNob3VsZF9mYWlsX3VzZXJjb3B5KCkpCisJCWdvdG8gZmFpbDsKKwlpZiAo
Y2FuX2RvX21hc2tlZF91c2VyX2FjY2VzcygpKQorCQlmcm9tID0gbWFza191c2VyX2FkZHJlc3Mo
ZnJvbSk7CisJZWxzZSB7CisJCWlmICghYWNjZXNzX29rKGZyb20sIG4pKQorCQkJZ290byBmYWls
OwogCQkvKgogCQkgKiBFbnN1cmUgdGhhdCBiYWQgYWNjZXNzX29rKCkgc3BlY3VsYXRpb24gd2ls
bCBub3QKIAkJICogbGVhZCB0byBuYXN0eSBzaWRlIGVmZmVjdHMgKmFmdGVyKiB0aGUgY29weSBp
cwogCQkgKiBmaW5pc2hlZDoKIAkJICovCiAJCWJhcnJpZXJfbm9zcGVjKCk7Ci0JCWluc3RydW1l
bnRfY29weV9mcm9tX3VzZXJfYmVmb3JlKHRvLCBmcm9tLCBuKTsKLQkJcmVzID0gcmF3X2NvcHlf
ZnJvbV91c2VyKHRvLCBmcm9tLCBuKTsKLQkJaW5zdHJ1bWVudF9jb3B5X2Zyb21fdXNlcl9hZnRl
cih0bywgZnJvbSwgbiwgcmVzKTsKIAl9Ci0JaWYgKHVubGlrZWx5KHJlcykpCi0JCW1lbXNldCh0
byArIChuIC0gcmVzKSwgMCwgcmVzKTsKKwlpbnN0cnVtZW50X2NvcHlfZnJvbV91c2VyX2JlZm9y
ZSh0bywgZnJvbSwgbik7CisJcmVzID0gcmF3X2NvcHlfZnJvbV91c2VyKHRvLCBmcm9tLCBuKTsK
KwlpbnN0cnVtZW50X2NvcHlfZnJvbV91c2VyX2FmdGVyKHRvLCBmcm9tLCBuLCByZXMpOworCWlm
IChsaWtlbHkoIXJlcykpCisJCXJldHVybiAwOworZmFpbDoKKwltZW1zZXQodG8gKyAobiAtIHJl
cyksIDAsIHJlcyk7CiAJcmV0dXJuIHJlczsKIH0KIGV4dGVybiBfX211c3RfY2hlY2sgdW5zaWdu
ZWQgbG9uZwo=
--000000000000d758120625a81cd4--

