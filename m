Return-Path: <linux-kernel+bounces-551519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EECA56D91
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CFAE3AA8F8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838191E1E0B;
	Fri,  7 Mar 2025 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxfARFPD"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4AB23BD01;
	Fri,  7 Mar 2025 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741364705; cv=none; b=FjvadR26XwVhhjIXcqx7MoU2MUb7HZTjkW6j1QPxj6GfbzZQxiATpQzRhZ9POmoBgGPh5K2AyS8Dvz0SZIFG2d9PEpYJM/+VmXzbuee57t1XfLHs5I9vivNTLL4SBZlGbyoE5p15WK6p/WP3A2YEpc83BTgxQBgLOkmvLImibxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741364705; c=relaxed/simple;
	bh=UiLD7yBHAJKBTn6IaZwAwe32NIzhtSP4kxkhZS1qJF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nx91dfkCqzTg4Ir+OlwYVIlvF/X69GSLwDfhMuAymGzc2c+AlPCA6RBhXK6myakeqTrhidVMNv6SZBldgFcOZfR2AaZw8viXAy1IBnScXIaoo6VAGA/HoShLjrTsS9n9p0Kw+f3Q5sBzQqjCTJiEnOT8KAXzWYKkDKt3+WJC8Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxfARFPD; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21f8f3bd828so4064925ad.2;
        Fri, 07 Mar 2025 08:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741364703; x=1741969503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UiLD7yBHAJKBTn6IaZwAwe32NIzhtSP4kxkhZS1qJF0=;
        b=mxfARFPDVc1fX65g1FLA6bZWcSlriVOZ4TM1otfcja8W473+z/hdFtL7aHtPfUOU0a
         uemj5z9+PE+Otq9bgBj5zfHnBiTd4d/stUjhLNaoTGOT2/dqezQGjJSjiBYhqDC/LPUo
         /TDwPNNOfM1VcoFGknOnhAbsNMlWD198Zy0LN1+rbhqV8daQTRk8E4kCy51Lj6YKmbw1
         eokY8lcs2t9Z5oQrxTIHA8397AwEJlLmrju+yOP2GgkmRR1W1haiYIb3fOy9Z/Ds1VRJ
         FhjE5ztfXUGABpJUvgU5CHyhHcqIgA2s2NmS8h9kR+oGmZDp+PncsAsodPqsBVhSX/VF
         tYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741364703; x=1741969503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UiLD7yBHAJKBTn6IaZwAwe32NIzhtSP4kxkhZS1qJF0=;
        b=VAgpmBW+tSzOoANQR4/RkB59BIA3vFYPBuHpddSGe4LD6o15FDOLIx1uV0akeYv1KD
         PD8DNgkIHMuIqmFyLwQVm3ddedNEBvoGznb6sFYzymNrvA0/7hJ1TWzYsBYSGjzOIcPm
         p7XiPbIYTPCkeJBVjcmh2npucK/quTIzy01IZ+7E1Yp9wdE5imVWfQMsbtSiJlbu3ylQ
         KkIZrbAAMFLWiOto1ls4JcKRPZYTgR0IDKnnt0tewSqZJI0c1dV+joBvcVl+5FcLd5H/
         JGhCdWekRigo2z4StwDg+v01Ak0k8eF/vqIwA2qIQscPRa1XQ3vn8H/apWEF6aqnJYWE
         Q1vA==
X-Forwarded-Encrypted: i=1; AJvYcCWTcugs8nb38bDUHI8I8J8BRWosKolqqpng51oNgY4BrU/1+IHoxcdKTJ0dkELx24yGUhmlHxx8K2qi64s=@vger.kernel.org, AJvYcCXxZlFt8CEbwAefOrCXJKVHo4eOye1ujCeW3q5967MwlDwqu52CRiKMRf2+cV85Gv+yfHYavE9ZVOu73oFUfM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDoueJ9l0G2dSwPdZqiefPLHVOFDhuJLA4Ro4VYK+6vslL8Kgo
	82X+ykfANtkBwFHPWznJlPcSUstxGgasxER5bRzUHrWpFcUjFffzQEqnU8toNKnYSY/RSFdbC5Q
	V85NO8QdxIHb2kp/jXP5y4xKFzJI=
X-Gm-Gg: ASbGncuX3Al/6T5vPcUv0+4a5i+OO/lJ3yqhKGrxkPGsj4Nhu7Fwr01G4Ej/VFzc1nC
	owCNGZE/jNyJSv5bXOcOXku7yc+kN4NYjVMVTipZ8ja92LJNesfhmWytQqmVfuynd4HW6g8hrRy
	lU93PLE3p163YfCSvT+1L3q+RGuw==
X-Google-Smtp-Source: AGHT+IGzuyx2khrqmQFCRDY1W2460IMmx7kriW6qonWU83eNHoq7OKTDGi/ueoa/0kqUy6eJVU4vHkzvzMaSaBkRh5w=
X-Received: by 2002:a17:903:22cb:b0:224:706:6d08 with SMTP id
 d9443c01a7336-2243a1a8c3dmr1521965ad.8.1741364702839; Fri, 07 Mar 2025
 08:25:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z8rz9nrY7Yj1Z2hP@google.com> <20250307154341.639752-1-trintaeoitogc@gmail.com>
In-Reply-To: <20250307154341.639752-1-trintaeoitogc@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 7 Mar 2025 17:24:49 +0100
X-Gm-Features: AQ5f1Jo8QelYZ4KKLF0a_EY0cI7Lh7m8PaLxO4oDgGsEPFCw_oy1bK-NcDg7AgI
Message-ID: <CANiq72mWBrHpv9XYcBbVsJkhH9SzM9N4fcL2SqoNQ9X-4GiZbw@mail.gmail.com>
Subject: Re: [PATCH V7 1/2] rust: module: change author to an array
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: aliceryhl@google.com, a.hindborg@kernel.org, alex.gaynor@gmail.com, 
	apw@canonical.com, arnd@arndb.de, aswinunni01@gmail.com, axboe@kernel.dk, 
	benno.lossin@proton.me, bhelgaas@google.com, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, charmitro@posteo.net, dakr@kernel.org, 
	dwaipayanray1@gmail.com, ethan.twardy@gmail.com, fujita.tomonori@gmail.com, 
	gary@garyguo.net, gregkh@linuxfoundation.org, joe@perches.com, 
	linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com, ojeda@kernel.org, 
	pbonzini@redhat.com, rust-for-linux@vger.kernel.org, tmgross@umich.edu, 
	walmeida@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 4:43=E2=80=AFPM Guilherme Giacomo Simoes
<trintaeoitogc@gmail.com> wrote:
>
> I'm sorry, I will pick up your tag and send a v8
>
> Too, I will pick up Charalampos and Andreas tags

In general, if it is the last version, you don't need to pick up tags
-- maintainers will do that for you.

i.e. in this case, it would have been fine telling Alice that you
didn't change anything (if that is the case -- is it?)

Thanks!

Cheers,
Miguel

