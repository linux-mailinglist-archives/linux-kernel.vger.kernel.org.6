Return-Path: <linux-kernel+bounces-392892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6269B9957
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700D71F21769
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3D51D7E52;
	Fri,  1 Nov 2024 20:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nhys4nrw"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DAD1CEAD7
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 20:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730492505; cv=none; b=O+QIZ2+UxdT1DKvAW0owXgx0gzNj+c1nrhIRvkrWDNJZr09f6NpKtBpeVHb7Xr51j0yumqrd6428j/zy/Sio0bSeNpmfv1x9p55eqn2/rJUF4bKYzYED4mOd/aYno7ilug938PfnURzaTOa1vX0lQbrygyL83pgpvliLrzx7OD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730492505; c=relaxed/simple;
	bh=89rOcnEfbrh++Q72N8Ey9wdXk4mOjuMF6EhTiVkFG14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Poprfvjj2F4Sj+PL2u32rghzd84cIDDhZ53O5/yuQGf98m8lLwvWhH81wcUiL0zWANEw72m/wwQJ3eypeT4uBhxDr4nnhAo8GgZcvLQ2xTfM6Ek+Pd7io2iYRKU3MxFN4DZ5GSihoUAowtBeNNdBbC6W70JYwUWkdvokpvyS9H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nhys4nrw; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539e19d8c41so6836e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 13:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730492502; x=1731097302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89rOcnEfbrh++Q72N8Ey9wdXk4mOjuMF6EhTiVkFG14=;
        b=Nhys4nrwo/oDndicU3kISoK3Ooi2KtObnjE8UuDMWV7nHZBThPp0jb9h3TkoSvsgVb
         BGuR3lACL0hEdulEeZsRdOYks+tL7jvuSfHLndNItQUM9xjITaiWjkhYlXvJA4q6kFrU
         aQsil1KgMeojEr2cUA3Ugl5m8yld3dreuQlA2IHh29tlyHOx29ROge0fimgcuxfR1diV
         nnF+Yv0zbu5UwPx41XyFeSxFsEocJ03teji9q31FP1kTbN7TSJAPJ0UlHSUQcmDmoLZc
         Fq7qrIysSAhs0kohy1wowlfSmKp8KY5YBvQMf+3DyCcePwiSVZuPGLXmNNJYnYq5htIq
         P/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730492502; x=1731097302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89rOcnEfbrh++Q72N8Ey9wdXk4mOjuMF6EhTiVkFG14=;
        b=fzjq7ApB9Gv8yX0xASPYq7TfS3k0zjUrj7b7OXflli4wyP1txrlJyCr36/xR702nen
         F2x5dm9YE0ZgZ+1mVX6aHk68svF+FvaINzAHULGXMSsldjosysybJ0ap4rPWyc4NP9Z7
         1EXVuryVJgYyxQye613H6VWgZoDEuDq9zNTKcIUxZEQaJYOrppzTRj+sRgEgctstkk1O
         Kr7rtpM+iXmyD8Vyet+UiW7koNDKAiuZhq9tyeYMTYfOQENFYgmDvFgzTfbULoVQL1XW
         XMd6IGcQGNg/I4uokPykAgxk1M36pWnH4jTQybFWHhS+tuICItzG8PLy0EWA8d0n1pTl
         q+1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmT+xbx0KwWBT2EA5WRWULzLPZ2UYJSFUJ9ASkb972honRH9dL5O6vLvKlIDCY2u3OTQaDNxsS+z1NurM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPekbDbv65i1BRJM+5/8qk4bObMLKO1KXuZNiHW7O/fu1oFapQ
	QEA1HajlNszW8m/qX9Ps5hKr+fyE2TfbxkePVu3A76o0h/f3SSTDxfV9o9K7LWdjhxWcogb84uG
	7V/QxWvg5eVH7AI4d06Hk7mC/1s5BxE3AOijs
X-Gm-Gg: ASbGnctcaxXkq9We/OX62zT1AGkeqOD7TuCrKd9yiWbefSwHI4Vr9QvQuCef6dFA3C0
	1FbcHidLvC24R6F0ROQFgQSmk3BjhvUkjB9ShhPk8qTfYGnMVLjBngcqUOXyp
X-Google-Smtp-Source: AGHT+IEAPJzx2uQHlMIrHXN6W0szDXgPd+rVEi3ZiRYWj3r6Jmyd0vqoU74+2xiJQDlbqX7Vkd98+vpJ1dRqIr9DhKI=
X-Received: by 2002:a19:690d:0:b0:52c:dd42:cf57 with SMTP id
 2adb3069b0e04-53d6ab62d5amr102033e87.0.1730492501694; Fri, 01 Nov 2024
 13:21:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101201437.1604321-1-vipinsh@google.com> <20241101201437.1604321-2-vipinsh@google.com>
In-Reply-To: <20241101201437.1604321-2-vipinsh@google.com>
From: Vipin Sharma <vipinsh@google.com>
Date: Fri, 1 Nov 2024 13:21:04 -0700
Message-ID: <CAHVum0eZ1z4NfmQEmr2T34LFY9EEhM0rdkEEx_yxF-zijhmLYA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] KVM: x86/mmu: Remove KVM mmu shrinker
To: seanjc@google.com, pbonzini@redhat.com, dmatlack@google.com
Cc: zhi.wang.linux@gmail.com, weijiang.yang@intel.com, mizhang@google.com, 
	liangchen.linux@gmail.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 1:14=E2=80=AFPM Vipin Sharma <vipinsh@google.com> wr=
ote:
>
> Remove KVM MMU shrinker and all its related code. Remove global
> kvm_total_used_mmu_pages and page zapping flow from MMU shrinker.
> Remove zapped_obsolete_pages list from struct kvm_arch{} and use local
> list in kvm_zap_obsolete_pages() since MMU shrinker is not using it
> anymore.
>
> Current flow of KVM MMU shrinker is very disruptive to VMs. It picks the
> first VM in the vm_list, zaps the oldest page which is most likely an
> upper level SPTEs and most like to be reused. Prior to TDP MMU, this is
> even more disruptive in nested VMs case, considering L1 SPTEs will be
> the oldest even though most of the entries are for L2 SPTEs.
>
> As discussed in [1] shrinker logic has not be very useful in actually
> keeping VMs performant and reducing memory usage.
>
> There was an alternative suggested [2] to repurpose shrinker for
> shrinking vCPU caches. But considering that in all of the KVM MMU
> shrinker history it hasn't been used/needed/complained, and there has
> not been any conversation regarding KVM using lots of page tables, it
> might be better to just not have shrinker. If the need arise [2] can be
> revisited.
>
> [1] https://lore.kernel.org/lkml/Y45dldZnI6OIf+a5@google.com/
> [2] https://lore.kernel.org/kvm/20241004195540.210396-3-vipinsh@google.co=
m/
>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Suggested-by: David Matlack <dmatlack@google.com>
> Reviewed-by: David Matlack <dmatlack@google.com>

FYI, I carried forward David's Reviewed-by from the previous versions.
Extra change from the previous version is removing registration of KVM
MMU shrinker in kvm_mmu_vendor_module_init() and mmu_shrinker object
along with its callback functions.

