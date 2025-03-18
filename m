Return-Path: <linux-kernel+bounces-566882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D4FA67DE8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDD87174A66
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A451D214226;
	Tue, 18 Mar 2025 20:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKsCVtPK"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231502139DB;
	Tue, 18 Mar 2025 20:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328863; cv=none; b=IkgMte442fpRTyB/RJ7e53VNOJfGPhlg8Az0OY/A/81zGZCBiZMT2kC/xxxBAauKWriu8Ls9NbFy8QOk7mSE+LwmkRGaATo9eK+KyVDbiasH1ry7wmaeZfN0DF5t0m/XH2IwUzXzlVPjjSPBeV2JjgWjS0XDOUrKAnKnf6557r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328863; c=relaxed/simple;
	bh=u39ajD0+BeOrIDvjxfLznHiLdbFsNHhj6yP+lokG/Bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCLxRFHQ0GAK9K5VF9xa8rf9jGpYVwuYEVja3DtQizBKNp6tmYs8IrPf6SSk708WO8XOwpAHn5zeRpk6LOCEiFEuH7fxNrK+KVjkwRQBIblhFuGeIUWQdR+AZ6lclmBhKCzjDzSnpohCyBVG8/1EPkx64zAqbG0XYlw/OoBMwv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKsCVtPK; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54954fa61c9so7476924e87.1;
        Tue, 18 Mar 2025 13:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742328860; x=1742933660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u39ajD0+BeOrIDvjxfLznHiLdbFsNHhj6yP+lokG/Bg=;
        b=YKsCVtPKPOub3Fs++Xy+a2jLcb1l25WKLj3cYOQ+4ibHSqln1tA1pgD8sErFzH7TFn
         XzSMn0DKPNXFXc7/5kA37YGxvdb6dKHTzc1DKLM7nOPGvXDeN1tXsSUsYBfDg3Wd6p31
         Ps6Uiljugy2QMV2hmsATyBHkfDolAZOEV47hqUwtbLOdpnYk7+qsvpCuC5J1l5DJxoG/
         HnTn0Vg2O+fOziYGsUqbg05J3A/8oisC5L77C2vqMIsFnlBLfPQdJf2nct94YB3D36if
         lp+GWDc0J9soeU4QZkn6IGDiQ9LIuWnGlqmT5iKGxn4cb8kcXbJiB8F1r5yJ7F2Zv0bZ
         FRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742328860; x=1742933660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u39ajD0+BeOrIDvjxfLznHiLdbFsNHhj6yP+lokG/Bg=;
        b=eSn6RVzNbxAAx9XxBV0oL4e7NW2bm3NFYqlb4Ay7mwpVT8st/PG8N17Gt1Qse9Helk
         nI6L1Ojeulahw7gmmoUDyLijQHBVcI9EqZXIhve9zk+5Uc8pO/HfKFk2ZfB4ewuPYLA+
         yW6JOvw52DS37/43HRrrMSy14vWF4CWo+k5RivkHYtvLitSqtQiIRY9zsgHdkAbC/qf2
         /4DrtoL0E7qegiLqaix+GXy6wSrcuQVr3je7Hqe8H4zqpvxrcbql2RLpQiTGLMFWJuVj
         GSOYQROA3tsEv0o/lrCsFB9BG7vsi5pCikavh0USqsmQwxqmxE1VZigqZJ9+L0kMRhlT
         iwwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0Q0w8PrB1dRJmpNRkV358W1O1h28PN62BuukTojM33tevAhvTkVC61FD78sgZ63rRAu3P05NAaL58brhGHdk=@vger.kernel.org, AJvYcCUd1uZinWuLkeUYIovYnHo84wRuwxyr6Q1HBfOoZB9J86UXVBXuILzrKf9FlqefS3tVtEbeoL82n6n9hEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl14MzSpXmRHt4i6LjEm0kQZsGuBx+VOpJLoInMG1HvBF4w78J
	0YBUfkzjwIJ3TdhoSr11ZJKIeAoBYYOcW5hJyOLakEuDeMell+MA/cb/th6ja1DuDjm3QDem2ft
	W1rphHkMrAXzoV0cww3iQI7AD/hg=
