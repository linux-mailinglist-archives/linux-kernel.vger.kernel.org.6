Return-Path: <linux-kernel+bounces-522836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974CCA3CEF2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 555AA16625D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79331C4A24;
	Thu, 20 Feb 2025 01:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkjzE/qa"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564471C5D79
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740016389; cv=none; b=qbg1ZjkAfFQqf5QxdgreFNzHJNyk6EfxtW8OjNUhL7KGAad9fnukqvejX4xr3x0NMKBNRtkcRLCAM1WHND56C7QmiSrNzJDHju3zQjUmQg/lb0yp/DBNsgtAbYb0kDMWaslhPPiqB+Gg3dXPr/jRvs470rRhm8fqwGtZWd0Qi2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740016389; c=relaxed/simple;
	bh=VsWYuOocFG8H9OvoYBsSenQTRN91GcfiNLb0Cptd6h0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2SP5oHcm2rLOS7ng0GEZK352aJqS81uEz8I9a+Qmt60YYoQY/mhUw0pT90reuzUOBNf8Mcp8PzcGV9zTdQ4shLsz+P6B37pFvkDfhEPi2Soq73UZgH2jUW49/vPmhuVMfbO6VQ6niKrBS7hhNaxOG5yRJUV6x/9P9DETZtBJxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkjzE/qa; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5dedae49c63so766546a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740016385; x=1740621185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsWYuOocFG8H9OvoYBsSenQTRN91GcfiNLb0Cptd6h0=;
        b=TkjzE/qaArzkBjtk6nf58sqaeFaxMjsUrZonh9t/3nZFzPQQVNJ6/DY6bYsLjejNFd
         cmenkq19R63mjYWPEmf+dVfTyCffcxLZIaapCIsk8jAMNLas6f0RnDQ/K5WSWvxSvsaz
         pgpDUxH6aP0qvypDkE8zKLHEjlGpMp1QUAJLisUaDn+gt4ZFPGsJxfp3W8IOVXjT0Ero
         zNwmf74u0x808sFk238W5+hHwIABtduhW8KU04ClLLbAsDEasrsRcZT6K6ZlmJ0b9UPX
         s48guJ0ctN+8itJ7jIUDKNHUgl4a746Rnl6eZ7nBdECBCpNW5dSeoJ7v4q835qkupuQE
         D76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740016385; x=1740621185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsWYuOocFG8H9OvoYBsSenQTRN91GcfiNLb0Cptd6h0=;
        b=YXY17yblyZYn5TKDbCEUlG8QLrkgJyp3HNd/3lb1IG0aPc7soglEswUuectBZiIJce
         DuLgF0yVnokpq0v15KNZ+NEOP+qreafb9uAuiyhUsBcRWLgOJlO6oNwU1ns3KzZ32hPr
         FJLIb9uqTBQ7Bi90kUpyreTCW4JwT8NQQPye5PykArBb1ovqaspogQQU6xpE9xz+rdle
         FFxAfy/1hY5ioZnGwl1t7E8vycznJO/R6l/S/pvAQV7baNHuniLVq6puSUbVXGZMgMyV
         Nd/6WR7ZmhuwbawACsbWtVp1RI1w891J/3hM7wH5GMcEE4KJ4UcR/5UdofAL+SLxamtD
         7cuw==
X-Forwarded-Encrypted: i=1; AJvYcCUdc7daSHHwar+o3oTLpCKMnC7ITEVgsnb3KRMWImWfpJMfbkoQm6qmVuUSbes6EGCPhZbz+8aKrQlPRyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkYcQu7YbsnvHz/wKiul+RBLeX3lNZVGADmOHB6E/6luF56Ef/
	9YR/mfDCz2LMSGgOwAV7rYOcyVcwnwLtyqSSa88WLLYSrmSdHf4sfM91bEu3gU71B7eaXs9Rcxd
	qVOF9TWU2eNjOYamctkcKrxPVaKI=
