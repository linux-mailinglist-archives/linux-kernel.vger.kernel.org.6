Return-Path: <linux-kernel+bounces-224462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D25329122BE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 096E01C22022
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF85171E6A;
	Fri, 21 Jun 2024 10:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgJSQG9G"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CC616F854
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966711; cv=none; b=NTYWUav14rY77E7URMoAjzZAUSrcx+h6wqi+tMZ1eNsz3C+qK0PchcXquaK5NXReTAsW5UpprOnV3/I5dqHmliMJ181wDCpQIZE1NRw3zYHGHsW0f7twIwyzizv5kDBBS/WnUjXSVYfqy/MEUP6LcB4uBCO23iT+GHjNLsroB/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966711; c=relaxed/simple;
	bh=vCzKBkI0EOlIaIsyEt1Ho+UPCJV1SGzIjta1R/xOqyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NkBQS4vCcL/lmJ1F9JpZPDXcWCKJw2w0uryrJ8Bzzz6jfsgPTDN+c5AhkWb9WUAUd3kKQRZGJWsN4FP5SMqYDf3KLrcsRT6vsTEP9wrSWnR9+BBVkpB3PNMk2xpX7hc1wtmJSlulceaZHvce0vC2/Og5h6o3f+xqyKZK+l/gyy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgJSQG9G; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b50b704ffeso2722826d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 03:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718966709; x=1719571509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCzKBkI0EOlIaIsyEt1Ho+UPCJV1SGzIjta1R/xOqyo=;
        b=hgJSQG9GjTvc/j8hdCsPkfxeebXotpIQB64mr/kcmI/AdlWcore13QrboDIDn/2C++
         4Q6hCWk965WvEC0hUS3QhSruUvTzKhvIA7OTlZpMlDBZuJuYmgdK8+YojT9yySZM2Vpq
         FziIy2xqQiuDe+XdeZChIgccF9y5ajyks4mQpUKW7xW0AKaBQVWIwtmsZNOKeac29Ao4
         r8onlNJVp0dl8deRsOGZygRar/GDzatVxK++lSeI3po/zW7DlSc3biav4LIGQnop9hcP
         tav2v7GjRhjLVOleMIP04Rbg+/ZtlU0t1cvbbi1uAXJYGrbU9AOOVa441vBmxfdyaASo
         4uOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718966709; x=1719571509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCzKBkI0EOlIaIsyEt1Ho+UPCJV1SGzIjta1R/xOqyo=;
        b=unfi398TiJaQ7vyD6RAXpDwYIOgDljNFM7TwVo2tsmIrHmdj9zV44StuJAwStqi3wn
         CL0eB1w0k72re0dH2fynr0J9g7LjvvZ8iX5AeaZJ8yDT1PwXr/61Q8kj9+kF+XuRTjLr
         OhBz4SZvSlExasvQfrCbpI3Snm0UzX6/OShdzdJbkq225qwsjAZ+mRJTvprL55CclQAF
         IMtHBNM8gm4BusL51wZbJRsuG6MEyvdWHpYNWR5TN0rMaL2ILkbDLDlZcKCN0Z2ZjDhi
         FCqS0BkLCarJB9lqVD8OISh0HUk4QwtI/S4ezUE5A65elUycM1j4bCLEA+fUSQ1irOe5
         pfKg==
X-Forwarded-Encrypted: i=1; AJvYcCVMGR1iZgIfcnxeYXZEWBT5VnX0ISrxADOVqw0hmGTm7YFCbPF32rSA4popZqmCdRehdE3A4/c85+7kFzacwEN48JxiRMdrloRtLkbU
X-Gm-Message-State: AOJu0Yxj7+o/nz/ixfz8SF+hXD30KID6l0c2m4wzoqieGHMWHqW5JZW9
	uw0VB5yloVlgpkc9EEmg9ZGGMwGhzQCrcj6ALv2zg4paY9522/l1MFgmiMxZC2ksCM5XLeajn1u
	YqbIBzPMsvU5PEl6RnQqbapuh4No=
X-Google-Smtp-Source: AGHT+IGI1lyNp+TbE3ThRp8In7N425hvlee/0+RjTWRu6FiUFfFtrbG1ST8pJQ2n45IwF01JbVb46PDQIa50lhYgPS4=
X-Received: by 2002:a05:6214:c8b:b0:6b2:af02:28d6 with SMTP id
 6a1803df08f44-6b501d261e4mr83907056d6.0.1718966708856; Fri, 21 Jun 2024
 03:45:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsNptxsQO=5=qi-JYiFX=rX8Ok5inK80Gn0qrUFWbtBGng@mail.gmail.com>
 <CADnq5_PDxJ8O1JUQ9RBYRFB9G1WZJos05ZAM4jUKuPBwPxjNkA@mail.gmail.com>
 <CABXGCsNN9LwHc2x2AAEH=5UNwpvkWkBqRYz3OP8MZ6Woy+HDXA@mail.gmail.com> <b6c440ca-e63e-429b-af41-5f27d4b8b2a2@leemhuis.info>
In-Reply-To: <b6c440ca-e63e-429b-af41-5f27d4b8b2a2@leemhuis.info>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Fri, 21 Jun 2024 15:44:58 +0500
Message-ID: <CABXGCsNoFfMn7LaqqFgEPg-ECyUPN=f=SXVrFi=GZk6c69-Gqw@mail.gmail.com>
Subject: Re: 6.10/bisected/regression - commits bc87d666c05 and 6d4279cb99ac
 cause appearing green flashing bar on top of screen on Radeon 6900XT and 120Hz
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Alex Deucher <alexdeucher@gmail.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>, 
	Rodrigo.Siqueira@amd.com, "Deucher, Alexander" <alexander.deucher@amd.com>, 
	amd-gfx list <amd-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 12:56=E2=80=AFPM Linux regression tracking (Thorste=
n
Leemhuis) <regressions@leemhuis.info> wrote:
> Hmmm, I might have missed something, but it looks like nothing happened
> here since then. What's the status? Is the issue still happening?

Yes. Tested on e5b3efbe1ab1.

I spotted that the problem disappears after forcing the TV to sleep
(activate screensaver <Super> + <L>) and then wake it up by pressing
any button and entering a password.
Hope this information can't help figure out how to fix it.

--=20
Best Regards,
Mike Gavrilov.

