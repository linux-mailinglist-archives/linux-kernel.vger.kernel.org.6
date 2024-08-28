Return-Path: <linux-kernel+bounces-305797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F43963498
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 00:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6325E1F2469B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146C31AD3F2;
	Wed, 28 Aug 2024 22:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4PMJAqN"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE7314A4D4;
	Wed, 28 Aug 2024 22:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724883630; cv=none; b=eL2E0LV29SYrvPjvYetn2moVVSIy26TKFWFKk4Q5dvrPM2Ti8xRd9M0amISdUqs2j7psQQfFC2Z+K4dc9mAjhLGFIzeFuHU7g44xNUcoYdzja08j2/hJ3MaRkEMQY28ucloTMoBI4zxxEtjTJBd+CW1L5/s07fx+PKKff0vn7dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724883630; c=relaxed/simple;
	bh=hc0fEZy6JascCqwgE3EK7KMdL8zSFxX6pTGSIkmjZn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qzqsN1Kgy2UotD0eeZ/q1CEljvDNBeU1GO6ZiwebJ4PGbGu9dCp0DmPV7TA1oj+qrPbuCsdOzqUqdHFuYRxxIMTbSIzAXJZ4vaujgnBVsEHeltbF4gRXQrermJkOXfNxVekmbvilAhQa3o+MKaKO2IsaEFwUkllUh/s4D4I3lA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4PMJAqN; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d3ba497224so265a91.0;
        Wed, 28 Aug 2024 15:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724883628; x=1725488428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hc0fEZy6JascCqwgE3EK7KMdL8zSFxX6pTGSIkmjZn0=;
        b=H4PMJAqNfwgGqbI+ADSmETrCduZDjPFjrqKtNCgofgToCV7s8vGtwdMUgRht7O2dXW
         Xt21obYEqkiaYA1Ju/st5FlsL5sSo0DGc0u+ECXdLhylGHv+gp6RG8/KEHszZlwFXcAB
         q/J4Us+OwnsFBPDhkmO667ffDB8hPZCOGltnlDiDm2Wg8qcbKQO1QbTIQAUSujL9ahmA
         pEbGqrqzLTlXDjBMZAb3Q82ppuEYf9b73K7i6RqpDSc0+F9+K3dzC40lP1J3aTJ5T7mF
         zPfx1Y12EXfvU5JJGP6SjOvKrCh3Cm2SOWuLtcLzftcrNxV4hUpxU9qXdZhdtoygwRQO
         aJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724883628; x=1725488428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hc0fEZy6JascCqwgE3EK7KMdL8zSFxX6pTGSIkmjZn0=;
        b=HC+pys/Qx1gId2NmLxYcrVP2xIOhEi8L/+66Q/qu5bnmuP/CPYSDsuKHUnN9aaEw5T
         mxi1W8FHRdrx9wGCAdqoZZy2RdbOEXwoctfSaUc1gSM4fqKGtcZhZ4qjBwP2Dn9w5TNh
         Xn6xy1DtaxgDwv/jvUFasfSl3CeIb9dl/XWI4z53My1t2DteC2/jVhRCoqy8j/uVVpxc
         q/zp3dxCjG+bamOiH37VwbndPfqeWUMj5aMuq5liXbDXWVom43WrfyIygv4q31x9991H
         VzneA7aLmFToHp4bTNF1Wcq16XqIvAg32vhKdCO8rDKNKIlQn9flcPSlsq7Qj4+zT2Eu
         5+2A==
X-Forwarded-Encrypted: i=1; AJvYcCUY+x/XpKRz3z7mq27KYMdxQ1RNZaltBuMl1mMUtWAWk4EdwjhjUXGGTfm8oINoQqzaaK8K85AVsAVJ02Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmAFXb1I8smkLRZCWKfjj7LOEc9z6/kygJstq8BpX+juRSvcJR
	Pm4T8i9OJNQEQ7K1GUKje+ef0WJx5qYDsgCJoXLL5slFVOF27SUhn/LCNBCvF9ar+0ZSsiXLckC
	GcUi0rhCP8jUSXmhg3xQMQkvzFqEZRVQN5NA=
X-Google-Smtp-Source: AGHT+IH+w6Gl9YBuWfr82PCzjdNpeQM94Z5vcJer/l+TZADkuLQ3PrjIyFOfJAnF6yQrau7gFFVmnlqsUaDoFKWyXFI=
X-Received: by 2002:a17:90b:1202:b0:2cb:4382:99eb with SMTP id
 98e67ed59e1d1-2d85654b5bamr442235a91.6.1724883628066; Wed, 28 Aug 2024
 15:20:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828211117.9422-1-wedsonaf@gmail.com>
In-Reply-To: <20240828211117.9422-1-wedsonaf@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 29 Aug 2024 00:20:15 +0200
Message-ID: <CANiq72mzNyZkJbPJU1i1PLC81g8CPqfTZ-oO+mAMGeo-r28xKw@mail.gmail.com>
Subject: Re: [PATCH 0/1] Retiring from the Rust for Linux project
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 11:11=E2=80=AFPM Wedson Almeida Filho
<wedsonaf@gmail.com> wrote:
>
> To the Rust for Linux team: thank you, you are great. It was a pleasure w=
orking
> with you all; the times we spent discussing technical issues, finding way=
s to
> address soundness holes, etc. were something I always enjoyed and looked
> forward to. I count myself lucky to have collaborated with such a talende=
d and
> friendly group.
>
> I wish all the success to the project.

Thanks Wedson, it has been a pleasure -- I think I speak for everyone
in the team when I say we will all miss you.

Rust for Linux got where it is this quickly thanks in big part to all
your efforts and quite a few people inherited code you started.

I wish you the best of luck in whatever you decide to do.

P.S. I will miss our long calls! :)

Cheers,
Miguel

