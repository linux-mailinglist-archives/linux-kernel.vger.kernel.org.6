Return-Path: <linux-kernel+bounces-524567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94066A3E4A9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FBFB189D104
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9288526388E;
	Thu, 20 Feb 2025 19:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xwTFnN/N"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7741ADC6F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 19:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740078229; cv=none; b=cOXSUC7UMfJVgRM8QdP9H5WSgZ/isy9HJXMBa/FMGPtH+8zo44nD3o7dNrVPRsyTwm9kCK6EelcRoD8BckisjYjcCE6kl7Sun6oHna9aNP9WlMdlnAWRl1xqPUK3Fr/gYl/f49o7gZOZRDt6ItmtFDL+6UfJBQU6Fh2yLIAKozM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740078229; c=relaxed/simple;
	bh=CMYJVuqdWZQhUoTuE+0FXAVoJqmbZLoa6YqwNgt6M+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PL5v3wYITBKnk+E32ytBYEqD5UprknO46X8OYeVVXurYIFIf+WXGf+DF9VLK+8HEPByLfrOrsoiNcl4up7zbmUvcD/2OcvIbxwTlH1MKbK3SoqpAvXJcgN0TnMTogyhwxvLT0WKS+/pPc1BN1cISLFEDzaQVEKCnJbtKOM7USMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xwTFnN/N; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-471f1dd5b80so21901cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740078227; x=1740683027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxiQ6wtOwdm+dkAsya9a3cEEzdO1LAZKevXVrkE5I78=;
        b=xwTFnN/NQ9igU0lmBP9diC0CuX6yamRJ/+Ov+48btUHRN0FVRLgVBtcEqedBi1YV6g
         hNRURjsRIZgZufevHV/Pbch4MgD2NjEHyuYToOYhh7TyxJKhGNG1hJIz4yP3FfniSijX
         qrEVHTvnJUc1yQo9D4A5bLtmvZ2fg+RoPApQ6XRln13xULQMK4qAr22An19oiMtxvNAK
         bH4Ahxzky+VM85tFflb04JBQ88Pgm3nmjWd4Q59e3aoHvZtc6+OEu7IKc5tvTUeyi+MT
         qXn4+zRQjKwswuXvABA8uG7J5KUlQJvLLny+YiN4aKVU65uetnH8gGY8p8umxZY6yZOy
         IuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740078227; x=1740683027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxiQ6wtOwdm+dkAsya9a3cEEzdO1LAZKevXVrkE5I78=;
        b=woA0b+InY22mMu5WLf772s9w+EJ8IfnQV1coCaPnV54kbg18OOfDpOPz39idytJ90P
         Qx/Nmkg5zHsYuUTyGfPhssFOiKFjMxriBqoWTXL3lCbru58Vri4lhawJJNHf2+QQI7ZE
         Su8yZoXF3oeq4+BRFz2/EMXkGReNVgjcTJhwUxlebLZjXFqOj38AGYF1vrXHpPgi5qrZ
         yV5oAIWyULlL/u0gRK02rogboyzmEgjFA3jZU2yKx04d6tTaBYaBg8I/2aDd4SWG4ww6
         7kQ0xqlld7ghtkNYJoOMRj7DPJgq67a7GVlJtNHBCJPGFswbyKMXKdbb/YqZ93vf9jf4
         tH+w==
X-Forwarded-Encrypted: i=1; AJvYcCXFJP12HnDr/pR9QCvMeMi4tV9YPZmMpwu9hKU16bMgPWrlCb2deskNDdKdtkm5NoX7t69Bks1QO4CfxVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb5IOaAEI5Csu+oIFWonJtXfCPsvfjRVfYE2uMCI0dZA2J7F+S
	mFSGaAk568WWQ6fEbP8nEOTeifU/0FnR/78woz4payBsz9OYqQflojHz1zTcDdbUiumVQaldmdN
	FBuDkIv+cnWB92Z65JnXRt4gTJY3DojSePOhJ
