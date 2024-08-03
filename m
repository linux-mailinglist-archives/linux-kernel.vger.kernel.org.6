Return-Path: <linux-kernel+bounces-273546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F51946A6E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 17:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E480281DD2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 15:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EEE14F9F1;
	Sat,  3 Aug 2024 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fBhANPeb"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD8013BAE4
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722699930; cv=none; b=q4/lqZXIN6wGw2x1/KC1+prRwFRMJADofn7oLGux1jwuF4rQSwq8GU0QjtyBKeIQEr7o9IkkVlCOD/1/73su4Nvmf3yhaQ44p+AHMHEthWW6GIbvt//YWKCes5fAwLt4adOLARx47AsYUNni7rO+++XrmMNVHmaXSjUTHXIt5UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722699930; c=relaxed/simple;
	bh=gQUjXX29Q2SaA8GctLtKHHrJYgPF0n9QU8ERvxs0BvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DwtpaHp2ooKbK+hG8FtJ+dTdtjg5B/Dg/9sOOEwM5n5Vm0ux53hhvrO0E5pP4snUuOAlZxpT9alPmOTNW6o0Qwi/eiOPq9XV5fHCesqX1UYoxqBRbqUAnlgfYlOWjsRyQAEoPFnfp3knY/PqXQwyyJqvp+fCkTcsxLv4whSpLt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fBhANPeb; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ef2c56d9dcso112074201fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2024 08:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722699926; x=1723304726; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rFfluvB3E9CQz+J/qmF/TOCUd+imVKwZ/BTDUIvYdng=;
        b=fBhANPebEctaAyZOqo0MbC9G021vS3rbL3IbU+7ZmuNwUVy2tS+3pxRuGTU6U8kco6
         klUWoBmKZSzycRIVMi96d1CbqXrnQOZjgah4gsseRSmncOXu79Lj3HzoB8woobSGcIS1
         EC7c9sTDewDlvPV+sJYzYZLILF7oliiCYkZMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722699926; x=1723304726;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rFfluvB3E9CQz+J/qmF/TOCUd+imVKwZ/BTDUIvYdng=;
        b=iP+3TrSPnq0Rx4aYKpBBf7W0hKS5kA7p9p2wtxgWwjKHeIXqVdvUQaBEs+mJoCP7uW
         NCaEQip6pAvCmh5Gu9PwmK0b2N/ANRMSN8mIkDas/bO1Kyr0OkA/6/pYKa4bxdOWuYmM
         XSPcauKjrmjZV55oe6r9QVI8rXkSSjVlk8Yra3EKpXG3vF9gZzaaQ4nyRj1nC6rQx8Mv
         cf8rFn9qsKxeaCMZWljm/znsC97xG8gM7ZXXqhEQLpeaCKwkz1wxrstKbZwij5lBPram
         +MB2POVWKHnD3veQYxhHUl5ei7Nw2P4wcCFR90yB2cJRWDfvQLTOdJVhoQdgTyLziigX
         nlhg==
X-Gm-Message-State: AOJu0YzwaYLvtcEIcqyo/rVoDo8wrvSWihkt33BIEyloZ083tTIZV7LY
	2uwAYohyy+X8pJgzo2nbfYnGhYNqd9iel1HN3LrD7t2M79Xxu+I6FoPkH/dVmbZJNVjHl3+O36o
	nZa9+Mg==
X-Google-Smtp-Source: AGHT+IGMIALErCaEqN7TiqJANTGt6qMD+Hp+zGKm61tRTqxOBGvPwdpAp2foQsciFUe4EzIkmLwY6w==
X-Received: by 2002:a2e:9f06:0:b0:2f0:1a36:1d79 with SMTP id 38308e7fff4ca-2f15ab24cfamr49444721fa.45.1722699925845;
        Sat, 03 Aug 2024 08:45:25 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e17edafsm4703191fa.3.2024.08.03.08.45.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Aug 2024 08:45:25 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ef2c56d9dcso112074041fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2024 08:45:25 -0700 (PDT)
X-Received: by 2002:ac2:4e07:0:b0:530:ac41:4bf with SMTP id
 2adb3069b0e04-530bb3b42ccmr4020789e87.61.1722699924969; Sat, 03 Aug 2024
 08:45:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802114518.GA20924@redhat.com> <CAHk-=wguPQZKfWdNjF8OedfttMNkrW57Kb5Wjv0NmTzoEbUG7A@mail.gmail.com>
 <20240802221014.GA20135@redhat.com> <CAHk-=wiXK4cc8ikqN15vfi2+wsYJYh08qH8qzCpy+08Gh9whLw@mail.gmail.com>
 <20240803120136.GA2986@redhat.com>
In-Reply-To: <20240803120136.GA2986@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 3 Aug 2024 08:45:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi1cQZugtWN5x1wZwkUnj6BVPhyynz5P9HOW8URXLOEDQ@mail.gmail.com>
Message-ID: <CAHk-=wi1cQZugtWN5x1wZwkUnj6BVPhyynz5P9HOW8URXLOEDQ@mail.gmail.com>
Subject: Re: build failure caused by RUNTIME_CONST()
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 3 Aug 2024 at 05:01, Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 08/02, Linus Torvalds wrote:
> >
> > Yeah, we document that we support building with ld-2.25.
>
> Where? I tried to grep Documentation/ but didn't find anything...

It's not hugely obvious, but you can find the line

    binutils               2.25             ld -v

in Documentation/process/changes.rst under the "Current Minimal
Requirements" header.

                Linus

