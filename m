Return-Path: <linux-kernel+bounces-566866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 522D3A67DB0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6DA5172E2C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670F8207E0B;
	Tue, 18 Mar 2025 20:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRsN8JFz"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C11C1C5F3F;
	Tue, 18 Mar 2025 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328377; cv=none; b=CiJI/NOpMZZA6gOca+VWwagsl0eBL539MiMvizTuMojNo0OOLTz8cAbR0FaQ1ln/rx/ZHXTM+mrp26Y3LK3wSSWAKX+OjX8nkJI2zo4m0z1DTJbNQNCJqF7Vq3bLGwhXLVmCI4TKzG/QWdLYm/Ng/DGOrlNax7KcJ/qQx0oynro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328377; c=relaxed/simple;
	bh=sJ91F9o74Zypp90eWRyjzCPDNDVmPFb6kTJCfvNeHAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hoz6I23i6BdGhwvCF3DMIfs0ktOq8AVUqpbHnGDiTnNVdJDLC9friygBI7Ng88tloaW+PNJVRbAXsGhT0OFvDM9aOdK6r1bojFG+sbYSqUT5WdSP4sC7AoX7xwqN9iXqvWq3/Wp3bZHo8JFA+ruYQ6SXlCqSYdpKdnCZfQcErHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRsN8JFz; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3061513d353so74355671fa.2;
        Tue, 18 Mar 2025 13:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742328369; x=1742933169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJ91F9o74Zypp90eWRyjzCPDNDVmPFb6kTJCfvNeHAQ=;
        b=PRsN8JFzol75h6oTuF1GGgKXdsz5iRiufV9xJ+xBbbSudv2F9sFWLaEDLp0Bt48lqc
         gFGvPG25ih5ar6P/y92ovl7unbMKF1MmfQRH41MCVH7CZxeBcSv7mW/SaqtCLQTBs4nN
         uyPUtLyqGvNV8/ecZgXdGOgJJFRfiNBuPLufB2hyslm2w+efhxKCnGNkO6QDz9Ihpe2H
         /HeblxaTa8To8amCfKxhv/s1FIJAwl30Xqp+wZJtPFWKFkUM8W7Aig6SGjhmyX5q/EQw
         q+o0DW9HEPJJ/Ap/h/pGWRpbzrFHnA9LSidZPeSwEcgqSsDelx2K2XDA+Pl68Ur5A6eU
         9arA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742328369; x=1742933169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJ91F9o74Zypp90eWRyjzCPDNDVmPFb6kTJCfvNeHAQ=;
        b=sghyzf2LxJZv4V5DXZNkk+aeOOCy4g4/O25+mBDX5V/Moxy4GszQAoPrGh+iGgIaqk
         F0ELXaN/LbiBD1sYyWgIkV95xt6T9BoXT8/IQp934XnThWQmFNDBZKSqFitJN/f1vMTu
         eM2GFXoGauZC4Lxb2K4WpUqAcC4DvA8yGI5abG8DimdgpxA9M53aajGjiWfDbzXtuR1i
         5RkazroWpIKfHIY5yd7Pax7V9+RPmMBfGnMoJ8F9X+QqhFcMZ2cqNykpcj3+N+WzzRVe
         OZQl0Zdzejv0BoAxSMt+rUZXtOgzs57gLBEOYzStdJ+AJgkGrveUIViOy6Lj5Fe6p/AY
         mXqw==
X-Forwarded-Encrypted: i=1; AJvYcCUCa6W0bnx3PCpsK6J5S7/KUkmu16m6HmpxOptTcvcyRQIP492YyQrtcHIYopws+vmomgglzOOkdLrw8qs=@vger.kernel.org, AJvYcCWCh0rjQd5DVPEBorDPYuYS4DMZmPMlQ2TFHylKVKIJtVNotMGtr5wg7X21mtVBAE5Aoii8/prSMIAz2apz/TY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv4zhxkoldcFLz9qOMrkULMNA8Q9McZsdQRxlkCyPga/WE9EtA
	9J5Kjt2u9WgwZuIG0fe2wOxuB2kN28E/zhX/7VtX03r+lzzspVt9MyH1Zt5MdgUePzaeN/zgi3a
	c4BFUWetUxfF56oADdnpJ2MECIyo=
X-Gm-Gg: ASbGncuReQ8lhnTW2YmAO2uQ/0cOmIMIA4wyVz/MhiT/5h5XlHPFGvALP91c/hZ0TkH
	NZ2uJwDEr3tvY2g3Xvkib3Du8ewUmb87uK1SbugG+E/8p6wqBxnT2juyDU3u9Tkxmnzw4LUTd/x
	zbEXkmjVEPaj3/JjVYzYOBT4Nk4/eRlIimA2bppMsgDw==
