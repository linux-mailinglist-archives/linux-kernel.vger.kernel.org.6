Return-Path: <linux-kernel+bounces-211335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CA2905030
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE5F2830B8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125C816E87C;
	Wed, 12 Jun 2024 10:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FdY2uucs"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DA733FE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 10:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718187104; cv=none; b=B38u5Ron5Zcb5fV5TgeXciZXPkWtjpUHvNtyLjkONpEiR8Z+zJp0KCNOKXv6eZ92T8kmhtUSW1tz18oF/hUStB8CZthxyDRW5Rs5Zp2Wl3nKfnb2IQstVylkEgc8lHdYMkMzirDVm7bCExkXTrJ3WBYzEzmZIWCGbmO+Izu5bpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718187104; c=relaxed/simple;
	bh=KFf2FT18RPV8C8MRIqXhIhGb0bt0t/RSv998zsVKsOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tuLWbaGf98JL/pT+L5BH35GB8bfjKGTXSzDMm5cCVK7GIYI2NNUJI63aDhkcW6l9awvcWGZXTwnhR8HGMmlS1ubHnFxuLxSGuVGp3oACwYalm0vDLJYXcFPQXC7xtxHXxDl5GfEhTvtUkAK7w0r/TWl5to9SwhpWOnE+LQRkr6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FdY2uucs; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ee5f3123d8so109505ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718187102; x=1718791902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JB137Y60BhwWEDBjTqvHulcYwQ9jTNh9hWVkbeGFpbY=;
        b=FdY2uucssI/Pc5Gx5pwQ8/ZrpiX0jO/VHBFMJ5EZnOXBWMYEN1W8F6fMe/yOPJqADR
         pWYFhotDZJj2z5ag4jZFl1IWZtlTI8L20gmaB5AiPqTVlF/hb+/D4fLeQdu4Z/LhelVu
         KzshCLBt5Hv3tds9nRCzi/QIrXURpJ8OPP7+JZm01TkBekIoFrRXRYdWHa9NclPcLwNR
         4Pm/MWg7Sxycj9AnFv7IPYyaZONdVkfFhcxg38tv50CbDm3VkweoBGHSiP2RGxQgCmaQ
         8C45mkIqnVnjbUlquUtWIf+ttoXONNGYJ+/1RWpslj76hOLEHaHuyr/bqBdCN3NTVYAK
         MgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718187102; x=1718791902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JB137Y60BhwWEDBjTqvHulcYwQ9jTNh9hWVkbeGFpbY=;
        b=stR4TUSL9lOtpXqnM63Dv0gxR9Go4C42bDQTfOko/2eiDKyYs5kvbf36XpSqxUaqhc
         vr8HEeyTHF7/kcZP/5stwEki/L0P6PYspQ+LMXJ5n6uDDhXAsPNWvzp28Phfnbcwtamu
         fH0NEGDAcqRvoZw+E7WkWJw/4+JlhzlO7WG1iIRlMSEFaKG9FK/7gih0kwmZaAGgUrVu
         GDkN1KUFklLzvlA2IwnAGZjcKQtDgDg/CGccd9DhDG/t6uS7bEIsMn0wjmwul7E2HLbc
         Fabm2eT9jUEA8Z2+6lE7/bDyFazSS4ulAULZhpvz1kLIsPQsnFIsC1i6ZKR58l/kFN6K
         BH3A==
X-Forwarded-Encrypted: i=1; AJvYcCWgdBlq0wSXm3488gcFRaodRCTt1fT9pz+2HXIY5ervxD/sBWlphEqhPzEZQ2AFO0wzqu63d/ttyTbO0r9Lp5uBhX/tyzy9idoIjYN9
X-Gm-Message-State: AOJu0YyMrWez9Nh8EAGlQWknkrfFlsIXBMDvyHCMSmfgcYZRmxBUIlsK
	lAexYkxF6bqlZwBqdX7e4Qm7j9NyPnWQNiqAiNtL7femLIEn+vkJxNRFTxjRPROUWoRL+ueR1N7
	7aJBHdu240JPQXG5Yzb2VquIGR3VxtaEPr1BU
X-Google-Smtp-Source: AGHT+IFt0QaTJrjbAM5Lih+9Ea8MU4NOCHo2x5tga3NpRGP3FmXtBmDy4kPOtkuS4PyhJ27G4ZzU8X9NtVD5QjNUA9Y=
X-Received: by 2002:a17:902:c40a:b0:1e0:c571:d652 with SMTP id
 d9443c01a7336-1f83b371decmr2105695ad.1.1718187101848; Wed, 12 Jun 2024
 03:11:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611133229.527822-1-nogikh@google.com> <20240611115133.fa80466e924ad34ed4ad73cb@linux-foundation.org>
In-Reply-To: <20240611115133.fa80466e924ad34ed4ad73cb@linux-foundation.org>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Wed, 12 Jun 2024 12:11:30 +0200
Message-ID: <CANp29Y6TqZ2T5xKzwW8RJ4o7+4w+mWs2awNebXo1dyaw154Opg@mail.gmail.com>
Subject: Re: [PATCH] kcov: don't lose track of remote references during softirqs
To: Andrew Morton <akpm@linux-foundation.org>
Cc: dvyukov@google.com, andreyknvl@gmail.com, arnd@arndb.de, elver@google.com, 
	glider@google.com, syzkaller@googlegroups.com, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 8:51=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 11 Jun 2024 15:32:29 +0200 Aleksandr Nogikh <nogikh@google.com> w=
rote:
>
> > In kcov_remote_start()/kcov_remote_stop(), we swap the previous KCOV
> > metadata of the current task into a per-CPU variable. However, the
> > kcov_mode_enabled(mode) check is not sufficient in the case of remote
> > KCOV coverage: current->kcov_mode always remains KCOV_MODE_DISABLED
> > for remote KCOV objects.
> >
> > If the original task that has invoked the KCOV_REMOTE_ENABLE ioctl
> > happens to get interrupted and kcov_remote_start() is called, it
> > ultimately leads to kcov_remote_stop() NOT restoring the original
> > KCOV reference. So when the task exits, all registered remote KCOV
> > handles remain active forever.
> >
> > Fix it by introducing a special kcov_mode that is assigned to the
> > task that owns a KCOV remote object. It makes kcov_mode_enabled()
> > return true and yet does not trigger coverage collection in
> > __sanitizer_cov_trace_pc() and write_comp_data().
>
> What are the userspace visible effects of this bug?  I *think* it's
> just an efficiency thing, but how significant?  In other words, should
> we backport this fix?
>

The most uncomfortable effect (at least for syzkaller) is that the bug
prevents the reuse of the same /sys/kernel/debug/kcov descriptor. If
we obtain it in the parent process and then e.g. drop some
capabilities and continuously fork to execute individual programs, at
some point current->kcov of the forked process is lost,
kcov_task_exit() takes no action, and all KCOV_REMOTE_ENABLE ioctls
calls from subsequent forks fail.

And, yes, the efficiency is also affected if we keep on losing remote
kcov objects.
a) kcov_remote_map keeps on growing forever.
b) (If I'm not mistaken), we're also not freeing the memory referenced
by kcov->area.

I think it would be nice to backport the fix to the stable trees.

--=20
Aleksandr