X-Gm-Gg: ASbGncs5meXEuBWuYvDHSGdya0iZJOPr5aaIe+hjTUAjuAeJt5Vgdv62bl8gwYeG4g8
	CUgdhGI4eNjWOEZDcjm6u/e6AbCXhzZAlYgG9Cjsxfm0AEh9Q7sB9HLTcz/CBpZ0HbAvZMiNIPE
	rPwPD5yCeVHyXsDXgIn3OB2rTjnK/8QASJxvAcuVN4PV2Kk2l0WWer
X-Google-Smtp-Source: AGHT+IHOxtQBwriPLZpkVib0GdCPB2qqU0cgQVG4LCKi5uSrORFsW9jt1EXcnzA13Jz4hpIwaqz65jk6JP4w/bIeXOQ=
X-Received: by 2002:a05:6512:118b:b0:549:8c2a:3b4 with SMTP id
 2adb3069b0e04-54ac9c4dab7mr149397e87.13.1742328860016; Tue, 18 Mar 2025
 13:14:20 -0700 (PDT)
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
 <Z9nI_kM6LPELbodm@cassiopeiae> <CAJ-ks9=yvF2bV6bQTATZWNxCEtbMmROo5BqY3FmPx1DEkX1g=g@mail.gmail.com>
In-Reply-To: <CAJ-ks9=yvF2bV6bQTATZWNxCEtbMmROo5BqY3FmPx1DEkX1g=g@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 18 Mar 2025 16:13:43 -0400
X-Gm-Features: AQ5f1JpLbCZ8LCr93MK_jr5e7RYMH4J7jusELsztBP_8toXSY-e-zCky9vYzxZw
Message-ID: <CAJ-ks9mmkm2LT7BYg3ni0v-PsV4Gv57=SOD1xDp1_aeqN7XPzA@mail.gmail.com>
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

On Tue, Mar 18, 2025 at 4:05=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> On Tue, Mar 18, 2025 at 3:27=E2=80=AFPM Danilo Krummrich <dakr@kernel.org=
> wrote:
> >
> > On Tue, Mar 18, 2025 at 02:53:48PM -0400, Tamir Duberstein wrote:
> > > On Tue, Mar 18, 2025 at 2:46=E2=80=AFPM Danilo Krummrich <dakr@kernel=
.org> wrote:
> > > >
> > > > On Tue, Mar 18, 2025 at 02:28:02PM -0400, Tamir Duberstein wrote:
> > > > > On Tue, Mar 18, 2025 at 10:44=E2=80=AFAM Alice Ryhl <aliceryhl@go=
ogle.com> wrote:
> > > > > >
> > > > > > On Tue, Mar 18, 2025 at 10:12:28AM -0400, Tamir Duberstein wrot=
e:\
> > > > > > >
> > > > > > > The methods you're describing are all on Vec, right? In other=
 words,
> > > > > > > their usage calls for a private `dec_len` or `set_len`. As I'=
ve said
> > > > > > > repeatedly in the course of this discussion: I would prefer n=
ot to
> > > > > > > introduce `dec_len` at all here. It (or `set_len`) can be int=
roduced
> > > > > > > in the series that adds truncate or your patch that adds clea=
r, where
> > > > > > > its signature can be properly scrutinized in the context of a=
n actual
> > > > > > > caller.
> > > > > >
> > > > > > Oh I did not see that you said that. Dropping patch 2 is fine w=
ith me.
> > > > > >
> > > > > > Alice
> > > > >
> > > > > Benno, Danilo: are you both OK with this? I'll discard this patch=
 on
> > > > > the respin and prepend the patch adding the len <=3D cap invarian=
t.
> > > >
> > > > I mean, the whole reason to switch set_len() to inc_len() and have =
a separate
> > > > dec_len() was to properly cover things like [1] and Alice' patch by=
 having
> > > > dec_len() return the abandoned entries.
> > > >
> > > > If we now only switch set_len() to inc_len() and drop dec_len() the=
n what should
> > > > Andrew do?
> > >
> > > I'd be completely fine with Andrew (or Alice) taking this patch into
> > > the truncate/resize series[1] (or the series that introduces clear
> > > [2]). It can be properly reviewed there in context.
> >
> > Sorry, I'm not willing to make this Andrew's responsibility; set_len() =
worked
> > for his patches before.
> >
> > If you're uncomfortable implementing your proposal without the existenc=
e of
> > truncate(), please rebase onto Andrew's patches.
>
> This suits me just fine! I tried applying Andrew's patches locally but
> I don't have `Documentation/gpu/nova/core/todo.rst`. Do you know what
> his base commit is?

Nevermind, I can just specify the patch ID.

