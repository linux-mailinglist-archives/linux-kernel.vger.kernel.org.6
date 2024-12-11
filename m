Return-Path: <linux-kernel+bounces-441237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AD49ECB8E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1A72830A3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B82225A56;
	Wed, 11 Dec 2024 11:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NYUGwhbh"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91EC211A3B
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 11:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733917756; cv=none; b=kOBKf07lvwBwxYabBknnZpqe8AgRutQBbhADdeqKXQ+S8OjePYPmYIoEc45z8FiDfZPTk7S5ZrA8Ui01nTjrn3T3zBxbr9dlFyOUVvCwJGZ/IRlcLK2NXzjr8UKy95rYB+CDFYO0NGX2ydj5a8srcfL8m0CDRlRKoNZX80xqAhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733917756; c=relaxed/simple;
	bh=Afz7Md+4SGxygkYzcj/QROHNaaIWlCVNEawMwRt3y44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ksy/0miK6n7WnYPfc2+iq4T8t1LRhX8gdhXO7TR7uapoDmSBYNZcgSqCHvYT7X+GeGwKLH5BGdndP97XSzkqVeUZ1Gi7bgL8siV8I8x3os4/ot8zaUF7Qw/gAzH6sSTSzvperNGl0PjuXXdscgtoOZ+nhjb0O2Fn8eLu+0jb7rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NYUGwhbh; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38637614567so1986052f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 03:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733917753; x=1734522553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2EqaIbo3wdkBMFqNSfSBUJWTerrNTKyiQvdFD0aob0=;
        b=NYUGwhbhOKldudn8YLya5Gl49SSQNfaOV1CMGDr7p1o1iPTZrzzbg1ZYHhfI//KUpz
         W1eHR+hzqcXC8HlCsbeVMY9F9tnjrAn5ad+RbjNVZXk9BBCyCVkNW4E4MKj6yqJMgwQ8
         hMEYg7Ck9n6sTbhC0hF8Jf3scI+40Yyl0fZLAYLK5xIJjobFtsYnktdDh7fDd6vlE2dY
         UFnDIebPMbQ15NgJBv/jZrYcIB9RLwpgZV+g4qtXJfiMAhY8/l0MMiDWtf7g3TvE6uJd
         3Lc1wnyUWhJd32Vl6Y/Up3NzhDqSjdJ6zZhs+JsFVSgMoQrv3IM6NpCME/CyoVroOOs8
         DORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733917753; x=1734522553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2EqaIbo3wdkBMFqNSfSBUJWTerrNTKyiQvdFD0aob0=;
        b=fhHfIpbP/8oxdWElXTJpX9rzLMm2JT9b/tfsxJCmbf1r1rIOi0kWhY24HFHC+B8Vwb
         /uI33/seuVSjWYolujpRCWiKqUItXiwMiGIfK7iAngh1Vl/ZX+PiumbH8KGOQWZs2HSL
         m/X0tGh6RMXrf7AUGpnNxiPX/bEmJ3n2tLu56wfrPf6q8jnssut4pEqAomv/oPtwnU0/
         SLLzFflV3dvZmBmQlEXbsGPeQoL9v4K2HEvae0Wn56XNeDKrWDT6kMlmPMGYpIuu2xvM
         Ed8UoY7vEkDCFEcrhlcnFPPcIcRfv7DVoZ2xFG0DDtnb9q39Q/HFhyuo3l+e+StNibFc
         ddbw==
X-Forwarded-Encrypted: i=1; AJvYcCVqproODsOzWpcT0FQgDmMxItbxh2tMJLnOV7txNzhFBsXDEybACByjKISj5ki+TeDe8G1tOhNr0s2A2b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YynuRpdhYHgKcQpaXzFKVyr5P4hDUwlea5BK7eshMJoysH+EdrD
	h77qdRO71S/A/m8g39BKRYKX4odrpYD9AGsZzzTfIJMMjkCuUjog/ts/rtLJOUb7k3pJQT8XZ2n
	Rs+STOUNWAlCKn1wGGpEp1vOwzrvQlM+SjKCo
X-Gm-Gg: ASbGncsp16pI5Q56WQJN3G+qFLuonawkiMKaVwqEocyT9nrJ5OiAk9xdQRLWdCfjgOQ
	PBhG8J7uXoXzo5MdW9MsNwZnkKXSHFq4yoG9YDcOrlwKjdZrO2cQPXvbfXkqIXLyK5Q==
X-Google-Smtp-Source: AGHT+IEgqLUMUT+juj9Mz/4TVFLG854CMxmP4SkHc3G7aR8QuFtzd3qYLUl66jeKf0yyTAiDhmt6EUqT8QmMjt4DZac=
X-Received: by 2002:a5d:64aa:0:b0:385:e0d6:fb48 with SMTP id
 ffacd0b85a97d-3864ce894b6mr2199747f8f.7.1733917752950; Wed, 11 Dec 2024
 03:49:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202412111617.7lVvmoPB-lkp@intel.com>
In-Reply-To: <202412111617.7lVvmoPB-lkp@intel.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 11 Dec 2024 12:49:01 +0100
Message-ID: <CAH5fLgjmtuZ7Sxp49GoGC079sXqS4wmsEmZKM-T4Mh9FycDYGQ@mail.gmail.com>
Subject: Re: error[E0425]: cannot find value `__tracepoint_rust_sample_loaded`
 in crate `$crate::bindings`
To: kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, "Steven Rostedt (Google)" <rostedt@goodmis.org>, 
	Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 9:20=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   f92f4749861b06fed908d336b4dee1326003291b
> commit: 91d39024e1b02914cc5e2dbc137908e29b269ce4 rust: samples: add trace=
point to Rust sample
> date:   5 weeks ago
> config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/202=
41211/202412111617.7lVvmoPB-lkp@intel.com/config)
> compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51=
eccf88f5321e7c60591c5546b254b6afab99)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20241211/202412111617.7lVvmoPB-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202412111617.7lVvmoPB-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> error[E0425]: cannot find value `__tracepoint_rust_sample_loaded` in c=
rate `$crate::bindings`
>    --> samples/rust/rust_print.rs:87:5
>    |
>    87 | /     kernel::declare_trace! {
>    88 | |         /// # Safety
>    89 | |         ///
>    90 | |         /// Always safe to call.
>    91 | |         unsafe fn rust_sample_loaded(magic: c_int);
>    92 | |     }
>    | |_____^ not found in `$crate::bindings`
>    |
>    =3D note: this error originates in the macro `kernel::declare_trace` (=
in Nightly builds, run with -Z macro-backtrace for more info)
> --
> >> error[E0425]: cannot find function `rust_do_trace_rust_sample_loaded` =
in crate `$crate::bindings`
>    --> samples/rust/rust_print.rs:87:5
>    |
>    87 | /     kernel::declare_trace! {
>    88 | |         /// # Safety
>    89 | |         ///
>    90 | |         /// Always safe to call.
>    91 | |         unsafe fn rust_sample_loaded(magic: c_int);
>    92 | |     }
>    | |_____^ not found in `$crate::bindings`
>    |
>    =3D note: this error originates in the macro `kernel::declare_trace` (=
in Nightly builds, run with -Z macro-backtrace for more info)

Would it be possible to update the bindgen version used by this robot?
See commit b2603f8ac821 ("rust: warn on bindgen < 0.69.5 and libclang
>=3D 19.1") for details on why.

Alice

