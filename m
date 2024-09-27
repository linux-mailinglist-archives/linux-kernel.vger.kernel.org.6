Return-Path: <linux-kernel+bounces-341371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6067F987F23
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CF662853F3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244DE17C9F6;
	Fri, 27 Sep 2024 07:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rypwgteq"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FFE15DBA3
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727420870; cv=none; b=qRv4kLspRObrsyUiPLi0LBN7gnXWnRLPWFEdSr2VLYTZ0CwfwIFE+VEuijzbfWuqdSdMzdbfp/SvS8LJAYTs8PwzRfyBZPagXWkA9tV2XcewYuc0IewcVhq9oM0mFbk8yOH/EPxL8a+EDWSBTBeWzeG3TS0s6F/mYvc+v9jwgQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727420870; c=relaxed/simple;
	bh=W70e6iiDaCpib+TE/Ouz8u1gAKPcXJbKo4xZC7JpTPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFeXmGgTKMH+AFHiyyZ84w7V99oMtG9v9pnB63Dy0E/oJ5/U40qEuPMg6hsO1ICMmSnyqDEcssXXjtgWN4Ik74uLNqWQCuTdL+vzztY9303OuAevFgGyM8zBCqLxx+plYq9osxUNhA1bwpFe9C2bQ5YgFARrCh3z1RcdsfxzXrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rypwgteq; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37cc60c9838so1064253f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 00:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727420867; x=1728025667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TclUmNl+mEJN7UB0vi1aCVc79ZezAtt3jamN25qcvw=;
        b=rypwgteqVcNziVuorgqa+IpCUe1GahCHmiPg4Pk1s2CXSjdzGWDQAa3gdWwOOthO8h
         SkRJqNsG2YOnqPXLiaotC8re3wvUUoRE0BDneaM7b4RYtTXVXOjGxrLU3V+kuxpYk4oo
         cMzMnYWf0OLdlSdzRzWEwAq5YvwxdywusTmPoo6Wvxc9CV1Rdv7pE2tQ0eq5UAHRCKDc
         jYmwyiTBZXX9JjEv/8PzXE/5Hq0FKjBDWifFoxPQK8zHJLwe07Lf/utfklyXYKmuCaTK
         azDY/ALj0lDOHAGbQXBIIEPTRrGdmtJM87k3CtKwF4uA3EFam0zWT/+7nOcCy6o4gTKO
         Ax4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727420867; x=1728025667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TclUmNl+mEJN7UB0vi1aCVc79ZezAtt3jamN25qcvw=;
        b=o/JQ1Xrdi5yqt2dZ6uFBFkn28+FgXNvulBu8cUveCsceZKZ4JmJz3+c8Y+xUvg/PA/
         RpGDVEN7hkUCzjE8wek2YAlQE2FlfMJcARuW8oHAB9Q/2Hp/dY0uluqdSc99R2aheSuD
         0Ekloz7+5ekAEYGiy4kkkZm/p3gpYIv4sKzdk8g/txVyU71oo1yRrY5cHDXcDT7ayiq+
         A4PxLOzr+QIhkotEWsPTysjiTR9u3hdupeAb5th7YW7GcM+OI1HMxSx0aEPaKzqclY8g
         jJe9ANBcd2+eHfDOBPi10hpjWT72g4zviQnMGnZnD6Z8UPFt++XgPUukN2KFxaOtRo0+
         DlQA==
X-Forwarded-Encrypted: i=1; AJvYcCX1x2bOuuAXRg/t2bRDjXReMuEuns31Wdvs+uNWe8O3SvUVKcs2PuE7AOUZKhAtkHDfTLJU+5onnyAbUe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTMCWmRkNMOFpGdu+Qng2l5s/a75m9UJC5DcKWudiHKhirqx/r
	/gY+IbM/HeGIN2oPD0TnqjyrVp66b2Hl8WI/gnv14FCls27lzJWgblxtw/b6sGEf8+CdHjIx9bv
	uP7jNHXPvi1QzeJha3VT21sVCK7GgEUaIWGWAmI6cdv8AKrGNfw==
X-Google-Smtp-Source: AGHT+IEYwN3TOsl+c28IvkDqXwinzUTagPXnNK0vbOUrvdfHpmordLeUXZZYBG6rDRpPb+Qx5kO5KjOTCWGsy4qePog=
X-Received: by 2002:adf:ee06:0:b0:374:b6e4:16a7 with SMTP id
 ffacd0b85a97d-37ccdb12819mr3587930f8f.8.1727420867114; Fri, 27 Sep 2024
 00:07:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926233632.821189-1-cmllamas@google.com> <20240926233632.821189-5-cmllamas@google.com>
In-Reply-To: <20240926233632.821189-5-cmllamas@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 27 Sep 2024 09:07:34 +0200
Message-ID: <CAH5fLghsesAW=wXz86OXUrJtO4So_jYSmOzocJ9RxrrrT=+MaQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] binder: fix BINDER_WORK_FROZEN_BINDER debug logs
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Yu-Ting Tseng <yutingtseng@google.com>, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, stable@vger.kernel.org, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 1:36=E2=80=AFAM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> The BINDER_WORK_FROZEN_BINDER type is not handled in the binder_logs
> entries and it shows up as "unknown work" when logged:
>
>   proc 649
>   context binder-test
>     thread 649: l 00 need_return 0 tr 0
>     ref 13: desc 1 node 8 s 1 w 0 d 0000000053c4c0c3
>     unknown work: type 10
>
> This patch add the freeze work type and is now logged as such:
>
>   proc 637
>   context binder-test
>     thread 637: l 00 need_return 0 tr 0
>     ref 8: desc 1 node 3 s 1 w 0 d 00000000dc39e9c6
>     has frozen binder
>
> Fixes: d579b04a52a1 ("binder: frozen notification")
> Cc: stable@vger.kernel.org
> Acked-by: Todd Kjos <tkjos@google.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

