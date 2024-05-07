Return-Path: <linux-kernel+bounces-171971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104408BEB55
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4111F1C2467C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3228116C870;
	Tue,  7 May 2024 18:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y0KIFMQI"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA5773513
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 18:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105741; cv=none; b=JjHUBu1QF7uh5bBYZpidptvv8oTs/XAwv8E0yYl/faxmm6Uf3JWuI12nrhk8hcWo755q/361anCwwzkoxQC5vmtdFhfqboOtB+RnrpdvBMDf0Vem8wwhOxdTZn3zzDWArlG1ghwiKrrUyALzDT9IXXdeVnGUqdo/K6mk/Rw31Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105741; c=relaxed/simple;
	bh=B6+1EVHa+BxNC/qNjMSbBDQufkF0NNXGNNBGPC9g5A8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DTkrVvfcr8durmGzoD1+uvkHvX7+vEiHzJWPu+gv6WJYLLN/tcH+Uoi2Mm6Qtf66qRgEbgoXqK54bgaSqqsGswuSaLo69BHNEDrSMEg1kNJ1lcRgT+U1Ui87Pd5SiPwjyB5QFKwTSwok/Gs2g1qSLRS3UqgNGVq6RGOeccylEyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y0KIFMQI; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-34e7a35d5d4so2580490f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 11:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715105738; x=1715710538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6+1EVHa+BxNC/qNjMSbBDQufkF0NNXGNNBGPC9g5A8=;
        b=Y0KIFMQIY3rUK9a+s+68qD8L6zYhqwOXJy8bzzS/9+ACOJsJdGAJoOgvS4/sWe7uTv
         k0DFAy6cjTQXJYBNxrwmK5C2TUPXJOMkFMqJG1qebB1RAJsUaNTLvulys24TyafHz4JT
         3n5/OqwbDx64ERIUXAzP/UpCnzs5JjICapDfzQxpe62Tu2H8gFcFUabgs66K6uDml0qX
         59C5JsOy7zeFepuCDdalLLoOl3184ittZu0C+iuYGcr16KC8HgS/aURF595hIxk3noUB
         oBZhDVcO9I9nCZYKF1XYGertO5W3/pk3ezPXtkMuZwOesn9I0CEZersX6JhrxszniLy8
         r0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715105738; x=1715710538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6+1EVHa+BxNC/qNjMSbBDQufkF0NNXGNNBGPC9g5A8=;
        b=ElZVPdCEkpZRc73wqkFUr6BryrI+D0wiwfJBfpRPOrkOHa3SAd52stbKv/SgREGT3/
         QzltJNPX4//a4SdV1YnJA0K0s3uokx04bq2bOEZYQ2QIfSoDFX5ahIim02aNGUMIqff5
         Eq90ifI4jU8cpPmuOtx873YQk4f0ivUEkt4fimLcMoPZGrE5knxBs1FKKriwl3GzbMOB
         h2+M9wqDINZx/g/5MJ6UBvPIZgrLTJT+N1irDOCSHtJFsqOoa6T9vqjcR4RdBHHpPni5
         y0sQLqqnND+yu9UowItnGIAozKxkKnviMGmNczpfA8tYs8G/W0q/Mo3thTTze0iA3gF5
         UfLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXabsO/SQptOwUY9iTqvWN6esMJi0AfgravLsKka+sjCCck2n1F/s4Z786S5ioU4jEDG1Zle7MOtjuy040Z7yxM5VBaXVFVGe3aT9H
X-Gm-Message-State: AOJu0Yya+FTQvW/g7LHq42gvdha/7jW5h2WNG8mdm2fcqp9mPMYtdT3p
	kizyyUmMPdaOo1gD2gTarLsvf12aaNb3AfZyWqD9kd75ft2EDhuFiVXd3klDe+v6xnbPwkvRJ+9
	syN9Trri711xEgpmlhp+JqCIzDRR2MHdGuxUa
X-Google-Smtp-Source: AGHT+IGiBLfJdAu/j1h1St0V1qhBnv47XeLp3sDStOowYbzmVGS+F9ghfuJ76RnsVj0Nru5zzf74YpLbJGjySEDtGfI=
X-Received: by 2002:adf:e781:0:b0:34c:f3cb:759d with SMTP id
 ffacd0b85a97d-34fca718376mr330142f8f.45.1715105738140; Tue, 07 May 2024
 11:15:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507022939.236896-1-jhubbard@nvidia.com> <016d8cff-efc3-4ef1-9aff-7c21c48f2d69@redhat.com>
 <302d50ac-45ff-470e-90a0-b349821706a6@nvidia.com> <21d88422-7378-4a63-8fbf-f70889f309c1@redhat.com>
 <CAJHvVcgYsZJ3Hm1Hpc1pifH49uVniAedL-YxUpS8q7=Y8veZ5g@mail.gmail.com> <cf7eaed2-6331-45cc-a66e-76abb5448afe@nvidia.com>
In-Reply-To: <cf7eaed2-6331-45cc-a66e-76abb5448afe@nvidia.com>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Tue, 7 May 2024 11:15:01 -0700
Message-ID: <CAJHvVcg2FQCGBwm0Y41YGgpMYKs8_KJaonwyDg7SPuQipxqH2A@mail.gmail.com>
Subject: Re: [PATCH] x86/fault: speed up uffd-unit-test by 10x: rate-limit
 "MCE: Killing" logs
To: John Hubbard <jhubbard@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, 
	Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 11:11=E2=80=AFAM John Hubbard <jhubbard@nvidia.com> =
wrote:
>
> On 5/7/24 11:08 AM, Axel Rasmussen wrote:
> > On Tue, May 7, 2024 at 9:43=E2=80=AFAM David Hildenbrand <david@redhat.=
com> wrote:
> ...
> >>> That thread seems to have stalled.
> >>
> >> Yes, there was no follow-up.
> >
> > Apologies, I had completely forgotten about this. I blame the weekend. =
:)
> >
> > No objections from me to the simple rate limiting proposed here, if
> > useful you can take:
> >
> > Acked-by: Axel Rasmussen <axelrasmussen@google.com>
> >
> > But, it seems to me the earlier proposal may still be useful.
> > Specifically, don't print at all for "synthetic" poisons from
> > UFFDIO_POISON or similar mechanisms. This way, "real" errors aren't
> > gobbled up by the ratelimit due to spam from "synthetic" errors. If
> > folks agree, I can *actually* send a patch this time. :)
> >
>
> That sounds good to me. (Should it also rate limit, though? I'm leaning
> toward yes.)

I believe the proposal so far was, simulated poisons aren't really
"global" events, and are only relevant to the process itself. So don't
send them to the global kernel log at all, and instead let the process
do whatever it wants with them (e.g. it could print something when it
receives a signal, perhaps with rate limiting).

>
>
> thanks,
> --
> John Hubbard
> NVIDIA
>