X-Google-Smtp-Source: AGHT+IFkS9QwT8jQGFHph1qa6JHCApQJ7Z+fJJIuJ/wKVtxrnyOCXykrq9OHZwSo6YU8OuwpsWL6/oZvLSSy2BIAteg=
X-Received: by 2002:a05:651c:2127:b0:30b:c83e:720f with SMTP id
 38308e7fff4ca-30d6a410c7cmr311281fa.7.1742328369068; Tue, 18 Mar 2025
 13:06:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ-ks9=oq+c_pMg41QgGWsj=phWYfntXQgpSrFmz16Vifofn3g@mail.gmail.com>
 <Z9gL5hQWvCNy5XNH@google.com> <Z9gcqHihXLg6kcZb@google.com>
 <CAJ-ks9n=7fqtNr88co-EU7d9Wo1Dz1Wmp0p3K0b8RQE9mjrbHQ@mail.gmail.com>
 <Z9k9I6mp11Z358vz@google.com> <CAJ-ks9kcNvGqGrU1nKjYs_4XPbdxo2cW8Tj9JOGJesGO4StdAw@mail.gmail.com>
 <Z9mGv6ir4c96Of0Q@google.com> <CAJ-ks9mHvjPn98mcXh3q18nB5pPH6YBj3jf1YH6510bP-mtFtQ@mail.gmail.com>
 <Z9m_mfg5b0XE_HCF@cassiopeiae> <CAJ-ks9=YSN8VRUW6VTfThkN8uh42rbq9pBwvrG=EuW2wpuXx5A@mail.gmail.com>
 <Z9nI_kM6LPELbodm@cassiopeiae>
In-Reply-To: <Z9nI_kM6LPELbodm@cassiopeiae>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 18 Mar 2025 16:05:32 -0400
X-Gm-Features: AQ5f1Jr7O7kX7FG5tlllu_eiGeVGIjwIAneZzHlbTVAER2mdHcgkSBhQ5Ih6igw
Message-ID: <CAJ-ks9=yvF2bV6bQTATZWNxCEtbMmROo5BqY3FmPx1DEkX1g=g@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: alloc: add `Vec::dec_len`
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andrew Ballance <andrewjballance@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 3:27=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Tue, Mar 18, 2025 at 02:53:48PM -0400, Tamir Duberstein wrote:
> > On Tue, Mar 18, 2025 at 2:46=E2=80=AFPM Danilo Krummrich <dakr@kernel.o=
rg> wrote:
> > >
> > > On Tue, Mar 18, 2025 at 02:28:02PM -0400, Tamir Duberstein wrote:
> > > > On Tue, Mar 18, 2025 at 10:44=E2=80=AFAM Alice Ryhl <aliceryhl@goog=
le.com> wrote:
> > > > >
> > > > > On Tue, Mar 18, 2025 at 10:12:28AM -0400, Tamir Duberstein wrote:=
\
> > > > > >
> > > > > > The methods you're describing are all on Vec, right? In other w=
ords,
> > > > > > their usage calls for a private `dec_len` or `set_len`. As I've=
 said
> > > > > > repeatedly in the course of this discussion: I would prefer not=
 to
> > > > > > introduce `dec_len` at all here. It (or `set_len`) can be intro=
duced
> > > > > > in the series that adds truncate or your patch that adds clear,=
 where
> > > > > > its signature can be properly scrutinized in the context of an =
actual
> > > > > > caller.
> > > > >
> > > > > Oh I did not see that you said that. Dropping patch 2 is fine wit=
h me.
> > > > >
> > > > > Alice
> > > >
> > > > Benno, Danilo: are you both OK with this? I'll discard this patch o=
n
> > > > the respin and prepend the patch adding the len <=3D cap invariant.
> > >
> > > I mean, the whole reason to switch set_len() to inc_len() and have a =
separate
> > > dec_len() was to properly cover things like [1] and Alice' patch by h=
aving
> > > dec_len() return the abandoned entries.
> > >
> > > If we now only switch set_len() to inc_len() and drop dec_len() then =
what should
> > > Andrew do?
> >
> > I'd be completely fine with Andrew (or Alice) taking this patch into
> > the truncate/resize series[1] (or the series that introduces clear
> > [2]). It can be properly reviewed there in context.
>
> Sorry, I'm not willing to make this Andrew's responsibility; set_len() wo=
rked
> for his patches before.
>
> If you're uncomfortable implementing your proposal without the existence =
of
> truncate(), please rebase onto Andrew's patches.

This suits me just fine! I tried applying Andrew's patches locally but
I don't have `Documentation/gpu/nova/core/todo.rst`. Do you know what
his base commit is?

> I think Alice' patch can also go on top of that, since it should just be
> truncate(0).

=F0=9F=91=8D

