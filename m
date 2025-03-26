Return-Path: <linux-kernel+bounces-577544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A8FA71E87
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC436189804C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4777924E4A8;
	Wed, 26 Mar 2025 18:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JdGv+Aqj"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D529F24290B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743014214; cv=none; b=CnwFuKm+Q5Bit33BLMtR0x0UCrB2j2m13+t9NOrplG/aG/7woKwMCDwmhCCtchYAyeETpjJZvwcNPgny9DhzJDYF3SJJ+TQOo3xpbLSVdZ0jS13R3AEgqntgkF0LTMMnPaE/sRtQYHlglovYtlipzEBXmB6bUArPE8FHenEM/WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743014214; c=relaxed/simple;
	bh=gvQ72XqhVYqahbcBoHdMWqC6dXEXWPdoOpspT2sL2Yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5iUkftYUQq9oqHjy2hpJxAUKVpLwpnRPrn90Df21vrkLvCLCppl3LBCchF7qvgC2jsmQ7McBG4YQfiBHc0Z2sNTjeQQEVk42jvZRluXcXEHpw4bIv6ZH41u/UmqYU1nNvSHzOF6QmXo+I6rlEdsCp7Tr8FfTQiieLhKIXnnSos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JdGv+Aqj; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e53ef7462b6so211413276.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 11:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1743014211; x=1743619011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qNPVx9J3I2u7r+pWJFYW27zcpF92LIDKBWH5rLLtBo=;
        b=JdGv+AqjAv8LLeVQj5TlsDERBr7Yo1+Kv17NLE2JFzbsyXyekVeSOo8bZUl7wWvGHN
         Yn/RZdTIpcraNGpE1bJUtn9snPZbyrP2cgQuVH/YWups7DoPi3Aq6baopaFo8/WjTxQO
         7RuBMM8XFMasBv1SV0TSa1Kcc5wHR1PVLu+fU1cJZgs3CoX4NHbLKImEvewp58w/VLrh
         B7eTrx2LmvS3McLer22BXm/mlgnPJPv4TIKBHphGg8tTx76o1VIkCPxCiP5g+kz3zs/9
         5wBJY7e546a39FWgAf5bCJ/CFYZLwhyTC/ZNksAS+N3pzo+cVSvkOeD+o89Xvt5h2cZa
         8QJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743014211; x=1743619011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qNPVx9J3I2u7r+pWJFYW27zcpF92LIDKBWH5rLLtBo=;
        b=dCChecU186RAmRzRiBvqkvV8EllHXuB+/okb/Th08wC576yYEhbXUue/jDXX5xPZn5
         Y/V02ZSutBiZDSxKUHSFQ5ZdPAZ577YxgA3M5KKCivelah+kC+w2sEeE6qohS8e+wRZR
         D4yAHNT0vFZ6nTPao5sTW3FUJhs9ymifALl1kM31NtK5J+o4Fz4Qjf0PLog0AeI5icxU
         V0sTMQr9hx/lkkYZFzCNWUo9Mo13w+4fmakbtasyAgPCkzaVlX5+WfwzfhJEa0Fckdl9
         d+tT5AC0k3qnifUOwvLk8wa58E5KkuWBa+TDBuxBlM1rbIyxZfTcXIY8YvhsT4OD4392
         UcJA==
X-Forwarded-Encrypted: i=1; AJvYcCV1NnYpoyyh2MV+KP5NOrurcoMgqwxeH8vLDL3jdktb9eOH2dOfBfjGjS6oec30pGVqaTuKK0Y3lNN+yPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMirlcEyyoTGrL1sxU+1jGcqIF/iOABrc5ih17pJwOibjSHbJ5
	x3OncJ3WqYeTOp2ycEePOjupzjC/RfOHphVrTDr248xZVic3jWGcLYyqYY6tOx3zXjI7XAigrUM
	EKbbzLka/BJZHztJwcYET8jk5cWg1/KhUQ1OU
X-Gm-Gg: ASbGncuOG09MP47+Q5YNs/yywA/FFCR0glmghRslvf2D9x3wGVCXgfzNLVOmrUco+ps
	cKLa1xOVUPrqibPxpcOW/ymTv2jlgCilK2iKetyJJ84kGdS/jbEYQAUFu71TIHM1xNAvgBWHLuu
	e1/5SvMKsUPowz3hTqtSN3HTVcKA==
X-Google-Smtp-Source: AGHT+IHFVthYODlKcOsuPG80+S5CYT0fq2uoWH/clwMi/MGhGD3v4JKAA/Stluyl4CMIT9rmrhBMmk2BmOBi+Yn61EM=
X-Received: by 2002:a05:6902:478e:b0:e63:ef84:1098 with SMTP id
 3f1490d57ef6-e69437fd0bemr981758276.34.1743014211543; Wed, 26 Mar 2025
 11:36:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0ade43454dee9c00689f03e8d9bd32a@paul-moore.com> <CAHk-=wjbahY4JjLCXNT4o3xVq2cejqBG69z+MNfHsN9FQBnbOw@mail.gmail.com>
In-Reply-To: <CAHk-=wjbahY4JjLCXNT4o3xVq2cejqBG69z+MNfHsN9FQBnbOw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 26 Mar 2025 14:36:40 -0400
X-Gm-Features: AQ5f1JrbC2zBMF6igGTE7A-fwhhXGmslJ1ZVSxkucZ1YEFk3sLw9u2wDn0GzvK4
Message-ID: <CAHC9VhRExVqdhHqs0njs7NY6bFg0BfcE-gMpS30HW9O7MSDfWQ@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 7:02=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sun, 23 Mar 2025 at 12:39, Paul Moore <paul@paul-moore.com> wrote:
> >
> > - Add additional SELinux access controls for kernel file reads/loads
> >
> >   The SELinux kernel file read/load access controls were never updated
> >   beyond the initial kernel module support, this pull request adds
> >   support for firmware, kexec, policies, and x.509 certificates.
>
> Honestly, is there a *reason* for this, or is this just some misguided
> "for completeness" issue?
>
> Because dammit, adding more complexity to the security rules isn't a
> feature, and isn't security. It's just theater ...

From my perspective this is largely a continuation of our discussion
last April, and considering that you ignored my response then, I'm not
sure typing out a meaningful reply here is a good use of my time.
Anyone who is interested can find that thread on lore, unfortunately
much of my response still applies.

--=20
paul-moore.com