X-Gm-Gg: ASbGncsx2kkAKB60jVGvqMuQDSlR/UOMwINc2WF+pzPpLxHEdaWm1DwOaeH/DdNCLAr
	akrYaJxLtQFjUxoIJRc5Hylc5vOOSC78Y5vgDaa9UkeBbZtANn9335HhmEdgmbDJVjQVGsMpUcN
	g=
X-Google-Smtp-Source: AGHT+IFhzt2J0AqeR+vIAI7bZz8MxZFOD0m8T0wn4hNryhSisAcfEXygPVO/cJgQ5GIN8SMpY2LtadfxFH0d+fL5HyA=
X-Received: by 2002:a05:6402:1ec5:b0:5df:35ff:dc47 with SMTP id
 4fb4d7f45d1cf-5e0361c0cd7mr19614345a12.26.1740016385488; Wed, 19 Feb 2025
 17:53:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <173997003868.2137198.9462617208992136056.stgit@mhiramat.tok.corp.google.com>
 <173997004932.2137198.7959507113210521328.stgit@mhiramat.tok.corp.google.com>
 <20250219112308.5d905680@gandalf.local.home> <0fa9dd8e-2d83-487e-bfb1-1f5d20cd9fe6@redhat.com>
 <20250219152435.35077ac3@gandalf.local.home> <db4ee5e9-56bb-408c-85e7-f93e2c3226dc@redhat.com>
 <20250220075639.298616eb494248d390417977@kernel.org> <20250219185531.1140c3c4@gandalf.local.home>
In-Reply-To: <20250219185531.1140c3c4@gandalf.local.home>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 20 Feb 2025 09:52:29 +0800
X-Gm-Features: AWEUYZkkvsksjNhmabBQW4GXcXWCnpHKpxhhJ7xinS7Xw-NdASDGtQ3beXYnghQ
Message-ID: <CAK1f24kngiS4=mz09xAT31E7waHU8dPWrvWmv0SrJhnH9cjsxg@mail.gmail.com>
Subject: Re: [PATCH 1/2] hung_task: Show the blocker task if the task is hung
 on mutex
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Waiman Long <llong@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Joel Granados <joel.granados@kernel.org>, Anna Schumaker <anna.schumaker@oracle.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Yongliang Gao <leonylgao@tencent.com>, 
	Tomasz Figa <tfiga@chromium.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-kernel@vger.kernel.org, 
	Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 7:55=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 20 Feb 2025 07:56:39 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > > >> this field, we don't need to take lock, though taking the wait_loc=
k may
> > > >> still be needed to examine other information inside the mutex.
> >
> > Do we need to take it just for accessing owner, which is in an atomic?
>
> Updating the task_struct would be in the same location as the blocked_on =
is
> anyway. I would make it into a wrapper function that is a nop when disabl=
ed.
>
> >
> > > > But perhaps if we add a new config option for this feature, we coul=
d just
> > > > add the lock that a task is blocked on before it goes to sleep and
> > > > reference that instead. That would be easier than trying to play ga=
mes
> > > > getting the lock owner from the blocked_on field.
> > >
> > > Yes, it could be a new config option. This will be a useful feature t=
hat
> > > I believe most distros will turn it on. Or we may just include that i=
n
> > > the core code without any option.
> >
> > Do we need another option? or just extend DETECT_HUNG_TASK?
>
> DETECT_HUNG_TASK is just that, for detecting hung tasks. This adds more
> information to that, which increases the size of the task_struct not to
> mention adds code in the mutex/rwsem handlers.
>
> I would definitely make it a separate config that may depend on
> DETECT_HUNG_TASK.

Agreed. Making it a separate config option that depends on DETECT_HUNG_TASK
sounds like a reasonable approach. It could help us to identify the
root cause, but it
also adds a bit of extra overhead.

Thanks,
Lance

>
> -- Steve