X-Gm-Gg: ASbGncsbIDCme5pUMaYjGASVWv/GcBWAH5XnW+33s7l5dFVJiSIWK3YTJOVhcs+feL3
	iCxaW/zCDQy2VpGzZHL4lF7ZThOhAagEVtu3a5+Zv4tkoo2EpQJgiHk5zFdlutLsx7O2Zm18g
X-Google-Smtp-Source: AGHT+IESP4lbni9JLo1iujP72rl0UncWhPZ3xqcQGvW9Vo/oQYynNgMZNvVxa6DNjIc9FvD6XgPJibfnmYh6QZ2GyiA=
X-Received: by 2002:ac8:5fd4:0:b0:46c:7cf2:d7b2 with SMTP id
 d75a77b69052e-472238fc66amr85181cf.18.1740078226855; Thu, 20 Feb 2025
 11:03:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213224655.1680278-1-surenb@google.com> <20250213224655.1680278-13-surenb@google.com>
 <20250220185304.8313A7d-hca@linux.ibm.com>
In-Reply-To: <20250220185304.8313A7d-hca@linux.ibm.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 20 Feb 2025 11:03:35 -0800
X-Gm-Features: AWEUYZnhHZmA7CKIk6-rs2tkls49oh6ILCc24Xt36DF6I4s6NBc5M1Lba_eQz4M
Message-ID: <CAJuCfpFPaVY1EHus1p0SY1=hpiGogdPCkgtft7fNZ4gPPj2TGA@mail.gmail.com>
Subject: Re: [PATCH v10 12/18] mm: replace vm_lock and detached flag with a
 reference count
To: Heiko Carstens <hca@linux.ibm.com>
Cc: akpm@linux-foundation.org, peterz@infradead.org, willy@infradead.org, 
	liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	david.laight.linux@gmail.com, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	lokeshgidra@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	klarasmodin@gmail.com, richard.weiyang@gmail.com, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 10:53=E2=80=AFAM Heiko Carstens <hca@linux.ibm.com>=
 wrote:
>
> On Thu, Feb 13, 2025 at 02:46:49PM -0800, Suren Baghdasaryan wrote:
> ...
> > While this vm_lock replacement does not yet result in a smaller
> > vm_area_struct (it stays at 256 bytes due to cacheline alignment), it
> > allows for further size optimization by structure member regrouping
> > to bring the size of vm_area_struct below 192 bytes.
> >
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> > Changes since v9 [1]:
> > - Use __refcount_inc_not_zero_limited_acquire() in vma_start_read(),
> > per Hillf Danton
> > - Refactor vma_assert_locked() to avoid vm_refcnt read when CONFIG_DEBU=
G_VM=3Dn,
> > per Mateusz Guzik
> > - Update changelog, per Wei Yang
> > - Change vma_start_read() to return EAGAIN if vma got isolated and chan=
ged
> > lock_vma_under_rcu() back to detect this condition, per Wei Yang
> > - Change VM_BUG_ON_VMA() to WARN_ON_ONCE() when checking vma detached s=
tate,
> > per Lorenzo Stoakes
> > - Remove Vlastimil's Reviewed-by since code is changed
>
> This causes crashes (NULL pointer deref) with linux-next when running
> the ltp test suite; mtest06 (mmap1) test case.
>
> The bug seems to be quite obvious:
>
> > @@ -6424,15 +6492,18 @@ struct vm_area_struct *lock_vma_under_rcu(struc=
t mm_struct *mm,
> >       if (!vma)
> >               goto inval;
> >
> > -     if (!vma_start_read(vma))
> > -             goto inval;
> > +     vma =3D vma_start_read(vma);
> > +     if (IS_ERR_OR_NULL(vma)) {
>             ^^^^^^^^^^^^^^^^^^^
> > +             /* Check if the VMA got isolated after we found it */
> > +             if (PTR_ERR(vma) =3D=3D -EAGAIN) {
> > +                     vma_end_read(vma);
>                         ^^^^^^^^^^^^^^^^

Doh! Thanks for reporting! I'll post a fix shortly.

